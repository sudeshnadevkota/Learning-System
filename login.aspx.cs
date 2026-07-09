using System;
using System.Configuration;
using System.Data.SqlClient;

namespace Learning_System
{
    public partial class login : System.Web.UI.Page
    {
        string connString = ConfigurationManager.ConnectionStrings["conn"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            // debug Response.Write removed — this was printing raw text on every page load
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            string username = Username.Text.Trim();
            string password = Password.Text;

            using (SqlConnection conn = new SqlConnection(connString))
            {
                // Joins AdminProfile and TeacherProfile so we get AccessLevel/DepartmentId
                // in one round trip, and Department twice (once per possible department source)
                // so we can read the department CODE (e.g. "BIT") for redirect routing.
                string query = @"SELECT U.ProfileId, U.UserName, U.Role,
                                         A.AccessLevel, A.DepartmentId AS AdminDeptId,
                                         T.DepartmentId AS TeacherDeptId,
                                         DA.DepartmentCode AS AdminDeptCode,
                                         DT.DepartmentCode AS TeacherDeptCode
                                  FROM UserProfile U
                                  LEFT JOIN AdminProfile   A  ON U.ProfileId = A.ProfileId
                                  LEFT JOIN TeacherProfile T  ON U.ProfileId = T.ProfileId
                                  LEFT JOIN Department      DA ON A.DepartmentId = DA.DepartmentId
                                  LEFT JOIN Department      DT ON T.DepartmentId = DT.DepartmentId
                                  WHERE U.UserName = @Username
                                    AND U.Password = @Password
                                    AND U.IsActive = 1";

                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@Username", username);

                // TODO: replace with your existing password hashing method —
                // this still compares plaintext, matching the rest of the project for now
                cmd.Parameters.AddWithValue("@Password", password);

                try
                {
                    conn.Open();
                    SqlDataReader reader = cmd.ExecuteReader();

                    if (reader.HasRows)
                    {
                        reader.Read();

                        string role = reader["Role"].ToString(); // 'Student' / 'Teacher' / 'Admin'
                        string accessLevel = reader["AccessLevel"] == DBNull.Value ? null : reader["AccessLevel"].ToString();

                        // Pull whichever DepartmentId/Code actually applies to this role
                        int? departmentId = null;
                        string departmentCode = null;

                        if (role == "Teacher" && reader["TeacherDeptId"] != DBNull.Value)
                        {
                            departmentId = Convert.ToInt32(reader["TeacherDeptId"]);
                            departmentCode = reader["TeacherDeptCode"].ToString();
                        }
                        else if (role == "Admin" && reader["AdminDeptId"] != DBNull.Value)
                        {
                            departmentId = Convert.ToInt32(reader["AdminDeptId"]);
                            departmentCode = reader["AdminDeptCode"].ToString();
                        }

                        // ── These are the session values PermissionHelper.cs relies on ──
                        Session["ProfileId"] = Convert.ToInt32(reader["ProfileId"]);
                        Session["Username"] = reader["UserName"].ToString();
                        Session["Role"] = role;
                        Session["AccessLevel"] = accessLevel;          // null unless Role == "Admin"
                        Session["DepartmentId"] = departmentId;         // null for Student/MainAdmin/SuperAdmin

                        reader.Close();

                        // ── Redirect based on Role + AccessLevel ──
                        if (role == "Student")
                        {
                            Response.Redirect("~/Bit_Notes/dash.aspx"); // TODO: route by departmentCode once per-department student dashboards exist
                        }
                        else if (role == "Teacher")
                        {
                            Response.Redirect("~/Staff/default_staff.aspx");
                        }
                        else if (role == "Admin")
                        {
                            if (accessLevel == "MainAdmin")
                            {
                                Response.Redirect("~/MainAdmin/main_admin.aspx");
                            }
                            else if (accessLevel == "SuperAdmin")
                            {
                                Response.Redirect("~/Administrator/default_administrator.aspx");
                            }
                            else if (accessLevel == "DepartmentAdmin")
                            {
                                // Routes dynamically by department code, e.g. ~/Bit_Admin/dash.aspx
                                if (!string.IsNullOrEmpty(departmentCode))
                                {
                                    string folderName = char.ToUpper(departmentCode[0]) + departmentCode.Substring(1).ToLower() + "_Admin";
                                    Response.Redirect("~/" + folderName + "/dash.aspx");
                                }
                                else
                                {
                                    Label1.Text = "Your admin account has no department assigned. Contact MainAdmin.";
                                }
                            }
                            else
                            {
                                Label1.Text = "Your account role is invalid. Please contact support.";
                            }
                        }
                        else
                        {
                            Label1.Text = "Your account role is invalid. Please contact support.";
                        }
                    }
                    else
                    {
                        Label1.Text = "Incorrect username or password";
                    }
                }
                catch (Exception ex)
                {
                    Label1.Text = "An error occurred. Please try again.";
                    Label1.ForeColor = System.Drawing.Color.Red;
                }
            }
        }

        protected void BackHomeButton_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Default.aspx");
        }
    }
}
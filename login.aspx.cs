using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Web;

namespace Learning_System
{
    public partial class login : System.Web.UI.Page
    {
        string connString = ConfigurationManager.ConnectionStrings["conn"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            string username = Username.Text.Trim();
            string password = Password.Text;

            using (SqlConnection conn = new SqlConnection(connString))
            {
                // NEW — added S.Semester so Students get their current semester in session too.
                string query = @"SELECT U.ProfileId, U.UserName, U.Role,
                                         A.AccessLevel, A.DepartmentId AS AdminDeptId,
                                         T.DepartmentId AS TeacherDeptId,
                                         S.DepartmentId AS StudentDeptId,
                                         S.Semester AS StudentSemester,
                                         DA.DepartmentCode AS AdminDeptCode,
                                         DT.DepartmentCode AS TeacherDeptCode,
                                         DS.DepartmentCode AS StudentDeptCode
                                  FROM UserProfile U
                                  LEFT JOIN AdminProfile   A  ON U.ProfileId = A.ProfileId
                                  LEFT JOIN TeacherProfile T  ON U.ProfileId = T.ProfileId
                                  LEFT JOIN StudentProfile S  ON U.ProfileId = S.ProfileId
                                  LEFT JOIN Department      DA ON A.DepartmentId = DA.DepartmentId
                                  LEFT JOIN Department      DT ON T.DepartmentId = DT.DepartmentId
                                  LEFT JOIN Department      DS ON S.DepartmentId = DS.DepartmentId
                                  WHERE U.UserName = @Username
                                    AND U.Password = @Password
                                    AND U.IsActive = 1";

                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@Username", username);
                cmd.Parameters.AddWithValue("@Password", password);

                try
                {
                    conn.Open();
                    SqlDataReader reader = cmd.ExecuteReader();

                    if (reader.HasRows)
                    {
                        reader.Read();

                        string role = reader["Role"].ToString();
                        string accessLevel = reader["AccessLevel"] == DBNull.Value ? null : reader["AccessLevel"].ToString();

                        int? departmentId = null;
                        string departmentCode = null;
                        int? semester = null; // NEW

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
                        else if (role == "Student" && reader["StudentDeptId"] != DBNull.Value)
                        {
                            departmentId = Convert.ToInt32(reader["StudentDeptId"]);
                            departmentCode = reader["StudentDeptCode"].ToString();

                            // NEW — only students have a semester
                            if (reader["StudentSemester"] != DBNull.Value)
                            {
                                semester = Convert.ToInt32(reader["StudentSemester"]);
                            }
                        }

                        Session["ProfileId"] = Convert.ToInt32(reader["ProfileId"]);
                        Session["Username"] = reader["UserName"].ToString();
                        Session["Role"] = role;
                        Session["AccessLevel"] = accessLevel;
                        Session["DepartmentId"] = departmentId;
                        Session["DepartmentCode"] = departmentCode;
                        Session["Semester"] = semester; // int? — null for Teacher/Admin, populated for Student

                        reader.Close();

                        string returnUrl = Request.QueryString["ReturnUrl"];
                        if (!string.IsNullOrEmpty(returnUrl) && IsLocalUrl(returnUrl))
                        {
                            Response.Redirect(returnUrl);
                            return;
                        }

                        if (role == "Student")
                        {
                            Response.Redirect("~/Bit_Notes/dash.aspx");
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

        private bool IsLocalUrl(string url)
        {
            return !string.IsNullOrEmpty(url)
                && ((url[0] == '/' && (url.Length == 1 || (url[1] != '/' && url[1] != '\\')))
                    || (url.Length > 1 && url[0] == '~' && url[1] == '/'));
        }

        protected void BackHomeButton_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Default.aspx");
        }
    }
}
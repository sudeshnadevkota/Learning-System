using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Learning_System
{
    public partial class login : System.Web.UI.Page
    {
        string connString = ConfigurationManager.ConnectionStrings["conn"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["ProfileId"] == null)
            {
                Response.Write("Session is EMPTY - not set!");
            }
            else
            {
                Response.Write("Session ProfileId = " + Session["ProfileId"] + ", Username = " + Session["Username"]);
            }
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            string username = Username.Text;
            string password = Password.Text;

            using (SqlConnection conn = new SqlConnection(connString))
            {
                string query = @"SELECT U.ProfileId, U.UserName, U.Role, A.AccessLevel
                                 FROM UserProfile U
                                 LEFT JOIN AdminProfile A ON U.ProfileId = A.ProfileId
                                 WHERE U.UserName = @Username
                                 AND U.Password = @Password";

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
                        string status = reader["Role"].ToString();

                        Session["ProfileId"] = Convert.ToInt32(reader["ProfileId"]);
                        Session["Username"] = reader["UserName"].ToString();

                        if (status == "Student")
                        {
                            Response.Redirect("~/Bit_Notes/dash.aspx");
                        }
                        else if (status == "Staff")
                        {
                            Response.Redirect("~/Staff/default_staff.aspx");
                        }
                        else if (status == "Admin")
                        {
                            Session["AccessLevel"] = reader["AccessLevel"] == DBNull.Value ? null : reader["AccessLevel"].ToString();

                            if (Session["AccessLevel"]?.ToString() == "SuperAdmin") Response.Redirect("~/Administrator/default_administrator.aspx");
                            else if (Session["AccessLevel"]?.ToString() == "Moderator") Response.Redirect("~/Moderator/default_moderator.aspx");
                            else Response.Redirect("~/MainAdmin/main_admin.aspx");
                        }
                        else if (status == "SuperAdmin") Response.Redirect("~/Administrator/default_administrator.aspx");
                        else if (status == "students") Response.Redirect("~/students/default_student.aspx");
                        else if (status == "verification") Response.Redirect("~/verification/verification_default.aspx");
                        else if (status == "Bit_Admin") Response.Redirect("~/Bit_Admin/dash.aspx");
                        else if (status == "Bhm_Admin") Response.Redirect("~/Bhm_Admin/dash.aspx");
                        else if (status == "Mcs_Admin") Response.Redirect("~/Mcs_Admin/dash.aspx");
                        else if (status == "Bba_Admin") Response.Redirect("~/Bba_Admin/dash.aspx");
                        else if (status == "Mba_Admin") Response.Redirect("~/Mba_Admin/dash.aspx");
                        else if (status == "Bcs_Admin") Response.Redirect("~/Bcs_Admin/dash.aspx");
                        else if (status == "pyq_Bit") Response.Redirect("~/Past_Year_Paper_Admin/Bit_Admin/dash.aspx");
                        else if (status == "pyq_Bcs") Response.Redirect("~/Past_Year_Paper_Admin/BCS_Admin/dash.aspx");
                        else if (status == "pyq_Mba") Response.Redirect("~/Past_Year_Paper_Admin/MBA_Admin/dash.aspx");
                        else if (status == "pyq_Mcs") Response.Redirect("~/Past_Year_Paper_Admin/MCS_Admin/dash.aspx");
                        else if (status == "pyq_bhm") Response.Redirect("~/Past_Year_Paper_Admin/BHM_Admin/dash.aspx");
                        else if (status == "pyq_BBA") Response.Redirect("~/Past_Year_Paper_Admin/BBA_Admin/dash.aspx");
                        else Label1.Text = "Your account role is invalid. Please contact support.";
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
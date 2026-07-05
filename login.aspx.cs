using Learning_System.students;
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

        }
        protected void Button1_Click(object sender, EventArgs e)
        {
            string username = Username.Text;
            string password = Password.Text;
            using (SqlConnection conn = new SqlConnection(connString))
            {
                string query = @"SELECT Role, UserId, Username
                 FROM Login
                 WHERE Username = @Username
                 AND Password = @Password";
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
                        string status = reader["role"].ToString();
                        string userId = reader["UserId"].ToString();
                        string name = reader["Username"].ToString();
                        if (status == "superadmin")
                        {
                            Session["UserId"] = Convert.ToInt32(reader["UserId"]);
                            Session["Username"] = reader["Username"].ToString();
                            Response.Redirect("~/Administrator//default_administrator.aspx");
                        }
                        else if (status == "students")
                        {
                            Session["UserId"] = Convert.ToInt32(reader["UserId"]);
                            Session["Username"] = reader["Username"].ToString();
                            Response.Redirect("~/students//default_student.aspx");
                        }
                        else if (status == "verification")
                        {
                            Session["UserId"] = Convert.ToInt32(reader["UserId"]);
                            Session["Username"] = reader["Username"].ToString();
                            Response.Redirect("~/verification//verification_default.aspx");
                        }
                        else if (status == "Bit_Admin")
                        {
                            Session["UserId"] = Convert.ToInt32(reader["UserId"]);
                            Session["Username"] = reader["Username"].ToString();
                            Response.Redirect("~/Bit_Admin/dash.aspx");
                        }
                        else if (status == "Bhm_Admin")
                        {
                            Session["UserId"] = Convert.ToInt32(reader["UserId"]);
                            Session["Username"] = reader["Username"].ToString();
                            Response.Redirect("~/Bhm_Admin/dash.aspx");
                        }
                        else if (status == "Mcs_Admin")
                        {
                            Session["UserId"] = Convert.ToInt32(reader["UserId"]);
                            Session["Username"] = reader["Username"].ToString();
                            Response.Redirect("~/Mcs_Admin/dash.aspx");
                        }
                        else if (status == "Bba_Admin")
                        {
                            Session["UserId"] = Convert.ToInt32(reader["UserId"]);
                            Session["Username"] = reader["Username"].ToString();
                            Response.Redirect("~/Bba_Admin/dash.aspx");
                        }
                        else if (status == "Mba_Admin")
                        {
                            Session["UserId"] = Convert.ToInt32(reader["UserId"]);
                            Session["Username"] = reader["Username"].ToString();
                            Response.Redirect("~/Mba_Admin/dash.aspx");
                        }
                        else if (status == "Bcs_Admin")
                        {
                            Session["UserId"] = Convert.ToInt32(reader["UserId"]);
                            Session["Username"] = reader["Username"].ToString();
                            Response.Redirect("~/Bcs_Admin/dash.aspx");
                        }
                        else if (status == "pyq_Bit")
                        {
                            Session["UserId"] = Convert.ToInt32(reader["UserId"]);
                            Session["Username"] = reader["Username"].ToString();
                            Response.Redirect("~/Past_Year_Paper_Admin/Bit_Admin/dash.aspx");
                        }
                        else if (status == "pyq_Bcs")
                        {
                            Session["UserId"] = Convert.ToInt32(reader["UserId"]);
                            Session["Username"] = reader["Username"].ToString();
                            Response.Redirect("~/Past_Year_Paper_Admin/BCS_Admin/dash.aspx");
                        }
                        else if (status == "pyq_Mba")
                        {
                            Session["UserId"] = Convert.ToInt32(reader["UserId"]);
                            Session["Username"] = reader["Username"].ToString();
                            Response.Redirect("~/Past_Year_Paper_Admin/MBA_Admin/dash.aspx");
                        }
                        else if (status == "pyq_Mcs")
                        {
                            Session["UserId"] = Convert.ToInt32(reader["UserId"]);
                            Session["Username"] = reader["Username"].ToString();
                            Response.Redirect("~/Past_Year_Paper_Admin/MCS_Admin/dash.aspx");
                        }
                        else if (status == "pyq_bhm")
                        {
                            Session["UserId"] = Convert.ToInt32(reader["UserId"]);
                            Session["Username"] = reader["Username"].ToString();
                            Response.Redirect("~/Past_Year_Paper_Admin/BHM_Admin/dash.aspx");
                        }
                        else if (status == "pyq_BBA")
                        {
                            Session["UserId"] = Convert.ToInt32(reader["UserId"]);
                            Session["Username"] = reader["Username"].ToString();
                            Response.Redirect("~/Past_Year_Paper_Admin/BBA_Admin/dash.aspx");
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
            Response.Redirect("~/Default.aspx"); // change to your actual home page path
        }
    }
}
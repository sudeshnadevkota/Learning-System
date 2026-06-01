using System;
using System.Configuration;
using System.Data.SqlClient;

namespace Learning_System.administrator
{
    public partial class default_administrator : System.Web.UI.Page
    {
        string connectionString =
            ConfigurationManager.ConnectionStrings["conn"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Check Login
                if (Session["id"] == null)
                {
                    Response.Redirect("../login.aspx");
                    return;
                }

                LoadUserInfo();

                // Future dashboard methods
                // LoadStatistics();
                // LoadRecentActivities();
            }
        }

        private void LoadUserInfo()
        {
            try
            {
                if (Session["full_name"] != null)
                {
                    lblUserName.Text =
                        Session["full_name"].ToString();
                }
                else
                {
                    lblUserName.Text = "Administrator";
                }
            }
            catch
            {
                lblUserName.Text = "Administrator";
            }
        }

        /*
        ======================================
        FUTURE DASHBOARD METHODS
        ======================================

        Uncomment when you create database tables.

        private void LoadStatistics()
        {
            try
            {
                using (SqlConnection con =
                    new SqlConnection(connectionString))
                {
                    con.Open();

                    // Total Users
                    SqlCommand cmdUsers =
                        new SqlCommand(
                        "SELECT COUNT(*) FROM login_", con);

                    int totalUsers =
                        Convert.ToInt32(
                        cmdUsers.ExecuteScalar());

                    lblTotalUsers.Text =
                        totalUsers.ToString();

                    // Total Courses
                    SqlCommand cmdCourses =
                        new SqlCommand(
                        "SELECT COUNT(*) FROM Courses", con);

                    int totalCourses =
                        Convert.ToInt32(
                        cmdCourses.ExecuteScalar());

                    lblCourses.Text =
                        totalCourses.ToString();
                }
            }
            catch
            {
            }
        }
        */
    }
}
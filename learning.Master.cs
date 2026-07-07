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
    public partial class learning : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack) // Ensure this only runs on the first load
            {
                if (Session["ProfileId"] != null)
                {
                    Linklogin.Visible = false;
                    UserDropdown.Visible = true; // Use the new ID for the container

                    string connString = ConfigurationManager.ConnectionStrings["conn"].ConnectionString;
                    using (SqlConnection conn = new SqlConnection(connString))
                    {
                        string query = "SELECT ProfilePhoto FROM UserProfile WHERE ProfileId = @PID";
                        SqlCommand cmd = new SqlCommand(query, conn);
                        cmd.Parameters.AddWithValue("@PID", Session["ProfileId"]);
                        conn.Open();
                        object result = cmd.ExecuteScalar();

                        if (result != null && result != DBNull.Value)
                        {
                            byte[] bytes = (byte[])result;
                            string base64String = Convert.ToBase64String(bytes);
                            // Ensure you are assigning to ProfileImage
                            ProfileImage.ImageUrl = "data:image/jpeg;base64," + base64String;
                        }
                    }
                }
                else
                {
                    Linklogin.Visible = true;
                    UserDropdown.Visible = false;
                }
            }
        }

        protected void BtnLogout_Click(object sender, EventArgs e)
        {
            Session.Abandon();
            Session.Clear();
            Response.Redirect("~/Default.aspx");
        }

        protected void Linklogin_Click(object sender, EventArgs e)
        {
            Response.Redirect("Login.aspx");
        }

        protected void Linkregister_Click(object sender, EventArgs e)
        {
            Response.Redirect("registration.aspx");
        }
    }
}
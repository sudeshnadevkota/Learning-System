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
    public partial class Profile : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["ProfileId"] == null) Response.Redirect("~/login.aspx");
            if (!IsPostBack) LoadProfile();
        }

        private void LoadProfile()
        {
            using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["conn"].ConnectionString))
            {
                string query = "SELECT FullName, ContactNumber, Address, ProfilePhoto FROM UserProfile WHERE ProfileId = @PID";
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@PID", Session["ProfileId"]);
                conn.Open();
                SqlDataReader dr = cmd.ExecuteReader();
                if (dr.Read())
                {
                    txtFullName.Text = dr["FullName"].ToString();
                    txtContact.Text = dr["ContactNumber"].ToString();
                    txtAddress.Text = dr["Address"].ToString();
                    if (dr["ProfilePhoto"] != DBNull.Value)
                        imgProfile.ImageUrl = "data:image/jpeg;base64," + Convert.ToBase64String((byte[])dr["ProfilePhoto"]);
                }
            }
        }

        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["conn"].ConnectionString))
            {
                string query = "UPDATE UserProfile SET FullName=@Name, ContactNumber=@Contact, Address=@Addr WHERE ProfileId=@PID";
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@Name", txtFullName.Text);
                cmd.Parameters.AddWithValue("@Contact", txtContact.Text);
                cmd.Parameters.AddWithValue("@Addr", txtAddress.Text);
                cmd.Parameters.AddWithValue("@PID", Session["ProfileId"]);
                conn.Open();
                cmd.ExecuteNonQuery();
                lblMsg.Text = "Profile Updated Successfully!";
            }
        }
    }
}
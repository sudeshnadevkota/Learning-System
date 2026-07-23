using System;
using System.Configuration;
using System.Data.SqlClient;

namespace Learning_System
{
    public partial class Pending : System.Web.UI.Page
    {
        string connString = ConfigurationManager.ConnectionStrings["conn"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (IsPostBack) return;

            int profileId;
            if (!int.TryParse(Request.QueryString["id"], out profileId))
            {
                Response.Redirect("~/Login.aspx");
                return;
            }

            string status = null;
            bool isActive = false;
            string fullName = null;

            using (SqlConnection conn = new SqlConnection(connString))
            {
                string query = "SELECT FullName, ApprovalStatus, IsActive FROM UserProfile WHERE ProfileId = @Id";
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@Id", profileId);

                conn.Open();
                SqlDataReader reader = cmd.ExecuteReader();
                if (reader.Read())
                {
                    fullName = reader["FullName"].ToString();
                    status = reader["ApprovalStatus"] == DBNull.Value ? null : reader["ApprovalStatus"].ToString();
                    isActive = reader["IsActive"] != DBNull.Value && Convert.ToBoolean(reader["IsActive"]);
                }
                reader.Close();
            }

            // No such profile — don't leak info, just bounce to login
            if (status == null)
            {
                Response.Redirect("~/Login.aspx");
                return;
            }

            // Account is now active — nothing to show here, let them log in
            if (isActive)
            {
                Response.Redirect("~/Login.aspx");
                return;
            }

            if (status == "Rejected")
            {
                Response.Redirect("~/Rejected.aspx");
                return;
            }

            if (status == "Approved")
            {
                // Approved but IsActive = 0 means an admin suspended them after the fact
                Response.Redirect("~/Suspended.aspx");
                return;
            }

            // status == "Pending" — stay here and show the message
            NameLabel.Text = string.IsNullOrEmpty(fullName) ? "" : fullName;
        }
    }
}
using System;
using System.Configuration;
using System.Data.SqlClient;

namespace Learning_System
{
    public partial class Rejected : System.Web.UI.Page
    {
        string connString = ConfigurationManager.ConnectionStrings["conn"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (IsPostBack) return;

            int profileId;
            if (!int.TryParse(Request.QueryString["id"], out profileId))
            {
                // No id passed — just show the generic message, no name lookup needed
                return;
            }

            using (SqlConnection conn = new SqlConnection(connString))
            {
                string query = "SELECT FullName FROM UserProfile WHERE ProfileId = @Id";
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@Id", profileId);

                conn.Open();
                object result = cmd.ExecuteScalar();
                if (result != null && result != DBNull.Value)
                {
                    NameLabel.Text = result.ToString();
                }
            }
        }
    }
}
using System;
using System.Configuration;
using System.Data.SqlClient;

namespace Learning_System.Bit_Notes
{
    public partial class NoticeWidget : System.Web.UI.UserControl
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string constr = ConfigurationManager.ConnectionStrings["YourConnStringName"].ConnectionString;

            using (SqlConnection con = new SqlConnection(constr))
            {
                string sql = @"SELECT TOP 4 Id, Title, PostedByName, PostedDate
                               FROM Notice
                               WHERE IsActive = 1 AND (ExpiryDate IS NULL OR ExpiryDate >= GETDATE())
                               ORDER BY IsPinned DESC, PostedDate DESC";
                using (SqlCommand cmd = new SqlCommand(sql, con))
                {
                    con.Open();
                    using (SqlDataReader sdr = cmd.ExecuteReader())
                    {
                        rptWidget.DataSource = sdr;
                        rptWidget.DataBind();
                    }
                }
            }

            litEmpty.Visible = rptWidget.Items.Count == 0;
        }
    }
}
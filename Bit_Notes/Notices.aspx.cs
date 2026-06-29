using System;
using System.Data.SqlClient;

namespace Learning_System.Bit_Notes
{
    public partial class Notices : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindNotices();
            }
        }

        private void BindNotices()
        {
            using (SqlConnection con = new SqlConnection(constr))
            {
                string sql = @"SELECT NoticeId, Title, Description, PostedByName, PostedByRole,
                                      PostedDate, AttachmentName, AttachmentType, IsPinned
                               FROM Notice
                               WHERE IsActive = 1 AND (ExpiryDate IS NULL OR ExpiryDate >= GETDATE())
                               ORDER BY IsPinned DESC, PostedDate DESC";
                using (SqlCommand cmd = new SqlCommand(sql, con))
                {
                    con.Open();
                    using (SqlDataReader sdr = cmd.ExecuteReader())
                    {
                        rptNotices.DataSource = sdr;
                        rptNotices.DataBind();
                    }
                }
            }

            noticeEmpty.Visible = rptNotices.Items.Count == 0;
        }
    }
}
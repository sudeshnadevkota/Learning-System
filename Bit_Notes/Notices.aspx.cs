using System;
using System.Collections.Generic;
using System.Data.SqlClient;

namespace Learning_System.Bit_Notes
{
    public partial class Notices : BasePage
    {
        // Whitelist of valid class codes — same OrdinalIgnoreCase pattern as SubjectMap
        private static readonly HashSet<string> ValidClasses = new HashSet<string>(StringComparer.OrdinalIgnoreCase)
        {
            "BCS", "BHM", "BIT", "MCS", "BBA", "MBA"
        };

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindNotices();
            }
        }

        private void BindNotices()
        {
            string studentClass = Request.QueryString["class"];

            if (string.IsNullOrEmpty(studentClass) || !ValidClasses.Contains(studentClass))
            {
                Response.Redirect("~/Bit_Notes/dash.aspx");
                return;
            }

            litClassName.Text = studentClass.ToUpper();

            using (SqlConnection con = new SqlConnection(constr))
            {
                string sql = @"SELECT NoticeId, Title, Description, PostedByName, PostedByRole,
                                      PostedDate, AttachmentName, AttachmentType, IsPinned
                               FROM Notice
                               WHERE IsActive = 1 
                                 AND Class = @Class
                                 AND (ExpiryDate IS NULL OR ExpiryDate >= GETDATE())
                               ORDER BY IsPinned DESC, PostedDate DESC";
                using (SqlCommand cmd = new SqlCommand(sql, con))
                {
                    cmd.Parameters.AddWithValue("@Class", studentClass);
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
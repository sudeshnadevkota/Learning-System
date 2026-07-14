using System;
using System.Configuration;
using System.Data.SqlClient;

namespace Learning_System
{
    public partial class NoticeWidget : System.Web.UI.UserControl
    {
        private string constr = ConfigurationManager.ConnectionStrings["conn"].ConnectionString;
        private const int MaxWidgetItems = 5;

        protected void Page_Load(object sender, EventArgs e)
        {
            BindWidget();
        }

        private void BindWidget()
        {
            // Students/staff see notices for their own department + "ALL" department notices.
            // Admins with no department (MainAdmin/SuperAdmin) see everything recent.
            string myDeptCode = PermissionHelper.GetDepartmentCode(Session);

            using (SqlConnection con = new SqlConnection(constr))
            {
                string sql = string.IsNullOrEmpty(myDeptCode)
                    ? @"SELECT TOP (@Top) NoticeId, Title, PostedByName, PostedDate
                        FROM Notice
                        WHERE IsActive = 1 AND (ExpiryDate IS NULL OR ExpiryDate >= GETDATE())
                        ORDER BY IsPinned DESC, PostedDate DESC"
                    : @"SELECT TOP (@Top) NoticeId, Title, PostedByName, PostedDate
                        FROM Notice
                        WHERE IsActive = 1 
                          AND (Class = @Class OR Class = 'ALL')
                          AND (ExpiryDate IS NULL OR ExpiryDate >= GETDATE())
                        ORDER BY IsPinned DESC, PostedDate DESC";

                using (SqlCommand cmd = new SqlCommand(sql, con))
                {
                    cmd.Parameters.AddWithValue("@Top", MaxWidgetItems);
                    if (!string.IsNullOrEmpty(myDeptCode))
                        cmd.Parameters.AddWithValue("@Class", myDeptCode);

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
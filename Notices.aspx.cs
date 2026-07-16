using System;
using System.Collections.Generic;
using System.Data.SqlClient;

namespace Learning_System
{
    public partial class Notices : BasePage
    {
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
            // 1. Session security handling based on your login schema
            //    Check this FIRST so unauthenticated users are always caught,
            //    regardless of what's in the query string.
            string userRole = Session["Role"] as string;
            string sessionDeptCode = Session["DepartmentCode"] as string;

            if (string.IsNullOrEmpty(userRole))
            {
                // Not logged in -> Access Denied
                Response.Redirect("~/AccessDenied.aspx");
                return;
            }

            // 2. Basic URL parameter validation
            string studentClass = Request.QueryString["class"];

            if (string.IsNullOrEmpty(studentClass) || !ValidClasses.Contains(studentClass))
            {
                Response.Redirect("~/Default.aspx");
                return;
            }

            // 3. Apply role-based department restrictions
            if (userRole == "Student")
            {
                // Students can only see notices if their session department code matches the query string
                if (string.IsNullOrEmpty(sessionDeptCode) || !sessionDeptCode.Equals(studentClass, StringComparison.OrdinalIgnoreCase))
                {
                    Response.Redirect("~/AccessDenied.aspx");
                    return;
                }
            }
            else if (userRole == "Admin")
            {
                string accessLevel = Session["AccessLevel"] as string;
                // Optional security layer: Restrict Department Admins to their assigned branch
                if (accessLevel == "DepartmentAdmin" && !string.IsNullOrEmpty(sessionDeptCode))
                {
                    if (!sessionDeptCode.Equals(studentClass, StringComparison.OrdinalIgnoreCase))
                    {
                        Response.Redirect("~/AccessDenied.aspx");
                        return;
                    }
                }
            }

            litClassName.Text = studentClass.ToUpper();

            using (SqlConnection con = new SqlConnection(constr))
            {
                string sql = @"SELECT NoticeId, Title, Description, PostedByName, PostedByRole,
                                      PostedDate, AttachmentName, AttachmentType, IsPinned
                               FROM Notice
                               WHERE IsActive = 1 
                                 AND (Class = @Class OR Class = 'ALL')
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
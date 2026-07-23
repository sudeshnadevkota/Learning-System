using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Learning_System
{
    public partial class ApproveStudents : UserControl
    {
        string connString = ConfigurationManager.ConnectionStrings["conn"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            // The hosting master pages (MainAdmin, SuperAdmin, and each per-department
            // admin master) only hide the nav link for unauthorized roles — they don't
            // re-check on postback. So this control must gate itself every load,
            // regardless of how it got loaded into phDynamic.
            if (!CheckAccess())
            {
                pnlContent.Visible = false;
                pnlDenied.Visible = true;
                return;
            }

            // This control is recreated via LoadControl on every postback that keeps
            // the section active (see the master's RestoreSection/Page_Init pattern) —
            // including the very postback that first navigates here. IsPostBack is
            // therefore always true by the time we get here, so binding must happen
            // unconditionally rather than being gated on "not a postback".
            SetScopeLabel();
            BindGrid();
        }

        // Only Admins with AccessLevel MainAdmin, SuperAdmin, or DepartmentAdmin may act here.
        // Explicitly excludes Teacher even though Teacher can reach the same master page.
        private bool CheckAccess()
        {
            string role = Session["Role"] as string;
            string accessLevel = Session["AccessLevel"] as string;

            if (role != "Admin")
                return false;

            return accessLevel == "MainAdmin"
                || accessLevel == "SuperAdmin"
                || accessLevel == "DepartmentAdmin";
        }

        private bool IsDepartmentAdmin()
        {
            return (Session["AccessLevel"] as string) == "DepartmentAdmin";
        }

        // The DepartmentId of the currently logged-in DepartmentAdmin (null for Main/SuperAdmin).
        private int? CurrentAdminDepartmentId()
        {
            return Session["DepartmentId"] as int?;
        }

        private void SetScopeLabel()
        {
            if (IsDepartmentAdmin())
            {
                string deptCode = Session["DepartmentCode"] as string;
                ScopeLiteral.Text = "Showing pending registrations for your department"
                    + (string.IsNullOrEmpty(deptCode) ? "." : " (" + Server.HtmlEncode(deptCode) + ").");
            }
            else
            {
                ScopeLiteral.Text = "Showing pending registrations across all departments.";
            }
        }

        private void BindGrid()
        {
            using (SqlConnection conn = new SqlConnection(connString))
            {
                string query = @"SELECT U.ProfileId, U.FullName, U.UserName, U.Email,
                                         U.ApprovalStatus, U.RegisteredDate,
                                         S.DepartmentId, S.Semester,
                                         D.DepartmentCode
                                  FROM UserProfile U
                                  INNER JOIN StudentProfile S ON U.ProfileId = S.ProfileId
                                  INNER JOIN Department D ON S.DepartmentId = D.DepartmentId
                                  WHERE U.ApprovalStatus = 'Pending'";

                // DepartmentAdmin only ever sees their own department's pending students.
                if (IsDepartmentAdmin())
                {
                    query += " AND S.DepartmentId = @DeptId";
                }

                query += " ORDER BY U.RegisteredDate ASC";

                SqlCommand cmd = new SqlCommand(query, conn);

                if (IsDepartmentAdmin())
                {
                    int? deptId = CurrentAdminDepartmentId();
                    if (deptId == null)
                    {
                        // DepartmentAdmin with no department on session — show nothing rather than everything.
                        GridView1.DataSource = null;
                        GridView1.DataBind();
                        return;
                    }
                    cmd.Parameters.AddWithValue("@DeptId", deptId.Value);
                }

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);

                GridView1.DataSource = dt;
                GridView1.DataBind();
            }
        }

        protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            // Re-checked here too — Page_Load already gates the whole control, but a
            // row command is its own postback path, so belt-and-braces.
            if (!CheckAccess())
                return;

            if (e.CommandName != "Approve" && e.CommandName != "Reject")
                return;

            int profileId;
            if (!int.TryParse(e.CommandArgument.ToString(), out profileId))
                return;

            // Never trust the posted CommandArgument alone for a DepartmentAdmin.
            // Look up the row's real department from the DB and compare it against
            // the admin's own session department before touching anything.
            int? rowDepartmentId = GetDepartmentIdForProfile(profileId);

            if (rowDepartmentId == null)
            {
                ShowMessage("That student record could not be found.", false);
                BindGrid();
                return;
            }

            if (IsDepartmentAdmin())
            {
                int? adminDeptId = CurrentAdminDepartmentId();
                if (adminDeptId == null || rowDepartmentId.Value != adminDeptId.Value)
                {
                    ShowMessage("You are not authorized to act on that student's department.", false);
                    BindGrid();
                    return;
                }
            }

            if (e.CommandName == "Approve")
            {
                ApproveProfile(profileId);
                ShowMessage("Student approved.", true);
            }
            else
            {
                RejectProfile(profileId);
                ShowMessage("Registration rejected.", true);
            }

            BindGrid();
        }

        private int? GetDepartmentIdForProfile(int profileId)
        {
            using (SqlConnection conn = new SqlConnection(connString))
            {
                string query = "SELECT DepartmentId FROM StudentProfile WHERE ProfileId = @Id";
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@Id", profileId);

                conn.Open();
                object result = cmd.ExecuteScalar();
                return (result == null || result == DBNull.Value) ? (int?)null : Convert.ToInt32(result);
            }
        }

        private void ApproveProfile(int profileId)
        {
            using (SqlConnection conn = new SqlConnection(connString))
            {
                string query = "UPDATE UserProfile SET IsActive = 1, ApprovalStatus = 'Approved' WHERE ProfileId = @Id";
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@Id", profileId);

                conn.Open();
                cmd.ExecuteNonQuery();
            }
        }

        private void RejectProfile(int profileId)
        {
            using (SqlConnection conn = new SqlConnection(connString))
            {
                // IsActive stays 0 — rejected accounts are never active.
                string query = "UPDATE UserProfile SET ApprovalStatus = 'Rejected' WHERE ProfileId = @Id";
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@Id", profileId);

                conn.Open();
                cmd.ExecuteNonQuery();
            }
        }

        private void ShowMessage(string text, bool success)
        {
            MessageLabel.Text = text;
            MessageLabel.CssClass = "appr-msg " + (success ? "appr-msg-success" : "appr-msg-error");
            MessageLabel.Visible = true;
        }
    }
}
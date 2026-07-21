using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;
using Learning_System.Common;

namespace Learning_System
{
    public partial class AppointUserControl : System.Web.UI.UserControl, IDynamicSection
    {
        string constr = ConfigurationManager.ConnectionStrings["conn"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            PermissionHelper.RequireAccessLevel(this.Page, "MainAdmin", "SuperAdmin", "DepartmentAdmin");

            // NOTE: dropdown binding / query-string handling used to live here behind
            // "if (!IsPostBack)". That's wrong for a control that gets loaded dynamically
            // via LoadControl() in response to a sidebar click — that click IS a postback,
            // so this.IsPostBack is true even on this control's very first appearance.
            // BaseAdminMaster.LoadSection() now calls LoadInitialData() explicitly right
            // after adding this control to the tree, so all of that logic moved there.
        }

        // Called by BaseAdminMaster.LoadSection() immediately after this control is
        // freshly added to the page — i.e. exactly once, when the user first navigates
        // to this section. NOT called on ordinary postbacks within the section (e.g.
        // ddlRoleToAppoint's own AutoPostBack), so in-progress form data and the
        // dropdown's current selection survive via ViewState instead of being reset.
        public void LoadInitialData()
        {
            BindRoleDropdown();
            BindDepartmentDropdown();

            bool isPostAppointBounce = Request.QueryString["appointed"] == "true";

            if (!isPostAppointBounce)
            {
                string referrer = Request.UrlReferrer?.ToString();

                bool referrerIsUsable =
                    !string.IsNullOrEmpty(referrer) &&
                    Uri.TryCreate(referrer, UriKind.Absolute, out Uri refUri) &&
                    refUri.Host == Request.Url.Host &&
                    !refUri.AbsolutePath.TrimEnd('/').EndsWith("AppointUser.aspx", StringComparison.OrdinalIgnoreCase);

                // Session survives Response.Redirect; ViewState does not.
                Session["AppointUserReturnUrl"] = referrerIsUsable
                    ? referrer
                    : GetDefaultDashboardUrl();
            }

            string requestedRole = Request.QueryString["role"];
            if (!string.IsNullOrEmpty(requestedRole) &&
                ddlRoleToAppoint.Items.FindByValue(requestedRole) != null)
            {
                ddlRoleToAppoint.SelectedValue = requestedRole;
            }

            ddlRoleToAppoint_SelectedIndexChanged(null, null);
        }

        protected void btnClose_Click(object sender, EventArgs e)
        {
            string returnUrl = Session["AppointUserReturnUrl"] as string;
            Response.Redirect(!string.IsNullOrEmpty(returnUrl) ? returnUrl : GetDefaultDashboardUrl());
        }

        // Role-aware fallback: used both when there's no valid referrer, and as the
        // stored ReturnUrl itself when the page was reached with no usable referrer.
        private string GetDefaultDashboardUrl()
        {
            string accessLevel = PermissionHelper.GetAccessLevel(Session);

            switch (accessLevel)
            {
                case "SuperAdmin":
                    return ResolveUrl("~/SuperAdmin/super_admin.aspx");

                case "MainAdmin":
                    return ResolveUrl("~/MainAdmin/main_admin.aspx");

                case "DepartmentAdmin":
                    string folderName = PermissionHelper.GetDepartmentAdminFolder(Session);
                    if (!string.IsNullOrEmpty(folderName))
                        return ResolveUrl($"~/{folderName}/dash.aspx");
                    return ResolveUrl("~/MainAdmin/main_admin.aspx");

                default:
                    return ResolveUrl("~/default.aspx");
            }
        }

        private void BindRoleDropdown()
        {
            string myAccessLevel = PermissionHelper.GetAccessLevel(Session);
            ddlRoleToAppoint.Items.Clear();

            foreach (var role in PermissionHelper.GetAppointableRoles(myAccessLevel))
            {
                ddlRoleToAppoint.Items.Add(new ListItem(role, role));
            }
        }

        private void BindDepartmentDropdown()
        {
            string myAccessLevel = PermissionHelper.GetAccessLevel(Session);
            int? myDepartmentId = PermissionHelper.GetDepartmentId(Session);

            ddlDepartment.Items.Clear();

            using (SqlConnection con = new SqlConnection(constr))
            {
                con.Open();
                string q = "SELECT DepartmentId, DepartmentCode FROM Department ORDER BY DepartmentCode";
                using (SqlCommand cmd = new SqlCommand(q, con))
                using (SqlDataReader reader = cmd.ExecuteReader())
                {
                    while (reader.Read())
                    {
                        ddlDepartment.Items.Add(new ListItem(
                            reader["DepartmentCode"].ToString(),
                            reader["DepartmentId"].ToString()));
                    }
                }
            }

            // A DepartmentAdmin can only ever appoint within their own department —
            // lock the dropdown so the choice can't be tampered with client-side.
            // (btnAppoint_Click re-derives this from Session regardless, as a second layer.)
            if (myAccessLevel == "DepartmentAdmin" && myDepartmentId.HasValue)
            {
                ddlDepartment.SelectedValue = myDepartmentId.Value.ToString();
                ddlDepartment.Enabled = false;
                lblDepartmentLocked.Text = "Locked to your department.";
            }
        }

        protected void ddlRoleToAppoint_SelectedIndexChanged(object sender, EventArgs e)
        {
            string selectedRole = ddlRoleToAppoint.SelectedValue;

            pnlStaff.CssClass = "lp-role-panel";
            pnlDepartmentPicker.CssClass = "lp-role-panel";

            if (selectedRole == "Staff")
            {
                pnlStaff.CssClass = "lp-role-panel active";
                pnlDepartmentPicker.CssClass = "lp-role-panel active";
            }
            else if (selectedRole == "DepartmentAdmin")
            {
                pnlDepartmentPicker.CssClass = "lp-role-panel active";
            }
            // SuperAdmin needs neither panel — no department scope, no designation
        }

        protected void btnAppoint_Click(object sender, EventArgs e)
        {
            if (!Page.IsValid) return;

            string myAccessLevel = PermissionHelper.GetAccessLevel(Session);
            string roleToAppoint = ddlRoleToAppoint.SelectedValue;

            // Re-validate server-side — never trust that the dropdown wasn't tampered with
            if (!PermissionHelper.CanAppointRole(myAccessLevel, roleToAppoint))
            {
                lblError.Text = "You are not authorized to appoint that role.";
                return;
            }

            int appointerProfileId = PermissionHelper.GetProfileId(Session);
            int? myDepartmentId = PermissionHelper.GetDepartmentId(Session);

            using (SqlConnection con = new SqlConnection(constr))
            {
                con.Open();
                SqlTransaction transaction = con.BeginTransaction();

                try
                {
                    // Map appointed role -> the Role value stored in UserProfile
                    string userProfileRole = (roleToAppoint == "Staff") ? "Teacher" : "Admin";

                    // 1. Insert into UserProfile
                    int newProfileId;
                    string profileQuery = @"INSERT INTO UserProfile
                                (FullName, UserName, Password, Email, ContactNumber, Role, RegisteredDate, ApprovalStatus, IsActive)
                                OUTPUT INSERTED.ProfileId
                                VALUES
                                (@FullName, @UserName, @Password, @Email, @ContactNumber, @Role, GETDATE(), 'Approved', 1)";

                    using (SqlCommand cmd = new SqlCommand(profileQuery, con, transaction))
                    {
                        cmd.Parameters.AddWithValue("@FullName", txtFullName.Text.Trim());
                        cmd.Parameters.AddWithValue("@UserName", txtUsername.Text.Trim());

                        // TODO: replace with your existing password hashing method
                        cmd.Parameters.AddWithValue("@Password", txtPassword.Text);

                        cmd.Parameters.AddWithValue("@Email", txtEmail.Text.Trim());
                        cmd.Parameters.AddWithValue("@ContactNumber", string.IsNullOrWhiteSpace(txtContact.Text) ? (object)DBNull.Value : txtContact.Text.Trim());
                        cmd.Parameters.AddWithValue("@Role", userProfileRole);
                        newProfileId = (int)cmd.ExecuteScalar();
                    }

                    // 2. Insert into the role-specific table
                    if (roleToAppoint == "Staff")
                    {
                        // DepartmentAdmin is always forced to their OWN department server-side,
                        // regardless of what the (disabled) dropdown posted back
                        int departmentId = (myAccessLevel == "DepartmentAdmin" && myDepartmentId.HasValue)
                            ? myDepartmentId.Value
                            : Convert.ToInt32(ddlDepartment.SelectedValue);

                        string q = @"INSERT INTO TeacherProfile (ProfileId, Designation, DepartmentId, SubjectsHandled, AppointedBy)
                                     VALUES (@ProfileId, @Designation, @DepartmentId, @SubjectsHandled, @AppointedBy)";
                        using (SqlCommand cmd = new SqlCommand(q, con, transaction))
                        {
                            cmd.Parameters.AddWithValue("@ProfileId", newProfileId);
                            cmd.Parameters.AddWithValue("@Designation", string.IsNullOrWhiteSpace(txtDesignation.Text) ? (object)DBNull.Value : txtDesignation.Text.Trim());
                            cmd.Parameters.AddWithValue("@DepartmentId", departmentId);
                            cmd.Parameters.AddWithValue("@SubjectsHandled", string.IsNullOrWhiteSpace(txtSubjectsHandled.Text) ? (object)DBNull.Value : txtSubjectsHandled.Text.Trim());
                            cmd.Parameters.AddWithValue("@AppointedBy", appointerProfileId);
                            cmd.ExecuteNonQuery();
                        }
                    }
                    else if (roleToAppoint == "DepartmentAdmin")
                    {
                        int departmentId = Convert.ToInt32(ddlDepartment.SelectedValue);

                        string q = @"INSERT INTO AdminProfile (ProfileId, AccessLevel, DepartmentId, AppointedBy)
                                     VALUES (@ProfileId, 'DepartmentAdmin', @DepartmentId, @AppointedBy)";
                        using (SqlCommand cmd = new SqlCommand(q, con, transaction))
                        {
                            cmd.Parameters.AddWithValue("@ProfileId", newProfileId);
                            cmd.Parameters.AddWithValue("@DepartmentId", departmentId);
                            cmd.Parameters.AddWithValue("@AppointedBy", appointerProfileId);
                            cmd.ExecuteNonQuery();
                        }
                    }
                    else // SuperAdmin — only MainAdmin can reach this branch (enforced above)
                    {
                        string q = @"INSERT INTO AdminProfile (ProfileId, AccessLevel, DepartmentId, AppointedBy)
                                     VALUES (@ProfileId, 'SuperAdmin', NULL, @AppointedBy)";
                        using (SqlCommand cmd = new SqlCommand(q, con, transaction))
                        {
                            cmd.Parameters.AddWithValue("@ProfileId", newProfileId);
                            cmd.Parameters.AddWithValue("@AppointedBy", appointerProfileId);
                            cmd.ExecuteNonQuery();
                        }
                    }

                    transaction.Commit();
                    Response.Redirect(Request.RawUrl.Contains("?") ? Request.RawUrl + "&appointed=true" : Request.RawUrl + "?appointed=true");
                }
                catch (Exception ex)
                {
                    transaction.Rollback();
                    lblError.Text = "Failed to create account: " + ex.Message;
                }
            }
        }
    }
}
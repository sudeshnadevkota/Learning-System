using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;

namespace Learning_System
{
    public partial class AppointUser : System.Web.UI.Page
    {
        string constr = ConfigurationManager.ConnectionStrings["conn"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            // Only MainAdmin, SuperAdmin, or DepartmentAdmin may reach this page at all
            PermissionHelper.RequireAccessLevel(this, "MainAdmin", "SuperAdmin", "DepartmentAdmin");

            if (!IsPostBack)
            {
                BindRoleDropdown();
                BindDepartmentDropdown();

                // Pre-select role from query string if it's a valid, appointable option
                // for the currently logged-in user's access level.
                // Safe by design: FindByValue only matches roles BindRoleDropdown already
                // filtered via PermissionHelper.GetAppointableRoles(), so a DepartmentAdmin
                // hitting ?role=SuperAdmin directly simply finds nothing and nothing changes.
                string requestedRole = Request.QueryString["role"];
                if (!string.IsNullOrEmpty(requestedRole) &&
                    ddlRoleToAppoint.Items.FindByValue(requestedRole) != null)
                {
                    ddlRoleToAppoint.SelectedValue = requestedRole;
                }

                ddlRoleToAppoint_SelectedIndexChanged(null, null);
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
            // (The code-behind on submit re-derives this from Session regardless, as a second layer.)
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
                    Response.Redirect("AppointUser.aspx?appointed=true");
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
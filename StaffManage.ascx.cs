using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;
using Learning_System.Common;

namespace Learning_System
{
    // Changed inheritance from System.Web.UI.Page to System.Web.UI.UserControl
    // Class name altered slightly to avoid cross-reference naming conflicts if placed in the same namespace folder.
    // Implements IDynamicSection so BaseAdminMaster.LoadSection() can trigger
    // the initial data load right after this control is added to the tree.
    public partial class StaffManageControl : System.Web.UI.UserControl, IDynamicSection
    {
        protected string constr = ConfigurationManager.ConnectionStrings["conn"].ConnectionString;

        private bool IsSuperScope => !PermissionHelper.IsDepartmentAdmin(Session);

        protected void Page_Load(object sender, EventArgs e)
        {
            // IMPORTANT: If this control checks global application authorization context, 
            // ensure 'this.Page' is passed into helpers rather than just 'this' since it's no longer a full Page object.
            PermissionHelper.RequireAccessLevel(this.Page, "MainAdmin", "SuperAdmin", "DepartmentAdmin");

            // Data loading moved to LoadInitialData() — IsPostBack can't be trusted here,
            // since the sidebar click that creates this control is itself a postback.
        }

        // Called by BaseAdminMaster.LoadSection() right after this control is
        // freshly added to the page — NOT called on plain postbacks (paging,
        // Save, etc.), where the grid/dropdown state should persist via ViewState
        // and the relevant handler (e.g. btnSaveEdit_Click) reloads data itself.
        public void LoadInitialData()
        {
            LoadDepartmentsDropdown();
            LoadStaff();
        }

        private void LoadDepartmentsDropdown()
        {
            using (SqlConnection con = new SqlConnection(constr))
            {
                string sql = IsSuperScope
                    ? "SELECT DepartmentId, DepartmentName FROM Department ORDER BY DepartmentName"
                    : "SELECT DepartmentId, DepartmentName FROM Department WHERE DepartmentId = @DeptId ORDER BY DepartmentName";

                using (SqlCommand cmd = new SqlCommand(sql, con))
                {
                    if (!IsSuperScope)
                        cmd.Parameters.AddWithValue("@DeptId", (object)Session["DepartmentId"] ?? DBNull.Value);

                    con.Open();
                    using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                    {
                        DataTable dt = new DataTable();
                        da.Fill(dt);
                        ddlDepartment.DataSource = dt;
                        ddlDepartment.DataBind();
                    }
                }
            }
        }

        private void LoadStaff()
        {
            using (SqlConnection con = new SqlConnection(constr))
            {
                string sql = @"SELECT
                                    u.ProfileId,
                                    u.UserName AS Username,
                                    d.DepartmentName,
                                    d.DepartmentCode,
                                    u.IsActive
                                FROM TeacherProfile t
                                JOIN UserProfile u ON u.ProfileId = t.ProfileId
                                JOIN Department d ON d.DepartmentId = t.DepartmentId
                                WHERE (@IsSuper = 1 OR t.DepartmentId = @DeptId)
                                ORDER BY u.UserName";

                using (SqlCommand cmd = new SqlCommand(sql, con))
                {
                    cmd.Parameters.AddWithValue("@IsSuper", IsSuperScope ? 1 : 0);
                    cmd.Parameters.AddWithValue("@DeptId", (object)Session["DepartmentId"] ?? DBNull.Value);

                    con.Open();
                    using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                    {
                        DataTable dt = new DataTable();
                        da.Fill(dt);
                        gvStaff.DataSource = dt;
                        gvStaff.DataBind();
                    }
                }
            }
        }

        private void ShowSuccess(string message)
        {
            phError.Visible = false;
            phSuccess.Visible = true;
            litSuccess.Text = message;
        }

        private void ShowError(string message)
        {
            phSuccess.Visible = false;
            phError.Visible = true;
            litError.Text = message;
        }

        private bool TryGetStaffDepartment(SqlConnection con, int profileId, out int departmentId)
        {
            departmentId = 0;
            using (SqlCommand cmd = new SqlCommand(
                "SELECT DepartmentId FROM TeacherProfile WHERE ProfileId = @Id", con))
            {
                cmd.Parameters.AddWithValue("@Id", profileId);
                object result = cmd.ExecuteScalar();
                if (result == null) return false;
                departmentId = Convert.ToInt32(result);
                return true;
            }
        }

        protected void gvStaff_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            int profileId;
            if (!int.TryParse(e.CommandArgument as string, out profileId)) return;

            if (e.CommandName == "EditStaff")
            {
                using (SqlConnection con = new SqlConnection(constr))
                {
                    con.Open();

                    int currentDeptId;
                    if (!TryGetStaffDepartment(con, profileId, out currentDeptId))
                    {
                        ShowError("Staff member not found.");
                        LoadStaff();
                        return;
                    }

                    if (!PermissionHelper.CanManageDepartment(Session, currentDeptId))
                    {
                        ShowError("You are not authorized to manage staff outside your department.");
                        LoadStaff();
                        return;
                    }

                    using (SqlCommand cmd = new SqlCommand(@"
                        SELECT u.Username, t.DepartmentId
                        FROM TeacherProfile t
                        JOIN UserProfile u ON u.ProfileId = t.ProfileId
                        WHERE t.ProfileId = @Id", con))
                    {
                        cmd.Parameters.AddWithValue("@Id", profileId);
                        using (SqlDataReader rdr = cmd.ExecuteReader())
                        {
                            if (rdr.Read())
                            {
                                hfProfileId.Value = profileId.ToString();
                                litEditingName.Text = rdr["Username"].ToString();
                                ddlDepartment.SelectedValue = rdr["DepartmentId"].ToString();
                                pnlEdit.Visible = true;
                            }
                        }
                    }
                }
                phSuccess.Visible = false;
                phError.Visible = false;
                LoadStaff();
            }
            else if (e.CommandName == "ToggleActive")
            {
                using (SqlConnection con = new SqlConnection(constr))
                {
                    con.Open();

                    int currentDeptId;
                    if (!TryGetStaffDepartment(con, profileId, out currentDeptId))
                    {
                        ShowError("Staff member not found.");
                        LoadStaff();
                        return;
                    }

                    if (!PermissionHelper.CanManageDepartment(Session, currentDeptId))
                    {
                        ShowError("You are not authorized to manage staff outside your department.");
                        LoadStaff();
                        return;
                    }

                    using (SqlCommand cmd = new SqlCommand(
                        "UPDATE UserProfile SET IsActive = ~IsActive WHERE ProfileId = @Id", con))
                    {
                        cmd.Parameters.AddWithValue("@Id", profileId);
                        cmd.ExecuteNonQuery();
                    }
                }
                ShowSuccess("Status updated.");
                LoadStaff();
            }
        }

        protected void btnSaveEdit_Click(object sender, EventArgs e)
        {
            int profileId;
            if (!int.TryParse(hfProfileId.Value, out profileId))
            {
                ShowError("Could not determine which staff member to update.");
                LoadStaff();
                return;
            }

            int deptId;
            if (!int.TryParse(ddlDepartment.SelectedValue, out deptId))
            {
                ShowError("Please choose a valid department.");
                LoadStaff();
                return;
            }

            using (SqlConnection con = new SqlConnection(constr))
            {
                con.Open();

                int currentDeptId;
                if (!TryGetStaffDepartment(con, profileId, out currentDeptId))
                {
                    ShowError("Staff member not found.");
                    LoadStaff();
                    return;
                }

                if (!PermissionHelper.CanManageDepartment(Session, currentDeptId) ||
                    !PermissionHelper.CanManageDepartment(Session, deptId))
                {
                    ShowError("You are not authorized to manage staff outside your department.");
                    LoadStaff();
                    return;
                }

                using (SqlCommand cmd = new SqlCommand(
                    "UPDATE TeacherProfile SET DepartmentId = @DeptId WHERE ProfileId = @Id", con))
                {
                    cmd.Parameters.AddWithValue("@DeptId", deptId);
                    cmd.Parameters.AddWithValue("@Id", profileId);
                    cmd.ExecuteNonQuery();
                }
            }

            pnlEdit.Visible = false;
            ShowSuccess("Staff member updated.");
            LoadStaff();
        }

        protected void btnCancelEdit_Click(object sender, EventArgs e)
        {
            pnlEdit.Visible = false;
            phSuccess.Visible = false;
            phError.Visible = false;
            LoadStaff();
        }
    }
}
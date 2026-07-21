using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;

namespace Learning_System
{
    public partial class DepartmentStaffManage : System.Web.UI.Page
    {
        protected string constr = ConfigurationManager.ConnectionStrings["conn"].ConnectionString;

        // True for MainAdmin/SuperAdmin (see everyone). False for DepartmentAdmin (scoped to own department).
        private bool IsSuperScope => !PermissionHelper.IsDepartmentAdmin(Session);

        protected void Page_Load(object sender, EventArgs e)
        {
            PermissionHelper.RequireAccessLevel(this, "MainAdmin", "SuperAdmin", "DepartmentAdmin");

            if (!IsPostBack)
            {
                LoadDepartmentsDropdown();
                LoadStaff();
            }
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
                        cmd.Parameters.AddWithValue("@DeptId", Session["DepartmentId"]);

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
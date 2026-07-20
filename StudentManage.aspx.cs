using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;

namespace Learning_System
{
    public partial class StudentManage : System.Web.UI.Page
    {
        // NOTE: assumes StudentProfile has IsActive (bit), DepartmentId (FK), and Semester (int),
        // joined to UserProfile via ProfileId for the Username. Adjust if your schema differs.
        protected string constr = ConfigurationManager.ConnectionStrings["conn"].ConnectionString;

        // True for MainAdmin/SuperAdmin (see everyone). False for DepartmentAdmin (scoped to own department).
        private bool IsSuperScope => !PermissionHelper.IsDepartmentAdmin(Session);

        protected void Page_Load(object sender, EventArgs e)
        {
            PermissionHelper.RequireAccessLevel(this, "MainAdmin", "SuperAdmin", "DepartmentAdmin");

            if (!IsPostBack)
            {
                LoadDepartmentsDropdown();
                LoadStudents();
            }
        }

        private void LoadDepartmentsDropdown()
        {
            using (SqlConnection con = new SqlConnection(constr))
            {
                // DepartmentAdmins only get their own department in the dropdown,
                // so they can't reassign a student out of their scope.
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

        private void LoadStudents()
        {
            using (SqlConnection con = new SqlConnection(constr))
            {
                string sql = @"SELECT
                                    u.ProfileId,
                                    u.UserName AS Username,
                                    d.DepartmentName,
                                    d.DepartmentCode,
                                    s.Semester,
                                    u.IsActive
                                FROM StudentProfile s
                                JOIN UserProfile u ON u.ProfileId = s.ProfileId
                                JOIN Department d ON d.DepartmentId = s.DepartmentId
                                WHERE (@IsSuper = 1 OR s.DepartmentId = @DeptId)
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
                        gvStudents.DataSource = dt;
                        gvStudents.DataBind();
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

        // Looks up the student's current DepartmentId so we can verify a DepartmentAdmin
        // is allowed to touch this record before we let them edit or toggle it.
        private bool TryGetStudentDepartment(SqlConnection con, int profileId, out int departmentId)
        {
            departmentId = 0;
            using (SqlCommand cmd = new SqlCommand(
                "SELECT DepartmentId FROM StudentProfile WHERE ProfileId = @Id", con))
            {
                cmd.Parameters.AddWithValue("@Id", profileId);
                object result = cmd.ExecuteScalar();
                if (result == null) return false;
                departmentId = Convert.ToInt32(result);
                return true;
            }
        }

        protected void gvStudents_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            int profileId;
            if (!int.TryParse(e.CommandArgument as string, out profileId)) return;

            if (e.CommandName == "EditStudent")
            {
                using (SqlConnection con = new SqlConnection(constr))
                {
                    con.Open();

                    int currentDeptId;
                    if (!TryGetStudentDepartment(con, profileId, out currentDeptId))
                    {
                        ShowError("Student not found.");
                        LoadStudents();
                        return;
                    }

                    if (!PermissionHelper.CanManageDepartment(Session, currentDeptId))
                    {
                        ShowError("You are not authorized to manage students outside your department.");
                        LoadStudents();
                        return;
                    }

                    using (SqlCommand cmd = new SqlCommand(@"
                        SELECT u.Username, s.DepartmentId, s.Semester
                        FROM StudentProfile s
                        JOIN UserProfile u ON u.ProfileId = s.ProfileId
                        WHERE s.ProfileId = @Id", con))
                    {
                        cmd.Parameters.AddWithValue("@Id", profileId);
                        using (SqlDataReader rdr = cmd.ExecuteReader())
                        {
                            if (rdr.Read())
                            {
                                hfProfileId.Value = profileId.ToString();
                                litEditingName.Text = rdr["Username"].ToString();
                                ddlDepartment.SelectedValue = rdr["DepartmentId"].ToString();
                                ddlSemester.SelectedValue = rdr["Semester"].ToString();
                                pnlEdit.Visible = true;
                            }
                        }
                    }
                }
                phSuccess.Visible = false;
                phError.Visible = false;
                LoadStudents();
            }
            else if (e.CommandName == "ToggleActive")
            {
                using (SqlConnection con = new SqlConnection(constr))
                {
                    con.Open();

                    int currentDeptId;
                    if (!TryGetStudentDepartment(con, profileId, out currentDeptId))
                    {
                        ShowError("Student not found.");
                        LoadStudents();
                        return;
                    }

                    if (!PermissionHelper.CanManageDepartment(Session, currentDeptId))
                    {
                        ShowError("You are not authorized to manage students outside your department.");
                        LoadStudents();
                        return;
                    }

                    // Login only checks UserProfile.IsActive, so that's the column that matters here.
                    using (SqlCommand cmd = new SqlCommand(
                        "UPDATE UserProfile SET IsActive = ~IsActive WHERE ProfileId = @Id", con))
                    {
                        cmd.Parameters.AddWithValue("@Id", profileId);
                        cmd.ExecuteNonQuery();
                    }
                }
                ShowSuccess("Status updated.");
                LoadStudents();
            }
        }

        protected void btnSaveEdit_Click(object sender, EventArgs e)
        {
            int profileId;
            if (!int.TryParse(hfProfileId.Value, out profileId))
            {
                ShowError("Could not determine which student to update.");
                LoadStudents();
                return;
            }

            int deptId;
            if (!int.TryParse(ddlDepartment.SelectedValue, out deptId))
            {
                ShowError("Please choose a valid department.");
                LoadStudents();
                return;
            }

            int semester;
            if (!int.TryParse(ddlSemester.SelectedValue, out semester))
            {
                ShowError("Please choose a valid semester.");
                LoadStudents();
                return;
            }

            using (SqlConnection con = new SqlConnection(constr))
            {
                con.Open();

                // Re-check both the student's current department and the target department,
                // so a DepartmentAdmin can't move a student into/out of a department they don't own.
                int currentDeptId;
                if (!TryGetStudentDepartment(con, profileId, out currentDeptId))
                {
                    ShowError("Student not found.");
                    LoadStudents();
                    return;
                }

                if (!PermissionHelper.CanManageDepartment(Session, currentDeptId) ||
                    !PermissionHelper.CanManageDepartment(Session, deptId))
                {
                    ShowError("You are not authorized to manage students outside your department.");
                    LoadStudents();
                    return;
                }

                using (SqlCommand cmd = new SqlCommand(
                    "UPDATE StudentProfile SET DepartmentId = @DeptId, Semester = @Semester WHERE ProfileId = @Id", con))
                {
                    cmd.Parameters.AddWithValue("@DeptId", deptId);
                    cmd.Parameters.AddWithValue("@Semester", semester);
                    cmd.Parameters.AddWithValue("@Id", profileId);
                    cmd.ExecuteNonQuery();
                }
            }

            pnlEdit.Visible = false;
            ShowSuccess("Student updated.");
            LoadStudents();
        }

        protected void btnCancelEdit_Click(object sender, EventArgs e)
        {
            pnlEdit.Visible = false;
            phSuccess.Visible = false;
            phError.Visible = false;
            LoadStudents();
        }
    }
}
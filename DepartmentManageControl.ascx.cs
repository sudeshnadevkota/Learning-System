using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;
using Learning_System.Common;

namespace Learning_System
{
    // Inherits System.Web.UI.UserControl instead of System.Web.UI.Page
    public partial class DepartmentManageControl : System.Web.UI.UserControl, IDynamicSection
    {
        protected string constr = ConfigurationManager.ConnectionStrings["conn"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            // Only SuperAdmin (and MainAdmin, in case they want to peek) may manage departments
            // Passed 'this.Page' instead of 'this' because the helper method expects a Page object
            PermissionHelper.RequireAccessLevel(this.Page, "MainAdmin", "SuperAdmin");

            // Data loading moved to LoadInitialData() — IsPostBack can't be trusted here,
            // since the sidebar click that creates this control is itself a postback.
        }

        // Called by BaseAdminMaster.LoadSection() right after this control is
        // freshly added to the page.
        public void LoadInitialData()
        {
            LoadDepartments();
        }

        private void LoadDepartments()
        {
            using (SqlConnection con = new SqlConnection(constr))
            {
                string sql = @"SELECT
                                    d.DepartmentId,
                                    d.DepartmentName,
                                    d.DepartmentCode,
                                    (SELECT COUNT(*) FROM AdminProfile a
                                        WHERE a.DepartmentId = d.DepartmentId AND a.AccessLevel = 'DepartmentAdmin') AS DeptAdminCount,
                                    (SELECT COUNT(*) FROM TeacherProfile t
                                        WHERE t.DepartmentId = d.DepartmentId) AS StaffCount,
                                    (SELECT COUNT(*) FROM StudentProfile s
                                        WHERE s.DepartmentId = d.DepartmentId) AS StudentCount
                                FROM Department d
                                ORDER BY d.DepartmentName";

                using (SqlCommand cmd = new SqlCommand(sql, con))
                {
                    con.Open();
                    using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                    {
                        DataTable dt = new DataTable();
                        da.Fill(dt);
                        gvDepartments.DataSource = dt;
                        gvDepartments.DataBind();
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

        private void ResetForm()
        {
            hfDepartmentId.Value = "0";
            txtDeptName.Text = string.Empty;
            txtDeptCode.Text = string.Empty;
            litFormTitle.Text = "Add Department";
            btnSave.Text = "Save Department";
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            string name = (txtDeptName.Text ?? string.Empty).Trim();
            string code = (txtDeptCode.Text ?? string.Empty).Trim();
            int deptId = 0;
            int.TryParse(hfDepartmentId.Value, out deptId);

            if (string.IsNullOrEmpty(name) || string.IsNullOrEmpty(code))
            {
                ShowError("Department name and code are both required.");
                LoadDepartments();
                return;
            }

            using (SqlConnection con = new SqlConnection(constr))
            {
                con.Open();

                // Prevent duplicate department codes (excluding the row being edited)
                using (SqlCommand dupCmd = new SqlCommand(
                    "SELECT COUNT(*) FROM Department WHERE DepartmentCode = @Code AND DepartmentId <> @Id", con))
                {
                    dupCmd.Parameters.AddWithValue("@Code", code);
                    dupCmd.Parameters.AddWithValue("@Id", deptId);
                    int dupCount = (int)dupCmd.ExecuteScalar();
                    if (dupCount > 0)
                    {
                        ShowError("A department with the code \"" + code + "\" already exists.");
                        LoadDepartments();
                        return;
                    }
                }

                if (deptId > 0)
                {
                    // Update existing department
                    using (SqlCommand cmd = new SqlCommand(
                        "UPDATE Department SET DepartmentName = @Name, DepartmentCode = @Code WHERE DepartmentId = @Id", con))
                    {
                        cmd.Parameters.AddWithValue("@Name", name);
                        cmd.Parameters.AddWithValue("@Code", code);
                        cmd.Parameters.AddWithValue("@Id", deptId);
                        cmd.ExecuteNonQuery();
                    }
                    ShowSuccess("Department \"" + name + "\" was updated.");
                }
                else
                {
                    // Insert new department
                    using (SqlCommand cmd = new SqlCommand(
                        "INSERT INTO Department (DepartmentName, DepartmentCode) VALUES (@Name, @Code)", con))
                    {
                        cmd.Parameters.AddWithValue("@Name", name);
                        cmd.Parameters.AddWithValue("@Code", code);
                        cmd.ExecuteNonQuery();
                    }
                    ShowSuccess("Department \"" + name + "\" was added.");
                }
            }

            ResetForm();
            LoadDepartments();
        }

        protected void btnCancel_Click(object sender, EventArgs e)
        {
            ResetForm();
            phSuccess.Visible = false;
            phError.Visible = false;
            LoadDepartments();
        }

        protected void gvDepartments_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            int deptId;
            if (!int.TryParse(e.CommandArgument as string, out deptId)) return;

            if (e.CommandName == "EditDept")
            {
                using (SqlConnection con = new SqlConnection(constr))
                using (SqlCommand cmd = new SqlCommand(
                    "SELECT DepartmentName, DepartmentCode FROM Department WHERE DepartmentId = @Id", con))
                {
                    cmd.Parameters.AddWithValue("@Id", deptId);
                    con.Open();
                    using (SqlDataReader rdr = cmd.ExecuteReader())
                    {
                        if (rdr.Read())
                        {
                            hfDepartmentId.Value = deptId.ToString();
                            txtDeptName.Text = rdr["DepartmentName"].ToString();
                            txtDeptCode.Text = rdr["DepartmentCode"].ToString();
                            litFormTitle.Text = "Edit Department";
                            btnSave.Text = "Update Department";
                        }
                    }
                }
                phSuccess.Visible = false;
                phError.Visible = false;
                LoadDepartments();
            }
        }
    }
}
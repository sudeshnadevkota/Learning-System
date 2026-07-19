using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;

namespace Learning_System.SuperAdmin
{
    public partial class StudentManage : System.Web.UI.Page
    {
        // NOTE: assumes StudentProfile has IsActive (bit), DepartmentId (FK), and Semester (int),
        // joined to UserProfile via ProfileId for the Username. Adjust if your schema differs.
        protected string constr = ConfigurationManager.ConnectionStrings["conn"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            PermissionHelper.RequireAccessLevel(this, "MainAdmin", "SuperAdmin");

            if (!IsPostBack)
            {
                LoadDepartmentsDropdown();
                LoadStudents();
            }
        }

        private void LoadDepartmentsDropdown()
        {
            using (SqlConnection con = new SqlConnection(constr))
            using (SqlCommand cmd = new SqlCommand("SELECT DepartmentId, DepartmentName FROM Department ORDER BY DepartmentName", con))
            {
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
                                ORDER BY u.UserName";

                using (SqlCommand cmd = new SqlCommand(sql, con))
                {
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

        protected void gvStudents_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            int profileId;
            if (!int.TryParse(e.CommandArgument as string, out profileId)) return;

            if (e.CommandName == "EditStudent")
            {
                using (SqlConnection con = new SqlConnection(constr))
                using (SqlCommand cmd = new SqlCommand(@"
                    SELECT u.Username, s.DepartmentId, s.Semester
                    FROM StudentProfile s
                    JOIN UserProfile u ON u.ProfileId = s.ProfileId
                    WHERE s.ProfileId = @Id", con))
                {
                    cmd.Parameters.AddWithValue("@Id", profileId);
                    con.Open();
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
                phSuccess.Visible = false;
                phError.Visible = false;
                LoadStudents();
            }
            else if (e.CommandName == "ToggleActive")
            {
                // Login only checks UserProfile.IsActive, so that's the column that matters here.
                using (SqlConnection con = new SqlConnection(constr))
                using (SqlCommand cmd = new SqlCommand(
                    "UPDATE UserProfile SET IsActive = ~IsActive WHERE ProfileId = @Id", con))
                {
                    cmd.Parameters.AddWithValue("@Id", profileId);
                    con.Open();
                    cmd.ExecuteNonQuery();
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
            using (SqlCommand cmd = new SqlCommand(
                "UPDATE StudentProfile SET DepartmentId = @DeptId, Semester = @Semester WHERE ProfileId = @Id", con))
            {
                cmd.Parameters.AddWithValue("@DeptId", deptId);
                cmd.Parameters.AddWithValue("@Semester", semester);
                cmd.Parameters.AddWithValue("@Id", profileId);
                con.Open();
                cmd.ExecuteNonQuery();
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
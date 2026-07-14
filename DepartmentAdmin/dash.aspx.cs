using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

namespace Learning_System.DepartmentAdmin
{
    public partial class dash : System.Web.UI.Page
    {
        protected string constr = ConfigurationManager.ConnectionStrings["conn"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            // Explicitly verify user has DepartmentAdmin clearances
            PermissionHelper.RequireAccessLevel(this, "DepartmentAdmin");

            if (Session["DepartmentId"] == null)
            {
                Response.Redirect("~/login.aspx");
                return;
            }

            if (!IsPostBack)
            {
                int deptId = Convert.ToInt32(Session["DepartmentId"]);
                string deptCode = Session["DepartmentCode"]?.ToString() ?? "Department";

                litDeptTitle.Text = deptCode.ToUpper();
                LoadScopedStats(deptId);
                LoadScopedStudents(deptId);
            }
        }

        private void LoadScopedStats(int departmentId)
        {
            using (SqlConnection con = new SqlConnection(constr))
            {
                con.Open();

                // Count staff exclusively inside this department
                litStaffCount.Text = ScalarCount(con,
                    "SELECT COUNT(*) FROM TeacherProfile WHERE DepartmentId = @DeptId", departmentId);

                // Count students exclusively inside this department
                litStudentCount.Text = ScalarCount(con,
                    "SELECT COUNT(*) FROM StudentProfile WHERE DepartmentId = @DeptId", departmentId);

                // Count notices filtered specifically to this department code
                string deptCode = Session["DepartmentCode"]?.ToString() ?? "";
                using (SqlCommand cmd = new SqlCommand("SELECT COUNT(*) FROM Notice WHERE Class = @DeptCode", con))
                {
                    cmd.Parameters.AddWithValue("@DeptCode", deptCode);
                    object res = cmd.ExecuteScalar();
                    litNoticeCount.Text = res != null ? res.ToString() : "0";
                }
            }
        }

        private string ScalarCount(SqlConnection con, string sql, int departmentId)
        {
            using (SqlCommand cmd = new SqlCommand(sql, con))
            {
                cmd.Parameters.AddWithValue("@DeptId", departmentId);
                object result = cmd.ExecuteScalar();
                return result == null ? "0" : result.ToString();
            }
        }

        private void LoadScopedStudents(int departmentId)
        {
            using (SqlConnection con = new SqlConnection(constr))
            {
                string sql = @"SELECT u.FullName, u.UserName, u.Email, s.Semester 
                               FROM StudentProfile s
                               INNER JOIN UserProfile u ON s.ProfileId = u.ProfileId
                               WHERE s.DepartmentId = @DeptId
                               ORDER BY s.Semester ASC, u.FullName ASC";

                using (SqlCommand cmd = new SqlCommand(sql, con))
                {
                    cmd.Parameters.AddWithValue("@DeptId", departmentId);
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
    }
}
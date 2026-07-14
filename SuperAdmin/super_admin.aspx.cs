using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

namespace Learning_System.SuperAdmin
{
    public partial class super_admin : System.Web.UI.Page
    {
        protected string constr = ConfigurationManager.ConnectionStrings["conn"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            // Only SuperAdmin (and MainAdmin, in case they want to peek) may reach this page
            PermissionHelper.RequireAccessLevel(this, "MainAdmin", "SuperAdmin");

            if (!IsPostBack)
            {
                LoadStats();
                LoadDepartmentOverview();
            }
        }

        private void LoadStats()
        {
            using (SqlConnection con = new SqlConnection(constr))
            {
                con.Open();

                litDeptCount.Text = ScalarCount(con, "SELECT COUNT(*) FROM Department");

                litDeptAdminCount.Text = ScalarCount(con,
                    "SELECT COUNT(*) FROM AdminProfile WHERE AccessLevel = 'DepartmentAdmin'");

                litStaffCount.Text = ScalarCount(con,
                    "SELECT COUNT(*) FROM TeacherProfile");

                litStudentCount.Text = ScalarCount(con,
                    "SELECT COUNT(*) FROM StudentProfile");

                litSubjectCount.Text = SubjectMap.Subjects.Count.ToString();
            }
        }

        private string ScalarCount(SqlConnection con, string sql)
        {
            using (SqlCommand cmd = new SqlCommand(sql, con))
            {
                object result = cmd.ExecuteScalar();
                return result == null ? "0" : result.ToString();
            }
        }

        private void LoadDepartmentOverview()
        {
            using (SqlConnection con = new SqlConnection(constr))
            {
                string sql = @"SELECT
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
    }
}
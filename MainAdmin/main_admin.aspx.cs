using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;

namespace Learning_System.MainAdmin
{
    public partial class main_admin : System.Web.UI.Page
    {
        protected string constr = ConfigurationManager.ConnectionStrings["conn"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadStats();
                LoadSuperAdmins();
                LoadDepartmentOverview();
            }
        }

        // ===== Top stat cards =====
        private void LoadStats()
        {
            using (SqlConnection con = new SqlConnection(constr))
            {
                con.Open();

                litDeptCount.Text = ScalarCount(con, "SELECT COUNT(*) FROM Department");

                litSuperAdminCount.Text = ScalarCount(con,
                    "SELECT COUNT(*) FROM AdminProfile WHERE AccessLevel = 'SuperAdmin'");

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

        // ===== SuperAdmin table =====
        private void LoadSuperAdmins()
        {
            using (SqlConnection con = new SqlConnection(constr))
            {
                string sql = @"SELECT a.AdminProfileId, u.FullName, u.Email
                                FROM AdminProfile a
                                INNER JOIN UserProfile u ON a.ProfileId = u.ProfileId
                                WHERE a.AccessLevel = 'SuperAdmin'";
                using (SqlCommand cmd = new SqlCommand(sql, con))
                {
                    con.Open();
                    using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                    {
                        DataTable dt = new DataTable();
                        da.Fill(dt);
                        gvSuperAdmins.DataSource = dt;
                        gvSuperAdmins.DataBind();
                    }
                }
            }
        }

        // ===== Department overview table =====
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

        // ===== SuperAdmin actions =====
        protected void lnkSuspend_Click(object sender, EventArgs e)
        {
            LinkButton lnk = (LinkButton)sender;
            int adminProfileId = Convert.ToInt32(lnk.CommandArgument);

            // AdminProfile has no Status column in the current schema.
            // Suspension would need to go through UserProfile.IsActive instead
            // (via the ProfileId FK on AdminProfile). Left as TODO until you confirm
            // whether "suspend" should mean IsActive = 0 on UserProfile.

            LoadSuperAdmins();
        }

        protected void lnkRemove_Click(object sender, EventArgs e)
        {
            LinkButton lnk = (LinkButton)sender;
            int adminProfileId = Convert.ToInt32(lnk.CommandArgument);

            using (SqlConnection con = new SqlConnection(constr))
            {
                string sql = "DELETE FROM AdminProfile WHERE AdminProfileId = @id";
                using (SqlCommand cmd = new SqlCommand(sql, con))
                {
                    cmd.Parameters.AddWithValue("@id", adminProfileId);
                    con.Open();
                    cmd.ExecuteNonQuery();
                }
            }

            LoadSuperAdmins();
        }
    }
}
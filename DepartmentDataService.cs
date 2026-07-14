using System;
using System.Data;
using System.Data.SqlClient;

namespace Learning_System
{
    // Shared data-access for every department's dash.aspx (DepartmentAdmin) and the
    // single shared Staff/default_staff.aspx page. Both roles manage department-scoped
    // Staff/Student rosters — this keeps that SQL in one place instead of duplicated
    // across 6 department folders.
    public static class DepartmentDataService
    {
        public static int GetStaffCount(string connStr, int departmentId) =>
            ScalarInt(connStr, "SELECT COUNT(*) FROM TeacherProfile WHERE DepartmentId = @DeptId", departmentId);

        public static int GetStudentCount(string connStr, int departmentId) =>
            ScalarInt(connStr, "SELECT COUNT(*) FROM StudentProfile WHERE DepartmentId = @DeptId", departmentId);

        private static int ScalarInt(string connStr, string sql, int departmentId)
        {
            using (SqlConnection con = new SqlConnection(connStr))
            using (SqlCommand cmd = new SqlCommand(sql, con))
            {
                cmd.Parameters.AddWithValue("@DeptId", departmentId);
                con.Open();
                object result = cmd.ExecuteScalar();
                return result == null ? 0 : Convert.ToInt32(result);
            }
        }

        // IsActive comes from UserProfile — the same column login.aspx.cs already
        // checks — so Suspend/Reinstate here takes effect on next login immediately.
        public static DataTable GetStaffList(string connStr, int departmentId) => Fill(connStr, @"
            SELECT T.ProfileId, U.FullName, U.UserName, U.IsActive
            FROM TeacherProfile T
            JOIN UserProfile U ON U.ProfileId = T.ProfileId
            WHERE T.DepartmentId = @DeptId
            ORDER BY U.FullName", departmentId);

        public static DataTable GetStudentList(string connStr, int departmentId) => Fill(connStr, @"
            SELECT S.ProfileId, U.FullName, U.UserName, U.IsActive
            FROM StudentProfile S
            JOIN UserProfile U ON U.ProfileId = S.ProfileId
            WHERE S.DepartmentId = @DeptId
            ORDER BY U.FullName", departmentId);

        private static DataTable Fill(string connStr, string sql, int departmentId)
        {
            using (SqlConnection con = new SqlConnection(connStr))
            using (SqlCommand cmd = new SqlCommand(sql, con))
            using (SqlDataAdapter da = new SqlDataAdapter(cmd))
            {
                cmd.Parameters.AddWithValue("@DeptId", departmentId);
                DataTable dt = new DataTable();
                da.Fill(dt);
                return dt;
            }
        }

        public static void SetActive(string connStr, int profileId, bool active)
        {
            using (SqlConnection con = new SqlConnection(connStr))
            using (SqlCommand cmd = new SqlCommand(
                "UPDATE UserProfile SET IsActive = @Active WHERE ProfileId = @ProfileId", con))
            {
                cmd.Parameters.AddWithValue("@Active", active);
                cmd.Parameters.AddWithValue("@ProfileId", profileId);
                con.Open();
                cmd.ExecuteNonQuery();
            }
        }

        // roleTable is always a hardcoded literal passed by the code-behind
        // ("TeacherProfile" / "StudentProfile"), never user input.
        // Removes both the role-specific row and the UserProfile row so nothing orphans.
        public static void Delete(string connStr, string roleTable, int profileId)
        {
            using (SqlConnection con = new SqlConnection(connStr))
            {
                con.Open();
                SqlTransaction tx = con.BeginTransaction();
                try
                {
                    using (SqlCommand cmd = new SqlCommand(
                        "DELETE FROM " + roleTable + " WHERE ProfileId = @ProfileId", con, tx))
                    {
                        cmd.Parameters.AddWithValue("@ProfileId", profileId);
                        cmd.ExecuteNonQuery();
                    }
                    using (SqlCommand cmd2 = new SqlCommand(
                        "DELETE FROM UserProfile WHERE ProfileId = @ProfileId", con, tx))
                    {
                        cmd2.Parameters.AddWithValue("@ProfileId", profileId);
                        cmd2.ExecuteNonQuery();
                    }
                    tx.Commit();
                }
                catch
                {
                    tx.Rollback();
                    throw;
                }
            }
        }
    }
}
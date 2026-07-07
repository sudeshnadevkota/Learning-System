using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

namespace Learning_System
{
    public partial class register : System.Web.UI.Page
    {
        string constr = ConfigurationManager.ConnectionStrings["conn"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            string userType = Status.SelectedValue;

            if (string.IsNullOrWhiteSpace(userType))
            {
                return;
            }

            string role = userType == "students" ? "Student"
                        : userType == "Staff" ? "Staff"
                        : "Admin";

            using (SqlConnection con = new SqlConnection(constr))
            {
                con.Open();
                SqlTransaction transaction = con.BeginTransaction();

                try
                {
                    // 1. Insert directly into UserProfile — Username/Password now live here,
                    //    no more separate Login table or two-step insert
                    int newProfileId;
                    string profileQuery = @"INSERT INTO UserProfile
                                (FullName, Email, ContactNumber, DOB, Gender, Address, Role, ProfilePhoto, Username, Password, RegisteredDate, Status)
                                OUTPUT INSERTED.ProfileId
                                VALUES
                                (@FullName, @Email, @ContactNumber, @DOB, @Gender, @Address, @Role, @ProfilePhoto, @Username, @Password, GETDATE(), 1)";

                    using (SqlCommand cmd = new SqlCommand(profileQuery, con, transaction))
                    {
                        cmd.Parameters.AddWithValue("@FullName", Full_name.Text.Trim());
                        cmd.Parameters.AddWithValue("@Email", Email.Text.Trim());
                        cmd.Parameters.AddWithValue("@ContactNumber", Contact.Text.Trim());
                        cmd.Parameters.AddWithValue("@DOB", Convert.ToDateTime(Dob.Text));
                        cmd.Parameters.AddWithValue("@Gender", Gender.SelectedValue);
                        cmd.Parameters.AddWithValue("@Address", "");
                        cmd.Parameters.AddWithValue("@Role", role);
                        cmd.Parameters.AddWithValue("@Username", username.Text.Trim());

                        // TODO: replace with your existing password hashing method
                        cmd.Parameters.AddWithValue("@Password", Password.Text);

                        SqlParameter photoParam = cmd.Parameters.Add("@ProfilePhoto", SqlDbType.VarBinary, -1);
                        photoParam.Value = ProfilePhotoUpload.HasFile
                            ? (object)ProfilePhotoUpload.FileBytes
                            : DBNull.Value;

                        newProfileId = (int)cmd.ExecuteScalar();
                    }

                    // 2. Insert into the role-specific table (unchanged, still keyed on ProfileId)
                    if (role == "Student")
                    {
                        string q = @"INSERT INTO StudentProfile (ProfileId, Semester, SubjectName, RollNumber)
                                     VALUES (@ProfileId, @Semester, @SubjectName, @RollNumber)";
                        using (SqlCommand cmd = new SqlCommand(q, con, transaction))
                        {
                            cmd.Parameters.AddWithValue("@ProfileId", newProfileId);
                            cmd.Parameters.AddWithValue("@Semester", Convert.ToInt32(Semester.SelectedValue));
                            cmd.Parameters.AddWithValue("@SubjectName", Faculty.SelectedValue);
                            cmd.Parameters.AddWithValue("@RollNumber",
                                string.IsNullOrWhiteSpace(LCID.Text) ? (object)DBNull.Value : LCID.Text.Trim());
                            cmd.ExecuteNonQuery();
                        }
                    }
                    else if (role == "Staff")
                    {
                        string q = @"INSERT INTO TeacherProfile (ProfileId, Designation, Department, SubjectsHandled)
                                     VALUES (@ProfileId, @Designation, @Department, @SubjectsHandled)";
                        using (SqlCommand cmd = new SqlCommand(q, con, transaction))
                        {
                            cmd.Parameters.AddWithValue("@ProfileId", newProfileId);
                            cmd.Parameters.AddWithValue("@Designation", string.IsNullOrWhiteSpace(Designation.Text) ? (object)DBNull.Value : Designation.Text.Trim());
                            cmd.Parameters.AddWithValue("@Department", string.IsNullOrWhiteSpace(StaffDepartment.Text) ? (object)DBNull.Value : StaffDepartment.Text.Trim());
                            cmd.Parameters.AddWithValue("@SubjectsHandled", string.IsNullOrWhiteSpace(SubjectsHandled.Text) ? (object)DBNull.Value : SubjectsHandled.Text.Trim());
                            cmd.ExecuteNonQuery();
                        }
                    }
                    else // Admin
                    {
                        string q = @"INSERT INTO AdminProfile (ProfileId, AccessLevel, Department)
                                     VALUES (@ProfileId, @AccessLevel, @Department)";
                        using (SqlCommand cmd = new SqlCommand(q, con, transaction))
                        {
                            cmd.Parameters.AddWithValue("@ProfileId", newProfileId);
                            cmd.Parameters.AddWithValue("@AccessLevel", AccessLevel.SelectedValue);
                            cmd.Parameters.AddWithValue("@Department", string.IsNullOrWhiteSpace(AdminDepartment.Text) ? (object)DBNull.Value : AdminDepartment.Text.Trim());
                            cmd.ExecuteNonQuery();
                        }
                    }

                    transaction.Commit();
                    Response.Redirect("Login.aspx?registered=true");
                }
                catch (SqlException sqlEx) when (sqlEx.Number == 2627 || sqlEx.Number == 2601)
                {
                    SafeRollback(transaction);
                    lblError.Text = "That email or username is already registered. Please use a different one.";
                }
                catch (Exception ex)
                {
                    SafeRollback(transaction);
                    lblError.Text = "Registration failed: " + ex.Message;
                }
            }
        }

        private void SafeRollback(SqlTransaction transaction)
        {
            try
            {
                if (transaction.Connection != null)
                    transaction.Rollback();
            }
            catch
            {
                // transaction was already completed/rolled back by SQL Server — ignore
            }
        }
    }
}
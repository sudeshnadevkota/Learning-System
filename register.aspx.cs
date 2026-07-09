using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;

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
            if (!Page.IsValid) return;

            using (SqlConnection con = new SqlConnection(constr))
            {
                con.Open();
                SqlTransaction transaction = con.BeginTransaction();

                try
                {
                    // 1. Look up DepartmentId from the chosen Faculty code (BIT, BCS, etc.)
                    int departmentId;
                    string deptQuery = "SELECT DepartmentId FROM Department WHERE DepartmentCode = @Code";
                    using (SqlCommand cmd = new SqlCommand(deptQuery, con, transaction))
                    {
                        cmd.Parameters.AddWithValue("@Code", Faculty.SelectedValue);
                        object result = cmd.ExecuteScalar();
                        if (result == null)
                        {
                            throw new Exception("Selected faculty is not a recognized department.");
                        }
                        departmentId = (int)result;
                    }

                    // 2. Read profile photo bytes (if uploaded)
                    byte[] photoBytes = null;
                    if (ProfilePhotoUpload.HasFile)
                    {
                        using (var ms = new MemoryStream())
                        {
                            ProfilePhotoUpload.PostedFile.InputStream.CopyTo(ms);
                            photoBytes = ms.ToArray();
                        }
                    }

                    // 3. Insert into UserProfile (consolidated auth + profile table)
                    int newProfileId;
                    string profileQuery = @"INSERT INTO UserProfile
                                (FullName, UserName, Password, Email, ContactNumber, DOB, Gender, Address,
                                 Role, ProfilePhoto, RegisteredDate, ApprovalStatus, IsActive)
                                OUTPUT INSERTED.ProfileId
                                VALUES
                                (@FullName, @UserName, @Password, @Email, @ContactNumber, @DOB, @Gender, @Address,
                                 'Student', @ProfilePhoto, GETDATE(), 'Approved', 1)";

                    using (SqlCommand cmd = new SqlCommand(profileQuery, con, transaction))
                    {
                        cmd.Parameters.AddWithValue("@FullName", Full_name.Text.Trim());
                        cmd.Parameters.AddWithValue("@UserName", username.Text.Trim());

                        // TODO: replace with your existing password hashing method
                        cmd.Parameters.AddWithValue("@Password", Password.Text);

                        cmd.Parameters.AddWithValue("@Email", Email.Text.Trim());
                        cmd.Parameters.AddWithValue("@ContactNumber", Contact.Text.Trim());
                        cmd.Parameters.AddWithValue("@DOB", Convert.ToDateTime(Dob.Text));
                        cmd.Parameters.AddWithValue("@Gender", Gender.SelectedValue);

                        // NOTE: form has no Address field yet — stored empty until one is added
                        cmd.Parameters.AddWithValue("@Address", "");

                        SqlParameter photoParam = cmd.Parameters.Add("@ProfilePhoto", SqlDbType.VarBinary, -1);
                        photoParam.Value = (object)photoBytes ?? DBNull.Value;

                        newProfileId = (int)cmd.ExecuteScalar();
                    }

                    // 4. Insert into StudentProfile
                    string studentQuery = @"INSERT INTO StudentProfile (ProfileId, Semester, DepartmentId, RollNumber)
                                             VALUES (@ProfileId, @Semester, @DepartmentId, @RollNumber)";
                    using (SqlCommand cmd = new SqlCommand(studentQuery, con, transaction))
                    {
                        cmd.Parameters.AddWithValue("@ProfileId", newProfileId);
                        cmd.Parameters.AddWithValue("@Semester", Convert.ToInt32(Semester.SelectedValue));
                        cmd.Parameters.AddWithValue("@DepartmentId", departmentId);
                        cmd.Parameters.AddWithValue("@RollNumber", string.IsNullOrWhiteSpace(LCID.Text) ? (object)DBNull.Value : LCID.Text.Trim());
                        cmd.ExecuteNonQuery();
                    }

                    transaction.Commit();
                    Response.Redirect("Login.aspx?registered=true");
                }
                catch (Exception ex)
                {
                    transaction.Rollback();
                    lblError.Text = "Registration failed: " + ex.Message;
                }
            }
        }
    }
}
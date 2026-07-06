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
            // Status.SelectedValue is one of: "students" / "Staff" / "Admin"
            string userType = Status.SelectedValue;

            if (string.IsNullOrWhiteSpace(userType))
            {
                return; // RequiredFieldValidator already covers this on the client, guard server-side too
            }

            // Map the dropdown value to the Role stored in Login/UserProfile
            string role = userType == "students" ? "Student"
                        : userType == "Staff" ? "Staff"
                        : "Admin";

            using (SqlConnection con = new SqlConnection(constr))
            {
                con.Open();
                SqlTransaction transaction = con.BeginTransaction();

                try
                {
                    // 1. Insert into Login, get the new UserId
                    int newUserId;
                    string loginQuery = @"INSERT INTO Login (Username, Password, Role, CreatedDate)
                                           OUTPUT INSERTED.UserId
                                           VALUES (@Username, @Password, @Role, GETDATE())";

                    using (SqlCommand cmd = new SqlCommand(loginQuery, con, transaction))
                    {
                        cmd.Parameters.AddWithValue("@Username", username.Text.Trim());

                        // TODO: replace with your existing password hashing method
                        // (whatever Login.aspx.cs / your original register.aspx.cs uses)
                        cmd.Parameters.AddWithValue("@Password", Password.Text);

                        cmd.Parameters.AddWithValue("@Role", role);
                        newUserId = (int)cmd.ExecuteScalar();
                    }

                    // 2. Insert into UserProfile (base/master table — common fields)
                    int newProfileId;
                    string profileQuery = @"INSERT INTO UserProfile
                                (UserId, FullName, Email, ContactNumber, DOB, Address, Role, RegisteredDate, Status)
                                OUTPUT INSERTED.ProfileId
                                VALUES
                                (@UserId, @FullName, @Email, @ContactNumber, @DOB, @Address, @Role, GETDATE(), 1)";

                    using (SqlCommand cmd = new SqlCommand(profileQuery, con, transaction))
                    {
                        cmd.Parameters.AddWithValue("@UserId", newUserId);
                        cmd.Parameters.AddWithValue("@FullName", Full_name.Text.Trim());
                        cmd.Parameters.AddWithValue("@Email", Email.Text.Trim());
                        cmd.Parameters.AddWithValue("@ContactNumber", Contact.Text.Trim());
                        cmd.Parameters.AddWithValue("@DOB", Convert.ToDateTime(Dob.Text));
                        // NOTE: your form has no Address field yet — add an Address TextBox
                        // if you want it captured, otherwise this stores an empty string
                        cmd.Parameters.AddWithValue("@Address", "");
                        cmd.Parameters.AddWithValue("@Role", role);
                        newProfileId = (int)cmd.ExecuteScalar();
                    }

                    // 3. Insert into the role-specific table
                    if (role == "Student")
                    {
                        string q = @"INSERT INTO StudentProfile (ProfileId, Semester, SubjectName)
                                     VALUES (@ProfileId, @Semester, @SubjectName)";
                        using (SqlCommand cmd = new SqlCommand(q, con, transaction))
                        {
                            cmd.Parameters.AddWithValue("@ProfileId", newProfileId);
                            cmd.Parameters.AddWithValue("@Semester", Convert.ToInt32(Semester.SelectedValue));
                            cmd.Parameters.AddWithValue("@SubjectName", Faculty.SelectedValue);
                            cmd.ExecuteNonQuery();
                        }
                    }
                    else if (role == "Staff")
                    {
                        string q = @"INSERT INTO TeacherProfile (ProfileId, Designation, Department)
                                     VALUES (@ProfileId, @Designation, @Department)";
                        using (SqlCommand cmd = new SqlCommand(q, con, transaction))
                        {
                            cmd.Parameters.AddWithValue("@ProfileId", newProfileId);
                            cmd.Parameters.AddWithValue("@Designation", string.IsNullOrWhiteSpace(Designation.Text) ? (object)DBNull.Value : Designation.Text.Trim());
                            cmd.Parameters.AddWithValue("@Department", string.IsNullOrWhiteSpace(StaffDepartment.Text) ? (object)DBNull.Value : StaffDepartment.Text.Trim());
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
                catch (Exception ex)
                {
                    transaction.Rollback();
                    // Surface the error however your other pages do (e.g. a Label control)
                    // lblError.Text = "Registration failed: " + ex.Message;
                }
            }
        }
    }
}

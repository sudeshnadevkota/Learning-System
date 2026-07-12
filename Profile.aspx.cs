using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;

namespace Learning_System
{
    public partial class Profile : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["ProfileId"] == null) Response.Redirect("~/login.aspx");
            if (!IsPostBack) LoadProfile();
        }

        private void LoadProfile()
        {
            using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["conn"].ConnectionString))
            {
                string query = @"
                    SELECT 
                        u.FullName, 
                        u.Email, 
                        u.ContactNumber, 
                        u.Address, 
                        u.DOB, 
                        u.ProfilePhoto,
                        sp.RollNumber,
                        sp.ParentName,
                        sp.ParentContact
                    FROM UserProfile u
                    LEFT JOIN StudentProfile sp ON sp.ProfileId = u.ProfileId
                    WHERE u.ProfileId = @PID";

                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@PID", Session["ProfileId"]);
                conn.Open();

                using (SqlDataReader dr = cmd.ExecuteReader())
                {
                    if (dr.Read())
                    {
                        txtFullName.Text = dr["FullName"].ToString();
                        txtEmail.Text = dr["Email"].ToString();
                        txtContact.Text = dr["ContactNumber"].ToString();
                        txtAddress.Text = dr["Address"].ToString();

                        if (dr["DOB"] != DBNull.Value)
                            txtDOB.Text = Convert.ToDateTime(dr["DOB"]).ToString("yyyy-MM-dd");

                        txtLCID.Text = dr["RollNumber"] != DBNull.Value ? dr["RollNumber"].ToString() : "";
                        txtParentName.Text = dr["ParentName"] != DBNull.Value ? dr["ParentName"].ToString() : "";
                        txtParentContact.Text = dr["ParentContact"] != DBNull.Value ? dr["ParentContact"].ToString() : "";

                        // Sidebar labels
                        lblDisplayName.Text = dr["FullName"].ToString();
                        lblEmail.Text = dr["Email"].ToString();
                        lblStudentId.Text = "Student ID: " + (dr["RollNumber"] != DBNull.Value ? dr["RollNumber"].ToString() : "");

                        if (dr["ProfilePhoto"] != DBNull.Value)
                            imgProfile.ImageUrl = "data:image/jpeg;base64," + Convert.ToBase64String((byte[])dr["ProfilePhoto"]);
                    }
                }
            }
        }

        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["conn"].ConnectionString))
            {
                conn.Open();
                SqlTransaction tran = conn.BeginTransaction();

                try
                {
                    // 1) Update UserProfile
                    string userQuery = @"
                        UPDATE UserProfile 
                        SET FullName = @Name, 
                            Email = @Email,
                            ContactNumber = @Contact, 
                            Address = @Addr,
                            DOB = @DOB
                        WHERE ProfileId = @PID";

                    SqlCommand userCmd = new SqlCommand(userQuery, conn, tran);
                    userCmd.Parameters.AddWithValue("@Name", txtFullName.Text.Trim());
                    userCmd.Parameters.AddWithValue("@Email", txtEmail.Text.Trim());
                    userCmd.Parameters.AddWithValue("@Contact", txtContact.Text.Trim());
                    userCmd.Parameters.AddWithValue("@Addr", txtAddress.Text.Trim());

                    if (DateTime.TryParse(txtDOB.Text, out DateTime dob))
                        userCmd.Parameters.AddWithValue("@DOB", dob);
                    else
                        userCmd.Parameters.AddWithValue("@DOB", DBNull.Value);

                    userCmd.Parameters.AddWithValue("@PID", Session["ProfileId"]);
                    userCmd.ExecuteNonQuery();

                    // 2) Update StudentProfile (ParentName / ParentContact)
                    string studentQuery = @"
                        UPDATE StudentProfile 
                        SET ParentName = @ParentName, 
                            ParentContact = @ParentContact
                        WHERE ProfileId = @PID";

                    SqlCommand studentCmd = new SqlCommand(studentQuery, conn, tran);
                    studentCmd.Parameters.AddWithValue("@ParentName", txtParentName.Text.Trim());
                    studentCmd.Parameters.AddWithValue("@ParentContact", txtParentContact.Text.Trim());
                    studentCmd.Parameters.AddWithValue("@PID", Session["ProfileId"]);
                    studentCmd.ExecuteNonQuery();

                    tran.Commit();
                    lblMsg.Text = "Profile Updated Successfully!";

                    // Refresh sidebar + form values after update
                    LoadProfile();
                }
                catch (Exception ex)
                {
                    tran.Rollback();

                    if (ex is SqlException sqlEx && (sqlEx.Number == 2601 || sqlEx.Number == 2627))
                    {
                        lblMsg.Text = "This email is already in use by another account.";
                    }
                    else
                    {
                        lblMsg.Text = "Update failed: " + ex.Message;
                    }
                }
            }
        }
    }
}
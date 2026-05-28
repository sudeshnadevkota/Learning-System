using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Helpers;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Learning_System
{
    public partial class register : System.Web.UI.Page
    {
        string connectionString = ConfigurationManager.ConnectionStrings["conn"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            string full_name = Full_name.Text;
            string dob = Dob.Text;
            string contact = Contact.Text;
            string email = Email.Text;
            string Username = username.Text;
            string password = Password.Text;
            string status = Status.SelectedValue;
            string faculty = Faculty.SelectedValue;
            if (IsUserRegistered(contact, Username))
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('User already registered with the provided contact or email.');", true);
            }
            else
            {
                SaveFormData(full_name, dob, contact, email, Username, password, status, faculty);
            }
            ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('An unexpected error occurred. Please try again later.');", true);
        }
        private bool IsUserRegistered(string contact, string email)
        {
            string query = "SELECT COUNT(*) FROM login_ WHERE contact = @contact OR Username = @Username";
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@contact", contact);
                cmd.Parameters.AddWithValue("@Username", email);
                conn.Open();
                int count = (int)cmd.ExecuteScalar();
                return count > 0;
            }
        }
        private void SaveFormData(string full_name, string dob, string contact, string email, string Username, string password, string status, string faculty)
        {
            string query = "INSERT INTO login_ (full_name, dob, contact, email, Username, password, status, faculty) " +
                           "VALUES (@full_name, @dob, @contact, @email, @Username, @password, @status, @faculty)";
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@full_name", full_name);
                cmd.Parameters.AddWithValue("@dob", dob);
                cmd.Parameters.AddWithValue("@contact", contact);
                cmd.Parameters.AddWithValue("@email", email);
                cmd.Parameters.AddWithValue("@Username", Username);
                cmd.Parameters.AddWithValue("@password", password);
                cmd.Parameters.AddWithValue("@status", status);
                cmd.Parameters.AddWithValue("@faculty", faculty);
                conn.Open();
                cmd.ExecuteNonQuery();
                Response.Redirect("login.aspx");
            }
        }
    }
}
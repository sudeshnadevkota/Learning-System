using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Web.UI;

namespace Learning_System
{
    public partial class Contact : Page
    {
        // Connection string from Web.config
        string connString = ConfigurationManager.ConnectionStrings["conn"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void SubmitButton_Click(object sender, EventArgs e)
        {
            // Validation
            if (string.IsNullOrWhiteSpace(name.Text) ||
                string.IsNullOrWhiteSpace(email.Text) ||
                string.IsNullOrWhiteSpace(subject.Text) ||
                string.IsNullOrWhiteSpace(message.Text))
            {
                Response.Write("<script>alert('Please fill all fields!');</script>");
                return;
            }

            try
            {
                using (SqlConnection con = new SqlConnection(connString))
                {
                    string query = @"INSERT INTO Contact
                                    (Name, Email, Subject, Message)
                                    VALUES
                                    (@Name, @Email, @Subject, @Message)";

                    using (SqlCommand cmd = new SqlCommand(query, con))
                    {
                        cmd.Parameters.AddWithValue("@Name", name.Text.Trim());
                        cmd.Parameters.AddWithValue("@Email", email.Text.Trim());
                        cmd.Parameters.AddWithValue("@Subject", subject.Text.Trim());
                        cmd.Parameters.AddWithValue("@Message", message.Text.Trim());

                        con.Open();
                        cmd.ExecuteNonQuery();
                        con.Close();
                    }
                }

                // Success Message
                Response.Write("<script>alert('Message Sent Successfully!');</script>");

                // Clear Form
                name.Text = "";
                email.Text = "";
                subject.Text = "";
                message.Text = "";
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('Error: " + ex.Message.Replace("'", "") + "');</script>");
            }
        }
    }
}
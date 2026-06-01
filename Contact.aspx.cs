using System;

using System.Data.SqlClient;
using System.Web.UI;
using System.Configuration; // Needed for ConfigurationManager


namespace Learning_System
{
    public partial class Contact : Page
    {
<<<<<<< HEAD
        protected void Page_Load(object sender, EventArgs e)
        {
            // Optional: Add any logic needed when the page loads.

        }

        protected void SubmitButton_Click(object sender, EventArgs e)
        {
            // Validate inputs before proceeding

            if (string.IsNullOrWhiteSpace(name.Text) ||
                string.IsNullOrWhiteSpace(email.Text) ||
                string.IsNullOrWhiteSpace(subject.Text) ||
                string.IsNullOrWhiteSpace(message.Text))
            {
<<<<<<< HEAD
                // Display an error message to the user
                // e.g., ErrorLabel.Text = "All fields are required.";
                return;
            }

            string nameValue = name.Text.Trim();
            string emailValue = email.Text.Trim();
            string subjectValue = subject.Text.Trim();
            string messageValue = message.Text.Trim();

            // Retrieve the connection string from the web.config file
            string connString = ConfigurationManager.ConnectionStrings["conn"].ConnectionString;

            // SQL query to insert data into the Contact table
            string query = "INSERT INTO Contact (Name, Email, Subject, Message) VALUES (@Name, @Email, @Subject, @Message)";

            try
            {
                // Using statement ensures the connection is closed and disposed properly
                using (SqlConnection connection = new SqlConnection(connString))
                {
                    using (SqlCommand command = new SqlCommand(query, connection))
                    {
                        // Add parameters with explicit data types to avoid SQL injection and data type issues
                        command.Parameters.Add("@Name", System.Data.SqlDbType.NVarChar).Value = nameValue;
                        command.Parameters.Add("@Email", System.Data.SqlDbType.NVarChar).Value = emailValue;
                        command.Parameters.Add("@Subject", System.Data.SqlDbType.NVarChar).Value = subjectValue;
                        command.Parameters.Add("@Message", System.Data.SqlDbType.NVarChar).Value = messageValue;

                        // Open the connection, execute the query, and close the connection
                        connection.Open();
                        command.ExecuteNonQuery();
                    }
                }

                // Clear the form fields after successful submission

                name.Text = "";
                email.Text = "";
                subject.Text = "";
                message.Text = "";
<<<<<<< HEAD

                // Display a success message to the user
                // e.g., SuccessLabel.Text = "Your message has been sent successfully!";
            }
            catch (Exception ex)
            {
                // Handle any errors that may have occurred
                // e.g., ErrorLabel.Text = "An error occurred: " + ex.Message;
            }
        }
    }
}


using System;
using System.Configuration;
using System.Data.SqlClient;

namespace Learning_System
{
    public partial class Feedback : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void SubmitButton_Click(object sender, EventArgs e)
        {

            // Get the connection string from Web.config
            string connString = ConfigurationManager.ConnectionStrings["conn"].ConnectionString;

            // Retrieve form data from the TextBox controls
            string nameValue = name.Text.Trim();
            string emailValue = email.Text.Trim();
            string phoneNumberValue = PhoneNumber.Text.Trim();
            string messageValue = message.Text.Trim();

            // SQL query to insert data into the Feedback table
            string query = "INSERT INTO Feedback (Name, Email, PhoneNumber, Message) VALUES (@Name, @Email, @PhoneNumber, @Message)";

            // Using the connection and command to execute the query
            using (SqlConnection connection = new SqlConnection(connString))
            {
                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    // Adding parameters to prevent SQL injection
                    command.Parameters.AddWithValue("@Name", nameValue);
                    command.Parameters.AddWithValue("@Email", emailValue);
                    command.Parameters.AddWithValue("@PhoneNumber", phoneNumberValue);
                    command.Parameters.AddWithValue("@Message", messageValue);

                    // Open the connection, execute the query, and close the connection
                    connection.Open();
                    command.ExecuteNonQuery();
                    connection.Close();
                }
            }

            // Clear the form fields after submission
            name.Text = "";
            email.Text = "";
            PhoneNumber.Text = "";
            message.Text = "";
        }
    }
}

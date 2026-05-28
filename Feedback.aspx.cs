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
            try
            {
                int rating = GetRating();

                string connString = ConfigurationManager.ConnectionStrings["conn"].ConnectionString;

                using (SqlConnection connection = new SqlConnection(connString))
                {
                    string query = @"INSERT INTO Feedback
                                    (Name, Email, PhoneNumber, Message, Rating)
                                    VALUES
                                    (@Name, @Email, @PhoneNumber, @Message, @Rating)";

                    using (SqlCommand command = new SqlCommand(query, connection))
                    {
                        command.Parameters.AddWithValue("@Name", txtName.Text.Trim());
                        command.Parameters.AddWithValue("@Email", txtEmail.Text.Trim());
                        command.Parameters.AddWithValue("@PhoneNumber", txtPhone.Text.Trim());
                        command.Parameters.AddWithValue("@Message", txtMessage.Text.Trim());
                        command.Parameters.AddWithValue("@Rating", rating);

                        connection.Open();

                        int rows = command.ExecuteNonQuery();

                        if (rows > 0)
                        {
                            txtName.Text = "";
                            txtEmail.Text = "";
                            txtPhone.Text = "";
                            txtMessage.Text = "";

                            Response.Write("<script>alert('🎉 Thank you! Feedback submitted successfully.');</script>");
                        }
                        else
                        {
                            Response.Write("<script>alert('Failed to submit feedback!');</script>");
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('Error: " + ex.Message.Replace("'", "") + "');</script>");
            }
        }

        private int GetRating()
        {
            string rating = Request.Form["rating"];

            if (string.IsNullOrEmpty(rating))
            {
                return 0;
            }

            return Convert.ToInt32(rating);
        }
    }
}
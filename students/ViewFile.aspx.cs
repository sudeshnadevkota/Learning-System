using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Learning_System.students
{
    public partial class ViewFile : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["id"] == null) 
            {
                Response.Redirect("../login.aspx"); 
                return;
            }
            if (!IsPostBack)
            {
                string fileId = Request.QueryString["id"];
                if (!string.IsNullOrEmpty(fileId))
                {
                    DisplayFile(fileId);
                }
            }
        }

        private void DisplayFile(string fileId)
        {
            string connString = ConfigurationManager.ConnectionStrings["conn"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connString))
            {
                using (SqlCommand cmd = new SqlCommand("SELECT Name, Data, ContentType FROM bit_1_BE WHERE Id = @Id", conn))
                {
                    cmd.Parameters.AddWithValue("@Id", fileId);
                    conn.Open();

                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                            byte[] fileData = (byte[])reader["Data"];
                            string contentType = reader["ContentType"].ToString();

                            // Send the file to the browser
                            Response.Clear();
                            Response.ContentType = contentType;
                            Response.BinaryWrite(fileData);
                            Response.Flush();
                            Response.End();
                        }
                        else
                        {
                            Response.Write("File not found.");
                        }
                    }
                }
            }
        }
    }
}
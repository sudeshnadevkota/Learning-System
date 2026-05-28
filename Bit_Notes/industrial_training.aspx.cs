using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Learning_System.Bit_Notes
{
    public partial class industrial_training : System.Web.UI.Page
    {
        private string connectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                connectionString = ConfigurationManager.ConnectionStrings["conn"].ConnectionString;
                BindGrid();
            }
        }

        protected void DownloadFile(object sender, EventArgs e)
        {
            try
            {
                // Get the file ID from the command argument
                int id = int.Parse((sender as LinkButton).CommandArgument);
                byte[] fileData;
                string fileName, contentType;

                // Connection string from Web.config
                using (SqlConnection con = new SqlConnection(connectionString))
                {
                    string query = "SELECT Name, Data, ContentType FROM bit_6_IT WHERE Id = @Id";
                    using (SqlCommand cmd = new SqlCommand(query, con))
                    {
                        cmd.Parameters.AddWithValue("@Id", id);
                        con.Open();

                        using (SqlDataReader sdr = cmd.ExecuteReader())
                        {
                            if (sdr.Read())
                            {
                                fileData = (byte[])sdr["Data"];
                                fileName = sdr["Name"].ToString();
                                contentType = sdr["ContentType"].ToString();
                            }
                            else
                            {
                                fileData = null;
                                fileName = "Unknown";
                                contentType = "application/octet-stream";
                            }
                        }
                    }
                }

                if (fileData != null)
                {
                    // Prepare response for file download
                    Response.Clear();
                    Response.Buffer = true;
                    Response.Charset = "";
                    Response.Cache.SetCacheability(HttpCacheability.NoCache);
                    Response.ContentType = contentType;
                    Response.AppendHeader("Content-Disposition", $"attachment; filename={fileName}");
                    Response.BinaryWrite(fileData);
                    Response.Flush();
                    Response.End();
                }
                else
                {
                    // Handle file not found case
                    Response.Write("File not found.");
                }
            }
            catch (Exception ex)
            {
                // Handle exception
                Response.Write("An error occurred: " + ex.Message);
            }
        }

        private void BindGrid()
        {
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                string query = "SELECT Id, Name, Topic FROM bit_6_IT";
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    con.Open();
                    SqlDataAdapter sda = new SqlDataAdapter(cmd);
                    DataTable dt = new DataTable();
                    sda.Fill(dt);
                    GridView1.DataSource = dt;
                    GridView1.DataBind();
                }
            }
        }

        protected void btnBackToDash_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Bit_Notes/dash.aspx");
        }
    }
}

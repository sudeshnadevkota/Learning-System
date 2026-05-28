using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Learning_System.Bit_Notes
{
    public partial class software_project_management : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindGrid();
            }
        }

        // Event handler for downloading files
        protected void DownloadFile(object sender, EventArgs e)
        {
            try
            {
                // Get the file ID from the command argument
                int id = int.Parse((sender as LinkButton).CommandArgument);
                byte[] fileData;
                string fileName, contentType;

                // Connection string from Web.config
                string constr = ConfigurationManager.ConnectionStrings["conn"].ConnectionString;

                using (SqlConnection con = new SqlConnection(constr))
                {
                    string query = "SELECT Name, Data, ContentType FROM bit_6_SPM WHERE Id = @Id";
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
                                // Handle case where no data is returned
                                fileData = null;
                                fileName = "Unknown";
                                contentType = "application/octet-stream";
                            }
                        }
                        con.Close();
                    }
                }

                if (fileData != null)
                {
                    // Prepare response for file download
                    Response.Clear();
                    Response.Buffer = true;
                    Response.Charset = "";
                    Response.Cache.SetCacheability(System.Web.HttpCacheability.NoCache);
                    Response.ContentType = contentType;
                    Response.AppendHeader("Content-Disposition", $"attachment; filename={fileName}");
                    Response.BinaryWrite(fileData);
                    Response.Flush();
                    Response.End();
                }
                else
                {
                    // Handle file not found case (optional)
                    Response.Write("File not found.");
                }
            }
            catch (Exception ex)
            {
                // Handle exception
                Response.Write("An error occurred: " + ex.Message);
            }
        }

        // Method to bind GridView with data from database
        private void BindGrid()
        {
            string constr = ConfigurationManager.ConnectionStrings["conn"].ConnectionString;

            using (SqlConnection con = new SqlConnection(constr))
            {
                string query = "SELECT Id, Name, Topic FROM bit_6_SPM";
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    con.Open();
                    SqlDataAdapter sda = new SqlDataAdapter(cmd);
                    DataTable dt = new DataTable();
                    sda.Fill(dt);
                    GridView1.DataSource = dt;
                    GridView1.DataBind();
                    con.Close();
                }
            }
        }

        // Event handler for navigating back to the dashboard
        protected void btnBackToDash_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Bit_Notes/dash.aspx");
        }
    }
}

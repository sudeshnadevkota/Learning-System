using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Learning_System.Bit_Notes
{
    public partial class system_analysis_and_design : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindGrid();
            }
        }

        protected void DownloadFile(object sender, EventArgs e)
        {
            try
            {
                // Get the file ID from the command argument
                if (int.TryParse((sender as LinkButton)?.CommandArgument, out int id))
                {
                    byte[] fileData;
                    string fileName, contentType, topic;

                    // Connection string from Web.config
                    string constr = ConfigurationManager.ConnectionStrings["conn"].ConnectionString;

                    using (SqlConnection con = new SqlConnection(constr))
                    {
                        using (SqlCommand cmd = new SqlCommand("SELECT Name, Data, ContentType, Topic FROM bit_3_SAD WHERE Id = @Id", con))
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
                                    topic = sdr["Topic"].ToString();
                                }
                                else
                                {
                                    // Handle case where no data is returned
                                    Response.Write("File not found.");
                                    return;
                                }
                            }
                        }
                    }

                    // Sanitize the file name to prevent potential security issues
                    fileName = fileName.Replace(" ", "_").Replace(";", "").Replace(",", "");

                    // Prepare response for file download
                    Response.Clear();
                    Response.Buffer = true;
                    Response.Cache.SetCacheability(System.Web.HttpCacheability.NoCache);
                    Response.ContentType = contentType;
                    Response.AppendHeader("Content-Disposition", "attachment; filename=" + fileName);
                    Response.BinaryWrite(fileData);
                    Response.Flush();
                    Response.End();
                }
                else
                {
                    // Invalid file ID
                    Response.Write("Invalid file ID.");
                }
            }
            catch (Exception ex)
            {
                // Handle exception and consider logging the error
                Response.Write("An error occurred while processing your request.");
                // Log the error details for diagnostics (consider using a logging framework)
            }
        }

        private void BindGrid()
        {
            string constr = ConfigurationManager.ConnectionStrings["conn"].ConnectionString;

            using (SqlConnection con = new SqlConnection(constr))
            {
                using (SqlCommand cmd = new SqlCommand("SELECT Id, Name, Topic FROM bit_3_SAD", con))
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

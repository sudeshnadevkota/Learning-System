using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Learning_System.Past_Year_Paper.BIT
{
    public partial class BIT_4_2021 : System.Web.UI.Page
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
                int id = int.Parse((sender as LinkButton).CommandArgument);
                byte[] fileData;
                string fileName, contentType;

                // Connection string from Web.config
                string constr = ConfigurationManager.ConnectionStrings["conn"].ConnectionString;

                using (SqlConnection con = new SqlConnection(constr))
                {
                    string query = "SELECT Name, Data, ContentType FROM BIT_4_2021 WHERE Id = @Id";
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
                    Response.AppendHeader("Content-Disposition", "attachment; filename=\"" + HttpUtility.UrlEncode(fileName) + "\"");
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
                // Log the exception and show user-friendly message
                // Consider using a logging framework
                Response.Write("An error occurred: " + ex.Message);
                // Log exception (ex) here
            }
        }

        private void BindGrid()
        {
            string constr = ConfigurationManager.ConnectionStrings["conn"].ConnectionString;

            using (SqlConnection con = new SqlConnection(constr))
            {
                string query = "SELECT Id, Name, Topic FROM BIT_4_2021";
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
            Response.Redirect("~/Past_Year_Paper/BIT/dash.aspx");

        }
    }
    }

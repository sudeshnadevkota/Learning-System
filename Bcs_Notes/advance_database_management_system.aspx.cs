using System;
using System.Data.SqlClient;
using System.Configuration;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Learning_System.Bcs_Notes
{
    public partial class advance_database_management_system : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindGrid();
            }
        }

        protected void BackToDashButton_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Bcs_Notes/dash.aspx");
        }

        protected void DownloadFile(object sender, EventArgs e)
        {
            try
            {
                int id = int.Parse((sender as LinkButton).CommandArgument);
                byte[] fileData;
                string fileName, contentType;

                string constr = ConfigurationManager.ConnectionStrings["conn"].ConnectionString;
                using (SqlConnection con = new SqlConnection(constr))
                {
                    string query = "SELECT Name, Data, ContentType FROM bcs_adms WHERE Id = @Id";
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
                                // Handle file not found scenario
                                Response.Write("File not found.");
                                return;
                            }
                        }
                    }
                }

                Response.Clear();
                Response.Buffer = true;
                Response.Charset = "";
                Response.Cache.SetCacheability(HttpCacheability.NoCache);
                Response.ContentType = contentType;
                Response.AppendHeader("Content-Disposition", "attachment; filename=" + fileName);
                Response.BinaryWrite(fileData);
                Response.Flush();
                Response.End();
            }
            catch (Exception ex)
            {
                // Log the exception and display a user-friendly message
                Response.Write("An error occurred: " + ex.Message);
            }
        }

        private void BindGrid()
        {
            try
            {
                string constr = ConfigurationManager.ConnectionStrings["conn"].ConnectionString;
                using (SqlConnection con = new SqlConnection(constr))
                {
                    string query = "SELECT Id, Topic, Name FROM bcs_adms";
                    using (SqlCommand cmd = new SqlCommand(query, con))
                    {
                        con.Open();
                        GridView1.DataSource = cmd.ExecuteReader();
                        GridView1.DataBind();
                    }
                }
            }
            catch (Exception ex)
            {
                // Log the exception and display a user-friendly message
                Response.Write("An error occurred: " + ex.Message);
            }
        }
    }
}

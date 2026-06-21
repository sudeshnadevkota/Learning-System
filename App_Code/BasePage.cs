using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web;
using System.Web.UI.WebControls;

namespace Learning_System
{
    public class BasePage : System.Web.UI.Page
    {
        protected string constr = ConfigurationManager.ConnectionStrings["conn"].ConnectionString;

        protected string TableName { get; set; } = "";

        protected void BindData(GridView gvNotes, GridView gvPapers)
        {
            if (string.IsNullOrEmpty(TableName)) return;

            using (SqlConnection con = new SqlConnection(constr))
            {
                string query = $"SELECT Id, Name, Topic, FileCategory, FileType FROM {TableName}";
                SqlDataAdapter sda = new SqlDataAdapter(query, con);
                DataTable dt = new DataTable();
                sda.Fill(dt);

                // Update this filter to include Assignments in the first Grid
                // Now it excludes ONLY Past Year Questions
                DataView dvNotes = new DataView(dt);
                dvNotes.RowFilter = "FileCategory <> 'Past Year Question'";
                gvNotes.DataSource = dvNotes;
                gvNotes.DataBind();

                // Keep this for Past Year Questions
                DataView dvPapers = new DataView(dt);
                dvPapers.RowFilter = "FileCategory = 'Past Year Question'";
                gvPapers.DataSource = dvPapers;
                gvPapers.DataBind();
            }
        }

        protected void DownloadFile(object sender, EventArgs e)
        {
            try
            {
                int id = int.Parse((sender as LinkButton).CommandArgument);
                using (SqlConnection con = new SqlConnection(constr))
                {
                    string sql = $"SELECT Name, Data, ContentType FROM {TableName} WHERE Id = @Id";
                    using (SqlCommand cmd = new SqlCommand(sql, con))
                    {
                        cmd.Parameters.AddWithValue("@Id", id);
                        con.Open();
                        using (SqlDataReader sdr = cmd.ExecuteReader())
                        {
                            if (sdr.Read())
                            {
                                byte[] fileData = (byte[])sdr["Data"];
                                string fileName = sdr["Name"].ToString();
                                string contentType = sdr["ContentType"].ToString();

                                Response.Clear();
                                Response.Buffer = true;
                                Response.ContentType = contentType;
                                Response.AppendHeader("Content-Disposition", "attachment; filename=" + fileName);
                                Response.BinaryWrite(fileData);
                                Response.Flush();
                                HttpContext.Current.ApplicationInstance.CompleteRequest();
                            }
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                Response.Write("Error: " + ex.Message);
            }
        }

        protected void btnBackToDash_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Bit_Notes/dash.aspx");
        }
    }
}
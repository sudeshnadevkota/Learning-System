using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Learning_System.Bit_Notes
{
    public partial class business_english : System.Web.UI.Page
    {
        string constr = ConfigurationManager.ConnectionStrings["conn"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindData();
            }
        }

        private void BindData()
        {
            using (SqlConnection con = new SqlConnection(constr))
            {
                // Fetch all necessary columns including FileCategory and FileType
                string query = "SELECT Id, Name, Topic, FileCategory, FileType FROM bit_1_BE";
                SqlDataAdapter sda = new SqlDataAdapter(query, con);
                DataTable dt = new DataTable();
                sda.Fill(dt);

                // Bind Notes
                DataView dvNotes = dt.DefaultView;
                dvNotes.RowFilter = "FileType = 'Notes'";
                GridViewNotes.DataSource = dvNotes;
                GridViewNotes.DataBind();

                // Bind Past Papers
                DataView dvPapers = dt.DefaultView;
                dvPapers.RowFilter = "FileType = 'PastYearQuestion'";
                GridViewPapers.DataSource = dvPapers;
                GridViewPapers.DataBind();
            }
        }

        protected void DownloadFile(object sender, EventArgs e)
        {
            try
            {
                int id = int.Parse((sender as LinkButton).CommandArgument);
                using (SqlConnection con = new SqlConnection(constr))
                {
                    using (SqlCommand cmd = new SqlCommand("SELECT Name, Data, ContentType FROM bit_1_BE WHERE Id = @Id", con))
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

                                // Gracefully complete the request to avoid ThreadAbortException
                                HttpContext.Current.ApplicationInstance.CompleteRequest();
                            }
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                // Log the error internally here if necessary
                Response.Write("Error: " + ex.Message);
            }
        }

        // Handles the dynamic badge colors in the Notes GridView
        protected void GridView_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                // This event is already linked to GridViewNotes
            }
        }

        protected void btnBackToDash_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Bit_Notes/dash.aspx");
        }
    }
}
#pragma checksum "D:\Learningportal\Learning-System\App_Code\BasePage.cs" "{ff1816ec-aa5e-4d10-87f7-6f4963833460}" "25D353701E9672B7A501E7D4EEE8E5E94D906568"

#line 1 "D:\Learningportal\Learning-System\App_Code\BasePage.cs"
using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Learning_System
{
    public class BasePage : System.Web.UI.Page
    {
        protected string constr = ConfigurationManager.ConnectionStrings["conn"].ConnectionString;

        // Individual pages will override this to specify their table
        protected virtual string TableName => "";

        protected void BindData(GridView gvNotes, GridView gvPapers)
        {
            if (string.IsNullOrEmpty(TableName)) return;

            using (SqlConnection con = new SqlConnection(constr))
            {
                string query = $"SELECT Id, Name, Topic, FileCategory, FileType FROM {TableName}";
                SqlDataAdapter sda = new SqlDataAdapter(query, con);
                DataTable dt = new DataTable();
                sda.Fill(dt);

                DataView dvNotes = dt.DefaultView;
                dvNotes.RowFilter = "FileType = 'Notes'";
                gvNotes.DataSource = dvNotes;
                gvNotes.DataBind();

                DataView dvPapers = dt.DefaultView;
                dvPapers.RowFilter = "FileType = 'PastYearQuestion'";
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

#line default
#line hidden

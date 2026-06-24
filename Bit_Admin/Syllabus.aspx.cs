using System;
using System.Configuration;
using System.Data.SqlClient;
using System.IO;
using System.Web;
using System.Web.UI.WebControls;

namespace Learning_System.Bit_Admin
{
    public partial class syllabus : System.Web.UI.Page
    {
        string strcon = ConfigurationManager.ConnectionStrings["conn"].ConnectionString;

        protected string PageTitleText;
        private string subject;

        protected void Page_Load(object sender, EventArgs e)
        {
            subject = Request.QueryString["subject"];

            if (string.IsNullOrEmpty(subject) || !SubjectMap.Subjects.ContainsKey(subject))
            {
                Response.Redirect("~/Bit_Admin/Default.aspx");
                return;
            }

            PageTitleText = SubjectMap.Subjects[subject].Title;

            if (!IsPostBack)
            {
                BindData();
            }
        }

        private void BindData()
        {
            using (SqlConnection con = new SqlConnection(strcon))
            {
                string query = "SELECT Id, DisplayCode, Credit, Hours, TopicCount, FileName " +
                               "FROM Syllabus WHERE SubjectCode = @SubjectCode";

                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@SubjectCode", subject);
                    con.Open();
                    GridView1.DataSource = cmd.ExecuteReader();
                    GridView1.DataBind();
                }
            }
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            if (!FileUpload1.HasFile)
            {
                lblMessage.Text = "Please select a file to upload.";
                return;
            }

            try
            {
                byte[] bytes;
                using (BinaryReader br = new BinaryReader(FileUpload1.PostedFile.InputStream))
                {
                    bytes = br.ReadBytes(FileUpload1.PostedFile.ContentLength);
                }

                using (SqlConnection con = new SqlConnection(strcon))
                {
                    con.Open();

                    // The metadata row (DisplayCode/Credit/Hours/TopicCount) must already exist.
                    string checkQuery = "SELECT COUNT(*) FROM Syllabus WHERE SubjectCode = @SubjectCode";
                    int count;
                    using (SqlCommand checkCmd = new SqlCommand(checkQuery, con))
                    {
                        checkCmd.Parameters.AddWithValue("@SubjectCode", subject);
                        count = (int)checkCmd.ExecuteScalar();
                    }

                    if (count == 0)
                    {
                        lblMessage.Text = "No syllabus record exists yet for " + PageTitleText +
                                           ". Add a row with Credit/Hours/TopicCount to the Syllabus table first.";
                        return;
                    }

                    string updateQuery = "UPDATE Syllabus SET FileName = @FileName, ContentType = @ContentType, " +
                                          "FileData = @FileData, UploadedDate = GETDATE() WHERE SubjectCode = @SubjectCode";

                    using (SqlCommand cmd = new SqlCommand(updateQuery, con))
                    {
                        cmd.Parameters.AddWithValue("@FileName", Path.GetFileName(FileUpload1.PostedFile.FileName));
                        cmd.Parameters.AddWithValue("@ContentType", FileUpload1.PostedFile.ContentType);
                        cmd.Parameters.AddWithValue("@FileData", bytes);
                        cmd.Parameters.AddWithValue("@SubjectCode", subject);
                        cmd.ExecuteNonQuery();
                    }
                }

                lblMessage.ForeColor = System.Drawing.Color.Green;
                lblMessage.Text = "Syllabus uploaded successfully.";

                BindData();
            }
            catch (Exception ex)
            {
                lblMessage.Text = "Upload failed: " + ex.Message;
            }
        }

        protected void lnkDownload_Click(object sender, EventArgs e)
        {
            try
            {
                int id = int.Parse(((LinkButton)sender).CommandArgument);

                using (SqlConnection con = new SqlConnection(strcon))
                {
                    string query = "SELECT FileName, ContentType, FileData FROM Syllabus WHERE Id = @Id";
                    using (SqlCommand cmd = new SqlCommand(query, con))
                    {
                        cmd.Parameters.AddWithValue("@Id", id);
                        con.Open();

                        using (SqlDataReader dr = cmd.ExecuteReader())
                        {
                            if (dr.Read())
                            {
                                if (dr["FileData"] == DBNull.Value)
                                {
                                    lblMessage.Text = "No file has been uploaded for this subject yet.";
                                    return;
                                }

                                byte[] bytes = (byte[])dr["FileData"];
                                Response.Clear();
                                Response.ContentType = dr["ContentType"].ToString();
                                Response.AddHeader("content-disposition", "attachment;filename=\"" + dr["FileName"].ToString() + "\"");
                                Response.BinaryWrite(bytes);
                                Response.Flush();
                                HttpContext.Current.ApplicationInstance.CompleteRequest();
                            }
                        }
                    }
                }
            }
            catch (System.Threading.ThreadAbortException)
            {
                // Expected when calling CompleteRequest()
            }
            catch (Exception ex)
            {
                lblMessage.Text = "Download failed: " + ex.Message;
            }
        }

        protected void GridView1_RowDeleting1(object sender, GridViewDeleteEventArgs e)
        {
            int id = Convert.ToInt32(GridView1.DataKeys[e.RowIndex].Value);

            using (SqlConnection con = new SqlConnection(strcon))
            {
                // Clears file fields only — keeps Credit/Hours/TopicCount metadata intact
                string query = "UPDATE Syllabus SET FileName = NULL, ContentType = NULL, FileData = NULL, UploadedDate = NULL WHERE Id = @Id";
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@Id", id);
                    con.Open();
                    cmd.ExecuteNonQuery();
                }
            }

            BindData();
        }
    }
}
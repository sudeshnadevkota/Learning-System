using System;
using System.Configuration;
using System.Data.SqlClient;
using System.IO;
using System.Web;
using System.Web.UI.WebControls;

namespace Learning_System.Bba_Admin
{
    public partial class Syllabus : System.Web.UI.Page
    {
        string strcon = ConfigurationManager.ConnectionStrings["conn"].ConnectionString;

        protected string PageTitleText;
        private string subject;

        protected void Page_Load(object sender, EventArgs e)
        {
            subject = Request.QueryString["subject"];

            if (string.IsNullOrEmpty(subject) || !SubjectMap.Subjects.ContainsKey(subject))
            {
                Response.Redirect("~/Bba_Admin/Default.aspx");
                return;
            }

            PageTitleText = SubjectMap.Subjects[subject].Title;

            if (!IsPostBack)
            {
                BindData();
                LoadExistingMetadata();
            }
        }

        private void BindData()
        {
            using (SqlConnection con = new SqlConnection(strcon))
            {
                string query = "SELECT Id, SubjectCode, CreditScore, TotalHours, FileName " +
                               "FROM Syllabus WHERE SubjectName = @SubjectName";

                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@SubjectName", subject);
                    con.Open();
                    GridView1.DataSource = cmd.ExecuteReader();
                    GridView1.DataBind();
                }
            }
        }

        // Pre-fills the form with the existing SubjectCode/CreditScore/TotalHours
        // for this subject, if a record already exists, so the admin can edit
        // metadata without retyping everything.
        private void LoadExistingMetadata()
        {
            using (SqlConnection con = new SqlConnection(strcon))
            {
                string query = "SELECT SubjectCode, CreditScore, TotalHours " +
                               "FROM Syllabus WHERE SubjectName = @SubjectName";

                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@SubjectName", subject);
                    con.Open();

                    using (SqlDataReader dr = cmd.ExecuteReader())
                    {
                        if (dr.Read())
                        {
                            txtSubjectCode.Text = dr["SubjectCode"] == DBNull.Value ? "" : dr["SubjectCode"].ToString();
                            txtCreditScore.Text = dr["CreditScore"] == DBNull.Value ? "" : dr["CreditScore"].ToString();
                            txtTotalHours.Text = dr["TotalHours"] == DBNull.Value ? "" : dr["TotalHours"].ToString();
                        }
                    }
                }
            }
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            string subjectCode = txtSubjectCode.Text.Trim();

            if (string.IsNullOrEmpty(subjectCode))
            {
                lblMessage.ForeColor = System.Drawing.Color.Red;
                lblMessage.Text = "Please enter the Subject Code (e.g. BIT113).";
                return;
            }

            decimal creditScore;
            if (!decimal.TryParse(txtCreditScore.Text.Trim(), out creditScore) || creditScore <= 0)
            {
                lblMessage.ForeColor = System.Drawing.Color.Red;
                lblMessage.Text = "Please enter a valid Credit Score.";
                return;
            }

            // Authoritative calculation — never trust the client-side value
            decimal totalHours = creditScore * 16;
            txtTotalHours.Text = totalHours.ToString();

            bool hasFile = FileUpload1.HasFile;
            byte[] bytes = null;
            string fileName = null;
            string contentType = null;

            if (hasFile)
            {
                using (BinaryReader br = new BinaryReader(FileUpload1.PostedFile.InputStream))
                {
                    bytes = br.ReadBytes(FileUpload1.PostedFile.ContentLength);
                }
                fileName = Path.GetFileName(FileUpload1.PostedFile.FileName);
                contentType = FileUpload1.PostedFile.ContentType;
            }

            try
            {
                using (SqlConnection con = new SqlConnection(strcon))
                {
                    con.Open();

                    string checkQuery = "SELECT COUNT(*) FROM Syllabus WHERE SubjectName = @SubjectName";
                    int count;
                    using (SqlCommand checkCmd = new SqlCommand(checkQuery, con))
                    {
                        checkCmd.Parameters.AddWithValue("@SubjectName", subject);
                        count = (int)checkCmd.ExecuteScalar();
                    }

                    if (count == 0)
                    {
                        // No record yet for this subject — create it
                        string insertQuery = "INSERT INTO Syllabus " +
                            "(SubjectName, SubjectCode, CreditScore, TotalHours, FileName, ContentType, FileData, UploadedDate) " +
                            "VALUES (@SubjectName, @SubjectCode, @CreditScore, @TotalHours, @FileName, @ContentType, @FileData, @UploadedDate)";

                        using (SqlCommand cmd = new SqlCommand(insertQuery, con))
                        {
                            cmd.Parameters.AddWithValue("@SubjectName", subject);
                            cmd.Parameters.AddWithValue("@SubjectCode", subjectCode);
                            cmd.Parameters.AddWithValue("@CreditScore", creditScore);
                            cmd.Parameters.AddWithValue("@TotalHours", totalHours);
                            cmd.Parameters.AddWithValue("@FileName", (object)fileName ?? DBNull.Value);
                            cmd.Parameters.AddWithValue("@ContentType", (object)contentType ?? DBNull.Value);
                            cmd.Parameters.AddWithValue("@FileData", (object)bytes ?? DBNull.Value);
                            cmd.Parameters.AddWithValue("@UploadedDate", hasFile ? (object)DateTime.Now : DBNull.Value);
                            cmd.ExecuteNonQuery();
                        }
                    }
                    else
                    {
                        // Record already exists — update metadata always,
                        // only overwrite the file columns if a new file was selected
                        string updateQuery = hasFile
                            ? "UPDATE Syllabus SET SubjectCode = @SubjectCode, CreditScore = @CreditScore, TotalHours = @TotalHours, " +
                              "FileName = @FileName, ContentType = @ContentType, FileData = @FileData, UploadedDate = GETDATE() " +
                              "WHERE SubjectName = @SubjectName"
                            : "UPDATE Syllabus SET SubjectCode = @SubjectCode, CreditScore = @CreditScore, TotalHours = @TotalHours " +
                              "WHERE SubjectName = @SubjectName";

                        using (SqlCommand cmd = new SqlCommand(updateQuery, con))
                        {
                            cmd.Parameters.AddWithValue("@SubjectCode", subjectCode);
                            cmd.Parameters.AddWithValue("@CreditScore", creditScore);
                            cmd.Parameters.AddWithValue("@TotalHours", totalHours);
                            cmd.Parameters.AddWithValue("@SubjectName", subject);

                            if (hasFile)
                            {
                                cmd.Parameters.AddWithValue("@FileName", fileName);
                                cmd.Parameters.AddWithValue("@ContentType", contentType);
                                cmd.Parameters.AddWithValue("@FileData", bytes);
                            }

                            cmd.ExecuteNonQuery();
                        }
                    }
                }

                lblMessage.ForeColor = System.Drawing.Color.Green;
                lblMessage.Text = "Syllabus saved successfully.";

                BindData();
            }
            catch (Exception ex)
            {
                lblMessage.ForeColor = System.Drawing.Color.Red;
                lblMessage.Text = "Save failed: " + ex.Message;
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
                // Clears file fields only — keeps SubjectCode/CreditScore/TotalHours metadata intact
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
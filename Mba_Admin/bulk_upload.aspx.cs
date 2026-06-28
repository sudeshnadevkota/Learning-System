using System;
using System.Configuration;
using System.Data.SqlClient;
using System.IO;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Learning_System.Mba_Admin
{
    public partial class bulk_upload : System.Web.UI.Page
    {
        string strcon = ConfigurationManager.ConnectionStrings["conn"].ConnectionString;

        protected string TableName;
        protected string PageTitleText;

        protected void Page_Load(object sender, EventArgs e)
        {
            string subject = Request.QueryString["subject"];

            if (string.IsNullOrEmpty(subject) || !SubjectMap.Subjects.ContainsKey(subject))
            {
                Response.Redirect("~/Mba_Admin/Default.aspx");
                return;
            }

            TableName = SubjectMap.Subjects[subject].Table;
            PageTitleText = SubjectMap.Subjects[subject].Title;

            if (!IsPostBack) BindData();
        }

        // ── Submit button: handles multiple files from one FileUpload control ──
        // Requires AllowMultiple="true" on the FileUpload1 markup (.NET 4.5+),
        // which posts every selected file into FileUpload1.PostedFiles.
        protected void Button1_Click(object sender, EventArgs e)
        {
            string fileType = ddlFileType.SelectedValue;
            bool needsDestination = (fileType == "Lecture" || fileType == "Tutorial" || fileType == "Workshop");

            if (needsDestination && string.IsNullOrEmpty(ddlContentType.SelectedValue))
            {
                lblMessage.ForeColor = System.Drawing.Color.Red;
                lblMessage.Text = "Error: Please select a File Destination.";
                return;
            }

            if (!FileUpload1.HasFiles)
            {
                lblMessage.ForeColor = System.Drawing.Color.Red;
                lblMessage.Text = "Please select at least one file to upload.";
                return;
            }

            int successCount = 0;
            int failCount = 0;
            var failedNames = new StringBuilder();

            foreach (HttpPostedFile postedFile in FileUpload1.PostedFiles)
            {
                if (postedFile == null || postedFile.ContentLength <= 0)
                    continue;

                try
                {
                    byte[] bytes;
                    using (BinaryReader br = new BinaryReader(postedFile.InputStream))
                    {
                        bytes = br.ReadBytes(postedFile.ContentLength);
                    }

                    using (SqlConnection con = new SqlConnection(strcon))
                    {
                        string query = "INSERT INTO " + TableName +
                                       " (Topic, Name, ContentType, Data, FileCategory, UploadDate, FileType) " +
                                       "VALUES (@Topic, @Name, @ContentType, @Data, @FileCategory, GETDATE(), @FileType)";

                        using (SqlCommand cmd = new SqlCommand(query, con))
                        {
                            cmd.Parameters.AddWithValue("@Topic", Path.GetFileNameWithoutExtension(postedFile.FileName));
                            cmd.Parameters.AddWithValue("@Name", Path.GetFileName(postedFile.FileName));
                            cmd.Parameters.AddWithValue("@ContentType", postedFile.ContentType);
                            cmd.Parameters.AddWithValue("@Data", bytes);
                            cmd.Parameters.AddWithValue("@FileCategory", ddlFileType.SelectedItem.Text);
                            cmd.Parameters.AddWithValue("@FileType", needsDestination ? ddlContentType.SelectedValue : "N/A");

                            con.Open();
                            cmd.ExecuteNonQuery();
                        }
                    }

                    successCount++;
                }
                catch (Exception)
                {
                    failCount++;
                    failedNames.Append(postedFile.FileName).Append(", ");
                }
            }

            if (successCount == 0 && failCount == 0)
            {
                lblMessage.ForeColor = System.Drawing.Color.Red;
                lblMessage.Text = "No valid files were found in the selection.";
            }
            else if (failCount == 0)
            {
                lblMessage.ForeColor = System.Drawing.Color.Green;
                lblMessage.Text = successCount + " file(s) uploaded successfully.";
            }
            else
            {
                lblMessage.ForeColor = System.Drawing.Color.Red;
                lblMessage.Text = successCount + " file(s) uploaded, " + failCount +
                                   " failed (" + failedNames.ToString().TrimEnd(',', ' ') + ").";
            }

            BindData();
        }

        // ── Populate the GridView with previously uploaded files ───────────────
        private void BindData()
        {
            using (SqlConnection con = new SqlConnection(strcon))
            {
                string query = "SELECT id, Name, ContentType FROM " + TableName + " ORDER BY UploadDate DESC";
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    con.Open();
                    GridView1.DataSource = cmd.ExecuteReader();
                    GridView1.DataBind();
                }
            }
        }

        // ── GridView Delete ─────────────────────────────────────────────────────
        protected void GridView1_RowDeleting1(object sender, GridViewDeleteEventArgs e)
        {
            int id = int.Parse(GridView1.DataKeys[e.RowIndex].Value.ToString());

            using (SqlConnection con = new SqlConnection(strcon))
            {
                string query = "DELETE FROM " + TableName + " WHERE id = @id";
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@id", id);
                    con.Open();
                    cmd.ExecuteNonQuery();
                }
            }

            BindData();
        }

        // ── GridView Edit ───────────────────────────────────────────────────────
        protected void GridView1_RowEditing1(object sender, GridViewEditEventArgs e)
        {
            GridView1.EditIndex = e.NewEditIndex;
            BindData();
        }

        protected void GridView1_RowCancelingEdit1(object sender, GridViewCancelEditEventArgs e)
        {
            GridView1.EditIndex = -1;
            BindData();
        }

        protected void GridView1_RowUpdating1(object sender, GridViewUpdateEventArgs e)
        {
            int id = int.Parse(GridView1.DataKeys[e.RowIndex].Value.ToString());

            // Only Name and ContentType are bound as editable BoundFields in this grid.
            TextBox txtName = (TextBox)GridView1.Rows[e.RowIndex].Cells[0].Controls[0];
            TextBox txtContentType = (TextBox)GridView1.Rows[e.RowIndex].Cells[1].Controls[0];

            using (SqlConnection con = new SqlConnection(strcon))
            {
                string query = "UPDATE " + TableName + " SET Name = @Name, ContentType = @ContentType WHERE id = @id";
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@Name", txtName.Text.Trim());
                    cmd.Parameters.AddWithValue("@ContentType", txtContentType.Text.Trim());
                    cmd.Parameters.AddWithValue("@id", id);
                    con.Open();
                    cmd.ExecuteNonQuery();
                }
            }

            GridView1.EditIndex = -1;
            BindData();
        }

        // ── Download link ───────────────────────────────────────────────────────
        protected void lnkDownload_Click(object sender, EventArgs e)
        {
            try
            {
                int id = int.Parse(((LinkButton)sender).CommandArgument);

                using (SqlConnection con = new SqlConnection(strcon))
                {
                    string query = "SELECT Name, ContentType, Data FROM " + TableName + " WHERE id = @id";
                    SqlCommand cmd = new SqlCommand(query, con);
                    cmd.Parameters.AddWithValue("@id", id);
                    con.Open();

                    using (SqlDataReader dr = cmd.ExecuteReader())
                    {
                        if (dr.Read())
                        {
                            byte[] bytes = (byte[])dr["Data"];
                            Response.Clear();
                            Response.ContentType = dr["ContentType"].ToString();
                            Response.AddHeader("content-disposition", "attachment;filename=\"" + dr["Name"].ToString() + "\"");
                            Response.BinaryWrite(bytes);
                            Response.Flush();
                            HttpContext.Current.ApplicationInstance.CompleteRequest();
                        }
                    }
                }
            }
            catch (System.Threading.ThreadAbortException)
            {
                // Expected when calling CompleteRequest()/Response.End()
            }
            catch (Exception ex)
            {
                lblMessage.ForeColor = System.Drawing.Color.Red;
                lblMessage.Text = "Download failed: " + ex.Message;
            }
        }
    }
}
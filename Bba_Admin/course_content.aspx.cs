using System;
using System.Configuration;
using System.Data.SqlClient;
using System.IO;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

//using Learning_System;

namespace Learning_System.Bba_Admin
{
    public partial class course_content : System.Web.UI.Page
    {
        string strcon = ConfigurationManager.ConnectionStrings["conn"].ConnectionString;

        protected string TableName;
        protected string PageTitleText;

        protected void Page_Load(object sender, EventArgs e)
        {
            string subject = Request.QueryString["subject"];

            if (string.IsNullOrEmpty(subject) || !SubjectMap.Subjects.ContainsKey(subject))
            {
                Response.Redirect("~/Bba_Admin/Default.aspx");
                return;
            }

            TableName = SubjectMap.Subjects[subject].Table;
            PageTitleText = SubjectMap.Subjects[subject].Title;

            if (!IsPostBack) BindGrid();
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            string fileType = ddlFileType.SelectedValue;
            bool needsDestination = (fileType == "Lecture" || fileType == "Tutorial" || fileType == "Workshop");

            if (needsDestination && string.IsNullOrEmpty(ddlContentType.SelectedValue))
            {
                lblMessage.Text = "Error: Please select a File Destination.";
                return;
            }

            if (FileUpload1.HasFile)
            {
                try
                {
                    byte[] bytes;
                    using (BinaryReader br = new BinaryReader(FileUpload1.PostedFile.InputStream))
                    {
                        bytes = br.ReadBytes(FileUpload1.PostedFile.ContentLength);
                    }

                    using (SqlConnection con = new SqlConnection(strcon))
                    {
                        string query = "INSERT INTO " + TableName +
                                       " (Topic, Name, ContentType, Data, FileCategory, UploadDate, FileType) " +
                                       "VALUES (@Topic, @Name, @ContentType, @Data, @FileCategory, GETDATE(), @FileType)";

                        using (SqlCommand cmd = new SqlCommand(query, con))
                        {
                            cmd.Parameters.AddWithValue("@Topic", TextBox1.Text.Trim());
                            cmd.Parameters.AddWithValue("@Name", Path.GetFileName(FileUpload1.PostedFile.FileName));
                            cmd.Parameters.AddWithValue("@ContentType", FileUpload1.PostedFile.ContentType);
                            cmd.Parameters.AddWithValue("@Data", bytes);
                            cmd.Parameters.AddWithValue("@FileCategory", ddlFileType.SelectedItem.Text);
                            cmd.Parameters.AddWithValue("@FileType",
    needsDestination
        ? ddlContentType.SelectedValue
        : ddlFileType.SelectedItem.Text);

                            con.Open();
                            cmd.ExecuteNonQuery();
                        }
                    }

                    BindGrid();
                    lblMessage.Text = "Successfully Added.";
                }
                catch (Exception ex)
                {
                    lblMessage.Text = "Upload failed: " + ex.Message;
                }
            }
            else
            {
                lblMessage.Text = "Please select a file first.";
            }
        }

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
                lblMessage.Text = "Download failed: " + ex.Message;
            }
        }

        private void BindGrid()
        {
            using (SqlConnection con = new SqlConnection(strcon))
            {
                string query = "SELECT id, Topic, Name, ContentType, FileCategory, FileType FROM " + TableName;
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    con.Open();
                    GridView1.DataSource = cmd.ExecuteReader();
                    GridView1.DataBind();
                }
            }
        }

        private void update(int id, string topic, string name, string content)
        {
            using (SqlConnection con = new SqlConnection(strcon))
            {
                string sqlquery = "UPDATE " + TableName +
                                   " SET Topic = @Topic, Name = @Name, ContentType = @ContentType WHERE id = @id";

                using (SqlCommand cmd = new SqlCommand(sqlquery, con))
                {
                    cmd.Parameters.AddWithValue("@Topic", topic);
                    cmd.Parameters.AddWithValue("@Name", name);
                    cmd.Parameters.AddWithValue("@ContentType", content);
                    cmd.Parameters.AddWithValue("@id", id);
                    con.Open();
                    cmd.ExecuteNonQuery();
                }
            }
        }

        private void delete(int id)
        {
            using (SqlConnection con = new SqlConnection(strcon))
            {
                string sqlquery = "DELETE FROM " + TableName + " WHERE id = @id";
                using (SqlCommand cmd = new SqlCommand(sqlquery, con))
                {
                    cmd.Parameters.AddWithValue("@id", id);
                    con.Open();
                    cmd.ExecuteNonQuery();
                }
            }
        }

        protected void GridView1_RowUpdating1(object sender, GridViewUpdateEventArgs e)
        {
            int id = int.Parse(GridView1.DataKeys[e.RowIndex].Value.ToString());

            string topic = e.NewValues["Topic"].ToString();
            string name = e.NewValues["Name"].ToString();
            string content = e.NewValues["ContentType"].ToString();

            update(id, topic, name, content);

            GridView1.EditIndex = -1;
            BindGrid();
        }

        protected void GridView1_RowEditing1(object sender, GridViewEditEventArgs e)
        {
            GridView1.EditIndex = e.NewEditIndex;
            BindGrid();
        }

        protected void GridView1_RowDeleting1(object sender, GridViewDeleteEventArgs e)
        {
            delete(int.Parse(GridView1.DataKeys[e.RowIndex].Value.ToString()));
            BindGrid();
        }

        protected void GridView1_RowCancelingEdit1(object sender, GridViewCancelEditEventArgs e)
        {
            GridView1.EditIndex = -1;
            BindGrid();
        }
    }
}
using System;
using System.Data;
using System.IO;
using System.Web.UI.WebControls;

namespace Learning_System.Bit_Admin
{
    public partial class syllabus : System.Web.UI.Page
    {
        // Expose the subject title to the .aspx markup
        public string PageTitleText { get; private set; }

        protected void Page_Load(object sender, EventArgs e)
        {
            // ── Resolve subject display name (same mapping as course_content) ──
            string subject = Request.QueryString["subject"] ?? "";
            PageTitleText = ResolveSubjectName(subject);

            if (!IsPostBack)
            {
                BindData();
            }
        }

        // ── Populate the GridView ─────────────────────────────────────────────
        private void BindData()
        {
            // TODO: Replace with your actual DB call filtered by subject + "Syllabus" type.
            // Example pattern (mirrors course_content.aspx.cs):
            //
            // string subject = Request.QueryString["subject"] ?? "";
            // DataTable dt = YourDataAccess.GetSyllabus(subject);
            // GridView1.DataSource = dt;
            // GridView1.DataBind();

            // Placeholder: bind empty table so GridView renders without error
            DataTable dt = new DataTable();
            dt.Columns.Add("id", typeof(int));
            dt.Columns.Add("Name", typeof(string));
            dt.Columns.Add("ContentType", typeof(string));
            GridView1.DataSource = dt;
            GridView1.DataBind();
        }

        // ── Submit button ─────────────────────────────────────────────────────
        protected void Button1_Click(object sender, EventArgs e)
        {
            // Validate file selection
            if (!FileUpload1.HasFile)
            {
                lblMessage.Text = "Please select a file to upload.";
                return;
            }

            string fileType = ddlFileType.SelectedValue;
            string contentType = ddlContentType.SelectedValue;
            string subject = Request.QueryString["subject"] ?? "";

            // Fixed topic for syllabus entries
            string topic = PageTitleText + " Syllabus";

            try
            {
                // ── Save the file (adjust upload folder path as needed) ──
                string uploadsFolder = Server.MapPath("~/Uploads/Syllabus/");
                if (!Directory.Exists(uploadsFolder))
                    Directory.CreateDirectory(uploadsFolder);

                string safeFileName = topic.Replace(" ", "_") +
                                      "_" + DateTimeOffset.UtcNow.ToUnixTimeSeconds() +
                                      Path.GetExtension(FileUpload1.FileName);

                string savePath = Path.Combine(uploadsFolder, safeFileName);
                FileUpload1.SaveAs(savePath);

                // ── Persist to DB (replace with your actual data-access call) ──
                // Example:
                // YourDataAccess.InsertContent(
                //     topic, safeFileName, FileUpload1.PostedFile.ContentType, subject, contentType);

                lblMessage.Text = "";
                lblMessage.ForeColor = System.Drawing.Color.Green;
                lblMessage.Text = "Syllabus uploaded successfully.";

                BindData();
            }
            catch (Exception ex)
            {
                lblMessage.Text = "Upload failed: " + ex.Message;
            }
        }

        // ── GridView Delete ───────────────────────────────────────────────────
        protected void GridView1_RowDeleting1(object sender, GridViewDeleteEventArgs e)
        {
            int id = Convert.ToInt32(GridView1.DataKeys[e.RowIndex].Value);

            // TODO: YourDataAccess.DeleteContent(id);

            BindData();
        }

        // ── GridView Edit ─────────────────────────────────────────────────────
        protected void GridView1_RowEditing1(object sender, GridViewEditEventArgs e)
        {
            GridView1.EditIndex = e.NewEditIndex;
            BindData();
        }

        // ── Download link ─────────────────────────────────────────────────────
        protected void lnkDownload_Click(object sender, EventArgs e)
        {
            LinkButton btn = (LinkButton)sender;
            int id = Convert.ToInt32(btn.CommandArgument);

            // TODO: retrieve file path by id and stream it:
            // string filePath = YourDataAccess.GetFilePath(id);
            // Response.TransmitFile(Server.MapPath(filePath));
            // Response.End();
        }

        // ── Helper: subject code → display name ──────────────────────────────
        private static string ResolveSubjectName(string code)
        {
            switch (code?.ToUpperInvariant())
            {
                case "BE": return "Business English";
                case "MATH": return "Mathematics I";
                case "IT": return "Introduction to IT";
                // Add more mappings to match your course_content page
                default: return string.IsNullOrWhiteSpace(code) ? "Subject" : code;
            }
        }
    }
}

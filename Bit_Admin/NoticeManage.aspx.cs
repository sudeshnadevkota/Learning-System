using System;
using System.Data.SqlClient;
using System.IO;

namespace Learning_System.Admin
{
    public partial class NoticeManage : BasePage
    {
        private static readonly string[] AllowedExtensions = { ".pdf", ".jpg", ".jpeg", ".png" };
        private const int MaxFileSizeBytes = 8 * 1024 * 1024; // 8 MB

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindGrid();
            }
        }

        private void BindGrid()
        {
            using (SqlConnection con = new SqlConnection(constr))
            {
                string sql = "SELECT NoticeId, Title, PostedByName, PostedByRole, PostedDate, IsActive FROM Notice ORDER BY PostedDate DESC";
                using (SqlCommand cmd = new SqlCommand(sql, con))
                {
                    con.Open();
                    gvNotices.DataSource = cmd.ExecuteReader();
                    gvNotices.DataBind();
                }
            }
        }

        // Looks up the poster's display name and role from the Login table
        // using the FK relationship (Notice.PostedByUserId -> Login.UserId).
        private void GetPostedByInfo(SqlConnection con, int userId, out string name, out string role)
        {
            name = "";
            role = "";
            string sql = "SELECT FullName, Role FROM Login WHERE UserId = @UserId";
            using (SqlCommand cmd = new SqlCommand(sql, con))
            {
                cmd.Parameters.AddWithValue("@UserId", userId);
                using (SqlDataReader sdr = cmd.ExecuteReader())
                {
                    if (sdr.Read())
                    {
                        name = sdr["FullName"].ToString();
                        role = sdr["Role"].ToString();
                    }
                }
            }
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            if (Session["UserId"] == null)
            {
                lblMessage.Text = "Session UserId is null.";
                lblMessage.Style["color"] = "red";
                return;
            }


            int currentUserId = Convert.ToInt32(Session["UserId"]);

            string title = txtTitle.Text.Trim();
            string description = txtDescription.Text.Trim();
            string className = ddlClass.SelectedValue;

            // ddlSemester's options are injected client-side by the updateSemesters()
            // JS function, so the server-side control never has them in its Items
            // collection. ddlSemester.SelectedValue would always read back empty —
            // we read the raw posted form value instead, which the browser sends
            // correctly regardless of how the <option> got into the <select>.
            string semester = Request.Form[ddlSemester.UniqueID];

            DateTime? expiry = null;
            DateTime parsedExpiry;
            if (!string.IsNullOrWhiteSpace(txtExpiry.Text) && DateTime.TryParse(txtExpiry.Text, out parsedExpiry))
                expiry = parsedExpiry;

            if (string.IsNullOrWhiteSpace(title) || string.IsNullOrWhiteSpace(description) ||
                string.IsNullOrWhiteSpace(className) || string.IsNullOrWhiteSpace(semester))
            {
                lblMessage.Text = "Please fill in all required fields.";
                lblMessage.Style["color"] = "red";
                return;
            }

            // Optional file upload
            string fileName = null, fileType = null;
            byte[] fileBytes = null;
            bool hasNewFile = fileAttachment.HasFile;

            if (hasNewFile)
            {
                string ext = Path.GetExtension(fileAttachment.FileName).ToLowerInvariant();
                if (Array.IndexOf(AllowedExtensions, ext) < 0)
                {
                    lblMessage.Text = "Only PDF, JPG, JPEG, or PNG files are allowed.";
                    lblMessage.Style["color"] = "red";
                    return;
                }
                if (fileAttachment.PostedFile.ContentLength > MaxFileSizeBytes)
                {
                    lblMessage.Text = "File size must be under 8 MB.";
                    lblMessage.Style["color"] = "red";
                    return;
                }

                fileName = Path.GetFileName(fileAttachment.FileName);
                fileType = fileAttachment.PostedFile.ContentType;
                using (var ms = new MemoryStream())
                {
                    fileAttachment.PostedFile.InputStream.CopyTo(ms);
                    fileBytes = ms.ToArray();
                }
            }

            bool isEdit = !string.IsNullOrEmpty(hidNoticeId.Value);

            using (SqlConnection con = new SqlConnection(constr))
            {
                con.Open();

                if (isEdit)
                {
                    int noticeId = Convert.ToInt32(hidNoticeId.Value);

                    // PostedByUserId / PostedByName / PostedByRole are never touched
                    // on edit — the original poster's attribution stays intact even
                    // if a different admin edits the notice later.
                    string sql = hasNewFile
                        ? @"UPDATE Notice SET Title=@Title, Description=@Description, Class=@Class, Semester=@Semester,
                        ExpiryDate=@ExpiryDate,
                        AttachmentName=@AttachmentName, AttachmentType=@AttachmentType, AttachmentData=@AttachmentData
                    WHERE NoticeId=@NoticeId"
                        : @"UPDATE Notice SET Title=@Title, Description=@Description, Class=@Class, Semester=@Semester,
                        ExpiryDate=@ExpiryDate
                    WHERE NoticeId=@NoticeId";

                    using (SqlCommand cmd = new SqlCommand(sql, con))
                    {
                        cmd.Parameters.AddWithValue("@Class", className);
                        cmd.Parameters.AddWithValue("@Semester", semester);
                        cmd.Parameters.AddWithValue("@NoticeId", noticeId);
                        AddCommonParams(cmd, title, description, expiry, fileName, fileType, fileBytes, includeAttachmentOnlyIfPresent: true);
                        cmd.ExecuteNonQuery();
                    }
                }
                else
                {
                    // PostedDate and IsPinned are intentionally left out of the
                    // column list below — the table's own DEFAULT constraints
                    // (GETDATE() and 0) fill them in automatically.
                    string postedByName, postedByRole;
                    GetPostedByInfo(con, currentUserId, out postedByName, out postedByRole);

                    string sql = @"INSERT INTO Notice
                    (PostedByUserId, PostedByName, PostedByRole, Title, Description, Class, Semester, Section, ExpiryDate, AttachmentName, AttachmentType, AttachmentData)
                VALUES
                    (@UserId, @PostedByName, @PostedByRole, @Title, @Description, @Class, @Semester, @Section, @ExpiryDate, @AttachmentName, @AttachmentType, @AttachmentData)";

                    using (SqlCommand cmd = new SqlCommand(sql, con))
                    {
                        cmd.Parameters.AddWithValue("@UserId", currentUserId);
                        cmd.Parameters.AddWithValue("@PostedByName", postedByName);
                        cmd.Parameters.AddWithValue("@PostedByRole", postedByRole);
                        cmd.Parameters.AddWithValue("@Class", className);
                        cmd.Parameters.AddWithValue("@Semester", semester);
                        cmd.Parameters.AddWithValue("@Section", ""); // no Section control in the form yet
                        AddCommonParams(cmd, title, description, expiry, fileName, fileType, fileBytes);
                        cmd.ExecuteNonQuery();
                    }
                }
            }

            lblMessage.Text = "Notice saved successfully.";
            lblMessage.Style["color"] = "#16a34a";
            ClearForm();
            BindGrid();
        }

        private void AddCommonParams(SqlCommand cmd, string title, string description, DateTime? expiry,
            string fileName, string fileType, byte[] fileBytes, bool includeAttachmentOnlyIfPresent = false)
        {
            cmd.Parameters.AddWithValue("@Title", title);
            cmd.Parameters.AddWithValue("@Description", description);
            cmd.Parameters.AddWithValue("@ExpiryDate", expiry.HasValue ? (object)expiry.Value : DBNull.Value);

            if (!includeAttachmentOnlyIfPresent || fileBytes != null)
            {
                cmd.Parameters.AddWithValue("@AttachmentName", (object)fileName ?? DBNull.Value);
                cmd.Parameters.AddWithValue("@AttachmentType", (object)fileType ?? DBNull.Value);

                // Explicit SqlDbType — AddWithValue can't infer varbinary from a null/DBNull value,
                // which is what caused the "implicit conversion from nvarchar to varbinary(max)" error.
                var attachParam = cmd.Parameters.Add("@AttachmentData", System.Data.SqlDbType.VarBinary, -1);
                attachParam.Value = (object)fileBytes ?? DBNull.Value;
            }
        }

        protected void gvNotices_RowCommand(object sender, System.Web.UI.WebControls.GridViewCommandEventArgs e)
        {
            int id = int.Parse(e.CommandArgument.ToString());

            switch (e.CommandName)
            {
                case "EditNotice":
                    LoadNoticeForEdit(id);
                    break;

                case "DeleteNotice":
                    using (SqlConnection con = new SqlConnection(constr))
                    using (SqlCommand cmd = new SqlCommand("DELETE FROM Notice WHERE NoticeId = @Id", con))
                    {
                        cmd.Parameters.AddWithValue("@Id", id);
                        con.Open();
                        cmd.ExecuteNonQuery();
                    }
                    BindGrid();
                    break;

                case "ToggleActive":
                    using (SqlConnection con = new SqlConnection(constr))
                    using (SqlCommand cmd = new SqlCommand("UPDATE Notice SET IsActive = ~IsActive WHERE NoticeId = @Id", con))
                    {
                        cmd.Parameters.AddWithValue("@Id", id);
                        con.Open();
                        cmd.ExecuteNonQuery();
                    }
                    BindGrid();
                    break;
            }
        }

        private void LoadNoticeForEdit(int id)
        {
            using (SqlConnection con = new SqlConnection(constr))
            {
                string sql = "SELECT * FROM Notice WHERE NoticeId = @Id";
                using (SqlCommand cmd = new SqlCommand(sql, con))
                {
                    cmd.Parameters.AddWithValue("@Id", id);
                    con.Open();
                    using (SqlDataReader sdr = cmd.ExecuteReader())
                    {
                        if (sdr.Read())
                        {
                            hidNoticeId.Value = id.ToString();
                            txtTitle.Text = sdr["Title"].ToString();
                            txtDescription.Text = sdr["Description"].ToString();
                            txtExpiry.Text = sdr["ExpiryDate"] != DBNull.Value
                                ? Convert.ToDateTime(sdr["ExpiryDate"]).ToString("yyyy-MM-dd")
                                : "";
                        }
                    }
                }
            }
        }

        protected void btnClear_Click(object sender, EventArgs e)
        {
            ClearForm();
        }

        private void ClearForm()
        {
            hidNoticeId.Value = "";
            txtTitle.Text = "";
            txtDescription.Text = "";
            txtExpiry.Text = "";
        }
    }
}
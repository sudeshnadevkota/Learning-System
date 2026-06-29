using Learning_System.Bit_Notes;
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
                BindRoleDropdown();
                BindGrid();
            }
        }

        private void BindRoleDropdown()
        {
            ddlRole.Items.Clear();
            foreach (var role in NoticeRoles.Roles)
            {
                ddlRole.Items.Add(new System.Web.UI.WebControls.ListItem(role, role));
            }
        }

        private void BindGrid()
        {
            using (SqlConnection con = new SqlConnection(constr))
            {
                string sql = "SELECT Id, Title, PostedByName, PostedByRole, PostedDate, IsPinned, IsActive FROM Notice ORDER BY IsPinned DESC, PostedDate DESC";
                using (SqlCommand cmd = new SqlCommand(sql, con))
                {
                    con.Open();
                    gvNotices.DataSource = cmd.ExecuteReader();
                    gvNotices.DataBind();
                }
            }
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            string title = txtTitle.Text.Trim();
            string description = txtDescription.Text.Trim();
            string postedByName = txtPostedByName.Text.Trim();
            string postedByRole = ddlRole.SelectedValue == "Other" ? txtCustomRole.Text.Trim() : ddlRole.SelectedValue;
            bool isPinned = chkPinned.Checked;
            DateTime? expiry = string.IsNullOrEmpty(txtExpiry.Text) ? (DateTime?)null : DateTime.Parse(txtExpiry.Text);

            if (string.IsNullOrEmpty(title) || string.IsNullOrEmpty(description) || string.IsNullOrEmpty(postedByName) || string.IsNullOrEmpty(postedByRole))
            {
                lblMessage.Text = "Please fill in Title, Description, Posted By Name and Role.";
                lblMessage.Style["color"] = "#dc2626";
                return;
            }

            byte[] fileBytes = null;
            string fileName = null;
            string fileType = null;

            if (fileAttachment.HasFile)
            {
                string ext = Path.GetExtension(fileAttachment.FileName).ToLowerInvariant();
                if (Array.IndexOf(AllowedExtensions, ext) < 0)
                {
                    lblMessage.Text = "Only PDF, JPG, or PNG attachments are allowed.";
                    lblMessage.Style["color"] = "#dc2626";
                    return;
                }
                if (fileAttachment.PostedFile.ContentLength > MaxFileSizeBytes)
                {
                    lblMessage.Text = "Attachment must be smaller than 8 MB.";
                    lblMessage.Style["color"] = "#dc2626";
                    return;
                }

                fileBytes = fileAttachment.FileBytes;
                fileName = Path.GetFileName(fileAttachment.FileName);
                fileType = fileAttachment.PostedFile.ContentType;
            }

            using (SqlConnection con = new SqlConnection(constr))
            {
                con.Open();

                if (string.IsNullOrEmpty(hidNoticeId.Value))
                {
                    // INSERT
                    string sql = @"INSERT INTO Notice
                        (Title, Description, PostedByName, PostedByRole, ExpiryDate, AttachmentName, AttachmentType, AttachmentData, IsPinned, IsActive)
                        VALUES (@Title, @Description, @PostedByName, @PostedByRole, @ExpiryDate, @AttachmentName, @AttachmentType, @AttachmentData, @IsPinned, 1)";

                    using (SqlCommand cmd = new SqlCommand(sql, con))
                    {
                        AddCommonParams(cmd, title, description, postedByName, postedByRole, expiry, fileName, fileType, fileBytes, isPinned);
                        cmd.ExecuteNonQuery();
                    }
                }
                else
                {
                    // UPDATE — only touch attachment columns if a new file was uploaded
                    string sql = @"UPDATE Notice SET
                        Title = @Title, Description = @Description,
                        PostedByName = @PostedByName, PostedByRole = @PostedByRole, ExpiryDate = @ExpiryDate,
                        IsPinned = @IsPinned" +
                        (fileBytes != null ? ", AttachmentName = @AttachmentName, AttachmentType = @AttachmentType, AttachmentData = @AttachmentData" : "") +
                        " WHERE Id = @Id";

                    using (SqlCommand cmd = new SqlCommand(sql, con))
                    {
                        AddCommonParams(cmd, title, description, postedByName, postedByRole, expiry, fileName, fileType, fileBytes, isPinned, includeAttachmentOnlyIfPresent: true);
                        cmd.Parameters.AddWithValue("@Id", int.Parse(hidNoticeId.Value));
                        cmd.ExecuteNonQuery();
                    }
                }
            }

            lblMessage.Text = "Notice saved successfully.";
            lblMessage.Style["color"] = "#059669";
            ClearForm();
            BindGrid();
        }

        private void AddCommonParams(SqlCommand cmd, string title, string description,
            string postedByName, string postedByRole, DateTime? expiry,
            string fileName, string fileType, byte[] fileBytes, bool isPinned, bool includeAttachmentOnlyIfPresent = false)
        {
            cmd.Parameters.AddWithValue("@Title", title);
            cmd.Parameters.AddWithValue("@Description", description);
            cmd.Parameters.AddWithValue("@PostedByName", postedByName);
            cmd.Parameters.AddWithValue("@PostedByRole", postedByRole);
            cmd.Parameters.AddWithValue("@ExpiryDate", expiry.HasValue ? (object)expiry.Value : DBNull.Value);
            cmd.Parameters.AddWithValue("@IsPinned", isPinned);

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
                    using (SqlCommand cmd = new SqlCommand("DELETE FROM Notice WHERE Id = @Id", con))
                    {
                        cmd.Parameters.AddWithValue("@Id", id);
                        con.Open();
                        cmd.ExecuteNonQuery();
                    }
                    BindGrid();
                    break;

                case "ToggleActive":
                    using (SqlConnection con = new SqlConnection(constr))
                    using (SqlCommand cmd = new SqlCommand("UPDATE Notice SET IsActive = ~IsActive WHERE Id = @Id", con))
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
                string sql = "SELECT * FROM Notice WHERE Id = @Id";
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
                            txtPostedByName.Text = sdr["PostedByName"].ToString();

                            string role = sdr["PostedByRole"].ToString();
                            if (NoticeRoles.Roles.Contains(role))
                            {
                                ddlRole.SelectedValue = role;
                            }
                            else
                            {
                                ddlRole.SelectedValue = "Other";
                                txtCustomRole.Text = role;
                                txtCustomRole.Style["display"] = "block";
                            }

                            chkPinned.Checked = Convert.ToBoolean(sdr["IsPinned"]);
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
            txtPostedByName.Text = "";
            txtCustomRole.Text = "";
            txtExpiry.Text = "";
            chkPinned.Checked = false;
            ddlRole.SelectedIndex = 0;
        }
    }
}
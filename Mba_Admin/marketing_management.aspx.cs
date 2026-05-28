using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Web.UI.WebControls;

namespace Learning_System.Mba_Admin
{
    public partial class marketing_management : System.Web.UI.Page
    {
        string strcon = ConfigurationManager.ConnectionStrings["conn"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindGrid();
            }
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            string topic = TextBox1.Text.Trim();
            if (FileUpload1.HasFile)
            {
                string filename = Path.GetFileName(FileUpload1.PostedFile.FileName);
                string contentType = FileUpload1.PostedFile.ContentType;

                using (Stream fs = FileUpload1.PostedFile.InputStream)
                {
                    using (BinaryReader br = new BinaryReader(fs))
                    {
                        byte[] bytes = br.ReadBytes((Int32)fs.Length);

                        using (SqlConnection con = new SqlConnection(strcon))
                        {
                            string query = "INSERT INTO mba_mm (Topic, Name, ContentType, Data) VALUES (@Topic, @Name, @ContentType, @Data)";
                            using (SqlCommand cmd = new SqlCommand(query, con))
                            {
                                cmd.Parameters.Add("@Topic", SqlDbType.NVarChar).Value = topic;
                                cmd.Parameters.Add("@Name", SqlDbType.NVarChar).Value = filename;
                                cmd.Parameters.Add("@ContentType", SqlDbType.NVarChar).Value = contentType;
                                cmd.Parameters.Add("@Data", SqlDbType.VarBinary).Value = bytes;

                                try
                                {
                                    con.Open();
                                    cmd.ExecuteNonQuery();
                                    lblMessage.Text = "Successfully Added.";
                                }
                                catch (Exception ex)
                                {
                                    lblMessage.Text = "Error: " + ex.Message;
                                }
                                finally
                                {
                                    con.Close();
                                    BindGrid();
                                }
                            }
                        }
                    }
                }
            }
            else
            {
                lblMessage.Text = "Please select a file to upload.";
            }
        }

        private void BindGrid()
        {
            using (SqlConnection con = new SqlConnection(strcon))
            {
                string query = "SELECT * FROM mba_mm";
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    try
                    {
                        con.Open();
                        GridView1.DataSource = cmd.ExecuteReader();
                        GridView1.DataBind();
                    }
                    catch (Exception ex)
                    {
                        lblMessage.Text = "Error: " + ex.Message;
                    }
                    finally
                    {
                        con.Close();
                    }
                }
            }
        }

        protected void GridView1_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            int id = int.Parse(GridView1.DataKeys[e.RowIndex].Value.ToString());
            TextBox txtTopic = (TextBox)GridView1.Rows[e.RowIndex].FindControl("TextBox2");
            TextBox txtName = (TextBox)GridView1.Rows[e.RowIndex].FindControl("TextBox3");
            TextBox txtContentType = (TextBox)GridView1.Rows[e.RowIndex].FindControl("TextBox4");
            TextBox txtData = (TextBox)GridView1.Rows[e.RowIndex].FindControl("TextBox5");

            byte[] data = Convert.FromBase64String(txtData.Text); // Convert from base64 string if needed

            Update(id, txtTopic.Text, txtName.Text, txtContentType.Text, data);
            GridView1.EditIndex = -1;
            BindGrid();
        }

        private void Update(int id, string topic, string name, string content, byte[] data)
        {
            using (SqlConnection con = new SqlConnection(strcon))
            {
                string query = "UPDATE mba_mm SET Topic = @Topic, Name = @Name, ContentType = @ContentType, Data = @Data WHERE id = @Id";
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.Add("@Topic", SqlDbType.NVarChar).Value = topic;
                    cmd.Parameters.Add("@Name", SqlDbType.NVarChar).Value = name;
                    cmd.Parameters.Add("@ContentType", SqlDbType.NVarChar).Value = content;
                    cmd.Parameters.Add("@Data", SqlDbType.VarBinary).Value = data;
                    cmd.Parameters.Add("@Id", SqlDbType.Int).Value = id;

                    try
                    {
                        con.Open();
                        cmd.ExecuteNonQuery();
                    }
                    catch (Exception ex)
                    {
                        lblMessage.Text = "Error: " + ex.Message;
                    }
                    finally
                    {
                        con.Close();
                    }
                }
            }
        }

        protected void GridView1_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            int id = Convert.ToInt32(GridView1.DataKeys[e.RowIndex].Value);
            Delete(id);
            BindGrid();
        }

        private void Delete(int id)
        {
            using (SqlConnection con = new SqlConnection(strcon))
            {
                string query = "DELETE FROM mba_mm WHERE id = @Id";
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.Add("@Id", SqlDbType.Int).Value = id;

                    try
                    {
                        con.Open();
                        cmd.ExecuteNonQuery();
                    }
                    catch (Exception ex)
                    {
                        lblMessage.Text = "Error: " + ex.Message;
                    }
                    finally
                    {
                        con.Close();
                    }
                }
            }
        }

        protected void GridView1_RowEditing(object sender, GridViewEditEventArgs e)
        {
            GridView1.EditIndex = e.NewEditIndex;
            BindGrid();
        }

        protected void GridView1_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            GridView1.EditIndex = -1;
            BindGrid();
        }
    }
}

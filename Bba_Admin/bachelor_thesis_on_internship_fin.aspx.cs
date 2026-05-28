using System;
using System.Configuration;
using System.Data.SqlClient;
using System.IO;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Learning_System.Bba_Admin
{
    public partial class bachelor_thesis_on_internship_fin : System.Web.UI.Page
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
            string filename = Path.GetFileName(FileUpload1.PostedFile.FileName);
            string contentType = FileUpload1.PostedFile.ContentType;

            using (Stream fs = FileUpload1.PostedFile.InputStream)
            {
                using (BinaryReader br = new BinaryReader(fs))
                {
                    byte[] bytes = br.ReadBytes((int)fs.Length);

                    using (SqlConnection con = new SqlConnection(strcon))
                    {
                        string query = "INSERT INTO bba_bti_finance (Topic, Name, ContentType, Data) VALUES (@Topic, @Name, @ContentType, @Data)";
                        using (SqlCommand cmd = new SqlCommand(query, con))
                        {
                            cmd.Parameters.AddWithValue("@Topic", topic);
                            cmd.Parameters.AddWithValue("@Name", filename);
                            cmd.Parameters.AddWithValue("@ContentType", contentType);
                            cmd.Parameters.AddWithValue("@Data", bytes);
                            con.Open();
                            cmd.ExecuteNonQuery();
                            con.Close();
                            BindGrid();
                        }
                    }
                }
            }

            lblMessage.Text = "Successfully Added.";
        }

        private void BindGrid()
        {
            using (SqlConnection con = new SqlConnection(strcon))
            {
                using (SqlCommand cmd = new SqlCommand("SELECT * FROM bba_bti_finance", con))
                {
                    con.Open();
                    GridView1.DataSource = cmd.ExecuteReader();
                    GridView1.DataBind();
                    con.Close();
                }
            }
        }

        private void UpdateRecord(int id, string topic, string name, string content, byte[] data)
        {
            using (SqlConnection con = new SqlConnection(strcon))
            {
                string sqlquery = "UPDATE bba_bti_finance SET Topic = @Topic, Name = @Name, ContentType = @ContentType, Data = @Data WHERE id = @Id";
                using (SqlCommand cmd = new SqlCommand(sqlquery, con))
                {
                    cmd.Parameters.AddWithValue("@Topic", topic);
                    cmd.Parameters.AddWithValue("@Name", name);
                    cmd.Parameters.AddWithValue("@ContentType", content);
                    cmd.Parameters.AddWithValue("@Data", data);
                    cmd.Parameters.AddWithValue("@Id", id);
                    con.Open();
                    cmd.ExecuteNonQuery();
                    con.Close();
                }
            }
        }

        private void DeleteRecord(int id)
        {
            using (SqlConnection con = new SqlConnection(strcon))
            {
                string sqlquery = "DELETE FROM bba_bti_finance WHERE id = @Id";
                using (SqlCommand cmd = new SqlCommand(sqlquery, con))
                {
                    cmd.Parameters.AddWithValue("@Id", id);
                    con.Open();
                    cmd.ExecuteNonQuery();
                    con.Close();
                }
            }
        }

        protected void GridView1_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            int id = int.Parse(GridView1.DataKeys[e.RowIndex].Value.ToString());
            string topic = ((TextBox)GridView1.Rows[e.RowIndex].FindControl("TextBox2")).Text;
            string name = ((TextBox)GridView1.Rows[e.RowIndex].FindControl("TextBox3")).Text;
            string content = ((TextBox)GridView1.Rows[e.RowIndex].FindControl("TextBox4")).Text;
            byte[] data = null;

            UpdateRecord(id, topic, name, content, data);
            GridView1.EditIndex = -1;
            BindGrid();
        }

        protected void GridView1_RowDeleting1(object sender, GridViewDeleteEventArgs e)
        {
            int id = Convert.ToInt32(GridView1.DataKeys[e.RowIndex].Value.ToString());
            DeleteRecord(id);
            BindGrid();
        }
    }
}

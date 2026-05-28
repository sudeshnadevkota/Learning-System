using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Learning_System.Past_Year_Paper_Admin.BHM_Admin.logo
{
    public partial class BHM_2_2017 : System.Web.UI.Page
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
                    byte[] bytes = br.ReadBytes((Int32)fs.Length);

                    using (SqlConnection con = new SqlConnection(strcon))
                    {
                        string query = "INSERT INTO BHM_2_2017 (Topic, Name, ContentType, Data) VALUES (@Topic, @Name, @ContentType, @Data)";
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
                using (SqlCommand cmd = new SqlCommand("SELECT * FROM BHM_2_2017", con))
                {
                    con.Open();
                    GridView1.DataSource = cmd.ExecuteReader();
                    GridView1.DataBind();
                    con.Close();
                }
            }
        }

        private void UpdateRecord(int id, string topic, string name, string contentType, byte[] data)
        {
            using (SqlConnection con = new SqlConnection(strcon))
            {
                string query = "UPDATE BHM_2_2017 SET Topic = @Topic, Name = @Name, ContentType = @ContentType, Data = @Data WHERE Id = @Id";
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@Id", id);
                    cmd.Parameters.AddWithValue("@Topic", topic);
                    cmd.Parameters.AddWithValue("@Name", name);
                    cmd.Parameters.AddWithValue("@ContentType", contentType);
                    cmd.Parameters.AddWithValue("@Data", data);

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
                string query = "DELETE FROM BHM_2_2017 WHERE Id = @Id";
                using (SqlCommand cmd = new SqlCommand(query, con))
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
            int id = Convert.ToInt32(GridView1.DataKeys[e.RowIndex].Value.ToString());
            TextBox txtTopic = (TextBox)GridView1.Rows[e.RowIndex].FindControl("TextBox2");
            TextBox txtName = (TextBox)GridView1.Rows[e.RowIndex].FindControl("TextBox3");
            TextBox txtContentType = (TextBox)GridView1.Rows[e.RowIndex].FindControl("TextBox4");

            // Assuming data update doesn't change the file, hence not re-uploading the data
            byte[] data = null; // Replace with actual data if necessary

            UpdateRecord(id, txtTopic.Text, txtName.Text, txtContentType.Text, data);

            GridView1.EditIndex = -1;
            BindGrid();
        }

        protected void GridView1_RowEditing(object sender, GridViewEditEventArgs e)
        {
            GridView1.EditIndex = e.NewEditIndex;
            BindGrid();
        }

        protected void GridView1_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            int id = Convert.ToInt32(GridView1.DataKeys[e.RowIndex].Value.ToString());
            DeleteRecord(id);
            BindGrid();
        }

        protected void GridView1_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            GridView1.EditIndex = -1;
            BindGrid();
        }
    }
}
using System;
using System.Configuration;
using System.Data.SqlClient;
using System.IO;
using System.Web.UI.WebControls;

namespace Learning_System.Mba_Admin
{
    public partial class banking_and_insurance : System.Web.UI.Page
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
            byte[] bytes;

            using (Stream fs = FileUpload1.PostedFile.InputStream)
            {
                using (BinaryReader br = new BinaryReader(fs))
                {
                    bytes = br.ReadBytes((Int32)fs.Length);
                }
            }

            using (SqlConnection con = new SqlConnection(strcon))
            {
                string query = "insert into mba_bi(Topic, Name, ContentType, Data) values (@Topic, @Name, @ContentType, @Data)";
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@Topic", topic);
                    cmd.Parameters.AddWithValue("@Name", filename);
                    cmd.Parameters.AddWithValue("@ContentType", contentType);
                    cmd.Parameters.AddWithValue("@Data", bytes);

                    con.Open();
                    cmd.ExecuteNonQuery();
                    con.Close();
                }
            }

            lblMessage.Text = "Successfully Added..";
            BindGrid();
        }

        private void BindGrid()
        {
            using (SqlConnection con = new SqlConnection(strcon))
            {
                string query = "select * from mba_bi";
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    con.Open();
                    GridView1.DataSource = cmd.ExecuteReader();
                    GridView1.DataBind();
                    con.Close();
                }
            }
        }

        private void update(int id, string topic, string name, string content, byte[] data)
        {
            using (SqlConnection con = new SqlConnection(strcon))
            {
                string sqlquery = "update mba_bi set Topic = @Topic, Name = @Name, ContentType = @ContentType, Data = @Data where id = @Id";
                SqlCommand cmd = new SqlCommand(sqlquery, con);
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

        private void delete(int id)
        {
            using (SqlConnection con = new SqlConnection(strcon))
            {
                string sqlquery = "delete from mba_bi where id = @Id";
                SqlCommand cmd = new SqlCommand(sqlquery, con);
                cmd.Parameters.AddWithValue("@Id", id);

                con.Open();
                cmd.ExecuteNonQuery();
                con.Close();
            }
        }

        protected void GridView1_RowUpdating1(object sender, GridViewUpdateEventArgs e)
        {
            int id = int.Parse(GridView1.DataKeys[e.RowIndex].Value.ToString());
            TextBox txtTopic = (TextBox)GridView1.Rows[e.RowIndex].FindControl("TextBox2");
            TextBox txtName = (TextBox)GridView1.Rows[e.RowIndex].FindControl("TextBox3");
            TextBox txtContent = (TextBox)GridView1.Rows[e.RowIndex].FindControl("TextBox4");
            TextBox txtData = (TextBox)GridView1.Rows[e.RowIndex].FindControl("TextBox5");

            byte[] data = Convert.FromBase64String(txtData.Text); // Convert from base64 string if stored as such

            update(id, txtTopic.Text, txtName.Text, txtContent.Text, data);
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
            int id = int.Parse(GridView1.DataKeys[e.RowIndex].Value.ToString());
            delete(id);
            BindGrid();
        }

        protected void GridView1_RowCancelingEdit1(object sender, GridViewCancelEditEventArgs e)
        {
            GridView1.EditIndex = -1;
            BindGrid();
        }
    }
}

using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

namespace Learning_System.administrator
{
    public partial class administrator_master : System.Web.UI.MasterPage
    {
        string connectionString =
            ConfigurationManager.ConnectionStrings["conn"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Check Session
                if (Session["id"] != null)
                {
                    BindUsers();
                }
                else
                {
                    Response.Redirect("../login.aspx");
                }
            }
        }

        private void BindUsers()
        {
            try
            {
                string id = Session["id"].ToString();

                string query = "SELECT * FROM login_ WHERE id=@id";

                using (SqlConnection connection =
                    new SqlConnection(connectionString))
                {
                    using (SqlCommand command =
                        new SqlCommand(query, connection))
                    {
                        command.Parameters.AddWithValue("@id", id);

                        SqlDataAdapter adapter =
                            new SqlDataAdapter(command);

                        DataTable dt = new DataTable();

                        adapter.Fill(dt);

                        username.DataSource = dt;
                        username.DataBind();
                    }
                }
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('" + ex.Message + "')</script>");
            }
        }
    }
}
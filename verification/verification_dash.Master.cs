using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Learning_System.verification
{
    public partial class verification_dash : System.Web.UI.MasterPage
    {
        string connectionString = ConfigurationManager.ConnectionStrings["conn"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
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
            string id = Session["id"]?.ToString();
            string query = "SELECT * FROM login_ WHERE id = @id";
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();
                SqlCommand command = new SqlCommand(query, connection);
                command.Parameters.AddWithValue("@id", id);
                SqlDataAdapter adapter = new SqlDataAdapter(command);
                DataTable dataTable = new DataTable();
                adapter.Fill(dataTable);
                username.DataSource = dataTable;
                username.DataBind();
            }
        }
    }
}
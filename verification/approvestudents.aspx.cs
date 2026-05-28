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
    public partial class approvestudents : System.Web.UI.Page
    {
        string connectionString = ConfigurationManager.ConnectionStrings["conn"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindRegister();
            }
        }

        private void BindRegister()
        {
            string query = "SELECT * FROM login_ WHERE status = 'students'";
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                SqlCommand cmd = new SqlCommand(query, conn);
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);

                register.DataSource = dt;
                register.DataBind();
            }
        }

        protected void register_RowEditing(object sender, GridViewEditEventArgs e)
        {
            register.EditIndex = e.NewEditIndex;
            BindRegister();
        }

        protected void register_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            int id = Convert.ToInt32(register.DataKeys[e.RowIndex].Value);
            GridViewRow row = register.Rows[e.RowIndex];

            DropDownList ddlrole = (DropDownList)row.FindControl("ddlrole");
            string role = ddlrole.SelectedValue;

            DropDownList ddlsemester = (DropDownList)row.FindControl("ddlsemester");
            string semester = ddlsemester.SelectedValue;

            string query = "UPDATE login_ SET role = @role, semester = @semester WHERE id = @id";
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@role", role);
                cmd.Parameters.AddWithValue("@semester", semester);
                cmd.Parameters.AddWithValue("@id", id);
                conn.Open();
                cmd.ExecuteNonQuery();
            }

            register.EditIndex = -1;
            BindRegister();
        }

        protected void register_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            register.EditIndex = -1;
            BindRegister();
        }

        protected void register_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            int id = Convert.ToInt32(register.DataKeys[e.RowIndex].Value);
            string query = "DELETE FROM login_ WHERE id = @id";
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@id", id);
                conn.Open();
                cmd.ExecuteNonQuery();
            }
            BindRegister();
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            string searchQuery = txtSearch.Text.Trim();
            BindRepeater(searchQuery);
        }

        private void BindRepeater(string searchQuery)
        {
            string query = "SELECT * FROM login_ WHERE status = 'students'";
            if (!string.IsNullOrEmpty(searchQuery))
            {
                query += " AND (Username LIKE @SearchQuery OR role LIKE @SearchQuery OR full_name LIKE @SearchQuery OR contact LIKE @SearchQuery OR status LIKE @SearchQuery OR faculty LIKE @SearchQuery OR semester LIKE @SearchQuery)";
            }
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();
                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    if (!string.IsNullOrEmpty(searchQuery))
                    {
                        command.Parameters.AddWithValue("@SearchQuery", "%" + searchQuery + "%");
                    }
                    SqlDataAdapter adapter = new SqlDataAdapter(command);
                    DataTable dataTable = new DataTable();
                    adapter.Fill(dataTable);
                    register.DataSource = dataTable;
                    register.DataBind();
                }
            }
        }
    }
}

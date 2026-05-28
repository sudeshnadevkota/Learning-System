using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Learning_System.students
{
    public partial class default_student : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["id"] != null)
                {
                    LoadTableNames();
                }
                else
                {
                    Response.Redirect("../login.aspx");
                }
            }
        }

        private void LoadTableNames()
        {
            string connString = ConfigurationManager.ConnectionStrings["conn"].ConnectionString;
            string procedureName = GetStoredProcedureNameFromLogin(Session["id"].ToString());

            if (!string.IsNullOrEmpty(procedureName))
            {
                using (SqlConnection conn = new SqlConnection(connString))
                {
                    using (SqlCommand cmd = new SqlCommand(procedureName, conn))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        conn.Open();

                        SqlDataAdapter da = new SqlDataAdapter(cmd);
                        DataTable dt = new DataTable();
                        da.Fill(dt);
                        GridView1.DataSource = dt;
                        GridView1.DataBind();
                    }
                }
            }
            else
            {
                Response.Write("No procedure found for this user.");
            }
        }

        private string GetStoredProcedureNameFromLogin(string userId)
        {
            string connString = ConfigurationManager.ConnectionStrings["conn"].ConnectionString;
            string procedureName = string.Empty;
            using (SqlConnection conn = new SqlConnection(connString))
            {
                using (SqlCommand cmd = new SqlCommand("SELECT semester FROM login_ WHERE id = @id", conn))
                {
                    cmd.Parameters.AddWithValue("@id", userId);
                    conn.Open();
                    object result = cmd.ExecuteScalar();
                    if (result != null)
                    {
                        procedureName = result.ToString();
                    }
                }
            }

            return procedureName;
        }
    }
}
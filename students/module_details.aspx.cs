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
    public partial class module_details : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string subjectName = Request.QueryString["subject"];
                if (!string.IsNullOrEmpty(subjectName))
                {
                    lblSubject.Text = subjectName;
                    LoadModuleData(subjectName);
                }
                else
                {
                    Response.Redirect("login.aspx");
                }
            }

        }

        private void LoadModuleData(string subjectName)
        {
            string connString = ConfigurationManager.ConnectionStrings["conn"].ConnectionString;
            string storedProcedureName = GetStoredProcedureNameFromLogin(Session["id"].ToString());

            if (!string.IsNullOrEmpty(storedProcedureName))
            {
                using (SqlConnection conn = new SqlConnection(connString))
                {
                    using (SqlCommand cmd = new SqlCommand(storedProcedureName, conn))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        conn.Open();

                        SqlDataAdapter da = new SqlDataAdapter(cmd);
                        DataTable dt = new DataTable();
                        da.Fill(dt);
                        string tableName = ConvertSubjectToTable(dt, subjectName);

                        if (!string.IsNullOrEmpty(tableName))
                        {
                            using (SqlCommand cmd2 = new SqlCommand($"SELECT * FROM {tableName}", conn))
                            {
                                SqlDataAdapter da2 = new SqlDataAdapter(cmd2);
                                DataTable dt2 = new DataTable();
                                da2.Fill(dt2);

                                ModuleGridView.DataSource = dt2;
                                ModuleGridView.DataBind();
                            }
                        }
                    }
                }
            }
            else
            {
                Response.Write("No stored procedure found for this user.");
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

        private string ConvertSubjectToTable(DataTable dt, string subjectName)
        {
            foreach (DataRow row in dt.Rows)
            {
                if (row["Subject_Name"].ToString() == subjectName)
                {
                    return row["Table_Name"].ToString();
                }
            }
            return null;
        }

        protected void DownloadFile(object sender, EventArgs e)
        {
            try
            {
                int id = int.Parse((sender as LinkButton).CommandArgument);
                byte[] fileData;
                string fileName, contentType;
                string connString = ConfigurationManager.ConnectionStrings["conn"].ConnectionString;
                string storedProcedureName = GetStoredProcedureNameFromLogin(Session["id"].ToString());
                if (string.IsNullOrEmpty(storedProcedureName))
                {
                    Response.Write("No stored procedure found for this user.");
                    return;
                }
                string subjectName = lblSubject.Text;
                string tableName = "";
                using (SqlConnection conn = new SqlConnection(connString))
                {
                    using (SqlCommand cmd = new SqlCommand(storedProcedureName, conn))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        conn.Open();
                        SqlDataAdapter da = new SqlDataAdapter(cmd);
                        DataTable dt = new DataTable();
                        da.Fill(dt);
                        tableName = ConvertSubjectToTable(dt, subjectName);
                    }
                }
                if (string.IsNullOrEmpty(tableName))
                {
                    Response.Write("No data available for this module.");
                    return;
                }
                using (SqlConnection con = new SqlConnection(connString))
                {
                    using (SqlCommand cmd = new SqlCommand($"SELECT Name, Data, ContentType FROM {tableName} WHERE Id = @Id", con))
                    {
                        cmd.Parameters.AddWithValue("@Id", id);
                        con.Open();

                        using (SqlDataReader sdr = cmd.ExecuteReader())
                        {
                            if (sdr.Read())
                            {
                                fileData = (byte[])sdr["Data"];
                                fileName = sdr["Name"].ToString();
                                contentType = sdr["ContentType"].ToString();
                            }
                            else
                            {
                                Response.Write("File not found.");
                                return;
                            }
                        }
                    }
                }
                Response.Clear();
                Response.Buffer = true;
                Response.Charset = "";
                Response.Cache.SetCacheability(HttpCacheability.NoCache);
                Response.ContentType = contentType;
                Response.AppendHeader("Content-Disposition", "attachment; filename=" + fileName);
                Response.BinaryWrite(fileData);
                Response.Flush();
                Response.End();
            }
            catch (Exception ex)
            {
                Response.Write("An error occurred: " + ex.Message);
            }
        }


    }
}
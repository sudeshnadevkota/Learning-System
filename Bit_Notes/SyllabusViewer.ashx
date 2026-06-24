<%@ WebHandler Language="C#" Class="Learning_System.Bit_Notes.SyllabusViewer" %>

using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Web;

namespace Learning_System.Bit_Notes
{
    public class SyllabusViewer : IHttpHandler
    {
        public bool IsReusable
        {
            get { return true; }
        }

        public void ProcessRequest(HttpContext context)
        {
            string code = context.Request.QueryString["code"];

            if (string.IsNullOrEmpty(code) || !SubjectMap.Subjects.ContainsKey(code))
            {
                context.Response.StatusCode = 404;
                return;
            }

            string constr = ConfigurationManager.ConnectionStrings["conn"].ConnectionString;

            using (SqlConnection con = new SqlConnection(constr))
            {
                string sql = "SELECT FileName, ContentType, FileData FROM Syllabus WHERE SubjectCode = @Code";
                using (SqlCommand cmd = new SqlCommand(sql, con))
                {
                    cmd.Parameters.AddWithValue("@Code", code);
                    con.Open();

                    using (SqlDataReader dr = cmd.ExecuteReader())
                    {
                        if (dr.Read() && dr["FileData"] != DBNull.Value)
                        {
                            byte[] bytes = (byte[])dr["FileData"];
                            string contentType = dr["ContentType"].ToString();
                            string fileName = dr["FileName"].ToString();

                            context.Response.Clear();
                            context.Response.ContentType = string.IsNullOrEmpty(contentType) ? "application/pdf" : contentType;
                            context.Response.AddHeader("Content-Disposition", "inline; filename=\"" + fileName + "\"");
                            context.Response.BinaryWrite(bytes);
                            context.Response.Flush();
                        }
                        else
                        {
                            context.Response.StatusCode = 404;
                            context.Response.Write("No syllabus uploaded yet for this subject.");
                        }
                    }
                }
            }
        }
    }
}
<%@ WebHandler Language="C#" Class="Learning_System.NoticeViewer" %>

using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Web;

namespace Learning_System
{
    public class NoticeViewer : IHttpHandler
    {
        public void ProcessRequest(HttpContext context)
        {
            int id;
            if (!int.TryParse(context.Request.QueryString["id"], out id))
            {
                context.Response.StatusCode = 400;
                return;
            }

            string constr = ConfigurationManager.ConnectionStrings["conn"].ConnectionString;

            using (SqlConnection con = new SqlConnection(constr))
            {
                string sql = "SELECT AttachmentName, AttachmentType, AttachmentData FROM Notice WHERE NoticeId = @Id AND IsActive = 1";
                using (SqlCommand cmd = new SqlCommand(sql, con))
                {
                    cmd.Parameters.AddWithValue("@Id", id);
                    con.Open();
                    using (SqlDataReader sdr = cmd.ExecuteReader())
                    {
                        if (sdr.Read() && sdr["AttachmentData"] != DBNull.Value)
                        {
                            byte[] data = (byte[])sdr["AttachmentData"];
                            string contentType = sdr["AttachmentType"].ToString();

                            context.Response.ContentType = string.IsNullOrEmpty(contentType) ? "application/octet-stream" : contentType;
                            context.Response.AddHeader("Content-Disposition", "inline; filename=" + sdr["AttachmentName"]);
                            context.Response.BinaryWrite(data);
                        }
                        else
                        {
                            context.Response.StatusCode = 404;
                        }
                    }
                }
            }
        }

        public bool IsReusable { get { return false; } }
    }
}
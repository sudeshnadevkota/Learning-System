using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

namespace Learning_System.Bit_Notes
{
    public partial class course_content : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string code = Request.QueryString["code"];

            if (string.IsNullOrEmpty(code) || !SubjectMap.Subjects.TryGetValue(code, out SubjectMap.SubjectInfo subject))
            {
                Response.Redirect("~/Bit_Notes/dash.aspx");
                return;
            }

            TableName = subject.Table;

            if (!IsPostBack)
            {
                LoadSyllabusInfo(code, subject.Title);
                BindData(GridViewNotes, GridViewPapers);
            }
        }

        private void LoadSyllabusInfo(string code, string fallbackTitle)
        {
            using (SqlConnection con = new SqlConnection(constr))
            {
                string sql = @"SELECT DisplayCode,
              Credit,
              Hours,
              TopicCount,
              FileName
       FROM Syllabus
       WHERE SubjectCode = @Code";
                using (SqlCommand cmd = new SqlCommand(sql, con))
                {
                    cmd.Parameters.AddWithValue("@Code", code);
                    con.Open();
                    using (SqlDataReader sdr = cmd.ExecuteReader())
                    {
                        if (sdr.Read())
                        {
                            litTitle.Text = fallbackTitle;

                            litDisplayCode.Text = sdr["DisplayCode"].ToString();
                            litCredits.Text = sdr["Credit"].ToString();
                            litHours.Text = sdr["Hours"].ToString() + "h";
                            litTopics.Text = sdr["TopicCount"].ToString();

                            litSylTitle.Text = sdr["DisplayCode"].ToString() + " Syllabus";

                            // NEW — point the iframe at the streaming handler, only if a file actually exists
                            if (sdr["FileName"] != DBNull.Value)
                            {
                                sylPdfFrame.Attributes["src"] = ResolveUrl("~/Bit_Notes/SyllabusViewer.ashx?code=" + code);
                            }
                        }
                        else
                        {
                            // No Syllabus row yet for this subject — fall back to SubjectMap title, blank stats
                            litTitle.Text = fallbackTitle;
                            litDisplayCode.Text = "-";
                            litCredits.Text = "-";
                            litHours.Text = "-";
                            litTopics.Text = "-";
                        }
                    }
                }
            }
        }
    }
}
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
                string sql = "SELECT Title, DisplayCode, Credits, TotalHours, TopicsCount, SyllabusPdfPath " +
                             "FROM Syllabus WHERE Code = @Code";
                using (SqlCommand cmd = new SqlCommand(sql, con))
                {
                    cmd.Parameters.AddWithValue("@Code", code);
                    con.Open();
                    using (SqlDataReader sdr = cmd.ExecuteReader())
                    {
                        if (sdr.Read())
                        {
                            litTitle.Text = sdr["Title"].ToString();
                            litDisplayCode.Text = sdr["DisplayCode"].ToString();
                            litCredits.Text = sdr["Credits"].ToString();
                            litHours.Text = sdr["TotalHours"].ToString() + "h";
                            litTopics.Text = sdr["TopicsCount"].ToString();
                            sylPdfFrame.Src = ResolveUrl("~" + sdr["SyllabusPdfPath"].ToString()) + "#toolbar=0";
                            litSylTitle.Text = sdr["DisplayCode"].ToString() + " Syllabus";
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
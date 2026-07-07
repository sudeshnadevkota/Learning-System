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


            if (Session["ProfileId"] == null)
            {
                Response.Redirect("~/login.aspx");
            }
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
                string sql = @"SELECT SubjectCode,
              CreditScore,
              TotalHours,
              FileName
       FROM Syllabus
       WHERE SubjectName = @Code";
                using (SqlCommand cmd = new SqlCommand(sql, con))
                {
                    cmd.Parameters.AddWithValue("@Code", code);
                    con.Open();
                    using (SqlDataReader sdr = cmd.ExecuteReader())
                    {
                        if (sdr.Read())
                        {
                            litTitle.Text = fallbackTitle;

                            litDisplayCode.Text = sdr["SubjectCode"].ToString();
                            litCredits.Text = sdr["CreditScore"].ToString();
                            litHours.Text = sdr["TotalHours"].ToString() + "h";

                            litSylTitle.Text = sdr["SubjectCode"].ToString() + " Syllabus";

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
                        }
                    }
                }
            }
        }
    }
}
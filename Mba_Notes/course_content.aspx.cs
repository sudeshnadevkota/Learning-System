using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

namespace Learning_System.Mba_Notes
{
    public partial class course_content : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {



            string code = Request.QueryString["code"];
            if (string.IsNullOrEmpty(code) || !SubjectMap.Subjects.TryGetValue(code, out SubjectMap.SubjectInfo subject))
            {
                Response.Redirect("~/Mba_Notes/dash.aspx");
                return;
            }

            TableName = subject.Table;

            // Check login for the MaterialsPanel
            if (Session["ProfileId"] == null)
            {
                MaterialsPanel.Visible = false;
                pnlLoginPrompt.Visible = true; // Show the new panel with the button
            }
            else
            {
                MaterialsPanel.Visible = true;
                pnlLoginPrompt.Visible = false;
            }

            if (!IsPostBack)
            {
                LoadSyllabusInfo(code, subject.Title);
                // Only bind data if user is logged in to save resources
                if (Session["ProfileId"] != null)
                {
                    BindData(GridViewNotes, GridViewPapers);
                }
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
                                sylPdfFrame.Attributes["src"] = ResolveUrl("~/Mba_Notes/SyllabusViewer.ashx?code=" + code);
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
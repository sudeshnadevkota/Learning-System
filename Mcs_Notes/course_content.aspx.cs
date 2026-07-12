using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

namespace Learning_System.Mcs_Notes
{
    public partial class course_content : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string code = Request.QueryString["code"];
            if (string.IsNullOrEmpty(code) || !SubjectMap.Subjects.TryGetValue(code, out SubjectMap.SubjectInfo subject))
            {
                Response.Redirect("~/Mcs_Notes/dash.aspx");
                return;
            }

            TableName = subject.Table;

            bool hasAccess = CheckAccess(subject);

            if (Session["ProfileId"] == null)
            {
                // Not logged in at all
                MaterialsPanel.Visible = false;
                pnlDeptDenied.Visible = false;
                pnlLoginPrompt.Visible = true;

                lnkLogin.NavigateUrl = "~/login.aspx?ReturnUrl=" + Server.UrlEncode(Request.Url.PathAndQuery);
            }
            else
            {
                if (hasAccess)
                {
                    MaterialsPanel.Visible = true;
                    pnlLoginPrompt.Visible = false;
                    pnlDeptDenied.Visible = false;
                }
                else
                {
                    MaterialsPanel.Visible = false;
                    pnlLoginPrompt.Visible = false;
                    pnlDeptDenied.Visible = true; // covers both dept mismatch AND semester not reached yet
                }
            }

            if (!IsPostBack)
            {
                LoadSyllabusInfo(code, subject.Title);

                if (hasAccess)
                {
                    BindData(GridViewNotes, GridViewPapers);
                }
            }
        }

        // Logged in + same department + subject's semester is current or already passed
        private bool CheckAccess(SubjectMap.SubjectInfo subject)
        {
            if (Session["ProfileId"] == null)
                return false;

            string userDeptCode = Session["DepartmentCode"] as string;
            bool deptMatch = !string.IsNullOrEmpty(userDeptCode)
                              && !string.IsNullOrEmpty(subject.DepartmentCode)
                              && string.Equals(userDeptCode, subject.DepartmentCode, StringComparison.OrdinalIgnoreCase);

            if (!deptMatch)
                return false;

            int userSemester;
            if (!int.TryParse(Session["Semester"]?.ToString(), out userSemester))
                return false;

            // subject.Semester <= userSemester means:
            // 4th semester student can access semester 1, 2, 3, 4 but not 5
            return subject.Semester <= userSemester;
        }

        private void LoadSyllabusInfo(string code, string fallbackTitle)
        {
            using (SqlConnection con = new SqlConnection(constr))
            {
                string sql = @"SELECT SubjectCode, CreditScore, TotalHours, FileName
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

                            if (sdr["FileName"] != DBNull.Value)
                            {
                                hidSylUrl.Value = ResolveUrl("~/Bcs_Notes/SyllabusViewer.ashx?code=" + code);
                            }
                        }
                        else
                        {
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
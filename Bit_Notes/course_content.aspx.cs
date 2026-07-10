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
                // NEW — logged in, but check DepartmentCode matches this subject's department
                string userDeptCode = Session["DepartmentCode"] as string;

                bool hasAccess = !string.IsNullOrEmpty(userDeptCode)
                                  && !string.IsNullOrEmpty(subject.DepartmentCode)
                                  && string.Equals(userDeptCode, subject.DepartmentCode, StringComparison.OrdinalIgnoreCase);

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
                    pnlDeptDenied.Visible = true; // NEW — "your department doesn't have access" message
                }
            }

            if (!IsPostBack)
            {
                LoadSyllabusInfo(code, subject.Title);

                // Only bind grid data if user is logged in AND has department access
                string userDeptCode = Session["DepartmentCode"] as string;
                bool hasAccess = Session["ProfileId"] != null
                                  && !string.IsNullOrEmpty(userDeptCode)
                                  && !string.IsNullOrEmpty(subject.DepartmentCode)
                                  && string.Equals(userDeptCode, subject.DepartmentCode, StringComparison.OrdinalIgnoreCase);

                if (hasAccess)
                {
                    BindData(GridViewNotes, GridViewPapers);
                }
            }
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
                                sylPdfFrame.Attributes["src"] = ResolveUrl("~/Bit_Notes/SyllabusViewer.ashx?code=" + code);
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
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web.UI;
using Learning_System.Common;

namespace Learning_System
{
    // Changed base class from System.Web.UI.Page to System.Web.UI.UserControl
    public partial class SubjectManageControl : System.Web.UI.UserControl, IDynamicSection
    {
        protected string constr = ConfigurationManager.ConnectionStrings["conn"].ConnectionString;

        // ── View models for the nested Repeaters ──
        public class SubjectRow
        {
            public string Code { get; set; }
            public string Title { get; set; }
            public string Table { get; set; }
        }

        public class SemesterGroup
        {
            public int Semester { get; set; }
            public List<SubjectRow> Subjects { get; set; }
        }

        public class DepartmentGroup
        {
            public string DepartmentCode { get; set; }
            public string DepartmentName { get; set; }
            public int SubjectCount { get; set; }
            public List<SemesterGroup> Semesters { get; set; }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            // 'this.Page' is passed explicitly now since authorization logic expects the parent Page context.
            // Added DepartmentAdmin since this control is now shared across all three dashboards.
            PermissionHelper.RequireAccessLevel(this.Page, "MainAdmin", "SuperAdmin", "DepartmentAdmin");

            // Data loading moved to LoadInitialData() — IsPostBack can't be trusted here,
            // since the sidebar click that creates this control is itself a postback.
        }

        // Called by BaseAdminMaster.LoadSection() right after this control is
        // freshly added to the page.
        public void LoadInitialData()
        {
            LoadSubjects();
        }

        private void LoadSubjects()
        {
            string role = Session["AccessLevel"] as string;
            string myDeptCode = Session["DepartmentCode"] as string;

            // DepartmentAdmin with no department assigned sees nothing rather than
            // everything — fail closed, not open.
            if (role == "DepartmentAdmin" && string.IsNullOrEmpty(myDeptCode))
            {
                rptDepartments.DataSource = new List<DepartmentGroup>();
                rptDepartments.DataBind();
                return;
            }

            // Department names come from the DB; subjects themselves come from the
            // in-code SubjectMap whitelist, not from a table.
            Dictionary<string, string> deptNames = new Dictionary<string, string>(StringComparer.OrdinalIgnoreCase);
            using (SqlConnection con = new SqlConnection(constr))
            using (SqlCommand cmd = new SqlCommand("SELECT DepartmentCode, DepartmentName FROM Department", con))
            {
                con.Open();
                using (SqlDataReader rdr = cmd.ExecuteReader())
                {
                    while (rdr.Read())
                    {
                        deptNames[rdr["DepartmentCode"].ToString()] = rdr["DepartmentName"].ToString();
                    }
                }
            }

            var subjectSource = SubjectMap.Subjects.AsEnumerable();

            // DepartmentAdmin: filter down to their own department only.
            // MainAdmin/SuperAdmin: no filter, they see everything.
            if (role == "DepartmentAdmin")
            {
                subjectSource = subjectSource.Where(kvp =>
                    string.Equals(kvp.Value.DepartmentCode, myDeptCode, StringComparison.OrdinalIgnoreCase));
            }

            var groups = subjectSource
                .Select(kvp => new
                {
                    Code = kvp.Key,
                    kvp.Value.Title,
                    kvp.Value.Table,
                    kvp.Value.DepartmentCode,
                    kvp.Value.Semester
                })
                .GroupBy(s => s.DepartmentCode, StringComparer.OrdinalIgnoreCase)
                .OrderBy(g => g.Key)
                .Select(deptGroup => new DepartmentGroup
                {
                    DepartmentCode = deptGroup.Key,
                    DepartmentName = deptNames.ContainsKey(deptGroup.Key) ? deptNames[deptGroup.Key] : deptGroup.Key,
                    SubjectCount = deptGroup.Count(),
                    Semesters = deptGroup
                        .GroupBy(s => s.Semester)
                        .OrderBy(sg => sg.Key)
                        .Select(sg => new SemesterGroup
                        {
                            Semester = sg.Key,
                            Subjects = sg
                                .OrderBy(s => s.Title)
                                .Select(s => new SubjectRow { Code = s.Code, Title = s.Title, Table = s.Table })
                                .ToList()
                        })
                        .ToList()
                })
                .ToList();

            rptDepartments.DataSource = groups;
            rptDepartments.DataBind();
        }
    }
}
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;

namespace Learning_System
{
    public partial class SubjectManage : System.Web.UI.Page
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
            // Only SuperAdmin (and MainAdmin, in case they want to peek) may view this
            PermissionHelper.RequireAccessLevel(this, "MainAdmin", "SuperAdmin");

            if (!IsPostBack)
            {
                LoadSubjects();
            }
        }

        private void LoadSubjects()
        {
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

            var groups = SubjectMap.Subjects
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
using System;
using System.Collections.Generic;
using System.Web.UI.WebControls;
using Learning_System.Common;

namespace Learning_System.SuperAdmin
{
    public partial class SuperAdminMaster : BaseAdminMaster
    {
        protected override PlaceHolder DynamicPlaceHolder => phDynamic;

        // Keys match CommandArgument on the LinkButtons in the markup above.
        // Paths point at the shared root-level controls used by all three dashboards.
        private static readonly Dictionary<string, string> Sections = new Dictionary<string, string>
        {
            { "Staff",    "~/StaffManage.ascx" },
            { "Students", "~/StudentManage.ascx" },
            { "Subjects", "~/SubjectManage.ascx" },
            { "DeptAdmins",  "~/DepartmentAdminManageControl.ascx" },
            { "Departments", "~/DepartmentManageControl.ascx" },
                { "AppointUser", "/administrator/AppointUserControl.ascx" },
    { "NoticeManage", "~/NoticeManageControl.ascx" },
        };

        protected void Page_Init(object sender, EventArgs e)
        {
            if (IsPostBack)
            {
                RestoreSection();
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            lnkStaff.CssClass = GetNavClass("Staff");
            lnkStudents.CssClass = GetNavClass("Students");
            lnkSubjects.CssClass = GetNavClass("Subjects");
            lnkDeptAdmins.CssClass = GetNavClass("DeptAdmins");
            lnkDepartments.CssClass = GetNavClass("Departments");
            lnkAppointUser.CssClass = GetNavClass("AppointUser");
            lnkNoticeManage.CssClass = GetNavClass("NoticeManage");

            if (!IsPostBack)
            {
                pnlStaticContent.Visible = true;
                pnlDynamicContent.Visible = false;
            }
            else if (Session["ActiveSection_" + GetType().Name] != null)
            {
                // Section was restored in Page_Init — just fix panel visibility here.
                pnlStaticContent.Visible = false;
                pnlDynamicContent.Visible = true;
            }
        }

        protected void NavLink_Click(object sender, EventArgs e)
        {
            var key = ((LinkButton)sender).CommandArgument;
            if (Sections.TryGetValue(key, out var path))
            {
                LoadSection(key, path);
                pnlStaticContent.Visible = false;
                pnlDynamicContent.Visible = true;
            }
        }
    }
}
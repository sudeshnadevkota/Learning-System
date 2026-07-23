using System;
using System.Collections.Generic;
using System.Web.Security;
using System.Web.UI.WebControls;
using Learning_System.Common;

namespace Learning_System.Bcs_Admin
{
    public partial class upload : BaseAdminMaster
    {
        protected override PlaceHolder DynamicPlaceHolder => phDynamic;

        protected bool IsDepartmentAdmin;
        protected bool IsTeacher;

        // Only Quick Action items that already have a working .ascx control go here.
        // AppointUser, RegisterStudent, Notices, Reports are still plain .aspx links
        // in the markup above — add them here (and switch their markup to
        // asp:LinkButton) once their .ascx controls exist.
        private static readonly Dictionary<string, string> Sections = new Dictionary<string, string>
        {
            //{ "StaffManage",  "~/StaffManage.ascx" },
            //{ "DeptSettings", "~/DepartmentManageControl.ascx" },
            //{ "NoticeManage", "~/NoticeManageControl.ascx" },
            //{ "AppointUser", "~/administrator/AppointUserControl.ascx" },
            { "ApproveStudents", "~/ApproveStudents.ascx" },
        };

        protected void Page_Init(object sender, EventArgs e)
        {
            if (IsPostBack)
                RestoreSection();
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            // User must be logged in
            if (!PermissionHelper.IsLoggedIn(Session))
            {
                Response.Redirect("~/login.aspx");
                return;
            }

            // Determine current user's role
            IsTeacher = PermissionHelper.GetRole(Session) == "Teacher";
            IsDepartmentAdmin = PermissionHelper.GetAccessLevel(Session) == "DepartmentAdmin";

            // Only Department Admin and Teacher can access this master page
            if (!(IsTeacher || IsDepartmentAdmin))
            {
                Response.Redirect("~/AccessDenied.aspx");
                return;
            }

            if (IsDepartmentAdmin)
            {
                // Set CSS class for active dynamic navigation links
                lnkApproveStudents.CssClass = GetNavClass("ApproveStudents");
            }

            if (!IsPostBack)
            {
                pnlStaticContent.Visible = true;
                pnlDynamicContent.Visible = false;
            }
            else if (HasActiveSection)
            {
                // Section was restored in Page_Init — adjust panel visibility here.
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

        protected void LinkOut_Click(object sender, EventArgs e)
        {
            Session.Clear();
            Session.Abandon();
            FormsAuthentication.SignOut();

            Response.Redirect("~/Default.aspx");
        }
    }
}
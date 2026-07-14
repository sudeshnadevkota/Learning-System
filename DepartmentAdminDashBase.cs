using System;
using System.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Learning_System
{
    // Shared behavior for every {DeptCode}_Admin/dash.aspx page. Both that department's
    // DepartmentAdmin AND its Staff land here — the markup/data for staff-management is
    // only shown to DepartmentAdmin; Staff only ever sees/controls the student roster.
    public abstract class DepartmentAdminDashBase : System.Web.UI.Page
    {
        protected string constr = ConfigurationManager.ConnectionStrings["conn"].ConnectionString;
        protected int DeptId;
        protected bool IsDeptAdmin;

        protected abstract Literal LitStaffCount { get; }
        protected abstract Literal LitStudentCount { get; }
        protected abstract GridView GvStaff { get; }
        protected abstract GridView GvStudents { get; }
        protected abstract Panel PnlStaffRoster { get; }

        protected abstract Panel PnlAdminControls { get; }



        protected void Page_Load(object sender, EventArgs e)
        {
            // Staff (Role="Teacher", AccessLevel=null) and DepartmentAdmin
            // (Role="Admin", AccessLevel="DepartmentAdmin") are the only two roles
            // that reach this page — neither RequireAccessLevel nor
            // RequireAnyAccessLevel alone covers both, so check both explicitly.
            bool isTeacher = PermissionHelper.GetRole(Session) == "Teacher";
            bool isDeptAdminRole = PermissionHelper.GetAccessLevel(Session) == "DepartmentAdmin";

            if (!PermissionHelper.IsLoggedIn(Session) || !(isTeacher || isDeptAdminRole))
            {
                Response.Redirect("~/AccessDenied.aspx");
                return;
            }

            IsDeptAdmin = isDeptAdminRole;

            int? deptId = PermissionHelper.GetDepartmentId(Session);
            if (!deptId.HasValue)
            {
                Response.Redirect("~/AccessDenied.aspx");
                return;
            }
            DeptId = deptId.Value;

            // Removed server-side, not just hidden by CSS — Staff gets nothing to
            // tamper with client-side, since the panel and its GridView are never bound.
            PnlStaffRoster.Visible = IsDeptAdmin;
            PnlAdminControls.Visible = IsDeptAdmin;

            if (!IsPostBack)
            {
                BindStats();
                if (IsDeptAdmin) BindStaff();
                BindStudents();
            }
        }

        protected void BindStats()
        {
            LitStudentCount.Text = DepartmentDataService.GetStudentCount(constr, DeptId).ToString();
            if (IsDeptAdmin)
                LitStaffCount.Text = DepartmentDataService.GetStaffCount(constr, DeptId).ToString();
        }

        protected void BindStaff()
        {
            GvStaff.DataSource = DepartmentDataService.GetStaffList(constr, DeptId);
            GvStaff.DataBind();
        }

        protected void BindStudents()
        {
            GvStudents.DataSource = DepartmentDataService.GetStudentList(constr, DeptId);
            GvStudents.DataBind();
        }

        // Belt-and-braces: even if a Staff session somehow posts back a command against
        // gvStaff, it's refused here too, not just hidden.
        protected void gvStaff_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (!IsDeptAdmin) return;
            if (e.CommandName != "ToggleSuspend" && e.CommandName != "Delete") return;

            GridViewRow row = (GridViewRow)((Control)e.CommandSource).NamingContainer;
            int profileId = Convert.ToInt32(GvStaff.DataKeys[row.RowIndex]["ProfileId"]);
            bool isActive = Convert.ToBoolean(GvStaff.DataKeys[row.RowIndex]["IsActive"]);

            if (e.CommandName == "ToggleSuspend")
                DepartmentDataService.SetActive(constr, profileId, !isActive);
            else if (e.CommandName == "Delete")
            {
                if (!IsDeptAdmin)
                    return;

                DepartmentDataService.Delete(constr, "TeacherProfile", profileId);

            }

            BindStaff();
            BindStats();
        }

        // Both roles can suspend/remove students.
        protected void gvStudents_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName != "ToggleSuspend" && e.CommandName != "Delete") return;

            GridViewRow row = (GridViewRow)((Control)e.CommandSource).NamingContainer;
            int profileId = Convert.ToInt32(GvStudents.DataKeys[row.RowIndex]["ProfileId"]);
            bool isActive = Convert.ToBoolean(GvStudents.DataKeys[row.RowIndex]["IsActive"]);

            if (e.CommandName == "ToggleSuspend")
                DepartmentDataService.SetActive(constr, profileId, !isActive);
            else if (e.CommandName == "Delete")
                DepartmentDataService.Delete(constr, "StudentProfile", profileId);

            BindStudents();
            BindStats();
        }
    }
}
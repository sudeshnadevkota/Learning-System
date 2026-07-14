using System;
using System.Web.Security;

namespace Learning_System.Bit_Admin
{
    public partial class upload : System.Web.UI.MasterPage
    {
        protected bool IsDepartmentAdmin;
        protected bool IsTeacher;

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

            if (!IsPostBack)
            {
                ApplyPermissions();
            }
        }

        private void ApplyPermissions()
        {
            // ===================================================
            // Department Admin only menu items can be hidden here.
            //
            // Your current menu only contains:
            //  - Dashboard
            //  - Semester 1-8
            //
            // Since Teachers are allowed to upload notes/resources,
            // they should also see these menu items.
            //
            // If you later add menu items such as:
            //  • Register Staff
            //  • Register Student
            //  • Department Settings
            //  • Manage Teachers
            //
            // Then hide them here for teachers.
            // ===================================================

            if (!IsDepartmentAdmin)
            {
                // Example:
                // Menu1.FindItem("Register Staff").Selectable = false;
                // Menu1.FindItem("Register Staff").NavigateUrl = "";

                // Menu1.FindItem("Register Student").Selectable = false;
                // Menu1.FindItem("Register Student").NavigateUrl = "";
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
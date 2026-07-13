using System.Web.UI.WebControls;

namespace Learning_System.Bit_Admin
{
    public partial class dash : DepartmentAdminDashBase
    {
        protected override Literal LitStaffCount => litStaffCount;
        protected override Literal LitStudentCount => litStudentCount;
        protected override GridView GvStaff => gvStaff;
        protected override GridView GvStudents => gvStudents;
        protected override Panel PnlStaffRoster => pnlStaffRoster;
    }
}
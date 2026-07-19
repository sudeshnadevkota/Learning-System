using System;
using System.Web;
using System.Web.Security;
using System.Web.UI;

namespace Learning_System.Bhm_Admin
{
    public partial class bhm_admin_upload_master : MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
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

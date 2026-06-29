using System;
using System.Web.Security;

namespace Learning_System.Bcs_Admin
{
    public partial class upload : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
        }

        // Change the name here to match exactly what is in your .Master file
        protected void LinkOut_Click(object sender, EventArgs e)
        {
            Session.Abandon();
            Session.Clear();
            FormsAuthentication.SignOut();
            Response.Redirect("~/Default.aspx");
        }
    }
}
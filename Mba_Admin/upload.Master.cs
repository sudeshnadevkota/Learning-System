using System;
using System.Web;
using System.Web.UI;

namespace Learning_System.Mba_Admin
{
    public partial class upload : MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
        }

        protected void LinkOut_Click(object sender, EventArgs e)
        {
            Session.Clear();
            Session.Abandon();
            Response.Redirect("~/Default.aspx");
        }
    }
}

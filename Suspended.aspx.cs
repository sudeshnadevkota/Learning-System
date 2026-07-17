using System;

namespace Learning_System
{
    public partial class Suspended : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
        }

        protected void lnkBackToLogin_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/login.aspx");
        }
    }
}
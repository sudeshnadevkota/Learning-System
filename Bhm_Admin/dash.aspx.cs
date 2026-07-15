using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Learning_System.Bhm_Admin
{
    public partial class upload : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Your code here
        }
        protected void LinkOut_Click(object sender, EventArgs e)
        {
            // 1. Clear the session data
            Session.Clear();
            Session.Abandon();

            // 2. Redirect the user back to the login page
            // Change "Login.aspx" to whatever your actual login page filename is
            Response.Redirect("~/Login.aspx");
        }
    }
}
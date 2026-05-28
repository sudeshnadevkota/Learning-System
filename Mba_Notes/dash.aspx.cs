using System;
using System.Web.UI;

namespace Learning_System.Mba_Notes
{
    public partial class dash : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Code to be executed on page load
        }

        protected void btnHome_Click(object sender, EventArgs e)
        {
            // Redirect to the home page
            Response.Redirect("~/Default.aspx");
        }
    }
}

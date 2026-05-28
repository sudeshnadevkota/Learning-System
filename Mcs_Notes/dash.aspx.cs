using System;
using System.Web.UI;

namespace Learning_System.Mcs_Notes
{
    public partial class dash : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Any necessary code for page load
        }

        protected void btnHome_Click(object sender, EventArgs e)
        {
            // Redirect to the home page
            Response.Redirect("~/Default.aspx");
        }
    }
}

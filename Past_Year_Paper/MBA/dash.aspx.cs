using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Learning_System.Past_Year_Paper.MBA
{
    public partial class dash : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void btnHome_Click(object sender, EventArgs e)
        {
            // Redirect to the home page
            Response.Redirect("~/Default.aspx");
        }
    }
}
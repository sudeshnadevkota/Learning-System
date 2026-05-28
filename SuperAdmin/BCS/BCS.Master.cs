using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Learning_System.SuperAdmin.BCS
{
    public partial class BCS : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void Linklogin_Click(object sender, EventArgs e)
        {
            Response.Redirect("../../Default.aspx");
        }
    }
}
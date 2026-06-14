using System;
// Remove: using System.Web.UI;  — not needed
// Remove: using Learning_System; — you're a sub-namespace, no need

namespace Learning_System.Bit_Notes
{
    public partial class business_english : BasePage  // simplified
    {
        protected override string TableName => "bit_1_BE";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
                BindData(GridViewNotes, GridViewPapers);
        }
    }
}
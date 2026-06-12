using System;
using System.Web.UI;
using Learning_System;

namespace Learning_System.Bit_Notes
{
    public partial class math_i : Learning_System.BasePage
    {
        // Just change this string to match your Math database table
        protected override string TableName => "bit_1_Math";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindData(GridViewNotes, GridViewPapers);
            }
        }
    }
}
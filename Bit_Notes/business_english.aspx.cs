using System;

namespace Learning_System.Bit_Notes
{
    public partial class business_english : BasePage
    {
        protected override string TableName => "bit_1_BE";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
                BindData(GridViewNotes, GridViewPapers);
        }
    }
}
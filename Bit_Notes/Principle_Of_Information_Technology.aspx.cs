using System;

namespace Learning_System.Bit_Notes
{
    public partial class Principle_Of_Information_Technology : BasePage
    {
        protected override string TableName => "bit_1_PIT";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
                BindData(GridViewNotes, GridViewPapers);
        }
    }
}
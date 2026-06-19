using System;

namespace Learning_System.Bit_Notes
{
    public partial class Computer_Related_Mathematics_And_Statistics : BasePage
    {
        protected override string TableName => "bit_1_Math";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
                BindData(GridViewNotes, GridViewPapers);
        }
    }
}
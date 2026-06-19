using System;

namespace Learning_System.Bit_Notes
{
    public partial class Introduction_To_C_Programming : BasePage
    {
        protected override string TableName => "bit_1_ICP";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
                BindData(GridViewNotes, GridViewPapers);
        }
    }
}
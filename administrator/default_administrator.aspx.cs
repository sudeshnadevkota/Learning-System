using System;

namespace Learning_System.administrator
{
    public partial class default_administrator :
        System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Session check
                if (Session["id"] == null)
                {
                    Response.Redirect("../login.aspx");
                }

                // Set username
                if (Session["full_name"] != null)
                {
                    lblUserName.Text =
                        Session["full_name"].ToString();
                }
                else
                {
                    lblUserName.Text = "Administrator";
                }
            }
        }
    }
}
using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;
using Learning_System.Common;

namespace Learning_System.MainAdmin
{
    public partial class SuperAdminManageControl : System.Web.UI.UserControl, IDynamicSection
    {
        protected string constr = ConfigurationManager.ConnectionStrings["conn"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            // Referenced the parent Page instance for authorization check
            PermissionHelper.RequireAccessLevel(this.Page, "MainAdmin");

            // Data loading moved to LoadInitialData() — IsPostBack can't be trusted here,
            // since the sidebar click that creates this control is itself a postback.
        }

        // Called by BaseAdminMaster.LoadSection() right after this control is
        // freshly added to the page.
        public void LoadInitialData()
        {
            LoadSuperAdmins();
        }

        private void LoadSuperAdmins()
        {
            using (SqlConnection con = new SqlConnection(constr))
            {
                string sql = @"SELECT u.ProfileId, u.FullName, u.Email, u.IsActive
                                FROM AdminProfile a
                                JOIN UserProfile u ON u.ProfileId = a.ProfileId
                                WHERE a.AccessLevel = 'SuperAdmin'
                                ORDER BY u.FullName";

                using (SqlCommand cmd = new SqlCommand(sql, con))
                {
                    con.Open();
                    using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                    {
                        DataTable dt = new DataTable();
                        da.Fill(dt);
                        gvSuperAdmins.DataSource = dt;
                        gvSuperAdmins.DataBind();
                    }
                }
            }
        }

        private void ShowSuccess(string message)
        {
            phError.Visible = false;
            phSuccess.Visible = true;
            litSuccess.Text = message;
        }

        private void ShowError(string message)
        {
            phSuccess.Visible = false;
            phError.Visible = true;
            litError.Text = message;
        }

        protected void gvSuperAdmins_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType != DataControlRowType.DataRow) return;

            DataRowView row = (DataRowView)e.Row.DataItem;
            int rowProfileId = Convert.ToInt32(row["ProfileId"]);

            if (Session["ProfileId"] != null && Convert.ToInt32(Session["ProfileId"]) == rowProfileId)
            {
                var youBadge = e.Row.FindControl("litYouBadge") as System.Web.UI.WebControls.Literal;
                if (youBadge != null) youBadge.Visible = true;
            }
        }

        protected void gvSuperAdmins_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            int profileId;
            if (!int.TryParse(e.CommandArgument as string, out profileId)) return;

            bool isSelf = Session["ProfileId"] != null && Convert.ToInt32(Session["ProfileId"]) == profileId;

            if (e.CommandName == "ToggleActive")
            {
                if (isSelf)
                {
                    ShowError("You can't suspend the account you're currently logged in as.");
                    LoadSuperAdmins();
                    return;
                }

                using (SqlConnection con = new SqlConnection(constr))
                {
                    using (SqlCommand cmd = new SqlCommand("UPDATE UserProfile SET IsActive = ~IsActive WHERE ProfileId = @Id", con))
                    {
                        cmd.Parameters.AddWithValue("@Id", profileId);
                        con.Open();
                        cmd.ExecuteNonQuery();
                    }
                }
                ShowSuccess("Status updated.");
                LoadSuperAdmins();
            }
            else if (e.CommandName == "RemoveAdmin")
            {
                if (isSelf)
                {
                    ShowError("You can't remove the account you're currently logged in as.");
                    LoadSuperAdmins();
                    return;
                }

                using (SqlConnection con = new SqlConnection(constr))
                {
                    using (SqlCommand cmd = new SqlCommand("DELETE FROM AdminProfile WHERE ProfileId = @Id", con))
                    {
                        cmd.Parameters.AddWithValue("@Id", profileId);
                        con.Open();
                        cmd.ExecuteNonQuery();
                    }
                }
                ShowSuccess("Super Admin removed.");
                LoadSuperAdmins();
            }
        }
    }
}
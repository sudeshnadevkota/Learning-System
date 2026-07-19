using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;

namespace Learning_System.MainAdmin
{
    public partial class SuperAdminManage : System.Web.UI.Page
    {
        protected string constr = ConfigurationManager.ConnectionStrings["conn"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            // Only MainAdmin may manage Super Admins — a SuperAdmin cannot appoint,
            // suspend, or remove another SuperAdmin (see PermissionHelper.GetAppointableRoles).
            PermissionHelper.RequireAccessLevel(this, "MainAdmin");

            if (!IsPostBack)
            {
                LoadSuperAdmins();
            }
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
                using (SqlCommand cmd = new SqlCommand(
                    "UPDATE UserProfile SET IsActive = ~IsActive WHERE ProfileId = @Id", con))
                {
                    cmd.Parameters.AddWithValue("@Id", profileId);
                    con.Open();
                    cmd.ExecuteNonQuery();
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
                using (SqlCommand cmd = new SqlCommand(
                    "DELETE FROM AdminProfile WHERE ProfileId = @Id", con))
                {
                    cmd.Parameters.AddWithValue("@Id", profileId);
                    con.Open();
                    cmd.ExecuteNonQuery();
                }
                // NOTE: this removes the AdminProfile row (their SuperAdmin appointment)
                // but leaves the underlying UserProfile row in place, same as the
                // original lnkRemove_Click behavior. Their account still exists but
                // has no AccessLevel, so login.aspx.cs's "Admin" branch will show
                // "Your account role is invalid" if they try to sign in.
                ShowSuccess("Super Admin removed.");
                LoadSuperAdmins();
            }
        }
    }
}
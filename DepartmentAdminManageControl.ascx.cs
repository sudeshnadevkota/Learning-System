using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;
using Learning_System.Common;

namespace Learning_System
{
    public partial class DepartmentAdminManageControl : System.Web.UI.UserControl, IDynamicSection
    {
        protected string constr = ConfigurationManager.ConnectionStrings["conn"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            // Note: Since this is now a UserControl, ensure your PermissionHelper can accept 
            // 'UserControl' or use 'this.Page' if it strictly evaluates standard Page components.
            PermissionHelper.RequireAccessLevel(this.Page, "MainAdmin", "SuperAdmin");

            // Data loading moved to LoadInitialData() — IsPostBack can't be trusted here,
            // since the sidebar click that creates this control is itself a postback.
        }

        // Called by BaseAdminMaster.LoadSection() right after this control is
        // freshly added to the page.
        public void LoadInitialData()
        {
            LoadDepartmentsDropdown();
            LoadAdmins();
        }

        private void LoadDepartmentsDropdown()
        {
            using (SqlConnection con = new SqlConnection(constr))
            using (SqlCommand cmd = new SqlCommand("SELECT DepartmentId, DepartmentName FROM Department ORDER BY DepartmentName", con))
            {
                con.Open();
                using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                {
                    DataTable dt = new DataTable();
                    da.Fill(dt);
                    ddlDepartment.DataSource = dt;
                    ddlDepartment.DataBind();
                }
            }
        }

        private void LoadAdmins()
        {
            using (SqlConnection con = new SqlConnection(constr))
            {
                string sql = @"SELECT
                                    u.ProfileId,
                                    u.UserName AS Username,
                                    d.DepartmentName,
                                    d.DepartmentCode,
                                    u.IsActive
                                FROM AdminProfile a
                                JOIN UserProfile u ON u.ProfileId = a.ProfileId
                                JOIN Department d ON d.DepartmentId = a.DepartmentId
                                WHERE a.AccessLevel = 'DepartmentAdmin'
                                ORDER BY u.UserName";

                using (SqlCommand cmd = new SqlCommand(sql, con))
                {
                    con.Open();
                    using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                    {
                        DataTable dt = new DataTable();
                        da.Fill(dt);
                        gvAdmins.DataSource = dt;
                        gvAdmins.DataBind();
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

        protected void gvAdmins_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            int profileId;
            if (!int.TryParse(e.CommandArgument as string, out profileId)) return;

            if (e.CommandName == "EditAdmin")
            {
                using (SqlConnection con = new SqlConnection(constr))
                using (SqlCommand cmd = new SqlCommand(@"
                    SELECT u.Username, a.DepartmentId
                    FROM AdminProfile a
                    JOIN UserProfile u ON u.ProfileId = a.ProfileId
                    WHERE a.ProfileId = @Id", con))
                {
                    cmd.Parameters.AddWithValue("@Id", profileId);
                    con.Open();
                    using (SqlDataReader rdr = cmd.ExecuteReader())
                    {
                        if (rdr.Read())
                        {
                            hfProfileId.Value = profileId.ToString();
                            litEditingName.Text = rdr["Username"].ToString();
                            ddlDepartment.SelectedValue = rdr["DepartmentId"].ToString();
                            pnlEdit.Visible = true;
                        }
                    }
                }
                phSuccess.Visible = false;
                phError.Visible = false;
                LoadAdmins();
            }
            else if (e.CommandName == "ToggleActive")
            {
                if (Session["ProfileId"] != null && Convert.ToInt32(Session["ProfileId"]) == profileId)
                {
                    ShowError("You can't deactivate the account you're currently logged in as.");
                    LoadAdmins();
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
                LoadAdmins();
            }
        }

        protected void btnSaveEdit_Click(object sender, EventArgs e)
        {
            int profileId;
            if (!int.TryParse(hfProfileId.Value, out profileId))
            {
                ShowError("Could not determine which admin to update.");
                LoadAdmins();
                return;
            }

            int deptId;
            if (!int.TryParse(ddlDepartment.SelectedValue, out deptId))
            {
                ShowError("Please choose a valid department.");
                LoadAdmins();
                return;
            }

            using (SqlConnection con = new SqlConnection(constr))
            using (SqlCommand cmd = new SqlCommand(
                "UPDATE AdminProfile SET DepartmentId = @DeptId WHERE ProfileId = @Id", con))
            {
                cmd.Parameters.AddWithValue("@DeptId", deptId);
                cmd.Parameters.AddWithValue("@Id", profileId);
                con.Open();
                cmd.ExecuteNonQuery();
            }

            pnlEdit.Visible = false;
            ShowSuccess("Department admin updated.");
            LoadAdmins();
        }

        protected void btnCancelEdit_Click(object sender, EventArgs e)
        {
            pnlEdit.Visible = false;
            phSuccess.Visible = false;
            phError.Visible = false;
            LoadAdmins();
        }
    }
}
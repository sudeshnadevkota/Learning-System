<%@ Page Title="" Language="C#" MasterPageFile="~/Bit_Admin/upload.Master" AutoEventWireup="true" CodeBehind="dash.aspx.cs" Inherits="Learning_System.Bit_Admin.dash" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

<style>
    :root {
        --primary: #0B1F66;
        --secondary: #081547;
        --pink: #FF2D8D;
        --pink-light: rgba(255,45,141,0.08);
        --gray-bg: #fafbff;
        --border-color: rgba(11,31,102,0.08);
        --text-muted: #6b7280;
        --success: #16a34a;
        --success-bg: #f0fdf4;
        --danger: #dc2626;
        --danger-bg: #fef2f2;
        --icon-blue-bg: rgba(11,31,102,0.09); --icon-blue: #0B1F66;
        --icon-rose-bg: rgba(255,45,141,0.1); --icon-rose: #FF2D8D;
        --icon-purple-bg: rgba(124,58,237,0.1); --icon-purple: #7c3aed;
        --icon-amber-bg: rgba(217,119,6,0.12); --icon-amber: #d97706;
    }

    * { box-sizing: border-box; }
    .dd-wrap { font-family: 'Plus Jakarta Sans', sans-serif; padding: 28px 34px 12px; }

    /* ── Hero ── */
    .dd-hero {
        background: linear-gradient(135deg, #0B1F66 0%, #1a3499 100%);
        padding: 30px 34px; border-radius: 18px; margin-bottom: 24px; color: #fff;
        position: relative; overflow: hidden;
    }
    .dd-hero-tag {
        display: inline-flex; align-items: center; gap: 6px; font-size: 10.5px; letter-spacing: 1.5px;
        color: var(--pink); background: rgba(255,45,141,0.12); border: 1px solid rgba(255,45,141,0.25);
        border-radius: 20px; padding: 4px 14px; text-transform: uppercase; margin-bottom: 12px;
    }
    .dd-hero h1 { font-size: 24px; font-weight: 800; margin: 0 0 6px; letter-spacing: -0.3px; }
    .dd-hero p { font-size: 13px; color: rgba(255,255,255,0.6); margin: 0; }

    /* ── Stat cards ── */
    .dd-stats-grid { display: grid; grid-template-columns: repeat(auto-fit, minmax(190px, 1fr)); gap: 16px; margin-bottom: 24px; }
    .dd-stat-card {
        position: relative; background: #fff; border: 1px solid var(--border-color); border-radius: 16px;
        padding: 22px; display: flex; align-items: center; gap: 14px;
        transition: transform 0.2s ease, box-shadow 0.2s ease;
    }
    .dd-stat-card:hover { transform: translateY(-3px); box-shadow: 0 14px 30px -8px rgba(11,31,102,0.14); }
    .dd-stat-icon {
        width: 46px; height: 46px; border-radius: 13px; display: flex; align-items: center;
        justify-content: center; font-size: 1.3rem; flex: none;
    }
    .dd-stat-icon.blue { background: var(--icon-blue-bg); color: var(--icon-blue); }
    .dd-stat-icon.rose { background: var(--icon-rose-bg); color: var(--icon-rose); }
    .dd-stat-value { font-size: 1.55rem; font-weight: 800; color: var(--primary); line-height: 1.1; }
    .dd-stat-label { font-size: 11px; color: var(--text-muted); font-weight: 700; text-transform: uppercase; letter-spacing: 0.5px; margin-top: 2px; }

    /* ── Panel ── */
    .dd-panel { background: #fff; border: 1px solid var(--border-color); border-radius: 16px; padding: 26px; margin-bottom: 24px; }
    .dd-panel-header {
        display: flex; align-items: center; justify-content: space-between; margin-bottom: 20px;
        padding-bottom: 14px; border-bottom: 1px solid var(--border-color); flex-wrap: wrap; gap: 10px;
    }
    .dd-panel-title {
        font-size: 11.5px; letter-spacing: 1.5px; color: var(--primary); text-transform: uppercase;
        font-weight: 800; display: flex; align-items: center; gap: 10px;
    }
    .dd-panel-title-icon {
        width: 28px; height: 28px; border-radius: 8px; background: var(--pink-light); color: var(--pink);
        display: flex; align-items: center; justify-content: center; font-size: 0.9rem;
    }

    /* ── Quick action tiles (admin-only) ── */
    .dd-quick-grid { display: grid; grid-template-columns: repeat(auto-fit, minmax(200px, 1fr)); gap: 14px; }
    .dd-quick-link {
        display: flex; flex-direction: column; gap: 12px; padding: 18px; border-radius: 14px;
        border: 1px solid var(--border-color); background: var(--gray-bg); text-decoration: none;
        color: var(--primary); transition: transform 0.18s ease, box-shadow 0.18s ease, background 0.18s ease;
    }
    .dd-quick-link:hover { background: #fff; transform: translateY(-3px); box-shadow: 0 12px 26px -8px rgba(11,31,102,0.14); color: var(--primary); }
    .dd-quick-icon {
        width: 40px; height: 40px; border-radius: 11px; display: flex; align-items: center; justify-content: center; font-size: 1.1rem;
    }
    .dd-quick-icon.blue { background: var(--icon-blue-bg); color: var(--icon-blue); }
    .dd-quick-icon.rose { background: var(--icon-rose-bg); color: var(--icon-rose); }
    .dd-quick-icon.purple { background: var(--icon-purple-bg); color: var(--icon-purple); }
    .dd-quick-icon.amber { background: var(--icon-amber-bg); color: var(--icon-amber); }
    .dd-quick-title { font-size: 13.5px; font-weight: 700; }
    .dd-quick-text { font-size: 12px; color: var(--text-muted); line-height: 1.5; margin: 0; }

    /* ── Table ── */
    .dd-table-container { overflow: hidden; border-radius: 12px; border: 1px solid var(--border-color); }
    .table-modern { width: 100%; border-collapse: collapse; font-size: 13px; }
    .table-modern th {
        background: var(--gray-bg); color: var(--primary); font-weight: 700; font-size: 11px;
        text-transform: uppercase; letter-spacing: 0.6px; padding: 13px 18px; text-align: left;
        border-bottom: 1px solid var(--border-color);
    }
    .table-modern td { padding: 13px 18px; border-bottom: 1px solid var(--border-color); color: #4a4a4a; }
    .table-modern tr:last-child td { border-bottom: none; }
    .table-modern tr:hover { background-color: var(--gray-bg); }
    .table-modern td:first-child { font-weight: 700; color: var(--primary); }

    .dd-status-pill {
        display: inline-flex; align-items: center; padding: 3px 10px; border-radius: 50px;
        font-weight: 700; font-size: 11px;
    }
    .dd-status-active { background: var(--success-bg); color: var(--success); }
    .dd-status-suspended { background: var(--danger-bg); color: var(--danger); }

    .table-modern a {
        color: var(--pink); text-decoration: none; font-weight: 700; margin-right: 12px; font-size: 12px;
    }
    .table-modern a:hover { text-decoration: underline; }

    @media (max-width: 900px) {
        .dd-wrap { padding: 18px 16px 8px; }
        .dd-stats-grid { grid-template-columns: 1fr 1fr; }
    }
</style>

<div class="dd-wrap">

    <!-- Hero -->
    <div class="dd-hero">
        <div class="dd-hero-tag"><i class="ti ti-layout-dashboard" style="font-size:11px;"></i> Department Dashboard</div>
        <h1>Welcome to BIT Upload Section</h1>
        <p>Manage and publish your e-learning content from one place</p>
    </div>

    <!-- Roster stat cards -->
    <div class="dd-stats-grid">
        <asp:Panel ID="pnlStaffCountBox" runat="server" CssClass="dd-stat-card">
            <div class="dd-stat-icon blue"><i class="ti ti-user-check"></i></div>
            <div>
                <div class="dd-stat-value"><asp:Literal ID="litStaffCount" runat="server">0</asp:Literal></div>
                <div class="dd-stat-label">Staff</div>
            </div>
        </asp:Panel>
        <div class="dd-stat-card">
            <div class="dd-stat-icon rose"><i class="ti ti-users"></i></div>
            <div>
                <div class="dd-stat-value"><asp:Literal ID="litStudentCount" runat="server">0</asp:Literal></div>
                <div class="dd-stat-label">Students</div>
            </div>
        </div>
    </div>

    <!-- Admin-only quick actions (visibility controlled server-side, same as before) -->
    <asp:Panel ID="pnlAdminControls" runat="server">
        <div class="dd-panel">
            <div class="dd-panel-header">
                <div class="dd-panel-title"><span class="dd-panel-title-icon"><i class="ti ti-bolt"></i></span> Administrative Controls</div>
            </div>
            <div class="dd-quick-grid">
                <a href="/administrator/AppointUser.aspx" class="dd-quick-link">
                    <div class="dd-quick-icon blue"><i class="ti ti-user-plus"></i></div>
                    <div class="dd-quick-title">Register Staff</div>
                    <p class="dd-quick-text">Register new teachers and staff for this department.</p>
                </a>
                <a href="RegisterStudent.aspx" class="dd-quick-link">
                    <div class="dd-quick-icon rose"><i class="ti ti-users-plus"></i></div>
                    <div class="dd-quick-title">Register Student</div>
                    <p class="dd-quick-text">Add and manage student registrations.</p>
                </a>
    <a href="/StaffManage.aspx" class="dd-quick-link">
        <div class="dd-quick-icon amber"><i class="ti ti-user-cog"></i></div>
        <div class="dd-quick-title">Manage Teachers</div>
        <p class="dd-quick-text">Manage teacher accounts and assignments.</p>
    </a>
    <a href="/StudentManage.aspx" class="dd-quick-link">
        <div class="dd-quick-icon rose"><i class="ti ti-users-plus"></i></div>
        <div class="dd-quick-title">Manage Students</div>
        <p class="dd-quick-text">Manage Students.</p>
    </a>
    <a href="/NoticeManage.aspx" class="dd-quick-link">
        <div class="dd-quick-icon blue"><i class="ti ti-speakerphone"></i></div>
        <div class="dd-quick-title">Notices</div>
        <p class="dd-quick-text">Publish notices for students and teachers.</p>
    </a>
                <a href="Reports.aspx" class="dd-quick-link">
                    <div class="dd-quick-icon rose"><i class="ti ti-chart-bar"></i></div>
                    <div class="dd-quick-title">Reports</div>
                    <p class="dd-quick-text">View department reports and activity.</p>
                </a>
                <a href="DepartmentSettings.aspx" class="dd-quick-link">
                    <div class="dd-quick-icon purple"><i class="ti ti-settings"></i></div>
                    <div class="dd-quick-title">Department Settings</div>
                    <p class="dd-quick-text">Configure department info and preferences.</p>
                </a>
            </div>
        </div>
    </asp:Panel>

    <!-- Staff roster — visible/bound for DepartmentAdmin only, removed server-side for Staff -->
    <asp:Panel ID="pnlStaffRoster" runat="server" CssClass="dd-panel">
        <div class="dd-panel-header">
            <div class="dd-panel-title"><span class="dd-panel-title-icon"><i class="ti ti-user-cog"></i></span> Staff</div>
        </div>
        <div class="dd-table-container">
            <asp:GridView ID="gvStaff" runat="server"
                AutoGenerateColumns="False"
                DataKeyNames="ProfileId,IsActive"
                CssClass="table-modern"
                GridLines="None" BorderWidth="0" CellPadding="0"
                OnRowCommand="gvStaff_RowCommand"
                EmptyDataText="No staff in your department yet.">
                <Columns>
                    <asp:BoundField DataField="FullName" HeaderText="Name" />
                    <asp:BoundField DataField="UserName" HeaderText="Username" />
                    <asp:TemplateField HeaderText="Status">
                        <ItemTemplate>
                            <span class='dd-status-pill <%# (bool)Eval("IsActive") ? "dd-status-active" : "dd-status-suspended" %>'>
                                <%# (bool)Eval("IsActive") ? "Active" : "Suspended" %>
                            </span>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Actions">
                        <ItemTemplate>
                            <asp:LinkButton runat="server" CommandName="ToggleSuspend"
                                OnClientClick='<%# "return confirm(\x27" + (((bool)Eval("IsActive")) ? "Suspend this staff member?" : "Reinstate this staff member?") + "\x27);" %>'>
                                <%# (bool)Eval("IsActive") ? "Suspend" : "Reinstate" %>
                            </asp:LinkButton>
                            <asp:LinkButton runat="server" CommandName="Delete"
                                OnClientClick="return confirm('Permanently remove this staff member? This cannot be undone.');">
                                Remove
                            </asp:LinkButton>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
        </div>
    </asp:Panel>

    <!-- Student roster — visible to both DepartmentAdmin and Staff -->
    <div class="dd-panel">
        <div class="dd-panel-header">
            <div class="dd-panel-title"><span class="dd-panel-title-icon"><i class="ti ti-users"></i></span> Students</div>
        </div>
        <div class="dd-table-container">
            <asp:GridView ID="gvStudents" runat="server"
                AutoGenerateColumns="False"
                DataKeyNames="ProfileId,IsActive"
                CssClass="table-modern"
                GridLines="None" BorderWidth="0" CellPadding="0"
                OnRowCommand="gvStudents_RowCommand"
                EmptyDataText="No students in your department yet.">
                <Columns>
                    <asp:BoundField DataField="FullName" HeaderText="Name" />
                    <asp:BoundField DataField="UserName" HeaderText="Username" />
                    <asp:TemplateField HeaderText="Status">
                        <ItemTemplate>
                            <span class='dd-status-pill <%# (bool)Eval("IsActive") ? "dd-status-active" : "dd-status-suspended" %>'>
                                <%# (bool)Eval("IsActive") ? "Active" : "Suspended" %>
                            </span>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Actions">
                        <ItemTemplate>
                            <asp:LinkButton runat="server" CommandName="ToggleSuspend"
                                OnClientClick='<%# "return confirm(\x27" + (((bool)Eval("IsActive")) ? "Suspend this student?" : "Reinstate this student?") + "\x27);" %>'>
                                <%# (bool)Eval("IsActive") ? "Suspend" : "Reinstate" %>
                            </asp:LinkButton>
                            <asp:LinkButton runat="server" CommandName="Delete"
                                OnClientClick="return confirm('Permanently remove this student? This cannot be undone.');">
                                Remove
                            </asp:LinkButton>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
        </div>
    </div>

</div>

</asp:Content>
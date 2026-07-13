<%@ Page Title="Main Admin" Language="C#" AutoEventWireup="true" CodeFile="main_admin.aspx.cs" Inherits="Learning_System.MainAdmin.main_admin" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Main Admin Dashboard</title>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />

    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700&display=swap" />
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/@tabler/icons-webfont@latest/tabler-icons.min.css" />

    <style>
        :root {
            --primary: #0B1F66;
            --secondary: #081547;
            --pink: #FF2D8D;
            --pink-light: rgba(255,45,141,0.08);
            --pink-hover: #e0277c;
            --gray-bg: #fafbff;
            --border-color: rgba(11,31,102,0.08);
            --text-muted: #6b7280;
            --success: #16a34a;
            --success-bg: #f0fdf4;
            --success-border: #4ade80;
            --danger: #dc2626;
            --danger-bg: #fef2f2;
        }

        * { box-sizing: border-box; }

        body {
            font-family: 'Plus Jakarta Sans', sans-serif;
            background: var(--gray-bg);
            margin: 0;
        }

        .c-wrap {
            padding: 1.5rem 2rem 3rem;
            max-width: 1400px;
            margin: 0 auto;
        }

        /* ── Hero ── */
        .c-hero {
            background: linear-gradient(135deg, #0B1F66 0%, #1a3499 100%);
            padding: 28px 32px;
            border-radius: 16px;
            margin-bottom: 24px;
            color: #fff;
            display: flex;
            align-items: center;
            justify-content: space-between;
            flex-wrap: wrap;
            gap: 16px;
        }

        .c-hero h3 {
            margin: 0 0 4px;
            font-size: 1.25rem;
            font-weight: 700;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .c-hero p {
            margin: 0;
            font-size: 13px;
            color: rgba(255,255,255,0.7);
        }

        .c-hero-actions {
            display: flex;
            gap: 10px;
            flex-wrap: wrap;
        }

        .c-hero-btn {
            display: inline-flex;
            align-items: center;
            gap: 7px;
            padding: 10px 20px;
            border-radius: 10px;
            font-size: 13px;
            font-weight: 700;
            font-family: 'Plus Jakarta Sans', sans-serif;
            cursor: pointer;
            border: none;
            text-decoration: none;
            transition: transform 0.18s ease, box-shadow 0.18s ease, background 0.18s ease;
            letter-spacing: 0.3px;
        }

        .c-hero-btn:hover {
            transform: translateY(-2px) scale(1.03);
            box-shadow: 0 6px 20px rgba(0,0,0,0.22);
        }

        .c-hero-btn-outline {
            background: rgba(255,255,255,0.15);
            color: #fff;
            border: 1.5px solid rgba(255,255,255,0.35);
            backdrop-filter: blur(4px);
        }

        .c-hero-btn-outline:hover { background: rgba(255,255,255,0.25); color: #fff; }

        .c-hero-btn-pink {
            background: var(--pink);
            color: #fff;
            box-shadow: 0 3px 12px rgba(255,45,141,0.35);
        }

        .c-hero-btn-pink:hover { background: var(--pink-hover); color: #fff; }

        /* ── Stat Cards ── */
        .c-stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(190px, 1fr));
            gap: 16px;
            margin-bottom: 24px;
        }

        .c-stat-card {
            background: #fff;
            border: 1px solid var(--border-color);
            border-radius: 14px;
            padding: 20px 22px;
            display: flex;
            align-items: center;
            gap: 14px;
            transition: transform 0.18s ease, box-shadow 0.18s ease;
        }

        .c-stat-card:hover {
            transform: translateY(-3px);
            box-shadow: 0 10px 24px rgba(11,31,102,0.08);
        }

        .c-stat-icon {
            width: 46px;
            height: 46px;
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.3rem;
            flex: none;
            background: var(--pink-light);
            color: var(--pink);
        }

        .c-stat-icon.blue { background: rgba(11,31,102,0.08); color: var(--primary); }

        .c-stat-value {
            font-size: 1.5rem;
            font-weight: 700;
            color: var(--primary);
            line-height: 1.1;
        }

        .c-stat-label {
            font-size: 11.5px;
            color: var(--text-muted);
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 0.4px;
        }

        /* ── Panel ── */
        .c-panel {
            background: #ffffff;
            border: 1px solid var(--border-color);
            border-radius: 14px;
            padding: 28px;
            margin-bottom: 24px;
        }

        .c-panel-header {
            display: flex;
            align-items: center;
            justify-content: space-between;
            margin-bottom: 20px;
            flex-wrap: wrap;
            gap: 10px;
        }

        .c-panel-title {
            font-size: 11px;
            letter-spacing: 1.5px;
            color: var(--primary);
            text-transform: uppercase;
            font-weight: 700;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        /* ── Table ── */
        .c-table-container {
            overflow: hidden;
            border-radius: 12px;
            border: 1px solid var(--border-color);
        }

        .table-modern {
            width: 100%;
            border-collapse: collapse;
            font-size: 13px;
        }

        .table-modern th {
            background: var(--gray-bg);
            color: var(--primary);
            font-weight: 700;
            padding: 14px 18px;
            text-align: left;
            border-bottom: 2px solid var(--border-color);
        }

        .table-modern td {
            padding: 12px 18px;
            border-bottom: 1px solid var(--border-color);
            color: #4a4a4a;
        }

        .table-modern tr:last-child td { border-bottom: none; }
        .table-modern tr:hover { background-color: #fcfcfd; }

        .table-modern a {
            color: var(--pink);
            text-decoration: none;
            font-weight: 600;
            margin-right: 10px;
            font-size: 12.5px;
        }

        .table-modern a:hover { text-decoration: underline; }

        .table-modern a.danger { color: var(--danger); }

        .role-badge {
            display: inline-block;
            padding: 3px 10px;
            border-radius: 6px;
            font-size: 11px;
            font-weight: 700;
            background: var(--pink-light);
            color: var(--pink);
        }

        /* ── Quick Actions ── */
        .c-quick-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 14px;
        }

        .c-quick-link {
            display: flex;
            align-items: center;
            gap: 12px;
            padding: 16px 18px;
            border-radius: 12px;
            border: 1px solid var(--border-color);
            background: var(--gray-bg);
            text-decoration: none;
            color: var(--primary);
            font-weight: 600;
            font-size: 13.5px;
            transition: transform 0.18s ease, box-shadow 0.18s ease, background 0.18s ease;
        }

        .c-quick-link:hover {
            background: #fff;
            transform: translateY(-2px);
            box-shadow: 0 8px 20px rgba(11,31,102,0.08);
            color: var(--primary);
        }

        .c-quick-link i { font-size: 1.3rem; color: var(--pink); }

        .empty-note {
            padding: 20px;
            text-align: center;
            color: var(--text-muted);
            font-size: 13px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="c-wrap">

            <!-- Hero -->
            <div class="c-hero">
                <div>
                    <h3><i class="ti ti-crown"></i> Main Admin Dashboard</h3>
                    <p>Logged in as <strong><%= Session["Username"] %></strong> &middot; Full system access</p>
                </div>
                <div class="c-hero-actions">
                    <a href="/administrator/AppointUser.aspx" class="c-hero-btn c-hero-btn-outline">
    <i class="ti ti-user-plus"></i> Appoint User
</a>
                    <a href="logout.aspx" class="c-hero-btn c-hero-btn-pink">
                        <i class="ti ti-logout"></i> Logout
                    </a>
                </div>
            </div>

            <!-- Stat Cards -->
            <div class="c-stats-grid">
                <div class="c-stat-card">
                    <div class="c-stat-icon blue"><i class="ti ti-building"></i></div>
                    <div>
                        <div class="c-stat-value"><asp:Literal ID="litDeptCount" runat="server">0</asp:Literal></div>
                        <div class="c-stat-label">Departments</div>
                    </div>
                </div>
                <div class="c-stat-card">
                    <div class="c-stat-icon"><i class="ti ti-shield-star"></i></div>
                    <div>
                        <div class="c-stat-value"><asp:Literal ID="litSuperAdminCount" runat="server">0</asp:Literal></div>
                        <div class="c-stat-label">Super Admins</div>
                    </div>
                </div>
                <div class="c-stat-card">
                    <div class="c-stat-icon blue"><i class="ti ti-user-cog"></i></div>
                    <div>
                        <div class="c-stat-value"><asp:Literal ID="litDeptAdminCount" runat="server">0</asp:Literal></div>
                        <div class="c-stat-label">Dept Admins</div>
                    </div>
                </div>
                <div class="c-stat-card">
                    <div class="c-stat-icon"><i class="ti ti-user-check"></i></div>
                    <div>
                        <div class="c-stat-value"><asp:Literal ID="litStaffCount" runat="server">0</asp:Literal></div>
                        <div class="c-stat-label">Staff</div>
                    </div>
                </div>
                <div class="c-stat-card">
                    <div class="c-stat-icon blue"><i class="ti ti-users"></i></div>
                    <div>
                        <div class="c-stat-value"><asp:Literal ID="litStudentCount" runat="server">0</asp:Literal></div>
                        <div class="c-stat-label">Students</div>
                    </div>
                </div>
                <div class="c-stat-card">
                    <div class="c-stat-icon"><i class="ti ti-book-2"></i></div>
                    <div>
                        <div class="c-stat-value"><asp:Literal ID="litSubjectCount" runat="server">0</asp:Literal></div>
                        <div class="c-stat-label">Subjects</div>
                    </div>
                </div>
            </div>

            <!-- Admin Hierarchy -->
            <div class="c-panel">
                <div class="c-panel-header">
                    <div class="c-panel-title"><i class="ti ti-hierarchy-3"></i> Super Admin Management</div>
                   <a href="/administrator/AppointUser.aspx?role=SuperAdmin" class="c-hero-btn c-hero-btn-pink" style="padding:8px 18px;font-size:12px;">
    <i class="ti ti-plus"></i> Appoint SuperAdmin
</a>
                </div>
                <div class="c-table-container">
                    <asp:GridView ID="gvSuperAdmins" runat="server"
                        AutoGenerateColumns="False"
                        class="table-modern"
                        GridLines="None" BorderWidth="0" CellPadding="0"
                        EmptyDataText="No SuperAdmins appointed yet.">
                        <Columns>
                            <asp:BoundField DataField="FullName" HeaderText="Name" />
                            <asp:BoundField DataField="Email" HeaderText="Email" />
                            <asp:TemplateField HeaderText="Role">
                                <ItemTemplate><span class="role-badge">SuperAdmin</span></ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Action">
                                <ItemTemplate>
                                    <asp:LinkButton ID="lnkSuspend" runat="server" Text="Suspend"
    CommandArgument='<%# Eval("AdminProfileId") %>'
    OnClick="lnkSuspend_Click"></asp:LinkButton>
<asp:LinkButton ID="lnkRemove" runat="server" Text="Remove" CssClass="danger"
    CommandArgument='<%# Eval("AdminProfileId") %>'
    OnClick="lnkRemove_Click"
    OnClientClick="return confirm('Remove this SuperAdmin? This cannot be undone.');"></asp:LinkButton>
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>
                </div>
            </div>

            <!-- Department Overview -->
            <div class="c-panel">
                <div class="c-panel-header">
                    <div class="c-panel-title"><i class="ti ti-building-community"></i> Department Overview</div>
                </div>
                <div class="c-table-container">
                    <asp:GridView ID="gvDepartments" runat="server"
                        AutoGenerateColumns="False"
                        class="table-modern"
                        GridLines="None" BorderWidth="0" CellPadding="0"
                        EmptyDataText="No departments found.">
                        <Columns>
                            <asp:BoundField DataField="DepartmentName" HeaderText="Department" />
                            <asp:BoundField DataField="DepartmentCode" HeaderText="Code" />
                            <asp:BoundField DataField="DeptAdminCount" HeaderText="Dept Admins" />
                            <asp:BoundField DataField="StaffCount" HeaderText="Staff" />
                            <asp:BoundField DataField="StudentCount" HeaderText="Students" />
                        </Columns>
                    </asp:GridView>
                </div>
            </div>

            <!-- Quick Actions -->
            <div class="c-panel">
                <div class="c-panel-header">
                    <div class="c-panel-title"><i class="ti ti-bolt"></i> Quick Actions</div>
                </div>
                <div class="c-quick-grid">
                    <a href="AppointUser.aspx" class="c-quick-link">
                        <i class="ti ti-user-plus"></i> Appoint User
                    </a>
                    <a href="/NoticeManage.aspx" class="c-quick-link">
                        <i class="ti ti-speakerphone"></i> Manage Notices
                    </a>
                    <a href="ManageDepartments.aspx" class="c-quick-link">
                        <i class="ti ti-building"></i> Manage Departments
                    </a>
                    <a href="AuditLog.aspx" class="c-quick-link">
                        <i class="ti ti-history"></i> Audit Log
                    </a>
                </div>
            </div>

        </div>
    </form>
</body>
</html>
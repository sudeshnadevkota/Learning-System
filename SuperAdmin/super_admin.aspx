<%@ Page Title="Super Admin" Language="C#" AutoEventWireup="true" CodeBehind="super_admin.aspx.cs" Inherits="Learning_System.SuperAdmin.super_admin" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Super Admin Dashboard</title>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />

    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800&display=swap" />
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

            /* stat / quick-action icon accents */
            --icon-blue-bg: rgba(11,31,102,0.09);
            --icon-blue: #0B1F66;
            --icon-rose-bg: rgba(255,45,141,0.1);
            --icon-rose: #FF2D8D;
            --icon-purple-bg: rgba(124,58,237,0.1);
            --icon-purple: #7c3aed;
            --icon-amber-bg: rgba(217,119,6,0.12);
            --icon-amber: #d97706;

            --sidebar-w: 246px;
        }

        * { box-sizing: border-box; }

        html, body {
            font-family: 'Plus Jakarta Sans', sans-serif;
            background: var(--gray-bg);
            background-image:
                radial-gradient(circle at 100% 0%, rgba(11,31,102,0.035) 0%, transparent 45%),
                radial-gradient(circle at 0% 100%, rgba(255,45,141,0.03) 0%, transparent 40%);
            background-attachment: fixed;
            margin: 0;
            overflow-x: hidden;
        }

        @media (prefers-reduced-motion: no-preference) {
            .c-fade-up { animation: cFadeUp 0.5s cubic-bezier(0.16, 1, 0.3, 1) both; }
            @keyframes cFadeUp {
                from { opacity: 0; transform: translateY(10px); }
                to { opacity: 1; transform: translateY(0); }
            }
        }

        /* ── Shell ── */
        .c-shell { display: flex; min-height: 100vh; }

        /* ── Sidebar ── */
        .c-sidebar {
            width: var(--sidebar-w);
            flex: none;
            background: linear-gradient(180deg, var(--primary) 0%, var(--secondary) 100%);
            color: #fff;
            display: flex;
            flex-direction: column;
            padding: 22px 16px;
            position: sticky;
            top: 0;
            height: 100vh;
            overflow: hidden;
        }

        /* Watermark logo, matching the Bit_Notes sidebar treatment */
        .c-sidebar::after {
            content: '';
            position: absolute;
            bottom: -10px;
            left: -20px;
            width: 320px;
            height: 320px;
            background: url('../Bit_Notes/logo/sidebar-removebg-preview.png') no-repeat center/contain;
            opacity: 0.35;
            pointer-events: none;
            z-index: 0;
        }

        /* Keep real sidebar content above the watermark */
        .c-sidebar > * {
            position: relative;
            z-index: 1;
        }

        .c-brand {
            display: flex;
            align-items: center;
            gap: 12px;
            padding: 6px 8px 24px;
        }

        .c-brand-badge {
            width: 38px;
            height: 38px;
            border-radius: 11px;
            background: linear-gradient(155deg, rgba(255,255,255,0.24), rgba(255,255,255,0.06));
            border: 1px solid rgba(255,255,255,0.25);
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.1rem;
            flex: none;
        }

        .c-brand span {
            font-weight: 800;
            font-size: 15px;
            letter-spacing: -0.2px;
        }

        .c-nav { display: flex; flex-direction: column; gap: 3px; margin-bottom: 22px; }

        .c-nav-link {
            display: flex;
            align-items: center;
            gap: 12px;
            padding: 10px 12px;
            border-radius: 10px;
            color: rgba(255,255,255,0.72);
            text-decoration: none;
            font-weight: 600;
            font-size: 13.5px;
            transition: background 0.15s ease, color 0.15s ease;
        }

        .c-nav-link i { font-size: 1.05rem; width: 20px; text-align: center; }

        .c-nav-link:hover { background: rgba(255,255,255,0.08); color: #fff; }

        .c-nav-link.active {
            background: rgba(255,255,255,0.14);
            color: #fff;
            box-shadow: inset 3px 0 0 var(--pink);
        }

        .c-nav-eyebrow {
            font-size: 10.5px;
            font-weight: 800;
            letter-spacing: 1.2px;
            color: rgba(255,255,255,0.42);
            text-transform: uppercase;
            padding: 4px 12px 8px;
        }

        .c-sidebar-spacer { flex: 1; }

        .c-sidebar-user {
            display: flex;
            align-items: center;
            gap: 10px;
            padding: 12px;
            border-radius: 12px;
            background: rgba(255,255,255,0.06);
            border: 1px solid rgba(255,255,255,0.1);
        }

        .c-sidebar-avatar {
            width: 34px;
            height: 34px;
            border-radius: 50%;
            background: linear-gradient(135deg, var(--pink), #ff5aa5);
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: 800;
            font-size: 13px;
            flex: none;
        }

        .c-sidebar-user-name { font-size: 13px; font-weight: 700; line-height: 1.2; }
        .c-sidebar-user-role { font-size: 11px; color: rgba(255,255,255,0.55); }
        .c-sidebar-user i { margin-left: auto; color: rgba(255,255,255,0.5); font-size: 1rem; }

        /* ── Main ── */
        .c-main { flex: 1; min-width: 0; padding: 28px 34px 44px; }

        .c-topbar {
            position: relative;
            z-index: 1;
            display: flex;
            align-items: center;
            justify-content: space-between;
            gap: 16px;
            flex-wrap: wrap;
            margin-bottom: 26px;
        }

        .c-topbar h1 {
            margin: 0 0 4px;
            font-size: 1.55rem;
            font-weight: 800;
            color: var(--primary);
            letter-spacing: -0.3px;
        }

        .c-topbar p { margin: 0; font-size: 13px; color: var(--text-muted); }

        .c-topbar-actions { display: flex; align-items: center; gap: 12px; }

        .c-search {
            display: flex;
            align-items: center;
            gap: 8px;
            background: #fff;
            border: 1px solid var(--border-color);
            border-radius: 10px;
            padding: 9px 14px;
            font-size: 13px;
            color: var(--text-muted);
            min-width: 220px;
        }

        .c-search i { color: var(--text-muted); }

        .c-bell {
            position: relative;
            width: 38px;
            height: 38px;
            border-radius: 10px;
            background: #fff;
            border: 1px solid var(--border-color);
            display: flex;
            align-items: center;
            justify-content: center;
            color: var(--primary);
        }

        .c-bell::after {
            content: "";
            position: absolute;
            top: 8px;
            right: 9px;
            width: 7px;
            height: 7px;
            border-radius: 50%;
            background: var(--pink);
            border: 1.5px solid #fff;
        }

        .c-btn-pink {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            gap: 7px;
            padding: 10px 18px;
            border-radius: 10px;
            font-size: 13px;
            font-weight: 700;
            font-family: 'Plus Jakarta Sans', sans-serif;
            cursor: pointer;
            border: none;
            text-decoration: none;
            background: linear-gradient(135deg, var(--pink), #ff5aa5);
            color: #fff;
            box-shadow: 0 3px 12px rgba(255,45,141,0.4);
            transition: transform 0.18s ease, box-shadow 0.18s ease;
        }

        .c-btn-pink:hover { transform: translateY(-2px) scale(1.03); color: #fff; }

        /* ── Stat Cards ── */
        .c-stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(190px, 1fr));
            gap: 16px;
            margin-bottom: 24px;
        }

        .c-stat-card {
            position: relative;
            background: #fff;
            border: 1px solid var(--border-color);
            border-radius: 16px;
            padding: 22px 22px 20px;
            display: flex;
            align-items: center;
            gap: 14px;
            overflow: hidden;
            transition: transform 0.22s cubic-bezier(0.16, 1, 0.3, 1), box-shadow 0.22s ease, border-color 0.22s ease;
        }

        .c-stat-card::before {
            content: "";
            position: absolute;
            top: 0; left: 0; right: 0;
            height: 3px;
            background: linear-gradient(90deg, var(--primary), var(--pink));
            opacity: 0;
            transition: opacity 0.22s ease;
        }

        .c-stat-card::before {
            content: "";
            position: absolute;
            top: 0; left: 0; right: 0;
            height: 3px;
            background: linear-gradient(90deg, var(--primary), var(--pink));
            opacity: 0;
            transition: opacity 0.22s ease;
        }

        .c-stat-card:hover {
            transform: translateY(-4px);
            box-shadow: 0 16px 32px -8px rgba(11,31,102,0.14);
            border-color: transparent;
        }

        .c-stat-card:hover::before { opacity: 1; }

        .c-stat-icon {
            width: 48px;
            height: 48px;
            border-radius: 13px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.35rem;
            flex: none;
        }

        .c-stat-icon.blue   { background: var(--icon-blue-bg);   color: var(--icon-blue); }
        .c-stat-icon.rose   { background: var(--icon-rose-bg);   color: var(--icon-rose); }
        .c-stat-icon.purple { background: var(--icon-purple-bg); color: var(--icon-purple); }
        .c-stat-icon.amber  { background: var(--icon-amber-bg);  color: var(--icon-amber); }

        .c-stat-value {
            font-size: 1.65rem;
            font-weight: 800;
            color: var(--primary);
            line-height: 1.1;
            letter-spacing: -0.3px;
            font-variant-numeric: tabular-nums;
        }

        .c-stat-label {
            font-size: 11px;
            color: var(--text-muted);
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: 0.6px;
            margin-top: 2px;
        }

        /* ── Panel ── */
        .c-panel {
            background: #ffffff;
            border: 1px solid var(--border-color);
            border-radius: 16px;
            padding: 28px;
            margin-bottom: 24px;
            box-shadow: 0 1px 2px rgba(11,31,102,0.03);
        }

        .c-panel-header {
            display: flex;
            align-items: center;
            justify-content: space-between;
            margin-bottom: 22px;
            padding-bottom: 16px;
            border-bottom: 1px solid var(--border-color);
            flex-wrap: wrap;
            gap: 10px;
        }

        .c-panel-title {
            font-size: 11.5px;
            letter-spacing: 1.6px;
            color: var(--primary);
            text-transform: uppercase;
            font-weight: 800;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .c-panel-title-icon {
            width: 28px;
            height: 28px;
            border-radius: 8px;
            background: var(--pink-light);
            color: var(--pink);
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 0.95rem;
        }

        .c-view-all {
            display: inline-flex;
            align-items: center;
            gap: 4px;
            padding: 7px 14px;
            border-radius: 8px;
            border: 1px solid var(--border-color);
            background: #fff;
            color: var(--primary);
            font-size: 12.5px;
            font-weight: 700;
            text-decoration: none;
            transition: border-color 0.15s ease, color 0.15s ease;
        }

        .c-view-all:hover { border-color: var(--pink); color: var(--pink); }

        /* ── Table ── */
        .c-table-container {
            overflow: hidden;
            border-radius: 12px;
            border: 1px solid var(--border-color);
        }

        .table-modern { width: 100%; border-collapse: collapse; font-size: 13px; }

        .table-modern th {
            background: var(--gray-bg);
            color: var(--primary);
            font-weight: 700;
            font-size: 11px;
            text-transform: uppercase;
            letter-spacing: 0.6px;
            padding: 14px 18px;
            text-align: left;
            border-bottom: 1px solid var(--border-color);
        }

        .table-modern td {
            padding: 14px 18px;
            border-bottom: 1px solid var(--border-color);
            color: #4a4a4a;
            font-weight: 500;
        }

        .table-modern tr { transition: background-color 0.15s ease; }
        .table-modern tr:last-child td { border-bottom: none; }
        .table-modern tr:hover { background-color: var(--gray-bg); }
        .table-modern tbody tr { position: relative; }

        .table-modern tbody tr td:first-child {
            font-weight: 700;
            color: var(--primary);
            box-shadow: inset 3px 0 0 transparent;
            transition: box-shadow 0.15s ease;
        }

        .table-modern tbody tr:hover td:first-child { box-shadow: inset 3px 0 0 var(--pink); }

        /* ── Quick Actions ── */
        .c-quick-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(190px, 1fr));
            gap: 14px;
        }

        .c-quick-link {
            display: flex;
            flex-direction: column;
            gap: 14px;
            padding: 20px 18px;
            border-radius: 14px;
            border: 1px solid var(--border-color);
            background: var(--gray-bg);
            text-decoration: none;
            color: var(--primary);
            font-weight: 700;
            font-size: 13.5px;
            transition: transform 0.2s cubic-bezier(0.16, 1, 0.3, 1), box-shadow 0.2s ease, background 0.2s ease, border-color 0.2s ease;
        }

        .c-quick-link:hover {
            background: #fff;
            transform: translateY(-3px);
            box-shadow: 0 12px 28px -6px rgba(11,31,102,0.14);
            border-color: rgba(255,45,141,0.2);
            color: var(--primary);
        }

        .c-quick-link-icon {
            width: 42px;
            height: 42px;
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
            flex: none;
            font-size: 1.2rem;
        }

        .c-quick-link-icon.blue   { background: var(--icon-blue-bg);   color: var(--icon-blue); }
        .c-quick-link-icon.rose   { background: var(--icon-rose-bg);   color: var(--icon-rose); }
        .c-quick-link-icon.purple { background: var(--icon-purple-bg); color: var(--icon-purple); }
        .c-quick-link-icon.amber  { background: var(--icon-amber-bg);  color: var(--icon-amber); }

        /* ── Responsive ── */
        @media (max-width: 900px) {
            .c-shell { flex-direction: column; }
            .c-sidebar { width: 100%; height: auto; position: relative; flex-direction: row; flex-wrap: wrap; }
            .c-nav { flex-direction: row; flex-wrap: wrap; }
            .c-sidebar-spacer { display: none; }
            .c-sidebar-user { margin-top: 12px; }
            .c-main { padding: 22px 18px 36px; }
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="c-shell">

            <!-- Sidebar -->
            <aside class="c-sidebar">
                <div class="c-brand">
                    <div class="c-brand-badge"><i class="ti ti-shield-star"></i></div>
                    <span>Super Admin</span>
                </div>

                <nav class="c-nav">
                    <a href="super_admin.aspx" class="c-nav-link active"><i class="ti ti-layout-dashboard"></i> Dashboard</a>
                    <a href="DepartmentManage.aspx" class="c-nav-link"><i class="ti ti-building"></i> Departments</a>
                    <a href="DepartmentAdminManage.aspx" class="c-nav-link"><i class="ti ti-user-cog"></i> Department Admins</a>
                    <a href="StaffManage.aspx" class="c-nav-link"><i class="ti ti-user-check"></i> Staff</a>
                    <a href="StudentManage.aspx" class="c-nav-link"><i class="ti ti-users"></i> Students</a>
                    <a href="SubjectManage.aspx" class="c-nav-link"><i class="ti ti-book-2"></i> Subjects</a>
                </nav>

                <div class="c-nav-eyebrow">Quick Actions</div>
                <nav class="c-nav">
                    <a href="DepartmentManage.aspx" class="c-nav-link"><i class="ti ti-building"></i> Manage Departments</a>
                    <a href="/administrator/AppointUser.aspx" class="c-nav-link"><i class="ti ti-user-plus"></i> Manage Admins</a>
                    <a href="StaffManage.aspx" class="c-nav-link"><i class="ti ti-user-check"></i> Manage Staff</a>
                    <a href="SubjectManage.aspx" class="c-nav-link"><i class="ti ti-book-2"></i> Manage Subjects</a>
                </nav>

                <div class="c-sidebar-spacer"></div>

                <div class="c-sidebar-user">
                    <div class="c-sidebar-avatar">
                        <i class="ti ti-user"></i>
                    </div>
                    <div>
                        <div class="c-sidebar-user-name">Super Admin</div>
                        <div class="c-sidebar-user-role">Administrator</div>
                    </div>
                    <i class="ti ti-chevron-down"></i>
                </div>
            </aside>

            <!-- Main -->
            <main class="c-main">

                <div class="c-topbar c-fade-up">
                    <div>
                        <h1>Welcome back, Super Admin! 👋</h1>
                        <p>Logged in as <strong><%= Session["Username"] %></strong> &middot; System-wide access</p>
                    </div>
                    <div class="c-topbar-actions">
                        <div class="c-search"><i class="ti ti-search"></i> Search anything…</div>
                        <a class="c-bell" href="../NoticeManage.aspx"><i class="ti ti-bell"></i>
                            
                        </a>
                        <a href="../logout.aspx" class="c-btn-pink"><i class="ti ti-logout"></i> Logout</a>
                    </div>
                </div>

                <!-- Stat Cards -->
                <div class="c-stats-grid c-fade-up" style="animation-delay: 0.05s;">
                    <div class="c-stat-card">
                        <div class="c-stat-icon blue"><i class="ti ti-building"></i></div>
                        <div>
                            <div class="c-stat-value"><asp:Literal ID="litDeptCount" runat="server">0</asp:Literal></div>
                            <div class="c-stat-label">Departments</div>
                        </div>
                    </div>
                    <div class="c-stat-card">
                        <div class="c-stat-icon rose"><i class="ti ti-user-cog"></i></div>
                        <div>
                            <div class="c-stat-value"><asp:Literal ID="litDeptAdminCount" runat="server">0</asp:Literal></div>
                            <div class="c-stat-label">Dept Admins</div>
                        </div>
                    </div>
                    <div class="c-stat-card">
                        <div class="c-stat-icon purple"><i class="ti ti-user-check"></i></div>
                        <div>
                            <div class="c-stat-value"><asp:Literal ID="litStaffCount" runat="server">0</asp:Literal></div>
                            <div class="c-stat-label">Staff</div>
                        </div>
                    </div>
                    <div class="c-stat-card">
                        <div class="c-stat-icon rose"><i class="ti ti-users"></i></div>
                        <div>
                            <div class="c-stat-value"><asp:Literal ID="litStudentCount" runat="server">0</asp:Literal></div>
                            <div class="c-stat-label">Students</div>
                        </div>
                    </div>
                    <div class="c-stat-card">
                        <div class="c-stat-icon amber"><i class="ti ti-book-2"></i></div>
                        <div>
                            <div class="c-stat-value"><asp:Literal ID="litSubjectCount" runat="server">0</asp:Literal></div>
                            <div class="c-stat-label">Subjects</div>
                        </div>
                    </div>
                </div>

                <!-- Department Overview -->
                <div class="c-panel c-fade-up" style="animation-delay: 0.1s;">
                    <div class="c-panel-header">
                        <div class="c-panel-title">
                            <span class="c-panel-title-icon"><i class="ti ti-building-community"></i></span>
                            Department Overview
                        </div>
                        <a href="DepartmentManage.aspx" class="c-view-all">View All <i class="ti ti-chevron-right"></i></a>
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
                <div class="c-panel c-fade-up" style="animation-delay: 0.15s;">
                    <div class="c-panel-header">
                        <div class="c-panel-title">
                            <span class="c-panel-title-icon"><i class="ti ti-bolt"></i></span>
                            Quick Actions
                        </div>
                    </div>
                    <div class="c-quick-grid">
                        <a href="DepartmentManage.aspx" class="c-quick-link">
                            <span class="c-quick-link-icon blue"><i class="ti ti-building"></i></span>
                            Manage Departments
                        </a>
                        <a href="/administrator/AppointUser.aspx" class="c-quick-link">
                            <span class="c-quick-link-icon rose"><i class="ti ti-user-plus"></i></span>
                            Manage Admins
                        </a>
                        <a href="StaffManage.aspx" class="c-quick-link">
                            <span class="c-quick-link-icon purple"><i class="ti ti-user-check"></i></span>
                            Manage Staff
                        </a>
                        <a href="SubjectManage.aspx" class="c-quick-link">
                            <span class="c-quick-link-icon amber"><i class="ti ti-book-2"></i></span>
                            Manage Subjects
                        </a>
                    </div>
                </div>

            </main>
        </div>
    </form>
</body>
</html>

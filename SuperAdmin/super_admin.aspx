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
        }

        * { box-sizing: border-box; }

        body {
            font-family: 'Plus Jakarta Sans', sans-serif;
            background: var(--gray-bg);
            background-image:
                radial-gradient(circle at 100% 0%, rgba(11,31,102,0.035) 0%, transparent 45%),
                radial-gradient(circle at 0% 100%, rgba(255,45,141,0.03) 0%, transparent 40%);
            background-attachment: fixed;
            margin: 0;
        }

        .c-wrap {
            padding: 1.5rem 2rem 3rem;
            max-width: 1400px;
            margin: 0 auto;
        }

        @media (prefers-reduced-motion: no-preference) {
            .c-fade-up {
                animation: cFadeUp 0.5s cubic-bezier(0.16, 1, 0.3, 1) both;
            }
            @keyframes cFadeUp {
                from { opacity: 0; transform: translateY(10px); }
                to { opacity: 1; transform: translateY(0); }
            }
        }

        /* ── Hero ── */
        .c-hero {
            position: relative;
            background: linear-gradient(135deg, #0B1F66 0%, #142d82 55%, #1a3499 100%);
            padding: 32px 36px;
            border-radius: 20px;
            margin-bottom: 24px;
            color: #fff;
            display: flex;
            align-items: center;
            justify-content: space-between;
            flex-wrap: wrap;
            gap: 16px;
            box-shadow: 0 20px 40px -12px rgba(11,31,102,0.45);
            overflow: hidden;
        }

        .c-hero::before {
            content: "";
            position: absolute;
            inset: 0;
            background-image: radial-gradient(rgba(255,255,255,0.09) 1px, transparent 1px);
            background-size: 22px 22px;
            mask-image: linear-gradient(135deg, rgba(0,0,0,0.9) 0%, transparent 65%);
            -webkit-mask-image: linear-gradient(135deg, rgba(0,0,0,0.9) 0%, transparent 65%);
            pointer-events: none;
        }

        .c-hero::after {
            content: "";
            position: absolute;
            top: -60%;
            right: -8%;
            width: 320px;
            height: 320px;
            background: radial-gradient(circle, rgba(255,45,141,0.35) 0%, transparent 70%);
            pointer-events: none;
        }

        .c-hero-left {
            position: relative;
            z-index: 1;
            display: flex;
            align-items: center;
            gap: 16px;
        }

        .c-hero-icon-badge {
            width: 52px;
            height: 52px;
            flex: none;
            border-radius: 14px;
            background: linear-gradient(155deg, rgba(255,255,255,0.22), rgba(255,255,255,0.06));
            border: 1px solid rgba(255,255,255,0.25);
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.4rem;
            backdrop-filter: blur(6px);
        }

        .c-hero h3 {
            margin: 0 0 4px;
            font-size: 1.35rem;
            font-weight: 800;
            letter-spacing: -0.2px;
        }

        .c-hero p {
            margin: 0;
            font-size: 13px;
            color: rgba(255,255,255,0.68);
        }

        .c-hero p strong {
            color: #fff;
            font-weight: 700;
        }

        .c-hero-actions {
            position: relative;
            z-index: 1;
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
            background: linear-gradient(135deg, var(--pink), #ff5aa5);
            color: #fff;
            box-shadow: 0 3px 12px rgba(255,45,141,0.4);
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
            background: linear-gradient(155deg, var(--pink-light), rgba(255,45,141,0.14));
            color: var(--pink);
            box-shadow: inset 0 0 0 1px rgba(255,45,141,0.12);
        }

        .c-stat-icon.blue {
            background: linear-gradient(155deg, rgba(11,31,102,0.07), rgba(11,31,102,0.13));
            color: var(--primary);
            box-shadow: inset 0 0 0 1px rgba(11,31,102,0.1);
        }

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

        .table-modern tr {
            transition: background-color 0.15s ease;
        }

        .table-modern tr:last-child td { border-bottom: none; }

        .table-modern tr:hover {
            background-color: var(--gray-bg);
        }

        .table-modern tbody tr {
            position: relative;
        }

        .table-modern tbody tr td:first-child {
            font-weight: 700;
            color: var(--primary);
            box-shadow: inset 3px 0 0 transparent;
            transition: box-shadow 0.15s ease;
        }

        .table-modern tbody tr:hover td:first-child {
            box-shadow: inset 3px 0 0 var(--pink);
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
            gap: 14px;
            padding: 16px 18px;
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
            width: 38px;
            height: 38px;
            border-radius: 10px;
            background: var(--pink-light);
            display: flex;
            align-items: center;
            justify-content: center;
            flex: none;
            transition: background 0.2s ease, transform 0.2s ease;
        }

        .c-quick-link:hover .c-quick-link-icon {
            background: var(--pink);
            transform: scale(1.05);
        }

        .c-quick-link i { font-size: 1.15rem; color: var(--pink); transition: color 0.2s ease; }
        .c-quick-link:hover i { color: #fff; }

        .c-quick-link-arrow {
            margin-left: auto;
            color: var(--text-muted);
            font-size: 1rem;
            opacity: 0;
            transform: translateX(-4px);
            transition: opacity 0.2s ease, transform 0.2s ease;
        }

        .c-quick-link:hover .c-quick-link-arrow {
            opacity: 1;
            transform: translateX(0);
            color: var(--pink);
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="c-wrap">

            <!-- Hero -->
            <div class="c-hero c-fade-up">
                <div class="c-hero-left">
                    <div class="c-hero-icon-badge"><i class="ti ti-shield-star"></i></div>
                    <div>
                        <h3>Super Admin Dashboard</h3>
                        <p>Logged in as <strong><%= Session["Username"] %></strong> &middot; System-wide access</p>
                    </div>
                </div>
                <div class="c-hero-actions">
                    <a href="/administrator/AppointUser.aspx" class="c-hero-btn c-hero-btn-outline">
                        <i class="ti ti-user-plus"></i> Appoint User
                    </a>
                    <a href="../logout.aspx" class="c-hero-btn c-hero-btn-pink">
                        <i class="ti ti-logout"></i> Logout
                    </a>
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
                    <div class="c-stat-icon"><i class="ti ti-user-cog"></i></div>
                    <div>
                        <div class="c-stat-value"><asp:Literal ID="litDeptAdminCount" runat="server">0</asp:Literal></div>
                        <div class="c-stat-label">Dept Admins</div>
                    </div>
                </div>
                <div class="c-stat-card">
                    <div class="c-stat-icon blue"><i class="ti ti-user-check"></i></div>
                    <div>
                        <div class="c-stat-value"><asp:Literal ID="litStaffCount" runat="server">0</asp:Literal></div>
                        <div class="c-stat-label">Staff</div>
                    </div>
                </div>
                <div class="c-stat-card">
                    <div class="c-stat-icon"><i class="ti ti-users"></i></div>
                    <div>
                        <div class="c-stat-value"><asp:Literal ID="litStudentCount" runat="server">0</asp:Literal></div>
                        <div class="c-stat-label">Students</div>
                    </div>
                </div>
                <div class="c-stat-card">
                    <div class="c-stat-icon blue"><i class="ti ti-book-2"></i></div>
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
                    <a href="/administrator/AppointUser.aspx" class="c-quick-link">
                        <span class="c-quick-link-icon"><i class="ti ti-user-plus"></i></span>
                        Appoint User
                        <i class="ti ti-chevron-right c-quick-link-arrow"></i>
                    </a>
                    <a href="../NoticeManage.aspx" class="c-quick-link">
                        <span class="c-quick-link-icon"><i class="ti ti-speakerphone"></i></span>
                        Manage Notices
                        <i class="ti ti-chevron-right c-quick-link-arrow"></i>
                    </a>
                </div>
            </div>

        </div>
    </form>
</body>
</html>
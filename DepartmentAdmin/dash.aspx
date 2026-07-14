<%@ Page Title="Department Admin" Language="C#" AutoEventWireup="true" CodeBehind="dash.aspx.cs" Inherits="Learning_System.DepartmentAdmin.dash" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Department Admin Dashboard</title>
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

        /* ── Badge ── */
        .dept-badge {
            background: var(--pink);
            color: #white;
            padding: 4px 10px;
            border-radius: 6px;
            font-size: 12px;
            font-weight: 700;
            display: inline-block;
        }

        /* ── Stat Cards ── */
        .c-stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(220px, 1fr));
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
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="c-wrap">

            <div class="c-hero">
                <div>
                    <h3>
                        <i class="ti ti-building-community"></i> 
                        <asp:Literal ID="litDeptTitle" runat="server">Department</asp:Literal> Administration Portal
                    </h3>
                    <p>Logged in as <strong><%= Session["Username"] %></strong> &middot; Department-bounded access control rule active</p>
                </div>
                <div class="c-hero-actions">
                    <a href="../logout.aspx" class="c-hero-btn c-hero-btn-pink">
                        <i class="ti ti-logout"></i> Logout
                    </a>
                </div>
            </div>

            <div class="c-stats-grid">
                <div class="c-stat-card">
                    <div class="c-stat-icon blue"><i class="ti ti-user-check"></i></div>
                    <div>
                        <div class="c-stat-value"><asp:Literal ID="litStaffCount" runat="server">0</asp:Literal></div>
                        <div class="c-stat-label">Department Staff</div>
                    </div>
                </div>
                <div class="c-stat-card">
                    <div class="c-stat-icon"><i class="ti ti-users"></i></div>
                    <div>
                        <div class="c-stat-value"><asp:Literal ID="litStudentCount" runat="server">0</asp:Literal></div>
                        <div class="c-stat-label">Enrolled Students</div>
                    </div>
                </div>
                <div class="c-stat-card">
                    <div class="c-stat-icon blue"><i class="ti ti-speakerphone"></i></div>
                    <div>
                        <div class="c-stat-value"><asp:Literal ID="litNoticeCount" runat="server">0</asp:Literal></div>
                        <div class="c-stat-label">Department Notices</div>
                    </div>
                </div>
            </div>

            <div class="c-panel">
                <div class="c-panel-header">
                    <div class="c-panel-title"><i class="ti ti-users-group"></i> Active Student Roster</div>
                </div>
                <div class="c-table-container">
                    <asp:GridView ID="gvStudents" runat="server"
                        AutoGenerateColumns="False"
                        class="table-modern"
                        GridLines="None" BorderWidth="0" CellPadding="0"
                        EmptyDataText="No students registered under your department.">
                        <Columns>
                            <asp:BoundField DataField="FullName" HeaderText="Name" />
                            <asp:BoundField DataField="UserName" HeaderText="Username/Roll" />
                            <asp:BoundField DataField="Semester" HeaderText="Semester" />
                            <asp:BoundField DataField="Email" HeaderText="Email Address" />
                        </Columns>
                    </asp:GridView>
                </div>
            </div>

            <div class="c-panel">
                <div class="c-panel-header">
                    <div class="c-panel-title"><i class="ti ti-bolt"></i> Department Actions</div>
                </div>
                <div class="c-quick-grid">
                    <a href="../AppointUser.aspx" class="c-quick-link">
                        <i class="ti ti-user-plus"></i> Add Faculty / Staff
                    </a>
                    <a href="../NoticeManage.aspx" class="c-quick-link">
                        <i class="ti ti-speakerphone"></i> Push Department Notice
                    </a>
                </div>
            </div>

        </div>
    </form>
</body>
</html>
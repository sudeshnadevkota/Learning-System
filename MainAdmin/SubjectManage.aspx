<%@ Page Title="Subjects" Language="C#" AutoEventWireup="true" CodeBehind="SubjectManage.aspx.cs" Inherits="Learning_System.SuperAdmin.SubjectManage" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Subjects</title>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />

    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800&display=swap" />
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/@tabler/icons-webfont@latest/tabler-icons.min.css" />

    <style>
        :root {
            --primary: #0B1F66; --secondary: #081547; --pink: #FF2D8D;
            --pink-light: rgba(255,45,141,0.08); --pink-hover: #e0277c; --gray-bg: #fafbff;
            --border-color: rgba(11,31,102,0.08); --text-muted: #6b7280;
            --success: #16a34a; --success-bg: #f0fdf4; --success-border: #4ade80;
            --danger: #dc2626; --danger-bg: #fef2f2; --danger-border: #fca5a5;
            --icon-blue-bg: rgba(11,31,102,0.09); --icon-blue: #0B1F66;
            --icon-rose-bg: rgba(255,45,141,0.1); --icon-rose: #FF2D8D;
            --icon-purple-bg: rgba(124,58,237,0.1); --icon-purple: #7c3aed;
            --icon-amber-bg: rgba(217,119,6,0.12); --icon-amber: #d97706;
            --sidebar-w: 246px;
        }

        * { box-sizing: border-box; }
        html, body { font-family: 'Plus Jakarta Sans', sans-serif; background: var(--gray-bg); margin: 0; }

        @media (prefers-reduced-motion: no-preference) {
            .c-fade-up { animation: cFadeUp 0.5s cubic-bezier(0.16, 1, 0.3, 1) both; }
            @keyframes cFadeUp { from { opacity: 0; transform: translateY(10px); } to { opacity: 1; transform: translateY(0); } }
        }

        .c-shell { display: flex; min-height: 100vh; }

        .c-sidebar {
            width: var(--sidebar-w); flex: none;
            background: linear-gradient(180deg, var(--primary) 0%, var(--secondary) 100%);
            color: #fff; display: flex; flex-direction: column; padding: 22px 16px;
            position: sticky; top: 0; height: 100vh; overflow: hidden;
        }

        .c-sidebar::after {
            content: ''; position: absolute; bottom: -10px; left: -20px; width: 320px; height: 320px;
            background: url('../Bit_Notes/logo/sidebar-removebg-preview.png') no-repeat center/contain;
            opacity: 0.35; pointer-events: none; z-index: 0;
        }

        .c-sidebar > * { position: relative; z-index: 1; }

        .c-brand { display: flex; align-items: center; gap: 12px; padding: 6px 8px 24px; }
        .c-brand-badge {
            width: 38px; height: 38px; border-radius: 11px;
            background: linear-gradient(155deg, rgba(255,255,255,0.24), rgba(255,255,255,0.06));
            border: 1px solid rgba(255,255,255,0.25);
            display: flex; align-items: center; justify-content: center; font-size: 1.1rem; flex: none;
        }
        .c-brand span { font-weight: 800; font-size: 15px; letter-spacing: -0.2px; }

        .c-nav { display: flex; flex-direction: column; gap: 3px; margin-bottom: 22px; }
        .c-nav-link {
            display: flex; align-items: center; gap: 12px; padding: 10px 12px; border-radius: 10px;
            color: rgba(255,255,255,0.72); text-decoration: none; font-weight: 600; font-size: 13.5px;
            transition: background 0.15s ease, color 0.15s ease;
        }
        .c-nav-link i { font-size: 1.05rem; width: 20px; text-align: center; }
        .c-nav-link:hover { background: rgba(255,255,255,0.08); color: #fff; }
        .c-nav-link.active { background: rgba(255,255,255,0.14); color: #fff; box-shadow: inset 3px 0 0 var(--pink); }

        .c-nav-eyebrow {
            font-size: 10.5px; font-weight: 800; letter-spacing: 1.2px;
            color: rgba(255,255,255,0.42); text-transform: uppercase; padding: 4px 12px 8px;
        }

        .c-sidebar-spacer { flex: 1; }
        .c-sidebar-user {
            display: flex; align-items: center; gap: 10px; padding: 12px; border-radius: 12px;
            background: rgba(255,255,255,0.06); border: 1px solid rgba(255,255,255,0.1);
        }
        .c-sidebar-avatar {
            width: 34px; height: 34px; border-radius: 50%;
            background: linear-gradient(135deg, var(--pink), #ff5aa5);
            display: flex; align-items: center; justify-content: center; font-weight: 800; font-size: 13px; flex: none;
        }
        .c-sidebar-user-name { font-size: 13px; font-weight: 700; line-height: 1.2; }
        .c-sidebar-user-role { font-size: 11px; color: rgba(255,255,255,0.55); }
        .c-sidebar-user i { margin-left: auto; color: rgba(255,255,255,0.5); font-size: 1rem; }

        .c-main { flex: 1; min-width: 0; padding: 28px 34px 44px; }
        .c-topbar { display: flex; align-items: center; justify-content: space-between; gap: 16px; flex-wrap: wrap; margin-bottom: 26px; }
        .c-topbar h1 { margin: 0 0 4px; font-size: 1.55rem; font-weight: 800; color: var(--primary); letter-spacing: -0.3px; }
        .c-topbar p { margin: 0; font-size: 13px; color: var(--text-muted); }

        .c-btn-ghost {
            display: inline-flex; align-items: center; gap: 7px; padding: 10px 18px; border-radius: 10px;
            font-size: 13px; font-weight: 700; font-family: 'Plus Jakarta Sans', sans-serif; cursor: pointer;
            background: #fff; color: var(--primary); border: 1px solid var(--border-color);
            transition: border-color 0.15s ease, color 0.15s ease;
        }
        .c-btn-ghost:hover { border-color: var(--pink); color: var(--pink); }

        .c-note {
            display: flex; align-items: flex-start; gap: 10px; padding: 13px 16px; border-radius: 12px;
            font-size: 12.5px; font-weight: 500; margin-bottom: 22px;
            background: var(--icon-amber-bg); color: #92620a; border: 1px solid rgba(217,119,6,0.25);
        }
        .c-note i { font-size: 15px; margin-top: 1px; flex: none; }

        .c-dept-panel {
            background: #ffffff; border: 1px solid var(--border-color); border-radius: 16px;
            padding: 26px 28px; margin-bottom: 20px; box-shadow: 0 1px 2px rgba(11,31,102,0.03);
        }

        .c-dept-header {
            display: flex; align-items: center; justify-content: space-between;
            margin-bottom: 18px; padding-bottom: 14px; border-bottom: 1px solid var(--border-color); flex-wrap: wrap; gap: 8px;
        }

        .c-dept-title { display: flex; align-items: center; gap: 12px; }

        .c-dept-icon {
            width: 38px; height: 38px; border-radius: 11px; background: var(--icon-blue-bg); color: var(--icon-blue);
            display: flex; align-items: center; justify-content: center; font-size: 1.1rem; flex: none;
        }

        .c-dept-name { font-size: 15px; font-weight: 800; color: var(--primary); }
        .c-dept-code { font-size: 11.5px; color: var(--text-muted); font-weight: 600; }

        .c-dept-count { font-size: 12px; font-weight: 700; color: var(--pink); background: var(--pink-light); padding: 4px 12px; border-radius: 50px; }

        .c-sem-block { margin-bottom: 14px; }
        .c-sem-block:last-child { margin-bottom: 0; }

        .c-sem-label {
            font-size: 10.5px; font-weight: 800; letter-spacing: 1.1px; color: var(--text-muted);
            text-transform: uppercase; margin-bottom: 8px; display: flex; align-items: center; gap: 8px;
        }

        .c-sem-badge {
            width: 20px; height: 20px; border-radius: 6px; background: var(--icon-purple-bg); color: var(--icon-purple);
            display: inline-flex; align-items: center; justify-content: center; font-size: 10.5px; font-weight: 800;
        }

        .c-subject-grid { display: grid; grid-template-columns: repeat(auto-fill, minmax(230px, 1fr)); gap: 10px; }

        .c-subject-chip {
            display: flex; flex-direction: column; gap: 3px; padding: 11px 14px; border-radius: 10px;
            background: var(--gray-bg); border: 1px solid var(--border-color);
        }

        .c-subject-title { font-size: 12.5px; font-weight: 700; color: var(--primary); line-height: 1.3; }
        .c-subject-meta { font-size: 10.5px; color: var(--text-muted); font-family: monospace; }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="c-shell">

            <aside class="c-sidebar">
                <div class="c-brand">
                    <div class="c-brand-badge"><i class="ti ti-shield-star"></i></div>
                    <span>Super Admin</span>
                </div>

                <nav class="c-nav">
                    <a href="super_admin.aspx" class="c-nav-link"><i class="ti ti-layout-dashboard"></i> Dashboard</a>
                    <a href="DepartmentManage.aspx" class="c-nav-link"><i class="ti ti-building"></i> Departments</a>
                    <a href="DepartmentAdminManage.aspx" class="c-nav-link"><i class="ti ti-user-cog"></i> Department Admins</a>
                    <a href="StaffManage.aspx" class="c-nav-link"><i class="ti ti-user-check"></i> Staff</a>
                    <a href="StudentManage.aspx" class="c-nav-link"><i class="ti ti-users"></i> Students</a>
                    <a href="SubjectManage.aspx" class="c-nav-link active"><i class="ti ti-book-2"></i> Subjects</a>
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
                    <div class="c-sidebar-avatar"><i class="ti ti-user"></i></div>
                    <div>
                        <div class="c-sidebar-user-name">Super Admin</div>
                        <div class="c-sidebar-user-role">Administrator</div>
                    </div>
                    <i class="ti ti-chevron-down"></i>
                </div>
            </aside>

            <main class="c-main">

                <div class="c-topbar c-fade-up">
                    <div>
                        <h1>Subjects</h1>
                        <p>Read-only view, sourced from SubjectMap.cs and grouped by department and semester.</p>
                    </div>
                    <div>
                        <a href="super_admin.aspx" class="c-btn-ghost"><i class="ti ti-arrow-left"></i> Back to Dashboard</a>
                    </div>
                </div>

                <div class="c-note c-fade-up">
                    <i class="ti ti-info-circle"></i>
                    <div>Subjects are defined in code (<strong>SubjectMap.cs</strong>), not in a database table, so this page is read-only. Adding, renaming, or removing a subject means editing that file — and usually creating a matching content table — then redeploying.</div>
                </div>

                <asp:Repeater ID="rptDepartments" runat="server">
                    <ItemTemplate>
                        <div class="c-dept-panel c-fade-up">
                            <div class="c-dept-header">
                                <div class="c-dept-title">
                                    <div class="c-dept-icon"><i class="ti ti-building"></i></div>
                                    <div>
                                        <div class="c-dept-name"><%# Eval("DepartmentName") %></div>
                                        <div class="c-dept-code"><%# Eval("DepartmentCode") %></div>
                                    </div>
                                </div>
                                <div class="c-dept-count"><%# Eval("SubjectCount") %> subjects</div>
                            </div>

                            <asp:Repeater ID="rptSemesters" runat="server" DataSource='<%# Eval("Semesters") %>'>
                                <ItemTemplate>
                                    <div class="c-sem-block">
                                        <div class="c-sem-label">
                                            <span class="c-sem-badge"><%# Eval("Semester") %></span>
                                            Semester <%# Eval("Semester") %>
                                        </div>
                                        <div class="c-subject-grid">
                                            <asp:Repeater ID="rptSubjects" runat="server" DataSource='<%# Eval("Subjects") %>'>
                                                <ItemTemplate>
                                                    <div class="c-subject-chip">
                                                        <span class="c-subject-title"><%# Eval("Title") %></span>
                                                        <span class="c-subject-meta"><%# Eval("Code") %> &middot; <%# Eval("Table") %></span>
                                                    </div>
                                                </ItemTemplate>
                                            </asp:Repeater>
                                        </div>
                                    </div>
                                </ItemTemplate>
                            </asp:Repeater>
                        </div>
                    </ItemTemplate>
                </asp:Repeater>

            </main>
        </div>
    </form>
</body>
</html>

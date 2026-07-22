<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="SubjectManage.ascx.cs" Inherits="Learning_System.SubjectManageControl" %>

<!-- 
  Shared variables, sidebar, topbar, and button styles now come from AdminStyles.css 
  via SuperAdmin.master. Only this control's own department/semester/subject-chip 
  layout and mobile tweaks live here.
-->
<style>
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

    @media (max-width: 640px) {
        .c-dept-panel { padding: 18px; border-radius: 14px; }
        .c-subject-grid { grid-template-columns: 1fr 1fr; gap: 8px; }
        .c-dept-header { gap: 6px; }
    }

    @media (max-width: 400px) {
        .c-subject-grid { grid-template-columns: 1fr; }
    }
</style>

<main class="c-main">

    <div class="c-topbar c-fade-up">
        <div>
            <h1>Subjects</h1>
            <p>Read-only view, sourced from SubjectMap.cs and grouped by department and semester.</p>
        </div>
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

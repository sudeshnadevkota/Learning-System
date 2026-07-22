<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="DepartmentManageControl.ascx.cs" Inherits="Learning_System.DepartmentManageControl" %>

<!-- 
  NOTE: All shared styles (variables, sidebar, topbar, panels, forms, tables, 
  responsive rules) now come from AdminStyles.css via SuperAdmin.master.
  This control only contains its own content-specific styles (form fields, 
  alerts, row actions, count pills) that aren't already defined there.
-->
<style>
    /* ── Alerts ── */
    .c-alert {
        display: flex; align-items: center; gap: 10px;
        padding: 13px 16px; border-radius: 12px; font-size: 13px; font-weight: 600;
        margin-bottom: 18px; border: 1px solid transparent;
    }

    .c-alert.success { background: var(--success-bg); border-color: var(--success-border); color: var(--success); }
    .c-alert.danger { background: var(--danger-bg); border-color: var(--danger-border, #fca5a5); color: var(--danger); }

    /* ── Form ── */
    .c-form-grid {
        display: grid; grid-template-columns: repeat(auto-fit, minmax(220px, 1fr));
        gap: 16px; margin-bottom: 18px;
    }

    .c-field label {
        display: block; font-size: 11.5px; font-weight: 700; color: var(--primary);
        text-transform: uppercase; letter-spacing: 0.5px; margin-bottom: 7px;
    }

    .c-field input[type=text] {
        width: 100%; padding: 11px 14px; border-radius: 10px; border: 1.5px solid var(--border-color);
        font-family: 'Plus Jakarta Sans', sans-serif; font-size: 13.5px; color: var(--primary);
        background: var(--gray-bg); transition: border-color 0.15s ease, background 0.15s ease;
    }

    .c-field input[type=text]:focus { outline: none; border-color: var(--pink); background: #fff; }

    .c-form-actions { display: flex; gap: 10px; flex-wrap: wrap; }

    /* ── Row actions / count pill (control-specific) ── */
    .c-row-actions { display: flex; gap: 8px; }

    .c-icon-btn {
        width: 32px; height: 32px; border-radius: 8px; border: 1px solid var(--border-color);
        background: #fff; display: inline-flex; align-items: center; justify-content: center;
        cursor: pointer; color: var(--primary); font-size: 14px; transition: all 0.15s ease;
    }

    .c-icon-btn:hover { border-color: var(--pink); color: var(--pink); }

    .c-count-pill {
        display: inline-flex; align-items: center; justify-content: center;
        min-width: 24px; padding: 2px 8px; border-radius: 50px;
        background: var(--icon-blue-bg); color: var(--icon-blue); font-weight: 700; font-size: 12px;
    }

    /* Mobile tweaks specific to this control's form/table */
    @media (max-width: 640px) {
        .c-form-actions .c-btn-pink,
        .c-form-actions .c-btn-ghost { flex: 1; justify-content: center; }
        .table-modern { min-width: 560px; }
    }
</style>

<main class="c-main">

    <div class="c-topbar c-fade-up">
        <div>
            <h1>Departments</h1>
            <p>Create, edit, and remove departments across the system.</p>
        </div>
    </div>

    <asp:PlaceHolder ID="phSuccess" runat="server" Visible="false">
        <div class="c-alert success"><i class="ti ti-circle-check"></i> <asp:Literal ID="litSuccess" runat="server" /></div>
    </asp:PlaceHolder>

    <asp:PlaceHolder ID="phError" runat="server" Visible="false">
        <div class="c-alert danger"><i class="ti ti-alert-circle"></i> <asp:Literal ID="litError" runat="server" /></div>
    </asp:PlaceHolder>

    <!-- Add / Edit Form -->
    <div class="c-panel c-fade-up" style="animation-delay: 0.05s;">
        <div class="c-panel-header">
            <div class="c-panel-title">
                <span class="c-panel-title-icon"><i class="ti ti-building-plus"></i></span>
                <asp:Literal ID="litFormTitle" runat="server" Text="Add Department" />
            </div>
        </div>

        <asp:HiddenField ID="hfDepartmentId" runat="server" Value="0" />

        <div class="c-form-grid">
            <div class="c-field">
                <label for="<%= txtDeptName.ClientID %>">Department Name</label>
                <asp:TextBox ID="txtDeptName" runat="server" CssClass="" TextMode="SingleLine" placeholder="e.g. Bachelor of Information Technology" />
            </div>
            <div class="c-field">
                <label for="<%= txtDeptCode.ClientID %>">Department Code</label>
                <asp:TextBox ID="txtDeptCode" runat="server" CssClass="" TextMode="SingleLine" placeholder="e.g. BIT" MaxLength="15" />
            </div>
        </div>

        <div class="c-form-actions">
            <asp:Button ID="btnSave" runat="server" Text="Save Department" CssClass="c-btn-pink" OnClick="btnSave_Click" />
            <asp:Button ID="btnCancel" runat="server" Text="Cancel" CssClass="c-btn-ghost" OnClick="btnCancel_Click" CausesValidation="false" />
        </div>
    </div>

    <!-- Department List -->
    <div class="c-panel c-fade-up" style="animation-delay: 0.1s;">
        <div class="c-panel-header">
            <div class="c-panel-title">
                <span class="c-panel-title-icon"><i class="ti ti-building-community"></i></span>
                All Departments
            </div>
        </div>
        <div class="c-table-container">
            <asp:GridView ID="gvDepartments" runat="server"
                AutoGenerateColumns="False"
                class="table-modern"
                GridLines="None" BorderWidth="0" CellPadding="0"
                DataKeyNames="DepartmentId"
                EmptyDataText="No departments found. Add one above to get started."
                OnRowCommand="gvDepartments_RowCommand">
                <Columns>
                    <asp:BoundField DataField="DepartmentName" HeaderText="Department" />
                    <asp:BoundField DataField="DepartmentCode" HeaderText="Code" />
                    <asp:TemplateField HeaderText="Dept Admins">
                        <ItemTemplate><span class="c-count-pill"><%# Eval("DeptAdminCount") %></span></ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Staff">
                        <ItemTemplate><span class="c-count-pill"><%# Eval("StaffCount") %></span></ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Students">
                        <ItemTemplate><span class="c-count-pill"><%# Eval("StudentCount") %></span></ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Actions">
                        <ItemTemplate>
                            <div class="c-row-actions">
                                <asp:LinkButton ID="lnkEdit" runat="server" CssClass="c-icon-btn" ToolTip="Edit"
                                    CommandName="EditDept" CommandArgument='<%# Eval("DepartmentId") %>'>
                                    <i class="ti ti-pencil"></i>
                                </asp:LinkButton>
                            </div>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
        </div>
    </div>

</main>

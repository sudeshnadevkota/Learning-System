<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="StudentManage.ascx.cs" Inherits="Learning_System.StudentManageControl" %>

<!-- 
  Shared variables, sidebar, topbar, panel, table, and button styles now come from 
  AdminStyles.css via SuperAdmin.master. Only this control's own status-pill styling 
  and mobile tweaks live here.
-->
<style>
    .c-status-pill {
        display: inline-flex; align-items: center; gap: 6px; padding: 4px 10px; border-radius: 50px;
        font-weight: 700; font-size: 11.5px;
    }
    .c-status-pill.active { background: var(--success-bg); color: var(--success); }
    .c-status-pill.inactive { background: var(--danger-bg); color: var(--danger); }

    @media (max-width: 640px) {
        .c-form-actions .c-btn-pink,
        .c-form-actions .c-btn-ghost { flex: 1; justify-content: center; }
        .c-topbar > div[style] .c-btn-pink { width: 100%; justify-content: center; }
        .table-modern { min-width: 660px; }
    }
</style>

<main class="c-main">
    <div class="c-topbar c-fade-up">
        <div>
            <h1>Students</h1>
            <p>Reassign department/semester, and activate or deactivate student accounts.</p>
        </div>
        <div style="display:flex; gap:10px;">
            <a href="/administrator/AppointUser.aspx" class="c-btn-pink"><i class="ti ti-user-plus"></i> Appoint New Student</a>
        </div>
    </div>

    <asp:PlaceHolder ID="phSuccess" runat="server" Visible="false">
        <div class="c-alert success"><i class="ti ti-circle-check"></i> <asp:Literal ID="litSuccess" runat="server" /></div>
    </asp:PlaceHolder>
    <asp:PlaceHolder ID="phError" runat="server" Visible="false">
        <div class="c-alert danger"><i class="ti ti-alert-circle"></i> <asp:Literal ID="litError" runat="server" /></div>
    </asp:PlaceHolder>

    <asp:Panel ID="pnlEdit" runat="server" CssClass="c-panel c-fade-up" Visible="false" style="animation-delay: 0.05s;">
        <div class="c-panel-header">
            <div class="c-panel-title">
                <span class="c-panel-title-icon"><i class="ti ti-users"></i></span>
                Edit Student — <asp:Literal ID="litEditingName" runat="server" />
            </div>
        </div>

        <asp:HiddenField ID="hfProfileId" runat="server" />

        <div class="c-form-grid">
            <div class="c-field">
                <label for="<%= ddlDepartment.ClientID %>">Department</label>
                <asp:DropDownList ID="ddlDepartment" runat="server" DataTextField="DepartmentName" DataValueField="DepartmentId" />
            </div>
            <div class="c-field">
                <label for="<%= ddlSemester.ClientID %>">Semester</label>
                <asp:DropDownList ID="ddlSemester" runat="server">
                    <asp:ListItem Text="1" Value="1" />
                    <asp:ListItem Text="2" Value="2" />
                    <asp:ListItem Text="3" Value="3" />
                    <asp:ListItem Text="4" Value="4" />
                    <asp:ListItem Text="5" Value="5" />
                    <asp:ListItem Text="6" Value="6" />
                    <asp:ListItem Text="7" Value="7" />
                    <asp:ListItem Text="8" Value="8" />
                </asp:DropDownList>
            </div>
        </div>

        <div class="c-form-actions">
            <asp:Button ID="btnSaveEdit" runat="server" Text="Save Changes" CssClass="c-btn-pink" OnClick="btnSaveEdit_Click" />
            <asp:Button ID="btnCancelEdit" runat="server" Text="Cancel" CssClass="c-btn-ghost" OnClick="btnCancelEdit_Click" CausesValidation="false" />
        </div>
    </asp:Panel>

    <div class="c-panel c-fade-up" style="animation-delay: 0.1s;">
        <div class="c-panel-header">
            <div class="c-panel-title">
                <span class="c-panel-title-icon"><i class="ti ti-users"></i></span>
                All Students
            </div>
        </div>
        <div class="c-table-container">
            <asp:GridView ID="gvStudents" runat="server"
                AutoGenerateColumns="False" class="table-modern" GridLines="None" BorderWidth="0" CellPadding="0"
                DataKeyNames="ProfileId" EmptyDataText="No students found."
                OnRowCommand="gvStudents_RowCommand">
                <Columns>
                    <asp:BoundField DataField="Username" HeaderText="Username" />
                    <asp:BoundField DataField="DepartmentName" HeaderText="Department" />
                    <asp:BoundField DataField="DepartmentCode" HeaderText="Code" />
                    <asp:BoundField DataField="Semester" HeaderText="Semester" />
                    <asp:TemplateField HeaderText="Status">
                        <ItemTemplate>
                            <span class='c-status-pill <%# (bool)Eval("IsActive") ? "active" : "inactive" %>'>
                                <i class='ti <%# (bool)Eval("IsActive") ? "ti-circle-check" : "ti-circle-x" %>'></i>
                                <%# (bool)Eval("IsActive") ? "Active" : "Inactive" %>
                            </span>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Actions">
                        <ItemTemplate>
                            <div class="c-row-actions">
                                <asp:LinkButton ID="lnkEdit" runat="server" CssClass="c-icon-btn" ToolTip="Edit Department/Semester"
                                    CommandName="EditStudent" CommandArgument='<%# Eval("ProfileId") %>'>
                                    <i class="ti ti-pencil"></i>
                                </asp:LinkButton>
                                <asp:LinkButton ID="lnkToggle" runat="server" CssClass="c-icon-btn" ToolTip="Toggle Active/Inactive"
                                    CommandName="ToggleActive" CommandArgument='<%# Eval("ProfileId") %>'>
                                    <i class='ti <%# (bool)Eval("IsActive") ? "ti-toggle-right" : "ti-toggle-left" %>'></i>
                                </asp:LinkButton>
                            </div>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
        </div>
    </div>
</main>

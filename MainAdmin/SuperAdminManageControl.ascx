<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="SuperAdminManageControl.ascx.cs" Inherits="Learning_System.MainAdmin.SuperAdminManageControl" %>

<!-- 
  Shared variables, sidebar, topbar, panel, table, and button styles now come from 
  AdminStyles.css via MainAdmin.master. Only this control's own status-pill, 
  "You" badge, and mobile tweaks live here.
-->
<style>
    .c-status-pill {
        display: inline-flex; align-items: center; gap: 6px; padding: 4px 10px; border-radius: 50px;
        font-weight: 700; font-size: 11.5px;
    }
    .c-status-pill.active { background: var(--success-bg); color: var(--success); }
    .c-status-pill.inactive { background: var(--danger-bg); color: var(--danger); }

    .c-icon-btn.danger:hover { border-color: var(--danger); color: var(--danger); }

    .c-you-badge {
        display: inline-flex; align-items: center; padding: 2px 8px; border-radius: 50px;
        background: var(--icon-blue-bg); color: var(--icon-blue); font-size: 10.5px; font-weight: 700;
        margin-left: 8px; text-transform: uppercase; letter-spacing: 0.4px;
    }

    @media (max-width: 640px) {
        .c-topbar > div[style] .c-btn-pink { width: 100%; justify-content: center; }
        .table-modern { min-width: 560px; }
    }
</style>

<main class="c-main">
    <div class="c-topbar c-fade-up">
        <div>
            <h1>Super Admins</h1>
            <p>Only Main Admin can appoint, suspend, or remove Super Admins.</p>
        </div>
        <div style="display:flex; gap:10px;">
            <a href="/administrator/AppointUser.aspx?role=SuperAdmin" class="c-btn-pink"><i class="ti ti-user-plus"></i> Appoint Super Admin</a>
        </div>
    </div>

    <asp:PlaceHolder ID="phSuccess" runat="server" Visible="false">
        <div class="c-alert success"><i class="ti ti-circle-check"></i> <asp:Literal ID="litSuccess" runat="server" /></div>
    </asp:PlaceHolder>
    <asp:PlaceHolder ID="phError" runat="server" Visible="false">
        <div class="c-alert danger"><i class="ti ti-alert-circle"></i> <asp:Literal ID="litError" runat="server" /></div>
    </asp:PlaceHolder>

    <div class="c-panel c-fade-up" style="animation-delay: 0.1s;">
        <div class="c-panel-header">
            <div class="c-panel-title">
                <span class="c-panel-title-icon"><i class="ti ti-shield-star"></i></span>
                All Super Admins
            </div>
        </div>
        <div class="c-table-container">
            <asp:GridView ID="gvSuperAdmins" runat="server"
                AutoGenerateColumns="False" class="table-modern" GridLines="None" BorderWidth="0" CellPadding="0"
                DataKeyNames="ProfileId" EmptyDataText="No Super Admins appointed yet."
                OnRowCommand="gvSuperAdmins_RowCommand" OnRowDataBound="gvSuperAdmins_RowDataBound">
                <Columns>
                    <asp:TemplateField HeaderText="Name">
                        <ItemTemplate>
                            <%# Eval("FullName") %><asp:Literal ID="litYouBadge" runat="server" Visible="false" Text="<span class='c-you-badge'>You</span>" />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:BoundField DataField="Email" HeaderText="Email" />
                    <asp:TemplateField HeaderText="Status">
                        <ItemTemplate>
                            <span class='c-status-pill <%# (bool)Eval("IsActive") ? "active" : "inactive" %>'>
                                <i class='ti <%# (bool)Eval("IsActive") ? "ti-circle-check" : "ti-circle-x" %>'></i>
                                <%# (bool)Eval("IsActive") ? "Active" : "Suspended" %>
                            </span>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Actions">
                        <ItemTemplate>
                            <div class="c-row-actions">
                                <asp:LinkButton ID="lnkToggle" runat="server" CssClass="c-icon-btn" ToolTip="Suspend/Activate"
                                    CommandName="ToggleActive" CommandArgument='<%# Eval("ProfileId") %>'>
                                    <i class='ti <%# (bool)Eval("IsActive") ? "ti-player-pause" : "ti-player-play" %>'></i>
                                </asp:LinkButton>
                                <asp:LinkButton ID="lnkRemove" runat="server" CssClass="c-icon-btn danger" ToolTip="Remove"
                                    CommandName="RemoveAdmin" CommandArgument='<%# Eval("ProfileId") %>'
                                    OnClientClick='<%# "return confirm(\"Remove " + Eval("FullName") + " as a Super Admin? This cannot be undone.\");" %>'>
                                    <i class="ti ti-trash"></i>
                                </asp:LinkButton>
                            </div>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
        </div>
    </div>
</main>

<%@ Page Title="Manage Staff" Language="C#" MasterPageFile="~/Bit_Admin/upload.Master" AutoEventWireup="true" CodeBehind="DepartmentStaffManage.aspx.cs" Inherits="Learning_System.DepartmentStaffManage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <!-- External Fonts & Stylesheets -->
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800&display=swap" />
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/@tabler/icons-webfont@latest/tabler-icons.min.css" />

    <!-- Page Specific Styles -->
    <style>
        :root {
            --primary: #0B1F66; --secondary: #081547; --pink: #FF2D8D;
            --pink-light: rgba(255,45,141,0.08); --pink-hover: #e0277c; --gray-bg: #fafbff;
            --border-color: rgba(11,31,102,0.08); --text-muted: #6b7280;
            --success: #16a34a; --success-bg: #f0fdf4; --success-border: #4ade80;
            --danger: #dc2626; --danger-bg: #fef2f2; --danger-border: #fca5a5;
        }

        @media (prefers-reduced-motion: no-preference) {
            .c-fade-up { animation: cFadeUp 0.5s cubic-bezier(0.16, 1, 0.3, 1) both; }
            @keyframes cFadeUp { from { opacity: 0; transform: translateY(10px); } to { opacity: 1; transform: translateY(0); } }
        }

        .c-main-content { padding: 24px 10px; font-family: 'Plus Jakarta Sans', sans-serif; }
        .c-topbar { display: flex; align-items: center; justify-content: space-between; gap: 16px; flex-wrap: wrap; margin-bottom: 26px; }
        .c-topbar h1 { margin: 0 0 4px; font-size: 1.55rem; font-weight: 800; color: var(--primary); letter-spacing: -0.3px; }
        .c-topbar p { margin: 0; font-size: 13px; color: var(--text-muted); }

        .c-btn-pink {
            display: inline-flex; align-items: center; gap: 7px; padding: 10px 18px; border-radius: 10px;
            font-size: 13px; font-weight: 700; font-family: 'Plus Jakarta Sans', sans-serif; cursor: pointer;
            border: none; text-decoration: none; background: linear-gradient(135deg, var(--pink), #ff5aa5);
            color: #fff; box-shadow: 0 3px 12px rgba(255,45,141,0.4);
            transition: transform 0.18s ease, box-shadow 0.18s ease;
        }
        .c-btn-pink:hover { transform: translateY(-2px) scale(1.03); color: #fff; }

        .c-btn-ghost {
            display: inline-flex; align-items: center; gap: 7px; padding: 10px 18px; border-radius: 10px;
            font-size: 13px; font-weight: 700; font-family: 'Plus Jakarta Sans', sans-serif; cursor: pointer;
            background: #fff; color: var(--primary); border: 1px solid var(--border-color);
            transition: border-color 0.15s ease, color 0.15s ease;
        }
        .c-btn-ghost:hover { border-color: var(--pink); color: var(--pink); }

        .c-alert {
            display: flex; align-items: center; gap: 10px; padding: 13px 16px; border-radius: 12px;
            font-size: 13px; font-weight: 600; margin-bottom: 18px; border: 1px solid transparent;
        }
        .c-alert.success { background: var(--success-bg); border-color: var(--success-border); color: var(--success); }
        .c-alert.danger { background: var(--danger-bg); border-color: var(--danger-border); color: var(--danger); }

        .c-panel {
            background: #ffffff; border: 1px solid var(--border-color); border-radius: 16px;
            padding: 28px; margin-bottom: 24px; box-shadow: 0 1px 2px rgba(11,31,102,0.03);
        }
        .c-panel-header {
            display: flex; align-items: center; justify-content: space-between; margin-bottom: 22px;
            padding-bottom: 16px; border-bottom: 1px solid var(--border-color); flex-wrap: wrap; gap: 10px;
        }
        .c-panel-title {
            font-size: 11.5px; letter-spacing: 1.6px; color: var(--primary); text-transform: uppercase;
            font-weight: 800; display: flex; align-items: center; gap: 10px;
        }
        .c-panel-title-icon {
            width: 28px; height: 28px; border-radius: 8px; background: var(--pink-light); color: var(--pink);
            display: flex; align-items: center; justify-content: center; font-size: 0.95rem;
        }

        .c-form-grid { display: grid; grid-template-columns: repeat(auto-fit, minmax(220px, 1fr)); gap: 16px; margin-bottom: 18px; }
        .c-field label {
            display: block; font-size: 11.5px; font-weight: 700; color: var(--primary);
            text-transform: uppercase; letter-spacing: 0.5px; margin-bottom: 7px;
        }
        .c-field select, .c-field input[type=text] {
            width: 100%; padding: 11px 14px; border-radius: 10px; border: 1.5px solid var(--border-color);
            font-family: 'Plus Jakarta Sans', sans-serif; font-size: 13.5px; color: var(--primary);
            background: var(--gray-bg); transition: border-color 0.15s ease, background 0.15s ease;
        }
        .c-field select:focus, .c-field input[type=text]:focus { outline: none; border-color: var(--pink); background: #fff; }
        .c-form-actions { display: flex; gap: 10px; }

        .c-table-container { overflow: hidden; border-radius: 12px; border: 1px solid var(--border-color); }
        .table-modern { width: 100%; border-collapse: collapse; font-size: 13px; }
        .table-modern th {
            background: var(--gray-bg); color: var(--primary); font-weight: 700; font-size: 11px;
            text-transform: uppercase; letter-spacing: 0.6px; padding: 14px 18px; text-align: left;
            border-bottom: 1px solid var(--border-color);
        }
        .table-modern td { padding: 14px 18px; border-bottom: 1px solid var(--border-color); color: #4a4a4a; font-weight: 500; }
        .table-modern tr { transition: background-color 0.15s ease; }
        .table-modern tr:last-child td { border-bottom: none; }
        .table-modern tr:hover { background-color: var(--gray-bg); }
        .table-modern tbody tr td:first-child { font-weight: 700; color: var(--primary); }

        .c-row-actions { display: flex; gap: 8px; }
        .c-icon-btn {
            width: 32px; height: 32px; border-radius: 8px; border: 1px solid var(--border-color); background: #fff;
            display: inline-flex; align-items: center; justify-content: center; cursor: pointer;
            color: var(--primary); font-size: 14px; transition: all 0.15s ease;
        }
        .c-icon-btn:hover { border-color: var(--pink); color: var(--pink); }

        .c-status-pill {
            display: inline-flex; align-items: center; gap: 6px; padding: 4px 10px; border-radius: 50px;
            font-weight: 700; font-size: 11.5px;
        }
        .c-status-pill.active { background: var(--success-bg); color: var(--success); }
        .c-status-pill.inactive { background: var(--danger-bg); color: var(--danger); }
    </style>

    <!-- Page Body Markup -->
    <div class="c-main-content">
        <div class="c-topbar c-fade-up">
            <div>
                <h1>Staff</h1>
                <p>Reassign department, and activate or deactivate staff accounts.</p>
            </div>
            <div style="display:flex; gap:10px;">
                <a href="/administrator/AppointUser.aspx" class="c-btn-pink"><i class="ti ti-user-plus"></i> Appoint New Staff</a>
                <a href="super_admin.aspx" class="c-btn-ghost"><i class="ti ti-arrow-left"></i> Dashboard</a>
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
                    <span class="c-panel-title-icon"><i class="ti ti-user-check"></i></span>
                    Edit Staff — <asp:Literal ID="litEditingName" runat="server" />
                </div>
            </div>

            <asp:HiddenField ID="hfProfileId" runat="server" />

            <div class="c-form-grid">
                <div class="c-field">
                    <label for="<%= ddlDepartment.ClientID %>">Department</label>
                    <asp:DropDownList ID="ddlDepartment" runat="server" DataTextField="DepartmentName" DataValueField="DepartmentId" />
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
                    <span class="c-panel-title-icon"><i class="ti ti-user-check"></i></span>
                    All Staff
                </div>
            </div>
            <div class="c-table-container">
                <asp:GridView ID="gvStaff" runat="server"
                    AutoGenerateColumns="False" class="table-modern" GridLines="None" BorderWidth="0" CellPadding="0"
                    DataKeyNames="ProfileId" EmptyDataText="No staff found."
                    OnRowCommand="gvStaff_RowCommand">
                    <Columns>
                        <asp:BoundField DataField="Username" HeaderText="Username" />
                        <asp:BoundField DataField="DepartmentName" HeaderText="Department" />
                        <asp:BoundField DataField="DepartmentCode" HeaderText="Code" />
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
                                    <asp:LinkButton ID="lnkEdit" runat="server" CssClass="c-icon-btn" ToolTip="Reassign Department"
                                        CommandName="EditStaff" CommandArgument='<%# Eval("ProfileId") %>'>
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
    </div>
</asp:Content>
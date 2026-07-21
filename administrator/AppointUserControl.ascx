<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="AppointUserControl.ascx.cs" Inherits="Learning_System.AppointUserControl" %>

<style>
    .lp-app-wrap {
        --lp-primary: #2B397D;
        --lp-violet: #5b4fcf;
        --lp-border: #dde3f0;
        --lp-danger: #dc2626;
        --lp-radius: 14px;
        --lp-radius-lg: 22px;
        max-width: 55%;
        margin: 40px auto;
        background: #fff;
        border-radius: var(--lp-radius-lg);
        box-shadow: 0 0 0 1px rgba(0,0,0,.04), 0 20px 60px rgba(0,0,0,.12);
        overflow: hidden;
    }

    .lp-app-header {
        background: linear-gradient(160deg, rgba(20,30,72,.95) 0%, rgba(35,48,108,.90) 50%, rgba(55,72,148,.92) 100%);
        padding: 28px 40px;
        color: #fff;
        position: relative;
    }

        .lp-app-header h2 {
            margin: 0;
            font-size: 22px;
            font-weight: 800;
        }

        .lp-app-header p {
            margin: 4px 0 0;
            font-size: 13.5px;
            color: rgba(255,255,255,.65);
        }

    .lp-close-btn {
        position: absolute;
        top: 20px;
        right: 24px;
        width: 36px;
        height: 36px;
        border-radius: 50%;
        background: rgba(255,255,255,.12);
        border: 1px solid rgba(255,255,255,.18);
        color: #fff;
        display: flex;
        align-items: center;
        justify-content: center;
        font-size: 15px;
        text-decoration: none;
        transition: background-color .2s ease, transform .2s ease;
    }

        .lp-close-btn:hover {
            background: rgba(255,255,255,.28);
            transform: rotate(90deg);
            color: #fff;
        }

    .lp-app-body {
        padding: 36px 40px;
    }

    .lp-app-grid {
        display: grid;
        grid-template-columns: 1fr 1fr;
        gap: 20px 24px;
        margin-bottom: 20px;
    }

    .lp-field-label {
        display: block;
        font-size: 12.5px;
        font-weight: 700;
        color: #374151;
        text-transform: uppercase;
        letter-spacing: .07em;
        margin-bottom: 8px;
    }

    .lp-input-wrap {
        border: 1.5px solid var(--lp-border);
        border-radius: var(--lp-radius);
        background: #f8faff;
    }

    .lp-form-control {
        width: 100%;
        border: none;
        background: transparent;
        outline: none;
        padding: 12px;
        font-size: 14.5px;
        font-family: inherit;
    }

    .lp-role-panel {
        display: none;
        border: 1px dashed var(--lp-border);
        border-radius: var(--lp-radius);
        padding: 18px;
        margin-bottom: 20px;
    }

        .lp-role-panel.active {
            display: block;
        }

    .lp-error-text {
        display: block;
        margin-top: 6px;
        font-size: 12.5px;
        color: var(--lp-danger);
        font-weight: 600;
    }

    .lp-app-btn {
        padding: 13px 32px;
        border: none;
        border-radius: var(--lp-radius);
        background: linear-gradient(135deg, var(--lp-primary) 0%, var(--lp-violet) 100%);
        color: #fff;
        font-weight: 700;
        cursor: pointer;
    }

    .lp-locked-note {
        font-size: 12.5px;
        color: #64748b;
        margin-top: 6px;
    }
</style>

<div class="lp-app-wrap">
    <div class="lp-app-header">
        <asp:LinkButton ID="btnClose" runat="server" CssClass="lp-close-btn"
            OnClick="btnClose_Click" CausesValidation="false" ToolTip="Close">
            <i class="fas fa-times"></i>
        </asp:LinkButton>
        <h2>Appoint User</h2>
        <p>Create a Staff, Department Admin, or Super Admin account</p>
    </div>

    <div class="lp-app-body">

        <div class="lp-app-grid">

            <div class="lp-field">
                <label class="lp-field-label" for="<%= ddlRoleToAppoint.ClientID %>">Role to Appoint</label>
                <div class="lp-input-wrap">
                    <asp:DropDownList CssClass="lp-form-control" ID="ddlRoleToAppoint" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlRoleToAppoint_SelectedIndexChanged" />
                </div>
            </div>

            <div class="lp-field">
                <label class="lp-field-label" for="<%= txtFullName.ClientID %>">Full Name</label>
                <div class="lp-input-wrap">
                    <asp:TextBox CssClass="lp-form-control" ID="txtFullName" runat="server" />
                </div>
                <asp:RequiredFieldValidator runat="server" ControlToValidate="txtFullName" ErrorMessage="Required*" CssClass="lp-error-text" Display="Dynamic" />
            </div>

            <div class="lp-field">
                <label class="lp-field-label" for="<%= txtEmail.ClientID %>">Email</label>
                <div class="lp-input-wrap">
                    <asp:TextBox CssClass="lp-form-control" ID="txtEmail" runat="server" TextMode="Email" />
                </div>
                <asp:RequiredFieldValidator runat="server" ControlToValidate="txtEmail" ErrorMessage="Required*" CssClass="lp-error-text" Display="Dynamic" />
            </div>

            <div class="lp-field">
                <label class="lp-field-label" for="<%= txtContact.ClientID %>">Contact No</label>
                <div class="lp-input-wrap">
                    <asp:TextBox CssClass="lp-form-control" ID="txtContact" runat="server" />
                </div>
            </div>

            <div class="lp-field">
                <label class="lp-field-label" for="<%= txtUsername.ClientID %>">Username</label>
                <div class="lp-input-wrap">
                    <asp:TextBox CssClass="lp-form-control" ID="txtUsername" runat="server" />
                </div>
                <asp:RequiredFieldValidator runat="server" ControlToValidate="txtUsername" ErrorMessage="Required*" CssClass="lp-error-text" Display="Dynamic" />
            </div>

            <div class="lp-field">
                <label class="lp-field-label" for="<%= txtPassword.ClientID %>">Temporary Password</label>
                <div class="lp-input-wrap">
                    <asp:TextBox CssClass="lp-form-control" ID="txtPassword" runat="server" TextMode="Password" />
                </div>
                <asp:RequiredFieldValidator runat="server" ControlToValidate="txtPassword" ErrorMessage="Required*" CssClass="lp-error-text" Display="Dynamic" />
            </div>

        </div>

        <asp:Panel ID="pnlStaff" runat="server" CssClass="lp-role-panel">
            <div class="lp-app-grid">
                <div class="lp-field">
                    <label class="lp-field-label" for="<%= txtDesignation.ClientID %>">Designation</label>
                    <div class="lp-input-wrap">
                        <asp:TextBox CssClass="lp-form-control" ID="txtDesignation" runat="server" placeholder="e.g. Lecturer" />
                    </div>
                </div>
                <div class="lp-field">
                    <label class="lp-field-label" for="<%= txtSubjectsHandled.ClientID %>">Subjects Handled</label>
                    <div class="lp-input-wrap">
                        <asp:TextBox CssClass="lp-form-control" ID="txtSubjectsHandled" runat="server" placeholder="e.g. DBMS, Networking" />
                    </div>
                </div>
            </div>
        </asp:Panel>

        <asp:Panel ID="pnlDepartmentPicker" runat="server" CssClass="lp-role-panel">
            <div class="lp-field">
                <label class="lp-field-label" for="<%= ddlDepartment.ClientID %>">Department</label>
                <div class="lp-input-wrap">
                    <asp:DropDownList CssClass="lp-form-control" ID="ddlDepartment" runat="server" />
                </div>
                <asp:Label ID="lblDepartmentLocked" runat="server" CssClass="lp-locked-note" Text="" />
            </div>
        </asp:Panel>

        <div>
            <asp:Button CssClass="lp-app-btn" ID="btnAppoint" runat="server" Text="Create Account" OnClick="btnAppoint_Click" />
            <asp:Label ID="lblError" runat="server" CssClass="lp-error-text" Text="" />
        </div>

    </div>
</div>
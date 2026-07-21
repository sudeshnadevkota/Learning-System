<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AppointUser.aspx.cs" Inherits="Learning_System.AppointUser" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Appoint User</title>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css" />
    
    <style>
        * { box-sizing: border-box; }

        body{
            min-height:100vh;
            width:100vw;
            margin: 0;
            display:flex;
            align-items:center;
            justify-content:center;
        }
        #form1{
            width:100%;
        }

        /* ── OUTER WRAPPER — icon wallpaper background ── */
        .lp-wrap {
            width: 100vw;
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            position: relative;
            overflow: hidden;
            background-color: #f5efe6;
            background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='200' height='200'%3E%3Cg fill='none' stroke='%232B397D' stroke-width='1.5' stroke-linecap='round' stroke-linejoin='round' opacity='0.20'%3E%3Cg transform='translate(14,18) scale(1.35)'%3E%3Cpath d='M12 3L1 9l11 6 9-4.91V17'/%3E%3Cpath d='M5 12v5c0 0 2.5 3 7 3s7-3 7-3v-5'/%3E%3C/g%3E%3Cg transform='translate(116,18) scale(1.35)'%3E%3Crect x='3' y='4' width='18' height='18' rx='2'/%3E%3Cline x1='3' y1='9' x2='21' y2='9'/%3E%3Cline x1='8' y1='2' x2='8' y2='6'/%3E%3Cline x1='16' y1='2' x2='16' y2='6'/%3E%3Cpolyline points='9,14 11,16 15,12'/%3E%3C/g%3E%3Cg transform='translate(14,118) scale(1.35)'%3E%3Ccircle cx='12' cy='12' r='9'/%3E%3Cpolyline points='12,7 12,12 15,15'/%3E%3C/g%3E%3Cg transform='translate(116,118) scale(1.35)'%3E%3Ccircle cx='12' cy='7' r='4'/%3E%3Cpath d='M4,20 C4,16 7.6,13 12,13 C16.4,13 20,16 20,20'/%3E%3C/g%3E%3C/g%3E%3C/svg%3E"),
                radial-gradient(ellipse at 12% 15%, rgba(210,140,60,.22) 0%, transparent 50%),
                radial-gradient(ellipse at 88% 88%, rgba(200,100,80,.16) 0%, transparent 50%),
                radial-gradient(ellipse at 55% 45%, rgba(240,200,100,.12) 0%, transparent 45%);
            background-size: 200px 200px, 100% 100%, 100% 100%, 100% 100%;
        }

        .lp-app-wrap {
            --lp-primary: #2B397D;
            --lp-violet: #5b4fcf;
            --lp-border: #dde3f0;
            --lp-danger: #dc2626;
            --lp-radius: 14px;
            --lp-radius-lg: 22px;
            max-width: 55%;
            width: 100%;
            margin: 40px auto;
            background: #fff;
            border-radius: var(--lp-radius-lg);
            box-shadow: 0 0 0 1px rgba(0,0,0,.04), 0 20px 60px rgba(0,0,0,.12);
            overflow: hidden;
            position: relative;
            z-index: 1;
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

        /* ── Tablet ── */
        @media (max-width: 900px) {
            .lp-app-wrap { max-width: 88%; }
        }

        /* ── Mobile ── */
        @media (max-width: 640px) {
            body {
                height: auto;
                width: 100%;
                min-height: 100vh;
                align-items: center;
                padding: 18px 0;
            }

            .lp-app-wrap {
                max-width: 100%;
                width: 92%;
                margin: 0 auto;
                border-radius: 18px;
            }

            .lp-app-header { padding: 22px 22px 20px; }
            .lp-app-header h2 { font-size: 18px; }
            .lp-app-header p { font-size: 12px; }

            .lp-close-btn {
                width: 32px;
                height: 32px;
                top: 14px;
                right: 14px;
                font-size: 13px;
            }

            .lp-app-body { padding: 22px 20px 26px; }

            .lp-app-grid {
                grid-template-columns: 1fr;
                gap: 14px;
                margin-bottom: 14px;
            }

            .lp-field-label { font-size: 11.5px; margin-bottom: 6px; }
            .lp-form-control { padding: 11px 12px; font-size: 14px; }

            .lp-role-panel { padding: 14px; margin-bottom: 14px; }

            .lp-app-btn { width: 100%; padding: 13px 20px; }
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="lp-wrap" onclick="if(event.target === this){ __doPostBack('<%= btnClose.UniqueID %>',''); }">
        <div class="lp-app-wrap" onclick="event.stopPropagation();">
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
        </div>
    </form>
</body>
</html>

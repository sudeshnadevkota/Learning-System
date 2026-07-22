<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="register.aspx.cs" Inherits="Learning_System.register" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Student Registration</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" />
    
    <style>
        body {
            overflow-x: hidden;
            margin: 0;
            padding: 0;
        }

        .lp-reg-wrap {
            --lp-primary: #2B397D;
            --lp-violet: #5b4fcf;
            --lp-text: #0f172a;
            --lp-text-muted: #64748b;
            --lp-border: #dde3f0;
            --lp-danger: #dc2626;
            --lp-radius: 14px;
            --lp-radius-lg: 22px;
            --lp-transition: .18s ease;
        }

        .lp-reg-wrap *, .lp-reg-wrap *::before, .lp-reg-wrap *::after {
            box-sizing: border-box;
        }

        .lp-reg-wrap {
            width: 100%;
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 40px 16px;
            position: relative;
            overflow: hidden;
            background-color: #f5efe6;
            background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='200' height='200'%3E%3Cg fill='none' stroke='%232B397D' stroke-width='1.5' stroke-linecap='round' stroke-linejoin='round' opacity='0.20'%3E%3Cg transform='translate(14,18) scale(1.35)'%3E%3Cpath d='M12 3L1 9l11 6 9-4.91V17'/%3E%3Cpath d='M5 12v5c0 0 2.5 3 7 3s7-3 7-3v-5'/%3E%3C/g%3E%3Cg transform='translate(116,18) scale(1.35)'%3E%3Crect x='3' y='4' width='18' height='18' rx='2'/%3E%3Cline x1='3' y1='9' x2='21' y2='9'/%3E%3Cline x1='8' y1='2' x2='8' y2='6'/%3E%3Cline x1='16' y1='2' x2='16' y2='6'/%3E%3Cpolyline points='9,14 11,16 15,12'/%3E%3C/g%3E%3Cg transform='translate(14,118) scale(1.35)'%3E%3Ccircle cx='12' cy='12' r='9'/%3E%3Cpolyline points='12,7 12,12 15,15'/%3E%3C/g%3E%3Cg transform='translate(116,118) scale(1.35)'%3E%3Ccircle cx='12' cy='7' r='4'/%3E%3Cpath d='M4,20 C4,16 7.6,13 12,13 C16.4,13 20,16 20,20'/%3E%3C/g%3E%3C/g%3E%3C/svg%3E"), radial-gradient(ellipse at 12% 15%, rgba(210,140,60,.22) 0%, transparent 50%), radial-gradient(ellipse at 88% 88%, rgba(200,100,80,.16) 0%, transparent 50%);
            background-size: 200px 200px, 100% 100%, 100% 100%;
        }

        .lp-reg-wrap::before {
            content: '';
            position: absolute;
            width: 420px;
            height: 420px;
            border-radius: 50%;
            background: radial-gradient(circle, rgba(210,140,60,.18) 0%, transparent 70%);
            top: -120px;
            left: -120px;
            animation: lpRegOrb 15s ease-in-out infinite alternate;
            pointer-events: none;
            z-index: 0;
        }

        .lp-reg-wrap::after {
            content: '';
            position: absolute;
            width: 360px;
            height: 360px;
            border-radius: 50%;
            background: radial-gradient(circle, rgba(200,100,80,.14) 0%, transparent 70%);
            bottom: -90px;
            right: -90px;
            animation: lpRegOrb 19s ease-in-out infinite alternate-reverse;
            pointer-events: none;
            z-index: 0;
        }

        @keyframes lpRegOrb {
            0% { transform: translate(0,0) scale(1); }
            50% { transform: translate(30px,-38px) scale(1.08); }
            100% { transform: translate(-18px,24px) scale(.95); }
        }

        .lp-reg-card {
            width: 100%;
            max-width: 820px;
            background: #ffffff;
            border-radius: var(--lp-radius-lg);
            box-shadow: 0 0 0 1px rgba(255,255,255,.08), 0 40px 100px rgba(0,0,0,.40), 0 6px 24px rgba(0,0,0,.22);
            position: relative;
            z-index: 1;
            overflow: hidden;
            animation: lpRegFadeUp .55s cubic-bezier(.22,.68,0,1.2) both;
        }

        @keyframes lpRegFadeUp {
            from {
                opacity: 0;
                transform: translateY(24px) scale(.97);
            }
            to {
                opacity: 1;
                transform: translateY(0) scale(1);
            }
        }

        .lp-reg-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 4px;
            background: linear-gradient(90deg, var(--lp-primary) 0%, var(--lp-violet) 50%, #7c6ef5 100%);
        }

        .lp-reg-close-btn {
            position: absolute;
            top: 10px;
            right: 20px;
            width: auto;
            height: auto;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            font-size: 34px;
            font-weight: 400;
            line-height: 1;
            color: #b0bbc8;
            background: none;
            border-radius: 0;
            text-decoration: none;
            z-index: 2;
            transition: color var(--lp-transition), transform var(--lp-transition);
        }

        .lp-reg-close-btn:hover {
            color: #ffffff;
            transform: scale(1.1);
            text-decoration: none;
        }

        .lp-reg-header {
            background: linear-gradient(160deg, rgba(20,30,72,.95) 0%, rgba(35,48,108,.90) 50%, rgba(55,72,148,.92) 100%);
            padding: 34px 44px;
            display: flex;
            align-items: center;
            gap: 16px;
        }

        .lp-reg-logo-box {
            width: 60px;
            height: 60px;
            border-radius: 16px;
            background: #ffffff;
            border: 2.5px solid rgba(255,255,255,.92);
            box-shadow: 0 6px 20px rgba(0,0,0,.28);
            display: flex;
            align-items: center;
            justify-content: center;
            flex-shrink: 0;
        }

        .lp-reg-logo-box img {
            width: 40px;
            height: 40px;
            object-fit: contain;
        }

        .lp-reg-title {
            font-size: 24px;
            font-weight: 800;
            color: #fff;
            letter-spacing: -.3px;
        }

        .lp-reg-subtitle {
            font-size: 14px;
            font-weight: 500;
            color: rgba(255,255,255,.65);
            margin-top: 3px;
        }

        .lp-reg-body {
            padding: 40px 44px 36px;
        }

        .lp-reg-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 22px 24px;
            margin-bottom: 22px;
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
            display: flex;
            align-items: center;
            border: 1.5px solid var(--lp-border);
            border-radius: var(--lp-radius);
            background: #f8faff;
            transition: border-color var(--lp-transition), box-shadow var(--lp-transition), background var(--lp-transition);
        }

        .lp-input-wrap:focus-within {
            border-color: var(--lp-primary);
            background: #fff;
            box-shadow: 0 0 0 3.5px rgba(43,57,125,.10);
        }

        .lp-input-icon {
            padding: 0 14px;
            color: #b0bbc8;
            font-size: 15px;
            flex-shrink: 0;
        }

        .lp-input-wrap:focus-within .lp-input-icon {
            color: var(--lp-primary);
        }

        .lp-form-control {
            flex: 1;
            border: none;
            background: transparent;
            outline: none;
            padding: 13px 12px 13px 0;
            font-size: 14.5px;
            font-weight: 500;
            color: #000;
            font-family: inherit;
            width: 100%;
        }

        .lp-form-control::placeholder {
            color: #b8c2d0;
            font-weight: 400;
        }

        select.lp-form-control {
            padding: 13px 12px 13px 0;
            appearance: none;
            -webkit-appearance: none;
            background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='14' height='9'%3E%3Cpath d='M1 1l6 6 6-6' stroke='%2364748b' stroke-width='1.6' fill='none' stroke-linecap='round' stroke-linejoin='round'/%3E%3C/svg%3E");
            background-repeat: no-repeat;
            background-position: right 8px center;
            padding-right: 22px;
        }

        input[type="file"].lp-form-control {
            padding: 10px 12px 10px 0;
            font-size: 13.5px;
        }

        .lp-error-text {
            display: block;
            margin-top: 6px;
            font-size: 12.5px;
            color: var(--lp-danger);
            font-weight: 600;
        }

        .lp-reg-btn-row {
            display: flex;
            flex-direction: column;
            align-items: center;
            margin-top: 8px;
        }

        .lp-reg-btn {
            width: 100%;
            max-width: 340px;
            padding: 15px;
            border: none;
            border-radius: var(--lp-radius);
            background: linear-gradient(135deg, var(--lp-primary) 0%, var(--lp-violet) 100%);
            color: #fff;
            font-size: 16px;
            font-weight: 700;
            font-family: inherit;
            cursor: pointer;
            letter-spacing: .2px;
            box-shadow: 0 4px 18px rgba(43,57,125,.32), 0 1px 4px rgba(0,0,0,.15);
            transition: opacity var(--lp-transition), transform var(--lp-transition), box-shadow var(--lp-transition);
        }

        .lp-reg-btn:hover {
            opacity: .92;
            transform: translateY(-1px);
            box-shadow: 0 8px 28px rgba(43,57,125,.40);
        }

        .lp-reg-btn:active {
            transform: translateY(0);
            opacity: 1;
        }

        .lp-reg-login-row {
            text-align: center;
            margin-top: 22px;
            font-size: 14px;
            color: var(--lp-text-muted);
        }

        .lp-login-link {
            color: var(--lp-primary);
            font-weight: 700;
            text-decoration: none;
        }

        .lp-login-link:hover {
            text-decoration: underline;
        }

        /* Mobile Responsiveness Rules */
        @media (max-width: 768px) {
            .lp-reg-wrap {
                padding: 16px 10px;
            }

            .lp-reg-card {
                border-radius: 16px;
            }

            .lp-reg-close-btn { 
                top: 12px; 
                right: 16px; 
            }

            .lp-reg-header {
                padding: 24px 30px;
                gap: 12px;
            }

            .lp-reg-logo-box {
                width: 50px;
                height: 50px;
            }

            .lp-reg-logo-box img {
                width: 32px;
                height: 32px;
            }

            .lp-reg-body {
                padding: 24px 30px 20px;
            }

            /* Stack all inputs vertically */
            .lp-reg-grid {
                grid-template-columns: 1fr;
                gap: 16px;
            }

            .lp-reg-title {
                font-size: 18px;
            }

            .lp-reg-subtitle {
                font-size: 12px;
            }

            .lp-reg-btn {
                max-width: 100%;
            }
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="lp-reg-wrap" onclick="if(event.target === this){ window.location.href = '<%= ResolveUrl("~/Default.aspx") %>'; }">
            <div class="lp-reg-card" onclick="event.stopPropagation();">
                
                <asp:HyperLink ID="HyperLinkClose" runat="server" CssClass="lp-reg-close-btn" NavigateUrl="~/Login.aspx" ToolTip="Back to Login">&times;</asp:HyperLink>

                <div class="lp-reg-header">
                    <div class="lp-reg-logo-box">
                        <img src="administrator/images/logo.png" alt="Texas College Logo" />
                    </div>
                    <div>
                        <div class="lp-reg-title">Create Your Account</div>
                        <div class="lp-reg-subtitle">Texas College &mdash; Learning Portal (Student Registration)</div>
                    </div>
                </div>

                <div class="lp-reg-body">

                    <div class="lp-reg-grid">

                        <div class="lp-field">
                            <label class="lp-field-label" for="<%= Full_name.ClientID %>">Full Name</label>
                            <div class="lp-input-wrap">
                                <span class="lp-input-icon"><i class="bi bi-person-fill"></i></span>
                                <asp:TextBox CssClass="lp-form-control" ID="Full_name" runat="server" placeholder="Full Name"></asp:TextBox>
                            </div>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="Enter full name*" ControlToValidate="Full_name" CssClass="lp-error-text" Display="Dynamic"></asp:RequiredFieldValidator>
                        </div>

                        <div class="lp-field">
                            <label class="lp-field-label" for="<%= Dob.ClientID %>">Date of Birth</label>
                            <div class="lp-input-wrap">
                                <span class="lp-input-icon"><i class="bi bi-calendar-event-fill"></i></span>
                                <asp:TextBox CssClass="lp-form-control" ID="Dob" runat="server" placeholder="Date of Birth" TextMode="Date"></asp:TextBox>
                            </div>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="Select your date of birth*" ControlToValidate="Dob" CssClass="lp-error-text" Display="Dynamic"></asp:RequiredFieldValidator>
                        </div>

                        <div class="lp-field">
                            <label class="lp-field-label" for="<%= Contact.ClientID %>">Contact No</label>
                            <div class="lp-input-wrap">
                                <span class="lp-input-icon"><i class="bi bi-telephone-fill"></i></span>
                                <asp:TextBox CssClass="lp-form-control" ID="Contact" runat="server" placeholder="Contact No" TextMode="Number"></asp:TextBox>
                            </div>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ErrorMessage="Enter your contact*" ControlToValidate="Contact" CssClass="lp-error-text" Display="Dynamic"></asp:RequiredFieldValidator>
                        </div>

                        <div class="lp-field">
                            <label class="lp-field-label" for="<%= Email.ClientID %>">Email ID</label>
                            <div class="lp-input-wrap">
                                <span class="lp-input-icon"><i class="bi bi-envelope-fill"></i></span>
                                <asp:TextBox CssClass="lp-form-control" ID="Email" runat="server" placeholder="Email ID" TextMode="Email"></asp:TextBox>
                            </div>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ErrorMessage="Enter your email*" ControlToValidate="Email" CssClass="lp-error-text" Display="Dynamic"></asp:RequiredFieldValidator>
                        </div>

                        <div class="lp-field">
                            <label class="lp-field-label" for="<%= username.ClientID %>">Username</label>
                            <div class="lp-input-wrap">
                                <span class="lp-input-icon"><i class="bi bi-person-badge-fill"></i></span>
                                <asp:TextBox CssClass="lp-form-control" ID="username" runat="server" placeholder="Username"></asp:TextBox>
                            </div>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ErrorMessage="Enter your username*" ControlToValidate="username" CssClass="lp-error-text" Display="Dynamic"></asp:RequiredFieldValidator>
                        </div>

                        <!-- LCID -->
                        <div class="lp-field">
                            <label class="lp-field-label" for="<%= LCID.ClientID %>">LCID</label>
                            <div class="lp-input-wrap">
                                <span class="lp-input-icon"><i class="bi bi-card-text"></i></span>
                                <asp:TextBox CssClass="lp-form-control" ID="LCID" runat="server" placeholder="LCID"></asp:TextBox>
                            </div>
                        </div>

                        <div class="lp-field">
                            <label class="lp-field-label" for="<%= Password.ClientID %>">Password</label>
                            <div class="lp-input-wrap">
                                <span class="lp-input-icon"><i class="bi bi-lock-fill"></i></span>
                                <asp:TextBox CssClass="lp-form-control" ID="Password" runat="server" placeholder="Password" TextMode="Password"></asp:TextBox>
                            </div>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ErrorMessage="Enter your password*" ControlToValidate="Password" CssClass="lp-error-text" Display="Dynamic"></asp:RequiredFieldValidator>
                        </div>

                        <!-- Confirm Password -->
                        <div class="lp-field">
                            <label class="lp-field-label" for="<%= ConfirmPassword.ClientID %>">Confirm Password</label>
                            <div class="lp-input-wrap">
                                <span class="lp-input-icon"><i class="bi bi-lock-fill"></i></span>
                                <asp:TextBox CssClass="lp-form-control" ID="ConfirmPassword" runat="server" placeholder="Confirm Password" TextMode="Password"></asp:TextBox>
                            </div>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" ErrorMessage="Confirm your password*" ControlToValidate="ConfirmPassword" CssClass="lp-error-text" Display="Dynamic"></asp:RequiredFieldValidator>
                            <asp:CompareValidator ID="CompareValidator1" runat="server" ErrorMessage="Passwords do not match*" ControlToValidate="ConfirmPassword" ControlToCompare="Password" CssClass="lp-error-text" Display="Dynamic"></asp:CompareValidator>
                        </div>

                        <div class="lp-field">
                            <label class="lp-field-label" for="<%= Gender.ClientID %>">Gender</label>
                            <div class="lp-input-wrap">
                                <span class="lp-input-icon"><i class="bi bi-person-vcard-fill"></i></span>
                                <asp:DropDownList CssClass="lp-form-control" ID="Gender" runat="server">
                                    <asp:ListItem Text="Select" Value=""></asp:ListItem>
                                    <asp:ListItem Text="Male" Value="Male"></asp:ListItem>
                                    <asp:ListItem Text="Female" Value="Female"></asp:ListItem>
                                    <asp:ListItem Text="Other" Value="Other"></asp:ListItem>
                                </asp:DropDownList>
                            </div>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator8" runat="server" ErrorMessage="Select gender*" ControlToValidate="Gender" CssClass="lp-error-text" Display="Dynamic"></asp:RequiredFieldValidator>
                        </div>

                        <!-- Parent's Name -->
                        <div class="lp-field">
                            <label class="lp-field-label" for="<%= ParentName.ClientID %>">Parent's Name</label>
                            <div class="lp-input-wrap">
                                <span class="lp-input-icon"><i class="bi bi-people-fill"></i></span>
                                <asp:TextBox CssClass="lp-form-control" ID="ParentName" runat="server" placeholder="Parent's Name"></asp:TextBox>
                            </div>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator11" runat="server" ErrorMessage="Enter parent's name*" ControlToValidate="ParentName" CssClass="lp-error-text" Display="Dynamic"></asp:RequiredFieldValidator>
                        </div>

                        <!-- Parent's Contact Number -->
                        <div class="lp-field">
                            <label class="lp-field-label" for="<%= ParentContact.ClientID %>">Parent's Contact Number</label>
                            <div class="lp-input-wrap">
                                <span class="lp-input-icon"><i class="bi bi-telephone-fill"></i></span>
                                <asp:TextBox CssClass="lp-form-control" ID="ParentContact" runat="server" placeholder="Parent's Contact Number" TextMode="Number"></asp:TextBox>
                            </div>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator12" runat="server" ErrorMessage="Enter parent's contact number*" ControlToValidate="ParentContact" CssClass="lp-error-text" Display="Dynamic"></asp:RequiredFieldValidator>
                        </div>

                        <!-- Parent's Email Address -->
                        <div class="lp-field">
                            <label class="lp-field-label" for="<%= ParentEmail.ClientID %>">Parent's Email Address</label>
                            <div class="lp-input-wrap">
                                <span class="lp-input-icon"><i class="bi bi-envelope-fill"></i></span>
                                <asp:TextBox CssClass="lp-form-control" ID="ParentEmail" runat="server" placeholder="Parent's Email Address" TextMode="Email"></asp:TextBox>
                            </div>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator13" runat="server" ErrorMessage="Enter parent's email address*" ControlToValidate="ParentEmail" CssClass="lp-error-text" Display="Dynamic"></asp:RequiredFieldValidator>
                        </div>

                        <div class="lp-field">
                            <label class="lp-field-label" for="<%= ProfilePhotoUpload.ClientID %>">Profile Photo</label>
                            <div class="lp-input-wrap">
                                <span class="lp-input-icon"><i class="bi bi-camera-fill"></i></span>
                                <asp:FileUpload CssClass="lp-form-control" ID="ProfilePhotoUpload" runat="server" />
                            </div>
                        </div>

                        <div class="lp-field">
                            <label class="lp-field-label" for="<%= Faculty.ClientID %>">Faculty</label>
                            <div class="lp-input-wrap">
                                <span class="lp-input-icon"><i class="bi bi-building-fill"></i></span>
                                <asp:DropDownList CssClass="lp-form-control" ID="Faculty" runat="server">
                                    <asp:ListItem Text="Select" Value=""></asp:ListItem>
                                    <asp:ListItem Text="BBA" Value="BBA"></asp:ListItem>
                                    <asp:ListItem Text="BCS" Value="BCS"></asp:ListItem>
                                    <asp:ListItem Text="BHM" Value="BHM"></asp:ListItem>
                                    <asp:ListItem Text="BIT" Value="BIT"></asp:ListItem>
                                    <asp:ListItem Text="MBA" Value="MBA"></asp:ListItem>
                                    <asp:ListItem Text="MCS" Value="MCS"></asp:ListItem>
                                </asp:DropDownList>
                            </div>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator9" runat="server" ErrorMessage="Select your faculty*" ControlToValidate="Faculty" CssClass="lp-error-text" Display="Dynamic"></asp:RequiredFieldValidator>
                        </div>

                        <div class="lp-field">
                            <label class="lp-field-label" for="<%= Semester.ClientID %>">Semester</label>
                            <div class="lp-input-wrap">
                                <span class="lp-input-icon"><i class="bi bi-journal-bookmark-fill"></i></span>
                                <asp:DropDownList CssClass="lp-form-control" ID="Semester" runat="server">
                                    <asp:ListItem Text="Select" Value=""></asp:ListItem>
                                    <asp:ListItem Text="1" Value="1"></asp:ListItem>
                                    <asp:ListItem Text="2" Value="2"></asp:ListItem>
                                    <asp:ListItem Text="3" Value="3"></asp:ListItem>
                                    <asp:ListItem Text="4" Value="4"></asp:ListItem>
                                    <asp:ListItem Text="5" Value="5"></asp:ListItem>
                                    <asp:ListItem Text="6" Value="6"></asp:ListItem>
                                    <asp:ListItem Text="7" Value="7"></asp:ListItem>
                                    <asp:ListItem Text="8" Value="8"></asp:ListItem>
                                </asp:DropDownList>
                            </div>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator10" runat="server" ErrorMessage="Select your semester*" ControlToValidate="Semester" CssClass="lp-error-text" Display="Dynamic"></asp:RequiredFieldValidator>
                        </div>

                        <!-- Province / State -->
                        <div class="lp-field">
                            <label class="lp-field-label" for="<%= Province.ClientID %>">Province / State</label>
                            <div class="lp-input-wrap">
                                <span class="lp-input-icon"><i class="bi bi-geo-alt-fill"></i></span>
                                <asp:DropDownList CssClass="lp-form-control" ID="Province" runat="server">
                                    <asp:ListItem Text="Select" Value=""></asp:ListItem>
                                    <asp:ListItem Text="Koshi Province" Value="Koshi Province"></asp:ListItem>
                                    <asp:ListItem Text="Madhesh Province" Value="Madhesh Province"></asp:ListItem>
                                    <asp:ListItem Text="Bagmati Province" Value="Bagmati Province"></asp:ListItem>
                                    <asp:ListItem Text="Gandaki Province" Value="Gandaki Province"></asp:ListItem>
                                    <asp:ListItem Text="Lumbini Province" Value="Lumbini Province"></asp:ListItem>
                                    <asp:ListItem Text="Karnali Province" Value="Karnali Province"></asp:ListItem>
                                    <asp:ListItem Text="Sudurpaschim Province" Value="Sudurpaschim Province"></asp:ListItem>
                                </asp:DropDownList>
                            </div>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator14" runat="server" ErrorMessage="Select province/state*" ControlToValidate="Province" CssClass="lp-error-text" Display="Dynamic"></asp:RequiredFieldValidator>
                        </div>

                    </div>

                    <div class="lp-reg-btn-row">
                        <asp:Button CssClass="lp-reg-btn" ID="Button1" runat="server" OnClick="Button1_Click" Text="Submit" />
                        <asp:Label ID="lblError" runat="server" CssClass="lp-error-text" Text=""></asp:Label>
                    </div>

                    <div class="lp-reg-login-row">
                        Already have an Account? 
                        <asp:HyperLink ID="HyperLinkLogin" runat="server" CssClass="lp-login-link" NavigateUrl="~/Login.aspx">Login</asp:HyperLink>
                    </div>

                </div>
            </div>
        </div>
    </form>
</body>
</html>
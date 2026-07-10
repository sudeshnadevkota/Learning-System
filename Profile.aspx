<%@ Page Title="" Language="C#" MasterPageFile="~/learning.Master" AutoEventWireup="true" CodeBehind="Profile.aspx.cs" Inherits="Learning_System.Profile" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet">

    <style>
        :root {
            --primary: #10214F;
            --secondary: #0A1638;
            --accent: #2F6FED;
            --pink: #FF2D8D;
            --yellow: #F6B400;
            --ink: #1E2433;
            --muted: #6B7280;
            --border: #E6E9F2;
            --surface: #FFFFFF;
            --bg-soft: #F4F6FB;
            --lp-radius-lg: 24px;
        }

        .profile-page-bg {
            font-family: 'Inter', -apple-system, BlinkMacSystemFont, 'Segoe UI', sans-serif;
            background-color: #f5efe6;
            background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='200' height='200'%3E%3Cg fill='none' stroke='%232B397D' stroke-width='1.5' stroke-linecap='round' stroke-linejoin='round' opacity='0.20'%3E%3Cg transform='translate(14,18) scale(1.35)'%3E%3Cpath d='M12 3L1 9l11 6 9-4.91V17'/%3E%3Cpath d='M5 12v5c0 0 2.5 3 7 3s7-3 7-3v-5'/%3E%3C/g%3E%3Cg transform='translate(116,18) scale(1.35)'%3E%3Crect x='3' y='4' width='18' height='18' rx='2'/%3E%3Cline x1='3' y1='9' x2='21' y2='9'/%3E%3Cline x1='8' y1='2' x2='8' y2='6'/%3E%3Cline x1='16' y1='2' x2='16' y2='6'/%3E%3Cpolyline points='9,14 11,16 15,12'/%3E%3C/g%3E%3Cg transform='translate(14,118) scale(1.35)'%3E%3Ccircle cx='12' cy='12' r='9'/%3E%3Cpolyline points='12,7 12,12 15,15'/%3E%3C/g%3E%3Cg transform='translate(116,118) scale(1.35)'%3E%3Ccircle cx='12' cy='7' r='4'/%3E%3Cpath d='M4,20 C4,16 7.6,13 12,13 C16.4,13 20,16 20,20'/%3E%3C/g%3E%3C/g%3E%3C/svg%3E"),
                radial-gradient(ellipse at 12% 15%, rgba(210,140,60,.22) 0%, transparent 50%),
                radial-gradient(ellipse at 88% 88%, rgba(200,100,80,.16) 0%, transparent 50%),
                radial-gradient(ellipse at 55% 45%, rgba(240,200,100,.12) 0%, transparent 45%);
            background-size: 200px 200px, 100% 100%, 100% 100%, 100% 100%;
            border-radius: var(--lp-radius-lg);
            padding: 48px 0;
        }

        .profile-wrapper {
            max-width: 900px;
            margin: 0 auto;
            padding: 0 16px;
        }

        .profile-card {
            background: var(--surface);
            border-radius: 20px;
            overflow: hidden;
            border: 1px solid var(--border);
            box-shadow: 0 20px 45px rgba(16, 33, 79, 0.10);
        }

        /* ---------- Banner ---------- */

        .profile-banner {
            background: linear-gradient(135deg, var(--primary), var(--secondary));
            padding: 34px 36px 30px;
            position: relative;
            display: flex;
            align-items: center;
            justify-content: space-between;
        }

        .profile-banner::after {
            content: "";
            position: absolute;
            bottom: 0;
            left: 0;
            width: 100%;
            height: 4px;
            background: linear-gradient(90deg, var(--pink), var(--yellow));
        }

        .profile-banner-text h2 {
            color: #fff;
            font-weight: 700;
            font-size: 1.5rem;
            margin: 0;
            letter-spacing: 0.2px;
        }

        .profile-banner-text p {
            color: rgba(255, 255, 255, 0.65);
            margin: 4px 0 0;
            font-size: 0.88rem;
            font-weight: 400;
        }

        .profile-banner-icon {
            width: 44px;
            height: 44px;
            border-radius: 12px;
            background: rgba(255, 255, 255, 0.10);
            display: flex;
            align-items: center;
            justify-content: center;
            flex-shrink: 0;
        }

        /* ---------- Body layout ---------- */

        .profile-body {
            padding: 36px 36px 38px;
        }

        .photo-col {
            text-align: center;
        }

        .profile-id-card {
            background: linear-gradient(160deg, var(--primary), var(--secondary));
            border-radius: 18px;
            padding: 32px 20px 26px;
            box-shadow: 0 12px 28px rgba(16, 33, 79, 0.20);
        }

        .photo-frame {
            position: relative;
            display: inline-block;
        }

        .photo-frame .img-circle {
            width: 112px;
            height: 112px;
            border-radius: 50%;
            object-fit: cover;
            border: 3px solid rgba(255, 255, 255, 0.85);
            box-shadow: 0 8px 18px rgba(0, 0, 0, 0.28);
            background: #eef0fa;
            display: block;
        }

        .change-badge {
            position: absolute;
            bottom: -4px;
            left: 50%;
            transform: translateX(-50%);
            background: rgba(15, 20, 40, 0.85);
            color: #fff;
            font-size: 0.68rem;
            font-weight: 600;
            letter-spacing: 0.3px;
            padding: 5px 14px;
            border-radius: 20px;
            cursor: pointer;
            white-space: nowrap;
            box-shadow: 0 3px 10px rgba(0, 0, 0, 0.35);
            user-select: none;
            transition: background 0.2s ease;
            display: inline-flex;
            align-items: center;
            gap: 5px;
        }

        .change-badge:hover {
            background: var(--pink);
        }

        .file-upload-hidden {
            display: none;
        }

        .id-name {
            color: #fff;
            font-weight: 700;
            font-size: 1.05rem;
            margin-top: 24px;
            margin-bottom: 0;
            display: block;
            text-align: center;
            width: 100%;
            clear: both;
        }

        .id-email {
            display: block;
            color: rgba(255, 255, 255, 0.72);
            font-size: 0.82rem;
            font-weight: 400;
            margin-top: 6px;
            word-break: break-all;
        }

        .id-student {
            display: inline-block;
            color: #fff;
            font-size: 0.72rem;
            font-weight: 600;
            letter-spacing: 0.3px;
            margin-top: 12px;
            padding: 4px 12px;
            background: rgba(255, 255, 255, 0.12);
            border-radius: 20px;
        }

        /* ---------- Form section ---------- */

        .form-section {
            padding-top: 4px;
        }

        .form-section-heading {
            font-size: 0.78rem;
            font-weight: 700;
            color: var(--muted);
            text-transform: uppercase;
            letter-spacing: 0.6px;
            margin: 0 0 18px;
            padding-bottom: 10px;
            border-bottom: 1px solid var(--border);
        }

        .form-section label {
            font-weight: 600;
            color: var(--ink);
            font-size: 0.82rem;
            letter-spacing: 0.1px;
            margin-bottom: 6px;
            display: block;
        }

        .form-section .form-control {
            width: 100%;
            border: 1px solid var(--border);
            background: var(--bg-soft);
            border-radius: 10px;
            padding: 11px 14px;
            font-family: inherit;
            font-size: 0.92rem;
            color: var(--ink);
            transition: border-color 0.18s ease, box-shadow 0.18s ease, background 0.18s ease;
        }

        .form-section .form-control::placeholder {
            color: #9AA1B2;
        }

        .form-section .form-control:focus {
            border-color: var(--accent);
            background: #fff;
            box-shadow: 0 0 0 3px rgba(47, 111, 237, 0.14);
            outline: none;
        }

        .mb-3 {
            margin-bottom: 18px;
        }

        .form-row {
            display: flex;
            gap: 18px;
            flex-wrap: wrap;
        }

        .form-row .mb-3 {
            flex: 1 1 200px;
            min-width: 0;
        }

        .form-control[readonly] {
            background: #EEF0F5;
            color: var(--muted);
            cursor: not-allowed;
        }

        .form-actions {
            display: flex;
            align-items: center;
            gap: 16px;
            margin-top: 8px;
            padding-top: 20px;
            border-top: 1px solid var(--border);
        }

        .btn-update {
            background: var(--primary);
            border: none;
            color: #fff;
            font-weight: 600;
            font-size: 0.9rem;
            padding: 12px 32px;
            border-radius: 10px;
            letter-spacing: 0.2px;
            box-shadow: 0 6px 16px rgba(16, 33, 79, 0.22);
            transition: background 0.2s ease, transform 0.15s ease, box-shadow 0.2s ease;
        }

        .btn-update:hover {
            background: var(--accent);
            transform: translateY(-1px);
            box-shadow: 0 8px 20px rgba(47, 111, 237, 0.28);
        }

        .msg-label {
            font-weight: 600;
            font-size: 0.85rem;
            color: #B45309;
            background: #FEF3E2;
            padding: 8px 14px;
            border-radius: 8px;
        }

        .msg-label:empty {
            display: none;
        }

        /* ---------- Responsive ---------- */

        @media (max-width: 767px) {
            .profile-page-bg {
                padding: 24px 0;
            }

            .profile-banner {
                padding: 26px 22px 24px;
            }

            .profile-banner-text h2 {
                font-size: 1.25rem;
            }

            .profile-body {
                padding: 24px 20px 28px;
            }

            .photo-col {
                margin-bottom: 24px;
            }

            .profile-id-card {
                padding: 26px 16px 22px;
            }

            .photo-frame .img-circle {
                width: 96px;
                height: 96px;
            }

            .form-row {
                flex-direction: column;
                gap: 0;
            }

            .form-row .mb-3 {
                flex: 1 1 100%;
            }

            .form-actions {
                flex-direction: column;
                align-items: stretch;
            }

            .btn-update {
                width: 100%;
                text-align: center;
            }

            .msg-label {
                text-align: center;
            }
        }

        @media (max-width: 400px) {
            .profile-wrapper {
                padding: 0 8px;
            }

            .id-name {
                font-size: 0.95rem;
            }

            .id-email,
            .id-student {
                font-size: 0.75rem;
            }
        }
    </style>

    <div class="profile-page-bg">
        <div class="profile-wrapper">
            <div class="profile-card">

                <div class="profile-banner">
                    <div class="profile-banner-text">
                        <h2>My Profile</h2>
                        <p>Manage your personal information and photo</p>
                    </div>
                    <div class="profile-banner-icon">
                        <svg width="22" height="22" viewBox="0 0 24 24" fill="none" stroke="#fff" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round">
                            <path d="M20 21v-2a4 4 0 0 0-4-4H8a4 4 0 0 0-4 4v2" />
                            <circle cx="12" cy="7" r="4" />
                        </svg>
                    </div>
                </div>

                <div class="profile-body">
                    <div class="row">
                        <div class="col-md-4 photo-col">
                            <div class="profile-id-card">
                                <div class="photo-frame">
                                    <asp:Image ID="imgProfile" runat="server" CssClass="img-circle" />
                                    <span class="change-badge" onclick="document.getElementById('<%= fileUpload.ClientID %>').click();">
                                        <svg width="11" height="11" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.2" stroke-linecap="round" stroke-linejoin="round">
                                            <path d="M23 19a2 2 0 0 1-2 2H3a2 2 0 0 1-2-2V8a2 2 0 0 1 2-2h4l2-3h6l2 3h4a2 2 0 0 1 2 2z" />
                                            <circle cx="12" cy="13" r="4" />
                                        </svg>
                                        Change
                                    </span>
                                </div>
                                <asp:FileUpload ID="fileUpload" runat="server" CssClass="file-upload-hidden" onchange="this.form.submit();" />

                                <asp:Label ID="lblDisplayName" runat="server" CssClass="id-name" Text="Dorji Sherpa" />
                                <asp:Label ID="lblEmail" runat="server" CssClass="id-email" Text="dorjisherpa@gmail.com" />
                                <asp:Label ID="lblStudentId" runat="server" CssClass="id-student" Text="Student ID: LC00017003701" />
                            </div>
                        </div>

                        <div class="col-md-8 form-section">
                            <p class="form-section-heading">Personal Information</p>

                            <div class="form-row">
                                <div class="mb-3">
                                    <label>Full Name</label>
                                    <asp:TextBox ID="txtFullName" runat="server" CssClass="form-control" placeholder="Enter your full name" />
                                </div>
                                <div class="mb-3">
                                    <label>Email</label>
                                    <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" TextMode="Email" placeholder="Enter your email" />
                                </div>
                            </div>

                            <div class="form-row">
                                <div class="mb-3">
                                    <label>Contact Number</label>
                                    <asp:TextBox ID="txtContact" runat="server" CssClass="form-control" placeholder="Enter your contact number" />
                                </div>
                                <div class="mb-3">
                                    <label>Date of Birth</label>
                                    <asp:TextBox ID="txtDOB" runat="server" CssClass="form-control" TextMode="Date" />
                                </div>
                            </div>

                           

                            <div class="form-row">
                                <div class="mb-3">
                                    <label>LCID</label>
                                    <asp:TextBox ID="txtLCID" runat="server" CssClass="form-control" ReadOnly="true" placeholder="LC00017003701" />
                                </div>
                                <div class="mb-3">
                                    <label>Address</label>
                                    <asp:TextBox ID="txtAddress" runat="server" CssClass="form-control" placeholder="Enter your address" />
                                </div>
                            </div>

                            <div class="form-actions">
                                <asp:Button ID="btnUpdate" runat="server" Text="Update Profile" CssClass="btn btn-update" OnClick="btnUpdate_Click" />
                                <asp:Label ID="lblMsg" runat="server" CssClass="msg-label" />
                            </div>
                        </div>
                    </div>
                </div>

            </div>
        </div>
    </div>

</asp:Content>

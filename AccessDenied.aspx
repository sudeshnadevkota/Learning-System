<%@ Page Title="" Language="C#" MasterPageFile="~/learning.Master" AutoEventWireup="true" CodeBehind="AccessDenied.aspx.cs" Inherits="Learning_System.AccessDenied" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <style>
        .lp-denied-bg {
            min-height: 70vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 60px 20px;
            background: radial-gradient(circle at 50% 0%, #fdf2f8 0%, #f8fafc 60%);
        }

        .lp-denied-wrap {
            max-width: 460px;
            width: 100%;
            text-align: center;
            padding: 48px 40px;
            background: #ffffff;
            border-radius: 20px;
            box-shadow: 0 10px 15px -3px rgba(43, 57, 125, 0.08),
                        0 4px 6px -4px rgba(43, 57, 125, 0.08),
                        0 0 0 1px rgba(226, 232, 240, 0.8);
            animation: lp-denied-pop 0.4s ease-out;
        }

        @keyframes lp-denied-pop {
            from { opacity: 0; transform: translateY(12px); }
            to   { opacity: 1; transform: translateY(0); }
        }

        .lp-denied-icon {
            width: 84px;
            height: 84px;
            margin: 0 auto 24px;
            display: flex;
            align-items: center;
            justify-content: center;
            border-radius: 50%;
            background: linear-gradient(135deg, #fee2e2 0%, #fecaca 100%);
        }

        .lp-denied-icon svg {
            width: 40px;
            height: 40px;
        }

        .lp-denied-wrap h2 {
            color: #1e1b3a;
            font-size: 26px;
            font-weight: 800;
            margin: 0 0 12px;
            letter-spacing: -0.02em;
        }

        .lp-denied-wrap p {
            color: #64748b;
            font-size: 15px;
            line-height: 1.6;
            margin: 0 0 28px;
        }

        .lp-denied-divider {
            height: 1px;
            background: linear-gradient(90deg, transparent, #e2e8f0, transparent);
            margin: 0 0 28px;
        }

        .lp-denied-link {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            color: #ffffff;
            background: linear-gradient(135deg, #2B397D 0%, #1e2a5e 100%);
            font-weight: 700;
            font-size: 14px;
            text-decoration: none;
            padding: 13px 28px;
            border-radius: 10px;
            box-shadow: 0 4px 10px rgba(43, 57, 125, 0.25);
            transition: transform 0.15s ease, box-shadow 0.15s ease;
        }

        .lp-denied-link:hover {
            transform: translateY(-1px);
            box-shadow: 0 6px 14px rgba(43, 57, 125, 0.32);
            color: #ffffff;
        }

        .lp-denied-code {
            margin-top: 20px;
            font-size: 12px;
            letter-spacing: 0.08em;
            color: #cbd5e1;
            text-transform: uppercase;
            font-weight: 600;
        }
    </style>

    <div class="lp-denied-bg">
        <div class="lp-denied-wrap">
            <div class="lp-denied-icon">
                <svg viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                    <path d="M12 2L4 5.5V11C4 16.05 7.41 20.74 12 22C16.59 20.74 20 16.05 20 11V5.5L12 2Z" stroke="#dc2626" stroke-width="1.6" stroke-linejoin="round"/>
                    <path d="M9.5 9.5L14.5 14.5M14.5 9.5L9.5 14.5" stroke="#dc2626" stroke-width="1.8" stroke-linecap="round"/>
                </svg>
            </div>

            <h2>Access Denied</h2>
            <p>You don't have permission to view this page. If you believe this is a mistake, please contact your system administrator.</p>

            <div class="lp-denied-divider"></div>

            <a class="lp-denied-link" href="~/Login.aspx" runat="server">
                <svg width="16" height="16" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                    <path d="M15 3H19C19.5304 3 20.0391 3.21071 20.4142 3.58579C20.7893 3.96086 21 4.46957 21 5V19C21 19.5304 20.7893 20.0391 20.4142 20.4142C20.0391 20.7893 19.5304 21 19 21H15" stroke="white" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round"/>
                    <path d="M10 17L15 12L10 7" stroke="white" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round"/>
                    <path d="M15 12H3" stroke="white" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round"/>
                </svg>
                Return to Login
            </a>

            <div class="lp-denied-code">Error 403 &middot; Restricted Access</div>
        </div>
    </div>
</asp:Content>

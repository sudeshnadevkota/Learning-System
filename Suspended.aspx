<%@ Page Title="Account Suspended" Language="C#" AutoEventWireup="true" CodeBehind="Suspended.aspx.cs" Inherits="Learning_System.Suspended" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Account Suspended - Texas College</title>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" />

    <style>
        .sp-wrap {
            --sp-primary: #2B397D;
            --sp-primary-dark: #1e2a5e;
            --sp-danger: #dc2626;
            --sp-danger-dark: #b91c1c;
            --sp-text: #0f172a;
            --sp-text-muted: #64748b;
            --sp-radius: 14px;
            --sp-radius-lg: 22px;
            --sp-transition: .18s ease;
        }

        .sp-wrap * , .sp-wrap *::before, .sp-wrap *::after { box-sizing: border-box; }

        .sp-wrap {
            width: 100vw;
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            position: relative;
            overflow: hidden;
            background-color: #f5efe6;
            background-image:
                radial-gradient(ellipse at 12% 15%, rgba(220,38,38,.10) 0%, transparent 50%),
                radial-gradient(ellipse at 88% 88%, rgba(200,100,80,.14) 0%, transparent 50%),
                radial-gradient(ellipse at 55% 45%, rgba(43,57,125,.08) 0%, transparent 45%);
            font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', sans-serif;
        }

        .sp-wrap::before {
            content: '';
            position: absolute;
            width: 420px; height: 420px; border-radius: 50%;
            background: radial-gradient(circle, rgba(220,38,38,.10) 0%, transparent 70%);
            top: -120px; left: -120px;
            animation: spOrbDrift 15s ease-in-out infinite alternate;
            pointer-events: none; z-index: 0;
        }

        .sp-wrap::after {
            content: '';
            position: absolute;
            width: 360px; height: 360px; border-radius: 50%;
            background: radial-gradient(circle, rgba(43,57,125,.10) 0%, transparent 70%);
            bottom: -90px; right: -90px;
            animation: spOrbDrift 19s ease-in-out infinite alternate-reverse;
            pointer-events: none; z-index: 0;
        }

        @keyframes spOrbDrift {
            0%   { transform: translate(0,0) scale(1); }
            50%  { transform: translate(30px,-38px) scale(1.08); }
            100% { transform: translate(-18px,24px) scale(.95); }
        }

        .sp-card {
            width: 100%;
            max-width: 440px;
            background: #fff;
            border-radius: var(--sp-radius-lg);
            box-shadow: 0 0 0 1px rgba(255,255,255,.08), 0 40px 100px rgba(0,0,0,.35), 0 6px 24px rgba(0,0,0,.2);
            padding: 44px 40px 38px;
            text-align: center;
            position: relative;
            z-index: 1;
            animation: spFadeUp .55s cubic-bezier(.22,.68,0,1.2) both;
        }

        @keyframes spFadeUp {
            from { opacity: 0; transform: translateY(24px) scale(.97); }
            to   { opacity: 1; transform: translateY(0) scale(1); }
        }

        .sp-icon-badge {
            width: 78px; height: 78px;
            margin: 0 auto 22px;
            border-radius: 50%;
            background: linear-gradient(135deg, #fee2e2, #fecaca);
            display: flex; align-items: center; justify-content: center;
            font-size: 34px;
            color: var(--sp-danger);
            box-shadow: 0 0 0 8px rgba(220,38,38,.06);
        }

        .sp-title {
            font-size: 24px; font-weight: 800; color: var(--sp-text);
            letter-spacing: -.3px; margin-bottom: 10px;
        }

        .sp-message {
            font-size: 14.5px; color: var(--sp-text-muted); line-height: 1.65; margin-bottom: 26px;
        }

        .sp-message strong { color: var(--sp-text); }

        .sp-contact-box {
            background: #f8faff;
            border: 1.5px solid #dde3f0;
            border-radius: var(--sp-radius);
            padding: 16px 18px;
            text-align: left;
            margin-bottom: 28px;
        }

        .sp-contact-label {
            font-size: 11px; font-weight: 700; color: var(--sp-primary);
            text-transform: uppercase; letter-spacing: .06em; margin-bottom: 6px;
        }

        .sp-contact-row {
            display: flex; align-items: center; gap: 10px;
            font-size: 13.5px; color: var(--sp-text); margin-top: 6px;
        }

        .sp-contact-row i { color: var(--sp-primary); font-size: 15px; flex-shrink: 0; }

        .sp-btn {
            width: 100%; padding: 14px; border: none; border-radius: var(--sp-radius);
            background: linear-gradient(135deg, var(--sp-primary) 0%, #5b4fcf 100%);
            color: #fff; font-size: 15px; font-weight: 700; cursor: pointer;
            box-shadow: 0 4px 18px rgba(43,57,125,.3);
            transition: opacity var(--sp-transition), transform var(--sp-transition);
            text-decoration: none; display: inline-flex; align-items: center; justify-content: center; gap: 8px;
        }

        .sp-btn:hover { opacity: .92; transform: translateY(-1px); color: #fff; text-decoration: none; }

        @media (max-width: 480px) {
            .sp-card { padding: 34px 26px 30px; }
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="sp-wrap">
            <div class="sp-card">
                <div class="sp-icon-badge"><i class="bi bi-slash-circle"></i></div>

                <div class="sp-title">Account Suspended</div>
                <div class="sp-message">
                    Your account has been <strong>deactivated</strong> by an administrator and no longer has access to the portal.
                    If you believe this is a mistake, please reach out to your department admin or the college office.
                </div>

                <div class="sp-contact-box">
                    <div class="sp-contact-label">Need help?</div>
                    <div class="sp-contact-row"><i class="bi bi-telephone-fill"></i> 01-4589134 &nbsp;|&nbsp; 9801644458</div>
                    <div class="sp-contact-row"><i class="bi bi-geo-alt-fill"></i> Sifal, Chabahil, Kathmandu</div>
                </div>

                <asp:LinkButton ID="lnkBackToLogin" runat="server" CssClass="sp-btn" OnClick="lnkBackToLogin_Click">
                    <i class="bi bi-arrow-left"></i> Back to Login
                </asp:LinkButton>
            </div>
        </div>
    </form>
</body>
</html>

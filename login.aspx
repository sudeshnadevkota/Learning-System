<%@ Page Title="" Language="C#" MasterPageFile="~/learning.Master" AutoEventWireup="true" CodeBehind="login.aspx.cs" Inherits="Learning_System.login" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

<style>
/* ─────────────────────────────────────────
   SCOPED VARIABLES (prefixed lp- to avoid
   clashing with master page styles)
───────────────────────────────────────── */
.lp-wrap {
  --lp-primary:      #2B397D;
  --lp-primary-dark: #1e2a5e;
  --lp-violet:       #5b4fcf;
  --lp-text:         #0f172a;
  --lp-text-muted:   #64748b;
  --lp-border:       #dde3f0;
  --lp-danger:       #dc2626;
  --lp-danger-bg:    #fef2f2;
  --lp-danger-border:#fecaca;
  --lp-radius:       14px;
  --lp-radius-lg:    22px;
  --lp-transition:   .18s ease;
}

.lp-wrap * , .lp-wrap *::before, .lp-wrap *::after { box-sizing: border-box; }

/* ── OUTER WRAPPER — icon wallpaper background ── */
.lp-wrap {
  width: 100%;
  min-height: 80vh;
  display: flex;
  align-items: center;
  justify-content: center;
  padding: 32px 12px;
  position: relative;
  overflow: hidden;
  background-color: #f5efe6;
  background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='200' height='200'%3E%3Cg fill='none' stroke='%232B397D' stroke-width='1.5' stroke-linecap='round' stroke-linejoin='round' opacity='0.20'%3E%3Cg transform='translate(14,18) scale(1.35)'%3E%3Cpath d='M12 3L1 9l11 6 9-4.91V17'/%3E%3Cpath d='M5 12v5c0 0 2.5 3 7 3s7-3 7-3v-5'/%3E%3C/g%3E%3Cg transform='translate(116,18) scale(1.35)'%3E%3Crect x='3' y='4' width='18' height='18' rx='2'/%3E%3Cline x1='3' y1='9' x2='21' y2='9'/%3E%3Cline x1='8' y1='2' x2='8' y2='6'/%3E%3Cline x1='16' y1='2' x2='16' y2='6'/%3E%3Cpolyline points='9,14 11,16 15,12'/%3E%3C/g%3E%3Cg transform='translate(14,118) scale(1.35)'%3E%3Ccircle cx='12' cy='12' r='9'/%3E%3Cpolyline points='12,7 12,12 15,15'/%3E%3C/g%3E%3Cg transform='translate(116,118) scale(1.35)'%3E%3Ccircle cx='12' cy='7' r='4'/%3E%3Cpath d='M4,20 C4,16 7.6,13 12,13 C16.4,13 20,16 20,20'/%3E%3C/g%3E%3C/g%3E%3C/svg%3E"),
    radial-gradient(ellipse at 12% 15%, rgba(210,140,60,.22) 0%, transparent 50%),
    radial-gradient(ellipse at 88% 88%, rgba(200,100,80,.16) 0%, transparent 50%),
    radial-gradient(ellipse at 55% 45%, rgba(240,200,100,.12) 0%, transparent 45%);
  background-size: 200px 200px, 100% 100%, 100% 100%, 100% 100%;
  border-radius: var(--lp-radius-lg);
}

.lp-wrap::before {
  content: '';
  position: absolute;
  width: 420px; height: 420px; border-radius: 50%;
  background: radial-gradient(circle, rgba(210,140,60,.18) 0%, transparent 70%);
  top: -120px; left: -120px;
  animation: lpOrbDrift 15s ease-in-out infinite alternate;
  pointer-events: none; z-index: 0;
}
.lp-wrap::after {
  content: '';
  position: absolute;
  width: 360px; height: 360px; border-radius: 50%;
  background: radial-gradient(circle, rgba(200,100,80,.14) 0%, transparent 70%);
  bottom: -90px; right: -90px;
  animation: lpOrbDrift 19s ease-in-out infinite alternate-reverse;
  pointer-events: none; z-index: 0;
}
@keyframes lpOrbDrift {
  0%   { transform: translate(0,0)        scale(1);    }
  50%  { transform: translate(30px,-38px) scale(1.08); }
  100% { transform: translate(-18px,24px) scale(.95);  }
}

/* ── SHELL — split card ── */
.lp-shell {
  width: 100%;
  max-width: 980px;
  min-height: 560px;
  display: flex;
  border-radius: var(--lp-radius-lg);
  overflow: hidden;
  box-shadow:
    0 0 0 1px rgba(255,255,255,.08),
    0 40px 100px rgba(0,0,0,.45),
    0  6px 24px  rgba(0,0,0,.25);
  animation: lpFadeUp .55s cubic-bezier(.22,.68,0,1.2) both;
  position: relative; z-index: 1;
  background: #fff;
}
@keyframes lpFadeUp {
  from { opacity: 0; transform: translateY(24px) scale(.97); }
  to   { opacity: 1; transform: translateY(0)    scale(1); }
}

/* ── LEFT — BRANDING PANEL ── */
.lp-brand-panel {
  flex: 1 1 42%;
  background: linear-gradient(160deg,
    rgba(20,30,72,.95)  0%,
    rgba(35,48,108,.90) 50%,
    rgba(55,72,148,.92) 100%);
  padding: 60px 52px;
  display: flex;
  flex-direction: column;
  justify-content: center;
  align-items: flex-start;
  position: relative;
  overflow: hidden;
}
.lp-brand-inner { display: flex; flex-direction: column; align-items: flex-start; }
.lp-brand-logo-row { display: flex; align-items: center; gap: 16px; }
.lp-brand-logo-box {
  width: 88px; height: 88px;
  border-radius: 22px;
  background: #ffffff;
  border: 2.5px solid rgba(255,255,255,.92);
  box-shadow: 0 6px 26px rgba(0,0,0,.28), 0 0 0 6px rgba(255,255,255,.06);
  display: flex; align-items: center; justify-content: center;
  flex-shrink: 0;
}
.lp-brand-logo-box img {
  width: 66px;
  height: 66px;
  object-fit: contain;
}
.lp-brand-college-name { font-size: 24px; font-weight: 800; color: #fff; letter-spacing: -.2px; }
.lp-brand-college-sub {
  font-size: 15px; font-weight: 500; color: rgba(255,255,255,.65);
  margin-top: 5px; line-height: 1.4; max-width: 190px;
}
.lp-brand-accent-bar {
  width: 50px; height: 4px; border-radius: 4px;
  background: linear-gradient(90deg, rgba(255,255,255,.70) 0%, rgba(91,79,207,.60) 100%);
  margin-top: 28px;
}
.lp-brand-tagline {
  margin-top: 18px; font-size: 15px; font-weight: 500;
  color: rgba(255,255,255,.45); letter-spacing: .05em;
}

/* ── RIGHT — LOGIN PANEL ── */
.lp-login-panel {
  flex: 0 0 440px;
  background: #ffffff;
  padding: 48px 48px 44px;
  display: flex;
  flex-direction: column;
  justify-content: center;
  position: relative;
}
.lp-login-panel::before {
  content: '';
  position: absolute; top: 0; left: 0; right: 0; height: 4px;
  background: linear-gradient(90deg, var(--lp-primary) 0%, var(--lp-violet) 50%, #7c6ef5 100%);
}

.lp-signin-label { font-size: 30px; font-weight: 800; color: var(--lp-text); letter-spacing: -.5px; margin-bottom: 6px; }
.lp-signin-sub   { font-size: 15px; color: var(--lp-text-muted); margin-bottom: 28px; line-height: 1.5; }

.lp-field { margin-bottom: 20px; }
.lp-field-label {
  display: block; font-size: 13px; font-weight: 700; color: #374151;
  text-transform: uppercase; letter-spacing: .07em; margin-bottom: 8px;
}
.lp-input-wrap {
  display: flex; align-items: stretch;
  border: 1.5px solid var(--lp-border); border-radius: var(--lp-radius);
  background: #f8faff;
  overflow: hidden;
  transition: border-color var(--lp-transition), box-shadow var(--lp-transition), background var(--lp-transition);
}
.lp-input-wrap:focus-within {
  border-color: var(--lp-primary); background: #fff;
  box-shadow: 0 0 0 3.5px rgba(43,57,125,.10);
}
.lp-input-icon {
  display: flex; align-items: center;
  padding: 0 14px; color: #b0bbc8; font-size: 16px; flex-shrink: 0;
  background: transparent;
}
.lp-input-wrap:focus-within .lp-input-icon { color: var(--lp-primary); }

/* Fix autofill background mismatch causing the white/blue gap */
.lp-form-control:-webkit-autofill,
.lp-form-control:-webkit-autofill:hover,
.lp-form-control:-webkit-autofill:focus {
  -webkit-box-shadow: 0 0 0px 1000px #f8faff inset !important;
  -webkit-text-fill-color: #000 !important;
  caret-color: #000;
  transition: background-color 5000s ease-in-out 0s;
}
.lp-input-wrap:focus-within .lp-form-control:-webkit-autofill {
  -webkit-box-shadow: 0 0 0px 1000px #fff inset !important;
}

.lp-form-control {
  flex: 1; border: none; background: transparent; outline: none;
  padding: 14px 12px 14px 0; font-size: 15px; font-weight: 500; color: #000; font-family: inherit;
  width: 100%;
  height: 100%;
  align-self: stretch;
}
.lp-form-control::placeholder { color: #b8c2d0; font-weight: 400; }

.lp-toggle-pw {
  display: flex; align-items: center;
  background: none; border: none; padding: 0 14px; cursor: pointer;
  color: #b0bbc8; font-size: 16px; flex-shrink: 0;
}
.lp-toggle-pw:hover { color: var(--lp-primary); }

/* Back to home button */
.lp-back-home-link {
  position: absolute;
  top: 20px;
  left: 24px;
  display: inline-flex;
  align-items: center;
  gap: 6px;
  font-size: 14px;
  font-weight: 700;
  color: rgba(255,255,255,.85);
  text-decoration: none;
  z-index: 2;
  transition: color var(--lp-transition), transform var(--lp-transition);
}
.lp-back-home-link:hover {
  color: #fff;
  transform: translateX(-2px);
  text-decoration: underline;
}
.lp-back-arrow {
  font-size: 15px;
  line-height: 1;
}


.lp-label-row { display: flex; justify-content: space-between; align-items: center; margin-bottom: 8px; }
.lp-forgot-link { font-size: 14px; font-weight: 600; color: var(--lp-primary); text-decoration: none; }
.lp-forgot-link:hover { color: var(--lp-violet); text-decoration: underline; }

.lp-error-text { display: block; margin-top: 6px; font-size: 13px; color: var(--lp-danger); font-weight: 600; }

.lp-login-btn {
  width: 100%; padding: 15px; border: none; border-radius: var(--lp-radius);
  background: linear-gradient(135deg, var(--lp-primary) 0%, var(--lp-violet) 100%);
  color: #fff; font-size: 16px; font-weight: 700; font-family: inherit; cursor: pointer;
  letter-spacing: .2px;
  box-shadow: 0 4px 18px rgba(43,57,125,.32), 0 1px 4px rgba(0,0,0,.15);
  transition: opacity var(--lp-transition), transform var(--lp-transition), box-shadow var(--lp-transition);
  margin-top: 6px;
}
.lp-login-btn:hover { opacity: .92; transform: translateY(-1px); box-shadow: 0 8px 28px rgba(43,57,125,.40); }
.lp-login-btn:active { transform: translateY(0); opacity: 1; }

.lp-signup-row { text-align: center; margin-top: 20px; font-size: 14px; color: var(--lp-text-muted); }
.lp-signup-row a { color: var(--lp-primary); font-weight: 700; text-decoration: none; }
.lp-signup-row a:hover { text-decoration: underline; }

@media (max-width: 900px) {
  .lp-shell { flex-direction: column; max-width: 480px; }
  .lp-brand-panel { padding: 52px 32px 30px; }
  .lp-brand-accent-bar, .lp-brand-tagline { display: none; }
  .lp-login-panel { flex: none; padding: 34px 30px; }
  .lp-back-home-link { top: 14px; left: 16px; font-size: 13px; }
}
</style>

<div class="lp-wrap">
  <div class="lp-shell">

      <asp:LinkButton ID="LinkButton1" runat="server" CssClass="lp-back-home-link" OnClick="BackHomeButton_Click">
    <span class="lp-back-arrow">&larr;</span> Back to Home
  </asp:LinkButton>

    <!-- LEFT — BRANDING PANEL -->
    <div class="lp-brand-panel">
      <div class="lp-brand-inner">
        <div class="lp-brand-logo-row">
          <div class="lp-brand-logo-box">
          <img src="administrator/images/logo.png" alt="Texas College Logo" />
          </div>
          <div>
            <div class="lp-brand-college-name">Texas College</div>
            <div class="lp-brand-college-sub">Learning Portal</div>
          </div>
        </div>
        <div class="lp-brand-accent-bar"></div>
        <div class="lp-brand-tagline">Learn. Track. Succeed.</div>
      </div>
    </div>

    <!-- RIGHT — LOGIN PANEL -->
    <div class="lp-login-panel">

      <div class="lp-signin-label">Sign In</div>
      <div class="lp-signin-sub">Enter your credentials to access your account</div>

      <!-- Username -->
      <div class="lp-field">
        <label class="lp-field-label" for="<%= Username.ClientID %>">Username</label>
        <div class="lp-input-wrap">
          <span class="lp-input-icon" aria-hidden="true"><i class="bi bi-person-fill"></i></span>
          <asp:TextBox ID="Username" runat="server" CssClass="lp-form-control" required="true"
              placeholder="Enter number or email" aria-label="Username"></asp:TextBox>
        </div>
      </div>

      <!-- Password -->
      <div class="lp-field">
        <div class="lp-label-row">
          <label class="lp-field-label" for="<%= Password.ClientID %>">Password</label>
          <a href="#" class="lp-forgot-link">Forgot Password</a>
        </div>
        <div class="lp-input-wrap">
          <span class="lp-input-icon" aria-hidden="true"><i class="bi bi-lock-fill"></i></span>
          <asp:TextBox ID="Password" runat="server" CssClass="lp-form-control" TextMode="Password"
              required="true" placeholder="Enter Password" aria-label="Password"></asp:TextBox>
          <span id="togglePassword" class="lp-toggle-pw" role="button" tabindex="0" aria-label="Show or hide password">
            <i class="bi bi-eye-slash-fill"></i>
          </span>
        </div>
        <asp:Label ID="Label1" runat="server" CssClass="lp-error-text"></asp:Label>
      </div>

      <!-- Login button -->
      <asp:Button ID="Button1" runat="server" Text="Login" CssClass="lp-login-btn" OnClick="Button1_Click" />


      <div class="lp-signup-row">
        Don't have an account? <a href="register.aspx">Sign up</a>
      </div>

    </div>
  </div>
</div>

<script>
    document.getElementById("togglePassword").addEventListener("click", function () {
        var passwordField = document.getElementById("<%= Password.ClientID %>");
        var toggleIcon = this.querySelector("i");

        if (passwordField.type === "password") {
            passwordField.type = "text";
            toggleIcon.classList.remove("bi-eye-slash-fill");
            toggleIcon.classList.add("bi-eye-fill");
        } else {
            passwordField.type = "password";
            toggleIcon.classList.remove("bi-eye-fill");
            toggleIcon.classList.add("bi-eye-slash-fill");
        }
    });
</script>

</asp:Content>
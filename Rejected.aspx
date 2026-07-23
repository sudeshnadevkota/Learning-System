<%@ Page Title="Registration Rejected" Language="C#" MasterPageFile="~/learning.Master" AutoEventWireup="true" CodeBehind="Rejected.aspx.cs" Inherits="Learning_System.Rejected" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

<style>
.rej-wrap {
  --rej-primary: #2B397D;
  --rej-violet:  #5b4fcf;
  --rej-text:       #0f172a;
  --rej-text-muted: #64748b;
  --rej-danger:     #dc2626;
}
.rej-wrap * , .rej-wrap *::before, .rej-wrap *::after { box-sizing: border-box; }

.rej-wrap {
  width: 100%;
  min-height: 70vh;
  display: flex;
  align-items: center;
  justify-content: center;
  padding: 40px 16px;
}

.rej-card {
  max-width: 460px;
  width: 100%;
  background: #ffffff;
  border-radius: 22px;
  box-shadow:
    0 0 0 1px rgba(0,0,0,.04),
    0 30px 80px rgba(0,0,0,.18),
    0 6px 20px rgba(0,0,0,.10);
  padding: 48px 40px;
  text-align: center;
  position: relative;
  overflow: hidden;
  animation: rejFadeUp .5s cubic-bezier(.22,.68,0,1.2) both;
}
.rej-card::before {
  content: '';
  position: absolute; top: 0; left: 0; right: 0; height: 4px;
  background: linear-gradient(90deg, var(--rej-danger) 0%, #ef4444 50%, #f87171 100%);
}
@keyframes rejFadeUp {
  from { opacity: 0; transform: translateY(20px) scale(.97); }
  to   { opacity: 1; transform: translateY(0)    scale(1); }
}

.rej-icon {
  width: 72px; height: 72px; border-radius: 50%;
  background: #fef2f2; color: var(--rej-danger);
  display: flex; align-items: center; justify-content: center;
  font-size: 32px; margin: 0 auto 20px;
}
.rej-title { font-size: 22px; font-weight: 800; color: var(--rej-text); margin-bottom: 10px; letter-spacing: -.3px; }
.rej-text  { font-size: 15px; color: var(--rej-text-muted); line-height: 1.65; margin-bottom: 28px; }
.rej-text strong { color: var(--rej-text); font-weight: 700; }

.rej-back {
  display: inline-block; padding: 13px 30px; border-radius: 12px;
  background: linear-gradient(135deg, var(--rej-primary) 0%, var(--rej-violet) 100%);
  color: #fff; font-weight: 700; text-decoration: none; font-size: 14.5px;
  box-shadow: 0 4px 16px rgba(43,57,125,.28);
  transition: opacity .18s ease, transform .18s ease;
}
.rej-back:hover { opacity: .92; transform: translateY(-1px); text-decoration: none; color: #fff; }

@media (max-width: 480px) {
  .rej-card { padding: 36px 24px; }
}
</style>

<div class="rej-wrap">
    <div class="rej-card">
        <div class="rej-icon"><i class="bi bi-x-circle-fill"></i></div>
        <div class="rej-title">Registration Not Approved</div>
        <div class="rej-text">
            Hi <strong><asp:Label ID="NameLabel" runat="server"></asp:Label></strong>, your registration
            was reviewed and was not approved. If you believe this is a mistake, please contact the
            administration office.
        </div>
        <asp:HyperLink ID="HyperLinkLogin" runat="server" CssClass="rej-back" NavigateUrl="~/Login.aspx">Back to Login</asp:HyperLink>
    </div>
</div>

</asp:Content>

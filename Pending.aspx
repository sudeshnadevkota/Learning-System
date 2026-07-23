<%@ Page Title="Pending Approval" Language="C#" MasterPageFile="~/learning.Master" AutoEventWireup="true" CodeBehind="Pending.aspx.cs" Inherits="Learning_System.Pending" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

<style>
.pend-wrap {
  --pend-primary: #2B397D;
  --pend-violet:  #5b4fcf;
  --pend-text:       #0f172a;
  --pend-text-muted: #64748b;
}
.pend-wrap * , .pend-wrap *::before, .pend-wrap *::after { box-sizing: border-box; }

.pend-wrap {
  width: 100%;
  min-height: 70vh;
  display: flex;
  align-items: center;
  justify-content: center;
  padding: 40px 16px;
}

.pend-card {
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
  animation: pendFadeUp .5s cubic-bezier(.22,.68,0,1.2) both;
}
.pend-card::before {
  content: '';
  position: absolute; top: 0; left: 0; right: 0; height: 4px;
  background: linear-gradient(90deg, var(--pend-primary) 0%, var(--pend-violet) 50%, #7c6ef5 100%);
}
@keyframes pendFadeUp {
  from { opacity: 0; transform: translateY(20px) scale(.97); }
  to   { opacity: 1; transform: translateY(0)    scale(1); }
}

.pend-icon {
  width: 72px; height: 72px; border-radius: 50%;
  background: #fff7e6; color: #d2933c;
  display: flex; align-items: center; justify-content: center;
  font-size: 32px; margin: 0 auto 20px;
}
.pend-title { font-size: 22px; font-weight: 800; color: var(--pend-text); margin-bottom: 10px; letter-spacing: -.3px; }
.pend-text  { font-size: 15px; color: var(--pend-text-muted); line-height: 1.65; margin-bottom: 28px; }
.pend-text strong { color: var(--pend-text); font-weight: 700; }

.pend-back {
  display: inline-block; padding: 13px 30px; border-radius: 12px;
  background: linear-gradient(135deg, var(--pend-primary) 0%, var(--pend-violet) 100%);
  color: #fff; font-weight: 700; text-decoration: none; font-size: 14.5px;
  box-shadow: 0 4px 16px rgba(43,57,125,.28);
  transition: opacity .18s ease, transform .18s ease;
}
.pend-back:hover { opacity: .92; transform: translateY(-1px); text-decoration: none; color: #fff; }

@media (max-width: 480px) {
  .pend-card { padding: 36px 24px; }
}
</style>

<div class="pend-wrap">
    <div class="pend-card">
        <div class="pend-icon"><i class="bi bi-hourglass-split"></i></div>
        <div class="pend-title">Account Pending Approval</div>
        <div class="pend-text">
            Hi <strong><asp:Label ID="NameLabel" runat="server"></asp:Label></strong>, your account has
            been created but is still awaiting review by an administrator. You'll be able to log in once
            it's approved.
        </div>
        <asp:HyperLink ID="HyperLinkLogin" runat="server" CssClass="pend-back" NavigateUrl="~/Login.aspx">Back to Login</asp:HyperLink>
    </div>
</div>

</asp:Content>

<%@ Page Title="" Language="C#" MasterPageFile="~/Bcs_Admin/upload.Master" AutoEventWireup="true" CodeBehind="dash.aspx.cs" Inherits="Learning_System.Bcs_Admin.dash" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

<style>
    @import url('https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700&display=swap');
    @import url('https://cdn.jsdelivr.net/npm/@tabler/icons-webfont@latest/tabler-icons.min.css');

    :root {
        --primary: #0B1F66;
        --secondary: #081547;
        --pink: #FF2D8D;
        --yellow: #F6B400;
    }

    .d-wrap { font-family: 'Plus Jakarta Sans', sans-serif; padding: 1rem !important; }

    /* ── COMPACT HERO ── */
    .d-hero {
        background: linear-gradient(135deg, #0B1F66 0%, #1a3499 100%);
        padding: 24px 24px;
        border-radius: 14px;
        position: relative;
        overflow: hidden;
        margin-bottom: 16px;
    }
    .d-hero-tag { display: inline-flex; align-items: center; gap: 6px; font-size: 10px; color: #FF2D8D; background: rgba(255,45,141,0.15); border-radius: 20px; padding: 3px 12px; text-transform: uppercase; margin-bottom: 12px; }
    .d-hero h1 { font-size: 20px; font-weight: 700; color: #fff; margin-bottom: 4px; }
    .d-hero-sub { font-size: 12px; color: rgba(255,255,255,0.6); margin-bottom: 16px; }
    .d-hero-stats { display: flex; gap: 20px; align-items: center; }
    .d-hstat-val { font-size: 18px; font-weight: 700; color: #fff; }
    .d-hstat-label { font-size: 10px; color: rgba(255,255,255,0.5); text-transform: uppercase; margin-top: 2px; }
    .d-hstat-sep { width: 1px; height: 24px; background: rgba(255,255,255,0.15); }

    /* ── TIGHTENED GRID ── */
    .d-section { font-size: 10px; letter-spacing: 1px; color: #0B1F66; text-transform: uppercase; font-weight: 700; margin-bottom: 12px; display: flex; align-items: center; gap: 10px; }
    .d-section::after { content: ''; flex: 1; height: 1px; background: rgba(11,31,102,0.08); }

    .d-cards { display: grid; grid-template-columns: repeat(2, 1fr); gap: 12px; margin-bottom: 16px; }

    /* Shared Card Styles */
    .d-card { border-radius: 12px; padding: 18px; position: relative; overflow: hidden; transition: transform .2s; border: none; }
    .d-card-icon-inner { width: 36px; height: 36px; border-radius: 10px; display: flex; align-items: center; justify-content: center; margin-bottom: 12px; }
    .d-card-kicker { font-size: 9px; letter-spacing: 1px; text-transform: uppercase; margin-bottom: 4px; }
    .d-card-title { font-size: 14px; font-weight: 700; text-transform: uppercase; margin-bottom: 6px; }
    .d-card-text { font-size: 12px; line-height: 1.5; margin-bottom: 14px; }

    /* Pink & Blue Variants */
    .d-card.card-pink { background: linear-gradient(145deg, #FF2D8D, #ff6aae); color: #fff; }
    .d-card.card-pink .d-card-icon-inner { background: rgba(255,255,255,0.2); color: #fff; }
    .d-card.card-blue { background: linear-gradient(145deg, #0B1F66, #1a3499); color: #fff; }
    .d-card.card-blue .d-card-icon-inner { background: rgba(255,255,255,0.15); color: #fff; }
    
    .d-go { font-size: 11px; font-weight: 700; padding: 6px 12px; background: rgba(255,255,255,0.2); border-radius: 6px; color: #fff; text-decoration: none; }
    .d-badge-status { font-size: 9px; padding: 2px 8px; background: rgba(0,0,0,0.1); border-radius: 4px; }

    /* ── COMPACT FEATURE BOX ── */
    .d-feature { border-radius: 12px; border: 1px solid rgba(11,31,102,0.08); background: #fff; overflow: hidden; }
    .d-feature-head { padding: 12px 18px; background: #f8f9fc; display: flex; align-items: center; justify-content: space-between; }
    .d-feature-body { padding: 18px; }
    .d-feature-title { font-size: 15px; font-weight: 700; margin-bottom: 8px; }
    .d-feature-text { font-size: 12px; color: #666; margin-bottom: 16px; }

    @media (max-width: 768px) { .d-cards { grid-template-columns: 1fr; } }
</style>

<div class="d-wrap container-fluid">

    <%-- HERO --%>
    <div class="d-hero">
        <h1>Welcome to BCS Upload Section</h1>
        <p class="d-hero-sub">Manage and publish your e-learning content from one place</p>
        <div class="d-hero-stats">
            <div class="d-hstat"><span class="d-hstat-val">8</span><span class="d-hstat-label">Semesters</span></div>
            <div class="d-hstat-sep"></div>
            <div class="d-hstat"><span class="d-hstat-val">32</span><span class="d-hstat-label">Subjects</span></div>
            <div class="d-hstat-sep"></div>
            <div class="d-hstat"><span class="d-hstat-val">Active</span><span class="d-hstat-label">Status</span></div>
        </div>
    </div>

    <%-- CARDS --%>
    <div class="d-section">E-Learning Modules</div>
    <div class="d-cards">
        <div class="d-card card-pink">
            <div class="d-card-icon-inner"><i class="ti ti-device-desktop"></i></div>
            <div class="d-card-kicker">Module 01</div>
            <div class="d-card-title">Elearning Features</div>
            <p class="d-card-text">Manage your primary features and core settings.</p>
            <a href="#" class="d-go">Go More</a>
        </div>
        <div class="d-card card-blue">
            <div class="d-card-icon-inner"><i class="ti ti-bulb"></i></div>
            <div class="d-card-kicker">Module 02</div>
            <div class="d-card-title">Elearning Needs</div>
            <p class="d-card-text">Update daily requirements and student resources.</p>
            <a href="#" class="d-go">Go More</a>
        </div>
    </div>

    <%-- FEATURED --%>
    <div class="d-section">Featured</div>
    <div class="d-feature">
        <div class="d-feature-head">
            <span style="font-size: 11px; font-weight: 700;">Special Highlight</span>
        </div>
        <div class="d-feature-body">
            <div class="d-feature-title">Special E-Learning Content</div>
            <p class="d-feature-text">A learning system based on formalized teaching but with the help of electronic resources. This is your highlighted module for the week.</p>
            <a href="#" class="d-btn-pink">Learn More</a>
        </div>
    </div>
</div>

</asp:Content>
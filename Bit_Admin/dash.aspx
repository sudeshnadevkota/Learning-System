<%@ Page Title="" Language="C#" MasterPageFile="~/Bit_Admin/upload.Master" AutoEventWireup="true" CodeBehind="dash.aspx.cs" Inherits="Learning_System.Bit_Admin.dash" %>
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

    .d-wrap { font-family: 'Plus Jakarta Sans', sans-serif; }

    .d-hero {
        background: linear-gradient(135deg, #0B1F66 0%, #1a3499 100%);
        padding: 36px 32px 30px;
        border-radius: 16px;
        position: relative;
        overflow: hidden;
        margin-bottom: 24px;
    }
    .d-hero-ring1 { position: absolute; right: -30px; top: -30px; width: 200px; height: 200px; border-radius: 50%; border: 1px solid rgba(255,45,141,0.12); pointer-events: none; }
    .d-hero-ring2 { position: absolute; right: 30px; top: 30px; width: 110px; height: 110px; border-radius: 50%; border: 1px solid rgba(255,45,141,0.08); pointer-events: none; }
    .d-hero-ring3 { position: absolute; left: -40px; bottom: -40px; width: 150px; height: 150px; border-radius: 50%; border: 1px solid rgba(255,255,255,0.04); pointer-events: none; }
    .d-hero-tag { display: inline-flex; align-items: center; gap: 6px; font-size: 11px; letter-spacing: 1.5px; color: #FF2D8D; background: rgba(255,45,141,0.12); border: 1px solid rgba(255,45,141,0.25); border-radius: 20px; padding: 4px 14px; text-transform: uppercase; margin-bottom: 14px; }
    .d-hero h1 { font-size: 26px; font-weight: 700; color: #fff; letter-spacing: 0.5px; margin-bottom: 6px; }
    .d-hero-sub { font-size: 13px; color: rgba(255,255,255,0.5); margin-bottom: 24px; }
    .d-hero-stats { display: flex; gap: 24px; flex-wrap: wrap; align-items: center; }
    .d-hstat { display: flex; flex-direction: column; }
    .d-hstat-val { font-size: 22px; font-weight: 700; color: #fff; line-height: 1; }
    .d-hstat-label { font-size: 11px; color: rgba(255,255,255,0.4); letter-spacing: 0.5px; margin-top: 3px; }
    .d-hstat-sep { width: 1px; height: 36px; background: rgba(255,255,255,0.12); }

    .d-section { font-size: 11px; letter-spacing: 2px; color: #0B1F66; text-transform: uppercase; font-weight: 700; margin-bottom: 14px; display: flex; align-items: center; gap: 10px; }
    .d-section::after { content: ''; flex: 1; height: 1px; background: rgba(11,31,102,0.08); }

    /* ── SYSTEM METRICS PANEL (REPLACED QUICK ACCESS) ── */
    .d-metrics-panel { display: grid; grid-template-columns: repeat(3, 1fr); gap: 16px; margin-bottom: 28px; }
    .d-metric-box { border-radius: 14px; border: 1px solid rgba(11,31,102,0.06); background: #ffffff; padding: 20px; display: flex; align-items: center; gap: 16px; box-shadow: 0 4px 12px rgba(11,31,102,0.01); }
    .d-metric-icon-wrap { width: 46px; height: 46px; border-radius: 12px; display: flex; align-items: center; justify-content: center; font-size: 20px; }
    .d-metric-icon-wrap.m-pink { background: rgba(255,45,141,0.08); color: #FF2D8D; }
    .d-metric-icon-wrap.m-blue { background: rgba(11,31,102,0.06); color: #0B1F66; }
    .d-metric-icon-wrap.m-yellow { background: rgba(246,180,0,0.1); color: #D49B00; }
    .d-metric-info { display: flex; flex-direction: column; gap: 2px; }
    .d-metric-title { font-size: 11px; text-transform: uppercase; letter-spacing: 0.5px; color: rgba(11,31,102,0.45); font-weight: 600; }
    .d-metric-count { font-size: 20px; font-weight: 700; color: #0B1F66; line-height: 1.2; }

    /* ── MODULE CARDS ── */
    .d-cards { display: grid; grid-template-columns: repeat(3, 1fr); gap: 16px; margin-bottom: 28px; }

    .d-card { border-radius: 14px; padding: 22px 20px; position: relative; overflow: hidden; transition: transform .2s, box-shadow .2s; border: none; }
    .d-card:hover { transform: translateY(-4px); }

    /* PINK card */
    .d-card.card-pink { background: linear-gradient(145deg, #FF2D8D, #ff6aae); }
    .d-card.card-pink .d-card-top-bar { background: rgba(255,255,255,0.25); }
    .d-card.card-pink .d-card-icon-inner { background: rgba(255,255,255,0.2); }
    .d-card.card-pink .d-card-icon-inner i { color: #fff; }
    .d-card.card-pink .d-card-kicker { color: rgba(255,255,255,0.65); }
    .d-card.card-pink .d-card-title { color: #fff; }
    .d-card.card-pink .d-card-text { color: rgba(255,255,255,0.8); }
    .d-card.card-pink .d-go { color: #FF2D8D; background: #fff; border-color: transparent; }
    .d-card.card-pink .d-go:hover { background: rgba(255,255,255,0.88); }
    .d-card.card-pink .d-badge-status { color: rgba(255,255,255,0.7); background: rgba(255,255,255,0.15); }

    /* BLUE card */
    .d-card.card-blue { background: linear-gradient(145deg, #0B1F66, #1a3499); }
    .d-card.card-blue .d-card-top-bar { background: rgba(255,255,255,0.15); }
    .d-card.card-blue .d-card-icon-inner { background: rgba(255,255,255,0.12); }
    .d-card.card-blue .d-card-icon-inner i { color: #fff; }
    .d-card.card-blue .d-card-kicker { color: rgba(255,255,255,0.5); }
    .d-card.card-blue .d-card-title { color: #fff; }
    .d-card.card-blue .d-card-text { color: rgba(255,255,255,0.7); }
    .d-card.card-blue .d-go { color: #0B1F66; background: #fff; border-color: transparent; }
    .d-card.card-blue .d-go:hover { background: rgba(255,255,255,0.88); }
    .d-card.card-blue .d-badge-status { color: rgba(255,255,255,0.6); background: rgba(255,255,255,0.12); }

    /* YELLOW card */
    .d-card.card-yellow { background: linear-gradient(145deg, #F6C84B, #fad96e); }
    .d-card.card-yellow .d-card-top-bar { background: rgba(255,255,255,0.3); }
    .d-card.card-yellow .d-card-icon-inner { background: rgba(255,255,255,0.3); }
    .d-card.card-yellow .d-card-icon-inner i { color: #7a4f00; }
    .d-card.card-yellow .d-card-kicker { color: rgba(100,65,0,0.6); }
    .d-card.card-yellow .d-card-title { color: #3d2800; }
    .d-card.card-yellow .d-card-text { color: rgba(80,50,0,0.75); }
    .d-card.card-yellow .d-go { color: #7a4f00; background: rgba(255,255,255,0.7); border-color: transparent; }
    .d-card.card-yellow .d-go:hover { background: rgba(255,255,255,0.9); }
    .d-card.card-yellow .d-badge-status { color: rgba(80,50,0,0.6); background: rgba(255,255,255,0.25); }

    /* Shared card internals */
    .d-card-top-bar { position: absolute; top: 0; left: 0; right: 0; height: 3px; border-radius: 14px 14px 0 0; }
    .d-card-icon { margin-bottom: 16px; }
    .d-card-icon-inner { width: 42px; height: 42px; border-radius: 11px; display: flex; align-items: center; justify-content: center; }
    .d-card-icon-inner i { font-size: 22px; }
    .d-card-kicker { font-size: 10px; letter-spacing: 2px; text-transform: uppercase; margin-bottom: 5px; }
    .d-card-title { font-size: 15px; font-weight: 700; text-transform: uppercase; letter-spacing: 0.5px; margin-bottom: 8px; }
    .d-card-text { font-size: 13px; line-height: 1.65; margin-bottom: 18px; }
    .d-card-foot { display: flex; align-items: center; justify-content: space-between; }
    .d-go { display: inline-flex; align-items: center; gap: 5px; font-size: 12px; font-weight: 700; border-radius: 8px; padding: 7px 16px; text-decoration: none; transition: background .15s; }
    .d-go i { font-size: 13px; }
    .d-badge-status { font-size: 10px; font-weight: 700; border-radius: 6px; padding: 3px 10px; letter-spacing: 0.5px; }

    /* ── FEATURE BOX ── */
    .d-feature { border-radius: 14px; border: 1px solid rgba(11,31,102,0.08); background: #fff; overflow: hidden; margin-bottom: 8px; }
    .d-feature-head { background: linear-gradient(90deg, #0B1F66, #1a3499); padding: 16px 22px; display: flex; align-items: center; justify-content: space-between; }
    .d-feature-head-left { display: flex; align-items: center; gap: 10px; }
    .d-feature-head-left i { font-size: 20px; color: #FF2D8D; }
    .d-feature-head-title { font-size: 13px; font-weight: 700; color: #fff; letter-spacing: 1px; text-transform: uppercase; }
    .d-feature-head-badge { font-size: 10px; color: #F6B400; border: 1px solid rgba(246,180,0,0.45); border-radius: 6px; padding: 3px 10px; letter-spacing: 1px; text-transform: uppercase; }
    .d-feature-body { padding: 24px 22px; }
    .d-feature-title { font-size: 18px; font-weight: 700; color: #0B1F66; letter-spacing: 0.5px; text-transform: uppercase; margin-bottom: 12px; }
    .d-feature-text { font-size: 13.5px; color: rgba(11,31,102,0.6); line-height: 1.75; margin-bottom: 20px; }
    .d-feature-actions { display: flex; align-items: center; gap: 10px; flex-wrap: wrap; }
    .d-btn-pink { display: inline-flex; align-items: center; gap: 6px; font-size: 12px; font-weight: 700; color: #fff; background: #FF2D8D; border: none; border-radius: 8px; padding: 9px 20px; text-decoration: none; cursor: pointer; transition: opacity .15s; }
    .d-btn-pink:hover { opacity: 0.88; text-decoration: none; color: #fff; }
    .d-btn-navy { display: inline-flex; align-items: center; gap: 6px; font-size: 12px; font-weight: 700; color: #0B1F66; background: transparent; border: 1px solid rgba(11,31,102,0.2); border-radius: 8px; padding: 9px 20px; text-decoration: none; cursor: pointer; transition: background .15s; }
    .d-btn-navy:hover { background: rgba(11,31,102,0.05); text-decoration: none; color: #0B1F66; }
    .d-btn-ghost { display: inline-flex; align-items: center; gap: 5px; font-size: 12px; font-weight: 600; color: rgba(11,31,102,0.4); background: transparent; border: none; padding: 9px 6px; text-decoration: none; cursor: pointer; }
    .d-btn-ghost:hover { color: rgba(11,31,102,0.7); text-decoration: none; }

    @media (max-width: 992px) { .d-metrics-panel { grid-template-columns: 1fr; } }
    @media (max-width: 768px) { .d-cards { grid-template-columns: 1fr; } }
    @media (max-width: 640px) { .d-hero h1 { font-size: 18px; } .d-hero { padding: 24px 20px 20px; } }
</style>

<div class="d-wrap container-fluid" style="padding: 1.5rem;">

    <%-- HERO --%>
    <div class="d-hero">
        <div class="d-hero-ring1"></div>
        <div class="d-hero-ring2"></div>
        <div class="d-hero-ring3"></div>
        <div class="d-hero-tag">
            <i class="ti ti-layout-dashboard" style="font-size:12px;"></i> Admin Dashboard
        </div>
        <h1>Welcome to BIT Upload Section</h1>
        <p class="d-hero-sub">Manage and publish your e-learning content from one place</p>
        <div class="d-hero-stats">
            <div class="d-hstat">
                <span class="d-hstat-val">8</span>
                <span class="d-hstat-label">Semesters</span>
            </div>
            <div class="d-hstat-sep"></div>
            <div class="d-hstat">
                <span class="d-hstat-val">32</span>
                <span class="d-hstat-label">Subjects</span>
            </div>
            <div class="d-hstat-sep"></div>
            <div class="d-hstat">
                <span class="d-hstat-val">Active</span>
                <span class="d-hstat-label">System Status</span>
            </div>
        </div>
    </div>



    <%-- MODULE CARDS — Pink · Blue · Yellow --%>
    <div class="d-section">E-Learning Modules</div>
    <div class="d-cards">

        <%-- PINK --%>
        <div class="d-card card-pink">
            <div class="d-card-top-bar"></div>
            <div class="d-card-icon">
                <div class="d-card-icon-inner"><i class="ti ti-device-desktop"></i></div>
            </div>
            <div class="d-card-kicker">Module 01</div>
            <div class="d-card-title">Elearning Features</div>
            <p class="d-card-text">With supporting text below as a natural lead-in to additional content.</p>
            <div class="d-card-foot">
                <a href="#" class="d-go"><i class="ti ti-arrow-right"></i> Go More</a>
                <span class="d-badge-status">Active</span>
            </div>
        </div>

        <%-- BLUE --%>
        <div class="d-card card-blue">
            <div class="d-card-top-bar"></div>
            <div class="d-card-icon">
                <div class="d-card-icon-inner"><i class="ti ti-bulb"></i></div>
            </div>
            <div class="d-card-kicker">Module 02</div>
            <div class="d-card-title">Elearning Needs of Day</div>
            <p class="d-card-text">With supporting text below as a natural lead-in to additional content.</p>
            <div class="d-card-foot">
                <a href="#" class="d-go"><i class="ti ti-arrow-right"></i> Go More</a>
                <span class="d-badge-status">Active</span>
            </div>
        </div>

        <%-- YELLOW --%>
        <div class="d-card card-yellow">
            <div class="d-card-top-bar"></div>
            <div class="d-card-icon">
                <div class="d-card-icon-inner"><i class="ti ti-star"></i></div>
            </div>
            <div class="d-card-kicker">Featured</div>
            <div class="d-card-title">Special E-Learning</div>
            <p class="d-card-text">With supporting text below as a natural lead-in to additional content.</p>
            <div class="d-card-foot">
                <a href="#" class="d-go"><i class="ti ti-arrow-right"></i> Go More</a>
                <span class="d-badge-status">Active</span>
            </div>
        </div>

    </div>

    <%-- SPECIAL FEATURED --%>
    <div class="d-section">Featured</div>
    <div class="d-feature">
        <div class="d-feature-head">
            <div class="d-feature-head-left">
                <i class="ti ti-star"></i>
                <span class="d-feature-head-title">Special Featured</span>
            </div>
            <span class="d-feature-head-badge">Highlighted</span>
        </div>
        <div class="d-feature-body">
            <div class="d-feature-title">Special E-Learning</div>
            <p class="d-feature-text">
                A learning system based on formalized teaching but with the help of electronic resources is known as E-learning.
                E-learning refers to a learning system that we can obtain through the internet using an electronic device. We also call it online learning or online education.
                The 'E' in E-learning stands for 'Electronic.' Hence, the original term 'electronic learning.'
            </p>
            <div class="d-feature-actions">
                <a href="#" class="d-btn-pink"><i class="ti ti-arrow-right"></i> Go More</a>
                <a href="#" class="d-btn-navy"><i class="ti ti-book"></i> Learn More</a>
                <a href="#" class="d-btn-ghost"><i class="ti ti-share"></i> Share</a>
            </div>
        </div>
    </div>

</div>

</asp:Content>
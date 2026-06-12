<%@ Page Title="Business English - BIT Notes" Language="C#" MasterPageFile="~/Bit_Notes/note.Master" AutoEventWireup="true" CodeBehind="business_english.aspx.cs" Inherits="Learning_System.Bit_Notes.business_english" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

<style>

  :root {
    --primary: #0B1F66;
    --secondary: #081547;
    --pink: #FF2D8D;
    --pink-dark: #d4206e;
    --pink-glow: rgba(255,45,141,0.22);
    --pink-soft: rgba(255,45,141,0.1);
    --bg: #f0f3fc;
    --bg-card: #ffffff;
    --text-primary: #0B1F66;
    --text-secondary: #5a6a99;
    --text-light: #a0aec8;
    --border: rgba(11,31,102,0.1);
    --border-pink: rgba(255,45,141,0.18);
    --shadow-sm: 0 2px 12px rgba(8,21,71,0.07);
    --shadow-md: 0 8px 32px rgba(8,21,71,0.13);
    --shadow-lg: 0 20px 60px rgba(8,21,71,0.2);
    --radius: 18px;
    --radius-sm: 10px;
    --sidebar-w: 265px;
    --header-h: 68px;
    --ease: 0.28s cubic-bezier(0.4,0,0.2,1);
  }

  *, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }

  body {
    font-family: 'DM Sans', sans-serif;
    background: var(--bg);
    color: var(--text-primary);
    min-height: 100vh;
    overflow-x: hidden;
  }

  /* ══ SCROLLBAR ══ */
  ::-webkit-scrollbar { width: 5px; }
  ::-webkit-scrollbar-track { background: transparent; }
  ::-webkit-scrollbar-thumb { background: rgba(11,31,102,0.15); border-radius: 4px; }

  /* ══ HEADER ══ */
  header {
    position: fixed; top: 0; left: 0; right: 0; z-index: 200;
    height: var(--header-h);
    background: rgba(255,255,255,0.92);
    backdrop-filter: blur(20px);
    -webkit-backdrop-filter: blur(20px);
    border-bottom: 1px solid var(--border);
    display: flex; align-items: center;
    padding: 0 28px 0 0;
    box-shadow: 0 2px 24px rgba(8,21,71,0.07);
  }

  .header-logo {
    width: var(--sidebar-w);
    display: flex; align-items: center; justify-content: center;
    padding: 0 20px;
    border-right: 1px solid var(--border);
    height: 100%;
    flex-shrink: 0;
  }
  .header-logo img {
    height: 44px; width: auto; object-fit: contain;
  }

  .header-center {
    flex: 1; display: flex; align-items: center;
    padding: 0 28px; gap: 16px;
  }

  .page-title {
    font-family: 'Sora', sans-serif;
    font-size: 15px; font-weight: 700;
    color: var(--primary);
    letter-spacing: -0.2px;
    white-space: nowrap;
    display: flex; align-items: center; gap: 8px;
  }
  .page-title .tag {
    font-size: 10px; font-weight: 700;
    background: var(--pink);
    color: white;
    padding: 3px 9px; border-radius: 50px;
    letter-spacing: 0.4px;
    font-family: 'Sora', sans-serif;
  }

  .search-bar {
    display: flex; align-items: center; gap: 10px;
    background: var(--bg);
    border: 1.5px solid var(--border);
    border-radius: 50px;
    padding: 9px 18px;
    max-width: 380px; width: 100%;
    transition: var(--ease);
  }
  .search-bar:focus-within {
    border-color: var(--pink);
    box-shadow: 0 0 0 4px var(--pink-glow);
    background: white;
  }
  .search-bar svg { color: var(--text-light); flex-shrink: 0; }
  .search-bar input {
    border: none; background: transparent;
    font-family: 'DM Sans', sans-serif;
    font-size: 13.5px; color: var(--text-primary);
    outline: none; width: 100%;
  }
  .search-bar input::placeholder { color: var(--text-light); }

  .header-actions {
    display: flex; align-items: center; gap: 8px;
  }

  .icon-btn {
    width: 38px; height: 38px;
    border-radius: 10px;
    border: 1.5px solid var(--border);
    background: white;
    display: flex; align-items: center; justify-content: center;
    cursor: pointer; transition: var(--ease);
    color: var(--text-secondary);
    position: relative;
  }
  .icon-btn:hover { background: var(--bg); border-color: var(--pink); color: var(--pink); }

  .notif-dot {
    position: absolute; top: 8px; right: 8px;
    width: 7px; height: 7px;
    background: var(--pink); border-radius: 50%;
    border: 2px solid white;
  }

  .avatar {
    width: 38px; height: 38px; border-radius: 50%;
    background: linear-gradient(135deg, var(--primary), var(--pink));
    display: flex; align-items: center; justify-content: center;
    font-family: 'Sora', sans-serif;
    font-weight: 700; font-size: 13px; color: white;
    cursor: pointer;
    box-shadow: 0 2px 10px var(--pink-glow);
    border: 2px solid white;
  }

  /* ══ SIDEBAR TOGGLE ══ */
  .sidebar-toggle {
    display: none; width: 36px; height: 36px;
    border-radius: 10px; border: 1.5px solid var(--border);
    background: white; align-items: center; justify-content: center;
    cursor: pointer; color: var(--primary); margin-right: 8px;
  }

  /* ══ SIDEBAR ══ */
  .sidebar {
    position: fixed; left: 0; top: var(--header-h);
    width: var(--sidebar-w);
    height: calc(100vh - var(--header-h));
    background: var(--secondary);
    overflow-y: auto; overflow-x: hidden;
    padding: 18px 10px 24px;
    z-index: 150;
    transition: var(--ease);
    border-right: 1px solid rgba(255,255,255,0.05);
  }
  .sidebar::-webkit-scrollbar { width: 3px; }
  .sidebar::-webkit-scrollbar-thumb { background: rgba(255,255,255,0.08); border-radius: 3px; }

  .sidebar-label {
    font-size: 10px; font-weight: 700;
    text-transform: uppercase; letter-spacing: 1.8px;
    color: rgba(255,255,255,0.28);
    padding: 4px 12px 10px;
    margin-top: 4px;
  }

  .sem-item { margin-bottom: 1px; }

  .sem-header {
    display: flex; align-items: center; gap: 10px;
    padding: 9px 12px;
    border-radius: var(--radius-sm);
    cursor: pointer; transition: var(--ease);
    color: rgba(255,255,255,0.58);
    font-size: 13px; font-weight: 500;
    position: relative; user-select: none;
  }
  .sem-header:hover {
    background: rgba(255,255,255,0.06); color: rgba(255,255,255,0.9);
  }
  .sem-header.active {
    background: rgba(255,45,141,0.16); color: white;
  }
  .sem-header.active::before {
    content: '';
    position: absolute; left: 0; top: 20%; bottom: 20%;
    width: 3px; background: var(--pink);
    border-radius: 0 3px 3px 0;
  }

  .sem-icon {
    width: 26px; height: 26px;
    background: rgba(255,255,255,0.07);
    border-radius: 7px;
    display: flex; align-items: center; justify-content: center;
    font-size: 12px; flex-shrink: 0;
    transition: var(--ease);
  }
  .sem-header.active .sem-icon {
    background: rgba(255,45,141,0.28);
  }

  .sem-label { flex: 1; }
  .sem-chevron { transition: var(--ease); opacity: 0.45; flex-shrink: 0; }
  .sem-item.open .sem-chevron { transform: rotate(180deg); opacity: 1; color: var(--pink); }

  .sem-subjects { display: none; padding: 3px 0 3px 16px; }
  .sem-item.open .sem-subjects { display: block; }

  .subject-link {
    display: flex; align-items: center; gap: 8px;
    padding: 7px 12px; border-radius: 8px;
    font-size: 12.5px; color: rgba(255,255,255,0.4);
    cursor: pointer; transition: var(--ease);
  }
  .subject-link:hover { color: rgba(255,255,255,0.75); background: rgba(255,255,255,0.04); }
  .subject-link.active { color: var(--pink); background: rgba(255,45,141,0.08); font-weight: 500; }
  .subject-dot { width: 4px; height: 4px; border-radius: 50%; background: currentColor; flex-shrink: 0; }

  /* ══ MAIN ══ */
  .main { margin-left: var(--sidebar-w); padding-top: var(--header-h); min-height: 100vh; width: calc(100% - var(--sidebar-w)); }
  .main-inner { padding: 30px 36px; width: 100%; }

  /* breadcrumb */
  .breadcrumb {
    display: flex; align-items: center; gap: 7px;
    font-size: 12.5px; color: var(--text-light);
    margin-bottom: 22px;
  }
  .breadcrumb a { color: var(--pink); text-decoration: none; font-weight: 500; }
  .breadcrumb a:hover { text-decoration: underline; }

  /* ══ HERO CARD ══ */
  .hero-card {
    background: linear-gradient(135deg, #0B1F66 0%, #081547 100%);
    border-radius: 22px;
    padding: 44px 44px 40px;
    position: relative; overflow: hidden;
    box-shadow: var(--shadow-lg);
    margin-bottom: 28px; width: 100%;
  }

  .hero-card::before {
    content: '';
    position: absolute; top: -80px; right: -60px;
    width: 380px; height: 380px;
    background: radial-gradient(circle, rgba(245,197,66,0.10) 0%, transparent 65%);
    pointer-events: none;
  }
  .hero-card::after {
    content: '';
    position: absolute; bottom: -100px; left: 35%;
    width: 320px; height: 320px;
    background: radial-gradient(circle, rgba(245,197,66,0.05) 0%, transparent 65%);
    pointer-events: none;
  }

  /* decorative circles */
  .hero-deco {
    position: absolute; right: 48px; top: 50%;
    transform: translateY(-50%);
    width: 200px; height: 200px;
    pointer-events: none;
  }
  .hero-deco-ring {
    position: absolute; border-radius: 50%;
    border: 1.5px solid rgba(255,255,255,0.07);
  }
  .hero-deco-ring:nth-child(1) { inset: 0; }
  .hero-deco-ring:nth-child(2) { inset: 24px; border-color: rgba(245,197,66,0.14); }
  .hero-deco-ring:nth-child(3) { inset: 48px; border-color: rgba(255,255,255,0.05); }
  .hero-deco-dot {
    position: absolute; border-radius: 50%;
    top: 50%; left: 50%; transform: translate(-50%, -50%);
    width: 64px; height: 64px;
    background: rgba(245,197,66,0.12);
    display: flex; align-items: center; justify-content: center;
    font-size: 28px;
    border: 1px solid rgba(245,197,66,0.22);
  }

  .hero-tag {
    display: inline-flex; align-items: center; gap: 7px;
    background: rgba(255,255,255,0.08);
    border: 1px solid rgba(255,255,255,0.12);
    color: rgba(255,255,255,0.75);
    font-size: 11px; font-weight: 600;
    padding: 5px 14px; border-radius: 50px;
    font-family: 'Sora', sans-serif;
    letter-spacing: 0.4px;
    margin-bottom: 18px;
  }
  .hero-tag svg { color: #F5C542; }

  .hero-title {
    font-family: 'Sora', sans-serif;
    font-size: 30px; font-weight: 800;
    color: white; line-height: 1.18;
    letter-spacing: -0.6px;
    margin-bottom: 14px;
    max-width: 580px;
  }
  .hero-title span { color: #F5C542; }

  .hero-desc {
    font-size: 14px; color: rgba(255,255,255,0.55);
    line-height: 1.65; max-width: 560px;
    margin-bottom: 32px;
  }

  /* stats */
  .hero-stats {
    display: flex; gap: 0; margin-bottom: 30px;
    max-width: 540px;
  }
  .stat-item {
    display: flex; flex-direction: column; gap: 3px;
    flex: 1;
    padding-right: 20px;
  }
  .stat-item + .stat-item {
    padding-left: 20px;
    border-left: 1px solid rgba(255,255,255,0.1);
    padding-right: 20px;
  }
  .stat-item:last-child { padding-right: 0; }
  .stat-val {
    font-family: 'Sora', sans-serif;
    font-size: 26px; font-weight: 800; color: white;
  }
  .stat-lbl {
    font-size: 10px; font-weight: 600;
    color: rgba(255,255,255,0.4);
    text-transform: uppercase; letter-spacing: 0.8px;
  }

  /* progress */
  .progress-wrap { margin-bottom: 28px; max-width: 560px; }
  .progress-meta {
    display: flex; justify-content: space-between;
    font-size: 12px; color: rgba(255,255,255,0.5);
    margin-bottom: 10px;
  }
  .progress-meta strong { color: white; font-weight: 600; }

  .progress-track {
    height: 6px; background: rgba(255,255,255,0.1);
    border-radius: 3px; position: relative;
  }
  .progress-fill {
    height: 100%; width: 35%;
    background: linear-gradient(90deg, var(--pink), #ff6bb0);
    border-radius: 3px;
  }
  .progress-thumb {
    position: absolute; right: calc(65% - 7px); top: 50%;
    transform: translateY(-50%);
    width: 14px; height: 14px;
    background: white; border-radius: 50%;
    box-shadow: 0 0 0 3px rgba(255,45,141,0.4);
  }

  /* buttons */
  .hero-btns { display: flex; gap: 12px; flex-wrap: wrap; }

  .btn-primary {
    display: inline-flex; align-items: center; gap: 9px;
    background: var(--pink);
    color: white;
    font-family: 'Sora', sans-serif;
    font-weight: 700; font-size: 13.5px;
    padding: 12px 24px; border-radius: 12px;
    border: none; cursor: pointer;
    transition: var(--ease);
    box-shadow: 0 4px 18px rgba(255,45,141,0.45);
    letter-spacing: 0.2px;
  }
  .btn-primary:hover {
    background: var(--pink-dark);
    transform: translateY(-2px);
    box-shadow: 0 8px 26px rgba(255,45,141,0.55);
  }

  .btn-outline {
    display: inline-flex; align-items: center; gap: 9px;
    background: rgba(255,255,255,0.08);
    border: 1.5px solid rgba(255,255,255,0.18);
    color: rgba(255,255,255,0.8);
    font-family: 'Sora', sans-serif;
    font-weight: 500; font-size: 13.5px;
    padding: 12px 24px; border-radius: 12px;
    cursor: pointer; transition: var(--ease);
  }
  .btn-outline:hover {
    background: rgba(255,255,255,0.14);
    border-color: rgba(255,255,255,0.3);
    color: white;
  }

  /* ══ QUICK STATS ROW ══ */
  .stats-row {
    display: grid; grid-template-columns: repeat(4, 1fr);
    gap: 16px; margin-bottom: 28px; width: 100%;
  }

  .stat-card {
    background: white; border-radius: 16px;
    border: 1.5px solid var(--border);
    padding: 20px 20px;
    display: flex; align-items: center; gap: 14px;
    box-shadow: var(--shadow-sm);
    transition: var(--ease); cursor: default;
  }
  .stat-card:hover {
    border-color: var(--pink);
    box-shadow: 0 6px 24px var(--pink-glow);
    transform: translateY(-2px);
  }

  .sc-icon {
    width: 44px; height: 44px; border-radius: 12px;
    display: flex; align-items: center; justify-content: center;
    font-size: 19px; flex-shrink: 0;
  }
  .sc-icon.blue { background: rgba(11,31,102,0.08); }
  .sc-icon.green { background: rgba(16,185,129,0.1); }
  .sc-icon.pink { background: rgba(255,45,141,0.1); }
  .sc-icon.orange { background: rgba(251,146,60,0.1); }

  .sc-val {
    font-family: 'Sora', sans-serif;
    font-size: 22px; font-weight: 700; color: var(--primary);
  }
  .sc-lbl { font-size: 12px; color: var(--text-secondary); }

  /* ══ LEARN SECTION ══ */
  .section-head {
    display: flex; align-items: center; justify-content: space-between;
    margin-bottom: 18px;
  }
  .section-title {
    font-family: 'Sora', sans-serif;
    font-size: 17px; font-weight: 700; color: var(--primary);
    display: flex; align-items: center; gap: 10px;
  }
  .section-icon {
    width: 32px; height: 32px; border-radius: 9px;
    background: linear-gradient(135deg, var(--primary), var(--pink));
    display: flex; align-items: center; justify-content: center;
    color: white; font-size: 14px;
  }

  .learn-grid {
    display: grid; grid-template-columns: repeat(3, 1fr);
    gap: 16px; margin-bottom: 28px;
  }

  .learn-card {
    background: white; border: 1.5px solid var(--border);
    border-radius: 14px; padding: 20px;
    display: flex; align-items: flex-start; gap: 14px;
    transition: var(--ease); cursor: default;
  }
  .learn-card:hover {
    border-color: var(--pink);
    box-shadow: 0 4px 20px var(--pink-glow);
    transform: translateY(-2px);
  }
  .learn-card.full { grid-column: 1 / -1; }

  .lc-icon {
    width: 38px; height: 38px; flex-shrink: 0;
    border-radius: 10px;
    background: linear-gradient(135deg, rgba(11,31,102,0.07), rgba(255,45,141,0.08));
    display: flex; align-items: center; justify-content: center;
    font-size: 18px;
  }
  .lc-text h4 {
    font-family: 'Sora', sans-serif;
    font-size: 13px; font-weight: 600;
    color: var(--primary); margin-bottom: 4px;
  }
  .lc-text p { font-size: 12px; color: var(--text-secondary); line-height: 1.55; }

  /* ══ FILES TABLE ══ */
  .files-card {
    background: white; border: 1.5px solid var(--border);
    border-radius: var(--radius); overflow: hidden;
    box-shadow: var(--shadow-sm); margin-bottom: 32px; width: 100%;
  }

  .files-table { width: 100%; border-collapse: collapse; }
  .files-table thead { background: var(--bg); }
  .files-table th {
    padding: 13px 20px;
    font-family: 'Sora', sans-serif;
    font-size: 10.5px; font-weight: 700;
    text-transform: uppercase; letter-spacing: 1.2px;
    color: var(--text-secondary); text-align: left;
  }
  .files-table td {
    padding: 15px 20px;
    font-size: 13.5px; color: var(--text-primary);
    border-top: 1px solid var(--border);
  }
  .files-table tbody tr { transition: var(--ease); }
  .files-table tbody tr:hover { background: rgba(255,45,141,0.025); }

  .file-cell { display: flex; align-items: center; gap: 12px; }
  .file-badge {
    width: 34px; height: 34px; border-radius: 9px;
    background: rgba(255,45,141,0.08);
    color: var(--pink); flex-shrink: 0;
    display: flex; align-items: center; justify-content: center;
    font-size: 10px; font-weight: 800;
    font-family: 'Sora', sans-serif;
    border: 1px solid rgba(255,45,141,0.15);
  }

  .topic-pill {
    display: inline-block;
    background: rgba(11,31,102,0.07);
    color: var(--primary);
    font-size: 12px; font-weight: 500;
    padding: 4px 12px; border-radius: 50px;
  }

  .btn-dl {
    display: inline-flex; align-items: center; gap: 7px;
    background: var(--pink);
    color: white;
    font-family: 'Sora', sans-serif;
    font-size: 12.5px; font-weight: 700;
    padding: 8px 18px; border-radius: 10px;
    border: none; cursor: pointer;
    transition: var(--ease);
    box-shadow: 0 3px 12px rgba(255,45,141,0.35);
    letter-spacing: 0.2px;
  }
  .btn-dl:hover {
    background: var(--pink-dark);
    transform: translateY(-1px);
    box-shadow: 0 6px 18px rgba(255,45,141,0.48);
  }

  /* ══ OVERLAY + MOBILE ══ */
  .overlay {
    display: none; position: fixed; inset: 0;
    background: rgba(8,21,71,0.45); z-index: 140;
    backdrop-filter: blur(3px);
  }
  .overlay.show { display: block; }

  @media (max-width: 900px) {
    .sidebar { transform: translateX(-100%); }
    .sidebar.open { transform: translateX(0); }
    .main { margin-left: 0; }
    .main-inner { padding: 20px; }
    .header-logo { width: auto; border-right: none; padding: 0 14px; }
    .sidebar-toggle { display: flex; }
    .stats-row { grid-template-columns: 1fr 1fr; }
    .learn-grid { grid-template-columns: 1fr 1fr; }
    .hero-card { padding: 28px; }
    .hero-title { font-size: 24px; }
    .hero-deco { display: none; }
    .page-title { display: none; }
  }
  @media (max-width: 560px) {
    .stats-row { grid-template-columns: 1fr 1fr; }
    .learn-grid { grid-template-columns: 1fr; }
    .hero-stats { flex-wrap: wrap; gap: 14px; }
    .search-bar { max-width: 180px; }
  }

  /* ══ ANIMATIONS ══ */
  .fade-up {
    opacity: 0; transform: translateY(18px);
    animation: fadeUp 0.5s ease forwards;
  }
  @keyframes fadeUp {
    to { opacity: 1; transform: translateY(0); }
  }
  .d1 { animation-delay: 0.06s; }
  .d2 { animation-delay: 0.13s; }
  .d3 { animation-delay: 0.20s; }
  .d4 { animation-delay: 0.27s; }
  .d5 { animation-delay: 0.34s; }

  /* ── Master Page overrides ── */
  header { display: none !important; }
  .sidebar { display: none !important; }
  .overlay { display: none !important; }
  body { padding-top: 0 !important; background: var(--bg) !important; }
  .main { margin-left: 0 !important; padding-top: 0 !important; width: 100% !important; }
  .main-inner { padding: 16px 28px 40px !important; }

  /* ── Syllabus section ── */
  .syllabus-card {
    background: var(--bg-card);
    border-radius: 16px;
    border: 1px solid var(--border);
    box-shadow: var(--shadow-sm);
    overflow: hidden;
    margin-bottom: 24px;
  }
  .syllabus-info-grid {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(180px, 1fr));
    gap: 0;
    border-bottom: 1px solid var(--border);
  }
  .syllabus-info-item {
    padding: 14px 20px;
    border-right: 1px solid var(--border);
  }
  .syllabus-info-item:last-child { border-right: none; }
  .syllabus-info-label {
    font-size: 10px;
    font-weight: 700;
    letter-spacing: 1px;
    text-transform: uppercase;
    color: var(--text-light);
    margin-bottom: 4px;
    font-family: 'Sora', sans-serif;
  }
  .syllabus-info-val {
    font-size: 13.5px;
    font-weight: 600;
    color: var(--text-primary);
    font-family: 'Sora', sans-serif;
  }

  /* Topics table */
  .syllabus-table-wrap { padding: 0 20px 20px; }
  .syllabus-table {
    width: 100%;
    border-collapse: collapse;
    margin-top: 16px;
    font-size: 13px;
  }
  .syllabus-table th {
    background: var(--bg);
    color: var(--text-secondary);
    font-family: 'Sora', sans-serif;
    font-size: 10.5px;
    font-weight: 700;
    letter-spacing: 0.8px;
    text-transform: uppercase;
    padding: 10px 14px;
    text-align: left;
    border-bottom: 1px solid var(--border);
  }
  .syllabus-table td {
    padding: 11px 14px;
    border-bottom: 1px solid var(--border);
    color: var(--text-primary);
    vertical-align: top;
    line-height: 1.5;
  }
  .syllabus-table tr:last-child td { border-bottom: none; }
  .syllabus-table tr:hover td { background: rgba(11,31,102,0.02); }
  .topic-num {
    display: inline-flex;
    align-items: center;
    justify-content: center;
    width: 22px; height: 22px;
    background: var(--primary);
    color: #fff;
    border-radius: 6px;
    font-size: 11px;
    font-weight: 700;
    font-family: 'Sora', sans-serif;
    flex-shrink: 0;
  }
  .topic-cell { display: flex; align-items: flex-start; gap: 10px; }
  .topic-name { font-weight: 600; color: var(--text-primary); }
  .topic-sub  { font-size: 12px; color: var(--text-secondary); margin-top: 2px; }
  .hours-badge {
    display: inline-block;
    background: var(--pink-soft);
    color: var(--pink);
    border-radius: 6px;
    padding: 2px 9px;
    font-size: 11.5px;
    font-weight: 600;
    font-family: 'Sora', sans-serif;
  }

  /* Syllabus modal overlay */
  .syl-modal-bg {
    display: none;
    position: fixed;
    inset: 0;
    background: rgba(8,21,71,0.65);
    z-index: 9999;
    align-items: center;
    justify-content: center;
    padding: 20px;
  }
  .syl-modal-bg.open { display: flex; }
  .syl-modal {
    background: #fff;
    border-radius: 16px;
    width: 100%;
    max-width: 820px;
    max-height: 88vh;
    display: flex;
    flex-direction: column;
    overflow: hidden;
    box-shadow: 0 24px 80px rgba(8,21,71,0.25);
  }
  .syl-modal-header {
    display: flex;
    align-items: center;
    justify-content: space-between;
    padding: 16px 22px;
    border-bottom: 1px solid var(--border);
    flex-shrink: 0;
  }
  .syl-modal-title {
    font-family: 'Sora', sans-serif;
    font-size: 15px;
    font-weight: 700;
    color: var(--text-primary);
  }
  .syl-modal-close {
    background: none;
    border: none;
    cursor: pointer;
    color: var(--text-secondary);
    font-size: 20px;
    line-height: 1;
    padding: 4px 8px;
    border-radius: 6px;
    transition: background 0.2s;
  }
  .syl-modal-close:hover { background: var(--bg); }
  .syl-modal-body {
    flex: 1;
    overflow-y: auto;
    padding: 0;
  }
  /* The syllabus content rendered inside modal */
  .syl-preview {
    padding: 24px 28px;
    font-size: 13.5px;
    line-height: 1.7;
    color: var(--text-primary);
  }
  .syl-preview h3 {
    font-family: 'Sora', sans-serif;
    font-size: 13px;
    font-weight: 700;
    color: var(--text-secondary);
    text-transform: uppercase;
    letter-spacing: 0.8px;
    margin: 20px 0 6px;
  }
  .syl-preview p { margin: 0 0 8px; }
  .syl-preview .syl-row {
    display: flex; gap: 8px;
    padding: 8px 0;
    border-bottom: 1px solid var(--border);
  }
  .syl-preview .syl-row:last-child { border-bottom: none; }
  .syl-preview .syl-row-label {
    font-weight: 600;
    min-width: 120px;
    color: var(--text-secondary);
    font-size: 12.5px;
  }
  .syl-modal-footer {
    padding: 12px 22px;
    border-top: 1px solid var(--border);
    display: flex;
    justify-content: flex-end;
    gap: 10px;
    flex-shrink: 0;
  }

  /* View Syllabus button */
  .btn-view-syl {
    display: inline-flex;
    align-items: center;
    gap: 7px;
    background: var(--pink) !important;
    color: #fff;
    font-family: 'Sora', sans-serif;
    font-size: 13px;
    font-weight: 600;
    padding: 9px 20px;
    border-radius: 10px;
    border: none;
    cursor: pointer;
    transition: background 0.2s, box-shadow 0.2s;
    box-shadow: 0 4px 18px var(--pink-glow);
  }
  .btn-view-syl:hover {
    background: var(--pink-dark) !important;
    box-shadow: 0 6px 24px var(--pink-glow) !important;
  }
  .btn-outline-syl {
    display: inline-flex;
    align-items: center;
    gap: 7px;
    background: transparent;
    color: var(--text-secondary);
    font-family: 'Sora', sans-serif;
    font-size: 13px;
    font-weight: 600;
    padding: 9px 20px;
    border-radius: 10px;
    border: 1px solid var(--border);
    cursor: pointer;
    transition: background 0.2s;
  }
  .btn-outline-syl:hover { background: var(--bg); }

  /* GridView / files table */
  .table-bordered { width: 100%; border-collapse: collapse; }
  .table-bordered th {
    background: var(--bg);
    color: var(--text-secondary);
    font-family: 'Sora', sans-serif;
    font-size: 11px; font-weight: 700;
    letter-spacing: 0.8px; text-transform: uppercase;
    padding: 12px 16px;
    border-bottom: 1px solid var(--border);
    text-align: left;
  }
  .table-bordered td {
    padding: 14px 16px;
    border-bottom: 1px solid var(--border);
    font-size: 13.5px; color: var(--text-primary);
    vertical-align: middle;
  }
  .table-bordered tr:last-child td { border-bottom: none; }
  .table-bordered tr:hover td { background: rgba(11,31,102,0.02); }
  .table-bordered .btn-success {
    display: inline-flex; align-items: center; gap: 6px;
    background: var(--primary); color: #fff;
    font-family: 'Sora', sans-serif;
    font-size: 12px; font-weight: 600;
    padding: 7px 16px; border-radius: 8px;
    border: none; cursor: pointer; text-decoration: none;
    transition: background 0.2s, box-shadow 0.2s;
  }
  .table-bordered .btn-success:hover {
    background: var(--secondary);
    box-shadow: 0 4px 14px rgba(11,31,102,0.18); color: #fff;
  }
  .btn-primary {
    background: var(--primary); color: #fff;
    border: none; border-radius: 8px;
    padding: 8px 20px;
    font-family: 'Sora', sans-serif;
    font-size: 13px; font-weight: 600;
    cursor: pointer; transition: background 0.2s;
  }
  .btn-primary:hover { background: var(--secondary); color: #fff; }

  @media (max-width: 600px) {
    .syllabus-info-grid { grid-template-columns: 1fr 1fr; }
    .syllabus-info-item { border-right: none; border-bottom: 1px solid var(--border); }
    .syl-modal { max-height: 95vh; border-radius: 12px; }
    .syl-preview { padding: 16px; }
  }

  /* ── Hero compact layout ── */
  .hero-card-compact { padding: 28px 36px 28px !important; }
  .hero-deco { display: none !important; }

  .hero-row {
    display: flex;
    align-items: center;
    justify-content: space-between;
    gap: 32px;
    margin: 12px 0 20px;
    flex-wrap: wrap;
  }

  .hero-title-inline {
    font-size: 32px !important;
    white-space: nowrap;
    margin: 0 !important;
    line-height: 1.15 !important;
  }

  .hero-stats-inline {
    display: flex !important;
    align-items: center;
    gap: 0;
    margin: 0 !important;
    flex-shrink: 0;
  }

  .hero-stats-inline .stat-val { white-space: nowrap; }

  @media (max-width: 860px) {
    .hero-row { flex-direction: column; align-items: flex-start; gap: 14px; }
    .hero-title-inline { white-space: normal; font-size: 26px !important; }
    .hero-stats-inline { flex-wrap: wrap; gap: 0; width: 100%; }
    .hero-stats-inline .stat-item { flex: 1 1 auto; min-width: 80px; }
  }
  @media (max-width: 480px) {
    .hero-stats-inline { display: grid !important; grid-template-columns: 1fr 1fr; gap: 0; }
    .hero-stats-inline .stat-item { border-left: none !important; border-bottom: 1px solid rgba(255,255,255,0.1); padding: 8px 0 !important; }
    .hero-stats-inline .stat-item:nth-child(2n) { border-left: 1px solid rgba(255,255,255,0.1) !important; padding-left: 14px !important; }
    .hero-title-inline { font-size: 22px !important; }
    .content-tabs { max-width: 100%; }
  }

  /* ── Syllabus document layout ── */
  .syl-doc-table { display: flex; flex-direction: column; }

  .syl-row-doc {
    display: flex;
    border-bottom: 1px solid #e5e9f2;
    font-size: 13.5px;
    line-height: 1.65;
    color: #1a2a5e;
  }
  .syl-row-doc:last-child { border-bottom: none; }

  .syl-num {
    min-width: 40px; width: 40px;
    padding: 12px 10px;
    font-weight: 700;
    font-family: 'Sora', sans-serif;
    font-size: 12px;
    color: #fff;
    background: #0B1F66;
    display: flex;
    align-items: flex-start;
    justify-content: center;
    padding-top: 14px;
    flex-shrink: 0;
  }

  .syl-cell { padding: 12px 16px; flex: 1; }
  .syl-cell strong { color: #0B1F66; }
  .syl-cell ul { margin: 6px 0 0 18px; padding: 0; }
  .syl-cell ul li { margin-bottom: 3px; }

  .syl-inner-table {
    width: 100%; border-collapse: collapse; margin-top: 10px; font-size: 12.5px;
  }
  .syl-inner-table th {
    background: #f0f3fc; color: #5a6a99;
    font-weight: 700; font-size: 11px; letter-spacing: 0.5px;
    text-transform: uppercase; padding: 7px 10px;
    text-align: left; border: 1px solid #e0e5f0;
  }
  .syl-inner-table td { padding: 8px 10px; border: 1px solid #e0e5f0; vertical-align: top; }
  .syl-topics-table td:first-child {
    font-weight: 700; text-align: center; white-space: nowrap;
    color: #0B1F66; width: 30px;
  }
  .syl-topics-table td:nth-child(3),
  .syl-topics-table td:nth-child(4),
  .syl-topics-table td:nth-child(5),
  .syl-topics-table td:nth-child(6) { text-align: center; white-space: nowrap; width: 50px; }
  .syl-topics-table td ul { margin: 4px 0 0 16px; padding: 0; }
  .syl-topics-table td ul li { margin-bottom: 2px; font-size: 12.5px; }
  .syl-topics-table td strong { display: block; color: #0B1F66; margin-bottom: 2px; }

  @media (max-width: 600px) {
    .syl-num { min-width: 28px; width: 28px; font-size: 11px; padding: 12px 5px; }
    .syl-cell { padding: 10px 10px; font-size: 12.5px; }
    .syl-inner-table { display: block; overflow-x: auto; -webkit-overflow-scrolling: touch; }
    .syl-modal { border-radius: 0; max-height: 100vh; height: 100vh; }
    .syl-modal-bg { padding: 0; align-items: flex-end; }
  }

  /* ── Back to Home link ── */
  .btn-back-home {
    display: inline-flex; align-items: center; gap: 7px;
    color: rgba(255,255,255,0.7);
    text-decoration: none;
    font-family: 'Sora', sans-serif;
    font-size: 12px; font-weight: 600;
    transition: color 0.2s;
  }
  .btn-back-home:hover { color: #fff; text-decoration: none; }

  /* ── Content tabs ── */
  .content-tabs {
    display: flex; gap: 6px;
    background: var(--bg-card);
    border: 1px solid var(--border);
    border-radius: 12px;
    padding: 5px;
    margin-bottom: 16px;
    width: 100%; max-width: 480px;
  }
  .ctab-btn {
    flex: 1;
    display: inline-flex; align-items: center; justify-content: center; gap: 7px;
    padding: 10px 16px; border-radius: 9px;
    border: none; background: transparent;
    color: var(--text-secondary);
    font-family: 'Sora', sans-serif;
    font-size: 13px; font-weight: 600;
    cursor: pointer; transition: all 0.2s;
    white-space: nowrap;
  }
  .ctab-btn:hover { background: var(--bg); color: var(--text-primary); }
  .ctab-btn.active {
    background: var(--pink); color: #fff;
    box-shadow: 0 3px 12px var(--pink-glow);
  }

  /* ── Empty state ── */
  .empty-state {
    display: flex; flex-direction: column;
    align-items: center; justify-content: center;
    padding: 48px 24px; text-align: center; gap: 10px;
  }
  .empty-icon { font-size: 40px; }
  .empty-title {
    font-family: 'Sora', sans-serif; font-size: 15px;
    font-weight: 700; color: var(--text-primary);
  }
  .empty-text {
    font-size: 13px; color: var(--text-secondary);
    max-width: 340px; line-height: 1.6;
  }

  @media (max-width: 500px) {
    .content-tabs { width: 100%; }
    .ctab-btn { flex: 1; justify-content: center; }
    .hero-card-compact { padding: 20px 18px !important; }
  }

  /* ── Filter bar ── */
  .filter-bar {
    display: flex; align-items: center; gap: 12px;
    margin-bottom: 12px; flex-wrap: wrap;
  }
  .filter-label {
    font-family: 'Sora', sans-serif; font-size: 12px;
    font-weight: 700; color: var(--text-secondary);
    white-space: nowrap; text-transform: uppercase; letter-spacing: 0.6px;
  }
  .filter-chips { display: flex; gap: 8px; flex-wrap: wrap; }
  .fchip {
    display: inline-flex; align-items: center; gap: 6px;
    padding: 6px 14px; border-radius: 50px;
    border: 1.5px solid var(--border);
    background: var(--bg-card); color: var(--text-secondary);
    font-family: 'Sora', sans-serif; font-size: 12px; font-weight: 600;
    cursor: pointer; transition: all 0.2s; white-space: nowrap;
  }
  .fchip:hover { border-color: var(--pink); color: var(--pink); background: rgba(255,45,141,0.05); }
  .fchip.active { background: var(--primary); border-color: var(--primary); color: #fff; }
  .fchip[data-filter="Lecture"].active  { background: #0B1F66; border-color: #0B1F66; }
  .fchip[data-filter="Tutorial"].active { background: #059669; border-color: #059669; }
  .fchip[data-filter="Workshop"].active { background: #7c3aed; border-color: #7c3aed; }

  /* ── Type badge in table ── */
  .type-badge {
    display: inline-flex; align-items: center;
    padding: 3px 10px; border-radius: 50px;
    font-family: 'Sora', sans-serif; font-size: 11px;
    font-weight: 700; white-space: nowrap;
  }
  .type-lecture  { background: rgba(11,31,102,0.09);  color: #0B1F66; }
  .type-tutorial { background: rgba(5,150,105,0.1);   color: #059669; }
  .type-workshop { background: rgba(124,58,237,0.1);  color: #7c3aed; }

  @media (max-width: 500px) {
    .filter-bar { gap: 8px; }
    .filter-label { font-size: 11px; }
    .fchip { font-size: 11px; padding: 5px 11px; }
  }

  .files-card { min-height: 120px; }

  #filterEmpty {
    display: none; /* Hidden by default */
    justify-content: center;
    padding: 40px;
    color: #888;
}

</style>

<main class="main">
  <div class="main-inner">

    <!-- Hero Card -->
    <div class="hero-card hero-card-compact fade-up d1">

      <div class="hero-tag">
        <a href="../../Default.aspx" class="btn-back-home">
          <svg width="13" height="13" fill="none" stroke="currentColor" stroke-width="2.5" viewBox="0 0 24 24"><path d="M19 12H5M12 5l-7 7 7 7"/></svg>
          Back to Home
        </a>
      </div>

      <div class="hero-row">
        <h1 class="hero-title hero-title-inline">Business <span>English</span></h1>
        <div class="hero-stats hero-stats-inline">
          <div class="stat-item"><span class="stat-val">ENG I</span><span class="stat-lbl">Course Code</span></div>
          <div class="stat-item"><span class="stat-val">8</span><span class="stat-lbl">Topics</span></div>
          <div class="stat-item"><span class="stat-val">3</span><span class="stat-lbl">Credits</span></div>
          <div class="stat-item"><span class="stat-val">128h</span><span class="stat-lbl">Total hrs</span></div>
        </div>
      </div>

      <div class="hero-btns">
        <button type="button" class="btn-view-syl" onclick="openSyllabus()">
          <svg width="14" height="14" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><path d="M1 12s4-8 11-8 11 8 11 8-4 8-11 8-11-8-11-8z"/><circle cx="12" cy="12" r="3"/></svg>
          View Syllabus
        </button>
      </div>
    </div>

    <!-- ══ NOTES / PAST PAPERS TABS ══ -->
    <div class="fade-up d2">
      <div class="section-head">
        <div class="content-tabs">
          <button type="button" class="ctab-btn active" id="tabNotes" onclick="switchTab('notes')">
            <svg width="14" height="14" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><path d="M14 2H6a2 2 0 00-2 2v16a2 2 0 002 2h12a2 2 0 002-2V8z"/><polyline points="14 2 14 8 20 8"/></svg>
            Downloadable Notes
          </button>
          <button type="button" class="ctab-btn" id="tabPapers" onclick="switchTab('papers')">
            <svg width="14" height="14" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><rect x="3" y="3" width="18" height="18" rx="2"/><path d="M3 9h18M9 21V9"/></svg>
            Past Papers
          </button>
        </div>
      </div>

      <%-- NOTES PANEL --%>
      <div id="panelNotes">

        <%-- Filter chips --%>
        <div class="filter-bar">
          <span class="filter-label">Filter by type:</span>
          <div class="filter-chips">
            <button type="button" class="fchip active" data-filter="all" onclick="filterNotes(this,'all')">
              All
            </button>
            <button type="button" class="fchip" data-filter="Lecture" onclick="filterNotes(this,'Lecture')">
              <svg width="12" height="12" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><rect x="3" y="3" width="18" height="13" rx="2"/><path d="M8 21h8M12 17v4"/></svg>
              Lecture Slides
            </button>
            <button type="button" class="fchip" data-filter="Tutorial" onclick="filterNotes(this,'Tutorial')">
              <svg width="12" height="12" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><path d="M17 21v-2a4 4 0 00-4-4H5a4 4 0 00-4 4v2"/><circle cx="9" cy="7" r="4"/><path d="M23 21v-2a4 4 0 00-3-3.87M16 3.13a4 4 0 010 7.75"/></svg>
              Tutorial Slides
            </button>
            <button type="button" class="fchip" data-filter="Workshop" onclick="filterNotes(this,'Workshop')">
              <svg width="12" height="12" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><path d="M14.7 6.3a1 1 0 000 1.4l1.6 1.6a1 1 0 001.4 0l3.77-3.77a6 6 0 01-7.94 7.94l-6.91 6.91a2.12 2.12 0 01-3-3l6.91-6.91a6 6 0 017.94-7.94l-3.76 3.76z"/></svg>
              Workshop Slides
            </button>
          </div>
        </div>

         <div class="files-card" id="notesTable">
    <asp:GridView ID="GridViewNotes" runat="server" 
        AutoGenerateColumns="False" 
        CssClass="table table-bordered table-condensed table-hover" 
        ShowHeader="True" 
        OnRowDataBound="GridView_RowDataBound">
        <Columns>
            
            <%-- 1. Dynamic Type Badge Column with Header --%>
            <asp:TemplateField HeaderText="Type">
                <ItemTemplate>
                    <span class="type-badge type-<%# Eval("FileCategory").ToString().ToLower().Split(' ')[0] %>">
                        <%# Eval("FileCategory") %>
                    </span>
                </ItemTemplate>
            </asp:TemplateField>
            
            <%-- 2. Bound Fields with Headers --%>
            <asp:BoundField DataField="Name" HeaderText="File Name" />
            <asp:BoundField DataField="Topic" HeaderText="Topic" />
            
            <%-- 3. Link Button Column with Header and Lowercase id --%>
            <asp:TemplateField ItemStyle-HorizontalAlign="Center" HeaderText="Download and View">
                <ItemTemplate>
                    <asp:LinkButton ID="lnkDownload" runat="server" Text="Download" 
                        OnClick="DownloadFile" CommandArgument='<%# Eval("id") %>' 
                        CssClass="btn btn-success"></asp:LinkButton>
                </ItemTemplate>
                <ItemStyle HorizontalAlign="Center"></ItemStyle>
            </asp:TemplateField>
            
        </Columns>
    </asp:GridView>
</div>

        <%-- Empty state shown when filter returns no results --%>
        <div class="empty-state" id="filterEmpty" style="display:none;">
          <div class="empty-icon">🔍</div>
          <div class="empty-title">No slides found</div>
          <div class="empty-text">No notes match the selected filter. Try a different type.</div>
        </div>

      </div>

      <%-- PAST PAPERS PANEL --%>
<div class="files-card" id="panelPapers" style="display: none;">
    <asp:GridView ID="GridViewPapers" runat="server" 
        AutoGenerateColumns="False" 
        CssClass="table table-bordered table-condensed table-hover" 
        ShowHeader="True">
        <Columns>
            
            <%-- 1. Type Badge Column with Header --%>
            <asp:TemplateField HeaderText="Type">
                <ItemTemplate>
                    <span class="type-badge type-past">
                        Past Paper
                    </span>
                </ItemTemplate>
            </asp:TemplateField>
            
            <%-- 2. Bound Fields with Headers --%>
            <asp:BoundField DataField="Name" HeaderText="File Name" />
            <asp:BoundField DataField="Topic" HeaderText="Topic" />
            
            <%-- 3. Download Link Button with Header and Centering --%>
            <asp:TemplateField ItemStyle-HorizontalAlign="Center" HeaderText="Download and View">
                <ItemTemplate>
                    <asp:LinkButton ID="lnkDownload" runat="server" Text="Download" 
                        OnClick="DownloadFile" CommandArgument='<%# Eval("id") %>' 
                        CssClass="btn btn-success"></asp:LinkButton>
                </ItemTemplate>
                <ItemStyle HorizontalAlign="Center"></ItemStyle>
            </asp:TemplateField>

        </Columns>
    </asp:GridView>
</div>
</div>
  </div>
</main>

<!-- ══ SYLLABUS MODAL ══ -->
<div class="syl-modal-bg" id="sylModal">
  <div class="syl-modal">
    <div class="syl-modal-header">
      <span class="syl-modal-title">📋 Business English — Course Syllabus (BIT 113)</span>
      <button class="syl-modal-close" type="button" onclick="closeSyllabus()" title="Close">&times;</button>
    </div>
    <div class="syl-modal-body">
      <div class="syl-preview">
        <div class="syl-doc-table">

          <div class="syl-row-doc">
            <div class="syl-num">1</div>
            <div class="syl-cell"><strong>Name of Course/Module:</strong> Business English</div>
          </div>

          <div class="syl-row-doc">
            <div class="syl-num">2</div>
            <div class="syl-cell"><strong>Course Code:</strong> BIT 113</div>
          </div>

          <div class="syl-row-doc">
            <div class="syl-num">3</div>
            <div class="syl-cell"><strong>Name(s) of Academic Staff:</strong> <span style="color:#888">—</span></div>
          </div>

          <div class="syl-row-doc">
            <div class="syl-num">4</div>
            <div class="syl-cell"><strong>Rationale:</strong> This course module helps to provide the basic language skills to the students and teach them concepts in reading, writing and grammar. This course will also introduce students to new vocabulary and writing styles.</div>
          </div>

          <div class="syl-row-doc">
            <div class="syl-num">5</div>
            <div class="syl-cell"><strong>Semester and Year Offered:</strong> Year 1, Semester 1</div>
          </div>

          <div class="syl-row-doc">
            <div class="syl-num">6</div>
            <div class="syl-cell">
              <strong>Course Hours:</strong>
              <table class="syl-inner-table">
                <thead>
                  <tr><th>L (Lecture)</th><th>T (Tutorial)</th><th>P (Practical)</th><th>O (Others)</th><th>ILT</th><th>TSLT</th></tr>
                </thead>
                <tbody>
                  <tr><td>45</td><td>16</td><td>—</td><td>6</td><td>61</td><td>128</td></tr>
                </tbody>
              </table>
            </div>
          </div>

          <div class="syl-row-doc">
            <div class="syl-num">7</div>
            <div class="syl-cell"><strong>Credit Value:</strong> 3</div>
          </div>

          <div class="syl-row-doc">
            <div class="syl-num">8</div>
            <div class="syl-cell"><strong>Prerequisite:</strong> Nil</div>
          </div>

          <div class="syl-row-doc">
            <div class="syl-num">9</div>
            <div class="syl-cell">
              <strong>Course Learning Outcomes:</strong> On completion of this course students will be able to:
              <ul>
                <li>Analyze the relationship among ideas in written material.</li>
                <li>Use critical reasoning skills to evaluate what they are reading.</li>
                <li>Apply study skills to reading assignments.</li>
                <li>Observe standard mechanical conventions such as spelling and punctuation.</li>
              </ul>
            </div>
          </div>

          <div class="syl-row-doc">
            <div class="syl-num">10</div>
            <div class="syl-cell">
              <strong>Transferable Skills:</strong>
              <ul>
                <li>Critical Thinking and problem solving skills</li>
                <li>Communication skills</li>
                <li>Ethics, moral and professionalism</li>
                <li>Information management and lifelong learning</li>
              </ul>
            </div>
          </div>

          <div class="syl-row-doc">
            <div class="syl-num">11</div>
            <div class="syl-cell">
              <strong>Teaching, Learning and Assessment Strategy:</strong>
              <ul>
                <li>Lectures</li>
                <li>Tutorials</li>
              </ul>
              At the end of the programme, students are given an opportunity to evaluate the course and the lecturer.
            </div>
          </div>

          <div class="syl-row-doc">
            <div class="syl-num">12</div>
            <div class="syl-cell"><strong>Synopsis:</strong> Through the use of literature this course will give the students a greater understanding of the English language. There will be focus on paragraph writing and light research topics.</div>
          </div>

          <div class="syl-row-doc">
            <div class="syl-num">13</div>
            <div class="syl-cell"><strong>Mode of Delivery:</strong> Lectures, Tutorials.</div>
          </div>

          <div class="syl-row-doc">
            <div class="syl-num">14</div>
            <div class="syl-cell">
              <strong>Assessment Methods and Types:</strong>
              <table class="syl-inner-table">
                <tbody>
                  <tr><td>Assignments</td><td>20%</td></tr>
                  <tr><td>Mid Exam</td><td>20%</td></tr>
                  <tr><td>Final Exam</td><td>50%</td></tr>
                  <tr><td>Quiz</td><td>10%</td></tr>
                  <tr><td><strong>Total</strong></td><td><strong>100%</strong></td></tr>
                </tbody>
              </table>
            </div>
          </div>

          <div class="syl-row-doc">
            <div class="syl-num">15</div>
            <div class="syl-cell">
              <strong>Content Outline:</strong>
              <table class="syl-inner-table syl-topics-table">
                <thead>
                  <tr><th>#</th><th>Subject Description</th><th>Lecture</th><th>Tutorial</th><th>ILT</th><th>Total</th></tr>
                </thead>
                <tbody>
                  <tr>
                    <td>1</td>
                    <td>
                      <strong>Grammar</strong>
                      <ul>
                        <li>Verb non-finites</li>
                        <li>To-infinitives and gerund</li>
                        <li>Parts of speech (nouns, pronouns, verbs, adjectives, adverbs, conjunctions, prepositions)</li>
                        <li>Idioms and phrases</li>
                        <li>Punctuation and capitalisation</li>
                        <li>Sentence types (simple, compound, complex)</li>
                        <li>Subject-verb agreement</li>
                        <li>If clause and causatives</li>
                        <li>Parallel structures and faulty sentences</li>
                        <li>Tense, voice and reported speech</li>
                        <li>Articles</li>
                      </ul>
                    </td>
                    <td>12</td><td>2</td><td>14</td><td>28</td>
                  </tr>
                  <tr>
                    <td>2</td>
                    <td>
                      <strong>Negotiating</strong>
                      <ul>
                        <li>Key negotiating language</li>
                        <li>Framing your argument</li>
                        <li>Negotiating with suppliers</li>
                        <li>Negotiating with customers</li>
                      </ul>
                    </td>
                    <td>5</td><td>2</td><td>7</td><td>14</td>
                  </tr>
                  <tr>
                    <td>3</td>
                    <td>
                      <strong>Writing</strong>
                      <ul>
                        <li>Paragraphs and essays</li>
                        <li>Business correspondence</li>
                        <li>Sales letters, enquiries and orders</li>
                        <li>Complaints</li>
                        <li>Memos and notices</li>
                        <li>Advertisements</li>
                        <li>Job applications</li>
                      </ul>
                    </td>
                    <td>7</td><td>2</td><td>9</td><td>18</td>
                  </tr>
                  <tr>
                    <td>4</td>
                    <td>
                      <strong>Meetings</strong>
                      <ul>
                        <li>Charting and setting the agenda</li>
                        <li>Controlling the conversation</li>
                        <li>Turn-taking, listening and note-taking</li>
                        <li>Being diplomatic</li>
                        <li>Agreeing and disagreeing</li>
                      </ul>
                    </td>
                    <td>4</td><td>2</td><td>6</td><td>12</td>
                  </tr>
                  <tr>
                    <td>5</td>
                    <td>
                      <strong>Business Correspondence</strong>
                      <ul>
                        <li>Emails, register and style</li>
                        <li>Standard phrasing</li>
                        <li>Notes and memos</li>
                        <li>Business-specific language</li>
                      </ul>
                    </td>
                    <td>4</td><td>2</td><td>6</td><td>12</td>
                  </tr>
                  <tr>
                    <td>6</td>
                    <td>
                      <strong>Telephoning</strong>
                      <ul>
                        <li>Checking &amp; clarifying information</li>
                        <li>Finance-specific scenarios</li>
                        <li>Listening to different accents and intonation</li>
                      </ul>
                    </td>
                    <td>4</td><td>2</td><td>6</td><td>12</td>
                  </tr>
                  <tr>
                    <td>7</td>
                    <td>
                      <strong>Making Presentations</strong>
                      <ul>
                        <li>Introducing a topic effectively</li>
                        <li>Linking and sequencing ideas</li>
                        <li>Concluding</li>
                        <li>Responding to questions</li>
                      </ul>
                    </td>
                    <td>5</td><td>2</td><td>7</td><td>14</td>
                  </tr>
                  <tr>
                    <td>8</td>
                    <td>
                      <strong>Process Management</strong>
                      <ul>
                        <li>Describing processes</li>
                        <li>Cause and effect</li>
                        <li>Criticizing and recommending</li>
                        <li>Quality assurance and continuous improvement</li>
                      </ul>
                    </td>
                    <td>4</td><td>2</td><td>6</td><td>12</td>
                  </tr>
                  <tr>
                    <td colspan="2"><strong>Total</strong></td>
                    <td>45</td><td>16</td><td>61</td><td>122</td>
                  </tr>
                </tbody>
              </table>
            </div>
          </div>

          <div class="syl-row-doc">
            <div class="syl-num">16</div>
            <div class="syl-cell">
              <strong>Main References:</strong>
              <ul>
                <li>Business English, 13th Edition — Mary Ellen Guffey &amp; Carolyn M. Seefer</li>
                <li>Business English for Success — Scott McLean, Arizona Western College (2011)</li>
              </ul>
            </div>
          </div>

        </div>
      </div>
    </div>
    <div class="syl-modal-footer">
      <button class="btn-outline-syl" type="button" onclick="closeSyllabus()">Close</button>
    </div>
  </div>
</div>

<script>
    function switchTab(tab) {
        var panelNotes = document.getElementById('panelNotes');
        var panelPapers = document.getElementById('panelPapers');
        var tabNotes = document.getElementById('tabNotes');
        var tabPapers = document.getElementById('tabPapers');

        if (tab === 'notes') {
            panelNotes.style.display = '';
            panelPapers.style.display = 'none';
            tabNotes.classList.add('active');
            tabPapers.classList.remove('active');
        } else {
            panelNotes.style.display = 'none';
            panelPapers.style.display = '';
            tabPapers.classList.add('active');
            tabNotes.classList.remove('active');
        }
    }

    // ── Notes filter by Type ──
    function filterNotes(btn, filterType) {
        // 1. Manage Active Class
        document.querySelectorAll('.fchip').forEach(function (c) {
            c.classList.remove('active');
        });
        btn.classList.add('active');

        // 2. Select rows from the GridView table
        var rows = document.querySelectorAll('#notesTable table tr');
        var visible = 0;

        rows.forEach(function (row) {
            // Skip header row if it exists (GridView usually renders <th> or no <td> in first row)
            if (row.querySelector('th')) return;

            var badge = row.querySelector('.type-badge');
            if (!badge) return; // Skip if no badge found in this row

            var badgeText = badge.textContent.trim().toLowerCase();

            // 3. Logic: Match 'all' or check if the badge text contains the filter type
            if (filterType === 'all' || badgeText.includes(filterType.toLowerCase())) {
                row.style.display = '';
                visible++;
            } else {
                row.style.display = 'none';
            }
        });

        // 4. Handle "No Results" state
        var emptyEl = document.getElementById('filterEmpty');
        var tableEl = document.getElementById('notesTable');

        if (visible === 0 && tableEl) {
            tableEl.style.display = 'none';
            if (emptyEl) emptyEl.style.display = 'flex';
        } else if (tableEl) {
            tableEl.style.display = '';
            if (emptyEl) emptyEl.style.display = 'none';
        }
    }

    function openSyllabus() {
        document.getElementById("sylModal").classList.add("open");
        document.body.style.overflow = "hidden";
    }

    function closeSyllabus() {
        document.getElementById("sylModal").classList.remove("open");
        document.body.style.overflow = "";
    }

    document.getElementById("sylModal").addEventListener("click", function (e) {
        if (e.target === this) closeSyllabus();
    });

    document.addEventListener("keydown", function (e) {
        if (e.key === "Escape") closeSyllabus();
    });
</script>

</asp:Content>
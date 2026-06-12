<%@ Page Title="Introduction to C++ Programming - BIT Notes" Language="C#" MasterPageFile="~/Bit_Notes/note.Master" AutoEventWireup="true" CodeBehind="computer_network.aspx.cs" Inherits="Learning_System.Bit_Notes.computer_network" %>

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
    background: var(--primary);
    color: #fff;
    font-family: 'Sora', sans-serif;
    font-size: 13px;
    font-weight: 600;
    padding: 9px 20px;
    border-radius: 10px;
    border: none;
    cursor: pointer;
    transition: background 0.2s, box-shadow 0.2s;
  }
  .btn-view-syl:hover {
    background: var(--secondary);
    box-shadow: 0 4px 14px rgba(11,31,102,0.18);
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

  /* prevent BIT 113 from wrapping */
  .hero-stats-inline .stat-val {
    white-space: nowrap;
  }

  /* ── Pink buttons for View Syllabus ── */
  .btn-view-syl {
    background: var(--pink) !important;
    box-shadow: 0 4px 18px var(--pink-glow);
  }
  .btn-view-syl:hover {
    background: var(--pink-dark) !important;
    box-shadow: 0 6px 24px var(--pink-glow) !important;
  }

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
    min-width: 40px;
    width: 40px;
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

  .syl-cell {
    padding: 12px 16px;
    flex: 1;
  }
  .syl-cell strong { color: #0B1F66; }
  .syl-cell ul {
    margin: 6px 0 0 18px;
    padding: 0;
  }
  .syl-cell ul li { margin-bottom: 3px; }

  /* Inner tables (course hours, assessment, content outline) */
  .syl-inner-table {
    width: 100%;
    border-collapse: collapse;
    margin-top: 10px;
    font-size: 12.5px;
  }
  .syl-inner-table th {
    background: #f0f3fc;
    color: #5a6a99;
    font-weight: 700;
    font-size: 11px;
    letter-spacing: 0.5px;
    text-transform: uppercase;
    padding: 7px 10px;
    text-align: left;
    border: 1px solid #e0e5f0;
  }
  .syl-inner-table td {
    padding: 8px 10px;
    border: 1px solid #e0e5f0;
    vertical-align: top;
  }
  .syl-topics-table td:first-child {
    font-weight: 700;
    text-align: center;
    white-space: nowrap;
    color: #0B1F66;
    width: 30px;
  }
  .syl-topics-table td:nth-child(3),
  .syl-topics-table td:nth-child(4),
  .syl-topics-table td:nth-child(5),
  .syl-topics-table td:nth-child(6) {
    text-align: center;
    white-space: nowrap;
    width: 50px;
  }
  .syl-topics-table td ul {
    margin: 4px 0 0 16px;
    padding: 0;
  }
  .syl-topics-table td ul li {
    margin-bottom: 2px;
    font-size: 12.5px;
  }
  .syl-topics-table td strong {
    display: block;
    color: #0B1F66;
    margin-bottom: 2px;
  }
    background: #f0f3fc;
    font-weight: 700;
    color: #0B1F66;
  }

  /* Mobile: make content table horizontally scrollable */
  @media (max-width: 600px) {
    .syl-num { min-width: 28px; width: 28px; font-size: 11px; padding: 12px 5px; }
    .syl-cell { padding: 10px 10px; font-size: 12.5px; }
    .syl-inner-table { display: block; overflow-x: auto; -webkit-overflow-scrolling: touch; }
    .syl-modal { border-radius: 0; max-height: 100vh; height: 100vh; }
    .syl-modal-bg { padding: 0; align-items: flex-end; }
  }

  /* ── Back to Home link in hero-tag ── */
  .btn-back-home {
    display: inline-flex; align-items: center; gap: 7px;
    color: rgba(255,255,255,0.7);
    text-decoration: none;
    font-family: 'Sora', sans-serif;
    font-size: 12px; font-weight: 600;
    transition: color 0.2s;
  }
  .btn-back-home:hover { color: #fff; text-decoration: none; }

  /* ── Content tabs (Notes / Past Papers) ── */
  .content-tabs {
    display: flex; gap: 6px;
    background: var(--bg-card);
    border: 1px solid var(--border);
    border-radius: 12px;
    padding: 5px;
    margin-bottom: 16px;
    width: 100%;
    max-width: 480px;
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


  /* ── Back to Home link in hero-tag ── */
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
    width: 100%;
    max-width: 480px;
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

  /* ── Hero compact layout ── */
  .hero-card-compact { padding: 28px 36px 28px !important; }
  .hero-deco { display: none !important; }
  .hero-row {
    display: flex; align-items: center;
    justify-content: space-between;
    gap: 32px; margin: 12px 0 20px; flex-wrap: wrap;
  }
  .hero-title-inline {
    font-size: 32px !important;
    white-space: nowrap; margin: 0 !important; line-height: 1.15 !important;
  }
  .hero-stats-inline {
    display: flex !important; align-items: center;
    gap: 0; margin: 0 !important; flex-shrink: 0;
  }
  .hero-stats-inline .stat-val { white-space: nowrap; }
  .btn-view-syl {
    background: var(--pink) !important;
    box-shadow: 0 4px 18px var(--pink-glow);
  }
  .btn-view-syl:hover {
    background: var(--pink-dark) !important;
    box-shadow: 0 6px 24px var(--pink-glow) !important;
  }
  @media (max-width: 860px) {
    .hero-row { flex-direction: column; align-items: flex-start; gap: 14px; }
    .hero-title-inline { white-space: normal; font-size: 24px !important; }
    .hero-stats-inline { flex-wrap: wrap; gap: 8px 0; }
  }
  @media (max-width: 500px) {
    .content-tabs { width: 100%; }
    .ctab-btn { flex: 1; justify-content: center; }
    .hero-card-compact { padding: 20px 18px !important; }
  }

  /* Master Page overrides */
  header { display: none !important; }
  .sidebar { display: none !important; }
  .overlay { display: none !important; }
  body { padding-top: 0 !important; background: var(--bg) !important; }
  .main { margin-left: 0 !important; padding-top: 0 !important; width: 100% !important; }
  .main-inner { padding: 16px 28px 40px !important; }

  /* GridView table */
  .table-bordered { width: 100%; border-collapse: collapse; }
  .table-bordered th {
    background: var(--bg); color: var(--text-secondary);
    font-family: 'Sora', sans-serif; font-size: 11px; font-weight: 700;
    letter-spacing: 0.8px; text-transform: uppercase;
    padding: 12px 16px; border-bottom: 1px solid var(--border); text-align: left;
  }
  .table-bordered td {
    padding: 14px 16px; border-bottom: 1px solid var(--border);
    font-size: 13.5px; color: var(--text-primary); vertical-align: middle;
  }
  .table-bordered tr:last-child td { border-bottom: none; }
  .table-bordered tr:hover td { background: rgba(11,31,102,0.02); }
  .table-bordered .btn-success {
    display: inline-flex; align-items: center; gap: 6px;
    background: var(--primary); color: #fff;
    font-family: 'Sora', sans-serif; font-size: 12px; font-weight: 600;
    padding: 7px 16px; border-radius: 8px; border: none; cursor: pointer;
    text-decoration: none; transition: background 0.2s, box-shadow 0.2s;
  }
  .table-bordered .btn-success:hover {
    background: var(--secondary); box-shadow: 0 4px 14px rgba(11,31,102,0.18); color: #fff;
  }
  .btn-primary {
    background: var(--primary); color: #fff; border: none; border-radius: 8px;
    padding: 8px 20px; font-family: 'Sora', sans-serif;
    font-size: 13px; font-weight: 600; cursor: pointer; transition: background 0.2s;
  }
  .btn-primary:hover { background: var(--secondary); color: #fff; }
  /* ── files-card min height ── */
  .files-card { min-height: 120px; }

  /* ── Filter bar ── */
  .filter-bar {{
    display: flex; align-items: center; gap: 12px;
    margin-bottom: 12px; flex-wrap: wrap;
  }}
  .filter-label {{
    font-family: 'Sora', sans-serif; font-size: 12px; font-weight: 700;
    color: var(--text-secondary); white-space: nowrap;
    text-transform: uppercase; letter-spacing: 0.6px;
  }}
  .filter-chips {{ display: flex; gap: 8px; flex-wrap: wrap; }}
  .fchip {{
    display: inline-flex; align-items: center; gap: 6px;
    padding: 6px 14px; border-radius: 50px;
    border: 1.5px solid var(--border);
    background: var(--bg-card); color: var(--text-secondary);
    font-family: 'Sora', sans-serif; font-size: 12px; font-weight: 600;
    cursor: pointer; transition: all 0.2s; white-space: nowrap;
  }}
  .fchip:hover {{ border-color: var(--pink); color: var(--pink); background: rgba(255,45,141,0.05); }}
  .fchip.active {{ background: var(--primary); border-color: var(--primary); color: #fff; }}
  .fchip[data-filter="Lecture"].active  {{ background: #0B1F66; border-color: #0B1F66; }}
  .fchip[data-filter="Tutorial"].active {{ background: #059669; border-color: #059669; }}
  .fchip[data-filter="Workshop"].active {{ background: #7c3aed; border-color: #7c3aed; }}
  .type-badge {{
    display: inline-flex; align-items: center;
    padding: 3px 10px; border-radius: 50px;
    font-family: 'Sora', sans-serif; font-size: 11px; font-weight: 700; white-space: nowrap;
  }}
  .type-lecture  {{ background: rgba(11,31,102,0.09); color: #0B1F66; }}
  .type-tutorial {{ background: rgba(5,150,105,0.1);  color: #059669; }}
  .type-workshop {{ background: rgba(124,58,237,0.1); color: #7c3aed; }}
  @media (max-width: 500px) {{
    .filter-label {{ font-size: 11px; }}
    .fchip {{ font-size: 11px; padding: 5px 11px; }}
  }}

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
        <h1 class="hero-title hero-title-inline">Introduction to <span>C++ Programming</span></h1>
        <div class="hero-stats hero-stats-inline">
          <div class="stat-item"><span class="stat-val">BIT 6044</span><span class="stat-lbl">Course Code</span></div>
          <div class="stat-item"><span class="stat-val">10</span><span class="stat-lbl">Topics</span></div>
          <div class="stat-item"><span class="stat-val">4</span><span class="stat-lbl">Credits</span></div>
          <div class="stat-item"><span class="stat-val">160h</span><span class="stat-lbl">Total hrs</span></div>
        </div>
      </div>

      <div class="hero-btns">
        <button type="button" class="btn-view-syl" onclick="openSyllabus()">
          <svg width="14" height="14" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><path d="M1 12s4-8 11-8 11 8 11 8-4 8-11 8-11-8-11-8z"/><circle cx="12" cy="12" r="3"/></svg>
          View Syllabus
        </button>
      </div>
    </div>

    <!-- Tabs + Content -->
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

      <div id="panelNotes">

        <div class="filter-bar">
          <span class="filter-label">Filter by type:</span>
          <div class="filter-chips">
            <button type="button" class="fchip active" data-filter="all" onclick="filterNotes(this,'all')">All</button>
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
          <asp:GridView ID="GridView1" runat="server"
              CssClass="table table-bordered table-condensed table-hover"
              AutoGenerateColumns="False">
            <Columns>
              <asp:TemplateField HeaderText="Type">
                <ItemTemplate>
                  <span class='<%# "type-badge type-" + Eval("Type").ToString().ToLower() %>'><%# Eval("Type") %></span>
                </ItemTemplate>
              </asp:TemplateField>
              <asp:BoundField DataField="Name" HeaderText="File Name" />
              <asp:BoundField DataField="Topic" HeaderText="Topic" />
              <asp:TemplateField ItemStyle-HorizontalAlign="Center" HeaderText="Download and View">
                <ItemTemplate>
                  <asp:LinkButton ID="lnkDownload" runat="server" Text="Download"
                      OnClick="DownloadFile" CssClass="btn btn-success"
                      CommandArgument='<%# Eval("Id") %>'></asp:LinkButton>
                </ItemTemplate>
                <ItemStyle HorizontalAlign="Center"></ItemStyle>
              </asp:TemplateField>
            </Columns>
          </asp:GridView>
        </div>

        <div class="empty-state" id="filterEmpty" style="display:none;">
          <div class="empty-icon">🔍</div>
          <div class="empty-title">No slides found</div>
          <div class="empty-text">No notes match the selected filter. Try a different type.</div>
        </div>

      </div>

      <div class="files-card" id="panelPapers" style="display:none;">
        <div class="empty-state">
          <div class="empty-icon">📄</div>
          <div class="empty-title">Past Papers Coming Soon</div>
          <div class="empty-text">Past year question papers for Introduction to C++ Programming will be added once available from the teacher.</div>
        </div>
      </div>
    </div>

  </div>
</main>

<!-- Syllabus Modal -->
<div class="syl-modal-bg" id="sylModal">
  <div class="syl-modal">
    <div class="syl-modal-header">
      <span class="syl-modal-title">📋 Introduction to C++ Programming — Course Syllabus (BIT 114)</span>
      <button class="syl-modal-close" type="button" onclick="closeSyllabus()" title="Close">&times;</button>
    </div>
    <div class="syl-modal-body">
      <div class="syl-preview">
        <div class="syl-doc-table">

          <div class="syl-row-doc">
            <div class="syl-num">1</div>
            <div class="syl-cell"><strong>Course Name:</strong> Introduction to C++ Programming</div>
          </div>
          <div class="syl-row-doc">
            <div class="syl-num">2</div>
            <div class="syl-cell"><strong>Course Code:</strong> BIT 114</div>
          </div>
          <div class="syl-row-doc">
            <div class="syl-num">3</div>
            <div class="syl-cell"><strong>Credit Value:</strong> 4</div>
          </div>
          <div class="syl-row-doc">
            <div class="syl-num">4</div>
            <div class="syl-cell"><strong>Semester:</strong> Year 1, Semester 1</div>
          </div>
          <div class="syl-row-doc">
            <div class="syl-num">5</div>
            <div class="syl-cell"><strong>Synopsis:</strong> This course introduces students to structured and object-oriented programming using C++. Students will develop problem-solving skills through hands-on coding exercises.</div>
          </div>
          <div class="syl-row-doc">
            <div class="syl-num">6</div>
            <div class="syl-cell"><strong>Content Outline:</strong>
              <table class="syl-inner-table syl-topics-table">
                <thead><tr><th>#</th><th>Topic</th></tr></thead>
                <tbody>
                  <tr><td>1</td><td><strong>Introduction to C++</strong><ul><li>History and overview</li><li>Structure of a C++ program</li><li>Compilation and execution</li></ul></td></tr>
                  <tr><td>2</td><td><strong>Data Types &amp; Variables</strong><ul><li>Primitive types</li><li>Constants and literals</li><li>Type casting</li></ul></td></tr>
                  <tr><td>3</td><td><strong>Control Structures</strong><ul><li>If-else, switch</li><li>For, while, do-while loops</li><li>Break and continue</li></ul></td></tr>
                  <tr><td>4</td><td><strong>Functions</strong><ul><li>Function declaration and definition</li><li>Parameters and return types</li><li>Recursion</li></ul></td></tr>
                  <tr><td>5</td><td><strong>Arrays &amp; Strings</strong><ul><li>1D and 2D arrays</li><li>String manipulation</li><li>Array algorithms</li></ul></td></tr>
                  <tr><td>6</td><td><strong>Pointers</strong><ul><li>Pointer basics</li><li>Pointer arithmetic</li><li>Pointers and arrays</li></ul></td></tr>
                  <tr><td>7</td><td><strong>Structures &amp; Unions</strong><ul><li>Defining structures</li><li>Nested structures</li><li>Unions</li></ul></td></tr>
                  <tr><td>8</td><td><strong>OOP Concepts</strong><ul><li>Classes and objects</li><li>Encapsulation</li><li>Inheritance and polymorphism</li></ul></td></tr>
                  <tr><td>9</td><td><strong>File Handling</strong><ul><li>File streams</li><li>Reading and writing files</li><li>Error handling</li></ul></td></tr>
                  <tr><td>10</td><td><strong>Exception Handling</strong><ul><li>Try, catch, throw</li><li>Standard exceptions</li><li>Custom exceptions</li></ul></td></tr>
                </tbody>
              </table></div>
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
            panelNotes.style.display = ''; panelPapers.style.display = 'none';
            tabNotes.classList.add('active'); tabPapers.classList.remove('active');
        } else {
            panelNotes.style.display = 'none'; panelPapers.style.display = '';
            tabPapers.classList.add('active'); tabNotes.classList.remove('active');
        }
    }
    function filterNotes(btn, type) {
        document.querySelectorAll('.fchip').forEach(function (c) { c.classList.remove('active'); });
        btn.classList.add('active');
        var rows = document.querySelectorAll('#notesTable table tbody tr');
        var visible = 0;
        rows.forEach(function (row) {
            if (type === 'all') { row.style.display = ''; visible++; }
            else {
                var badge = row.querySelector('td:first-child .type-badge');
                var rowType = badge ? badge.textContent.trim() : '';
                if (rowType.toLowerCase() === type.toLowerCase()) { row.style.display = ''; visible++; }
                else { row.style.display = 'none'; }
            }
        });
        var emptyEl = document.getElementById('filterEmpty');
        var tableEl = document.getElementById('notesTable');
        if (visible === 0 && rows.length > 0) { tableEl.style.display = 'none'; emptyEl.style.display = 'flex'; }
        else { tableEl.style.display = ''; emptyEl.style.display = 'none'; }
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
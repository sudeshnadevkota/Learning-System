<%@ Page Title="" Language="C#" MasterPageFile="~/Bit_Notes/note.Master" AutoEventWireup="true" CodeBehind="dash.aspx.cs" Inherits="Learning_System.Bit_Notes.dash" %>

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
    gap: 10px;
  }

  .logo-mark {
    width: 36px; height: 36px;
    background: linear-gradient(135deg, var(--primary), var(--pink));
    border-radius: 10px;
    display: flex; align-items: center; justify-content: center;
    font-family: 'Sora', sans-serif;
    font-weight: 800; font-size: 14px; color: white;
    flex-shrink: 0;
  }

  .logo-text {
    display: flex; flex-direction: column;
  }
  .logo-text strong {
    font-family: 'Sora', sans-serif;
    font-size: 14px; font-weight: 800;
    color: var(--primary); line-height: 1.1;
  }
  .logo-text span {
    font-size: 10px; color: var(--text-light); letter-spacing: 0.3px;
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
    max-width: 340px; width: 100%;
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

  .header-actions { display: flex; align-items: center; gap: 8px; }

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
  .sem-header:hover { background: rgba(255,255,255,0.06); color: rgba(255,255,255,0.9); }
  .sem-header.active { background: rgba(255,45,141,0.16); color: white; }
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
  .sem-header.active .sem-icon { background: rgba(255,45,141,0.28); }

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

  /* sidebar course tabs */
  .course-tabs {
    display: flex; gap: 6px;
    padding: 0 8px 14px;
    margin-bottom: 4px;
  }
  .ctab {
    flex: 1; padding: 7px 0;
    border-radius: 8px;
    font-family: 'Sora', sans-serif;
    font-size: 11px; font-weight: 700;
    text-align: center;
    cursor: pointer; transition: var(--ease);
    color: rgba(255,255,255,0.4);
    border: 1px solid rgba(255,255,255,0.07);
    background: rgba(255,255,255,0.04);
    letter-spacing: 0.3px;
  }
  .ctab.active {
    background: var(--pink);
    color: white;
    border-color: transparent;
    box-shadow: 0 3px 12px rgba(255,45,141,0.4);
  }
  .ctab:not(.active):hover {
    background: rgba(255,255,255,0.08);
    color: rgba(255,255,255,0.7);
  }

  /* ══ MAIN ══ */
  .main { margin-left: var(--sidebar-w); padding-top: var(--header-h); min-height: 100vh; width: calc(100% - var(--sidebar-w)); }
  .main-inner { padding: 30px 36px; width: 100%; }


  /* ══ HERO BANNER ══ */
  .hero-banner {
    background: linear-gradient(135deg, #0B1F66 0%, #081547 100%);
    border-radius: 24px;
    padding: 0;
    position: relative; overflow: hidden;
    box-shadow: var(--shadow-lg);
    margin-bottom: 28px;
    display: grid;
    grid-template-columns: 1fr 340px;
    min-height: 28px;
  }

  .hero-banner::before {
    content: '';
    position: absolute; top: -100px; right: 280px;
    width: 420px; height: 420px;
    background: radial-gradient(circle, rgba(245,197,66,0.10) 0%, transparent 65%);
    pointer-events: none;
  }
  .hero-banner::after {
    content: '';
    position: absolute; bottom: -80px; left: 20%;
    width: 300px; height: 300px;
    background: radial-gradient(circle, rgba(8,21,71,0.4) 0%, transparent 70%);
    pointer-events: none;
  }

  /* floating shapes */
  .hero-shapes {
    position: absolute; inset: 0; pointer-events: none; overflow: hidden;
  }
  .shape {
    position: absolute; border-radius: 50%;
    border: 1px solid rgba(255,255,255,0.07);
  }
  .shape-1 { width: 200px; height: 200px; top: -60px; right: 300px; border-color: rgba(245,197,66,0.12); }
  .shape-2 { width: 120px; height: 120px; bottom: -30px; right: 380px; border-color: rgba(255,255,255,0.06); }
  .shape-3 { width: 60px; height: 60px; top: 40px; right: 440px; background: rgba(245,197,66,0.05); border: none; }

  .hero-content {
    padding: 44px 44px 40px;
    display: flex; flex-direction: column;
    justify-content: center;
    position: relative; z-index: 2;
  }

/*  .hero-badge {
    display: inline-flex; align-items: center; gap: 8px;
    background: rgba(255,255,255,0.08);
    border: 1px solid rgba(255,255,255,0.13);
    color: rgba(255,255,255,0.75);
    font-size: 11px; font-weight: 700;
    padding: 5px 14px; border-radius: 50px;
    font-family: 'Sora', sans-serif;
    letter-spacing: 0.5px;
    margin-bottom: 18px;
    width: fit-content;
  }*/

/*  .hero-badge .dot {
    width: 6px; height: 6px; border-radius: 50%;
    background: #F5C542;
    box-shadow: 0 0 6px #F5C542;
    animation: pulse 2s ease-in-out infinite;
  }*/
  @keyframes pulse {
    0%,100% { opacity: 1; transform: scale(1); }
    50% { opacity: 0.5; transform: scale(0.8); }
  }

  .hero-title {
    font-family: 'Sora', sans-serif;
    font-size: 34px; font-weight: 800;
    color: white; line-height: 1.15;
    letter-spacing: -0.8px;
    margin-bottom: 10px;
  }
  .hero-title .highlight { color: #F5C542; }
  .hero-title .separator {
    color: rgba(255,255,255,0.25);
    font-weight: 300; margin: 0 8px;
  }



  .hero-mini-stats {
    display: flex; gap: 0; margin-bottom: 30px;
  }
  .hms-item {
    display: flex; flex-direction: column; gap: 2px;
    padding-right: 22px;
  }
  .hms-item + .hms-item {
    padding-left: 22px;
    border-left: 1px solid rgba(255,255,255,0.1);
  }
  .hms-val {
    font-family: 'Sora', sans-serif;
    font-size: 24px; font-weight: 800; color: white;
  }
  .hms-val span { color: #F5C542; font-size: 16px; }
  .hms-lbl {
    font-size: 10px; font-weight: 600;
    color: rgba(255,255,255,0.38);
    text-transform: uppercase; letter-spacing: 0.9px;
  }


  .btn-pink {
    display: inline-flex; align-items: center; gap: 9px;
    background: var(--pink);
    color: white;
    font-family: 'Sora', sans-serif;
    font-weight: 700; font-size: 13.5px;
    padding: 12px 24px; border-radius: 12px;
    border: none; cursor: pointer;
    transition: var(--ease);
    box-shadow: 0 4px 20px rgba(255,45,141,0.45);
    letter-spacing: 0.2px;
  }
  .btn-pink:hover {
    background: var(--pink-dark);
    transform: translateY(-2px);
    box-shadow: 0 8px 28px rgba(255,45,141,0.55);
  }



  /* illustration panel */
  .hero-visual {
    position: relative; z-index: 2;
    display: flex; align-items: flex-end; justify-content: center;
    padding: 0 20px 0 0;
    overflow: hidden;
  }

  /* SVG illustration placeholder */
  .hero-illustration {
    width: 100%; height: 100%;
    display: flex; align-items: flex-end; justify-content: center;
    position: relative;
  }

  .ilu-glow {
    position: absolute; bottom: 0; left: 50%;
    transform: translateX(-50%);
    width: 260px; height: 120px;
    background: radial-gradient(ellipse, rgba(245,197,66,0.15) 0%, transparent 70%);
    pointer-events: none;
  }

  .student-fig {
    width: 240px; height: 260px;
    position: relative;
    flex-shrink: 0;
  }

  /* floating badges on illustration */
  .ilu-badge {
    position: absolute;
    background: white;
    border-radius: 14px;
    padding: 9px 14px;
    box-shadow: 0 8px 28px rgba(8,21,71,0.22);
    display: flex; align-items: center; gap: 8px;
    white-space: nowrap;
    animation: float 3s ease-in-out infinite;
  }
  .ilu-badge:nth-child(2) { animation-delay: 1.2s; }
  .ilu-badge:nth-child(3) { animation-delay: 2.1s; }

  @keyframes float {
    0%,100% { transform: translateY(0); }
    50% { transform: translateY(-6px); }
  }

  .ib-1 { top: 30px; left: -20px; }
  .ib-2 { top: 110px; right: -24px; }
  .ib-3 { bottom: 68px; left: -30px; }

  .ib-icon {
    width: 30px; height: 30px; border-radius: 8px;
    display: flex; align-items: center; justify-content: center;
    font-size: 15px; flex-shrink: 0;
  }
  .ib-icon.blue { background: rgba(11,31,102,0.1); }
  .ib-icon.pink { background: rgba(255,45,141,0.1); }
  .ib-icon.green { background: rgba(16,185,129,0.1); }
  .ib-txt strong { font-family: 'Sora', sans-serif; font-size: 12px; font-weight: 700; color: var(--primary); display: block; line-height: 1.2; }
  .ib-txt span { font-size: 10px; color: var(--text-secondary); }



  /* ══ COURSE CARDS ══ */
  .course-cards {
    display: grid; grid-template-columns: 1fr 1fr;
    gap: 18px; margin-bottom: 28px;
  }

  .course-card {
    background: white;
    border-radius: 20px;
    border: 2px solid var(--border);
    overflow: hidden;
    box-shadow: var(--shadow-sm);
    transition: var(--ease);
    cursor: pointer;
    position: relative;
  }
  .course-card:hover {
    border-color: var(--pink);
    box-shadow: 0 12px 40px var(--pink-glow);
    transform: translateY(-3px);
  }
  .course-card.selected {
    border-color: var(--pink);
    box-shadow: 0 10px 36px var(--pink-glow);
  }

  .cc-header {
    padding: 22px 24px 18px;
    display: flex; align-items: flex-start; gap: 14px;
    position: relative;
  }

  .cc-icon {
    width: 50px; height: 50px;
    border-radius: 14px;
    display: flex; align-items: center; justify-content: center;
    font-size: 24px; flex-shrink: 0;
  }
  .cc-icon.bit { background: rgba(11,31,102,0.08); }
  .cc-icon.bcs { background: rgba(255,45,141,0.09); }

  .cc-info { flex: 1; }
  .cc-abbr {
    font-family: 'Sora', sans-serif;
    font-size: 22px; font-weight: 800;
    color: var(--primary);
    letter-spacing: -0.5px;
    line-height: 1;
  }
  .cc-name {
    font-size: 11.5px; color: var(--text-secondary);
    margin-top: 4px; line-height: 1.3;
  }

  .cc-badge {
    position: absolute; top: 18px; right: 20px;
    font-size: 10px; font-weight: 700;
    font-family: 'Sora', sans-serif;
    padding: 4px 11px; border-radius: 50px;
    letter-spacing: 0.4px;
  }
  .cc-badge.popular { background: rgba(255,45,141,0.12); color: var(--pink); }
  .cc-badge.new { background: rgba(11,31,102,0.08); color: var(--primary); }

  .cc-divider { height: 1px; background: var(--border); margin: 0 24px; }

  .cc-body { padding: 18px 24px 22px; }

  .cc-desc {
    font-size: 13px; color: var(--text-secondary);
    line-height: 1.6; margin-bottom: 16px;
  }

  .cc-features {
    display: flex; flex-direction: column; gap: 6px;
    margin-bottom: 18px;
  }
  .cc-feat {
    display: flex; align-items: center; gap: 9px;
    font-size: 12.5px; color: var(--text-primary);
  }
  .feat-dot {
    width: 18px; height: 18px; border-radius: 5px;
    background: var(--pink-soft);
    display: flex; align-items: center; justify-content: center;
    flex-shrink: 0;
    font-size: 10px;
  }

  .cc-footer {
    display: flex; align-items: center; justify-content: space-between;
    padding: 14px 24px 16px;
    background: rgba(11,31,102,0.025);
    border-top: 1px solid var(--border);
  }
  .cc-meta {
    display: flex; gap: 16px;
  }
  .cm-item {
    display: flex; flex-direction: column; gap: 1px;
  }
  .cm-val {
    font-family: 'Sora', sans-serif;
    font-size: 15px; font-weight: 700;
    color: var(--primary);
  }
  .cm-lbl {
    font-size: 10px; color: var(--text-light);
    text-transform: uppercase; letter-spacing: 0.7px;
    font-weight: 600;
  }

  .cc-cta {
    display: inline-flex; align-items: center; gap: 8px;
    background: var(--primary);
    color: white;
    font-family: 'Sora', sans-serif;
    font-weight: 700; font-size: 12.5px;
    padding: 10px 18px; border-radius: 10px;
    border: none; cursor: pointer;
    transition: var(--ease);
    letter-spacing: 0.2px;
  }
  .cc-cta:hover { background: var(--pink); box-shadow: 0 4px 16px rgba(255,45,141,0.4); transform: translateY(-1px); }
  .course-card.selected .cc-cta { background: var(--pink); box-shadow: 0 4px 16px rgba(255,45,141,0.35); }



  /* ══ AFFILIATION BANNER ══ */
  .affil-banner {
    background: linear-gradient(135deg, var(--secondary) 0%, var(--primary) 60%, #162077 100%);
    border-radius: 20px;
    padding: 28px 36px;
    display: flex; align-items: center; gap: 32px;
    position: relative; overflow: hidden;
    box-shadow: var(--shadow-md);
    margin-bottom: 28px;
  }
  .affil-banner::before {
    content: '';
    position: absolute; top: -60px; right: -60px;
    width: 260px; height: 260px;
    background: radial-gradient(circle, rgba(255,45,141,0.15) 0%, transparent 65%);
    pointer-events: none;
  }

  .affil-left {
    flex-shrink: 0;
    display: flex; flex-direction: column; gap: 4px;
  }
  .affil-label {
    font-size: 10px; font-weight: 700;
    color: rgba(255,255,255,0.4);
    text-transform: uppercase; letter-spacing: 1.5px;
    font-family: 'Sora', sans-serif;
  }
  .affil-name {
    font-family: 'Sora', sans-serif;
    font-size: 20px; font-weight: 800;
    color: white; letter-spacing: -0.3px;
  }
  .affil-name span { color: var(--pink); }
  .affil-sub {
    font-size: 12px; color: rgba(255,255,255,0.45);
    margin-top: 2px;
  }

  .affil-divider {
    width: 1px; height: 54px;
    background: rgba(255,255,255,0.12);
    flex-shrink: 0;
  }

  .affil-pills {
    display: flex; gap: 10px; flex-wrap: wrap; flex: 1;
  }
  .apill {
    display: inline-flex; align-items: center; gap: 7px;
    background: rgba(255,255,255,0.08);
    border: 1px solid rgba(255,255,255,0.12);
    border-radius: 10px;
    padding: 9px 14px;
    font-size: 12px; font-weight: 500;
    color: rgba(255,255,255,0.75);
    transition: var(--ease);
  }
  .apill:hover { background: rgba(255,255,255,0.14); color: white; border-color: rgba(255,45,141,0.4); }
  .apill-icon { font-size: 15px; }

  .affil-right {
    flex-shrink: 0;
  }

  .btn-learn {
    display: inline-flex; align-items: center; gap: 9px;
    background: white;
    color: var(--primary);
    font-family: 'Sora', sans-serif;
    font-weight: 700; font-size: 13px;
    padding: 12px 22px; border-radius: 12px;
    border: none; cursor: pointer;
    transition: var(--ease);
    box-shadow: 0 4px 16px rgba(0,0,0,0.12);
    white-space: nowrap;
  }
  .btn-learn:hover { background: var(--pink); color: white; transform: translateY(-2px); box-shadow: 0 8px 24px rgba(255,45,141,0.4); }

  /* ══ QUICK STATS ROW ══ */
  .stats-row {
    display: grid; grid-template-columns: repeat(4, 1fr);
    gap: 16px; margin-bottom: 28px;
  }

  .stat-card {
    background: white; border-radius: 16px;
    border: 1.5px solid var(--border);
    padding: 20px;
    display: flex; align-items: center; gap: 14px;
    box-shadow: var(--shadow-sm);
    transition: var(--ease);
  }
  .stat-card:hover {
    border-color: var(--pink);
    box-shadow: 0 6px 24px var(--pink-glow);
    transform: translateY(-2px);
  }
  .sc-icon {
    width: 44px; height: 44px; border-radius: 12px;
    display: flex; align-items: center; justify-content: center;
    font-size: 20px; flex-shrink: 0;
  }
  .sc-icon.blue { background: rgba(11,31,102,0.08); }
  .sc-icon.green { background: rgba(16,185,129,0.1); }
  .sc-icon.pink { background: rgba(255,45,141,0.1); }
  .sc-icon.amber { background: rgba(245,158,11,0.1); }
  .sc-val { font-family: 'Sora', sans-serif; font-size: 22px; font-weight: 700; color: var(--primary); }
  .sc-lbl { font-size: 11px; color: var(--text-secondary); margin-top: 1px; }

  /* ══ ABOUT SECTION ══ */
  .about-section {
    display: grid;
    grid-template-columns: 1fr 360px;
    gap: 32px;
    margin-bottom: 28px;
    align-items: start;
  }

  .about-left {
    background: white;
    border-radius: 22px;
    border: 1.5px solid var(--border);
    padding: 36px 38px 32px;
    box-shadow: var(--shadow-sm);
  }

  .about-label {
    font-size: 11px; font-weight: 700;
    text-transform: uppercase; letter-spacing: 1.8px;
    color: var(--pink);
    font-family: 'Sora', sans-serif;
    margin-bottom: 10px;
  }

  .about-heading {
    font-family: 'Sora', sans-serif;
    font-size: 26px; font-weight: 800;
    color: var(--primary);
    letter-spacing: -0.5px;
    line-height: 1.2;
    margin-bottom: 20px;
  }
  .about-heading span { color: #16a34a; }

  .about-para {
    font-size: 14px;
    color: #374151;
    line-height: 1.75;
    margin-bottom: 14px;
  }
  .about-para strong { color: var(--primary); font-weight: 700; }
  .about-para:last-of-type { margin-bottom: 24px; }

  .about-highlights {
    display: flex; flex-direction: column; gap: 12px;
    margin-bottom: 28px;
    padding: 20px;
    background: var(--bg);
    border-radius: 14px;
    border: 1.5px solid var(--border);
  }

  .ah-card {
    display: flex; align-items: flex-start; gap: 12px;
    padding: 14px 16px;
    background: white;
    border-radius: 12px;
    border: 1px solid var(--border);
    box-shadow: var(--shadow-sm);
    transition: var(--ease);
  }
  .ah-card:hover { border-color: var(--pink); box-shadow: 0 4px 16px var(--pink-glow); }

  .ah-icon {
    width: 38px; height: 38px; border-radius: 10px;
    background: var(--pink-soft);
    display: flex; align-items: center; justify-content: center;
    font-size: 18px; flex-shrink: 0;
  }
  .ah-title {
    font-family: 'Sora', sans-serif;
    font-size: 13px; font-weight: 700;
    color: var(--primary); margin-bottom: 3px;
  }
  .ah-text {
    font-size: 12px; color: var(--text-secondary); line-height: 1.5;
  }

  .about-btns { display: flex; gap: 12px; flex-wrap: wrap; }



  /* ══ POSTER ══ */
  .about-right {
    position: sticky; top: calc(var(--header-h) + 20px);
  }

  .poster-wrap {
    position: relative;
  }
  .poster-glow {
    position: absolute; bottom: -20px; left: 50%;
    transform: translateX(-50%);
    width: 280px; height: 60px;
    background: radial-gradient(ellipse, rgba(255,45,141,0.25) 0%, transparent 70%);
    pointer-events: none;
  }

  .poster-card {
    border-radius: 20px;
    overflow: hidden;
    box-shadow: 0 24px 64px rgba(8,21,71,0.28);
    position: relative;
  }

  .poster-inner {
    background: linear-gradient(160deg, #0047b3 0%, #0B1F66 35%, #081547 70%, #060e33 100%);
    padding: 22px 20px 16px;
    position: relative;
    overflow: hidden;
    min-height: 520px;
  }
  .poster-inner::before {
    content: '';
    position: absolute; top: -80px; right: -60px;
    width: 280px; height: 280px;
    background: radial-gradient(circle, rgba(255,45,141,0.15) 0%, transparent 65%);
    pointer-events: none;
  }
  .poster-inner::after {
    content: '';
    position: absolute; top: 0; left: 0; right: 0; bottom: 0;
    background: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='60' height='60'%3E%3Cpath d='M30 0 L60 30 L30 60 L0 30Z' stroke='rgba(255,255,255,0.03)' fill='none'/%3E%3C/svg%3E") repeat;
    pointer-events: none;
  }

  .poster-logos {
    display: flex; align-items: center; justify-content: space-between;
    margin-bottom: 18px; position: relative; z-index: 2;
  }
  .poster-logo-tx {
    display: flex; align-items: center; gap: 7px;
  }
  .tx-text-wrap { display: flex; flex-direction: column; }
  .tx-name {
    font-family: 'Sora', sans-serif;
    font-size: 17px; font-weight: 900;
    color: white; letter-spacing: -0.3px; line-height: 1;
  }
  .tx-sub { font-size: 8px; color: rgba(255,255,255,0.5); line-height: 1.2; }

  .poster-logo-luc {
    display: flex; align-items: center; gap: 6px;
  }
  .luc-seal {
    width: 28px; height: 28px; border-radius: 50%;
    background: #c8102e;
    display: flex; align-items: center; justify-content: center;
    font-family: 'Sora', sans-serif;
    font-weight: 800; font-size: 8px; color: white;
    border: 2px solid rgba(255,255,255,0.3);
    flex-shrink: 0;
  }
  .luc-name {
    font-size: 8px; font-weight: 700;
    color: rgba(255,255,255,0.75);
    line-height: 1.4;
    font-family: 'Sora', sans-serif;
    letter-spacing: 0.3px;
  }

  .poster-tagline {
    font-family: 'Sora', sans-serif;
    font-size: 11px; font-weight: 600;
    color: rgba(255,255,255,0.65);
    letter-spacing: 1.5px;
    margin-bottom: 2px;
    position: relative; z-index: 2;
  }
  .poster-main-title {
    font-family: 'Sora', sans-serif;
    font-size: 30px; font-weight: 900;
    color: #00c8ff;
    line-height: 1.05;
    letter-spacing: -0.5px;
    margin-bottom: 14px;
    position: relative; z-index: 2;
  }
  .poster-degree-row { display: flex; align-items: center; gap: 12px; position: relative; z-index: 2; }
  .poster-degree-title {
    font-family: 'Sora', sans-serif;
    font-size: 36px; font-weight: 900;
    color: white;
    letter-spacing: -1px;
    line-height: 1;
    position: relative; z-index: 2;
  }
  .poster-degree-sub {
    font-size: 11px; color: rgba(255,255,255,0.6);
    line-height: 1.4; margin-bottom: 16px;
    position: relative; z-index: 2;
  }
  .poster-degree-sub strong { color: rgba(255,255,255,0.9); }

  .poster-why-box {
    background: rgba(255,255,255,0.08);
    border: 1px solid rgba(255,255,255,0.12);
    border-radius: 12px;
    padding: 14px 16px;
    margin-bottom: 14px;
    position: relative; z-index: 2;
    max-width: 175px;
  }
  .pwb-title {
    font-family: 'DM Sans', sans-serif;
    font-size: 13px; color: rgba(255,255,255,0.75);
    margin-bottom: 10px; line-height: 1.4;
  }
  .pwb-title span {
    font-family: 'Sora', sans-serif;
    font-size: 16px; font-weight: 900;
    color: #00c8ff;
  }
  .pwb-item {
    font-size: 11px; color: rgba(255,255,255,0.65);
    margin-bottom: 5px; display: flex; align-items: center; gap: 4px;
  }
  .pwb-item::before { content: ''; }

  .poster-admission {
    position: absolute; bottom: 50px; right: 16px;
    z-index: 3; text-align: right;
  }
  .pa-open {
    font-family: 'Sora', sans-serif;
    font-size: 20px; font-weight: 900;
    color: white; line-height: 1.1;
    letter-spacing: -0.5px;
    text-shadow: 0 2px 8px rgba(0,0,0,0.3);
  }
  .pa-intake {
    font-size: 11px; color: rgba(255,255,255,0.6);
    margin-top: 2px;
  }

  .poster-student {
    position: absolute; bottom: 0; right: -8px;
    z-index: 2;
  }

  .poster-footer {
    border-top: 1px solid rgba(255,255,255,0.1);
    padding-top: 10px;
    margin-top: 4px;
    position: relative; z-index: 2;
  }
  .pf-item {
    font-size: 9.5px; color: rgba(255,255,255,0.5);
    margin-bottom: 3px;
  }

  @media (max-width: 1100px) {
    .about-section { grid-template-columns: 1fr; }
    .about-right { position: static; }
    .poster-card { max-width: 360px; }
  }

  /* ══ FADE ANIMATIONS ══ */
  .fade-up {
    opacity: 0;
    transform: translateY(22px);
    animation: fadeUp 0.55s cubic-bezier(0.22,1,0.36,1) forwards;
  }
  .d1 { animation-delay: 0.05s; }
  .d2 { animation-delay: 0.15s; }
  .d3 { animation-delay: 0.25s; }
  .d4 { animation-delay: 0.35s; }
  .d5 { animation-delay: 0.45s; }
  .d6 { animation-delay: 0.55s; }

  @keyframes fadeUp {
    to { opacity: 1; transform: translateY(0); }
  }

  /* overlay */
  .overlay {
    display: none; position: fixed; inset: 0;
    background: rgba(8,21,71,0.4);
    z-index: 140; backdrop-filter: blur(4px);
  }
  .overlay.show { display: block; }

  /* ══ RESPONSIVE ══ */
  @media (max-width: 1100px) {
    .why-grid { grid-template-columns: repeat(2, 1fr); }
    .affil-banner { flex-wrap: wrap; gap: 20px; }
    .affil-divider { display: none; }
  }

  @media (max-width: 900px) {
    :root { --sidebar-w: 0px; }
    .sidebar { left: -265px; width: 265px; }
    .sidebar.open { left: 0; }
    .main { margin-left: 0; width: 100%; }
    .header-logo { width: auto; border-right: none; }
    .sidebar-toggle { display: flex; }
    .hero-banner { grid-template-columns: 1fr; }
    .hero-visual { display: none; }
    .course-cards { grid-template-columns: 1fr; }
    .stats-row { grid-template-columns: repeat(2, 1fr); }
    .why-grid { grid-template-columns: 1fr; }
  }

  @media (max-width: 600px) {
    .main-inner { padding: 20px 16px; }
    .hero-content { padding: 28px 24px; }
    .hero-title { font-size: 24px; }
    .affil-banner { padding: 20px 20px; }
    .stats-row { grid-template-columns: 1fr 1fr; }
  }


  /* ── Master Page overrides: neutralise standalone layout ── */
  header { display: none !important; }
  .sidebar { display: none !important; }
  .overlay { display: none !important; }
  body { padding-top: 0 !important; background: var(--bg) !important; }
  .main { margin-left: 0 !important; padding-top: 0 !important; width: 100% !important; }
  .main-inner { padding: 24px 32px !important; }

</style>

<main class="main">
  <div class="main-inner">



    <!-- HERO BANNER -->
    <div class="hero-banner fade-up d1">
      <div class="hero-shapes">
        <div class="shape shape-1"></div>
        <div class="shape shape-2"></div>
        <div class="shape shape-3"></div>
      </div>

      <div class="hero-content">
        

        <div class="hero-title">
          Shape the Future<br>
          <span class="highlight">with Technology</span>
        </div>


        <div class="hero-mini-stats">
          <div class="hms-item">
            <div class="hms-val">4<span>yr</span></div>
            <div class="hms-lbl">Program</div>
          </div>
          <div class="hms-item">
            <div class="hms-val">8</div>
            <div class="hms-lbl">Semesters</div>
          </div>
          <div class="hms-item">
            <div class="hms-val">120</div>
            <div class="hms-lbl">Credit Hours</div>
          </div>
          <div class="hms-item">
            <div class="hms-val">7000<span>+</span></div>
            <div class="hms-lbl">Graduates</div>
          </div>
        </div>

     
      </div>

      <!-- ILLUSTRATION PANEL -->
      <div class="hero-visual">
        <div class="hero-illustration">
          <div class="ilu-glow"></div>

          <!-- SVG Student Illustration -->
          <svg class="student-fig" viewBox="0 0 240 280" fill="none" xmlns="http://www.w3.org/2000/svg">
            <!-- body / suit -->
            <rect x="68" y="155" width="104" height="125" rx="14" fill="#1a2e6e"/>
            <!-- shirt / tie area -->
            <rect x="108" y="155" width="24" height="80" rx="4" fill="#0B1F66"/>
            <polygon points="120,162 115,190 120,196 125,190" fill="#FF2D8D"/>
            <!-- collar -->
            <polygon points="108,155 120,175 132,155 118,160" fill="white" opacity="0.9"/>
            <polygon points="132,155 120,175 108,155 122,160" fill="#e0e4f0" opacity="0.9"/>
            <!-- arms -->
            <rect x="38" y="158" width="36" height="92" rx="14" fill="#1a2e6e"/>
            <rect x="166" y="158" width="36" height="92" rx="14" fill="#1a2e6e"/>
            <!-- hand left -->
            <ellipse cx="56" cy="256" rx="16" ry="12" fill="#f5c5a3"/>
            <!-- hand right holding cube -->
            <ellipse cx="184" cy="253" rx="16" ry="12" fill="#f5c5a3"/>
            <!-- rubiks cube -->
            <rect x="188" y="228" width="38" height="38" rx="6" fill="#222"/>
            <rect x="190" y="230" width="10" height="10" rx="2" fill="#FF2D8D"/>
            <rect x="203" y="230" width="10" height="10" rx="2" fill="#4ade80"/>
            <rect x="216" y="230" width="8" height="10" rx="2" fill="#60a5fa"/>
            <rect x="190" y="243" width="10" height="10" rx="2" fill="#fbbf24"/>
            <rect x="203" y="243" width="10" height="10" rx="2" fill="#FF2D8D"/>
            <rect x="216" y="243" width="8" height="10" rx="2" fill="#4ade80"/>
            <rect x="190" y="256" width="10" height="8" rx="2" fill="#60a5fa"/>
            <rect x="203" y="256" width="10" height="8" rx="2" fill="#fbbf24"/>
            <rect x="216" y="256" width="8" height="8" rx="2" fill="#FF2D8D"/>
            <!-- neck -->
            <rect x="108" y="132" width="24" height="28" rx="8" fill="#f5c5a3"/>
            <!-- head -->
            <ellipse cx="120" cy="110" rx="46" ry="50" fill="#f5c5a3"/>
            <!-- hair -->
            <path d="M74 96 Q76 52 120 50 Q164 52 166 96 Q155 72 120 70 Q85 72 74 96Z" fill="#2d1a08"/>
            <!-- bun -->
            <ellipse cx="120" cy="55" rx="20" ry="14" fill="#2d1a08"/>
            <!-- facial features -->
            <ellipse cx="108" cy="114" rx="6" ry="7" fill="white"/>
            <ellipse cx="132" cy="114" rx="6" ry="7" fill="white"/>
            <ellipse cx="109" cy="115" rx="3.5" ry="4" fill="#1a0a0a"/>
            <ellipse cx="133" cy="115" rx="3.5" ry="4" fill="#1a0a0a"/>
            <ellipse cx="110" cy="114" rx="1.5" ry="2" fill="white"/>
            <ellipse cx="134" cy="114" rx="1.5" ry="2" fill="white"/>
            <!-- smile -->
            <path d="M112 128 Q120 135 128 128" stroke="#c27a5a" stroke-width="2" fill="none" stroke-linecap="round"/>
            <!-- eyebrows -->
            <path d="M102 107 Q108 104 114 106" stroke="#2d1a08" stroke-width="2.5" fill="none" stroke-linecap="round"/>
            <path d="M126 106 Q132 104 138 107" stroke="#2d1a08" stroke-width="2.5" fill="none" stroke-linecap="round"/>
            <!-- laptop on lap -->
            <rect x="72" y="236" width="96" height="6" rx="3" fill="#374151"/>
            <rect x="78" y="208" width="84" height="30" rx="4" fill="#1f2937"/>
            <rect x="80" y="210" width="80" height="26" rx="3" fill="#0B1F66"/>
            <!-- code lines on screen -->
            <rect x="84" y="214" width="28" height="2" rx="1" fill="#FF2D8D" opacity="0.8"/>
            <rect x="84" y="219" width="44" height="2" rx="1" fill="#60a5fa" opacity="0.7"/>
            <rect x="84" y="224" width="36" height="2" rx="1" fill="#4ade80" opacity="0.7"/>
            <rect x="84" y="229" width="20" height="2" rx="1" fill="#fbbf24" opacity="0.7"/>
          </svg>

          <!-- Floating badges -->
          <div class="ilu-badge ib-1">
            <div class="ib-icon blue">🎓</div>
            <div class="ib-txt">
              <strong>MQA Accredited</strong>
              <span>Internationally recognised</span>
            </div>
          </div>

          <div class="ilu-badge ib-2">
            <div class="ib-icon pink">🔐</div>
            <div class="ib-txt">
              <strong>CEH & CHFI Lab</strong>
              <span>Hands-on security</span>
            </div>
          </div>

          <div class="ilu-badge ib-3">
            <div class="ib-icon green">💼</div>
            <div class="ib-txt">
              <strong>92% Placement</strong>
              <span>2024 cohort</span>
            </div>
          </div>
        </div>
      </div>
    </div>

    <!-- ABOUT THE PROGRAM: two-column prose + poster -->
    <div class="about-section fade-up d2" id="coursesSection">
      <div class="about-left">
        <div class="about-label">About the Program</div>
        <h2 class="about-heading">Nepal's Premier <span>BIT Degree</span></h2>

        <p class="about-para">
        The <strong>Bachelor of Information Technology (BIT)</strong> at Texas College of Management and IT (TCMIT) is a 4-year, 8-semester program affiliated with <strong> Lincoln University College, Malaysia</strong>. Designed to blend technical theory with practical execution, the program covers software development, networking, databases, cloud computing, AI, and DevOps. With modern facilities like our IoT & Robotics labs, VFX Studio, and Incubation Center, students gain hands-on experience through project work and industry training to graduate completely career-ready
        </p>
        <p class="about-para">

        To ensure our students are industry-ready from day one, Texas College integrates structured, After-Class Professional Classes directly into the academic timeline. Students will kickstart their first semester with foundational web design in <strong>HTML/CSS alongside hands-on IoT & Robotics engineering</strong>. Moving into the second semester, they will begin building dynamic applications using React and Node.js, which seamlessly scales into your third and fourth semesters with<strong> Advanced React, Node.js with Express, and Python Django</strong>. By the fifth semester and leading up to graduation, they will master the full MERN Stack to handle enterprise-level architectures.
        </p>
       <p class="about-para">
           Alongside this core development track, students' journey includes specialized industry certifications to make you globally competitive. You will dive into professional<strong> Cisco Training and UI/UX / Multimedia design workshops, build cross-platform mobile apps with React Native, and master Cybersecurity Essentials</strong>. Finally, students will achieve production-ready expertise in Cloud Foundations and Cloud Architecting running on Linux 9.0. This progressive curriculum aligns beautifully with the semester-by-semester navigation, giving prospective students a clear, exciting view of their technical future.
       </p>
        

        <div class="about-btns">

        </div>
      </div>

      <div class="about-right">
        <div class="poster-wrap">
          <div class="poster-card">
            <div class="poster-inner">
              <div class="poster-logos">
                <div class="poster-logo-tx">
                  
                  <div class="tx-text-wrap">
                    <span class="tx-name">Texas</span>
                    <span class="tx-sub">College of Management &amp; IT</span>
                  </div>
                </div>
                <div class="poster-logo-luc">
                  <div class="luc-seal">LUC</div>
                  <span class="luc-name">LINCOLN<br>UNIVERSITY<br>COLLEGE</span>
                </div>
              </div>

              <div class="poster-tagline">SHAPE THE FUTURE</div>
              <div class="poster-main-title">WITH<br>TECHNOLOGY</div>
              <div class="poster-degree-row">
                <div class="poster-degree-title">BIT</div>
              </div>
              <div class="poster-degree-sub">Bachelor of (Hons.) in<br><strong>Information Technology</strong></div>

              <div class="poster-why-box">
                <div class="pwb-title">Discover <span>BIT</span>at Texas</div>
                <div class="pwb-item">▶ Learn by Building Real Projects</div>
                <div class="pwb-item">▶ Professional Skill Development</div>
                <div class="pwb-item">▶ Career &amp; Internship Opportunities</div>
                <div class="pwb-item">▶ Workshops, Seminars &amp; Tech Events</div>
                <div class="pwb-item">▶ Advanced IT Labs</div>
              </div>

              <div class="poster-admission">
                <div class="pa-open">ADMISSION<br>OPEN 2026</div>

              </div>

              <div class="poster-student">
                <svg viewBox="0 0 160 270" fill="none" xmlns="http://www.w3.org/2000/svg" width="155" height="270">
                  <rect x="38" y="125" width="84" height="145" rx="12" fill="#1e3a8a"/>
                  <rect x="72" y="125" width="16" height="70" rx="3" fill="#1a2e6e"/>
                  <polygon points="80,131 76,155 80,160 84,155" fill="#FF2D8D"/>
                  <polygon points="72,125 80,142 88,125 79,129" fill="white" opacity="0.85"/>
                  <rect x="16" y="128" width="28" height="84" rx="12" fill="#1e3a8a"/>
                  <rect x="116" y="128" width="28" height="84" rx="12" fill="#1e3a8a"/>
                  <ellipse cx="30" cy="218" rx="13" ry="10" fill="#f5c5a3"/>
                  <ellipse cx="130" cy="216" rx="13" ry="10" fill="#f5c5a3"/>
                  <rect x="132" y="188" width="32" height="32" rx="5" fill="#111"/>
                  <rect x="134" y="190" width="9" height="9" rx="2" fill="#FF2D8D"/>
                  <rect x="145" y="190" width="9" height="9" rx="2" fill="#4ade80"/>
                  <rect x="134" y="201" width="9" height="9" rx="2" fill="#fbbf24"/>
                  <rect x="145" y="201" width="9" height="9" rx="2" fill="#60a5fa"/>
                  <rect x="134" y="212" width="9" height="6" rx="2" fill="#a78bfa"/>
                  <rect x="145" y="212" width="9" height="6" rx="2" fill="#FF2D8D"/>
                  <rect x="72" y="103" width="16" height="26" rx="7" fill="#f5c5a3"/>
                  <ellipse cx="80" cy="82" rx="36" ry="40" fill="#f5c5a3"/>
                  <path d="M44 72 Q46 34 80 32 Q114 34 116 72 Q106 50 80 52 Q54 50 44 72Z" fill="#2d1a08"/>
                  <ellipse cx="80" cy="36" rx="18" ry="12" fill="#2d1a08"/>
                  <ellipse cx="68" cy="86" rx="5.5" ry="6.5" fill="white"/>
                  <ellipse cx="92" cy="86" rx="5.5" ry="6.5" fill="white"/>
                  <ellipse cx="69" cy="87" rx="3.2" ry="3.8" fill="#1a0a0a"/>
                  <ellipse cx="93" cy="87" rx="3.2" ry="3.8" fill="#1a0a0a"/>
                  <ellipse cx="70" cy="86" rx="1.3" ry="1.6" fill="white"/>
                  <ellipse cx="94" cy="86" rx="1.3" ry="1.6" fill="white"/>
                  <path d="M73 100 Q80 107 87 100" stroke="#c27a5a" stroke-width="1.8" fill="none" stroke-linecap="round"/>
                  <path d="M62 78 Q68 75 74 77" stroke="#2d1a08" stroke-width="2" fill="none" stroke-linecap="round"/>
                  <path d="M86 77 Q92 75 98 78" stroke="#2d1a08" stroke-width="2" fill="none" stroke-linecap="round"/>
                </svg>
              </div>

              <div class="poster-footer">
                <div class="pf-item">📍 Sifal, Chabahil, Kathmandu</div>
                <div class="pf-item">📞 01-4589134 | 9801644458</div>
                <div class="pf-item">🌐 www.texascollege.edu.np</div>
              </div>
            </div>
          </div>
          <div class="poster-glow"></div>
        </div>
      </div>
    </div>

    <!-- AFFILIATION BANNER -->
    <div class="affil-banner fade-up d4">
      <div class="affil-left">
        <div class="affil-label">Affiliated with</div>
        <div class="affil-name">Lincoln University <span>College</span></div>
        <div class="affil-sub">Petaling Jaya, Malaysia · Est. 2002</div>
      </div>

      <div class="affil-divider"></div>

      <div class="affil-pills">
        <div class="apill"><span class="apill-icon">✅</span> MQA Accredited</div>
        <div class="apill"><span class="apill-icon">🎓</span> TU Equivalent</div>
        <div class="apill"><span class="apill-icon">📜</span> MoE Approved</div>
        <div class="apill"><span class="apill-icon">🌏</span> Globally Recognised</div>
        <div class="apill"><span class="apill-icon">🏆</span> Top-ranked College</div>
      </div>

     <div class="affil-right">
  <a href="https://www.lincoln.edu.my" target="_blank" rel="noopener noreferrer" class="btn-learn" style="text-decoration: none; display: inline-flex; align-items: center; gap: 8px;">
    Learn More
    <svg width="13" height="13" fill="none" stroke="currentColor" stroke-width="2.5" viewBox="0 0 24 24">
      <path d="M18 13v6a2 2 0 01-2 2H5a2 2 0 01-2-2V8a2 2 0 012-2h6"/>
      <polyline points="15 3 21 3 21 9"/>
      <line x1="10" y1="14" x2="21" y2="3"/>
    </svg>
  </a>
</div>
    </div>

  
   

  </div>
</main>

<script>
    const semesterData = [
        { label: "First Sem", icon: "1️⃣", subjects: ["Discrete Maths", "C Programming", "Digital Logic", "Physics", "English"] },
        { label: "Second Sem", icon: "2️⃣", subjects: ["Data Structures", "OOP (Java)", "Calculus", "Statistics", "Microprocessor"] },
        { label: "Third Sem", icon: "3️⃣", subjects: ["DBMS", "Computer Networks", "OS", "Web Tech", "Numerical Methods"] },
        { label: "Fourth Sem", icon: "4️⃣", subjects: ["Software Engineering", "AI", "Computer Graphics", "Theory of Computation", "Management Info Sys"] },
        { label: "Fifth Sem", icon: "5️⃣", subjects: ["Advanced Java", "Cloud Computing", "Mobile App Dev", "Information Security", "Project Mgmt"] },
        { label: "Sixth Sem", icon: "6️⃣", subjects: ["Machine Learning", "Big Data", "DevOps", "IoT", "Research Methods"] },
        { label: "Seventh Sem", icon: "7️⃣", subjects: ["Capstone Project", "Internship", "Elective I", "Elective II", "Advanced Topics"] },
        { label: "Eighth Sem", icon: "8️⃣", subjects: ["Final Project", "Dissertation", "Viva Voce", "Elective III"] },
    ];

    const menu = document.getElementById('semMenu');
    semesterData.forEach((sem, i) => {
        const el = document.createElement('div');
        el.className = 'sem-item' + (i === 0 ? ' open' : '');
        el.innerHTML = `
      <div class="sem-header${i === 0 ? ' active' : ''}" onclick="toggleSem(this)">
        <div class="sem-icon">${sem.icon}</div>
        <span class="sem-label">${sem.label}</span>
        <svg class="sem-chevron" width="13" height="13" fill="none" stroke="currentColor" stroke-width="2.5" viewBox="0 0 24 24"><path d="M19 9l-7 7-7-7"/></svg>
      </div>
      <div class="sem-subjects">
        ${sem.subjects.map((s, j) => `<div class="subject-link${i === 0 && j === 0 ? ' active' : ''}" onclick="pickSubject(this)"><div class="subject-dot"></div>${s}</div>`).join('')}
      </div>`;
        menu?.appendChild(el);
    });

    function toggleSem(el: any) {
        el.parentElement.classList.toggle('open');
    }

    function pickSubject(el: any) {
        document.querySelectorAll('.subject-link').forEach(l => l.classList.remove('active'));
        el.classList.add('active');
        if (window.innerWidth < 900) closeSidebar();
    }

    function scrollToCourses() {
        document.getElementById('coursesSection')?.scrollIntoView({ behavior: 'smooth', block: 'start' });
    }

    // function toggleSidebar() {
    //     document.getElementById('sidebar').classList.toggle('open');
    //     document.getElementById('overlay').classList.toggle('show');
    // }

    function closeSidebar() {
        document.getElementById('sidebar')?.classList.remove('open');
        document.getElementById('overlay')?.classList.remove('show');
    }
</script>

</asp:Content>
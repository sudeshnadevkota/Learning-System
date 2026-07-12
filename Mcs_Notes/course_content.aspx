<%@ Page Title="Object Oriented Programming - MCS Notes" Language="C#" MasterPageFile="~/Mcs_Notes/note.Master" AutoEventWireup="true" CodeBehind="course_content.aspx.cs" Inherits="Learning_System.Mcs_Notes.course_content" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

<link rel="stylesheet" type="text/css" href="<%= ResolveUrl("~/Bit_Notes/Css/note.css") %>" />

<style>
    /* ===== Status Banner (shared base for login + dept-denied) ===== */
    .status-banner-wrapper {
        display: block !important;
        width: 100% !important;
        margin: 24px 0 40px 0 !important;
        box-sizing: border-box !important;
    }

    .status-banner-wrapper .status-banner-card {
        border-radius: 20px !important;
        padding: 44px 56px !important;
        width: 100% !important;
        text-align: left !important;
        position: relative !important;
        overflow: hidden !important;
        box-sizing: border-box !important;
        display: flex !important;
        align-items: center !important;
        justify-content: space-between !important;
        gap: 32px !important;
        flex-wrap: wrap !important;
    }

    .status-banner-wrapper .status-banner-left {
        display: flex !important;
        align-items: center !important;
        gap: 22px !important;
        position: relative !important;
        z-index: 1 !important;
        flex: 1 1 380px !important;
        min-width: 0 !important;
    }

    .status-banner-wrapper .status-icon-badge {
        flex: none !important;
        width: 60px !important;
        height: 60px !important;
        border-radius: 16px !important;
        display: flex !important;
        align-items: center !important;
        justify-content: center !important;
    }

    .status-banner-wrapper .status-banner-text {
        min-width: 0 !important;
    }

    .status-banner-wrapper .status-banner-title {
        color: #ffffff !important;
        font-size: 21px !important;
        font-weight: 700 !important;
        margin: 0 0 6px 0 !important;
        letter-spacing: 0.2px !important;
    }

    .status-banner-wrapper .status-banner-subtext {
        color: rgba(255, 255, 255, 0.62) !important;
        font-size: 14.5px !important;
        line-height: 1.55 !important;
        margin: 0 !important;
        max-width: 460px !important;
    }

    /* ===== Login prompt (pink accent) ===== */
    .login-prompt-wrapper .status-banner-card {
        background: linear-gradient(135deg, #10154a 0%, #161b56 45%, #0b0e33 100%) !important;
        border: 1px solid rgba(236, 35, 119, 0.25) !important;
        box-shadow: 0 20px 50px rgba(6, 8, 34, 0.4), 0 0 0 1px rgba(255,255,255,0.03) inset !important;
    }

    .login-prompt-wrapper .status-banner-card::before {
        content: "" !important;
        position: absolute !important;
        top: -80px !important;
        right: 120px !important;
        width: 260px !important;
        height: 260px !important;
        background: radial-gradient(circle, rgba(236, 35, 119, 0.22) 0%, transparent 70%) !important;
        pointer-events: none !important;
    }

    .login-prompt-wrapper .status-banner-card::after {
        content: "" !important;
        position: absolute !important;
        bottom: -100px !important;
        left: -60px !important;
        width: 220px !important;
        height: 220px !important;
        background: radial-gradient(circle, rgba(80, 90, 220, 0.18) 0%, transparent 70%) !important;
        pointer-events: none !important;
    }

    .login-prompt-wrapper .status-icon-badge {
        background: linear-gradient(135deg, #ec2377, #ff5fa2) !important;
        box-shadow: 0 8px 22px rgba(236, 35, 119, 0.4) !important;
    }

    a.btn-login-elegant {
        flex: none !important;
        display: inline-flex !important;
        align-items: center !important;
        gap: 10px !important;
        background: linear-gradient(135deg, #ec2377, #ff5fa2) !important;
        color: #ffffff !important;
        font-weight: 600 !important;
        font-size: 15px !important;
        padding: 15px 34px !important;
        border-radius: 12px !important;
        text-decoration: none !important;
        box-shadow: 0 10px 25px rgba(236, 35, 119, 0.35) !important;
        transition: transform 0.2s ease, box-shadow 0.2s ease !important;
        border: none !important;
        position: relative !important;
        z-index: 1 !important;
        white-space: nowrap !important;
    }

    a.btn-login-elegant:hover,
    a.btn-login-elegant:focus,
    a.btn-login-elegant:active {
        transform: translateY(-2px) !important;
        box-shadow: 0 14px 30px rgba(236, 35, 119, 0.5) !important;
        color: #ffffff !important;
        text-decoration: none !important;
    }

    a.btn-login-elegant svg {
        transition: transform 0.2s ease !important;
    }

    a.btn-login-elegant:hover svg {
        transform: translateX(3px) !important;
    }

    /* ===== Department denied (amber accent) ===== */
    .dept-denied-wrapper .status-banner-card {
        background: linear-gradient(135deg, #1a1530 0%, #241a3a 45%, #150f28 100%) !important;
        border: 1px solid rgba(245, 158, 11, 0.25) !important;
        box-shadow: 0 20px 50px rgba(10, 6, 20, 0.4), 0 0 0 1px rgba(255,255,255,0.03) inset !important;
    }

    .dept-denied-wrapper .status-banner-card::before {
        content: "" !important;
        position: absolute !important;
        top: -80px !important;
        right: 120px !important;
        width: 260px !important;
        height: 260px !important;
        background: radial-gradient(circle, rgba(245, 158, 11, 0.18) 0%, transparent 70%) !important;
        pointer-events: none !important;
    }

    .dept-denied-wrapper .status-banner-card::after {
        content: "" !important;
        position: absolute !important;
        bottom: -100px !important;
        left: -60px !important;
        width: 220px !important;
        height: 220px !important;
        background: radial-gradient(circle, rgba(236, 35, 119, 0.14) 0%, transparent 70%) !important;
        pointer-events: none !important;
    }

    .dept-denied-wrapper .status-icon-badge {
        background: linear-gradient(135deg, #f59e0b, #fbbf24) !important;
        box-shadow: 0 8px 22px rgba(245, 158, 11, 0.35) !important;
    }

    @media (max-width: 640px) {
        .status-banner-wrapper .status-banner-card {
            flex-direction: column !important;
            align-items: flex-start !important;
            padding: 32px 28px !important;
        }
        a.btn-login-elegant {
            width: 100% !important;
            justify-content: center !important;
        }
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
        <h1 class="hero-title hero-title-inline"><asp:Literal ID="litTitle" runat="server" /></h1>
<div class="hero-stats hero-stats-inline">
  <div class="stat-item"><span class="stat-val"><asp:Literal ID="litDisplayCode" runat="server" /></span><span class="stat-lbl">Course Code</span></div>
  <div class="stat-item"><span class="stat-val"><asp:Literal ID="litCredits" runat="server" /></span><span class="stat-lbl">Credits</span></div>
  <div class="stat-item"><span class="stat-val"><asp:Literal ID="litHours" runat="server" /></span><span class="stat-lbl">Total hrs</span></div>
</div>
      </div>

      <div class="hero-btns">
        <button type="button" class="btn-view-syl" onclick="openSyllabus()">
          <svg width="14" height="14" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><path d="M1 12s4-8 11-8 11 8 11 8-4 8-11 8-11-8-11-8z"/><circle cx="12" cy="12" r="3"/></svg>
          View Syllabus
        </button>
      </div>
    </div>

    <asp:Panel ID="pnlLoginPrompt" runat="server" Visible="false" CssClass="status-banner-wrapper login-prompt-wrapper">
        <div class="status-banner-card">
            <div class="status-banner-left">
                <div class="status-icon-badge">
                    <svg xmlns="http://www.w3.org/2000/svg" width="26" height="26" viewBox="0 0 24 24" fill="none" stroke="#ffffff" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                        <rect x="3" y="11" width="18" height="11" rx="2" ry="2"></rect>
                        <path d="M7 11V7a5 5 0 0 1 10 0v4"></path>
                    </svg>
                </div>
                <div class="status-banner-text">
                    <h4 class="status-banner-title">Members Only</h4>
                    <p class="status-banner-subtext">
                        Please log in to view course files, assignments, and past questions.
                    </p>
                </div>
            </div>
            <asp:HyperLink ID="lnkLogin" runat="server" NavigateUrl="~/login.aspx" CssClass="btn-login-elegant">
                <span>Go to Login Page</span>
                <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="#ffffff" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round">
                    <line x1="5" y1="12" x2="19" y2="12"></line>
                    <polyline points="12 5 19 12 12 19"></polyline>
                </svg>
            </asp:HyperLink>
        </div>
    </asp:Panel>

    <asp:Panel ID="pnlDeptDenied" runat="server" Visible="false" CssClass="status-banner-wrapper dept-denied-wrapper">
        <div class="status-banner-card">
            <div class="status-banner-left">
                <div class="status-icon-badge">
                    <svg xmlns="http://www.w3.org/2000/svg" width="26" height="26" viewBox="0 0 24 24" fill="none" stroke="#ffffff" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                        <circle cx="12" cy="12" r="10"></circle>
                        <line x1="4.93" y1="4.93" x2="19.07" y2="19.07"></line>
                    </svg>
                </div>
                <div class="status-banner-text">
                    <h4 class="status-banner-title">Access Restricted</h4>
                    <p class="status-banner-subtext">
                        Your department does not have access to this course's notes.
                    </p>
                </div>
            </div>
        </div>
    </asp:Panel>

      <asp:Panel ID="MaterialsPanel" runat="server">

    <!-- ══ NOTES / PAST PAPERS TABS ══ -->
    <div class="fade-up d2">
    

      <%-- Filter chips (kept outside the panels so it stays visible no matter which panel is active) --%>
      <div class="filter-bar">

      
        <div class="filter-chips">
          
          <button type="button" class="fchip" data-filter="Lecture" onclick="filterNotes(this,'Lecture')">
            <svg width="12" height="12" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><rect x="3" y="3" width="18" height="13" rx="2"/><path d="M8 21h8M12 17v4"/></svg>
            Lecture Content
          </button>
          <button type="button" class="fchip" data-filter="Tutorial" onclick="filterNotes(this,'Tutorial')">
            <svg width="12" height="12" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><path d="M17 21v-2a4 4 0 00-4-4H5a4 4 0 00-4 4v2"/><circle cx="9" cy="7" r="4"/><path d="M23 21v-2a4 4 0 00-3-3.87M16 3.13a4 4 0 010 7.75"/></svg>
            Tutorial Content
          </button>
          <button type="button" class="fchip" data-filter="Workshop" onclick="filterNotes(this,'Workshop')">
            <svg width="12" height="12" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><path d="M14.7 6.3a1 1 0 000 1.4l1.6 1.6a1 1 0 001.4 0l3.77-3.77a6 6 0 01-7.94 7.94l-6.91 6.91a2.12 2.12 0 01-3-3l6.91-6.91a6 6 0 017.94-7.94l-3.76 3.76z"/></svg>
            Workshop Content
          </button>
            <button type="button" class="fchip" data-filter="Question" onclick="filterNotes(this, 'Question')">
                <svg width="12" height="12" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
                    <path d="M9 12h6m-6 4h6m2 5H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z" />
                    <circle cx="12" cy="14" r="1" />
                </svg>
                Past Questions
            </button>

            <button type="button" class="fchip" data-filter="Assignment" onclick="filterNotes(this, 'Assignment')">
                <svg width="12" height="12" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
                    <path d="M9 5H7a2 2 0 00-2 2v12a2 2 0 002 2h10a2 2 0 002-2V7a2 2 0 00-2-2h-2M9 5a2 2 0 002 2h2a2 2 0 002-2M9 5a2 2 0 012-2h2a2 2 0 012 2m-6 9l2 2 4-4" />
                </svg>
                Assignments
            </button>
            
        </div>
      </div>

      <%-- NOTES PANEL --%>
      <div id="panelNotes">

         <div class="files-card" id="notesTable">
    <asp:GridView ID="GridViewNotes" runat="server" 
        AutoGenerateColumns="False" 
        CssClass="table table-bordered table-condensed table-hover" 
        ShowHeader="True" 
        >
        <Columns>
            
            <%-- 1. Dynamic Type Badge Column with Header --%>
            <asp:TemplateField HeaderText="Type">
    <ItemTemplate>
        <span class="type-badge">
            <%# Eval("FileType") %>
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
                        Past question
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
          </asp:Panel>

    <asp:Label ID="lblAccessDenied" runat="server" Text="Please log in to view course materials." Visible="false" CssClass="text-center mt-5" />
  </div>
</main>

<!-- ══ SYLLABUS MODAL ══ -->
<div class="syl-modal-bg" id="sylModal">
  <div class="syl-modal">

   <div class="syl-modal-header">
  <span class="syl-modal-title"><asp:Literal ID="litSylTitle" runat="server" /></span>
  <button type="button" class="syl-modal-close" onclick="closeSyllabus()">&times;</button>
</div>

<iframe
    id="sylPdfFrame"
    width="100%"
    height="700">
</iframe>
<asp:HiddenField ID="hidSylUrl" runat="server" />

  </div>
</div>

<script type="text/javascript">
document.addEventListener("DOMContentLoaded", function () {
    var lectureBtn = document.querySelector('.fchip[data-filter="Lecture"]');
    if (lectureBtn) {
        filterNotes(lectureBtn, 'Lecture');
    }
});



function switchTab(tab) {
    var panelNotes = document.getElementById('panelNotes');
    var panelPapers = document.getElementById('panelPapers');

    if (tab === 'notes') {
        panelNotes.style.display = '';
        panelPapers.style.display = 'none';
    }
    else {
        panelNotes.style.display = 'none';
        panelPapers.style.display = '';
    }
}

function filterNotes(btn, filterType) {
    // 1. Manage Active Class
    document.querySelectorAll('.fchip').forEach(function (c) { c.classList.remove('active'); });
    btn.classList.add('active');

    // 2. Select rows from BOTH tables
    var rows = document.querySelectorAll('#panelNotes table tr, #panelPapers table tr');
    var visible = 0;
    var foundInNotes = false;
    var foundInPapers = false;

    rows.forEach(function (row) {
        var badge = row.querySelector('.type-badge');
        if (!badge) return;

        var badgeText = badge.textContent.replace(/\s+/g, ' ').trim().toLowerCase();
        var searchKey = filterType.toLowerCase();
        var isMatch = false;

        // Matching logic
        if (searchKey === 'question') isMatch = badgeText.includes('question');
        else if (searchKey === 'assignment') isMatch = badgeText.includes('assignment');
        else isMatch = badgeText.includes(searchKey);

        if (isMatch) {
            row.style.display = '';
            visible++;
            // Track which table the match is in
            if (row.closest('#panelNotes')) foundInNotes = true;
            if (row.closest('#panelPapers')) foundInPapers = true;
        } else {
            row.style.display = 'none';
        }
    });

    // 3. Auto-switch to the correct tab if necessary
    if (foundInPapers && !foundInNotes) {
        switchTab('papers');
    } else if (foundInNotes) {
        switchTab('notes');
    }

    // 4. Handle Empty State
    var emptyEl = document.getElementById('filterEmpty');
    if (visible === 0) {
        if (emptyEl) emptyEl.style.display = 'flex';
    } else {
        if (emptyEl) emptyEl.style.display = 'none';
    }
}

    function openSyllabus() {
        var modal = document.getElementById("sylModal");
        var frame = document.getElementById("sylPdfFrame");
        var hidUrl = document.getElementById("<%= hidSylUrl.ClientID %>");

    if (frame && hidUrl && hidUrl.value && frame.getAttribute("src") !== hidUrl.value) {
        frame.src = hidUrl.value;
    }
    if (modal) {
        modal.classList.add("open");
        document.body.style.overflow = "hidden";
    }
}

function closeSyllabus() {
    var modal = document.getElementById("sylModal");
    if (modal) {
        modal.classList.remove("open");
        document.body.style.overflow = "";
    }
}

document.addEventListener("DOMContentLoaded", function () {
    var modal = document.getElementById("sylModal");
    if (modal) {
        modal.addEventListener("click", function (e) {
            if (e.target === this) closeSyllabus();
        });
    }
});

document.addEventListener("keydown", function (e) {
    if (e.key === "Escape") closeSyllabus();
});
</script>

</asp:Content>
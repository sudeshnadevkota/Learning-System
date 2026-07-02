<%@ Page Title="Business English - BIT Notes" Language="C#" MasterPageFile="~/Bit_Notes/note.Master" AutoEventWireup="true" CodeBehind="course_content.aspx.cs" Inherits="Learning_System.Bit_Notes.course_content" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

<link rel="stylesheet" type="text/css" href="<%= ResolveUrl("~/Bit_Notes/Css/note.css") %>" />

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
  </div>
</main>

<!-- ══ SYLLABUS MODAL ══ -->
<!-- ══ SYLLABUS MODAL ══ -->
<div class="syl-modal-bg" id="sylModal">
  <div class="syl-modal">

   <div class="syl-modal-header">
  <span class="syl-modal-title"><asp:Literal ID="litSylTitle" runat="server" /></span>
  <button type="button" class="syl-modal-close" onclick="closeSyllabus()">&times;</button>
</div>

<iframe
    id="sylPdfFrame"
    runat="server"
    width="100%"
    height="700">
</iframe>

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
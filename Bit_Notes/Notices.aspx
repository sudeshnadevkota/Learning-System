<%@ Page Title="Notices - BIT" Language="C#" MasterPageFile="~/Bit_Notes/note.Master" AutoEventWireup="true" CodeBehind="Notices.aspx.cs" Inherits="Learning_System.Bit_Notes.Notices" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

<link rel="stylesheet" type="text/css" href="<%= ResolveUrl("~/Bit_Notes/Css/note.css") %>" />

<main class="main">
  <div class="main-inner">

    <div class="hero-card hero-card-compact fade-up d1">
      <div class="hero-tag">
        <a href="../../Default.aspx" class="btn-back-home">
          <svg width="13" height="13" fill="none" stroke="currentColor" stroke-width="2.5" viewBox="0 0 24 24"><path d="M19 12H5M12 5l-7 7 7 7"/></svg>
          Back to Home
        </a>
      </div>
      <h1 class="hero-title-inline">Notices</h1>
    </div>

    <div id="noticeList" class="fade-up d2">
      <asp:Repeater ID="rptNotices" runat="server">
        <ItemTemplate>
          <div class="notice-card <%# Convert.ToBoolean(Eval("IsPinned")) ? "pinned" : "" %>"
               data-title='<%# HttpUtility.HtmlAttributeEncode(Eval("Title").ToString()) %>'
               data-posted-by='<%# HttpUtility.HtmlAttributeEncode(Eval("PostedByName").ToString()) %>'
               data-posted-role='<%# HttpUtility.HtmlAttributeEncode(Eval("PostedByRole").ToString()) %>'
               data-posted-date='<%# Eval("PostedDate", "{0:MMM dd, yyyy}") %>'
               data-description='<%# HttpUtility.HtmlAttributeEncode(Eval("Description").ToString()) %>'
               data-attachment-url='<%# Eval("AttachmentName") != DBNull.Value ? ResolveUrl("~/Bit_Notes/NoticeViewer.ashx?id=" + Eval("NoticeId")) : "" %>'
               data-attachment-type='<%# Eval("AttachmentType") %>'
               onclick="openNoticeModal(this)">

            <%# Convert.ToBoolean(Eval("IsPinned")) ? "<span class='notice-pin'>📌</span>" : "" %>

            <div class="notice-title"><%# Eval("Title") %></div>
            <div class="notice-excerpt"><%# Eval("Description") %></div>

            <div class="notice-meta-row">
              <span class="author-pill"><strong><%# Eval("PostedByName") %></strong> — <%# Eval("PostedByRole") %></span>
              <span class="notice-date"><%# Eval("PostedDate", "{0:MMM dd, yyyy}") %></span>
            </div>
          </div>
        </ItemTemplate>
      </asp:Repeater>

      <div class="empty-state" id="noticeEmpty" runat="server" visible="false">
        <div class="empty-icon">📋</div>
        <div class="empty-title">No notices yet</div>
        <div class="empty-text">Check back later for updates.</div>
      </div>
    </div>

  </div>
</main>

<!-- ══ NOTICE MODAL ══ -->
<div class="syl-modal-bg" id="noticeModal">
  <div class="syl-modal">
    <div class="syl-modal-header">
      <span class="syl-modal-title" id="nmTitle"></span>
      <button type="button" class="syl-modal-close" onclick="closeNoticeModal()">&times;</button>
    </div>
    <div class="notice-modal-body">
      <div class="notice-modal-meta">
        <span class="author-pill"><strong id="nmAuthor"></strong> — <span id="nmRole"></span></span>
        <span class="notice-date" id="nmDate"></span>
      </div>
      <div class="notice-modal-desc" id="nmDescription"></div>
      <div class="notice-modal-attachment" id="nmAttachmentWrap"></div>
    </div>
  </div>
</div>

<script type="text/javascript">
    function openNoticeModal(card) {
        document.getElementById('nmTitle').textContent = card.getAttribute('data-title');
        document.getElementById('nmAuthor').textContent = card.getAttribute('data-posted-by');
        document.getElementById('nmRole').textContent = card.getAttribute('data-posted-role');
        document.getElementById('nmDate').textContent = card.getAttribute('data-posted-date');
        document.getElementById('nmDescription').textContent = card.getAttribute('data-description');

        var attachUrl = card.getAttribute('data-attachment-url');
        var attachType = card.getAttribute('data-attachment-type') || '';
        var wrap = document.getElementById('nmAttachmentWrap');
        wrap.innerHTML = '';

        if (attachUrl) {
            if (attachType.indexOf('image') === 0) {
                wrap.innerHTML = '<img src="' + attachUrl + '" alt="Attachment" />';
            } else {
                wrap.innerHTML = '<iframe src="' + attachUrl + '#toolbar=0" width="100%" height="500" class="pdf-viewer"></iframe>';
            }
        }

        document.getElementById('noticeModal').classList.add('open');
        document.body.style.overflow = 'hidden';
    }

    function closeNoticeModal() {
        document.getElementById('noticeModal').classList.remove('open');
        document.body.style.overflow = '';
    }

    document.addEventListener('DOMContentLoaded', function () {
        var modal = document.getElementById('noticeModal');
        modal.addEventListener('click', function (e) { if (e.target === this) closeNoticeModal(); });
    });
    document.addEventListener('keydown', function (e) { if (e.key === 'Escape') closeNoticeModal(); });
</script>

</asp:Content>
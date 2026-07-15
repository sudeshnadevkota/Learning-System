<%@ Page Title="Notices" Language="C#" AutoEventWireup="true" CodeBehind="Notices.aspx.cs" Inherits="Learning_System.Notices" %>

<!DOCTYPE html>
<html lang="en">
<head runat="server">
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>College Notices</title>

    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet" />

<style>
    :root {
        --primary: #0B1F66;
        --secondary: #081547;
        --gold: #F6B400;
        --pink: #FF2D8D;
        --violet: #7c3aed;
        --text: #172033;
        --muted: #64748b;
        --border: #e2e8f0;
        --card: rgba(255,255,255,.78);
    }

    *, *::before, *::after {
        box-sizing: border-box;
        margin: 0;
        padding: 0;
    }

    html, body {
        width: 100%;
        min-height: 100%;
        font-family: 'Segoe UI', system-ui, sans-serif;
        background:
            radial-gradient(circle at 12% 10%, rgba(124,58,237,.12), transparent 28%),
            radial-gradient(circle at 88% 12%, rgba(255,45,141,.10), transparent 30%),
            linear-gradient(135deg, #f0f4ff 0%, #faf5ff 52%, #f0fdf4 100%);
        color: var(--text);
        overflow-x: hidden;
    }

    .main {
        min-height: 100vh;
        padding: 30px 24px 48px;
    }

    .main-inner {
        width: min(1120px, 100%);
        margin: 0 auto;
    }

    /* Header */
    .notice-hero {
        position: relative;
        overflow: hidden;
        padding: 30px;
        margin-bottom: 24px;
        border-radius: 30px;
        background:
            radial-gradient(circle at 85% 20%, rgba(246,180,0,.22), transparent 25%),
            radial-gradient(circle at 14% 16%, rgba(255,255,255,.12), transparent 26%),
            linear-gradient(135deg, #0B1F66 0%, #081547 58%, #172554 100%);
        box-shadow: 0 24px 65px rgba(11,31,102,.28);
        color: #fff;
        animation: fadeUp .45s ease both;
    }

    .notice-hero::before {
        content: "";
        position: absolute;
        right: -70px;
        bottom: -95px;
        width: 270px;
        height: 270px;
        border-radius: 50%;
        background: rgba(255,255,255,.08);
    }

    .notice-hero::after {
        content: "\f0a1";
        font-family: "Font Awesome 6 Free";
        font-weight: 900;
        position: absolute;
        right: 38px;
        top: 42px;
        color: rgba(255,255,255,.08);
        font-size: 110px;
        transform: rotate(-12deg);
    }

    .hero-top {
        position: relative;
        z-index: 1;
        display: flex;
        align-items: center;
        justify-content: space-between;
        gap: 14px;
        flex-wrap: wrap;
        margin-bottom: 26px;
    }

    .btn-back-home {
        display: inline-flex;
        align-items: center;
        gap: 8px;
        min-height: 42px;
        padding: 10px 16px;
        border-radius: 999px;
        background: rgba(255,255,255,.12);
        color: #fff;
        border: 1px solid rgba(255,255,255,.18);
        text-decoration: none;
        font-size: 13px;
        font-weight: 850;
        transition: .18s ease;
    }

    .btn-back-home:hover {
        background: rgba(255,255,255,.22);
        color: #fff;
        transform: translateY(-2px);
    }



    .hero-title-wrap {
        position: relative;
        z-index: 1;
    }

    .hero-kicker {
        display: block;
        margin-bottom: 8px;
        color: rgba(255,255,255,.72);
        font-size: 12px;
        font-weight: 850;
        text-transform: uppercase;
        letter-spacing: 1px;
    }

    .hero-title {
        margin: 0;
        font-size: clamp(30px, 4.4vw, 48px);
        font-weight: 950;
        letter-spacing: -.9px;
        line-height: 1.1;
    }

    .hero-title span {
        color: var(--gold);
    }

   

    /* Notice Board */
    .notice-board {
        padding: 22px;
        border-radius: 28px;
        background: rgba(255,255,255,.50);
        border: 1px solid rgba(255,255,255,.70);
        box-shadow: 0 12px 38px rgba(31,38,135,.08), inset 0 1px 0 rgba(255,255,255,.85);
        backdrop-filter: blur(16px);
        -webkit-backdrop-filter: blur(16px);
        animation: fadeUp .45s ease both;
    }

    .board-title {
        display: flex;
        align-items: center;
        gap: 10px;
        margin-bottom: 18px;
        color: var(--primary);
        font-size: 18px;
        font-weight: 950;
    }

    .board-title i {
        color: var(--violet);
    }

    .notice-list {
        display: grid;
        grid-template-columns: repeat(2, minmax(0, 1fr));
        gap: 18px;
    }

    .notice-card {
        position: relative;
        overflow: hidden;
        min-height: 205px;
        padding: 22px;
        border-radius: 24px;
        background: var(--card);
        border: 1px solid rgba(255,255,255,.78);
        box-shadow: 0 8px 30px rgba(31,38,135,.08), inset 0 1px 0 rgba(255,255,255,.86);
        cursor: pointer;
        transition: transform .18s ease, box-shadow .18s ease, border-color .18s ease;
    }

    .notice-card::before {
        content: "";
        position: absolute;
        inset: 0 auto 0 0;
        width: 6px;
        background: linear-gradient(180deg, var(--primary), var(--violet), var(--pink));
    }

    .notice-card::after {
        content: "";
        position: absolute;
        right: -65px;
        bottom: -80px;
        width: 170px;
        height: 170px;
        border-radius: 50%;
        background: rgba(124,58,237,.07);
        pointer-events: none;
    }

    .notice-card:hover {
        transform: translateY(-6px);
        border-color: rgba(124,58,237,.28);
        box-shadow: 0 22px 50px rgba(31,38,135,.15);
    }

    .notice-card.pinned {
        background:
            radial-gradient(circle at 88% 14%, rgba(246,180,0,.13), transparent 30%),
            rgba(255,255,255,.84);
        border-color: rgba(246,180,0,.28);
    }

    .notice-card.pinned::before {
        background: linear-gradient(180deg, #F6B400, #FF2D8D);
    }

    .notice-pin {
        position: absolute;
        top: 15px;
        right: 15px;
        display: inline-grid;
        place-items: center;
        width: 36px;
        height: 36px;
        border-radius: 14px;
        background: #fff7ed;
        color: #b45309;
        border: 1px solid #fed7aa;
        box-shadow: 0 8px 20px rgba(180,83,9,.13);
        z-index: 2;
    }

    .notice-tags {
        display: flex;
        gap: 8px;
        flex-wrap: wrap;
        min-height: 28px;
        padding-right: 42px;
        margin-bottom: 12px;
    }

    .tag {
        display: inline-flex;
        align-items: center;
        gap: 6px;
        padding: 6px 10px;
        border-radius: 999px;
        font-size: 11px;
        font-weight: 900;
        letter-spacing: .2px;
    }

    .tag-pinned {
        background: #fff7ed;
        color: #b45309;
        border: 1px solid #fed7aa;
    }

    .tag-attachment {
        background: #eef2ff;
        color: #4338ca;
        border: 1px solid #c7d2fe;
    }

    .notice-title {
        position: relative;
        z-index: 1;
        margin-bottom: 10px;
        padding-right: 28px;
        color: #0f172a;
        font-size: 21px;
        font-weight: 950;
        line-height: 1.3;
    }

    .notice-excerpt {
        position: relative;
        z-index: 1;
        margin-bottom: 18px;
        color: #475569;
        font-size: 14px;
        font-weight: 560;
        line-height: 1.65;
        display: -webkit-box;
        -webkit-line-clamp: 3;
        -webkit-box-orient: vertical;
        overflow: hidden;
    }

    .notice-meta-row {
        position: relative;
        z-index: 1;
        display: flex;
        align-items: center;
        justify-content: space-between;
        gap: 12px;
        flex-wrap: wrap;
    }

    .author-pill {
        display: inline-flex;
        align-items: center;
        gap: 6px;
        max-width: 100%;
        padding: 8px 12px;
        border-radius: 999px;
        background: #f8fafc;
        color: #334155;
        border: 1px solid #e2e8f0;
        font-size: 12px;
        font-weight: 750;
    }

    .notice-date {
        display: inline-flex;
        align-items: center;
        gap: 6px;
        color: #64748b;
        font-size: 12px;
        font-weight: 850;
    }

    /* Empty */
    .empty-state {
        grid-column: 1 / -1;
        min-height: 280px;
        display: grid;
        place-items: center;
        padding: 34px 22px;
        border-radius: 24px;
        background: rgba(255,255,255,.78);
        border: 1px solid rgba(255,255,255,.78);
        box-shadow: 0 8px 30px rgba(31,38,135,.08);
        text-align: center;
    }

    .empty-icon {
        display: grid;
        place-items: center;
        width: 72px;
        height: 72px;
        margin: 0 auto 15px;
        border-radius: 22px;
        background: #ede9fe;
        color: var(--violet);
        font-size: 31px;
    }

    .empty-title {
        color: #0f172a;
        font-size: 22px;
        font-weight: 950;
        margin-bottom: 7px;
    }

    .empty-text {
        color: var(--muted);
        font-size: 14px;
        font-weight: 650;
    }

    /* Modal */
    .syl-modal-bg {
        position: fixed;
        inset: 0;
        z-index: 99999;
        display: none;
        align-items: center;
        justify-content: center;
        padding: 24px;
        background:
            radial-gradient(circle at 25% 15%, rgba(255,45,141,.18), transparent 30%),
            radial-gradient(circle at 75% 20%, rgba(124,58,237,.22), transparent 32%),
            rgba(15,23,42,.66);
        backdrop-filter: blur(8px);
        -webkit-backdrop-filter: blur(8px);
    }

    .syl-modal-bg.open {
        display: flex;
    }

    .syl-modal {
        width: min(860px, 96vw);
        max-height: 90vh;
        overflow: hidden;
        display: flex;
        flex-direction: column;
        border-radius: 28px;
        background: linear-gradient(135deg, rgba(255,255,255,.98), rgba(248,250,252,.96));
        border: 1px solid rgba(255,255,255,.72);
        box-shadow: 0 35px 100px rgba(15,23,42,.42), inset 0 1px 0 rgba(255,255,255,.95);
        animation: modalPop .20s ease-out;
    }

    .syl-modal-header {
        padding: 22px 24px;
        border-bottom: 1px solid rgba(226,232,240,.9);
        background:
            radial-gradient(circle at 14% 15%, rgba(246,180,0,.14), transparent 28%),
            radial-gradient(circle at 85% 10%, rgba(124,58,237,.12), transparent 32%),
            linear-gradient(135deg, rgba(255,255,255,.98), rgba(248,250,252,.92));
        display: flex;
        align-items: flex-start;
        justify-content: space-between;
        gap: 14px;
    }

    .syl-modal-title {
        color: #0f172a;
        font-size: 25px;
        font-weight: 950;
        line-height: 1.28;
    }

    .syl-modal-close {
        width: 42px;
        height: 42px;
        border-radius: 14px;
        border: 1px solid #e2e8f0;
        background: #fff;
        color: #0f172a;
        font-size: 26px;
        line-height: 1;
        cursor: pointer;
        transition: .18s ease;
        flex-shrink: 0;
    }

    .syl-modal-close:hover {
        background: #fee2e2;
        color: #991b1b;
        border-color: #fecaca;
    }

    .notice-modal-body {
        padding: 24px;
        overflow-y: auto;
    }

    .notice-modal-meta {
        display: flex;
        align-items: center;
        justify-content: space-between;
        gap: 12px;
        flex-wrap: wrap;
        margin-bottom: 18px;
    }

    .notice-modal-desc {
        color: #334155;
        font-size: 15px;
        font-weight: 560;
        line-height: 1.8;
        white-space: pre-wrap;
        padding: 18px;
        border-radius: 18px;
        background: #f8fafc;
        border: 1px solid #e2e8f0;
    }

    .notice-modal-attachment {
        margin-top: 20px;
    }

    .notice-modal-attachment img {
        width: 100%;
        max-height: 520px;
        object-fit: contain;
        border-radius: 18px;
        background: #fff;
        border: 1px solid #e2e8f0;
        box-shadow: 0 8px 24px rgba(15,23,42,.08);
    }

    .pdf-viewer {
        width: 100%;
        min-height: 540px;
        border: 1px solid #e2e8f0;
        border-radius: 18px;
        background: #fff;
        box-shadow: 0 8px 24px rgba(15,23,42,.08);
    }

    @keyframes fadeUp {
        from {
            opacity: 0;
            transform: translateY(22px);
        }

        to {
            opacity: 1;
            transform: translateY(0);
        }
    }

    @keyframes modalPop {
        from {
            opacity: 0;
            transform: translateY(14px) scale(.97);
        }

        to {
            opacity: 1;
            transform: none;
        }
    }

    @media(max-width: 820px) {
        .notice-list {
            grid-template-columns: 1fr;
        }

        .main {
            padding: 22px 16px 36px;
        }
    }

    @media(max-width: 560px) {
        .notice-hero {
            padding: 22px;
            border-radius: 22px;
        }

        .notice-board {
            padding: 16px;
            border-radius: 22px;
        }

        .notice-card {
            padding: 19px;
            border-radius: 20px;
        }

        .hero-title {
            font-size: 29px;
        }

        .syl-modal-bg {
            padding: 12px;
        }

        .syl-modal {
            border-radius: 22px;
            max-height: 92vh;
        }

        .syl-modal-title {
            font-size: 20px;
        }

        .syl-modal-header,
        .notice-modal-body {
            padding: 18px;
        }

        .pdf-viewer {
            min-height: 410px;
        }
    }
</style>
</head>

<body>
<form id="form1" runat="server">

    <main class="main">
        <div class="main-inner">

            <section class="notice-hero">
                <div class="hero-top">
                    <a href="<%= ResolveUrl("~/Default.aspx") %>" class="btn-back-home">
                        <i class="fas fa-arrow-left"></i>
                        Back to Home
                    </a>

                   
                </div>

                <div class="hero-title-wrap">
                    <span class="hero-kicker">Official Announcements</span>
                    <h1 class="
                        ">
                        Notices — <span><asp:Literal ID="litClassName" runat="server" /></span>
                    </h1>
                   
                </div>
            </section>

            <section class="notice-board">
                <div class="board-title">
                    <i class="fas fa-clipboard-list"></i>
                    Latest College Notices
                </div>

                <div id="noticeList" class="notice-list">

                    <asp:Repeater ID="rptNotices" runat="server">
                        <ItemTemplate>
                            <article class='notice-card <%# Convert.ToBoolean(Eval("IsPinned")) ? "pinned" : "" %>'
                                data-title='<%# HttpUtility.HtmlAttributeEncode(Convert.ToString(Eval("Title"))) %>'
                                data-posted-by='<%# HttpUtility.HtmlAttributeEncode(Convert.ToString(Eval("PostedByName"))) %>'
                                data-posted-role='<%# HttpUtility.HtmlAttributeEncode(Convert.ToString(Eval("PostedByRole"))) %>'
                                data-posted-date='<%# Eval("PostedDate", "{0:MMM dd, yyyy}") %>'
                                data-description='<%# HttpUtility.HtmlAttributeEncode(Convert.ToString(Eval("Description"))) %>'
                                data-attachment-url='<%# Eval("AttachmentName") != DBNull.Value && !String.IsNullOrWhiteSpace(Convert.ToString(Eval("AttachmentName"))) ? ResolveUrl("~/NoticeViewer.ashx?id=" + Eval("NoticeId")) : "" %>'
                                data-attachment-type='<%# HttpUtility.HtmlAttributeEncode(Convert.ToString(Eval("AttachmentType"))) %>'
                                onclick="openNoticeModal(this)">

                                <%# Convert.ToBoolean(Eval("IsPinned")) ? "<span class='notice-pin'><i class='fas fa-thumbtack'></i></span>" : "" %>

                                <div class="notice-tags">
                                    <%# Convert.ToBoolean(Eval("IsPinned")) ? "<span class='tag tag-pinned'><i class='fas fa-thumbtack'></i> Pinned</span>" : "" %>
                                    <%# Eval("AttachmentName") != DBNull.Value && !String.IsNullOrWhiteSpace(Convert.ToString(Eval("AttachmentName"))) ? "<span class='tag tag-attachment'><i class='fas fa-paperclip'></i> Attachment</span>" : "" %>
                                </div>

                                <h2 class="notice-title">
                                    <%# Server.HtmlEncode(Convert.ToString(Eval("Title"))) %>
                                </h2>

                                <div class="notice-excerpt">
                                    <%# Server.HtmlEncode(Convert.ToString(Eval("Description"))) %>
                                </div>

                                <div class="notice-meta-row">
                                    <span class="author-pill">
                                        <i class="fas fa-user"></i>
                                        <strong><%# Server.HtmlEncode(Convert.ToString(Eval("PostedByName"))) %></strong>
                                        —
                                        <%# Server.HtmlEncode(Convert.ToString(Eval("PostedByRole"))) %>
                                    </span>

                                    <span class="notice-date">
                                        <i class="fas fa-calendar"></i>
                                        <%# Eval("PostedDate", "{0:MMM dd, yyyy}") %>
                                    </span>
                                </div>
                            </article>
                        </ItemTemplate>
                    </asp:Repeater>

                    <div class="empty-state" id="noticeEmpty" runat="server" Visible="false">
                        <div>
                            <div class="empty-icon">
                                <i class="fas fa-clipboard-list"></i>
                            </div>
                            <div class="empty-title">No notices yet</div>
                            <div class="empty-text">Check back later for official updates.</div>
                        </div>
                    </div>

                </div>
            </section>

        </div>
    </main>

    <div class="syl-modal-bg" id="noticeModal">
        <div class="syl-modal">
            <div class="syl-modal-header">
                <span class="syl-modal-title" id="nmTitle"></span>

                <button type="button" class="syl-modal-close" onclick="closeNoticeModal()" aria-label="Close notice">
                    &times;
                </button>
            </div>

            <div class="notice-modal-body">
                <div class="notice-modal-meta">
                    <span class="author-pill">
                        <i class="fas fa-user"></i>
                        <strong id="nmAuthor"></strong>
                        —
                        <span id="nmRole"></span>
                    </span>

                    <span class="notice-date">
                        <i class="fas fa-calendar"></i>
                        <span id="nmDate"></span>
                    </span>
                </div>

                <div class="notice-modal-desc" id="nmDescription"></div>
                <div class="notice-modal-attachment" id="nmAttachmentWrap"></div>
            </div>
        </div>
    </div>

</form>

<script type="text/javascript">
function openNoticeModal(card) {
    document.getElementById('nmTitle').textContent = card.getAttribute('data-title') || '';
    document.getElementById('nmAuthor').textContent = card.getAttribute('data-posted-by') || '';
    document.getElementById('nmRole').textContent = card.getAttribute('data-posted-role') || '';
    document.getElementById('nmDate').textContent = card.getAttribute('data-posted-date') || '';
    document.getElementById('nmDescription').textContent = card.getAttribute('data-description') || '';

    var attachUrl = card.getAttribute('data-attachment-url') || '';
    var attachType = (card.getAttribute('data-attachment-type') || '').toLowerCase();
    var wrap = document.getElementById('nmAttachmentWrap');

    wrap.innerHTML = '';

    if (attachUrl) {
        if (attachType.indexOf('image') === 0) {
            wrap.innerHTML = '<img src="' + attachUrl + '" alt="Notice attachment" />';
        } else {
            wrap.innerHTML = '<iframe src="' + attachUrl + '#toolbar=0" class="pdf-viewer"></iframe>';
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

    modal.addEventListener('click', function (e) {
        if (e.target === modal) closeNoticeModal();
    });
});

document.addEventListener('keydown', function (e) {
    if (e.key === 'Escape') closeNoticeModal();
});
</script>

</body>
</html>
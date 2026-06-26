<%@ Page Title="" Language="C#" MasterPageFile="~/Bit_Admin/upload.Master" AutoEventWireup="true" CodeBehind="bulk_upload.aspx.cs" Inherits="Learning_System.Bit_Admin.bulk_upload" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <style>
        @import url('https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700&display=swap');
        @import url('https://cdn.jsdelivr.net/npm/@tabler/icons-webfont@latest/tabler-icons.min.css');

        :root {
            --primary: #0B1F66;
            --secondary: #081547;
            --pink: #FF2D8D;
            --pink-light: rgba(255,45,141,0.08);
            --pink-hover: #e0277c;
            --gray-bg: #fafbff;
            --border-color: rgba(11,31,102,0.08);
            --text-muted: #6b7280;
            --success: #16a34a;
            --success-bg: #f0fdf4;
            --success-border: #4ade80;
        }

        .c-wrap {
            font-family: 'Plus Jakarta Sans', sans-serif;
            padding: 1.5rem;
        }

        /* ── Hero (matches course_content.aspx / syllabus.aspx) ── */
        .c-hero {
            background: linear-gradient(135deg, #0B1F66 0%, #1a3499 100%);
            padding: 28px 32px;
            border-radius: 16px;
            margin-bottom: 24px;
            color: #fff;
            display: flex;
            align-items: center;
            justify-content: space-between;
            flex-wrap: wrap;
            gap: 16px;
        }

        .c-hero-text small {
            display: block;
            margin-top: 6px;
            font-size: 12px;
            opacity: 0.7;
            font-weight: 400;
        }

        /* Small back link, sits above the title */
        .c-back-link {
            display: inline-flex;
            align-items: center;
            gap: 5px;
            font-size: 12px;
            font-weight: 600;
            color: rgba(255,255,255,0.75);
            text-decoration: none;
            margin-bottom: 10px;
            transition: color 0.15s ease;
        }

        .c-back-link:hover {
            color: #fff;
        }

        .c-hero h3 {
            margin: 0;
            font-size: 1.25rem;
            font-weight: 700;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .c-hero-actions {
            display: flex;
            gap: 10px;
            flex-wrap: wrap;
        }

        /* Hero action buttons (same as course_content.aspx) */
        .c-hero-btn {
            display: inline-flex;
            align-items: center;
            gap: 7px;
            padding: 10px 20px;
            border-radius: 10px;
            font-size: 13px;
            font-weight: 700;
            font-family: 'Plus Jakarta Sans', sans-serif;
            cursor: pointer;
            border: none;
            text-decoration: none;
            transition: transform 0.18s ease, box-shadow 0.18s ease, background 0.18s ease;
            letter-spacing: 0.3px;
        }

        .c-hero-btn:hover {
            transform: translateY(-2px) scale(1.03);
            box-shadow: 0 6px 20px rgba(0,0,0,0.22);
        }

        .c-hero-btn:active {
            transform: translateY(0) scale(0.98);
        }

        .c-hero-btn-bulk {
            background: var(--pink);
            color: #fff;
            box-shadow: 0 3px 12px rgba(255,45,141,0.35);
        }

        .c-hero-btn-bulk:hover {
            background: var(--pink-hover);
            color: #fff;
        }

        /* ── Panel ── */
        .c-panel {
            background: #ffffff;
            border: 1px solid var(--border-color);
            border-radius: 14px;
            padding: 28px;
            margin-bottom: 24px;
        }

        .c-panel-title {
            font-size: 11px;
            letter-spacing: 1.5px;
            color: var(--primary);
            text-transform: uppercase;
            font-weight: 700;
            margin-bottom: 22px;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .c-panel-title::after {
            content: '';
            flex: 1;
            height: 1px;
            background: var(--border-color);
        }

        /* ── Notice banner ── */
        .c-notice {
            display: flex;
            align-items: flex-start;
            gap: 12px;
            background: rgba(11,31,102,0.04);
            border: 1px solid rgba(11,31,102,0.1);
            border-left: 3px solid var(--primary);
            border-radius: 10px;
            padding: 14px 16px;
            margin-bottom: 22px;
            font-size: 13px;
            color: var(--primary);
        }

        .c-notice i {
            flex-shrink: 0;
            font-size: 1.1rem;
            margin-top: 1px;
        }

        /* ── Form ── */
        .c-form-row {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 20px;
            margin-bottom: 12px;
        }

        .form-group {
            position: relative;
            margin-bottom: 15px;
        }

        .form-group label {
            font-size: 12px;
            font-weight: 600;
            color: var(--primary);
            margin-bottom: 8px;
            display: block;
        }

        .form-control {
            width: 100%;
            box-sizing: border-box;
            display: block;
            border: 1px solid var(--border-color);
            border-radius: 8px;
            background-color: var(--gray-bg);
        }

        select.form-control {
            width: 100%;
            min-width: 0;
        }

        .c-val-msg {
            font-size: 11px;
            color: red;
            margin-top: 5px;
            display: block;
        }

        /* ── Submit Button ── */
        .c-btn-submit {
            background: var(--pink);
            color: #fff;
            border: none;
            border-radius: 8px;
            padding: 11px 28px;
            cursor: pointer;
            text-transform: uppercase;
            font-weight: 700;
            font-family: 'Plus Jakarta Sans', sans-serif;
            font-size: 13px;
            letter-spacing: 0.5px;
            transition: transform 0.18s ease, box-shadow 0.18s ease, background 0.18s ease;
        }

        .c-btn-submit:hover {
            background: var(--pink-hover);
            transform: translateY(-1px);
            box-shadow: 0 4px 14px rgba(255,45,141,0.35);
        }

        .c-btn-submit:disabled {
            opacity: 0.6;
            cursor: not-allowed;
            transform: none;
        }

        /* ── Drop Zone ── */
        #dropZone {
            border: 2px dashed rgba(11,31,102,0.2);
            border-radius: 12px;
            padding: 36px 20px;
            text-align: center;
            background: var(--gray-bg);
            transition: border-color 0.25s, background 0.25s;
            cursor: pointer;
        }

        #dropZone.dragover {
            border-color: var(--pink);
            background: var(--pink-light);
        }

        #dropZone.has-file {
            border-color: var(--success-border);
            background: var(--success-bg);
        }

        /* ── Selected files list (bulk) ── */
        .bulk-file-list {
            list-style: none;
            padding: 0;
            margin: 16px 0 0;
            display: flex;
            flex-direction: column;
            gap: 8px;
            text-align: left;
        }

        .bulk-file-item {
            display: flex;
            align-items: center;
            gap: 10px;
            padding: 10px 14px;
            background: var(--success-bg);
            border: 1px solid var(--success-border);
            border-radius: 8px;
            font-size: 13px;
        }

        .bulk-file-item .fi-name {
            flex: 1;
            font-weight: 600;
            color: #15803d;
            overflow: hidden;
            text-overflow: ellipsis;
            white-space: nowrap;
        }

        .bulk-file-item .fi-size {
            font-size: 11px;
            color: var(--text-muted);
            white-space: nowrap;
        }

        .bulk-file-count {
            margin-top: 14px;
            font-size: 12px;
            font-weight: 700;
            color: var(--primary);
            display: none;
        }

        .bulk-file-count.visible {
            display: block;
        }

        /* ── File Destination ── */
        #divFileDestination {
            overflow: hidden;
            max-height: 0;
            opacity: 0;
            transition: max-height 0.3s ease, opacity 0.3s ease;
        }

        #divFileDestination.visible {
            max-height: 200px;
            opacity: 1;
        }

        /* ── Table ── */
        .c-table-container {
            overflow: hidden;
            border-radius: 12px;
            border: 1px solid var(--border-color);
            background: #ffffff;
        }

        .table-modern,
        .table-modern th,
        .table-modern td {
            border-color: var(--border-color);
        }

        .table-modern {
            width: 100%;
            border-collapse: collapse;
            font-size: 13px;
        }

        .table-modern th {
            background: var(--gray-bg);
            color: var(--primary);
            font-weight: 700;
            padding: 16px 20px;
            text-align: left;
            border-bottom: 2px solid var(--border-color);
        }

        .table-modern td {
            padding: 14px 20px;
            border-bottom: 1px solid var(--border-color);
            color: #4a4a4a;
        }

        .table-modern tr:last-child td {
            border-bottom: none;
        }

        .table-modern tr:hover {
            background-color: #fcfcfd;
        }

        .table-modern a {
            color: var(--pink);
            text-decoration: none;
            font-weight: 600;
            margin-right: 10px;
        }

        .table-modern a:hover {
            text-decoration: underline;
        }
    </style>

    <div class="c-wrap container-fluid">

        <!-- Hero -->
        <div class="c-hero">
            <div class="c-hero-text">
                <a href="course_content.aspx?subject=<%= Request.QueryString["subject"] %>" class="c-back-link">
                    <i class="ti ti-arrow-left"></i> Back to Course Content
                </a>
                <h3><i class="ti ti-files"></i> Bulk Upload: <%= PageTitleText %></h3>
                <small>Upload multiple resource files for this subject at once</small>
            </div>
            <div class="c-hero-actions">
                <span class="c-hero-btn c-hero-btn-bulk">
                    <i class="ti ti-files"></i> Bulk Upload
                </span>
            </div>
        </div>

        <!-- Upload Panel -->
        <div class="c-panel">
            <div class="c-panel-title">Upload Multiple Files</div>

            <div class="c-notice">
                <i class="ti ti-info-circle"></i>
                <span>Select multiple files to upload together. Every file in this batch will be tagged with the same file type and destination below.</span>
            </div>

            <div class="c-form-row">
                <div class="form-group">
                    <label>Select File Type</label>
                    <asp:DropDownList ID="ddlFileType" runat="server" class="form-control">
                        <asp:ListItem Text="-- Select Category --" Value="" />
                        <asp:ListItem Text="Lecture Content"    Value="Lecture" />
                        <asp:ListItem Text="Tutorial Content"   Value="Tutorial" />
                        <asp:ListItem Text="Workshop Content"   Value="Workshop" />
                        <asp:ListItem Text="Past Year Question" Value="PYQ" />
                        <asp:ListItem Text="Assignment"         Value="Assignment" />
                    </asp:DropDownList>
                </div>
            </div>

            <div class="form-group">
                <label>Upload Files</label>
                <asp:FileUpload ID="FileUpload1" runat="server" AllowMultiple="true" style="display:none;"
                    accept=".pdf,.doc,.docx,.ppt,.pptx,.xls,.xlsx,.jpg,.png,.zip,.txt" />

                <div id="dropZone">
                    <i class="ti ti-cloud-upload" style="font-size:2.5rem; color:var(--primary); margin-bottom:8px; display:block;"></i>
                    <p style="margin:0 0 4px; font-weight:700; color:var(--primary); font-size:14px;">
                        Drag &amp; drop multiple files here
                    </p>
                    <p style="font-size:12px; color:#aaa; margin:0 0 14px;">
                        PDF, DOC, PPT, XLS, JPG, PNG, ZIP supported
                    </p>
                    <button type="button" id="btnBrowse" class="c-btn-submit"
                            style="padding:8px 22px; font-size:12px;">
                        <i class="ti ti-folder-open" style="margin-right:5px;"></i>Browse Files
                    </button>

                    <p class="bulk-file-count" id="bulkFileCount">0 files selected</p>
                    <ul class="bulk-file-list" id="bulkFileList"></ul>
                </div>
            </div>

            <div id="divFileDestination">
                <div class="form-group">
                    <label>File Destination</label>
                    <asp:DropDownList ID="ddlContentType" runat="server" class="form-control">
                        <asp:ListItem Text="-- Select Destination --" Value="" />
                        <asp:ListItem Text="Lecture Slides"  Value="Lecture Slides"  data-group="Lecture" />
                        <asp:ListItem Text="Lecture Notes"   Value="Lecture Notes"   data-group="Lecture" />
                        <asp:ListItem Text="Tutorial Slides" Value="Tutorial Slides" data-group="Tutorial" />
                        <asp:ListItem Text="Tutorial Notes"  Value="Tutorial Notes"  data-group="Tutorial" />
                        <asp:ListItem Text="Workshop Slides" Value="Workshop Slides" data-group="Workshop" />
                        <asp:ListItem Text="Workshop Notes"  Value="Workshop Notes"  data-group="Workshop" />
                    </asp:DropDownList>
                </div>
            </div>

            <asp:Label ID="lblMessage" runat="server" CssClass="c-val-msg"></asp:Label>
            <br /><br />
            <asp:Button ID="Button1" runat="server" class="c-btn-submit" Text="Upload Files" OnClick="Button1_Click" />
        </div>

        <!-- Table Panel -->
        <div class="c-panel">
            <div class="c-panel-title">Bulk Uploaded Files</div>
            <div class="c-table-container">
                <asp:GridView ID="GridView1" runat="server"
                    AutoGenerateColumns="False"
                    DataKeyNames="id"
                    class="table-modern"
                    GridLines="None"
                    BorderWidth="0"
                    CellPadding="0"
                    OnRowDeleting="GridView1_RowDeleting1"
                    OnRowEditing="GridView1_RowEditing1">
                    <Columns>
                        <asp:BoundField DataField="Name"        HeaderText="File Name" />
                        <asp:BoundField DataField="ContentType" HeaderText="Data Type" />
                        <asp:TemplateField HeaderText="Action">
                            <ItemTemplate>
                                <asp:LinkButton ID="lnkDownload" runat="server"
                                    Text="Download"
                                    CommandArgument='<%# Eval("id") %>'
                                    OnClick="lnkDownload_Click">
                                </asp:LinkButton>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:CommandField ShowEditButton="True" ShowDeleteButton="True" />
                    </Columns>
                </asp:GridView>
            </div>
        </div>
    </div>

    <script>
        window.addEventListener('DOMContentLoaded', function () {

            // ── Destination filter ────────────────────────────────────────
            var fileTypeEl  = document.getElementById('<%= ddlFileType.ClientID %>');
            var destWrapper = document.getElementById('divFileDestination');
            var destEl      = document.getElementById('<%= ddlContentType.ClientID %>');

            if (fileTypeEl && destEl) {
                var allOptions     = Array.from(destEl.options).slice(1);
                var hasDestination = ['Lecture', 'Tutorial', 'Workshop'];

                function filterDestination(selectedGroup) {
                    if (hasDestination.indexOf(selectedGroup) !== -1) {
                        destWrapper.classList.add('visible');
                        while (destEl.options.length > 1) destEl.remove(1);
                        allOptions.forEach(function (opt) {
                            if (opt.getAttribute('data-group') === selectedGroup) {
                                destEl.add(opt.cloneNode(true));
                            }
                        });
                        destEl.selectedIndex = 0;
                    } else {
                        destWrapper.classList.remove('visible');
                        while (destEl.options.length > 1) destEl.remove(1);
                    }
                }

                fileTypeEl.addEventListener('change', function () { filterDestination(this.value); });
                filterDestination(fileTypeEl.value);
            }

            // ── Drop Zone (multi-file) ──────────────────────────────────────
            var dropZone     = document.getElementById('dropZone');
            var fileInput    = document.getElementById('<%= FileUpload1.ClientID %>');
            var btnBrowse    = document.getElementById('btnBrowse');
            var bulkFileList = document.getElementById('bulkFileList');
            var bulkCount    = document.getElementById('bulkFileCount');

            function formatSize(bytes) {
                if (bytes < 1024) return bytes + ' B';
                if (bytes < 1048576) return (bytes / 1024).toFixed(1) + ' KB';
                return (bytes / 1048576).toFixed(2) + ' MB';
            }

            function escHtml(s) {
                return s.replace(/&/g, '&amp;').replace(/</g, '&lt;').replace(/>/g, '&gt;');
            }

            function renderFileList(files) {
                bulkFileList.innerHTML = '';

                if (!files || files.length === 0) {
                    bulkCount.classList.remove('visible');
                    dropZone.classList.remove('has-file');
                    return;
                }

                Array.from(files).forEach(function (f) {
                    var li = document.createElement('li');
                    li.className = 'bulk-file-item';
                    li.innerHTML =
                        '<i class="ti ti-file-check" style="color:#16a34a;font-size:1.1rem;"></i>' +
                        '<span class="fi-name">' + escHtml(f.name) + '</span>' +
                        '<span class="fi-size">' + formatSize(f.size) + '</span>';
                    bulkFileList.appendChild(li);
                });

                bulkCount.textContent = files.length + (files.length === 1 ? ' file selected' : ' files selected');
                bulkCount.classList.add('visible');
                dropZone.classList.add('has-file');
                dropZone.classList.remove('dragover');
            }

            if (dropZone && fileInput && btnBrowse) {
                btnBrowse.addEventListener('click', function (e) { e.stopPropagation(); fileInput.click(); });
                dropZone.addEventListener('click', function (e) {
                    if (e.target !== btnBrowse && !btnBrowse.contains(e.target)) fileInput.click();
                });
                fileInput.addEventListener('change', function () { renderFileList(this.files); });

                dropZone.addEventListener('dragover', function (e) { e.preventDefault(); dropZone.classList.add('dragover'); });
                dropZone.addEventListener('dragleave', function (e) { if (!dropZone.contains(e.relatedTarget)) dropZone.classList.remove('dragover'); });
                dropZone.addEventListener('drop', function (e) {
                    e.preventDefault();
                    dropZone.classList.remove('dragover');
                    var files = e.dataTransfer.files;
                    if (files && files.length > 0) {
                        try {
                            var dt = new DataTransfer();
                            Array.from(files).forEach(function (f) { dt.items.add(f); });
                            fileInput.files = dt.files;
                        } catch (err) { /* DataTransfer assignment unsupported — input still works via native drop in modern browsers */ }
                        renderFileList(fileInput.files);
                    }
                });
            }
        });
    </script>

</asp:Content>

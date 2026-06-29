<%@ Page Title="Manage Notices" EnableEventValidation="false" Language="C#" MasterPageFile="~/Bit_Admin/Upload.master" AutoEventWireup="true" CodeBehind="NoticeManage.aspx.cs" Inherits="Learning_System.Admin.NoticeManage" %>

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

        .c-hero-btn-syllabus {
            background: rgba(255,255,255,0.15);
            color: #fff;
            border: 1.5px solid rgba(255,255,255,0.35);
            backdrop-filter: blur(4px);
        }

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

        .form-group {
            position: relative;
            margin-bottom: 18px;
        }

            .form-group label {
                font-size: 12px;
                font-weight: 600;
                color: var(--primary);
                margin-bottom: 8px;
                display: block;
            }

        .c-input, .c-textarea, select.c-input {
            width: 100%;
            padding: 10px 14px;
            border: 1px solid var(--border-color);
            border-radius: 8px;
            font-family: 'Plus Jakarta Sans', sans-serif;
            font-size: 13px;
            color: #333;
            background: #fff;
            box-sizing: border-box;
            transition: border-color 0.15s ease;
        }

            .c-input:focus, .c-textarea:focus, select.c-input:focus {
                outline: none;
                border-color: var(--primary);
            }

        .c-textarea {
            resize: vertical;
            min-height: 120px;
        }

        .c-row-2 {
            display: flex;
            gap: 20px;
            flex-wrap: wrap;
        }

            .c-row-2 > div {
                flex: 1;
                min-width: 200px;
            }

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

        .c-btn-outline {
            background: #fff;
            color: var(--primary);
            border: 1.5px solid var(--border-color);
            border-radius: 8px;
            padding: 11px 28px;
            cursor: pointer;
            font-weight: 700;
            font-family: 'Plus Jakarta Sans', sans-serif;
            font-size: 13px;
            letter-spacing: 0.5px;
            transition: border-color 0.15s ease, background 0.15s ease;
        }

            .c-btn-outline:hover {
                border-color: var(--primary);
                background: var(--gray-bg);
            }

        #dropZone {
            border: 2px dashed rgba(11,31,102,0.2);
            border-radius: 12px;
            padding: 30px 20px;
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

        #filePreview {
            display: none;
            margin-top: 16px;
            padding: 10px 14px;
            background: var(--success-bg);
            border: 1px solid var(--success-border);
            border-radius: 8px;
            align-items: center;
            gap: 10px;
        }

            #filePreview.visible {
                display: flex !important;
            }

        .c-table-container {
            overflow: hidden;
            border-radius: 12px;
            border: 1px solid var(--border-color);
            background: #ffffff;
        }

        .table-modern, .table-modern th, .table-modern td {
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
                vertical-align: middle;
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

                .table-modern a.status-inactive {
                    color: var(--text-muted);
                }

        .c-val-msg {
            font-size: 13px;
            margin-top: 10px;
            display: block;
            font-weight: 600;
        }
    </style>

    <div class="c-wrap container-fluid">

        <!-- Hero -->
        <div class="c-hero">
            <div class="c-hero-text">
                <a href="<%= ResolveUrl("~/Default.aspx") %>" class="c-back-link">
                    <i class="ti ti-arrow-left"></i>Back to Dashboard
                </a>
                <h3><i class="ti ti-speakerphone"></i>Manage Notices</h3>
                <small>Create and publish notices for students to view on the notice board</small>
            </div>
            <div class="c-hero-actions">
                <span class="c-hero-btn c-hero-btn-syllabus">
                    <i class="ti ti-bell"></i>Notice Board
                </span>
            </div>
        </div>

        <!-- Form Panel -->
        <div class="c-panel">
            <div class="c-panel-title">Notice Details</div>

            <div class="c-notice">
                <i class="ti ti-info-circle"></i>
                <span>Notices appear on the student notice board and dashboard widget once saved.</span>
            </div>

            <asp:HiddenField ID="hidNoticeId" runat="server" />

            <div class="form-group">
                <label>Title <span style="color: var(--pink);">*</span></label>
                <asp:TextBox ID="txtTitle" runat="server" CssClass="c-input" placeholder="e.g. Mid-term Exam Routine Published" />
            </div>

            <div class="form-group c-row-2">
                <div>
                    <label>Class <span style="color: var(--pink);">*</span></label>
                    <asp:DropDownList ID="ddlClass" runat="server" CssClass="c-input" onchange="updateSemesters(this.value)">
                        <asp:ListItem Text="-- Select Class --" Value="" />
                        <asp:ListItem Text="BIT" Value="BIT" />
                        <asp:ListItem Text="BCS" Value="BCS" />
                        <asp:ListItem Text="BHM" Value="BHM" />
                        <asp:ListItem Text="BBA" Value="BBA" />
                        <asp:ListItem Text="MCS" Value="MCS" />
                        <asp:ListItem Text="MBA" Value="MBA" />
                    </asp:DropDownList>
                </div>
                <div>
                    <label>Semester <span style="color: var(--pink);">*</span></label>
                    <asp:DropDownList ID="ddlSemester" runat="server" CssClass="c-input" />
                </div>
            </div>

            <div class="form-group">
                <label>Description <span style="color: var(--pink);">*</span></label>
                <asp:TextBox ID="txtDescription" runat="server" TextMode="MultiLine" Rows="6" CssClass="c-input c-textarea" placeholder="Write the full notice content here..." />
            </div>

            <div class="form-group">
                <label>Attachment <small style="color: var(--text-muted); font-weight: 400;">(PDF or Image, optional)</small></label>
                <asp:FileUpload ID="fileAttachment" runat="server" Style="display: none;" accept=".pdf,.jpg,.jpeg,.png" />

                <div id="dropZone">
                    <i class="ti ti-cloud-upload" style="font-size: 2.2rem; color: var(--primary); margin-bottom: 8px; display: block;"></i>
                    <p style="margin: 0 0 4px; font-weight: 700; color: var(--primary); font-size: 14px;">
                        Drag &amp; drop a file here
                    </p>
                    <p style="font-size: 12px; color: #aaa; margin: 0 0 14px;">
                        PDF, JPG, or PNG — up to 8 MB
                    </p>
                    <button type="button" id="btnBrowse" class="c-btn-submit" style="padding: 8px 22px; font-size: 12px;">
                        <i class="ti ti-folder-open" style="margin-right: 5px;"></i>Browse File
                    </button>
                    <div id="filePreview">
                        <i class="ti ti-file-check" style="font-size: 1.4rem; color: #16a34a;"></i>
                        <div>
                            <p id="fileName" style="margin: 0; font-size: 13px; font-weight: 700; color: #15803d;"></p>
                            <p id="fileSize" style="margin: 0; font-size: 11px; color: #86efac;"></p>
                        </div>
                        <button type="button" id="btnClearFile" style="margin-left: auto; background: none; border: none; cursor: pointer; color: #16a34a; font-size: 1.1rem;">
                            <i class="ti ti-x"></i>
                        </button>
                    </div>
                </div>
            </div>

            <div class="form-group">
                <label>Expiry Date <small style="color: var(--text-muted); font-weight: 400;">(optional)</small></label>
                <asp:TextBox ID="txtExpiry" runat="server" CssClass="c-input" TextMode="Date" Style="max-width: 240px;" />
            </div>

            <div style="display: flex; gap: 10px; margin-top: 6px;">
                <asp:Button ID="btnSave" runat="server" Text="Save Notice" CssClass="c-btn-submit" OnClick="btnSave_Click" />
                <asp:Button ID="btnClear" runat="server" Text="Clear / New" CssClass="c-btn-outline" OnClick="btnClear_Click" CausesValidation="false" />
            </div>

            <asp:Label ID="lblMessage" runat="server" CssClass="c-val-msg" />
        </div>

        <!-- Table Panel -->
        <div class="c-panel">
            <div class="c-panel-title">Published Notices</div>
            <div class="c-table-container">
                <asp:GridView ID="gvNotices" runat="server" AutoGenerateColumns="False"
                    CssClass="table-modern" OnRowCommand="gvNotices_RowCommand" DataKeyNames="NoticeId">
                    <Columns>
                        <asp:BoundField DataField="Title" HeaderText="Title" />
                        <asp:TemplateField HeaderText="Posted By">
                            <ItemTemplate>
                                <%# Eval("PostedByName") %> — <%# Eval("PostedByRole") %>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="PostedDate" HeaderText="Date" DataFormatString="{0:yyyy-MM-dd}" />
                        <asp:TemplateField HeaderText="Actions">
                            <ItemTemplate>
                                <asp:LinkButton ID="btnEdit" runat="server" CommandName="EditNotice" CommandArgument='<%# Eval("NoticeId") %>' Text="Edit" />
                                <asp:LinkButton ID="btnDelete" runat="server" CommandName="DeleteNotice" CommandArgument='<%# Eval("NoticeId") %>' Text="Delete" OnClientClick="return confirm('Are you sure?');" />
                                <asp:LinkButton ID="btnToggle" runat="server" CommandName="ToggleActive" CommandArgument='<%# Eval("NoticeId") %>' Text='<%# Convert.ToBoolean(Eval("IsActive")) ? "Deactivate" : "Activate" %>' />
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
            </div>
        </div>

    </div>

    <script>
        window.addEventListener('DOMContentLoaded', function () {
            var dropZone = document.getElementById('dropZone');
            var fileInput = document.getElementById('<%= fileAttachment.ClientID %>');
            var filePreview = document.getElementById('filePreview');
            var fileNameEl = document.getElementById('fileName');
            var fileSizeEl = document.getElementById('fileSize');
            var btnBrowse = document.getElementById('btnBrowse');
            var btnClear = document.getElementById('btnClearFile');

            function formatSize(bytes) {
                if (bytes < 1024) return bytes + ' B';
                if (bytes < 1048576) return (bytes / 1024).toFixed(1) + ' KB';
                return (bytes / 1048576).toFixed(2) + ' MB';
            }

            function showFile(file) {
                if (fileNameEl) fileNameEl.textContent = file.name;
                if (fileSizeEl) fileSizeEl.textContent = formatSize(file.size);
                if (filePreview) filePreview.classList.add('visible');
                dropZone.classList.add('has-file');
                dropZone.classList.remove('dragover');
            }

            function clearFile() {
                fileInput.value = '';
                if (filePreview) filePreview.classList.remove('visible');
                dropZone.classList.remove('has-file');
                if (fileNameEl) fileNameEl.textContent = '';
                if (fileSizeEl) fileSizeEl.textContent = '';
            }

            if (dropZone && fileInput && btnBrowse && btnClear) {
                btnBrowse.addEventListener('click', function (e) { e.stopPropagation(); fileInput.click(); });
                dropZone.addEventListener('click', function (e) { if (e.target !== btnBrowse && e.target !== btnClear) fileInput.click(); });
                fileInput.addEventListener('change', function () { if (this.files && this.files[0]) showFile(this.files[0]); });
                btnClear.addEventListener('click', function (e) { e.stopPropagation(); clearFile(); });
                dropZone.addEventListener('dragover', function (e) { e.preventDefault(); dropZone.classList.add('dragover'); });
                dropZone.addEventListener('dragleave', function (e) { if (!dropZone.contains(e.relatedTarget)) dropZone.classList.remove('dragover'); });
                dropZone.addEventListener('drop', function (e) {
                    e.preventDefault(); dropZone.classList.remove('dragover');
                    var files = e.dataTransfer.files;
                    if (files && files[0]) {
                        try { var dt = new DataTransfer(); dt.items.add(files[0]); fileInput.files = dt.files; } catch (err) { }
                        showFile(files[0]);
                    }
                });
            }
        });
        function updateSemesters(selectedClass) {
            var ddlSem = document.getElementById('<%= ddlSemester.ClientID %>');
            ddlSem.innerHTML = ''; // Clear existing
            var limit = (['MCS', 'MBA'].includes(selectedClass)) ? 4 : 8;
            for (var i = 1; i <= limit; i++) {
                var opt = document.createElement('option');
                opt.value = i;
                opt.innerHTML = 'Semester ' + i;
                ddlSem.appendChild(opt);
            }
        }
    </script>

</asp:Content>

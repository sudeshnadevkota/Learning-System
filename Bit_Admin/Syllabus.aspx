<%@ Page Title="" Language="C#" MasterPageFile="~/Bit_Admin/upload.Master" AutoEventWireup="true" CodeBehind="Syllabus.aspx.cs" Inherits="Learning_System.Bit_Admin.Syllabus" %>

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

        .c-wrap { font-family: 'Plus Jakarta Sans', sans-serif; padding: 1.5rem; }

        .c-hero {
            background: linear-gradient(135deg, #0B1F66 0%, #1a3499 100%);
            padding: 28px 32px; border-radius: 16px; margin-bottom: 24px; color: #fff;
            display: flex; align-items: center; justify-content: space-between;
            flex-wrap: wrap; gap: 16px;
        }

        .c-hero-text small { display: block; margin-top: 6px; font-size: 12px; opacity: 0.7; font-weight: 400; }

        .c-back-link {
            display: inline-flex; align-items: center; gap: 5px; font-size: 12px; font-weight: 600;
            color: rgba(255,255,255,0.75); text-decoration: none; margin-bottom: 10px; transition: color 0.15s ease;
        }
        .c-back-link:hover { color: #fff; }

        .c-hero h3 { margin: 0; font-size: 1.25rem; font-weight: 700; display: flex; align-items: center; gap: 10px; }

        .c-hero-actions { display: flex; gap: 10px; flex-wrap: wrap; }

        .c-hero-btn {
            display: inline-flex; align-items: center; gap: 7px; padding: 10px 20px; border-radius: 10px;
            font-size: 13px; font-weight: 700; font-family: 'Plus Jakarta Sans', sans-serif; cursor: pointer;
            border: none; text-decoration: none; transition: transform 0.18s ease, box-shadow 0.18s ease, background 0.18s ease;
            letter-spacing: 0.3px;
        }
        .c-hero-btn:hover { transform: translateY(-2px) scale(1.03); box-shadow: 0 6px 20px rgba(0,0,0,0.22); }
        .c-hero-btn:active { transform: translateY(0) scale(0.98); }

        .c-hero-btn-syllabus {
            background: rgba(255,255,255,0.15); color: #fff; border: 1.5px solid rgba(255,255,255,0.35); backdrop-filter: blur(4px);
        }
        .c-hero-btn-syllabus:hover { background: rgba(255,255,255,0.25); color: #fff; }

        .c-panel { background: #ffffff; border: 1px solid var(--border-color); border-radius: 14px; padding: 28px; margin-bottom: 24px; }

        .c-panel-title {
            font-size: 11px; letter-spacing: 1.5px; color: var(--primary); text-transform: uppercase;
            font-weight: 700; margin-bottom: 22px; display: flex; align-items: center; gap: 8px;
        }
        .c-panel-title::after { content: ''; flex: 1; height: 1px; background: var(--border-color); }

        .c-notice {
            display: flex; align-items: flex-start; gap: 12px; background: rgba(11,31,102,0.04);
            border: 1px solid rgba(11,31,102,0.1); border-left: 3px solid var(--primary); border-radius: 10px;
            padding: 14px 16px; margin-bottom: 22px; font-size: 13px; color: var(--primary);
        }
        .c-notice i { flex-shrink: 0; font-size: 1.1rem; margin-top: 1px; }

        .form-group { position: relative; margin-bottom: 15px; }
        .form-group label { font-size: 12px; font-weight: 600; color: var(--primary); margin-bottom: 8px; display: block; }

        .c-val-msg { font-size: 11px; color: red; margin-top: 5px; display: block; }

        /* New: plain inputs for SubjectCode / CreditScore / TotalHours */
        .c-input {
            width: 100%; padding: 10px 14px; border: 1px solid var(--border-color); border-radius: 8px;
            font-family: 'Plus Jakarta Sans', sans-serif; font-size: 13px; color: #333; background: #fff;
            box-sizing: border-box; transition: border-color 0.15s ease;
        }
        .c-input:focus { outline: none; border-color: var(--primary); }
        .c-input[readonly] { background: var(--gray-bg); color: var(--text-muted); cursor: not-allowed; }

        .c-row-2 { display: flex; gap: 20px; flex-wrap: wrap; }
        .c-row-2 > div { flex: 1; min-width: 200px; }

        .c-btn-submit {
            background: var(--pink); color: #fff; border: none; border-radius: 8px; padding: 11px 28px;
            cursor: pointer; text-transform: uppercase; font-weight: 700; font-family: 'Plus Jakarta Sans', sans-serif;
            font-size: 13px; letter-spacing: 0.5px; transition: transform 0.18s ease, box-shadow 0.18s ease, background 0.18s ease;
        }
        .c-btn-submit:hover { background: var(--pink-hover); transform: translateY(-1px); box-shadow: 0 4px 14px rgba(255,45,141,0.35); }

        #dropZone {
            border: 2px dashed rgba(11,31,102,0.2); border-radius: 12px; padding: 36px 20px; text-align: center;
            background: var(--gray-bg); transition: border-color 0.25s, background 0.25s; cursor: pointer;
        }
        #dropZone.dragover { border-color: var(--pink); background: var(--pink-light); }
        #dropZone.has-file { border-color: var(--success-border); background: var(--success-bg); }

        #filePreview {
            display: none; margin-top: 16px; padding: 10px 14px; background: var(--success-bg);
            border: 1px solid var(--success-border); border-radius: 8px; align-items: center; gap: 10px;
        }
        #filePreview.visible { display: flex !important; }

        .c-table-container { overflow: hidden; border-radius: 12px; border: 1px solid var(--border-color); background: #ffffff; }

        .table-modern, .table-modern th, .table-modern td { border-color: var(--border-color); }
        .table-modern { width: 100%; border-collapse: collapse; font-size: 13px; }
        .table-modern th {
            background: var(--gray-bg); color: var(--primary); font-weight: 700; padding: 16px 20px;
            text-align: left; border-bottom: 2px solid var(--border-color);
        }
        .table-modern td { padding: 14px 20px; border-bottom: 1px solid var(--border-color); color: #4a4a4a; }
        .table-modern tr:last-child td { border-bottom: none; }
        .table-modern tr:hover { background-color: #fcfcfd; }
        .table-modern a { color: var(--pink); text-decoration: none; font-weight: 600; margin-right: 10px; }
        .table-modern a:hover { text-decoration: underline; }

        /* ── Table horizontal scroll (mobile-safe, desktop unaffected) ── */
        .c-table-container {
            overflow-x: auto;
            -webkit-overflow-scrolling: touch;
        }

            .c-table-container::-webkit-scrollbar {
                height: 8px;
            }

            .c-table-container::-webkit-scrollbar-track {
                background: var(--gray-bg);
            }

            .c-table-container::-webkit-scrollbar-thumb {
                background: var(--pink);
                border-radius: 8px;
            }

        /* ── Mobile-only refinements (desktop layout/content unchanged) ── */
        @media (max-width: 767.98px) {
            .c-wrap {
                padding: 1rem;
            }

            .c-hero {
                flex-direction: column;
                align-items: flex-start;
                padding: 20px;
                border-radius: 14px;
                gap: 16px;
            }

                .c-hero h3 {
                    font-size: 1.05rem;
                    line-height: 1.45;
                    gap: 8px;
                    align-items: flex-start;
                }

                    .c-hero h3 i {
                        font-size: 1.1rem;
                        margin-top: 3px;
                        flex-shrink: 0;
                    }

            .c-hero-actions {
                width: 100%;
                flex-direction: column;
                gap: 10px;
            }

            .c-hero-btn {
                width: 100%;
                justify-content: center;
                padding: 12px 18px;
            }

            .c-panel {
                padding: 20px;
                border-radius: 12px;
            }

            .table-modern {
                min-width: 640px;
            }
        }
    </style>

    <div class="c-wrap container-fluid">

        <!-- Hero -->
        <div class="c-hero">
            <div class="c-hero-text">
                <a href="course_content.aspx?subject=<%= Request.QueryString["subject"] %>" class="c-back-link">
                    <i class="ti ti-arrow-left"></i> Back to Course Content
                </a>
                <h3><i class="ti ti-file-text"></i> Syllabus Upload: <%= PageTitleText %></h3>
                <small>Upload the official syllabus document for this subject</small>
            </div>
            <div class="c-hero-actions">
                <span class="c-hero-btn c-hero-btn-syllabus">
                    <i class="ti ti-clipboard-list"></i> Syllabus
                </span>
            </div>
        </div>

        <!-- Upload Panel -->
        <div class="c-panel">
            <div class="c-panel-title">Upload Syllabus</div>

            <div class="c-notice">
                <i class="ti ti-info-circle"></i>
                <span>Upload the official syllabus PDF or document for this subject. This will be available to all enrolled students.</span>
            </div>

            <!-- Subject Code -->
            <div class="form-group">
                <label>Subject Code <span style="color:var(--pink);">*</span></label>
                <asp:TextBox ID="txtSubjectCode" runat="server" CssClass="c-input" placeholder="e.g. BIT113" MaxLength="20"></asp:TextBox>
            </div>

            <!-- Credit Score + Total Hours (auto-calculated) -->
            <div class="form-group c-row-2">
                <div>
                    <label>Credit Score <span style="color:var(--pink);">*</span></label>
                    <asp:TextBox ID="txtCreditScore" runat="server" CssClass="c-input" placeholder="e.g. 3" TextMode="Number"></asp:TextBox>
                </div>
                <div>
                    <label>Total Hours <small style="color:var(--text-muted); font-weight:400;">(Credit &times; 16, auto-calculated)</small></label>
                    <asp:TextBox ID="txtTotalHours" runat="server" CssClass="c-input" ReadOnly="true" placeholder="0"></asp:TextBox>
                </div>
            </div>

            <div class="form-group">
                <label>Upload Syllabus File</label>
                <asp:FileUpload ID="FileUpload1" runat="server" style="display:none;"
                    accept=".pdf,.doc,.docx,.ppt,.pptx,.xls,.xlsx,.jpg,.png,.zip,.txt" />

                <div id="dropZone">
                    <i class="ti ti-cloud-upload" style="font-size:2.5rem; color:var(--primary); margin-bottom:8px; display:block;"></i>
                    <p style="margin:0 0 4px; font-weight:700; color:var(--primary); font-size:14px;">
                        Drag &amp; drop your syllabus here
                    </p>
                    <p style="font-size:12px; color:#aaa; margin:0 0 14px;">
                        PDF, DOC, PPT, XLS, JPG, PNG, ZIP supported
                    </p>
                    <button type="button" id="btnBrowse" class="c-btn-submit"
                            style="padding:8px 22px; font-size:12px;">
                        <i class="ti ti-folder-open" style="margin-right:5px;"></i>Browse File
                    </button>
                    <div id="filePreview">
                        <i class="ti ti-file-check" style="font-size:1.4rem; color:#16a34a;"></i>
                        <div>
                            <p id="fileName" style="margin:0; font-size:13px; font-weight:700; color:#15803d;"></p>
                            <p id="fileSize" style="margin:0; font-size:11px; color:#86efac;"></p>
                        </div>
                        <button type="button" id="btnClearFile"
                                style="margin-left:auto; background:none; border:none;
                                       cursor:pointer; color:#16a34a; font-size:1.1rem;">
                            <i class="ti ti-x"></i>
                        </button>
                    </div>
                </div>
            </div>

            <asp:Label ID="lblMessage" runat="server" CssClass="c-val-msg"></asp:Label>
            <br /><br />
            <asp:Button ID="Button1" runat="server" class="c-btn-submit" Text="Submit Syllabus" OnClick="Button1_Click" />
        </div>

        <!-- Table Panel -->
        <div class="c-panel">
            <div class="c-panel-title">Syllabus Record</div>
            <div class="c-table-container">
                <asp:GridView ID="GridView1" runat="server"
                    AutoGenerateColumns="False"
                    DataKeyNames="Id"
                    class="table-modern"
                    GridLines="None"
                    BorderWidth="0"
                    CellPadding="0"
                    OnRowDeleting="GridView1_RowDeleting1">
                    <Columns>
                        <asp:BoundField DataField="SubjectCode" HeaderText="Course Code" />
                        <asp:BoundField DataField="CreditScore" HeaderText="Credit" />
                        <asp:BoundField DataField="TotalHours"  HeaderText="Hours" />
                        <asp:BoundField DataField="FileName"    HeaderText="File Name" />
                        <asp:TemplateField HeaderText="Action">
                            <ItemTemplate>
                                <asp:LinkButton ID="lnkDownload" runat="server"
                                    Text="Download"
                                    CommandArgument='<%# Eval("id") %>'
                                    OnClick="lnkDownload_Click">
                                </asp:LinkButton>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:CommandField ShowDeleteButton="True" DeleteText="Clear File" />
                    </Columns>
                </asp:GridView>
            </div>
        </div>
    </div>

    <script>
        window.addEventListener('DOMContentLoaded', function () {

            var dropZone   = document.getElementById('dropZone');
            var fileInput  = document.getElementById('<%= FileUpload1.ClientID %>');
            var filePreview = document.getElementById('filePreview');
            var fileNameEl = document.getElementById('fileName');
            var fileSizeEl = document.getElementById('fileSize');
            var btnBrowse = document.getElementById('btnBrowse');
            var btnClear = document.getElementById('btnClearFile');

            // Credit Score -> Total Hours live auto-calculation
            var creditInput = document.getElementById('<%= txtCreditScore.ClientID %>');
            var hoursInput  = document.getElementById('<%= txtTotalHours.ClientID %>');

            function recalcHours() {
                var credit = parseFloat(creditInput.value);
                if (!isNaN(credit) && credit > 0) {
                    hoursInput.value = (credit * 16).toString();
                } else {
                    hoursInput.value = '';
                }
            }

            if (creditInput && hoursInput) {
                creditInput.addEventListener('input', recalcHours);
            }

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
    </script>

</asp:Content>
<%@ Page Title="" Language="C#" MasterPageFile="~/Bit_Admin/upload.Master" AutoEventWireup="true" CodeBehind="course_content.aspx.cs" Inherits="Learning_System.Bit_Admin.course_content" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <style>
        @import url('https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800&display=swap');
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
            --danger: #dc2626;
            --danger-bg: #fef2f2;
            --danger-border: #fca5a5;
            --radius-lg: 16px;
            --radius-md: 12px;
            --radius-sm: 8px;
            --shadow-sm: 0 1px 3px rgba(11,31,102,0.06);
            --shadow-md: 0 8px 24px rgba(11,31,102,0.10);
            --ease: cubic-bezier(0.4, 0, 0.2, 1);
        }

        /* ── Base ── */
        .c-wrap {
            font-family: 'Plus Jakarta Sans', sans-serif;
            padding: 1.5rem;
            max-width: 1200px;
            margin: 0 auto;
        }

        .c-wrap *:focus-visible {
            outline: 2.5px solid var(--pink);
            outline-offset: 2px;
            border-radius: 6px;
        }

        @media (prefers-reduced-motion: reduce) {
            .c-wrap * {
                animation: none !important;
                transition: none !important;
            }
        }

        /* ── Hero ── */
        .c-hero {
            background: linear-gradient(135deg, #0B1F66 0%, #1a3499 100%);
            padding: 28px 32px;
            border-radius: var(--radius-lg);
            margin-bottom: 20px;
            color: #fff;
            display: flex;
            align-items: center;
            justify-content: space-between;
            flex-wrap: wrap;
            gap: 16px;
            box-shadow: var(--shadow-md);
        }

        .c-hero-text h3 {
            margin: 0 0 4px;
            font-size: 1.3rem;
            font-weight: 800;
            display: flex;
            align-items: center;
            gap: 10px;
            letter-spacing: -0.2px;
        }

        .c-hero-text p {
            margin: 0;
            font-size: 13px;
            color: rgba(255,255,255,0.7);
            padding-left: 30px;
        }

        .c-hero-actions {
            display: flex;
            gap: 10px;
            flex-wrap: wrap;
        }

        /* Hero action buttons */
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
            transition: transform 0.18s var(--ease), box-shadow 0.18s var(--ease), background 0.18s var(--ease);
            letter-spacing: 0.3px;
            white-space: nowrap;
        }

        .c-hero-btn:hover {
            transform: translateY(-2px) scale(1.03);
            box-shadow: 0 6px 20px rgba(0,0,0,0.22);
        }

        .c-hero-btn:active {
            transform: translateY(0) scale(0.98);
        }

        .c-hero-btn-syllabus {
            background: rgba(255,255,255,0.15);
            color: #fff;
            border: 1.5px solid rgba(255,255,255,0.35);
            backdrop-filter: blur(4px);
        }

        .c-hero-btn-syllabus:hover {
            background: rgba(255,255,255,0.25);
            color: #fff;
        }

        .c-hero-btn-bulk {
            background: var(--pink);
            color: #fff;
            box-shadow: 0 3px 12px rgba(255,45,141,0.35);
        }

        .c-hero-btn-bulk:hover {
            background: var(--pink-hover);
        }

        /* ── Panel ── */
        .c-panel {
            background: #ffffff;
            border: 1px solid var(--border-color);
            border-radius: var(--radius-lg);
            padding: 28px;
            margin-bottom: 24px;
            box-shadow: var(--shadow-sm);
        }

        .c-panel-title {
            font-size: 11px;
            letter-spacing: 1.5px;
            color: var(--primary);
            text-transform: uppercase;
            font-weight: 700;
            margin-bottom: 6px;
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

        

        /* ── Form ── */
        .c-form-row {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 20px;
            margin-bottom: 4px;
        }

        .form-group {
            position: relative;
            margin-bottom: 18px;
        }

        .form-group label {
            font-size: 12.5px;
            font-weight: 700;
            color: var(--primary);
            margin-bottom: 8px;
            display: flex;
            align-items: center;
            gap: 6px;
        }

        .form-group label .req-dot {
            width: 5px;
            height: 5px;
            border-radius: 50%;
            background: var(--pink);
            display: inline-block;
        }

        .form-control {
            width: 100%;
            box-sizing: border-box;
            display: block;
            border: 1.5px solid var(--border-color);
            border-radius: var(--radius-sm);
            background-color: var(--gray-bg);
            padding: 12px 14px;
            font-family: 'Plus Jakarta Sans', sans-serif;
            font-size: 13.5px;
            color: #1f2937;
            transition: border-color 0.18s var(--ease), box-shadow 0.18s var(--ease), background 0.18s var(--ease);
        }

        .form-control:hover {
            border-color: rgba(11,31,102,0.2);
        }

        .form-control:focus {
            outline: none;
            border-color: var(--pink);
            background: #fff;
            box-shadow: 0 0 0 4px var(--pink-light);
        }

        select.form-control {
            width: 100%;
            min-width: 0;
            appearance: none;
            -webkit-appearance: none;
            background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='12' height='8' viewBox='0 0 12 8'%3E%3Cpath d='M1 1L6 6L11 1' stroke='%230B1F66' stroke-width='1.6' fill='none' stroke-linecap='round' stroke-linejoin='round'/%3E%3C/svg%3E");
            background-repeat: no-repeat;
            background-position: right 14px center;
            padding-right: 36px;
            cursor: pointer;
        }

        .c-val-msg {
            font-size: 11.5px;
            font-weight: 600;
            color: var(--danger);
            margin-top: 6px;
            display: flex;
            align-items: center;
            gap: 5px;
        }

        .c-val-msg:empty {
            display: none;
        }

        /* ── Submit Button ── */
        .c-btn-submit {
            background: var(--pink);
            color: #fff;
            border: none;
            border-radius: var(--radius-sm);
            padding: 13px 30px;
            cursor: pointer;
            text-transform: uppercase;
            font-weight: 700;
            font-family: 'Plus Jakarta Sans', sans-serif;
            font-size: 13px;
            letter-spacing: 0.5px;
            transition: transform 0.18s var(--ease), box-shadow 0.18s var(--ease), background 0.18s var(--ease), opacity 0.18s var(--ease);
            display: inline-flex;
            align-items: center;
            gap: 8px;
        }

        .c-btn-submit:hover {
            background: var(--pink-hover);
            transform: translateY(-1px);
            box-shadow: 0 4px 14px rgba(255,45,141,0.35);
        }

        .c-btn-submit:disabled {
            opacity: 0.65;
            cursor: not-allowed;
            transform: none;
        }

        .c-btn-submit .c-spinner {
            display: none;
            width: 13px;
            height: 13px;
            border: 2px solid rgba(255,255,255,0.4);
            border-top-color: #fff;
            border-radius: 50%;
            animation: c-spin 0.7s linear infinite;
        }

        .c-btn-submit.is-loading .c-spinner {
            display: inline-block;
        }

        @keyframes c-spin {
            to { transform: rotate(360deg); }
        }

        /* ── Message banner ── */
        #msgBanner {
            display: none;
            align-items: flex-start;
            gap: 10px;
            padding: 12px 16px;
            border-radius: var(--radius-sm);
            font-size: 13px;
            font-weight: 600;
            margin-bottom: 18px;
            background: var(--gray-bg);
            border: 1.5px solid var(--border-color);
            color: var(--primary);
        }

        #msgBanner.visible {
            display: flex;
        }

        /* ── Drop Zone ── */
        #dropZone {
            border: 2px dashed rgba(11,31,102,0.2);
            border-radius: var(--radius-md);
            padding: 36px 20px;
            text-align: center;
            background: var(--gray-bg);
            transition: border-color 0.25s var(--ease), background 0.25s var(--ease);
            cursor: pointer;
        }

        #dropZone:hover {
            border-color: rgba(11,31,102,0.35);
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
            background: #fff;
            border: 1px solid var(--success-border);
            border-radius: var(--radius-sm);
            align-items: center;
            gap: 10px;
            text-align: left;
        }

        #filePreview.visible {
            display: flex !important;
        }

        #fileWarning {
            display: none;
            margin-top: 10px;
            padding: 10px 14px;
            background: var(--danger-bg);
            border: 1px solid var(--danger-border);
            border-radius: var(--radius-sm);
            color: var(--danger);
            font-size: 12px;
            font-weight: 600;
            text-align: left;
            align-items: center;
            gap: 8px;
        }

        #fileWarning.visible {
            display: flex;
        }

        /* ── File Destination (hidden initially) ── */
        #divFileDestination {
            overflow: hidden;
            max-height: 0;
            opacity: 0;
            transition: max-height 0.3s var(--ease), opacity 0.3s var(--ease), margin 0.3s var(--ease);
        }

        #divFileDestination.visible {
            max-height: 200px;
            opacity: 1;
        }

        /* ── Table ── */
        .c-table-container {
            overflow: hidden;
            border-radius: var(--radius-md);
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
            padding: 14px 20px;
            text-align: left;
            border-bottom: 2px solid var(--border-color);
            font-size: 11.5px;
            text-transform: uppercase;
            letter-spacing: 0.6px;
        }

        .table-modern td {
            padding: 14px 20px;
            border-bottom: 1px solid var(--border-color);
            color: #374151;
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
            font-weight: 700;
            margin-right: 14px;
            font-size: 12.5px;
        }

        .table-modern a:hover {
            text-decoration: underline;
        }

        .c-empty-state {
            padding: 48px 20px;
            text-align: center;
            color: var(--text-muted);
        }

        .c-empty-state i {
            font-size: 2.2rem;
            color: rgba(11,31,102,0.2);
            display: block;
            margin-bottom: 10px;
        }

        .c-empty-state p {
            margin: 0;
            font-size: 13.5px;
            font-weight: 600;
            color: var(--primary);
        }

        .c-empty-state span {
            font-size: 12px;
        }

        /* ── Table horizontal scroll fallback (desktop unaffected) ── */
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

        /* ── Mobile-only refinements ── */
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

            .c-hero-text h3 {
                font-size: 1.05rem;
                line-height: 1.45;
                gap: 8px;
                align-items: flex-start;
            }

            .c-hero-text h3 i {
                font-size: 1.1rem;
                margin-top: 3px;
                flex-shrink: 0;
            }

            .c-hero-text p {
                padding-left: 0;
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
                padding: 18px;
                border-radius: 12px;
                margin-bottom: 16px;
            }

            .c-btn-submit {
                width: 100%;
                justify-content: center;
            }

            /* Card-ified table for small screens */
            .c-table-container {
                border: none;
                background: transparent;
                overflow: visible;
            }

            .table-modern {
                min-width: 0;
            }

            .table-modern thead {
                position: absolute;
                width: 1px;
                height: 1px;
                overflow: hidden;
                clip: rect(0 0 0 0);
                white-space: nowrap;
            }

            .table-modern tr {
                display: block;
                background: #fff;
                border: 1px solid var(--border-color);
                border-radius: var(--radius-md);
                margin-bottom: 12px;
                padding: 6px 4px;
                box-shadow: var(--shadow-sm);
            }

            .table-modern tr:hover {
                background: #fff;
            }

            .table-modern td {
                display: flex;
                justify-content: space-between;
                align-items: center;
                gap: 12px;
                text-align: right;
                padding: 10px 14px;
                border-bottom: 1px solid var(--border-color);
            }

            .table-modern tr td:last-child {
                border-bottom: none;
            }

            .table-modern td::before {
                content: attr(data-label);
                font-weight: 700;
                color: var(--primary);
                font-size: 11px;
                text-transform: uppercase;
                letter-spacing: 0.5px;
                text-align: left;
            }

            .table-modern td.c-td-actions {
                justify-content: flex-end;
                gap: 16px;
            }

            .table-modern td.c-td-actions::before {
                display: none;
            }
        }
    </style>


    <div class="c-wrap container-fluid">

        <!-- Hero -->
        <div class="c-hero">
            <div class="c-hero-text">
                <h3><i class="ti ti-vocabulary"></i> Course Content Management: <%= PageTitleText %></h3>
               
            </div>
            <div class="c-hero-actions">
                <a href="syllabus.aspx?subject=<%= Request.QueryString["subject"] %>"
                   class="c-hero-btn c-hero-btn-syllabus">
                    <i class="ti ti-file-text"></i> Upload Syllabus
                </a>
                <a href="bulk_upload.aspx?subject=<%= Request.QueryString["subject"] %>"
                   class="c-hero-btn c-hero-btn-bulk">
                    <i class="ti ti-files"></i> Upload Bulk
                </a>
            </div>
        </div>

        <!-- Upload Form Panel -->
        <div class="c-panel">
            <div class="c-panel-title">Upload Resource Form</div>
          

            <div id="msgBanner">
                <i class="ti ti-info-circle"></i>
                <span><asp:Literal ID="litMsgText" runat="server"></asp:Literal></span>
            </div>

            <div class="c-form-row">
                <div class="form-group">
                    <label><span class="req-dot"></span> Name of Topic</label>
                    <asp:TextBox ID="TextBox1" runat="server" class="form-control" placeholder="e.g. Introduction to Data Structures"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server"
                        ErrorMessage="Enter topic name*"
                        ControlToValidate="TextBox1"
                        CssClass="c-val-msg"
                        Display="Dynamic"
                        ValidationGroup="UploadForm">
                    </asp:RequiredFieldValidator>
                </div>

                <div class="form-group">
                    <label><span class="req-dot"></span> Select File Type</label>
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
                <label><span class="req-dot"></span> Upload Files</label>
                <asp:FileUpload ID="FileUpload1" runat="server" style="display:none;"
                    accept=".pdf,.doc,.docx,.ppt,.pptx,.xls,.xlsx,.jpg,.png,.zip,.txt" />

                <div id="dropZone" role="button" tabindex="0" aria-label="Upload a file: click to browse or drag a file here">
                    <i class="ti ti-cloud-upload" style="font-size:2.5rem; color:var(--primary); margin-bottom:8px; display:block;"></i>
                    <p style="margin:0 0 4px; font-weight:700; color:var(--primary); font-size:14px;">
                        Drag &amp; drop your file here
                    </p>
                    <p style="font-size:12px; color:#9ca3af; margin:0 0 14px;">
                        PDF, DOC, PPT, XLS, JPG, PNG, ZIP &middot; up to 25&nbsp;MB
                    </p>
                    <button type="button" id="btnBrowse" class="c-btn-submit"
                            style="padding:8px 22px; font-size:12px;">
                        <i class="ti ti-folder-open" style="margin-right:5px;"></i>Browse File
                    </button>
                    <div id="filePreview">
                        <i class="ti ti-file-check" style="font-size:1.4rem; color:#16a34a;"></i>
                        <div>
                            <p id="fileName" style="margin:0; font-size:13px; font-weight:700; color:#15803d;"></p>
                            <p id="fileSize" style="margin:0; font-size:11px; color:#6b7280;"></p>
                        </div>
                        <button type="button" id="btnClearFile" aria-label="Remove selected file"
                                style="margin-left:auto; background:none; border:none;
                                       cursor:pointer; color:#16a34a; font-size:1.1rem;">
                            <i class="ti ti-x"></i>
                        </button>
                    </div>
                    <div id="fileWarning">
                        <i class="ti ti-alert-triangle"></i>
                        <span id="fileWarningText"></span>
                    </div>
                </div>
            </div>

            <div id="divFileDestination">
                <div class="form-group">
                    <label><span class="req-dot"></span> File Destination</label>
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

            <asp:Label ID="lblMessage" runat="server" CssClass="c-val-msg" aria-live="polite"></asp:Label>
            <br /><br />
            <asp:Button ID="Button1" runat="server" CssClass="c-btn-submit" Text="Submit Content"
                OnClick="Button1_Click" ValidationGroup="UploadForm"
                OnClientClick="return handleSubmitClick(this);" />
        </div>

        <!-- Table Panel -->
        <div class="c-panel">
            <div class="c-panel-title">Uploaded Course Modules Database</div>
            
            <div class="c-table-container">
                <asp:GridView ID="GridView1" runat="server"
                    AutoGenerateColumns="False"
                    DataKeyNames="id"
                    class="table-modern"
                    GridLines="None"
                    BorderWidth="0"
                    CellPadding="0"
                    OnRowDeleting="GridView1_RowDeleting1"
                    OnRowEditing="GridView1_RowEditing1"
                    OnRowUpdating="GridView1_RowUpdating1"
                    OnRowCancelingEdit="GridView1_RowCancelingEdit1">
                    <Columns>
                        <asp:BoundField DataField="Topic"       HeaderText="Topic" />
                        <asp:BoundField DataField="Name"        HeaderText="Name" />
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
                        <asp:CommandField ShowEditButton="True" ShowDeleteButton="True" CausesValidation="false"/>
                    </Columns>
                    <EmptyDataTemplate>
                        <div class="c-empty-state">
                            <i class="ti ti-folder-off"></i>
                            
                        </div>
                    </EmptyDataTemplate>
                </asp:GridView>
            </div>
        </div>
    </div>

    <script>
        window.addEventListener('DOMContentLoaded', function () {

            // ── Message banner: surface lblMessage (if server set it) in a styled banner ──
            var lblMessage = document.getElementById('<%= lblMessage.ClientID %>');
            var msgBanner  = document.getElementById('msgBanner');
            if (lblMessage && msgBanner && lblMessage.textContent.trim().length > 0) {
                var isError = /fail|error|invalid|required|\*/i.test(lblMessage.textContent);
                msgBanner.classList.add('visible');
                msgBanner.style.color = isError ? 'var(--danger)' : 'var(--success)';
                msgBanner.style.background = isError ? 'var(--danger-bg)' : 'var(--success-bg)';
                msgBanner.style.borderColor = isError ? 'var(--danger-border)' : 'var(--success-border)';
                msgBanner.querySelector('i').className = isError ? 'ti ti-alert-circle' : 'ti ti-circle-check';
                msgBanner.querySelector('span').textContent = lblMessage.textContent;
                lblMessage.style.display = 'none';
            }

            // ── Destination filtering based on selected file type ──
            var fileTypeEl  = document.getElementById('<%= ddlFileType.ClientID %>');
            var destWrapper = document.getElementById('divFileDestination');
            var destEl      = document.getElementById('<%= ddlContentType.ClientID %>');

            if (fileTypeEl && destEl) {
                var allOptions    = Array.from(destEl.options).slice(1);
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

            // ── Drop zone ──
            var dropZone    = document.getElementById('dropZone');
            var fileInput = document.getElementById('<%= FileUpload1.ClientID %>');
            var filePreview = document.getElementById('filePreview');
            var fileNameEl = document.getElementById('fileName');
            var fileSizeEl = document.getElementById('fileSize');
            var btnBrowse = document.getElementById('btnBrowse');
            var btnClear = document.getElementById('btnClearFile');
            var fileWarning = document.getElementById('fileWarning');
            var fileWarningText = document.getElementById('fileWarningText');
            var MAX_BYTES = 25 * 1024 * 1024;

            function formatSize(bytes) {
                if (bytes < 1024) return bytes + ' B';
                if (bytes < 1048576) return (bytes / 1024).toFixed(1) + ' KB';
                return (bytes / 1048576).toFixed(2) + ' MB';
            }

            function showWarning(text) {
                fileWarningText.textContent = text;
                fileWarning.classList.add('visible');
            }

            function hideWarning() {
                fileWarning.classList.remove('visible');
            }

            function showFile(file) {
                hideWarning();
                if (file.size > MAX_BYTES) {
                    showWarning('This file is ' + formatSize(file.size) + ', which is over the 25 MB limit. Choose a smaller file.');
                    clearFile();
                    return;
                }
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
                dropZone.addEventListener('keydown', function (e) {
                    if (e.key === 'Enter' || e.key === ' ') { e.preventDefault(); fileInput.click(); }
                });
                fileInput.addEventListener('change', function () { if (this.files && this.files[0]) showFile(this.files[0]); });
                btnClear.addEventListener('click', function (e) { e.stopPropagation(); clearFile(); hideWarning(); });
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

            // ── Mobile card-view: tag each cell with its column header for the ::before label ──
            function applyDataLabels() {
                var table = document.querySelector('.table-modern');
                if (!table) return;
                var headerCells = table.querySelectorAll('thead th');
                if (!headerCells.length) return;
                var headers = Array.from(headerCells).map(function (th) { return th.textContent.trim(); });
                table.querySelectorAll('tbody tr').forEach(function (row) {
                    var cells = row.querySelectorAll('td');
                    cells.forEach(function (td, i) {
                        if (headers[i]) td.setAttribute('data-label', headers[i]);
                        if (headers[i] === 'Action' || td.querySelectorAll('a, input[type=submit]').length > 0) {
                            td.classList.add('c-td-actions');
                        }
                    });
                });
            }
            applyDataLabels();

            // ── Confirm before deleting a row ──
            document.addEventListener('click', function (e) {
                var link = e.target.closest('.table-modern a, .table-modern input[type=submit]');
                if (!link) return;
                var label = (link.value || link.textContent || '').trim().toLowerCase();
                if (label === 'delete') {
                    if (!confirm('Delete this item? This cannot be undone.')) {
                        e.preventDefault();
                        e.stopPropagation();
                    }
                }
            }, true);

        });

// ── Submit button loading state (kept outside DOMContentLoaded so it's
//    available immediately for the OnClientClick attribute) ──
function handleSubmitClick(btn) {
    if (typeof Page_ClientValidate === 'function') {
        if (!Page_ClientValidate('UploadForm')) {
            return false;
        }
    }
    btn.classList.add('is-loading');
    btn.value = 'Uploading…';
    // Disable on the next tick, after the browser has already queued
    // this click's form submission. Disabling synchronously here would
    // exclude the button's name/value from the POST body, and ASP.NET
    // would never see which control triggered the postback.
    window.setTimeout(function () {
        btn.disabled = true;
    }, 0);
    return true;
}
</script>

</asp:Content>

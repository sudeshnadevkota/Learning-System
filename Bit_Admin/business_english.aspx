

<%@ Page Title="" Language="C#" MasterPageFile="~/Bit_Admin/upload.Master" AutoEventWireup="true" CodeBehind="business_english.aspx.cs" Inherits="Learning_System.Bit_Admin.business_english" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <style>
        @import url('https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700&display=swap');
        @import url('https://cdn.jsdelivr.net/npm/@tabler/icons-webfont@latest/tabler-icons.min.css');

        :root {
            --primary: #0B1F66;
            --secondary: #081547;
            --pink: #FF2D8D;
            --gray-bg: #fafbff;
            --border-color: rgba(11,31,102,0.08);
        }

        .c-wrap {
            font-family: 'Plus Jakarta Sans', sans-serif;
            padding: 1.5rem;
        }

        .c-hero {
            background: linear-gradient(135deg, #0B1F66 0%, #1a3499 100%);
            padding: 30px 32px;
            border-radius: 16px;
            margin-bottom: 24px;
            color: #fff;
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
        }

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
            background: rgba(255, 45, 141, 0.04);
        }

        #dropZone.has-file {
            border-color: #4ade80;
            background: #f0fdf4;
        }

        #filePreview {
            display: none;
            margin-top: 16px;
            padding: 10px 14px;
            background: #f0fdf4;
            border: 1px solid #4ade80;
            border-radius: 8px;
            align-items: center;
            gap: 10px;
        }

        #filePreview.visible {
            display: flex !important;
        }
    </style>

    <div class="c-wrap container-fluid">
        <div class="c-hero">
            <h3><i class="ti ti-vocabulary"></i> Course Content Management: Business English</h3>
        </div>

        <div class="c-panel">
            <div class="c-panel-title">Upload Resource Form</div>

            <div class="c-form-row">
                <div class="form-group">
                    <label>Name of Topic</label>
                    <asp:TextBox ID="TextBox1" runat="server" class="form-control" placeholder="Enter topic name"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server"
                        ErrorMessage="Enter topic name*"
                        ControlToValidate="TextBox1"
                        CssClass="c-val-msg">
                    </asp:RequiredFieldValidator>
                </div>

                <div class="form-group">
                    <label>Select File Type</label>
                    <asp:DropDownList ID="ddlFileType" runat="server" class="form-control">
                        <asp:ListItem Text="-- Select Category --" Value="" />
                        <asp:ListItem Text="Lecture Content"      Value="Lecture" />
                        <asp:ListItem Text="Tutorial Content"     Value="Tutorial" />
                        <asp:ListItem Text="Workshop Content"     Value="Workshop" />
                        <asp:ListItem Text="Past Year Question"   Value="PYQ" />
                        <asp:ListItem Text="Assignment"           Value="Assignment" />
                    </asp:DropDownList>
                </div>
            </div>

            <%-- Plain HTML file input — no runat="server" to avoid the IIS Express crash --%>
            <div class="form-group">
                <label>Upload Files</label>

                <input type="file" id="FileUpload1" name="FileUpload1" style="display:none;"
                    accept=".pdf,.doc,.docx,.ppt,.pptx,.xls,.xlsx,.jpg,.png,.zip,.txt" />

                <div id="dropZone">
                    <i class="ti ti-cloud-upload" style="font-size:2.5rem; color:var(--primary); margin-bottom:8px; display:block;"></i>
                    <p style="margin:0 0 4px; font-weight:700; color:var(--primary); font-size:14px;">
                        Drag &amp; drop your file here
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
            <asp:Button ID="Button1" runat="server" class="c-btn-submit" Text="Submit Content" OnClick="Button1_Click" />
        </div>

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
                    OnRowEditing="GridView1_RowEditing1">
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
                        <asp:CommandField ShowEditButton="True" ShowDeleteButton="True" />
                    </Columns>
                </asp:GridView>
            </div>
        </div>
    </div>

    <script>
        (function () {

            // ── Destination filter ────────────────────────────────────────
            var fileTypeEl = document.getElementById('<%= ddlFileType.ClientID %>');
            var destWrapper = document.getElementById('divFileDestination');
            var destEl      = document.getElementById('<%= ddlContentType.ClientID %>');

            var allOptions = Array.from(destEl.options).slice(1);
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

            fileTypeEl.addEventListener('change', function () {
                filterDestination(this.value);
            });
            filterDestination(fileTypeEl.value);


            // ── Drag & Drop File Upload ───────────────────────────────────
            var dropZone = document.getElementById('dropZone');
            var fileInput = document.getElementById('FileUpload1');
            var filePreview = document.getElementById('filePreview');
            var fileNameEl = document.getElementById('fileName');
            var fileSizeEl = document.getElementById('fileSize');
            var btnBrowse = document.getElementById('btnBrowse');
            var btnClear = document.getElementById('btnClearFile');

            function formatSize(bytes) {
                if (bytes < 1024) return bytes + ' B';
                if (bytes < 1024 * 1024) return (bytes / 1024).toFixed(1) + ' KB';
                return (bytes / (1024 * 1024)).toFixed(2) + ' MB';
            }

            function showFile(file) {
                fileNameEl.textContent = file.name;
                fileSizeEl.textContent = formatSize(file.size);
                filePreview.classList.add('visible');
                dropZone.classList.add('has-file');
                dropZone.classList.remove('dragover');
            }

            function clearFile() {
                fileInput.value = '';
                filePreview.classList.remove('visible');
                dropZone.classList.remove('has-file');
                fileNameEl.textContent = '';
                fileSizeEl.textContent = '';
            }

            btnBrowse.addEventListener('click', function (e) {
                e.stopPropagation();
                fileInput.click();
            });

            dropZone.addEventListener('click', function (e) {
                if (e.target !== btnBrowse && e.target !== btnClear) {
                    fileInput.click();
                }
            });

            fileInput.addEventListener('change', function () {
                if (this.files && this.files[0]) {
                    showFile(this.files[0]);
                }
            });

            btnClear.addEventListener('click', function (e) {
                e.stopPropagation();
                clearFile();
            });

            dropZone.addEventListener('dragover', function (e) {
                e.preventDefault();
                dropZone.classList.add('dragover');
            });

            dropZone.addEventListener('dragleave', function (e) {
                if (!dropZone.contains(e.relatedTarget)) {
                    dropZone.classList.remove('dragover');
                }
            });

            dropZone.addEventListener('drop', function (e) {
                e.preventDefault();
                dropZone.classList.remove('dragover');
                var files = e.dataTransfer.files;
                if (files && files[0]) {
                    try {
                        var dt = new DataTransfer();
                        dt.items.add(files[0]);
                        fileInput.files = dt.files;
                        showFile(files[0]);
                    } catch (err) {
                        fileNameEl.textContent = files[0].name;
                        filePreview.classList.add('visible');
                    }
                }
            });

        })();
    </script>

</asp:Content>
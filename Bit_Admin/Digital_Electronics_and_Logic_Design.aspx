<%@ Page Title="" Language="C#" MasterPageFile="~/Bit_Admin/upload.Master" AutoEventWireup="true" CodeBehind="Digital_Electronics_and_Logic_Design.aspx.cs" Inherits="Learning_System.Bit_Admin.digital_logics" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

<style>
    @import url('https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700&display=swap');
    @import url('https://cdn.jsdelivr.net/npm/@tabler/icons-webfont@latest/tabler-icons.min.css');

    :root {
        --primary: #0B1F66;
        --secondary: #081547;
        --pink: #FF2D8D;
        --yellow: #F6B400;
        --gray-bg: #fafbff;
        --border-color: rgba(11,31,102,0.08);
    }

    .c-wrap { 
        font-family: 'Plus Jakarta Sans', sans-serif; 
        padding: 1.5rem;
    }

    /* ── HEADER HERO BANNER ── */
    .c-hero {
        background: linear-gradient(135deg, #0B1F66 0%, #1a3499 100%);
        padding: 30px 32px;
        border-radius: 16px;
        position: relative;
        overflow: hidden;
        margin-bottom: 24px;
        box-shadow: 0 4px 20px rgba(11, 31, 102, 0.08);
    }
    .c-hero-ring { position: absolute; right: -20px; top: -20px; width: 140px; height: 140px; border-radius: 50%; border: 1px solid rgba(255,45,141,0.1); pointer-events: none; }
    .c-hero h3 { font-size: 24px; font-weight: 700; color: #fff; letter-spacing: 0.5px; margin: 0; display: flex; align-items: center; gap: 12px; }
    .c-hero h3 i { color: #FF2D8D; font-size: 26px; }

    /* ── CONTAINER PANELS (STACKED FULL WIDTH) ── */
    .c-panel {
        background: #ffffff;
        border: 1px solid var(--border-color);
        border-radius: 14px;
        padding: 28px;
        box-shadow: 0 4px 15px rgba(11,31,102,0.02);
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
    .c-panel-title::after { content: ''; flex: 1; height: 1px; background: var(--border-color); }

    /* ── FORM CONTROL ROW MIX ── */
    .c-form-row {
        display: grid;
        grid-template-columns: 1fr 1fr;
        gap: 20px;
        margin-bottom: 12px;
    }

    @media (max-width: 768px) {
        .c-form-row { grid-template-columns: 1fr; gap: 14px; }
    }

    .form-group { position: relative; }
    .form-group label { font-size: 12px; font-weight: 600; color: var(--primary); margin-bottom: 8px; display: block; }
    
    .c-wrap .form-control {
        font-family: 'Plus Jakarta Sans', sans-serif;
        font-size: 13.5px;
        color: #333;
        background-color: var(--gray-bg);
        border: 1px solid var(--border-color);
        border-radius: 8px;
        padding: 11px 16px;
        height: auto;
        width: 100%;
        box-sizing: border-box;
        transition: border-color 0.2s, background-color 0.2s;
    }
    .c-wrap .form-control:focus {
        border-color: rgba(255, 45, 141, 0.4);
        background-color: #fff;
        box-shadow: none;
        outline: none;
    }

    .c-wrap input[type="file"].form-control {
        padding: 8px 14px;
    }

    .c-val-msg {
        display: block;
        font-size: 11px;
        margin-top: 5px;
        font-weight: 500;
    }

    /* Action footer inside form panel */
    .c-form-footer {
        display: flex;
        align-items: center;
        justify-content: space-between;
        margin-top: 10px;
        padding-top: 10px;
    }

    .c-btn-submit {
        font-family: 'Plus Jakarta Sans', sans-serif;
        font-size: 13px;
        font-weight: 700;
        color: #fff !important;
        background: var(--pink) !important;
        border: none !important;
        border-radius: 8px;
        padding: 11px 28px;
        cursor: pointer;
        transition: transform 0.15s, opacity 0.15s;
        text-transform: uppercase;
        letter-spacing: 0.5px;
    }
    .c-btn-submit:hover { opacity: 0.9; transform: translateY(-1px); }

    .c-msg-lbl {
        font-size: 13px;
        font-weight: 600;
    }

    /* ── FULL WIDTH INTERACTIVE DATA TABLE ── */
    .c-table-container {
        overflow-x: auto;
        width: 100%;
    }

    .c-wrap .table-modern {
        width: 100%;
        margin-bottom: 0;
        color: var(--primary);
        border-collapse: separate;
        border-spacing: 0;
        border: none;
    }

    .c-wrap .table-modern th {
        background: var(--gray-bg);
        font-size: 11px;
        font-weight: 700;
        text-transform: uppercase;
        letter-spacing: 0.5px;
        color: rgba(11,31,102,0.6);
        padding: 16px 20px;
        border-bottom: 2px solid var(--border-color);
        border-top: none;
        border-left: none;
        border-right: none;
    }

    .c-wrap .table-modern td {
        padding: 16px 20px;
        font-size: 13.5px;
        vertical-align: middle;
        border-bottom: 1px solid var(--border-color);
        border-top: none;
        border-left: none;
        border-right: none;
        background: #fff;
    }

    .c-wrap .table-modern tr:last-child td {
        border-bottom: none;
    }

    .c-wrap .table-modern tr:hover td {
        background-color: rgba(11,31,102,0.01);
    }

    .c-wrap .table-modern td input[type="text"] {
        width: 100%;
        padding: 6px 12px;
        font-size: 13px;
        border: 1px solid var(--border-color);
        border-radius: 6px;
    }

    /* Custom Delete buttons inside cells */
    .c-wrap .table-modern input[type="button"] {
        font-family: 'Plus Jakarta Sans', sans-serif;
        font-size: 11px;
        font-weight: 700;
        text-transform: uppercase;
        letter-spacing: 0.5px;
        background: rgba(255, 45, 141, 0.08);
        border: 1px solid rgba(255, 45, 141, 0.15);
        padding: 6px 16px;
        border-radius: 6px;
        cursor: pointer;
        transition: all 0.2s;
    }
    .c-wrap .table-modern input[type="button"]:hover {
        background: var(--pink);
        color: #fff !important;
        border-color: transparent;
    }
</style>

<div class="c-wrap container-fluid">

    <%-- HEADER HERO BANNER --%>
    <div class="c-hero">
        <div class="c-hero-ring"></div>
        <h3><i class="ti ti-cpu"></i> Course Content Management: Digital Logics</h3>
    </div>

    <%-- STACK 1: FULL WIDTH FORM PANEL --%>
    <div class="c-panel">
        <div class="c-panel-title">
            <i class="ti ti-file-plus" style="font-size: 14px; color: var(--pink)"></i> Upload Resource Form
        </div>
        
        <div class="c-form-row">
            <div class="form-group">
                <label for="Unite">Name of Topic</label>
                <asp:TextBox ID="TextBox1" runat="server" class="form-control" placeholder="Enter topic name (e.g., Sequential Circuit Design & Karnaugh Maps)"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="Enter topic name*" ControlToValidate="TextBox1" ForeColor="Red" CssClass="c-val-msg"></asp:RequiredFieldValidator>
            </div>

            <div class="form-group">
                <label for="Unite">Upload Files</label>
                <asp:FileUpload ID="FileUpload1" runat="server" class="form-control" />
                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="Upload your file*" ControlToValidate="FileUpload1" ForeColor="Red" CssClass="c-val-msg"></asp:RequiredFieldValidator>
            </div>
        </div>

        <div class="c-form-footer">
            <div>
                <asp:Label ID="lblMessage" Text="" runat="server" CssClass="c-msg-lbl" />
            </div>
            <asp:Button ID="Button1" runat="server" class="c-btn-submit" Text="Submit Content" OnClick="Button1_Click" />
        </div>
    </div>

    <%-- STACK 2: FULL WIDTH DATABASE RECORDS --%>
    <div class="c-panel">
        <div class="c-panel-title">
            <i class="ti ti-database" style="font-size: 14px; color: var(--primary)"></i> Uploaded Course Modules Database
        </div>

        <div class="c-table-container">
            <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataKeyNames="id" class="table-modern" OnRowDeleting="GridView1_RowDeleting1">
                <Columns>
                    <asp:TemplateField HeaderText="Topic">
                        <EditItemTemplate>
                            <asp:TextBox ID="TextBox2" runat="server" Text='<%# Eval("Topic") %>'></asp:TextBox>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="Label2" runat="server" Text='<%# Eval("Topic") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Name">
                        <EditItemTemplate>
                            <asp:TextBox ID="TextBox3" runat="server" Text='<%# Eval("Name") %>'></asp:TextBox>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="Label3" runat="server" Text='<%# Eval("Name") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Data Type">
                        <EditItemTemplate>
                            <asp:TextBox ID="TextBox4" runat="server" Text='<%# Eval("ContentType") %>'></asp:TextBox>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="Label4" runat="server" Text='<%# Eval("ContentType") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Data">
                        <EditItemTemplate>
                            <asp:TextBox ID="TextBox5" runat="server" Text='<%# Eval("Data") %>'></asp:TextBox>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="Label5" runat="server" Text='<%# Eval("Data") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:CommandField ShowDeleteButton="True" ButtonType="Button" ControlStyle-ForeColor="Red" />
                </Columns>
            </asp:GridView>
        </div>
    </div>

</div>

</asp:Content>
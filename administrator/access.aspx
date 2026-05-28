<%@ Page Title="" Language="C#" MasterPageFile="~/administrator/administrator_master.Master" AutoEventWireup="true" CodeBehind="access.aspx.cs" Inherits="Learning_System.administrator.access" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container" style="padding-top: 20px; padding-bottom: 20px;">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h3 class="fw-bold" style="color: #2c3e50; padding-right: 10px;">Access </h3>
            <div class="d-flex align-items-center">
                <div id="search" style="display: flex;">
                    <asp:TextBox ID="txtSearch" runat="server" CssClass="form-control" placeholder="Search events"></asp:TextBox>
                    <asp:Button ID="btnSearch" runat="server" Text="Search" CssClass="btn btn-primary" OnClick="btnSearch_Click" />
                </div>
            </div>
        </div>

        <asp:GridView ID="register" runat="server" OnRowDeleting="register_RowDeleting" OnRowEditing="register_RowEditing" OnRowUpdating="register_RowUpdating" OnRowCancelingEdit="register_RowCancelingEdit" DataKeyNames="id" AutoGenerateColumns="False" class="table table-hover">
            <Columns>
                <asp:BoundField DataField="full_name" HeaderText="Full Name" SortExpression="full_name" />
                <asp:BoundField DataField="contact" HeaderText="Contact" SortExpression="contact" />
                <asp:BoundField DataField="Username" HeaderText="Username" SortExpression="Username" />
                <asp:BoundField DataField="status" HeaderText="Status" SortExpression="status" />
                <asp:TemplateField HeaderText="Role">
                    <ItemTemplate>
                        <%# Eval("role") %>
                    </ItemTemplate>
                    <EditItemTemplate>
                        <asp:DropDownList ID="ddlrole" runat="server">
                            <asp:ListItem Text="" Value="select role" />
                            <asp:ListItem Text="verification" Value="verification" />
                            <asp:ListItem Text="students" Value="students" />
                            <asp:ListItem Text="Bit_Admin" Value="Bit_Admin" />
                            <asp:ListItem Text="Bhm_Admin" Value="Bhm_Admin" />
                            <asp:ListItem Text="Mcs_Admin" Value="Mcs_Admin" />
                            <asp:ListItem Text="Bba_Admin" Value="Bba_Admin" />
                            <asp:ListItem Text="Mba_Admin" Value="Mba_Admin" />
                            <asp:ListItem Text="Bcs_Admin" Value="Bcs_Admin" />
                            <asp:ListItem Text="pyq_Bit" Value="pyq_Bit" />
                            <asp:ListItem Text="pyq_Bcs" Value="pyq_Bcs" />
                            <asp:ListItem Text="pyq_Mba" Value="pyq_Mba" />
                            <asp:ListItem Text="pyq_Mcs" Value="pyq_Mcs" />
                            <asp:ListItem Text="pyq_bhm" Value="pyq_bhm" />
                            <asp:ListItem Text="pyq_BBA" Value="pyq_BBA" />
                            <asp:ListItem Text="superadmin" Value="superadmin" />
                        </asp:DropDownList>
                    </EditItemTemplate>
                </asp:TemplateField>
                <asp:CommandField ControlStyle-CssClass="btn btn-success" ShowEditButton="True" HeaderText="Edit" />
                <asp:CommandField ControlStyle-CssClass="btn btn-danger" ShowDeleteButton="True" HeaderText="Delete" DeleteText="Delete" ButtonType="Button" />
            </Columns>
        </asp:GridView>
    </div>
</asp:Content>

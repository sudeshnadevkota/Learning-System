<%@ Page Title="" Language="C#" MasterPageFile="~/verification/verification_dash.Master" AutoEventWireup="true" CodeBehind="approvestudents.aspx.cs" Inherits="Learning_System.verification.approvestudents" %>

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
                <asp:BoundField DataField="faculty" HeaderText="faculty" SortExpression="faculty" />
                <asp:TemplateField HeaderText="Role">
                    <ItemTemplate>
                        <%# Eval("role") %>
                    </ItemTemplate>
                    <EditItemTemplate>
                        <asp:DropDownList ID="ddlrole" runat="server">
                            <asp:ListItem Text="Decline" Value="Decline" />
                            <asp:ListItem Text="Approved" Value="students" />
                        </asp:DropDownList>
                    </EditItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Semester">
                    <ItemTemplate>
                        <%# Eval("semester") %>
                    </ItemTemplate>
                    <EditItemTemplate>
                        <asp:DropDownList ID="ddlsemester" runat="server">
                            <asp:ListItem Text="Decline" Value="Decline" />
                            <asp:ListItem Text="BIT_SEM_1" Value="BIT_SEM_1" />
                            <asp:ListItem Text="BIT_SEM_2" Value="BIT_SEM_2" />
                            <asp:ListItem Text="BIT_SEM_22" Value="BIT_SEM_22" />
                        </asp:DropDownList>
                    </EditItemTemplate>
                </asp:TemplateField>
                <asp:CommandField ControlStyle-CssClass="btn btn-success" ShowEditButton="True" HeaderText="Edit" />
                <asp:CommandField ControlStyle-CssClass="btn btn-danger" ShowDeleteButton="True" HeaderText="Delete" DeleteText="Delete" ButtonType="Button" />
            </Columns>
        </asp:GridView>
    </div>
</asp:Content>

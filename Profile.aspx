<%@ Page Title="" Language="C#" MasterPageFile="~/learning.Master" AutoEventWireup="true" CodeBehind="Profile.aspx.cs" Inherits="Learning_System.Profile" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">


    <div class="container py-5">
    <h2>My Profile</h2>
    <div class="row">
        <div class="col-md-4 text-center">
            <asp:Image ID="imgProfile" runat="server" Width="150px" Height="150px" CssClass="rounded-circle border" />
            <asp:FileUpload ID="fileUpload" runat="server" CssClass="form-control mt-2" />
        </div>
        <div class="col-md-8">
            <div class="mb-3">
                <label>Full Name</label>
                <asp:TextBox ID="txtFullName" runat="server" CssClass="form-control" />
            </div>
            <div class="mb-3">
                <label>Contact Number</label>
                <asp:TextBox ID="txtContact" runat="server" CssClass="form-control" />
            </div>
            <div class="mb-3">
                <label>Address</label>
                <asp:TextBox ID="txtAddress" runat="server" CssClass="form-control" />
            </div>
            <asp:Button ID="btnUpdate" runat="server" Text="Update Profile" CssClass="btn btn-primary" OnClick="btnUpdate_Click" />
            <asp:Label ID="lblMsg" runat="server" />
        </div>
    </div>
</div>
</asp:Content>

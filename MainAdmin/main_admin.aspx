<%@ Page Title="Main Admin" Language="C#" AutoEventWireup="true" CodeBehind="main_admin.aspx.cs" Inherits="Learning_System.MainAdmin.main_admin" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Main Admin Dashboard</title>
</head>
<body>
    <form id="form1" runat="server">
        <div style="padding:40px;font-family:sans-serif;">
            <h2>Main Admin Dashboard — Coming Soon</h2>
            <p>Logged in as: <%= Session["Username"] %></p>
        </div>
    </form>
</body>
</html>
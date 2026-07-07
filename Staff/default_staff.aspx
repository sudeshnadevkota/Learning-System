<%@ Page Title="Staff Dashboard" Language="C#" AutoEventWireup="true" CodeBehind="default_staff.aspx.cs" Inherits="Learning_System.Staff.default_staff" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Staff Dashboard</title>
</head>
<body>
    <form id="form1" runat="server">
        <div style="padding:40px;font-family:sans-serif;">
            <h2>Staff Dashboard — Coming Soon</h2>
            <p>Logged in as: <%= Session["Username"] %></p>
        </div>
    </form>
</body>
</html>
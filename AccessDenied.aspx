<%@ Page Title="" Language="C#" MasterPageFile="~/learning.Master" AutoEventWireup="true" CodeBehind="AccessDenied.aspx.cs" Inherits="Learning_System.AccessDenied" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <style>
        .lp-denied-wrap {
            max-width: 520px;
            margin: 80px auto;
            text-align: center;
            padding: 40px;
        }
        .lp-denied-wrap h2 {
            color: #dc2626;
            font-size: 24px;
            margin-bottom: 12px;
        }
        .lp-denied-wrap p {
            color: #64748b;
            font-size: 15px;
            margin-bottom: 24px;
        }
        .lp-denied-link {
            color: #2B397D;
            font-weight: 700;
            text-decoration: none;
        }
    </style>

    <div class="lp-denied-wrap">
        <h2>Access Denied</h2>
        <p>You don't have permission to view this page. If you believe this is a mistake, contact your system administrator.</p>
        <a class="lp-denied-link" href="~/Login.aspx" runat="server">Return to Login</a>
    </div>
</asp:Content>

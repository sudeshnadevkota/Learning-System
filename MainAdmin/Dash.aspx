<%@ Page Title="Main Admin Dashboard" Language="C#" MasterPageFile="~/MainAdmin/MainAdmin.master" AutoEventWireup="true" CodeBehind="Dash.aspx.cs" Inherits="Learning_System.MainAdmin.Dash" %>
<%@ MasterType VirtualPath="~/MainAdmin/MainAdmin.master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <div class="c-topbar c-fade-up"> 
        <div>
            <h1><i class="ti ti-crown"></i> Main Admin Dashboard</h1>
            <p>Logged in as <strong><%= Session["Username"] %></strong> &middot; Full system access</p>
        </div>
        <div class="c-topbar-actions">
            
            <asp:HyperLink runat="server" NavigateUrl="~/logout.aspx" CssClass="c-btn-pink">
                <i class="ti ti-logout"></i> Logout
            </asp:HyperLink>
        </div>
    </div>

    <!-- Stat Cards -->
    <div class="c-stats-grid c-fade-up" style="animation-delay: 0.05s;">
        <div class="c-stat-card">
            <div class="c-stat-icon blue"><i class="ti ti-building"></i></div>
            <div>
                <div class="c-stat-value"><asp:Literal ID="litDeptCount" runat="server">0</asp:Literal></div>
                <div class="c-stat-label">Departments</div>
            </div>
        </div>
        <div class="c-stat-card">
            <div class="c-stat-icon rose"><i class="ti ti-shield-star"></i></div>
            <div>
                <div class="c-stat-value"><asp:Literal ID="litSuperAdminCount" runat="server">0</asp:Literal></div>
                <div class="c-stat-label">Super Admins</div>
            </div>
        </div>
        <div class="c-stat-card">
            <div class="c-stat-icon blue"><i class="ti ti-user-cog"></i></div>
            <div>
                <div class="c-stat-value"><asp:Literal ID="litDeptAdminCount" runat="server">0</asp:Literal></div>
                <div class="c-stat-label">Dept Admins</div>
            </div>
        </div>
        <div class="c-stat-card">
            <div class="c-stat-icon purple"><i class="ti ti-user-check"></i></div>
            <div>
                <div class="c-stat-value"><asp:Literal ID="litStaffCount" runat="server">0</asp:Literal></div>
                <div class="c-stat-label">Staff</div>
            </div>
        </div>
        <div class="c-stat-card">
            <div class="c-stat-icon rose"><i class="ti ti-users"></i></div>
            <div>
                <div class="c-stat-value"><asp:Literal ID="litStudentCount" runat="server">0</asp:Literal></div>
                <div class="c-stat-label">Students</div>
            </div>
        </div>
        <div class="c-stat-card">
            <div class="c-stat-icon amber"><i class="ti ti-book-2"></i></div>
            <div>
                <div class="c-stat-value"><asp:Literal ID="litSubjectCount" runat="server">0</asp:Literal></div>
                <div class="c-stat-label">Subjects</div>
            </div>
        </div>
    </div>

    <!-- Department Overview -->
    <div class="c-panel c-fade-up" style="animation-delay: 0.1s;">
        <div class="c-panel-header">
            <div class="c-panel-title">
                <span class="c-panel-title-icon"><i class="ti ti-building-community"></i></span>
                Department Overview
            </div>
            <a href="../SuperAdmin/DepartmentManage.aspx" class="c-view-all">View All <i class="ti ti-chevron-right"></i></a>
        </div>
        <div class="c-table-container">
            <asp:GridView ID="gvDepartments" runat="server"
                AutoGenerateColumns="False"
                CssClass="table-modern"
                GridLines="None" BorderWidth="0" CellPadding="0"
                EmptyDataText="No departments found.">
                <Columns>
                    <asp:BoundField DataField="DepartmentName" HeaderText="Department" />
                    <asp:BoundField DataField="DepartmentCode" HeaderText="Code" />
                    <asp:BoundField DataField="DeptAdminCount" HeaderText="Dept Admins" />
                    <asp:BoundField DataField="StaffCount" HeaderText="Staff" />
                    <asp:BoundField DataField="StudentCount" HeaderText="Students" />
                </Columns>
            </asp:GridView>
        </div>
    </div>

    <!-- Quick Actions -->
    <div class="c-panel c-fade-up" style="animation-delay: 0.15s;">
        <div class="c-panel-header">
            <div class="c-panel-title">
                <span class="c-panel-title-icon"><i class="ti ti-bolt"></i></span>
                Quick Actions
            </div>
        </div>
        <div class="c-quick-grid">
            <a href="SuperAdminManage.aspx" class="c-quick-link">
                <span class="c-quick-link-icon rose"><i class="ti ti-shield-star"></i></span>
                Manage Super Admins
            </a>
            <a href="../SuperAdmin/DepartmentManage.aspx" class="c-quick-link">
                <span class="c-quick-link-icon blue"><i class="ti ti-building"></i></span>
                Manage Departments
            </a>
            <a href="/NoticeManage.aspx" class="c-quick-link">
                <span class="c-quick-link-icon purple"><i class="ti ti-speakerphone"></i></span>
                Manage Notices
            </a>
            <a href="AuditLog.aspx" class="c-quick-link">
                <span class="c-quick-link-icon amber"><i class="ti ti-history"></i></span>
                Audit Log
            </a>
        </div>
    </div>

</asp:Content>

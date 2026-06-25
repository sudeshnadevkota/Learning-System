<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="NoticeWidget.ascx.cs" Inherits="Learning_System.Bit_Notes.NoticeWidget" %>



<div class="notice-widget">
  <div class="notice-widget-head">
    <h3>📋 Recent Notices</h3>
    <a href="<%= ResolveUrl("~/Bit_Notes/Notices.aspx") %>">View All</a>
  </div>

  <asp:Repeater ID="rptWidget" runat="server">
    <ItemTemplate>
      <div class="notice-widget-item" onclick="location.href='<%# ResolveUrl("~/Bit_Notes/Notices.aspx") %>'">
        <div>
          <div class="notice-widget-title"><%# Eval("Title") %></div>
          <div class="notice-widget-sub"><%# Eval("PostedByName") %> · <%# Eval("PostedDate", "{0:MMM dd}") %></div>
        </div>
      </div>
    </ItemTemplate>
  </asp:Repeater>

  <asp:Literal ID="litEmpty" runat="server" Visible="false">
    <div class="notice-widget-empty">No notices right now.</div>
  </asp:Literal>
</div>
<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ApproveStudents.ascx.cs" Inherits="Learning_System.ApproveStudents" %>

<div class="appr-wrap">
<style>
.appr-wrap {
  --appr-primary: #2B397D;
  --appr-violet:  #5b4fcf;
  --appr-text:       #0f172a;
  --appr-text-muted: #64748b;
  --appr-border:     #dde3f0;
  --appr-success:    #16a34a;
  --appr-danger:     #dc2626;
}
.appr-wrap * , .appr-wrap *::before, .appr-wrap *::after { box-sizing: border-box; }

.appr-header { margin-bottom: 20px; }
.appr-title { font-size: 22px; font-weight: 800; color: var(--appr-text); letter-spacing: -.3px; }
.appr-subtitle { font-size: 14px; color: var(--appr-text-muted); margin-top: 4px; }

.appr-card {
  background: #fff;
  border-radius: 16px;
  border: 1px solid var(--appr-border);
  box-shadow: 0 4px 20px rgba(0,0,0,.05);
  overflow: hidden;
}

.appr-table { width: 100%; border-collapse: collapse; font-size: 13.5px; }
.appr-table th {
  text-align: left; padding: 13px 16px; background: #f8faff;
  font-size: 11.5px; font-weight: 700; color: #374151;
  text-transform: uppercase; letter-spacing: .06em;
  border-bottom: 1.5px solid var(--appr-border);
}
.appr-table td {
  padding: 13px 16px; border-bottom: 1px solid var(--appr-border);
  color: var(--appr-text); vertical-align: middle;
}
.appr-table tr:last-child td { border-bottom: none; }
.appr-table tr:hover td { background: #fafbff; }

.appr-badge {
  display: inline-block; padding: 4px 10px; border-radius: 999px;
  font-size: 11px; font-weight: 700; background: #fff7e6; color: #d2933c;
}

.appr-btn {
  border: none; border-radius: 9px; padding: 7px 13px;
  font-size: 12.5px; font-weight: 700; cursor: pointer; font-family: inherit;
  margin-right: 6px; transition: opacity .15s ease, transform .15s ease;
}
.appr-btn:hover { opacity: .88; transform: translateY(-1px); }
.appr-btn-approve { background: var(--appr-success); color: #fff; }
.appr-btn-reject  { background: var(--appr-danger);  color: #fff; }

.appr-empty { padding: 40px 20px; text-align: center; color: var(--appr-text-muted); font-size: 14px; }

.appr-msg {
  margin-bottom: 16px; padding: 11px 15px; border-radius: 10px;
  font-size: 13.5px; font-weight: 600;
}
.appr-msg-success { background: #f0fdf4; color: var(--appr-success); border: 1px solid #bbf7d0; }
.appr-msg-error   { background: #fef2f2; color: var(--appr-danger);  border: 1px solid #fecaca; }

.appr-denied {
  padding: 40px 20px; text-align: center; color: var(--appr-danger); font-size: 14.5px; font-weight: 600;
}
</style>

    <asp:Panel ID="pnlDenied" runat="server" CssClass="appr-denied" Visible="false">
        You are not authorized to view student approvals.
    </asp:Panel>

    <asp:Panel ID="pnlContent" runat="server">
        <div class="appr-header">
            <div class="appr-title">Pending Student Approvals</div>
            <div class="appr-subtitle"><asp:Literal ID="ScopeLiteral" runat="server"></asp:Literal></div>
        </div>

        <asp:Label ID="MessageLabel" runat="server" Visible="false"></asp:Label>

        <div class="appr-card">
            <asp:GridView ID="GridView1" runat="server"
                AutoGenerateColumns="false"
                CssClass="appr-table"
                GridLines="None"
                DataKeyNames="ProfileId,DepartmentId"
                OnRowCommand="GridView1_RowCommand"
                EmptyDataText="No pending registrations right now."
                EmptyDataRowStyle-CssClass="appr-empty">
                <Columns>
                    <asp:BoundField DataField="FullName" HeaderText="Full Name" />
                    <asp:BoundField DataField="UserName" HeaderText="Username" />
                    <asp:BoundField DataField="Email" HeaderText="Email" />
                    <asp:BoundField DataField="DepartmentCode" HeaderText="Department" />
                    <asp:BoundField DataField="Semester" HeaderText="Semester" />
                    <asp:BoundField DataField="RegisteredDate" HeaderText="Registered" DataFormatString="{0:dd MMM yyyy}" />
                    <asp:TemplateField HeaderText="Status">
                        <ItemTemplate>
                            <span class="appr-badge"><%# Eval("ApprovalStatus") %></span>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Action">
                        <ItemTemplate>
                            <asp:LinkButton ID="ApproveBtn" runat="server" CssClass="appr-btn appr-btn-approve"
                                CommandName="Approve" CommandArgument='<%# Eval("ProfileId") %>'
                                OnClientClick="return confirm('Approve this student?');">Approve</asp:LinkButton>
                            <asp:LinkButton ID="RejectBtn" runat="server" CssClass="appr-btn appr-btn-reject"
                                CommandName="Reject" CommandArgument='<%# Eval("ProfileId") %>'
                                OnClientClick="return confirm('Reject this registration?');">Reject</asp:LinkButton>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
        </div>
    </asp:Panel>
</div>

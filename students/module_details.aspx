<%@ Page Title="" Language="C#" MasterPageFile="~/students/student.Master" AutoEventWireup="true" CodeBehind="module_details.aspx.cs" Inherits="Learning_System.students.module_details" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container-fluid" style="padding-top: 30px;">
        <div class="container">
            <h4>
                <asp:Label ID="lblSubject" runat="server" />
            </h4>
            <asp:GridView ID="ModuleGridView" runat="server" CssClass="table table-bordered"
                AutoGenerateColumns="false"
                EmptyDataText="No data available for this module.">
                <Columns>
                    <asp:BoundField DataField="Topic" HeaderText="Topic" SortExpression="Topic" />
                    <asp:BoundField DataField="Name" HeaderText="File" SortExpression="Name" />
                    <asp:TemplateField HeaderText="Actions">
                        <ItemTemplate>
                            <asp:LinkButton ID="lnkView" runat="server" Text="View" CssClass="btn btn-sm btn-info"
                                CommandArgument='<%# Eval("Id") %>' OnClientClick='<%# "window.open(\"ViewFile.aspx?id=" + Eval("Id") + "\", \"_blank\"); return false;" %>'>
                            </asp:LinkButton>
                            <asp:LinkButton ID="lnkDownload" runat="server" Text="Download" OnClick="DownloadFile" CssClass="btn btn-sm btn-success"
                                CommandArgument='<%# Eval("Id") %>'>
                            </asp:LinkButton>
                        </ItemTemplate>
                        <ItemStyle HorizontalAlign="Center"></ItemStyle>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
        </div>
    </div>
</asp:Content>

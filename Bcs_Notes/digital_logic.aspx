<%@ Page Title="" Language="C#" MasterPageFile="~/Bcs_Notes/note.Master" AutoEventWireup="true" CodeBehind="digital_logic.aspx.cs" Inherits="Learning_System.Bcs_Notes.digital_logic" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container mt-5">
        <asp:Button ID="btnBackToDash" runat="server" Text="Back to Dashboard" CssClass="btn btn-primary" OnClick="btnBackToDash_Click" />
        <asp:GridView ID="GridView1" runat="server" class="table table-bordered table-condensed table-hover" AutoGenerateColumns="False">
            <Columns>
                <asp:BoundField DataField="Name" HeaderText="File Name"/>
                <asp:BoundField DataField="Topic" HeaderText="Topic"/>
                <asp:TemplateField ItemStyle-HorizontalAlign="Center" HeaderText="Download and View">
                    <ItemTemplate>
                        <asp:LinkButton ID="DownloadFile" runat="server" Text="Download" OnClick="DownloadFile" class="btn btn-success"
                            CommandArgument='<%# Eval("Id") %>'></asp:LinkButton>
                    </ItemTemplate>
                    <ItemStyle HorizontalAlign="Center"></ItemStyle>
                </asp:TemplateField>
            </Columns>
        </asp:GridView>
    </div>
</asp:Content>

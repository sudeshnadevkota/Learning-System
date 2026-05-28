<%@ Page Title="" Language="C#" MasterPageFile="~/Bit_Notes/note.Master" AutoEventWireup="true" CodeBehind="basic_computer_architecture.aspx.cs" Inherits="Learning_System.Bit_Notes.basic_computer_architecture" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container mt-5">
        <!-- Button to navigate back to dashboard -->
        <asp:Button ID="btnBackToDash" runat="server" Text="Back to Dashboard" OnClick="btnBackToDash_Click" CssClass="btn btn-secondary mb-3" />

        <!-- GridView for displaying files -->
        <asp:GridView ID="GridView1" runat="server" class="table table-bordered table-condensed table-hover" AutoGenerateColumns="False">
            <Columns>
                <asp:BoundField DataField="Name" HeaderText="File Name"/>
                <asp:BoundField DataField="Topic" HeaderText="Topic" />
                <asp:TemplateField ItemStyle-HorizontalAlign="Center" HeaderText="Download">
                    <ItemTemplate>
                        <asp:LinkButton ID="lnkDownload" runat="server" Text="Download" OnClick="DownloadFile" class="btn btn-success"
                            CommandArgument='<%# Eval("Id") %>'></asp:LinkButton>
                    </ItemTemplate>
                    <ItemStyle HorizontalAlign="Center"></ItemStyle>
                </asp:TemplateField>
            </Columns>
        </asp:GridView>
    </div>
</asp:Content>

<%@ Page Title="" Language="C#" MasterPageFile="~/Bit_Notes/note.Master" AutoEventWireup="true" CodeBehind="data_structure_and_algorithm.aspx.cs" Inherits="Learning_System.Bit_Notes.data_structure_and_algorithm" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container mt-5">
        <!-- Button for adding new files or another action -->
        <asp:Button ID="btnAddFile" runat="server" Text="Add New File" OnClick="AddNewFile" CssClass="btn btn-primary mb-3" />

        <!-- GridView for displaying files -->
        <asp:GridView ID="GridView1" runat="server" class="table table-bordered table-condensed table-hover" AutoGenerateColumns="False">
            <Columns>
                <asp:BoundField DataField="Name" HeaderText="File Name"/>
                <asp:BoundField DataField="Topic" HeaderText="Topic" />
                <asp:TemplateField ItemStyle-HorizontalAlign="Center" HeaderText="Download and View">
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

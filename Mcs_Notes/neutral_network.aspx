<%@ Page Title="" Language="C#" MasterPageFile="~/Mcs_Notes/note.Master" AutoEventWireup="true" CodeBehind="neutral_network.aspx.cs" Inherits="Learning_System.Mcs_Notes.neutral_network" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container mt-5">
        <!-- Back to Notes button -->
        <div class="mb-3">
            <asp:Button ID="BackToNotesButton" runat="server" Text="Back to dash" CssClass="btn btn-primary" OnClick="BackToNotesButton_Click" />
        </div>

        <!-- Add table-responsive class to ensure responsiveness -->
        <div class="table-responsive">
            <asp:GridView ID="GridView1" runat="server" CssClass="table table-bordered table-hover" AutoGenerateColumns="False">
                <Columns>
                    <asp:BoundField DataField="Name" HeaderText="File Name" />
                    <asp:BoundField DataField="Topic" HeaderText="Topic" />
                    <asp:TemplateField ItemStyle-HorizontalAlign="Center" HeaderText="Download and View">
                        <ItemTemplate>
                            <asp:LinkButton ID="DownloadFile" runat="server" Text="Download" OnClick="DownloadFile" CssClass="btn btn-success"
                                CommandArgument='<%# Eval("Id") %>'></asp:LinkButton>
                        </ItemTemplate>
                        <ItemStyle HorizontalAlign="Center"></ItemStyle>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
        </div>
    </div>
</asp:Content>

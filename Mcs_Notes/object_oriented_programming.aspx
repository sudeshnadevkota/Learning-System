<%--<%@ Page Title="" Language="C#" MasterPageFile="~/Mcs_Notes/note.Master" AutoEventWireup="true" CodeBehind="object_oriented_programming.aspx.cs" Inherits="Learning_System.Mcs_Notes.object_oriented_programming" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
      
    <div class="container mt-5">
        <div class="table-responsive">
            <asp:GridView ID="GridView1" runat="server" class="table table-bordered table-condensed table-hover" AutoGenerateColumns="False">
                <Columns>
                    <asp:BoundField DataField="Name" HeaderText="File Name" ItemStyle-Width="50%" />
                    <asp:BoundField DataField="Topic" HeaderText="Topic" ItemStyle-Width="30%" />
                    <asp:TemplateField ItemStyle-HorizontalAlign="Center" HeaderText="Download and View" ItemStyle-Width="20%">
                        <ItemTemplate>
                            <asp:LinkButton ID="DownloadFile" runat="server" Text="Download" OnClick="DownloadFile" class="btn btn-success"
                                CommandArgument='<%# Eval("Id") %>'></asp:LinkButton>
                        </ItemTemplate>
                        <ItemStyle HorizontalAlign="Center"></ItemStyle>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
        </div>
    </div>



</asp:Content>--%>


<%@ Page Title="" Language="C#" MasterPageFile="~/Mcs_Notes/note.Master" AutoEventWireup="true" CodeBehind="object_oriented_programming.aspx.cs" Inherits="Learning_System.Mcs_Notes.object_oriented_programming" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container mt-5">
        <!-- Back to Notes button -->
        <div class="mb-3">
            <asp:Button ID="BackToNotesButton" runat="server" Text="Back to dash" CssClass="btn btn-primary" OnClick="BackToNotesButton_Click" />
        </div>
        
        <div class="table-responsive">
            <asp:GridView ID="GridView1" runat="server" class="table table-bordered table-condensed table-hover" AutoGenerateColumns="False">
                <Columns>
                    <asp:BoundField DataField="Name" HeaderText="File Name" ItemStyle-Width="50%" />
                    <asp:BoundField DataField="Topic" HeaderText="Topic" ItemStyle-Width="30%" />
                    <asp:TemplateField ItemStyle-HorizontalAlign="Center" HeaderText="Download and View" ItemStyle-Width="20%">
                        <ItemTemplate>
                            <asp:LinkButton ID="DownloadFile" runat="server" Text="Download" OnClick="DownloadFile" class="btn btn-success"
                                CommandArgument='<%# Eval("Id") %>'></asp:LinkButton>
                        </ItemTemplate>
                        <ItemStyle HorizontalAlign="Center"></ItemStyle>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
        </div>
    </div>
</asp:Content>


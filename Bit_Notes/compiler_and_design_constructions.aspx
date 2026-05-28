<%@ Page Title="" Language="C#" MasterPageFile="~/Bit_Notes/note.Master" AutoEventWireup="true" CodeBehind="compiler_and_design_constructions.aspx.cs" Inherits="Learning_System.Bit_Notes.compiler_and_design_constructions" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container mt-5">
    <!-- Back to Dashboard Button -->
    <div class="mb-3">
        <asp:Button ID="btnBackToDash" runat="server" Text="Back to Dashboard" CssClass="btn btn-primary" OnClick="btnBackToDash_Click" />
    </div><div class="container mt-5">
    

      <asp:GridView ID="GridView1"  runat="server" class="table table-bordered table-condensed table-hover"  AutoGenerateColumns="False">
    <Columns>
        <asp:BoundField DataField="Name" HeaderText="File Name"/>
        <asp:BoundField DataField="Topic" HeaderText="Topic" />
        <asp:TemplateField ItemStyle-HorizontalAlign = "Center" HeaderText="Download and View">
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

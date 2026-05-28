<%@ Page Title="" Language="C#" MasterPageFile="~/students/student.Master" AutoEventWireup="true" CodeBehind="default_student.aspx.cs" Inherits="Learning_System.students.default_student" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="container-fluid" style="padding-top:30px; ">
        <div class="container">
            <asp:GridView ID="GridView1" runat="server" CssClass="table table-bordered" AutoGenerateColumns="False">
                <Columns>
                    <asp:BoundField DataField="Subject_Name" HeaderText="Subject Name" SortExpression="Subject_Name" />
                    <asp:TemplateField>
                        <ItemTemplate>
                            <a href='module_details.aspx?subject=<%# Eval("Subject_Name") %>' class="btn btn-sm btn-info">Go to module</a>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
        </div>
    </div>
</asp:Content>

<%@ Page Title="" Language="C#" MasterPageFile="~/learning.Master" AutoEventWireup="true" CodeBehind="register.aspx.cs" Inherits="Learning_System.register" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="container" style="margin-top: 20px; margin-bottom:20px;">
        <div class="row">
            <div class="col-md-8 mx-auto">
                <div class="card">
                    <div class="card-body">
                        <div class="row">
                            <div class="col">
                                <center>
                                    <h4>Sign Up</h4>
                                </center>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col">
                                <hr>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-6">
                                <label>Full Name</label>
                                <div class="form-group">
                                    <asp:TextBox CssClass="form-control" ID="Full_name" runat="server" placeholder="Full Name"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="Enter full name*" ControlToValidate="Full_name" ForeColor="Red"></asp:RequiredFieldValidator>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <label>Date of Birth</label>
                                <div class="form-group">
                                    <asp:TextBox CssClass="form-control" ID="Dob" runat="server" placeholder="Date of Birth" TextMode="Date"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="Select your date of birth*" ControlToValidate="Dob" ForeColor="Red"></asp:RequiredFieldValidator>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-6">
                                <label>Contact No</label>
                                <div class="form-group">
                                    <asp:TextBox CssClass="form-control" ID="Contact" runat="server" placeholder="Contact No" TextMode="Number"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ErrorMessage="Enter your contact*" ControlToValidate="Contact" ForeColor="Red"></asp:RequiredFieldValidator>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <label>Email ID</label>
                                <div class="form-group">
                                    <asp:TextBox CssClass="form-control" ID="Email" runat="server" placeholder="Email ID" TextMode="Email"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ErrorMessage="Enter your email*" ControlToValidate="Email" ForeColor="Red"></asp:RequiredFieldValidator>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-6">
                                <label>Username</label>
                                <div class="form-group">
                                    <asp:TextBox CssClass="form-control" ID="username" runat="server" placeholder="Username"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ErrorMessage="Enter your username*" ControlToValidate="username" ForeColor="Red"></asp:RequiredFieldValidator>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <label>Password</label>
                                <div class="form-group">
                                    <asp:TextBox CssClass="form-control" ID="Password" runat="server" placeholder="Password" TextMode="Password"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ErrorMessage="Enter your password*" ControlToValidate="Password" ForeColor="Red"></asp:RequiredFieldValidator>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-6">
                                <label>User Type</label>
                                <div class="form-group">
                                    <asp:DropDownList CssClass="form-control" ID="Status" runat="server" required="true" onchange="toggleFaculty()">
                                        <asp:ListItem Text="Select" Value=""></asp:ListItem>
                                        <asp:ListItem Text="Students" Value="students"></asp:ListItem>
                                        <asp:ListItem Text="Staff" Value="Staff"></asp:ListItem>
                                    </asp:DropDownList>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" ErrorMessage="Enter your username*" ControlToValidate="Status" ForeColor="Red"></asp:RequiredFieldValidator>
                                </div>
                            </div>
                            <div class="col-md-6" id="facultyDiv" style="display: none;">
                                <label for="faculty">Faculty</label>
                                <div class="form-group">
                                    <asp:DropDownList CssClass="form-control" ID="Faculty" runat="server">
                                        <asp:ListItem Text="Select" Value=""></asp:ListItem>
                                        <asp:ListItem Text="BBA" Value="BBA"></asp:ListItem>
                                        <asp:ListItem Text="BCS" Value="BCS"></asp:ListItem>
                                        <asp:ListItem Text="BHM" Value="BHM"></asp:ListItem>
                                        <asp:ListItem Text="BIT" Value="BIT"></asp:ListItem>
                                        <asp:ListItem Text="MBA" Value="MBA"></asp:ListItem>
                                        <asp:ListItem Text="MCS" Value="MCS"></asp:ListItem>
                                    </asp:DropDownList>
                                   
                                </div>
                            </div>
                        </div>

                        <div class="row " style="display:flex; justify-content:center;">
                            <div class="col-md-6">
                                <div class="form-group">
                                    <asp:Button CssClass="btn btn-primary w-100 " ID="Button1" runat="server" OnClick="Button1_Click" Text="Submit" Style="margin-top: 2rem;" />
                                </div>
                            </div>
                        </div>

                        <!-- Link for login -->
                        <div class="text-center mt-3">
                            <asp:HyperLink ID="HyperLinkLogin" runat="server" CssClass="text-primary text-decoration-none" NavigateUrl="~/Login.aspx">Already have an Account? Login</asp:HyperLink>
                        </div>

                    </div>
                </div>
            </div>
        </div>
    </div>

    <script>
        function toggleFaculty() {
            var status = document.getElementById('<%= Status.ClientID %>').value;
        var facultyDiv = document.getElementById("facultyDiv");
        var facultyDropdown = document.getElementById('<%= Faculty.ClientID %>');

            if (status === "students") {
                facultyDiv.style.display = "block";
                facultyDropdown.setAttribute("required", "true");
            } else {
                facultyDiv.style.display = "none";
                facultyDropdown.removeAttribute("required", "false");
            }
        }
</script>

</asp:Content>

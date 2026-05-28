<%@ Page Title="" Language="C#" MasterPageFile="~/learning.Master" AutoEventWireup="true" CodeBehind="login.aspx.cs" Inherits="Learning_System.login" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container-fluid" style="width: 100%; min-height: 80vh; display: flex; justify-content: center; align-items: center;">
        <div class="container">
            <div class="row" style="align-items: center; display: flex; justify-content: center;">
                <div class="col-md-4">
                    <div style="box-shadow: 0 4px 10px rgba(0, 0, 0, 0.2); padding: 40px 30px 20px 30px; border-radius: 10px;">
                        <div style="text-align: center;">
                            <h4 style="color: #2D3748;">Texas Learning Portal
                            </h4>
                        </div>
                        <asp:Label ID="Label2" runat="server" Text="Username" Style="font-size: 13px;"></asp:Label><br />
                        <div style="position: relative; width: 100%;">
                            <asp:TextBox ID="Username" runat="server" required="true" Style="width: 100%; background-color: #3D3BDD0A; border: 1px solid #EAEAEA; outline: none; border-radius: 8px; font-size: 12px; padding: 6px 8px;" placeholder="Enter number or email"></asp:TextBox><br />
                            <span style="position: absolute; top: 50%; right: 10px; transform: translateY(-50%);"><i class="bi bi-person-fill"></i></span>
                        </div>
                        <asp:Label ID="Label3" runat="server" Text="Password" Style="font-size: 13px;"></asp:Label><br />
                        <div style="position: relative; width: 100%;">
                            <asp:TextBox ID="Password" runat="server" TextMode="Password" required="true" Style="width: 100%; background-color: #3D3BDD0A; border: 1px solid #EAEAEA; outline: none; border-radius: 8px; font-size: 12px; padding: 6px 8px;" placeholder="Enter Password"> </asp:TextBox>
                            <span id="togglePassword" style="position: absolute; top: 50%; right: 10px; transform: translateY(-50%); cursor: pointer;"><i class="bi bi-eye-slash-fill"></i></span>
                            <asp:Label ID="Label1" runat="server" Style="color: red;"></asp:Label>
                        </div>

                        <div style="width: 100%; padding: 15px 0px; text-align: right;">
                            <a href="#" style="text-decoration: none;">Forgot Password</a>
                        </div>
                        <div style="text-align: center;">
                            <asp:Button ID="Button1" runat="server" Text="Login" OnClick="Button1_Click" Style="width: 80%; border-radius: 25px; font-size: 20px; border: none; background-color: #2D3748; color: #ffffff; padding: 4px 0px;" />
                        </div>

                        <br />
                        <p style="text-align: center">Don't have an account? <span><a href="register.aspx" style="text-decoration: none;">Sigup</a></span></p>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <script>
        document.getElementById("togglePassword").addEventListener("click", function () {
            var passwordField = document.getElementById("<%= Password.ClientID %>");
            var toggleIcon = this.querySelector("i");

            if (passwordField.type === "password") {
                passwordField.type = "text";
                toggleIcon.classList.remove("bi-eye-slash-fill");
                toggleIcon.classList.add("bi-eye-fill");
            } else {
                passwordField.type = "password";
                toggleIcon.classList.remove("bi-eye-fill");
                toggleIcon.classList.add("bi-eye-slash-fill");
            }
        });
</script>
</asp:Content>

<%@ Page Title="" Language="C#" MasterPageFile="~/learning.Master" AutoEventWireup="true" CodeBehind="login.aspx.cs" Inherits="Learning_System.login" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">


    <div style="
        width: 100%;
        min-height: calc(100vh - 120px);
        display: flex;
        justify-content: flex-end;
        align-items: center;
        padding-right: 80px;
        box-sizing: border-box;
    ">

        <div style="
            width: 350px;
            background: white;
            box-shadow: 0 4px 10px rgba(0,0,0,0.2);
            padding: 40px 30px 20px 30px;
            border-radius: 10px;
        ">

            <h4 style="text-align:center; color:#2D3748;">
                Texas Learning Portal
            </h4>

            <br />

            <asp:Label ID="Label2" runat="server" Text="Username" Style="font-size:13px;"></asp:Label>

            <div style="position:relative;">
                <asp:TextBox ID="Username" runat="server"
                    style="width:100%; background:#3D3BDD0A; border:1px solid #EAEAEA;
                           border-radius:8px; font-size:12px; padding:6px 8px;"
                    placeholder="Enter number or email" />

                <span style="position:absolute; right:10px; top:50%; transform:translateY(-50%);">
                    <i class="bi bi-person-fill"></i>
                </span>
            </div>

            <br />

            <asp:Label ID="Label3" runat="server" Text="Password" Style="font-size:13px;"></asp:Label>

            <div style="position:relative;">
                <asp:TextBox ID="Password" runat="server" TextMode="Password"
                    style="width:100%; background:#3D3BDD0A; border:1px solid #EAEAEA;
                           border-radius:8px; font-size:12px; padding:6px 8px;"
                    placeholder="Enter Password" />

                <span id="togglePassword"
                    style="position:absolute; right:10px; top:50%; transform:translateY(-50%); cursor:pointer;">
                    <i class="bi bi-eye-slash-fill"></i>
                </span>
            </div>

            <asp:Label ID="Label1" runat="server" Style="color:red;"></asp:Label>

            <div style="text-align:right; padding:10px 0;">
                <a href="#">Forgot Password</a>
            </div>

            <div style="text-align:center;">
                <asp:Button ID="Button1" runat="server" Text="Login"
                    OnClick="Button1_Click"
                    style="width:80%; border-radius:25px; font-size:20px;
                           background:#2D3748; color:white; border:none; padding:5px 0;" />
            </div>

            <p style="text-align:center; margin-top:10px;">
                Don't have an account?
                <a href="register.aspx">Signup</a>
            </p>

        </div>
    </div>

    <script>
document.getElementById("togglePassword").addEventListener("click", function () {
  var passwordField = document.getElementById("<%= Password.ClientID %>");
            var icon = this.querySelector("i");

            if (passwordField.type === "password") {
                passwordField.type = "text";
                icon.classList.remove("bi-eye-slash-fill");
                icon.classList.add("bi-eye-fill");
            } else {
                passwordField.type = "password";
                icon.classList.remove("bi-eye-fill");
                icon.classList.add("bi-eye-slash-fill");
            }
        });
    </script>

</asp:Content>

<%@ Page Title="" Language="C#" MasterPageFile="~/students/student.Master" AutoEventWireup="true" CodeBehind="abcd.aspx.cs" Inherits="Learning_System.students.abcd" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <style>
        .col-md-4 {
            background: #ffffff;
            margin: 50px auto;
            padding: 40px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            border-radius: 30px;
        }

        h1 {
            color: #444;
            font-size: 2em;
            text-align: center;
        }

        .container .input-box {
            width: 100%;
            height: 70px;
            margin: 30px 0;
        }

        .input-box input {
            width: 100%;
            height: 30px;
            padding: 10px 35px 10px 10px;
            margin-bottom: 10px;
            border: 1px solid #ddd;
            border-radius: 6px;
            background-color: #f3fcfc
        }

        .input-box i {
            position: absolute;
            right: 20px;
            top: 60%;
            transform: translate(-50%);
            font-size: 20px;
            color: #888;
        }
    </style>
    <div class="container-fluid">
        <div class="container">
            <div class="row" style="display: flex; justify-content: center;">
                <div class="col-md-4">
                    <h1>Login</h1>
                    <div class="input-box">
                        <label>Username</label><br />
                        <br />
                        <input type="text" placeholder="Username" required />
                        <i class='bx bxs-user'></i>
                        <br />
                    </div>
                    <div class="input-box">
                        <label>Password</label><br />
                        <br />
                        <input type="text" placeholder="Password" required />
                        <i class='bx bxs-lock-alt'></i>
                        <br />
                    </div>
                    <div style="text-align: right;">
                        <a href="default.aspx">Forgot password?</a><br />
                        <br />
                        <div class="button" style="text-align: center;">
                            <button type="submit" class="btn btn-sm btn-success" style="width: 80%; border-radius: 25px;">Login</button>
                        </div>
                        <div class="Register"></div>
                        <p>Don't have an account? <a href="default.aspx">Register now</a> </p>
                    </div>
                </div>
            </div>
        </div>
    </div>




</asp:Content>


﻿<%@ Page Title="Feedback" Language="C#" MasterPageFile="~/learning.Master" AutoEventWireup="true" CodeBehind="Feedback.aspx.cs" Inherits="Learning_System.Feedback" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container mt-5">
        <h1 class="text-center text-primary">We Value Your Feedback</h1>
        <p class="text-center text-dark mb-5">
            Your opinion matters to us! Please take a moment to share your thoughts and experiences with our services. 
            Your feedback helps us improve and better serve you. Whether it's a suggestion, compliment, or concern, 
            we’re eager to hear from you.
        </p>

        <div class="row justify-content-center">
            <div class="col-md-8">
                <asp:Panel ID="contactFormPanel" runat="server" CssClass="card p-4">
                    <div class="form-group my-3">
                        <asp:TextBox ID="name" runat="server" CssClass="form-control" Placeholder="Your name" />
                    </div>
                    <div class="form-group my-3">
                        <asp:TextBox ID="email" runat="server" CssClass="form-control" Placeholder="Your email" TextMode="Email" />
                    </div>
                    <div class="form-group my-3">
                        <asp:TextBox ID="PhoneNumber" runat="server" CssClass="form-control" Placeholder="Your phone number" T />
                    </div>
                    <div class="form-group my-3">
                        <asp:TextBox ID="message" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="5" Placeholder="Your feedback" />
                    </div>
                    <div class="form-group my-3 text-center">
                        <asp:Button ID="submitButton" runat="server" CssClass="btn btn-primary btn-lg btn-block" Text="Submit" OnClick="SubmitButton_Click" />
                    </div>
                </asp:Panel>
            </div>
        </div>
    </div>

    <!-- Bootstrap JS -->
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.bundle.min.js"></script>
</asp:Content>


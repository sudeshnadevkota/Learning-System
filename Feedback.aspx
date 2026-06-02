<%@ Page Title="Feedback" Language="C#" MasterPageFile="~/learning.Master" AutoEventWireup="true" CodeBehind="Feedback.aspx.cs" Inherits="Learning_System.Feedback" %>


<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">


```
<style>
    /* ================= HERO SECTION ================= */

    .feedback-hero {
        background: linear-gradient(135deg,#0B1F66,#081547);
        color: white;
        text-align: center;
        padding: 90px 20px;
        border-radius: 0 0 40px 40px;
        position: relative;
        overflow: hidden;
        margin-bottom: 60px;
    }

    .feedback-hero::before {
        content: "";
        position: absolute;
        width: 300px;
        height: 300px;
        background: rgba(255,255,255,0.08);
        border-radius: 50%;
        top: -120px;
        right: -80px;
    }

    .feedback-hero::after {
        content: "";
        position: absolute;
        width: 250px;
        height: 250px;
        background: rgba(255,255,255,0.05);
        border-radius: 50%;
        bottom: -100px;
        left: -80px;
    }

    .hero-icon {
        font-size: 60px;
        margin-bottom: 20px;
    }

    .feedback-hero h1 {
        font-size: 3.2rem;
        font-weight: 800;
        margin-bottom: 15px;
    }

    .feedback-hero p {
        font-size: 18px;
        max-width: 700px;
        margin: auto;
        line-height: 1.8;
        opacity: 0.95;
    }

    /* ================= MAIN SECTION ================= */

    .feedback-container {
        margin-bottom: 70px;
    }

    /* LEFT CARD */

    .info-card {
        background: linear-gradient(135deg,#0B1F66,#081547);
        color: white;
        border-radius: 25px;
        padding: 35px;
        height: 100%;
        box-shadow: 0 15px 35px rgba(11,31,102,.20);
    }

    .info-card h3 {
        font-weight: 700;
        margin-bottom: 30px;
    }

    .info-item {
        display: flex;
        align-items: center;
        margin-bottom: 25px;
        font-size: 17px;
    }

    .info-item i {
        margin-right: 12px;
        font-size: 18px;
    }

    /* RIGHT CARD */

    .feedback-card {
        background: white;
        border-radius: 25px;
        padding: 35px;
        box-shadow: 0 15px 35px rgba(0,0,0,.08);
    }

    .feedback-card h3 {
        color: #0B1F66;
        font-weight: 700;
        margin-bottom: 25px;
    }

    /* FORM */

    .form-control {
        border-radius: 15px;
        border: 1px solid #d6e4ff;
        padding: 14px 16px;
        font-size: 15px;
        transition: .3s ease;
    }

    .form-control:focus {
        border-color: #0B1F66;
        box-shadow: 0 0 15px rgba(11,31,102,.15);
    }

    /* BUTTON */

    .btn-feedback {
        background: linear-gradient(135deg,#0B1F66,#081547);
        border: none;
        color: white;
        width: 100%;
        border-radius: 15px;
        padding: 14px;
        font-size: 17px;
        font-weight: 700;
        transition: .3s ease;
    }

    .btn-feedback:hover {
        color: white;
        transform: translateY(-2px);
        box-shadow: 0 10px 25px rgba(11,31,102,.25);
    }

    /* RESPONSIVE */

    @media(max-width:768px) {

        .feedback-hero h1 {
            font-size: 2.3rem;
        }

        .info-card {
            margin-bottom: 25px;
        }

        .feedback-card,
        .info-card {
            padding: 25px;
        }
    }
</style>

<!-- ================= HERO SECTION ================= -->

<div class="feedback-hero">

    <div class="hero-icon">
        <i class="fas fa-comments"></i>
    </div>

    <h1>We Value Your Feedback</h1>

    <p>
        Help us improve your experience by sharing your thoughts,
        suggestions, and ideas with us.
    </p>

</div>

<!-- ================= MAIN CONTENT ================= -->

<div class="container feedback-container">

    <div class="row">

        <!-- LEFT SIDE -->

        <div class="col-lg-4 mb-4">

            <div class="info-card">

                <h3>Why Feedback Matters</h3>

                <div class="info-item">
                    <i class="fas fa-check-circle"></i>
                    Improve Courses
                </div>

                <div class="info-item">
                    <i class="fas fa-check-circle"></i>
                    Better Student Support
                </div>

                <div class="info-item">
                    <i class="fas fa-check-circle"></i>
                    Enhance Student Experience
                </div>

                <div class="info-item">
                    <i class="fas fa-check-circle"></i>
                    Help Us Grow & Improve
                </div>

            </div>

        </div>

        <!-- RIGHT SIDE -->

        <div class="col-lg-8">

            <asp:Panel ID="contactFormPanel" runat="server" CssClass="feedback-card">

                <h3>Feedback Form</h3>

                <div class="form-group mb-3">

                    <asp:TextBox
                        ID="name"
                        runat="server"
                        CssClass="form-control"
                        Placeholder="Your Name">
                    </asp:TextBox>

                </div>

                <div class="form-group mb-3">

                    <asp:TextBox
                        ID="email"
                        runat="server"
                        CssClass="form-control"
                        Placeholder="Your Email"
                        TextMode="Email">
                    </asp:TextBox>

                </div>

                <div class="form-group mb-3">

                    <asp:TextBox
                        ID="PhoneNumber"
                        runat="server"
                        CssClass="form-control"
                        Placeholder="Your Phone Number">
                    </asp:TextBox>

                </div>

                <div class="form-group mb-4">

                    <asp:TextBox
                        ID="message"
                        runat="server"
                        CssClass="form-control"
                        TextMode="MultiLine"
                        Rows="6"
                        Placeholder="Write your feedback here...">
                    </asp:TextBox>

                </div>

                <asp:Button
                    ID="submitButton"
                    runat="server"
                    Text="Submit Feedback"
                    CssClass="btn-feedback"
                    OnClick="SubmitButton_Click" />

            </asp:Panel>

        </div>

    </div>

</div>

<!-- Font Awesome -->

<script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/js/all.min.js"></script>
```

</asp:Content>


<%@ Page Title="Contact Us" Language="C#" MasterPageFile="~/learning.Master" AutoEventWireup="true" CodeBehind="Contact.aspx.cs" Inherits="Learning_System.Contact" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    

    <style>
        body {
            background: white;
            min-height: 100vh;
        }

        .contact-section {
            padding: 70px 0;
        }

        .contact-title {
            font-size: 3rem;
            font-weight: 800;
            color: linear-gradient(135deg,#0B1F66,#081547);
        }

        .contact-subtitle {
            max-width: 750px;
            margin: auto;
            color: dimgray;
            font-size: 17px;
            line-height: 1.8;
        } 

        .contact-card {
            background: #e8e7e6;
            backdrop-filter: blur(12px);
            -webkit-backdrop-filter: blur(12px);

            border-radius: 25px;
            padding: 35px;

            border: 1px solid rgba(255,255,255,0.3);

            box-shadow: 0 8px 30px rgba(0,0,0,0.08);

            transition: all 0.4s ease;
            height: 100%;
        }

        .contact-card:hover {
            transform: translateY(-8px);
            box-shadow: 0 15px 35px rgba(13,110,253,0.18);
        }

        .contact-info-box {
            display: flex;
            align-items: flex-start;
            margin-bottom: 28px;
        }

        .contact-icon {
            width: 58px;
            height: 58px;

            background:linear-gradient(135deg,#0B1F66,#081547);

            border-radius: 18px;

            display: flex;
            align-items: center;
            justify-content: center;

            color: white;
            font-size: 22px;

            margin-right: 18px;

            box-shadow: 0 8px 20px rgba(13,110,253,0.25);
        }

        .contact-label {
            font-size: 18px;
            font-weight: 700;
            color: #0d6efd;
            margin-bottom: 4px;
        }

        

        .form-control {
            border-radius: 15px;
            border: 1px solid #d6e4ff;

            padding: 14px 16px;
            font-size: 15px;

            background: rgba(255,255,255,0.85);

            transition: 0.3s ease;
        }

        .form-control:focus {
            border-color: #0d6efd;
            box-shadow: 0 0 15px rgba(13,110,253,0.18);
            background: white;
        }

        .btn-contact {
            background: linear-gradient(135deg,#0B1F66,#081547);
            border: none;

            border-radius: 15px;

            padding: 14px;

            font-size: 17px;
            font-weight: 700;

            color: white;

            transition: all 0.3s ease;
        }

        .btn-contact:hover {
            transform: scale(1.02);
            box-shadow: 0 10px 25px rgba(13,110,253,0.25);
            
        }

        .map-container iframe {
            border-radius: 20px;
        }

        @media(max-width:768px) {

            .contact-title {
                font-size: 2.2rem;
            }

            .contact-card {
                padding: 25px;
            }
        }
    </style>

    <div class="container contact-section">

        <!-- Heading -->
        <div class="text-center mb-5">

            <h1 class="contact-title">
                Contact Us
            </h1>

            <p class="contact-subtitle mt-3">
                We'd love to hear from you! Whether you have questions about admissions,
                courses, or anything else, our team is always ready to help.
            </p>

        </div>

        <div class="row g-4">

            <!-- Left Side -->
            <div class="col-lg-5">

                <div class="contact-card">

                    <h2 class="fw-bold text-primary mb-4">
                        Get In Touch
                    </h2>

                    <!-- Address -->
                    <div class="contact-info-box">

                        <div class="contact-icon">
                            <i class="fas fa-map-marker-alt"></i>
                        </div>

                        <div>
                            <div class="contact-label">
                                Address
                            </div>

                            <span class="text-muted">
                                Sifal, Chabahil <br />
                                Kathmandu, Nepal
                            </span>
                        </div>

                    </div>

                    <!-- Email -->
                    <div class="contact-info-box">

                        <div class="contact-icon">
                            <i class="fas fa-envelope"></i>
                        </div>

                        <div>
                            <div class="contact-label">
                                Email
                            </div>

                            <span class="text-muted">
                                inquiry@texascollege.edu.np
                            </span>
                        </div>

                    </div>

                    <!-- Phone -->
                    <div class="contact-info-box">

                        <div class="contact-icon">
                            <i class="fas fa-phone-alt"></i>
                        </div>

                        <div>
                            <div class="contact-label">
                                Phone
                            </div>

                            <span class="text-muted">
                                01-4589134 <br />
                                01-4588627 <br />
                                9801644462
                            </span>
                        </div>

                    </div>

                    <!-- Google Map -->
                    <div class="map-container mt-4">

                        <iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3532.120631698675!2d85.33990897536928!3d27.713561476179!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x39eb19711fc67af3%3A0x4ec22ef7b705ac5!2sTexas%20College%20of%20Management%20%26%20IT!5e0!3m2!1sen!2snp!4v1721095801648!5m2!1sen!2snp"
                            width="100%"
                            height="260"
                            style="border:0;"
                            allowfullscreen=""
                            loading="lazy">
                        </iframe>

                    </div>

                </div>

            </div>

            <!-- Right Side -->
            <div class="col-lg-7">

                <div class="contact-card">

                    <h2 class="fw-bold text-primary mb-4">
                        Send Message
                    </h2>

                    <asp:Panel ID="contactFormPanel" runat="server">

                        <div class="row">

                            <div class="col-md-6 mb-3">

                                <asp:TextBox
                                    ID="name"
                                    runat="server"
                                    CssClass="form-control"
                                    Placeholder="Your Name">
                                </asp:TextBox>

                            </div>

                            <div class="col-md-6 mb-3">

                                <asp:TextBox
                                    ID="email"
                                    runat="server"
                                    CssClass="form-control"
                                    Placeholder="Your Email"
                                    TextMode="Email">
                                </asp:TextBox>

                            </div>

                        </div>

                        <div class="mb-3">

                            <asp:TextBox
                                ID="subject"
                                runat="server"
                                CssClass="form-control"
                                Placeholder="Subject">
                            </asp:TextBox>

                        </div>

                        <div class="mb-4">

                            <asp:TextBox
                                ID="message"
                                runat="server"
                                CssClass="form-control"
                                TextMode="MultiLine"
                                Rows="8"
                                Placeholder="Write your message here...">
                            </asp:TextBox>

                        </div>

                        <div class="d-grid">

                            <asp:Button
                                ID="submitButton"
                                runat="server"
                                Text="Send Message"
                                CssClass="btn-contact"
                                OnClick="SubmitButton_Click" />

                        </div>

                    </asp:Panel>

                </div>

            </div>

        </div>

    </div>

    <!-- Font Awesome -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/js/all.min.js"></script>

</asp:Content>

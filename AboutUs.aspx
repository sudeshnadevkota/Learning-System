<%@ Page Title="" Language="C#" MasterPageFile="~/learning.Master" AutoEventWireup="true" CodeBehind="AboutUs.aspx.cs" Inherits="Learning_System.WebForm1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    
    <!-- About Us Section -->
    <div class="container py-5">
        <div class="row align-items-center">

            <div class="col-lg-7 mb-4 mb-lg-0">
                <div class="about-card">

                    <h2 class="about-title">About Us</h2>

                    <p class="about-text">
                        The Texas College of Management Learning Portal is a centralized
                        digital platform designed to support students and faculty in their
                        academic journey. Through this portal, users can access courses,
                        learning materials, assignments, announcements, and academic
                        resources anytime and anywhere.
                    </p>

                    <div class="info-box">
                        <h4>Our Mission</h4>
                        <p>
                            To enhance teaching and learning through innovative,
                            accessible, and technology-driven educational solutions.
                        </p>
                    </div>

                    <div class="info-box">
                        <h4>Our Vision</h4>
                        <p>
                            To create a modern digital learning environment that empowers
                            students to achieve academic excellence and lifelong success.
                        </p>
                    </div>

                </div>
            </div>

            <div class="col-lg-5 text-center">
                <img src="slide/Tcmit.png"
                    alt="Texas College of Management"
                    class="img-fluid about-image" />
            </div>

        </div>
    </div>

    <!-- Developer Section -->
   <div class="container py-5">

    <h2 class="text-center section-title">Development Team</h2>

    <p class="text-center section-subtitle">
        This Learning Portal was developed to provide a modern and efficient
        digital learning experience for students and faculty.
    </p>

    <div class="row justify-content-center g-4">

        <!-- Developer 1 -->
        <div class="col-md-6 col-lg-4 d-flex">
            <div class="developer-card text-center">

                <img src="slide/Durganand.png"
                     alt="Developer"
                     class="developer-img" />

                <h4 class="mt-3">Durganand Panjiyar</h4>

                <p class="developer-role">Lead Developer</p>

                <p class="developer-description">
                    Designed and developed the Learning Portal using ASP.NET,
                    SQL Server, Bootstrap, and modern web technologies to
                    support digital education and academic management.
                </p>

                <div class="social-links">
                    <a href="https://www.linkedin.com/in/durganand-panjiyar-b06b19308/"
                       target="_blank">
                        <i class="fab fa-linkedin-in"></i>
                    </a>
                </div>

            </div>
        </div>

        <!-- Developer 2 -->
        <div class="col-md-6 col-lg-4 d-flex">
            <div class="developer-card text-center">

                <img src="slide/devgroup.png"
                     alt="Developer"
                     class="developer-img" />

                <h4 class="mt-3">Texas Imaginology Team</h4>

                <p class="developer-role">Developer</p>

                <p class="developer-description">
                    The success of this Learning Portal is the result of teamwork, innovation, and dedication.
                  Developed using .NET and modern web technologies, the platform showcases the collective expertise
                  of our team in delivering a secure, efficient, and user-friendly educational solution.
                </p>

                

            </div>
        </div>

    </div>

</div>

    <style>

        body {
            background: #f8fafc;
        }

        /* About Section */

        .about-card {
            background: #ffffff;
            padding: 35px;
            border-radius: 20px;
            box-shadow: 0 10px 25px rgba(0,0,0,0.08);
        }

        .about-title {
            color: linear-gradient(135deg,#0B1F66,#081547);
            font-size: 2.2rem;
            font-weight: 700;
            margin-bottom: 20px;
        }

        .about-text {
            color: #555;
            line-height: 1.8;
            margin-bottom: 25px;
        }

        .info-box {
            background: #f8f9fa;
            padding: 18px;
            border-left: 5px solid #0d6efd;
            border-radius: 12px;
            margin-bottom: 15px;
            transition: 0.3s;
        }

        .info-box:hover {
            transform: translateY(-3px);
            box-shadow: 0 5px 15px rgba(0,0,0,0.08);
        }

        .info-box h4 {
            margin-bottom: 8px;
            font-size: 1.2rem;
            font-weight: 600;
        }

        .info-box p {
            margin: 0;
            color: #666;
        }

        .about-image {
            border-radius: 20px;
            max-height: 450px;
            object-fit: cover;
            box-shadow: 0 10px 30px rgba(0,0,0,0.15);
        }

        /* Developer Section */

        .section-title {
            font-size: 2rem;
            font-weight: 700;
            color: #212529;
            margin-bottom: 10px;
        }

        .section-subtitle {
            color: #6c757d;
            margin-bottom: 40px;
        }

        .developer-card {
            background: #ffffff;
            padding: 30px;
            border-radius: 20px;
            box-shadow: 0 10px 25px rgba(0,0,0,0.08);
            transition: 0.3s ease;

            height: 100%;
            display: flex;
            flex-direction: column;
        }

        .developer-card:hover {
            transform: translateY(-5px);
        }

      .developer-img {
    width: 180px;
    height: auto;
    max-height: 220px;
    border-radius: 20px;
    border: 5px solid #f1f1f1;

    display: block;
    margin: 0 auto;
}

        .developer-role {
            color: linear-gradient(135deg,#0B1F66,#081547);
            font-weight: 600;
            margin-bottom: 15px;
        }

        .developer-description {
            color: #555;
            line-height: 1.7;
            min-height: 140px;
        }

        .social-links a {
            color: #0d6efd;
            font-size: 24px;
            transition: 0.3s;
        }

        .social-links a:hover {
            color: #084298;
        }

        @media(max-width:768px) {

            .about-card {
                padding: 25px;
            }

            .about-title {
                font-size: 1.8rem;
            }

            .developer-img {
                width: 150px;
                height: 150px;
            }
        }

    </style>

</asp:Content>

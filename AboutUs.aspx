<%@ Page Title="" Language="C#" MasterPageFile="~/learning.Master" AutoEventWireup="true" CodeBehind="AboutUs.aspx.cs" Inherits="Learning_System.WebForm1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="container mt-5">
        <div class="row">
            <div class="col-md-8">
                <h2 class="text-primary mb-3 fs-3">About Us</h2>
                <h4 class="fs-5">We are Experts in Learning</h4>
                <p class="fs-6 text-dark">At our institution, we are dedicated to providing a transformative educational experience. Our team of expert educators is committed to fostering a dynamic learning environment where students can thrive and reach their full potential.</p>

                <h4 class="fs-5">Our Goal</h4>
                <p class="fs-6 text-dark">Our goal is to empower students with the knowledge and skills they need to succeed in their chosen fields. We strive to cultivate a passion for learning that lasts a lifetime, encouraging critical thinking and innovation.</p>

            
                <h4 class="fs-5">Our Vision</h4>
                <p class="fs-6 text-dark">Our vision is to create a world where education is the foundation for a brighter future. We aspire to be a global institution recognized for our commitment to academic rigor, student success, and community engagement.</p>
            </div>
            <div class="col-md-4">
                <img src="slide/college.jpg" alt="Colorful educational blocks" class="img-fluid mt-4 h-100 py-2" style="border-radius:20px;" />
            </div>
        </div>
    </div>

    <div class="container mt-5">
        <h1 class="text-center mb-4">Our Top Instructor</h1>
        <p class="text-center mb-5 text-dark">Meet our top instructor, a passionate leader with extensive experience and a commitment to student success, inspiring students to excel.</p>

        <div class="row">

                        <div class="col-md-3 col-sm-6 mb-4">
                <div class="instructor-card text-center rounded-3 ">
                    <img src="slide/sumansir.png" alt="Instructor" class="rounded-3 img-fluid" />
                    <p class="instructor-name mt-2">Suman Thapaliya, Ph.D.</p>
                    <p class="instructor-role">Educator -Cyber Security, Researcher, Information Security Auditor
</p>
                    <div class="social-icons mt-2">
<%--                        <a href=" class="me-2"><i class="fab fa-facebook-f"></i></a>--%>
                       <%-- <a href="#" class="me-2"><i class="fab fa-instagram"></i></a>
                        <a href="#" class="me-2"><i class="fab fa-twitter"></i></a>--%>
                        <a href="https://www.linkedin.com/in/suman-thapaliya-ph-d-ba139144/"><i class="fab fa-linkedin-in"></i></a>
                    </div>
                </div>
            </div>

            <div class="col-md-3 col-sm-6 mb-4">
                <div class="instructor-card text-center rounded-3 ">
                    <img src="slide/rohitsri.png" alt="Instructor" class="rounded-3 img-fluid" />
                    <p class="instructor-name mt-2">Er. Rohit Prasad Pandy</p>
                    <p class="instructor-role">Educator/Electronics and Communication Engineer/Researcher
</p>
                    <div class="social-icons mt-2">
                        <a href="https://www.facebook.com/rohit.pandey.1428" class="me-2"><i class="fab fa-facebook-f"></i></a>
                       <%-- <a href="#" class="me-2"><i class="fab fa-instagram"></i></a>
                        <a href="#" class="me-2"><i class="fab fa-twitter"></i></a>--%>
                        <a href="https://www.linkedin.com/in/er-rohit-prasad-pandey-09137a215/"><i class="fab fa-linkedin-in"></i></a>
                    </div>
                </div>
            </div>

            <div class="col-md-3 col-sm-6 mb-4">
                <div class="instructor-card text-center rounded-3 ">
                    <img src="slide/deepaksir.png" alt="Instructor" class="rounded-3 img-fluid" />
                    <p class="instructor-name mt-2">Dipak Adhikari</p>
                    <p class="instructor-role">Educator | Network Engineer | Researcher</p>
                    <div class="social-icons mt-2">
                       <%-- <a href="#" class="me-2"><i class="fab fa-facebook-f"></i></a>
                        <a href="#" class="me-2"><i class="fab fa-instagram"></i></a>
                        <a href="#" class="me-2"><i class="fab fa-twitter"></i></a>--%>
                        <a href="https://www.linkedin.com/in/dipak-adhikari-371b2987/"><i class="fab fa-linkedin-in"></i></a>
                    </div>
                </div>
            </div>
            <div class="col-md-3 col-sm-6 mb-4">
                <div class="instructor-card text-center rounded-3 ">
                    <img src="slide/Durganand.png" alt="Instructor" class="rounded-3 img-fluid" />
                    <p class="instructor-name mt-2">Durganand Panjiyar</p>
                    <p class="instructor-role">Educator/ Dot.Net Developer in Multiple Platform</p>
                    <div class="social-icons mt-2">
                 <%--       <a href="#" class="me-2"><i class="fab fa-facebook-f"></i></a>
                        <a href="#" class="me-2"><i class="fab fa-instagram"></i></a>
                        <a href="#" class="me-2"><i class="fab fa-twitter"></i></a>--%>
                        <a href="https://www.linkedin.com/in/durganand-panjiyar-b06b19308/"><i class="fab fa-linkedin-in"></i></a>
                    </div>
                </div>
            </div>
        </div>
    </div>


    <div class="container-xl my-5">
        <h2 class="text-center my-5">What <b>Our Students</b> Are Saying</h2>
        <div id="myCarousel" class="carousel slide" data-bs-ride="carousel">
            <ol class="carousel-indicators">
                <li data-bs-target="#myCarousel" data-bs-slide-to="0" class="active"></li>
                <li data-bs-target="#myCarousel" data-bs-slide-to="1"></li>
                <li data-bs-target="#myCarousel" data-bs-slide-to="2"></li>
            </ol>
            <div class="carousel-inner">
                <div class="carousel-item active">
                    <div class="row">
                        <div class="col-sm-6 mb-4">
                          
                            <div class="d-flex align-items-start">
                                <img src="slide/arik.png" class="me-3 rounded-circle" alt="Client 1" style="width: 80px; height: 80px;" />
                                <div>
                                    <div class="testimonial">
<p>This institution has truly transformed my frontend development career. The instructors are knowledgeable and supportive, and the resources are top-notch.</p>
                                        <p class="overview"><b>Arik Rai</b>, Frontend Developer</p>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-sm-6 mb-4">
                            <div class="d-flex align-items-start">
                                <img src="slide/saroj.png" class="me-3 rounded-circle" alt="Client 2" style="width: 80px; height: 80px;" />
                                <div>
                                    <div class="testimonial">
<p>The hands-on approach to learning has been invaluable. I've gained practical mobile development skills that I use every day in my work.</p>
                                        <p class="overview"><b>Saroj Shrestha</b>,Mobile Developer</p>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="carousel-item">
                    <div class="row">
                        <div class="col-sm-6 mb-4">
                            <div class="d-flex align-items-start">
                                <img src="slide/subash.png" class="me-3 rounded-circle" alt="Client 3" style="width: 80px; height: 80px;" />
                                <div>
                                    <div class="testimonial">
<p>Exceptional experience! The courses are expertly structured, and the faculty is deeply invested in our success as AI developers.</p>
                                        <p class="overview"><b>Subash Sigdel</b>, AI Developer</p>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-sm-6 mb-4">
                            <div class="d-flex align-items-start">
                                <img src="slide/manoj.png" class="me-3 rounded-circle" alt="Client 4" style="width: 80px; height: 80px;" />
                                <div>
                                    <div class="testimonial">
<p>Innovative and engaging—this institution provides everything you need to excel in your Flutter development career.</p>
                                        <p class="overview"><b>Manoj Khatiwada</b>, Flutter Developer</p>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="carousel-item">
                    <div class="row">
                        <div class="col-sm-6 mb-4">
                            <div class="d-flex align-items-start">
                                <img src="slide/tara.png" class="me-3 rounded-circle" alt="Client 5" style="width: 80px; height: 80px;" />
                                <div>
                                    <div class="testimonial">
<p>An outstanding learning experience. The support and guidance I received helped me master React and achieve my goals.</p>
                                        <p class="overview"><b>Tara Lama</b>, React Developer</p>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-sm-6 mb-4">
                            <div class="d-flex align-items-start">
                                <img src="slide/zidan.png" class="me-3 rounded-circle" alt="Client 6" style="width: 80px; height: 80px;" />
                                <div>
                                    <div class="testimonial">
<p>This institution has leveled up my game development career. The instructors are experts, and the resources are spot-on.</p>
                                        <p class="overview"><b>Zidan Chamling Rai</b>,Game Developer </p>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <a class="carousel-control-prev" href="#myCarousel" role="button" data-bs-slide="prev">
                <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                <span class="visually-hidden">Previous</span>
            </a>
            <a class="carousel-control-next" href="#myCarousel" role="button" data-bs-slide="next">
                <span class="carousel-control-next-icon" aria-hidden="true"></span>
                <span class="visually-hidden">Next</span>
            </a>
        </div>
    </div>

    <style>
        .testimonial {
            background-color: #f8f9fa;
            padding: 15px;
            border-radius: 10px;
        }


        @media (max-width: 767px) {
            .carousel-item {
                text-align: center;
            }
        }
    </style>


</asp:Content>

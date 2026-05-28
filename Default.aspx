<%@ Page Title="" Language="C#" MasterPageFile="~/learning.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="Learning_System._default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">


    <div class="container-fluid row ">
        <div class="col-md-4 d-none d-md-flex position-relative justify-content-center align-items-center mb-4 mb-md-0">
            <div class="position-relative d-flex justify-content-center align-items-center">
                <img src="slide/learn3.png" class="position-relative object-fit-cover" alt="img" style="width: 12rem; height: 12rem; border-radius: 10px;object-fit:cover;">
                <div style="top: 10rem; left: 7rem; border-radius: 10px; padding: 5px; border: 10px solid white;"
                    class="position-absolute m-0 p-0 rounded-3 d-none d-md-block">
                    <img src="slide/sd.jpg" alt="ig" class="rounded-3 z-1 object-fit-cover" style="width: 10rem; height: 7rem; border-radius: 10px; object-fit:cover;" />
                </div>
            </div>
        </div>

        <div class="col-md-4">
            <div class="text-center my-5">
                <div class="d-flex justify-content-center position-relative align-items-center bg-light rounded-pill py-2 px-3 shadow-sm"
                    style="width: fit-content; margin-left: auto; margin-right: auto;">
                    <img src="slide/lgo.png" alt="Graduation cap" class="me-2 position-absolute"
                        style="width: 50px; height: 60px; top: -1.5rem; left: 0.5rem;">
                    <span class="text-muted px-5 fs-6">One of the Top IT College of Nepal</span>
                </div>
                <h1 class="mt-3 text-dark fw-bold">Empowering Students To <span class="text-primary">Lead </span>And
                    <span class="text-primary">Succeed</span></h1>
                <p class="fs-6 text-dark">We provide meaningful content to empower students and enhance their academic success.</p>
<!-- Button to scroll to a specific section -->
<a href="#courses-section" class="btn btn-primary btn-lg my-4 fs-6 px-5" style="border-radius: 30px; background-color: #28346f;">View All Courses</a>

                <div class="row text-center mt-4 text-primary">
                    <div class="col-6 mb-3 mb-md-0">
                        <div class="d-flex justify-content-center align-items-center">
                            <img src="slide/lgo.png" style="width: 4rem; height: 4rem;">
                            <h3 class="ms-2 fw-bold" style="color: #FF1493;">7.1k</h3>
                        </div>
                        <p>Total students present at TCMIT</p>

                    </div>
                    <div class="col-6">
                        <div class="d-flex justify-content-center align-items-center">
                            <img src="slide/lgo.png" style="width: 4rem; height: 4rem;">
                            <h3 class="highlight ms-2 fw-bold">20+</h3>
                        </div>
                        <p>Programs are available at TCMIT</p>
                    </div>

                </div>
            </div>
        </div>
        <div class="col-md-4 position-relative d-none d-md-flex justify-content-center align-items-center mb-4 mb-md-0">
            <div class="position-relative d-flex justify-content-center align-items-center">
                <img src="slide/sartak.png" class="position-relative object-fit-cover" alt="img" style="width: 12rem; height: 12rem; border-radius: 10px;object-fit:cover;">
                <div style="top: 10rem; right: 7rem; border-radius: 10px; padding: 5px; border: 10px solid white;"
                    class="position-absolute m-0 p-0 rounded-3 d-md-block inner-image">
                    <img src="slide/haik.jpg" alt="ig" class="rounded-3 z-1 object-fit-cover" style="width: 10rem; height: 7rem;object-fit:cover;">
                </div>
            </div>
        </div>



    </div>





    <div id="courses-section" class="container-fluid mt-5">
        <h1 class="text-center mb-4">All Program's Notes</h1>
        <p class="text-center text-dark mb-5">
            Discover curated notes across programs to boost your learning and exam preparation. These resources cover key concepts and provide valuable insights for academic success.
        </p>

        <!-- Use Bootstrap's grid system for responsive design -->
        <div class="container-fluid row">

            <div class="col-12 d-flex flex-wrap justify-content-center">




                <div class="nima-card card mx-2 mb-4 d-flex justify-content-start" style="width: 13rem; height: 12rem;">
                    <img src="slide/mbacard1.png" class="card-img-top " alt="Computer Technology"
                        style="border-radius: 20px; padding: 1rem;"
                        loading="lazy" decoding="async">

                    <h5 class="card-title  mt-0 text-center">MBA</h5>

                    <div class="button-container ">
                        <a href="Mba_Notes/dash.aspx" class="btn btn-secondary w-100 mb-2">Notes</a>
                        <a class="btn btn-primary w-100 " href="Past_Year_Paper/MBA/dash.aspx">Past Year Questions</a>
                    </div>
                </div>



                    <div class="nima-card card mx-2 mb-4  d-flex justify-content-start" style="width: 13rem; height: 12rem;">
                    <img src="slide/computer.png" class="card-img-top " alt="Computer Technology"
                        style="border-radius: 20px; padding: 1rem;"
                        loading="lazy" decoding="async">

                    <h5 class="card-title  mt-0 text-center">MCS</h5>

                    <div class="button-container">
                        <a href="Mcs_Notes/dash.aspx" class="btn btn-secondary mb-2 w-100">Notes</a>
                                                <a class="btn btn-primary w-100 " href="Past_Year_Paper/MCS/dash.aspx">Past Year Questions</a>

                   
                    </div>
                </div>


                
                    <div class="nima-card card mx-2 mb-4  d-flex justify-content-start" style="width: 13rem; height: 12rem;">
                    <img src="slide/chefcap.png" class="card-img-top " alt="Computer Technology"
                        style="border-radius: 20px; padding: 1rem;"
                        loading="lazy" decoding="async">

                    <h5 class="card-title  mt-0 text-center">BHM</h5>

                    <div class="button-container">
                        <a href="Bhm_Notes/dash.aspx" class="btn btn-secondary mb-2 w-100">Notes</a>
                                                <a class="btn btn-primary w-100 " href="Past_Year_Paper/BHM/dash.aspx">Past Year Questions</a>

                   
                    </div>
                </div>


                
                    <div class="nima-card card mx-2  mb-4  d-flex justify-content-start" style="width: 13rem; height: 12rem;">
                    <img src="slide/bba2.jpg" class="card-img-top " alt="Computer Technology"
                        style="border-radius: 20px; padding: 1rem;"
                        loading="lazy" decoding="async">

                    <h5 class="card-title  mt-0 text-center">BBA</h5>

                    <div class="button-container">
                        <a href="Bba_Notes/dash.aspx" class="btn btn-secondary mb-2 w-100">Notes</a>
                                                <a class="btn btn-primary w-100 " href="Past_Year_Paper/BBA/dash.aspx">Past Year Questions</a>
                    </div>
                </div>


                
                    <div class="nima-card card mx-2 mb-4 d-flex justify-content-start" style="width: 13rem; height: 12rem;">
                    <img src="slide/bcs4.png" class="card-img-top " alt="Computer Technology"
                        style="border-radius: 20px; padding: 1rem;"
                        loading="lazy" decoding="async">

                    <h5 class="card-title  mt-0 text-center">BCS</h5>

                    <div class="button-container">
                        <a href="Bcs_Notes/dash.aspx" class="btn btn-secondary mb-2 w-100">Notes</a>
                         <a class="btn btn-primary w-100 " href="Past_Year_Paper/BCS/dash.aspx">Past Year Questions</a>
                    </div>
                </div>


                    <div class="nima-card card mx-2 mb-4 d-flex justify-content-start" style="width: 13rem; height: 12rem;">
    <img src="slide/bit.png"" class="card-img-top " alt="Computer Technology"
        style="border-radius: 20px; padding: 1rem;"
        loading="lazy" decoding="async">
    <h5 class="card-title  mt-0 text-center">BIT</h5>

    <div class="button-container">
        <a href="Bit_Notes/dash.aspx" class="btn btn-secondary mb-2 w-100">Notes</a>
         <a class="btn btn-primary w-100 " href="Past_Year_Paper/Bit/dash.aspx">Past Year Questions</a>
    </div>
</div>


             


            </div>
        </div>
    </div>







    <div class="container mt-5">
        <h1 class="text-center mb-4">Our Top Instructor</h1>
        <p class="text-center mb-5 text-dark">Meet our top instructor, a passionate leader with extensive experience and a commitment to student success, inspiring students to excel.</p>

        <div class="row">

                        <div class="col-md-4 col-sm-6 mb-4">
                <div class="instructor-card text-center rounded-3 ">
                    <img src="slide/sumansir.png" alt="Instructor" class="rounded-3 img-fluid" />
                    <p class="instructor-name mt-2">Suman Thapaliya, Ph.D.</p>
                    <p class="instructor-role">Educator -Cyber Security, Researcher, Information Security Auditor
</p>
                    <div class="social-icons mt-2">
<%--                        <a href=" class="me-2"><i class="fab fa-facebook-f"></i></a>--%>
                       <%-- <a href="#" class="me-2"><i class="fab fa-instagram"></i></a>
                        <a href="#" class="me-2"><i class="fab fa-twitter"></i></a>--%>
                        <a href="https://www.linkedin.com/in/suman-thapaliya-ph-d-ba139144/" class="bg-primary"><i class="fab fa-linkedin-in bg-primary"></i></a>
                    </div>
                </div>
            </div>

            <div class="col-md-4 col-sm-6 mb-4">
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

            
            <div class="col-md-4 col-sm-6 mb-4">
                <div class="instructor-card text-center rounded-3 ">
                    <img src="slide/Durganand.png" alt="Instructor" class="rounded-3 img-fluid" />
                    <p class="instructor-name mt-2">Durganand Panjiyar</p>
                    <p class="instructor-role">Educator/ Dot.Net Developer in Multiple Platform</p>
                    <div class="social-icons mt-2">
                 <%--       <a href="#" class="me-2"><i class="fab fa-facebook-f"></i></a>
                        <a href="#" class="me-2"><i class="fab fa-instagram"></i></a>
                        <a href="#" class="me-2"><i class="fab fa-twitter"></i></a>--%>
                        <a href="https://www.linkedin.com/in/durganand-panjiyar-b06b19308/"><i class="fab fa-linkedin-in bg-primary"></i></a>
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

<%@ Page Title="" Language="C#" MasterPageFile="~/learning.Master" AutoEventWireup="true" CodeBehind="Blog.aspx.cs" Inherits="Learning_System.WebForm2" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <!-- Blog Section for Hotel -->
    <section class="py-3 py-md-5">
        <div class="container">
            <div class="row justify-content-md-center">
                <div class="col-12 col-md-10 col-lg-8 col-xl-7 col-xxl-6">
                    <h3 class="fs-5 text-secondary mb-2 text-uppercase text-center">Our News</h3>
                    <h4 class="display-5 mb-4 mb-md-5 text-center text-primary">Uncover the Latest Insights and Innovations </h4>
                    <hr class="w-50 mx-auto mb-5 mb-xl-9 border-dark-subtle">
                </div>
            </div>
        </div>

        <div class="container overflow-hidden">
            <div class="row gy-5">
                <!-- Blog 1 -->
                <div class="col-12">
                    <div class="row align-items-center gy-3 gy-md-0 gx-xl-5">
                        <div class="col-xs-12 col-md-6">
                            <div class="img-wrapper position-relative bsb-hover-push ">
                                <a href="AIBlog.aspx">
                                    <span class="badge rounded-pill text-bg-warning position-absolute top-0 start-0 m-3">Face Detection</span>
                                    <a href="AIBlog.aspx">
                                        <img class="img-fluid rounded w-100 h-100 object-fit-cover" loading="lazy" src="slide/facedetection.png" alt="Face Detection">
                                    </a>

                                </a>
                            </div>
                        </div>
                        <div class="col-xs-12 col-md-6 mt-3">
                            <div>
                                <div class="d-flex align-items-center my-3">
                                    <img src="slide/subash.png" class="me-3 rounded-circle" alt="Client 5" style="width: 80px; height: 80px;" />
                                    <div>
                                        <div class="testimonial">
                                            <p class="overview">
                                                <b>Subash Sigdel</b>, AI Developer
                                                <br />
                                                <span class="text-secondary mb-1 fs-6">Aug 27, 2024</span>
                                            </p>
                                        </div>
                                    </div>
                                </div>

                                <h3 class="text-primary mb-3"><a class="link-dark text-decoration-none" href="~/Blog/Blog1">Build a Real-Time Face Recognition and Attendance System </a></h3>
                                <p class="fs-6 mb-4">Learn how to build a Real-Time Face Recognition and Attendance System Using OpenCV, Face Recognition, and Google Text-to-Speech</p>
                                <a href="AIBlog.aspx" class="btn btn-primary">Read more</a>
                            </div>
                        </div>
                    </div>
                </div>

                <%-- <!-- Blog 2 -->
            <div class="col-12">
                <div class="row align-items-center flex-row-reverse gy-3 gy-md-0 gx-xl-5">
                    <div class="col-xs-12 col-md-6">
                        <div class="img-wrapper position-relative bsb-hover-push">
                            <a href="~/Blog/Blog2">
                                <span class="badge rounded-pill text-bg-warning position-absolute top-0 end-0 m-3">Dining</span>
                                <img class="img-fluid rounded w-100 h-100 object-fit-cover" loading="lazy" src="~/images/ro.jpg" alt="Dining">
                            </a>
                        </div>
                    </div>
                    <div class="col-xs-12 col-md-6">
                        <div>
                            <p class="text-secondary mb-1 fs-6">Dec 20, 2023</p>
                            <h3 class="text-primary mb-3"><a class="link-dark text-decoration-none" href="~/Blog/Blog2">A Culinary Journey: Exploring Our Gourmet Dining Options</a></h3>
                            <p class="fs-6 mb-4">Join us as we take you through a delightful journey of our gourmet dining options, curated by our top chefs.</p>
                            <a class="btn btn-primary" asp-controller="Blog" asp-action="Blog2" target="_self">Read More</a>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Blog 3 -->
            <div class="col-12">
                <div class="row align-items-center gy-3 gy-md-0 gx-xl-5">
                    <div class="col-xs-12 col-md-6">
                        <div class="img-wrapper position-relative bsb-hover-push">
                            <a href="~/Blog/Blog3">
                                <span class="badge rounded-pill text-bg-warning position-absolute top-0 start-0 m-3">Events</span>
                                <img class="img-fluid rounded w-100 h-100 object-fit-cover" loading="lazy" src="~/images/ro.jpg" alt="Events">
                            </a>
                        </div>
                    </div>
                    <div class="col-xs-12 col-md-6">
                        <div>
                            <p class="text-secondary mb-1 fs-6">Nov 30, 2023</p>
                            <h3 class="text-primary mb-3"><a class="link-dark text-decoration-none" href="~/Blog/Blog3">Memorable Moments: Hosting Events at Our Hotel</a></h3>
                            <p class="fs-6 mb-4">Our hotel is the perfect venue for all types of events, from weddings to corporate meetings. Learn more about our event hosting services.</p>
                            <a class="btn btn-primary" asp-controller="Blog" asp-action="Blog3" target="_self">Read More</a>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Blog 4 -->
            <div class="col-12">
                <div class="row align-items-center flex-row-reverse gy-3 gy-md-0 gx-xl-5">
                    <div class="col-xs-12 col-md-6">
                        <div class="img-wrapper position-relative bsb-hover-push">
                            <a href="~/Blog/Blog4">
                                <span class="badge rounded-pill text-bg-warning position-absolute top-0 end-0 m-3">Travel Tips</span>
                                <img class="img-fluid rounded w-100 h-100 object-fit-cover" loading="lazy" src="~/images/ro.jpg" alt="Travel Tips">
                            </a>
                        </div>
                    </div>
                    <div class="col-xs-12 col-md-6">
                        <div>
                            <p class="text-secondary mb-1 fs-6">Oct 5, 2023</p>
                            <h3 class="text-primary mb-3"><a class="link-dark text-decoration-none" href="~/Blog/Blog4">Essential Travel Tips for Your Next Stay</a></h3>
                            <p class="fs-6 mb-4">Planning your next stay with us? Here are some essential travel tips to make your visit even more enjoyable.</p>
                            <a class="btn btn-primary" asp-controller="Blog" asp-action="Blog4" target="_self">Read More</a>
                        </div>
                    </div>
                </div>
            </div>--%>
            </div>
        </div>
    </section>

</asp:Content>

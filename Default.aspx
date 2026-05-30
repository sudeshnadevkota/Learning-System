<%@ Page Title="" Language="C#" MasterPageFile="~/learning.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="Learning_System._default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

<style>

:root{
    --primary:#0B1F66;
    --secondary:#081547;
    --pink:#FF2D8D;
    --yellow:#F6B400;
    --light:#F5F7FD;
    --white:#FFFFFF;
    --border:#E7ECFF;
    --text:#6B7280;
}

/* BODY */

body{
    background:var(--light) !important;
    font-family:'Segoe UI',sans-serif;
    overflow-x:hidden;
}

/* HERO SECTION */

.hero-section{
    background:linear-gradient(135deg,#0B1F66,#081547) !important;
    padding:60px 50px !important;
    border-radius:0 0 40px 40px;
    position:relative;
    overflow:hidden;
}

/* HERO GLOW */

.hero-section::before{
    content:'';
    position:absolute;
    width:320px;
    height:320px;
    background:rgba(255,45,141,0.12);
    border-radius:50%;
    top:-100px;
    right:-80px;
}

/* TITLE */

.hero-title{
    font-size:48px;
    font-weight:800;
    line-height:1.15;
    color:white !important;
}

.hero-title span{
    color:var(--yellow) !important;
}

/* TEXT */

.hero-text{
    color:#d8ddf0 !important;
    font-size:15px;
    margin-top:16px;
    line-height:1.6;
    max-width:500px;
}

/* TOP BADGE */

.top-badge{
    display:inline-block;
    background:rgba(255,255,255,0.12);
    color:white;
    padding:10px 22px;
    border-radius:50px;
    font-size:14px;
    font-weight:600;
    border:1px solid rgba(255,255,255,0.2);
    backdrop-filter:blur(10px);
}

/* HERO IMAGE */

.hero-img{
    width:100%;
    max-width:420px;
    border-radius:24px;
    box-shadow:0 18px 40px rgba(0,0,0,0.22);
    transition:.4s;
}

.hero-img:hover{
    transform:translateY(-6px) scale(1.01);
}

/* BUTTONS */

.hero-btn,
.btn-primary{
    background:var(--pink) !important;
    color:white !important;
    border:none !important;
    border-radius:50px !important;
    padding:11px 26px !important;
    font-size:14px;
    font-weight:700 !important;
    transition:.3s;
    box-shadow:0 8px 18px rgba(255,45,141,.25);
}

.hero-btn:hover,
.btn-primary:hover{
    background:var(--yellow) !important;
    color:var(--primary) !important;
    transform:translateY(-2px);
}

/* SECOND BUTTON */

.btn-secondary{
    background:var(--yellow) !important;
    color:var(--primary) !important;
    border:none !important;
    border-radius:50px !important;
    padding:10px 22px !important;
    font-size:14px;
    font-weight:700 !important;
    transition:.3s;
}

.btn-secondary:hover{
    background:var(--pink) !important;
    color:white !important;
}

/* STATS */

.stats-box{
    background:rgba(255,255,255,0.08);
    border-radius:18px;
    padding:18px;
    margin-top:15px;
    backdrop-filter:blur(10px);
}

.stats-box h3{
    color:var(--yellow);
    font-size:28px;
    font-weight:800;
    margin-bottom:5px;
}

.stats-box p{
    color:#dbe3ff;
    font-size:13px;
    margin:0;
    line-height:1.5;
}

/* SECTIONS */

/* SERVICES SECTION = BLUE */

#services-section{
    background:linear-gradient(135deg,#0B1F66,#081547) !important;
    padding:60px 50px !important;
}

#services-section .section-title{
    color:white !important;
}

#services-section .section-subtitle{
    color:#d8ddf0 !important;
}

/* COURSES SECTION = WHITE */

#courses-section{
    background:white !important;
    padding:60px 50px !important;
    margin-top:0;
}

.container,
.container-xl{
    background:transparent !important;
}

/* SECTION TITLE */

.section-title{
    color:var(--primary) !important;
    font-size:38px;
    font-weight:800;
    margin-bottom:12px;
}

.section-subtitle{
    color:var(--text);
    font-size:15px;
}

/* PROGRAM CARDS */

.nima-card{
    width:14rem !important;
    border:none !important;
    border-radius:22px !important;
    overflow:hidden;
    background:white !important;
    padding:14px !important;
    margin:12px !important;
    transition:.4s;
    box-shadow:0 8px 24px rgba(11,31,102,.08);
}

.nima-card:hover{
    transform:translateY(-8px);
    box-shadow:0 16px 32px rgba(11,31,102,.14);
}

.nima-card img{
    width:100%;
    height:180px;
    object-fit:contain;
    border-radius:18px !important;
    background:white;
}

.card-title{
    color:var(--primary) !important;
    font-size:20px;
    font-weight:800;
    margin:14px 0;
}

/* INSTRUCTOR */

.instructor-card{
    background:white !important;
    border-radius:24px;
    padding:18px;
    transition:.4s;
    box-shadow:0 8px 24px rgba(11,31,102,.08);
    border:none;
}

.instructor-card:hover{
    transform:translateY(-8px);
}

.instructor-card img{
    width:100%;
    height:220px;
    object-fit:cover;
    border-radius:18px;
}

.instructor-name{
    color:var(--primary);
    font-size:20px;
    font-weight:800;
}

.instructor-role{
    color:var(--text);
    font-size:13px;
}

/* TESTIMONIAL */

.testimonial{
    background:white;
    border-radius:22px;
    padding:24px;
    box-shadow:0 8px 24px rgba(11,31,102,.08);
}

.testimonial p{
    color:var(--text);
    line-height:1.6;
    font-size:14px;
}

.overview{
    color:var(--primary) !important;
    font-weight:700;
    margin-top:14px;
    font-size:14px;
}

/* MOBILE */

@media(max-width:768px){

    .hero-section{
        padding:45px 20px !important;
        text-align:center;
        border-radius:0 0 30px 30px;
    }

    .hero-title{
        font-size:34px;
    }

    .hero-text{
        font-size:14px;
        margin:auto;
        margin-top:14px;
    }

    .hero-img{
        max-width:320px;
        margin-top:30px;
    }

    .nima-card{
        width:100% !important;
    }

    .section-title{
        font-size:28px;
    }

    .stats-box{
        margin-bottom:10px;
    }

    .instructor-card img{
        height:200px;
    }
}

</style>




<!-- STUDENT SERVICES -->

<div id="services-section" class="container-fluid py-5">

    <h1 class="section-title text-center">
        Our Services
    </h1>

    <p class="section-subtitle text-center mb-5">
        Access all important student facilities and services.
    </p>

    <div class="row justify-content-center">

      <!-- ATTENDANCE -->

<div class="nima-card card text-center">

    <img src="slide/attendence.png" class="card-img-top" />

    <h5 class="card-title">
        Attendance
    </h5>

    <a href="https://texasattendance.com/" class="btn btn-primary">
        Open
    </a>

</div>

      <!-- CERTIFICATE -->

<div class="nima-card card text-center">

    <img src="slide/certificate.png" class="card-img-top" />

    <h5 class="card-title">
        Certificate
    </h5>

    <a href="https://certificate.texascollegenepal.com/Default.aspx" class="btn btn-primary">
        Open
    </a>

</div>

        <!-- Leave-->

        <div class="nima-card card text-center">

            <img src="slide/leave.png" class="card-img-top" />

            <h5 class="card-title">
                Leave
            </h5>

            <a href="" class="btn btn-primary">
                Open
            </a>

        </div>

        <!-- JOB -->

        <div class="nima-card card text-center">

            <img src="slide/job.png" class="card-img-top" />

            <h5 class="card-title">
                Jobs
            </h5>

            <a href="https://texasjobportal.com/default.aspx  QA" class="btn btn-primary">
                Open
            </a>

        </div>

        

        

        <!-- INFORMATION -->

        <div class="nima-card card text-center">

            <img src="slide/QRinfo.png" class="card-img-top" />

            <h5 class="card-title">
                Information
            </h5>

            <a href="information.aspx" class="btn btn-primary">
                Open
            </a>

        </div>

    </div>

</div>

<!-- COURSES -->

<div id="courses-section" class="container-fluid py-5">

    <h1 class="section-title text-center">
        Browse By Your Degree
    </h1>

    <p class="section-subtitle text-center mb-5">
        Discover curated notes across programs.
    </p>

    <div class="row justify-content-center">

        <!-- MBA -->

        <div class="nima-card card">
            <img src="slide/mbacard1.png" class="card-img-top" />
            <h5 class="card-title text-center">MBA</h5>

            <a href="Mba_Notes/dash.aspx" class="btn btn-secondary mb-2">
                Notes
            </a>

            <a href="Past_Year_Paper/MBA/dash.aspx" class="btn btn-primary">
                Past Year Questions
            </a>
        </div>

        <!-- MCS -->

        <div class="nima-card card">
            <img src="slide/computer.png" class="card-img-top" />
            <h5 class="card-title text-center">MCS</h5>

            <a href="Mcs_Notes/dash.aspx" class="btn btn-secondary mb-2">
                Notes
            </a>

            <a href="Past_Year_Paper/MCS/dash.aspx" class="btn btn-primary">
                Past Year Questions
            </a>
        </div>

        <!-- BBA -->

        <div class="nima-card card">
            <img src="slide/bba2.jpg" class="card-img-top" />
            <h5 class="card-title text-center">BBA</h5>

            <a href="Bba_Notes/dash.aspx" class="btn btn-secondary mb-2">
                Notes
            </a>

            <a href="Past_Year_Paper/BBA/dash.aspx" class="btn btn-primary">
                Past Year Questions
            </a>
        </div>

        <!-- BCS -->

        <div class="nima-card card">
            <img src="slide/bcs4.png" class="card-img-top" />
            <h5 class="card-title text-center">BCS</h5>

            <a href="Bcs_Notes/dash.aspx" class="btn btn-secondary mb-2">
                Notes
            </a>

            <a href="Past_Year_Paper/BCS/dash.aspx" class="btn btn-primary">
                Past Year Questions
            </a>
        </div>

        <!-- BIT -->

        <div class="nima-card card">
            <img src="slide/bit.png" class="card-img-top" />
            <h5 class="card-title text-center">BIT</h5>

            <a href="Bit_Notes/dash.aspx" class="btn btn-secondary mb-2">
                Notes
            </a>

            <a href="Past_Year_Paper/Bit/dash.aspx" class="btn btn-primary">
                Past Year Questions
            </a>
        </div>

    </div>

</div>


</asp:Content>

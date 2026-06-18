<%@ Page Title="" Language="C#" MasterPageFile="~/learning.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="Learning_System._default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <style>
        :root {
            --primary: #0B1F66;
            --secondary: #081547;
            --pink: #FF2D8D;
            --yellow: #F6B400;
            --light: #F5F7FD;
            --white: #FFFFFF;
            --border: #E7ECFF;
            --text: #6B7280;
        }

        body {
            background: var(--light) !important;
            font-family: 'Segoe UI', sans-serif;
            overflow :hidden;
        }

        .hero-section {
            background: linear-gradient(135deg, #0B1F66, #081547) !important;
            padding: 60px 50px !important;
            border-radius: 0 0 40px 40px;
            position: relative;
            overflow: hidden;
        }

            .hero-section::before {
                content: '';
                position: absolute;
                width: 320px;
                height: 320px;
                background: rgba(255, 45, 141, 0.12);
                border-radius: 50%;
                top: -100px;
                right: -80px;
            }

        .hero-title {
            font-size: 48px;
            font-weight: 800;
            line-height: 1.15;
            color: white !important;
        }

            .hero-title span {
                color: var(--yellow) !important;
            }

        .hero-text {
            color: #d8ddf0 !important;
            font-size: 15px;
            margin-top: 16px;
            line-height: 1.6;
            max-width: 500px;
        }

        .top-badge {
            display: inline-block;
            background: rgba(255, 255, 255, 0.12);
            color: white;
            padding: 10px 22px;
            border-radius: 50px;
            font-size: 14px;
            font-weight: 600;
            border: 1px solid rgba(255, 255, 255, 0.2);
            backdrop-filter: blur(10px);
        }

        .hero-img {
            width: 100%;
            max-width: 420px;
            border-radius: 24px;
            box-shadow: 0 18px 40px rgba(0, 0, 0, 0.22);
            transition: .4s;
        }

            .hero-img:hover {
                transform: translateY(-6px) scale(1.01);
            }

        .hero-btn {
            background: var(--pink);
            color: white;
            border: none;
            border-radius: 50px;
            padding: 11px 26px;
            font-size: 14px;
            font-weight: 700;
            transition: .3s;
            box-shadow: 0 8px 18px rgba(255, 45, 141, .25);
        }

            .hero-btn:hover {
                background: var(--yellow);
                color: var(--primary);
            }

        .btn-secondary {
            background: var(--yellow) !important;
            color: var(--primary) !important;
            border: none !important;
            border-radius: 50px !important;
            padding: 10px 22px !important;
            font-size: 14px;
            font-weight: 700 !important;
            transition: .3s;
        }

            .btn-secondary:hover {
                background: var(--pink) !important;
                color: white !important;
            }

        .stats-box {
            background: rgba(255, 255, 255, 0.08);
            border-radius: 18px;
            padding: 18px;
            margin-top: 15px;
            backdrop-filter: blur(10px);
        }

            .stats-box h3 {
                color: var(--yellow);
                font-size: 28px;
                font-weight: 800;
                margin-bottom: 5px;
            }

            .stats-box p {
                color: #dbe3ff;
                font-size: 13px;
                margin: 0;
                line-height: 1.5;
            }

        #services-section {
            background: linear-gradient(135deg, #0B1F66, #081547) !important;
            padding: 60px 50px !important;
        }

            #services-section .section-title {
                color: white !important;
            }

            #services-section .section-subtitle {
                color: #d8ddf0 !important;
            }

        #courses-section {
            background: white !important;
            padding: 70px 50px 50px 50px !important;
            margin-top: 0;
        }

        .container, .container-xl {
            background: transparent !important;
        }

        .section-title {
            color: var(--primary) !important;
            font-size: 38px;
            font-weight: 800;
            margin-bottom: 12px;
        }

        .section-subtitle {
            color: var(--text);
            font-size: 15px;
        }

        /* Layout fix for single row without slider */
        .cards-wrapper {
            display: flex;
            flex-wrap: wrap;
            justify-content: center;
            gap: 20px;
            padding: 0 50px;
        }

        .nima-card {
            width: 12rem !important;
            border: none !important;
            border-radius: 22px !important;
            overflow: hidden;
            background: white !important;
            padding: 14px !important;
            transition: .4s;
            box-shadow: 0 8px 24px rgba(11, 31, 102, .08);
        }

            .nima-card:hover {
                transform: translateY(-8px);
                box-shadow: 0 16px 32px rgba(11, 31, 102, .14);
            }

            .nima-card img {
                width: 100%;
                height: 140px;
                object-fit: contain;
                border-radius: 18px !important;
                background: white;
            }

        .card-title {
            color: var(--primary) !important;
            font-size: 20px;
            font-weight: 800;
            margin: 14px 0;
        }

        @media(max-width: 992px) {
            .cards-wrapper {
                padding: 0 20px;
            }

            .nima-card {
                width: 10rem !important;
            }
        }
    </style>

    <div id="courses-section" class="container-fluid py-5">
        <h1 class="section-title text-center">Get Your Learning Material</h1>
        <p class="section-subtitle text-center mb-5">Access study materials and previous exam papers for your courses.</p>

        <div class="cards-wrapper">
            <div class="nima-card card">
                <img src="slide/bit.png" class="card-img-top" />
                <h5 class="card-title text-center">BIT</h5>
                <a href="Bit_Notes/dash.aspx" class="btn btn-secondary mb-2">Study Materials</a>
            </div>
            <div class="nima-card card">
                <img src="slide/bcs4.png" class="card-img-top" />
                <h5 class="card-title text-center">BCS</h5>
                <a href="Bcs_Notes/dash.aspx" class="btn btn-secondary mb-2">Study Materials</a>
            </div>
            <div class="nima-card card">
                <img src="slide/mbacard1.png" class="card-img-top" />
                <h5 class="card-title text-center">MBA</h5>
                <a href="Mba_Notes/dash.aspx" class="btn btn-secondary mb-2">Study Materials</a>
            </div>
            <div class="nima-card card">
                <img src="slide/computer.png" class="card-img-top" />
                <h5 class="card-title text-center">MCS</h5>
                <a href="Mcs_Notes/dash.aspx" class="btn btn-secondary mb-2">Study Materials</a>
            </div>
            <div class="nima-card card">
                <img src="slide/bba2.jpg" class="card-img-top" />
                <h5 class="card-title text-center">BBA</h5>
                <a href="Bba_Notes/dash.aspx" class="btn btn-secondary mb-2">Study Materials</a>
            </div>
                        <div class="nima-card card">
                <img src="slide/bba2.jpg" class="card-img-top" />
                <h5 class="card-title text-center">BHM</h5>
                <a href="Bhm_Notes/dash.aspx" class="btn btn-secondary mb-2">Study Materials</a>
            </div>
           
        </div>
    </div>
</asp:Content>

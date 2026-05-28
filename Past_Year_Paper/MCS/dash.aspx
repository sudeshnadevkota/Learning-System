<%@ Page Title="" Language="C#" MasterPageFile="~/Past_Year_Paper/MCS/MCS.Master" AutoEventWireup="true" CodeBehind="dash.aspx.cs" Inherits="Learning_System.Past_Year_Paper.MCS.dash" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="container " style="padding-top: 3px;">
        <asp:Button
            ID="btnHome"
            runat="server"
            Text="Go to Home"
            OnClick="btnHome_Click"
            Style="background: #002366; border: none; color: white; text-decoration: none; cursor: pointer; border-radius: 5px; width: 125px; height: 40px;" />


        <div class="text-center rounded-4 py-4">
            <img src="../../slide/mcs2.png" class="img-fluid w-100" style="height: 350px; border-radius: 10px; object-fit: cover" />
        </div>

        <!-- Course Details -->
        <h1 class="text-custom">Master of Computer Science (MCS)</h1>
        <p>The Master of Computer Science (MCS) program provides an in-depth exploration of advanced computer science topics and prepares students for leadership roles in the technology sector. This program emphasizes both theoretical knowledge and practical skills, covering areas such as algorithms, software engineering, data science, and artificial intelligence. Ideal for professionals seeking to advance their expertise and career opportunities in computing, the MCS program equips students with the tools needed to tackle complex technical challenges.</p>
        <p>Gain cutting-edge knowledge in emerging technologies and develop problem-solving skills essential for innovation and advancement in the field of computer science.</p>

        <div class="container">
            <div class="row">
                <div class="col-md-8">
                    <h3 class="text-decoration-none text-custom">What You'll Learn</h3>
                    <ul class="list-group list-group-flush" style="text-decoration: none;">
                        <li class="list-group-item" style="border: none;">
                            <i class="bi bi-check-circle-fill text-primary me-2" style="text-decoration: none;"></i>
                            Master advanced algorithms and data structures.
                        </li>
                        <li class="list-group-item" style="border: none;">
                            <i class="bi bi-check-circle-fill text-primary me-2" style="text-decoration: none;"></i>
                            Develop expertise in software engineering and system design.
                        </li>
                        <li class="list-group-item" style="border: none;">
                            <i class="bi bi-check-circle-fill text-primary me-2" style="text-decoration: none;"></i>
                            Explore data science methodologies and machine learning techniques.
                        </li>
                        <li class="list-group-item" style="border: none;">
                            <i class="bi bi-check-circle-fill text-primary me-2" style="text-decoration: none;"></i>
                            Understand the principles of artificial intelligence and its applications.
                        </li>
                        <li class="list-group-item" style="border: none;">
                            <i class="bi bi-check-circle-fill text-primary me-2" style="text-decoration: none;"></i>
                            Gain skills in cybersecurity and data protection strategies.
                        </li>
                    </ul>
                </div>
                <div class="col-md-4">
                    <h3 class="text-custom">How it helps Students</h3>
                    <blockquote class="blockquote">
                        <p class="mb-0">"The MCS program has provided students with advanced skills and knowledge in computer science, preparing them for high-level technical roles and research opportunities. The hands-on experience and comprehensive curriculum have been instrumental in their career advancement."</p>
                    </blockquote>
                </div>
            </div>
        </div>

        <div style="width: 100%; font-family: Arial, sans-serif;">
            <h2 class="text-custom" style="font-size: 24px; margin-bottom: 10px;">Course Content</h2>
            <h5 class="text-custom" style="font-size: 18px; margin-bottom: 20px;">MCS Core Topics</h5>
            <div>
                <div style="border: 1px solid #dee2e6; border-radius: 4px; margin-bottom: 10px; padding: 15px; display: flex; align-items: center;">
                    <input type="checkbox" style="appearance: none; -webkit-appearance: none; width: 20px; height: 20px; border: 2px solid #ced4da; border-radius: 50%; margin-right: 15px; outline: none; cursor: pointer;" />
                    <span style="font-size: 16px;">Advanced Algorithms and Data Structures</span>
                </div>
                <div style="border: 1px solid #dee2e6; border-radius: 4px; margin-bottom: 10px; padding: 15px; display: flex; align-items: center;">
                    <input type="checkbox" style="appearance: none; -webkit-appearance: none; width: 20px; height: 20px; border: 2px solid #ced4da; border-radius: 50%; margin-right: 15px; outline: none; cursor: pointer;" />
                    <span style="font-size: 16px;">Software Engineering and System Design</span>
                </div>
                <div style="border: 1px solid #dee2e6; border-radius: 4px; margin-bottom: 10px; padding: 15px; display: flex; align-items: center;">
                    <input type="checkbox" style="appearance: none; -webkit-appearance: none; width: 20px; height: 20px; border: 2px solid #ced4da; border-radius: 50%; margin-right: 15px; outline: none; cursor: pointer;" />
                    <span style="font-size: 16px;">Data Science and Machine Learning</span>
                </div>
                <div style="border: 1px solid #dee2e6; border-radius: 4px; margin-bottom: 10px; padding: 15px; display: flex; align-items: center;">
                    <input type="checkbox" style="appearance: none; -webkit-appearance: none; width: 20px; height: 20px; border: 2px solid #ced4da; border-radius: 50%; margin-right: 15px; outline: none; cursor: pointer;" />
                    <span style="font-size: 16px;">Artificial Intelligence and Applications</span>
                </div>
                <div style="border: 1px solid #dee2e6; border-radius: 4px; margin-bottom: 10px; padding: 15px; display: flex; align-items: center;">
                    <input type="checkbox" style="appearance: none; -webkit-appearance: none; width: 20px; height: 20px; border: 2px solid #ced4da; border-radius: 50%; margin-right: 15px; outline: none; cursor: pointer;" />
                    <span style="font-size: 16px;">Cybersecurity and Data Protection</span>
                </div>
            </div>
        </div>
    </div>
    <style>
        .text-custom {
            color: #002366;
        }
    </style>
</asp:Content>


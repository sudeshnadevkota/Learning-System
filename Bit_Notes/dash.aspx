<%@ Page Title="" Language="C#" MasterPageFile="~/Bit_Notes/note.Master" AutoEventWireup="true" CodeBehind="dash.aspx.cs" Inherits="Learning_System.Bit_Notes.dash" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="container " style="padding-top: 3px;">
        <asp:Button
            ID="btnHome"
            runat="server"
            Text="Go to Home"
            OnClick="btnHome_Click"
            Style="background: #002366; border: none; color: white; text-decoration: none; cursor: pointer; border-radius: 5px; width: 125px; height: 40px;" />



        <div class="text-center rounded-4 py-4">
            <img src="../slide/bit2.jpeg" class="img-fluid w-100" style="height: 350px; border-radius: 10px; object-fit: cover" />
        </div>


        <!-- Course Details -->
        <h1 class="text-custom">Bachelor of Information Technology</h1>
        <p>This degree program offers an in-depth understanding of various aspects of information technology, including software development, network management, database systems, and cybersecurity. Designed for those interested in pursuing a career in IT, this course equips students with the skills needed to tackle complex technology challenges and innovate in the IT field.</p>
        <p>Gain practical experience with the latest technologies and develop a comprehensive understanding of IT systems, programming, and data management. This program prepares students for a wide range of IT roles, providing both theoretical knowledge and hands-on skills.</p>

        <div class="container">
            <div class="row">
                <div class="col-md-8">
                    <h3 class="text-decoration-none text-custom">What You'll Learn</h3>
                    <ul class="list-group list-group-flush" style="text-decoration: none;">
                        <li class="list-group-item" style="border: none;">
                            <i class="bi bi-check-circle-fill text-primary me-2" style="text-decoration: none;"></i>
                            Develop a strong foundation in software development and programming.
                        </li>
                        <li class="list-group-item" style="border: none;">
                            <i class="bi bi-check-circle-fill text-primary me-2" style="text-decoration: none;"></i>
                            Understand network management and security protocols.
                        </li>
                        <li class="list-group-item" style="border: none;">
                            <i class="bi bi-check-circle-fill text-primary me-2" style="text-decoration: none;"></i>
                            Learn about database design, implementation, and management.
                        </li>
                        <li class="list-group-item" style="border: none;">
                            <i class="bi bi-check-circle-fill text-primary me-2" style="text-decoration: none;"></i>
                            Gain insights into systems analysis and IT project management.
                        </li>
                        <li class="list-group-item" style="border: none;">
                            <i class="bi bi-check-circle-fill text-primary me-2" style="text-decoration: none;"></i>
                            Explore emerging technologies and trends in information technology.
                        </li>
                    </ul>
                </div>
                <div class="col-md-4">
                    <h3 class="text-custom">How it helps Student</h3>
                    <blockquote class="blockquote">
                        <p class="mb-0">"The Bachelor of Information Technology program provides students with essential skills and knowledge for a successful career in the IT industry. The comprehensive curriculum and practical experience gained through this program prepare students for diverse IT roles and emerging technology challenges."</p>
                    </blockquote>
                </div>
            </div>
        </div>

        <div style="width: 100%; font-family: Arial, sans-serif;">
            <h2 class="text-custom" style="font-size: 24px; margin-bottom: 10px;">Course Content</h2>
            <h5 class="text-custom" style="font-size: 18px; margin-bottom: 20px;">Information Technology Topics</h5>
            <div>
                <div style="border: 1px solid #dee2e6; border-radius: 4px; margin-bottom: 10px; padding: 15px; display: flex; align-items: center;">
                    <input type="checkbox" style="appearance: none; -webkit-appearance: none; width: 20px; height: 20px; border: 2px solid #ced4da; border-radius: 50%; margin-right: 15px; outline: none; cursor: pointer;" />
                    <span style="font-size: 16px;">Introduction to Programming</span>
                </div>
                <div style="border: 1px solid #dee2e6; border-radius: 4px; margin-bottom: 10px; padding: 15px; display: flex; align-items: center;">
                    <input type="checkbox" style="appearance: none; -webkit-appearance: none; width: 20px; height: 20px; border: 2px solid #ced4da; border-radius: 50%; margin-right: 15px; outline: none; cursor: pointer;" />
                    <span style="font-size: 16px;">Network Management and Security</span>
                </div>
                <div style="border: 1px solid #dee2e6; border-radius: 4px; margin-bottom: 10px; padding: 15px; display: flex; align-items: center;">
                    <input type="checkbox" style="appearance: none; -webkit-appearance: none; width: 20px; height: 20px; border: 2px solid #ced4da; border-radius: 50%; margin-right: 15px; outline: none; cursor: pointer;" />
                    <span style="font-size: 16px;">Database Systems</span>
                </div>
                <div style="border: 1px solid #dee2e6; border-radius: 4px; margin-bottom: 10px; padding: 15px; display: flex; align-items: center;">
                    <input type="checkbox" style="appearance: none; -webkit-appearance: none; width: 20px; height: 20px; border: 2px solid #ced4da; border-radius: 50%; margin-right: 15px; outline: none; cursor: pointer;" />
                    <span style="font-size: 16px;">Systems Analysis and Design</span>
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


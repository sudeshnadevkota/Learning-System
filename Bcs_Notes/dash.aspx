<%@ Page Title="" Language="C#" MasterPageFile="~/Bcs_Notes/note.Master" AutoEventWireup="true" CodeBehind="dash.aspx.cs" Inherits="Learning_System.Bcs_Notes.dash" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="container " style="padding-top: 3px;">
        <asp:Button
            ID="btnHome"
            runat="server"
            Text="Go to Home"
            OnClick="btnHome_Click"
            Style="background: #002366; border: none; color: white; text-decoration: none; cursor: pointer; border-radius: 5px; width: 125px; height: 40px;" />


        <div class="text-center rounded-4 py-4">
            <img src="../slide/bcs4.png" class="img-fluid w-100" style="height: 350px; border-radius: 10px; object-fit: cover" />
        </div>

        <!-- Course Details -->
        <h1 class="text-custom">Bachelor of Cyber Security</h1>
        <p>This program provides a comprehensive understanding of cybersecurity principles, including threat analysis, risk management, and secure system design. It’s designed to equip you with the skills necessary to protect information systems and data from cyber threats.</p>
        <p>Gain insights into advanced security techniques and learn how to manage and mitigate security risks. This course provides practical knowledge and skills to excel in the rapidly evolving field of cybersecurity.</p>

        <div class="container">
            <div class="row">
                <div class="col-md-8">
                    <h3 class="text-decoration-none text-custom">What You'll Learn</h3>
                    <ul class="list-group list-group-flush" style="text-decoration: none;">
                        <li class="list-group-item" style="border: none;">
                            <i class="bi bi-check-circle-fill text-primary me-2" style="text-decoration: none;"></i>
                            Develop a deep understanding of cybersecurity concepts and practices.
                        </li>
                        <li class="list-group-item" style="border: none;">
                            <i class="bi bi-check-circle-fill text-primary me-2" style="text-decoration: none;"></i>
                            Learn about threat analysis, risk management, and incident response.
                        </li>
                        <li class="list-group-item" style="border: none;">
                            <i class="bi bi-check-circle-fill text-primary me-2" style="text-decoration: none; border: none;"></i>
                            Understand secure system design and implementation techniques.
                        </li>
                        <li class="list-group-item" style="border: none;">
                            <i class="bi bi-check-circle-fill text-primary me-2" style="text-decoration: none; border: none;"></i>
                            Explore encryption methods and secure network protocols.
                        </li>
                        <li class="list-group-item" style="border: none;">
                            <i class="bi bi-check-circle-fill text-primary me-2" style="text-decoration: none;"></i>
                            Gain practical experience in identifying and mitigating cybersecurity threats.
                        </li>
                    </ul>
                </div>
                <div class="col-md-4">
                    <h3 class="text-custom">How it helps Student</h3>
                    <blockquote class="blockquote">
                        <p class="mb-0">"This program provided students with an in-depth understanding of cybersecurity. The skills and knowledge gained have been crucial for their careers in safeguarding information systems and combating cyber threats."</p>

                    </blockquote>
                </div>
            </div>
        </div>

        <div style="width: 100%; font-family: Arial, sans-serif;">
            <h2 class="text-custom" style="font-size: 24px; margin-bottom: 10px;">Course Content</h2>
            <h5 class="text-custom" style="font-size: 18px; margin-bottom: 20px;">Cyber Security Topics</h5>
            <div>
                <div style="border: 1px solid #dee2e6; border-radius: 4px; margin-bottom: 10px; padding: 15px; display: flex; align-items: center;">
                    <input type="checkbox" style="appearance: none; -webkit-appearance: none; width: 20px; height: 20px; border: 2px solid #ced4da; border-radius: 50%; margin-right: 15px; outline: none; cursor: pointer;" />
                    <span style="font-size: 16px;">Introduction to Cyber Security</span>
                </div>
                <div style="border: 1px solid #dee2e6; border-radius: 4px; margin-bottom: 10px; padding: 15px; display: flex; align-items: center;">
                    <input type="checkbox" style="appearance: none; -webkit-appearance: none; width: 20px; height: 20px; border: 2px solid #ced4da; border-radius: 50%; margin-right: 15px; outline: none; cursor: pointer;" />
                    <span style="font-size: 16px;">Threat Analysis and Risk Management</span>
                </div>
                <div style="border: 1px solid #dee2e6; border-radius: 4px; margin-bottom: 10px; padding: 15px; display: flex; align-items: center;">
                    <input type="checkbox" style="appearance: none; -webkit-appearance: none; width: 20px; height: 20px; border: 2px solid #ced4da; border-radius: 50%; margin-right: 15px; outline: none; cursor: pointer;" />
                    <span style="font-size: 16px;">Secure System Design</span>
                </div>
                <div style="border: 1px solid #dee2e6; border-radius: 4px; margin-bottom: 10px; padding: 15px; display: flex; align-items: center;">
                    <input type="checkbox" style="appearance: none; -webkit-appearance: none; width: 20px; height: 20px; border: 2px solid #ced4da; border-radius: 50%; margin-right: 15px; outline: none; cursor: pointer;" />
                    <span style="font-size: 16px;">Network Security</span>
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


<%@ Page Title="" Language="C#" MasterPageFile="~/Past_Year_Paper/BBA/BBA.Master" AutoEventWireup="true" CodeBehind="dash.aspx.cs" Inherits="Learning_System.Past_Year_Paper.BBA.dash" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="container " style="padding-top:3px;">
        <asp:Button 
            ID="btnHome" 
            runat="server" 
            Text="Go to Home" 
            OnClick="btnHome_Click" 
            Style="background: #002366; border: none; color: white; text-decoration: none; cursor: pointer; border-radius: 5px; width: 125px; height: 40px;" 
        />

     

                        <div class="text-center rounded-4 py-4">
    <img src="../../slide/bba2.jpg" class="img-fluid w-100" style="height: 350px; border-radius: 10px; object-fit: cover" />
</div>
        
        
        <!-- Course Details -->
        <h1 class="text-custom">Business Management Essentials</h1>
        <p>This course covers key concepts in business management including strategic planning, organizational behavior, and effective leadership. It’s designed to equip you with the skills necessary to excel in managerial roles and understand business operations.</p>
        <p>Gain insights into essential business strategies and learn how to manage teams, resources, and projects efficiently. This course provides practical knowledge to apply in real-world business scenarios.</p>
        
        <div class="container">
            <div class="row">
                <div class="col-md-8">
                    <h3  class="text-decoration-none text-custom">What You'll Learn</h3>
                    <ul class="list-group list-group-flush" style="text-decoration: none;">
                        <li class="list-group-item" style="border: none;">
                            <i class="bi bi-check-circle-fill text-primary me-2" style="text-decoration: none;"></i>
                            Develop a solid understanding of business management principles.
                        </li>
                        <li class="list-group-item" style="border: none;">
                            <i class="bi bi-check-circle-fill text-primary me-2" style="text-decoration: none;"></i>
                            Learn about organizational behavior and effective team management.
                        </li>
                        <li class="list-group-item" style="border: none;">
                            <i class="bi bi-check-circle-fill text-primary me-2" style="text-decoration: none; border: none;"></i>
                            Understand strategic planning and its impact on business success.
                        </li>
                        <li class="list-group-item" style="border: none;">
                            <i class="bi bi-check-circle-fill text-primary me-2" style="text-decoration: none; border: none;"></i>
                            Explore techniques for managing operations and resources efficiently.
                        </li>
                        <li class="list-group-item" style="border: none;">
                            <i class="bi bi-check-circle-fill text-primary me-2" style="text-decoration: none;"></i>
                            Gain practical skills for addressing real-world business challenges.
                        </li>
                    </ul>
                </div>
                <div class="col-md-4">
                    <h3 class="text-custom">How it helps Student</h3>
                    <blockquote class="blockquote">
                        <p class="mb-0">"This course provided student with a comprehensive understanding of business management. The practical insights and knowledge gained have been invaluable for their career in management."</p>
                        
                    </blockquote>
                </div>
            </div>
        </div>

        <div style="width: 100%; font-family: Arial, sans-serif;">
            <h2 class="text-custom" style="font-size: 24px; margin-bottom: 10px;">Course Content</h2>
            <h5 class="text-custom"  style="font-size: 18px; margin-bottom: 20px;">Business Management Topics</h5>
            <div>
                <div style="border: 1px solid #dee2e6; border-radius: 4px; margin-bottom: 10px; padding: 15px; display: flex; align-items: center;">
                    <input type="checkbox" style="appearance: none; -webkit-appearance: none; width: 20px; height: 20px; border: 2px solid #ced4da; border-radius: 50%; margin-right: 15px; outline: none; cursor: pointer;" />
                    <span style="font-size: 16px;">Introduction to Business Management</span>
                </div>
                <div style="border: 1px solid #dee2e6; border-radius: 4px; margin-bottom: 10px; padding: 15px; display: flex; align-items: center;">
                    <input type="checkbox" style="appearance: none; -webkit-appearance: none; width: 20px; height: 20px; border: 2px solid #ced4da; border-radius: 50%; margin-right: 15px; outline: none; cursor: pointer;" />
                    <span style="font-size: 16px;">Organizational Behavior</span>
                </div>
                <div style="border: 1px solid #dee2e6; border-radius: 4px; margin-bottom: 10px; padding: 15px; display: flex; align-items: center;">
                    <input type="checkbox" style="appearance: none; -webkit-appearance: none; width: 20px; height: 20px; border: 2px solid #ced4da; border-radius: 50%; margin-right: 15px; outline: none; cursor: pointer;" />
                    <span style="font-size: 16px;">Strategic Planning</span>
                </div>
                <div style="border: 1px solid #dee2e6; border-radius: 4px; margin-bottom: 10px; padding: 15px; display: flex; align-items: center;">
                    <input type="checkbox" style="appearance: none; -webkit-appearance: none; width: 20px; height: 20px; border: 2px solid #ced4da; border-radius: 50%; margin-right: 15px; outline: none; cursor: pointer;" />
                    <span style="font-size: 16px;">Operations Management</span>
                </div>
            </div>
        </div>
    </div>
    <style>
        .text-custom{
            color:#002366;
        }
    </style>
</asp:Content>

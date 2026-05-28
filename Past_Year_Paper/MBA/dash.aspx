<%@ Page Title="" Language="C#" MasterPageFile="~/Past_Year_Paper/MBA/MBA.Master" AutoEventWireup="true" CodeBehind="dash.aspx.cs" Inherits="Learning_System.Past_Year_Paper.MBA.dash" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="container" style="padding-top:3px;">
        <asp:Button 
            ID="btnHome" 
            runat="server" 
            Text="Go to Home" 
            OnClick="btnHome_Click" 
            Style="background: #002366; border: none; color: white; text-decoration: none; cursor: pointer; border-radius: 5px; width: 125px; height: 40px;" 
        />

        <!-- Image Section -->
  

          <div class="text-center rounded-4 py-4">
      <img src="../../slide/mba5.jpg" class="img-fluid w-100" style="height: 350px; border-radius: 10px; object-fit: cover" />
  </div>
        
        <!-- Course Details -->
        <h1 class="text-custom">Master of Business Administration (MBA)</h1>
        <p>The Master of Business Administration (MBA) program is designed to provide a comprehensive understanding of business management and leadership. This advanced degree covers a broad range of business disciplines, including finance, marketing, operations, and strategic management. Ideal for professionals aiming to advance their careers, the MBA program equips students with the skills and knowledge needed to excel in executive and managerial roles.</p>
        <p>Enhance your strategic thinking, leadership abilities, and decision-making skills while gaining practical experience through case studies and real-world projects. This program prepares you to lead organizations effectively and drive business success.</p>
        
        <div class="container">
            <div class="row">
                <div class="col-md-8">
                    <h3 class="text-decoration-none text-custom">What You'll Learn</h3>
                    <ul class="list-group list-group-flush" style="text-decoration: none;">
                        <li class="list-group-item" style="border: none;">
                            <i class="bi bi-check-circle-fill text-primary me-2" style="text-decoration: none;"></i>
                            Develop advanced leadership and management skills.
                        </li>
                        <li class="list-group-item" style="border: none;">
                            <i class="bi bi-check-circle-fill text-primary me-2" style="text-decoration: none;"></i>
                            Gain expertise in strategic planning and business analysis.
                        </li>
                        <li class="list-group-item" style="border: none;">
                            <i class="bi bi-check-circle-fill text-primary me-2" style="text-decoration: none;"></i>
                            Understand financial management and economic strategies.
                        </li>
                        <li class="list-group-item" style="border: none;">
                            <i class="bi bi-check-circle-fill text-primary me-2" style="text-decoration: none;"></i>
                            Learn about marketing strategies and consumer behavior.
                        </li>
                        <li class="list-group-item" style="border: none;">
                            <i class="bi bi-check-circle-fill text-primary me-2" style="text-decoration: none;"></i>
                            Explore operations management and organizational behavior.
                        </li>
                    </ul>
                </div>
                <div class="col-md-4">
                    <h3 class="text-custom">How it helps Students</h3>
                    <blockquote class="blockquote">
                        <p class="mb-0">"The MBA program provided students with an in-depth understanding of business management principles and practices. The comprehensive curriculum and practical experience gained through this program have significantly enhanced their leadership and strategic decision-making capabilities."</p>
                    </blockquote>
                </div>
            </div>
        </div>

        <div style="width: 100%; font-family: Arial, sans-serif;">
            <h2 class="text-custom" style="font-size: 24px; margin-bottom: 10px;">Course Content</h2>
            <h5 class="text-custom" style="font-size: 18px; margin-bottom: 20px;">MBA Core Topics</h5>
            <div>
                <div style="border: 1px solid #dee2e6; border-radius: 4px; margin-bottom: 10px; padding: 15px; display: flex; align-items: center;">
                    <input type="checkbox" style="appearance: none; -webkit-appearance: none; width: 20px; height: 20px; border: 2px solid #ced4da; border-radius: 50%; margin-right: 15px; outline: none; cursor: pointer;" />
                    <span style="font-size: 16px;">Advanced Leadership and Management</span>
                </div>
                <div style="border: 1px solid #dee2e6; border-radius: 4px; margin-bottom: 10px; padding: 15px; display: flex; align-items: center;">
                    <input type="checkbox" style="appearance: none; -webkit-appearance: none; width: 20px; height: 20px; border: 2px solid #ced4da; border-radius: 50%; margin-right: 15px; outline: none; cursor: pointer;" />
                    <span style="font-size: 16px;">Strategic Planning and Business Analysis</span>
                </div>
                <div style="border: 1px solid #dee2e6; border-radius: 4px; margin-bottom: 10px; padding: 15px; display: flex; align-items: center;">
                    <input type="checkbox" style="appearance: none; -webkit-appearance: none; width: 20px; height: 20px; border: 2px solid #ced4da; border-radius: 50%; margin-right: 15px; outline: none; cursor: pointer;" />
                    <span style="font-size: 16px;">Financial Management</span>
                </div>
                <div style="border: 1px solid #dee2e6; border-radius: 4px; margin-bottom: 10px; padding: 15px; display: flex; align-items: center;">
                    <input type="checkbox" style="appearance: none; -webkit-appearance: none; width: 20px; height: 20px; border: 2px solid #ced4da; border-radius: 50%; margin-right: 15px; outline: none; cursor: pointer;" />
                    <span style="font-size: 16px;">Marketing Strategies and Consumer Behavior</span>
                </div>
                <div style="border: 1px solid #dee2e6; border-radius: 4px; margin-bottom: 10px; padding: 15px; display: flex; align-items: center;">
                    <input type="checkbox" style="appearance: none; -webkit-appearance: none; width: 20px; height: 20px; border: 2px solid #ced4da; border-radius: 50%; margin-right: 15px; outline: none; cursor: pointer;" />
                    <span style="font-size: 16px;">Operations Management and Organizational Behavior</span>
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


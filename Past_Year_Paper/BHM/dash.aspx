<%@ Page Title="" Language="C#" MasterPageFile="~/Past_Year_Paper/BHM/BHM.Master" AutoEventWireup="true" CodeBehind="dash.aspx.cs" Inherits="Learning_System.Past_Year_Paper.BHM.dash" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="container " style="padding-top:3px;">
        <asp:Button 
            ID="btnHome" 
            runat="server" 
            Text="Go to Home" 
            OnClick="btnHome_Click" 
            Style="background: #002366; border: none; color: white; text-decoration: none; cursor: pointer; border-radius: 5px; width: 125px; height: 40px;" 
        />

        <!-- Image Section -->
     
                        <div class="text-center rounded-4 py-4">
    <img src="../../slide/bhm4.jpg" class="img-fluid w-100" style="height: 350px; border-radius: 10px; object-fit: cover" />
</div>
        
        <!-- Course Details -->
        <h1 class="text-custom">Bachelor of Hospitality Management</h1>
        <p>This degree program provides comprehensive training in hospitality management, covering essential aspects such as hotel operations, food and beverage management, and event planning. Designed for those aspiring to excel in the hospitality industry, this course equips students with the skills and knowledge needed for effective management and exceptional guest service.</p>
        <p>Explore the intricacies of managing hospitality operations, delivering high-quality guest experiences, and leading teams in a fast-paced environment. This program offers a blend of theoretical knowledge and practical experience to prepare students for successful careers in hospitality management.</p>
        
        <div class="container">
            <div class="row">
                <div class="col-md-8">
                    <h3 class="text-decoration-none text-custom">What You'll Learn</h3>
                    <ul class="list-group list-group-flush" style="text-decoration: none;">
                        <li class="list-group-item" style="border: none;">
                            <i class="bi bi-check-circle-fill text-primary me-2" style="text-decoration: none;"></i>
                            Acquire a strong foundation in hospitality management principles.
                        </li>
                        <li class="list-group-item" style="border: none;">
                            <i class="bi bi-check-circle-fill text-primary me-2" style="text-decoration: none;"></i>
                            Understand the dynamics of hotel and restaurant operations.
                        </li>
                        <li class="list-group-item" style="border: none;">
                            <i class="bi bi-check-circle-fill text-primary me-2" style="text-decoration: none;"></i>
                            Learn effective event planning and coordination techniques.
                        </li>
                        <li class="list-group-item" style="border: none;">
                            <i class="bi bi-check-circle-fill text-primary me-2" style="text-decoration: none;"></i>
                            Develop skills in customer service and guest relations.
                        </li>
                        <li class="list-group-item" style="border: none;">
                            <i class="bi bi-check-circle-fill text-primary me-2" style="text-decoration: none;"></i>
                            Gain insights into managing and leading teams within the hospitality industry.
                        </li>
                    </ul>
                </div>
                <div class="col-md-4">
                    <h3 class="text-custom">How it helps Student</h3>
                    <blockquote class="blockquote">
                        <p class="mb-0">"The Bachelor of Hospitality Management program has equipped students with essential skills and knowledge to thrive in the hospitality industry. The practical training and comprehensive curriculum provide a strong foundation for a successful career in hospitality management."</p>
                    </blockquote>
                </div>
            </div>
        </div>

        <div style="width: 100%; font-family: Arial, sans-serif;">
            <h2 class="text-custom" style="font-size: 24px; margin-bottom: 10px;">Course Content</h2>
            <h5 class="text-custom" style="font-size: 18px; margin-bottom: 20px;">Hospitality Management Topics</h5>
            <div>
                <div style="border: 1px solid #dee2e6; border-radius: 4px; margin-bottom: 10px; padding: 15px; display: flex; align-items: center;">
                    <input type="checkbox" style="appearance: none; -webkit-appearance: none; width: 20px; height: 20px; border: 2px solid #ced4da; border-radius: 50%; margin-right: 15px; outline: none; cursor: pointer;" />
                    <span style="font-size: 16px;">Introduction to Hospitality Management</span>
                </div>
                <div style="border: 1px solid #dee2e6; border-radius: 4px; margin-bottom: 10px; padding: 15px; display: flex; align-items: center;">
                    <input type="checkbox" style="appearance: none; -webkit-appearance: none; width: 20px; height: 20px; border: 2px solid #ced4da; border-radius: 50%; margin-right: 15px; outline: none; cursor: pointer;" />
                    <span style="font-size: 16px;">Hotel and Restaurant Operations</span>
                </div>
                <div style="border: 1px solid #dee2e6; border-radius: 4px; margin-bottom: 10px; padding: 15px; display: flex; align-items: center;">
                    <input type="checkbox" style="appearance: none; -webkit-appearance: none; width: 20px; height: 20px; border: 2px solid #ced4da; border-radius: 50%; margin-right: 15px; outline: none; cursor: pointer;" />
                    <span style="font-size: 16px;">Event Planning and Management</span>
                </div>
                <div style="border: 1px solid #dee2e6; border-radius: 4px; margin-bottom: 10px; padding: 15px; display: flex; align-items: center;">
                    <input type="checkbox" style="appearance: none; -webkit-appearance: none; width: 20px; height: 20px; border: 2px solid #ced4da; border-radius: 50%; margin-right: 15px; outline: none; cursor: pointer;" />
                    <span style="font-size: 16px;">Customer Service and Guest Relations</span>
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

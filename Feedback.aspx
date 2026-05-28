<%@ Page Title="Feedback" Language="C#" MasterPageFile="~/learning.Master"
AutoEventWireup="true" CodeBehind="Feedback.aspx.cs"
Inherits="Learning_System.Feedback" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

<style>

    body {
        background: linear-gradient(135deg, #dbeafe, #eff6ff, #bfdbfe);
        font-family: 'Segoe UI', sans-serif;
    }

    .feedback-section {
        min-height: 100vh;
        display: flex;
        justify-content: center;
        align-items: center;
        padding: 40px 15px;
    }

    .feedback-card {
        width: 100%;
        max-width: 700px;
        background: rgba(255,255,255,0.75);
        backdrop-filter: blur(15px);
        border-radius: 24px;
        padding: 40px;
        box-shadow: 0 20px 50px rgba(0,0,0,0.15);
        border: 1px solid rgba(255,255,255,0.4);
        animation: fadeIn 0.5s ease;
    }

    @keyframes fadeIn {
        from {
            opacity: 0;
            transform: translateY(20px);
        }

        to {
            opacity: 1;
            transform: translateY(0);
        }
    }

    .feedback-title {
        font-size: 34px;
        font-weight: 700;
        color: #1d4ed8;
        text-align: center;
        margin-bottom: 10px;
    }

    .feedback-subtitle {
        text-align: center;
        color: #6b7280;
        margin-bottom: 35px;
        font-size: 15px;
    }

    .input-group-modern {
        margin-bottom: 20px;
    }

    .input-label {
        display: block;
        margin-bottom: 8px;
        font-weight: 600;
        color: #374151;
    }

    .modern-input {
        width: 100%;
        padding: 14px 16px;
        border-radius: 14px;
        border: 1px solid #d1d5db;
        background: rgba(255,255,255,0.9);
        font-size: 15px;
        outline: none;
        transition: all 0.3s ease;
        box-sizing: border-box;
    }

    .modern-input:focus {
        border-color: #2563eb;
        box-shadow: 0 0 15px rgba(37,99,235,0.25);
        transform: translateY(-2px);
    }

    /* ⭐ Rating */

    .rating-box {
        margin-top: 10px;
    }

    .rating {
        direction: rtl;
        unicode-bidi: bidi-override;
        display: inline-flex;
        gap: 10px;
    }

    .rating input {
        display: none;
    }

    .rating label {
        font-size: 42px;
        color: #d1d5db;
        cursor: pointer;
        transition: all 0.25s ease;
    }

    .rating label:hover,
    .rating label:hover ~ label {
        color: #fbbf24;
        transform: scale(1.25) rotate(-5deg);
        text-shadow: 0 0 15px rgba(251,191,36,0.8);
    }

    .rating input:checked ~ label {
        color: #f59e0b;
        text-shadow: 0 0 15px rgba(245,158,11,0.9);
    }

    /* 🚀 Submit Button */

    .submit-btn {
        width: 100%;
        padding: 15px;
        border: none;
        border-radius: 14px;
        background: linear-gradient(135deg, #2563eb, #1d4ed8);
        color: white;
        font-size: 16px;
        font-weight: 600;
        cursor: pointer;
        transition: all 0.3s ease;
        margin-top: 10px;
    }

    .submit-btn:hover {
        transform: translateY(-3px);
        box-shadow: 0 15px 25px rgba(37,99,235,0.35);
    }

    .submit-btn:active {
        transform: scale(0.98);
    }

    @media(max-width:768px) {

        .feedback-card {
            padding: 25px;
        }

        .feedback-title {
            font-size: 28px;
        }

        .rating label {
            font-size: 34px;
        }
    }

</style>

<div class="feedback-section">

    <div class="feedback-card">

        <div class="feedback-title">
            We Value Your Feedback
        </div>

        <div class="feedback-subtitle">
            Your opinion helps us improve our learning system 🚀
        </div>

        <!-- Name -->
        <div class="input-group-modern">
            <label class="input-label">Full Name</label>

            <asp:TextBox ID="txtName" runat="server"
                CssClass="modern-input"
                Placeholder="Enter your full name">
            </asp:TextBox>
        </div>

        <!-- Email -->
        <div class="input-group-modern">
            <label class="input-label">Email Address</label>

            <asp:TextBox ID="txtEmail" runat="server"
                CssClass="modern-input"
                TextMode="Email"
                Placeholder="Enter your email">
            </asp:TextBox>
        </div>

        <!-- Phone -->
        <div class="input-group-modern">
            <label class="input-label">Phone Number</label>

            <asp:TextBox ID="txtPhone" runat="server"
                CssClass="modern-input"
                Placeholder="Enter your phone number">
            </asp:TextBox>
        </div>

        <!-- Rating -->
        <div class="input-group-modern rating-box">

            <label class="input-label">Rate Your Experience</label>

            <div class="rating">

                <input type="radio" id="star5" name="rating" value="5" />
                <label for="star5">★</label>

                <input type="radio" id="star4" name="rating" value="4" />
                <label for="star4">★</label>

                <input type="radio" id="star3" name="rating" value="3" />
                <label for="star3">★</label>

                <input type="radio" id="star2" name="rating" value="2" />
                <label for="star2">★</label>

                <input type="radio" id="star1" name="rating" value="1" />
                <label for="star1">★</label>

            </div>

        </div>

        <!-- Message -->
        <div class="input-group-modern">

            <label class="input-label">Your Feedback</label>

            <asp:TextBox ID="txtMessage" runat="server"
                CssClass="modern-input"
                TextMode="MultiLine"
                Rows="5"
                Placeholder="Write your feedback here...">
            </asp:TextBox>

        </div>

        <!-- Submit Button -->
        <asp:Button ID="submitButton" runat="server"
            CssClass="submit-btn"
            Text="Submit Feedback"
            OnClick="SubmitButton_Click" />

    </div>

</div>

</asp:Content>
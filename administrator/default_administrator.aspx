<%@ Page Title="Dashboard" Language="C#" MasterPageFile="~/administrator/administrator_master.Master"
    AutoEventWireup="true"
    CodeBehind="default_administrator.aspx.cs"
    Inherits="Learning_System.administrator.default_administrator" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

<!-- Chart JS -->
<script src="https://cdn.jsdelivr.net/npm/chart.js@4.4.1/dist/chart.umd.min.js"></script>

<style>
    :root {
        --primary: #0B1F66;
        --secondary: #081547;
        --pink: #FF2D8D;
        --yellow: #F6B400;
    }

    body {
        background: #f6f8fb;
    }

    /* ================= CARD ================= */
    .dashboard-card {
        border: none;
        border-radius: 18px;
        transition: 0.3s ease;
        overflow: hidden;
        box-shadow: 0 6px 18px rgba(0,0,0,0.06);
    }

    .dashboard-card:hover {
        transform: translateY(-5px);
    }

    .card-primary { background: linear-gradient(135deg, #0B1F66, #1e3a8a); }
    .card-success { background: linear-gradient(135deg, #FF2D8D, #ff5aa3); }
    .card-warning { background: linear-gradient(135deg, #F6B400, #fbbf24); color: #000; }
    .card-accent{ background: linear-gradient(135deg, #0B1F66, #1e3a8a); }
    .stat-number {
        font-size: 2.2rem;
        font-weight: 700;
    }

    /* ================= CHART ================= */
    .chart-card {
        border-radius: 18px;
        border: none;
        box-shadow: 0 8px 25px rgba(0,0,0,0.05);
    }

    .chart-container {
        position: relative;
        height: 340px;
        width: 100%;
    }

    /* ================= LIST ================= */
    .list-group-item {
        border: none;
        border-bottom: 1px solid #eee;
    }

    /* ================= HEADER ================= */
    .dashboard-header {
        display: flex;
        justify-content: space-between;
        align-items: center;
        margin-bottom: 20px;
    }

    /* ================= RESPONSIVE ================= */

    @media (max-width: 992px) {
        .chart-container {
            height: 280px;
        }
    }

    @media (max-width: 768px) {

        .dashboard-header {
            flex-direction: column;
            align-items: flex-start;
            gap: 12px;
        }

        .dashboard-header button {
            width: 100%;
        }

        .stat-number {
            font-size: 1.7rem;
        }

        .dashboard-card .card-body {
            padding: 50px;
        }

        .chart-container {
            height: 250px;
        }
    }

    @media (max-width: 576px) {

        .chart-container {
            height: 220px;
        }

        .dashboard-card {
            border-radius: 14px;
        }

        .stat-number {
            font-size: 1.5rem;
        }

        .dashboard-card i {
            font-size: 2rem !important;
        }

        .btn {
            width: 100%;
        }
    }

</style>

<!-- ================= HEADER ================= -->
<div class="dashboard-header">
    <div>
        <h2 class="fw-bold mb-1">Dashboard</h2>
        <p class="text-muted mb-0">
            Welcome Back,
            <asp:Label ID="lblUserName" runat="server" CssClass="fw-semibold"></asp:Label>
        </p>
    </div>

    <div>
        <button class="btn btn-primary px-4 py-2 rounded-pill">
            <i class="bi bi-download me-2"></i>Export Report
        </button>
    </div>
</div>

<!-- ================= STATS ================= -->
<div class="row g-3 mb-4">

<div class="col-lg-2 col-md-4 col-6">
        <div class="card dashboard-card card-primary text-white">
            <div class="card-body p-2">
                <i class="bi bi-people fs-1 opacity-75"></i>
                <h3 class="stat-number mt-3">0</h3>
                <p>Total Users</p>
            </div>
        </div>
    </div>

    <div class="col-lg-2 col-md-4 col-6">
        <div class="card dashboard-card card-success text-white">
            <div class="card-body p-2">
                <i class="bi bi-book fs-1 opacity-75"></i>
                <h3 class="stat-number mt-3">0</h3>
                <p>Active Courses</p>
            </div>
        </div>
    </div>

    <div class="col-lg-2 col-md-4 col-6">
        <div class="card dashboard-card card-warning">
            <div class="card-body p-2">
                <i class="bi bi-mortarboard fs-1 opacity-75"></i>
                <h3 class="stat-number mt-3">0</h3>
                <p>Active Learners</p>
            </div>
        </div>
    </div>

   <div class="col-lg-2 col-md-4 col-6">
        <div class="card dashboard-card card-accent text-white">
            <div class="card-body p-2">
                <i class="bi bi-graph-up fs-1 opacity-75"></i>
                <h3 class="stat-number mt-3">0</h3>
                <p>Avg Completion</p>
            </div>
        </div>
    </div>

</div>

<!-- ================= CHART + ACTIVITY ================= -->
<div class="row">

    <!-- CHART -->
    <div class="col-lg-8 col-12 mb-4">
        <div class="card chart-card">
            <div class="card-header bg-white border-0">
                <h5 class="mb-0">User Growth Analytics</h5>
            </div>

            <div class="card-body">
                <div class="chart-container">
                    <canvas id="userChart"></canvas>
                </div>
            </div>
        </div>
    </div>

    <!-- ACTIVITY -->
    <div class="col-lg-4 col-12">
        <div class="card chart-card h-100">
            <div class="card-header bg-white border-0">
                <h5 class="mb-0">Recent Activities</h5>
            </div>

            <div class="card-body p-0">
                <ul class="list-group list-group-flush">

                    <li class="list-group-item">
                        <strong>New user registered</strong><br>
                        <small class="text-muted">Rahul Sharma • 2 hours ago</small>
                    </li>

                    <li class="list-group-item">
                        <strong>New course published</strong><br>
                        <small class="text-muted">Digital Marketing • 5 hours ago</small>
                    </li>

                    <li class="list-group-item">
                        <strong>Course completed</strong><br>
                        <small class="text-muted">UI/UX Design • Yesterday</small>
                    </li>

                    <li class="list-group-item">
                        <strong>System maintenance completed</strong><br>
                        <small class="text-muted">Today 9:00 AM</small>
                    </li>

                </ul>
            </div>
        </div>
    </div>

</div>

<!-- ================= CHART SCRIPT ================= -->
<script>
window.addEventListener('load', function () {
    const ctx = document.getElementById('userChart');

    new Chart(ctx, {
        type: 'line',
        data: {
            labels: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun'],
            datasets: [{
                label: 'New Users',
                data: [120, 190, 150, 220, 280, 310],
                borderColor: '#0B1F66',
                backgroundColor: 'rgba(11, 31, 102, 0.08)',
                fill: true,
                tension: 0.4,
                borderWidth: 3,
                pointRadius: 4
            }]
        },
        options: {
            responsive: true,
            maintainAspectRatio: false,
            plugins: {
                legend: { display: false }
            },
            scales: {
                y: { beginAtZero: true },
                x: {}
            }
        }
    });
});
</script>

</asp:Content>
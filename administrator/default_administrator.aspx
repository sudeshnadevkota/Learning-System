<%@ Page Title="Dashboard" Language="C#" MasterPageFile="~/administrator/administrator_master.Master"
    AutoEventWireup="true"
    CodeBehind="default_administrator.aspx.cs"
    Inherits="Learning_System.administrator.default_administrator" %>

<asp:Content ID="Content1"
    ContentPlaceHolderID="ContentPlaceHolder1"
    runat="server">

    <!-- Chart JS -->
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

    <style>

        .dashboard-card {
            border: none;
            border-radius: 18px;
            transition: 0.3s;
        }

        .dashboard-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 12px 20px rgba(0,0,0,0.1);
        }

        .chart-card {
            border-radius: 18px;
            border: none;
        }

        .chart-container {
            position: relative;
            height: 350px;
        }

    </style>

    <!-- Heading -->
    <div class="d-flex justify-content-between align-items-center mb-4">

        <div>
            <h2 class="fw-bold">Dashboard</h2>

            <p class="text-muted">
                Welcome Back,
                <asp:Label ID="lblUserName"
                    runat="server"></asp:Label>
            </p>
        </div>

    </div>

    <!-- Statistics -->
    <div class="row g-4 mb-4">

        <div class="col-lg-3 col-md-6">

            <div class="card dashboard-card bg-primary text-white">

                <div class="card-body">

                    <i class="bi bi-people fs-1"></i>

                    <h3 class="mt-3">1,248</h3>

                    <p>Total Users</p>

                </div>

            </div>

        </div>

        <div class="col-lg-3 col-md-6">

            <div class="card dashboard-card bg-success text-white">

                <div class="card-body">

                    <i class="bi bi-book fs-1"></i>

                    <h3 class="mt-3">87</h3>

                    <p>Courses</p>

                </div>

            </div>

        </div>

        <div class="col-lg-3 col-md-6">

            <div class="card dashboard-card bg-warning text-white">

                <div class="card-body">

                    <i class="bi bi-mortarboard fs-1"></i>

                    <h3 class="mt-3">682</h3>

                    <p>Learners</p>

                </div>

            </div>

        </div>

        <div class="col-lg-3 col-md-6">

            <div class="card dashboard-card bg-info text-white">

                <div class="card-body">

                    <i class="bi bi-graph-up"></i>

                    <h3 class="mt-3">74%</h3>

                    <p>Completion Rate</p>

                </div>

            </div>

        </div>

    </div>

    <!-- Charts -->
    <div class="row">

        <div class="col-lg-8 mb-4">

            <div class="card chart-card shadow-sm">

                <div class="card-header bg-white">
                    <h5>User Growth Analytics</h5>
                </div>

                <div class="card-body">

                    <div class="chart-container">

                        <canvas id="userChart"></canvas>

                    </div>

                </div>

            </div>

        </div>

        <div class="col-lg-4">

            <div class="card shadow-sm border-0 h-100">

                <div class="card-header bg-white">
                    <h5>Recent Activities</h5>
                </div>

                <div class="card-body">

                    <ul class="list-group list-group-flush">

                        <li class="list-group-item">
                            New user registered
                        </li>

                        <li class="list-group-item">
                            New course published
                        </li>

                        <li class="list-group-item">
                            Course completed successfully
                        </li>

                        <li class="list-group-item">
                            System updated
                        </li>

                    </ul>

                </div>

            </div>

        </div>

    </div>

    <script>

window.addEventListener('load', function () {

    const ctx =
        document.getElementById('userChart');

    new Chart(ctx, {

        type: 'line',

        data: {

            labels:
                ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun'],

            datasets: [{

                label: 'Users',

                data:
                    [120, 190, 150, 220, 280, 310],

                borderColor: '#0d6efd',

                backgroundColor:
                    'rgba(13,110,253,0.1)',

                fill: true,

                tension: 0.4,

                borderWidth: 3

            }]
        },

        options: {

            responsive: true,

            maintainAspectRatio: false,

            plugins: {

                legend: {
                    display: false
                }

            },

            scales: {

                y: {
                    beginAtZero: true
                }

            }

        }

    });

});

</script>

</asp:Content>
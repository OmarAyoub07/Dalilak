﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ManageUsers.aspx.cs" Inherits="DalilakWeb.Views.Dashboard.ManageUsers" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8" />

        <!-- ================= Favicon ================== -->
    <!-- Styles -->
    <link href="../../assets/css/lib/calendar2/pignose.calendar.min.css" rel="stylesheet"/>
    <link href="../../assets/css/lib/chartist/chartist.min.css" rel="stylesheet"/>
    <link href="../../assets/css/lib/font-awesome.min.css" rel="stylesheet"/>
    <link href="../../assets/css/lib/themify-icons.css" rel="stylesheet"/>
    <link href="../../assets/css/lib/owl.carousel.min.css" rel="stylesheet" />
    <link href="../../assets/css/lib/owl.theme.default.min.css" rel="stylesheet" />
    <link href="../../assets/css/lib/weather-icons.css" rel="stylesheet" />
    <link href="../../assets/css/lib/menubar/sidebar.css" rel="stylesheet"/>
    <link href="../../assets/css/lib/bootstrap.min.css" rel="stylesheet"/>
    <link href="../../assets/css/lib/helper.css" rel="stylesheet"/>
    <link href="../../assets/css/style_dp.css" rel="stylesheet"/>
    <title>Manage Users</title>
</head>
<body>
    <form runat="server">

    <div class="sidebar sidebar-hide-to-small sidebar-shrink sidebar-gestures">
        <div class="nano">
            <div class="nano-content">
                <ul>
                    <div class="logo"><a href="index.html"><span>Dalilak.Pro</span></a></div>

                    <li class="label">Dashboard</li>
                    <li><a class="sidebar-sub-toggle"><i class="ti-bar-chart-alt"></i> System Summary</a>
                        
                    </li>

                    <li class="label">Managing System</li>


                     <li><a class="sidebar-sub-toggle"><i class="ti-panel"></i> Manage Users </a>
                    </li>

                    <li><a href="app-event-calender.html"><i class="ti-calendar"></i> Manage Places </a></li>
                    <li><a href="app-profile.html"><i class="ti-files"></i> Requests <span class="badge badge-primary">2</span></a></li>
                    <li><a href="app-email.html"><i class="ti-email"></i> Email-Reports</a></li>
    
                    <li><a><i class="ti-close"></i> Logout</a></li>
                </ul>
            </div>
        </div>
    </div>
    <!-- /# sidebar -->

      <div class="header">
        <div class="container-fluid">
            <div class="row">
                <div class="col-lg-12">
                    <div class="float-left">
                        <div class="hamburger sidebar-toggle">
                            <span class="line"></span>
                            <span class="line"></span>
                            <span class="line"></span>
                        </div>
                    </div>
                    <div class="float-right">
                        <div class="dropdown dib">
                            <div class="header-icon" data-toggle="dropdown">
                                <span class="user-avatar" id="lbl_admin" runat="server"></span>

                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

<div class="content-wrap">
        <div class="main">
            <div class="container-fluid">
                <div class="row">
                    <div class="col-lg-8 p-r-0 title-margin-right">
                        <div class="page-header">
                            <div class="page-title">
                                <h1>Manage Users</h1>
                            </div>
                        </div>
                    </div>
                    </div>
                <section id="main-content">
                    <div class="row">
                        
                            <div class="card">
                                <div class="card-title">
                                    <h4>Table Basic </h4>
                                    
                                </div>
                                <div class="card-body">
                <asp:DataList ID="users_list" runat="server"> 
                    <ItemTemplate>
                         
                        <div class="table-responsive">
                                        <table class="table">
                             <tr>  
                        <td>  
                            <b>ID: </b><span class="city"><%# Eval("ID") %></span><br />  
                            <b>Name: </b><span class="postal"><%# Eval("Name") %></span><br />  
                            <b>Email: </b><span class="country"><%# Eval("Email")%></span><br />  
                        </td>  
                    </tr>
                                            </table>
                                            </div>
                    </ItemTemplate>
                </asp:DataList>
</div>
                                </div>
                        </div>
                    </section>
                </div>
            </div>
    </div>
</form>
     <!-- jquery vendor -->
    <script src="../../assets/js/lib/jquery.min.js"></script>
    <script src="../../assets/js/lib/jquery.nanoscroller.min.js"></script>
    <!-- nano scroller -->
    <script src="../../assets/js/lib/menubar/sidebar.js"></script>
    <script src="../../assets/js/lib/preloader/pace.min.js"></script>
    <!-- sidebar -->

    <script src="../../assets/js/lib/bootstrap.min.js"></script>
    <script src="../../assets/js/scripts.js"></script>
    <!-- bootstrap -->

    <script src="../../assets/js/lib/calendar-2/moment.latest.min.js"></script>
    <script src="../../assets/js/lib/calendar-2/pignose.calendar.min.js"></script>
    <script src="../../assets/js/lib/calendar-2/pignose.init.js"></script>


    <script src="../../assets/js/lib/weather/jquery.simpleWeather.min.js"></script>
    <script src="../../assets/js/lib/weather/weather-init.js"></script>
    <script src="../../assets/js/lib/circle-progress/circle-progress.min.js"></script>
    <script src="../../assets/js/lib/circle-progress/circle-progress-init.js"></script>
    <script src="../../assets/js/lib/chartist/chartist.min.js"></script>
    <script src="../../assets/js/lib/sparklinechart/jquery.sparkline.min.js"></script>
    <script src="../../assets/js/lib/sparklinechart/sparkline.init.js"></script>
    <script src="../../assets/js/lib/owl-carousel/owl.carousel.min.js"></script>
    <script src="../../assets/js/lib/owl-carousel/owl.carousel-init.js"></script>
    <!-- scripit init-->
    <script src="../../assets/js/dashboard2.js"></script>
</body>
</html>

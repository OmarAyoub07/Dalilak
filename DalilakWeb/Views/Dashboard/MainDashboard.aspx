<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="MainDashboard.aspx.cs" Inherits="DalilakWeb.Views.Dashboard.MainDashboard" Async="true" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8" />

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
    <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.9.4/Chart.js"></script>

    <title>Dashboard</title>
</head>
<body>

<form runat="server">

        <%-- side navigation bar from focus template (the design changed to meet the system requirments) --%>
    <div class="sidebar sidebar-hide-to-small sidebar-shrink sidebar-gestures">
        <div class="nano">
            <div class="nano-content">

                <%-- nvigation list Items --%>
                <ul>
                    <div class="logo"><a href="http://dalilak.pro"><span>Dalilak.Pro</span></a></div>

                    <li class="label">Dashboard</li>

                    <li><a href="#"><i class="ti-bar-chart-alt"></i> System Summary </a></li>

                    <li class="label">Managing System</li>

                    <li><a runat="server" href="~//Users"><i class="ti-panel"></i> Manage Users </a></li>

                    <li><a runat="server" href="~//Places"><i class="ti-calendar"></i> Manage Places </a></li>

                    <li><a runat="server" href="~//Requests"><i class="ti-files"></i> Requests <span class="badge badge-primary"><%=totals[4]%></span></a></li>

                    <li><a href="mailto: dalilak526@gmail.com"><i class="ti-email"></i> Email-Reports</a></li>
    
                    <li><asp:LinkButton runat="server" OnClick="logOut"><i class="ti-close"></i> Logout</asp:LinkButton></li>
                </ul>

            </div>
        </div>
    </div>
    <!-- /# end of sidebar -->

        <%-- Header --%>
      <div class="header">
        <div class="container-fluid">

            <div class="row">

                <div class="col-lg-12">


                    <%-- Click on lines to show or hide the sidebar --%>
                    <div class="float-left">
                        <div class="hamburger sidebar-toggle">
                            <span class="line"></span>
                            <span class="line"></span>
                            <span class="line"></span>
                        </div>
                    </div>

                    <%-- Label to hold the email of logined account --%>
                    <div class="float-right">
                        <div class="dropdown dib">
                            <div class="header-icon" data-toggle="dropdown">
                                <%-- in the server side apply this concept {lbl_admin.text = logined email} to display logined email --%>
                                <span class="user-avatar" id="lbl_admin" runat="server"></span>
                            </div>
                        </div>
                    </div>


                </div>
                <%-- / Column End --%>
            </div>
            <%-- /Row End --%>
        </div>
    </div>
        <%-- / End of Header --%>


<div class="content-wrap">
        <div class="main">
            <div class="container-fluid">

                <div class="row"> <!--Header Row-->
                    <div class="col-lg-8 p-r-0 title-margin-right">
                        <div class="page-header">
                            <div class="page-title">
                                <h1>System Summary</h1>
                            </div>
                        </div>
                    </div>
                    </div> <!-- / End Header Row -->

                <section id="main-content">

                    <div class="row"> <!-- Row of 4 Boxes, that show the total of users, guiders, places and cities -->

                        <div class="col-lg-3"> <!-- Box 1 -->
                            <div class="card">
                                <div class="stat-widget-one">
                                    <div class="stat-icon dib"><i class="ti-user"></i>
                                    </div>
                                    <div class="stat-content dib">
                                        <div class="stat-text">Tourists</div>
                                        <div class="stat-digit"><%=totals[0]%></div>
                                    </div>
                                </div>
                            </div>
                        </div> <!-- /End of Box 1-->

                        <div class="col-lg-3"><!-- Box 2 -->
                            <div class="card">
                                <div class="stat-widget-one">
                                    <div class="stat-icon dib"><i class="ti-map-alt color-primary border-primary"></i>
                                    </div>
                                    <div class="stat-content dib">
                                        <div class="stat-text">Active Guiders</div>
                                        <div class="stat-digit"><%=totals[1]%></div>
                                    </div>
                                </div>
                            </div>
                        </div><!-- /End of Box 2-->

                        <div class="col-lg-3"><!-- Box 3 -->
                            <div class="card">
                                <div class="stat-widget-one">
                                    <div class="stat-icon dib"><i class="ti-gallery color-success border-success"></i>
                                    </div>
                                    <div class="stat-content dib">
                                        <div class="stat-text">Places</div>
                                        <div class="stat-digit"><%=totals[2]%></div>
                                    </div>
                                </div>
                            </div>
                        </div><!-- /End of Box 3-->

                        <div class="col-lg-3"><!-- Box 4 -->
                            <div class="card">
                                <div class="stat-widget-one">
                                    <div class="stat-icon dib"><i class="ti-location-pin color-danger border-danger"></i></div>
                                    <div class="stat-content dib">
                                        <div class="stat-text">Served Cities</div>
                                        <div class="stat-digit"><%=totals[3]%></div>
                                    </div>
                                </div>
                            </div>
                        </div><!-- /End of Box 4-->
                    </div> <!--/ Row End -->

                    <div class="row"> <!-- Row That contain the chart of predicted values-->

                        <div class="col-lg-7"> <!-- Card 1 - Line chart for 3 places (Prediction of next 19 hour)-->
                            <div class="card">

                                <div class="card-title">
                                    <h4>Linear Regression Prediction Samples</h4>
                                </div>

                                <!-- Rendering 2D Line Chart -->
                                <canvas id="LinearRegressionChart" style="width:100%; height:400px;"></canvas>

                                    <!--JS, get values from c# (Server Side) to render the graph-->
                                    <script>
                                        var xValues = [
                                            <%=times[0]%>,
                                            <%=times[1]%>,
                                            <%=times[2]%>,
                                            <%=times[3]%>,
                                            <%=times[4]%>,
                                            <%=times[5]%>,
                                            <%=times[6]%>];

                                        new Chart("LinearRegressionChart", {
                                            type: "line",
                                            data: {
                                                labels: xValues,
                                                
                                                datasets: [{
                                                    data: [
                                                    <%=visitsRate1[0]%>,
                                                    <%=visitsRate1[1]%>,
                                                    <%=visitsRate1[2]%>,
                                                    <%=visitsRate1[3]%>,
                                                    <%=visitsRate1[4]%>,
                                                    <%=visitsRate1[5]%>,
                                                    <%=visitsRate1[6]%>],
                                                    borderColor: "red",
                                                    fill: false,
                                                    label: "Al-Hada"
                                                    
                                                }, {
                                                    data: [
                                                    <%=visitsRate2[0]%>,
                                                    <%=visitsRate2[1]%>,
                                                    <%=visitsRate2[2]%>,
                                                    <%=visitsRate2[3]%>,
                                                    <%=visitsRate2[4]%>,
                                                    <%=visitsRate2[5]%>,
                                                    <%=visitsRate2[6]%>],
                                                    borderColor: "green",
                                                    fill: false,
                                                    label: "Ash-Shafa"
                                                }, {
                                                    data: [<%=times[0]%>,
                                                    <%=visitsRate3[1]%>,
                                                    <%=visitsRate3[2]%>,
                                                    <%=visitsRate3[3]%>,
                                                    <%=visitsRate3[4]%>,
                                                    <%=visitsRate3[5]%>,
                                                    <%=visitsRate3[6]%>],
                                                    borderColor: "blue",
                                                    fill: false,
                                                    label: "Bin Abbas"
                                                }]
                                            }
                                        });
                                    </script>

                            </div>
                        </div> <!--/ Line Chart card End-->

                        <div class="col-lg-5"><!-- Card 2 - Pie chart that visualize the total of recommender model predictions-->
                            <div class="card">

                                <div class="card-title">
                                    <h4>Recommender System</h4>
                                </div>

                                <div class="card-body">
                                    <div id="piechart"></div>

                                    <!-- Redering -->
                                    <canvas id="TotalRecommendChart" style="width:100%; height:400px;"></canvas>

                                    <!-- JS, Get the values from Server Side -->
                                    <script>
                                        var xValues = ["Recommended", "Not Recommended", "Cant Predict"];
                                        var yValues = [<%=recommenderSystem_totals[0]%> , <%=recommenderSystem_totals[1]%>, <%=recommenderSystem_totals[2]%>];
                                        var barColors = [
                                            "#2b5797",
                                            "#00aba9",
                                            "#b91d47"
                                        ];

                                        new Chart("TotalRecommendChart", {
                                            type: "pie",
                                            data: {
                                                labels: xValues,
                                                datasets: [{
                                                    backgroundColor: barColors,
                                                    data: yValues
                                                }]
                                            }
                                        });
                                    </script>
 
                                </div>
                            </div>
                        </div> <!--/ Pie Chart End-->
                    </div>

                    <!--Footer-->
                    <div class="row">
                            <div class="col-lg-12">
                                <div class="footer">
                                    <p>2022 © Admin Board. - <a href="http://dalilak.pro">dalilak.pro</a></p>
                                </div>
                            </div>
                        </div> <!--/Footer End -->
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

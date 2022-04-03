<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ManageRequests.aspx.cs" Inherits="DalilakWeb.Views.Dashboard.ManageRequests" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">

<head runat="server">

    <%-- Page UTF --%>
    <meta charset="utf-8" />

    <%-- Prebuilt Free Templates are used to design this website
        form "https://themefisher.com/products/focus-bootstrap4-admin-template/"
    --%>
        <!-- ================= Favicon ================== -->
    <!-- Styles (Focus Template) -->
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
    
    <%-- Page Title --%>

    <title>Manage Requests</title>
</head>
<body>
    <%-- * Form is Required to run specific processes at server side (Code Behinde)
         * "runat" Attribute is required to mark asp.Net tags as <asp:Button />
         * all asp.Net tags must be withn form
        --%>
    <form runat="server">

        <%-- side navigation bar from focus template (the design changed to meet the system requirments) --%>
    <div class="sidebar sidebar-hide-to-small sidebar-shrink sidebar-gestures">
        <div class="nano">
            <div class="nano-content">

                <%-- nvigation list Items --%>
                <ul>
                    <div class="logo"><a href="http://dalilak.pro"><span>Dalilak.Pro</span></a></div>

                    <li class="label">Dashboard</li>

                    <li><a runat="server" href="~//Dashboard"><i class="ti-bar-chart-alt"></i> System Summary </a></li>

                    <li class="label">Managing System</li>

                    <li><a href="#"><i class="ti-panel"></i> Manage Users </a></li>

                    <li><a runat="server" href="~//Places"><i class="ti-calendar"></i> Manage Places </a></li>

                    <li><a runat="server" href="~//Requests"><i class="ti-files"></i> Requests <span class="badge badge-primary"><%=HttpContext.Current.Session["notifs"]%></span></a></li>

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

         
         <div class="content-wrap"><%--  start of page desig --%>

             <div class="main">
            <div class="container-fluid">
                 <%-- Row contains of page title --%>
                <div class="row">
                    <div class="col-lg-8 p-r-0 title-margin-right">

                        <%-- apply page header layout by using css classes --%>
                        <div class="page-header">
                            <div class="page-title">
                                <h1>Manage Requests</h1>
                            </div>
                        </div>

                    </div>
                    <!-- /# column -->
                </div>
                <!-- /# row -->

                 <%-- Main content of the page as (tables, forms or messages...etc) --%>

                <section id="main-content">
                    <div class="row">

                         <%-- This column contains of main requests table (System functionality to manage the requests) --%>
                        <div class="col-lg-8">
                         <%-- card class to collect all components within <div class="card" in form of designed layout> --%>
                            <div class="card">
                                <%-- Card Header of form Header--%>
                                <div class="card-title">
                                    <h4>Guidance Requests Table </h4>
                                </div>
                                 <%-- * All componetnt will be within card-body (Form content)
                                     * This card designed to let the user have an ability to do searching operations
                                    --%>
                                <div class="card-body">
                                    <%-- Start of users Table --%>
                                    <div class="table-responsive">

                                         <%-- * Datalist (Table for users)
                                             * Datalist require ID and runat attributes
                                             * Datalist have an ability to bind data from server-side to client-side
                                             * OnItemCommand event handler waits for any type of command from columns and rows (more details below)
                                            --%>
                                        <asp:DataList ID="request_list" runat="server" OnItemCommand="request_list_ItemCommand">
                                            <HeaderTemplate>
                                                <%-- Note: the start of table here --%>
                                                <table class="table table-hover" style="text-align:center;">
                                                    <thead>
                                                        <tr>
                                                            <th>#</th>
                                                            <th>Email</th>
                                                            <th>State</th>
                                                        </tr>
                                                    </thead>
                                                    </HeaderTemplate>

                                            <ItemTemplate>
                                                <tbody>
                                                    <tr>
                                                        <%-- *{++rows} rows is a counter declared at server-side
                                                             *Eval("ColumnName"): this command responsible to take control of <ItemTemplate>
                                                             *there must be a data tabel at server-side with same columns names to bind the data
                                                             *Eval function is responsible alson to bind the data between client and server sides
                                                            --%>
                                                        <th scope="row"><%=++rows %></th>                                             
                                                        
                                                        <td><%# Eval("Email") %></td>
                                                        <td><%# Eval("State") %></td>

                                                        <%-- * Three Buttons to do specific processes
                                                             * requires "runat" and "CommandName"
                                                             * Note: the datalist event listener "OnItemCommand" have an ability to read "CommandName"
                                                             * thats lead to make if statments inside the function of event handler
                                                             * if(listener get a signal from (CommanName)){//Do processes}else if(another (CommandName))...etc
                                                            --%>
                                                        <td><asp:LinkButton runat="server" CommandName="accept" CssClass="btn btn-primary btn-flat btn-addon m-b-10 m-l-5">
                                                            <i class="ti-settings"></i>accept
                                                            </asp:LinkButton></td>

                                                        <td><asp:LinkButton runat="server" CommandName="reject" class="btn btn-danger btn-flat btn-addon m-b-10 m-l-5">
                                                            <i class="ti-close"></i>reject
                                                            </asp:LinkButton></td>

                                                        <td><asp:LinkButton runat="server" CommandName="browsing" class="btn btn-info btn-flat btn-addon m-b-10 m-l-5">
                                                            <i class="ti-search"></i>Download
                                                            </asp:LinkButton></td>
                                                    </tr>
                                                </tbody>
                                            </ItemTemplate>

                                            <FooterTemplate>
                                            </FooterTemplate>

                                            </asp:DataList>
                                        </div>

                                    </div>
                                
                                </div>

                            </div>

                        </div>
                    </section>

                </div><%--  /End of container  --%> 
                 </div>><%--  /End of Main  --%>

             </div><%--  /End of page desig --%>

        </form>

      <%-- Java scripts from focus template
        "https://themefisher.com/products/focus-bootstrap4-admin-template/"
        --%>
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
    <script src="../../assets/js/lib/data-table/datatables.min.js"></script>
    <script src="../../assets/js/lib/data-table/dataTables.buttons.min.js"></script>
    <script src="../../assets/js/lib/data-table/jszip.min.js"></script>
    <script src="../../assets/js/lib/data-table/pdfmake.min.js"></script>
    <script src="../../assets/js/lib/data-table/vfs_fonts.js"></script>
    <script src="../../assets/js/lib/data-table/buttons.html5.min.js"></script>
    <script src="../../assets/js/lib/data-table/buttons.print.min.js"></script>
    <script src="../../assets/js/lib/data-table/buttons.colVis.min.js"></script>
    <script src="../../assets/js/lib/data-table/datatables-init.js"></script>
</body>
</html>

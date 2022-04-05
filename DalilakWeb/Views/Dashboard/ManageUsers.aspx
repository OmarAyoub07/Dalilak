<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ManageUsers.aspx.cs" Inherits="DalilakWeb.Views.Dashboard.ManageUsers" %>

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
    <link rel="icon" href="../../Assets/Images/Icon.jpeg"/>
    
    <%-- Page Title --%>
    <title>Manage Users</title>

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


        <%--  start of page design
            * content-warp is the main container of the design
            * its make the website responsive and all component structured as well
            --%>
    <div class="content-wrap">
        <div class="main">
            <div class="container-fluid">

                <%-- Row contains of page title --%>
                <div class="row">
                    <div class="col-lg-8 p-r-0 title-margin-right">

                        <%-- apply page header layout by using css classes --%>
                        <div class="page-header">
                            <div class="page-title">
                                <h1>Manage Users</h1>
                            </div>
                        </div>

                    </div>
                    <!-- /# column -->
                </div>
                <!-- /# row -->


                <%-- Main content of the page as (tables, forms or messages...etc) --%>
                <section id="main-content">
                    <div class="row">

                        <%-- This column contains of main users table (System functionality to manage the users) --%>
                        <div class="col-lg-8">
                            <%-- card class to collect all components within <div class="card" in form of designed layout> --%>
                            <div class="card">
                                <%-- Card Header of form Header--%>
                                <div class="card-title">
                                    <h4>Users Table </h4>
                                </div>

                                <%-- * All componetnt will be within card-body (Form content)
                                     * This card designed to let the user have an ability to do searching operations
                                    --%>
                                <div class="card-body">

                                    <%-- start search text box --%>
                                    <div class="input-group input-group-default">
                                        <span class="input-group-btn">
                                            <button class="btn btn-primary" type="submit" onclick="searchUsers();" id="btn_search" runat="server"><i class="ti-search"></i></button>
                                        </span>

                                        <%-- * asp:TextBox can't be taged without initializing <form runat="server">
                                             * ID and runat attributes are required to apply processes for this item
                                             * OnTextChanged attribute is an event listener, its value "searchUser" is pointed to function at server-side
                                             * if user write any thing on this text field, the event will automatically executed
                                            --%>
                                        <asp:TextBox type="text" placeholder="Search" class="form-control" ID="txt_search" runat="server" OnTextChanged="searchUsers"/>
                                    </div>
                                    <%-- /End search text box --%>

                                    <%-- start of drop down lists row --%>
                                    <div class="row">

                                        <%-- dropdown class is to make a dropdown list when click on button, not when click on (dropdown list input) --%>
                                        <div class="dropdown" style="margin-top:1%; margin-left:10%;">

                                           <%-- * This button designed to drop list on client click
                                                * the text of this button must changed if the user select an item from the list
                                                * button text equals to selectedcity
                                               --%>
                                            <asp:LinkButton class="btn btn-default dropdown-toggle" type="button" id="drpDwn_city" runat="server" data-toggle="dropdown" Width="150"> Select City
											    <span class="caret"></span></asp:LinkButton>

                                             <%-- * asp:ListBox require ID and runat
                                                  * It will filled by items when client post request to get cities from database
                                                  * if user choose a city from this box, the table of users will show only users with selected city 
                                                  * OnSelectedIndexChanged is an event handler
                                                --%>
                                            <asp:ListBox runat="server" ID="drpLst_city" CssClass="dropdown-menu" OnSelectedIndexChanged="searchUsers" >
                                                  <asp:ListItem Text="All" Selected="True"></asp:ListItem>
                                              </asp:ListBox>

                                        </div>
                                        <%-- End drop down cities list --%>

                                        <%-- * Same Concept of cities dropdown list, but this list for users type
                                             * if the user select "Guider", the tale will display guiders only
                                            --%>
                                        <div class="dropdown" style="margin-top:1%; margin-left:10%;">

                                            <asp:LinkButton class="btn btn-default dropdown-toggle" type="button" id="drpDwn_user" runat="server" data-toggle="dropdown" Width="180">Select Accessibility
											    <span class="caret"></span></asp:LinkButton>

                                            <asp:ListBox runat="server" ID="drpLst_user" CssClass="dropdown-menu" OnSelectedIndexChanged="searchUsers" >
                                                  <asp:ListItem Text="All" Selected="True"></asp:ListItem>
                                                  <asp:ListItem Text="Guider"></asp:ListItem>
                                                  <asp:ListItem Text="Tourist"></asp:ListItem>
                                              </asp:ListBox>

                                        </div>
                                        <%-- End drop down user type list --%>

                                    </div>
                                    <%-- / End of drop down lists row --%>

                                    <%-- Start of users Table --%>
                                    <div class="table-responsive">

                                        <%-- * Datalist (Table for users)
                                             * Datalist require ID and runat attributes
                                             * Datalist have an ability to bind data from server-side to client-side
                                             * OnItemCommand event handler waits for any type of command from columns and rows (more details below)
                                            --%>
                                        <asp:DataList ID="users_list" runat="server" OnItemCommand="dListUsers_ItemCommand">

                                            <%-- datalist Header layout --%>
                                            <HeaderTemplate>
                                                <%-- Note: the start of table here --%>
                                                <table class="table table-hover" style="text-align:center;">
                                                    <thead>
                                                        <tr>
                                                            <th>#</th>
                                                            <th>Name</th>
                                                            <th>Email</th>
                                                            <th>Phone</th>
                                                            <th>City</th>
                                                            <th>Accessibility</th>
                                                        </tr>
                                                    </thead>
                                            </HeaderTemplate>

                                            <%-- * The general layout and order of binded data
                                                 * All rows of table will take the same Template
                                                --%>
                                            <ItemTemplate>
                                                <tbody>
                                                    <tr>
                                                        <%-- *{++rows} rows is a counter declared at server-side
                                                             *Eval("ColumnName"): this command responsible to take control of <ItemTemplate>
                                                             *there must be a data tabel at server-side with same columns names to bind the data
                                                             *Eval function is responsible alson to bind the data between client and server sides
                                                            --%>
                                                        <th scope="row"><%=++rows %></th>                                             
                                                        <td><%# Eval("Name") %></td>
                                                        <td><%# Eval("Email") %></td>
                                                        <td><%# Eval("Phone") %></td>
                                                        <td><%# Eval("City") %></td>
                                                        <td><%# Eval("Accessibility") %></td>

                                                        <%-- * Three Buttons to do specific processes
                                                             * requires "runat" and "CommandName"
                                                             * Note: the datalist event listener "OnItemCommand" have an ability to read "CommandName"
                                                             * thats lead to make if statments inside the function of event handler
                                                             * if(listener get a signal from (CommanName)){//Do processes}else if(another (CommandName))...etc
                                                            --%>
                                                        <td><asp:LinkButton runat="server" CommandName="editing" CssClass="btn btn-primary btn-flat btn-addon m-b-10 m-l-5">
                                                            <i class="ti-settings"></i>Edit
                                                            </asp:LinkButton></td>

                                                        <td><asp:LinkButton runat="server" CommandName="removing" class="btn btn-danger btn-flat btn-addon m-b-10 m-l-5">
                                                            <i class="ti-close"></i>Remove
                                                            </asp:LinkButton></td>

                                                        <td><asp:LinkButton runat="server" CommandName="browsing" class="btn btn-info btn-flat btn-addon m-b-10 m-l-5">
                                                            <i class="ti-search"></i>Info
                                                            </asp:LinkButton></td>
                                                    </tr>
                                                </tbody>
                                            </ItemTemplate>

                                            <%-- Footer of Table --%>
                                            <FooterTemplate>

                                                <td><asp:LinkButton runat="server" CommandName="Adding" class="btn btn-success btn-flat btn-addon m-b-10 m-l-5">
                                                        <i class="ti-plus"></i>Add User
                                                        </asp:LinkButton></td>
                                                <%-- Note: End of table is here --%>
                                                </table>

                                            </FooterTemplate>
                                        </asp:DataList>
                                        <%-- / End of datalist --%>
                                    </div>
                                    <%-- /End of users Table --%>
                                </div>
                            </div>
                            <!-- /# card -->
                        </div>
                        <!-- /# column -->


                        <div class="col-lg-4">

                            <%-- Card to edit User Information
                                 if user click on edit in specific row, show this form
                                --%>
                            <div class="card" id="form_edit" runat="server">

                                <%-- 
                                     * h2 will store the name of user in that row
                                     * p will be unvisible to store the ID of user
                                     * ID needed to apply changes to database
                                    --%>
                                <div class="card-title">
                                    <h2 id="lbl_userCard" runat="server"></h2>
                                    <p id="hidden_userId" runat="server"></p>      
                                </div>

                                <div class="card-body">
                                    <div class="basic-form">

                                        <%-- Radio button list to allow admin to edit if the user guider or tourist --%>
                                        <div class="form-group">
                                            <h5 >Accessibility</h5>
                                            <asp:RadioButtonList runat="server" ID="rdioLst_acsbilty">
                                                <asp:ListItem Text="Guider" Value="true"></asp:ListItem>
                                                <asp:ListItem Text="Tourist" Value="false"></asp:ListItem>
                                            </asp:RadioButtonList>
                                        </div>

                                        <%-- TextBox to edit user Email --%>
                                        <div class="form-group">
                                            <h5>Email:</h5>
                                            <asp:TextBox ID="txt_editEmail" runat="server" type="email" class="form-control input-flat"/>
                                        </div>

                                        <%-- TextBox to edit user Phone number --%>
                                        <div class="form-group">
                                            <h5>Phone (+966):</h5>
                                            <p class="text-muted m-b-15 f-s-12"> Please start from 5 (you need to write only '9' numbers as '5** *** ***')</p>
                                            <asp:TextBox ID="txt_editPhone" runat="server" type="text" class="form-control input-flat" MaxLength="9"/>
                                        </div>

                                        <%-- Two buttons, to submit changes and another one to cancel the process
                                             Event handler OnClick
                                            --%>
                                        <div class="button-list">
                                            <asp:Button type="button" class="btn btn-success m-b-10 m-l-5" Text="Post Edit" runat="server" OnClick="post_editedUser"/>
                                            <asp:Button type="button" class="btn btn-dark m-b-10 m-l-5" Text="Cancel" runat="server" OnClick="close_forms"/>
                                        </div>
                                    </div>

                                    
                                </div>
                            </div>
                                <!-- /# End of edit Form -->

                            <%-- Card to add new User
                                 if user click on add in specific row, show this form
                                --%>
                             <div class="card" id="form_add" runat="server">

                                <div class="card-title">
                                    <h2>New User</h2>     
                                </div>

                                <div class="card-body"> 
                                    <div class="basic-form">

                                        <%-- Text box for new user name --%>
                                        <div class="form-group">
                                            <h5 >Name:</h5>
                                            <asp:TextBox ID="txt_addName" runat="server" type="text" class="form-control input-flat" placeholder="Add New User Name" required/>
                                        </div>

                                        <%-- Text Box for new user email--%>
                                        <div class="form-group">
                                            <h5>Email:</h5>
                                            <asp:TextBox ID="txt_addEmail" runat="server" type="email" class="form-control input-flat" placeholder="Add new User Email" required/>
                                        </div>

                                        <%-- Text Box form new user phone --%>
                                        <div class="form-group">
                                            <h5>Phone (+966):</h5>
                                            <p class="text-muted m-b-15 f-s-12"> Please start from 5 (you need to write only '9' numbers as '5** *** ***')</p>
                                            <asp:TextBox ID="txt_addPhone" runat="server" type="text" class="form-control input-flat" MaxLength="9" placeholder="Add new User Phone" required/>
                                        </div>

                                        <%-- Buttons to post of close the form --%>
                                        <div class="button-list">
                                            <asp:Button type="button" class="btn btn-success m-b-10 m-l-5" Text="Post New User" runat="server" OnClick="post_AddUser"/>
                                            <asp:LinkButton type="button" class="btn btn-dark m-b-10 m-l-5" Text="Cancel" runat="server" OnClick="close_forms"/>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <%-- / End adding user form --%>

                            <%-- this form to display information for each user --%>
                            <div class="card" id="form_info" runat="server">
                                <div class="card-body">
                                    <div class="user-profile">
                                        <div class="row">

                                            <%-- display the user profile image --%>
                                            <div class="col-lg-4">
                                                <div class="user-photo m-b-30">
                                                    <img class="img-fluid" alt="Avatar" id="img_avatar" runat="server" />
                                                </div>
                                            </div>

                                            <%-- 
                                                For this "col", Note there are (<div> and <span>) tags with "ID" and "runat"
                                                Each item with ID and runat will display data related to the selected user
                                                for example: "lbl_infoName" will display user name by apply a concept of {lbl_infoName.Text = user.name}
                                                --%>
                                            <div class="col">
                                                <div class="row">
                                                    <div class="user-profile-name" id="lbl_infoName" runat="server"></div>
                                                </div>

                                                <div class="row">
                                                    <div class="user-job-title" id="lbl_infoIsGuider" runat="server"></div>
                                                </div>

                                                <div class="address-content">
                                                  <span class="contact-title">City:</span>
                                                  <span class="mail-address" id="lbl_infoCity" runat="server"></span>
                                                </div>

                                                <div class="birthday-content">
                                                  <span class="contact-title">Age:</span>
                                                  <span class="birth-date" id="lbl_infoAge" runat="server"></span>
                                                </div>
                                            </div>


                                            <div class="custom-tab user-profile-tab">
                                                <ul class="nav nav-tabs" role="tablist">
                                                    <li role="presentation" class="active">
                                                        <a href="#" aria-controls="1" role="tab" data-toggle="tab">About</a>
                                                    </li>
                                                </ul>

                                                <div class="tab-content">
                                                    <div role="tabpanel" class="tab-pane active" id="1">

                                                        <div class="contact-information">

                                                            <h4>Contact information</h4>
                                                                <div class="phone-content">
                                                                    <span class="contact-title">Phone:</span>
                                                                    <span class="phone-number" id="lbl_infoPhone" runat="server"></span>
                                                                </div>

                                                                <div class="email-content">
                                                                    <span class="contact-title">Email:</span>
                                                                    <span class="contact-email" id="lbl_infoEmail" runat="server"></span>
                                                                </div>

                                                            </div>

                                                            <div class="basic-information">
                                                                <h4>Basic information</h4>                             
                                                                <div class="gender-content">
                                                                    <span class="contact-title">Bio:</span>
                                                                    <span class="mail-address" id="lbl_infoBio" runat="server"></span>
                                                                </div>
                                                            </div>

                                                        </div>
                                                    </div>
                                                <%-- button to close the form --%>
                                                <asp:Button type="button" class="btn btn-dark m-b-10 m-l-5" Text="Close" runat="server" OnClick="close_forms"/>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <%-- / end of information form --%>

                            </div>
                                <!-- /# column -->
                        </div>
                    <!-- /# row footer -->
                        <div class="row">
                            <div class="col-lg-12">
                                <div class="footer">
                                    <p>2022 © Admin Board. - <a href="http://dalilak.pro">dalilak.pro</a></p>
                                </div>
                            </div>
                        </div>
                    </section>
                </div>
            <%-- /End of container --%>
            </div>
        <%-- /End of Main design class --%>
        </div>
        <%-- /end of design --%>

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

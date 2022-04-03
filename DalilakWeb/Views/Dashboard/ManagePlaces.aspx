<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ManagePlaces.aspx.cs" Inherits="DalilakWeb.Views.Dashboard.ManagePlaces" %>

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
    
    <title>Manage Places</title>
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

                    <li><a runat="server" href="~//Users"><i class="ti-panel"></i> Manage Users </a></li>

                    <li><a href="#"><i class="ti-calendar"></i> Manage Places </a></li>

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

        
        <div class="content-wrap"> <%-- start of warp--%>
             <div class="main"> <%--  start of main--%>
                 <div class="container-fluid"> <%--  start of containar--%>


                       <%-- Row contains of page title --%>
                <div class="row">
                    <div class="col-lg-8 p-r-0 title-margin-right">

                        <%-- apply page header layout by using css classes --%>
                        <div class="page-header">
                            <div class="page-title">
                                <h1>Manage Places</h1>
                            </div>
                        </div>

                    </div>
                    <!-- /# column -->
                </div>
                <!-- /# row -->

                      <%-- Main content of the page as (tables, forms or messages...etc) --%>
                      <section id="main-content">
                          <div class="row">
                              <%-- This column contains of main places table (System functionality to manage the places) --%>
                                <div class="col-lg-8">
                            <%-- card class to collect all components within <div class="card" in form of designed layout> --%>
                                     <div class="card">
                                           
                                            <%-- Card Header of form Header--%>
                                            <div class="card-title">
                                                <h4>Places Table </h4>
                                            </div>

                                            <div class="card-body">


                                                <%-- start search text box --%>
                                    <div class="input-group input-group-default">
                                        <span class="input-group-btn">
                                            <button class="btn btn-primary" type="submit" onclick="searchPlaces();" id="btn_search" runat="server"><i class="ti-search"></i></button>
                                        </span>

                                        <%-- * asp:TextBox can't be taged without initializing <form runat="server">
                                             * ID and runat attributes are required to apply processes for this item
                                             * OnTextChanged attribute is an event listener, its value "searchUser" is pointed to function at server-side
                                             * if user write any thing on this text field, the event will automatically executed
                                            --%>
                                        <asp:TextBox type="text" placeholder="Search" class="form-control" ID="txt_search" runat="server" OnTextChanged="searchPlaces"/>
                                    </div>
                                    <%-- /End search text box --%>

                                     <%-- start of drop down lists row --%>
                                    <div class="row">
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
                                            <asp:ListBox runat="server" ID="drpLst_city" CssClass="dropdown-menu" OnSelectedIndexChanged="searchPlaces" >
                                                  <asp:ListItem Text="All" Selected="True"></asp:ListItem>                 
                                                </asp:ListBox>

                                              <%-- * Same Concept of cities dropdown list, but this list for Places type
                                             * if the user select "Natural", the tale will display nautral Places only
                                            --%>
                                            <div class="dropdown" style="margin-top:1%; margin-left:10%;">

                                            <asp:LinkButton class="btn btn-default dropdown-toggle" type="button" id="drpDwn_Places" runat="server" data-toggle="dropdown" Width="180">Select Place Type
											    <span class="caret"></span></asp:LinkButton>

                                            <asp:ListBox runat="server" ID="drpLst_Places" CssClass="dropdown-menu" OnSelectedIndexChanged="searchPlaces" >
                                                  <asp:ListItem Text="All" Selected="True"></asp:ListItem>
                                                  <asp:ListItem Text="Natural"></asp:ListItem>
                                                  <asp:ListItem Text="Historical"></asp:ListItem>
                                                <asp:ListItem Text="Events"></asp:ListItem>
                                              </asp:ListBox>
                                         </div> <%-- End drop down user type list --%>
                                       

                                        </div><%--/ end of the dropdown lists--%>
                                        </div><%-- / End of drop down lists row --%>




                                                <%-- Start of users Table --%>
                                    <div class="table-responsive">

                                        <%-- * Datalist (Table for places)
                                             * Datalist require ID and runat attributes
                                             * Datalist have an ability to bind data from server-side to client-side
                                             * OnItemCommand event handler waits for any type of command from columns and rows (more details below)
                                            --%>
                                        <asp:DataList ID="Places_list" runat="server" OnItemCommand="Places_list_ItemCommand">

                                            <%-- datalist Header layout --%>
                                            <HeaderTemplate>
                                                <%-- Note: the start of table here --%>
                                                <table class="table table-hover" style="text-align:center;">
                                                    <thead>
                                                        <tr>
                                                            <th>#</th>
                                                            <th>Name</th>
                                                            <th>Nature</th>
                                                            <th>City</th>                                                          
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
                                                        <td><%# Eval("Nature") %></td>                                                       
                                                        <td><%# Eval("City") %></td>
                                                        
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

                                                        <td><asp:LinkButton runat="server" CommandName="addImage" class="btn btn-info btn-flat btn-addon m-b-10 m-l-5">
                                                            <i class="ti-search"></i>Add Image
                                                            </asp:LinkButton></td>

                                                    </tr>
                                                </tbody>
                                            </ItemTemplate>

                                            <%-- Footer of Table --%>
                                            <FooterTemplate>

                                                <td><asp:LinkButton runat="server" CommandName="Adding" class="btn btn-success btn-flat btn-addon m-b-10 m-l-5">
                                                        <i class="ti-plus"></i>Add Place
                                                        </asp:LinkButton></td>
                                                <%-- Note: End of table is here --%>
                                                </table>

                                            </FooterTemplate>
                                        </asp:DataList>
                                        <%-- / End of datalist --%>
                                    </div>
                                    <%-- /End of users Table --%>





                                        </div><%-- / end of the card body--%>                          
                                    </div>  <%-- / End of the card--%>
                                 </div>   <%-- / end of the col--%>
                             </div>    <%-- / end of the row--%>
                       </section>  <%-- / end of the main containt of the page --%>
                
                </div> <%--  / end of containar--%>
            </div><%--  / end of main--%>
         </div><%--  / end of warp--%>


     </form>
</body>
</html>

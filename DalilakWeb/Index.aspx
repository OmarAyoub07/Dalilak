<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Index.aspx.cs" Inherits="DalilakWeb.Views.Main" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml" runat="server" id="html">
<head runat="server">
     <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <meta name="description" content="" />
        <meta name="author" content="" />
        <!-- Font Awesome icons (free version)-->
        <script src="https://use.fontawesome.com/releases/v5.15.4/js/all.js" crossorigin="anonymous"></script>
        <!-- Google fonts-->
        <link href="https://fonts.googleapis.com/css?family=Varela+Round" rel="stylesheet" />
        <link href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i" rel="stylesheet" />
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css"/>

        <!-- Core theme CSS (includes Bootstrap)-->
        <link href="Assets/css/styles_main.css" rel="stylesheet" />

        <link rel="icon" href="Assets/Images/Icon.jpeg"/>

    <title id="title" runat="server"></title>
</head>
<body>
    
    <form runat="server">
    <!-- Navigation-->
        <nav class="navbar navbar-expand-lg navbar-light fixed-top" id="mainNav">
            <div class="container px-4 px-lg-5">
                <div class="collapse navbar-collapse" id="navbarResponsive">
                    <ul class="navbar-nav ms-auto">
                        <li class="nav-item"><asp:LinkButton CssClass="nav-link" runat="server" Text="عربي" OnClick="arabicLanguage"/></li>
                        <li class="nav-item"><asp:LinkButton CssClass="nav-link" runat="server" Text="English" OnClick="englishLanguage"/></li>
                    </ul>
                </div>
            </div>
        </nav>
    <!-- Masthead-->
        <header class="masthead">
            <div class="container px-4 px-lg-5 d-flex h-100 align-items-center justify-content-center">
                
                <div class="d-flex justify-content-center">
                    <div class="text-center">
                        <div class="row">
                            <div class="col">
                                <h1 class="mx-auto my-0 text-uppercase" id="h_appName" runat="server"></h1>
                                <h2 class="text-white-50 mx-auto mt-2 mb-5 " id="h_appDesc" runat="server"></h2>
                            </div>
                             <div class="col">
                            <div class="row" style="margin-top:15%;"><asp:LinkButton class="btn btn-primary" runat="server"><i class="fab fa-app-store-ios" style="font-size:38px;">  </i>  <p id="app_1" runat="server"></p></asp:LinkButton></div>
                            <div class="row" style="margin-top:10%;"><asp:LinkButton class="btn btn-primary" runat="server" OnClick="download_android"><i class="fab fa-android" style="font-size:38px;">  </i>  <p id="app_2" runat="server"></p></asp:LinkButton></div>
                            </div>
                        </div>

                    </div>
                </div>

            </div>
        </header>
        </form>

   
            <!-- Footer-->
        <footer class="footer bg-black small text-center text-white-50"><div class="container px-4 px-lg-5">Copyright Ta'if University; Dalilak Website 2022</div></footer>

    <!-- Bootstrap core JS-->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
        <!-- Core theme JS-->
        <script src="Assets/js/scripts_main.js"></script>
        <!-- * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *-->
        <!-- * *                               SB Forms JS                               * *-->
        <!-- * * Activate your form at https://startbootstrap.com/solution/contact-forms * *-->
        <!-- * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *-->
        <script src="https://cdn.startbootstrap.com/sb-forms-latest.js"></script>

</body>

</html>

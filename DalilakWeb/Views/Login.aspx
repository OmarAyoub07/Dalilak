<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="DalilakWeb.Views.Login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">

    <!-- Styles -->
    <link href="../assets/css/lib/font-awesome.min.css" rel="stylesheet"/>
    <link href="../assets/css/lib/themify-icons.css" rel="stylesheet"/>
    <link href="../assets/css/lib/bootstrap.min.css" rel="stylesheet"/>
    <link href="../assets/css/lib/helper.css" rel="stylesheet"/>
    <link href="../assets/css/style_dp.css" rel="stylesheet"/>

    <link rel="icon" href="../Assets/Images/Icon.jpeg"/>

    <title>Admin</title>
</head>
    <body style="background-color: white;">
    <div class="unix-login">
        <div class="container-fluid">
            <div class="row justify-content-center">
                <div class="col-lg-6">
                    <div class="login-content">
                        <div class="login-logo">
                            <a href="index.html"><span>Dalilak</span></a>
                        </div>
                        <form style="border: 2px solid gray;" runat="server">
                        <div class="login-form">
                            <h4>Administratior Login</h4>
                            <label id="lbl_err_msg" runat="server" style="color: saddlebrown;">! "You entered an invalid email or password"</label>
                                <div class="form-group">
                                    <label>Email address</label>
                                    <asp:TextBox id="txt_email" type="email" class="form-control" placeholder="Email" runat="server"></asp:TextBox>
                                </div>
                                <div class="form-group">
                                    <label>Password</label>
                                    <asp:TextBox id="txt_pass" type="password" class="form-control" placeholder="Password" runat="server"></asp:TextBox>
                                </div>
                                <div class="checkbox">
                                  
                                    <label class="pull-right">
										<a runat="server" href="#">Forgotten Password?</a>
									</label>

                                </div>
                                
                                <asp:button OnClick="btn_Sigin_click" id="btn_Sigin" runat="server" type="submit" class="btn btn-primary btn-flat m-b-30 m-t-30" text="Sign in"/>
                                
                                </div>
                                
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
</body>
</html>

using System;
using System.Web.Routing;

namespace DalilakWeb
{
    public class Global : System.Web.HttpApplication
    {

        protected void Application_Start(object sender, EventArgs e)
        {
            register_url(RouteTable.Routes);
        }

        public static void register_url(RouteCollection url)
        {
            // routing to admin login page // (dalilak.pro/Admin)
            url.MapPageRoute("routing to login page", "Admin", "~/Views/Login.aspx");

            url.MapPageRoute("routing to main Dashboard page", "Dashboard", "~/Views/Dashboard/MainDashboard.aspx");

            url.MapPageRoute("routing to Manage Users page", "Users", "~/Views/Dashboard/ManageUsers.aspx");

            url.MapPageRoute("routing to Manage Place page", "Places", "~/Views/Dashboard/ManagePlaces.aspx");

            url.MapPageRoute("routing to Manage Requests page", "Requests", "~/Views/Dashboard/ManageRequests.aspx");

        }
    }
}
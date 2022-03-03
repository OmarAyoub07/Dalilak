using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace DalilakWeb.Views.Dashboard
{
    public partial class MainDashboard : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            //if(HttpContext.Current.Session["admin"] == null)
            //{
            //    Response.Redirect("~//Admin");
            //}
            //else
            //    lbl_admin.InnerText = HttpContext.Current.Session["admin"].ToString();
        }
    }
}


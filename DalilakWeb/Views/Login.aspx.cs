using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace DalilakWeb.Views
{
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string test = "";
            using (var context = new Models.Database())
            {
                foreach(var item in context.Users)
                {
                    test += (item.id + "\n"+ item.name + "<br/>");
                }
            }
            Response.Write(test);
        }
    }
}
using RestSharp;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace DalilakWeb.Views
{
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        public void btn_Sigin_click(object sender, EventArgs e)
        {
            string uri = "http://api.dalilak.pro/Login/admin_?email=" + email.Text + "&pass=" + pass.Text;
            bool isExist = false;
            using (var client = new HttpClient())
            {
                var respons = client.PostAsync(uri, null);

                isExist = Convert.ToBoolean(respons.Result.Content.ReadAsStringAsync().Result.ToString());
            }
            if (isExist)
            {
                Response.Write(isExist.ToString());
            }
        }

    }
}
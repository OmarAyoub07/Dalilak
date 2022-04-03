using System;
using System.Net.Http;
using System.Web;

namespace DalilakWeb.Views
{
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            lbl_err_msg.Visible = false;
        }
        public void btn_Sigin_click(object sender, EventArgs e)
        {
            string uri = "http://api.dalilak.pro/Login/admin_?email=" + txt_email.Text + "&pass=" + txt_pass.Text;
            bool isExist = false;
            using (var client = new HttpClient())
            {
                var respons = client.PostAsync(uri, null);

                isExist = Convert.ToBoolean(respons.Result.Content.ReadAsStringAsync().Result.ToString());
            }
            if (isExist)
            {
                HttpContext.Current.Session["admin"] = txt_email.Text;
                Response.Redirect("~//Dashboard");
            }
            else
            {
                lbl_err_msg.Visible= true;
            }
        }
    }
}
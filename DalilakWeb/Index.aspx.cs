using System;
using System.Threading;
using System.Globalization;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;

namespace DalilakWeb.Views
{
    public partial class Main : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            setLabels();
        }

        protected void arabicLanguage(object sender, EventArgs e)
        {
            Thread.CurrentThread.CurrentUICulture = new CultureInfo("ar");
            Thread.CurrentThread.CurrentCulture = new CultureInfo("ar");
            setLabels();
        }
        protected void englishLanguage(object sender, EventArgs e)
        {
            Thread.CurrentThread.CurrentUICulture = new CultureInfo("en");
            Thread.CurrentThread.CurrentCulture = new CultureInfo("en");
            setLabels();
        }

        private void setLabels()
        {
            title.Text = Resources.Resource.main_title;
            h_appName.InnerText = Resources.Resource.main_h_appName;
            h_appDesc.InnerText = Resources.Resource.main_h_appDesc;
            app_1.InnerText = Resources.Resource.download;
            app_2.InnerText = Resources.Resource.main_commingSoon;

        }

        protected void download_android(object sender, EventArgs e)
        {
            var path = Server.MapPath("~/Assets/Apps/Dalilak Pro.apk");

            var stream = new FileStream(path, FileMode.Open, FileAccess.Read);
            BinaryReader br = new BinaryReader(stream);
            var file = br.ReadBytes((Int32)stream.Length);

            Response.ContentType = "application/force-download";
            Response.AppendHeader("Content-Disposition", "attachment;filename=Dalilak Pro - vAndroid.apk");
            Response.BinaryWrite(file);
            Response.End();
        }
    }
}
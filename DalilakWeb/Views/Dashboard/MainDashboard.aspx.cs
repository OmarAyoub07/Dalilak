using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Net.Http;
using System.Text;
using System.Web;

namespace DalilakWeb.Views.Dashboard
{
    public partial class MainDashboard : System.Web.UI.Page
    {
        public int[] totals = new int[5];
        public int[] recommenderSystem_totals = new int[3];

        public int[] times = new int[7];

        public float[] visitsRate1 = new float[7];
        public float[] visitsRate2 = new float[7];
        public float[] visitsRate3 = new float[7];

        private DateTime now = DateTime.UtcNow;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (HttpContext.Current.Session["admin"] == null)
            {
                Response.Redirect("~//Admin");
            }
            else
                lbl_admin.InnerText = HttpContext.Current.Session["admin"].ToString();

            int time = now.Hour+3;
            setTimes(time);
            setVisitsRate();
            setTotalRecommendations();
            setTotals();
        }

        protected void logOut(object sender, EventArgs e)
        {
            HttpContext.Current.Session["admin"] = null;
            Response.Redirect("~//Admin");
        }

        private void setTimes(int nowH)
        {
            for(int i = 0; i < 7; i++)
            {
                times[i] = nowH;
                nowH += 3;
                nowH = nowH % 24;
            }
        }

        private async void setVisitsRate()
        {
            using (var client = new HttpClient())
            {
                var body = new string[] { "b279738fb9a444e49c69173a9379c137", "c2718533cb2c4fad93ac190bd057052c", "34b077d134524ae498fad5af3422ea17" };
                var stringPayload = JsonConvert.SerializeObject(body);
                var content = new StringContent(stringPayload, Encoding.UTF8, "application/json");

                var uri = new Uri("http://api.dalilak.pro/Predict/LR_MultiPredicts?now="+now);

                var result = await client.PostAsync(uri, content);
                List<string[]> list = JsonConvert.DeserializeObject<List<string[]>>(result.Content.ReadAsStringAsync().Result.ToString());

                int[] counters = new int[3] {0,0,0};
                foreach (var arr in list)
                {
                    if (arr[0] == body[0])
                    {
                        visitsRate1[counters[0]] = float.Parse(arr[1])*100;
                        counters[0]++;
                    }
                    else if (arr[0] == body[1])
                    {
                        visitsRate2[counters[1]] = float.Parse(arr[1])*100;
                        counters[1]++;
                    }
                    else
                    {
                        visitsRate3[counters[2]] = float.Parse(arr[1])*100;
                        counters[2]++;
                    }
                }
            }
        }

        private async void setTotalRecommendations()
        {
            using (var client = new HttpClient())
            {
                var uri = new Uri("http://api.dalilak.pro/Predict/MF_GetTotalRecommendation");

                var result = await client.GetAsync(uri);
                recommenderSystem_totals = JsonConvert.DeserializeObject<int[]>(result.Content.ReadAsStringAsync().Result.ToString());
            }
        }

        private async void setTotals()
        {
            using (var client = new HttpClient())
            {
                var uri = new Uri("http://api.dalilak.pro/Query/Summation_");

                var result = await client.GetAsync(uri);
                totals = JsonConvert.DeserializeObject<int[]>(result.Content.ReadAsStringAsync().Result.ToString());

                HttpContext.Current.Session["notifs"] = totals[4];
            }
        }

    }
}
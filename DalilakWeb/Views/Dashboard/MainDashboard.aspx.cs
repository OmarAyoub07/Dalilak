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
        /* Intialize Variables */

        public int[] totals = new int[5]; // Totals of [users, guiders, places, cities, requests] (Boxes)
        public int[] recommenderSystem_totals = new int[3];// Totals of [recommended, not recommended, cantpredict]
                                                           // for Pie chart

        public int[] times = new int[7]; // x Values for Line Graph

        public float[] visitsRate1 = new float[7]; // y values for Line Graph (place 1)
        public float[] visitsRate2 = new float[7]; // y values for Line Graph (place 2)
        public float[] visitsRate3 = new float[7]; // y values for Line Graph (place 3)

        private DateTime now = DateTime.UtcNow; // GMT Time
        protected void Page_Load(object sender, EventArgs e)
        {
            // if no session called 'admin' redirect the user to login page
            if (HttpContext.Current.Session["admin"] == null)
            {
                Response.Redirect("~//Admin");
            }
            else // Else, print the content of 'admin' session
                lbl_admin.InnerText = HttpContext.Current.Session["admin"].ToString();

            /* Calls of API */
            // Each function set some values in the arrays to pring them in front end
            int time = now.Hour+3; // KSA => GMT+3
            setTimes(time); // set x values for line chart (times[])
            setVisitsRate(); // Set y Values for line chart
            setTotalRecommendations(); // set values for pie chart
            setTotals(); // set values for boxes
        }

        // Logout function
        protected void logOut(object sender, EventArgs e)
        {
            HttpContext.Current.Session["admin"] = null;
            Response.Redirect("~//Admin"); // Remove 'admin' session then redirect to login page
        }

        private void setTimes(int nowH)
        {
            for(int i = 0; i < 7; i++)
            {
                times[i] = nowH; // set one value
                nowH += 3; // incerement
                nowH = nowH % 24;// make values for line chart between 0 and 23
            }
        }

        private async void setVisitsRate()
        {
            using (var client = new HttpClient())
            {
                // boody to post array to the API
                var body = new string[] { "b279738fb9a444e49c69173a9379c137", "c2718533cb2c4fad93ac190bd057052c", "34b077d134524ae498fad5af3422ea17" };
                var stringPayload = JsonConvert.SerializeObject(body);//Convert array to json format
                var content = new StringContent(stringPayload, Encoding.UTF8, "application/json");//Encode

                var uri = new Uri("http://api.dalilak.pro/Predict/LR_MultiPredicts?now="+now);

                var result = await client.PostAsync(uri, content);// post using URI with Content of body
                // casting from string to list of arrays
                List<string[]> list = JsonConvert.DeserializeObject<List<string[]>>(result.Content.ReadAsStringAsync().Result.ToString());

                int[] counters = new int[3] {0,0,0}; // each index is a counter for one place
                                                    //  the API return 7 predicted values for each place
                                            
                foreach (var arr in list) // Add the values to (yValues) of line chart
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
                // casting string to array of int's
                recommenderSystem_totals = JsonConvert.DeserializeObject<int[]>(result.Content.ReadAsStringAsync().Result.ToString());
            }
        }

        private async void setTotals()
        {
            using (var client = new HttpClient())
            {
                // api url
                var uri = new Uri("http://api.dalilak.pro/Query/Summation_");

                var result = await client.GetAsync(uri);
                // cast the result from string to array of integers
                totals = JsonConvert.DeserializeObject<int[]>(result.Content.ReadAsStringAsync().Result.ToString());

                HttpContext.Current.Session["notifs"] = totals[4]; // notifications need to be shown to admin
                                                                   // while he is logined,
                                                                   // store notifications totals on 'notifs' session
            }
        }

    }
}
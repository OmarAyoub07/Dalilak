using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Net.Http;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace DalilakWeb.Views.Dashboard
{
    public partial class ManageRequests : System.Web.UI.Page
    {
        /* Variables */
        public int rows_t1 = 0 , rows_t2 = 0;

        private static string _id = "";

        private static string status = "";

        private static int index = 0;

        private static List<Request> new_requests = new List<Request>();

        private static List<Request> old_requests = new List<Request>();

        private static List<Modification> new_modi = new List<Modification>();

        private static List<Modification> old_modi = new List<Modification>();

        private static DataTable table_NewReq = new DataTable();

        private static DataTable table_oldReq = new DataTable();


        /* Event Handelers */
        protected void Page_Load(object sender, EventArgs e)
        {
            if (HttpContext.Current.Session["admin"] == null)
            {
                // Redirect to login page
                Response.Redirect("~//Admin");
            }
            else // if logined, assign the admin email to admin label (lbl_admin)
                lbl_admin.InnerText = HttpContext.Current.Session["admin"].ToString();

            if (!IsPostBack)
            {
                try
                {
                    table_NewReq.Columns.Add("reqId");
                    table_NewReq.Columns.Add("IndexOfList");
                    table_NewReq.Columns.Add("id"); // User Id
                    table_NewReq.Columns.Add("Email");
                    table_NewReq.Columns.Add("Request"); // Guidance, add, or modify


                    table_oldReq.Columns.Add("reqId");
                    table_oldReq.Columns.Add("IndexOfList");
                    table_oldReq.Columns.Add("id");
                    table_oldReq.Columns.Add("User");
                    table_oldReq.Columns.Add("Admin");
                    table_oldReq.Columns.Add("status");
                }
                catch
                {
                    reload();
                }

                GetRequests();
                hideForms();
            }
        }
        protected void logOut(object sender, EventArgs e) 
        {
            HttpContext.Current.Session["admin"] = null;
            Response.Redirect("~//Admin");
        }

        protected void request_list_ItemCommand(object source, DataListCommandEventArgs e)
        {
            index = (int)e.Item.ItemIndex;

            if (e.CommandName == "download")
            {
                if (table_NewReq.Rows[index].ItemArray[4].ToString() == "Guidance") 
                {
                    int temp_indx = int.Parse(table_NewReq.Rows[index].ItemArray[1].ToString());
                    Response.ContentType = "application/force-download";
                    Response.AppendHeader("Content-Disposition", "attachment;filename="+new_requests[temp_indx].user_id.Split(',')[1]+"-CV.pdf");
                    Response.BinaryWrite(new_requests[temp_indx].file);
                    Response.End();
                }
                else
                {
                    int temp_indx = int.Parse(table_NewReq.Rows[index].ItemArray[1].ToString());
                    form_information.Visible = true;
                    string[] newInfo = Encoding.UTF8.GetString(new_modi[temp_indx].file).Split('|');

                    lbl_infoName.InnerText = newInfo[0];
                    href_loc.Attributes["href"] = newInfo[1];
                    lbl_infoDes.InnerText = newInfo[2];
                    lbl_infoPlaceType.InnerText = newInfo[3];
                    lbl_infoCity.InnerText = newInfo[4];
                    img_Place.Src= "data:image/jpg;base64,"+newInfo[5];

                }
            }
            else if(e.CommandName == "accept")
            {
                if(table_NewReq.Rows[index].ItemArray[4].ToString() == "Guidance")
                {
                    index = int.Parse(table_NewReq.Rows[index].ItemArray[1].ToString());
                    form_postNewGuider.Visible = true;
                    lbl_warning.InnerText = "are you sure to give this user guidance accessibilities?";
                    lbl_usrAsGuider.InnerText = new_requests[index].user_id.Split(',')[1];
                    _id = new_requests[index].user_id.Split(',')[0];
                    status = "G,Accept";
                }
                else
                {
                    index = int.Parse(table_NewReq.Rows[index].ItemArray[1].ToString());
                    form_postNewGuider.Visible = true;
                    lbl_warning.InnerText = "are you sure to post this changes from this guider?";
                    lbl_usrAsGuider.InnerText = new_modi[index].user_id.Split(',')[1];
                    _id = new_modi[index].user_id.Split(',')[0];
                    if (table_NewReq.Rows[index].ItemArray[4].ToString().Contains("Adding"))
                        status = "AA";
                    else
                        status = "AM";
                }
            }
            else
            {
                if (table_NewReq.Rows[index].ItemArray[4].ToString() == "Guidance")
                {
                    int temp_indx = int.Parse(table_NewReq.Rows[index].ItemArray[1].ToString());
                    _id = new_requests[temp_indx].user_id.Split(',')[0];
                    status = "G,Reject";
                    PostPermission();
                }
                else
                {
                    index = int.Parse(table_NewReq.Rows[index].ItemArray[1].ToString());
                    _id = new_modi[index].user_id.Split(',')[0];
                    if (table_NewReq.Rows[index].ItemArray[4].ToString().Contains("Adding"))
                        status = "RA";
                    else
                        status = "RM";
                    PostModification();
                }
            }
        }
        protected void Oldrequest_list_ItemCommand(object source, DataListCommandEventArgs e)
        {
            index = (int)e.Item.ItemIndex;
            if (e.CommandName == "review")
            {
                if (table_oldReq.Rows[index].ItemArray[5].ToString().Contains("Guider"))
                {
                    int temp_indx = int.Parse(table_oldReq.Rows[index].ItemArray[1].ToString());

                    Response.ContentType = "application/force-download";
                    Response.AppendHeader("Content-Disposition", "attachment;filename="+old_requests[temp_indx].user_id.Split(',')[1]+"-CV.pdf");
                    Response.BinaryWrite(old_requests[temp_indx].file);
                    Response.End();
                }
                else
                {
                    int temp_indx = int.Parse(table_oldReq.Rows[index].ItemArray[1].ToString());
                    form_information.Visible = true;
                    string[] newInfo = Encoding.UTF8.GetString(old_modi[temp_indx].file).Split('|');

                    lbl_infoName.InnerText = newInfo[0];
                    href_loc.Attributes["href"] = newInfo[1];
                    lbl_infoDes.InnerText = newInfo[2];
                    lbl_infoPlaceType.InnerText = newInfo[3];
                    lbl_infoCity.InnerText = newInfo[4];
                    img_Place.Src= "data:image/jpg;base64,"+newInfo[5];
                }
            }
        }

        protected void SubmitPermi(object sender, EventArgs e)
        {
            if (status.Split(',')[0] == "G")
            {
                PostPermission();
            }
            else if(status == "AA")
            {
                Response.Write(alert("im here"));
                PostPlace();
            }
        }

        protected void close_forms(object sender, EventArgs e)
        {
            hideForms();
        }


        /* Tools */
        private void reload()
        {
            new_requests.Clear();
            old_requests.Clear();

            new_modi.Clear();
            old_modi.Clear();

            table_NewReq.Rows.Clear();
            table_NewReq.Columns.Clear();

            table_oldReq.Rows.Clear();
            table_oldReq.Columns.Clear();

            Page.Response.Redirect(Page.Request.Url.ToString(), true);
        }

        private void setRequests()
        {
            int counter = 0;
            foreach (var req in new_requests)
            {
                table_NewReq.Rows.Add(req.id, counter, req.user_id.Split(',')[0], req.user_id.Split(',')[1], "Guidance");
                counter++;
            }

            counter = 0;
            foreach(var req in old_requests)
            {
                string s = req.req_status > 0 ? "Accepted Guider" : "Rejected Guider";
                table_oldReq.Rows.Add(req.id, counter, req.user_id.Split(',')[0], req.user_id.Split(',')[1], req.admin_id, s);
                counter++;
            }

            counter = 0;
            foreach(var modi in new_modi)
            {
                string operation = modi.operation.Contains("Add") ? "Adding Place" : "Modify Place";
                table_NewReq.Rows.Add(modi.id, counter, modi.user_id.Split(',')[0], modi.user_id.Split(',')[1], operation);
                counter++;
            }

            counter = 0;
            foreach (var modi in old_modi)
            {
                string operation = modi.operation.Contains("AA") ? "Accepted Adding" : modi.operation.Contains("RA") ? "Rejected Adding" :
                    modi.operation.Contains("AM") ? "Accepted Modifying" : "Rejected Modifying";
                table_oldReq.Rows.Add(modi.id, counter, modi.user_id.Split(',')[0], modi.user_id.Split(',')[1], modi.admin_id, operation);
                counter++;
            }
        }

        private void displayReqs()
        {
            Newrequest_list.DataSource=table_NewReq;
            Newrequest_list.DataBind();

            Oldrequest_list.DataSource=table_oldReq;
            Oldrequest_list.DataBind();
        }

        private void hideForms()
        {
            form_postNewGuider.Visible = false;
            form_information.Visible = false;
        }
        private string alert(string message)
        {
            return @"<script>alert('"+message+"');</script>";
        }


        /* API Requests */
        private async void GetRequests()
        {
            using (var client = new HttpClient())
            {
                string uri = "http://api.dalilak.pro/Query/Requests_";
                var respons = await client.GetAsync(uri);
                var result = respons.Content.ReadAsStringAsync().Result;
                var all_requests = JsonConvert.DeserializeObject<List<Request>>(result);
                foreach (var req in all_requests)
                {
                    if (req.req_status == 0)
                        new_requests.Add(req);
                    else
                        old_requests.Add(req);
                }

                uri = "http://api.dalilak.pro/Query/Modifications_";
                respons = await client.GetAsync(uri);
                result = respons.Content.ReadAsStringAsync().Result;
                var all_modifys = JsonConvert.DeserializeObject<List<Modification>>(result);
                foreach(var modi in all_modifys)
                {
                    if (modi.operation.Contains("New"))
                        new_modi.Add(modi);
                    else
                        old_modi.Add(modi);
                }

                setRequests();
                displayReqs();
            }

        }

        private async void PostPermission()
        {
            string uri = "http://api.dalilak.pro/Insert/UpdateRequest_";
            string[] body = new string[4] 
            { 
                new_requests[index].id.ToString(),
                lbl_admin.InnerText,
                _id,
                status.Split(',')[1]
            };

            var stringPayload = JsonConvert.SerializeObject(body);
            var content = new StringContent(stringPayload, Encoding.UTF8, "application/json");

            using (var client = new HttpClient())
            {
                var response = await client.PostAsync(uri, content);
            }
            HttpContext.Current.Session["notifs"] = int.Parse(HttpContext.Current.Session["notifs"].ToString()) - 1;
            reload();
        }

        private async void PostPlace()
        {
            string[] newInfo = Encoding.UTF8.GetString(new_modi[index].file).Split('|');
            string placeType = newInfo[3] == "Natural" ? "NAT" : newInfo[3] == "Historical" ? "HIS" : "VNT";
            string uri = @"http://api.dalilak.pro/Insert/Place_?"+
                          "name="+newInfo[0]+
                          "&location="+newInfo[1]+
                          "&description="+newInfo[2]+
                          "&place_type="+placeType+
                          "&cityName="+newInfo[4];

            using (var client = new HttpClient())
            {
                var response = await client.PostAsync(uri, null);
                var result = response.Content.ReadAsStringAsync().Result;

                uri = "http://api.dalilak.pro/Insert/PlaceImage_?place_id="+result.ToString();
                var stringPayload = JsonConvert.SerializeObject(new string[] {newInfo[5]});
                var content = new StringContent(stringPayload, Encoding.UTF8, "application/json");
                response = await client.PostAsync(uri, content);    
            }
            PostModification();

        }

        private async void PostModification()
        {
            using (var client = new HttpClient())
            {
                string uri = "http://api.dalilak.pro/Insert/UpdateGuiderModify_";
                string[] body = new string[4]
                {
                    new_modi[index].id.ToString(),
                    lbl_admin.InnerText,
                    _id,
                    status
                };
                var stringPayload = JsonConvert.SerializeObject(body);
                var content = new StringContent(stringPayload, Encoding.UTF8, "application/json");
                var response = await client.PostAsync(uri, content);
                HttpContext.Current.Session["notifs"] = int.Parse(HttpContext.Current.Session["notifs"].ToString()) - 1;
            }
            reload();
        }

    }

}
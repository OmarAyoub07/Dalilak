using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Net.Http;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;


namespace DalilakWeb.Views.Dashboard
{
    public partial class ManagePlaces : System.Web.UI.Page
    {
        /* Variables */
        public int rows = 0;

        private static string _id = "";

        private static List<Place> places = new List<Place>();

        private static DataTable table = new DataTable();


        /* Event Handelers */
        protected void Page_Load(object sender, EventArgs e)
        {
            // if statment to secure the website from random routing
            // logined admin will be stored at current session layer
            if (HttpContext.Current.Session["admin"] == null)
            {
                // Redirect to login page
                Response.Redirect("~//Admin");
            }
            else // if logined, assign the admin email to admin label (lbl_admin)
                lbl_admin.InnerText = HttpContext.Current.Session["admin"].ToString();

            // such as if the page is loaded for first time
            if (!IsPostBack)
            {
                // prepare the columns of table to bind with "datalist" at client-side
                // some columns will not be binded. Theses columns have different needs,
                // for example "id", to update user in database using his id
                // the admin have no permissions to see the "id"
                try
                {
                    table.Columns.Add("id");
                    table.Columns.Add("location");
                    table.Columns.Add("description");
                    table.Columns.Add("Name");
                    table.Columns.Add("Nature");
                    table.Columns.Add("City");
                }
                catch
                {
                    reload();
                }
                getPlaces();
                hideForms();
            }
        }
        protected void Places_list_ItemCommand(object source, DataListCommandEventArgs e)
        {
            int row_Index = (int)e.Item.ItemIndex;

            // else if statments (Which command call me)?
            if (e.CommandName == "editing")
            {
                hideForms();
                var temp_place = places.Single(plc => plc.name ==  table.Rows[row_Index][3].ToString());
                form_editPlace.Visible = true;
                lbl_editPlace.InnerText = temp_place.name;
                _id = places[row_Index].id;
                txt_editName.Attributes.Add("Placeholder", temp_place.name);
                txt_editLoc.Attributes.Add("Placeholder", temp_place.location);
                txt_editInfo.Attributes.Add("Placeholder", temp_place.description);
                txt_editCity.Attributes.Add("Placeholder", temp_place.city_id);
                rdioLst_EditNature.SelectedIndex = temp_place.place_type == "NAT" ? 0 :
                                                   temp_place.place_type == "HIS" ? 1 : 2;

            }
            else if (e.CommandName == "removing")
            {
                using (var client = new HttpClient())
                {
                    var temp_place = places.Single(plc => plc.name ==  table.Rows[row_Index][3].ToString());
                    //string uri = "http://api.dalilak.pro/Drop/Place_?id="+temp_place.id;
                    //var response = await client.PostAsync(uri, null);
                    Response.Write(alert("This Function is Disabled...")/*response.Content.ReadAsStringAsync().Result*/);
                    //reload();
                }
            }
            else if (e.CommandName == "Adding")
            {
                hideForms();
                form_addPlace.Visible = true;
            }
            else if (e.CommandName == "addImage")
            {
                hideForms();
                form_addImage.Visible = true;
                _id = places[row_Index].id;
            }
            else
            {
                hideForms();
                form_information.Visible=true;
                var temp_place = places.Single(plc => plc.name ==  table.Rows[row_Index][3].ToString());
                _id= temp_place.id;
                GetOnePlace(temp_place);
            }
        }
        protected void searchPlaces(object sender, EventArgs e)
        {
            // clear table ro add filtered results to it
            table.Rows.Clear();

            // if the user select an item from drop down liast, cahnge the text of the drop down list
            drpDwn_city.Text = drpLst_city.SelectedItem.Text == "All" ? "Select City" : drpLst_city.SelectedItem.Text;
            drpDwn_Places.Text = drpLst_Places.SelectedItem.Text == "All" ? "Select Place Type" : drpLst_Places.SelectedItem.Text;

            // Search Operation
            // such as (SELECT * FROM places Where name LIKE '%text%' ... etc)
            var filtered = places.Select(place =>
                        (place.name.Contains(txt_search.Text)
                        || place.city_id.Contains(txt_search.Text))
                        && (drpLst_city.SelectedItem.Text != "All" ? place.city_id.Contains(drpLst_city.SelectedItem.Text) : place.city_id.Contains(""))
                        && (drpLst_Places.SelectedItem.Text == "All" ? place.place_type.Equals(place.place_type) :
                        place.place_type.Equals(drpLst_Places.SelectedItem.Value))
                        );

            // Filter Operation
            int index = 0;
            foreach (var item in filtered)
            {
                // if row match the filtered result
                if (item == true)
                {
                    // set one place to the table
                    setPlace(places[index]);
                }
                // counter will move throu all places
                index++;
            }
            displayplaces();
        }
        protected void SubmitPlace(object sender, EventArgs e)
        {
            var ob = sender as Button;
            if (img_new.HasFile && ob.Text != "Edit")
            {
                PostPlace(
                    txt_addName.Text,
                    txt_addLoc.Text,
                    txt_addInfo.Text,
                    rdioLst_AddNature.SelectedValue,
                    txt_addCity.Text,
                    img_new.PostedFile.InputStream
                            );
            }
            else if(ob.Text == "Edit")
            {
                UpdatePlace(
                    _id,
                    txt_editName.Text,
                    txt_editLoc.Text,
                    txt_editInfo.Text,
                    rdioLst_EditNature.SelectedValue,
                    txt_editCity.Text
                    );
            }
        }
        protected void UploadImage(object sender, EventArgs e)
        {
            if (img_file.HasFile)
            {
                string[] base64String = convertImage(img_file.PostedFile.InputStream);
                uploadedImage.Src = "data:image/jpg;base64,"+ base64String[0];
                PostImage(base64String);
            }

        }
        protected void logOut(object sender, EventArgs e)
        {
            HttpContext.Current.Session["admin"] = null;
            Response.Redirect("~//Admin");
        }
        protected void close_forms(object sender, EventArgs e)
        {
            hideForms();
        }


        /* Tools */
        private void setPlaces()
        {
            foreach (var place in places)
            {
                string plcNature = place.place_type == "NAT" ? "Natural" : place.place_type == "VNT" ? "Event" : "Historical";
                table.Rows.Add(place.id, place.location, place.description, place.name, plcNature, place.city_id);
            }
        }
        private void setPlace(Place place)
        {
            string plcNature = place.place_type == "NAT" ? "Natural" : place.place_type == "VNT" ? "Event" : "Historical";
            table.Rows.Add(place.id, place.location, place.description, place.name, plcNature, place.city_id);
        }
        private void displayplaces()
        {
            Places_list.DataSource=table;
            Places_list.DataBind();
        }
        private string alert(string message)
        {
            return @"<script>alert('"+message+"');</script>";
        }
        private void hideForms()
        {
            form_addImage.Visible = false;
            form_addPlace.Visible = false;
            form_editPlace.Visible = false;
            form_information.Visible=false;
        }
        private string[] convertImage(Stream st)
        {
            // Convert to binary
            BinaryReader br = new BinaryReader(st);

            // Read bytes
            byte[] image = br.ReadBytes((Int32)st.Length);

            // Convert it to base64String
            string[] base64String = new string[] { Convert.ToBase64String(image, 0, image.Length) };
            return base64String;
        }
        private void reload()
        {
            places.Clear();
            table.Rows.Clear();
            table.Columns.Clear();
            Page.Response.Redirect(Page.Request.Url.ToString(), true);
        }

        /* Api Requests */
        private async void getPlaces()
        {
            string uri = "http://api.dalilak.pro/Query/Cities_";


            using (var client = new HttpClient())
            {
                // Get All cities
                var respons = await client.GetAsync(uri);
                var result = respons.Content.ReadAsStringAsync().Result;
                var cities = JsonConvert.DeserializeObject<List<City>>(result);

                foreach (var city in cities)
                {
                    drpLst_city.Items.Add(city.name);

                    // get request uri - to get users
                    uri = "http://api.dalilak.pro/query/Places_?city_id="+city.id+"&place_type=NAT";
                    // get request from api
                    respons = await client.GetAsync(uri);

                    result = respons.Content.ReadAsStringAsync().Result;

                    // convert result to list of users
                    var places1 = JsonConvert.DeserializeObject<List<Place>>(result);

                    // 2
                    uri = "http://api.dalilak.pro/query/Places_?city_id="+city.id+"&place_type=HIS";

                    respons = await client.GetAsync(uri);
                    result = respons.Content.ReadAsStringAsync().Result;
                    var places2 = JsonConvert.DeserializeObject<List<Place>>(result);

                    // 3
                    uri = "http://api.dalilak.pro/query/Places_?city_id="+city.id+"&place_type=VNT";

                    respons = await client.GetAsync(uri);
                    result = respons.Content.ReadAsStringAsync().Result;
                    var places3 = JsonConvert.DeserializeObject<List<Place>>(result);

                    foreach (Place place in places1)
                        places.Add(place);
                    foreach (Place place in places2)
                        places.Add(place);
                    foreach (Place place in places3)
                        places.Add(place);
                }

                setPlaces();
                displayplaces();
            }
        }
        private async void PostPlace(string name, string location, string des, string plcType, string city, Stream file)
        {
            using (var client = new HttpClient())
            {
                string uri = @"http://api.dalilak.pro/Insert/Place_?"
                             +"name="+name+"&location="+location+"&cityName="+city
                             +"&description="+des+"&place_type="+plcType;
                var respons = await client.PostAsync(uri, null);
                _id = respons.Content.ReadAsStringAsync().Result;

                string[] base64String = convertImage(file);
                PostImage(base64String);
                reload();

            }
        }
        private async void UpdatePlace(string id, string name, string location, string des, string place_type, string cityName)
        {
            string uri = "http://api.dalilak.pro/Insert/UpdatePlace?id="+id;
            if (name.Length > 3)
                uri += "&name="+name;
            if (location.Contains("https"))
                uri += "&location="+location;
            if (des.Length > 10)
                uri += "&des="+des;
            if (place_type.Length == 3)
                uri += "&place_type="+place_type;
            if (cityName.Length > 2)
                uri += "&CityName="+cityName;

            using (var client = new HttpClient())
            {
                var response = await client.PostAsync(uri, null);
                Response.Write(alert("Edit: "+ response.Content.ReadAsStringAsync().Result));
                reload();
            }
        }
        private async void PostImage(string[] base64String)
        {
            using (var client = new HttpClient())
            {
                string s_uri = "http://api.dalilak.pro/Insert/PlaceImage_?place_id="+_id.ToString();
                Uri uri = new Uri(s_uri);

                var stringPayload = JsonConvert.SerializeObject(base64String);
                var content = new StringContent(stringPayload, Encoding.UTF8, "application/json");

                var respon = await client.PostAsync(uri, content);
            }
        }
        private async void GetOnePlace(Place place)
        {
            string uri = "http://api.dalilak.pro/Query/PlaceImage_?place_id="+_id;
            using (var client = new HttpClient())
            {
                var respon = await client.GetAsync(uri);
                var result = respon.Content.ReadAsStringAsync().Result;
                img_Place.Src = "data:image/jpg;base64,"+result;
                lbl_infoName.InnerText = place.name;
                href_loc.Attributes.Add("href", place.location);
                lbl_infoCity.InnerText = place.city_id;
                lbl_infoPlaceType.InnerText = place.place_type == "NAT" ? "Natural" :
                                              place.place_type == "HIS" ? "Historical" : "Event";
                lbl_infoDes.InnerText = place.description;
            }
        }


    }
}
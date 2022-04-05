using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Net.Http;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace DalilakWeb.Views.Dashboard
{
    public partial class ManageUsers : System.Web.UI.Page
    {

        /* Declare Variables */

        // Rows Counter for table
        public int rows=0;

        // List to store incoimg data from database (When client execute post request)
        // Useful to do seach operations at application layer rather than database layer
        private static List<User> users = new List<User>();

        // Variable will store filtered results from users list
        // static leads to have no changes if the page refreshed
        private static DataTable table = new DataTable();


        /* Declare function of events (7 functions as Event Handlers) */

        // 1- Event Executed when any client load the page
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
                    table.Columns.Add("Name");
                    table.Columns.Add("Email");
                    table.Columns.Add("Phone");
                    table.Columns.Add("City");
                    table.Columns.Add("Accessibility");
                    table.Columns.Add("age");
                    table.Columns.Add("Bio");
                }
                catch(Exception err)
                {
                    reload();
                }

                // Get Request to get all users to "users" variable
                getUsers();
                // Set all users to "table", and prepare the data to be displayed
                setUsers();
                // bind datatabe "table", with datalist "users_list", then display them
                displayUsers();

                // forms are hidden until the user want to use them
                form_edit.Visible = false;
                form_add.Visible = false;
                form_info.Visible = false;

                // user id hidden to the admin
                hidden_userId.Visible = false;
            }         
        }


        // 2- Datalist Events (Onclick Buttons (edit - remove - info - add))
        // the operations can be catched by getting e.CommandName
        // Command names are defined in client-side
        protected void dListUsers_ItemCommand(object sender, DataListCommandEventArgs e)
        {
            // get index of row, (from where did i get the command)?
            int row_Index = (int)e.Item.ItemIndex;

            // else if statments (Which command call me)?
            if (e.CommandName == "editing")
            {
                // Show Edit form and disable others
                form_edit.Visible = true;
                form_add.Visible = false;
                form_info.Visible = false;

                // prepare old data for admin

                // user name
                lbl_userCard.InnerText = table.Rows[row_Index][1].ToString();

                // select radio item (if guider select item[0])
                rdioLst_acsbilty.SelectedIndex = (table.Rows[row_Index][5].ToString() == "Guider" ? 0 : 1);

                // old email and phone  as place holder in textBox
                txt_editEmail.Attributes.Add("Placeholder", table.Rows[row_Index][2].ToString());
                txt_editPhone.Attributes.Add("Placeholder", table.Rows[row_Index][3].ToString());

                // user id to post changes to api then database
                hidden_userId.InnerText = table.Rows[row_Index][0].ToString();
            }
            else if(e.CommandName == "removing")
            {
                // Remove User Operation

                // post request to delete user from database
                //*deleteUser(table.Rows[row_Index][0].ToString());

                // remove user from application layer table
                //*table.Rows.RemoveAt(row_Index);

                // refresh tabel
                //*displayUsers();

                Response.Write(alert("This Function Is Disabled..."));
            }
            else if(e.CommandName == "Adding")
            {
                // Show Add form
                form_add.Visible = true;
                form_edit.Visible = false;
                form_info.Visible = false;
            }
            else
            {
                // Show information of selected User
                form_info.Visible = true;
                form_edit.Visible = false;
                form_add.Visible = false;

                // Display user information
                var temp_user = users.Single(user => user.email == table.Rows[row_Index][2].ToString());
                lbl_infoName.InnerText = table.Rows[row_Index][1].ToString();
                lbl_infoEmail.InnerText = table.Rows[row_Index][2].ToString();
                lbl_infoPhone.InnerText = table.Rows[row_Index][3].ToString();
                lbl_infoCity.InnerText = table.Rows[row_Index][4].ToString();
                lbl_infoIsGuider.InnerText = table.Rows[row_Index][5].ToString();
                lbl_infoAge.InnerText = temp_user.age.ToString();
                lbl_infoBio.InnerText = temp_user.information.ToString();
                displayAvatar(table.Rows[row_Index][0].ToString());
            }

        }


        // 3- Event on user search (click Enter or search button)
        // Function responsible to filter the result for the admin
        protected void searchUsers(object sender, EventArgs e)
        {
            // clear table ro add filtered results to it
            table.Rows.Clear();

            // if the user select an item from drop down liast, cahnge the text of the drop down list
            drpDwn_city.Text = drpLst_city.SelectedItem.Text == "All" ? "Select City" : drpLst_city.SelectedItem.Text;
            drpDwn_user.Text = drpLst_user.SelectedItem.Text == "All" ? "Select Accessibility" : drpLst_user.SelectedItem.Text;


            // Search Operation
            // such as (SELECT * FROM users Where name LIKE '%text%' ... etc)
            var filtered = users.Select(user => 
                        (  user.name.Contains(txt_search.Text)
                        || user.email.Contains(txt_search.Text)
                        || user.phone_num.Contains(txt_search.Text))
                        && (drpLst_city.SelectedItem.Text != "All" ? user.city_id.Contains(drpLst_city.SelectedItem.Text) : user.city_id.Contains(""))
                        && (drpLst_user.SelectedItem.Text == "All" ? user.user_type.Equals(user.user_type) : drpLst_user.SelectedItem.Text == "Tourist" ? user.user_type.Equals(false) : user.user_type.Equals(true))
                        );


            // Filter Operation
            int index = 0;
            foreach (var item in filtered)
            {
                // if row match the filtered result
                if (item == true)
                {
                    // set one user to the table
                    setUsers(users[index]);
                }
                // counter will move throu all users
                index++;
            }
            displayUsers();
        }


        // 4- event executed if the user click on post new user
        protected void post_AddUser(object sender, EventArgs e)
        {
            // uri required to post request, with setting values of parameters (name, phone, and email)
            string uri = "http://api.dalilak.pro/Insert/NewUser_?name="+txt_addName.Text+"&phone="+txt_addPhone.Text+"&email="+txt_addEmail.Text;


            using (var client = new HttpClient())
            {
                // post request to api
                var respons = client.PostAsync(uri, null);

                if (respons.Result.Content.ReadAsStringAsync().Result == "true")
                {
                    Response.Write(alert("User added to system Successfuly!"));
                    reload();
                }
                else
                    Response.Write(alert("Post Failed!"));

            }
        }


        // 5- function executed if the user click on cancel button
        protected void close_forms(object sender, EventArgs e)
        {
            form_edit.Visible = false;
            form_add.Visible = false;
            form_info.Visible = false;
        }


        // 6- function executed if the user click ib post edit
        protected void post_editedUser(object sender, EventArgs e)
        {
            // post request uri
            string uri = "http://api.dalilak.pro/insert/UpdateUser_?id="+hidden_userId.InnerText+"&userType="+rdioLst_acsbilty.SelectedValue;

            // minimum lenght of email == 10
            if (txt_editEmail.Text.Length > 10)
            {
                uri +="&email="+txt_editEmail.Text;
            }

            // max length of phone number == 9, and must to be 9 not lower or higher
            if (txt_editPhone.Text.Length == 9)
            {
                uri += "&phone="+txt_editPhone.Text;
            }

            // post request to api
            using (var client = new HttpClient())
            {
                var respons = client.PostAsync(uri, null);
                if (respons.Result.Content.ReadAsStringAsync().Result == "true")
                {
                    Response.Write(alert("Posted Successfuly!"));
                    // Reload page
                    reload();
                }
                else
                    Response.Write(alert("Post Failed!"));

            }
        }


        // 7- Logout function
        protected void logOut(object sender, EventArgs e)
        {
            HttpContext.Current.Session["admin"] = null;
            Response.Redirect("~//Admin");
        }


        /* Declare tools (8 function as tools)*/

        // 1- get users from database
        private void getUsers()
        {
            // get request uri - to get users
            string uri = "http://api.dalilak.pro/query/users_";

            using (var client = new HttpClient())
            {
                // get request from api
                var respons = client.GetAsync(uri);

                var result = respons.Result.Content.ReadAsStringAsync().Result;

                // convert result to list of users
                users = JsonConvert.DeserializeObject<List<User>>(result);

                // uri to get cities
                uri = "http://api.dalilak.pro/query/cities_";

                respons = client.GetAsync(uri);

                var cities = respons.Result.Content.ReadAsStringAsync().Result;

                // temporary list - the use of this list is to replace city_id at users list to their cities names.
                List<City> citiesList = JsonConvert.DeserializeObject<List<City>>(cities);

                // set cities name to drop down list - help the admin to filter the results
                foreach (var city in citiesList)
                { 
                    drpLst_city.Items.Add(city.name);
                }

                // replace city_id to city_name
                foreach (var user in users)
                {
                    string userCity = "-";
                    // in case if the user doesn't set his city in the database
                    if (citiesList.Any(city => city.id == user.city_id))
                        userCity = citiesList.Single(city => city.id == user.city_id).name;
                    user.city_id = userCity;
                }
            }
        }

        // 2- add users to datalist
        private void setUsers()
        {
            foreach (var user in users)
            {
                string isGuider = user.user_type == true ? "Guider" : "Tourist";
                table.Rows.Add(user.id, user.name, user.email, user.phone_num, user.city_id, isGuider, user.age, user.information);
            }
        }

        // 3- add one user to datalist 
        private void setUsers(User user)
        {
            string isGuider = user.user_type == true ? "Guider" : "Tourist";
            table.Rows.Add(user.id, user.name, user.email, user.phone_num, user.city_id, isGuider);
        }

        // 4- Bind and display users
        private void displayUsers()
        {
            users_list.DataSource=table;
            users_list.DataBind();
        }

        // 5- post Request to delete user from database
        private void deleteUser(string id)
        {
            string uri = "http://api.dalilak.pro/Drop/User_?id="+id;
            using (var client = new HttpClient())
            {
                var respons = client.PostAsync(uri, null);

                string isDeleted = respons.Result.Content.ReadAsStringAsync().Result;
                
                isDeleted = isDeleted == "true" ? "The user has been removed!!" : "The user not removed";

                Response.Write(alert(isDeleted));
            }
        }

        // 6- popup window to show specific message
        private string alert(string message)
        {
            return @"<script>alert('"+message+"');</script>";
        }

        // 7- Reaload the page and reset static variables
        private void reload()
        {
            users.Clear();
            table.Rows.Clear();
            table.Columns.Clear();
            Page.Response.Redirect(Page.Request.Url.ToString(), true);
        }

        // 8- display user avatar
        private void displayAvatar(string user_id)
        {
            string uri = "http://api.dalilak.pro/Query/ProfileImage_?id="+user_id;
            using (var client = new HttpClient())
            {
                var response = client.GetAsync(uri);
                img_avatar.Src = "data:image/png;base64," + response.Result.Content.ReadAsStringAsync().Result;
            }
        }

    }
}
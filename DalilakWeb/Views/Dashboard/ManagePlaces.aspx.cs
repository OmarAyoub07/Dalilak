using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;


namespace DalilakWeb.Views.Dashboard
{
    public partial class ManagePlaces : System.Web.UI.Page
    {
        public int rows = 0;


        // Variable will store filtered results from users list
        // static leads to have no changes if the page refreshed
        private static DataTable table = new DataTable();
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
             }  
        }
        protected void logOut(object sender, EventArgs e)
        {

        }
        protected void searchPlaces(object sender, EventArgs e)
        {

        }
        protected void Places_list_ItemCommand(object source, DataListCommandEventArgs e)
        {

        }
    }
}
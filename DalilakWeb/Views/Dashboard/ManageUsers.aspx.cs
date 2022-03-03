using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace DalilakWeb.Views.Dashboard
{
    public partial class ManageUsers : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            DataTable table = new DataTable();
            table.Columns.Add("ID");
            table.Columns.Add("Name");
            table.Columns.Add("Email");
            table.Rows.Add("101", "Sachin Kumar", "sachin@example.com");
            table.Rows.Add("102", "Peter", "peter@example.com");
            table.Rows.Add("103", "Ravi Kumar", "ravi@example.com");
            table.Rows.Add("104", "Irfan", "irfan@example.com");
            users_list.DataSource = table;
            users_list.DataBind();
        }
    }
}
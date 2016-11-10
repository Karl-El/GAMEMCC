using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Net;
using System.Configuration;

namespace Construction_Asset_Management_System
{
    public partial class Client : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void _btnAdd_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Client_CRUD.aspx");
        }
        protected void _btnSearch_Click(object sender, EventArgs e)
        {
            _btnShowList.Visible = true;
            string Search = null;
            
            DataSourceClient.SelectParameters.Clear();
            if (IsPostBack)
            {
                Search = _txtSearch.Text.Trim();
                DataSourceClient.SelectParameters.Add("Search", Search);
                DataSourceClient.SelectCommand = "SELECT * FROM CLIENT WHERE CLIENTNAME like'%'+@Search+'%' OR CLIENTADDR like'%'+@Search+'%' OR CLIENTCITY like'%'+@Search+'%' OR CLIENTPROV like'%'+@Search+'%' OR CLIENTEMAIL like'%'+@Search+'%' OR CLIENTCELL like'%'+@Search+'%' OR CLIENTTEL like'%'+@Search+'%'";
                DataSourceClient.DataBind();
                _listviewClient.DataBind();
            }

        }
        protected void _btnShowList_Click(object sender, EventArgs e)
        {
            _btnShowList.Visible = false;
            Response.Redirect("~/Client.aspx");
        }
        protected void _listviewClient_ItemDeleted(object sender, ListViewDeletedEventArgs e)
        {
            ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('Record Deleted')", true);
            Response.Redirect("~/Client.aspx");
        }

        protected void _listviewClient_ItemDeleting(object sender, ListViewDeleteEventArgs e)
        {
            string ClientID = e.Keys[0].ToString().Trim();
            String Conn = ConfigurationManager.ConnectionStrings["ConnString_WEB_ASSET_DB"].ConnectionString;
            SqlConnection Connect = new SqlConnection(Conn);
            Connect.Open();
            SqlCommand Cmd = new SqlCommand("SELECT COUNT (*) FROM CLIENTSTAFF WHERE CLIENTID=@ClientID", Connect);
            Cmd.Parameters.AddWithValue("@ClientID", ClientID);
            Int32 Count = (Int32)Cmd.ExecuteScalar();
            if (Count > 0)
            {
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('Record is use, Unable to delete')", true);
                e.Cancel = true;

            }
            Connect.Close();
            Connect.Open();
            Cmd = new SqlCommand("SELECT COUNT (*) FROM PROJECT WHERE CLIENTID=@ClientID", Connect);
            Cmd.Parameters.AddWithValue("@ClientID", ClientID);
            Count = (Int32)Cmd.ExecuteScalar();
            if (Count > 0)
            {
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('Client has/have a project, Unable to delete')", true);
                e.Cancel = true;

            }
            Connect.Close();
        }
    }
}
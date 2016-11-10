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
    public partial class ClientStaff : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void _listviewClientStaff_ItemDeleted(object sender, ListViewDeletedEventArgs e)
        {
            string scriptText = "alert('Record Deleted'); window.location='" + Request.ApplicationPath + "ClientStaff.aspx'";
            ScriptManager.RegisterStartupScript(this, this.GetType(), "alertMessage", scriptText, true);
        }
        protected void _btnAdd_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/ClientStaff_CRUD.aspx");
        }

        protected void _btnShowList_Click(object sender, EventArgs e)
        {
            _btnShowList.Visible = false;
            Response.Redirect("~/ClientStaff.aspx");
        }

        protected void _btnSearch_Click(object sender, EventArgs e)
        {
            _btnShowList.Visible = true;
            string Search = null;
            DataSourceClientStaff.SelectParameters.Clear();
            if (IsPostBack)
            {
                Search = _txtSearch.Text.Trim();
                DataSourceClientStaff.SelectParameters.Add("Search", Search);
                DataSourceClientStaff.SelectCommand = "SELECT [CLIENTSTAFFID], [CLIENTSTAFFFNAME], [CLIENTSTAFFLNAME], [CLIENTSTAFFTEL], [CLIENTSTAFFCELL], [CLIENTSTAFFSTATUS], CLIENTSTAFF.CLIENTID, CLIENT.CLIENTNAME  FROM CLIENTSTAFF INNER JOIN CLIENT ON CLIENTSTAFF.CLIENTID = CLIENT.CLIENTID WHERE CLIENTSTAFFFNAME like'%'+@Search+'%' OR CLIENTSTAFFLNAME like'%'+@Search+'%' OR CLIENTSTAFFEMAIL like'%'+@Search+'%' OR CLIENTSTAFFPOSITION like'%'+@Search+'%' OR CLIENTNAME like'%'+@Search+'%' OR CLIENTSTAFFSTATUS like'%'+@Search+'%'";
                DataSourceClientStaff.DataBind();
                _listviewClientStaff.DataBind();
            }

        }

        protected void _listviewClientStaff_ItemDeleting(object sender, ListViewDeleteEventArgs e)
        {
            String Conn = ConfigurationManager.ConnectionStrings["ConnString_WEB_ASSET_DB"].ConnectionString;
            SqlConnection Connect = new SqlConnection(Conn);
            string ClientStaffID = e.Keys[0].ToString().Trim();

            Connect.Open();
            SqlCommand Cmd = new SqlCommand("SELECT COUNT (*) FROM PROJECT WHERE  CLNTPROJCONTID=@ClientStaffID OR CLNTPROJPREPID=@ClientStaffID OR CLNTPROJAPPID=@ClientStaffID", Connect);
            Cmd.Parameters.AddWithValue("@ClientStaffID", ClientStaffID);
            Int32 Count = (Int32)Cmd.ExecuteScalar();
            if (Count > 0)
            {
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('Record is in  use, Unable to delete')", true);
                e.Cancel = true;
            }
        }
    }
}
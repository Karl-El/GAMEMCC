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
    public partial class CompanyStaff : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void _listviewCompanyStaff_ItemDeleted(object sender, ListViewDeletedEventArgs e)
        {
            ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('Record Deleted')", true);
        }

        protected void _btnAdd_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/CompanyStaff_CRUD.aspx");
        }

        protected void _btnShowList_Click(object sender, EventArgs e)
        {
            _btnShowList.Visible = false;
            Response.Redirect("~/CompanyStaff.aspx");
        }
         protected void _btnSearch_Click(object sender, EventArgs e)
        {
            _btnShowList.Visible = true;
            string Search = null;

            DataSourceCompanyStaff.SelectParameters.Clear();
            if (IsPostBack)
            {
                Search = _txtSearch.Text.Trim();
                DataSourceCompanyStaff.SelectParameters.Add("Search", Search);
                DataSourceCompanyStaff.SelectCommand = "SELECT [COMSTAFFID], [COMSTAFFFRSTNAME], [COMSTAFFLASTNAME], [COMSTAFFPOSITION] FROM COMPANYSTAFF WHERE COMSTAFFFRSTNAME like'%'+@Search+'%' OR COMSTAFFLASTNAME like'%'+@Search+'%' OR COMSTAFFPOSITION like'%'+@Search+'%' ";
                DataSourceCompanyStaff.DataBind();
                _listviewCompanyStaff.DataBind();
            }

        }

         protected void _listviewCompanyStaff_ItemDeleting(object sender, ListViewDeleteEventArgs e)
         {


             String Conn = ConfigurationManager.ConnectionStrings["ConnString_WEB_ASSET_DB"].ConnectionString;
             SqlConnection Connect = new SqlConnection(Conn);
             string ClientStaffID = e.Keys[0].ToString().Trim();

             Connect.Open();
             SqlCommand Cmd = new SqlCommand("SELECT COUNT (*) FROM PROJECT WHERE  CNTRCTRPROJRECEIID=@ClientStaffID OR CNTRCTRPROJAPPID=@ClientStaffID", Connect);
             Cmd.Parameters.AddWithValue("@ClientStaffID", ClientStaffID);
             Int32 Count = (Int32)Cmd.ExecuteScalar();
             if (Count > 0)
             {
                 ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('Record is in use, Unable to delete')", true);
                 e.Cancel = true;
             }
         }
    }
}
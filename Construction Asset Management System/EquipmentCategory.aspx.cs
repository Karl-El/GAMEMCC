using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Construction_Asset_Management_System
{
    public partial class EquipmentCategory : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void _btnAdd_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/EquipmentCategory_CRUD.aspx");
        }

        protected void _btnSearch_Click(object sender, EventArgs e)
        {
            _btnShowList.Visible = true;
            string Search = null;

            DataSourceEquipCtgry.SelectParameters.Clear();
            if (IsPostBack)
            {
                Search = _txtSearch.Text.Trim();
                DataSourceEquipCtgry.SelectParameters.Add("Search", Search);
                DataSourceEquipCtgry.SelectCommand = "SELECT [EQUIPCTGRYID], [EQUIPCTGRYNAME], [EQUIPCTGRYDESC] FROM [EQUIPCTGRY] WHERE EQUIPCTGRYID like'%'+@Search+'%'  OR EQUIPCTGRYNAME like'%'+@Search+'%' OR EQUIPCTGRYDESC like'%'+@Search+'%'";
                DataSourceEquipCtgry.DataBind();
                _listviewEquipCtgry.DataBind();
            }

        }

        protected void _btnShowList_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/EquipmentCategory.aspx");
            _btnShowList.Visible = false;
        }

        protected void _listviewEquipCtgry_ItemDeleted(object sender, ListViewDeletedEventArgs e)
        {
            string scriptText = "alert('Record Deleted'); window.location='" + Request.ApplicationPath + "MaterialCategory.aspx'";
            ScriptManager.RegisterStartupScript(this, this.GetType(), "alertMessage", scriptText, true);
        }

        protected void _listviewEquipCtgry_ItemDeleting(object sender, ListViewDeleteEventArgs e)
        {
            String Conn = ConfigurationManager.ConnectionStrings["ConnString_WEB_ASSET_DB"].ConnectionString;
            SqlConnection Connect = new SqlConnection(Conn);
            string EquipCatID = e.Keys[0].ToString().Trim();

            Connect.Open();
            SqlCommand Cmd = new SqlCommand("SELECT COUNT (*) FROM EQUIPMENT WHERE EQUIPCTGRYID=@EquipCatID", Connect);
            Cmd.Parameters.AddWithValue("@EquipCatID", EquipCatID);
            Int32 Count = (Int32)Cmd.ExecuteScalar();
            if (Count > 0)
            {
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('Record is in use, Unable to delete')", true);
                e.Cancel = true;

            }
        }
    }
}
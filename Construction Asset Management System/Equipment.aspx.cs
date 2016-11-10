using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Construction_Asset_Management_System
{
    public partial class Equipment : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void _btnAdd_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Equipment_CRUD.aspx");
        }

        protected void _btnSearch_Click(object sender, EventArgs e)
        {
            _btnShowList.Visible = true;
            string Search = null;
            DataSourceEquipment.SelectParameters.Clear();
            if (IsPostBack)
            {
                Search = _txtSearch.Text.Trim();
                DataSourceEquipment.SelectParameters.Add("Search", Search);
                DataSourceEquipment.SelectCommand = "SELECT  EQUIPMENTID, EQUIPMENTNAME, EQUIPMENTDESC, EQUIPMENTIMG, EQUIPMENT.EQUIPCTGRYID, EQUIPCTGRY.EQUIPCTGRYNAME FROM [EQUIPMENT] JOIN  EQUIPCTGRY ON EQUIPMENT.EQUIPCTGRYID = EQUIPCTGRY.EQUIPCTGRYID WHERE EQUIPMENTNAME like'%'+@Search+'%' OR EQUIPMENTDESC like'%'+@Search+'%'  OR EQUIPCTGRYNAME like'%'+@Search+'%'";
                DataSourceEquipment.DataBind();
                _listviewEquipment.DataBind();
            }
        }

        protected void _btnShowList_Click(object sender, EventArgs e)
        {
            _btnShowList.Visible = false;
            Response.Redirect("~/Equipment.aspx");
        }

        protected void _listviewEquipment_ItemDeleted(object sender, ListViewDeletedEventArgs e)
        {
            ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('Record Deleted')", true);
            Response.Redirect("~/Equipment.aspx");
        }
    }
}
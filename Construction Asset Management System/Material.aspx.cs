using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Construction_Asset_Management_System
{
    public partial class Material : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void _btnAdd_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Material_CRUD.aspx");
        }

        protected void _btnSearch_Click(object sender, EventArgs e)
        {
            _btnShowList.Visible = true;
            string Search = null;
            DataSourceMaterial.SelectParameters.Clear();
            if (IsPostBack)
            {
                Search = _txtSearch.Text.Trim();
                DataSourceMaterial.SelectParameters.Add("Search", Search);
                DataSourceMaterial.SelectCommand = "SELECT [MATERIALID], [MATERIALNAME], [MATERIALDESC], [MATERIALIMG], MATERIAL.MATERIALCTGRYID, MATERIALCTGRY.MATERIALCTGRYNAME FROM [MATERIAL] JOIN  MATERIALCTGRY ON MATERIALCTGRY.MATERIALCTGRYID = MATERIAL.MATERIALCTGRYID WHERE MATERIALNAME like'%'+@Search+'%' OR MATERIALDESC like'%'+@Search+'%'  OR MATERIALCTGRYNAME like'%'+@Search+'%'";
                DataSourceMaterial.DataBind();
                _listviewMaterial.DataBind();
            }
        }

        protected void _btnShowList_Click(object sender, EventArgs e)
        {
            _btnShowList.Visible = false;
            Response.Redirect("~/Material.aspx");
        }

        protected void _listviewMaterial_ItemDeleted(object sender, ListViewDeletedEventArgs e)
        {
            ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('Record Deleted')", true);
            Response.Redirect("~/Material.aspx");
        }
    }
}
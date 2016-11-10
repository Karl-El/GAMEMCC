using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using System.Data;
using System.Configuration;
using System.Data.SqlClient;
using System.Text.RegularExpressions;

namespace Construction_Asset_Management_System
{
    public partial class MaterialCategory : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            
        }

        protected void _btnAdd_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/MaterialCategory_CRUD.aspx");
        }

        protected void _btnSearch_Click(object sender, EventArgs e)
        {
            _btnShowList.Visible = true;
            string Search = null;
            DataSourceMaterialCtgry.SelectParameters.Clear();
            if (IsPostBack)
            {
                Search = _txtSearch.Text.Trim();
                DataSourceMaterialCtgry.SelectParameters.Add("Search", Search);
                DataSourceMaterialCtgry.SelectCommand = "SELECT * FROM MATERIALCTGRY WHERE MATERIALCTGRYNAME like'%'+@Search+'%'  OR MATERIALCTGRYDESC like'%'+@Search+'%'";
                DataSourceMaterialCtgry.DataBind();
                _listviewMtrlCtgry.DataBind();
            }
        }

        protected void _btnShowList_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/MaterialCategory.aspx");
            _btnShowList.Visible = false;
        }

        protected void _listviewMtrlCtgry_ItemDeleted(object sender, ListViewDeletedEventArgs e)
        {
            string scriptText = "alert('Record Deleted'); window.location='" + Request.ApplicationPath + "MaterialCategory.aspx'";
            ScriptManager.RegisterStartupScript(this, this.GetType(), "alertMessage", scriptText, true);
        }

   }
}
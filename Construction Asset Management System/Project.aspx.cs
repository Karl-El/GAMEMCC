using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Construction_Asset_Management_System
{
    public partial class datasetProject : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void _listviewWorker_ItemDeleted(object sender, ListViewDeletedEventArgs e)
        {
            ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('Record Deleted')", true);
        }
        protected void _btnAdd_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Project_CRUD.aspx");
        }

        protected void _btnShowList_Click(object sender, EventArgs e)
        {
            _btnShowList.Visible = false;
            Response.Redirect("~/Project.aspx");
        }
        protected void _btnSearch_Click(object sender, EventArgs e)
        {
            _btnShowList.Visible = true;
            string Search = null;
            DataSourceProject.SelectParameters.Clear();
            if (IsPostBack)
            {
                Search = _txtSearch.Text.Trim();
                DataSourceProject.SelectParameters.Add("Search", Search);
                DataSourceProject.SelectCommand = "SELECT [PROJID], [PROJNAME], [PROJSITE], PROJECT.CLIENTID, CLIENT.CLIENTNAME FROM [PROJECT] INNER JOIN CLIENT ON CLIENT.CLIENTID=PROJECT.CLIENTID WHERE PROJID like'%'+@Search+'%' OR PROJNAME like'%'+@Search+'%' OR PROJSITE like'%'+@Search+'%' OR CLIENTNAME like'%'+@Search+'%'";
                DataSourceProject.DataBind();
                _listviewProject.DataBind();
            }

        }
    }
}
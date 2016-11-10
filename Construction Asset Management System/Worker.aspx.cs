using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Construction_Asset_Management_System
{
    public partial class Worker : System.Web.UI.Page
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
            Response.Redirect("~/Worker_CRUD.aspx");
        }

        protected void _btnShowList_Click(object sender, EventArgs e)
          {
              _btnShowList.Visible = false;
            Response.Redirect("~/Worker.aspx");
        }
        protected void _btnSearch_Click(object sender, EventArgs e)
        {
            _btnShowList.Visible = true;
            string Search = null;
            DataSourceWorker.SelectParameters.Clear();
            if (IsPostBack)
            {
                Search = _txtSearch.Text.Trim();
                DataSourceWorker.SelectParameters.Add("Search", Search);
                DataSourceWorker.SelectCommand="SELECT [WORKERID], [WORKERFNAME], [WORKERLNAME], [WORKERDOB], [WORKERADDR], [WORKERSTATUS], [WORKEREMPLOYTYPE],ASSWORKER, WORKER.LABORTYPEID, LABORTYPE.LABORTYPENAME FROM WORKER INNER JOIN LABORTYPE ON WORKER.LABORTYPEID=LABORTYPE.LABORTYPEID  WHERE WORKERFNAME like'%'+@Search+'%' OR WORKERLNAME like'%'+@Search+'%' OR WORKERDOB like'%'+@Search+'%' OR WORKERADDR like'%'+@Search+'%' OR WORKERSTATUS like'%'+@Search+'%' OR WORKEREMPLOYTYPE like'%'+@Search+'%' OR LABORTYPENAME like'%'+@Search+'%'";
                DataSourceWorker.DataBind();
                _listviewWorker.DataBind();
            }
        
        }
    }
}
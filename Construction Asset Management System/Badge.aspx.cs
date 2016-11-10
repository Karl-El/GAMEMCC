using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Construction_Asset_Management_System
{
    public partial class Badge : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void _btnAdd_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Badge_CRUD.aspx");
        }

        protected void _btnShowList_Click(object sender, EventArgs e)
        {
            _btnShowList.Visible = false;
            Response.Redirect("~/Badge.aspx");
        }

        protected void _btnSearch_Click(object sender, EventArgs e)
        {
            _btnShowList.Visible = true;
            string Search = null;
            DataSourceBadge.SelectParameters.Clear();
            if (IsPostBack)
            {
                Search = _txtSearch.Text.Trim();
                DataSourceBadge.SelectParameters.Add("Search", Search);
                DataSourceBadge.SelectCommand = "SELECT WORKER.WORKERID, WORKER.WORKERIMAGE, WORKER.WORKERFNAME + ' ' + WORKER.WORKERLNAME AS WORKERFULLNAME, WORKER.WORKERDOB, WORKER.WORKERADDR, BADGE.BADGECODE, BADGE.BADGEFROM, BADGE.BADGETO, BADGE.BADGESTAT, BADGE.BADGEPICCODE FROM WORKER INNER JOIN BADGE ON WORKER.WORKERID = BADGE.WORKERID WHERE BADGECODE like'%'+@Search+'%' OR BADGEFROM like'%'+@Search+'%' OR BADGETO like'%'+@Search+'%' OR BADGESTAT like'%'+@Search+'%' OR BADGESTAT like'%'+@Search+'%' OR WORKERFNAME like'%'+@Search+'%' OR WORKERLNAME like'%'+@Search+'%'";
                DataSourceBadge.DataBind();
                _listviewBadge.DataBind();
            }

        }
    }
}
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Construction_Asset_Management_System
{
    public partial class Trade : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void _listviewTrade_ItemDeleted(object sender, ListViewDeletedEventArgs e)
        {
            ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('Record Deleted')", true);
        }
        protected void _btnAdd_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Trade_CRUD.aspx");
        }

        protected void _btnShowList_Click(object sender, EventArgs e)
        {
            _btnShowList.Visible = false;
            Response.Redirect("~/Trade.aspx");
        }
        protected void _btnSearch_Click(object sender, EventArgs e)
        {
            _btnShowList.Visible = true;
            string Search = null;
            DataSourceTrade.SelectParameters.Clear();
            if (IsPostBack)
            {
                Search = _txtSearch.Text.Trim();
                DataSourceTrade.SelectParameters.Add("Search", Search);
                DataSourceTrade.SelectCommand = "SELECT [TRADEID], [TRADENAME], TRADE.LABORTYPEID, LABORTYPE.LABORTYPENAME FROM TRADE INNER JOIN LABORTYPE ON TRADE.LABORTYPEID=LABORTYPE.LABORTYPEID WHERE TRADENAME like'%'+@Search+'%' OR LABORTYPENAME like'%'+@Search+'%'";
                DataSourceTrade.DataBind();
                _listviewTrade.DataBind();
            }

        }
    }
}
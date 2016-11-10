using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Construction_Asset_Management_System
{
    public partial class TradeHandling : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void _listviewTradeHandling_ItemDataBound(object sender, ListViewItemEventArgs e)
        {
            if (e.Item.ItemType==ListViewItemType.DataItem)
            {
                var _bulletWorkerTrade = (BulletedList)e.Item.FindControl("_bulletWorkerTrade");
                var _hyperlinkTradeEdit = (HyperLink)e.Item.FindControl("_hyperlinkTradeEdit");
                if (_bulletWorkerTrade.Items.Count==0)
                {
                    _hyperlinkTradeEdit.Text="Add Trades";
                    _bulletWorkerTrade.Items.Add("No Trades listed");
                }
                else
                {
                    _hyperlinkTradeEdit.Text = "Edit Trades";
                }
            }
        }

        protected void _btnAdd_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/TradeHandling_CRUD.aspx");
        }

        protected void _btnShowList_Click(object sender, EventArgs e)
        {
            _btnShowList.Visible = false;
            Response.Redirect("~/TradeHandling.aspx");
        }
        protected void _btnSearch_Click(object sender, EventArgs e)
        {
            _btnShowList.Visible = true;
            string Search = null;
            DataSourceTradeHandling.SelectParameters.Clear();
            if (IsPostBack)
            {
                Search = _txtSearch.Text.Trim();
                DataSourceTradeHandling.SelectParameters.Add("Search", Search);
                DataSourceTradeHandling.SelectCommand = "SELECT WORKER.WORKERID, WORKER.WORKERIMAGE, WORKER.WORKERFNAME + ' ' + WORKER.WORKERLNAME AS WORKERNAME, LABORTYPE.LABORTYPENAME FROM LABORTYPE INNER JOIN WORKER ON LABORTYPE.LABORTYPEID = WORKER.LABORTYPEID WHERE WORKERID like'%'+@Search+'%' OR WORKERFNAME like'%'+@Search+'%' OR LABORTYPENAME like'%'+@Search+'%' OR WORKERLNAME like'%'+@Search+'%'";
                DataSourceTradeHandling.DataBind();
                _listviewTradeHandling.DataBind();
            }

        }
    }
}
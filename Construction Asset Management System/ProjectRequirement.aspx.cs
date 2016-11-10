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
    public partial class ProjectRequirement : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void _listviewProjReq_ItemDataBound(object sender, ListViewItemEventArgs e)
        {
            if (e.Item.ItemType == ListViewItemType.DataItem)
            {
                var _labelTotalTrade = (Label)e.Item.FindControl("_labelTotalTrade");
                var _labelTotalEquip = (Label)e.Item.FindControl("_labelTotalEquip");
                var _bulletlistProjTrade = (BulletedList)e.Item.FindControl("_bulletlistProjTrade");
                var _bulletlistProjEquip = (BulletedList)e.Item.FindControl("_bulletlistProjEquip");
                var PROJIDLabel = (Label)e.Item.FindControl("PROJIDLabel");
                var _hyperlinkProjectEdit = (HyperLink)e.Item.FindControl("_hyperlinkProjectEdit");
                var _hyperlinkRequireEdit = (HyperLink)e.Item.FindControl("_hyperlinkRequireEdit");
                string ProjectID = PROJIDLabel.Text;
                String Conn = ConfigurationManager.ConnectionStrings["ConnString_WEB_ASSET_DB"].ConnectionString;
                SqlConnection Connect = new SqlConnection(Conn);
                Connect.Open();
                SqlCommand Cmd = new SqlCommand("SELECT SUM(CAST(TRADEQUANTITY AS INT)) FROM PROJREQTRADE WHERE PROJID=@ProjectID", Connect);
                Cmd.Parameters.AddWithValue("@ProjectID", ProjectID);
                object Value = Cmd.ExecuteScalar();
                if (Value !=DBNull.Value)
                {
                    int Total = Convert.ToInt32(Value);
                    _labelTotalTrade.Text = Total.ToString();
                }
                else
                {
                    _labelTotalTrade.Text = "0";
                    _bulletlistProjTrade.Items.Add("No Worker listed");;
                }
                Connect.Close();
                Connect.Open();
                Cmd = new SqlCommand("SELECT SUM(CAST(EQUIPQUANTITY AS INT)) FROM PROJREQEQUIP WHERE PROJID=@ProjectID", Connect);
                Cmd.Parameters.AddWithValue("@ProjectID", ProjectID);
                Value = Cmd.ExecuteScalar();
                if (Value != DBNull.Value)
                {
                    int Total = Convert.ToInt32(Value);
                    _labelTotalEquip.Text = Total.ToString();
                }
                else
                {
                    _labelTotalEquip.Text = "0";
                    _bulletlistProjEquip.Items.Add("No Equipment listed");
                }

                if (Convert.ToInt32(_labelTotalEquip.Text) == 0 && Convert.ToInt32(_labelTotalTrade.Text) == 0)
                {

                    _hyperlinkRequireEdit.Text = "Add Requirements";
                }
                else
                {

                    _hyperlinkRequireEdit.Text = "Edit Requirements";
                }

            }
        }

        protected void _btnAdd_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/ProjectRequirement_CRUD.aspx");
        }

        protected void _listviewProjReq_ItemCommand(object sender, ListViewCommandEventArgs e)
        {
            if (e.CommandName == "DownloadFile")
            {
                if (e.Item.ItemType == ListViewItemType.DataItem)
                {
                    var PROJIDLabel = (Label)e.Item.FindControl("PROJIDLabel"); string ProjID = PROJIDLabel.Text;
                    String Conn = ConfigurationManager.ConnectionStrings["ConnString_WEB_ASSET_DB"].ConnectionString;
                    SqlConnection Connect = new SqlConnection(Conn);
                    SqlCommand Cmd = new SqlCommand("SELECT PROJATTACH FROM PROJECT WHERE PROJID=@ProjID", Connect);
                    Cmd.Parameters.AddWithValue("@ProjID", ProjID);
                    Connect.Open();
                    SqlDataReader Reader = Cmd.ExecuteReader();
                    while (Reader.Read())
                        if (!Reader.IsDBNull(Reader.GetOrdinal("PROJATTACH")))
                        {
                            string Attach = Reader["PROJATTACH"].ToString();
                            string Path = Attach.ToString();
                            string NameFile = Attach.Replace("uploadfiles/", string.Empty);
                            Response.ContentType = "application/octet-stream";
                            Response.AppendHeader("Content-Disposition", "attachment; filename=" + NameFile);
                            Response.TransmitFile(Server.MapPath(Path));
                            Response.End();
                        }
                        else
                        {
                            ScriptManager.RegisterStartupScript(this, this.GetType(), "popup", "alert('No Attachments!');", true);
                        }
                    Connect.Close();
                }
            }
        }

        //protected void _btnNoReq_Click(object sender, EventArgs e)
        //{
        //    foreach (var item in _listviewProjReq.Items)
        //    {
        //        BulletedList _bulletlistProjTrade = item.FindControl("_bulletlistProjTrade") as BulletedList;
        //        if (_bulletlistProjTrade.Items.Count==0)
        //        {

        //        }
        //    }
        //}

        protected void _btnShowList_Click(object sender, EventArgs e)
        {
            _btnShowList.Visible = false;
            Response.Redirect("~/ProjectRequirement.aspx");
        }

        protected void _btnSearch_Click(object sender, EventArgs e)
        {
            _btnShowList.Visible = true;
            string Search = null;
            DataSourceProjReq.SelectParameters.Clear();
            if (IsPostBack)
            {
                Search = _txtSearch.Text.Trim();
                DataSourceProjReq.SelectParameters.Add("Search", Search);
                DataSourceProjReq.SelectCommand = "SELECT PROJECT.PROJID, PROJECT.PROJATTACH, CLIENT.CLIENTNAME + ', ' + PROJECT.PROJNAME AS 'CLIENTPROJECT', PROJECT.PROJSITE, PROJECT.PROJAPPR FROM PROJECT INNER JOIN CLIENT ON CLIENT.CLIENTID = PROJECT.CLIENTID WHERE PROJID like'%'+@Search+'%' OR PROJSITE like'%'+@Search+'%' OR PROJAPPR like'%'+@Search+'%' OR CLIENTNAME like'%'+@Search+'%' OR PROJNAME like'%'+@Search+'%'";
                DataSourceProjReq.DataBind();
                _listviewProjReq.DataBind();
            }
        }

    }
}
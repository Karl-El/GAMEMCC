using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

namespace Construction_Asset_Management_System.images
{
    public partial class TradeHandling : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void _dropdownWorkerName_SelectedIndexChanged(object sender, EventArgs e)
        {
        }

        protected void SaveButton_Click(object sender, EventArgs e)
        {
            int WorkerID = Convert.ToInt16(_dropdownWorkerName.SelectedValue.ToString());
            //int WorkerTradeID = 0;
            String Conn = ConfigurationManager.ConnectionStrings["ConnString_WEB_ASSET_DB"].ConnectionString;
            SqlConnection Connect = new SqlConnection(Conn);
            SqlCommand Cmd = new SqlCommand("SELECT COUNT (*) FROM WORKERTRADE WHERE WORKERID=@WorkerID", Connect);
            Cmd.Parameters.AddWithValue("@WorkerID", WorkerID);
            Connect.Open();
            Int32 Count = (Int32)Cmd.ExecuteScalar();
            Connect.Close();
            //-----------------------------------------------------------------

            if (Count > 0)
            {
                for (int i = 0; i <= Count - 1; i++)
                {
                    Connect.Open();
                    Cmd = new SqlCommand("DELETE FROM WORKERTRADE WHERE WORKERID=@WorkerID", Connect);
                    Cmd.Parameters.AddWithValue("@WorkerID", WorkerID);
                    Cmd.ExecuteNonQuery();
                    Connect.Close();

                }

                for (int i = 0; i <= _chlbxlistTrade.Items.Count - 1; i++)
                {
                    if (_chlbxlistTrade.Items[i].Selected)
                    {
                        Connect.Open();
                        Cmd = new SqlCommand("INSERT INTO WORKERTRADE (WORKERID,TRADEID) VALUES (@WorkerID,@TradeID)", Connect);
                        Cmd.Parameters.AddWithValue("@WorkerID", WorkerID);
                        Cmd.Parameters.AddWithValue("@TradeID", _chlbxlistTrade.Items[i].Value);
                        Cmd.ExecuteNonQuery();
                        Connect.Close();
                    }

                }
                string scriptText = "alert('Trade/s Modified'); window.location='" + Request.ApplicationPath + "TradeHandling.aspx'";
                ScriptManager.RegisterStartupScript(this, this.GetType(), "alertMessage", scriptText, true);

            }
            else
            {
                for (int i = 0; i <= _chlbxlistTrade.Items.Count - 1; i++)
                {
                    if (_chlbxlistTrade.Items[i].Selected)
                    {
                        Connect.Open();
                        Cmd = new SqlCommand("INSERT INTO WORKERTRADE (WORKERID,TRADEID) VALUES (@WorkerID,@TradeID)", Connect);
                        Cmd.Parameters.AddWithValue("@WorkerID", WorkerID);
                        Cmd.Parameters.AddWithValue("@TradeID", _chlbxlistTrade.Items[i].Value);
                        Cmd.ExecuteNonQuery();
                        Connect.Close();
                        string scriptText = "alert('Trade Added'); window.location='" + Request.ApplicationPath + "TradeHandling.aspx'";
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "alertMessage", scriptText, true);
                    }
                }
            }
        }



        protected void _dropdownWorkerName_PreRender(object sender, EventArgs e)
        {
            ListItem SelectedItem = _dropdownWorkerName.Items.FindByValue(Request.QueryString["id"]);
            if (SelectedItem != null)
            {
                SelectedItem.Selected = true;
                _dropdownWorkerName.Enabled = false;
                string WorkerID = _dropdownWorkerName.SelectedValue.ToString();
                String Conn = ConfigurationManager.ConnectionStrings["ConnString_WEB_ASSET_DB"].ConnectionString;
                SqlConnection Connect = new SqlConnection(Conn);
                //-------------------------------------------------------------------
                Connect.Open();
                SqlCommand Cmd = new SqlCommand("SELECT LABORTYPENAME FROM LABORTYPE INNER JOIN WORKER ON LABORTYPE.LABORTYPEID = WORKER.LABORTYPEID WHERE WORKERID=@WorkerID", Connect);
                Cmd.Parameters.AddWithValue("@WorkerID", WorkerID);
                SqlDataReader Reader = Cmd.ExecuteReader();
                //WorkerLaborTypeTextbox.Text = Cmd.ExecuteScalar().ToString();
                while (Reader.Read())
                {
                    WorkerLaborTypeTextbox.Text = Reader["LABORTYPENAME"].ToString();
                }
                Cmd.Connection.Close();
                //-------------------------------------------------------------------
                Cmd.Connection.Open();
                Cmd = new SqlCommand("SELECT TRADENAME, TRADEID FROM TRADE JOIN LABORTYPE ON LABORTYPE.LABORTYPEID = TRADE.LABORTYPEID JOIN WORKER ON  LABORTYPE.LABORTYPEID = WORKER.LABORTYPEID WHERE WORKERID=@WorkerID", Connect);
                Cmd.Parameters.AddWithValue("@WorkerID", WorkerID);
                _chlbxlistTrade.DataSource = Cmd.ExecuteReader();
                _chlbxlistTrade.DataValueField = "TRADEID";
                _chlbxlistTrade.DataTextField = "TRADENAME";
                _chlbxlistTrade.DataBind();
                Cmd.Connection.Close();
            }
            else
            {
                _dropdownWorkerName.Enabled = true;
                string WorkerID = _dropdownWorkerName.SelectedValue.ToString();
                String Conn = ConfigurationManager.ConnectionStrings["ConnString_WEB_ASSET_DB"].ConnectionString;
                SqlConnection Connect = new SqlConnection(Conn);
                //-------------------------------------------------------------------
                Connect.Open();
                SqlCommand Cmd = new SqlCommand("SELECT LABORTYPENAME FROM LABORTYPE INNER JOIN WORKER ON LABORTYPE.LABORTYPEID = WORKER.LABORTYPEID WHERE WORKERID=@WorkerID", Connect);
                Cmd.Parameters.AddWithValue("@WorkerID", WorkerID);
                SqlDataReader Reader = Cmd.ExecuteReader();
                //WorkerLaborTypeTextbox.Text = Cmd.ExecuteScalar().ToString();
                while (Reader.Read())
                {
                    WorkerLaborTypeTextbox.Text = Reader["LABORTYPENAME"].ToString();
                }
                Cmd.Connection.Close();
                //-------------------------------------------------------------------
                Cmd.Connection.Open();
                Cmd = new SqlCommand("SELECT TRADENAME, TRADEID FROM TRADE JOIN LABORTYPE ON LABORTYPE.LABORTYPEID = TRADE.LABORTYPEID JOIN WORKER ON  LABORTYPE.LABORTYPEID = WORKER.LABORTYPEID WHERE WORKERID=@WorkerID", Connect);
                Cmd.Parameters.AddWithValue("@WorkerID", WorkerID);
                _chlbxlistTrade.DataSource = Cmd.ExecuteReader();
                _chlbxlistTrade.DataValueField = "TRADEID";
                _chlbxlistTrade.DataTextField = "TRADENAME";
                _chlbxlistTrade.DataBind();
                Cmd.Connection.Close();
            }
        }

        protected void _dropdownWorkerName_DataBound(object sender, EventArgs e)
        {

        }

    }
}

//for (int i = 0; i <= _chlbxlistTrade.Items.Count - 1; i++)
//{
//    if (_chlbxlistTrade.Items[i].Selected)
//    {
//        Connect.Open();
//        Cmd = new SqlCommand("UPDATE WORKERTRADE SET TRADEID=@TradeID WHERE WORKERID=@WorkerID AND TRADEID!=@TradeID", Connect);
//        Cmd.Parameters.Clear();
//        Cmd.Parameters.AddWithValue("@WorkerID", WorkerID);
//        Cmd.Parameters.AddWithValue("@TradeID", _chlbxlistTrade.Items[i].Value);
//        Cmd.ExecuteNonQuery();
//        Connect.Close();
//        string scriptText = "alert('Trade Updated'); window.location='" + Request.ApplicationPath + "TradeHandling_CRUD.aspx'";
//        ScriptManager.RegisterStartupScript(this, this.GetType(), "alertMessage", scriptText, true);
//    }
//}
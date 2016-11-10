using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Net;
using System.Configuration;
namespace Construction_Asset_Management_System
{
    public partial class Trade_CRUD : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        public static void TrimTextBoxesRecursive(Control root)
        {
            foreach (Control control in root.Controls)
            {
                if (control is TextBox)
                {
                    var textbox = control as TextBox;
                    textbox.Text = textbox.Text.Trim();
                }
                else
                {
                    TrimTextBoxesRecursive(control);
                }
            }
        }

        protected void _listviewTradeCRUD_ItemUpdated(object sender, ListViewUpdatedEventArgs e)
        {
            string scriptText = "alert('Record Updated'); window.location='" + Request.ApplicationPath + "Trade.aspx'";
            ScriptManager.RegisterStartupScript(this, this.GetType(), "alertMessage", scriptText, true);
        }

        protected void _listviewTradeCRUD_ItemDeleted(object sender, ListViewDeletedEventArgs e)
        {
            string scriptText = "alert('Record Deleted'); window.location='" + Request.ApplicationPath + "Trade.aspx'";
            ScriptManager.RegisterStartupScript(this, this.GetType(), "alertMessage", scriptText, true);
        }

        protected void _listviewTradeCRUD_ItemInserted(object sender, ListViewInsertedEventArgs e)
        {
            string scriptText = "alert('Record Inserted '); window.location='" + Request.ApplicationPath + "Trade.aspx'";
            ScriptManager.RegisterStartupScript(this, this.GetType(), "alertMessage", scriptText, true);
        }

        protected void UpdateButton_Click(object sender, EventArgs e)
        {
            TrimTextBoxesRecursive(Page);
        }

        protected void InsertButton_Click(object sender, EventArgs e)
        {
            TrimTextBoxesRecursive(Page);
        }

        protected void _listviewTradeCRUD_DataBound(object sender, EventArgs e)
        {
            if (_listviewTradeCRUD.Items.Count > 0)
            {
                _listviewTradeCRUD.InsertItemPosition = InsertItemPosition.None;
                _listviewTradeCRUD.DataBind();
            }
        }

        protected void _listviewTradeCRUD_ItemInserting(object sender, ListViewInsertEventArgs e)
        {
            TextBox TRADENAMETextBox = (TextBox)_listviewTradeCRUD.InsertItem.FindControl("TRADENAMETextBox");
            String Conn = ConfigurationManager.ConnectionStrings["ConnString_WEB_ASSET_DB"].ConnectionString;
            SqlConnection Connect = new SqlConnection(Conn);
            string TradeName = TRADENAMETextBox.Text.Trim();

            Connect.Open();
            SqlCommand Cmd = new SqlCommand("SELECT COUNT (*) FROM TRADE WHERE TradeName=@TradeName", Connect);
            Cmd.Parameters.AddWithValue("@TradeName", TradeName);
            Int32 Count = (Int32)Cmd.ExecuteScalar();
            if (Count > 0)
            {
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('Trade Name is already existing')", true);
                e.Cancel = true;

            }
            else
            {

            }
        }

        protected void _listviewTradeCRUD_ItemUpdating(object sender, ListViewUpdateEventArgs e)
        {
            TextBox TRADENAMETextBox = (TextBox)_listviewTradeCRUD.EditItem.FindControl("TRADENAMETextBox");
            String Conn = ConfigurationManager.ConnectionStrings["ConnString_WEB_ASSET_DB"].ConnectionString;
            SqlConnection Connect = new SqlConnection(Conn);
            string TradeName = TRADENAMETextBox.Text.Trim();
            string TradeID = e.Keys[0].ToString().Trim();

            Connect.Open();
            SqlCommand Cmd = new SqlCommand("SELECT COUNT (*) FROM TRADE WHERE TradeName=@TradeName AND TRADEID!=@TradeID", Connect);
            Cmd.Parameters.AddWithValue("@TradeName", TradeName);
            Cmd.Parameters.AddWithValue("@TradeID", TradeID);
            Int32 Count = (Int32)Cmd.ExecuteScalar();
            if (Count > 0)
            {
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('Trade Name is already existing')", true);
                e.Cancel = true;

            }
            else
            {

            }
        }

    }
}
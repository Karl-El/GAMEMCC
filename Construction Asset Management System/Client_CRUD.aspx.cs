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
    public partial class Client_CRUD : System.Web.UI.Page
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

        protected void _listviewClientCRUD_ItemUpdated(object sender, ListViewUpdatedEventArgs e)
        {
            string scriptText = "alert('Record Updated'); window.location='" + Request.ApplicationPath + "Client.aspx'";
            ScriptManager.RegisterStartupScript(this, this.GetType(), "alertMessage", scriptText, true);
        }

        protected void _listviewClientCRUD_ItemDeleted(object sender, ListViewDeletedEventArgs e)
        {
            string scriptText = "alert('Record Deleted'); window.location='" + Request.ApplicationPath + "Client.aspx'";
            ScriptManager.RegisterStartupScript(this, this.GetType(), "alertMessage", scriptText, true);
        }

        protected void _listviewClientCRUD_ItemInserted(object sender, ListViewInsertedEventArgs e)
        {
            string scriptText = "alert('Record Inserted '); window.location='" + Request.ApplicationPath + "Client.aspx'";
            ScriptManager.RegisterStartupScript(this, this.GetType(), "alertMessage", scriptText, true);
        }

        protected void _listviewClientCRUD_DataBound(object sender, EventArgs e)
        {
            if (_listviewClientCRUD.Items.Count > 0)
            {
                _listviewClientCRUD.InsertItemPosition = InsertItemPosition.None;
                _listviewClientCRUD.DataBind();
            }
        }

        protected void InsertButton_Click(object sender, EventArgs e)
        {
            TrimTextBoxesRecursive(Page);
        }

        protected void UpdateButton_Click(object sender, EventArgs e)
        {
            TrimTextBoxesRecursive(Page);
        }

        protected void _listviewClientCRUD_ItemInserting(object sender, ListViewInsertEventArgs e)
        {
            TextBox CLIENTNAMETextBox = (TextBox)_listviewClientCRUD.InsertItem.FindControl("CLIENTNAMETextBox");
            String Conn = ConfigurationManager.ConnectionStrings["ConnString_WEB_ASSET_DB"].ConnectionString;
            SqlConnection Connect = new SqlConnection(Conn);
            string ClientName = CLIENTNAMETextBox.Text.Trim();

            Connect.Open();
            SqlCommand Cmd = new SqlCommand("SELECT COUNT (*) FROM CLIENT WHERE CLIENTNAME=@ClientName", Connect);
            Cmd.Parameters.AddWithValue("@ClientName", ClientName);
            Int32 Count = (Int32)Cmd.ExecuteScalar();
            if (Count > 0)
            {
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('Record Existing')", true);
                e.Cancel = true;

            }
            else
            {

            }
        }

        protected void _listviewClientCRUD_ItemUpdating(object sender, ListViewUpdateEventArgs e)
        {
            TextBox CLIENTNAMETextBox = (TextBox)_listviewClientCRUD.EditItem.FindControl("CLIENTNAMETextBox");
            String Conn = ConfigurationManager.ConnectionStrings["ConnString_WEB_ASSET_DB"].ConnectionString;
            SqlConnection Connect = new SqlConnection(Conn);
            string ClientName = CLIENTNAMETextBox.Text.Trim();
            string ClientID = e.Keys[0].ToString().Trim();

            Connect.Open();
            SqlCommand Cmd = new SqlCommand("SELECT COUNT (*) FROM CLIENT WHERE CLIENTNAME=@ClientName AND CLIENTID!=@ClientID", Connect);
            Cmd.Parameters.AddWithValue("@ClientName", ClientName);
            Cmd.Parameters.AddWithValue("@ClientID", ClientID);
            Int32 Count = (Int32)Cmd.ExecuteScalar();
            if (Count > 0)
            {
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('Client is already existing')", true);
                e.Cancel = true;

            }
            else
            {

            }
        }

        protected void _listviewClientCRUD_ItemDeleting(object sender, ListViewDeleteEventArgs e)
        {
            string ClientID = e.Keys[0].ToString().Trim();
            String Conn = ConfigurationManager.ConnectionStrings["ConnString_WEB_ASSET_DB"].ConnectionString;
            SqlConnection Connect = new SqlConnection(Conn);
            Connect.Open();
            SqlCommand Cmd = new SqlCommand("SELECT COUNT (*) FROM CLIENTSTAFF WHERE CLIENTID=@ClientID", Connect);
            Cmd.Parameters.AddWithValue("@ClientID", ClientID);
            Int32 Count = (Int32)Cmd.ExecuteScalar();
            if (Count > 0)
            {
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('Record is use, Unable to delete')", true);
                e.Cancel = true;

            }
            Connect.Close();
            Connect.Open();
            Cmd = new SqlCommand("SELECT COUNT (*) FROM PROJECT WHERE CLIENTID=@ClientID", Connect);
            Cmd.Parameters.AddWithValue("@ClientID", ClientID);
            Count = (Int32)Cmd.ExecuteScalar();
            if (Count > 0)
            {
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('Client has/have a project, Unable to delete')", true);
                e.Cancel = true;

            }
            Connect.Close();
        }
    }
}
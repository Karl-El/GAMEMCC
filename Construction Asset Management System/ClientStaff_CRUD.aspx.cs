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
    public partial class ClientStaff_CRUD : System.Web.UI.Page
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

        protected void _listviewClientStaffCRUD_ItemUpdated(object sender, ListViewUpdatedEventArgs e)
        {
            string scriptText = "alert('Record Updated'); window.location='" + Request.ApplicationPath + "ClientStaff.aspx'";
            ScriptManager.RegisterStartupScript(this, this.GetType(), "alertMessage", scriptText, true);
        }

        protected void _listviewClientStaffCRUD_ItemDeleted(object sender, ListViewDeletedEventArgs e)
        {
            string scriptText = "alert('Record Deleted'); window.location='" + Request.ApplicationPath + "ClientStaff.aspx'";
            ScriptManager.RegisterStartupScript(this, this.GetType(), "alertMessage", scriptText, true);
        }

        protected void _listviewClientStaffCRUD_ItemInserted(object sender, ListViewInsertedEventArgs e)
        {
            string scriptText = "alert('Record Inserted '); window.location='" + Request.ApplicationPath + "ClientStaff.aspx'";
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

        protected void _listviewClientStaffCRUD_DataBound(object sender, EventArgs e)
        {
            if (_listviewClientStaffCRUD.Items.Count > 0)
            {
                _listviewClientStaffCRUD.InsertItemPosition = InsertItemPosition.None;
                _listviewClientStaffCRUD.DataBind();
            }
        }

        protected void _listviewClientStaffCRUD_ItemInserting(object sender, ListViewInsertEventArgs e)
        {
            TextBox CLIENTSTAFFFNAMETextBox = (TextBox)_listviewClientStaffCRUD.InsertItem.FindControl("CLIENTSTAFFFNAMETextBox");
            TextBox CLIENTSTAFFLNAMETextBox = (TextBox)_listviewClientStaffCRUD.InsertItem.FindControl("CLIENTSTAFFLNAMETextBox");
            String Conn = ConfigurationManager.ConnectionStrings["ConnString_WEB_ASSET_DB"].ConnectionString;
            SqlConnection Connect = new SqlConnection(Conn);
            string ClientStaffFirstName = CLIENTSTAFFFNAMETextBox.Text.Trim();
            string ClientStaffLastName = CLIENTSTAFFLNAMETextBox.Text.Trim();

            Connect.Open();
            SqlCommand Cmd = new SqlCommand("SELECT COUNT (*) FROM CLIENTSTAFF WHERE CLIENTSTAFFFNAME=@ClientStaffFirstName AND CLIENTSTAFFLNAME=@ClientStaffLastName", Connect);
            Cmd.Parameters.AddWithValue("@ClientStaffFirstName", ClientStaffFirstName);
            Cmd.Parameters.AddWithValue("@ClientStaffLastName", ClientStaffLastName);
            Int32 Count = (Int32)Cmd.ExecuteScalar();
            if (Count > 0)
            {
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('Record Existing')", true);
                e.Cancel = true;
            }
        }

        protected void _listviewClientStaffCRUD_ItemUpdating(object sender, ListViewUpdateEventArgs e)
        {
            TextBox CLIENTSTAFFFNAMETextBox = (TextBox)_listviewClientStaffCRUD.EditItem.FindControl("CLIENTSTAFFFNAMETextBox");
            TextBox CLIENTSTAFFLNAMETextBox = (TextBox)_listviewClientStaffCRUD.EditItem.FindControl("CLIENTSTAFFLNAMETextBox");
            String Conn = ConfigurationManager.ConnectionStrings["ConnString_WEB_ASSET_DB"].ConnectionString;
            SqlConnection Connect = new SqlConnection(Conn);
            string ClientStaffFirstName = CLIENTSTAFFFNAMETextBox.Text.Trim();
            string ClientStaffLastName = CLIENTSTAFFLNAMETextBox.Text.Trim();
            string ClientStaffID = e.Keys[0].ToString().Trim();

            Connect.Open();
            SqlCommand Cmd = new SqlCommand("SELECT COUNT (*) FROM CLIENTSTAFF WHERE CLIENTSTAFFFNAME=@ClientStaffFirstName AND CLIENTSTAFFLNAME=@ClientStaffLastName AND CLIENTSTAFFID!=@ClientStaffID", Connect);
            Cmd.Parameters.AddWithValue("@ClientStaffFirstName", ClientStaffFirstName);
            Cmd.Parameters.AddWithValue("@ClientStaffLastName", ClientStaffLastName);
            Cmd.Parameters.AddWithValue("@ClientStaffID", ClientStaffID);
            Int32 Count = (Int32)Cmd.ExecuteScalar();
            if (Count > 0)
            {
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('Staff Name is already existing')", true);
                e.Cancel = true;

            }

        }

        protected void _listviewClientStaffCRUD_ItemDeleting(object sender, ListViewDeleteEventArgs e)
        {
            String Conn = ConfigurationManager.ConnectionStrings["ConnString_WEB_ASSET_DB"].ConnectionString;
            SqlConnection Connect = new SqlConnection(Conn);
            string ClientStaffID = e.Keys[0].ToString().Trim();

            Connect.Open();
            SqlCommand Cmd = new SqlCommand("SELECT COUNT (*) FROM PROJECT WHERE  CLNTPROJCONTID=@ClientStaffID OR CLNTPROJPREPID=@ClientStaffID OR CLNTPROJAPPID=@ClientStaffID", Connect);
            Cmd.Parameters.AddWithValue("@ClientStaffID", ClientStaffID);
            Int32 Count = (Int32)Cmd.ExecuteScalar();
            if (Count > 0)
            {
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('Record is in  use, Unable to delete')", true);
                e.Cancel = true;
            }
        }
    }
}
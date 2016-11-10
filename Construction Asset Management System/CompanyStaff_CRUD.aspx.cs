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
    public partial class CompanyStaff_CRUD : System.Web.UI.Page
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

        protected void _listviewCompanyStaffCRUD_ItemUpdated(object sender, ListViewUpdatedEventArgs e)
        {
            string scriptText = "alert('Record Updated'); window.location='" + Request.ApplicationPath + "CompanyStaff.aspx'";
            ScriptManager.RegisterStartupScript(this, this.GetType(), "alertMessage", scriptText, true);
        }

        protected void _listviewCompanyStaffCRUD_ItemDeleted(object sender, ListViewDeletedEventArgs e)
        {
            string scriptText = "alert('Record Deleted'); window.location='" + Request.ApplicationPath + "CompanyStaff.aspx'";
            ScriptManager.RegisterStartupScript(this, this.GetType(), "alertMessage", scriptText, true);
        }

        protected void _listviewCompanyStaffCRUD_ItemInserted(object sender, ListViewInsertedEventArgs e)
        {
            string scriptText = "alert('Record Inserted '); window.location='" + Request.ApplicationPath + "CompanyStaff.aspx'";
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

        protected void _listviewCompanyStaffCRUD_DataBound(object sender, EventArgs e)
        {
            if (_listviewCompanyStaffCRUD.Items.Count > 0)
            {
                _listviewCompanyStaffCRUD.InsertItemPosition = InsertItemPosition.None;
                _listviewCompanyStaffCRUD.DataBind();
            }
        }

        protected void _listviewCompanyStaffCRUD_ItemInserting(object sender, ListViewInsertEventArgs e)
        {
            TextBox COMSTAFFFRSTNAMETextBox = (TextBox)_listviewCompanyStaffCRUD.InsertItem.FindControl("COMSTAFFFRSTNAMETextBox");
            TextBox COMSTAFFLASTNAMETextBox = (TextBox)_listviewCompanyStaffCRUD.InsertItem.FindControl("COMSTAFFLASTNAMETextBox");
            String Conn = ConfigurationManager.ConnectionStrings["ConnString_WEB_ASSET_DB"].ConnectionString;
            SqlConnection Connect = new SqlConnection(Conn);
            string CompStaffFirstName = COMSTAFFFRSTNAMETextBox.Text.Trim();
            string CompStaffLastName = COMSTAFFLASTNAMETextBox.Text.Trim();

            Connect.Open();
            SqlCommand Cmd = new SqlCommand("SELECT COUNT (*) FROM COMPANYSTAFF WHERE COMSTAFFFRSTNAME=@CompStaffFirstName AND COMSTAFFLASTNAME=@CompStaffLastName", Connect);
            Cmd.Parameters.AddWithValue("@CompStaffFirstName", CompStaffFirstName);
            Cmd.Parameters.AddWithValue("@CompStaffLastName", CompStaffLastName);
            Int32 Count = (Int32)Cmd.ExecuteScalar();
            if (Count > 0)
            {
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('Record Existing')", true);
                e.Cancel = true;
            }
        }

        protected void _listviewCompanyStaffCRUD_ItemUpdating(object sender, ListViewUpdateEventArgs e)
        {
            TextBox COMSTAFFFRSTNAMETextBox = (TextBox)_listviewCompanyStaffCRUD.EditItem.FindControl("COMSTAFFFRSTNAMETextBox");
            TextBox COMSTAFFLASTNAMETextBox = (TextBox)_listviewCompanyStaffCRUD.EditItem.FindControl("COMSTAFFLASTNAMETextBox");
            String Conn = ConfigurationManager.ConnectionStrings["ConnString_WEB_ASSET_DB"].ConnectionString;
            SqlConnection Connect = new SqlConnection(Conn);
            string CompStaffFirstName = COMSTAFFFRSTNAMETextBox.Text.Trim();
            string CompStaffLastName = COMSTAFFLASTNAMETextBox.Text.Trim();
            string ClientStaffID = e.Keys[0].ToString().Trim();

            Connect.Open();
            SqlCommand Cmd = new SqlCommand("SELECT COUNT (*) FROM COMPANYSTAFF WHERE COMSTAFFFRSTNAME=@CompStaffFirstName AND COMSTAFFLASTNAME=@CompStaffLastName AND COMSTAFFID!=@ClientStaffID", Connect);
            Cmd.Parameters.AddWithValue("@CompStaffFirstName", CompStaffFirstName);
            Cmd.Parameters.AddWithValue("@CompStaffLastName", CompStaffLastName);
            Cmd.Parameters.AddWithValue("@ClientStaffID", ClientStaffID);
            Int32 Count = (Int32)Cmd.ExecuteScalar();
            if (Count > 0)
            {
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('Record Existing')", true);
                e.Cancel = true;
            }
        }

        protected void _listviewCompanyStaffCRUD_ItemDeleting(object sender, ListViewDeleteEventArgs e)
        {

            String Conn = ConfigurationManager.ConnectionStrings["ConnString_WEB_ASSET_DB"].ConnectionString;
            SqlConnection Connect = new SqlConnection(Conn);
            string ClientStaffID = e.Keys[0].ToString().Trim();

            Connect.Open();
            SqlCommand Cmd = new SqlCommand("SELECT COUNT (*) FROM PROJECT WHERE  COMSTAFFID=@ClientStaffID", Connect);
            Cmd.Parameters.AddWithValue("@ClientStaffID", ClientStaffID);
            Int32 Count = (Int32)Cmd.ExecuteScalar();
            if (Count > 0)
            {
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('Record is in use, Unable to delete')", true);
                e.Cancel = true;
            }
        }
    }
}
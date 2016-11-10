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
    public partial class EquipmentCategory_CRUD : System.Web.UI.Page
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

        protected void _listviewEquipCtgryCRUD_ItemUpdated(object sender, ListViewUpdatedEventArgs e)
        {
            string scriptText = "alert('Record Updated'); window.location='" + Request.ApplicationPath + "EquipmentCategory.aspx'";
            ScriptManager.RegisterStartupScript(this, this.GetType(), "alertMessage", scriptText, true);
        }

        protected void _listviewEquipCtgryCRUD_ItemDeleted(object sender, ListViewDeletedEventArgs e)
        {
            string scriptText = "alert('Record Deleted'); window.location='" + Request.ApplicationPath + "EquipmentCategory.aspx'";
            ScriptManager.RegisterStartupScript(this, this.GetType(), "alertMessage", scriptText, true);
        }

        protected void _listviewEquipCtgryCRUD_ItemInserted(object sender, ListViewInsertedEventArgs e)
        {
            string scriptText = "alert('Record Inserted '); window.location='" + Request.ApplicationPath + "EquipmentCategory.aspx'";
            ScriptManager.RegisterStartupScript(this, this.GetType(), "alertMessage", scriptText, true);
        }

        protected void _listviewEquipCtgryCRUD_DataBound(object sender, EventArgs e)
        {
            if (_listviewEquipCtgryCRUD.Items.Count > 0)
            {
                _listviewEquipCtgryCRUD.InsertItemPosition = InsertItemPosition.None;
                _listviewEquipCtgryCRUD.DataBind();
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

        protected void _listviewEquipCtgryCRUD_ItemInserting(object sender, ListViewInsertEventArgs e)
        {
            TextBox EQUIPCTGRYNAMETextBox = (TextBox)_listviewEquipCtgryCRUD.InsertItem.FindControl("EQUIPCTGRYNAMETextBox");
            String Conn = ConfigurationManager.ConnectionStrings["ConnString_WEB_ASSET_DB"].ConnectionString;
            SqlConnection Connect = new SqlConnection(Conn);
            string EquipCatName = EQUIPCTGRYNAMETextBox.Text.Trim();

            Connect.Open();
            SqlCommand Cmd = new SqlCommand("SELECT COUNT (*) FROM EQUIPCTGRY WHERE EQUIPCTGRYNAME=@EquipCatName", Connect);
            Cmd.Parameters.AddWithValue("@EquipCatName", EquipCatName);
            Int32 Count = (Int32)Cmd.ExecuteScalar();
            if (Count > 0)
            {
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('Record Existing')", true);
                e.Cancel = true;

            }
        }

        protected void _listviewEquipCtgryCRUD_ItemUpdating(object sender, ListViewUpdateEventArgs e)
        {
            TextBox EQUIPCTGRYNAMETextBox = (TextBox)_listviewEquipCtgryCRUD.EditItem.FindControl("EQUIPCTGRYNAMETextBox");
            String Conn = ConfigurationManager.ConnectionStrings["ConnString_WEB_ASSET_DB"].ConnectionString;
            SqlConnection Connect = new SqlConnection(Conn);
            string EquipCatName = EQUIPCTGRYNAMETextBox.Text.Trim();
            string EquipCatID = e.Keys[0].ToString().Trim();

            Connect.Open();
            SqlCommand Cmd = new SqlCommand("SELECT COUNT (*) FROM EQUIPCTGRY WHERE EQUIPCTGRYNAME=@EquipCatName AND EQUIPCTGRYID!=@EquipCatID", Connect);
            Cmd.Parameters.AddWithValue("@EquipCatName", EquipCatName);
            Cmd.Parameters.AddWithValue("@EquipCatID", EquipCatID);
            Int32 Count = (Int32)Cmd.ExecuteScalar();
            if (Count > 0)
            {
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('Record Existing')", true);
                e.Cancel = true;

            }
        }

        protected void _listviewEquipCtgryCRUD_ItemDeleting(object sender, ListViewDeleteEventArgs e)
        {
            String Conn = ConfigurationManager.ConnectionStrings["ConnString_WEB_ASSET_DB"].ConnectionString;
            SqlConnection Connect = new SqlConnection(Conn);
            string EquipCatID = e.Keys[0].ToString().Trim();

            Connect.Open();
            SqlCommand Cmd = new SqlCommand("SELECT COUNT (*) FROM EQUIPMENT WHERE EQUIPCTGRYID=@EquipCatID", Connect);
            Cmd.Parameters.AddWithValue("@EquipCatID", EquipCatID);
            Int32 Count = (Int32)Cmd.ExecuteScalar();
            if (Count > 0)
            {
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('Record is in use, Unable to delete')", true);
                e.Cancel = true;

            }
        }
    }
}
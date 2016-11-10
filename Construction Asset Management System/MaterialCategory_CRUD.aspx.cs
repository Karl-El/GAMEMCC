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
    public partial class MaterialCategoryCRUD : System.Web.UI.Page
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

        protected void _listviewMtrlCtgryCrud_ItemUpdated(object sender, ListViewUpdatedEventArgs e)
        {
            string scriptText = "alert('Record Updated'); window.location='" + Request.ApplicationPath + "MaterialCategory.aspx'";
            ScriptManager.RegisterStartupScript(this, this.GetType(), "alertMessage", scriptText, true);
        }

        protected void _listviewMtrlCtgryCrud_ItemDeleted(object sender, ListViewDeletedEventArgs e)
        {
            string scriptText = "alert('Record Deleted'); window.location='" + Request.ApplicationPath + "MaterialCategory.aspx'";
            ScriptManager.RegisterStartupScript(this, this.GetType(), "alertMessage", scriptText, true);
        }

        protected void _listviewMtrlCtgryCrud_ItemInserted(object sender, ListViewInsertedEventArgs e)
        {
            string scriptText = "alert('Record Inserted '); window.location='" + Request.ApplicationPath + "MaterialCategory.aspx'";
            ScriptManager.RegisterStartupScript(this, this.GetType(), "alertMessage", scriptText, true);
        }

        protected void _listviewMtrlCtgryCrud_DataBound(object sender, EventArgs e)
        {
            if (_listviewMtrlCtgryCrud.Items.Count > 0)
            {
                _listviewMtrlCtgryCrud.InsertItemPosition = InsertItemPosition.None;
                _listviewMtrlCtgryCrud.DataBind();
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

        protected void _listviewMtrlCtgryCrud_ItemInserting(object sender, ListViewInsertEventArgs e)
        {
            TextBox MATERIALCTGRYNAMETextBox = (TextBox)_listviewMtrlCtgryCrud.InsertItem.FindControl("MATERIALCTGRYNAMETextBox");
            String Conn = ConfigurationManager.ConnectionStrings["ConnString_WEB_ASSET_DB"].ConnectionString;
            SqlConnection Connect = new SqlConnection(Conn);
            string MaterialCatName = MATERIALCTGRYNAMETextBox.Text.Trim();

            Connect.Open();
            SqlCommand Cmd = new SqlCommand("SELECT COUNT (*) FROM MATERIALCTGRY WHERE MATERIALCTGRYNAME=@MaterialCatName", Connect);
            Cmd.Parameters.AddWithValue("@MaterialCatName", MaterialCatName);
            Int32 Count = (Int32)Cmd.ExecuteScalar();
            if (Count > 0)
            {
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('Record Existing')", true);
                e.Cancel = true;

            }
        }

        protected void _listviewMtrlCtgryCrud_ItemUpdating(object sender, ListViewUpdateEventArgs e)
        {

            TextBox MATERIALCTGRYNAMETextBox = (TextBox)_listviewMtrlCtgryCrud.EditItem.FindControl("MATERIALCTGRYNAMETextBox");
            String Conn = ConfigurationManager.ConnectionStrings["ConnString_WEB_ASSET_DB"].ConnectionString;
            SqlConnection Connect = new SqlConnection(Conn);
            string MaterialCatName = MATERIALCTGRYNAMETextBox.Text.Trim();
            string MatCatID = e.Keys[0].ToString().Trim();

            Connect.Open();
            SqlCommand Cmd = new SqlCommand("SELECT COUNT (*) FROM MATERIALCTGRY WHERE MATERIALCTGRYNAME=@MaterialCatName AND MATERIALCTGRYID!=@MatCatID", Connect);
            Cmd.Parameters.AddWithValue("@MaterialCatName", MaterialCatName);
            Cmd.Parameters.AddWithValue("@MatCatID", MatCatID);
            Int32 Count = (Int32)Cmd.ExecuteScalar();
            if (Count > 0)
            {
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('Category Name is already existing.')", true);
                e.Cancel = true;
                // if (e.OldValues["MATERIALCTGRYNAME"].ToString() == MaterialCatName)
                //{

                //}

            }

        }
    }


}


using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Configuration;

namespace Construction_Asset_Management_System
{
    public partial class MaterialCRUD : System.Web.UI.Page
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

        protected void _listviewMaterialCRUD_ItemUpdated(object sender, ListViewUpdatedEventArgs e)
        {
            string scriptText = "alert('Record Updated'); window.location='" + Request.ApplicationPath + "Material.aspx'";
            ScriptManager.RegisterStartupScript(this, this.GetType(), "alertMessage", scriptText, true);
        }

        protected void _listviewMaterialCRUD_ItemDeleted(object sender, ListViewDeletedEventArgs e)
        {
            string scriptText = "alert('Record Deleted'); window.location='" + Request.ApplicationPath + "Material.aspx'";
            ScriptManager.RegisterStartupScript(this, this.GetType(), "alertMessage", scriptText, true);
        }

        protected void _listviewMaterialCRUD_ItemInserted(object sender, ListViewInsertedEventArgs e)
        {
            string scriptText = "alert('Record Inserted '); window.location='" + Request.ApplicationPath + "Material.aspx'";
            ScriptManager.RegisterStartupScript(this, this.GetType(), "alertMessage", scriptText, true);
        }

        protected void _listviewMaterialCRUD_DataBound(object sender, EventArgs e)
        {
            if (_listviewMaterialCRUD.Items.Count > 0)
            {
                _listviewMaterialCRUD.InsertItemPosition = InsertItemPosition.None;
                _listviewMaterialCRUD.DataBind();
            }
        }

        public void InsertButton_Click(object sender, EventArgs e)
        {
            FileUpload _fileupImage = (FileUpload)_listviewMaterialCRUD.InsertItem.FindControl("_fileupImage");
            TextBox MATERIALIMGTextBox = (TextBox)_listviewMaterialCRUD.InsertItem.FindControl("MATERIALIMGTextBox");
            TrimTextBoxesRecursive(Page);
            if (_fileupImage.HasFile)
            {
                string pathName = "uploadimages/" + Path.GetFileName(_fileupImage.PostedFile.FileName);
                MATERIALIMGTextBox.Text = pathName.ToString();
                _fileupImage.SaveAs(Server.MapPath("~/uploadimages/" + _fileupImage.FileName));
            }
        }

        protected void UpdateButton_Click(object sender, EventArgs e)
        {
            FileUpload _fileupImage = (FileUpload)_listviewMaterialCRUD.EditItem.FindControl("_fileupImage");
            TextBox MATERIALIMGTextBox = (TextBox)_listviewMaterialCRUD.EditItem.FindControl("MATERIALIMGTextBox");
            TrimTextBoxesRecursive(Page);
            if (_fileupImage.HasFile)
            {
                string pathName = "uploadimages/" + Path.GetFileName(_fileupImage.PostedFile.FileName);
                MATERIALIMGTextBox.Text = pathName.ToString();
                _fileupImage.SaveAs(Server.MapPath("~/uploadimages/" + _fileupImage.FileName));
            }
            
        }

        protected void _listviewMaterialCRUD_ItemInserting(object sender, ListViewInsertEventArgs e)
        {
            TextBox MATERIALNAMETextBox = (TextBox)_listviewMaterialCRUD.InsertItem.FindControl("MATERIALNAMETextBox");
            String Conn = ConfigurationManager.ConnectionStrings["ConnString_WEB_ASSET_DB"].ConnectionString;
            SqlConnection Connect = new SqlConnection(Conn);
            string MaterialName = MATERIALNAMETextBox.Text.Trim();

            Connect.Open();
            SqlCommand Cmd = new SqlCommand("SELECT COUNT (*) FROM MATERIAL WHERE MATERIALNAME=@MaterialName", Connect);
            Cmd.Parameters.AddWithValue("@MaterialName", MaterialName);
            Int32 Count = (Int32)Cmd.ExecuteScalar();
            if (Count > 0)
            {
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('Record Existing')", true);
                e.Cancel = true;

            }

            FileUpload _fileupImage = (FileUpload)_listviewMaterialCRUD.InsertItem.FindControl("_fileupImage");
            TextBox MATERIALIMGTextBox = (TextBox)_listviewMaterialCRUD.InsertItem.FindControl("MATERIALIMGTextBox");

            if (_fileupImage.HasFile)
            {
                string Extension = System.IO.Path.GetExtension(_fileupImage.FileName);
                if (Extension.ToLower() != ".gif" && Extension.ToLower() != ".png" && Extension.ToLower() != ".jpg" && Extension.ToLower() != ".jpeg")
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "popup", "alert('Invalid Image Format');", true);
                    e.Cancel = true;
                }
                else
                {
                    int FileSize = _fileupImage.PostedFile.ContentLength;
                    if (FileSize > 1048576)
                    {
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "popup", "alert('Maximum file size 1 mb');", true);
                        e.Cancel = true;
                    }
                }
            }

        }

        protected void _listviewMaterialCRUD_ItemUpdating(object sender, ListViewUpdateEventArgs e)
        {
            TextBox MATERIALNAMETextBox = (TextBox)_listviewMaterialCRUD.EditItem.FindControl("MATERIALNAMETextBox");
            String Conn = ConfigurationManager.ConnectionStrings["ConnString_WEB_ASSET_DB"].ConnectionString;
            string MaterialName = MATERIALNAMETextBox.Text.Trim();
            string MaterialID = e.Keys[0].ToString().Trim();
            SqlConnection Connect = new SqlConnection(Conn);
            Connect.Open();
            SqlCommand Cmd = new SqlCommand("SELECT COUNT (*) FROM MATERIAL WHERE MATERIALNAME=@MaterialName AND MATERIALID!=@MaterialID", Connect);
            Cmd.Parameters.AddWithValue("@MaterialName", MaterialName);
            Cmd.Parameters.AddWithValue("@MaterialID", MaterialID);
            Int32 Count = (Int32)Cmd.ExecuteScalar();
            if (Count > 0)
            {
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('Material is already existing')", true);
                e.Cancel = true;
            }

            FileUpload _fileupImage = (FileUpload)_listviewMaterialCRUD.EditItem.FindControl("_fileupImage");
            TextBox MATERIALIMGTextBox = (TextBox)_listviewMaterialCRUD.EditItem.FindControl("MATERIALIMGTextBox");

            if (_fileupImage.HasFile)
            {
                string Extension = System.IO.Path.GetExtension(_fileupImage.FileName);
                if (Extension.ToLower() != ".gif" && Extension.ToLower() != ".png" && Extension.ToLower() != ".jpg" && Extension.ToLower() != ".jpeg")
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "popup", "alert('Invalid Image Format');", true);
                    e.Cancel = true;
                }
                else
                {
                    int FileSize = _fileupImage.PostedFile.ContentLength;
                    if (FileSize > 1048576)
                    {
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "popup", "alert('Maximum file size 1 mb');", true);
                        e.Cancel = true;
                    }
                }

            }

        }
    }

}


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
using System.Net;

namespace Construction_Asset_Management_System
{
    public partial class Worker_CRUD : System.Web.UI.Page
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
        protected void _listviewWorkerCRUD_DataBound(object sender, EventArgs e)
        {
            if (_listviewWorkerCRUD.Items.Count > 0)
            {
                _listviewWorkerCRUD.InsertItemPosition = InsertItemPosition.None;
                _listviewWorkerCRUD.DataBind();
            }
        }

        protected void _listviewWorkerCRUD_ItemUpdated(object sender, ListViewUpdatedEventArgs e)
        {
            string scriptText = "alert('Record Updated'); window.location='" + Request.ApplicationPath + "Worker.aspx'";
            ScriptManager.RegisterStartupScript(this, this.GetType(), "alertMessage", scriptText, true);
        }

        protected void _listviewWorkerCRUD_ItemDeleted(object sender, ListViewDeletedEventArgs e)
        {
            string scriptText = "alert('Record Deleted'); window.location='" + Request.ApplicationPath + "Worker.aspx'";
            ScriptManager.RegisterStartupScript(this, this.GetType(), "alertMessage", scriptText, true);
        }

        protected void _listviewWorkerCRUD_ItemInserted(object sender, ListViewInsertedEventArgs e)
        {
            string scriptText = "alert('Record Inserted '); window.location='" + Request.ApplicationPath + "Worker.aspx'";
            ScriptManager.RegisterStartupScript(this, this.GetType(), "alertMessage", scriptText, true);
        }

        protected void InsertButton_Click(object sender, EventArgs e)
        {
            FileUpload _fileupImage = (FileUpload)_listviewWorkerCRUD.InsertItem.FindControl("_fileupImage");
            TextBox WORKERIMAGETextBox = (TextBox)_listviewWorkerCRUD.InsertItem.FindControl("WORKERIMAGETextBox");
            if (_fileupImage.HasFile)
            {
                string pathName = "uploadimages/" + Path.GetFileName(_fileupImage.PostedFile.FileName);
                WORKERIMAGETextBox.Text = pathName.ToString();
                _fileupImage.SaveAs(Server.MapPath("~/uploadimages/" + _fileupImage.FileName));
            }
            TrimTextBoxesRecursive(Page);
        }

        protected void UpdateButton_Click(object sender, EventArgs e)
        {
            FileUpload _fileupImage = (FileUpload)_listviewWorkerCRUD.EditItem.FindControl("_fileupImage");
            TextBox WORKERIMAGETextBox = (TextBox)_listviewWorkerCRUD.EditItem.FindControl("WORKERIMAGETextBox");
            TrimTextBoxesRecursive(Page);
            if (_fileupImage.HasFile)
            {
                string pathName = "uploadimages/" + Path.GetFileName(_fileupImage.PostedFile.FileName);
                WORKERIMAGETextBox.Text = pathName.ToString();
                _fileupImage.SaveAs(Server.MapPath("~/uploadimages/" + _fileupImage.FileName));
            }


        }

        protected void _listviewWorkerCRUD_ItemInserting(object sender, ListViewInsertEventArgs e)
        {
            TextBox WORKERFNAMETextBox = (TextBox)_listviewWorkerCRUD.InsertItem.FindControl("WORKERFNAMETextBox");
            TextBox WORKERLNAMETextBox = (TextBox)_listviewWorkerCRUD.InsertItem.FindControl("WORKERLNAMETextBox");
            TextBox WORKERMIDNAMETextBox = (TextBox)_listviewWorkerCRUD.InsertItem.FindControl("WORKERMIDNAMETextBox");
            String Conn = ConfigurationManager.ConnectionStrings["ConnString_WEB_ASSET_DB"].ConnectionString;
            SqlConnection Connect = new SqlConnection(Conn);
            string WorkerFirstName = WORKERFNAMETextBox.Text.Trim();
            string WorkerLastName = WORKERLNAMETextBox.Text.Trim();
            string WorkerMidName = WORKERMIDNAMETextBox.Text.Trim();

            Connect.Open();
            SqlCommand Cmd = new SqlCommand("SELECT COUNT (*) FROM WORKER WHERE WORKERFNAME=@WorkerFirstName AND WORKERLNAME=@WorkerLastName AND WORKERMIDNAME=@WorkerMidName ", Connect);
            Cmd.Parameters.AddWithValue("@WorkerFirstName", WorkerFirstName);
            Cmd.Parameters.AddWithValue("@WorkerLastName", WorkerLastName);
            Cmd.Parameters.AddWithValue("@WorkerMidName", WorkerMidName);
            Int32 Count = (Int32)Cmd.ExecuteScalar();
            if (Count > 0)
            {
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('Record Existing')", true);
                e.Cancel = true;
            }


            FileUpload _fileupImage = (FileUpload)_listviewWorkerCRUD.InsertItem.FindControl("_fileupImage");
            TextBox WORKERIMAGETextBox = (TextBox)_listviewWorkerCRUD.InsertItem.FindControl("WORKERIMAGETextBox");
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

        protected void _listviewWorkerCRUD_ItemUpdating(object sender, ListViewUpdateEventArgs e)
        {

            TextBox WORKERFNAMETextBox = (TextBox)_listviewWorkerCRUD.EditItem.FindControl("WORKERFNAMETextBox");
            TextBox WORKERLNAMETextBox = (TextBox)_listviewWorkerCRUD.EditItem.FindControl("WORKERLNAMETextBox");
            TextBox WORKERMIDNAMETextBox = (TextBox)_listviewWorkerCRUD.EditItem.FindControl("WORKERMIDNAMETextBox");
            String Conn = ConfigurationManager.ConnectionStrings["ConnString_WEB_ASSET_DB"].ConnectionString;
            SqlConnection Connect = new SqlConnection(Conn);
            string WorkerFirstName = WORKERFNAMETextBox.Text.Trim();
            string WorkerLastName = WORKERLNAMETextBox.Text.Trim();
            string WorkerMidName = WORKERMIDNAMETextBox.Text.Trim();
            string WorkerID = e.Keys[0].ToString().Trim();

            Connect.Open();
            SqlCommand Cmd = new SqlCommand("SELECT COUNT (*) FROM WORKER WHERE WORKERFNAME=@WorkerFirstName AND WORKERLNAME=@WorkerLastName AND WORKERMIDNAME=@WorkerMidName AND WORKERID!=@WorkerID", Connect);
            Cmd.Parameters.AddWithValue("@WorkerFirstName", WorkerFirstName);
            Cmd.Parameters.AddWithValue("@WorkerLastName", WorkerLastName);
            Cmd.Parameters.AddWithValue("@WorkerMidName", WorkerMidName);
            Cmd.Parameters.AddWithValue("@WorkerID", WorkerID);
            Int32 Count = (Int32)Cmd.ExecuteScalar();
            if (Count > 0)
            {
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('Record Existing')", true);
                e.Cancel = true;
            }
            //---------------------------------------------------------------------------
            FileUpload _fileupImage = (FileUpload)_listviewWorkerCRUD.EditItem.FindControl("_fileupImage");
            TextBox WORKERIMAGETextBox = (TextBox)_listviewWorkerCRUD.EditItem.FindControl("WORKERIMAGETextBox");
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

            //------------------------------------------------------------------------------------

            Connect = new SqlConnection(Conn);

            Label WORKERIDLabel = (Label)_listviewWorkerCRUD.EditItem.FindControl("WORKERIDLabel");
            DropDownList _dropdownLaborType = (DropDownList)_listviewWorkerCRUD.EditItem.FindControl("_dropdownLaborType");
            //string WorkerID = WORKERIDLabel.Text.ToString();
            //string WorkerID = e.Keys[0].ToString().Trim();
            if (_dropdownLaborType.SelectedValue == "0" || _dropdownLaborType.SelectedValue == "1" || _dropdownLaborType.SelectedValue == "2" || _dropdownLaborType.SelectedValue == "3")
            {
                Cmd = new SqlCommand("SELECT COUNT (*) FROM WORKERTRADE WHERE WORKERID=@WorkerID", Connect);
                Cmd.Parameters.AddWithValue("@WorkerID", WorkerID);
                Connect.Open();
                Count = (Int32)Cmd.ExecuteScalar();
                Connect.Close();
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

                }


            }
        }

        protected void _listviewWorkerCRUD_ItemDataBound(object sender, ListViewItemEventArgs e)
        {
            //String Conn = ConfigurationManager.ConnectionStrings["ConnString_WEB_ASSET_DB"].ConnectionString;
            //SqlConnection Connect = new SqlConnection(Conn);

            //if (_listviewWorkerCRUD.EditIndex > -1)
            //
            //
            //{
            //    Label WORKERIDLabel = (Label)e.Item.FindControl("WORKERIDLabel");
            //    DropDownList _dropdownLaborType = (DropDownList)e.Item.FindControl("_dropdownLaborType");
            //    string WorkerID = WORKERIDLabel.ToString();
            //    if (_dropdownLaborType.SelectedValue == "0" || _dropdownLaborType.SelectedValue == "1" || _dropdownLaborType.SelectedValue == "2" || _dropdownLaborType.SelectedValue == "3")
            //    {
            //        SqlCommand Cmd = new SqlCommand("SELECT COUNT (*) FROM WORKERTRADE WHERE WORKERID=@WorkerID", Connect);
            //        Cmd.Parameters.AddWithValue("@WorkerID", WorkerID);
            //        Connect.Open();
            //        Int32 Count = (Int32)Cmd.ExecuteScalar();
            //        Connect.Close();
            //        if (Count > 0)
            //        {
            //            for (int i = 0; i <= Count - 1; i++)
            //            {
            //                Connect.Open();
            //                Cmd = new SqlCommand("DELETE FROM WORKERTRADE WHERE WORKERID=@WorkerID", Connect);
            //                Cmd.Parameters.AddWithValue("@WorkerID", WorkerID);
            //                Cmd.ExecuteNonQuery();
            //                Connect.Close();
            //            }

            //        }

            //    }
            //}
        }
    }
}
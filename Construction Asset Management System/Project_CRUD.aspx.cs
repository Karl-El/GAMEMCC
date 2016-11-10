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
    public partial class Project_CRUD1 : System.Web.UI.Page
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


        protected void _listviewProjectCRUD_ItemUpdated(object sender, ListViewUpdatedEventArgs e)
        {
            string scriptText = "alert('Record Updated'); window.location='" + Request.ApplicationPath + "Project.aspx'";
            ScriptManager.RegisterStartupScript(this, this.GetType(), "alertMessage", scriptText, true);
        }

        protected void _listviewProjectCRUD_ItemDeleted(object sender, ListViewDeletedEventArgs e)
        {
            string scriptText = "alert('Record Deleted'); window.location='" + Request.ApplicationPath + "Project.aspx'";
            ScriptManager.RegisterStartupScript(this, this.GetType(), "alertMessage", scriptText, true);
        }

        protected void _listviewProjectCRUD_ItemInserted(object sender, ListViewInsertedEventArgs e)
        {
            string scriptText = "alert('Record Inserted'); window.location='" + Request.ApplicationPath + "Project.aspx'";
            ScriptManager.RegisterStartupScript(this, this.GetType(), "alertMessage", scriptText, true);
        }

        protected void _listviewProjectCRUD_DataBound(object sender, EventArgs e)
        {
            if (_listviewProjectCRUD.Items.Count > 0)
            {
                _listviewProjectCRUD.InsertItemPosition = InsertItemPosition.None;
                _listviewProjectCRUD.DataBind();

            }
        }

        protected void _listviewProjectCRUD_PreRender(object sender, EventArgs e)
        {
            if (_listviewProjectCRUD.Items.Count == 0)
            {
                DropDownList _dropdownCompany = (DropDownList)_listviewProjectCRUD.InsertItem.FindControl("_dropdownCompany");
                TextBox PROJPMINOTextBox = (TextBox)_listviewProjectCRUD.InsertItem.FindControl("PROJPMINOTextBox");
                TextBox DATETODAYTextBox = (TextBox)_listviewProjectCRUD.InsertItem.FindControl("DATETODAYTextBox");
                string ClientID = _dropdownCompany.SelectedValue.ToString();
                String Conn = ConfigurationManager.ConnectionStrings["ConnString_WEB_ASSET_DB"].ConnectionString;
                SqlConnection Connect = new SqlConnection(Conn);
                SqlCommand Cmd = new SqlCommand("SELECT COUNT (*) FROM PROJECT WHERE CLIENTID=@ClientID", Connect);
                Cmd.Parameters.AddWithValue("@ClientID", ClientID);
                Connect.Open();
                string Today = DateTime.Today.ToString("MMddyyyy");
                Int32 Count = (Int32)Cmd.ExecuteScalar() + 1;
                PROJPMINOTextBox.Text = "PMI" + "-" + Today + "-" + ClientID + "-" + Count;
                Connect.Close();
                DATETODAYTextBox.Text = DateTime.Today.ToString("MM/dd/yyyy");
                //Connect.Open();
                //Cmd = new SqlCommand("INSERT INTO PROJECT (PROGRESS) VALUES ('On Queue')", Connect);
                //Cmd.ExecuteNonQuery();
                //Connect.Close();
            }
        }

        protected void UpdateButton_Click(object sender, EventArgs e)
        {
            TextBox CLNTPROJCONTIDTextBox = (TextBox)_listviewProjectCRUD.EditItem.FindControl("CLNTPROJCONTIDTextBox");
            TextBox CLNTPROJPREPIDTextBox = (TextBox)_listviewProjectCRUD.EditItem.FindControl("CLNTPROJPREPIDTextBox");
            TextBox CLNTPROJAPPIDTextBox = (TextBox)_listviewProjectCRUD.EditItem.FindControl("CLNTPROJAPPIDTextBox");
            DropDownList _dropdownContact = (DropDownList)_listviewProjectCRUD.EditItem.FindControl("_dropdownContact");
            DropDownList _dropdownPrepared = (DropDownList)_listviewProjectCRUD.EditItem.FindControl("_dropdownPrepared");
            DropDownList _dropdownApproved = (DropDownList)_listviewProjectCRUD.EditItem.FindControl("_dropdownApproved");
            CLNTPROJCONTIDTextBox.Text = _dropdownContact.SelectedValue.ToString();
            CLNTPROJPREPIDTextBox.Text = _dropdownPrepared.SelectedValue.ToString();
            CLNTPROJAPPIDTextBox.Text = _dropdownApproved.SelectedValue.ToString();
            TrimTextBoxesRecursive(Page);
            FileUpload _fileupFileAttach = (FileUpload)_listviewProjectCRUD.EditItem.FindControl("_fileupFileAttach");
            TextBox PROJATTACHTextBox = (TextBox)_listviewProjectCRUD.EditItem.FindControl("PROJATTACHTextBox");
            if (_fileupFileAttach.HasFile)
            {
                string pathName = "uploadfiles/" + Path.GetFileName(_fileupFileAttach.PostedFile.FileName);
                PROJATTACHTextBox.Text = pathName.ToString();
                _fileupFileAttach.SaveAs(Server.MapPath("~/uploadfiles/" + _fileupFileAttach.FileName));
            }
        }

        protected void InsertButton_Click(object sender, EventArgs e)
        {
            TextBox CLNTPROJCONTIDTextBox = (TextBox)_listviewProjectCRUD.InsertItem.FindControl("CLNTPROJCONTIDTextBox");
            TextBox CLNTPROJPREPIDTextBox = (TextBox)_listviewProjectCRUD.InsertItem.FindControl("CLNTPROJPREPIDTextBox");
            TextBox CLNTPROJAPPIDTextBox = (TextBox)_listviewProjectCRUD.InsertItem.FindControl("CLNTPROJAPPIDTextBox");
            DropDownList _dropdownContact = (DropDownList)_listviewProjectCRUD.InsertItem.FindControl("_dropdownContact");
            DropDownList _dropdownPrepared = (DropDownList)_listviewProjectCRUD.InsertItem.FindControl("_dropdownPrepared");
            DropDownList _dropdownApproved = (DropDownList)_listviewProjectCRUD.InsertItem.FindControl("_dropdownApproved");
            CLNTPROJCONTIDTextBox.Text = _dropdownContact.SelectedValue.ToString();
            CLNTPROJPREPIDTextBox.Text = _dropdownPrepared.SelectedValue.ToString();
            CLNTPROJAPPIDTextBox.Text = _dropdownApproved.SelectedValue.ToString();
            TrimTextBoxesRecursive(Page);
            FileUpload _fileupFileAttach = (FileUpload)_listviewProjectCRUD.InsertItem.FindControl("_fileupFileAttach");
            TextBox PROJATTACHTextBox = (TextBox)_listviewProjectCRUD.InsertItem.FindControl("PROJATTACHTextBox");
            if (_fileupFileAttach.HasFile)
            {
                string pathName = "uploadfiles/" + Path.GetFileName(_fileupFileAttach.PostedFile.FileName);
                PROJATTACHTextBox.Text = pathName.ToString();
                _fileupFileAttach.SaveAs(Server.MapPath("~/uploadfiles/" + _fileupFileAttach.FileName));
            }
            
        }

        protected void _listviewProjectCRUD_ItemInserting(object sender, ListViewInsertEventArgs e)
        {
            FileUpload _fileupFileAttach = (FileUpload)_listviewProjectCRUD.InsertItem.FindControl("_fileupFileAttach");
            TextBox PROJATTACHTextBox = (TextBox)_listviewProjectCRUD.InsertItem.FindControl("PROJATTACHTextBox");

            if (_fileupFileAttach.HasFile)
            {
                string Extension = System.IO.Path.GetExtension(_fileupFileAttach.FileName);
                if (Extension.ToLower() != ".gif" && Extension.ToLower() != ".zip" && Extension.ToLower() != ".rar")
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "popup", "alert('Invalid File Format! Must be ZIP/RAR format');", true);
                    e.Cancel = true;
                }
                else
                {
                    int FileSize = _fileupFileAttach.PostedFile.ContentLength;
                    if (FileSize > 5048576)
                    {
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "popup", "alert('Maximum file size 5 mb');", true);
                        e.Cancel = true;
                    }
                }
            }
        }

        protected void _listviewProjectCRUD_ItemUpdating(object sender, ListViewUpdateEventArgs e)
        {
            FileUpload _fileupFileAttach = (FileUpload)_listviewProjectCRUD.EditItem.FindControl("_fileupFileAttach");
            TextBox PROJATTACHTextBox = (TextBox)_listviewProjectCRUD.EditItem.FindControl("PROJATTACHTextBox");

            if (_fileupFileAttach.HasFile)
            {
                string Extension = System.IO.Path.GetExtension(_fileupFileAttach.FileName);
                if (Extension.ToLower() != ".gif" && Extension.ToLower() != ".zip" && Extension.ToLower() != ".rar")
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "popup", "alert('Invalid File Format! Must be ZIP/RAR format');", true);
                    e.Cancel = true;
                }
                else
                {
                    int FileSize = _fileupFileAttach.PostedFile.ContentLength;
                    if (FileSize > 5048576)
                    {
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "popup", "alert('Maximum file size 5 mb');", true);
                        e.Cancel = true;
                    }
                }
            }
        }


        protected void _listviewProjectCRUD_ItemDataBound(object sender, ListViewItemEventArgs e)
        {
            if (_listviewProjectCRUD.EditIndex > -1)
            {
                TextBox CLNTPROJCONTIDTextBox = (TextBox)e.Item.FindControl("CLNTPROJCONTIDTextBox");
                TextBox CLNTPROJPREPIDTextBox = (TextBox)e.Item.FindControl("CLNTPROJPREPIDTextBox");
                TextBox CLNTPROJAPPIDTextBox = (TextBox)e.Item.FindControl("CLNTPROJAPPIDTextBox");
                DropDownList _dropdownContact = (DropDownList)e.Item.FindControl("_dropdownContact");
                DropDownList _dropdownPrepared = (DropDownList)e.Item.FindControl("_dropdownPrepared");
                DropDownList _dropdownApproved = (DropDownList)e.Item.FindControl("_dropdownApproved");
                _dropdownContact.SelectedValue = CLNTPROJCONTIDTextBox.Text.ToString();
                _dropdownPrepared.SelectedValue = CLNTPROJPREPIDTextBox.Text.ToString();
                _dropdownApproved.SelectedValue = CLNTPROJAPPIDTextBox.Text.ToString();

            }

        }


        protected void _linkbtnDownload_Click(object sender, EventArgs e)
        {
            //if (e.Item.ItemType == ListViewItemType.DataItem)
            //{
            //    var PROJIDLabel = (Label)e.Item.FindControl("PROJIDLabel"); string ProjID = PROJIDLabel.Text;
            //    String Conn = ConfigurationManager.ConnectionStrings["ConnString_WEB_ASSET_DB"].ConnectionString;
            //    SqlConnection Connect = new SqlConnection(Conn);
            //    SqlCommand Cmd = new SqlCommand("SELECT PROJATTACH FROM PROJECT WHERE PROJID=@ProjID", Connect);
            //    Cmd.Parameters.AddWithValue("@ProjID", ProjID);
            //    SqlDataReader Reader = Cmd.ExecuteReader();
            //    while (Reader.Read())
            //    {
            //        string Path = Reader["PROJSITE"].ToString();
            //        Response.TransmitFile(Server.MapPath(Path));
            //    }
            //}
            //Label PROJIDLabel = (Label)_listviewProjectCRUD.FindControl("PROJIDLabel");
            //string ProjID = PROJIDLabel.Text;
            //String Conn = ConfigurationManager.ConnectionStrings["ConnString_WEB_ASSET_DB"].ConnectionString;
            //SqlConnection Connect = new SqlConnection(Conn);
            //SqlCommand Cmd = new SqlCommand("SELECT PROJATTACH FROM PROJECT WHERE PROJID=@ProjID", Connect);
            //Cmd.Parameters.AddWithValue("@ProjID", ProjID);
            //SqlDataReader Reader = Cmd.ExecuteReader();
            //while (Reader.Read())
            //{
            //    string Path = Reader["PROJSITE"].ToString();
            //    Response.TransmitFile(Server.MapPath(Path));
            //}
        }

        protected void _listviewProjectCRUD_ItemCommand(object sender, ListViewCommandEventArgs e)
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

    }
}
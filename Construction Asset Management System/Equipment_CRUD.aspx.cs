using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Drawing;
using System.Drawing.Imaging;
using System.IO;
using System.Drawing.Text;
using QRCoder;

namespace Construction_Asset_Management_System
{
    public partial class Equipment_CRUD : System.Web.UI.Page
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

        protected void _listviewEquipmentCRUD_ItemUpdated(object sender, ListViewUpdatedEventArgs e)
        {
            string scriptText = "alert('Record Updated'); window.location='" + Request.ApplicationPath + "Equipment.aspx'";
            ScriptManager.RegisterStartupScript(this, this.GetType(), "alertMessage", scriptText, true);
        }

        protected void _listviewEquipmentCRUD_ItemDeleted(object sender, ListViewDeletedEventArgs e)
        {
            string scriptText = "alert('Record Deleted'); window.location='" + Request.ApplicationPath + "Equipment.aspx'";
            ScriptManager.RegisterStartupScript(this, this.GetType(), "alertMessage", scriptText, true);
        }

        protected void _listviewEquipmentCRUD_ItemInserted(object sender, ListViewInsertedEventArgs e)
        {
            string scriptText = "alert('Record Inserted'); window.location='" + Request.ApplicationPath + "Equipment.aspx'";
            ScriptManager.RegisterStartupScript(this, this.GetType(), "alertMessage", scriptText, true);
        }

        protected void _listviewEquipmentCRUD_DataBound(object sender, EventArgs e)
        {
            if (_listviewEquipmentCRUD.Items.Count > 0)
            {
                _listviewEquipmentCRUD.InsertItemPosition = InsertItemPosition.None;
                _listviewEquipmentCRUD.DataBind();
            }

        }

        public void InsertButton_Click(object sender, EventArgs e)
        {
            TextBox EQUIPMENTIMGTextBox = (TextBox)_listviewEquipmentCRUD.InsertItem.FindControl("EQUIPMENTIMGTextBox");
            TextBox EQUIPMENTNAMETextBox = (TextBox)_listviewEquipmentCRUD.InsertItem.FindControl("EQUIPMENTNAMETextBox");
            String Code = EQUIPMENTNAMETextBox.Text.ToUpper();
            QRCodeGenerator qrGenerator = new QRCodeGenerator();
            QRCodeGenerator.QRCode qrCode = qrGenerator.CreateQrCode(Code, QRCodeGenerator.ECCLevel.Q);
            System.Web.UI.WebControls.Image imgBarCode = new System.Web.UI.WebControls.Image();
            imgBarCode.Height = 150;
            imgBarCode.Width = 150;
            using (Bitmap bitMap = qrCode.GetGraphic(20))
            {
                using (MemoryStream ms = new MemoryStream())
                {
                    string FileDest = Server.MapPath("~/barcodeimagesequip/");
                    string FileName = FileDest + EQUIPMENTNAMETextBox.Text.ToUpper() + "QrCode.png";
                    bitMap.Save(FileName, ImageFormat.Png);
                    bitMap.Save(ms, System.Drawing.Imaging.ImageFormat.Png);
                    //byte[] byteImage = ms.ToArray();
                    //imgBarCode.ImageUrl = "data:image/png;base64," + Convert.ToBase64String(byteImage);
                }
            }
            EQUIPMENTIMGTextBox.Text = "\\barcodeimagesequip\\" + EQUIPMENTNAMETextBox.Text.ToUpper() + "QrCode.png";
            //FileUpload _fileupImage = (FileUpload)_listviewEquipmentCRUD.InsertItem.FindControl("_fileupImage");
            //TrimTextBoxesRecursive(Page);
            //if (_fileupImage.HasFile)
            //{
            //    string pathName = "uploadimages/" + Path.GetFileName(_fileupImage.PostedFile.FileName);
            //    EQUIPMENTIMGTextBox.Text = pathName.ToString();
            //    _fileupImage.SaveAs(Server.MapPath("~/uploadimages/" + _fileupImage.FileName));
            //}
        }

        protected void UpdateButton_Click(object sender, EventArgs e)
        {
            TextBox EQUIPMENTIMGTextBox = (TextBox)_listviewEquipmentCRUD.EditItem.FindControl("EQUIPMENTIMGTextBox");
            TextBox EQUIPMENTNAMETextBox = (TextBox)_listviewEquipmentCRUD.EditItem.FindControl("EQUIPMENTNAMETextBox");
            String Code = EQUIPMENTNAMETextBox.Text.ToUpper();
            QRCodeGenerator qrGenerator = new QRCodeGenerator();
            QRCodeGenerator.QRCode qrCode = qrGenerator.CreateQrCode(Code, QRCodeGenerator.ECCLevel.Q);
            System.Web.UI.WebControls.Image imgBarCode = new System.Web.UI.WebControls.Image();
            imgBarCode.Height = 150;
            imgBarCode.Width = 150;
            using (Bitmap bitMap = qrCode.GetGraphic(20))
            {
                using (MemoryStream ms = new MemoryStream())
                {
                    string FileDest = Server.MapPath("~/barcodeimagesequip/");
                    string FileName = FileDest + EQUIPMENTNAMETextBox.Text.ToUpper() + "QrCode.png";
                    bitMap.Save(FileName, ImageFormat.Png);
                    bitMap.Save(ms, System.Drawing.Imaging.ImageFormat.Png);
                    //byte[] byteImage = ms.ToArray();
                    //imgBarCode.ImageUrl = "data:image/png;base64," + Convert.ToBase64String(byteImage);
                }
            }
            EQUIPMENTIMGTextBox.Text = "\\barcodeimagesequip\\" + EQUIPMENTNAMETextBox.Text.ToUpper() + "QrCode.png";
            //FileUpload _fileupImage = (FileUpload)_listviewEquipmentCRUD.EditItem.FindControl("_fileupImage");
            //TrimTextBoxesRecursive(Page);
            //if (_fileupImage.HasFile)
            //{
            //    string pathName = "uploadimages/" + Path.GetFileName(_fileupImage.PostedFile.FileName);
            //    EQUIPMENTIMGTextBox.Text = pathName.ToString();
            //    _fileupImage.SaveAs(Server.MapPath("~/uploadimages/" + _fileupImage.FileName));
            //}

        }

        protected void _listviewEquipmentCRUD_ItemInserting(object sender, ListViewInsertEventArgs e)
        {
            TextBox EQUIPMENTNAMETextBox = (TextBox)_listviewEquipmentCRUD.InsertItem.FindControl("EQUIPMENTNAMETextBox");
            String Conn = ConfigurationManager.ConnectionStrings["ConnString_WEB_ASSET_DB"].ConnectionString;
            SqlConnection Connect = new SqlConnection(Conn);
            string EquipmentName = EQUIPMENTNAMETextBox.Text.Trim();


            Connect.Open();
            SqlCommand Cmd = new SqlCommand("SELECT COUNT (*) FROM EQUIPMENT WHERE EQUIPMENTNAME=@EquipmentName", Connect);
            Cmd.Parameters.AddWithValue("@EquipmentName", EquipmentName);
            Int32 Count = (Int32)Cmd.ExecuteScalar();
            if (Count > 0)
            {
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('Record Existing')", true);
                e.Cancel = true;

            }
            Connect.Close();
            //FileUpload _fileupImage = (FileUpload)_listviewEquipmentCRUD.InsertItem.FindControl("_fileupImage");
            //TextBox EQUIPMENTIMGTextBox = (TextBox)_listviewEquipmentCRUD.InsertItem.FindControl("EQUIPMENTIMGTextBox");

            //if (_fileupImage.HasFile)
            //{
            //    string Extension = System.IO.Path.GetExtension(_fileupImage.FileName);
            //    if (Extension.ToLower() != ".gif" && Extension.ToLower() != ".png" && Extension.ToLower() != ".jpg" && Extension.ToLower() != ".jpeg")
            //    {
            //        ScriptManager.RegisterStartupScript(this, this.GetType(), "popup", "alert('Invalid Image Format');", true);
            //        e.Cancel = true;
            //    }
            //    else
            //    {
            //        int FileSize = _fileupImage.PostedFile.ContentLength;
            //        if (FileSize > 1048576)
            //        {
            //            ScriptManager.RegisterStartupScript(this, this.GetType(), "popup", "alert('Maximum file size 1 mb');", true);
            //            e.Cancel = true;
            //        }
            //    }
            //}

        }

        protected void _listviewEquipmentCRUD_ItemUpdating(object sender, ListViewUpdateEventArgs e)
        {
            TextBox EQUIPMENTNAMETextBox = (TextBox)_listviewEquipmentCRUD.EditItem.FindControl("EQUIPMENTNAMETextBox");
            String Conn = ConfigurationManager.ConnectionStrings["ConnString_WEB_ASSET_DB"].ConnectionString;
            SqlConnection Connect = new SqlConnection(Conn);
            string EquipmentName = EQUIPMENTNAMETextBox.Text.Trim();
            string EquipmentID = e.Keys[0].ToString().Trim();

            Connect.Open();
            SqlCommand Cmd = new SqlCommand("SELECT COUNT (*) FROM EQUIPMENT WHERE EQUIPMENTNAME=@EquipmentName AND EQUIPMENTID!=@EquipmentID", Connect);
            Cmd.Parameters.AddWithValue("@EquipmentName", EquipmentName);
            Cmd.Parameters.AddWithValue("@EquipmentID", EquipmentID);
            Int32 Count = (Int32)Cmd.ExecuteScalar();
            if (Count > 0)
            {
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('Record Existing')", true);
                e.Cancel = true;

            }

            //FileUpload _fileupImage = (FileUpload)_listviewEquipmentCRUD.EditItem.FindControl("_fileupImage");
            //TextBox EQUIPMENTIMGTextBox = (TextBox)_listviewEquipmentCRUD.EditItem.FindControl("EQUIPMENTIMGTextBox");

            //if (_fileupImage.HasFile)
            //{
            //    string Extension = System.IO.Path.GetExtension(_fileupImage.FileName);
            //    if (Extension.ToLower() != ".gif" && Extension.ToLower() != ".png" && Extension.ToLower() != ".jpg" && Extension.ToLower() != ".jpeg")
            //    {
            //        ScriptManager.RegisterStartupScript(this, this.GetType(), "popup", "alert('Invalid Image Format');", true);
            //        e.Cancel = true;
            //    }
            //    else
            //    {
            //        int FileSize = _fileupImage.PostedFile.ContentLength;
            //        if (FileSize > 1048576)
            //        {
            //            ScriptManager.RegisterStartupScript(this, this.GetType(), "popup", "alert('Maximum file size 1 mb');", true);
            //            e.Cancel = true;
            //        }
            //    }
            //}
        }
    }
}
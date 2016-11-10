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
    public partial class Badge_CRUD : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        public void _dropdownWorker_SelectedIndexChanged(object sender, EventArgs e)
        {
            string WorkerID = _dropdownWorker.SelectedValue.ToString();
            String Conn = ConfigurationManager.ConnectionStrings["ConnString_WEB_ASSET_DB"].ConnectionString;
            SqlConnection Connect = new SqlConnection(Conn);
            Connect.Open();
            SqlCommand Cmd = new SqlCommand("SELECT COUNT (*) FROM BADGE WHERE WORKERID=@WorkerID", Connect);
            Cmd.Parameters.AddWithValue("@WorkerID", WorkerID);
            Int32 Count = (Int32)Cmd.ExecuteScalar();
            Connect.Close();
            if (Count == 0)
            {
                Connect.Open();
                Cmd = new SqlCommand("SELECT WORKERID, WORKERIMAGE, WORKERFNAME, WORKERLNAME, WORKERDOB FROM WORKER WHERE WORKERID=@WorkerID", Connect);
                Cmd.Parameters.AddWithValue("@WorkerID", WorkerID);
                SqlDataReader Reader = Cmd.ExecuteReader();
                while (Reader.Read())
                {
                    _labelID.Text = Reader["WORKERID"].ToString();
                    _imageWorker.ImageUrl = Reader["WORKERIMAGE"].ToString();
                    //_txtValidFrom.Text = Reader["BADGEFROM"].ToString();
                    //_txtValidTo.Text = Reader["BADGETO"].ToString();
                    string FirstName = Reader["WORKERFNAME"].ToString();
                    string DateOfBirth = Reader["WORKERDOB"].ToString();
                    DateTime DOB = Convert.ToDateTime(DateOfBirth);
                    string Birthdate = DOB.Date.ToString("MM/dd/yyyy");
                    string FName;
                    if (FirstName.Length < 4)
                    {
                        FName = FirstName + "0";
                        FName = FName.Substring(0, 4);
                    }
                    else
                    {
                        FName = FirstName.Substring(0, 4);
                    }
                    int IdWork = Convert.ToInt32(_labelID.Text);
                    string WorkID = IdWork.ToString("00000");
                    _txtBadgeCode.Text = WorkID + FName.Replace(" ", string.Empty) + Birthdate.Replace("/", string.Empty);
                    _txtBadgeCode.Text = _txtBadgeCode.Text.ToUpper();
                    _txtValidFrom.Text = "";
                    _txtValidTo.Text = "";
                    _dropdownBadgeStat.ClearSelection();
                }
                Connect.Close();
                Cmd.Parameters.Clear();
            }
            else
            {
                Connect.Open();
                Cmd = new SqlCommand("SELECT BADGE.WORKERID, WORKERIMAGE, WORKERFNAME, WORKERLNAME, WORKERDOB, BADGE.BADGEFROM, BADGE.BADGETO,BADGE.BADGESTAT FROM WORKER JOIN BADGE ON BADGE.WORKERID=WORKER.WORKERID WHERE BADGE.WORKERID=@WorkerID", Connect);
                Cmd.Parameters.AddWithValue("@WorkerID", WorkerID);
                SqlDataReader Reader = Cmd.ExecuteReader();
                while (Reader.Read())
                {
                    _labelID.Text = Reader["WORKERID"].ToString();
                    _imageWorker.ImageUrl = Reader["WORKERIMAGE"].ToString();
                    //_txtValidFrom.Text = Reader["BADGEFROM"].ToString();
                    //_txtValidTo.Text = Reader["BADGETO"].ToString();
                    DateTime From = Convert.ToDateTime(Reader["BADGEFROM"].ToString());
                    DateTime To = Convert.ToDateTime(Reader["BADGETO"].ToString());
                    _txtValidFrom.Text = From.ToString("MM/dd/yyyy");
                    _txtValidTo.Text = To.ToString("MM/dd/yyyy");
                    string FirstName = Reader["WORKERFNAME"].ToString();
                    string DateOfBirth = Reader["WORKERDOB"].ToString();
                    DateTime DOB = Convert.ToDateTime(DateOfBirth);
                    string Birthdate = DOB.Date.ToString("MM/dd/yyyy");
                    string FName;
                    if (FirstName.Length < 4)
                    {
                         FName = FirstName + "0";
                         FName = FName.Substring(0, 4);
                    }
                    else
                    {
                         FName = FirstName.Substring(0, 4);
                    }
                    int IdWork = Convert.ToInt32(_labelID.Text);
                    string WorkID = IdWork.ToString("00000");
                    _txtBadgeCode.Text = WorkID + FName.Replace(" ", string.Empty) + Birthdate.Replace("/", string.Empty);
                    _txtBadgeCode.Text = _txtBadgeCode.Text.ToUpper();
                    _dropdownBadgeStat.SelectedValue = Reader["BADGESTAT"].ToString();
                }
                Connect.Close();
                Cmd.Parameters.Clear();
            }
        }

        protected void SaveButton_Click(object sender, EventArgs e)
        {
            string Code = _txtBadgeCode.Text;
            QRCodeGenerator qrGenerator = new QRCodeGenerator();
            QRCodeGenerator.QRCode qrCode = qrGenerator.CreateQrCode(Code, QRCodeGenerator.ECCLevel.Q);
            System.Web.UI.WebControls.Image imgBarCode = new System.Web.UI.WebControls.Image();
            imgBarCode.Height = 150;
            imgBarCode.Width = 150;
            using (Bitmap bitMap = qrCode.GetGraphic(20))
            {
                using (MemoryStream ms = new MemoryStream())
                {
                    string FileDest = Server.MapPath("~/barcodeimages/");
                    string FileName = FileDest + _txtBadgeCode.Text + "QrCode.png";
                    //string FileName = "C:\\Users\\Carl\\Documents\\Visual Studio 2013\\Projects\\Construction Asset Management System\\Construction Asset Management System\\barcodeimages\\" + _txtBadgeCode.Text + "QrCode.png";
                    bitMap.Save(FileName, ImageFormat.Png);
                    bitMap.Save(ms, System.Drawing.Imaging.ImageFormat.Png);
                    //byte[] byteImage = ms.ToArray();
                    //imgBarCode.ImageUrl = "data:image/png;base64," + Convert.ToBase64String(byteImage);
                }
            }

            string WorkerID = _dropdownWorker.SelectedValue.ToString();
            string BadgeCodePic = "\\barcodeimages\\" + _txtBadgeCode.Text + "QrCode.png";
            String Conn = ConfigurationManager.ConnectionStrings["ConnString_WEB_ASSET_DB"].ConnectionString;
            SqlConnection Connect = new SqlConnection(Conn);
            Connect.Open();
            SqlCommand Cmd = new SqlCommand("SELECT COUNT (*) FROM BADGE WHERE WORKERID=@WorkerID", Connect);
            Cmd.Parameters.AddWithValue("@WorkerID", WorkerID);
            Int32 Count = (Int32)Cmd.ExecuteScalar();
            Connect.Close();
            if (Count == 0)
            {
                Connect.Open();
                Cmd = new SqlCommand("INSERT INTO BADGE (BADGECODE, BADGESTAT, BADGEFROM, BADGETO, WORKERID, BADGEPICCODE) VALUES ( @badgecode, @badgestat, @badgefrom, @badgeto, @workerid,@badgepiccode) ", Connect);
                Cmd.Parameters.AddWithValue("@badgecode", _txtBadgeCode.Text);
                Cmd.Parameters.AddWithValue("@badgestat", _dropdownBadgeStat.SelectedValue);
                Cmd.Parameters.AddWithValue("@badgefrom", _txtValidFrom.Text);
                Cmd.Parameters.AddWithValue("@badgeto", _txtValidTo.Text);
                Cmd.Parameters.AddWithValue("@workerid", WorkerID);
                Cmd.Parameters.AddWithValue("@badgepiccode", BadgeCodePic);
                Cmd.ExecuteNonQuery();
                Connect.Close();
                string scriptText = "alert('Badge Created'); window.location='" + Request.ApplicationPath + "Badge.aspx'";
                ScriptManager.RegisterStartupScript(this, this.GetType(), "alertMessage", scriptText, true);
            }
            else
            {
                Code = _txtBadgeCode.Text;
                qrGenerator = new QRCodeGenerator();
                qrCode = qrGenerator.CreateQrCode(Code, QRCodeGenerator.ECCLevel.Q);
                imgBarCode = new System.Web.UI.WebControls.Image();
                imgBarCode.Height = 150;
                imgBarCode.Width = 150;
                using (Bitmap bitMap = qrCode.GetGraphic(20))
                {
                    using (MemoryStream ms = new MemoryStream())
                    {
                        string FileDest = Server.MapPath("~/barcodeimages/");
                        string FileName = FileDest + _txtBadgeCode.Text + "QrCode.png";
                        //string FileName = "C:\\Users\\Carl\\Documents\\Visual Studio 2013\\Projects\\Construction Asset Management System\\Construction Asset Management System\\barcodeimages\\" + _txtBadgeCode.Text + "QrCode.png";
                        bitMap.Save(FileName, ImageFormat.Png);
                        bitMap.Save(ms, System.Drawing.Imaging.ImageFormat.Png);
                        //byte[] byteImage = ms.ToArray();
                        //imgBarCode.ImageUrl = "data:image/png;base64," + Convert.ToBase64String(byteImage);
                    }
                }

                _dropdownWorker.Enabled = false;
                Connect.Open();
                Cmd = new SqlCommand("UPDATE BADGE SET BADGEPICCODE=@badgepiccode,BADGECODE=@badgecode,BADGESTAT=@badgestat, BADGEFROM=@badgefrom, BADGETO=@badgeto WHERE WORKERID=@workerid", Connect);
                Cmd.Parameters.AddWithValue("@badgecode", _txtBadgeCode.Text);
                Cmd.Parameters.AddWithValue("@badgestat", _dropdownBadgeStat.SelectedValue);
                Cmd.Parameters.AddWithValue("@badgefrom", _txtValidFrom.Text);
                Cmd.Parameters.AddWithValue("@badgeto", _txtValidTo.Text);
                Cmd.Parameters.AddWithValue("@workerid", WorkerID);
                Cmd.Parameters.AddWithValue("@badgepiccode", BadgeCodePic);
                Cmd.ExecuteNonQuery();
                Connect.Close();
                string scriptText = "alert('Badge Updated'); window.location='" + Request.ApplicationPath + "Badge.aspx'";
                ScriptManager.RegisterStartupScript(this, this.GetType(), "alertMessage", scriptText, true);
            }
        }

        protected void _dropdownWorker_PreRender(object sender, EventArgs e)
        {
            ListItem ChosenValue = _dropdownWorker.Items.FindByValue(Request.QueryString["id"]);
            if (ChosenValue != null)
            {
                _dropdownWorker.Enabled = false;
                _dropdownWorker.SelectedValue = Request.QueryString["id"] ?? String.Empty;
                string WorkerID = _dropdownWorker.SelectedValue.ToString();
                String Conn = ConfigurationManager.ConnectionStrings["ConnString_WEB_ASSET_DB"].ConnectionString;
                SqlConnection Connect = new SqlConnection(Conn);
                Connect.Open();
                SqlCommand Cmd = new SqlCommand("SELECT BADGE.WORKERID, WORKERIMAGE, WORKERFNAME, WORKERLNAME, WORKERDOB, BADGE.BADGEFROM, BADGE.BADGETO,BADGE.BADGESTAT FROM WORKER JOIN BADGE ON BADGE.WORKERID=WORKER.WORKERID WHERE BADGE.WORKERID=@WorkerID", Connect);
                Cmd.Parameters.AddWithValue("@WorkerID", WorkerID);
                SqlDataReader Reader = Cmd.ExecuteReader();
                while (Reader.Read())
                {
                    _labelID.Text = Reader["WORKERID"].ToString();
                    _imageWorker.ImageUrl = Reader["WORKERIMAGE"].ToString();
                    //_txtValidFrom.Text = Reader["BADGEFROM"].ToString();
                    //_txtValidTo.Text = Reader["BADGETO"].ToString();
                    DateTime From = Convert.ToDateTime(Reader["BADGEFROM"].ToString());
                    DateTime To = Convert.ToDateTime(Reader["BADGETO"].ToString());
                    _txtValidFrom.Text = From.ToString("MM/dd/yyyy");
                    _txtValidTo.Text = To.ToString("MM/dd/yyyy");
                    string FirstName = Reader["WORKERFNAME"].ToString();
                    string DateOfBirth = Reader["WORKERDOB"].ToString();
                    DateTime DOB = Convert.ToDateTime(DateOfBirth);
                    string Birthdate = DOB.Date.ToString("MM/dd/yyyy");
                    string FName;
                    if (FirstName.Length < 4)
                    {
                        FName = FirstName + "0";
                        FName = FName.Substring(0, 4);
                    }
                    else
                    {
                        FName = FirstName.Substring(0, 4);
                    }
                    int IdWork = Convert.ToInt32(_labelID.Text);
                    string WorkID = IdWork.ToString("00000");
                    _txtBadgeCode.Text = WorkID + FName.Replace(" ", string.Empty) + Birthdate.Replace("/", string.Empty);
                    _txtBadgeCode.Text = _txtBadgeCode.Text.ToUpper();
                    _dropdownBadgeStat.SelectedValue = Reader["BADGESTAT"].ToString();
                }
            }
            else
            {
                _dropdownWorker.Enabled = true;
                string WorkerID = _dropdownWorker.SelectedValue.ToString();
                String Conn = ConfigurationManager.ConnectionStrings["ConnString_WEB_ASSET_DB"].ConnectionString;
                SqlConnection Connect = new SqlConnection(Conn);
                Connect.Open();
                SqlCommand Cmd = new SqlCommand("SELECT COUNT (*) FROM BADGE WHERE WORKERID=@WorkerID", Connect);
                Cmd.Parameters.AddWithValue("@WorkerID", WorkerID);
                Int32 Count = (Int32)Cmd.ExecuteScalar();
                Connect.Close();
                if (Count == 0)
                {
                    Connect.Open();
                    Cmd = new SqlCommand("SELECT WORKERID, WORKERIMAGE, WORKERFNAME, WORKERLNAME, WORKERDOB FROM WORKER WHERE WORKERID=@WorkerID", Connect);
                    Cmd.Parameters.AddWithValue("@WorkerID", WorkerID);
                    SqlDataReader Reader = Cmd.ExecuteReader();
                    while (Reader.Read())
                    {
                        _labelID.Text = Reader["WORKERID"].ToString();
                        _imageWorker.ImageUrl = Reader["WORKERIMAGE"].ToString();
                        //_txtValidFrom.Text = Reader["BADGEFROM"].ToString();
                        //_txtValidTo.Text = Reader["BADGETO"].ToString();
                        string FirstName = Reader["WORKERFNAME"].ToString();
                        string DateOfBirth = Reader["WORKERDOB"].ToString();
                        DateTime DOB = Convert.ToDateTime(DateOfBirth);
                        string Birthdate = DOB.Date.ToString("MM/dd/yyyy");
                        string FName;
                        if (FirstName.Length < 4)
                        {
                            FName = FirstName + "0";
                            FName = FName.Substring(0, 4);
                        }
                        else
                        {
                            FName = FirstName.Substring(0, 4);
                        }
                        int IdWork = Convert.ToInt32(_labelID.Text);
                        string WorkID = IdWork.ToString("00000");
                        _txtBadgeCode.Text = WorkID + FName.Replace(" ", string.Empty) + Birthdate.Replace("/", string.Empty);
                        _txtBadgeCode.Text = _txtBadgeCode.Text.ToUpper();
                        _txtValidFrom.Text = "";
                        _txtValidTo.Text = "";
                        _dropdownBadgeStat.ClearSelection();
                    }
                    Connect.Close();
                    Cmd.Parameters.Clear();
                }
                else
                {
                    Connect.Open();
                    Cmd = new SqlCommand("SELECT BADGE.WORKERID, WORKERIMAGE, WORKERFNAME, WORKERLNAME, WORKERDOB, BADGE.BADGEFROM, BADGE.BADGETO,BADGE.BADGESTAT FROM WORKER JOIN BADGE ON BADGE.WORKERID=WORKER.WORKERID WHERE BADGE.WORKERID=@WorkerID", Connect);
                    Cmd.Parameters.AddWithValue("@WorkerID", WorkerID);
                    SqlDataReader Reader = Cmd.ExecuteReader();
                    while (Reader.Read())
                    {
                        _labelID.Text = Reader["WORKERID"].ToString();
                        _imageWorker.ImageUrl = Reader["WORKERIMAGE"].ToString();
                        //_txtValidFrom.Text = Reader["BADGEFROM"].ToString();
                        //_txtValidTo.Text = Reader["BADGETO"].ToString();
                        DateTime From = Convert.ToDateTime(Reader["BADGEFROM"].ToString());
                        DateTime To = Convert.ToDateTime(Reader["BADGETO"].ToString());
                        _txtValidFrom.Text = From.ToString("MM/dd/yyyy");
                        _txtValidTo.Text = To.ToString("MM/dd/yyyy");
                        string FirstName = Reader["WORKERFNAME"].ToString();
                        string DateOfBirth = Reader["WORKERDOB"].ToString();
                        DateTime DOB = Convert.ToDateTime(DateOfBirth);
                        string Birthdate = DOB.Date.ToString("MM/dd/yyyy");
                        string FName;
                        if (FirstName.Length < 4)
                        {
                            FName = FirstName + "0";
                            FName = FName.Substring(0, 4);
                        }
                        else
                        {
                            FName = FirstName.Substring(0, 4);
                        }
                        int IdWork = Convert.ToInt32(_labelID.Text);
                        string WorkID = IdWork.ToString("00000");
                        _txtBadgeCode.Text = WorkID + FName.Replace(" ", string.Empty) + Birthdate.Replace("/", string.Empty);
                        _txtBadgeCode.Text = _txtBadgeCode.Text.ToUpper();
                        _dropdownBadgeStat.SelectedValue = Reader["BADGESTAT"].ToString();
                    }
                    Connect.Close();
                    Cmd.Parameters.Clear();
                }
            }
        }
    }
}
//string Code = _txtBadgeCode.Text;
////string Code = Request["code"].ToString();

//// Multiply the lenght of the code by 40 (just to have enough width)
//int w = Code.Length * 26;

//// Create a bitmap object of the width that we calculated and height of 100
//Bitmap oBitmap = new Bitmap(w, 100);

//// then create a Graphic object for the bitmap we just created.
//Graphics oGraphics = Graphics.FromImage(oBitmap);

//// Now create a Font object for the Barcode Font
//// (in this case the IDAutomationHC39M) of 18 point size
//Font oFont = new Font("IDAHC39M Code 39 Barcode", 18);

//// Let's create the Point and Brushes for the barcode
//PointF oPoint = new PointF(2f, 2f);
//SolidBrush oBrushWrite = new SolidBrush(Color.Black);
//SolidBrush oBrush = new SolidBrush(Color.White);

//// Now lets create the actual barcode image
//// with a rectangle filled with white color
//oGraphics.FillRectangle(oBrush, 0, 0, w, 100);

//// We have to put prefix and sufix of an asterisk (*),
//// in order to be a valid barcode
//oGraphics.DrawString("*" + Code + "*", oFont, oBrushWrite, oPoint);
//string FileName = "C:\\Users\\Carl\\Documents\\Visual Studio 2013\\Projects\\Construction Asset Management System\\Construction Asset Management System\\barcodeimages\\" + _txtBadgeCode.Text + "QrCode.png";
//oBitmap.Save(FileName, ImageFormat.Png);
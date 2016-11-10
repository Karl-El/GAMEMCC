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
    public partial class EquipmentStash : System.Web.UI.Page
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
        protected void UpdateButton_Click(object sender, EventArgs e)
        {
            //TrimTextBoxesRecursive(Page);
            //TextBox QUANTITYTextBox = (TextBox)_listviewEquipmentStash.EditItem.FindControl("QUANTITYTextBox");
            //Label STOCKTextBox = (Label)_listviewEquipmentStash.EditItem.FindControl("STOCKTextBox");
            //Label INUSETextBox = (Label)_listviewEquipmentStash.EditItem.FindControl("INUSETextBox");

            //int Quantity = Convert.ToInt32(QUANTITYTextBox.Text);
            //int Stock = Convert.ToInt32(STOCKTextBox.Text);
            //int Used = Convert.ToInt32(INUSETextBox.Text);
            //Stock = Quantity - Used;
            //STOCKTextBox.Text = Convert.ToString(Stock);

        }
        protected void _btnAdd_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Equipment_CRUD.aspx");
        }

        protected void _btnSearch_Click(object sender, EventArgs e)
        {
            _btnShowList.Visible = true;
            string Search = null;
            DataSourceEquipmentStash.SelectParameters.Clear();
            if (IsPostBack)
            {
                Search = _txtSearch.Text.Trim();
                DataSourceEquipmentStash.SelectParameters.Add("Search", Search);
                DataSourceEquipmentStash.SelectCommand = "SELECT  [QUANTITY], [INUSE], [STOCK],  EQUIPMENTID, EQUIPMENTNAME, EQUIPMENTDESC, EQUIPMENTIMG, EQUIPMENT.EQUIPCTGRYID, EQUIPCTGRY.EQUIPCTGRYNAME FROM [EQUIPMENT] JOIN  EQUIPCTGRY ON EQUIPMENT.EQUIPCTGRYID = EQUIPCTGRY.EQUIPCTGRYID WHERE EQUIPMENTNAME like'%'+@Search+'%' OR EQUIPMENTDESC like'%'+@Search+'%'  OR EQUIPCTGRYNAME like'%'+@Search+'%'";
                DataSourceEquipmentStash.DataBind();
                _listviewEquipmentStash.DataBind();
            }
        }

        protected void _btnShowList_Click(object sender, EventArgs e)
        {
            _btnShowList.Visible = false;
            Response.Redirect("~/EquipmentStash.aspx");
        }

        protected void _listviewEquipmentStash_ItemUpdating(object sender, ListViewUpdateEventArgs e)
        {
            //Label STOCKTextBox = (Label)_listviewEquipmentStash.EditItem.FindControl("STOCKTextBox");
            //Label INUSETextBox = (Label)_listviewEquipmentStash.EditItem.FindControl("INUSETextBox");
            //TextBox QUANTITYTextBox = (TextBox)_listviewEquipmentStash.EditItem.FindControl("QUANTITYTextBox");
            //if (QUANTITYTextBox.Text.Contains(" "))
            //{

            //    QUANTITYTextBox.Text = "0";
            //    int Quantity = Convert.ToInt32(QUANTITYTextBox.Text);
            //    int Stock = Convert.ToInt32(STOCKTextBox.Text);
            //    int Used = Convert.ToInt32(INUSETextBox.Text);
            //    Stock = Quantity - Used;
            //    STOCKTextBox.Text = Convert.ToString(Stock);
            //}
            //else
            //{
            //    int Quantity = Convert.ToInt32(QUANTITYTextBox.Text);
            //    int Stock = Convert.ToInt32(STOCKTextBox.Text);
            //    int Used = Convert.ToInt32(INUSETextBox.Text);
            //    Stock = Quantity - Used;
            //    STOCKTextBox.Text = Convert.ToString(Stock);
        }

        protected void _listviewEquipmentStash_ItemDataBound(object sender, ListViewItemEventArgs e)
        {
            if (e.Item.ItemType == ListViewItemType.DataItem)
            {
                var STOCKLabel = (Label)e.Item.FindControl("STOCKLabel");
                var INUSELabel = (Label)e.Item.FindControl("INUSELabel");
                var QUANTITYLabel = (Label)e.Item.FindControl("QUANTITYLabel");
                var EQUIPMENTIDLabel = (Label)e.Item.FindControl("EQUIPMENTIDLabel");


                int EquipID = e.Item.DataItemIndex + 1;
                String Conn = ConfigurationManager.ConnectionStrings["ConnString_WEB_ASSET_DB"].ConnectionString;
                SqlConnection Connect = new SqlConnection(Conn);
                try
                {
                    Connect.Open();
                    SqlCommand Cmd = new SqlCommand("SELECT SUM(CAST(ASSEQUIPQUANT AS INT)) FROM ASSIGNEDEQUIP WHERE EQUIPMENTID=@EquipID", Connect);
                    Cmd.Parameters.AddWithValue("@EquipID", EquipID);
                    object InUsed = Cmd.ExecuteScalar();
                    if (InUsed != DBNull.Value)
                    {
                        int Used = Convert.ToInt32(InUsed);
                        Cmd = new SqlCommand("SELECT CAST(QUANTITY AS INT) FROM EQUIPMENT WHERE EQUIPMENTID=@EquipID", Connect);
                        Cmd.Parameters.AddWithValue("@EquipID", EquipID);
                        object TotalQuant = Cmd.ExecuteScalar();
                        if (TotalQuant != DBNull.Value)
                        {
                            int Quant = Convert.ToInt32(TotalQuant);
                            INUSELabel.Text = Used.ToString();
                            int Stock = Quant - Used;
                            Cmd = new SqlCommand("UPDATE EQUIPMENT SET STOCK=@Stock, INUSE=@Used WHERE EQUIPMENTID=@EquipID", Connect);
                            Cmd.Parameters.AddWithValue("@EquipID", EquipID);
                            Cmd.Parameters.AddWithValue("@Stock", Stock);
                            Cmd.Parameters.AddWithValue("@Used", Used);
                            //Cmd.Parameters.AddWithValue("@Used", Used);
                            Cmd.ExecuteNonQuery();

                        }
                        //int Quantity = Convert.ToInt32(QUANTITYLabel.Text);
                        //int Stock = Quantity - Used;
                        //STOCKLabel.Text = Convert.ToString(Stock);
                    }
                    else
                    {
                        int Used = 0;
                        Cmd = new SqlCommand("SELECT CAST(QUANTITY AS INT) FROM EQUIPMENT WHERE EQUIPMENTID=@EquipID", Connect);
                        Cmd.Parameters.AddWithValue("@EquipID", EquipID);
                        object TotalQuant = Cmd.ExecuteScalar();
                        if (TotalQuant != DBNull.Value)
                        {
                            int Quant = Convert.ToInt32(TotalQuant);
                            int Stock = Quant - Used;
                            Cmd = new SqlCommand("UPDATE EQUIPMENT SET STOCK=@Stock, INUSE=@Used WHERE EQUIPMENTID=@EquipID", Connect);
                            Cmd.Parameters.AddWithValue("@EquipID", EquipID);
                            Cmd.Parameters.AddWithValue("@Stock", Stock);
                            Cmd.Parameters.AddWithValue("@Used", Used);
                            Cmd.ExecuteNonQuery();

                        }
                    }
                }
                finally
                {
                    Connect.Close();
                }
            }
        }

        protected void _listviewEquipmentStash_PreRender(object sender, EventArgs e)
        {
            string EquipID = _listviewEquipmentStash.SelectedIndex.ToString();
            String Conn = ConfigurationManager.ConnectionStrings["ConnString_WEB_ASSET_DB"].ConnectionString;
            SqlConnection Connect = new SqlConnection(Conn);
            try
            {
                Connect.Open();
                SqlCommand Cmd = new SqlCommand("SELECT CAST(ASSEQUIPQUANT AS INT) FROM ASSIGNEDEQUIP WHERE EQUIPMENTID=@EquipID", Connect);
                Cmd.Parameters.AddWithValue("@EquipID", EquipID.ToString());
                object InUsed = Cmd.ExecuteScalar();
                if (InUsed != DBNull.Value)
                {
                    int Used = Convert.ToInt32(InUsed);
                    Cmd = new SqlCommand("SELECT SUM(CAST(QUANTITY AS INT)) FROM EQUIPMENT WHERE EQUIPMENTID=@EquipID", Connect);
                    Cmd.Parameters.AddWithValue("@EquipID", EquipID);
                    object TotalQuant = Cmd.ExecuteScalar();
                    if (TotalQuant != DBNull.Value)
                    {
                        int Quant = Convert.ToInt32(TotalQuant);
                        int Stock = Quant - Used;
                        Cmd = new SqlCommand("UPDATE EQUIPMENT SET STOCK=@Stock WHERE EQUIPMENTID=@EquipID", Connect);
                        Cmd.Parameters.AddWithValue("@EquipID", EquipID);
                        Cmd.Parameters.AddWithValue("@Stock", Stock);
                        //Cmd.Parameters.AddWithValue("@Used", Used);
                        Cmd.ExecuteNonQuery();

                    }
                    //int Quantity = Convert.ToInt32(QUANTITYLabel.Text);
                    //int Stock = Quantity - Used;
                    //STOCKLabel.Text = Convert.ToString(Stock);
                }
                else
                {
                    int Used = 0;
                    Cmd = new SqlCommand("SELECT CAST(QUANTITY AS INT) FROM EQUIPMENT WHERE EQUIPMENTID=@EquipID", Connect);
                    Cmd.Parameters.AddWithValue("@EquipID", EquipID);
                    object TotalQuant = Cmd.ExecuteScalar();
                    if (TotalQuant != DBNull.Value)
                    {
                        int Quant = Convert.ToInt32(TotalQuant);
                        int Stock = Quant - Used;
                        Cmd = new SqlCommand("UPDATE EQUIPMENT SET STOCK=@Stock WHERE EQUIPMENTID=@EquipID", Connect);
                        Cmd.Parameters.AddWithValue("@EquipID", EquipID);
                        Cmd.Parameters.AddWithValue("@Stock", Stock);
                        //Cmd.Parameters.AddWithValue("@Used", Used);
                        Cmd.ExecuteNonQuery();

                    }
                }
            }
            finally
            {
                Connect.Close();
            }
            _listviewEquipmentStash.DataBind();

        }
    }
}

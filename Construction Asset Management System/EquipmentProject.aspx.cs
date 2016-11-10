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
    public partial class EquipmentProject : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void _listviewEquipProject_ItemDataBound(object sender, ListViewItemEventArgs e)
        {
            if (e.Item.ItemType == ListViewItemType.DataItem)
            {
                var EQUIPMENTIDLabel = (Label)e.Item.FindControl("EQUIPMENTIDLabel");
                var _bulletlistEquipProj = (BulletedList)e.Item.FindControl("_bulletlistEquipProj");
                var _labelAssEquip = (Label)e.Item.FindControl("_labelAssEquip");
                string EquipID = EQUIPMENTIDLabel.Text;
                String Conn = ConfigurationManager.ConnectionStrings["ConnString_WEB_ASSET_DB"].ConnectionString;
                SqlConnection Connect = new SqlConnection(Conn);
                Connect.Open();
                SqlCommand Cmd = new SqlCommand("SELECT SUM(CAST(ASSEQUIPQUANT AS INT)) FROM ASSIGNEDEQUIP WHERE EQUIPMENTID=@EquipID", Connect);
                Cmd.Parameters.AddWithValue("@EquipID", EquipID);
                object Value = Cmd.ExecuteScalar();
                if (Value != DBNull.Value)
                {
                    int Total = Convert.ToInt32(Value);
                    _labelAssEquip.Text = Total.ToString();
                }
                else
                {
                    _labelAssEquip.Text = "0";
                    _bulletlistEquipProj.Items.Add("Not Yet Assigned to a Project"); ;
                }
            }
        }
    }
}
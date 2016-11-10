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
    public partial class ProjectRequirement_CRUD1 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void _dropdownProject_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (_dropdownProject.SelectedValue.Equals(" "))
            {
                _txtboxPMI.Text = "";
                _txtboxSite.Text = "";
                _txtboxSiteApprover.Text = "";
                _txtboxSiteDateApp.Text = "";
            }
            string ProjectID = _dropdownProject.SelectedValue.ToString();
            String Conn = ConfigurationManager.ConnectionStrings["ConnString_WEB_ASSET_DB"].ConnectionString;
            SqlConnection Connect = new SqlConnection(Conn);
            Connect.Open();
            SqlCommand Cmd = new SqlCommand("SELECT PROJID,PROJSITE,PROJPMINO,PROJAPPR, COMPANYSTAFF.COMSTAFFFRSTNAME+' '+COMPANYSTAFF.COMSTAFFLASTNAME+', '+COMPANYSTAFF.COMSTAFFPOSITION AS [COMPSTAFFPOS] FROM PROJECT JOIN COMPANYSTAFF ON PROJECT.CNTRCTRPROJAPPID=COMPANYSTAFF.COMSTAFFID WHERE PROJID=@ProjectID", Connect);
            Cmd.Parameters.AddWithValue("@ProjectID", ProjectID);
            SqlDataReader Reader = Cmd.ExecuteReader();
            while (Reader.Read())
            {
                _txtboxSite.Text = Reader["PROJSITE"].ToString();
                _txtboxSite.Text = Reader["PROJSITE"].ToString();
                _txtboxPMI.Text = Reader["PROJPMINO"].ToString();
                _txtboxSiteApprover.Text = Reader["COMPSTAFFPOS"].ToString();
                string DateApp = Reader["PROJAPPR"].ToString();
                DateTime AppDate = Convert.ToDateTime(DateApp);
                _txtboxSiteDateApp.Text = AppDate.Date.ToString("MMMM dd, yyyy");

            }

        }

        protected void NextButton1_Click(object sender, EventArgs e)
        {
            _panelReqTrade.Visible = true;
            _panelProjectDetails.Visible = false;
            _panelReqEquipment.Visible = false;
            _panelQuantTrade.Visible = false;
            _panelQuantEquip.Visible = false;
            _panelSummary.Visible = false;
        }

        protected void BackButtonPage2_Click(object sender, EventArgs e)
        {
            _panelProjectDetails.Visible = true;
            _panelReqTrade.Visible = false;
            _panelReqEquipment.Visible = false;
            _panelQuantTrade.Visible = false;
            _panelQuantEquip.Visible = false;
            _panelSummary.Visible = false;
        }

        protected void NextButtonPage2_Click(object sender, EventArgs e)
        {
            _panelReqEquipment.Visible = true;
            _panelProjectDetails.Visible = false;
            _panelReqTrade.Visible = false;
            _panelQuantTrade.Visible = false;
            _panelQuantEquip.Visible = false;
            _panelSummary.Visible = false;
        }

        protected void BackButtonPage3_Click(object sender, EventArgs e)
        {
            _panelReqTrade.Visible = true;
            _panelReqEquipment.Visible = false;
            _panelQuantTrade.Visible = false;
            _panelQuantEquip.Visible = false;
            _panelProjectDetails.Visible = false;
            _panelSummary.Visible = false;
        }

        protected void NextButtonPage3_Click(object sender, EventArgs e)
        {
            _panelQuantTrade.Visible = true;
            _panelQuantEquip.Visible = false;
            _panelProjectDetails.Visible = false;
            _panelReqEquipment.Visible = false;
            _panelReqTrade.Visible = false;
            _panelSummary.Visible = false;
            _panelSummary.Visible = false;
            String Conn = ConfigurationManager.ConnectionStrings["ConnString_WEB_ASSET_DB"].ConnectionString;
            SqlConnection Connect = new SqlConnection(Conn);
            int ProjectID = Convert.ToInt16(_dropdownProject.SelectedValue.ToString());
            //------------RequiredTrade-----------------------------------------------
            SqlCommand Cmd = new SqlCommand("SELECT COUNT (*) FROM PROJREQTRADE WHERE PROJID=@ProjectID", Connect);
            Cmd.Parameters.AddWithValue("@ProjectID", ProjectID);
            Connect.Open();
            Int32 Count = (Int32)Cmd.ExecuteScalar();
            Connect.Close();
            if (Count > 0)  //---------------------------------Check kung meron na
            {
                for (int i = 0; i <= Count - 1; i++)  //-------------Delete Required Treade
                {
                    Connect.Open();
                    Cmd = new SqlCommand("DELETE FROM PROJREQTRADE WHERE PROJID=@ProjectID", Connect);
                    Cmd.Parameters.AddWithValue("@ProjectID", ProjectID);
                    Cmd.ExecuteNonQuery();
                    Connect.Close();
                }
                for (int i = 0; i <= _chkbxlistReqTrade.Items.Count - 1; i++) //-------------Insert/Update Required Treade
                {
                    if (_chkbxlistReqTrade.Items[i].Selected)
                    {
                        Connect.Open();
                        Cmd = new SqlCommand("INSERT INTO PROJREQTRADE (PROJID, TRADEID,TRADEQUANTITY) VALUES (@ProjectID,@TradeID,1)", Connect);
                        Cmd.Parameters.AddWithValue("@ProjectID", ProjectID);
                        Cmd.Parameters.AddWithValue("@TradeID", _chkbxlistReqTrade.Items[i].Value);
                        Cmd.ExecuteNonQuery();
                        Connect.Close();
                        //ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('Trade/s Updated, pero deleted tas insert lang yun ginawa ko')", true);
                    }
                }
            }
            else //-------------Insert Required Treade
            {
                for (int i = 0; i <= _chkbxlistReqTrade.Items.Count - 1; i++)
                {
                    if (_chkbxlistReqTrade.Items[i].Selected)
                    {
                        Connect.Open();
                        Cmd = new SqlCommand("INSERT INTO PROJREQTRADE (PROJID, TRADEID,TRADEQUANTITY) VALUES (@ProjectID,@TradeID,1)", Connect);
                        Cmd.Parameters.AddWithValue("@ProjectID", ProjectID);
                        Cmd.Parameters.AddWithValue("@TradeID", _chkbxlistReqTrade.Items[i].Value);
                        Cmd.ExecuteNonQuery();
                        Connect.Close();
                        //ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('Trade/s Added')", true);
                    }
                }
            }

            //------------RequiredEquip---------------------------------------------------
            Cmd = new SqlCommand("SELECT COUNT (*) FROM PROJREQEQUIP WHERE PROJID=@ProjectID", Connect);
            Cmd.Parameters.AddWithValue("@ProjectID", ProjectID);
            Connect.Open();
            Count = (Int32)Cmd.ExecuteScalar();
            Connect.Close();
            if (Count > 0) //---------------------------------Check kung meron na
            {
                for (int i = 0; i <= Count - 1; i++) //-------------Delete Required Equipment
                {
                    Connect.Open();
                    Cmd = new SqlCommand("DELETE FROM PROJREQEQUIP WHERE PROJID=@ProjectID", Connect);
                    Cmd.Parameters.AddWithValue("@ProjectID", ProjectID);
                    Cmd.ExecuteNonQuery();
                    Connect.Close();
                }
                for (int i = 0; i <= _chkbxlistReqEquip.Items.Count - 1; i++) //-------------Insert/Update Required Equipment
                {
                    if (_chkbxlistReqEquip.Items[i].Selected)
                    {
                        Connect.Open();
                        Cmd = new SqlCommand("INSERT INTO PROJREQEQUIP (PROJID, EQUIPMENTID, EQUIPQUANTITY) VALUES (@ProjectID,@EquipID,1)", Connect);
                        Cmd.Parameters.AddWithValue("@ProjectID", ProjectID);
                        Cmd.Parameters.AddWithValue("@EquipID", _chkbxlistReqEquip.Items[i].Value);
                        Cmd.ExecuteNonQuery();
                        Connect.Close();
                        //ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('Equipment/s Udpated'pero deleted tas insert lang yun ginawa ko)", true);
                    }
                }
            }
            else //-------------Insert Required Equipment
            {
                for (int i = 0; i <= _chkbxlistReqEquip.Items.Count - 1; i++)
                {
                    if (_chkbxlistReqEquip.Items[i].Selected)
                    {
                        Connect.Open();
                        Cmd = new SqlCommand("INSERT INTO PROJREQEQUIP (PROJID, EQUIPMENTID, EQUIPQUANTITY) VALUES (@ProjectID,@EquipID,1)", Connect);
                        Cmd.Parameters.AddWithValue("@ProjectID", ProjectID);
                        Cmd.Parameters.AddWithValue("@EquipID", _chkbxlistReqEquip.Items[i].Value);
                        Cmd.ExecuteNonQuery();
                        Connect.Close();
                        //ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('Equipment/s Added')", true);
                    }
                }
            }
            _listviewQuantEquip.DataBind();
            _listviewQuantTrade.DataBind();
        }

        protected void BackButtonPage4_Click(object sender, EventArgs e)
        {

            _panelReqEquipment.Visible = true;
            _panelProjectDetails.Visible = false;
            _panelReqTrade.Visible = false;
            _panelQuantTrade.Visible = false;
            _panelQuantEquip.Visible = false;
            _panelSummary.Visible = false;
        }

        protected void NextButtonPage4_Click(object sender, EventArgs e)
        {
            _panelQuantEquip.Visible = true;
            _panelQuantTrade.Visible = false; ;
            _panelProjectDetails.Visible = false;
            _panelReqEquipment.Visible = false;
            _panelReqTrade.Visible = false;
            _panelSummary.Visible = false;
        }

        protected void BackButtonPage5_Click(object sender, EventArgs e)
        {
            _panelQuantTrade.Visible = true;
            _panelQuantEquip.Visible = false;
            _panelProjectDetails.Visible = false;
            _panelReqEquipment.Visible = false;
            _panelReqTrade.Visible = false;
            _panelSummary.Visible = false;
        }

        protected void FinishButtonPage5_Click(object sender, EventArgs e)
        {
            _panelSummary.Visible = true;
            _panelQuantTrade.Visible = false;
            _panelQuantEquip.Visible = false;
            _panelProjectDetails.Visible = false;
            _panelReqEquipment.Visible = false;
            _panelReqTrade.Visible = false;
            _lblTitleSummay.Text = _dropdownProject.SelectedItem.ToString();
            ScriptManager.RegisterStartupScript(Page, Page.GetType(), "_modalSummary", "$('#_modalSummary').modal();", true);
            _panelSummary.Update();
            string ProjectID = _dropdownProject.SelectedValue.ToString();
            String Conn = ConfigurationManager.ConnectionStrings["ConnString_WEB_ASSET_DB"].ConnectionString;
            SqlConnection Connect = new SqlConnection(Conn);
            Connect.Open();
            SqlCommand Cmd = new SqlCommand("SELECT SUM(CAST(TRADEQUANTITY AS INT)) FROM PROJREQTRADE WHERE PROJID=@ProjectID", Connect);
            Cmd.Parameters.AddWithValue("@ProjectID", ProjectID);
            object Value = Cmd.ExecuteScalar();
            if (Value != DBNull.Value)
            {
                int Total = Convert.ToInt32(Value);
                _labelTotalTrade.Text = Total.ToString();
            }
            else
            {
                _labelTotalTrade.Text = "0";
            }
            Connect.Close();
            Connect.Open();
            Cmd = new SqlCommand("SELECT SUM(CAST(EQUIPQUANTITY AS INT)) FROM PROJREQEQUIP WHERE PROJID=@ProjectID", Connect);
            Cmd.Parameters.AddWithValue("@ProjectID", ProjectID);
            Value = Cmd.ExecuteScalar();
            if (Value != DBNull.Value)
            {
                int Total = Convert.ToInt32(Value);
                _labelTotalEquip.Text = Total.ToString();
            }
            else
            {
                _labelTotalEquip.Text = "0";
            }
            Connect.Close();
        }

        protected void _dropdownProject_PreRender(object sender, EventArgs e)
        {
            ListItem SelectedValue = _dropdownProject.Items.FindByValue(Request.QueryString["id"]);
            if (SelectedValue != null)
            {
                _dropdownProject.Enabled = false;
                _dropdownProject.SelectedValue = Request.QueryString["id"] ?? String.Empty;
                string ProjectID = _dropdownProject.SelectedValue.ToString();
                String Conn = ConfigurationManager.ConnectionStrings["ConnString_WEB_ASSET_DB"].ConnectionString;
                SqlConnection Connect = new SqlConnection(Conn);
                Connect.Open();
                SqlCommand Cmd = new SqlCommand("SELECT PROJID,PROJSITE,PROJPMINO,PROJAPPR, COMPANYSTAFF.COMSTAFFFRSTNAME+' '+COMPANYSTAFF.COMSTAFFLASTNAME+', '+COMPANYSTAFF.COMSTAFFPOSITION AS [COMPSTAFFPOS] FROM PROJECT JOIN COMPANYSTAFF ON PROJECT.CNTRCTRPROJAPPID=COMPANYSTAFF.COMSTAFFID WHERE PROJID=@ProjectID", Connect);
                Cmd.Parameters.AddWithValue("@ProjectID", ProjectID);
                SqlDataReader Reader = Cmd.ExecuteReader();
                while (Reader.Read())
                {
                    _txtboxSite.Text = Reader["PROJSITE"].ToString();
                    _txtboxPMI.Text = Reader["PROJPMINO"].ToString();
                    _txtboxSiteApprover.Text = Reader["COMPSTAFFPOS"].ToString();
                    string DateApp = Reader["PROJAPPR"].ToString();
                    DateTime AppDate = Convert.ToDateTime(DateApp);
                    _txtboxSiteDateApp.Text = AppDate.Date.ToString("MMMM dd, yyyy");
                }
            }
            else
            {
                _dropdownProject.Enabled = true;
                string ProjectID = _dropdownProject.SelectedValue.ToString();
                String Conn = ConfigurationManager.ConnectionStrings["ConnString_WEB_ASSET_DB"].ConnectionString;
                SqlConnection Connect = new SqlConnection(Conn);
                Connect.Open();
                SqlCommand Cmd = new SqlCommand("SELECT PROJID,PROJSITE,PROJPMINO,PROJAPPR, COMPANYSTAFF.COMSTAFFFRSTNAME+' '+COMPANYSTAFF.COMSTAFFLASTNAME+', '+COMPANYSTAFF.COMSTAFFPOSITION AS [COMPSTAFFPOS] FROM PROJECT JOIN COMPANYSTAFF ON PROJECT.CNTRCTRPROJAPPID=COMPANYSTAFF.COMSTAFFID WHERE PROJID=@ProjectID", Connect);
                Cmd.Parameters.AddWithValue("@ProjectID", ProjectID);
                SqlDataReader Reader = Cmd.ExecuteReader();
                while (Reader.Read())
                {
                    _txtboxSite.Text = Reader["PROJSITE"].ToString();
                    _txtboxPMI.Text = Reader["PROJPMINO"].ToString();
                    _txtboxSiteApprover.Text = Reader["COMPSTAFFPOS"].ToString();
                    string DateApp = Reader["PROJAPPR"].ToString();
                    DateTime AppDate = Convert.ToDateTime(DateApp);
                    _txtboxSiteDateApp.Text = AppDate.Date.ToString("MMMM dd, yyyy");

                }

            }
        }


    }
}
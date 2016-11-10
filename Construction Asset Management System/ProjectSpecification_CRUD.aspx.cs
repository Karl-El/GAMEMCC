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
    public partial class ProjectSpecification_CRUD : System.Web.UI.Page
    {

        protected void Page_Load(object sender, EventArgs e)
        {


        }

        protected void _dropdownProject_SelectedIndexChanged(object sender, EventArgs e)
        {
            string ProjectID = _dropdownProject.SelectedValue.ToString();
            if (_dropdownProject.SelectedValue.Contains(" "))
            {
                _labelPMI.Text = "";
                _labelSite.Text = "";
                _labelSiteApprover.Text = "";
                _labelSiteDateApp.Text = "";
                _txtFromDate.Text = "";
                _txtToDate.Text = "";
                _dropdownProjectStat.ClearSelection();
            }
            ProjectID = _dropdownProject.SelectedValue.ToString();
            String Conn = ConfigurationManager.ConnectionStrings["ConnString_WEB_ASSET_DB"].ConnectionString;
            SqlConnection Connect = new SqlConnection(Conn);
            Connect.Open();
            SqlCommand Cmd = new SqlCommand("SELECT PROJID,PROJSITE,PROJPMINO,PROJAPPR,PROJFROM,PROJTO,PROGRESS,SHIFTID, COMPANYSTAFF.COMSTAFFFRSTNAME+' '+COMPANYSTAFF.COMSTAFFLASTNAME+', '+COMPANYSTAFF.COMSTAFFPOSITION AS [COMPSTAFFPOS] FROM PROJECT JOIN COMPANYSTAFF ON PROJECT.CNTRCTRPROJAPPID=COMPANYSTAFF.COMSTAFFID WHERE PROJID=@ProjectID", Connect);
            Cmd.Parameters.AddWithValue("@ProjectID", ProjectID);
            SqlDataReader Reader = Cmd.ExecuteReader();
            DateTime ProjFrom, ProjTo;
            while (Reader.Read())
            {
                if (Reader["PROJFROM"].Equals(DBNull.Value) || Reader["PROJTO"].Equals(DBNull.Value) || Reader["PROGRESS"].Equals(DBNull.Value))
                {
                    //ProjFrom = DateTime.Today.Date;
                    //ProjTo = DateTime.Today.Date;
                    _txtFromDate.Text = "--/--/----";
                    _txtToDate.Text = "--/--/----";
                    _labelSite.Text = Reader["PROJSITE"].ToString();
                    _labelPMI.Text = Reader["PROJPMINO"].ToString();
                    _labelSiteApprover.Text = Reader["COMPSTAFFPOS"].ToString();
                    string DateApp = Reader["PROJAPPR"].ToString();
                    DateTime AppDate = Convert.ToDateTime(DateApp);
                    _labelSiteDateApp.Text = AppDate.Date.ToString("MMMM dd, yyyy");
                    _dropdownProjectStat.ClearSelection();
                    _dropdownProjectShift.ClearSelection();
                }
                else
                {
                    _labelSite.Text = Reader["PROJSITE"].ToString();
                    _labelPMI.Text = Reader["PROJPMINO"].ToString();
                    _labelSiteApprover.Text = Reader["COMPSTAFFPOS"].ToString();
                    string DateApp = Reader["PROJAPPR"].ToString();
                    DateTime AppDate = Convert.ToDateTime(DateApp);
                    _labelSiteDateApp.Text = AppDate.Date.ToString("MMMM dd, yyyy");
                    ProjFrom = Convert.ToDateTime(Reader["PROJFROM"].ToString());
                    ProjTo = Convert.ToDateTime(Reader["PROJTO"].ToString());
                    _txtFromDate.Text = ProjFrom.ToString("MM/dd/yyyy");
                    _txtToDate.Text = ProjTo.ToString("MM/dd/yyyy");
                    _dropdownProjectStat.SelectedValue = Reader["PROGRESS"].ToString();
                    _dropdownProjectShift.SelectedValue = Reader["SHIFTID"].ToString();

                }

            }
            Connect.Close();

            ProjectID = _dropdownProject.SelectedValue.ToString();
            Connect.Open();
            Cmd = new SqlCommand("SELECT SUM(CAST(TRADEQUANTITY AS INT)) FROM PROJREQTRADE WHERE PROJID=@ProjectID", Connect);
            Cmd.Parameters.AddWithValue("@ProjectID", ProjectID);
            object Value = Cmd.ExecuteScalar();
            if (Value != DBNull.Value)
            {
                int Total = Convert.ToInt32(Value);
                _labelTotalTrade.Text = Total.ToString();
                _labelTotalTrade2.Text = Total.ToString();
            }
            else
            {
                _labelTotalTrade.Text = "0";
                _labelTotalTrade2.Text = "0";
                _bulletlistProjTrade.Items.Add("No Worker listed"); ;
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
                _labelTotalEquip2.Text = Total.ToString();
            }
            else
            {
                _labelTotalEquip.Text = "0";
                _labelTotalEquip2.Text = "0";
                _bulletlistProjEquip.Items.Add("No Equipment listed");
                _bulletlistProjEquip2.Items.Add("No Equipment listed");
            }
            Connect.Close();
            Connect.Open();
            string ProjID = _dropdownProject.SelectedValue;
            Cmd = new SqlCommand("SELECT  WORKER.WORKERID, WORKERFNAME+' '+WORKERLNAME AS [WORKFULLNAME] FROM WORKER JOIN ASSIGNEDWORKER ON WORKER.WORKERID=ASSIGNEDWORKER.WORKERID WHERE PROJID=@ProjID", Connect);
            Cmd.Parameters.AddWithValue("@ProjID", ProjID);
            _chlbxlistWorkerRemove.DataSource = Cmd.ExecuteReader();
            _chlbxlistWorkerRemove.DataValueField = "WORKERID";
            _chlbxlistWorkerRemove.DataTextField = "WORKFULLNAME";
            _chlbxlistWorkerRemove.DataBind();
            _bulletlistProjEquip2.DataBind();
            _bulletlistProjTrade2.DataBind();
            //_chkbxlistReqEquip.DataBind();
            Connect.Close();
            Connect.Open();

            Cmd = new SqlCommand("SELECT EQUIPMENT.EQUIPMENTID,EQUIPMENT.EQUIPMENTNAME FROM EQUIPMENT JOIN ASSIGNEDEQUIP ON EQUIPMENT.EQUIPMENTID=ASSIGNEDEQUIP.EQUIPMENTID WHERE PROJID=@ProjID", Connect);
            Cmd.Parameters.AddWithValue("@ProjID", ProjID);
            _chkbxlistEquipRemove.DataSource = Cmd.ExecuteReader();
            _chkbxlistEquipRemove.DataValueField = "EQUIPMENTID";
            _chkbxlistEquipRemove.DataTextField = "EQUIPMENTNAME";
            _chkbxlistEquipRemove.DataBind();
            Connect.Close();

            Connect.Open();
            Cmd = new SqlCommand("SELECT EQUIPMENTID, EQUIPMENTNAME FROM EQUIPMENT WHERE (CAST(STOCK AS INT) > 0)", Connect);
            _chkbxlistEquipAdd.DataSource = Cmd.ExecuteReader();
            _chkbxlistEquipAdd.DataValueField = "EQUIPMENTID";
            _chkbxlistEquipAdd.DataTextField = "EQUIPMENTNAME";
            _chkbxlistEquipAdd.DataBind();
            Connect.Close();
            //for (int i = 0; i <= _chkbxlistEquipAdd.Items.Count - 1; i++)
            //{
            //    for (int j = 0; j <= _chkbxlistEquipRemove.Items.Count - 1; j++)
            //    {
            //        if (_chkbxlistEquipRemove.Items[j] == _chkbxlistEquipAdd.Items[i])
            //        {
            //            _chkbxlistEquipAdd.Items[i].Enabled = false;
            //        }
            //    }
            //}

        }

        protected void NextButton1_Click(object sender, EventArgs e)
        {
            _panelEquipMain.Visible = true;
            _panelAssEquipList.Visible = true;
            _panelProjReqDetails.Visible = false;
            _panelAssEquipQuant.Visible = false;
            _panelWorkerMain.Visible = false;
            _panelSummary.Visible = false;
            //----------update ng Duration at Status
            string ProjID = _dropdownProject.SelectedValue.ToString();
            String Conn = ConfigurationManager.ConnectionStrings["ConnString_WEB_ASSET_DB"].ConnectionString;
            SqlConnection Connect = new SqlConnection(Conn);
            Connect.Open();
            SqlCommand Cmd = new SqlCommand("UPDATE PROJECT SET PROJFROM=@projfrom, PROJTO=@projto, PROGRESS=@progress, SHIFTID=@shiftid WHERE PROJID=@ProjectID", Connect);
            Cmd.Parameters.AddWithValue("@ProjectID", ProjID);
            Cmd.Parameters.AddWithValue("@projfrom", _txtFromDate.Text);
            Cmd.Parameters.AddWithValue("@projto", _txtToDate.Text);
            Cmd.Parameters.AddWithValue("@progress", _dropdownProjectStat.SelectedValue.ToString());
            Cmd.Parameters.AddWithValue("@shiftid", _dropdownProjectShift.SelectedValue.ToString());
            Cmd.ExecuteNonQuery();
            Connect.Close();
        }

        protected void BackButtonPage2_Click(object sender, EventArgs e)
        {
            _panelProjReqDetails.Visible = true;
            _panelEquipMain.Visible = false;
            _panelAssEquipList.Visible = false;
            _panelAssEquipQuant.Visible = false;
            _panelWorkerMain.Visible = false;
            _panelSummary.Visible = false;
        }

        protected void NextButtonPage2_Click(object sender, EventArgs e)
        {
            _panelEquipMain.Visible = true;
            _panelAssEquipQuant.Visible = true;
            _panelAssEquipList.Visible = false;
            _panelProjReqDetails.Visible = false;
            _panelWorkerMain.Visible = false;
            _panelSummary.Visible = false;
            //String Conn = ConfigurationManager.ConnectionStrings["ConnString_WEB_ASSET_DB"].ConnectionString;
            //SqlConnection Connect = new SqlConnection(Conn);
            //int ProjectID = Convert.ToInt16(_dropdownProject.SelectedValue.ToString());
            //SqlCommand Cmd = new SqlCommand("SELECT COUNT (*) FROM ASSIGNEDEQUIP WHERE PROJID=@ProjectID", Connect);
            //Cmd.Parameters.AddWithValue("@ProjectID", ProjectID);
            //Connect.Open();
            //int Count = (Int32)Cmd.ExecuteScalar();
            //Connect.Close();
            //if (Count > 0) //---------------------------------Check kung meron na
            //{
            //    for (int i = 0; i <= Count - 1; i++) //-------------Delete Required Equipment
            //    {
            //        Connect.Open();
            //        Cmd = new SqlCommand("DELETE FROM ASSIGNEDEQUIP WHERE PROJID=@ProjectID", Connect);
            //        Cmd.Parameters.AddWithValue("@ProjectID", ProjectID);
            //        Cmd.ExecuteNonQuery();
            //        Connect.Close();
            //    }
            //    for (int i = 0; i <= _chkbxlistReqEquip.Items.Count - 1; i++) //-------------Insert/Update Required Equipment
            //    {
            //        if (_chkbxlistReqEquip.Items[i].Selected)
            //        {
            //            Connect.Open();
            //            Cmd = new SqlCommand("INSERT INTO ASSIGNEDEQUIP (PROJID, EQUIPMENTID, ASSEQUIPQUANT) VALUES (@ProjectID,@EquipID,1)", Connect);
            //            Cmd.Parameters.AddWithValue("@ProjectID", ProjectID);
            //            Cmd.Parameters.AddWithValue("@EquipID", _chkbxlistReqEquip.Items[i].Value);
            //            Cmd.ExecuteNonQuery();
            //            Connect.Close();
            //            //ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('Equipment/s Udpated'pero deleted tas insert lang yun ginawa ko)", true);
            //        }
            //    }
            //}
            //else //-------------Insert Required Equipment
            //{
            //    for (int i = 0; i <= _chkbxlistReqEquip.Items.Count - 1; i++)
            //    {
            //        if (_chkbxlistReqEquip.Items[i].Selected)
            //        {
            //            Connect.Open();
            //            Cmd = new SqlCommand("INSERT INTO ASSIGNEDEQUIP (PROJID, EQUIPMENTID, ASSEQUIPQUANT) VALUES (@ProjectID,@EquipID,1)", Connect);
            //            Cmd.Parameters.AddWithValue("@ProjectID", ProjectID);
            //            Cmd.Parameters.AddWithValue("@EquipID", _chkbxlistReqEquip.Items[i].Value);
            //            Cmd.ExecuteNonQuery();
            //            Connect.Close();
            //            //ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('Equipment/s Added')", true);
            //        }
            //    }
            //}
            _listviewAssEquipQuant.DataBind();
        }

        protected void BackButtonPage3_Click(object sender, EventArgs e)
        {
            _panelEquipMain.Visible = true;
            _panelAssEquipList.Visible = true;
            _panelProjReqDetails.Visible = false;
            _panelAssEquipQuant.Visible = false;
            _panelWorkerMain.Visible = false;
            _panelSummary.Visible = false;
        }

        protected void NextButtonPage3_Click(object sender, EventArgs e)
        {
            _panelWorkerMain.Visible = true;
            _panelEquipMain.Visible = false;
            _panelAssEquipList.Visible = false;
            _panelProjReqDetails.Visible = false;
            _panelAssEquipQuant.Visible = false;
            _panelSummary.Visible = false;
        }

        protected void UpdateButton_Click(object sender, EventArgs e)
        {
            //TextBox EQUIPMENTIDTextBox = (TextBox)_listviewAssEquipQuant.EditItem.FindControl("EQUIPMENTIDTextBox");
            //TextBox ASSEQUIPQUANTTextBox = (TextBox)_listviewAssEquipQuant.EditItem.FindControl("ASSEQUIPQUANTTextBox");
            //int OnUse = Convert.ToInt32(ASSEQUIPQUANTTextBox.Text);
            //int EquipID = Convert.ToInt32(EQUIPMENTIDTextBox.Text);
            //int TotalUse, TotalStock, TotalQuant;
            //String Conn = ConfigurationManager.ConnectionStrings["ConnString_WEB_ASSET_DB"].ConnectionString;
            //SqlConnection Connect = new SqlConnection(Conn);
            //Connect.Open();
            //SqlCommand Cmd = new SqlCommand("SELECT QUANTITY, INUSE, CAST(STOCK AS INT) FROM EQUIPMENT WHERE EQUIPMENTID=@EquipID", Connect);
            //Cmd.Parameters.AddWithValue("@EquipID", EquipID);
            //SqlDataReader Reader = Cmd.ExecuteReader();
            //while (Reader.Read())
            //{
            //    int CAST(STOCK AS INT) = Convert.ToInt32(Reader["CAST(STOCK AS INT)"].ToString());
            //    int QUANTITY = Convert.ToInt32(Reader["QUANTITY"].ToString());
            //    int INUSE =  Convert.ToInt32(Reader["INUSE"].ToString());
            //    TotalUse = OnUse + INUSE;
            //    TotalStock = CAST(STOCK AS INT) - TotalUse;
            //    Cmd = new SqlCommand("UPDATE EQUIPMENT SET  INUSE=@TotalUse, CAST(STOCK AS INT)=@TotalStock WHERE EQUIPMENTID=@EquipID", Connect);
            //    Cmd.Parameters.AddWithValue("@EquipID", EquipID);
            //    Cmd.Parameters.AddWithValue("@TotalUse", TotalUse);
            //    Cmd.Parameters.AddWithValue("@TotalStock", TotalStock);

            //}
            //Connect.Close();
            //Connect.Open();
            //Cmd.ExecuteNonQuery();
            //Connect.Close();
        }

        protected void _dropdownTrade_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (_dropdownTrade.SelectedValue == "0")
            {
                String Conn = ConfigurationManager.ConnectionStrings["ConnString_WEB_ASSET_DB"].ConnectionString;
                SqlConnection Connect = new SqlConnection(Conn);
                Connect.Open();
                SqlCommand Cmd = new SqlCommand("SELECT WORKERID, WORKERFNAME+' '+WORKERLNAME AS WORKFULLNAME FROM WORKER WHERE ASSWORKER='False' AND WORKERSTATUS='Active'", Connect);
                _chlbxlistWorkerAdd.DataSource = Cmd.ExecuteReader();
                _chlbxlistWorkerAdd.DataValueField = "WORKERID";
                _chlbxlistWorkerAdd.DataTextField = "WORKFULLNAME";
                _chlbxlistWorkerAdd.DataBind();
                Cmd.Connection.Close();
            }
            else
            {
                string TradeID = _dropdownTrade.SelectedValue;

                String Conn = ConfigurationManager.ConnectionStrings["ConnString_WEB_ASSET_DB"].ConnectionString;
                SqlConnection Connect = new SqlConnection(Conn);
                Connect.Open();
                SqlCommand Cmd = new SqlCommand("SELECT WORKER.WORKERID, WORKERFNAME+' '+WORKERLNAME AS WORKFULLNAME FROM WORKER JOIN WORKERTRADE ON WORKER.WORKERID=WORKERTRADE.WORKERID WHERE ASSWORKER='False' AND WORKERSTATUS='Active' AND WORKERTRADE.TRADEID=@TradeID", Connect);
                Cmd.Parameters.AddWithValue("@TradeID", TradeID);
                _chlbxlistWorkerAdd.DataSource = Cmd.ExecuteReader();
                _chlbxlistWorkerAdd.DataValueField = "WORKERID";
                _chlbxlistWorkerAdd.DataTextField = "WORKFULLNAME";
                _chlbxlistWorkerAdd.DataBind();
                Cmd.Connection.Close();

            }
        }

        protected void _dropdownTrade_PreRender(object sender, EventArgs e)
        {
            String Conn = ConfigurationManager.ConnectionStrings["ConnString_WEB_ASSET_DB"].ConnectionString;
            SqlConnection Connect = new SqlConnection(Conn);
            Connect.Open();
            SqlCommand Cmd = new SqlCommand("SELECT WORKERID, WORKERFNAME+' '+WORKERLNAME AS WORKFULLNAME FROM WORKER WHERE ASSWORKER='False' AND WORKERSTATUS='Active'", Connect);
            _chlbxlistWorkerAdd.DataSource = Cmd.ExecuteReader();
            _chlbxlistWorkerAdd.DataValueField = "WORKERID";
            _chlbxlistWorkerAdd.DataTextField = "WORKFULLNAME";
            _chlbxlistWorkerAdd.DataBind();
            Cmd.Connection.Close();
            if (_dropdownTrade.SelectedValue == "0")
            {
                Conn = ConfigurationManager.ConnectionStrings["ConnString_WEB_ASSET_DB"].ConnectionString;
                Connect = new SqlConnection(Conn);
                Connect.Open();
                Cmd = new SqlCommand("SELECT WORKERID, WORKERFNAME+' '+WORKERLNAME AS WORKFULLNAME FROM WORKER WHERE ASSWORKER='False' AND WORKERSTATUS='Active'", Connect);
                _chlbxlistWorkerAdd.DataSource = Cmd.ExecuteReader();
                _chlbxlistWorkerAdd.DataValueField = "WORKERID";
                _chlbxlistWorkerAdd.DataTextField = "WORKFULLNAME";
                _chlbxlistWorkerAdd.DataBind();
                Cmd.Connection.Close();
            }
            else
            {
                string TradeID = _dropdownTrade.SelectedValue;
                Conn = ConfigurationManager.ConnectionStrings["ConnString_WEB_ASSET_DB"].ConnectionString;
                Connect = new SqlConnection(Conn);
                Connect.Open();
                Cmd = new SqlCommand("SELECT WORKER.WORKERID, WORKERFNAME+' '+WORKERLNAME AS WORKFULLNAME FROM WORKER JOIN WORKERTRADE ON WORKER.WORKERID=WORKERTRADE.WORKERID WHERE ASSWORKER='False' AND WORKERSTATUS='Active' AND WORKERTRADE.TRADEID=@TradeID", Connect);
                Cmd.Parameters.AddWithValue("@TradeID", TradeID);
                _chlbxlistWorkerAdd.DataSource = Cmd.ExecuteReader();
                _chlbxlistWorkerAdd.DataValueField = "WORKERID";
                _chlbxlistWorkerAdd.DataTextField = "WORKFULLNAME";
                _chlbxlistWorkerAdd.DataBind();
                Cmd.Connection.Close();
            }

        }

        protected void _btnEquipAdd_Click(object sender, EventArgs e)
        {
            String Conn = ConfigurationManager.ConnectionStrings["ConnString_WEB_ASSET_DB"].ConnectionString;
            SqlConnection Connect = new SqlConnection(Conn);
            SqlCommand Cmd;
            string ProjID = _dropdownProject.SelectedValue;
            for (int i = 0; i <= _chkbxlistEquipAdd.Items.Count - 1; i++)
            {
                if (_chkbxlistEquipAdd.Items[i].Selected)
                {
                    Connect.Open();
                    Cmd = new SqlCommand("INSERT INTO ASSIGNEDEQUIP (PROJID,EQUIPMENTID,ASSEQUIPQUANT) VALUES (@ProjID,@EquipId,'1')", Connect);
                    Cmd.Parameters.AddWithValue("@EquipId", _chkbxlistEquipAdd.Items[i].Value);
                    Cmd.Parameters.AddWithValue("@ProjID", ProjID);
                    Cmd.ExecuteNonQuery();
                    Connect.Close();
                    _chkbxlistEquipAdd.Items[i].Enabled = false;
                    _chkbxlistEquipAdd.Items[i].Selected = false;
                }
            }
            Connect.Open();
            Cmd = new SqlCommand("SELECT EQUIPMENT.EQUIPMENTID, EQUIPMENT.EQUIPMENTNAME FROM EQUIPMENT JOIN ASSIGNEDEQUIP ON EQUIPMENT.EQUIPMENTID=ASSIGNEDEQUIP.EQUIPMENTID WHERE PROJID=@ProjID", Connect);
            Cmd.Parameters.AddWithValue("@ProjID", ProjID);
            _chkbxlistEquipRemove.DataSource = Cmd.ExecuteReader();
            _chkbxlistEquipRemove.DataValueField = "EQUIPMENTID";
            _chkbxlistEquipRemove.DataTextField = "EQUIPMENTNAME";
            _chkbxlistEquipRemove.DataBind();
            Connect.Close();
        }

        protected void _btnEquipRemove_Click(object sender, EventArgs e)
        {
            List<ListItem> toBeRemoved = new List<ListItem>();
            for (int i = 0; i <= _chkbxlistEquipRemove.Items.Count - 1; i++)
            {
                if (_chkbxlistEquipRemove.Items[i].Selected)
                {
                    string ProjID = _dropdownProject.SelectedValue;
                    String Conn = ConfigurationManager.ConnectionStrings["ConnString_WEB_ASSET_DB"].ConnectionString;
                    SqlConnection Connect = new SqlConnection(Conn);
                    Connect.Open();
                    SqlCommand Cmd = new SqlCommand("DELETE FROM  ASSIGNEDEQUIP WHERE EQUIPMENTID=@equipmentid AND PROJID=@ProjID", Connect);
                    Cmd.Parameters.AddWithValue("@equipmentid", _chkbxlistEquipRemove.Items[i].Value);
                    Cmd.Parameters.AddWithValue("@ProjID", ProjID);
                    Cmd.ExecuteNonQuery();
                    Connect.Close();
                    toBeRemoved.Add(_chkbxlistEquipRemove.Items[i]);
                    foreach (ListItem AddEquip in _chkbxlistEquipAdd.Items)
                    {
                        if (AddEquip.Value.Equals(_chkbxlistEquipRemove.Items[i].Value))
                        {
                            AddEquip.Enabled = true;
                        }
                    }
                }
            }
            for (int i = 0; i < toBeRemoved.Count; i++)
            {
                _chkbxlistEquipRemove.Items.Remove(toBeRemoved[i]);
            }
        }

        protected void _chkbxlistEquipAdd_PreRender(object sender, EventArgs e)
        {
            for (int i = 0; i <= _chkbxlistEquipRemove.Items.Count - 1; i++)
            {
                foreach (ListItem AddEquip in _chkbxlistEquipAdd.Items)
                {
                    if (AddEquip.Value.Equals(_chkbxlistEquipRemove.Items[i].Value))
                    {
                        AddEquip.Enabled = false;
                    }
                }
            }
        }

        protected void _btnAddTrade_Click(object sender, EventArgs e)
        {
            String Conn = ConfigurationManager.ConnectionStrings["ConnString_WEB_ASSET_DB"].ConnectionString;
            SqlConnection Connect = new SqlConnection(Conn);
            SqlCommand Cmd;
            Connect.Open();
            string ProjID = _dropdownProject.SelectedValue;
            for (int i = 0; i <= _chlbxlistWorkerAdd.Items.Count - 1; i++)
            {
                if (_chlbxlistWorkerAdd.Items[i].Selected)
                {

                    Cmd = new SqlCommand("INSERT INTO ASSIGNEDWORKER (PROJID,WORKERID,INTHISPROJ) VALUES (@ProjID,@workerid,'true')", Connect);
                    Cmd.Parameters.AddWithValue("@workerid", _chlbxlistWorkerAdd.Items[i].Value);
                    Cmd.Parameters.AddWithValue("@ProjID", ProjID);
                    Cmd.ExecuteNonQuery();
                    Connect.Close();
                    Connect.Open();
                    Cmd = new SqlCommand("UPDATE WORKER SET ASSWORKER='True' WHERE WORKERID=@workerid", Connect);
                    Cmd.Parameters.AddWithValue("@workerid", _chlbxlistWorkerAdd.Items[i].Value);
                    Cmd.ExecuteNonQuery();
                    ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('ADDEDS)", true);
                }
            }

            Cmd = new SqlCommand("SELECT  WORKER.WORKERID, WORKERFNAME+' '+WORKERLNAME AS [WORKFULLNAME] FROM WORKER JOIN ASSIGNEDWORKER ON WORKER.WORKERID=ASSIGNEDWORKER.WORKERID WHERE PROJID=@ProjID", Connect);
            Cmd.Parameters.AddWithValue("@ProjID", ProjID);
            _chlbxlistWorkerRemove.DataSource = Cmd.ExecuteReader();
            _chlbxlistWorkerRemove.DataValueField = "WORKERID";
            _chlbxlistWorkerRemove.DataTextField = "WORKFULLNAME";
            _chlbxlistWorkerRemove.DataBind();
            Connect.Close();
        }

        protected void _btnRemoveTrade_Click(object sender, EventArgs e)
        {
            List<ListItem> toBeRemoved = new List<ListItem>();
            for (int i = 0; i <= _chlbxlistWorkerRemove.Items.Count - 1; i++)
            {
                if (_chlbxlistWorkerRemove.Items[i].Selected)
                {
                    String Conn = ConfigurationManager.ConnectionStrings["ConnString_WEB_ASSET_DB"].ConnectionString;
                    SqlConnection Connect = new SqlConnection(Conn);
                    Connect.Open();
                    SqlCommand Cmd = new SqlCommand("UPDATE WORKER SET WORKER.ASSWORKER='False' FROM WORKER JOIN ASSIGNEDWORKER ON WORKER.WORKERID=ASSIGNEDWORKER.WORKERID WHERE ASSIGNEDWORKER.WORKERID=@workerid", Connect);
                    Cmd.Parameters.AddWithValue("@workerid", _chlbxlistWorkerRemove.Items[i].Value);
                    Cmd.ExecuteNonQuery();
                    Connect.Close();

                    Connect.Open();
                    Cmd = new SqlCommand("UPDATE ASSIGNEDWORKER SET INTHISPROJ='False' FROM ASSIGNEDWORKER WHERE PROJID=@ProjectID", Connect);
                    Cmd.Parameters.AddWithValue("@ProjectID", _dropdownProject.SelectedValue);
                    Cmd.ExecuteNonQuery();
                    Connect.Close();

                    //Connect.Open();
                    //Cmd = new SqlCommand("DELETE FROM  ASSIGNEDWORKER WHERE WORKERID=@workerid AND PROJID=@ProjectID", Connect);
                    //Cmd.Parameters.AddWithValue("@workerid", _chlbxlistWorkerRemove.Items[i].Value);
                    //Cmd.Parameters.AddWithValue("@ProjectID", _dropdownProject.SelectedValue);
                    //Cmd.ExecuteNonQuery();
                    //Connect.Close();
                    toBeRemoved.Add(_chlbxlistWorkerRemove.Items[i]);
                }
            }
            for (int i = 0; i < toBeRemoved.Count; i++)
            {
                _chlbxlistWorkerRemove.Items.Remove(toBeRemoved[i]);
            }

        }

        protected void BackButtonPage4_Click(object sender, EventArgs e)
        {
            _panelEquipMain.Visible = true;
            _panelAssEquipQuant.Visible = true;
            _panelAssEquipList.Visible = false;
            _panelProjReqDetails.Visible = false;
            _panelWorkerMain.Visible = false;
            _panelSummary.Visible = false;
        }

        protected void FinishButtonPage4_Click(object sender, EventArgs e)
        {
            _panelSummary.Visible = true;
            _panelEquipMain.Visible = false;
            _panelAssEquipQuant.Visible = false;
            _panelAssEquipList.Visible = false;
            _panelProjReqDetails.Visible = false;
            _panelWorkerMain.Visible = false;
            _lblTitleSummary.Text = _dropdownProject.SelectedItem.ToString();
            ScriptManager.RegisterStartupScript(Page, Page.GetType(), "_modalSummary", "$('#_modalSummary').modal();", true);
            _panelSummary.Update();
            string ProjectID = _dropdownProject.SelectedValue.ToString();
            String Conn = ConfigurationManager.ConnectionStrings["ConnString_WEB_ASSET_DB"].ConnectionString;
            SqlConnection Connect = new SqlConnection(Conn);
            Connect.Open();
            SqlCommand Cmd = new SqlCommand("SELECT SUM(CAST(ASSEQUIPQUANT AS INT)) FROM ASSIGNEDEQUIP WHERE PROJID=@ProjectID", Connect);
            Cmd.Parameters.AddWithValue("@ProjectID", ProjectID);
            object Value = Cmd.ExecuteScalar();
            if (Value != DBNull.Value)
            {
                int Total = Convert.ToInt32(Value);
                _labelTotalAssEquip.Text = Total.ToString();
            }
            else
            {
                _labelTotalAssEquip.Text = "0";
            }
            Connect.Close();
            Connect.Open();
            Cmd = new SqlCommand("SELECT COUNT (*) FROM ASSIGNEDWORKER WHERE PROJID=@ProjectID", Connect);
            Cmd.Parameters.AddWithValue("@ProjectID", ProjectID);
            Value = Cmd.ExecuteScalar();
            if (Value != DBNull.Value)
            {
                int Total = Convert.ToInt32(Value);
                _labelTotalAssWorker.Text = Total.ToString();
            }
            else
            {
                _labelTotalAssWorker.Text = "0";
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
                SqlCommand Cmd = new SqlCommand("SELECT PROJID,PROJSITE,PROJPMINO,PROJAPPR,PROJFROM,PROJTO,PROGRESS,SHIFTID, COMPANYSTAFF.COMSTAFFFRSTNAME+' '+COMPANYSTAFF.COMSTAFFLASTNAME+', '+COMPANYSTAFF.COMSTAFFPOSITION AS [COMPSTAFFPOS] FROM PROJECT JOIN COMPANYSTAFF ON PROJECT.CNTRCTRPROJAPPID=COMPANYSTAFF.COMSTAFFID WHERE PROJID=@ProjectID", Connect);
                Cmd.Parameters.AddWithValue("@ProjectID", ProjectID);
                SqlDataReader Reader = Cmd.ExecuteReader();
                DateTime ProjFrom, ProjTo;
                while (Reader.Read())
                {
                    if (Reader["PROJFROM"].Equals(DBNull.Value) || Reader["PROJTO"].Equals(DBNull.Value) || Reader["PROGRESS"].Equals(DBNull.Value))
                    {
                        //ProjFrom = DateTime.Today.Date;
                        //ProjTo = DateTime.Today.Date;
                        _txtFromDate.Text = "--/--/----";
                        _txtToDate.Text = "--/--/----";
                        _labelSite.Text = Reader["PROJSITE"].ToString();
                        _labelPMI.Text = Reader["PROJPMINO"].ToString();
                        _labelSiteApprover.Text = Reader["COMPSTAFFPOS"].ToString();
                        string DateApp = Reader["PROJAPPR"].ToString();
                        DateTime AppDate = Convert.ToDateTime(DateApp);
                        _labelSiteDateApp.Text = AppDate.Date.ToString("MMMM dd, yyyy");
                        _dropdownProjectStat.ClearSelection();
                    }
                    else
                    {
                        _labelSite.Text = Reader["PROJSITE"].ToString();
                        _labelPMI.Text = Reader["PROJPMINO"].ToString();
                        _labelSiteApprover.Text = Reader["COMPSTAFFPOS"].ToString();
                        string DateApp = Reader["PROJAPPR"].ToString();
                        DateTime AppDate = Convert.ToDateTime(DateApp);
                        _labelSiteDateApp.Text = AppDate.Date.ToString("MMMM dd, yyyy");
                        ProjFrom = Convert.ToDateTime(Reader["PROJFROM"].ToString());
                        ProjTo = Convert.ToDateTime(Reader["PROJTO"].ToString());
                        _txtFromDate.Text = ProjFrom.ToString("MM/dd/yyyy");
                        _txtToDate.Text = ProjTo.ToString("MM/dd/yyyy");
                        _dropdownProjectStat.SelectedValue = Reader["PROGRESS"].ToString();
                        _dropdownProjectShift.SelectedValue = Reader["SHIFTID"].ToString();
                    }

                }
                Connect.Close();

                ProjectID = _dropdownProject.SelectedValue.ToString();
                Connect.Open();
                Cmd = new SqlCommand("SELECT SUM(CAST(TRADEQUANTITY AS INT)) FROM PROJREQTRADE WHERE PROJID=@ProjectID", Connect);
                Cmd.Parameters.AddWithValue("@ProjectID", ProjectID);
                object Value = Cmd.ExecuteScalar();
                if (Value != DBNull.Value)
                {
                    int Total = Convert.ToInt32(Value);
                    _labelTotalTrade.Text = Total.ToString();
                    _labelTotalTrade2.Text = Total.ToString();
                }
                else
                {
                    _labelTotalTrade.Text = "0";
                    _labelTotalTrade2.Text = "0";
                    _bulletlistProjTrade.Items.Add("No Worker listed"); ;
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
                    _labelTotalEquip2.Text = Total.ToString();
                }
                else
                {
                    _labelTotalEquip.Text = "0";
                    _labelTotalEquip2.Text = "0";
                    _bulletlistProjEquip.Items.Add("No Equipment listed");
                    _bulletlistProjEquip2.Items.Add("No Equipment listed");
                }
                Connect.Close();
                Connect.Open();
                string ProjID = _dropdownProject.SelectedValue;
                Cmd = new SqlCommand("SELECT  WORKER.WORKERID, WORKERFNAME+' '+WORKERLNAME AS [WORKFULLNAME] FROM WORKER JOIN ASSIGNEDWORKER ON WORKER.WORKERID=ASSIGNEDWORKER.WORKERID WHERE PROJID=@ProjID", Connect);
                Cmd.Parameters.AddWithValue("@ProjID", ProjID);
                _chlbxlistWorkerRemove.DataSource = Cmd.ExecuteReader();
                _chlbxlistWorkerRemove.DataValueField = "WORKERID";
                _chlbxlistWorkerRemove.DataTextField = "WORKFULLNAME";
                _chlbxlistWorkerRemove.DataBind();
                Cmd.Connection.Close();
                _bulletlistProjEquip2.DataBind();
                _bulletlistProjTrade2.DataBind();
                //_chkbxlistReqEquip.DataBind();
                Connect.Close();

                Connect.Open();
                Cmd = new SqlCommand("SELECT EQUIPMENT.EQUIPMENTID,EQUIPMENT.EQUIPMENTNAME FROM EQUIPMENT JOIN ASSIGNEDEQUIP ON EQUIPMENT.EQUIPMENTID=ASSIGNEDEQUIP.EQUIPMENTID WHERE PROJID=@ProjID", Connect);
                Cmd.Parameters.AddWithValue("@ProjID", ProjID);
                _chkbxlistEquipRemove.DataSource = Cmd.ExecuteReader();
                _chkbxlistEquipRemove.DataValueField = "EQUIPMENTID";
                _chkbxlistEquipRemove.DataTextField = "EQUIPMENTNAME";
                _chkbxlistEquipRemove.DataBind();
                Connect.Close();

                Connect.Open();
                Cmd = new SqlCommand("SELECT EQUIPMENTID, EQUIPMENTNAME FROM EQUIPMENT WHERE (CAST(STOCK AS INT) > 0)", Connect);
                _chkbxlistEquipAdd.DataSource = Cmd.ExecuteReader();
                _chkbxlistEquipAdd.DataValueField = "EQUIPMENTID";
                _chkbxlistEquipAdd.DataTextField = "EQUIPMENTNAME";
                _chkbxlistEquipAdd.DataBind();
                Connect.Close();
            }
            else
            {
                _dropdownProject.Enabled = true;
                string ProjectID = _dropdownProject.SelectedValue.ToString();
                String Conn = ConfigurationManager.ConnectionStrings["ConnString_WEB_ASSET_DB"].ConnectionString;
                SqlConnection Connect = new SqlConnection(Conn);
                Connect.Open();
                SqlCommand Cmd = new SqlCommand("SELECT PROJID,PROJSITE,PROJPMINO,PROJAPPR,PROJFROM,PROJTO,PROGRESS,SHIFTID, COMPANYSTAFF.COMSTAFFFRSTNAME+' '+COMPANYSTAFF.COMSTAFFLASTNAME+', '+COMPANYSTAFF.COMSTAFFPOSITION AS [COMPSTAFFPOS] FROM PROJECT JOIN COMPANYSTAFF ON PROJECT.CNTRCTRPROJAPPID=COMPANYSTAFF.COMSTAFFID WHERE PROJID=@ProjectID", Connect);
                Cmd.Parameters.AddWithValue("@ProjectID", ProjectID);
                SqlDataReader Reader = Cmd.ExecuteReader();
                DateTime ProjFrom, ProjTo;
                while (Reader.Read())
                {
                    if (Reader["PROJFROM"].Equals(DBNull.Value) || Reader["PROJTO"].Equals(DBNull.Value) || Reader["PROGRESS"].Equals(DBNull.Value))
                    {
                        //ProjFrom = DateTime.Today.Date;
                        //ProjTo = DateTime.Today.Date;
                        _txtFromDate.Text = "--/--/----";
                        _txtToDate.Text = "--/--/----";
                        _labelSite.Text = Reader["PROJSITE"].ToString();
                        _labelPMI.Text = Reader["PROJPMINO"].ToString();
                        _labelSiteApprover.Text = Reader["COMPSTAFFPOS"].ToString();
                        string DateApp = Reader["PROJAPPR"].ToString();
                        DateTime AppDate = Convert.ToDateTime(DateApp);
                        _labelSiteDateApp.Text = AppDate.Date.ToString("MMMM dd, yyyy");
                        _dropdownProjectStat.ClearSelection();
                    }
                    else
                    {
                        _labelSite.Text = Reader["PROJSITE"].ToString();
                        _labelPMI.Text = Reader["PROJPMINO"].ToString();
                        _labelSiteApprover.Text = Reader["COMPSTAFFPOS"].ToString();
                        string DateApp = Reader["PROJAPPR"].ToString();
                        DateTime AppDate = Convert.ToDateTime(DateApp);
                        _labelSiteDateApp.Text = AppDate.Date.ToString("MMMM dd, yyyy");
                        ProjFrom = Convert.ToDateTime(Reader["PROJFROM"].ToString());
                        ProjTo = Convert.ToDateTime(Reader["PROJTO"].ToString());
                        _txtFromDate.Text = ProjFrom.ToString("MM/dd/yyyy");
                        _txtToDate.Text = ProjTo.ToString("MM/dd/yyyy");
                        _dropdownProjectStat.SelectedValue = Reader["PROGRESS"].ToString();
                        _dropdownProjectShift.SelectedValue = Reader["SHIFTID"].ToString();

                    }

                }
                Connect.Close();

                ProjectID = _dropdownProject.SelectedValue.ToString();
                Connect.Open();
                Cmd = new SqlCommand("SELECT SUM(CAST(TRADEQUANTITY AS INT)) FROM PROJREQTRADE WHERE PROJID=@ProjectID", Connect);
                Cmd.Parameters.AddWithValue("@ProjectID", ProjectID);
                object Value = Cmd.ExecuteScalar();
                if (Value != DBNull.Value)
                {
                    int Total = Convert.ToInt32(Value);
                    _labelTotalTrade.Text = Total.ToString();
                    _labelTotalTrade2.Text = Total.ToString();
                }
                else
                {
                    _labelTotalTrade.Text = "0";
                    _labelTotalTrade2.Text = "0";
                    _bulletlistProjTrade.Items.Add("No Worker listed"); ;
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
                    _labelTotalEquip2.Text = Total.ToString();
                }
                else
                {
                    _labelTotalEquip.Text = "0";
                    _labelTotalEquip2.Text = "0";
                    _bulletlistProjEquip.Items.Add("No Equipment listed");
                    _bulletlistProjEquip2.Items.Add("No Equipment listed");
                }
                Connect.Close();
                string ProjID = _dropdownProject.SelectedValue;
                Connect.Open();
                Cmd = new SqlCommand("SELECT  WORKER.WORKERID, WORKERFNAME+' '+WORKERLNAME AS [WORKFULLNAME] FROM WORKER JOIN ASSIGNEDWORKER ON WORKER.WORKERID=ASSIGNEDWORKER.WORKERID WHERE PROJID=@ProjID", Connect);
                Cmd.Parameters.AddWithValue("@ProjID", ProjID);
                _chlbxlistWorkerRemove.DataSource = Cmd.ExecuteReader();
                _chlbxlistWorkerRemove.DataValueField = "WORKERID";
                _chlbxlistWorkerRemove.DataTextField = "WORKFULLNAME";
                _chlbxlistWorkerRemove.DataBind();
                _bulletlistProjEquip2.DataBind();
                _bulletlistProjTrade2.DataBind();
                //_chkbxlistReqEquip.DataBind();
                Connect.Close();

                Connect.Open();
                Cmd = new SqlCommand("SELECT EQUIPMENT.EQUIPMENTID,EQUIPMENT.EQUIPMENTNAME FROM EQUIPMENT JOIN ASSIGNEDEQUIP ON EQUIPMENT.EQUIPMENTID=ASSIGNEDEQUIP.EQUIPMENTID WHERE PROJID=@ProjID", Connect);
                Cmd.Parameters.AddWithValue("@ProjID", ProjID);
                _chkbxlistEquipRemove.DataSource = Cmd.ExecuteReader();
                _chkbxlistEquipRemove.DataValueField = "EQUIPMENTID";
                _chkbxlistEquipRemove.DataTextField = "EQUIPMENTNAME";
                _chkbxlistEquipRemove.DataBind();
                Connect.Close();

                Connect.Open();
                Cmd = new SqlCommand("SELECT EQUIPMENTID, EQUIPMENTNAME FROM EQUIPMENT WHERE (CAST(STOCK AS INT) > 0)", Connect);
                _chkbxlistEquipAdd.DataSource = Cmd.ExecuteReader();
                _chkbxlistEquipAdd.DataValueField = "EQUIPMENTID";
                _chkbxlistEquipAdd.DataTextField = "EQUIPMENTNAME";
                _chkbxlistEquipAdd.DataBind();
                Connect.Close();
            }
        }

        protected void _listviewAssEquipQuant_ItemUpdating(object sender, ListViewUpdateEventArgs e)
        {
            TextBox EQUIPMENTIDTextBox = (TextBox)_listviewAssEquipQuant.EditItem.FindControl("EQUIPMENTIDTextBox");
            TextBox ASSEQUIPQUANTTextBox = (TextBox)_listviewAssEquipQuant.EditItem.FindControl("ASSEQUIPQUANTTextBox");
            string EquipID = EQUIPMENTIDTextBox.Text.ToString();
            int EquipQuant = Convert.ToInt32(ASSEQUIPQUANTTextBox.Text);
            String Conn = ConfigurationManager.ConnectionStrings["ConnString_WEB_ASSET_DB"].ConnectionString;
            SqlConnection Connect = new SqlConnection(Conn);
            Connect.Open();
            SqlCommand Cmd = new SqlCommand("SELECT CAST(STOCK AS INT) FROM EQUIPMENT WHERE EQUIPMENTID=@EquipID", Connect);
            Cmd.Parameters.AddWithValue("@EquipID", EquipID);
            Int32 Stock = (Int32)Cmd.ExecuteScalar();
            if (EquipQuant > Stock)
            {
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('Not enough Equipments')", true);
                e.Cancel = true;
            }

        }
    }
}

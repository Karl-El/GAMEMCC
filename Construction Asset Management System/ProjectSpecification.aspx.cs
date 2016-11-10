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
    public partial class ProjectSpecification : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void _btnAdd_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/ProjectSpecification_CRUD.aspx");
        }

        protected void _listviewProjAss_ItemDataBound(object sender, ListViewItemEventArgs e)
        {
            if (e.Item.ItemType == ListViewItemType.DataItem)
            {
                var _labelTotalAssEquip = (Label)e.Item.FindControl("_labelTotalAssEquip");
                var _labelTotalAssWorker = (Label)e.Item.FindControl("_labelTotalAssWorker");
                var _bulletlistAssEquip = (BulletedList)e.Item.FindControl("_bulletlistAssEquip");
                var _bulletlistAssWorker = (BulletedList)e.Item.FindControl("_bulletlistAssWorker");
                var _dropdownProjectStat = (DropDownList)e.Item.FindControl("_dropdownProjectStat");
                var PROJIDLabel = (Label)e.Item.FindControl("PROJIDLabel");
                var _hyperlinkAssignEdit = (HyperLink)e.Item.FindControl("_hyperlinkAssignEdit");
                var EditButton = (LinkButton)e.Item.FindControl("EditButton");
               
                if (_dropdownProjectStat.SelectedValue == "Finish")
                {
                    _hyperlinkAssignEdit.Enabled = false;
                    EditButton.Enabled = false;
                }
                string ProjectID = PROJIDLabel.Text;
                String Conn = ConfigurationManager.ConnectionStrings["ConnString_WEB_ASSET_DB"].ConnectionString;
                SqlConnection Connect = new SqlConnection(Conn);
                Connect.Open();
                SqlCommand Cmd = new SqlCommand("SELECT COUNT(*) FROM ASSIGNEDWORKER WHERE PROJID=@ProjectID AND INTHISPROJ='true'", Connect);
                Cmd.Parameters.AddWithValue("@ProjectID", ProjectID);
                object Value = Cmd.ExecuteScalar();
                if (Convert.ToInt32(Value) != 0)
                {
                    int Total = Convert.ToInt32(Value);
                    _labelTotalAssWorker.Text = Total.ToString();
                }
                else
                {
                    _labelTotalAssWorker.Text = "0";
                }
                Connect.Close();
                Connect.Open();
                Cmd = new SqlCommand("SELECT SUM(CAST(ASSEQUIPQUANT AS INT)) FROM ASSIGNEDEQUIP WHERE PROJID=@ProjectID", Connect);
                Cmd.Parameters.AddWithValue("@ProjectID", ProjectID);
                Value = Cmd.ExecuteScalar();
                if (Value != DBNull.Value)
                {
                    int Total = Convert.ToInt32(Value);
                    _labelTotalAssEquip.Text = Total.ToString();
                }
                else
                {
                    _labelTotalAssEquip.Text = "0";
                }

                if (_labelTotalAssEquip.Text.Equals("0") && _labelTotalAssWorker.Text.Equals("0"))
                {
                    _hyperlinkAssignEdit.Text = "Add Worker/ Equipment";
                }
                else
                {
                    _hyperlinkAssignEdit.Text = "Edit Worker/ Equipment";
                }
                if (_bulletlistAssEquip.Items.Count == 0 || _bulletlistAssWorker.Items.Count == 0)
                {
                    _bulletlistAssEquip.Items.Add("No Equipment listed");
                    _bulletlistAssWorker.Items.Add("No Worker listed");

                }
            }
        }

        protected void _listviewProjAss_ItemUpdating(object sender, ListViewUpdateEventArgs e)
        {

            Label PROJIDLabel = (Label)_listviewProjAss.EditItem.FindControl("PROJIDLabel");
            DropDownList _dropdownProjectStat = (DropDownList)_listviewProjAss.EditItem.FindControl("_dropdownProjectStat");
            if (_dropdownProjectStat.SelectedValue.Equals("Finish"))
            {
                String Conn = ConfigurationManager.ConnectionStrings["ConnString_WEB_ASSET_DB"].ConnectionString;
                SqlConnection Connect = new SqlConnection(Conn);
                Connect.Open();
                SqlCommand Cmd = new SqlCommand("UPDATE ASSIGNEDEQUIP SET ASSEQUIPQUANT='0'  WHERE PROJID=@ProjectID", Connect);
                Cmd.Parameters.AddWithValue("@ProjectID", PROJIDLabel.Text);
                Cmd.ExecuteNonQuery();
                Connect.Close();
                Connect.Open();
                Cmd = new SqlCommand("UPDATE WORKER SET WORKER.ASSWORKER='False' FROM WORKER JOIN ASSIGNEDWORKER ON WORKER.WORKERID=ASSIGNEDWORKER.WORKERID WHERE ASSIGNEDWORKER.PROJID=@ProjectID", Connect);
                Cmd.Parameters.AddWithValue("@ProjectID", PROJIDLabel.Text);
                Cmd.ExecuteNonQuery();
                Connect.Close();
                Connect.Open();
                Cmd = new SqlCommand("UPDATE ASSIGNEDWORKER SET INTHISPROJ='False' FROM ASSIGNEDWORKER WHERE PROJID=@ProjectID", Connect);
                Cmd.Parameters.AddWithValue("@ProjectID", PROJIDLabel.Text);
                Cmd.ExecuteNonQuery();
                ScriptManager.RegisterStartupScript(this, this.GetType(), "popup", "alert('Equipments Returned and some Workers are now Available!');", true);
                Connect.Close();
            }
        }

        protected void _listviewProjAss_PreRender(object sender, EventArgs e)
        {

        }

        //protected void _dropdownProjectStat_SelectedIndexChanged(object sender, EventArgs e)
        //{
        //    DropDownList _dropdownProjectStatFind = (DropDownList)sender;
        //    ListViewItem items = (ListViewItem)_dropdownProjectStatFind.NamingContainer;
        //    DropDownList _dropdownProjectStat = (DropDownList)items.FindControl("_dropdownProjectStat");
        //    if (_dropdownProjectStat.SelectedItem.Equals("Finish"))
        //    {
        //         ScriptManager.RegisterStartupScript(this, this.GetType(), "popup", "alert('Maximum file size 5 mb');", true);
        //    }
        //}

        protected void _btnShowList_Click(object sender, EventArgs e)
        {
            _btnShowList.Visible = false;
            Response.Redirect("~/ProjectSpecification.aspx");
        }
        protected void _btnSearch_Click(object sender, EventArgs e)
        {
            _btnShowList.Visible = true;
            string Search = null;
            DataSourceProjectAssign.SelectParameters.Clear();
            if (IsPostBack)
            {
                Search = _txtSearch.Text.Trim();
                DataSourceProjectAssign.SelectParameters.Add("Search", Search);
                DataSourceProjectAssign.SelectCommand = "SELECT PROJECT.PROJID, CLIENT.CLIENTNAME + ' - ' + PROJECT.PROJNAME AS CLIENTPROJECT, PROJECT.PROJSITE, PROJECT.PROJFROM, PROJECT.PROJTO, PROJECT.STARTDATE, PROJECT.ENDDATE, PROJECT.PROGRESS FROM PROJECT INNER JOIN CLIENT ON PROJECT.CLIENTID = CLIENT.CLIENTID WHERE PROJID like'%'+@Search+'%' OR PROJSITE like'%'+@Search+'%' OR PROJFROM like'%'+@Search+'%' OR CLIENTNAME like'%'+@Search+'%' OR PROJNAME like'%'+@Search+'%' OR PROJTO like'%'+@Search+'%' OR ENDDATE like'%'+@Search+'%' OR STARTDATE like'%'+@Search+'%' OR PROGRESS like'%'+@Search+'%'";
                DataSourceProjectAssign.DataBind();
                _listviewProjAss.DataBind();
            }

        }
    }
}
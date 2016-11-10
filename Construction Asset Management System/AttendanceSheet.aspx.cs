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
    public partial class AttendanceSheet : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void _listviewAttendance_ItemDataBound(object sender, ListViewItemEventArgs e)
        {
            //DataSourceAttend.SelectParameters.Clear();
            //DataSourceAttend.SelectParameters.Add("PROJID", _dropdownProj.SelectedValue);
            //DataSourceAttend.SelectParameters.Add("ATTENDDDATE", _txtDate.Text);
            _listviewAttendance.DataBind();

            if (e.Item.ItemType == ListViewItemType.DataItem)
            {
                var DAILYATTENDIDLabel = (Label)e.Item.FindControl("DAILYATTENDIDLabel");
                var ATTENDTIMEINLabel = (Label)e.Item.FindControl("ATTENDTIMEINLabel");
                var ATTENDTIMEOUTLabel = (Label)e.Item.FindControl("ATTENDTIMEOUTLabel");
                var TOTALHRSLabel = (Label)e.Item.FindControl("TOTALHRSLabel");
                var ATTENDSTATUSLabel = (Label)e.Item.FindControl("ATTENDSTATUSLabel");
                string TimeStart = ATTENDTIMEINLabel.Text;
                string TimeEnd = ATTENDTIMEOUTLabel.Text;
                DateTime StartTime = Convert.ToDateTime(TimeStart);
                DateTime EndTime = Convert.ToDateTime(TimeEnd);
                TimeSpan Total = EndTime.Subtract(StartTime);
                TOTALHRSLabel.Text = Total.Hours.ToString() + " Hour(s) " + Total.Minutes.ToString() + " Minute(s) ";
                String Conn = ConfigurationManager.ConnectionStrings["ConnString_WEB_ASSET_DB"].ConnectionString;
                SqlConnection Connect = new SqlConnection(Conn);
                Connect.Open();
                string AttendID = DAILYATTENDIDLabel.Text;
                SqlCommand Cmd = new SqlCommand("SELECT PROJECT.PROJID, PROJECT.SHIFTID, SHIFT.SHIFTSTART, SHIFT.SHIFTEND, SHIFT.SHIFTTOTAL FROM PROJECT JOIN SHIFT ON SHIFT.SHIFTID=PROJECT.SHIFTID  WHERE PROJID=@ProjectID", Connect);
                Cmd.Parameters.AddWithValue("@ProjectID", _dropdownProj.SelectedValue);
                SqlDataReader Reader = Cmd.ExecuteReader();
                while (Reader.Read())
                {
                    TimeSpan ShiftHours = TimeSpan.Parse(Reader["SHIFTTOTAL"].ToString());
                    DateTime WorkStart = Convert.ToDateTime(Reader["SHIFTSTART"].ToString());
                    if (StartTime.TimeOfDay > WorkStart.TimeOfDay)
                    {
                        TimeSpan Lateness = StartTime.Subtract(WorkStart);
                        ATTENDSTATUSLabel.Text = "Late: " + Lateness.Hours.ToString() + " Hour(s)" + Lateness.Minutes.ToString() + " Minute(s)";
                    }
                    else
                    {
                        ATTENDSTATUSLabel.Text = "On Time";
                    }

                    if (StartTime.TimeOfDay.Minutes + 29 < WorkStart.TimeOfDay.Minutes)
                    {
                        TimeSpan Earlyness = StartTime - WorkStart;
                        ATTENDSTATUSLabel.Text = "30 minutes earlier or greater";
                    }
                    Cmd = new SqlCommand("UPDATE DAILYATTEND SET TOTALHRS=@totalhrs, ATTENDSTATUS=@attendstatus WHERE DAILYATTENDID=@AttendID", Connect);
                    Cmd.Parameters.AddWithValue("@AttendID", AttendID);
                    Cmd.Parameters.AddWithValue("@totalhrs", TOTALHRSLabel.Text);
                    Cmd.Parameters.AddWithValue("@attendstatus", ATTENDSTATUSLabel.Text);

                    //Cmd.Parameters.AddWithValue("@Used", Used);
                }
                Connect.Close();
                Connect.Open();
                Cmd.ExecuteNonQuery();
                Connect.Close();

            }
        }

        protected void _btnFilter_Click(object sender, EventArgs e)
        {
            //DataSourceAttend.SelectParameters.Clear();
            //DataSourceAttend.SelectCommand = "SELECT DAILYATTEND.DAILYATTENDID, WORKER.WORKERLNAME + ', ' + WORKER.WORKERFNAME AS FULLNAME, BADGE.BADGECODE, DAILYATTEND.ATTENDDDATE, DAILYATTEND.ATTENDTIMEIN, DAILYATTEND.ATTENDTIMEOUT, DAILYATTEND.TOTALHRS, DAILYATTEND.ATTENDSTATUS FROM DAILYATTEND INNER JOIN PROJECT ON DAILYATTEND.PROJID = PROJECT.PROJID INNER JOIN WORKER ON DAILYATTEND.WORKERID = WORKER.WORKERID INNER JOIN BADGE ON WORKER.WORKERID = BADGE.WORKERID WHERE (DAILYATTEND.PROJID = @PROJID AND DAILYATTEND.ATTENDDDATE=@ATTENDDDATE)";
            //DataSourceAttend.SelectParameters.Add("PROJID", _dropdownProj.SelectedValue);
            //DataSourceAttend.SelectParameters.Add("ATTENDDDATE", _txtDate.Text);
            //DataSourceAttend.DataBind();
            //_listviewAttendance.DataBind();
            _listviewAttendance.DataSourceID = "DataSourceAttendFilter";
            DataSourceAttendFilter.DataBind();
            _listviewAttendance.DataBind();
        }

        protected void _btnAll_Click(object sender, EventArgs e)
        {
            //DataSourceAttend.SelectParameters.Clear();
            //DataSourceAttend.SelectParameters.Add("PROJID", _dropdownProj.SelectedValue);
            //DataSourceAttend.DataBind();
            //_listviewAttendance.DataBind();
            _txtDate.Text = string.Empty;
            _listviewAttendance.DataSourceID = "DataSourceAttendAll";
            DataSourceAttendAll.DataBind();
            _listviewAttendance.DataBind();

        }
    }
}
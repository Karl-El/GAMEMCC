using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Construction_Asset_Management_System
{
    public partial class Shift : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void _btnAdd_Click(object sender, EventArgs e)
        {
            _listviewShift.InsertItemPosition = InsertItemPosition.FirstItem;
        }

        protected void _btnSearch_Click(object sender, EventArgs e)
        {
            _btnShowList.Visible = true;
            string Search = null;

            DataSourceShift.SelectParameters.Clear();
            if (IsPostBack)
            {
                Search = _txtSearch.Text.Trim();
                DataSourceShift.SelectParameters.Add("Search", Search);
                DataSourceShift.SelectCommand = "SELECT [SHIFTID], [SHIFTNAME], [SHIFTSTART], [SHIFTEND], [SHIFTTOTAL], [SHIFTCOLOR] FROM [SHIFT] WHERE SHIFTNAME like'%'+@Search+'%'  OR SHIFTSTART like'%'+@Search+'%' OR SHIFTEND like'%'+@Search+'%' OR SHIFTTOTAL like'%'+@Search+'%'";
                DataSourceShift.DataBind();
                _listviewShift.DataBind();
            }

        }

        protected void _btnShowList_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Shift.aspx");
            _btnShowList.Visible = false;
        }

        protected void InsertButton_Click(object sender, EventArgs e)
        {
            _listviewShift.InsertItemPosition = InsertItemPosition.None;
            TextBox SHIFTSTARTTextBox = (TextBox)_listviewShift.InsertItem.FindControl("SHIFTSTARTTextBox");
            TextBox SHIFTENDTextBox = (TextBox)_listviewShift.InsertItem.FindControl("SHIFTENDTextBox");
            TextBox SHIFTTOTALTextBox = (TextBox)_listviewShift.InsertItem.FindControl("SHIFTTOTALTextBox");
            string TimeStart = SHIFTSTARTTextBox.Text;
            string TimeEnd = SHIFTENDTextBox.Text;
            DateTime StartTime = Convert.ToDateTime(TimeStart);
            DateTime EndTime = Convert.ToDateTime(TimeEnd);
            TimeSpan Total = EndTime.Subtract(StartTime);
            SHIFTTOTALTextBox.Text = Total.Hours.ToString();
        }

        protected void CancelButton_Click(object sender, EventArgs e)
        {
            _listviewShift.InsertItemPosition = InsertItemPosition.None;
        }

        protected void UpdateButton_Click(object sender, EventArgs e)
        {
            TextBox SHIFTSTARTTextBox = (TextBox)_listviewShift.EditItem.FindControl("SHIFTSTARTTextBox");
            TextBox SHIFTENDTextBox = (TextBox)_listviewShift.EditItem.FindControl("SHIFTENDTextBox");
            TextBox SHIFTTOTALTextBox = (TextBox)_listviewShift.EditItem.FindControl("SHIFTTOTALTextBox");
            string TimeStart = SHIFTSTARTTextBox.Text;
            string TimeEnd = SHIFTENDTextBox.Text;
            DateTime StartTime = Convert.ToDateTime(TimeStart);
            DateTime EndTime = Convert.ToDateTime(TimeEnd);
            TimeSpan Total = EndTime.Subtract(StartTime);
            SHIFTTOTALTextBox.Text = Total.Hours.ToString();

        }

    }
}
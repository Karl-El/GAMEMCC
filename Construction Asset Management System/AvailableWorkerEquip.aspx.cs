using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Construction_Asset_Management_System
{
    public partial class AvailableWorkerEquip : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
           
            
        }

        protected void _chkbxlstAvailWorker_PreRender(object sender, EventArgs e)
        {
            foreach (ListItem Worker in _chkbxlstAvailWorker.Items)
            {
                Worker.Selected = true;
                Worker.Enabled = false;
            }
        }

        protected void _chkbxlstAvailEquip_PreRender(object sender, EventArgs e)
        {
            foreach (ListItem Equip in _chkbxlstAvailEquip.Items)
            {
                Equip.Selected = true;
                Equip.Enabled = false;
            }
        }
    }
}
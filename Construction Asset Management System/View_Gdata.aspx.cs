using System;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Xml.Linq;
using System.Web.Mail;
using System.IO;
using System.Net;
using System.Xml;
using System.Collections.Specialized;
using System.Text;
using Google.GData.Client;
using Google.GData.Spreadsheets;

namespace Construction_Asset_Management_System
{
    public partial class View_Gdata : System.Web.UI.Page
    {
        public double CurrPage, pageLen, lastNumber, PageRem, PageTen, next10, prev10, nPageCount, pnPageCount, start, RSPrevPage, RSNextPage, P;
        public string sSQL = null, strsession = null;
        public int countchk;
        protected void Page_Load(object sender, EventArgs e)
        {
            SpreadsheetsService service = new SpreadsheetsService("Final Attendance");
            service.setUserCredentials("carlsonjcruz@gmail.com", "carl101894");

            SpreadsheetQuery query = new SpreadsheetQuery();
            query.Title = "Final Attendance";
            SpreadsheetFeed feed = service.Query(query);

            if (feed.Entries.Count == 0)
            {
                // TODO: There were no spreadsheets, act accordingly.
            }

            SpreadsheetEntry spreadsheet = (SpreadsheetEntry)feed.Entries[0];
            WorksheetFeed wsFeed = spreadsheet.Worksheets;
            WorksheetEntry worksheet = (WorksheetEntry)wsFeed.Entries[0];
            AtomLink listFeedLink = worksheet.Links.FindService(GDataSpreadsheetsNameTable.ListRel, null);
            ListQuery listQuery = new ListQuery(listFeedLink.HRef.ToString());
            ListFeed listFeed = service.Query(listQuery);

            PagedDataSource pds = new PagedDataSource();
            var table = new DataTable();

            foreach (ListEntry row in listFeed.Entries.Reverse())
            {
                var roww = table.NewRow();
                foreach (ListEntry.Custom element in row.Elements)
                {
                    var column = table.Columns[element.LocalName] ?? table.Columns.Add(element.LocalName);
                    roww[column] = element.Value;
                }
                table.Rows.Add(roww);
            }

            pds.DataSource = table.DefaultView;

            pds.AllowPaging = true;
            pds.PageSize = 30;
            if (Request.QueryString["page"] != null)
            {
                CurrPage = Convert.ToInt32(Request.QueryString["page"].ToString());
                int intPage = (Convert.ToInt32(Request.QueryString["page"]) - 1);
                if (intPage < 0) intPage = 0;
                if (intPage > pds.PageCount) intPage = pds.PageCount - 1;
                pds.CurrentPageIndex = intPage;
            }
            else
            {
                CurrPage = 1;
            }

            next10 = Convert.ToDouble(getNext10(CurrPage));
            prev10 = Convert.ToDouble(getPrev10(CurrPage));
            nPageCount = pds.PageCount;
            pnPageCount = Convert.ToInt32(nPageCount) - 1;

            rptr.DataSource = pds;
            rptr.DataSource = pds;

            RSPrevPage = CurrPage - 1;
            RSNextPage = CurrPage + 1;

            if (next10 > pds.PageCount)
            {
                next10 = pds.PageCount;
            }

            if (prev10 == 1 & next10 - 1 < 10)
            {
                start = 1;
            }
            else
            {
                start = next10 - 10;
                if (Convert.ToInt32(start.ToString().Substring(start.ToString().Length - 1, 1)) > 0)
                {
                    start = Convert.ToDouble(start.ToString().Replace(start.ToString().Substring(start.ToString().Length - 1, 1), "0"));
                    start = start + 10;
                }
            }

            MyLiteral.Text = CreatePagerLinks(pds, next10, prev10, "View_Gdata.aspx");
        }
        public static string CreatePagerLinks(PagedDataSource pds, double next10, double prev10, string BaseUrl)
        {
            StringBuilder sbPager = new StringBuilder();
            sbPager.Append("<div class='paginationTTIQ'><p>");
            if (!pds.IsFirstPage)
            {
                // first page link
                sbPager.Append("<a href=\"");
                sbPager.Append(BaseUrl);
                sbPager.Append("\">|<</a> ");
                sbPager.Append("<a href=\"View_Gdata.aspx?page=" + prev10 + "\"><<</a> ");
                if (pds.CurrentPageIndex != 1)
                {
                    // previous page link
                    sbPager.Append("<a href=\"");
                    sbPager.Append(BaseUrl);
                    sbPager.Append("?page=");
                    sbPager.Append(pds.CurrentPageIndex.ToString());
                    sbPager.Append("\" alt=\"Previous Page\"><</a> ");
                }
            }
            // calc low and high limits for numeric links
            int intLow = pds.CurrentPageIndex - 1;
            int intHigh = pds.CurrentPageIndex + 3;
            if (intLow < 1) intLow = 1;
            if (intHigh > pds.PageCount) intHigh = pds.PageCount;
            if (intHigh - intLow < 10) while ((intHigh < intLow + 9) && intHigh < pds.PageCount) intHigh++;
            if (intHigh - intLow < 10) while ((intLow > intHigh - 9) && intLow > 1) intLow--;
            for (int x = intLow; x < intHigh + 1; x++)
            {
                // numeric links
                if (x == pds.CurrentPageIndex + 1) sbPager.Append(x.ToString() + " ");
                else
                {
                    sbPager.Append("<a href=\"");
                    sbPager.Append(BaseUrl);
                    sbPager.Append("?page=");
                    sbPager.Append(x.ToString());
                    sbPager.Append("\">");
                    sbPager.Append(x.ToString());
                    sbPager.Append("</a> ");
                }
            }
            if (!pds.IsLastPage)
            {
                if ((pds.CurrentPageIndex + 2) != pds.PageCount)
                {
                    // next page link
                    sbPager.Append("<a href=\"");
                    sbPager.Append(BaseUrl);
                    sbPager.Append("?page=");
                    sbPager.Append(Convert.ToString(pds.CurrentPageIndex + 2));
                    sbPager.Append("\">></a> ");
                }
                if (!(next10 == pds.PageCount))
                {
                    sbPager.Append("<a href=\"View_Gdata.aspx?page=" + next10 + "\">>></a>");
                }
                // last page link
                sbPager.Append("<a href=\"");
                sbPager.Append(BaseUrl);
                sbPager.Append("?page=");
                sbPager.Append(pds.PageCount.ToString());
                sbPager.Append("\"<<|</a>");
            }
            sbPager.Append("</p></div>");
            // conver the final links to a string and assign to labels
            return sbPager.ToString();
        }
        public object getNext10(double num)
        {
            pageLen = num.ToString().Length;
            if (pageLen == 1)
            {
                next10 = 10;
            }
            else if (pageLen > 1)
            {
                PageRem = 10;
                PageTen = Convert.ToInt32(num.ToString().Substring(num.ToString().Length - 1, 1));
                next10 = num + PageRem - PageTen;
            }
            return next10;
        }
        public object getPrev10(double num)
        {
            pageLen = num.ToString().Length;
            if (pageLen == 1)
            {
                prev10 = 1;
            }
            else if (pageLen > 1)
            {
                lastNumber = Convert.ToInt32(num.ToString().Substring(num.ToString().Length - 1, 1));
                prev10 = num - lastNumber - 10;
            }
            if (prev10 == 0)
            {
                prev10 = 1;
            }
            return prev10;
        }
        public static string Right(string param, int length)
        {
            string result = param.Substring(param.Length - length, length);
            return result;
        }
        public int PageNumber
        {
            get
            {
                if (ViewState["PageNumber"] != null)
                    return Convert.ToInt32(ViewState["PageNumber"]);
                else
                    return 0;
            }
            set
            {
                ViewState["PageNumber"] = value;
            }
        }
    }
}
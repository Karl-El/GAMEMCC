<%@ Page Title="Badge" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Badge.aspx.cs" Inherits="Construction_Asset_Management_System.Badge" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <h4 class="well text-center" style="padding: 8px">Badges</h4>
    <div class="row text-center">
        <div class="col-sm-12 form-inline">
            <div class="input-group">
                <asp:TextBox ID="_txtSearch" runat="server" CssClass="form-control" />
                <span class="input-group-btn">
                    <asp:LinkButton runat="server" ID="_btnSearch" CssClass="btn btn-info" OnClick="_btnSearch_Click"><span class="glyphicon glyphicon-search"></span> Search</asp:LinkButton>
                </span>
            </div>
            <asp:LinkButton runat="server" ID="_btnAdd" CssClass="btn btn-info " OnClick="_btnAdd_Click"><span class="glyphicon glyphicon-plus"></span> Add</asp:LinkButton>
            <asp:LinkButton runat="server" ID="_btnShowList" CssClass="btn btn-info" OnClick="_btnShowList_Click" Visible="false"><span class="glyphicon glyphicon-list-alt"></span> Show Full List</asp:LinkButton>
            <%--<asp:LinkButton runat="server" ID="_btnNoReq" CssClass="btn btn-info" Visible="false" OnClick="_btnNoReq_Click"><span class="glyphicon glyphicon-list-alt"></span> Show Full List</asp:LinkButton>--%>
        </div>
    </div>
    <br />
    <asp:ListView ID="_listviewBadge" runat="server" DataSourceID="DataSourceBadge" GroupItemCount="3">
        <%--<AlternatingItemTemplate>
            <td runat="server" style="">WORKERIMAGE:
                <asp:Label Text='<%# Eval("WORKERIMAGE") %>' runat="server" ID="WORKERIMAGELabel" /><br />
                WORKERFULLNAME:
                <asp:Label Text='<%# Eval("WORKERFULLNAME") %>' runat="server" ID="WORKERFULLNAMELabel" /><br />
                WORKERDOB:
                <asp:Label Text='<%# Eval("WORKERDOB") %>' runat="server" ID="WORKERDOBLabel" /><br />
                WORKERADDR:
                <asp:Label Text='<%# Eval("WORKERADDR") %>' runat="server" ID="WORKERADDRLabel" /><br />
                BADGECODE:
                <asp:Label Text='<%# Eval("BADGECODE") %>' runat="server" ID="BADGECODELabel" /><br />
                BADGEFROM:
                <asp:Label Text='<%# Eval("BADGEFROM") %>' runat="server" ID="BADGEFROMLabel" /><br />
                BADGETO:
                <asp:Label Text='<%# Eval("BADGETO") %>' runat="server" ID="BADGETOLabel" /><br />
                BADGESTAT:
                <asp:Label Text='<%# Eval("BADGESTAT") %>' runat="server" ID="BADGESTATLabel" /><br />
                BADGEPICCODE:
                <asp:Label Text='<%# Eval("BADGEPICCODE") %>' runat="server" ID="BADGEPICCODELabel" /><br />
            </td>
        </AlternatingItemTemplate>
        <EditItemTemplate>
            <td runat="server" style="">WORKERIMAGE:
                <asp:TextBox Text='<%# Bind("WORKERIMAGE") %>' runat="server" ID="WORKERIMAGETextBox" /><br />
                WORKERFULLNAME:
                <asp:TextBox Text='<%# Bind("WORKERFULLNAME") %>' runat="server" ID="WORKERFULLNAMETextBox" /><br />
                WORKERDOB:
                <asp:TextBox Text='<%# Bind("WORKERDOB") %>' runat="server" ID="WORKERDOBTextBox" /><br />
                WORKERADDR:
                <asp:TextBox Text='<%# Bind("WORKERADDR") %>' runat="server" ID="WORKERADDRTextBox" /><br />
                BADGECODE:
                <asp:TextBox Text='<%# Bind("BADGECODE") %>' runat="server" ID="BADGECODETextBox" /><br />
                BADGEFROM:
                <asp:TextBox Text='<%# Bind("BADGEFROM") %>' runat="server" ID="BADGEFROMTextBox" /><br />
                BADGETO:
                <asp:TextBox Text='<%# Bind("BADGETO") %>' runat="server" ID="BADGETOTextBox" /><br />
                BADGESTAT:
                <asp:TextBox Text='<%# Bind("BADGESTAT") %>' runat="server" ID="BADGESTATTextBox" /><br />
                BADGEPICCODE:
                <asp:TextBox Text='<%# Bind("BADGEPICCODE") %>' runat="server" ID="BADGEPICCODETextBox" /><br />
                <asp:Button runat="server" CommandName="Update" Text="Update" ID="UpdateButton" /><br />
                <asp:Button runat="server" CommandName="Cancel" Text="Cancel" ID="CancelButton" /><br />
            </td>
        </EditItemTemplate>--%>
        <EmptyDataTemplate>
            <div runat="server" style="">
                <div>
                    <div>No data was returned.</div>
                </div>
            </div>
        </EmptyDataTemplate>
        <EmptyItemTemplate>
            <div runat="server" />
        </EmptyItemTemplate>
        <GroupTemplate>
            <div runat="server" id="itemPlaceholderContainer">
                <div runat="server" id="itemPlaceholder"></div>
            </div>
        </GroupTemplate>
        <%--<InsertItemTemplate>
            <td runat="server" style="">WORKERIMAGE:
                <asp:TextBox Text='<%# Bind("WORKERIMAGE") %>' runat="server" ID="WORKERIMAGETextBox" /><br />
                WORKERFULLNAME:
                <asp:TextBox Text='<%# Bind("WORKERFULLNAME") %>' runat="server" ID="WORKERFULLNAMETextBox" /><br />
                WORKERDOB:
                <asp:TextBox Text='<%# Bind("WORKERDOB") %>' runat="server" ID="WORKERDOBTextBox" /><br />
                WORKERADDR:
                <asp:TextBox Text='<%# Bind("WORKERADDR") %>' runat="server" ID="WORKERADDRTextBox" /><br />
                BADGECODE:
                <asp:TextBox Text='<%# Bind("BADGECODE") %>' runat="server" ID="BADGECODETextBox" /><br />
                BADGEFROM:
                <asp:TextBox Text='<%# Bind("BADGEFROM") %>' runat="server" ID="BADGEFROMTextBox" /><br />
                BADGETO:
                <asp:TextBox Text='<%# Bind("BADGETO") %>' runat="server" ID="BADGETOTextBox" /><br />
                BADGESTAT:
                <asp:TextBox Text='<%# Bind("BADGESTAT") %>' runat="server" ID="BADGESTATTextBox" /><br />
                BADGEPICCODE:
                <asp:TextBox Text='<%# Bind("BADGEPICCODE") %>' runat="server" ID="BADGEPICCODETextBox" /><br />
                <asp:Button runat="server" CommandName="Insert" Text="Insert" ID="InsertButton" /><br />
                <asp:Button runat="server" CommandName="Cancel" Text="Clear" ID="CancelButton" /><br />
            </td>
        </InsertItemTemplate>--%>
        <ItemTemplate>
            <div class="col-sm-4">
                <div runat="server" style="" class="well">
                    <asp:Image runat="server" ImageUrl='<%# Eval("WORKERIMAGE") %>' CssClass="img-responsive img-thumbnail center-block" AlternateText="Not Available" Width="100" Height="100" />
                    <%--<label class="control-label">Worker Name:</label>--%>
                    <asp:Label Font-Size="X-Large" Font-Bold="true" CssClass="text-success text-center" Text='<%# Eval("WORKERFULLNAME") %>' runat="server" ID="WORKERFULLNAMELabel" /><br />
                    <label class="control-label">Birthdate:</label>
                    <asp:Label Text='<%# Eval("WORKERDOB","{0:MMMM dd, yyyy}") %>' runat="server" ID="WORKERDOBLabel" /><br />
                    <label class="control-label">Address</label>
                    <asp:Label Text='<%# Eval("WORKERADDR") %>' runat="server" ID="WORKERADDRLabel" /><br />
                    <label class="control-label">Badge Code:</label>
                    <asp:Label Text='<%# Eval("BADGECODE") %>' runat="server" ID="BADGECODELabel" /><br />
                    <label class="control-label">Valid From:</label>
                    <asp:Label Text='<%# Eval("BADGEFROM","{0:MMMM dd, yyyy}") %>' runat="server" ID="BADGEFROMLabel" /><br />
                    <label class="control-label">Valid To:</label>
                    <asp:Label Text='<%# Eval("BADGETO","{0:MMMM dd, yyyy}") %>' runat="server" ID="BADGETOLabel" /><br />
                    <label class="control-label">Badge Status:</label>
                    <asp:Label Text='<%# Eval("BADGESTAT") %>' runat="server" ID="BADGESTATLabel" /><br />
                    <label class="control-label">QR Code:</label>
                    <asp:Image runat="server" ImageUrl='<%# Eval("BADGEPICCODE") %>' CssClass="img-responsive img-thumbnail center-block" AlternateText="Not Available" Height="180" Width="180" />
                    <%--<asp:Label Text='<%# Eval("BADGEPICCODE") %>' runat="server" ID="BADGEPICCODELabel" /><br />--%>
                    <div class="text-center">
                        <asp:HyperLink ID="_hyperlinkBadgeEdit" runat="server" NavigateUrl='<%#"~/Badge_CRUD.aspx?id="+Eval("WORKERID") %>' Text="Edit Badge" CssClass="btn btn-link"></asp:HyperLink>
                    </div>
                </div>
            </div>
        </ItemTemplate>
        <LayoutTemplate>
            <div runat="server">
                <div runat="server">
                    <div runat="server">
                        <div runat="server" id="groupPlaceholderContainer" style="" border="0">
                            <div runat="server" id="groupPlaceholder"></div>
                        </div>
                    </div>
                </div>
                <div runat="server">
                    <div runat="server" style="">
                        <asp:DataPager runat="server" PageSize="12" ID="DataPager1">
                            <Fields>
                                <asp:NextPreviousPagerField ButtonType="Button" ShowFirstPageButton="True" ShowNextPageButton="False" ShowPreviousPageButton="True" ButtonCssClass="btn btn-info btn-sm" />
                                <asp:NumericPagerField NumericButtonCssClass="label label-success" CurrentPageLabelCssClass="badge" />
                                <asp:NextPreviousPagerField ButtonType="Button" ShowLastPageButton="True" ShowNextPageButton="True" ShowPreviousPageButton="False" ButtonCssClass="btn btn-info btn-sm" />
                            </Fields>
                        </asp:DataPager>
                    </div>
                </div>
            </div>
        </LayoutTemplate>
        <%--<SelectedItemTemplate>
            <td runat="server" style="">WORKERIMAGE:
                <asp:Label Text='<%# Eval("WORKERIMAGE") %>' runat="server" ID="WORKERIMAGELabel" /><br />
                WORKERFULLNAME:
                <asp:Label Text='<%# Eval("WORKERFULLNAME") %>' runat="server" ID="WORKERFULLNAMELabel" /><br />
                WORKERDOB:
                <asp:Label Text='<%# Eval("WORKERDOB") %>' runat="server" ID="WORKERDOBLabel" /><br />
                WORKERADDR:
                <asp:Label Text='<%# Eval("WORKERADDR") %>' runat="server" ID="WORKERADDRLabel" /><br />
                BADGECODE:
                <asp:Label Text='<%# Eval("BADGECODE") %>' runat="server" ID="BADGECODELabel" /><br />
                BADGEFROM:
                <asp:Label Text='<%# Eval("BADGEFROM") %>' runat="server" ID="BADGEFROMLabel" /><br />
                BADGETO:
                <asp:Label Text='<%# Eval("BADGETO") %>' runat="server" ID="BADGETOLabel" /><br />
                BADGESTAT:
                <asp:Label Text='<%# Eval("BADGESTAT") %>' runat="server" ID="BADGESTATLabel" /><br />
                BADGEPICCODE:
                <asp:Label Text='<%# Eval("BADGEPICCODE") %>' runat="server" ID="BADGEPICCODELabel" /><br />
            </td>
        </SelectedItemTemplate>--%>
    </asp:ListView>
    <asp:SqlDataSource runat="server" ID="DataSourceBadge" ConnectionString='<%$ ConnectionStrings:ConnString_WEB_ASSET_DB %>' SelectCommand="SELECT WORKER.WORKERID, WORKER.WORKERIMAGE, WORKER.WORKERFNAME + ' ' + WORKER.WORKERLNAME AS WORKERFULLNAME, WORKER.WORKERDOB, WORKER.WORKERADDR, BADGE.BADGECODE, BADGE.BADGEFROM, BADGE.BADGETO, BADGE.BADGESTAT, BADGE.BADGEPICCODE FROM WORKER INNER JOIN BADGE ON WORKER.WORKERID = BADGE.WORKERID"></asp:SqlDataSource>
</asp:Content>

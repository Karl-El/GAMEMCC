<%@ Page Title="Worker" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Worker.aspx.cs" Inherits="Construction_Asset_Management_System.Worker" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <link href="Content/checkbox.css" rel="stylesheet" type="text/css" />
    <h4 class="well text-center" style="padding: 8px">Worker List</h4>
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
        </div>
    </div>
    <br />
    <asp:ListView ID="_listviewWorker" runat="server" DataKeyNames="WORKERID" DataSourceID="DataSourceWorker" OnItemDeleted="_listviewWorker_ItemDeleted">
        <EmptyDataTemplate>
            <table runat="server" style="">
                <tr>
                    <td>No data was returned.</td>
                </tr>
            </table>
        </EmptyDataTemplate>
        <ItemTemplate>
            <tr onclick="window.location.href='<%# System.Web.VirtualPathUtility.ToAbsolute("~/Worker_CRUD.aspx?id=" + Eval("WORKERID"))%>';">
                <td>
                    <asp:Label ID="WORKERIDLabel" runat="server" Text='<%# Eval("WORKERID") %>' />
                </td>
                <td>
                    <asp:Label ID="WORKERFNAMELabel" runat="server" Text='<%# Eval("WORKERFNAME") %>' />
                </td>
                <td>
                    <asp:Label ID="WORKERLNAMELabel" runat="server" Text='<%# Eval("WORKERLNAME") %>' />
                </td>
                <td>
                    <asp:Label ID="WORKERDOBLabel" runat="server" Text='<%# Eval("WORKERDOB","{0:MM/dd/yyyy}") %>' />
                </td>
                <td>
                    <asp:Label ID="WORKERADDRLabel" runat="server" Text='<%# Eval("WORKERADDR") %>' />
                </td>
                <td>
                    <asp:Label ID="WORKERSTATUSLabel" runat="server" Text='<%# Eval("WORKERSTATUS") %>' />
                </td>
                <td>
                    <asp:Label ID="WORKEREMPLOYTYPELabel" runat="server" Text='<%# Eval("WORKEREMPLOYTYPE") %>' />
                </td>
                <td>
                    <asp:Label ID="LABORTYPEIDLabel" runat="server" Text='<%# Eval("LABORTYPENAME") %>' />
                </td>
                <td>
                <asp:CheckBox ID="ASSWORKERCheckbox" runat="server" Checked='<%# Eval("ASSWORKER") %>' Enabled="false" Text=" " CssClass="checkbox checkbox-danger checkbox-circle"/>
                    </td>
                <td onclick="return confirm('Are you sure to delete?')">
                    <asp:LinkButton ID="DeleteButton" runat="server" CommandName="Delete" Text="Delete" CssClass="btn btn-danger"><span class="glyphicon glyphicon-trash"></span></asp:LinkButton>
                </td>
            </tr>
        </ItemTemplate>
        <LayoutTemplate>
            <div runat="server" class="well table-responsive">
                <div runat="server">
                    <div runat="server">
                        <table id="itemPlaceholderContainer" runat="server" border="0" style="" class="table table-condensed table-hover">
                            <tr runat="server" style="" class="info">
                                <th runat="server">
                                    <asp:LinkButton ID="_linkbtnClientStaffID" CommandArgument="WORKERID" CommandName="Sort" Text="ID" runat="server"></asp:LinkButton>
                                </th>
                                <th runat="server">
                                    <asp:LinkButton ID="LinkButton1" CommandArgument="WORKERFNAME" CommandName="Sort" Text="First Name" runat="server"></asp:LinkButton>
                                </th>
                                <th runat="server">
                                    <asp:LinkButton ID="LinkButton2" CommandArgument="WORKERLNAME" CommandName="Sort" Text="Last Name" runat="server"></asp:LinkButton>
                                </th>
                                <th runat="server">
                                    <asp:LinkButton ID="LinkButton3" CommandArgument="WORKERDOB" CommandName="Sort" Text="Birthdate" runat="server"></asp:LinkButton>
                                </th>
                                <th runat="server">
                                    <asp:LinkButton ID="LinkButton4" CommandArgument="WORKERADDR" CommandName="Sort" Text="Address" runat="server"></asp:LinkButton>
                                </th>
                                <th runat="server">
                                    <asp:LinkButton ID="LinkButton5" CommandArgument="WORKERSTATUS" CommandName="Sort" Text="Employment Status" runat="server"></asp:LinkButton>
                                </th>
                                <th runat="server">
                                    <asp:LinkButton ID="LinkButton6" CommandArgument="WORKEREMPLOYTYPE" CommandName="Sort" Text="Employment Type" runat="server"></asp:LinkButton>
                                </th>
                                <th runat="server">
                                    <asp:LinkButton ID="LinkButton7" CommandArgument="LABORTYPENAME" CommandName="Sort" Text="Labor Career Type" runat="server"></asp:LinkButton>
                                </th>
                                <th runat="server">
                                    <asp:LinkButton ID="LinkButton8" CommandArgument="ASSWORKER" CommandName="Sort" Text="Is Assigned" runat="server"></asp:LinkButton>
                                </th>
                                <th runat="server"></th>
                            </tr>
                            <tr id="itemPlaceholder" runat="server">
                            </tr>
                        </table>
                    </div>
                </div>
                <tr runat="server">
                    <td runat="server" style="">
                        <asp:DataPager ID="DataPager1" runat="server" PageSize="15">
                            <Fields>
                                <asp:NextPreviousPagerField ButtonType="Button" ShowFirstPageButton="True" ShowNextPageButton="False" ShowPreviousPageButton="True" ButtonCssClass="btn btn-info btn-sm" />
                                <asp:NumericPagerField NumericButtonCssClass="label label-success" CurrentPageLabelCssClass="badge"/>
                                <asp:NextPreviousPagerField ButtonType="Button" ShowLastPageButton="True" ShowNextPageButton="True" ShowPreviousPageButton="False" ButtonCssClass="btn btn-info btn-sm" />
                            </Fields>
                        </asp:DataPager>
                    </td>
                </tr>
            </div>
        </LayoutTemplate>
    </asp:ListView>
    <asp:SqlDataSource ID="DataSourceWorker" runat="server" ConnectionString="<%$ ConnectionStrings:ConnString_WEB_ASSET_DB %>" DeleteCommand="DELETE FROM [WORKER] WHERE [WORKERID] = @WORKERID" InsertCommand="INSERT INTO [WORKER] ([WORKERFNAME], [WORKERLNAME], [WORKERDOB], [WORKERADDR], [WORKERSTATUS], [WORKEREMPLOYTYPE], [LABORTYPEID]) VALUES (@WORKERFNAME, @WORKERLNAME, @WORKERDOB, @WORKERADDR, @WORKERSTATUS, @WORKEREMPLOYTYPE, @LABORTYPEID)" SelectCommand="SELECT [WORKERID], [WORKERFNAME], [WORKERLNAME], [WORKERDOB], [WORKERADDR], [WORKERSTATUS], [WORKEREMPLOYTYPE],ASSWORKER, WORKER.LABORTYPEID, LABORTYPE.LABORTYPENAME FROM WORKER INNER JOIN LABORTYPE ON WORKER.LABORTYPEID=LABORTYPE.LABORTYPEID " UpdateCommand="UPDATE [WORKER] SET [WORKERFNAME] = @WORKERFNAME, [WORKERLNAME] = @WORKERLNAME, [WORKERDOB] = @WORKERDOB, [WORKERADDR] = @WORKERADDR, [WORKERSTATUS] = @WORKERSTATUS, [WORKEREMPLOYTYPE] = @WORKEREMPLOYTYPE, [LABORTYPEID] = @LABORTYPEID WHERE [WORKERID] = @WORKERID">
        <DeleteParameters>
            <asp:Parameter Name="WORKERID" Type="Int32" />
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="WORKERFNAME" Type="String" />
            <asp:Parameter Name="WORKERLNAME" Type="String" />
            <asp:Parameter DbType="Date" Name="WORKERDOB" />
            <asp:Parameter Name="WORKERADDR" Type="String" />
            <asp:Parameter Name="WORKERSTATUS" Type="String" />
            <asp:Parameter Name="WORKEREMPLOYTYPE" Type="String" />
            <asp:Parameter Name="LABORTYPEID" Type="Int32" />
        </InsertParameters>
        <UpdateParameters>
            <asp:Parameter Name="WORKERFNAME" Type="String" />
            <asp:Parameter Name="WORKERLNAME" Type="String" />
            <asp:Parameter DbType="Date" Name="WORKERDOB" />
            <asp:Parameter Name="WORKERADDR" Type="String" />
            <asp:Parameter Name="WORKERSTATUS" Type="String" />
            <asp:Parameter Name="WORKEREMPLOYTYPE" Type="String" />
            <asp:Parameter Name="LABORTYPEID" Type="Int32" />
            <asp:Parameter Name="WORKERID" Type="Int32" />
        </UpdateParameters>
    </asp:SqlDataSource>
</asp:Content>

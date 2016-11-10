<%@ Page Title="Trade" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Trade.aspx.cs" Inherits="Construction_Asset_Management_System.Trade" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <h4 class="well text-center" style="padding: 8px">Trade List</h4>
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
    <asp:ListView ID="_listviewTrade" runat="server" DataKeyNames="TRADEID" DataSourceID="DataSourceTrade" OnItemDeleted="_listviewTrade_ItemDeleted">
        <EmptyDataTemplate>
            <table runat="server" style="">
                <tr>
                    <td>No data was returned.</td>
                </tr>
            </table>
        </EmptyDataTemplate>
        <ItemTemplate>
            <tr onclick="window.location.href='<%# System.Web.VirtualPathUtility.ToAbsolute("~/Trade_CRUD.aspx?id=" + Eval("TRADEID"))%>';">
                <td>
                    <asp:Label ID="TRADEIDLabel" runat="server" Text='<%# Eval("TRADEID") %>' />
                </td>
                <td>
                    <asp:Label ID="TRADENAMELabel" runat="server" Text='<%# Eval("TRADENAME") %>' />
                </td>
                <td>
                    <asp:Label ID="LABORTYPEIDLabel" runat="server" Text='<%# Eval("LABORTYPENAME") %>' />
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
                                    <asp:LinkButton ID="LinkButton" CommandArgument="TRADEID" CommandName="Sort" Text="ID" runat="server"></asp:LinkButton>
                                </th>
                                <th runat="server">
                                    <asp:LinkButton ID="LinkButton1" CommandArgument="TRADENAME" CommandName="Sort" Text="Trade" runat="server"></asp:LinkButton>
                                </th>
                                <th runat="server">
                                    <asp:LinkButton ID="LinkButton2" CommandArgument="LABORTYPENAME" CommandName="Sort" Text="Labor Career Type" runat="server"></asp:LinkButton>
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
    <asp:SqlDataSource ID="DataSourceTrade" runat="server" ConnectionString="<%$ ConnectionStrings:ConnString_WEB_ASSET_DB %>" DeleteCommand="DELETE FROM [TRADE] WHERE [TRADEID] = @TRADEID" InsertCommand="INSERT INTO [TRADE] ([TRADENAME], [LABORTYPEID]) VALUES (@TRADENAME, @LABORTYPEID)" SelectCommand="SELECT [TRADEID], [TRADENAME], TRADE.LABORTYPEID, LABORTYPE.LABORTYPENAME FROM TRADE INNER JOIN LABORTYPE ON TRADE.LABORTYPEID=LABORTYPE.LABORTYPEID" UpdateCommand="UPDATE [TRADE] SET [TRADENAME] = @TRADENAME, [LABORTYPEID] = @LABORTYPEID WHERE [TRADEID] = @TRADEID">
        <DeleteParameters>
            <asp:Parameter Name="TRADEID" Type="Int32" />
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="TRADENAME" Type="String" />
            <asp:Parameter Name="LABORTYPEID" Type="Int32" />
        </InsertParameters>
        <UpdateParameters>
            <asp:Parameter Name="TRADENAME" Type="String" />
            <asp:Parameter Name="LABORTYPEID" Type="Int32" />
            <asp:Parameter Name="TRADEID" Type="Int32" />
        </UpdateParameters>
    </asp:SqlDataSource>
</asp:Content>

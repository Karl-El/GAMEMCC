<%@ Page Title="Equipment Category" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="EquipmentCategory.aspx.cs" Inherits="Construction_Asset_Management_System.EquipmentCategory" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <h4 class="well text-center" style="padding: 8px">Equipment Category List</h4>
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
    <asp:ListView ID="_listviewEquipCtgry" runat="server" DataSourceID="DataSourceEquipCtgry" DataKeyNames="EQUIPCTGRYID" OnItemDeleted="_listviewEquipCtgry_ItemDeleted" OnItemDeleting="_listviewEquipCtgry_ItemDeleting">

        <EmptyDataTemplate>
            <table runat="server" style="">
                <tr>
                    <td>No data was returned.</td>
                </tr>
            </table>
        </EmptyDataTemplate>
        <ItemTemplate>
            <tr onclick="window.location.href='<%# System.Web.VirtualPathUtility.ToAbsolute("~/EquipmentCategory_CRUD.aspx?id=" + Eval("EQUIPCTGRYID"))%>';">
                <td>
                    <asp:Label Text='<%# Eval("EQUIPCTGRYID") %>' runat="server" ID="EQUIPCTGRYIDLabel" />
                </td>
                <td>
                    <asp:Label Text='<%# Eval("EQUIPCTGRYNAME") %>' runat="server" ID="EQUIPCTGRYNAMELabel" />
                </td>
                <td>
                    <asp:Label Text='<%# Eval("EQUIPCTGRYDESC") %>' runat="server" ID="EQUIPCTGRYDESCLabel" />
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
                                    <asp:LinkButton ID="LinkButton1" runat="server" CommandArgument="EQUIPCTGRYID" CommandName="Sort" Text="ID"></asp:LinkButton>
                                </th>
                                <th runat="server">
                                    <asp:LinkButton ID="LinkButton2" runat="server" CommandArgument="EQUIPCTGRYNAME" CommandName="Sort" Text="Category Name"></asp:LinkButton>
                                </th>
                                <th runat="server">
                                    <asp:LinkButton ID="LinkButton3" runat="server" CommandArgument="EQUIPCTGRYDESC" CommandName="Sort" Text="Description"></asp:LinkButton>
                                </th>
                                <th runat="server"></th>
                            </tr>
                            <tr runat="server" id="itemPlaceholder"></tr>
                        </table>
                    </div>
                </div>
                <tr runat="server">
                    <td runat="server" style="">
                        <asp:DataPager ID="DataPager1" runat="server" PageSize="15">
                            <Fields>
                                <asp:NextPreviousPagerField ButtonType="Button" ShowFirstPageButton="True" ShowNextPageButton="False" ShowPreviousPageButton="True" ButtonCssClass="btn btn-info btn-sm" />
                                <asp:NumericPagerField NumericButtonCssClass="label label-success" CurrentPageLabelCssClass="badge" />
                                <asp:NextPreviousPagerField ButtonType="Button" ShowLastPageButton="True" ShowNextPageButton="True" ShowPreviousPageButton="False" ButtonCssClass="btn btn-info btn-sm" />
                            </Fields>
                        </asp:DataPager>
                    </td>
                </tr>
            </div>
        </LayoutTemplate>
    </asp:ListView>
    <asp:SqlDataSource runat="server" ID="DataSourceEquipCtgry" ConnectionString='<%$ ConnectionStrings:ConnString_WEB_ASSET_DB %>' DeleteCommand="DELETE FROM [EQUIPCTGRY] WHERE [EQUIPCTGRYID] = @EQUIPCTGRYID" InsertCommand="INSERT INTO [EQUIPCTGRY] ([EQUIPCTGRYNAME], [EQUIPCTGRYDESC]) VALUES (@EQUIPCTGRYNAME, @EQUIPCTGRYDESC)" SelectCommand="SELECT [EQUIPCTGRYID], [EQUIPCTGRYNAME], [EQUIPCTGRYDESC] FROM [EQUIPCTGRY]" UpdateCommand="UPDATE [EQUIPCTGRY] SET [EQUIPCTGRYNAME] = @EQUIPCTGRYNAME, [EQUIPCTGRYDESC] = @EQUIPCTGRYDESC WHERE [EQUIPCTGRYID] = @EQUIPCTGRYID">
        <DeleteParameters>
            <asp:Parameter Name="EQUIPCTGRYID" Type="Int32"></asp:Parameter>
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="EQUIPCTGRYNAME" Type="String"></asp:Parameter>
            <asp:Parameter Name="EQUIPCTGRYDESC" Type="String"></asp:Parameter>
        </InsertParameters>
        <UpdateParameters>
            <asp:Parameter Name="EQUIPCTGRYNAME" Type="String"></asp:Parameter>
            <asp:Parameter Name="EQUIPCTGRYDESC" Type="String"></asp:Parameter>
            <asp:Parameter Name="EQUIPCTGRYID" Type="Int32"></asp:Parameter>
        </UpdateParameters>
    </asp:SqlDataSource>
</asp:Content>

<%@ Page Title="Equipment" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Equipment.aspx.cs" Inherits="Construction_Asset_Management_System.Equipment" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <h4 class="well text-center" style="padding: 8px">Equipment List</h4>
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
    <asp:ListView ID="_listviewEquipment" runat="server" DataSourceID="DataSourceEquipment" DataKeyNames="EQUIPMENTID" OnItemDeleted="_listviewEquipment_ItemDeleted">

        <EmptyDataTemplate>
            <table runat="server" style="">
                <tr>
                    <td>No data was returned.</td>
                </tr>
            </table>
        </EmptyDataTemplate>
        <ItemTemplate>
            <tr onclick="window.location.href='<%# System.Web.VirtualPathUtility.ToAbsolute("~/Equipment_CRUD.aspx?id=" + Eval("EQUIPMENTID"))%>';">
                <td>
                    <asp:Label Text='<%# Eval("EQUIPMENTID") %>' runat="server" ID="EQUIPMENTIDLabel" /></td>
                <td>
                    <asp:Label Text='<%# Eval("EQUIPMENTNAME") %>' runat="server" ID="EQUIPMENTNAMELabel" /></td>
                <td>
                    <asp:Label Text='<%# Eval("EQUIPMENTDESC") %>' runat="server" ID="EQUIPMENTDESCLabel" /></td>
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
                                    <asp:LinkButton ID="LinkButton1" CommandArgument="EQUIPMENTID" CommandName="Sort" Text="ID" runat="server"></asp:LinkButton>
                                </th>
                                <th runat="server">
                                    <asp:LinkButton ID="LinkButton2" CommandArgument="EQUIPMENTNAME" CommandName="Sort" Text="Equipment Name" runat="server"></asp:LinkButton>
                                </th>
                                <th runat="server">
                                    <asp:LinkButton ID="LinkButton3" CommandArgument="EQUIPMENTDESC" CommandName="Sort" Text="Description" runat="server"></asp:LinkButton>
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
                                <asp:NumericPagerField NumericButtonCssClass="label label-success" CurrentPageLabelCssClass="badge"/>
                                <asp:NextPreviousPagerField ButtonType="Button" ShowLastPageButton="True" ShowNextPageButton="True" ShowPreviousPageButton="False" ButtonCssClass="btn btn-info btn-sm" />
                            </Fields>
                        </asp:DataPager>
                    </td>
                </tr>
            </div>
        </LayoutTemplate>
        <SelectedItemTemplate>
            <tr style="">
                <td>
                    <asp:Button runat="server" CommandName="Delete" Text="Delete" ID="DeleteButton" />
                </td>
                <td>
                    <asp:Label Text='<%# Eval("EQUIPMENTID") %>' runat="server" ID="EQUIPMENTIDLabel" /></td>
                <td>
                    <asp:Label Text='<%# Eval("EQUIPMENTNAME") %>' runat="server" ID="EQUIPMENTNAMELabel" /></td>
                <td>
                    <asp:Label Text='<%# Eval("EQUIPMENTDESC") %>' runat="server" ID="EQUIPMENTDESCLabel" /></td>
            </tr>
        </SelectedItemTemplate>
    </asp:ListView>
    <asp:SqlDataSource runat="server" ID="DataSourceEquipment" ConnectionString='<%$ ConnectionStrings:ConnString_WEB_ASSET_DB %>' DeleteCommand="DELETE FROM [EQUIPMENT] WHERE [EQUIPMENTID] = @EQUIPMENTID" InsertCommand="INSERT INTO [EQUIPMENT] ([EQUIPMENTNAME], [EQUIPMENTDESC]) VALUES (@EQUIPMENTNAME, @EQUIPMENTDESC)" SelectCommand="SELECT [EQUIPMENTID], [EQUIPMENTNAME], [EQUIPMENTDESC] FROM [EQUIPMENT]" UpdateCommand="UPDATE [EQUIPMENT] SET [EQUIPMENTNAME] = @EQUIPMENTNAME, [EQUIPMENTDESC] = @EQUIPMENTDESC WHERE [EQUIPMENTID] = @EQUIPMENTID">
        <DeleteParameters>
            <asp:Parameter Name="EQUIPMENTID" Type="Int32"></asp:Parameter>
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="EQUIPMENTNAME" Type="String"></asp:Parameter>
            <asp:Parameter Name="EQUIPMENTDESC" Type="String"></asp:Parameter>
        </InsertParameters>
        <UpdateParameters>
            <asp:Parameter Name="EQUIPMENTNAME" Type="String"></asp:Parameter>
            <asp:Parameter Name="EQUIPMENTDESC" Type="String"></asp:Parameter>
            <asp:Parameter Name="EQUIPMENTID" Type="Int32"></asp:Parameter>
        </UpdateParameters>
    </asp:SqlDataSource>
</asp:Content>

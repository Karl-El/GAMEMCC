<%@ Page Title="Client" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Client.aspx.cs" Inherits="Construction_Asset_Management_System.Client" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <h4 class="well text-center" style="padding: 8px">Client List</h4>
    <div class="row text-center">
        <div class="col-sm-12 form-inline">
            <div class="input-group">
                <asp:TextBox ID="_txtSearch" runat="server" CssClass="form-control" />
                <span class="input-group-btn">
                    <asp:LinkButton runat="server" ID="_btnSearch" CssClass="btn btn-info" OnClick="_btnSearch_Click"><span class="glyphicon glyphicon-search"></span> Search</asp:LinkButton>
                </span>
            </div>
            <asp:LinkButton runat="server" ID="_btnAdd" CssClass="btn btn-info " OnClick="_btnAdd_Click"><span class="glyphicon glyphicon-plus"></span> Add</asp:LinkButton>
            <asp:LinkButton runat="server"  ID="_btnShowList" CssClass="btn btn-info" OnClick="_btnShowList_Click" Visible="false"><span class="glyphicon glyphicon-list-alt"></span> Show Full List</asp:LinkButton>
        </div>
    </div>
    <br />
    <asp:ListView ID="_listviewClient" runat="server" DataKeyNames="CLIENTID" DataSourceID="DataSourceClient" OnItemDeleted="_listviewClient_ItemDeleted" OnItemDeleting="_listviewClient_ItemDeleting">

        <EmptyDataTemplate>
            <table runat="server" style="">
                <tr>
                    <td>No data was returned.</td>
                </tr>
            </table>
        </EmptyDataTemplate>

        <ItemTemplate>
            <tr onclick="window.location.href='<%# System.Web.VirtualPathUtility.ToAbsolute("~/Client_CRUD.aspx?id=" + Eval("CLIENTID"))%>';">
                <td>
                    <asp:Label ID="CLIENTIDLabel" runat="server" Text='<%# Eval("CLIENTID") %>' />
                </td>
                <td>
                    <asp:Label ID="CLIENTNAMELabel" runat="server" Text='<%# Eval("CLIENTNAME") %>' />
                </td>
                <td>
                    <asp:Label ID="CLIENTADDRLabel" runat="server" Text='<%# Eval("CLIENTADDR") %>' />
                </td>
                <td>
                    <asp:Label ID="CLIENTCELLLabel" runat="server" Text='<%# Eval("CLIENTCELL") %>' />
                </td>
                <td>
                    <asp:Label ID="CLIENTTELLabel" runat="server" Text='<%# Eval("CLIENTTEL") %>' />
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
                            <thead>
                                <tr runat="server" style="" class="info">
                                    <th runat="server">
                                        <asp:LinkButton ID="_linkbtnClientID" CommandArgument="CLIENTID" CommandName="Sort" Text="ID" runat="server"></asp:LinkButton>
                                    </th>
                                    <th runat="server">
                                        <asp:LinkButton ID="_linkbtnClientName" CommandArgument="CLIENTNAME" CommandName="Sort" Text="Company/ Business Name" runat="server"></asp:LinkButton>
                                    </th>
                                    <th runat="server">
                                        <asp:LinkButton ID="_linkbtnClientAdd" CommandArgument="CLIENTADDR" CommandName="Sort" Text="Address" runat="server"></asp:LinkButton>
                                    </th>
                                    <th runat="server">
                                        <asp:LinkButton ID="_linkbtnClientCell" CommandArgument="CLIENTCELL" CommandName="Sort" Text="Company/ Business Cellphone" runat="server"></asp:LinkButton>
                                    </th>
                                    <th runat="server">
                                        <asp:LinkButton ID="_linkbtnClientTele" CommandArgument="CLIENTTEL" CommandName="Sort" Text="Company/ Business Telephone" runat="server"></asp:LinkButton>
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
    <asp:SqlDataSource ID="DataSourceClient" runat="server" ConnectionString="<%$ ConnectionStrings:ConnString_WEB_ASSET_DB %>" DeleteCommand="DELETE FROM [CLIENT] WHERE [CLIENTID] = @CLIENTID" InsertCommand="INSERT INTO [CLIENT] ([CLIENTNAME], [CLIENTADDR], [CLIENTCELL], [CLIENTTEL]) VALUES (@CLIENTNAME, @CLIENTADDR, @CLIENTCELL, @CLIENTTEL)" SelectCommand="SELECT [CLIENTNAME], [CLIENTADDR], [CLIENTCELL], [CLIENTTEL], [CLIENTID] FROM [CLIENT]" UpdateCommand="UPDATE [CLIENT] SET [CLIENTNAME] = @CLIENTNAME, [CLIENTADDR] = @CLIENTADDR, [CLIENTCELL] = @CLIENTCELL, [CLIENTTEL] = @CLIENTTEL WHERE [CLIENTID] = @CLIENTID">
        <DeleteParameters>
            <asp:Parameter Name="CLIENTID" Type="Int32" />
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="CLIENTNAME" Type="String" />
            <asp:Parameter Name="CLIENTADDR" Type="String" />
            <asp:Parameter Name="CLIENTCELL" Type="String" />
            <asp:Parameter Name="CLIENTTEL" Type="String" />
        </InsertParameters>
        <UpdateParameters>
            <asp:Parameter Name="CLIENTNAME" Type="String" />
            <asp:Parameter Name="CLIENTADDR" Type="String" />
            <asp:Parameter Name="CLIENTCELL" Type="String" />
            <asp:Parameter Name="CLIENTTEL" Type="String" />
            <asp:Parameter Name="CLIENTID" Type="Int32" />
        </UpdateParameters>
    </asp:SqlDataSource>
</asp:Content>

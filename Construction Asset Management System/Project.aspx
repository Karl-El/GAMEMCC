<%@ Page Title="Project" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Project.aspx.cs" Inherits="Construction_Asset_Management_System.datasetProject" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <h4 class="well text-center" style="padding: 8px">Project List</h4>
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
    <asp:ListView ID="_listviewProject" runat="server" DataKeyNames="PROJID" DataSourceID="DataSourceProject">
        <EmptyDataTemplate>
            <table runat="server" style="">
                <tr>
                    <td>No data was returned.</td>
                </tr>
            </table>
        </EmptyDataTemplate>
        <ItemTemplate>
            <tr onclick="window.location.href='<%# System.Web.VirtualPathUtility.ToAbsolute("~/Project_CRUD.aspx?id=" + Eval("PROJID"))%>';">
                <td>
                    <asp:Label ID="PROJIDLabel" runat="server" Text='<%# Eval("PROJID") %>' />
                </td>
                <td>
                    <asp:Label ID="PROJNAMELabel" runat="server" Text='<%# Eval("PROJNAME") %>' />
                </td>
                <td>
                    <asp:Label ID="PROJSITELabel" runat="server" Text='<%# Eval("PROJSITE") %>' />
                </td>
                <td>
                    <asp:Label ID="CLIENTIDLabel" runat="server" Text='<%# Eval("CLIENTNAME") %>' />
                </td>
                <td onclick="return confirm('Are you sure to delete?')">
                    <asp:LinkButton ID="LinkButton1" runat="server" CommandName="Delete" Text="Delete" CssClass="btn btn-danger"><span class="glyphicon glyphicon-trash"></span></asp:LinkButton>
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
                                    <asp:LinkButton ID="LinkButton1" CommandArgument="PROJID" CommandName="Sort" Text="ID" runat="server"></asp:LinkButton>
                                </th>
                                <th runat="server">
                                    <asp:LinkButton ID="LinkButton2" CommandArgument="PROJNAME" CommandName="Sort" Text="Project Name" runat="server"></asp:LinkButton>
                                </th>
                                <th runat="server">
                                    <asp:LinkButton ID="LinkButton3" CommandArgument="PROJSITE" CommandName="Sort" Text="Site" runat="server"></asp:LinkButton>
                                </th>
                                <th runat="server">
                                    <asp:LinkButton ID="LinkButton4" CommandArgument="CLIENTNAME" CommandName="Sort" Text="Client/Company/Business Name" runat="server"></asp:LinkButton>
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
                        <asp:DataPager ID="DataPager1" runat="server">
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
    <asp:SqlDataSource ID="DataSourceProject" runat="server" ConnectionString="<%$ ConnectionStrings:ConnString_WEB_ASSET_DB %>" DeleteCommand="DELETE FROM [PROJECT] WHERE [PROJID] = @PROJID" InsertCommand="INSERT INTO [PROJECT] ([PROJNAME], [PROJSITE], [CLIENTID]) VALUES (@PROJNAME, @PROJSITE, @CLIENTID)" SelectCommand="SELECT [PROJID], [PROJNAME], [PROJSITE], PROJECT.CLIENTID, CLIENT.CLIENTNAME FROM [PROJECT] INNER JOIN CLIENT ON CLIENT.CLIENTID=PROJECT.CLIENTID " UpdateCommand="UPDATE [PROJECT] SET [PROJNAME] = @PROJNAME, [PROJSITE] = @PROJSITE, [CLIENTID] = @CLIENTID WHERE [PROJID] = @PROJID">
        <DeleteParameters>
            <asp:Parameter Name="PROJID" Type="Int32" />
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="PROJNAME" Type="String" />
            <asp:Parameter Name="PROJSITE" Type="String" />
            <asp:Parameter Name="CLIENTID" Type="Int32" />
        </InsertParameters>
        <UpdateParameters>
            <asp:Parameter Name="PROJNAME" Type="String" />
            <asp:Parameter Name="PROJSITE" Type="String" />
            <asp:Parameter Name="CLIENTID" Type="Int32" />
            <asp:Parameter Name="PROJID" Type="Int32" />
        </UpdateParameters>
    </asp:SqlDataSource>
</asp:Content>

<%@ Page Title="Company Staff" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="CompanyStaff.aspx.cs" Inherits="Construction_Asset_Management_System.CompanyStaff" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <h4 class="well text-center" style="padding: 8px">Company Staff List</h4>
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
    <asp:ListView ID="_listviewCompanyStaff" runat="server" DataKeyNames="COMSTAFFID" DataSourceID="DataSourceCompanyStaff" OnItemDeleted="_listviewCompanyStaff_ItemDeleted" OnItemDeleting="_listviewCompanyStaff_ItemDeleting">
        <EmptyDataTemplate>
            <table runat="server" style="">
                <tr>
                    <td>No data was returned.</td>
                </tr>
            </table>
        </EmptyDataTemplate>
        <ItemTemplate>
            <tr onclick="window.location.href='<%# System.Web.VirtualPathUtility.ToAbsolute("~/CompanyStaff_CRUD.aspx?id=" + Eval("COMSTAFFID"))%>';">
                <td>
                    <asp:Label ID="COMSTAFFIDLabel" runat="server" Text='<%# Eval("COMSTAFFID") %>' />
                </td>
                <td>
                    <asp:Label ID="COMSTAFFFRSTNAMELabel" runat="server" Text='<%# Eval("COMSTAFFFRSTNAME") %>' />
                </td>
                <td>
                    <asp:Label ID="COMSTAFFLASTNAMELabel" runat="server" Text='<%# Eval("COMSTAFFLASTNAME") %>' />
                </td>
                <td>
                    <asp:Label ID="COMSTAFFPOSITIONLabel" runat="server" Text='<%# Eval("COMSTAFFPOSITION") %>' />
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
                                    <asp:LinkButton ID="LinkButton1" CommandArgument="COMSTAFFID" CommandName="Sort" Text="ID" runat="server"></asp:LinkButton>
                                </th>
                                <th runat="server">
                                    <asp:LinkButton ID="LinkButton2" CommandArgument="COMSTAFFFRSTNAME" CommandName="Sort" Text="First Name" runat="server"></asp:LinkButton>
                                </th>
                                <th runat="server">
                                    <asp:LinkButton ID="LinkButton3" CommandArgument="COMSTAFFLASTNAME" CommandName="Sort" Text="Last Name" runat="server"></asp:LinkButton>
                                </th>
                                <th runat="server">
                                    <asp:LinkButton ID="LinkButton4" CommandArgument="COMSTAFFPOSITION" CommandName="Sort" Text="Position" runat="server"></asp:LinkButton>
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
    <asp:SqlDataSource ID="DataSourceCompanyStaff" runat="server" ConnectionString="<%$ ConnectionStrings:ConnString_WEB_ASSET_DB %>" DeleteCommand="DELETE FROM [COMPANYSTAFF] WHERE [COMSTAFFID] = @COMSTAFFID" InsertCommand="INSERT INTO [COMPANYSTAFF] ([COMSTAFFFRSTNAME], [COMSTAFFLASTNAME], [COMSTAFFPOSITION]) VALUES (@COMSTAFFFRSTNAME, @COMSTAFFLASTNAME, @COMSTAFFPOSITION)" SelectCommand="SELECT [COMSTAFFID], [COMSTAFFFRSTNAME], [COMSTAFFLASTNAME], [COMSTAFFPOSITION] FROM [COMPANYSTAFF]" UpdateCommand="UPDATE [COMPANYSTAFF] SET [COMSTAFFFRSTNAME] = @COMSTAFFFRSTNAME, [COMSTAFFLASTNAME] = @COMSTAFFLASTNAME, [COMSTAFFPOSITION] = @COMSTAFFPOSITION WHERE [COMSTAFFID] = @COMSTAFFID">
        <DeleteParameters>
            <asp:Parameter Name="COMSTAFFID" Type="Int32" />
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="COMSTAFFFRSTNAME" Type="String" />
            <asp:Parameter Name="COMSTAFFLASTNAME" Type="String" />
            <asp:Parameter Name="COMSTAFFPOSITION" Type="String" />
        </InsertParameters>
        <UpdateParameters>
            <asp:Parameter Name="COMSTAFFFRSTNAME" Type="String" />
            <asp:Parameter Name="COMSTAFFLASTNAME" Type="String" />
            <asp:Parameter Name="COMSTAFFPOSITION" Type="String" />
            <asp:Parameter Name="COMSTAFFID" Type="Int32" />
        </UpdateParameters>
    </asp:SqlDataSource>
</asp:Content>

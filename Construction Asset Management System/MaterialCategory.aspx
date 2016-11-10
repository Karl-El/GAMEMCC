<%@ Page Title="Material Category" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="MaterialCategory.aspx.cs" Inherits="Construction_Asset_Management_System.MaterialCategory" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <h4 class="well text-center" style="padding: 8px">Material Category List</h4>
    <<div class="row text-center">
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
    <asp:ListView ID="_listviewMtrlCtgry" runat="server" DataSourceID="DataSourceMaterialCtgry" DataKeyNames="MATERIALCTGRYID" OnItemDeleted="_listviewMtrlCtgry_ItemDeleted">

        <EmptyDataTemplate>
                <table runat="server" style="">
                    <tr>
                        <td>No data was returned.</td>
                    </tr>
                </table>
            </div>
        </EmptyDataTemplate>
        <ItemTemplate>
            <tr onclick="window.location.href='<%# System.Web.VirtualPathUtility.ToAbsolute("~/MaterialCategory_CRUD.aspx?id=" + Eval("MATERIALCTGRYID"))%>';">
                <td>
                    <asp:Label ID="MATERIALCTGRYIDLabel" runat="server" Text='<%# Eval("MATERIALCTGRYID") %>' />
                </td>
                <td>
                    <asp:Label ID="MATERIALCTGRYNAMELabel" runat="server" Text='<%# Eval("MATERIALCTGRYNAME") %>' />
                </td>
                <td>
                    <asp:Label ID="MATERIALCTGRYDESCLabel" runat="server" Text='<%# Eval("MATERIALCTGRYDESC") %>' />
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
                                        <asp:LinkButton ID="_linkbtnMatCatID" CommandArgument="MATERIALCTGRYID" CommandName="Sort" Text="ID" runat="server"></asp:LinkButton>
                                    </th>
                                    <th runat="server">
                                        <asp:LinkButton ID="_linkbtnMatCatName" CommandArgument="MATERIALCTGRYNAME" CommandName="Sort" Text="Category Name" runat="server"></asp:LinkButton>
                                    </th>
                                    <th runat="server">
                                        <asp:LinkButton ID="_linkbtnMatCatDesc" CommandArgument="MATERIALCTGRYDESC" CommandName="Sort" Text="Description" runat="server"></asp:LinkButton></th>
                                    <th runat="server"></th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr id="itemPlaceholder" runat="server">
                                </tr>
                            </tbody>
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
    <asp:SqlDataSource ID="DataSourceMaterialCtgry" runat="server" ConnectionString="<%$ ConnectionStrings:ConnString_WEB_ASSET_DB %>" DeleteCommand="DELETE FROM [MATERIALCTGRY] WHERE [MATERIALCTGRYID] = @MATERIALCTGRYID" InsertCommand="INSERT INTO [MATERIALCTGRY] ([MATERIALCTGRYNAME], [MATERIALCTGRYDESC]) VALUES (@MATERIALCTGRYNAME, @MATERIALCTGRYDESC)" SelectCommand="SELECT * FROM [MATERIALCTGRY]" UpdateCommand="UPDATE [MATERIALCTGRY] SET [MATERIALCTGRYNAME] = @MATERIALCTGRYNAME, [MATERIALCTGRYDESC] = @MATERIALCTGRYDESC WHERE [MATERIALCTGRYID] = @MATERIALCTGRYID">
        <DeleteParameters>
            <asp:Parameter Name="MATERIALCTGRYID" Type="Int32" />
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="MATERIALCTGRYNAME" Type="String" />
            <asp:Parameter Name="MATERIALCTGRYDESC" Type="String" />
        </InsertParameters>
        <UpdateParameters>
            <asp:Parameter Name="MATERIALCTGRYNAME" Type="String" />
            <asp:Parameter Name="MATERIALCTGRYDESC" Type="String" />
            <asp:Parameter Name="MATERIALCTGRYID" Type="Int32" />
        </UpdateParameters>
    </asp:SqlDataSource>

</asp:Content>

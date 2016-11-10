<%@ Page Title="Client Staff" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ClientStaff.aspx.cs" Inherits="Construction_Asset_Management_System.ClientStaff" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <h4 class="well text-center" style="padding: 8px">Client Staff List</h4>
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
    <asp:ListView ID="_listviewClientStaff" runat="server" DataKeyNames="CLIENTSTAFFID" DataSourceID="DataSourceClientStaff" OnItemDeleted="_listviewClientStaff_ItemDeleted" OnItemDeleting="_listviewClientStaff_ItemDeleting">


        <EmptyDataTemplate>
            <table runat="server" style="">
                <tr>
                    <td>No data was returned.</td>
                </tr>
            </table>
        </EmptyDataTemplate>

        <ItemTemplate>
            <tr onclick="window.location.href='<%# System.Web.VirtualPathUtility.ToAbsolute("~/ClientStaff_CRUD.aspx?id=" + Eval("CLIENTSTAFFID"))%>';">
                <td>
                    <asp:Label ID="CLIENTSTAFFIDLabel" runat="server" Text='<%# Eval("CLIENTSTAFFID") %>' />
                </td>
                <td>
                    <asp:Label ID="CLIENTSTAFFFNAMELabel" runat="server" Text='<%# Eval("CLIENTSTAFFFNAME") %>' />
                </td>
                <td>
                    <asp:Label ID="CLIENTSTAFFLNAMELabel" runat="server" Text='<%# Eval("CLIENTSTAFFLNAME") %>' />
                </td>
                <td>
                    <asp:Label ID="CLIENTSTAFFTELLabel" runat="server" Text='<%# Eval("CLIENTSTAFFTEL") %>' />
                </td>
                <td>
                    <asp:Label ID="CLIENTSTAFFCELLLabel" runat="server" Text='<%# Eval("CLIENTSTAFFCELL") %>' />
                </td>
                <td>
                    <asp:Label ID="CLIENTSTAFFSTATUSLabel" runat="server" Text='<%# Eval("CLIENTSTAFFSTATUS") %>' />
                </td>
                <td>
                    <asp:Label ID="CLIENTIDLabel" runat="server" Text='<%# Eval("CLIENTNAME") %>' />
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
                                    <asp:LinkButton ID="_linkbtnClientStaffID" CommandArgument="CLIENTSTAFFID" CommandName="Sort" Text="ID" runat="server"></asp:LinkButton>
                                </th>
                                <th runat="server">
                                    <asp:LinkButton ID="_linkbtnClientStaffFirstName" CommandArgument="CLIENTSTAFFFNAME" CommandName="Sort" Text="First Name" runat="server"></asp:LinkButton>
                                </th>
                                <th runat="server">
                                    <asp:LinkButton ID="_linkbtnClientStaffLastName" CommandArgument="CLIENTSTAFFLNAME" CommandName="Sort" Text="Last Name" runat="server"></asp:LinkButton>
                                </th>
                                <th runat="server">
                                    <asp:LinkButton ID="_linkbtnClientStaffTele" CommandArgument="CLIENTSTAFFTEL" CommandName="Sort" Text="Telephone" runat="server"></asp:LinkButton>
                                </th>
                                <th runat="server">
                                    <asp:LinkButton ID="_linkbtnClientStaffCell" CommandArgument="CLIENTSTAFFCELL" CommandName="Sort" Text="Cellphone" runat="server"></asp:LinkButton>
                                </th>
                                <th runat="server">
                                    <asp:LinkButton ID="_linkbtnClientStaffStat" CommandArgument="CLIENTSTAFFSTATUS" CommandName="Sort" Text="Status" runat="server"></asp:LinkButton>
                                </th>
                                <th runat="server">
                                    <asp:LinkButton ID="_linkbtnClientStaffCompany" CommandArgument="CLIENTID" CommandName="Sort" Text="Company/ Business" runat="server"></asp:LinkButton>
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
    <asp:SqlDataSource ID="DataSourceClientStaff" runat="server" ConnectionString="<%$ ConnectionStrings:ConnString_WEB_ASSET_DB %>" DeleteCommand="DELETE FROM [CLIENTSTAFF] WHERE [CLIENTSTAFFID] = @CLIENTSTAFFID" InsertCommand="INSERT INTO [CLIENTSTAFF] ([CLIENTSTAFFFNAME], [CLIENTSTAFFLNAME], [CLIENTSTAFFTEL], [CLIENTSTAFFCELL], [CLIENTSTAFFSTATUS], [CLIENTID]) VALUES (@CLIENTSTAFFFNAME, @CLIENTSTAFFLNAME, @CLIENTSTAFFTEL, @CLIENTSTAFFCELL, @CLIENTSTAFFSTATUS, @CLIENTID)" SelectCommand="SELECT [CLIENTSTAFFID], [CLIENTSTAFFFNAME], [CLIENTSTAFFLNAME], [CLIENTSTAFFTEL], [CLIENTSTAFFCELL], [CLIENTSTAFFSTATUS], CLIENTSTAFF.CLIENTID, CLIENT.CLIENTNAME  FROM CLIENTSTAFF INNER JOIN CLIENT ON CLIENTSTAFF.CLIENTID = CLIENT.CLIENTID" UpdateCommand="UPDATE [CLIENTSTAFF] SET [CLIENTSTAFFFNAME] = @CLIENTSTAFFFNAME, [CLIENTSTAFFLNAME] = @CLIENTSTAFFLNAME, [CLIENTSTAFFTEL] = @CLIENTSTAFFTEL, [CLIENTSTAFFCELL] = @CLIENTSTAFFCELL, [CLIENTSTAFFSTATUS] = @CLIENTSTAFFSTATUS, [CLIENTID] = @CLIENTID WHERE [CLIENTSTAFFID] = @CLIENTSTAFFID">
        <DeleteParameters>
            <asp:Parameter Name="CLIENTSTAFFID" Type="Int32" />
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="CLIENTSTAFFFNAME" Type="String" />
            <asp:Parameter Name="CLIENTSTAFFLNAME" Type="String" />
            <asp:Parameter Name="CLIENTSTAFFTEL" Type="String" />
            <asp:Parameter Name="CLIENTSTAFFCELL" Type="String" />
            <asp:Parameter Name="CLIENTSTAFFSTATUS" Type="String" />
            <asp:Parameter Name="CLIENTID" Type="Int32" />
        </InsertParameters>
        <UpdateParameters>
            <asp:Parameter Name="CLIENTSTAFFFNAME" Type="String" />
            <asp:Parameter Name="CLIENTSTAFFLNAME" Type="String" />
            <asp:Parameter Name="CLIENTSTAFFTEL" Type="String" />
            <asp:Parameter Name="CLIENTSTAFFCELL" Type="String" />
            <asp:Parameter Name="CLIENTSTAFFSTATUS" Type="String" />
            <asp:Parameter Name="CLIENTID" Type="Int32" />
            <asp:Parameter Name="CLIENTSTAFFID" Type="Int32" />
        </UpdateParameters>
    </asp:SqlDataSource>
</asp:Content>

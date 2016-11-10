<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="MaterialStash_CRUD.aspx.cs" Inherits="Construction_Asset_Management_System.MaterialStash_CRUD" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <hr />

    <div class="well">
        <div class="pull-right form-inline">
            <div class="form-group">
                <input type="button" value="Add Stock" onclick="window.location = 'Material_Stock.aspx';" class="btn btn-info" />
            </div>
        </div>
        <h3>Materials Stash</h3>
        <asp:ListView ID="ListView1" runat="server" DataKeyNames="MATERIALID" DataSourceID="DataSourceMaterialStashListView">
            <EmptyDataTemplate>
                <table runat="server" style="">
                    <tr>
                        <td>No data was returned.</td>
                    </tr>
                </table>
            </EmptyDataTemplate>
            <ItemTemplate>
                <tr style="">
                    <%-- <td>
                        <asp:Label ID="MATERIALIDLabel" runat="server" Text='<%# Eval("MATERIALID") %>' />
                    </td>--%>
                    <td>
                        <asp:Label ID="MATERIALNAMELabel" runat="server" Text='<%# Eval("MATERIALNAME") %>' />
                    </td>
                    <td>
                        <asp:Label ID="Label1" runat="server" Text='<%# Eval("MATERIALCTGRYNAME") %>' />
                    </td>
                    <td>
                        <asp:TextBox ID="Textbox1" runat="server" CssClass="form-control input-sm" Enabled="false" />
                    </td>
                    <td>
                        <asp:TextBox ID="Textbox2" runat="server" CssClass="form-control input-sm" Enabled="false" />
                    </td>
                    <td>
                        <asp:TextBox ID="Textbox3" runat="server" CssClass="form-control input-sm" Enabled="false" />
                    </td>
                </tr>
            </ItemTemplate>
            <LayoutTemplate>
                <div runat="server" class="table-responsive">
                    <div runat="server">
                        <div runat="server">
                            <table id="itemPlaceholderContainer" runat="server" border="0" style="" class="table">
                                <tr runat="server" style="" class="info">
                                    <%--<th runat="server">MATERIALID</th>--%>
                                    <th runat="server">Material Name</th>
                                    <th runat="server">Category</th>
                                    <th runat="server" class="col-sm-1">Total No. of Stock</th>
                                    <th runat="server" class="col-sm-1">In Use</th>
                                    <th runat="server" class="col-sm-1">Remaining</th>
                                </tr>
                                <tr id="itemPlaceholder" runat="server">
                                </tr>
                            </table>
                        </div>
                    </div>
                    <tr runat="server">
                        <td runat="server" style=""></td>
                    </tr>
                </div>
            </LayoutTemplate>
        </asp:ListView>
        <asp:SqlDataSource ID="DataSourceMaterialStashListView" runat="server" ConnectionString="<%$ ConnectionStrings:ConnString_WEB_ASSET_DB %>" SelectCommand="SELECT [MATERIALID], [MATERIALNAME], MATERIALCTGRY.MATERIALCTGRYNAME FROM [MATERIAL] JOIN  MATERIALCTGRY ON MATERIALCTGRY.MATERIALCTGRYID = MATERIAL.MATERIALCTGRYID"></asp:SqlDataSource>
    </div>
    <div id="_modalMaterialStock" class="modal fade " role="dialog">
        <div class="modal-dialog">

            <!-- Modal content-->
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Material Stock</h4>
                </div>
                <div class="modal-body">
                    <div class="form-horizontal row">
                        <asp:Label ID="Label2" runat="server" Text="Label" CssClass="control-label">Material Category:</asp:Label>
                        <asp:DropDownList ID="DropDownList1" runat="server" AppendDataBoundItems="True" AutoPostBack="True" CssClass="form-control" DataSourceID="SqlDataSource1" DataTextField="MATERIALCTGRYNAME" DataValueField="MATERIALCTGRYID">
                            <asp:ListItem Value="0">-- please select a Category</asp:ListItem>
                        </asp:DropDownList>
                        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ConnString_WEB_ASSET_DB %>" SelectCommand="SELECT [MATERIALCTGRYID], [MATERIALCTGRYNAME] FROM [MATERIALCTGRY]"></asp:SqlDataSource>
                    </div>
                    <div class="row">
                        <asp:ListView ID="ListView2" runat="server" DataSourceID="SourceMaterialStockListView">
                            <EmptyDataTemplate>
                                <table runat="server" style="">
                                    <tr>
                                        <td>No data was returned.</td>
                                    </tr>
                                </table>
                            </EmptyDataTemplate>
                            <ItemTemplate>
                                <tr style="">
                                    <td>
                                        <asp:Label ID="MATERIALNAMELabel" runat="server" Text='<%# Eval("MATERIALNAME") %>' />
                                    </td>
                                    <td>
                                        <asp:TextBox ID="Textbox1" runat="server" CssClass="form-control"/>
                                    </td>
                                </tr>
                            </ItemTemplate>
                            <LayoutTemplate>
                                <div runat="server" class="table-responsive">
                                    <div runat="server">
                                        <div runat="server">
                                            <table id="itemPlaceholderContainer" runat="server" border="0" style="" class="table">
                                                <tr runat="server" style="">
                                                    <th runat="server">Material Name</th>
                                                    <th runat="server">Stock Count</th>
                                                </tr>
                                                <tr id="itemPlaceholder" runat="server">
                                                </tr>
                                            </table>
                                        </div>
                                    </div>
                                    <tr runat="server">
                                        <td runat="server" style=""></td>
                                    </tr>
                                </div>
                            </LayoutTemplate>
                        </asp:ListView>
                        <asp:SqlDataSource ID="SourceMaterialStockListView" runat="server" ConnectionString="<%$ ConnectionStrings:ConnString_WEB_ASSET_DB %>" SelectCommand="SELECT [MATERIALNAME] FROM [MATERIAL] WHERE ([MATERIALCTGRYID] = @MATERIALCTGRYID)">
                            <SelectParameters>
                                <asp:ControlParameter ControlID="DropDownList1" Name="MATERIALCTGRYID" PropertyName="SelectedValue" Type="Int32" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                </div>
            </div>
        </div>
    </div>
</asp:Content>

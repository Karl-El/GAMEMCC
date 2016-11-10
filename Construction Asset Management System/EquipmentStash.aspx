<%@ Page Title="Equipment Stash" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="EquipmentStash.aspx.cs" Inherits="Construction_Asset_Management_System.EquipmentStash" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <script src="Scripts/Form Validator/jquery.form-validator.js"></script>
    <link href="Scripts/Form Validator/theme-default.css" rel="stylesheet" type="text/css" />
    <h4 class="well text-center" style="padding: 8px">Equipment Stash</h4>
    <div class="row text-center">
        <div class="col-sm-12 form-inline">
            <div class="input-group">
                <asp:TextBox ID="_txtSearch" runat="server" CssClass="form-control" />
                <span class="input-group-btn">
                    <asp:LinkButton runat="server" ID="_btnSearch" CssClass="btn btn-info" OnClick="_btnSearch_Click"><span class="glyphicon glyphicon-search"></span> Search</asp:LinkButton>
                </span>
            </div>
            <asp:LinkButton runat="server" ID="_btnAdd" CssClass="btn btn-info " OnClick="_btnAdd_Click"><span class="glyphicon glyphicon-plus"></span> Add New Equipment</asp:LinkButton>
            <asp:LinkButton runat="server" ID="_btnShowList" CssClass="btn btn-info" OnClick="_btnShowList_Click" Visible="false"><span class="glyphicon glyphicon-list-alt"></span> Show Full List</asp:LinkButton>
            <input type="button" value="Equipment with Projects" onclick="window.location = 'EquipmentProject.aspx';" class="btn btn-warning" />
        </div>
    </div>
    <br />
    <asp:ListView ID="_listviewEquipmentStash" runat="server" DataSourceID="DataSourceEquipmentStash" DataKeyNames="EQUIPMENTID" OnItemUpdating="_listviewEquipmentStash_ItemUpdating" OnItemDataBound="_listviewEquipmentStash_ItemDataBound" OnPreRender="_listviewEquipmentStash_PreRender">

        <%--<AlternatingItemTemplate>
            <tr style="">
                <td>
                    <asp:Button runat="server" CommandName="Edit" Text="Edit" ID="EditButton" />
                </td>
                <td>
                    <asp:Label Text='<%# Eval("EQUIPMENTID") %>' runat="server" ID="EQUIPMENTIDLabel" /></td>
                <td>
                    <asp:Label Text='<%# Eval("EQUIPMENTNAME") %>' runat="server" ID="EQUIPMENTNAMELabel" /></td>
                <td>
                    <asp:Label Text='<%# Eval("QUANTITY") %>' runat="server" ID="QUANTITYLabel" /></td>
                <td>
                    <asp:Label Text='<%# Eval("INUSE") %>' runat="server" ID="INUSELabel" /></td>
                <td>
                    <asp:Label Text='<%# Eval("STOCK") %>' runat="server" ID="STOCKLabel" /></td>
            </tr>
        </AlternatingItemTemplate>--%>
        <EditItemTemplate>
            <tr style="">
                <td>
                    <asp:Label Text='<%# Eval("EQUIPMENTID") %>' runat="server" ID="EQUIPMENTIDLabel1" /></td>
                <td>
                    <asp:Label Text='<%# Bind("EQUIPMENTNAME") %>' runat="server" ID="EQUIPMENTNAMETextBox" CssClass="control-label" Enabled="false"/></td>
                <td>
                    <asp:TextBox Text='<%# Bind("QUANTITY") %>' runat="server" ID="QUANTITYTextBox" CssClass="form-control"/>
                    <asp:RegularExpressionValidator ID="RegularExpressionValidator1" ControlToValidate="QUANTITYTextBox" runat="server" ErrorMessage="Whole numbers only" ValidationExpression="^[0-9]+$" Display="Static" ForeColor="#FF3535" SetFocusOnError="True"></asp:RegularExpressionValidator>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="Must at least have single digit" ControlToValidate="QUANTITYTextBox" ForeColor="#FF3535" SetFocusOnError="True"></asp:RequiredFieldValidator>
                </td>
                <td>
                    <asp:Label Text='<%# Bind("INUSE") %>' runat="server" ID="INUSELabel"  CssClass="control-label" Enabled="false"/></td>
                <td>
                    <asp:Label Text='<%# Bind("STOCK") %>' runat="server" ID="STOCKTextBox"  CssClass="control-label" Enabled="false"/></td>
                <td>
                    <asp:LinkButton runat="server" OnClick="UpdateButton_Click" CommandName="Update" Text="Save" ID="UpdateButton" CssClass="btn btn-info"
                        data-toggle="tooltip"
                        data-placement="top"
                        data-original-title="Save?" ValidateRequestMode="Enabled"><span class="glyphicon glyphicon-ok"></asp:LinkButton>
                    <asp:LinkButton runat="server" CommandName="Cancel" Text="Cancel" ID="CancelButton" CssClass="btn btn-danger"  OnClientClick="this.form.reset();return false;"
                        data-toggle="tooltip"
                        data-placement="top"
                        data-original-title="Cancel" CausesValidation="False"><span class="glyphicon glyphicon-remove"></asp:LinkButton>
                </td>
            </tr>
        </EditItemTemplate>
        <EmptyDataTemplate>
            <table runat="server" style="">
                <tr>
                    <td>No data was returned.</td>
                </tr>
            </table>
        </EmptyDataTemplate>
        <%--<InsertItemTemplate>
            <tr style="">
                <td>
                    <asp:Button runat="server" CommandName="Insert" Text="Insert" ID="InsertButton" />
                    <asp:Button runat="server" CommandName="Cancel" Text="Clear" ID="CancelButton" />
                </td>
                <td>&nbsp;</td>
                <td>
                    <asp:TextBox Text='<%# Bind("EQUIPMENTNAME") %>' runat="server" ID="EQUIPMENTNAMETextBox" /></td>
                <td>
                    <asp:TextBox Text='<%# Bind("QUANTITY") %>' runat="server" ID="QUANTITYTextBox" /></td>
                <td>
                    <asp:TextBox Text='<%# Bind("INUSE") %>' runat="server" ID="INUSETextBox" /></td>
                <td>
                    <asp:TextBox Text='<%# Bind("STOCK") %>' runat="server" ID="STOCKTextBox" /></td>
            </tr>
        </InsertItemTemplate>--%>
        <ItemTemplate>
            <tr style="">
                <td>
                    <asp:Label Text='<%# Eval("EQUIPMENTID") %>' runat="server" ID="EQUIPMENTIDLabel" /></td>
                <td>
                    <asp:Label Text='<%# Eval("EQUIPMENTNAME") %>' runat="server" ID="EQUIPMENTNAMELabel" /></td>
                <td>
                    <asp:Label Text='<%# Eval("QUANTITY") %>' runat="server" ID="QUANTITYLabel" /></td>
                <td>
                    <asp:Label Text='<%# Eval("INUSE") %>' runat="server" ID="INUSELabel" /></td>
                <td>
                    <asp:Label Text='<%# Eval("STOCK") %>' runat="server" ID="STOCKLabel" /></td>
                <td>
                    <asp:LinkButton ID="EditButton" runat="server" CommandName="Edit" Text="Edit" CssClass="btn btn-primary"
                        data-toggle="tooltip"
                        data-placement="top"
                        data-original-title="Add more?"><span class="glyphicon glyphicon-plus"></span></asp:LinkButton>
                </td>
            </tr>
        </ItemTemplate>
        <LayoutTemplate>
            <div runat="server" class="table-responsive col-sm-12 well">
                <div runat="server">
                    <div runat="server">
                        <table id="itemPlaceholderContainer" runat="server" border="0" style="" class="table table-condensed">
                            <tr runat="server" style="" class="success">
                                <th runat="server">ID</th>
                                <th runat="server">Equipment Name</th>
                                <th runat="server">Total</th>
                                <th runat="server">On Project</th>
                                <th runat="server">On Stock</th>
                                <th runat="server"></th>
                            </tr>
                            <tr runat="server" id="itemPlaceholder"></tr>
                        </table>
                    </div>
                </div>
                <tr runat="server">
                    <td runat="server" style="">
                        <asp:DataPager runat="server" ID="DataPager1">
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
        <%--<SelectedItemTemplate>
            <tr style="">
                <td>
                    <asp:Button runat="server" CommandName="Edit" Text="Edit" ID="EditButton" />
                </td>
                <td>
                    <asp:Label Text='<%# Eval("EQUIPMENTID") %>' runat="server" ID="EQUIPMENTIDLabel" /></td>
                <td>
                    <asp:Label Text='<%# Eval("EQUIPMENTNAME") %>' runat="server" ID="EQUIPMENTNAMELabel" /></td>
                <td>
                    <asp:Label Text='<%# Eval("QUANTITY") %>' runat="server" ID="QUANTITYLabel" /></td>
                <td>
                    <asp:Label Text='<%# Eval("INUSE") %>' runat="server" ID="INUSELabel" /></td>
                <td>
                    <asp:Label Text='<%# Eval("STOCK") %>' runat="server" ID="STOCKLabel" /></td>
            </tr>
        </SelectedItemTemplate>--%>
    </asp:ListView>
    <asp:SqlDataSource runat="server" ID="DataSourceEquipmentStash" ConnectionString='<%$ ConnectionStrings:ConnString_WEB_ASSET_DB %>' SelectCommand="SELECT [EQUIPMENTID], [EQUIPMENTNAME], [QUANTITY], [INUSE], [STOCK] FROM [EQUIPMENT]" DeleteCommand="DELETE FROM [EQUIPMENT] WHERE [EQUIPMENTID] = @EQUIPMENTID" InsertCommand="INSERT INTO [EQUIPMENT] ([EQUIPMENTNAME], [QUANTITY], [INUSE], [STOCK]) VALUES (@EQUIPMENTNAME, @QUANTITY, @INUSE, @STOCK)" UpdateCommand="UPDATE [EQUIPMENT] SET [EQUIPMENTNAME] = @EQUIPMENTNAME, [QUANTITY] = @QUANTITY, [INUSE] = @INUSE, [STOCK] = @STOCK WHERE [EQUIPMENTID] = @EQUIPMENTID">
        <DeleteParameters>
            <asp:Parameter Name="EQUIPMENTID" Type="Int32"></asp:Parameter>
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="EQUIPMENTNAME" Type="String"></asp:Parameter>
            <asp:Parameter Name="QUANTITY" Type="String"></asp:Parameter>
            <asp:Parameter Name="INUSE" Type="String"></asp:Parameter>
            <asp:Parameter Name="STOCK" Type="String"></asp:Parameter>
        </InsertParameters>
        <UpdateParameters>
            <asp:Parameter Name="EQUIPMENTNAME" Type="String"></asp:Parameter>
            <asp:Parameter Name="QUANTITY" Type="String"></asp:Parameter>
            <asp:Parameter Name="INUSE" Type="String"></asp:Parameter>
            <asp:Parameter Name="STOCK" Type="String"></asp:Parameter>
            <asp:Parameter Name="EQUIPMENTID" Type="Int32"></asp:Parameter>
        </UpdateParameters>
    </asp:SqlDataSource>
    <script type="text/javascript">
        $.validate()
    </script>
    <script type="text/javascript">
        $('[data-toggle=tooltip]').tooltip();
        $('[rel=tooltip]').tooltip();
    </script>
</asp:Content>

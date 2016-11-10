<%@ Page Title="Trade" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Trade_CRUD.aspx.cs" Inherits="Construction_Asset_Management_System.Trade_CRUD" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <script src="Scripts/Form Validator/jquery.form-validator.js"></script>
    <link href="Scripts/Form Validator/theme-default.css" rel="stylesheet" type="text/css" />
    <asp:ListView ID="_listviewTradeCRUD" runat="server" DataKeyNames="TRADEID" DataSourceID="DataSourceTradeCRUD" InsertItemPosition="LastItem" OnItemDeleted="_listviewTradeCRUD_ItemDeleted" OnItemInserted="_listviewTradeCRUD_ItemInserted" OnItemUpdated="_listviewTradeCRUD_ItemUpdated" OnDataBound="_listviewTradeCRUD_DataBound" OnItemInserting="_listviewTradeCRUD_ItemInserting" OnItemUpdating="_listviewTradeCRUD_ItemUpdating">
        <EditItemTemplate>
            <span style="">
                <div class="well">
                    <h4>Update Trade</h4>
                    <label class="control-label">ID:</label>
                    <asp:Label ID="TRADEIDLabel1" runat="server" Text='<%# Eval("TRADEID") %>' CssClass="control-label" />
                    <br />
                    <div class="row">
                        <p class="col-sm-6">
                            <label class="control-label">Trade Name:</label>
                            <asp:TextBox ID="TRADENAMETextBox" runat="server" Text='<%# Bind("TRADENAME") %>' CssClass="form-control"
                                data-validation="required custom"
                                data-validation-error-msg-required="you must enter a trade"
                                data-validation-regexp="^([a-zA-Z '().-]+)$"
                                data-validation-error-msg-custom="invalid input letters only. '().- characters is allowed" />
                        </p>
                        <p class="col-sm-6">
                            <label class="control-label">Labor Career Type:</label>
                            <%--<asp:TextBox ID="LABORTYPEIDTextBox" runat="server" Text='<%# Bind("LABORTYPEID") %>' />--%>
                            <asp:DropDownList ID="_dropdownLaborType" runat="server" SelectedValue='<%# Bind("LABORTYPEID") %>' DataSourceID="DataSourceLaborTypeDDList" DataTextField="LABORTYPENAME" DataValueField="LABORTYPEID" CssClass="form-control" AppendDataBoundItems="true"
                                data-validation="required"
                                data-validation-error-msg-required="You must select a Career Type">
                                <asp:ListItem Value=" "> -- please select Career Type -- </asp:ListItem>
                            </asp:DropDownList>
                            <asp:SqlDataSource ID="DataSourceLaborTypeDDList" runat="server" ConnectionString="<%$ ConnectionStrings:ConnString_WEB_ASSET_DB %>" SelectCommand="SELECT [LABORTYPEID], [LABORTYPENAME] FROM [LABORTYPE]"></asp:SqlDataSource>
                        </p>
                    </div>
                    <hr />
                    <div class="row">
                        <div class="col-sm-4 pull-right">
                            <div class="col-xs-6">
                                <asp:Button ID="UpdateButton" runat="server" CommandName="Update" Text="Save" CssClass="btn btn-primary center-block col-xs-12" OnClick="UpdateButton_Click" />
                            </div>
                            <div class="col-xs-6">
                                <asp:Button ID="CancelButton" runat="server" CommandName="Cancel" Text="Cancel" CssClass="btn btn-danger center-block col-xs-12" OnClientClick=" window.location = '/Trade.aspx';this.form.reset();return false;" />
                            </div>
                        </div>
                    </div>
                </div>
            </span>
        </EditItemTemplate>
        <EmptyDataTemplate>
            <span>No data was returned.</span>
        </EmptyDataTemplate>
        <InsertItemTemplate>
            <span style="">
                <div class="well">
                    <h4>Add Trade</h4>
                    <div class="row">
                        <p class="col-sm-6">
                            <label class="control-label">Trade Name:</label>
                            <asp:TextBox ID="TRADENAMETextBox" runat="server" Text='<%# Bind("TRADENAME") %>' CssClass="form-control"
                                data-validation="required custom"
                                data-validation-error-msg-required="you must enter a trade"
                                data-validation-regexp="^([a-zA-Z '().-]+)$"
                                data-validation-error-msg-custom="invalid input letters only. -.'() characters is allowed" />
                            <%--<asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="TRADENAMETextBox"
                                    ErrorMessage="Trade name is a required field."
                                    ForeColor="Red" ClientIDMode="Inherit" />
                                <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server"
                                    ErrorMessage="This expression does not validate." 
                                    ControlToValidate="TRADENAMETextBox"     
                                    ValidationExpression="^[a-zA-Z\s'().-]{1,40}$" />--%>
                        </p>
                        <p class="col-sm-6">
                            <label class="control-label">Labor Career Type:</label>
                            <%--<asp:TextBox ID="LABORTYPEIDTextBox" runat="server" Text='<%# Bind("LABORTYPEID") %>' />--%>
                            <asp:DropDownList ID="_dropdownLaborType" runat="server" SelectedValue='<%# Bind("LABORTYPEID") %>' DataSourceID="DataSourceLaborTypeDDList" DataTextField="LABORTYPENAME" DataValueField="LABORTYPEID" CssClass="form-control" AppendDataBoundItems="true"
                                data-validation="required"
                                data-validation-error-msg-required="You must select a Career Type">
                                <asp:ListItem Value=" "> -- please select Career Type -- </asp:ListItem>
                            </asp:DropDownList>
                            <asp:SqlDataSource ID="DataSourceLaborTypeDDList" runat="server" ConnectionString="<%$ ConnectionStrings:ConnString_WEB_ASSET_DB %>" SelectCommand="SELECT [LABORTYPEID], [LABORTYPENAME] FROM [LABORTYPE]"></asp:SqlDataSource>
                        </p>
                    </div>
                    <hr />
                    <div class="row">
                        <div class="col-sm-4 pull-right">
                            <div class="col-xs-6">
                                <asp:Button ID="InsertButton" runat="server" CommandName="Insert" Text="Save" CssClass="btn btn-primary center-block col-xs-12" OnClick="InsertButton_Click" />
                            </div>
                            <div class="col-xs-6">
                                <asp:Button ID="CancelButton" runat="server" CommandName="Cancel" Text="Cancel" CssClass="btn btn-danger center-block col-xs-12" OnClientClick=" window.location = '/Trade.aspx';this.form.reset();return false;" />
                            </div>
                        </div>
                    </div>
                </div>
            </span>
        </InsertItemTemplate>
        <ItemTemplate>
            <span style="">
                <div class="well">
                    <label class="control-label">ID:</label>
                    <asp:Label ID="TRADEIDLabel" runat="server" Text='<%# Eval("TRADEID") %>' />
                    <br />
                    <label class="control-label">Trade Name:</label>
                    <asp:Label ID="TRADENAMELabel" runat="server" Text='<%# Eval("TRADENAME") %>' />
                    <br />
                    <label class="control-label">Labor Career Type:</label>
                    <asp:Label ID="LABORTYPEIDLabel" runat="server" Text='<%# Eval("LABORTYPENAME") %>' />
                    <hr />
                    <div class="row">
                        <div class="col-sm-3 pull-right">
                            <asp:Button ID="EditButton" runat="server" CommandName="Edit" Text="Edit" CssClass="btn btn-primary" />
                            <asp:Button ID="DeleteButton" runat="server" CommandName="Delete" Text="Delete" CssClass="btn btn-danger" />
                            <input type="button" value="Back" onclick="window.location = 'Trade.aspx';" class="btn btn-warning" />
                        </div>
                    </div>
                    <br />
                </div>
            </span>
        </ItemTemplate>
        <LayoutTemplate>
            <div id="itemPlaceholderContainer" runat="server" style="">
                <span runat="server" id="itemPlaceholder" />
            </div>
            <div style="">
                <asp:DataPager ID="DataPager1" runat="server" Visible="false" PageSize="1">
                    <Fields>
                        <asp:NextPreviousPagerField ButtonType="Button" ShowFirstPageButton="True" ShowNextPageButton="False" ShowPreviousPageButton="False" />
                        <asp:NumericPagerField NumericButtonCssClass="label label-success" CurrentPageLabelCssClass="badge"/>
                        <asp:NextPreviousPagerField ButtonType="Button" ShowLastPageButton="True" ShowNextPageButton="False" ShowPreviousPageButton="False" />
                    </Fields>
                </asp:DataPager>
            </div>
        </LayoutTemplate>
    </asp:ListView>
    <asp:SqlDataSource ID="DataSourceTradeCRUD" runat="server" ConnectionString="<%$ ConnectionStrings:ConnString_WEB_ASSET_DB %>" DeleteCommand="DELETE FROM [TRADE] WHERE [TRADEID] = @TRADEID" InsertCommand="INSERT INTO [TRADE] ([TRADENAME], [LABORTYPEID]) VALUES (@TRADENAME, @LABORTYPEID)" SelectCommand="SELECT [TRADEID], [TRADENAME], TRADE.LABORTYPEID, LABORTYPE.LABORTYPENAME FROM TRADE INNER JOIN LABORTYPE ON TRADE.LABORTYPEID=LABORTYPE.LABORTYPEID WHERE TRADEID = @TRADEID" UpdateCommand="UPDATE [TRADE] SET [TRADENAME] = @TRADENAME, [LABORTYPEID] = @LABORTYPEID WHERE [TRADEID] = @TRADEID">
        <DeleteParameters>
            <asp:Parameter Name="TRADEID" Type="Int32" />
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="TRADENAME" Type="String" />
            <asp:Parameter Name="LABORTYPEID" Type="Int32" />
        </InsertParameters>
        <SelectParameters>
            <asp:QueryStringParameter Name="TRADEID" QueryStringField="id" Type="Int32" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="TRADENAME" Type="String" />
            <asp:Parameter Name="LABORTYPEID" Type="Int32" />
            <asp:Parameter Name="TRADEID" Type="Int32" />
        </UpdateParameters>
    </asp:SqlDataSource>
    <script type="text/javascript">
        $.validate();
    </script>
</asp:Content>

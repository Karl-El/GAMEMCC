<%@ Page Title="Client" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Client_CRUD.aspx.cs" Inherits="Construction_Asset_Management_System.Client_CRUD" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <script src="Scripts/Form Validator/jquery.form-validator.js"></script>
    <link href="Scripts/Form Validator/theme-default.css" rel="stylesheet" type="text/css" />
    <asp:ListView ID="_listviewClientCRUD" runat="server" DataKeyNames="CLIENTID" DataSourceID="DataSourceClientCRUD" InsertItemPosition="LastItem" OnDataBound="_listviewClientCRUD_DataBound" OnItemDeleted="_listviewClientCRUD_ItemDeleted" OnItemInserted="_listviewClientCRUD_ItemInserted" OnItemUpdated="_listviewClientCRUD_ItemUpdated" OnItemInserting="_listviewClientCRUD_ItemInserting" OnItemUpdating="_listviewClientCRUD_ItemUpdating" OnItemDeleting="_listviewClientCRUD_ItemDeleting">
        <EditItemTemplate>
            <span style="" class="">
                <div class="well">
                    <h4>Update Client</h4>
                    <label class="control-label">ID:</label>
                    <asp:Label ID="CLIENTIDLabel1" runat="server" Text='<%# Eval("CLIENTID") %>' />
                    <div class="row">
                        <p class="col-sm-12">
                            <label class="control-label">Company/ Business Name:</label>
                            <asp:TextBox ID="CLIENTNAMETextBox" runat="server" Text='<%# Bind("CLIENTNAME") %>' CssClass="form-control"
                                data-validation="required custom"
                                data-validation-error-msg-required="You must enter a Company or Business name"
                                data-validation-regexp="^([a-zA-Z0-9 &'(),-.@]+)$"
                                data-validation-error-msg-custom="Invalid input alphanumeric only. &'(),-.@ characters is allowed" />
                        </p>
                    </div>
                    <div class="row">
                        <p class="col-sm-6">
                            <label class="control-label">Address:</label>
                            <asp:TextBox ID="CLIENTADDRTextBox" runat="server" Text='<%# Bind("CLIENTADDR") %>' CssClass="form-control"
                                data-validation="required custom"
                                data-validation-error-msg-required="You must enter an address"
                                data-validation-regexp="^([a-zA-Z0-9 #&'(),-.@]+)$"
                                data-validation-error-msg-custom="Invalid input alphanumeric only. #&'(),-.@ characters is allowed" />
                        </p>
                        <p class="col-sm-3">
                            <label class="control-label">City:</label>
                            <asp:TextBox ID="CLIENTCITYTextBox" runat="server" Text='<%# Bind("CLIENTCITY") %>' CssClass="form-control"
                                data-validation="required custom"
                                data-validation-error-msg-required="You must enter a city"
                                data-validation-regexp="^([a-zA-Z0-9-_'@() ]+)$"
                                data-validation-error-msg-custom="Invalid input alphanumeric only. -_'@() characters is allowed" />
                        </p>
                        <p class="col-sm-3">
                            <label class="control-label">Province:</label>
                            <asp:TextBox ID="CLIENTPROVTextBox" runat="server" Text='<%# Bind("CLIENTPROV") %>' CssClass="form-control"
                                data-validation="required custom"
                                data-validation-error-msg-required="You must enter a province"
                                data-validation-regexp="^([a-zA-Z0-9-_'@() ]+)$"
                                data-validation-error-msg-custom="Invalid input alphanumeric only. -_'@() characters is allowed" />
                        </p>
                    </div>
                    <div class="row">
                        <p class="col-sm-4">
                            <label class="control-label">Company/ Business Telephone:</label>
                            <asp:TextBox ID="CLIENTTELTextBox" runat="server" Text='<%# Bind("CLIENTTEL") %>' CssClass="form-control"
                                data-validation="required custom"
                                data-validation-error-msg-required="You must enter a telephone number"
                                data-validation-regexp="^([0-9()+-]+)$"
                                data-validation-error-msg-custom="Invalid input numbers only. ()+- characters is allowed" />
                        </p>
                        <p class="col-sm-4">
                            <label class="control-label">Company/ Business Cellphone:</label>
                            <asp:TextBox ID="CLIENTCELLTextBox" runat="server" Text='<%# Bind("CLIENTCELL") %>' CssClass="form-control"
                                data-validation="required custom"
                                data-validation-error-msg-required="You must enter a cellphone number"
                                data-validation-regexp="^([0-9()+-]+)$"
                                data-validation-error-msg-custom="Invalid input numbers only. ()+- characters is allowed" />
                        </p>
                        <p class="col-sm-4">
                            <label class="control-label">Company/ Business Email:</label>
                            <asp:TextBox ID="CLIENTEMAILTextBox" runat="server" Text='<%# Bind("CLIENTEMAIL") %>' CssClass="form-control"
                                data-validation="email" />
                        </p>
                    </div>
                    <hr />
                    <div class="row col-sm-4 pull-right">
                        <div class="col-xs-6">
                            <asp:Button ID="UpdateButton" runat="server" CommandName="Update" Text="Save" CssClass="btn btn-primary center-block col-xs-12" OnClick="UpdateButton_Click" />
                        </div>
                        <div class="col-xs-6">
                            <asp:Button ID="CancelButton" runat="server" CommandName="Cancel" Text="Cancel" CssClass="btn btn-danger center-block col-xs-12" OnClientClick=" window.location = '/Client.aspx';this.form.reset();return false;" />
                        </div>
                    </div>
                    <br />
                    <br />
                </div>
            </span>
        </EditItemTemplate>
        <EmptyDataTemplate>
            <span>No data was returned.</span>
        </EmptyDataTemplate>
        <InsertItemTemplate>
            <span style="" class="">
                <div class="well">
                    <h4>Add Client</h4>
                    <div class="row">
                        <p class="col-sm-12">
                            <label class="control-label">Company/ Business Name:</label>
                            <asp:TextBox ID="CLIENTNAMETextBox" runat="server" Text='<%# Bind("CLIENTNAME") %>' CssClass="form-control"
                                data-validation="required custom"
                                data-validation-error-msg-required="You must enter a Company or Business name"
                                data-validation-regexp="^([a-zA-Z0-9 &'(),-.@]+)$"
                                data-validation-error-msg-custom="Invalid input alphanumeric only. &'(),-.@ characters is allowed" />
                        </p>
                    </div>
                    <div class="row">
                        <p class="col-sm-6">
                            <label class="control-label">Address:</label>
                            <asp:TextBox ID="CLIENTADDRTextBox" runat="server" Text='<%# Bind("CLIENTADDR") %>' CssClass="form-control"
                                data-validation="required custom"
                                data-validation-error-msg-required="You must enter an address"
                                data-validation-regexp="^([a-zA-Z0-9 #&'(),-.@]+)$"
                                data-validation-error-msg-custom="Invalid input alphanumeric only. #&'(),-.@ characters is allowed" />
                        </p>
                        <p class="col-sm-3">
                            <label class="control-label">City:</label>
                            <asp:TextBox ID="CLIENTCITYTextBox" runat="server" Text='<%# Bind("CLIENTCITY") %>' CssClass="form-control"
                                data-validation="required custom"
                                data-validation-error-msg-required="You must enter a city"
                                data-validation-regexp="^([a-zA-Z0-9-_'@() ]+)$"
                                data-validation-error-msg-custom="Invalid input alphanumeric only. -_'@() characters is allowed" />
                        </p>
                        <p class="col-sm-3">
                            <label class="control-label">Province:</label>
                            <asp:TextBox ID="CLIENTPROVTextBox" runat="server" Text='<%# Bind("CLIENTPROV") %>' CssClass="form-control"
                                data-validation="required custom"
                                data-validation-error-msg-required="You must enter a province"
                                data-validation-regexp="^([a-zA-Z0-9-_'@() ]+)$"
                                data-validation-error-msg-custom="Invalid input alphanumeric only. -_'@() characters is allowed" />
                        </p>
                    </div>
                    <div class="row">
                        <p class="col-sm-4">
                            <label class="control-label">Company/ Business Telephone:</label>
                            <asp:TextBox ID="CLIENTTELTextBox" runat="server" Text='<%# Bind("CLIENTTEL") %>' CssClass="form-control"
                                data-validation="required custom"
                                data-validation-error-msg-required="You must enter a telephone number"
                                data-validation-regexp="^([0-9()+-]+)$"
                                data-validation-error-msg-custom="Invalid input numbers only. ()+- characters is allowed" />
                        </p>
                        <p class="col-sm-4">
                            <label class="control-label">Company/ Business Cellphone:</label>
                            <asp:TextBox ID="CLIENTCELLTextBox" runat="server" Text='<%# Bind("CLIENTCELL") %>' CssClass="form-control"
                                data-validation="required custom"
                                data-validation-error-msg-required="You must enter a cellphone number"
                                data-validation-regexp="^([0-9()+-]+)$"
                                data-validation-error-msg-custom="Invalid input numbers only. ()+- characters is allowed" />
                        </p>
                        <p class="col-sm-4">
                            <label class="control-label">Company/ Business Email:</label>
                            <asp:TextBox ID="CLIENTEMAILTextBox" runat="server" Text='<%# Bind("CLIENTEMAIL") %>' CssClass="form-control"
                                data-validation="email" />
                        </p>
                    </div>
                    <hr />
                    <div class="row col-sm-4 pull-right">
                        <div class="col-xs-6">
                            <asp:Button ID="InsertButton" runat="server" CommandName="Insert" Text="Save" CssClass="btn btn-primary center-block col-xs-12" OnClick="InsertButton_Click" />
                        </div>
                        <div class="col-xs-6">
                            <asp:Button ID="CancelButton" runat="server" CommandName="Cancel" Text="Cancel" CssClass="btn btn-danger center-block col-xs-12" OnClientClick=" window.location = '/Client.aspx';this.form.reset();return false;" />
                        </div>
                    </div>
                    <br />
                    <br />
                </div>
            </span>
        </InsertItemTemplate>
        <ItemTemplate>
            <span style="">
                <div class="well">
                    <h4>Client Details</h4>
                    <label class="control-label">ID:</label>
                    <asp:Label ID="CLIENTIDLabel" runat="server" Text='<%# Eval("CLIENTID") %>' />
                    <br />
                    <label class="control-label">Company/ Business Name:</label>
                    <asp:Label ID="CLIENTNAMELabel" runat="server" Text='<%# Eval("CLIENTNAME") %>' />
                    <br />
                    <label class="control-label">Address:</label>
                    <asp:Label ID="CLIENTADDRLabel" runat="server" Text='<%# Eval("CLIENTADDR") %>' />
                    <br />
                    <label class="control-label">City:</label>
                    <asp:Label ID="CLIENTCITYLabel" runat="server" Text='<%# Eval("CLIENTCITY") %>' />
                    <br />
                    <label class="control-label">Province:</label>
                    <asp:Label ID="CLIENTPROVLabel" runat="server" Text='<%# Eval("CLIENTPROV") %>' />
                    <br />
                    <label class="control-label">Company/ Business Telephone:</label>
                    <asp:Label ID="CLIENTTELLabel" runat="server" Text='<%# Eval("CLIENTTEL") %>' />
                    <br />
                    <label class="control-label">Company/ Business Cellphone:</label>
                    <asp:Label ID="CLIENTCELLLabel" runat="server" Text='<%# Eval("CLIENTCELL") %>' />
                    <br />
                    <label class="control-label">Company/ Business Email:</label>
                    <asp:Label ID="CLIENTEMAILLabel" runat="server" Text='<%# Eval("CLIENTEMAIL") %>' />
                    <hr />
                    <div class="row">
                        <div class="col-sm-3 pull-right ">
                            <asp:Button ID="EditButton" runat="server" CommandName="Edit" Text="Edit" CssClass="btn btn-primary " />
                            <span onclick="return confirm('Are you sure to delete?')">
                                <asp:Button ID="DeleteButton" runat="server" CommandName="Delete" Text="Delete" CssClass="btn btn-danger" />
                            </span>
                            <input type="button" value="Back" onclick="window.location = 'Client.aspx';" class="btn btn-warning" />
                        </div>
                    </div>
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
                        <asp:NextPreviousPagerField ButtonType="Button" ShowFirstPageButton="True" ShowLastPageButton="True" />
                    </Fields>
                </asp:DataPager>
            </div>
        </LayoutTemplate>

    </asp:ListView>
    <asp:SqlDataSource ID="DataSourceClientCRUD" runat="server" ConnectionString="<%$ ConnectionStrings:ConnString_WEB_ASSET_DB %>" DeleteCommand="DELETE FROM [CLIENT] WHERE [CLIENTID] = @CLIENTID" InsertCommand="INSERT INTO [CLIENT] ([CLIENTNAME], [CLIENTADDR], [CLIENTCITY], [CLIENTPROV], [CLIENTTEL], [CLIENTCELL], [CLIENTEMAIL]) VALUES (@CLIENTNAME, @CLIENTADDR, @CLIENTCITY, @CLIENTPROV, @CLIENTTEL, @CLIENTCELL, @CLIENTEMAIL)" SelectCommand="SELECT [CLIENTID], [CLIENTNAME], [CLIENTADDR], [CLIENTCITY], [CLIENTPROV], [CLIENTTEL], [CLIENTCELL], [CLIENTEMAIL] FROM [CLIENT] WHERE ([CLIENTID] = @CLIENTID)" UpdateCommand="UPDATE [CLIENT] SET [CLIENTNAME] = @CLIENTNAME, [CLIENTADDR] = @CLIENTADDR, [CLIENTCITY] = @CLIENTCITY, [CLIENTPROV] = @CLIENTPROV, [CLIENTTEL] = @CLIENTTEL, [CLIENTCELL] = @CLIENTCELL, [CLIENTEMAIL] = @CLIENTEMAIL WHERE [CLIENTID] = @CLIENTID">
        <DeleteParameters>
            <asp:Parameter Name="CLIENTID" Type="Int32" />
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="CLIENTNAME" Type="String" />
            <asp:Parameter Name="CLIENTADDR" Type="String" />
            <asp:Parameter Name="CLIENTCITY" Type="String" />
            <asp:Parameter Name="CLIENTPROV" Type="String" />
            <asp:Parameter Name="CLIENTTEL" Type="String" />
            <asp:Parameter Name="CLIENTCELL" Type="String" />
            <asp:Parameter Name="CLIENTEMAIL" Type="String" />
        </InsertParameters>
        <SelectParameters>
            <asp:QueryStringParameter Name="CLIENTID" QueryStringField="id" Type="Int32" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="CLIENTNAME" Type="String" />
            <asp:Parameter Name="CLIENTADDR" Type="String" />
            <asp:Parameter Name="CLIENTCITY" Type="String" />
            <asp:Parameter Name="CLIENTPROV" Type="String" />
            <asp:Parameter Name="CLIENTTEL" Type="String" />
            <asp:Parameter Name="CLIENTCELL" Type="String" />
            <asp:Parameter Name="CLIENTEMAIL" Type="String" />
            <asp:Parameter Name="CLIENTID" Type="Int32" />
        </UpdateParameters>
    </asp:SqlDataSource>
    <script type="text/javascript">
        $.validate();
    </script>
</asp:Content>

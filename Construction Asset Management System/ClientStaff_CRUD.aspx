<%@ Page Title="Client Staff" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ClientStaff_CRUD.aspx.cs" Inherits="Construction_Asset_Management_System.ClientStaff_CRUD" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <script src="Scripts/Form Validator/jquery.form-validator.js"></script>
    <link href="Scripts/Form Validator/theme-default.css" rel="stylesheet" type="text/css" />
    <asp:ListView ID="_listviewClientStaffCRUD" runat="server" DataKeyNames="CLIENTSTAFFID" DataSourceID="DataSourceClientStaffCRUD" InsertItemPosition="LastItem" OnItemDeleted="_listviewClientStaffCRUD_ItemDeleted" OnItemInserted="_listviewClientStaffCRUD_ItemInserted" OnItemUpdated="_listviewClientStaffCRUD_ItemUpdated" OnDataBound="_listviewClientStaffCRUD_DataBound" OnItemInserting="_listviewClientStaffCRUD_ItemInserting" OnItemUpdating="_listviewClientStaffCRUD_ItemUpdating" OnItemDeleting="_listviewClientStaffCRUD_ItemDeleting">
        <EditItemTemplate>
            <span style="">
                <div class="well">
                    <h4>Update Client Staff</h4>
                    <label class="control-label">ID:</label>
                    <asp:Label ID="CLIENTSTAFFIDLabel1" runat="server" Text='<%# Eval("CLIENTSTAFFID") %>' />
                    <br />
                    <div class="row">
                        <p class="col-sm-6">
                            <label class="control-label">First Name:</label>
                            <asp:TextBox ID="CLIENTSTAFFFNAMETextBox" runat="server" Text='<%# Bind("CLIENTSTAFFFNAME") %>' CssClass="form-control"
                                data-validation="required custom"
                                data-validation-error-msg-required="You must enter a First Name"
                                data-validation-regexp="^([a-zA-Z '-.]+)$"
                                data-validation-error-msg-custom="Invalid input letters only. '-. characters is allowed" />
                        </p>
                        <p class="col-sm-6">
                            <label class="control-label">Last Name:</label>
                            <asp:TextBox ID="CLIENTSTAFFLNAMETextBox" runat="server" Text='<%# Bind("CLIENTSTAFFLNAME") %>' CssClass="form-control"
                                data-validation="required custom"
                                data-validation-error-msg-required="You must enter a Last Name"
                                data-validation-regexp="^([a-zA-Z '-.]+)$"
                                data-validation-error-msg-custom="Invalid input letters only. '-.. characters is allowed" />
                        </p>
                    </div>
                    <div class="row">
                        <p class="col-sm-3">
                            <label class="control-label">Telephone:</label>
                            <asp:TextBox ID="CLIENTSTAFFTELTextBox" runat="server" Text='<%# Bind("CLIENTSTAFFTEL") %>' CssClass="form-control"
                                data-validation="custom"
                                data-validation-optional="true"
                                data-validation-regexp="^([0-9()+-]+)$"
                                data-validation-error-msg-custom="Invalid input numbers only. ()+- characters is allowed" />
                        </p>
                        <p class="col-sm-3">
                            <label class="control-label">Cellphone:</label>
                            <asp:TextBox ID="CLIENTSTAFFCELLTextBox" runat="server" Text='<%# Bind("CLIENTSTAFFCELL") %>' CssClass="form-control"
                                data-validation="required custom"
                                data-validation-error-msg-required="You must enter a cellphone number"
                                data-validation-regexp="^([0-9()+-]+)$"
                                data-validation-error-msg-custom="Invalid input numbers only. ()+- characters is allowed" />
                        </p>
                        <p class="col-sm-6">
                            <label class="control-label">Email:</label>
                            <asp:TextBox ID="CLIENTSTAFFEMAILTextBox" runat="server" Text='<%# Bind("CLIENTSTAFFEMAIL") %>' CssClass="form-control"
                                data-validation="email" />
                        </p>
                    </div>
                    <div class="row">
                        <p class="col-sm-4">
                            <label class="control-label">Position:</label>
                            <asp:TextBox ID="CLIENTSTAFFPOSITIONTextBox" runat="server" Text='<%# Bind("CLIENTSTAFFPOSITION") %>' CssClass="form-control"
                                data-validation="required custom"
                                data-validation-error-msg-required="You must enter your position"
                                data-validation-regexp="^([a-zA-Z '-.]+)$"
                                data-validation-error-msg-custom="Invalid input letters only. -_'@() characters is allowed" />
                        </p>
                        <p class="col-sm-4">
                            <label class="control-label">Status:</label>
                            <%--<asp:TextBox ID="CLIENTSTAFFSTATUSTextBox" runat="server" Text='<%# Bind("CLIENTSTAFFSTATUS") %>' />--%>
                            <asp:DropDownList ID="_dropdownClientStaffStat" runat="server" Text='<%# Bind("CLIENTSTAFFSTATUS") %>' CssClass="form-control"
                                data-validation="required"
                                data-validation-error-msg-required="You must select a Status">
                                <asp:ListItem Value=" "> -- please select Status -- </asp:ListItem>
                                <asp:ListItem>Active</asp:ListItem>
                                <asp:ListItem>Inactive</asp:ListItem>
                            </asp:DropDownList>
                        </p>
                        <p class="col-sm-4">
                            <label class="control-label">Company Business Name:</label>
                            <asp:DropDownList ID="_dropdownClient" runat="server" SelectedValue='<%# Bind("CLIENTID") %>' AppendDataBoundItems="true" DataSourceID="DataSourceClientDDList" DataTextField="CLIENTNAME" DataValueField="CLIENTID" CssClass="form-control"
                                data-validation="required"
                                data-validation-error-msg-required="You must select a Company">
                                <asp:ListItem Value=" "> -- please select a Company -- </asp:ListItem>
                            </asp:DropDownList>
                            <asp:SqlDataSource ID="DataSourceClientDDList" runat="server" ConnectionString="<%$ ConnectionStrings:ConnString_WEB_ASSET_DB %>" SelectCommand="SELECT [CLIENTID], [CLIENTNAME] FROM [CLIENT]"></asp:SqlDataSource>
                        </p>
                    </div>
                    <hr />
                    <div class="row">
                        <div class="col-sm-4 pull-right">
                            <div class="col-xs-6">
                                <asp:Button ID="UpdateButton" runat="server" CommandName="Update" Text="Save" CssClass="btn btn-primary center-block col-xs-12" OnClick="UpdateButton_Click" />
                            </div>
                            <div class="col-xs-6">
                                <asp:Button ID="CancelButton" runat="server" CommandName="Cancel" Text="Cancel" CssClass="btn btn-danger center-block col-xs-12" OnClientClick=" window.location = '/ClientStaff.aspx';this.form.reset();return false;" />
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
                    <h4>Add Client Staff</h4>
                    <div class="row">
                        <p class="col-sm-6">
                            <label class="control-label">First Name:</label>
                            <asp:TextBox ID="CLIENTSTAFFFNAMETextBox" runat="server" Text='<%# Bind("CLIENTSTAFFFNAME") %>' CssClass="form-control"
                                data-validation="required custom"
                                data-validation-error-msg-required="You must enter a First Name"
                                data-validation-regexp="^([a-zA-Z '-.]+)$"
                                data-validation-error-msg-custom="Invalid input letters only. '-. characters is allowed" />
                        </p>
                        <p class="col-sm-6">
                            <label class="control-label">Last Name:</label>
                            <asp:TextBox ID="CLIENTSTAFFLNAMETextBox" runat="server" Text='<%# Bind("CLIENTSTAFFLNAME") %>' CssClass="form-control"
                                data-validation="required custom"
                                data-validation-error-msg-required="You must enter a Last Name"
                                data-validation-regexp="^([a-zA-Z '-.]+)$"
                                data-validation-error-msg-custom="Invalid input letters only. '-. characters is allowed" />
                        </p>
                    </div>
                    <div class="row">
                        <p class="col-sm-3">
                            <label class="control-label">Telephone:</label>
                            <asp:TextBox ID="CLIENTSTAFFTELTextBox" runat="server" Text='<%# Bind("CLIENTSTAFFTEL") %>' CssClass="form-control"
                                data-validation="custom"
                                data-validation-optional="true"
                                data-validation-regexp="^([0-9()+-]+)$"
                                data-validation-error-msg-custom="Invalid input numbers only. ()+- characters is allowed" />
                        </p>
                        <p class="col-sm-3">
                            <label class="control-label">Cellphone:</label>
                            <asp:TextBox ID="CLIENTSTAFFCELLTextBox" runat="server" Text='<%# Bind("CLIENTSTAFFCELL") %>' CssClass="form-control"
                                data-validation="required custom"
                                data-validation-error-msg-required="You must enter a cellphone number"
                                data-validation-regexp="^([0-9()+-]+)$"
                                data-validation-error-msg-custom="Invalid input numbers only. ()+- characters is allowed" />
                        </p>
                        <p class="col-sm-6">
                            <label class="control-label">Email:</label>
                            <asp:TextBox ID="CLIENTSTAFFEMAILTextBox" runat="server" Text='<%# Bind("CLIENTSTAFFEMAIL") %>' CssClass="form-control"
                                data-validation="email" />
                        </p>
                    </div>
                    <div class="row">
                        <p class="col-sm-4">
                            <label class="control-label">Position:</label>
                            <asp:TextBox ID="CLIENTSTAFFPOSITIONTextBox" runat="server" Text='<%# Bind("CLIENTSTAFFPOSITION") %>' CssClass="form-control"
                                data-validation="required custom"
                                data-validation-error-msg-required="You must enter your position"
                                data-validation-regexp="^([a-zA-Z '-.]+)$"
                                data-validation-error-msg-custom="Invalid input letters only. '-. characters is allowed" />
                        </p>
                        <p class="col-sm-4">
                            <label class="control-label">Status:</label>
                            <%--<asp:TextBox ID="CLIENTSTAFFSTATUSTextBox" runat="server" Text='<%# Bind("CLIENTSTAFFSTATUS") %>' />--%>
                            <asp:DropDownList ID="_dropdownClientStaffStat" runat="server" Text='<%# Bind("CLIENTSTAFFSTATUS") %>' CssClass="form-control"
                                data-validation="required"
                                data-validation-error-msg-required="You must select a Status">
                                <asp:ListItem Value=" "> -- please select Status -- </asp:ListItem>
                                <asp:ListItem>Active</asp:ListItem>
                                <asp:ListItem>Inactive</asp:ListItem>
                            </asp:DropDownList>
                        </p>
                        <p class="col-sm-4">
                            <label class="control-label">Company Business Name:</label>
                            <asp:DropDownList ID="_dropdownClient" runat="server" SelectedValue='<%# Bind("CLIENTID") %>' AppendDataBoundItems="true" DataSourceID="DataSourceClientDDList" DataTextField="CLIENTNAME" DataValueField="CLIENTID" CssClass="form-control"
                                data-validation="required"
                                data-validation-error-msg-required="You must select a Company">
                                <asp:ListItem Value=" "> -- please select a Company -- </asp:ListItem>
                            </asp:DropDownList>
                            <asp:SqlDataSource ID="DataSourceClientDDList" runat="server" ConnectionString="<%$ ConnectionStrings:ConnString_WEB_ASSET_DB %>" SelectCommand="SELECT [CLIENTID], [CLIENTNAME] FROM [CLIENT]"></asp:SqlDataSource>
                        </p>
                    </div>
                    <hr />
                    <div class="row col-sm-4 pull-right">
                        <div class="col-xs-6">
                            <asp:Button ID="InsertButton" runat="server" CommandName="Insert" Text="Save" CssClass="btn btn-primary center-block col-xs-12" OnClick="InsertButton_Click" />
                        </div>
                        <div class="col-xs-6">
                            <asp:Button ID="CancelButton" runat="server" CommandName="Cancel" Text="Cancel" CssClass="btn btn-danger center-block col-xs-12" OnClientClick=" window.location = '/ClientStaff.aspx';this.form.reset();return false;" />
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
                    <h4>Client Staff Details</h4>
                    <label class="control-label">ID:</label>
                    <asp:Label ID="CLIENTSTAFFIDLabel" runat="server" Text='<%# Eval("CLIENTSTAFFID") %>' />
                    <br />
                    <label class="control-label">First Name:</label>
                    <asp:Label ID="CLIENTSTAFFFNAMELabel" runat="server" Text='<%# Eval("CLIENTSTAFFFNAME") %>' />
                    <br />
                    <label class="control-label">Last Name:</label>
                    <asp:Label ID="CLIENTSTAFFLNAMELabel" runat="server" Text='<%# Eval("CLIENTSTAFFLNAME") %>' />
                    <br />
                    <label class="control-label">Telephone:</label>
                    <asp:Label ID="CLIENTSTAFFTELLabel" runat="server" Text='<%# Eval("CLIENTSTAFFTEL") %>' />
                    <br />
                    <label class="control-label">Cellphone:</label>
                    <asp:Label ID="CLIENTSTAFFCELLLabel" runat="server" Text='<%# Eval("CLIENTSTAFFCELL") %>' />
                    <br />
                    <label class="control-label">Email:</label>
                    <asp:Label ID="CLIENTSTAFFEMAILLabel" runat="server" Text='<%# Eval("CLIENTSTAFFEMAIL") %>' />
                    <br />
                    <label class="control-label">Position:</label>
                    <asp:Label ID="CLIENTSTAFFPOSITIONLabel" runat="server" Text='<%# Eval("CLIENTSTAFFPOSITION") %>' />
                    <br />
                    <label class="control-label">Status:</label>
                    <asp:Label ID="CLIENTSTAFFSTATUSLabel" runat="server" Text='<%# Eval("CLIENTSTAFFSTATUS") %>' />
                    <br />
                    <label class="control-label">Company/ Business Name:</label>
                    <asp:Label ID="CLIENTIDLabel" runat="server" Text='<%# Eval("CLIENTNAME") %>' />
                    <hr />
                    <div class="row">
                        <div class="col-sm-3 pull-right ">
                            <asp:Button ID="EditButton" runat="server" CommandName="Edit" Text="Edit" CssClass="btn btn-primary " />
                            <asp:Button ID="DeleteButton" runat="server" CommandName="Delete" Text="Delete" CssClass="btn btn-danger" />
                            <input type="button" value="Back" onclick="window.location = 'ClientStaff.aspx';" class="btn btn-warning" />
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
                <asp:DataPager ID="DataPager1" runat="server" PageSize="1" Visible="false">
                    <Fields>
                        <asp:NextPreviousPagerField ButtonType="Button" ShowFirstPageButton="True" ShowNextPageButton="False" ShowPreviousPageButton="False" />
                        <asp:NumericPagerField NumericButtonCssClass="label label-success" CurrentPageLabelCssClass="badge" />
                        <asp:NextPreviousPagerField ButtonType="Button" ShowLastPageButton="True" ShowNextPageButton="False" ShowPreviousPageButton="False" />
                    </Fields>
                </asp:DataPager>
            </div>
        </LayoutTemplate>
    </asp:ListView>
    <asp:SqlDataSource ID="DataSourceClientStaffCRUD" runat="server" ConnectionString="<%$ ConnectionStrings:ConnString_WEB_ASSET_DB %>" DeleteCommand="DELETE FROM [CLIENTSTAFF] WHERE [CLIENTSTAFFID] = @CLIENTSTAFFID" InsertCommand="INSERT INTO [CLIENTSTAFF] ([CLIENTSTAFFFNAME], [CLIENTSTAFFLNAME], [CLIENTSTAFFTEL], [CLIENTSTAFFCELL], [CLIENTSTAFFEMAIL], [CLIENTSTAFFPOSITION], [CLIENTSTAFFSTATUS], [CLIENTID]) VALUES (@CLIENTSTAFFFNAME, @CLIENTSTAFFLNAME, @CLIENTSTAFFTEL, @CLIENTSTAFFCELL, @CLIENTSTAFFEMAIL, @CLIENTSTAFFPOSITION, @CLIENTSTAFFSTATUS, @CLIENTID)" SelectCommand="SELECT [CLIENTSTAFFID], [CLIENTSTAFFFNAME], [CLIENTSTAFFLNAME], [CLIENTSTAFFTEL], [CLIENTSTAFFCELL], [CLIENTSTAFFEMAIL], [CLIENTSTAFFPOSITION], [CLIENTSTAFFSTATUS], CLIENTSTAFF.CLIENTID, CLIENT.CLIENTNAME  FROM CLIENTSTAFF INNER JOIN CLIENT ON CLIENTSTAFF.CLIENTID = CLIENT.CLIENTID WHERE ([CLIENTSTAFFID] = @CLIENTSTAFFID)" UpdateCommand="UPDATE [CLIENTSTAFF] SET [CLIENTSTAFFFNAME] = @CLIENTSTAFFFNAME, [CLIENTSTAFFLNAME] = @CLIENTSTAFFLNAME, [CLIENTSTAFFTEL] = @CLIENTSTAFFTEL, [CLIENTSTAFFCELL] = @CLIENTSTAFFCELL, [CLIENTSTAFFEMAIL] = @CLIENTSTAFFEMAIL, [CLIENTSTAFFPOSITION] = @CLIENTSTAFFPOSITION, [CLIENTSTAFFSTATUS] = @CLIENTSTAFFSTATUS, [CLIENTID] = @CLIENTID WHERE [CLIENTSTAFFID] = @CLIENTSTAFFID">
        <DeleteParameters>
            <asp:Parameter Name="CLIENTSTAFFID" Type="Int32" />
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="CLIENTSTAFFFNAME" Type="String" />
            <asp:Parameter Name="CLIENTSTAFFLNAME" Type="String" />
            <asp:Parameter Name="CLIENTSTAFFTEL" Type="String" />
            <asp:Parameter Name="CLIENTSTAFFCELL" Type="String" />
            <asp:Parameter Name="CLIENTSTAFFEMAIL" Type="String" />
            <asp:Parameter Name="CLIENTSTAFFPOSITION" Type="String" />
            <asp:Parameter Name="CLIENTSTAFFSTATUS" Type="String" />
            <asp:Parameter Name="CLIENTID" Type="Int32" />
        </InsertParameters>
        <SelectParameters>
            <asp:QueryStringParameter Name="CLIENTSTAFFID" QueryStringField="id" Type="Int32" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="CLIENTSTAFFFNAME" Type="String" />
            <asp:Parameter Name="CLIENTSTAFFLNAME" Type="String" />
            <asp:Parameter Name="CLIENTSTAFFTEL" Type="String" />
            <asp:Parameter Name="CLIENTSTAFFCELL" Type="String" />
            <asp:Parameter Name="CLIENTSTAFFEMAIL" Type="String" />
            <asp:Parameter Name="CLIENTSTAFFPOSITION" Type="String" />
            <asp:Parameter Name="CLIENTSTAFFSTATUS" Type="String" />
            <asp:Parameter Name="CLIENTID" Type="Int32" />
            <asp:Parameter Name="CLIENTSTAFFID" Type="Int32" />
        </UpdateParameters>
    </asp:SqlDataSource>
    <script type="text/javascript">
        $.validate();
    </script>
</asp:Content>

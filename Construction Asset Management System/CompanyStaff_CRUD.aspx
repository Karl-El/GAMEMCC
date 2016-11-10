<%@ Page Title="Company Staff" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="CompanyStaff_CRUD.aspx.cs" Inherits="Construction_Asset_Management_System.CompanyStaff_CRUD" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <script src="Scripts/Form Validator/jquery.form-validator.js"></script>
    <link href="Scripts/Form Validator/theme-default.css" rel="stylesheet" type="text/css" />
    <asp:ListView ID="_listviewCompanyStaffCRUD" runat="server" DataKeyNames="COMSTAFFID" DataSourceID="DataSourceCompanyStaffCRUD" InsertItemPosition="LastItem" OnDataBound="_listviewCompanyStaffCRUD_DataBound" OnItemDeleted="_listviewCompanyStaffCRUD_ItemDeleted" OnItemInserted="_listviewCompanyStaffCRUD_ItemInserted" OnItemUpdated="_listviewCompanyStaffCRUD_ItemUpdated" OnItemInserting="_listviewCompanyStaffCRUD_ItemInserting" OnItemUpdating="_listviewCompanyStaffCRUD_ItemUpdating" OnItemDeleting="_listviewCompanyStaffCRUD_ItemDeleting">
        <EditItemTemplate>
            <span style="">
                <div class="well">
                    <h4>Update Company Staff</h4>
                    <label class="control-label">ID:</label>
                    <asp:Label ID="COMSTAFFIDLabel1" runat="server" Text='<%# Eval("COMSTAFFID") %>' />
                    <br />
                    <div class="row">
                        <p class="col-sm-4">
                            <label class="control-label">First Name:</label>
                            <asp:TextBox ID="COMSTAFFFRSTNAMETextBox" runat="server" Text='<%# Bind("COMSTAFFFRSTNAME") %>' CssClass="form-control"
                                data-validation="required custom"
                                data-validation-error-msg-required="You must enter a First Name"
                                data-validation-regexp="^([a-zA-Z '-.]+)$"
                                data-validation-error-msg-custom="Invalid input letters only. '-. characters is allowed" />
                        </p>
                        <p class="col-sm-4">
                            <label class="control-label">Last Name:</label>
                            <asp:TextBox ID="COMSTAFFLASTNAMETextBox" runat="server" Text='<%# Bind("COMSTAFFLASTNAME") %>' CssClass="form-control"
                                data-validation="required custom"
                                data-validation-error-msg-required="You must enter a Last Name"
                                data-validation-regexp="^([a-zA-Z '-.]+)$"
                                data-validation-error-msg-custom="Invalid input letters only. '-. characters is allowed" />
                        </p>
                        <p class="col-sm-4">
                            <label class="control-label">Position:</label>
                            <asp:TextBox ID="COMSTAFFPOSITIONTextBox" runat="server" Text='<%# Bind("COMSTAFFPOSITION") %>' CssClass="form-control"
                                data-validation="required custom"
                                data-validation-error-msg-required="You must enter your position"
                                data-validation-regexp="^([a-zA-Z '-.]+)$"
                                data-validation-error-msg-custom="Invalid input letters only. -_'@() characters is allowed" />
                        </p>
                    </div>
                    <hr />
                    <div class="row">
                        <div class="col-sm-4 pull-right">
                            <div class="col-xs-6">
                                <asp:Button ID="UpdateButton" runat="server" CommandName="Update" Text="Save" CssClass="btn btn-primary center-block col-xs-12" OnClick="UpdateButton_Click" />
                            </div>
                            <div class="col-xs-6">
                                <asp:Button ID="CancelButton" runat="server" CommandName="Cancel" Text="Cancel" CssClass="btn btn-danger center-block col-xs-12" OnClientClick=" window.location = '/CompanyStaff.aspx';this.form.reset();return false;" />
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
                    <h4>Add Company Staff</h4>
                    <div class="row">
                        <p class="col-sm-4">
                            <label class="control-label">First Name:</label>
                            <asp:TextBox ID="COMSTAFFFRSTNAMETextBox" runat="server" Text='<%# Bind("COMSTAFFFRSTNAME") %>' CssClass="form-control"
                                data-validation="required custom"
                                data-validation-error-msg-required="You must enter a First Name"
                                data-validation-regexp="^([a-zA-Z '-.]+)$"
                                data-validation-error-msg-custom="Invalid input letters only. '-. characters is allowed" />
                        </p>
                        <p class="col-sm-4">
                            <label class="control-label">Last Name:</label>
                            <asp:TextBox ID="COMSTAFFLASTNAMETextBox" runat="server" Text='<%# Bind("COMSTAFFLASTNAME") %>' CssClass="form-control"
                                data-validation="required custom"
                                data-validation-error-msg-required="You must enter a Last Name"
                                data-validation-regexp="^([a-zA-Z '-.]+)$"
                                data-validation-error-msg-custom="Invalid input letters only. '-. characters is allowed" />
                        </p>
                        <p class="col-sm-4">
                            <label class="control-label">Position:</label>
                            <asp:TextBox ID="COMSTAFFPOSITIONTextBox" runat="server" Text='<%# Bind("COMSTAFFPOSITION") %>' CssClass="form-control"
                                data-validation="required custom"
                                data-validation-error-msg-required="You must enter your position"
                                data-validation-regexp="^([a-zA-Z '-.]+)$"
                                data-validation-error-msg-custom="Invalid input letters only. -_'@() characters is allowed" />
                        </p>
                    </div>
                    <hr />
                    <div class="row">
                        <div class="row col-sm-4 pull-right">
                            <div class="col-xs-6">
                                <asp:Button ID="InsertButton" runat="server" CommandName="Insert" Text="Save" CssClass="btn btn-primary center-block col-xs-12" OnClick="InsertButton_Click" />
                            </div>
                            <div class="col-xs-6">
                                <asp:Button ID="CancelButton" runat="server" CommandName="Cancel" Text="Cancel" CssClass="btn btn-danger center-block col-xs-12" OnClientClick=" window.location = '/CompanyStaff.aspx';this.form.reset();return false;" />
                            </div>
                        </div>
                    </div>
                </div>
            </span>
        </InsertItemTemplate>
        <ItemTemplate>
            <span style="">
                <div class="well">
                    <h4>Company Staff Details</h4>
                    <label class="control-label">ID:</label>
                    <asp:Label ID="COMSTAFFIDLabel" runat="server" Text='<%# Eval("COMSTAFFID") %>' />
                    <br />
                    <label class="control-label">First Name:</label>
                    <asp:Label ID="COMSTAFFFRSTNAMELabel" runat="server" Text='<%# Eval("COMSTAFFFRSTNAME") %>' />
                    <br />
                    <label class="control-label">Last Name:</label>
                    <asp:Label ID="COMSTAFFLASTNAMELabel" runat="server" Text='<%# Eval("COMSTAFFLASTNAME") %>' />
                    <br />
                    <label class="control-label">Position:</label>
                    <asp:Label ID="COMSTAFFPOSITIONLabel" runat="server" Text='<%# Eval("COMSTAFFPOSITION") %>' />
                    <hr />
                    <div class="row">
                        <div class="col-sm-3 pull-right ">
                            <asp:Button ID="EditButton" runat="server" CommandName="Edit" Text="Edit" CssClass="btn btn-primary " />
                            <asp:Button ID="DeleteButton" runat="server" CommandName="Delete" Text="Delete" CssClass="btn btn-danger" />
                            <input type="button" value="Back" onclick="window.location = 'CompanyStaff.aspx';" class="btn btn-warning" />
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
                <asp:DataPager ID="DataPager1" runat="server" PageSize="1" Visible="false">
                    <Fields>
                        <asp:NextPreviousPagerField ButtonType="Button" ShowFirstPageButton="True" ShowNextPageButton="False" ShowPreviousPageButton="False" />
                        <asp:NumericPagerField NumericButtonCssClass="label label-success" CurrentPageLabelCssClass="badge"/>
                        <asp:NextPreviousPagerField ButtonType="Button" ShowLastPageButton="True" ShowNextPageButton="False" ShowPreviousPageButton="False" />
                    </Fields>
                </asp:DataPager>
            </div>
        </LayoutTemplate>
    </asp:ListView>
    <asp:SqlDataSource ID="DataSourceCompanyStaffCRUD" runat="server" ConnectionString="<%$ ConnectionStrings:ConnString_WEB_ASSET_DB %>" DeleteCommand="DELETE FROM [COMPANYSTAFF] WHERE [COMSTAFFID] = @COMSTAFFID" InsertCommand="INSERT INTO [COMPANYSTAFF] ([COMSTAFFFRSTNAME], [COMSTAFFLASTNAME], [COMSTAFFPOSITION]) VALUES (@COMSTAFFFRSTNAME, @COMSTAFFLASTNAME, @COMSTAFFPOSITION)" SelectCommand="SELECT [COMSTAFFID], [COMSTAFFFRSTNAME], [COMSTAFFLASTNAME], [COMSTAFFPOSITION] FROM [COMPANYSTAFF] WHERE ([COMSTAFFID] = @COMSTAFFID)" UpdateCommand="UPDATE [COMPANYSTAFF] SET [COMSTAFFFRSTNAME] = @COMSTAFFFRSTNAME, [COMSTAFFLASTNAME] = @COMSTAFFLASTNAME, [COMSTAFFPOSITION] = @COMSTAFFPOSITION WHERE [COMSTAFFID] = @COMSTAFFID">
        <DeleteParameters>
            <asp:Parameter Name="COMSTAFFID" Type="Int32" />
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="COMSTAFFFRSTNAME" Type="String" />
            <asp:Parameter Name="COMSTAFFLASTNAME" Type="String" />
            <asp:Parameter Name="COMSTAFFPOSITION" Type="String" />
        </InsertParameters>
        <SelectParameters>
            <asp:QueryStringParameter Name="COMSTAFFID" QueryStringField="id" Type="Int32" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="COMSTAFFFRSTNAME" Type="String" />
            <asp:Parameter Name="COMSTAFFLASTNAME" Type="String" />
            <asp:Parameter Name="COMSTAFFPOSITION" Type="String" />
            <asp:Parameter Name="COMSTAFFID" Type="Int32" />
        </UpdateParameters>
    </asp:SqlDataSource>
    <script type="text/javascript">
        $.validate();
    </script>
</asp:Content>

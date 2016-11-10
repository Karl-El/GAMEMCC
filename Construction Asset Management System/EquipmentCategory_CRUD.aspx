<%@ Page Title="Equipment Category" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="EquipmentCategory_CRUD.aspx.cs" Inherits="Construction_Asset_Management_System.EquipmentCategory_CRUD" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <script src="Scripts/Form Validator/jquery.form-validator.min.js"></script>
    <link href="Scripts/Form Validator/theme-default.min.css" rel="stylesheet" type="text/css" />
    <asp:ListView ID="_listviewEquipCtgryCRUD" runat="server" DataSourceID="DataSourceEquipCtgryCRUD" DataKeyNames="EQUIPCTGRYID" InsertItemPosition="LastItem" OnDataBound="_listviewEquipCtgryCRUD_DataBound" OnItemDeleted="_listviewEquipCtgryCRUD_ItemDeleted" OnItemInserted="_listviewEquipCtgryCRUD_ItemInserted" OnItemUpdated="_listviewEquipCtgryCRUD_ItemUpdated" OnItemInserting="_listviewEquipCtgryCRUD_ItemInserting" OnItemUpdating="_listviewEquipCtgryCRUD_ItemUpdating" OnItemDeleting="_listviewEquipCtgryCRUD_ItemDeleting">
        <EditItemTemplate>
            <span style="">
                <div class="well">
                    <h4>Update Equipment Category</h4>
                    <label class="control-label">ID:</label>
                    <div class="row">
                        <p class="col-sm-6">
                            <label class="control-label">Category Name:</label>
                            <asp:TextBox Text='<%# Bind("EQUIPCTGRYNAME") %>' runat="server" ID="EQUIPCTGRYNAMETextBox" CssClass="form-control"
                                data-validation="required custom"
                                data-validation-error-msg-required="You must enter a category name"
                                data-validation-regexp="^([a-zA-Z0-9-_'@ ]+)$"
                                data-validation-error-msg-custom="Invalid input alphanumeric only. -_'@ characters is allowed" />
                        </p>
                        <p class="col-sm-6">
                            <label class="control-label">Description:</label>
                            <asp:TextBox Text='<%# Bind("EQUIPCTGRYDESC") %>' runat="server" ID="EQUIPCTGRYDESCTextBox" CssClass="form-control"
                                data-validation="custom"
                                data-validation-regexp="^([a-zA-Z0-9-_'@ ]+)$"
                                data-validation-error-msg-custom="Invalid input alphanumeric only. -_'@ characters is allowed"
                                data-validation-optional="true" />
                        </p>
                    </div>
                    <hr />
                    <p>
                        <div class="row col-sm-4 pull-right">
                            <div class="col-xs-6">
                                <asp:Button ID="UpdateButton" runat="server" CommandName="Update" Text="Save" CssClass="btn btn-primary center-block col-xs-12" OnClick="UpdateButton_Click" />
                            </div>
                            <div class="col-xs-6">
                                <asp:Button ID="CancelButton" runat="server" CommandName="Cancel" Text="Cancel" CssClass="btn btn-danger center-block col-xs-12" OnClientClick="window.location = '/EquipmentCategory.aspx'; this.form.reset();return false;" />
                            </div>
                        </div>
                    </p>
                    <br />
                    <br />
                </div>
            </span>
        </EditItemTemplate>
        <EmptyDataTemplate>
            <span>No data was returned.</span>
        </EmptyDataTemplate>
        <InsertItemTemplate>
            <span style="">
                <div class="well">
                    <h4>Add Equipment Category</h4>
                    <div class="row">
                        <p class="col-sm-6">
                            <label class="control-label">Category Name:</label>
                            <asp:TextBox Text='<%# Bind("EQUIPCTGRYNAME") %>' runat="server" ID="EQUIPCTGRYNAMETextBox" CssClass="form-control"
                                data-validation="required custom"
                                data-validation-error-msg-required="You must enter a category name"
                                data-validation-regexp="^([a-zA-Z0-9-_'@ ]+)$"
                                data-validation-error-msg-custom="Invalid input alphanumeric only. -_'@ characters is allowed" />
                        </p>
                        <p class="col-sm-6">
                            <label class="control-label">Description:</label>
                            <asp:TextBox Text='<%# Bind("EQUIPCTGRYDESC") %>' runat="server" ID="EQUIPCTGRYDESCTextBox" CssClass="form-control"
                                data-validation="custom"
                                data-validation-regexp="^([a-zA-Z0-9-_'@ ]+)$"
                                data-validation-error-msg-custom="Invalid input alphanumeric only. -_'@ characters is allowed"
                                data-validation-optional="true" />
                        </p>
                    </div>
                    <hr />
                    <p>
                        <div class="row col-sm-4 pull-right">
                            <div class="col-xs-6">
                                <asp:Button ID="InsertButton" runat="server" CommandName="Insert" Text="Save" CssClass="btn btn-primary center-block col-xs-12" OnClick="InsertButton_Click" />

                            </div>
                            <div class="col-xs-6">
                                <asp:Button ID="CancelButton" runat="server" CommandName="Cancel" Text="Cancel" CssClass="btn btn-danger center-block col-xs-12" OnClientClick=" window.location = '/EquipmentCategory.aspx';this.form.reset();return false;" />
                            </div>
                        </div>
                    </p>
                    <br />
                    <br />
                </div>
            </span>
        </InsertItemTemplate>
        <ItemTemplate>
            <span style="">
                <div class="well">
                    <h4>Equipmet Category Details</h4>
                    <label class="control-label">ID:</label>
                    <asp:Label Text='<%# Eval("EQUIPCTGRYID") %>' runat="server" ID="EQUIPCTGRYIDLabel" />
                    <br />
                    <label class="control-label">Category Name:</label>
                    <asp:Label Text='<%# Eval("EQUIPCTGRYNAME") %>' runat="server" ID="EQUIPCTGRYNAMELabel" />
                    <br />
                    <label class="control-label">Description:</label>
                    <asp:Label Text='<%# Eval("EQUIPCTGRYDESC") %>' runat="server" ID="EQUIPCTGRYDESCLabel" />
                    <hr />
                    <div class="row">
                        <div class="col-sm-3 pull-right">
                            <asp:Button ID="EditButton" runat="server" CommandName="Edit" Text="Edit" CssClass="btn btn-primary" />
                            <span onclick="return confirm('Are you sure to delete?')">
                                <asp:Button ID="DeleteButton" runat="server" CommandName="Delete" Text="Delete" CssClass="btn btn-danger" />
                            </span>
                            <input type="button" value="Back" onclick="window.location = 'EquipmentCategory.aspx';" class="btn btn-warning" />
                        </div>
                    </div>
                </div>
            </span>
        </ItemTemplate>
        <LayoutTemplate>
            <div runat="server" id="itemPlaceholderContainer" style=""><span runat="server" id="itemPlaceholder" /></div>
            <div style="">
                <asp:DataPager runat="server" ID="DataPager1" PageSize="1" Visible="false">
                    <Fields>
                        <asp:NextPreviousPagerField ButtonType="Button" ShowFirstPageButton="True" ShowNextPageButton="False" ShowPreviousPageButton="False"></asp:NextPreviousPagerField>
                        <asp:NumericPagerField></asp:NumericPagerField>
                        <asp:NextPreviousPagerField ButtonType="Button" ShowLastPageButton="True" ShowNextPageButton="False" ShowPreviousPageButton="False"></asp:NextPreviousPagerField>
                    </Fields>
                </asp:DataPager>

            </div>
        </LayoutTemplate>
    </asp:ListView>
    <asp:SqlDataSource runat="server" ID="DataSourceEquipCtgryCRUD" ConnectionString='<%$ ConnectionStrings:ConnString_WEB_ASSET_DB %>' SelectCommand="SELECT [EQUIPCTGRYID], [EQUIPCTGRYNAME], [EQUIPCTGRYDESC] FROM [EQUIPCTGRY] WHERE ([EQUIPCTGRYID] = @EQUIPCTGRYID)" DeleteCommand="DELETE FROM [EQUIPCTGRY] WHERE [EQUIPCTGRYID] = @EQUIPCTGRYID" InsertCommand="INSERT INTO [EQUIPCTGRY] ([EQUIPCTGRYNAME], [EQUIPCTGRYDESC]) VALUES (@EQUIPCTGRYNAME, @EQUIPCTGRYDESC)" UpdateCommand="UPDATE [EQUIPCTGRY] SET [EQUIPCTGRYNAME] = @EQUIPCTGRYNAME, [EQUIPCTGRYDESC] = @EQUIPCTGRYDESC WHERE [EQUIPCTGRYID] = @EQUIPCTGRYID">
        <DeleteParameters>
            <asp:Parameter Name="EQUIPCTGRYID" Type="Int32"></asp:Parameter>
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="EQUIPCTGRYNAME" Type="String"></asp:Parameter>
            <asp:Parameter Name="EQUIPCTGRYDESC" Type="String"></asp:Parameter>
        </InsertParameters>
        <SelectParameters>
            <asp:QueryStringParameter QueryStringField="id" Name="EQUIPCTGRYID" Type="Int32"></asp:QueryStringParameter>
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="EQUIPCTGRYNAME" Type="String"></asp:Parameter>
            <asp:Parameter Name="EQUIPCTGRYDESC" Type="String"></asp:Parameter>
            <asp:Parameter Name="EQUIPCTGRYID" Type="Int32"></asp:Parameter>
        </UpdateParameters>
    </asp:SqlDataSource>
    <script type="text/javascript">
        $.validate();
    </script>
</asp:Content>

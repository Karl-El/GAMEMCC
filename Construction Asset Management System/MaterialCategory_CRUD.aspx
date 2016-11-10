<%@ Page Title="Material Category" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="MaterialCategory_CRUD.aspx.cs" Inherits="Construction_Asset_Management_System.MaterialCategoryCRUD" %>


<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <script src="Scripts/Form Validator/jquery.form-validator.min.js"></script>
    <link href="Scripts/Form Validator/theme-default.min.css" rel="stylesheet" type="text/css" />
    <asp:ListView ID="_listviewMtrlCtgryCrud" runat="server" DataKeyNames="MATERIALCTGRYID" DataSourceID="DataSourceMaterialCtgryCRUD" InsertItemPosition="LastItem" OnItemDeleted="_listviewMtrlCtgryCrud_ItemDeleted" OnItemUpdated="_listviewMtrlCtgryCrud_ItemUpdated" OnItemInserted="_listviewMtrlCtgryCrud_ItemInserted" OnDataBound="_listviewMtrlCtgryCrud_DataBound" OnItemInserting="_listviewMtrlCtgryCrud_ItemInserting" OnItemUpdating="_listviewMtrlCtgryCrud_ItemUpdating">
        <EditItemTemplate>
            <span style="">
                <div class="well">
                    <h4>Update Material Category</h4>
                    <label class="control-label">ID:</label>
                    <asp:Label ID="MATERIALCTGRYIDLabel1" runat="server" Text='<%# Eval("MATERIALCTGRYID") %>' />
                    <br />
                    <div class="row">
                        <p class="col-sm-6">
                            <label class="control-label">Category Name:</label>
                            <asp:TextBox ID="MATERIALCTGRYNAMETextBox" runat="server" Text='<%# Bind("MATERIALCTGRYNAME") %>' CssClass="form-control"
                                data-validation="required custom"
                                data-validation-error-msg-required="You must enter a category name"
                                data-validation-regexp="^([a-zA-Z0-9-_'@ ]+)$"
                                data-validation-error-msg-custom="Invalid input alphanumeric only. -_'@ characters is allowed" />
                        </p>
                        <p class="col-sm-6">
                            <label class="control-label">Description:</label>
                            <asp:TextBox ID="MATERIALCTGRYDESCTextBox" runat="server" Text='<%# Bind("MATERIALCTGRYDESC") %>' CssClass="form-control"
                                data-validation="custom"
                                data-validation-regexp="^([a-zA-Z0-9-_'@ ]+)$"
                                data-validation-error-msg-custom="Invalid input alphanumeric only. -_'@ characters is allowed"
                                data-validation-optional="true" />
                        </p>
                    </div>
                    <hr />
                    <div class="row col-sm-4 pull-right">
                        <div class="col-xs-6">
                            <asp:Button ID="UpdateButton" runat="server" CommandName="Update" Text="Save" CssClass="btn btn-primary center-block col-xs-12" OnClick="UpdateButton_Click" />
                        </div>
                        <div class="col-xs-6">
                            <asp:Button ID="CancelButton" runat="server" CommandName="Cancel" Text="Cancel" CssClass="btn btn-danger center-block col-xs-12" OnClientClick="window.location = '/MaterialCategory.aspx'; this.form.reset();return false;" />
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
            <span style="">
                <div class="well">
                    <h4>Add Material Category</h4>
                    <div class="row">
                        <p class="col-sm-6">
                            <label class="control-label">Category Name:</label>
                            <asp:TextBox ID="MATERIALCTGRYNAMETextBox" runat="server" Text='<%# Bind("MATERIALCTGRYNAME") %>' CssClass="form-control"
                                data-validation="required custom"
                                data-validation-error-msg-required="You must enter a category name"
                                data-validation-regexp="^([a-zA-Z0-9-_'@ ]+)$"
                                data-validation-error-msg-custom="Invalid input alphanumeric only. -_'@ characters is allowed" />
                        </p>
                        <p class="col-sm-6">
                            <label class="control-label">Description:</label>
                            <asp:TextBox ID="MATERIALCTGRYDESCTextBox" runat="server" Text='<%# Bind("MATERIALCTGRYDESC") %>' CssClass="form-control"
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
                                <asp:Button ID="CancelButton" runat="server" CommandName="Cancel" Text="Cancel" CssClass="btn btn-danger center-block col-xs-12" OnClientClick=" window.location = '/MaterialCategory.aspx';this.form.reset();return false;" />
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
                    <h4>Material Category Details</h4>
                    <label class="control-label">ID:</label>
                    <asp:Label ID="MATERIALCTGRYIDLabel" runat="server" Text='<%# Eval("MATERIALCTGRYID") %>' />
                    <br />
                    <label class="control-label">Category Name:</label>
                    <asp:Label ID="MATERIALCTGRYNAMELabel" runat="server" Text='<%# Eval("MATERIALCTGRYNAME") %>' />
                    <br />
                    <label class="control-label">Description:</label>
                    <asp:Label ID="MATERIALCTGRYDESCLabel" runat="server" Text='<%# Eval("MATERIALCTGRYDESC") %>' />
                    <hr />
                    <div class="row">
                        <div class="col-sm-3 pull-right">
                            <asp:Button ID="EditButton" runat="server" CommandName="Edit" Text="Edit" CssClass="btn btn-primary" />
                            <span onclick="return confirm('Are you sure to delete?')">
                                <asp:Button ID="DeleteButton" runat="server" CommandName="Delete" Text="Delete" CssClass="btn btn-danger" />
                            </span>
                            <input type="button" value="Back" onclick="window.location = 'MaterialCategory.aspx';" class="btn btn-warning" />
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

    <asp:SqlDataSource ID="DataSourceMaterialCtgryCRUD" runat="server" ConnectionString="<%$ ConnectionStrings:ConnString_WEB_ASSET_DB %>" DeleteCommand="DELETE FROM [MATERIALCTGRY] WHERE [MATERIALCTGRYID] = @MATERIALCTGRYID" InsertCommand="INSERT INTO [MATERIALCTGRY] ([MATERIALCTGRYNAME], [MATERIALCTGRYDESC]) VALUES (@MATERIALCTGRYNAME, @MATERIALCTGRYDESC)" SelectCommand="SELECT * FROM [MATERIALCTGRY] WHERE ([MATERIALCTGRYID] = @MATERIALCTGRYID)" UpdateCommand="UPDATE [MATERIALCTGRY] SET [MATERIALCTGRYNAME] = @MATERIALCTGRYNAME, [MATERIALCTGRYDESC] = @MATERIALCTGRYDESC WHERE [MATERIALCTGRYID] = @MATERIALCTGRYID">
        <DeleteParameters>
            <asp:Parameter Name="MATERIALCTGRYID" Type="Int32" />
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="MATERIALCTGRYNAME" Type="String" />
            <asp:Parameter Name="MATERIALCTGRYDESC" Type="String" />
        </InsertParameters>
        <SelectParameters>
            <asp:QueryStringParameter Name="MATERIALCTGRYID" QueryStringField="id" Type="Int32" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="MATERIALCTGRYNAME" Type="String" />
            <asp:Parameter Name="MATERIALCTGRYDESC" Type="String" />
            <asp:Parameter Name="MATERIALCTGRYID" Type="Int32" />
        </UpdateParameters>
    </asp:SqlDataSource>
    <br />

    <script type="text/javascript">
        $.validate();
    </script>

</asp:Content>

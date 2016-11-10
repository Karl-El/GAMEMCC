<%@ Page Title="Material" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Material_CRUD.aspx.cs" Inherits="Construction_Asset_Management_System.MaterialCRUD" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <script src="Scripts/Form Validator/jquery.form-validator.js"></script>
    <link href="Scripts/Form Validator/theme-default.css" rel="stylesheet" type="text/css" />
    <asp:ListView ID="_listviewMaterialCRUD" runat="server" DataKeyNames="MATERIALID" DataSourceID="DataSourceMaterialCRUD" InsertItemPosition="LastItem" OnDataBound="_listviewMaterialCRUD_DataBound" OnItemDeleted="_listviewMaterialCRUD_ItemDeleted" OnItemInserted="_listviewMaterialCRUD_ItemInserted" OnItemUpdated="_listviewMaterialCRUD_ItemUpdated" OnItemInserting="_listviewMaterialCRUD_ItemInserting" OnItemUpdating="_listviewMaterialCRUD_ItemUpdating">
        <EditItemTemplate>
            <span style="">
                <div class="well">
                    <h4>Update Material</h4>
                    <div class="row">
                        <asp:Image runat="server" ImageUrl='<%# Eval("MATERIALIMG") %>' CssClass="img-responsive img-thumbnail center-block" AlternateText="Not Available" Width="200" Height="200" />
                    </div>
                    <div class="row">
                        <p class="col-sm-3">
                            <label class="control-label">ID:</label>
                            <asp:Label ID="MATERIALIDLabel1" runat="server" Text='<%# Eval("MATERIALID") %>' />
                        </p>
                    </div>
                    <div class="row">
                        <p class="col-sm-3">
                            <label class="control-label">Name:</label>
                            <asp:TextBox ID="MATERIALNAMETextBox" runat="server" Text='<%# Bind("MATERIALNAME") %>' CssClass="form-control"
                                data-validation="required custom"
                                data-validation-error-msg-required="You must enter a material name"
                                data-validation-regexp="^([a-zA-Z0-9-_'@ ]+)$"
                                data-validation-error-msg-custom="Invalid input alphanumeric only. -_'@ characters is allowed" />
                        </p>
                        <p class="col-sm-3">
                            <label class="control-label">Description:</label>
                            <asp:TextBox ID="MATERIALDESCTextBox" runat="server" Text='<%# Bind("MATERIALDESC") %>' CssClass="form-control"
                                data-validation="custom"
                                data-validation-regexp="^([a-zA-Z0-9-_'@ ]+)$"
                                data-validation-error-msg-custom="Invalid input alphanumeric only. -_'@ characters is allowed"
                                data-validation-optional="true" />
                        </p>
                        <p class="col-sm-3">
                            <label class="control-label">Material Category:</label>
                            <asp:DropDownList ID="_dropdownMtrlCtgry" runat="server" SelectedValue='<%# Bind("MATERIALCTGRYID") %>' AppendDataBoundItems="true" DataSourceID="DataSourceMtrlCtgryDDList" DataTextField="MATERIALCTGRYNAME" DataValueField="MATERIALCTGRYID" CssClass="form-control"
                                data-validation="required"
                                data-validation-error-msg-required="You must select a Category">
                                <asp:ListItem Value=" "> -- please select a Category -- </asp:ListItem>
                            </asp:DropDownList>
                            <asp:SqlDataSource ID="DataSourceMtrlCtgryDDList" runat="server" ConnectionString="<%$ ConnectionStrings:ConnString_WEB_ASSET_DB %>" SelectCommand="SELECT [MATERIALCTGRYID], [MATERIALCTGRYNAME] FROM [MATERIALCTGRY]"></asp:SqlDataSource>
                        </p>
                        <p class="col-sm-3">
                            <label class="control-label">Add Image:</label>
                            <asp:FileUpload ID="_fileupImage" runat="server" />
                            <%--<asp:Button ID="_btnUpload" runat="server" Text="Upload" CssClass="btn btn-success" OnClick="_btnUpload_Click1" />--%>
                            <asp:TextBox ID="MATERIALIMGTextBox" runat="server" Text='<%# Bind("MATERIALIMG") %>' CssClass="form-control" Visible="false"
                                data-validation="custom"
                                data-validation-optional="true" />
                        </p>
                    </div>
                    <hr />
                    <div class="row">
                        <div class=" col-sm-4 pull-right">
                            <div class="col-xs-6">
                                <asp:Button ID="UpdateButton" runat="server" CommandName="Update" Text="Save" CssClass="btn btn-primary center-block col-xs-12" OnClick="UpdateButton_Click" />
                            </div>
                            <div class="col-xs-6">
                                <asp:Button ID="CancelButton" runat="server" CommandName="Cancel" Text="Cancel" CssClass="btn btn-danger center-block col-xs-12" OnClientClick="window.location = '/Material.aspx'; this.form.reset();return false;" />
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
                    <h4>Add Material</h4>
                    <%--<asp:Image runat="server" ImageUrl="..." CssClass="img-responsive img-thumbnail center-block" AlternateText="Not Available" Width="200" Height="200" />--%>
                    <div class="row">
                        <p class="col-sm-3">
                            <label class="control-label">Name:</label>
                            <asp:TextBox ID="MATERIALNAMETextBox" runat="server" Text='<%# Bind("MATERIALNAME") %>' CssClass="form-control"
                                data-validation="required custom"
                                data-validation-error-msg-required="You must enter a material name"
                                data-validation-regexp="^([a-zA-Z0-9-_'@ ]+)$"
                                data-validation-error-msg-custom="Invalid input alphanumeric only. -_'@ characters is allowed" />
                        </p>
                        <p class="col-sm-3">
                            <label class="control-label">Description:</label>
                            <asp:TextBox ID="MATERIALDESCTextBox" runat="server" Text='<%# Bind("MATERIALDESC") %>' CssClass="form-control"
                                data-validation="custom"
                                data-validation-regexp="^([a-zA-Z0-9-_'@ ]+)$"
                                data-validation-error-msg-custom="Invalid input alphanumeric only. -_'@ characters is allowed"
                                data-validation-optional="true" />
                        </p>
                        <p class="col-sm-3">
                            <label class="control-label">Material Category:</label>
                            <asp:DropDownList ID="_dropdownMtrlCtgry" runat="server" SelectedValue='<%# Bind("MATERIALCTGRYID") %>' AppendDataBoundItems="true" DataSourceID="DataSourceMtrlCtgryDDList" DataTextField="MATERIALCTGRYNAME" DataValueField="MATERIALCTGRYID" CssClass="form-control"
                                data-validation="required"
                                data-validation-error-msg-required="You must select a Category">
                                <asp:ListItem Value=" "> -- please select a Category -- </asp:ListItem>
                            </asp:DropDownList>
                            <asp:SqlDataSource ID="DataSourceMtrlCtgryDDList" runat="server" ConnectionString="<%$ ConnectionStrings:ConnString_WEB_ASSET_DB %>" SelectCommand="SELECT [MATERIALCTGRYID], [MATERIALCTGRYNAME] FROM [MATERIALCTGRY]"></asp:SqlDataSource>
                        </p>
                        <p class="col-sm-3">
                            <label class="control-label">Add Image:</label>
                            <asp:FileUpload ID="_fileupImage" runat="server" />
                            <%--<asp:Button ID="_btnUpload" runat="server" Text="Upload" CssClass="btn btn-success" OnClick="_btnUpload_Click" />--%>
                            <asp:TextBox ID="MATERIALIMGTextBox" runat="server" Text='<%# Bind("MATERIALIMG") %>' CssClass="form-control" Visible="false"
                                data-validation="custom"
                                data-validation-optional="true" />
                        </p>
                    </div>
                    <hr />
                    <div class="row">
                        <div class="col-sm-4 pull-right">
                            <div class="col-xs-6">
                                <asp:Button ID="InsertButton" runat="server" CommandName="Insert" Text="Save" CssClass="btn btn-primary center-block col-xs-12" OnClick="InsertButton_Click" />
                            </div>
                            <div class="col-xs-6">
                                <asp:Button ID="CancelButton" runat="server" CommandName="Cancel" Text="Cancel" CssClass="btn btn-danger center-block col-xs-12" OnClientClick=" window.location = '/Material.aspx';this.form.reset();return false;" />
                            </div>
                        </div>
                    </div>
                    <br />
                </div>
            </span>
        </InsertItemTemplate>
        <ItemTemplate>
            <span style="">
                <div class="well">
                    <h4>Material Details</h4>
                    <div class="row">
                        <div class="col-sm-6">
                            <div class="img-rounded ">
                                <asp:Image runat="server" ImageUrl='<%# Eval("MATERIALIMG") %>' CssClass="img-responsive img-thumbnail" AlternateText="Not Available" Width="304" Height="236" />
                            </div>
                        </div>
                        <div class="col-sm-6">
                            <label class="control-label">ID:</label>
                            <asp:Label ID="MATERIALIDLabel" runat="server" Text='<%# Eval("MATERIALID") %>' />
                            <br />
                            <label class="control-label">ID:</label>
                            <asp:Label ID="MATERIALNAMELabel" runat="server" Text='<%# Eval("MATERIALNAME") %>' />
                            <br />
                            <label class="control-label">Description:</label>
                            <asp:Label ID="MATERIALDESCLabel" runat="server" Text='<%# Eval("MATERIALDESC") %>' />
                            <br />
                            <label class="control-label">Image URL:</label>
                            <asp:Label ID="MATERIALIMGLabel" runat="server" Text='<%# Eval("MATERIALIMG") %>' />
                            <br />
                            <label class="control-label">Material Category:</label>
                            <asp:Label ID="MATERIALCTGRYIDLabel" runat="server" Text='<%# Eval("MATERIALCTGRYNAME") %>' />
                        </div>
                    </div>
                    <hr />
                    <div class="row">
                        <div class="col-sm-3 pull-right">
                            <asp:Button ID="EditButton" runat="server" CommandName="Edit" Text="Edit" CssClass="btn btn-primary " />
                            <span onclick="return confirm('Are you sure to delete?')">
                                <asp:Button ID="DeleteButton" runat="server" CommandName="Delete" Text="Delete" CssClass="btn btn-danger" />
                            </span>
                            <input type="button" value="Back" onclick="window.location = 'Material.aspx';" class="btn btn-warning" />
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


    <asp:SqlDataSource ID="DataSourceMaterialCRUD" runat="server" ConnectionString="<%$ ConnectionStrings:ConnString_WEB_ASSET_DB %>" DeleteCommand="DELETE FROM [MATERIAL] WHERE [MATERIALID] = @MATERIALID" InsertCommand="INSERT INTO [MATERIAL] ([MATERIALNAME], [MATERIALDESC], [MATERIALIMG], [MATERIALCTGRYID]) VALUES (@MATERIALNAME, @MATERIALDESC, @MATERIALIMG, @MATERIALCTGRYID)" SelectCommand="SELECT MATERIAL.MATERIALID, MATERIAL.MATERIALNAME, MATERIAL.MATERIALDESC, MATERIAL.MATERIALIMG, MATERIAL.MATERIALCTGRYID, MATERIALCTGRY.MATERIALCTGRYNAME FROM MATERIAL INNER JOIN MATERIALCTGRY ON MATERIAL.MATERIALCTGRYID = MATERIALCTGRY.MATERIALCTGRYID WHERE ([MATERIALID] = @MATERIALID)" UpdateCommand="UPDATE [MATERIAL] SET [MATERIALNAME] = @MATERIALNAME, [MATERIALDESC] = @MATERIALDESC, [MATERIALIMG] = @MATERIALIMG, [MATERIALCTGRYID] = @MATERIALCTGRYID WHERE [MATERIALID] = @MATERIALID">
        <DeleteParameters>
            <asp:Parameter Name="MATERIALID" Type="Int32" />
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="MATERIALNAME" Type="String" />
            <asp:Parameter Name="MATERIALDESC" Type="String" />
            <asp:Parameter Name="MATERIALIMG" Type="String" />
            <asp:Parameter Name="MATERIALCTGRYID" Type="Int32" />
        </InsertParameters>
        <SelectParameters>
            <asp:QueryStringParameter Name="MATERIALID" QueryStringField="id" Type="Int32" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="MATERIALNAME" Type="String" />
            <asp:Parameter Name="MATERIALDESC" Type="String" />
            <asp:Parameter Name="MATERIALIMG" Type="String" />
            <asp:Parameter Name="MATERIALCTGRYID" Type="Int32" />
            <asp:Parameter Name="MATERIALID" Type="Int32" />
        </UpdateParameters>
    </asp:SqlDataSource>
    <script type="text/javascript">
        $.validate();
    </script>
</asp:Content>

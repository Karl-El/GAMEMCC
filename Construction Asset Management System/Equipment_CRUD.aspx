<%@ Page Title="Equipment" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Equipment_CRUD.aspx.cs" Inherits="Construction_Asset_Management_System.Equipment_CRUD" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <script src="Scripts/Form Validator/jquery.form-validator.js"></script>
    <link href="Scripts/Form Validator/theme-default.css" rel="stylesheet" type="text/css" />
    <asp:ListView ID="_listviewEquipmentCRUD" runat="server" DataSourceID="DataSourceEquipmentCRUD" DataKeyNames="EQUIPMENTID" InsertItemPosition="LastItem" OnDataBound="_listviewEquipmentCRUD_DataBound" OnItemDeleted="_listviewEquipmentCRUD_ItemDeleted" OnItemInserted="_listviewEquipmentCRUD_ItemInserted" OnItemInserting="_listviewEquipmentCRUD_ItemInserting" OnItemUpdated="_listviewEquipmentCRUD_ItemUpdated" OnItemUpdating="_listviewEquipmentCRUD_ItemUpdating">
        <EditItemTemplate>
            <span style="">
                <div class="well">
                    <h4>Update Equipment</h4>
                    <div class="row">
                        <asp:Image runat="server" ImageUrl='<%# Eval("EQUIPMENTIMG") %>' CssClass="img-responsive img-thumbnail center-block" AlternateText="Not Available" Width="200" Height="200" />
                    </div>
                    <div class="row">
                        <p class="col-sm-4">
                            <label class="control-label">ID:</label>
                            <asp:Label ID="EQUIPMENTIDLabel" runat="server" Text='<%# Eval("EQUIPMENTID") %>' />
                        </p>
                    </div>
                    <div class="row">
                        <p class="col-sm-4">
                            <label class="control-label">Name:</label>
                            <asp:TextBox Text='<%# Bind("EQUIPMENTNAME") %>' runat="server" ID="EQUIPMENTNAMETextBox" CssClass="form-control"
                                data-validation="required custom"
                                data-validation-error-msg-required="You must enter a material name"
                                data-validation-regexp="^([a-zA-Z0-9-_'@ ]+)$"
                                data-validation-error-msg-custom="Invalid input alphanumeric only. -_'@ characters is allowed" />
                        </p>
                        <p class="col-sm-4">
                            <label class="control-label">Description:</label>
                            <asp:TextBox Text='<%# Bind("EQUIPMENTDESC") %>' runat="server" ID="EQUIPMENTDESCTextBox" CssClass="form-control"
                                data-validation="custom"
                                data-validation-regexp="^([a-zA-Z0-9-_'@ ]+)$"
                                data-validation-error-msg-custom="Invalid input alphanumeric only. -_'@ characters is allowed"
                                data-validation-optional="true" />
                        </p>
                        <p class="col-sm-4">
                            <label class="control-label">Equipment Category:</label>
                            <asp:DropDownList ID="_dropdownEquipCtgry" runat="server" SelectedValue='<%# Bind("EQUIPCTGRYID") %>' AppendDataBoundItems="true" DataSourceID="DataSourceEquipCtgryDDList" DataTextField="EQUIPCTGRYNAME" DataValueField="EQUIPCTGRYID" CssClass="form-control"
                                data-validation="required"
                                data-validation-error-msg-required="You must select a Category">
                                <asp:ListItem Value=" "> -- please select a Category -- </asp:ListItem>
                            </asp:DropDownList>
                            <asp:TextBox Text='<%# Bind("EQUIPMENTIMG") %>' runat="server" ID="EQUIPMENTIMGTextBox" Visible="false" />
                            <asp:SqlDataSource runat="server" ID="DataSourceEquipCtgryDDList" ConnectionString='<%$ ConnectionStrings:ConnString_WEB_ASSET_DB %>' SelectCommand="SELECT [EQUIPCTGRYID], [EQUIPCTGRYNAME] FROM [EQUIPCTGRY]"></asp:SqlDataSource>
                        </p>
                        <%--<p class="col-sm-3">
                            <label class="control-label">Add Image:</label>
                            <asp:FileUpload ID="_fileupImage" runat="server" />
                            <asp:TextBox Text='<%# Bind("EQUIPMENTIMG") %>' runat="server" ID="EQUIPMENTIMGTextBox" Visible="false" />
                        </p>--%>
                    </div>
                    <hr />
                    <div class="row">
                        <div class=" col-sm-4 pull-right">
                            <div class="col-xs-6">
                                <asp:Button ID="UpdateButton" runat="server" CommandName="Update" Text="Save" CssClass="btn btn-primary center-block col-xs-12" OnClick="UpdateButton_Click" />
                            </div>
                            <div class="col-xs-6">
                                <asp:Button ID="CancelButton" runat="server" CommandName="Cancel" Text="Cancel" CssClass="btn btn-danger center-block col-xs-12" OnClientClick="window.location = '/Equipment.aspx'; this.form.reset();return false;" />
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
                    <h4>Add Equipment</h4>
                    <div class="row">
                        <p class="col-sm-4">
                            <label class="control-label">Name:</label>
                            <asp:TextBox Text='<%# Bind("EQUIPMENTNAME") %>' runat="server" ID="EQUIPMENTNAMETextBox" CssClass="form-control"
                                data-validation="required custom"
                                data-validation-error-msg-required="You must enter a material name"
                                data-validation-regexp="^([a-zA-Z0-9-_'@ ]+)$"
                                data-validation-error-msg-custom="Invalid input alphanumeric only. -_'@ characters is allowed" />
                        </p>
                        <p class="col-sm-4">
                            <label class="control-label">Description:</label>
                            <asp:TextBox Text='<%# Bind("EQUIPMENTDESC") %>' runat="server" ID="EQUIPMENTDESCTextBox" CssClass="form-control"
                                data-validation="custom"
                                data-validation-regexp="^([a-zA-Z0-9-_'@ ]+)$"
                                data-validation-error-msg-custom="Invalid input alphanumeric only. -_'@ characters is allowed"
                                data-validation-optional="true" />

                        </p>
                        <p class="col-sm-4">
                            <label class="control-label">Equipment Category:</label>
                            <asp:DropDownList ID="_dropdownEquipCtgry" runat="server" SelectedValue='<%# Bind("EQUIPCTGRYID") %>' AppendDataBoundItems="true" DataSourceID="DataSourceEquipCtgryDDList" DataTextField="EQUIPCTGRYNAME" DataValueField="EQUIPCTGRYID" CssClass="form-control"
                                data-validation="required"
                                data-validation-error-msg-required="You must select a Category">
                                <asp:ListItem Value=" "> -- please select a Category -- </asp:ListItem>
                            </asp:DropDownList>
                            <asp:TextBox Text='<%# Bind("EQUIPMENTIMG") %>' runat="server" ID="EQUIPMENTIMGTextBox" Visible="false" />
                            <asp:SqlDataSource runat="server" ID="DataSourceEquipCtgryDDList" ConnectionString='<%$ ConnectionStrings:ConnString_WEB_ASSET_DB %>' SelectCommand="SELECT [EQUIPCTGRYID], [EQUIPCTGRYNAME] FROM [EQUIPCTGRY]"></asp:SqlDataSource>
                        </p>
                        <%--<p class="col-sm-3">
                            <label class="control-label">Add Image:</label>
                            <asp:FileUpload ID="_fileupImage" runat="server" />
                            <asp:TextBox Text='<%# Bind("EQUIPMENTIMG") %>' runat="server" ID="EQUIPMENTIMGTextBox" Visible="false" />
                        </p>--%>
                    </div>
                    <hr />
                    <div class="row">
                        <div class="col-sm-4 pull-right">
                            <div class="col-xs-6">
                                <asp:Button ID="InsertButton" runat="server" CommandName="Insert" Text="Save" CssClass="btn btn-primary center-block col-xs-12" OnClick="InsertButton_Click" />
                            </div>
                            <div class="col-xs-6">
                                <asp:Button ID="CancelButton" runat="server" CommandName="Cancel" Text="Cancel" CssClass="btn btn-danger center-block col-xs-12" OnClientClick=" window.history.go(-1);this.form.reset();return false;" />
                            </div>
                        </div>
                    </div>
                    <br />
                </div>
            </span>
        </InsertItemTemplate>
        <ItemTemplate>
            <span style="">
                <div class="row">

                    <div class="row">
                        <div class="col-sm-4"></div>
                        <div class="col-sm-4">
                            <div class="well">
                                <h4>Equipment Details</h4>
                                <div class="row">
                                    <asp:Image runat="server" ImageUrl='<%# Eval("EQUIPMENTIMG") %>' CssClass="img-responsive center-block img-thumbnail" AlternateText="Not Available" Width="200" Height="200" />
                                    <label class="control-label">ID:</label>
                                    <asp:Label Text='<%# Eval("EQUIPMENTID") %>' runat="server" ID="EQUIPMENTIDLabel" />
                                    <br />
                                    <label class="control-label">Equipment Name:</label>
                                    <asp:Label Text='<%# Eval("EQUIPMENTNAME") %>' runat="server" ID="EQUIPMENTNAMELabel" />
                                    <br />
                                    <label class="control-label">Description:</label>
                                    <asp:Label Text='<%# Eval("EQUIPMENTDESC") %>' runat="server" ID="EQUIPMENTDESCLabel" />
                                    <br />
                                    <%-- <label class="control-label">Image URL:</label>
                            <asp:Label Text='<%# Eval("EQUIPMENTIMG") %>' runat="server" ID="EQUIPMENTIMGLabel" />
                            <br />--%>
                                    <label class="control-label">Material Category:</label>
                                    <asp:Label Text='<%# Eval("EQUIPCTGRYNAME") %>' runat="server" ID="EQUIPCTGRYIDLabel" />
                                    <br />
                                </div>
                                <hr />
                                <div class="row">
                                    <div class="pull-right">
                                        <asp:Button ID="EditButton" runat="server" CommandName="Edit" Text="Edit" CssClass="btn btn-primary " />
                                        <span onclick="return confirm('Are you sure to delete?')">
                                            <asp:Button ID="DeleteButton" runat="server" CommandName="Delete" Text="Delete" CssClass="btn btn-danger" />
                                        </span>
                                        <input type="button" value="Back" onclick="window.location = 'Equipment.aspx';" class="btn btn-warning" />
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-sm-4"></div>
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
    <asp:SqlDataSource runat="server" ID="DataSourceEquipmentCRUD" ConnectionString='<%$ ConnectionStrings:ConnString_WEB_ASSET_DB %>' DeleteCommand="DELETE FROM [EQUIPMENT] WHERE [EQUIPMENTID] = @EQUIPMENTID" InsertCommand="INSERT INTO [EQUIPMENT] ([EQUIPMENTNAME], [EQUIPMENTDESC], [EQUIPMENTIMG], [EQUIPCTGRYID],QUANTITY,INUSE,STOCK) VALUES (@EQUIPMENTNAME, @EQUIPMENTDESC, @EQUIPMENTIMG, @EQUIPCTGRYID,'0','0','0')" SelectCommand="SELECT  EQUIPMENTID, EQUIPMENTNAME, EQUIPMENTDESC, EQUIPMENTIMG, EQUIPMENT.EQUIPCTGRYID, EQUIPCTGRY.EQUIPCTGRYNAME FROM [EQUIPMENT] JOIN  EQUIPCTGRY ON EQUIPMENT.EQUIPCTGRYID = EQUIPCTGRY.EQUIPCTGRYID WHERE ([EQUIPMENTID] = @EQUIPMENTID)" UpdateCommand="UPDATE [EQUIPMENT] SET [EQUIPMENTNAME] = @EQUIPMENTNAME, [EQUIPMENTDESC] = @EQUIPMENTDESC, [EQUIPMENTIMG] = @EQUIPMENTIMG, [EQUIPCTGRYID] = @EQUIPCTGRYID WHERE [EQUIPMENTID] = @EQUIPMENTID">
        <DeleteParameters>
            <asp:Parameter Name="EQUIPMENTID" Type="Int32"></asp:Parameter>
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="EQUIPMENTNAME" Type="String"></asp:Parameter>
            <asp:Parameter Name="EQUIPMENTDESC" Type="String"></asp:Parameter>
            <asp:Parameter Name="EQUIPMENTIMG" Type="String"></asp:Parameter>
            <asp:Parameter Name="EQUIPCTGRYID" Type="Int32"></asp:Parameter>
        </InsertParameters>
        <SelectParameters>
            <asp:QueryStringParameter QueryStringField="id" Name="EQUIPMENTID" Type="Int32"></asp:QueryStringParameter>
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="EQUIPMENTNAME" Type="String"></asp:Parameter>
            <asp:Parameter Name="EQUIPMENTDESC" Type="String"></asp:Parameter>
            <asp:Parameter Name="EQUIPMENTIMG" Type="String"></asp:Parameter>
            <asp:Parameter Name="EQUIPCTGRYID" Type="Int32"></asp:Parameter>
            <asp:Parameter Name="EQUIPMENTID" Type="Int32"></asp:Parameter>
        </UpdateParameters>
    </asp:SqlDataSource>
    <script type="text/javascript">
        $.validate();
    </script>
</asp:Content>

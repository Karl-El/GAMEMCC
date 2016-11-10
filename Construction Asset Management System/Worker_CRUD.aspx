<%@ Page Title="Worker" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Worker_CRUD.aspx.cs" Inherits="Construction_Asset_Management_System.Worker_CRUD" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <link href="Scripts/Date Picker/datepicker.min.css" rel="stylesheet" type="text/css" />
    <script src="Scripts/Date Picker/bootstrap-datepicker.min.js"></script>
    <script src="Scripts/Form Validator/jquery.form-validator.js"></script>
    <link href="Scripts/Form Validator/theme-default.css" rel="stylesheet" type="text/css" />
    <asp:ListView ID="_listviewWorkerCRUD" runat="server" DataKeyNames="WORKERID" DataSourceID="DataSourceWorkerCRUD" InsertItemPosition="LastItem" OnDataBound="_listviewWorkerCRUD_DataBound" OnItemDeleted="_listviewWorkerCRUD_ItemDeleted" OnItemInserted="_listviewWorkerCRUD_ItemInserted" OnItemUpdated="_listviewWorkerCRUD_ItemUpdated" OnItemInserting="_listviewWorkerCRUD_ItemInserting" OnItemUpdating="_listviewWorkerCRUD_ItemUpdating" OnItemDataBound="_listviewWorkerCRUD_ItemDataBound">
        <EditItemTemplate>
            <div style="" class="well">
                <h3>Update Worker</h3>
                <asp:Image runat="server" ImageUrl='<%# Eval("WORKERIMAGE") %>' CssClass="img-responsive img-thumbnail center-block" AlternateText="Not Available" Width="250" Height="250" />
                <label class="control-label">ID:</label>
                <asp:Label ID="WORKERIDLabel1" runat="server" Text='<%# Eval("WORKERID") %>' />
                <div class="row">
                    <h4 class="bg-info text-center" style="padding: 8px">Personal Details</h4>
                    <p class="col-sm-3">
                        <label class="control-label">Add Image:</label>
                        <span>
                            <%--<asp:Image runat="server" ImageUrl='<%# Eval("MATERIALIMG") %>' CssClass="img-responsive img-thumbnail center-block" AlternateText="Not Available" Width="100" Height="100" />--%>
                            <asp:FileUpload ID="_fileupImage" runat="server" />
                        </span>
                        <asp:TextBox ID="WORKERIMAGETextBox" runat="server" Text='<%# Bind("WORKERIMAGE") %>' CssClass="form-control" Visible="false" />
                    </p>
                    <p class="col-sm-5">
                        <label class="control-label">First Name:</label>
                        <asp:TextBox ID="WORKERFNAMETextBox" runat="server" Text='<%# Bind("WORKERFNAME") %>' CssClass="form-control"
                            data-validation="required custom"
                            data-validation-error-msg-required="You must enter a First Name"
                            data-validation-regexp="^([a-zA-Z -'.]+)$"
                            data-validation-error-msg-custom="Invalid input letters only. -'. characters is allowed" />
                    </p>
                    <p class="col-sm-4">
                        <label class="control-label">Last Name:</label>
                        <asp:TextBox ID="WORKERLNAMETextBox" runat="server" Text='<%# Bind("WORKERLNAME") %>' CssClass="form-control"
                            data-validation="required custom"
                            data-validation-error-msg-required="You must enter a Last Name"
                            data-validation-regexp="^([a-zA-Z-'. ]+)$"
                            data-validation-error-msg-custom="Invalid input letters only. -'. characters is allowed" />
                    </p>
                </div>
                <div class="row">
                    <p class="col-sm-4">
                        <label class="control-label">Middle Name:</label>
                        <asp:TextBox ID="WORKERMIDNAMETextBox" runat="server" Text='<%# Bind("WORKERMIDNAME") %>' CssClass="form-control"
                            data-validation="required custom"
                            data-validation-error-msg-required="You must enter a Middle Name"
                            data-validation-regexp="^([a-zA-Z-'. ]+)$"
                            data-validation-error-msg-custom="Invalid input letters only. -'. characters is allowed" />
                    </p>
                    <p class="col-sm-3">
                        <label class="control-label">Gender:</label>
                        <%--<asp:TextBox ID="WORKERGENTextBox" runat="server" Text='<%# Bind("WORKERGEN") %>' CssClass="form-control" />--%>
                        <asp:DropDownList ID="_dropdownWrkrGen" runat="server" Text='<%# Bind("WORKERGEN") %>' CssClass="form-control"
                            data-validation="required"
                            data-validation-error-msg-required="You must select a Gender">
                            <asp:ListItem Value=" "> -- please select Gender -- </asp:ListItem>
                            <asp:ListItem>Male</asp:ListItem>
                            <asp:ListItem>Female</asp:ListItem>
                        </asp:DropDownList>
                    </p>
                    <p class="col-sm-5" id="birthdate-error-dialog">
                        <label class="control-label">Birthdate:</label>
                        <span class="input-group input-append date" id="datePickerDOB">
                            <asp:TextBox ID="WORKERDOBTextBox" runat="server" Text='<%# Bind("WORKERDOB","{0:MM/dd/yyyy}") %>' CssClass="form-control"
                                data-validation="required birthdate"
                                data-validation-format="mm/dd/yyyy"
                                data-validation-error-msg-required="You must enter a your a birthday with a format of MM/DD/YY,18+Only"
                                data-validation-error-msg-container="#birthdate-error-dialog" />
                            <span class="input-group-addon add-on"><span class="glyphicon glyphicon-calendar"></span></span>
                        </span>
                    </p>
                </div>
                <div class="row">
                    <h4 class="bg-info text-center" style="padding: 8px">Complete Address</h4>
                    <p class="col-sm-6">
                        <label class="control-label">Address:</label>
                        <asp:TextBox ID="WORKERADDRTextBox" runat="server" Text='<%# Bind("WORKERADDR") %>' CssClass="form-control"
                            data-validation="required custom"
                            data-validation-error-msg-required="You must enter an address"
                            data-validation-regexp="^([a-zA-Z0-9#&'(),-.@ ]+)$"
                            data-validation-error-msg-custom="Invalid input alphanumeric only. #&'(),-.@ characters is allowed" />

                    </p>
                    <p class="col-sm-3">
                        <label class="control-label">City:</label>
                        <asp:TextBox ID="WORKERCITYTextBox" runat="server" Text='<%# Bind("WORKERCITY") %>' CssClass="form-control"
                            data-validation="required custom"
                            data-validation-error-msg-required="You must enter a city"
                            data-validation-regexp="^([a-zA-Z0-9#&'(),-.@ ]+)$"
                            data-validation-error-msg-custom="Invalid input alphanumeric only. #&'(),-.@ characters is allowed" />
                    </p>
                    <p class="col-sm-3">
                        <label class="control-label">Province:</label>
                        <asp:TextBox ID="WORKERPROVTextBox" runat="server" Text='<%# Bind("WORKERPROV") %>' CssClass="form-control"
                            data-validation="required custom"
                            data-validation-error-msg-required="You must enter a province"
                            data-validation-regexp="^([a-zA-Z0-9#&'(),-.@ ]+)$"
                            data-validation-error-msg-custom="Invalid input alphanumeric only. #&'(),-.@ characters is allowed" />
                    </p>
                </div>
                <div class="row">
                    <h4 class="bg-info text-center" style="padding: 8px">Contact Information</h4>
                    <p class="col-sm-3">
                        <label class="control-label">Cellphone:</label>
                        <asp:TextBox ID="WORKERCELLTextBox" runat="server" Text='<%# Bind("WORKERCELL") %>' CssClass="form-control"
                            data-validation="required custom"
                            data-validation-error-msg-required="You must enter a cellphone number"
                            data-validation-regexp="^([0-9()+-]+)$"
                            data-validation-error-msg-custom="Invalid input numbers only. ()+- characters is allowed" />
                    </p>
                    <p class="col-sm-3">
                        <label class="control-label">Telephone:</label>
                        <asp:TextBox ID="WORKERTELTextBox" runat="server" Text='<%# Bind("WORKERTEL") %>' CssClass="form-control"
                            data-validation="custom"
                            data-validation-optional="true"
                            data-validation-regexp="^([0-9()+-]+)$"
                            data-validation-error-msg-custom="Invalid input numbers only. ()+- characters is allowed" />
                    </p>
                    <p class="col-sm-6">
                        <label class="control-label">Email:</label>
                        <asp:TextBox ID="WORKEREMAILTextBox" runat="server" Text='<%# Bind("WORKEREMAIL") %>' CssClass="form-control"
                            data-validation="email"
                            data-validation-optional="true" />
                    </p>
                </div>
                <div class="row">
                    <h4 class="bg-info text-center" style="padding: 8px">Empoyment Details</h4>
                    <p class="col-sm-4">
                        <label class="control-label">Badge ID:</label>
                        <asp:TextBox ID="BADGEIDTextBox" runat="server" Text='<%# Bind("BADGEID") %>' CssClass="form-control" Enabled="false" />
                    </p>
                    <p class="col-sm-4" id="datehire-error-dialog">
                        <label class="control-label">Date Hire:</label>
                        <span class="input-group input-append date" id="datePickerDOH">
                            <asp:TextBox ID="WORKERSTARTDATETextBox" runat="server" Text='<%# Bind("WORKERSTARTDATE","{0:MM/dd/yyyy}") %>' CssClass="form-control"
                                data-validation="required birthdate"
                                data-validation-format="mm/dd/yyyy"
                                data-validation-error-msg-required="You must enter a your date of hiring"
                                data-validation-error-msg-container="#datehire-error-dialog" />
                            <span class="input-group-addon add-on"><span class="glyphicon glyphicon-calendar"></span></span>
                        </span>
                    </p>
                    <p class="col-sm-4" id="dateresign-error-dialog">
                        <label class="control-label">Date Resign:</label>
                        <span class="input-group input-append date" id="datePickerDOR">
                            <asp:TextBox ID="WORKERENDDATETextBox" runat="server" Text='<%# Bind("WORKERENDDATE","{0:MM/dd/yyyy}") %>' CssClass="form-control"
                                data-validation="custom"
                                data-validation-format="mm/dd/yyyy"
                                data-validation-error-msg-container="#dateresign-error-dialog" />
                            <span class="input-group-addon add-on"><span class="glyphicon glyphicon-calendar"></span></span>
                            <%-- data-validation="required birthdate"
                                data-validation-format="mm/dd/yyyy"
                                data-validation-error-msg-required="You must enter a your a birthday with a format of MM/DD/YY,18+Only"
                                data-validation-error-msg-container="#dateresign-error-dialog" />--%>
                        </span>
                    </p>
                </div>
                <div class="row">
                    <p class="col-sm-4">
                        <label class="control-label">Employment Status:</label>
                        <%--<asp:TextBox ID="WORKERSTATUSTextBox" runat="server" Text='<%# Bind("WORKERSTATUS") %>' />--%>
                        <asp:DropDownList ID="_dropdownWrkrStat" runat="server" Text='<%# Bind("WORKERSTATUS") %>' CssClass="form-control"
                            data-validation="required"
                            data-validation-error-msg-required="You must select a Status">
                            <asp:ListItem Value=" "> -- please select Status -- </asp:ListItem>
                            <asp:ListItem>Active</asp:ListItem>
                            <asp:ListItem>Inactive</asp:ListItem>
                        </asp:DropDownList>
                    </p>
                    <p class="col-sm-4">
                        <label class="control-label">Employment Type:</label>
                        <%--<asp:TextBox ID="WORKEREMPLOYTYPETextBox" runat="server" Text='<%# Bind("WORKEREMPLOYTYPE") %>' CssClass="form-control" />--%>
                        <asp:DropDownList ID="_dropdownWrkrEmployType" runat="server" Text='<%# Bind("WORKEREMPLOYTYPE") %>' CssClass="form-control"
                            data-validation="required"
                            data-validation-error-msg-required="You must select an Employment Type">
                            <asp:ListItem Value=" "> -- please select Employment Type -- </asp:ListItem>
                            <asp:ListItem Value="Regular">Regular</asp:ListItem>
                            <asp:ListItem Value="Contractual">Contractual</asp:ListItem>
                        </asp:DropDownList>
                    </p>
                    <p class="col-sm-4">
                        <label class="control-label">Labor Career Type:</label>
                        <%--<asp:TextBox ID="LABORTYPEIDTextBox" runat="server" Text='<%# Bind("LABORTYPEID") %>' CssClass="form-control" />--%>
                        <asp:DropDownList ID="_dropdownLaborType" runat="server" SelectedValue='<%# Bind("LABORTYPEID") %>' AppendDataBoundItems="true" DataSourceID="DataSourceLaborTypeDDList" DataTextField="LABORTYPENAME" DataValueField="LABORTYPEID" CssClass="form-control"
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
                            <asp:Button ID="CancelButton" runat="server" CommandName="Cancel" Text="Cancel" CssClass="btn btn-danger center-block col-xs-12" OnClientClick=" window.location = '/Worker.aspx';this.form.reset();return false;" />
                        </div>
                    </div>
                </div>
            </div>
        </EditItemTemplate>

        <EmptyDataTemplate>
            <span>No data was returned.</span>
        </EmptyDataTemplate>

        <InsertItemTemplate>
            <div style="" class="well">
                <h3>Add Worker</h3>
                <%-- <asp:Image runat="server" ImageUrl='<%# Eval("WORKERIMAGE") %>' CssClass="img-responsive img-thumbnail center-block" AlternateText="Not Available" Width="250" Height="250" />--%>
                <div class="row">
                    <h4 class="bg-info text-center" style="padding: 8px">Personal Details</h4>
                    <p class="col-sm-3">
                        <label class="control-label">Add Image:</label>
                        <span>
                            <%--<asp:Image runat="server" ImageUrl='<%# Eval("MATERIALIMG") %>' CssClass="img-responsive img-thumbnail center-block" AlternateText="Not Available" Width="100" Height="100" />--%>
                            <asp:FileUpload ID="_fileupImage" runat="server" />
                        </span>
                        <asp:TextBox ID="WORKERIMAGETextBox" runat="server" Text='<%# Bind("WORKERIMAGE") %>' CssClass="form-control" Visible="false" />
                    </p>
                    <p class="col-sm-5">
                        <label class="control-label">First Name:</label>
                        <asp:TextBox ID="WORKERFNAMETextBox" runat="server" Text='<%# Bind("WORKERFNAME") %>' CssClass="form-control"
                            data-validation="required custom"
                            data-validation-error-msg-required="You must enter a First Name"
                            data-validation-regexp="^([a-zA-Z-'. ]+)$"
                            data-validation-error-msg-custom="Invalid input letters only. -'. characters is allowed" />
                    </p>
                    <p class="col-sm-4">
                        <label class="control-label">Last Name:</label>
                        <asp:TextBox ID="WORKERLNAMETextBox" runat="server" Text='<%# Bind("WORKERLNAME") %>' CssClass="form-control"
                            data-validation="required custom"
                            data-validation-error-msg-required="You must enter a Last Name"
                            data-validation-regexp="^([a-zA-Z-'. ]+)$"
                            data-validation-error-msg-custom="Invalid input letters only. -'. characters is allowed" />
                    </p>
                </div>
                <div class="row">
                    <p class="col-sm-4">
                        <label class="control-label">Middle Name:</label>
                        <asp:TextBox ID="WORKERMIDNAMETextBox" runat="server" Text='<%# Bind("WORKERMIDNAME") %>' CssClass="form-control"
                            data-validation="required custom"
                            data-validation-error-msg-required="You must enter a Middle Name"
                            data-validation-regexp="^([a-zA-Z-'. ]+)$"
                            data-validation-error-msg-custom="Invalid input letters only. -'. characters is allowed" />
                    </p>
                    <p class="col-sm-3">
                        <label class="control-label">Gender:</label>
                        <%--<asp:TextBox ID="WORKERGENTextBox" runat="server" Text='<%# Bind("WORKERGEN") %>' CssClass="form-control" />--%>
                        <asp:DropDownList ID="_dropdownWrkrGen" runat="server" Text='<%# Bind("WORKERGEN") %>' CssClass="form-control"
                            data-validation="required"
                            data-validation-error-msg-required="You must select a Gender">
                            <asp:ListItem Value=" "> -- please select Gender -- </asp:ListItem>
                            <asp:ListItem>Male</asp:ListItem>
                            <asp:ListItem>Female</asp:ListItem>
                        </asp:DropDownList>
                    </p>
                    <p class="col-sm-5" id="birthdate-error-dialog">
                        <label class="control-label">Birthdate:</label>
                        <span class="input-group input-append date" id="datePickerDOB">
                            <asp:TextBox ID="WORKERDOBTextBox" runat="server" Text='<%# Bind("WORKERDOB","{0:MM/dd/yyyy}") %>' CssClass="form-control"
                                data-validation="required birthdate"
                                data-validation-format="mm/dd/yyyy"
                                data-validation-error-msg-required="You must enter a your a birthday with a format of MM/DD/YY,18+Only"
                                data-validation-error-msg-container="#birthdate-error-dialog" />
                            <span class="input-group-addon add-on"><span class="glyphicon glyphicon-calendar"></span></span>
                        </span>
                    </p>
                </div>
                <div class="row">
                    <h4 class="bg-info text-center" style="padding: 8px">Complete Address</h4>
                    <p class="col-sm-6">
                        <label class="control-label">Address:</label>
                        <asp:TextBox ID="WORKERADDRTextBox" runat="server" Text='<%# Bind("WORKERADDR") %>' CssClass="form-control"
                            data-validation="required custom"
                            data-validation-error-msg-required="You must enter an address"
                            data-validation-regexp="^([a-zA-Z0-9#&'(),-.@ ]+)$"
                            data-validation-error-msg-custom="Invalid input alphanumeric only. #&'(),-.@ characters is allowed" />

                    </p>
                    <p class="col-sm-3">
                        <label class="control-label">City:</label>
                        <asp:TextBox ID="WORKERCITYTextBox" runat="server" Text='<%# Bind("WORKERCITY") %>' CssClass="form-control"
                            data-validation="required custom"
                            data-validation-error-msg-required="You must enter a city"
                            data-validation-regexp="^([a-zA-Z0-9#&'(),-.@ ]+)$"
                            data-validation-error-msg-custom="Invalid input alphanumeric only. #&'(),-.@ characters is allowed" />
                    </p>
                    <p class="col-sm-3">
                        <label class="control-label">Province:</label>
                        <asp:TextBox ID="WORKERPROVTextBox" runat="server" Text='<%# Bind("WORKERPROV") %>' CssClass="form-control"
                            data-validation="required custom"
                            data-validation-error-msg-required="You must enter a province"
                            data-validation-regexp="^([a-zA-Z0-9#&'(),-.@ ]+)$"
                            data-validation-error-msg-custom="Invalid input alphanumeric only. #&'(),-.@ characters is allowed" />
                    </p>
                </div>
                <div class="row">
                    <h4 class="bg-info text-center" style="padding: 8px">Contact Information</h4>
                    <p class="col-sm-3">
                        <label class="control-label">Cellphone:</label>
                        <asp:TextBox ID="WORKERCELLTextBox" runat="server" Text='<%# Bind("WORKERCELL") %>' CssClass="form-control"
                            data-validation="required custom"
                            data-validation-error-msg-required="You must enter a cellphone number"
                            data-validation-regexp="^([0-9()+-]+)$"
                            data-validation-error-msg-custom="Invalid input numbers only. ()+- characters is allowed" />
                    </p>
                    <p class="col-sm-3">
                        <label class="control-label">Telephone:</label>
                        <asp:TextBox ID="WORKERTELTextBox" runat="server" Text='<%# Bind("WORKERTEL") %>' CssClass="form-control"
                            data-validation="custom"
                            data-validation-optional="true"
                            data-validation-regexp="^([0-9()+-]+)$"
                            data-validation-error-msg-custom="Invalid input numbers only. ()+- characters is allowed" />
                    </p>
                    <p class="col-sm-6">
                        <label class="control-label">Email:</label>
                        <asp:TextBox ID="WORKEREMAILTextBox" runat="server" Text='<%# Bind("WORKEREMAIL") %>' CssClass="form-control"
                            data-validation="email"
                            data-validation-optional="true" />
                    </p>
                </div>
                <div class="row">
                    <h4 class="bg-info text-center" style="padding: 8px">Empoyment Details</h4>
                    <p class="col-sm-4">
                        <label class="control-label">Badge ID:</label>
                        <asp:TextBox ID="BADGEIDTextBox" runat="server" Text='<%# Bind("BADGEID") %>' CssClass="form-control" Enabled="false" />
                    </p>
                    <p class="col-sm-4" id="datehire-error-dialog">
                        <label class="control-label">Date Hire:</label>
                        <span class="input-group input-append date" id="datePickerDOH">
                            <asp:TextBox ID="WORKERSTARTDATETextBox" runat="server" Text='<%# Bind("WORKERSTARTDATE","{0:MM/dd/yyyy}") %>' CssClass="form-control"
                                data-validation="required birthdate"
                                data-validation-format="mm/dd/yyyy"
                                data-validation-error-msg-required="You must enter a your date of hiring"
                                data-validation-error-msg-container="#datehire-error-dialog" />
                            <span class="input-group-addon add-on"><span class="glyphicon glyphicon-calendar"></span></span>
                        </span>
                    </p>
                    <p class="col-sm-4" id="dateresign-error-dialog">
                        <label class="control-label">Date Resign:</label>
                        <span class="input-group input-append date" id="datePickerDOR">
                            <asp:TextBox ID="WORKERENDDATETextBox" runat="server" Text='<%# Bind("WORKERENDDATE","{0:MM/dd/yyyy}") %>' CssClass="form-control"
                                data-validation="custom"
                                data-validation-format="mm/dd/yyyy"
                                data-validation-error-msg-container="#dateresign-error-dialog" />
                            <span class="input-group-addon add-on"><span class="glyphicon glyphicon-calendar"></span></span>
                            <%-- data-validation="required birthdate"
                                data-validation-format="mm/dd/yyyy"
                                data-validation-error-msg-required="You must enter a your a birthday with a format of MM/DD/YY,18+Only"
                                data-validation-error-msg-container="#dateresign-error-dialog" />--%>
                        </span>
                    </p>
                </div>
                <div class="row">
                    <p class="col-sm-4">
                        <label class="control-label">Employment Status:</label>
                        <%--<asp:TextBox ID="WORKERSTATUSTextBox" runat="server" Text='<%# Bind("WORKERSTATUS") %>' />--%>
                        <asp:DropDownList ID="_dropdownWrkrStat" runat="server" Text='<%# Bind("WORKERSTATUS") %>' CssClass="form-control"
                            data-validation="required"
                            data-validation-error-msg-required="You must select a Status">
                            <asp:ListItem Value=" "> -- please select Status -- </asp:ListItem>
                            <asp:ListItem>Active</asp:ListItem>
                            <asp:ListItem>Inactive</asp:ListItem>
                        </asp:DropDownList>
                    </p>
                    <p class="col-sm-4">
                        <label class="control-label">Employment Type:</label>
                        <%--<asp:TextBox ID="WORKEREMPLOYTYPETextBox" runat="server" Text='<%# Bind("WORKEREMPLOYTYPE") %>' CssClass="form-control" />--%>
                        <asp:DropDownList ID="_dropdownWrkrEmployType" runat="server" Text='<%# Bind("WORKEREMPLOYTYPE") %>' CssClass="form-control"
                            data-validation="required"
                            data-validation-error-msg-required="You must select an Employment Type">
                            <asp:ListItem Value=" "> -- please select Employment Type -- </asp:ListItem>
                            <asp:ListItem>Regular</asp:ListItem>
                            <asp:ListItem Value="Contractual">Contractual</asp:ListItem>
                        </asp:DropDownList>
                    </p>
                    <p class="col-sm-4">
                        <label class="control-label">Labor Career Type:</label>
                        <%--<asp:TextBox ID="LABORTYPEIDTextBox" runat="server" Text='<%# Bind("LABORTYPEID") %>' CssClass="form-control" />--%>
                        <asp:DropDownList ID="_dropdownLaborType" runat="server" SelectedValue='<%# Bind("LABORTYPEID") %>' AppendDataBoundItems="true" DataSourceID="DataSourceLaborTypeDDList" DataTextField="LABORTYPENAME" DataValueField="LABORTYPEID" CssClass="form-control"
                            data-validation="required"
                            data-validation-error-msg-required="You must select a Career Type">
                            <asp:ListItem Value=" "> -- please select Career Type -- </asp:ListItem>
                        </asp:DropDownList>
                        <asp:SqlDataSource ID="DataSourceLaborTypeDDList" runat="server" ConnectionString="<%$ ConnectionStrings:ConnString_WEB_ASSET_DB %>" SelectCommand="SELECT [LABORTYPEID], [LABORTYPENAME] FROM [LABORTYPE]"></asp:SqlDataSource>
                    </p>
                </div>
                <hr />
                <div class="row">
                    <div class="row col-sm-4 pull-right">
                        <div class="col-xs-6">
                            <asp:Button ID="InsertButton" runat="server" CommandName="Insert" Text="Save" CssClass="btn btn-primary center-block col-xs-12" OnClick="InsertButton_Click" />
                        </div>
                        <div class="col-xs-6">
                            <asp:Button ID="CancelButton" runat="server" CommandName="Cancel" Text="Cancel" CssClass="btn btn-danger center-block col-xs-12" OnClientClick=" window.location = '/Worker.aspx';this.form.reset();return false;" />
                        </div>
                    </div>
                </div>
                <br />
            </div>
        </InsertItemTemplate>
        <ItemTemplate>
            <span style="">
                <div style="" class="well">
                    <h3>Update Worker</h3>
                    <div class="row">
                        <div class="col-sm-3">
                            <asp:Image runat="server" ImageUrl='<%# Eval("WORKERIMAGE") %>' CssClass="img-responsive img-thumbnail" AlternateText="Not Available" Width="250" Height="250" />
                        </div>
                        <div class="col-sm-3">
                            <p>
                                <label class="control-label">ID:</label>
                                <asp:Label ID="WORKERIDLabel" runat="server" Text='<%# Eval("WORKERID") %>' CssClass="control-label" />
                            </p>
                            <p>
                                <label class="control-label">First Name:</label>
                                <asp:Label ID="WORKERFNAMELabel" runat="server" Text='<%# Eval("WORKERFNAME") %>' CssClass="control-label" />
                            </p>
                            <p>
                                <label class="control-label">Last Name:</label>
                                <asp:Label ID="WORKERLNAMELabel" runat="server" Text='<%# Eval("WORKERLNAME") %>' CssClass="control-label" />
                            </p>
                            <p>
                                <label class="control-label">Middle Name:</label>
                                <asp:Label ID="WORKERMIDNAMELabel" runat="server" Text='<%# Eval("WORKERMIDNAME") %>' CssClass="control-label" />
                            </p>
                            <p>
                                <label class="control-label">Gender:</label>
                                <asp:Label ID="WORKERGENLabel" runat="server" Text='<%# Eval("WORKERGEN") %>' CssClass="control-label" />
                            </p>
                            <p>
                                <label class="control-label">Birthdate:</label>
                                <asp:Label ID="WORKERDOBLabel" runat="server" Text='<%# Eval("WORKERDOB","{0:MM/dd/yyyy}") %>' CssClass="control-label" />
                            </p>
                        </div>
                        <div class="col-sm-3">
                            <p>
                                <label class="control-label">Adddress:</label>
                                <asp:Label ID="WORKERADDRLabel" runat="server" Text='<%# Eval("WORKERADDR") %>' CssClass="control-label" />
                            </p>
                            <p>
                                <label class="control-label">City:</label>
                                <asp:Label ID="WORKERCITYLabel" runat="server" Text='<%# Eval("WORKERCITY") %>' CssClass="control-label" />
                            </p>
                            <p>
                                <label class="control-label">Province:</label>
                                <asp:Label ID="WORKERPROVLabel" runat="server" Text='<%# Eval("WORKERPROV") %>' CssClass="control-label" />
                            </p>
                            <p>
                                <label class="control-label">Email:</label>
                                <asp:Label ID="WORKEREMAILLabel" runat="server" Text='<%# Eval("WORKEREMAIL") %>' CssClass="control-label" />
                            </p>
                            <p>
                                <label class="control-label">Telephone:</label>
                                <asp:Label ID="WORKERTELLabel" runat="server" Text='<%# Eval("WORKERTEL") %>' CssClass="control-label" />
                            </p>
                            <p>
                                <label class="control-label">Cellphone:</label>
                                <asp:Label ID="WORKERCELLLabel" runat="server" Text='<%# Eval("WORKERCELL") %>' CssClass="control-label" />
                            </p>
                        </div>
                        <div class="col-sm-3 ">
                            <p>
                                <label class="control-label">Badge ID:</label>
                                <asp:Label ID="BADGEIDLabel" runat="server" Text='<%# Eval("BADGEID") %>' CssClass="control-label" />
                            </p>
                            <p>
                                <label class="control-label">Date Hired:</label>
                                <asp:Label ID="WORKERSTARTDATELabel" runat="server" Text='<%# Eval("WORKERSTARTDATE","{0:MM/dd/yyyy}") %>' CssClass="control-label" />
                            </p>
                            <p>
                                <label class="control-label">Date Resign:</label>
                                <asp:Label ID="WORKERENDDATELabel" runat="server" Text='<%# Eval("WORKERENDDATE","{0:MM/dd/yyyy}") %>' CssClass="control-label" />
                            </p>
                            <p>
                                <label class="control-label">Employment Status:</label>
                                <asp:Label ID="WORKERSTATUSLabel" runat="server" Text='<%# Eval("WORKERSTATUS") %>' CssClass="control-label" />
                            </p>
                            <p>
                                <label class="control-label">Employment Type:</label>
                                <asp:Label ID="WORKEREMPLOYTYPELabel" runat="server" Text='<%# Eval("WORKEREMPLOYTYPE") %>' CssClass="control-label" />
                                <%--<br />
                <label class="control-label" visible="false">WORKERIMAGE:</label>
                <asp:Label ID="WORKERIMAGELabel" runat="server" Text='<%# Eval("WORKERIMAGE") %>'  Visible="false"/>--%>
                            </p>
                            <p>
                                <label class="control-label">Labor Career Type:</label>
                                <asp:Label ID="LABORTYPEIDLabel" runat="server" Text='<%# Eval("LABORTYPENAME") %>' CssClass="control-label" />
                            </p>
                        </div>
                    </div>
                    <hr />
                    <div class="row">
                        <div class="col-sm-3 pull-right">
                            <asp:Button ID="EditButton" runat="server" CommandName="Edit" Text="Edit" CssClass="btn btn-primary " />
                            <span onclick="return confirm('Are you sure to delete?')">
                                <asp:Button ID="DeleteButton" runat="server" CommandName="Delete" Text="Delete" CssClass="btn btn-danger" />
                            </span>
                            <asp:Button ID="BackButton" runat="server" Text="Back" CssClass="btn btn-warning" OnClientClick="window.history.go(-1);return false;" />
                            <%--<input type="button" value="Back" onclick="window.location = 'Worker.aspx';" class="btn btn-warning" />--%>
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
                        <asp:NumericPagerField NumericButtonCssClass="label label-success" CurrentPageLabelCssClass="badge" />
                        <asp:NextPreviousPagerField ButtonType="Button" ShowLastPageButton="True" ShowNextPageButton="False" ShowPreviousPageButton="False" />
                    </Fields>
                </asp:DataPager>
            </div>
        </LayoutTemplate>
    </asp:ListView>
    <asp:SqlDataSource ID="DataSourceWorkerCRUD" runat="server" ConnectionString="<%$ ConnectionStrings:ConnString_WEB_ASSET_DB %>" DeleteCommand="DELETE FROM [WORKER] WHERE [WORKERID] = @WORKERID" InsertCommand="INSERT INTO [WORKER] ([WORKERFNAME], [WORKERLNAME], [WORKERMIDNAME], [WORKERGEN], [WORKERDOB], [WORKERADDR], [WORKERCITY], [WORKERPROV], [WORKEREMAIL], [WORKERTEL], [WORKERCELL], [BADGEID], [WORKERSTARTDATE], [WORKERENDDATE], [WORKERSTATUS], [WORKEREMPLOYTYPE], [WORKERIMAGE], [LABORTYPEID],[ASSWORKER]) VALUES (@WORKERFNAME, @WORKERLNAME, @WORKERMIDNAME, @WORKERGEN, @WORKERDOB, @WORKERADDR, @WORKERCITY, @WORKERPROV, @WORKEREMAIL, @WORKERTEL, @WORKERCELL, @BADGEID, @WORKERSTARTDATE, @WORKERENDDATE, @WORKERSTATUS, @WORKEREMPLOYTYPE, @WORKERIMAGE, @LABORTYPEID,'false')" SelectCommand="SELECT [WORKERID], [WORKERFNAME], [WORKERLNAME], [WORKERMIDNAME], [WORKERGEN], [WORKERDOB], [WORKERADDR], [WORKERCITY], [WORKERPROV], [WORKEREMAIL], [WORKERTEL], [WORKERCELL], [BADGEID], WORKERSTARTDATE, [WORKERENDDATE], [WORKERSTATUS], [WORKEREMPLOYTYPE], [WORKERIMAGE], WORKER.LABORTYPEID, LABORTYPE.LABORTYPENAME FROM WORKER INNER JOIN LABORTYPE ON WORKER.LABORTYPEID=LABORTYPE.LABORTYPEID WHERE ([WORKERID] = @WORKERID)" UpdateCommand="UPDATE [WORKER] SET [WORKERFNAME] = @WORKERFNAME, [WORKERLNAME] = @WORKERLNAME, [WORKERMIDNAME] = @WORKERMIDNAME, [WORKERGEN] = @WORKERGEN, [WORKERDOB] = @WORKERDOB, [WORKERADDR] = @WORKERADDR, [WORKERCITY] = @WORKERCITY, [WORKERPROV] = @WORKERPROV, [WORKEREMAIL] = @WORKEREMAIL, [WORKERTEL] = @WORKERTEL, [WORKERCELL] = @WORKERCELL, [BADGEID] = @BADGEID, [WORKERSTARTDATE] = @WORKERSTARTDATE, [WORKERENDDATE] = @WORKERENDDATE, [WORKERSTATUS] = @WORKERSTATUS, [WORKEREMPLOYTYPE] = @WORKEREMPLOYTYPE, [WORKERIMAGE] = @WORKERIMAGE, [LABORTYPEID] = @LABORTYPEID WHERE [WORKERID] = @WORKERID">
        <DeleteParameters>
            <asp:Parameter Name="WORKERID" Type="Int32" />
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="WORKERFNAME" Type="String" />
            <asp:Parameter Name="WORKERLNAME" Type="String" />
            <asp:Parameter Name="WORKERMIDNAME" Type="String" />
            <asp:Parameter Name="WORKERGEN" Type="String" />
            <asp:Parameter DbType="Date" Name="WORKERDOB" />
            <asp:Parameter Name="WORKERADDR" Type="String" />
            <asp:Parameter Name="WORKERCITY" Type="String" />
            <asp:Parameter Name="WORKERPROV" Type="String" />
            <asp:Parameter Name="WORKEREMAIL" Type="String" />
            <asp:Parameter Name="WORKERTEL" Type="String" />
            <asp:Parameter Name="WORKERCELL" Type="String" />
            <asp:Parameter Name="BADGEID" Type="Int32" />
            <asp:Parameter DbType="Date" Name="WORKERSTARTDATE" />
            <asp:Parameter DbType="Date" Name="WORKERENDDATE" />
            <asp:Parameter Name="WORKERSTATUS" Type="String" />
            <asp:Parameter Name="WORKEREMPLOYTYPE" Type="String" />
            <asp:Parameter Name="WORKERIMAGE" Type="String" />
            <asp:Parameter Name="LABORTYPEID" Type="Int32" />
        </InsertParameters>
        <SelectParameters>
            <asp:QueryStringParameter Name="WORKERID" QueryStringField="id" Type="Int32" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="WORKERFNAME" Type="String" />
            <asp:Parameter Name="WORKERLNAME" Type="String" />
            <asp:Parameter Name="WORKERMIDNAME" Type="String" />
            <asp:Parameter Name="WORKERGEN" Type="String" />
            <asp:Parameter DbType="Date" Name="WORKERDOB" />
            <asp:Parameter Name="WORKERADDR" Type="String" />
            <asp:Parameter Name="WORKERCITY" Type="String" />
            <asp:Parameter Name="WORKERPROV" Type="String" />
            <asp:Parameter Name="WORKEREMAIL" Type="String" />
            <asp:Parameter Name="WORKERTEL" Type="String" />
            <asp:Parameter Name="WORKERCELL" Type="String" />
            <asp:Parameter Name="BADGEID" Type="Int32" />
            <asp:Parameter DbType="Date" Name="WORKERSTARTDATE" />
            <asp:Parameter DbType="Date" Name="WORKERENDDATE" />
            <asp:Parameter Name="WORKERSTATUS" Type="String" />
            <asp:Parameter Name="WORKEREMPLOYTYPE" Type="String" />
            <asp:Parameter Name="WORKERIMAGE" Type="String" />
            <asp:Parameter Name="LABORTYPEID" Type="Int32" />
            <asp:Parameter Name="WORKERID" Type="Int32" />
        </UpdateParameters>
    </asp:SqlDataSource>
    <script type="text/javascript">
        var dt = new Date();
        dt.setFullYear(new Date().getFullYear() - 18);
        $('#datePickerDOB').datepicker({
            format: 'mm/dd/yyyy',
            endDate: dt,
            todayHighlight: true,
        });
    </script>
    <script type="text/javascript">
        $.validate({
            modules: 'date',
        })
    </script>
    <script type="text/javascript">
        $(function () {
            $('#datePickerDOH').datepicker({
                format: 'mm/dd/yyyy',
                todayHighlight: true,
                endDate: "today"
            });
            $('#datePickerDOR').datepicker({
                format: 'mm/dd/yyyy',
                todayHighlight: true,
                startDate: "today"
            });
        });
    </script>
    <%--  <asp:DropDownList ID="_dropdownLaborType" runat="server" DataSourceID="DataSourceLaborTypeDDList" DataTextField="LABORTYPENAME" DataValueField="LABORTYPEID">
    </asp:DropDownList>
    <asp:SqlDataSource ID="DataSourceLaborTypeDDList" runat="server" ConnectionString="<%$ ConnectionStrings:ConnString_WEB_ASSET_DB %>" SelectCommand="SELECT [LABORTYPEID], [LABORTYPENAME] FROM [LABORTYPE]"></asp:SqlDataSource>--%>
</asp:Content>

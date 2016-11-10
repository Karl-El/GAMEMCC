<%@ Page Title="Inquire a Project" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Project_CRUD.aspx.cs" Inherits="Construction_Asset_Management_System.Project_CRUD1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <link href="Scripts/Date Picker/datepicker.min.css" rel="stylesheet" type="text/css" />
    <script src="Scripts/Date Picker/bootstrap-datepicker.min.js"></script>
    <script src="Scripts/Form Validator/jquery.form-validator.js"></script>
    <link href="Scripts/Form Validator/theme-default.css" rel="stylesheet" type="text/css" />
    <asp:ListView ID="_listviewProjectCRUD" runat="server" DataKeyNames="PROJID" DataSourceID="DataSourceProjectCRUD" InsertItemPosition="LastItem" OnPreRender="_listviewProjectCRUD_PreRender" OnItemDeleted="_listviewProjectCRUD_ItemDeleted" OnItemInserted="_listviewProjectCRUD_ItemInserted" OnItemInserting="_listviewProjectCRUD_ItemInserting" OnItemUpdated="_listviewProjectCRUD_ItemUpdated" OnDataBound="_listviewProjectCRUD_DataBound" OnItemUpdating="_listviewProjectCRUD_ItemUpdating" OnItemDataBound="_listviewProjectCRUD_ItemDataBound">
        <EditItemTemplate>
            <div class="well">
                <h3>Modify Project</h3>
                <div class="row">
                    <label class="control-label">ID:</label>
                    <asp:Label ID="Label1" runat="server" Text='<%# Eval("PROJID") %>' />
                    <h4 class="bg-info text-center" style="padding: 8px">Client Information</h4>
                    <p class="col-sm-8">
                        <label class="control-label">Company/Business Name:</label>
                        <%--<asp:TextBox ID="CLIENTIDTextBox" runat="server" Text='<%# Bind("CLIENTID") %>' />--%>
                        <asp:DropDownList ID="_dropdownCompany" runat="server" CssClass="form-control" DataSourceID="DataSourceCompanyDDList" DataTextField="CLIENTNAME" DataValueField="CLIENTID" SelectedValue='<%# Bind("CLIENTID") %>' AppendDataBoundItems="true" AutoPostBack="true" Enabled="false"
                            data-validation="custom"
                            data-validation-regexp="^([1-9]+)$"
                            data-validation-error-msg-custom="You must select Business/Company Name">
                            <asp:ListItem Value="0"> --  please select Business/Company Name --</asp:ListItem>
                        </asp:DropDownList>
                        <asp:SqlDataSource runat="server" ID="DataSourceCompanyDDList" ConnectionString='<%$ ConnectionStrings:ConnString_WEB_ASSET_DB %>' SelectCommand="SELECT [CLIENTID], [CLIENTNAME] FROM [CLIENT]"></asp:SqlDataSource>
                    </p>
                    <p class="col-sm-4" id="propose-error-dialog">
                        <label class="control-label">Date Proposed:</label>
                        <span class="input-group input-append date" id="datePickerDOProp">
                            <asp:TextBox ID="PROJPROPTextBox" runat="server" Text='<%# Bind("PROJPROP","{0:MM/dd/yyyy}") %>' CssClass="form-control"
                                data-validation="required birthdate"
                                data-validation-format="mm/dd/yyyy"
                                data-validation-error-msg-required="You must enter the date they proposed"
                                data-validation-error-msg-container="#propose-error-dialog" />
                            <span class="input-group-addon add-on"><span class="glyphicon glyphicon-calendar"></span></span>
                        </span>
                    </p>
                </div>
                <div class="row">
                    <p class="col-sm-4">
                        <label class="control-label">Contact Person:</label>
                        <asp:TextBox ID="CLNTPROJCONTIDTextBox" runat="server" Text='<%# Bind("CLNTPROJCONTID") %>' Visible="false" />
                        <asp:DropDownList ID="_dropdownContact" runat="server" CssClass="form-control" DataSourceID="DataSourceContactDDList" DataTextField="CLIENTSTAFFPOS" DataValueField="CLIENTSTAFFID" AutoPostBack="true">
                            <%--SelectedValue='<%# Bind("CLNTPROJCONTID") %>'>--%>
                        </asp:DropDownList>
                        <asp:SqlDataSource runat="server" ID="DataSourceContactDDList" ConnectionString='<%$ ConnectionStrings:ConnString_WEB_ASSET_DB %>' SelectCommand="SELECT [CLIENTSTAFFID], CLIENTSTAFFFNAME+' '+CLIENTSTAFFLNAME+', '+CLIENTSTAFFPOSITION AS [CLIENTSTAFFPOS] FROM [CLIENTSTAFF] WHERE ([CLIENTID] = @CLIENTID) AND CLIENTSTAFFSTATUS='Active'">
                            <SelectParameters>
                                <asp:ControlParameter ControlID="_dropdownCompany" PropertyName="SelectedValue" Name="CLIENTID" Type="Int32"></asp:ControlParameter>
                            </SelectParameters>
                        </asp:SqlDataSource>
                    </p>
                    <p class="col-sm-4">
                        <label class="control-label">Prepared by:</label>
                        <asp:TextBox ID="CLNTPROJPREPIDTextBox" runat="server" Text='<%# Bind("CLNTPROJPREPID") %>' Visible="false" />
                        <asp:DropDownList ID="_dropdownPrepared" runat="server" CssClass="form-control" DataSourceID="DataSourcePreparedDDList" DataTextField="CLIENTSTAFFPOS" DataValueField="CLIENTSTAFFID" AutoPostBack="true">
                            <%--SelectedValue='<%# Bind("CLNTPROJPREPID") %>'>--%>
                        </asp:DropDownList>
                        <asp:SqlDataSource runat="server" ID="DataSourcePreparedDDList" ConnectionString='<%$ ConnectionStrings:ConnString_WEB_ASSET_DB %>' SelectCommand="SELECT [CLIENTSTAFFID], CLIENTSTAFFFNAME+' '+CLIENTSTAFFLNAME+', '+CLIENTSTAFFPOSITION AS [CLIENTSTAFFPOS] FROM [CLIENTSTAFF] WHERE ([CLIENTID] = @CLIENTID) AND CLIENTSTAFFSTATUS='Active'">
                            <SelectParameters>
                                <asp:ControlParameter ControlID="_dropdownCompany" PropertyName="SelectedValue" Name="CLIENTID" Type="Int32"></asp:ControlParameter>
                            </SelectParameters>
                        </asp:SqlDataSource>
                    </p>
                    <p class="col-sm-4">
                        <label class="control-label">Approved by:</label>
                        <asp:TextBox ID="CLNTPROJAPPIDTextBox" runat="server" Text='<%# Bind("CLNTPROJAPPID") %>' Visible="false" />
                        <asp:DropDownList ID="_dropdownApproved" runat="server" CssClass="form-control" DataSourceID="DataSourceApprovedDDList" DataTextField="CLIENTSTAFFPOS" DataValueField="CLIENTSTAFFID" AutoPostBack="true">
                            <%--SelectedValue='<%# Bind("CLNTPROJAPPID") %>'>--%>
                        </asp:DropDownList>
                        <asp:SqlDataSource runat="server" ID="DataSourceApprovedDDList" ConnectionString='<%$ ConnectionStrings:ConnString_WEB_ASSET_DB %>' SelectCommand="SELECT [CLIENTSTAFFID], CLIENTSTAFFFNAME+' '+CLIENTSTAFFLNAME+', '+CLIENTSTAFFPOSITION AS [CLIENTSTAFFPOS] FROM CLIENTSTAFF WHERE [CLIENTID] = @CLIENTID AND [CLIENTSTAFFID] <> @CLIENTSTAFFID AND [CLIENTSTAFFID] <> @CLIENTSTAFFID2 AND CLIENTSTAFFSTATUS='Active'">
                            <SelectParameters>
                                <asp:ControlParameter ControlID="_dropdownCompany" PropertyName="SelectedValue" Name="CLIENTID" Type="Int32"></asp:ControlParameter>
                                <asp:ControlParameter ControlID="_dropdownContact" PropertyName="SelectedValue" Name="CLIENTSTAFFID" Type="Int32"></asp:ControlParameter>
                                <asp:ControlParameter ControlID="_dropdownPrepared" PropertyName="SelectedValue" Name="CLIENTSTAFFID2" Type="Int32"></asp:ControlParameter>
                            </SelectParameters>
                        </asp:SqlDataSource>
                    </p>
                </div>
                <div class="row">
                    <h4 class="bg-info text-center" style="padding: 8px">Project Information</h4>
                    <p class="col-sm-9">
                        <label class="control-label">Project name:</label>
                        <asp:TextBox ID="PROJNAMETextBox" runat="server" Text='<%# Bind("PROJNAME") %>' CssClass="form-control"
                            data-validation="required custom"
                            data-validation-error-msg-required="You must enter a project Name"
                            data-validation-regexp="^([a-zA-Z0-9 #%&'*+,-./_]+)$"
                            data-validation-error-msg-custom="Invalid input alphanumeric only.#%&'*+,-./_ characters is allowed" />
                    </p>
                    <p class="col-sm-3">
                        <label class="control-label">Date:</label>
                        <asp:TextBox ID="DATETODAYTextBox" runat="server" Text='<%# Eval("DATETODAY","{0:MM/dd/yyyy}") %>' CssClass="form-control" Enabled="false" />
                    </p>
                </div>
                <div class="row">
                    <p class="col-sm-12">
                        <label class="control-label">Project Site:</label>
                        <asp:TextBox ID="PROJSITETextBox" runat="server" Text='<%# Bind("PROJSITE") %>' CssClass="form-control"
                            data-validation="required custom"
                            data-validation-error-msg-required="You must enter an project site/address"
                            data-validation-regexp="^([a-zA-Z0-9.,-_'@()# ]+)$"
                            data-validation-error-msg-custom="Invalid input alphanumeric only. -_'@() characters is allowed" />
                    </p>
                </div>
                <div class="row">
                    <p class="col-sm-4">
                        <label class="control-label">PMI No.:</label>
                        <asp:TextBox ID="PROJPMINOTextBox" runat="server" Text='<%# Eval("PROJPMINO") %>' CssClass="form-control" Enabled="false" />
                    </p>
                    <p class="col-sm-4">
                        <label class="control-label">Subject:</label>
                        <asp:TextBox ID="PROJSUBJTextBox" runat="server" Text='<%# Bind("PROJSUBJ") %>' CssClass="form-control"
                            data-validation="required custom"
                            data-validation-error-msg-required="You must enter a subject"
                            data-validation-regexp="^([a-zA-Z0-9 #%&'*+,-./_]+)$"
                            data-validation-error-msg-custom="Invalid input alphanumeric only. characters is allowed" />
                    </p>
                    <p class="col-sm-4">
                        <label class="control-label">Attachments:</label>
                        <asp:FileUpload ID="_fileupFileAttach" runat="server" />
                        <asp:TextBox ID="PROJATTACHTextBox" runat="server" Text='<%# Bind("PROJATTACH") %>' Visible="false" />
                    </p>
                </div>
                <div class="row">
                    <p class="col-sm-12">
                        <label class="control-label">Description:</label>
                        <asp:TextBox ID="PROJDESCTextBox" runat="server" Text='<%# Bind("PROJDESC") %>' CssClass="form-control" TextMode="MultiLine" Style="resize: none"
                            data-validation="custom" />
                    </p>
                </div>
                <div class="row">
                    <h4 class="bg-info text-center" style="padding: 8px">Contractor Information</h4>
                    <p class="col-sm-3">
                        <label class="control-label">Received by:</label>
                        <%--<asp:TextBox ID="CNTRCTRPROJRECEIIDTextBox" runat="server" Text='<%# Bind("CNTRCTRPROJRECEIID") %>' Visible="false" />--%>
                        <asp:DropDownList ID="_dropdownReceiver" runat="server" CssClass="form-control" DataSourceID="DataSourceReceiverDDList" DataTextField="COMSTAFFPOS" DataValueField="COMSTAFFID" SelectedValue='<%# Bind("CNTRCTRPROJRECEIID") %>' AppendDataBoundItems="true"
                            data-validation="custom"
                            data-validation-regexp="^0*[1-9]\d*$"
                            data-validation-error-msg-custom="You must select the receiver">
                            <asp:ListItem Value="0"> --  please select receiver --</asp:ListItem>
                        </asp:DropDownList>
                        <asp:SqlDataSource runat="server" ID="DataSourceReceiverDDList" ConnectionString='<%$ ConnectionStrings:ConnString_WEB_ASSET_DB %>' SelectCommand="SELECT [COMSTAFFID], COMSTAFFFRSTNAME+' '+COMSTAFFLASTNAME+', '+COMSTAFFPOSITION AS [COMSTAFFPOS] FROM [COMPANYSTAFF]"></asp:SqlDataSource>
                    </p>

                    <p class="col-sm-3" id="received-error-dialog">
                        <label class="control-label">Date Received:</label>
                        <span class="input-group input-append date" id="datePickerDOReceive">
                            <asp:TextBox ID="PROJRECEITextBox" runat="server" Text='<%# Bind("PROJRECEI","{0:MM/dd/yyyy}") %>' CssClass="form-control"
                                data-validation="required birthdate"
                                data-validation-format="mm/dd/yyyy"
                                data-validation-error-msg-required="You must enter the date you receive"
                                data-validation-error-msg-container="#received-error-dialog" />
                            <span class="input-group-addon add-on"><span class="glyphicon glyphicon-calendar"></span></span>
                        </span>

                    </p>
                    <p class="col-sm-3">
                        <label class="control-label">Approved by:</label>
                        <%--<asp:TextBox ID="CNTRCTRPROJAPPIDTextBox" runat="server" Text='<%# Bind("CNTRCTRPROJAPPID") %>' Visible="false" />--%>
                        <asp:DropDownList ID="_dropdownApprover" runat="server" CssClass="form-control" DataSourceID="DataSourceApprover" DataTextField="COMSTAFFPOS" DataValueField="COMSTAFFID" SelectedValue='<%# Bind("CNTRCTRPROJAPPID") %>' AppendDataBoundItems="true"
                            data-validation="custom"
                            data-validation-regexp="^0*[1-9]\d*$"
                            data-validation-error-msg-custom="You must select the approver">
                            <asp:ListItem Value="0"> --  please select approver --</asp:ListItem>
                        </asp:DropDownList>
                        <asp:SqlDataSource runat="server" ID="DataSourceApprover" ConnectionString='<%$ ConnectionStrings:ConnString_WEB_ASSET_DB %>' SelectCommand="SELECT [COMSTAFFID], COMSTAFFFRSTNAME+' '+COMSTAFFLASTNAME+', '+COMSTAFFPOSITION AS [COMSTAFFPOS] FROM [COMPANYSTAFF]"></asp:SqlDataSource>
                    </p>
                    <p class="col-sm-3" id="approved-error-dialog">
                        <label class="control-label">Date Approved:</label>
                        <span class="input-group input-append date" id="datePickerDOAppro">
                            <asp:TextBox ID="PROJAPPRTextBox" runat="server" Text='<%# Bind("PROJAPPR","{0:MM/dd/yyyy}") %>' CssClass="form-control"
                                data-validation="required birthdate"
                                data-validation-format="mm/dd/yyyy"
                                data-validation-error-msg-required="You must enter the date of approval"
                                data-validation-error-msg-container="#approved-error-dialog" />
                            <span class="input-group-addon add-on"><span class="glyphicon glyphicon-calendar"></span></span>
                        </span>
                    </p>
                </div>
                <hr />
                <div class="row">
                    <div class="col-sm-4 pull-right">
                        <div class="col-xs-6">
                            <asp:Button ID="UpdateButton" runat="server" CommandName="Update" Text="Save" CssClass="btn btn-primary center-block col-xs-12" OnClick="UpdateButton_Click" />
                        </div>
                        <div class="col-xs-6">
                            <asp:Button ID="CancelButton" runat="server" CommandName="Cancel" Text="Cancel" CssClass="btn btn-danger center-block col-xs-12" OnClientClick=" window.location = '/Project.aspx';this.form.reset();return false;" />
                        </div>
                    </div>
                </div>
            </div>
        </EditItemTemplate>
        <EmptyDataTemplate>
            <span>No data was returned.</span>
        </EmptyDataTemplate>
        <InsertItemTemplate>
            <div class="well">
                <h3>Add Project</h3>
                <div class="row">
                    <h4 class="bg-info text-center" style="padding: 8px">Client Information</h4>
                    <p class="col-sm-8">
                        <label class="control-label">Company/Business Name:</label>
                        <%--<asp:TextBox ID="CLIENTIDTextBox" runat="server" Text='<%# Bind("CLIENTID") %>' />--%>
                        <asp:DropDownList ID="_dropdownCompany" runat="server" CssClass="form-control" DataSourceID="DataSourceCompanyDDList" DataTextField="CLIENTNAME" DataValueField="CLIENTID" SelectedValue='<%# Bind("CLIENTID") %>' AppendDataBoundItems="true" AutoPostBack="true"
                            data-validation="custom"
                            data-validation-regexp="^([1-9]+)$"
                            data-validation-error-msg-custom="You must select Business/Company Name">
                            <asp:ListItem Value="0"> --  please select Business/Company Name --</asp:ListItem>
                        </asp:DropDownList>
                        <asp:SqlDataSource runat="server" ID="DataSourceCompanyDDList" ConnectionString='<%$ ConnectionStrings:ConnString_WEB_ASSET_DB %>' SelectCommand="SELECT [CLIENTID], [CLIENTNAME] FROM [CLIENT]"></asp:SqlDataSource>
                    </p>
                    <p class="col-sm-4" id="propose-error-dialog">
                        <label class="control-label">Date Proposed:</label>
                        <span class="input-group input-append date" id="datePickerDOProp">
                            <asp:TextBox ID="PROJPROPTextBox" runat="server" Text='<%# Bind("PROJPROP","{0:MM/dd/yyyy}") %>' CssClass="form-control"
                                data-validation="required birthdate"
                                data-validation-format="mm/dd/yyyy"
                                data-validation-error-msg-required="You must enter the date they proposed"
                                data-validation-error-msg-container="#propose-error-dialog" />
                            <span class="input-group-addon add-on"><span class="glyphicon glyphicon-calendar"></span></span>
                        </span>
                    </p>
                </div>
                <div class="row">
                    <p class="col-sm-4">
                        <label class="control-label">Contact Person:</label>
                        <asp:TextBox ID="CLNTPROJCONTIDTextBox" runat="server" Text='<%# Bind("CLNTPROJCONTID") %>' Visible="false" />
                        <asp:DropDownList ID="_dropdownContact" runat="server" CssClass="form-control" DataSourceID="DataSourceContactDDList" DataTextField="CLIENTSTAFFPOS" DataValueField="CLIENTSTAFFID" AutoPostBack="True">
                            <%--SelectedValue='<%# Bind("CLNTPROJCONTID") %>'>--%>
                        </asp:DropDownList>
                        <asp:SqlDataSource runat="server" ID="DataSourceContactDDList" ConnectionString='<%$ ConnectionStrings:ConnString_WEB_ASSET_DB %>' SelectCommand="SELECT [CLIENTSTAFFID], CLIENTSTAFFFNAME+' '+CLIENTSTAFFLNAME+', '+CLIENTSTAFFPOSITION AS [CLIENTSTAFFPOS] FROM [CLIENTSTAFF] WHERE ([CLIENTID] = @CLIENTID) AND CLIENTSTAFFSTATUS='Active'">
                            <SelectParameters>
                                <asp:ControlParameter ControlID="_dropdownCompany" PropertyName="SelectedValue" Name="CLIENTID" Type="Int32"></asp:ControlParameter>
                            </SelectParameters>
                        </asp:SqlDataSource>
                    </p>
                    <p class="col-sm-4">
                        <label class="control-label">Prepared by:</label>
                        <asp:TextBox ID="CLNTPROJPREPIDTextBox" runat="server" Text='<%# Bind("CLNTPROJPREPID") %>' Visible="false" />
                        <asp:DropDownList ID="_dropdownPrepared" runat="server" CssClass="form-control" DataSourceID="DataSourcePreparedDDList" DataTextField="CLIENTSTAFFPOS" DataValueField="CLIENTSTAFFID" AutoPostBack="True">
                            <%--SelectedValue='<%# Bind("CLNTPROJPREPID") %>'>--%>
                        </asp:DropDownList>
                        <asp:SqlDataSource runat="server" ID="DataSourcePreparedDDList" ConnectionString='<%$ ConnectionStrings:ConnString_WEB_ASSET_DB %>' SelectCommand="SELECT [CLIENTSTAFFID], CLIENTSTAFFFNAME+' '+CLIENTSTAFFLNAME+', '+CLIENTSTAFFPOSITION AS [CLIENTSTAFFPOS] FROM [CLIENTSTAFF] WHERE ([CLIENTID] = @CLIENTID) AND CLIENTSTAFFSTATUS='Active'">
                            <SelectParameters>
                                <asp:ControlParameter ControlID="_dropdownCompany" PropertyName="SelectedValue" Name="CLIENTID" Type="Int32"></asp:ControlParameter>
                            </SelectParameters>
                        </asp:SqlDataSource>
                    </p>
                    <p class="col-sm-4">
                        <label class="control-label">Approved by:</label>
                        <asp:TextBox ID="CLNTPROJAPPIDTextBox" runat="server" Text='<%# Bind("CLNTPROJAPPID") %>' Visible="false" />
                        <asp:DropDownList ID="_dropdownApproved" runat="server" CssClass="form-control" DataSourceID="DataSourceApprovedDDList" DataTextField="CLIENTSTAFFPOS" DataValueField="CLIENTSTAFFID" AutoPostBack="True">
                            <%--SelectedValue='<%# Bind("CLNTPROJAPPID") %>'>--%>
                        </asp:DropDownList>
                        <asp:SqlDataSource runat="server" ID="DataSourceApprovedDDList" ConnectionString='<%$ ConnectionStrings:ConnString_WEB_ASSET_DB %>' SelectCommand="SELECT [CLIENTSTAFFID], CLIENTSTAFFFNAME+' '+CLIENTSTAFFLNAME+', '+CLIENTSTAFFPOSITION AS [CLIENTSTAFFPOS] FROM CLIENTSTAFF WHERE [CLIENTID] = @CLIENTID AND [CLIENTSTAFFID] <> @CLIENTSTAFFID AND [CLIENTSTAFFID] <> @CLIENTSTAFFID2 AND CLIENTSTAFFSTATUS='Active'">
                            <SelectParameters>
                                <asp:ControlParameter ControlID="_dropdownCompany" PropertyName="SelectedValue" Name="CLIENTID" Type="Int32"></asp:ControlParameter>
                                <asp:ControlParameter ControlID="_dropdownContact" PropertyName="SelectedValue" Name="CLIENTSTAFFID" Type="Int32"></asp:ControlParameter>
                                <asp:ControlParameter ControlID="_dropdownPrepared" PropertyName="SelectedValue" Name="CLIENTSTAFFID2" Type="Int32"></asp:ControlParameter>
                            </SelectParameters>
                        </asp:SqlDataSource>
                    </p>
                </div>
                <div class="row">
                    <h4 class="bg-info text-center" style="padding: 8px">Project Information</h4>
                    <p class="col-sm-9">
                        <label class="control-label">Project name:</label>
                        <asp:TextBox ID="PROJNAMETextBox" runat="server" Text='<%# Bind("PROJNAME") %>' CssClass="form-control"
                            data-validation="required custom"
                            data-validation-error-msg-required="You must enter a project Name"
                            data-validation-regexp="^([a-zA-Z0-9 #%&'*+,-./_]+)$"
                            data-validation-error-msg-custom="Invalid input alphanumeric only.#%&'*+,-./_ characters is allowed" />
                    </p>
                    <p class="col-sm-3">
                        <label class="control-label">Date:</label>
                        <asp:TextBox ID="DATETODAYTextBox" runat="server" Text='<%# Bind("DATETODAY","{0:MM/dd/yyyy}") %>' CssClass="form-control" Enabled="false" />
                    </p>
                </div>
                <div class="row">
                    <p class="col-sm-12">
                        <label class="control-label">Project Site:</label>
                        <asp:TextBox ID="PROJSITETextBox" runat="server" Text='<%# Bind("PROJSITE") %>' CssClass="form-control"
                            data-validation="required custom"
                            data-validation-error-msg-required="You must enter an project site/address"
                            data-validation-regexp="^([a-zA-Z0-9.,-_'@()# ]+)$"
                            data-validation-error-msg-custom="Invalid input alphanumeric only. -_'@() characters is allowed" />
                    </p>
                </div>
                <div class="row">
                    <p class="col-sm-4">
                        <label class="control-label">PMI No.:</label>
                        <asp:TextBox ID="PROJPMINOTextBox" runat="server" Text='<%# Bind("PROJPMINO") %>' CssClass="form-control" Enabled="false" />
                    </p>
                    <p class="col-sm-4">
                        <label class="control-label">Subject:</label>
                        <asp:TextBox ID="PROJSUBJTextBox" runat="server" Text='<%# Bind("PROJSUBJ") %>' CssClass="form-control"
                            data-validation="required custom"
                            data-validation-error-msg-required="You must enter a subject"
                            data-validation-regexp="^([a-zA-Z0-9 #%&'*+,-./_]+)$"
                            data-validation-error-msg-custom="Invalid input alphanumeric only. characters is allowed" />
                    </p>
                    <p class="col-sm-4">
                        <label class="control-label">Attachments:</label>
                        <asp:FileUpload ID="_fileupFileAttach" runat="server" />
                        <asp:TextBox ID="PROJATTACHTextBox" runat="server" Text='<%# Bind("PROJATTACH") %>' Visible="false" />
                    </p>
                </div>
                <div class="row">
                    <p class="col-sm-12">
                        <label class="control-label">Description:</label>
                        <asp:TextBox ID="PROJDESCTextBox" runat="server" Text='<%# Bind("PROJDESC") %>' CssClass="form-control" TextMode="MultiLine" Style="resize: none"
                            data-validation="custom" />
                    </p>
                </div>
                <div class="row">
                    <h4 class="bg-info text-center" style="padding: 8px">Contractor Information</h4>
                    <p class="col-sm-3">
                        <label class="control-label">Received by:</label>
                        <%--<asp:TextBox ID="CNTRCTRPROJRECEIIDTextBox" runat="server" Text='<%# Bind("CNTRCTRPROJRECEIID") %>' Visible="false" />--%>
                        <asp:DropDownList ID="_dropdownReceiver" runat="server" CssClass="form-control" DataSourceID="DataSourceReceiverDDList" DataTextField="COMSTAFFPOS" DataValueField="COMSTAFFID" SelectedValue='<%# Bind("CNTRCTRPROJRECEIID") %>' AppendDataBoundItems="true"
                            data-validation="custom"
                            data-validation-regexp="^0*[1-9]\d*$"
                            data-validation-error-msg-custom="You must select the receiver">
                            <asp:ListItem Value="0"> --  please select receiver --</asp:ListItem>
                        </asp:DropDownList>
                        <asp:SqlDataSource runat="server" ID="DataSourceReceiverDDList" ConnectionString='<%$ ConnectionStrings:ConnString_WEB_ASSET_DB %>' SelectCommand="SELECT [COMSTAFFID], COMSTAFFFRSTNAME+' '+COMSTAFFLASTNAME+', '+COMSTAFFPOSITION AS [COMSTAFFPOS] FROM [COMPANYSTAFF]"></asp:SqlDataSource>
                    </p>

                    <p class="col-sm-3" id="received-error-dialog">
                        <label class="control-label">Date Received:</label>
                        <span class="input-group input-append date" id="datePickerDOReceive">
                            <asp:TextBox ID="PROJRECEITextBox" runat="server" Text='<%# Bind("PROJRECEI","{0:MM/dd/yyyy}") %>' CssClass="form-control"
                                data-validation="required birthdate"
                                data-validation-format="mm/dd/yyyy"
                                data-validation-error-msg-required="You must enter the date you receive"
                                data-validation-error-msg-container="#received-error-dialog" />
                            <span class="input-group-addon add-on"><span class="glyphicon glyphicon-calendar"></span></span>
                        </span>

                    </p>
                    <p class="col-sm-3">
                        <label class="control-label">Approved by:</label>
                        <%--<asp:TextBox ID="CNTRCTRPROJAPPIDTextBox" runat="server" Text='<%# Bind("CNTRCTRPROJAPPID") %>' Visible="false" />--%>
                        <asp:DropDownList ID="_dropdownApprover" runat="server" CssClass="form-control" DataSourceID="DataSourceApprover" DataTextField="COMSTAFFPOS" DataValueField="COMSTAFFID" SelectedValue='<%# Bind("CNTRCTRPROJAPPID") %>' AppendDataBoundItems="true"
                            data-validation="custom"
                            data-validation-regexp="^0*[1-9]\d*$"
                            data-validation-error-msg-custom="You must select the approver">
                            <asp:ListItem Value="0"> --  please select approver --</asp:ListItem>
                        </asp:DropDownList>
                        <asp:SqlDataSource runat="server" ID="DataSourceApprover" ConnectionString='<%$ ConnectionStrings:ConnString_WEB_ASSET_DB %>' SelectCommand="SELECT [COMSTAFFID], COMSTAFFFRSTNAME+' '+COMSTAFFLASTNAME+', '+COMSTAFFPOSITION AS [COMSTAFFPOS] FROM [COMPANYSTAFF]"></asp:SqlDataSource>
                    </p>
                    <p class="col-sm-3" id="approved-error-dialog">
                        <label class="control-label">Date Approved:</label>
                        <span class="input-group input-append date" id="datePickerDOAppro">
                            <asp:TextBox ID="PROJAPPRTextBox" runat="server" Text='<%# Bind("PROJAPPR","{0:MM/dd/yyyy}") %>' CssClass="form-control"
                                data-validation="required birthdate"
                                data-validation-format="mm/dd/yyyy"
                                data-validation-error-msg-required="You must enter the date of approval"
                                data-validation-error-msg-container="#approved-error-dialog" />
                            <span class="input-group-addon add-on"><span class="glyphicon glyphicon-calendar"></span></span>
                        </span>
                    </p>
                </div>
                <hr />
                <div class="row">
                    <div class="col-sm-4 pull-right">
                        <div class="col-xs-6">
                            <asp:Button ID="InsertButton" runat="server" CommandName="Insert" Text="Save" CssClass="btn btn-primary center-block col-xs-12" OnClick="InsertButton_Click" />
                        </div>
                        <div class="col-xs-6">
                            <asp:Button ID="CancelButton" runat="server" CommandName="Cancel" Text="Cancel" CssClass="btn btn-danger center-block col-xs-12" OnClientClick=" window.location = '/Project.aspx';this.form.reset();return false;" />
                        </div>
                    </div>
                </div>
            </div>
        </InsertItemTemplate>
        <ItemTemplate>
            <span style="">
                <div class="well">
                    <div class="row">
                        <div class="col-sm-6">
                            <label class="control-label">ID:</label>
                            <asp:Label ID="PROJIDLabel" runat="server" Text='<%# Eval("PROJID") %>' />
                            <br />
                            <label class="control-label">Project Name:</label>
                            <asp:Label ID="PROJNAMELabel" runat="server" Text='<%# Eval("PROJNAME") %>' />
                            <br />
                            <label class="control-label">Client Name:</label>
                            <asp:Label ID="CLIENTIDLabel" runat="server" Text='<%# Eval("CLIENTNAME") %>' />
                            <br />
                            <label class="control-label">Date Created:</label>
                            <asp:Label ID="DATETODAYLabel" runat="server" Text='<%# Eval("DATETODAY","{0:MMMM dd, yyyy}") %>' />
                            <br />
                            <label class="control-label">Project Site/Address:</label>
                            <asp:Label ID="PROJSITELabel" runat="server" Text='<%# Eval("PROJSITE") %>' />
                            <br />
                            <label class="control-label">PMI No.:</label>
                            <asp:Label ID="PROJPMINOLabel" runat="server" Text='<%# Eval("PROJPMINO") %>' />
                            <br />
                            <label class="control-label">Subject:</label>
                            <asp:Label ID="PROJSUBJLabel" runat="server" Text='<%# Eval("PROJSUBJ") %>' />
                        </div>
                        <div class="col-sm-6">
                            <label class="control-label">Attachments:</label>
                            <asp:Label ID="PROJATTACHLabel" runat="server" Text='<%# Eval("PROJATTACH") %>' />
                            <br />
                            <label class="control-label">Description:</label>
                            <asp:Label ID="PROJDESCLabel" runat="server" Text='<%# Eval("PROJDESC") %>' />
                            <br />
                            <label class="control-label">Date proposed:</label>
                            <asp:Label ID="PROJPROPLabel" runat="server" Text='<%# Eval("PROJPROP","{0:MMMM dd, yyyy}") %>' />
                            <br />
                            <label class="control-label">Contact Person:</label>
                            <asp:Label ID="CLNTPROJCONTIDLabel" runat="server" Text='<%# Eval("CLNTSTFFNAME") %>' />
                            <br />
                            <label class="control-label">Date Received:</label>
                            <asp:Label ID="PROJRECEILabel" runat="server" Text='<%# Eval("PROJRECEI","{0:MM/dd/yyyy}") %>' />
                            <br />
                            <label class="control-label">Approved By:</label>
                            <asp:Label ID="CNTRCTRPROJAPPIDLabel" runat="server" Text='<%# Eval("COMPSTFFNAME") %>' />
                            <br />
                            <label class="control-label">Date Approved:</label>
                            <asp:Label ID="PROJAPPRLabel" runat="server" Text='<%# Eval("PROJAPPR","{0:MMMM dd, yyyy}") %>' />
                        </div>
                    </div>
                    <hr />
                    <div class="row">
                        <div class="col-sm-3 pull-right ">
                            <asp:Button ID="EditButton" runat="server" CommandName="Edit" Text="Edit" CssClass="btn btn-primary " />
                            <span onclick="return confirm('Are you sure to delete?')">
                                <asp:Button ID="DeleteButton" runat="server" CommandName="Delete" Text="Delete" CssClass="btn btn-danger" />
                            </span>
                            <asp:Button ID="BackButton" runat="server" Text="Back" CssClass="btn btn-warning" OnClientClick="window.history.go(-1);return false;" />
                            <%--<input type="button" value="Back" onclick="window.location = 'Project.aspx';" class="btn btn-warning" />--%>
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
                <asp:DataPager ID="DataPager2" runat="server" PageSize="1" Visible="false">
                    <Fields>
                        <asp:NextPreviousPagerField ButtonType="Button" ShowFirstPageButton="True" ShowNextPageButton="False" ShowPreviousPageButton="False" />
                        <asp:NumericPagerField NumericButtonCssClass="label label-success" CurrentPageLabelCssClass="badge" />
                        <asp:NextPreviousPagerField ButtonType="Button" ShowLastPageButton="True" ShowNextPageButton="False" ShowPreviousPageButton="False" />
                    </Fields>
                </asp:DataPager>
            </div>
        </LayoutTemplate>
    </asp:ListView>
    <asp:SqlDataSource ID="DataSourceProjectCRUD" runat="server" ConnectionString="<%$ ConnectionStrings:ConnString_WEB_ASSET_DB %>" DeleteCommand="DELETE FROM [PROJECT] WHERE [PROJID] = @PROJID" InsertCommand="INSERT INTO [PROJECT] ([PROJNAME], [DATETODAY], [PROJSITE], [PROJPMINO], [PROJSUBJ], [PROJATTACH], [PROJDESC], [CLIENTID], [PROJPROP], [CLNTPROJCONTID], [CLNTPROJPREPID], [CLNTPROJAPPID], [CNTRCTRPROJAPPID], [PROJAPPR], [CNTRCTRPROJRECEIID], [PROJRECEI], [PROGRESS]) VALUES (@PROJNAME, @DATETODAY, @PROJSITE, @PROJPMINO, @PROJSUBJ, @PROJATTACH, @PROJDESC, @CLIENTID, @PROJPROP, @CLNTPROJCONTID, @CLNTPROJPREPID, @CLNTPROJAPPID, @CNTRCTRPROJAPPID, @PROJAPPR, @CNTRCTRPROJRECEIID, @PROJRECEI, 'On Queue')" SelectCommand="SELECT PROJECT.PROJID, PROJECT.PROJNAME, PROJECT.PROJSITE, PROJECT.PROJSUBJ, PROJECT.PROJDESC, PROJECT.PROJATTACH, PROJECT.PROJPMINO, PROJECT.DATETODAY, PROJECT.PROJPROP, PROJECT.PROJAPPR, PROJECT.PROJRECEI, CLIENT.CLIENTNAME, CLIENTSTAFF.CLIENTSTAFFFNAME + ' ' + CLIENTSTAFF.CLIENTSTAFFLNAME + ', ' + CLIENTSTAFF.CLIENTSTAFFPOSITION AS CLNTSTFFNAME, COMPANYSTAFF.COMSTAFFFRSTNAME + ' ' + COMPANYSTAFF.COMSTAFFLASTNAME + ', ' + COMPANYSTAFF.COMSTAFFPOSITION AS COMPSTFFNAME, PROJECT.CLIENTID, PROJECT.CLNTPROJCONTID, PROJECT.CLNTPROJPREPID, PROJECT.CLNTPROJAPPID, PROJECT.CNTRCTRPROJRECEIID, PROJECT.CNTRCTRPROJAPPID FROM PROJECT INNER JOIN CLIENT ON PROJECT.CLIENTID = CLIENT.CLIENTID INNER JOIN CLIENTSTAFF ON PROJECT.CLNTPROJCONTID = CLIENTSTAFF.CLIENTSTAFFID INNER JOIN COMPANYSTAFF ON PROJECT.CNTRCTRPROJAPPID = COMPANYSTAFF.COMSTAFFID WHERE (PROJECT.PROJID = @PROJID)" UpdateCommand="UPDATE [PROJECT] SET [PROJNAME] = @PROJNAME, [PROJSITE] = @PROJSITE, [PROJSUBJ] = @PROJSUBJ, [PROJATTACH] = @PROJATTACH, [PROJDESC] = @PROJDESC, [CLIENTID] = @CLIENTID, [PROJPROP] = @PROJPROP, [CLNTPROJCONTID] = @CLNTPROJCONTID, [CLNTPROJPREPID] = @CLNTPROJPREPID, [CLNTPROJAPPID] = @CLNTPROJAPPID, [CNTRCTRPROJAPPID] = @CNTRCTRPROJAPPID, [PROJAPPR] = @PROJAPPR, [CNTRCTRPROJRECEIID] = @CNTRCTRPROJRECEIID, [PROJRECEI] = @PROJRECEI WHERE [PROJID] = @PROJID">
        <DeleteParameters>
            <asp:Parameter Name="PROJID" Type="Int32" />
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="PROJNAME" Type="String" />
            <asp:Parameter Name="DATETODAY" DbType="Date" />
            <asp:Parameter Name="PROJSITE" Type="String" />
            <asp:Parameter Name="PROJPMINO" Type="String" />
            <asp:Parameter Name="PROJSUBJ" Type="String" />
            <asp:Parameter Name="PROJATTACH" Type="String" />
            <asp:Parameter Name="PROJDESC" Type="String" />
            <asp:Parameter Name="CLIENTID" Type="Int32" />
            <asp:Parameter DbType="Date" Name="PROJPROP" />
            <asp:Parameter Name="CLNTPROJCONTID" Type="Int32" />
            <asp:Parameter Name="CLNTPROJPREPID" Type="Int32" />
            <asp:Parameter Name="CLNTPROJAPPID" Type="Int32" />
            <asp:Parameter Name="CNTRCTRPROJAPPID" Type="Int32" />
            <asp:Parameter Name="PROJAPPR" DbType="Date" />
            <asp:Parameter Name="CNTRCTRPROJRECEIID" Type="Int32" />
            <asp:Parameter Name="PROJRECEI" DbType="Date" />
        </InsertParameters>
        <SelectParameters>
            <asp:QueryStringParameter Name="PROJID" QueryStringField="id" Type="Int32" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="PROJNAME" Type="String" />
            <asp:Parameter Name="PROJSITE" Type="String" />
            <asp:Parameter Name="PROJSUBJ" Type="String" />
            <asp:Parameter Name="PROJATTACH" Type="String" />
            <asp:Parameter Name="PROJDESC" Type="String" />
            <asp:Parameter Name="CLIENTID" Type="Int32" />
            <asp:Parameter Name="PROJPROP" DbType="Date" />
            <asp:Parameter Name="CLNTPROJCONTID" Type="Int32" />
            <asp:Parameter Name="CLNTPROJPREPID" Type="Int32" />
            <asp:Parameter Name="CLNTPROJAPPID" Type="Int32" />
            <asp:Parameter Name="CNTRCTRPROJAPPID" Type="Int32" />
            <asp:Parameter Name="PROJAPPR" DbType="Date" />
            <asp:Parameter Name="CNTRCTRPROJRECEIID" Type="Int32" />
            <asp:Parameter Name="PROJRECEI" DbType="Date" />
            <asp:Parameter Name="PROJID" Type="Int32" />
        </UpdateParameters>
    </asp:SqlDataSource>
    <script type="text/javascript">
        $.validate({
            modules: 'date',
        })
    </script>
    <script type="text/javascript">
        $(function () {
            $('#datePickerDOProp').datepicker({
                format: 'mm/dd/yyyy',
                todayHighlight: true,
            });
            $('#datePickerDOReceive').datepicker({
                format: 'mm/dd/yyyy',
                todayHighlight: true,
            });
            $('#datePickerDOAppro').datepicker({
                format: 'mm/dd/yyyy',
                todayHighlight: true,
            });
        });
    </script>
</asp:Content>

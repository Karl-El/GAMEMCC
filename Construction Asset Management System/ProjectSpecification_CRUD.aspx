<%@ Page Title="Project Specification" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ProjectSpecification_CRUD.aspx.cs" Inherits="Construction_Asset_Management_System.ProjectSpecification_CRUD" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <link href="Scripts/Date Picker/datepicker.min.css" rel="stylesheet" type="text/css" />
    <script src="Scripts/Date Picker/bootstrap-datepicker.min.js"></script>
    <script src="Scripts/Form Validator/jquery.form-validator.js"></script>
    <link href="Scripts/Form Validator/theme-default.css" rel="stylesheet" type="text/css" />
    <link href="Content/checkbox.css" rel="stylesheet" type="text/css" />
    <h4 class="well text-center" style="padding: 8px">Project Specification</h4>
    <asp:Panel ID="_panelProjReqDetails" runat="server">
        <div class="well">
            <div class="row">
                <h4 class="bg-info text-center" style="padding: 8px">Select a Project</h4>
                <p>
                    <label class="control-label">Project name:</label>
                    <asp:DropDownList ID="_dropdownProject" runat="server" CssClass="form-control" DataSourceID="DataSourceProjectDDList" DataTextField="PROJCLIENT" DataValueField="PROJID" AppendDataBoundItems="true" AutoPostBack="true" OnSelectedIndexChanged="_dropdownProject_SelectedIndexChanged" OnPreRender="_dropdownProject_PreRender"
                        data-validation="required"
                        data-validation-error-msg-required="You must select a Project">
                        <asp:ListItem Value=" "> -- please select a Project --  </asp:ListItem>
                    </asp:DropDownList>
                    <asp:SqlDataSource runat="server" ID="DataSourceProjectDDList" ConnectionString='<%$ ConnectionStrings:ConnString_WEB_ASSET_DB %>' SelectCommand="SELECT PROJECT.PROJID, CLIENT.CLIENTNAME + ', ' + PROJECT.PROJNAME AS PROJCLIENT FROM PROJECT INNER JOIN CLIENT ON CLIENT.CLIENTID = PROJECT.CLIENTID WHERE (PROJECT.PROGRESS <> 'Finish')"></asp:SqlDataSource>
                </p>
                <div class="col-sm-5">
                    <h5 class="bg-success text-center" style="padding: 8px">Project Requirements</h5>
                    <div class="col-sm-6">
                        <h5 class="bg-primary text-center" style="padding: 8px">Worker Needed</h5>
                        <asp:BulletedList ID="_bulletlistProjTrade" runat="server" DataSourceID="DataSourceProjTradeTOTAL" DataTextField="PROJTRADEQUANT" BulletStyle="Square" Height="100%"></asp:BulletedList>
                        <asp:SqlDataSource runat="server" ID="DataSourceProjTradeTOTAL" ConnectionString='<%$ ConnectionStrings:ConnString_WEB_ASSET_DB %>' SelectCommand="SELECT CAST(PROJREQTRADE.TRADEQUANTITY AS VARCHAR(10)) + '  -  ' + TRADE.TRADENAME AS [PROJTRADEQUANT] FROM PROJREQTRADE INNER JOIN TRADE ON PROJREQTRADE.TRADEID = TRADE.TRADEID WHERE (PROJREQTRADE.PROJID = @PROJID)">
                            <SelectParameters>
                                <asp:ControlParameter ControlID="_dropdownProject" PropertyName="SelectedValue" Name="PROJID"></asp:ControlParameter>
                            </SelectParameters>
                        </asp:SqlDataSource>
                        <asp:Label ID="Label1" runat="server" Text="Label" CssClass="text-info" Font-Size="Larger">Total Worker:</asp:Label>
                        <asp:Label ID="_labelTotalTrade" runat="server" Text="Label" CssClass="text-danger" Font-Size="Larger" Font-Bold="true">0</asp:Label>
                    </div>
                    <div class="col-sm-6">
                        <h5 class="bg-primary text-center" style="padding: 8px">Equipment Needed</h5>
                        <asp:BulletedList ID="_bulletlistProjEquip" runat="server" DataSourceID="DataSourceProjEquipTOTAL" DataTextField="PROJEQUIPQUANT" BulletStyle="Square" Height="100%"></asp:BulletedList>
                        <asp:SqlDataSource runat="server" ID="DataSourceProjEquipTOTAL" ConnectionString='<%$ ConnectionStrings:ConnString_WEB_ASSET_DB %>' SelectCommand="SELECT CAST(PROJREQEQUIP.EQUIPQUANTITY AS VARCHAR(10)) + '  -  ' + EQUIPMENT.EQUIPMENTNAME AS PROJEQUIPQUANT FROM EQUIPMENT INNER JOIN PROJREQEQUIP ON EQUIPMENT.EQUIPMENTID = PROJREQEQUIP.EQUIPMENTID WHERE (PROJREQEQUIP.PROJID = @PROJID)">
                            <SelectParameters>
                                <asp:ControlParameter ControlID="_dropdownProject" PropertyName="SelectedValue" Name="PROJID"></asp:ControlParameter>
                            </SelectParameters>
                        </asp:SqlDataSource>
                        <asp:Label ID="Label2" runat="server" Text="Label" CssClass="text-info" Font-Size="Larger">Total Equipment:</asp:Label>
                        <asp:Label ID="_labelTotalEquip" runat="server" Text="Label" CssClass="text-danger" Font-Size="Larger" Font-Bold="true">0</asp:Label>
                    </div>
                </div>
                <div class="col-sm-7">
                    <h5 class="bg-success text-center" style="padding: 8px">Project Details</h5>
                    <div class="col-sm-12">
                        <h5 class="bg-primary" style="padding: 8px">Project Information</h5>
                        <label class="control-label">Project Site:</label>
                        <asp:Label ID="_labelSite" runat="server" CssClass="control-label" />
                        <br />
                        <label class="control-label">PMI No.:</label>
                        <asp:Label ID="_labelPMI" runat="server" CssClass="control-label" />
                        <h5 class="bg-primary" style="padding: 8px">Contractor Information</h5>
                        <label class="control-label">Approved by:</label>
                        <asp:Label ID="_labelSiteApprover" runat="server" CssClass="control-label" />
                        <br />
                        <label class="control-label">Date Approved:</label>
                        <asp:Label ID="_labelSiteDateApp" runat="server" CssClass="control-label" />
                        <asp:SqlDataSource ID="DataSourceProj" runat="server" ConnectionString='<%$ ConnectionStrings:ConnString_WEB_ASSET_DB %>' SelectCommand="SELECT PROJID,PROJSITE,PROJPMINO,PROJAPPR, COMPANYSTAFF.COMSTAFFFRSTNAME+' '+COMPANYSTAFF.COMSTAFFLASTNAME+', '+COMPANYSTAFF.COMSTAFFPOSITION AS [COMPSTAFFPOS] FROM PROJECT JOIN COMPANYSTAFF ON PROJECT.CNTRCTRPROJAPPID=COMPANYSTAFF.COMSTAFFID WHERE PROJID=@PROJID">
                            <SelectParameters>
                                <asp:ControlParameter ControlID="_dropdownProject" PropertyName="SelectedValue" Name="PROJID"></asp:ControlParameter>
                            </SelectParameters>
                        </asp:SqlDataSource>

                        <h5 class="bg-primary" style="padding: 8px">Project Additional Information</h5>
                        <div class="row">
                            <p class="col-sm-6">
                                <label class="control-label">Project Status:</label>
                                <asp:DropDownList ID="_dropdownProjectStat" runat="server" CssClass="form-control"
                                    data-validation="required"
                                    data-validation-error-msg-required="You must select a Status">
                                    <asp:ListItem Value=" ">-- Please select a status --</asp:ListItem>
                                    <asp:ListItem>On Queue</asp:ListItem>
                                    <asp:ListItem>On Going</asp:ListItem>
                                </asp:DropDownList>
                            </p>
                            <p class="col-sm-6">
                                <label class="control-label">Project Shift:</label>
                                <asp:DropDownList ID="_dropdownProjectShift" runat="server" CssClass="form-control" AppendDataBoundItems="true"
                                    data-validation="required"
                                    data-validation-error-msg-required="You must select a Status" DataSourceID="DataSourceShiftDDList" DataTextField="SHIFTNAME" DataValueField="SHIFTID">
                                    <asp:ListItem Value=" ">-- Please select a Shift --</asp:ListItem>
                                </asp:DropDownList>
                                <asp:SqlDataSource runat="server" ID="DataSourceShiftDDList" ConnectionString='<%$ ConnectionStrings:ConnString_WEB_ASSET_DB %>' SelectCommand="SELECT SHIFTID, SHIFTNAME FROM SHIFT"></asp:SqlDataSource>
                            </p>
                        </div>
                        <div class="row">
                            <p class="col-sm-6" id="datestart-error-dialog">
                                <label class="control-label">From:</label>
                                <span class="input-group input-append date" id="datePickerProjFrom">
                                    <asp:TextBox ID="_txtFromDate" runat="server" CssClass="form-control"
                                        data-validation="required custom"
                                        data-validation-error-msg-required="You must select a Start Date"
                                        data-validation-regexp="^([0-9/]+)$"
                                        data-validation-error-msg-custom="Invalid date."
                                        data-validation-error-msg-container="#datestart-error-dialog" />
                                    <span class="input-group-addon add-on"><span class="glyphicon glyphicon-calendar"></span></span>
                                </span>
                            </p>
                            <p class="col-sm-6" id="dateend-error-dialog">
                                <label class="control-label">To:</label>
                                <span class="input-group input-append date" id="datePickerProjTo">
                                    <asp:TextBox ID="_txtToDate" runat="server" CssClass="form-control"
                                        data-validation="required custom"
                                        data-validation-error-msg-required="You must select a End Date"
                                        data-validation-regexp="^([0-9/]+)$"
                                        data-validation-error-msg-custom="Invalid date."
                                        data-validation-error-msg-container="#dateend-error-dialog" />
                                    <span class="input-group-addon add-on"><span class="glyphicon glyphicon-calendar"></span></span>
                                </span>
                            </p>
                        </div>
                    </div>
                </div>
            </div>
            <script type="text/javascript">
                $(function () {
                    $('#datePickerProjFrom').datepicker({
                        format: 'mm/dd/yyyy',
                        todayHighlight: true,
                    });
                    $('#datePickerProjTo').datepicker({
                        format: 'mm/dd/yyyy',
                        todayHighlight: true,
                    });
                });
            </script>
            <hr />
            <div class="row">
                <div class="col-sm-4 pull-right">
                    <div class="col-sm-6">
                    </div>
                    <div class="col-sm-6">
                        <asp:Button ID="NextButton1" runat="server" Text="Next" CssClass="btn btn-success center-block col-xs-12" OnClick="NextButton1_Click" />
                    </div>
                </div>
                <div class="col-sm-4 pull-left">
                    <div class="col-sm-6">
                        <asp:Button ID="CancelButton" runat="server" CommandName="Cancel" Text="Cancel" CssClass="btn btn-danger center-block col-xs-12" OnClientClick=" window.location = '/ProjectSpecification.aspx';return false;" />
                    </div>
                </div>
            </div>
        </div>
    </asp:Panel>

    <asp:Panel ID="_panelEquipMain" runat="server" Visible="false">
        <div class="well">
            <div class="row">
                <h4 class="bg-info text-center" style="padding: 8px">Equipment</h4>
                <div class="col-sm-3">
                    <h5 class="bg-primary text-center" style="padding: 8px">Equipment Needed</h5>
                    <asp:BulletedList ID="_bulletlistProjEquip2" runat="server" DataSourceID="DataSourceProjEquipTOTAL" DataTextField="PROJEQUIPQUANT" BulletStyle="Square" Height="100%"></asp:BulletedList>
                    <asp:Label ID="Label3" runat="server" Text="Label" CssClass="text-info" Font-Size="Larger">Total Equipment:</asp:Label>
                    <asp:Label ID="_labelTotalEquip2" runat="server" Text="Label" CssClass="text-danger" Font-Size="Larger" Font-Bold="true">0</asp:Label>
                </div>
                <div class="col-sm-9">
                    <asp:Panel ID="_panelAssEquipList" runat="server" Height="250" Visible="false">
                        <div class="row">
                            <h5 class="bg-info text-center" style="padding: 8px">Assign Equipments</h5>
                            <div class="col-sm-6">
                                <div class="text-center">
                                    <asp:LinkButton ID="_btnEquipAdd" runat="server" CssClass="btn btn-info" OnClick="_btnEquipAdd_Click">Add</asp:LinkButton>
                                </div>
                                <asp:CheckBoxList ID="_chkbxlistEquipAdd" runat="server" CssClass="checkbox checkbox-success" RepeatLayout="Table" RepeatDirection="Vertical" TextAlign="Right" OnPreRender="_chkbxlistEquipAdd_PreRender"></asp:CheckBoxList>
                            </div>
                            <div class="col-sm-6">
                                <div class="text-center">
                                    <asp:LinkButton ID="_btnEquipRemove" runat="server" CssClass="btn btn-danger" OnClick="_btnEquipRemove_Click">Remove</asp:LinkButton>
                                </div>
                                <asp:CheckBoxList ID="_chkbxlistEquipRemove" runat="server" CssClass="checkbox checkbox-danger" RepeatLayout="Table" RepeatDirection="Vertical" TextAlign="Right"></asp:CheckBoxList>
                            </div>
                            <%--<asp:SqlDataSource runat="server" ID="DataSourceReqEquipChkBxLst" ConnectionString='<%$ ConnectionStrings:ConnString_WEB_ASSET_DB %>' SelectCommand="SELECT [EQUIPMENTID], [EQUIPMENTNAME] FROM [EQUIPMENT] WHERE ([STOCK] <> @STOCK)">
                                <SelectParameters>
                                    <asp:Parameter DefaultValue="0" Name="STOCK" Type="String"></asp:Parameter>
                                </SelectParameters>
                            </asp:SqlDataSource>--%>
                        </div>
                        <hr />
                        <div class="row">
                            <div class="col-sm-4 pull-right">
                                <div class="col-sm-6">
                                    <asp:Button ID="BackButtonPage2" runat="server" Text="Back" CssClass="btn btn-danger center-block col-xs-12" OnClick="BackButtonPage2_Click" />
                                </div>
                                <div class="col-sm-6">
                                    <asp:Button ID="NextButtonPage2" runat="server" Text="Next" CssClass="btn btn-success center-block col-xs-12" OnClick="NextButtonPage2_Click" />
                                </div>
                            </div>
                            <div class="col-sm-4 pull-left">
                                <div class="col-sm-6">
                                    <asp:Button ID="Button1" runat="server" CommandName="Cancel" Text="Cancel" CssClass="btn btn-danger center-block col-xs-12" OnClientClick=" window.location = '/ProjectSpecification.aspx';return false;" />
                                </div>
                            </div>
                        </div>
                    </asp:Panel>
                    <asp:Panel ID="_panelAssEquipQuant" runat="server" Visible="false">
                        <div class="row">
                            <h5 class="bg-info text-center" style="padding: 8px">Add Quantity</h5>
                            <asp:ListView ID="_listviewAssEquipQuant" runat="server" DataSourceID="DataSourceAssEquipQuantListView" DataKeyNames="ASSIGNEDEQUIPID" OnItemUpdating="_listviewAssEquipQuant_ItemUpdating">
                                <EditItemTemplate>
                                    <tr style="">
                                        <%--<td>
                                            <asp:Label Text='<%# Eval("ASSIGNEDEQUIPID") %>' runat="server" ID="ASSIGNEDEQUIPIDLabel1" /></td>
                                        <td>
                                            <asp:TextBox Text='<%# Bind("PROJID") %>' runat="server" ID="PROJIDTextBox" /></td>
                                        <td>
                                            <asp:TextBox Text='<%# Bind("EQUIPMENTID") %>' runat="server" ID="EQUIPMENTIDTextBox" /></td>--%>
                                        <td>
                                            <asp:TextBox Text='<%# Bind("EQUIPMENTID") %>' runat="server" ID="EQUIPMENTIDTextBox" Visible="false" />
                                            <asp:TextBox Text='<%# Bind("EQUIPMENTNAME") %>' runat="server" ID="EQUIPMENTNAMETextBox" CssClass="form-control" Enabled="false" /></td>
                                        <td>
                                            <asp:TextBox Text='<%# Bind("ASSEQUIPQUANT") %>' runat="server" ID="ASSEQUIPQUANTTextBox" CssClass="form-control" />
                                            <asp:RegularExpressionValidator ID="RegularExpressionValidator1" ControlToValidate="ASSEQUIPQUANTTextBox" runat="server" ErrorMessage="Whole numbers only" ValidationExpression="^[0-9]+$" Display="Static" ForeColor="#FF3535" SetFocusOnError="True"></asp:RegularExpressionValidator>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="Must at least have single digit" ControlToValidate="ASSEQUIPQUANTTextBox" ForeColor="#FF3535" SetFocusOnError="True"></asp:RequiredFieldValidator></td>
                                        <td>
                                            <asp:TextBox Text='<%# Bind("STOCK") %>' runat="server" ID="STOCKTextbox" CssClass="form-control" Enabled="false" />
                                        </td>
                                        <td>
                                            <asp:LinkButton runat="server" CommandName="Update" Text="Save" ID="UpdateButton" CssClass="btn btn-info" OnClick="UpdateButton_Click"
                                                data-toggle="tooltip"
                                                data-placement="top"
                                                data-original-title="Save?"><span class="glyphicon glyphicon-ok"></asp:LinkButton>
                                            <asp:LinkButton runat="server" CommandName="Cancel" Text="Cancel" ID="CancelButton" CssClass="btn btn-danger" OnClientClick="this.form.reset();return false;" CausesValidation="false"
                                                data-toggle="tooltip"
                                                data-placement="top"
                                                data-original-title="Cancel"><span class="glyphicon glyphicon-remove"></asp:LinkButton>
                                        </td>
                                    </tr>
                                </EditItemTemplate>
                                <EmptyDataTemplate>
                                    <div runat="server" style="" class="col-sm-12">
                                        <div class="alert alert-danger">
                                            <td>No Equipment Selected</td>
                                        </div>
                                    </div>
                                </EmptyDataTemplate>
                                <ItemTemplate>
                                    <tr style="">
                                        <%--<td>
                                            <asp:Label Text='<%# Eval("ASSIGNEDEQUIPID") %>' runat="server" ID="ASSIGNEDEQUIPIDLabel" /></td>
                                        <td>
                                            <asp:Label Text='<%# Eval("PROJID") %>' runat="server" ID="PROJIDLabel" /></td>
                                        <td>
                                            <asp:Label Text='<%# Eval("EQUIPMENTID") %>' runat="server" ID="EQUIPMENTIDLabel" /></td>--%>
                                        <td>
                                            <asp:Label Text='<%# Eval("EQUIPMENTNAME") %>' runat="server" ID="EQUIPMENTNAMELabel" /></td>
                                        <td>
                                            <asp:Label Text='<%# Eval("ASSEQUIPQUANT") %>' runat="server" ID="ASSEQUIPQUANTLabel" /></td>
                                        <td>
                                            <asp:Label Text='<%# Bind("STOCK") %>' runat="server" ID="STOCKLabel" CssClass="control-label" />
                                        </td>
                                        <td>
                                            <asp:LinkButton ID="EditButton" runat="server" CommandName="Edit" Text="Edit" CssClass="btn btn-primary"
                                                data-toggle="tooltip"
                                                data-placement="top"
                                                data-original-title="Add Quantity"><span class="glyphicon glyphicon-pencil"></span></asp:LinkButton>
                                        </td>
                                    </tr>
                                </ItemTemplate>
                                <LayoutTemplate>
                                    <div runat="server" class="table-responsive col-sm-12">
                                        <div runat="server">
                                            <div runat="server">
                                                <table id="itemPlaceholderContainer" runat="server" border="0" style="" class="table table-condensed">
                                                    <tr runat="server" style="" class="success">
                                                        <th runat="server">Trade Name</th>
                                                        <th runat="server">Quantity</th>
                                                        <th runat="server">Stock</th>
                                                        <th runat="server">Add Quantity</th>
                                                    </tr>
                                                    <tr runat="server" id="itemPlaceholder"></tr>
                                                </table>
                                            </div>
                                        </div>
                                        <tr runat="server">
                                            <td runat="server" style=""></td>
                                        </tr>
                                    </div>
                                </LayoutTemplate>

                            </asp:ListView>
                            <asp:SqlDataSource runat="server" ID="DataSourceAssEquipQuantListView" ConnectionString='<%$ ConnectionStrings:ConnString_WEB_ASSET_DB %>' SelectCommand="SELECT ASSIGNEDEQUIP.ASSIGNEDEQUIPID, ASSIGNEDEQUIP.ASSEQUIPQUANT, EQUIPMENT.EQUIPMENTNAME, EQUIPMENT.EQUIPMENTID, EQUIPMENT.STOCK FROM ASSIGNEDEQUIP INNER JOIN EQUIPMENT ON ASSIGNEDEQUIP.EQUIPMENTID = EQUIPMENT.EQUIPMENTID WHERE (ASSIGNEDEQUIP.PROJID = @PROJID)" UpdateCommand="UPDATE ASSIGNEDEQUIP SET ASSEQUIPQUANT = @ASSEQUIPQUANT WHERE (ASSIGNEDEQUIPID = @ASSIGNEDEQUIPID)">
                                <SelectParameters>
                                    <asp:ControlParameter ControlID="_dropdownProject" PropertyName="SelectedValue" Name="PROJID" Type="Int32"></asp:ControlParameter>
                                </SelectParameters>
                                <UpdateParameters>
                                    <asp:Parameter Name="ASSEQUIPQUANT" Type="String"></asp:Parameter>
                                    <asp:Parameter Name="ASSIGNEDEQUIPID" Type="Int32"></asp:Parameter>
                                </UpdateParameters>
                            </asp:SqlDataSource>
                        </div>
                        <hr />
                        <div class="row">
                            <div class="col-sm-4 pull-right">
                                <div class="col-sm-6">
                                    <asp:Button ID="BackButtonPage3" runat="server" Text="Back" CssClass="btn btn-danger center-block col-xs-12" OnClick="BackButtonPage3_Click" />
                                </div>
                                <div class="col-sm-6">
                                    <asp:Button ID="NextButtonPage3" runat="server" Text="Next" CssClass="btn btn-success center-block col-xs-12" OnClick="NextButtonPage3_Click" />
                                </div>
                            </div>
                            <div class="col-sm-4 pull-left">
                                <div class="col-sm-6">
                                    <asp:Button ID="Button2" runat="server" CommandName="Cancel" Text="Cancel" CssClass="btn btn-danger center-block col-xs-12" OnClientClick=" window.location = '/ProjectSpecification.aspx';return false;" />
                                </div>
                            </div>
                        </div>
                    </asp:Panel>
                </div>
            </div>
        </div>
    </asp:Panel>

    <asp:Panel ID="_panelWorkerMain" runat="server" Visible="false">
        <div class="well">
            <div class="row">
                <div class="col-sm-3">
                    <h5 class="bg-primary text-center" style="padding: 8px">Worker Needed</h5>
                    <asp:BulletedList ID="_bulletlistProjTrade2" runat="server" DataSourceID="DataSourceProjTradeTOTAL" DataTextField="PROJTRADEQUANT" BulletStyle="Square" Height="100%"></asp:BulletedList>
                    <asp:Label ID="Label4" runat="server" Text="Label" CssClass="text-info" Font-Size="Larger">Total Worker:</asp:Label>
                    <asp:Label ID="_labelTotalTrade2" runat="server" Text="Label" CssClass="text-danger" Font-Size="Larger" Font-Bold="true">0</asp:Label>
                </div>
                <div class="col-sm-9">
                    <h5 class="bg-info text-center" style="padding: 8px">Assign Worker</h5>
                    <div class="row">
                        <div class="col-sm-4">
                        </div>
                        <div class="col-sm-4">
                            <label class="control-label">Filter:</label>
                            <asp:DropDownList ID="_dropdownTrade" runat="server" CssClass="form-control" DataSourceID="DataSourceTradeDDList" DataTextField="TRADENAME" DataValueField="TRADEID" AppendDataBoundItems="true" AutoPostBack="True" OnSelectedIndexChanged="_dropdownTrade_SelectedIndexChanged" OnPreRender="_dropdownTrade_PreRender">
                                <asp:ListItem Value="0"> -- Select a Trade/Display All --</asp:ListItem>
                            </asp:DropDownList>
                            <asp:SqlDataSource runat="server" ID="DataSourceTradeDDList" ConnectionString='<%$ ConnectionStrings:ConnString_WEB_ASSET_DB %>' SelectCommand="SELECT [TRADEID], [TRADENAME] FROM [TRADE]"></asp:SqlDataSource>
                        </div>
                        <div class="col-sm-4">
                        </div>
                    </div>
                    <hr />
                    <div class="row">
                        <div class="col-sm-6">
                            <h5 class="bg-info text-center" style="padding: 8px">Choose:</h5>
                            <div class="text-center">
                                <asp:LinkButton ID="_btnAddTrade" runat="server" OnClick="_btnAddTrade_Click" CssClass="btn btn-info">Add</asp:LinkButton>
                            </div>
                            <asp:CheckBoxList ID="_chlbxlistWorkerAdd" runat="server" CssClass="checkbox checkbox-info"></asp:CheckBoxList>
                        </div>
                        <div class="col-sm-6">
                            <h5 class="bg-info text-center" style="padding: 8px">List of Chosen:</h5>
                            <div class="text-center">
                                <asp:LinkButton ID="_btnRemoveTrade" runat="server" OnClick="_btnRemoveTrade_Click" CssClass="btn btn-danger">Remove</asp:LinkButton>
                            </div>
                            <asp:CheckBoxList ID="_chlbxlistWorkerRemove" CssClass="checkbox checkbox-danger" runat="server"></asp:CheckBoxList>
                        </div>
                    </div>
                </div>
            </div>
            <hr />
            <div class="row">
                <div class="col-sm-4 pull-right">
                    <div class="col-sm-6">
                        <asp:Button ID="BackButtonPage4" runat="server" Text="Back" CssClass="btn btn-danger center-block col-xs-12" OnClick="BackButtonPage4_Click" />
                    </div>
                    <div class="col-sm-6">
                        <asp:Button ID="FinishButtonPage4" runat="server" Text="Finish" CssClass="btn btn-info center-block col-xs-12" OnClick="FinishButtonPage4_Click" />
                    </div>
                </div>
                <div class="col-sm-4 pull-left">
                    <div class="col-sm-6">
                        <asp:Button ID="Button3" runat="server" CommandName="Cancel" Text="Cancel" CssClass="btn btn-danger center-block col-xs-12" OnClientClick=" window.location = '/ProjectSpecification.aspx';return false;" />
                    </div>
                </div>
            </div>
        </div>
    </asp:Panel>

    <div class="modal fade" id="_modalSummary" onclick="window.location = 'ProjectSpecification.aspx';">
        <div class="modal-dialog">
            <asp:UpdatePanel ID="_panelSummary" runat="server" Visible="false" UpdateMode="Conditional">
                <ContentTemplate>
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true" onclick="window.location = 'ProjectRequirement.aspx';">X</button>
                            <h4 class="modal-title">
                                <asp:Label ID="_lblTitleSummary" runat="server" Text=""></asp:Label>
                            </h4>
                        </div>
                        <div class="modal-footer">
                            <h4 class="bg-info text-center" style="padding: 8px">Requirement Summary</h4>
                            <div class="col-sm-6">
                                <h5 class="bg-primary text-center" style="padding: 8px">Assigned Equipment</h5>
                                <asp:BulletedList ID="_bulletlistAssEquip" runat="server" DataSourceID="DataSourceAssEquip" DataTextField="PROJEQUIPQUANT" BulletStyle="Square" Height="100%" CssClass="text-left"></asp:BulletedList>
                                <asp:SqlDataSource runat="server" ID="DataSourceAssEquip" ConnectionString='<%$ ConnectionStrings:ConnString_WEB_ASSET_DB %>' SelectCommand="SELECT CAST(ASSIGNEDEQUIP.ASSEQUIPQUANT AS VARCHAR(10)) + '  -  ' + EQUIPMENT.EQUIPMENTNAME AS PROJEQUIPQUANT FROM EQUIPMENT INNER JOIN ASSIGNEDEQUIP ON EQUIPMENT.EQUIPMENTID = ASSIGNEDEQUIP.EQUIPMENTID WHERE PROJID=@PROJID">
                                    <SelectParameters>
                                        <asp:ControlParameter ControlID="_dropdownProject" PropertyName="SelectedValue" Name="PROJID"></asp:ControlParameter>
                                    </SelectParameters>
                                </asp:SqlDataSource>
                                <asp:Label ID="Label6" runat="server" Text="Label" CssClass="text-info" Font-Size="Larger">Total Equipment Assigned:</asp:Label>
                                <asp:Label ID="_labelTotalAssEquip" runat="server" Text="Label" CssClass="text-success" Font-Size="Larger"></asp:Label>
                            </div>
                            <div class="col-sm-6">
                                <h5 class="bg-primary text-center" style="padding: 8px">Assigned Worker</h5>
                                <asp:BulletedList ID="_bulletlistAssWorker" runat="server" DataSourceID="DataSourceAssWorker" DataTextField="WORKERFULNAME" BulletStyle="Square" Height="100%" CssClass="text-left"></asp:BulletedList>
                                <asp:SqlDataSource runat="server" ID="DataSourceAssWorker" ConnectionString='<%$ ConnectionStrings:ConnString_WEB_ASSET_DB %>' SelectCommand="SELECT WORKER.WORKERLNAME + ',  ' + WORKER.WORKERFNAME AS WORKERFULNAME FROM WORKER INNER JOIN ASSIGNEDWORKER ON WORKER.WORKERID = ASSIGNEDWORKER.WORKERID WHERE (ASSIGNEDWORKER.PROJID = @PROJID)">
                                    <SelectParameters>
                                        <asp:ControlParameter ControlID="_dropdownProject" PropertyName="SelectedValue" Name="PROJID"></asp:ControlParameter>
                                    </SelectParameters>
                                </asp:SqlDataSource>
                                <asp:Label ID="Label5" runat="server" Text="Label" CssClass="text-info" Font-Size="Larger">Total Worker Assigned:</asp:Label>
                                <asp:Label ID="_labelTotalAssWorker" runat="server" Text="Label" CssClass="text-success" Font-Size="Larger"></asp:Label>
                            </div>
                        </div>
                    </div>
                </ContentTemplate>
            </asp:UpdatePanel>
        </div>
    </div>

    <script type="text/javascript">
        $.validate()
    </script>
    <script type="text/javascript">
        $('[data-toggle=tooltip]').tooltip();
        $('[rel=tooltip]').tooltip();
    </script>
</asp:Content>

<%@ Page Title="Project Requirement" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ProjectRequirement_CRUD.aspx.cs" Inherits="Construction_Asset_Management_System.ProjectRequirement_CRUD1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <script src="Scripts/Form Validator/jquery.form-validator.js"></script>
    <link href="Scripts/Form Validator/theme-default.css" rel="stylesheet" type="text/css" />
    <link href="Content/checkbox.css" rel="stylesheet" type="text/css" />
    <h4 class="well text-center" style="padding: 8px">Project Requirements</h4>
    <div class="well">
        <asp:Panel ID="_panelProjectDetails" runat="server">
            <div class="row">
                <h4 class="bg-info text-center" style="padding: 8px">Select a Project</h4>
                <div class="row">
                    <div class="col-sm-3">
                        <label class="control-label">Project name:</label>
                        <asp:DropDownList ID="_dropdownProject" runat="server" CssClass="form-control" DataSourceID="DataSourceProjectDDList" DataTextField="PROJCLIENT" DataValueField="PROJID" AppendDataBoundItems="true" AutoPostBack="true" OnSelectedIndexChanged="_dropdownProject_SelectedIndexChanged"
                            data-validation="required"
                            data-validation-error-msg-required="You must select a Project" OnPreRender="_dropdownProject_PreRender">
                            <asp:ListItem Value=" "> -- please select a Project --  </asp:ListItem>
                        </asp:DropDownList>
                        <asp:SqlDataSource runat="server" ID="DataSourceProjectDDList" ConnectionString='<%$ ConnectionStrings:ConnString_WEB_ASSET_DB %>' SelectCommand="SELECT [PROJID], CLIENT.CLIENTNAME+', '+PROJNAME as [PROJCLIENT] FROM PROJECT JOIN CLIENT ON CLIENT.CLIENTID=PROJECT.CLIENTID">
                            <%--<SelectParameters>
                                <asp:QueryStringParameter Name="PROJID" QueryStringField="id" Type="Int32" />
                            </SelectParameters>--%>
                        </asp:SqlDataSource>
                    </div>
                    <div class="col-sm-9">
                        <div class="col-sm-6">
                            <h5 class="bg-primary" style="padding: 8px">Project Information</h5>
                            <label class="control-label">Project Site:</label>
                            <asp:TextBox ID="_txtboxSite" runat="server" CssClass="form-control" Enabled="false" />
                            <br />
                            <label class="control-label">PMI No.:</label>
                            <asp:TextBox ID="_txtboxPMI" runat="server" CssClass="form-control" Enabled="false" />
                        </div>
                        <div class="col-sm-6">
                            <h5 class="bg-primary" style="padding: 8px">Contractor Information</h5>
                            <label class="control-label">Approved by:</label>
                            <asp:TextBox ID="_txtboxSiteApprover" runat="server" CssClass="form-control" Enabled="false" />
                            <br />
                            <label class="control-label">Date Approved:</label>
                            <asp:TextBox ID="_txtboxSiteDateApp" runat="server" CssClass="form-control" Enabled="false" />
                        </div>
                    </div>
                </div>
                <hr />
                <div class="row">
                    <div class="col-sm-4 pull-right">
                        <div class="col-sm-6">
                            <asp:Button ID="NextButton1" runat="server" Text="Next" CssClass="btn btn-success center-block col-xs-12" OnClick="NextButton1_Click" />
                        </div>
                    </div>
                    <div class="col-sm-4 pull-left">
                        <div class="col-sm-6">
                            <asp:Button ID="CancelButton" runat="server" CommandName="Cancel" Text="Cancel" CssClass="btn btn-danger center-block col-xs-12" OnClientClick=" window.location = '/ProjectRequirement.aspx';return false;" />
                        </div>
                    </div>
                </div>
            </div>
        </asp:Panel>

        <asp:Panel ID="_panelReqTrade" runat="server" Visible="false">
            <div class="row">
                <h4 class="bg-info text-center" style="padding: 8px">Required Trades</h4>
                <div class="row">
                    <div class="col-sm-12">
                        <asp:CheckBoxList ID="_chkbxlistReqTrade" runat="server" DataSourceID="DataSourceReqTradeChkBxLst" DataTextField="TRADENAME" DataValueField="TRADEID" CssClass="checkbox checkbox-info" RepeatLayout="Table" RepeatDirection="Vertical" TextAlign="Right" BorderStyle="NotSet"></asp:CheckBoxList>
                        <asp:SqlDataSource runat="server" ID="DataSourceReqTradeChkBxLst" ConnectionString='<%$ ConnectionStrings:ConnString_WEB_ASSET_DB %>' SelectCommand="SELECT [TRADEID], [TRADENAME] FROM [TRADE]"></asp:SqlDataSource>
                    </div>
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
                            <asp:Button ID="Button1" runat="server" CommandName="Cancel" Text="Cancel" CssClass="btn btn-danger center-block col-xs-12" OnClientClick=" window.location = '/ProjectRequirement.aspx';return false;" />
                        </div>
                    </div>
                </div>
            </div>
        </asp:Panel>

        <asp:Panel ID="_panelReqEquipment" runat="server" Visible="false">
            <div class="row">
                <h4 class="bg-info text-center" style="padding: 8px">Required Equipments</h4>
                <div class="row">
                    <div class="col-sm-12">
                        <asp:CheckBoxList ID="_chkbxlistReqEquip" runat="server" DataSourceID="DataSourceReqEquipChkBxLst" DataTextField="EQUIPMENTNAME" DataValueField="EQUIPMENTID" CssClass="checkbox checkbox-info" RepeatLayout="Table" RepeatDirection="Vertical" TextAlign="Right"></asp:CheckBoxList>
                        <asp:SqlDataSource runat="server" ID="DataSourceReqEquipChkBxLst" ConnectionString='<%$ ConnectionStrings:ConnString_WEB_ASSET_DB %>' SelectCommand="SELECT [EQUIPMENTID], [EQUIPMENTNAME] FROM [EQUIPMENT]"></asp:SqlDataSource>
                    </div>
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
                            <asp:Button ID="Button2" runat="server" CommandName="Cancel" Text="Cancel" CssClass="btn btn-danger center-block col-xs-12" OnClientClick=" window.location = '/ProjectRequirement.aspx';return false;" />
                        </div>
                    </div>
                </div>
            </div>
        </asp:Panel>

        <asp:Panel ID="_panelQuantTrade" runat="server" Visible="false">
            <div class="row">
                <h4 class="bg-info text-center" style="padding: 8px">How many Worker needed per Trade</h4>
                <div class="row">
                    <asp:ListView ID="_listviewQuantTrade" runat="server" DataSourceID="DataSourceQuantTradeListView" DataKeyNames="PROJREQTRADEID">
                        <EditItemTemplate>
                            <tr style="">
                                <%--<td>
                                    <asp:Label Text='<%# Eval("PROJREQTRADEID") %>' runat="server" ID="PROJREQTRADEIDLabel1" /></td>
                                <td>
                                    <asp:TextBox Text='<%# Bind("PROJID") %>' runat="server" ID="PROJIDTextBox" /></td>--%>
                                <td>
                                    <asp:Label Text='<%# Eval("TRADENAME") %>' runat="server" ID="TRADEIDTextBox" CssClass="form-control" Enabled="false" /></td>
                                <td>
                                    <asp:TextBox Text='<%# Bind("TRADEQUANTITY") %>' runat="server" ID="TRADEQUANTITYTextBox" CssClass="form-control" />
                                    <asp:RegularExpressionValidator ID="RegularExpressionValidator1" ControlToValidate="TRADEQUANTITYTextBox" runat="server" ErrorMessage="Whole numbers only" ValidationExpression="^[0-9]+$" Display="Static" ForeColor="#FF3535" SetFocusOnError="True"></asp:RegularExpressionValidator>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="Must at least have single digit" ControlToValidate="TRADEQUANTITYTextBox" ForeColor="#FF3535" SetFocusOnError="True"></asp:RequiredFieldValidator>
                                </td>
                                <td>
                                    <asp:LinkButton runat="server" CommandName="Update" Text="Save" ID="UpdateButton" CssClass="btn btn-info"
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
                                    <td>No Trade Selected</td>
                                </div>
                            </div>
                        </EmptyDataTemplate>
                        <ItemTemplate>
                            <tr style="" class="">
                                <%--<td>
                                    <asp:Label Text='<%# Eval("PROJREQTRADEID") %>' runat="server" ID="PROJREQTRADEIDLabel" /></td>
                                <td>
                                    <asp:Label Text='<%# Eval("PROJID") %>' runat="server" ID="PROJIDLabel" /></td>--%>
                                <td>
                                    <asp:Label Text='<%# Eval("TRADENAME") %>' runat="server" ID="TRADEIDLabel" /></td>
                                <td>
                                    <asp:Label Text='<%# Eval("TRADEQUANTITY") %>' runat="server" ID="TRADEQUANTITYLabel" /></td>
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
                                                <%--<th runat="server">PROJREQTRADEID</th>
                                                <th runat="server">PROJID</th>--%>
                                                <th runat="server">Trade Name</th>
                                                <th runat="server">Quantity</th>
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
                    <asp:SqlDataSource runat="server" ID="DataSourceQuantTradeListView" ConnectionString='<%$ ConnectionStrings:ConnString_WEB_ASSET_DB %>' DeleteCommand="DELETE FROM [PROJREQTRADE] WHERE [PROJREQTRADEID] = @PROJREQTRADEID" InsertCommand="INSERT INTO [PROJREQTRADE] ([PROJID], [TRADEID], [TRADEQUANTITY]) VALUES (@PROJID, @TRADEID, @TRADEQUANTITY)" SelectCommand="SELECT [PROJREQTRADEID], [PROJID], [TRADEQUANTITY], TRADE.TRADENAME FROM PROJREQTRADE JOIN TRADE ON PROJREQTRADE.TRADEID = TRADE.TRADEID WHERE ([PROJID] = @PROJID)" UpdateCommand="UPDATE [PROJREQTRADE] SET [TRADEQUANTITY] = @TRADEQUANTITY WHERE [PROJREQTRADEID] = @PROJREQTRADEID">
                        <DeleteParameters>
                            <asp:Parameter Name="PROJREQTRADEID" Type="Int32"></asp:Parameter>
                        </DeleteParameters>
                        <InsertParameters>
                            <asp:Parameter Name="PROJID" Type="Int32"></asp:Parameter>
                            <asp:Parameter Name="TRADEID" Type="Int32"></asp:Parameter>
                            <asp:Parameter Name="TRADEQUANTITY" Type="Int32"></asp:Parameter>
                        </InsertParameters>
                        <SelectParameters>
                            <asp:ControlParameter ControlID="_dropdownProject" PropertyName="SelectedValue" Name="PROJID" Type="Int32"></asp:ControlParameter>
                        </SelectParameters>
                        <UpdateParameters>
                            <asp:Parameter Name="PROJID" Type="Int32"></asp:Parameter>
                            <asp:Parameter Name="TRADEID" Type="Int32"></asp:Parameter>
                            <asp:Parameter Name="TRADEQUANTITY" Type="Int32"></asp:Parameter>
                            <asp:Parameter Name="PROJREQTRADEID" Type="Int32"></asp:Parameter>
                        </UpdateParameters>
                    </asp:SqlDataSource>
                </div>
                <hr />
                <div class="row">
                    <div class="col-sm-4 pull-right">
                        <div class="col-sm-6">
                            <asp:Button ID="BackButtonPage4" runat="server" Text="Back" CssClass="btn btn-danger center-block col-xs-12" OnClick="BackButtonPage4_Click" />
                        </div>
                        <div class="col-sm-6">
                            <asp:Button ID="NextButtonPage4" runat="server" Text="Next" CssClass="btn btn-success center-block col-xs-12" OnClick="NextButtonPage4_Click" />
                        </div>
                    </div>
                    <div class="col-sm-4 pull-left">
                        <div class="col-sm-6">
                            <asp:Button ID="Button3" runat="server" CommandName="Cancel" Text="Cancel" CssClass="btn btn-danger center-block col-xs-12" OnClientClick=" window.location = '/ProjectRequirement.aspx';return false;" />
                        </div>
                    </div>
                </div>
            </div>
        </asp:Panel>

        <asp:Panel ID="_panelQuantEquip" runat="server" Visible="false">
            <div class="row">
                <h4 class="bg-info text-center" style="padding: 8px">How many Equipment needed</h4>
                <div class="row">
                    <asp:ListView ID="_listviewQuantEquip" runat="server" DataSourceID="DataSourceQuantEquipListView" DataKeyNames="PROJREQEQUIPID">
                        <EditItemTemplate>
                            <tr style="">
                                <%--<td>
                                    <asp:Label Text='<%# Eval("PROJREQEQUIPID") %>' runat="server" ID="PROJREQEQUIPIDLabel1" /></td>
                                <td>
                                    <asp:TextBox Text='<%# Bind("PROJID") %>' runat="server" ID="PROJIDTextBox" /></td>--%>
                                <td>
                                    <asp:Label Text='<%# Bind("EQUIPMENTNAME") %>' runat="server" ID="EQUIPMENTIDTextBox" CssClass="form-control" Enabled="false" /></td>
                                <td>
                                    <asp:TextBox Text='<%# Bind("EQUIPQUANTITY") %>' runat="server" ID="EQUIPQUANTITYTextBox" CssClass="form-control" />
                                    <asp:RegularExpressionValidator ID="RegularExpressionValidator1" ControlToValidate="EQUIPQUANTITYTextBox" runat="server" ErrorMessage="Whole numbers only" ValidationExpression="^[0-9]+$" Display="Static" ForeColor="#FF3535" SetFocusOnError="True"></asp:RegularExpressionValidator>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="Must at least have single digit" ControlToValidate="EQUIPQUANTITYTextBox" ForeColor="#FF3535" SetFocusOnError="True"></asp:RequiredFieldValidator>
                                </td>
                                <td>
                                    <asp:LinkButton runat="server" CommandName="Update" Text="Save" ID="UpdateButton" CssClass="btn btn-info"
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
                                    <asp:Label Text='<%# Eval("PROJREQEQUIPID") %>' runat="server" ID="PROJREQEQUIPIDLabel" /></td>
                                <td>
                                    <asp:Label Text='<%# Eval("PROJID") %>' runat="server" ID="PROJIDLabel" /></td>--%>
                                <td>
                                    <asp:Label Text='<%# Eval("EQUIPMENTNAME") %>' runat="server" ID="EQUIPMENTIDLabel" /></td>
                                <td>
                                    <asp:Label Text='<%# Eval("EQUIPQUANTITY") %>' runat="server" ID="EQUIPQUANTITYLabel"></asp:Label>
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
                                                <%--<th runat="server">PROJREQEQUIPID</th>
                                                <th runat="server">PROJID</th>--%>
                                                <th runat="server">Equipment Name</th>
                                                <th runat="server">Quantity</th>
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
                    <asp:SqlDataSource runat="server" ID="DataSourceQuantEquipListView" ConnectionString='<%$ ConnectionStrings:ConnString_WEB_ASSET_DB %>' DeleteCommand="DELETE FROM [PROJREQEQUIP] WHERE [PROJREQEQUIPID] = @PROJREQEQUIPID" InsertCommand="INSERT INTO [PROJREQEQUIP] ([PROJID], [EQUIPMENTID], [EQUIPQUANTITY]) VALUES (@PROJID, @EQUIPMENTID, @EQUIPQUANTITY)" SelectCommand="SELECT [PROJREQEQUIPID], [PROJID], [EQUIPQUANTITY], EQUIPMENT.EQUIPMENTNAME FROM PROJREQEQUIP JOIN EQUIPMENT ON PROJREQEQUIP.EQUIPMENTID=EQUIPMENT.EQUIPMENTID WHERE ([PROJID] = @PROJID)" UpdateCommand="UPDATE [PROJREQEQUIP] SET [EQUIPQUANTITY] = @EQUIPQUANTITY WHERE [PROJREQEQUIPID] = @PROJREQEQUIPID">
                        <DeleteParameters>
                            <asp:Parameter Name="PROJREQEQUIPID" Type="Int32"></asp:Parameter>
                        </DeleteParameters>
                        <InsertParameters>
                            <asp:Parameter Name="PROJID" Type="Int32"></asp:Parameter>
                            <asp:Parameter Name="EQUIPMENTID" Type="Int32"></asp:Parameter>
                            <asp:Parameter Name="EQUIPQUANTITY" Type="Int32"></asp:Parameter>
                        </InsertParameters>
                        <SelectParameters>
                            <asp:ControlParameter ControlID="_dropdownProject" PropertyName="SelectedValue" Name="PROJID" Type="Int32"></asp:ControlParameter>
                        </SelectParameters>
                        <UpdateParameters>
                            <asp:Parameter Name="PROJID" Type="Int32"></asp:Parameter>
                            <asp:Parameter Name="EQUIPMENTID" Type="Int32"></asp:Parameter>
                            <asp:Parameter Name="EQUIPQUANTITY" Type="Int32"></asp:Parameter>
                            <asp:Parameter Name="PROJREQEQUIPID" Type="Int32"></asp:Parameter>
                        </UpdateParameters>
                    </asp:SqlDataSource>
                </div>
                <hr />
                <div class="row">
                    <div class="col-sm-4 pull-right">
                        <div class="col-sm-6">
                            <asp:Button ID="BackButtonPage5" runat="server" Text="Back" CssClass="btn btn-danger center-block col-xs-12" OnClick="BackButtonPage5_Click" />
                        </div>
                        <div class="col-sm-6">
                            <asp:Button ID="FinishButtonPage5" runat="server" Text="Finish" CssClass="btn btn-info center-block col-xs-12" OnClick="FinishButtonPage5_Click" />
                        </div>
                    </div>
                    <div class="col-sm-4 pull-left">
                        <div class="col-sm-6">
                            <asp:Button ID="Button4" runat="server" CommandName="Cancel" Text="Cancel" CssClass="btn btn-danger center-block col-xs-12" OnClientClick=" window.location = '/ProjectRequirement.aspx';return false;" />
                        </div>
                    </div>
                </div>
            </div>
        </asp:Panel>

        <div class="modal fade" id="_modalSummary" onclick="window.location = 'ProjectRequirement.aspx';">
            <div class="modal-dialog">
                <asp:UpdatePanel ID="_panelSummary" runat="server" Visible="false" UpdateMode="Conditional">
                    <ContentTemplate>
                        <div class="modal-content">
                            <div class="modal-header">
                                <button type="button" class="close" data-dismiss="modal" aria-hidden="true" onclick="window.location = 'ProjectRequirement.aspx';">X</button>
                                <h4 class="modal-title">
                                    <asp:Label ID="_lblTitleSummay" runat="server" Text=""></asp:Label></h4>
                            </div>
                            <%--<div class="modal-body">
                                <div class="col-sm-6">
                                </div>
                                <div class="col-sm-6">
                                </div>
                            </div>--%>
                            <div class="modal-footer">
                                <h4 class="bg-info text-center" style="padding: 8px">Requirement Summary</h4>
                                <div class="col-sm-6">
                                    <h5 class="bg-primary text-center" style="padding: 8px">Worker Trade Needed</h5>
                                    <asp:BulletedList ID="_bulletlistProjTrade" runat="server" DataSourceID="DataSourceProjTradeTOTAL" DataTextField="PROJTRADEQUANT" CssClass="text-left"></asp:BulletedList>
                                    <asp:SqlDataSource runat="server" ID="DataSourceProjTradeTOTAL" ConnectionString='<%$ ConnectionStrings:ConnString_WEB_ASSET_DB %>' SelectCommand="SELECT CAST(PROJREQTRADE.TRADEQUANTITY AS VARCHAR(10)) + '  -  ' + TRADE.TRADENAME AS [PROJTRADEQUANT] FROM PROJREQTRADE INNER JOIN TRADE ON PROJREQTRADE.TRADEID = TRADE.TRADEID WHERE (PROJREQTRADE.PROJID = @PROJID)">
                                        <SelectParameters>
                                            <asp:ControlParameter ControlID="_dropdownProject" PropertyName="SelectedValue" Name="PROJID"></asp:ControlParameter>
                                        </SelectParameters>
                                    </asp:SqlDataSource>
                                    <asp:Label ID="Label1" runat="server" Text="Label" CssClass="text-info" Font-Size="Larger">Total Worker Needed:</asp:Label>
                                    <asp:Label ID="_labelTotalTrade" runat="server" Text="Label" CssClass="text-success" Font-Size="Larger"></asp:Label>
                                </div>
                                <div class="col-sm-6">
                                    <h5 class="bg-primary text-center" style="padding: 8px">Equipment Needed</h5>
                                    <asp:BulletedList ID="_bulletlistProjEquip" runat="server" DataSourceID="DataSourceProjEquipTOTAL" DataTextField="PROJEQUIPQUANT" CssClass="text-left"></asp:BulletedList>
                                    <asp:SqlDataSource runat="server" ID="DataSourceProjEquipTOTAL" ConnectionString='<%$ ConnectionStrings:ConnString_WEB_ASSET_DB %>' SelectCommand="SELECT CAST(PROJREQEQUIP.EQUIPQUANTITY AS VARCHAR(10)) + '  -  ' + EQUIPMENT.EQUIPMENTNAME AS PROJEQUIPQUANT FROM EQUIPMENT INNER JOIN PROJREQEQUIP ON EQUIPMENT.EQUIPMENTID = PROJREQEQUIP.EQUIPMENTID WHERE (PROJREQEQUIP.PROJID = @PROJID)">
                                        <SelectParameters>
                                            <asp:ControlParameter ControlID="_dropdownProject" PropertyName="SelectedValue" Name="PROJID"></asp:ControlParameter>
                                        </SelectParameters>
                                    </asp:SqlDataSource>
                                    <asp:Label ID="Label2" runat="server" Text="Label" CssClass="text-info" Font-Size="Larger">Total Equipment Needed:</asp:Label>
                                    <asp:Label ID="_labelTotalEquip" runat="server" Text="Label" CssClass="text-success" Font-Size="Larger"></asp:Label>
                                </div>
                            </div>
                        </div>
                    </ContentTemplate>
                </asp:UpdatePanel>
            </div>
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

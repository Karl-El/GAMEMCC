<%@ Page Title="Project Specification" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ProjectSpecification.aspx.cs" Inherits="Construction_Asset_Management_System.ProjectSpecification" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <link href="Scripts/Date Picker/datepicker.min.css" rel="stylesheet" type="text/css" />
    <script src="Scripts/Date Picker/bootstrap-datepicker.min.js"></script>
    <script src="Scripts/Form Validator/jquery.form-validator.js"></script>
    <link href="Scripts/Form Validator/theme-default.css" rel="stylesheet" type="text/css" />
    <h4 class="well text-center" style="padding: 8px">Project Assigments List</h4>
    <div class="row text-center">
        <div class="col-sm-12 form-inline">
            <div class="input-group">
                <asp:TextBox ID="_txtSearch" runat="server" CssClass="form-control" />
                <span class="input-group-btn">
                    <asp:LinkButton runat="server" ID="_btnSearch" CssClass="btn btn-info" OnClick="_btnSearch_Click"><span class="glyphicon glyphicon-search"></span> Search</asp:LinkButton>
                </span>
            </div>
            <asp:LinkButton runat="server" ID="_btnAdd" CssClass="btn btn-info " OnClick="_btnAdd_Click"><span class="glyphicon glyphicon-plus"></span> Add</asp:LinkButton>
            <asp:LinkButton runat="server" ID="_btnShowList" CssClass="btn btn-info" OnClick="_btnShowList_Click" Visible="false"><span class="glyphicon glyphicon-list-alt"></span> Show Full List</asp:LinkButton>
           <%--<asp:LinkButton runat="server" ID="_btnNoReq" CssClass="btn btn-info" Visible="false" OnClick="_btnNoReq_Click"><span class="glyphicon glyphicon-list-alt"></span> Show Full List</asp:LinkButton>--%>
        </div>
    </div>
    <br />
    <asp:ListView ID="_listviewProjAss" runat="server" DataSourceID="DataSourceProjectAssign" DataKeyNames="PROJID" GroupItemCount="4" OnItemDataBound="_listviewProjAss_ItemDataBound" OnItemUpdating="_listviewProjAss_ItemUpdating" OnPreRender="_listviewProjAss_PreRender">
        <%--<AlternatingItemTemplate>
            <td runat="server" style="">PROJID:
                <asp:Label ID="PROJIDLabel" runat="server" Text='<%# Eval("PROJID") %>' />
                <br />
                CLIENTPROJECT:
                <asp:Label ID="CLIENTPROJECTLabel" runat="server" Text='<%# Eval("CLIENTPROJECT") %>' />
                <br />
                PROJSITE:
                <asp:Label ID="PROJSITELabel" runat="server" Text='<%# Eval("PROJSITE") %>' />
                <br />
                PROJFROM:
                <asp:Label ID="PROJFROMLabel" runat="server" Text='<%# Eval("PROJFROM") %>' />
                <br />
                PROJTO:
                <asp:Label ID="PROJTOLabel" runat="server" Text='<%# Eval("PROJTO") %>' />
                <br />
                STARTDATE:
                <asp:Label ID="STARTDATELabel" runat="server" Text='<%# Eval("STARTDATE") %>' />
                <br />
                ENDDATE:
                <asp:Label ID="ENDDATELabel" runat="server" Text='<%# Eval("ENDDATE") %>' />
                <br />
                PROGRESS:
                <asp:Label ID="PROGRESSLabel" runat="server" Text='<%# Eval("PROGRESS") %>' />
                <br />
                <asp:Button ID="EditButton" runat="server" CommandName="Edit" Text="Edit" />
                <br />
            </td>
        </AlternatingItemTemplate>--%>
        <EditItemTemplate>
            <div class="col-sm-12">
                <asp:Panel ID="Panel1" runat="server">
                    <div runat="server" style="" class="well">
                        <div class="row">
                            <div class="col-sm-4">
                                <label class="control-label">ID:</label>
                                <asp:Label ID="PROJIDLabel" runat="server" Text='<%# Eval("PROJID") %>' /><br />
                                <asp:Label Font-Size="X-Large" Font-Bold="true" CssClass="text-info" Text='<%# Eval("CLIENTPROJECT") %>' runat="server" ID="CLIENTPROJECTLabel" /><br />
                                <label class="control-label">Project Site/ Address:</label>
                                <asp:Label ID="PROJSITELabel" runat="server" Text='<%# Eval("PROJSITE") %>' /><br />
                                <label class="control-label">Duration-From:</label>
                                <asp:Label ID="PROJFROMLabel" runat="server" Text='<%# Eval("PROJFROM","{0:MMMM dd, yyyy}") %>' /><br />
                                <label class="control-label">Duration-To:</label>
                                <asp:Label ID="PROJTOLabel" runat="server" Text='<%# Eval("PROJTO","{0:MMMM dd, yyyy}") %>' /><br />
                                <%--<label class="control-label">Started:</label>
                                <asp:TextBox ID="STARTDATELabel" runat="server" Text='<%# Bind("STARTDATE","{0:MMMM dd, yyyy}") %>' CssClass="form-control" /><br />
                                <label class="control-label">Ended:</label>
                                <asp:TextBox ID="ENDDATELabel" runat="server" Text='<%# Bind("ENDDATE","{0:MMMM dd, yyyy}") %>' CssClass="form-control" /><br />--%>
                                <p id="datestart-error-dialog">
                                    <label class="control-label">Started:</label>
                                    <span class="input-group input-append date" id="datePickerProjFrom">
                                        <asp:TextBox ID="_txtFromDate" Text='<%# Bind("STARTDATE","{0:MM/dd/yyyy}") %>' runat="server" CssClass="form-control"
                                            data-validation="required custom"
                                            data-validation-error-msg-required="You must select a Start Date"
                                            data-validation-regexp="^([0-9/]+)$"
                                            data-validation-error-msg-custom="Invalid date."
                                            data-validation-error-msg-container="#datestart-error-dialog" />
                                        <span class="input-group-addon add-on"><span class="glyphicon glyphicon-calendar"></span></span>
                                    </span>
                                </p>
                                <p id="dateend-error-dialog">
                                    <label class="control-label">Ended:</label>
                                    <span class="input-group input-append date" id="datePickerProjTo">
                                        <asp:TextBox ID="_txtToDate" Text='<%# Bind("ENDDATE","{0:MM/dd/yyyy}") %>' runat="server" CssClass="form-control"
                                            data-validation="custom"
                                            data-validation-optional="true"
                                            data-validation-error-msg-required="You must select a End Date"
                                            data-validation-regexp="^([0-9/]+)$"
                                            data-validation-error-msg-custom="Invalid date."
                                            data-validation-error-msg-container="#dateend-error-dialog" />
                                        <span class="input-group-addon add-on"><span class="glyphicon glyphicon-calendar"></span></span>
                                    </span>
                                </p>
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
                                <p>
                                    <label class="control-label">Project Status:</label>
                                    <asp:DropDownList ID="_dropdownProjectStat" runat="server" CssClass="form-control" SelectedValue='<%# Bind("PROGRESS") %>' 
                                        data-validation="required"
                                        data-validation-error-msg-required="You must select a Status">
                                        <asp:ListItem Value=" ">-- Please select a status --</asp:ListItem>
                                        <asp:ListItem>On Queue</asp:ListItem>
                                        <asp:ListItem>On Going</asp:ListItem>
                                        <asp:ListItem>Finish</asp:ListItem>
                                    </asp:DropDownList>
                                </p>
                                <%--<label class="control-label">Status:</label>
                                <asp:Label ID="PROGRESSLabel" runat="server" Text='<%# Eval("PROGRESS") %>' /><br />--%>
                            </div>
                            <div class="col-sm-8">
                                <div class="col-sm-6">
                                    <h5 class="bg-primary text-center" style="padding: 8px">Assigned Equipment</h5>
                                    <asp:BulletedList ID="_bulletlistAssEquip" runat="server" DataSourceID="DataSourceAssEquip" DataTextField="PROJEQUIPQUANT" BulletStyle="Square" Height="100%"></asp:BulletedList>
                                    <asp:SqlDataSource runat="server" ID="DataSourceAssEquip" ConnectionString='<%$ ConnectionStrings:ConnString_WEB_ASSET_DB %>' SelectCommand="SELECT CAST(ASSIGNEDEQUIP.ASSEQUIPQUANT AS VARCHAR(10)) + '  -  ' + EQUIPMENT.EQUIPMENTNAME AS PROJEQUIPQUANT FROM EQUIPMENT INNER JOIN ASSIGNEDEQUIP ON EQUIPMENT.EQUIPMENTID = ASSIGNEDEQUIP.EQUIPMENTID WHERE PROJID=@PROJID">
                                        <SelectParameters>
                                            <asp:ControlParameter ControlID="PROJIDLabel" PropertyName="Text" Name="PROJID"></asp:ControlParameter>
                                        </SelectParameters>
                                    </asp:SqlDataSource>
                                    <asp:Label ID="Label6" runat="server" Text="Label" CssClass="text-info" Font-Size="Larger">Total Equipment Assigned:</asp:Label>
                                    <asp:Label ID="_labelTotalAssEquip" runat="server" Text="Label" CssClass="text-success" Font-Size="Larger"></asp:Label>
                                </div>
                                <div class="col-sm-6">
                                    <h5 class="bg-primary text-center" style="padding: 8px">Assigned Worker</h5>
                                    <asp:BulletedList ID="_bulletlistAssWorker" runat="server" DataSourceID="DataSourceAssWorker" DataTextField="WORKERFULNAME" BulletStyle="Square" Height="100%"></asp:BulletedList>
                                    <asp:SqlDataSource runat="server" ID="DataSourceAssWorker" ConnectionString='<%$ ConnectionStrings:ConnString_WEB_ASSET_DB %>' SelectCommand="SELECT WORKER.WORKERLNAME + ',  ' + WORKER.WORKERFNAME AS WORKERFULNAME FROM WORKER INNER JOIN ASSIGNEDWORKER ON WORKER.WORKERID = ASSIGNEDWORKER.WORKERID WHERE (ASSIGNEDWORKER.PROJID = @PROJID)">
                                        <SelectParameters>
                                            <asp:ControlParameter ControlID="PROJIDLabel" PropertyName="Text" Name="PROJID"></asp:ControlParameter>
                                        </SelectParameters>
                                    </asp:SqlDataSource>
                                    <asp:Label ID="Label5" runat="server" Text="Label" CssClass="text-info" Font-Size="Larger">Total Worker Assigned:</asp:Label>
                                    <asp:Label ID="_labelTotalAssWorker" runat="server" Text="Label" CssClass="text-success" Font-Size="Larger"></asp:Label>
                                    <asp:HyperLink ID="_hyperlinkAssignEdit" runat="server" NavigateUrl='<%#"~/ProjectSpecification_CRUD.aspx?id="+Eval("PROJID") %>' Text="" CssClass="btn btn-link" Visible="false">Add/Edit Assigments</asp:HyperLink>
                                </div>
                            </div>
                        </div>
                        <hr />
                        <div class="row">
                            <div class="col-sm-4 pull-right">
                                <div class="col-xs-6">
                                    <asp:Button ID="UpdateButton" runat="server" CommandName="Update" Text="Save" CssClass="btn btn-primary center-block col-xs-12" />
                                </div>
                                <div class="col-xs-6">
                                    <asp:Button ID="CancelButton" runat="server" CommandName="Cancel" Text="Cancel" CssClass="btn btn-danger center-block col-xs-12" OnClientClick="window.location = '/ProjectSpecification.aspx'; this.form.reset();return false;" />
                                </div>
                            </div>
                        </div>
                        <br />
                    </div>
                </asp:Panel>
                <%--<td runat="server" style="">PROJID:
                <asp:Label ID="PROJIDLabel1" runat="server" Text='<%# Eval("PROJID") %>' />
                <br />
                CLIENTPROJECT:
                <asp:TextBox ID="CLIENTPROJECTTextBox" runat="server" Text='<%# Bind("CLIENTPROJECT") %>' />
                <br />
                PROJSITE:
                <asp:TextBox ID="PROJSITETextBox" runat="server" Text='<%# Bind("PROJSITE") %>' />
                <br />
                PROJFROM:
                <asp:TextBox ID="PROJFROMTextBox" runat="server" Text='<%# Bind("PROJFROM") %>' />
                <br />
                PROJTO:
                <asp:TextBox ID="PROJTOTextBox" runat="server" Text='<%# Bind("PROJTO") %>' />
                <br />
                STARTDATE:
                <asp:TextBox ID="STARTDATETextBox" runat="server" Text='<%# Bind("STARTDATE") %>' />
                <br />
                ENDDATE:
                <asp:TextBox ID="ENDDATETextBox" runat="server" Text='<%# Bind("ENDDATE") %>' />
                <br />
                PROGRESS:
                <asp:TextBox ID="PROGRESSTextBox" runat="server" Text='<%# Bind("PROGRESS") %>' />
                <br />
                <asp:Button ID="UpdateButton" runat="server" CommandName="Update" Text="Update" />
                <br />
                <asp:Button ID="CancelButton" runat="server" CommandName="Cancel" Text="Cancel" />
                <br />
            </td>--%>
        </EditItemTemplate>
        <EmptyDataTemplate>
            <div runat="server" style="">
                <div>
                    <div>No data was returned.</div>
                </div>
            </div>
        </EmptyDataTemplate>
        <EmptyItemTemplate>
            <div runat="server" />
        </EmptyItemTemplate>
        <GroupTemplate>
            <div id="itemPlaceholderContainer" runat="server">
                <div id="itemPlaceholder" runat="server"></div>
            </div>
        </GroupTemplate>
        <%--<InsertItemTemplate>
            <td runat="server" style="">CLIENTPROJECT:
                <asp:TextBox ID="CLIENTPROJECTTextBox" runat="server" Text='<%# Bind("CLIENTPROJECT") %>' />
                <br />
                PROJSITE:
                <asp:TextBox ID="PROJSITETextBox" runat="server" Text='<%# Bind("PROJSITE") %>' />
                <br />
                PROJFROM:
                <asp:TextBox ID="PROJFROMTextBox" runat="server" Text='<%# Bind("PROJFROM") %>' />
                <br />
                PROJTO:
                <asp:TextBox ID="PROJTOTextBox" runat="server" Text='<%# Bind("PROJTO") %>' />
                <br />
                STARTDATE:
                <asp:TextBox ID="STARTDATETextBox" runat="server" Text='<%# Bind("STARTDATE") %>' />
                <br />
                ENDDATE:
                <asp:TextBox ID="ENDDATETextBox" runat="server" Text='<%# Bind("ENDDATE") %>' />
                <br />
                PROGRESS:
                <asp:TextBox ID="PROGRESSTextBox" runat="server" Text='<%# Bind("PROGRESS") %>' />
                <br />
                <asp:Button ID="InsertButton" runat="server" CommandName="Insert" Text="Insert" />
                <br />
                <asp:Button ID="CancelButton" runat="server" CommandName="Cancel" Text="Clear" />
                <br />
            </td>
        </InsertItemTemplate>--%>
        <ItemTemplate>
            <div class="col-sm-12">
                <asp:Panel ID="Panel1" runat="server">
                    <div runat="server" style="" class="well">
                        <div class="row">
                            <div class="col-sm-4">
                                <asp:DropDownList ID="_dropdownProjectStat" runat="server" CssClass="form-control" SelectedValue='<%# Bind("PROGRESS") %>' Visible="false"
                                        data-validation="required"
                                        data-validation-error-msg-required="You must select a Status">
                                        <asp:ListItem Value=" ">-- Please select a status --</asp:ListItem>
                                        <asp:ListItem>On Queue</asp:ListItem>
                                        <asp:ListItem>On Going</asp:ListItem>
                                        <asp:ListItem>Finish</asp:ListItem>
                                    </asp:DropDownList>
                                <label class="control-label">ID:</label>
                                <asp:Label ID="PROJIDLabel" runat="server" Text='<%# Eval("PROJID") %>' /><br />
                                <asp:Label Font-Size="X-Large" Font-Bold="true" CssClass="text-info" Text='<%# Eval("CLIENTPROJECT") %>' runat="server" ID="CLIENTPROJECTLabel" /><br />
                                <label class="control-label">Project Site/ Address:</label>
                                <asp:Label ID="PROJSITELabel" runat="server" Text='<%# Eval("PROJSITE") %>' /><br />
                                <label class="control-label">Duration-From:</label>
                                <asp:Label ID="PROJFROMLabel" runat="server" Text='<%# Eval("PROJFROM","{0:MMMM dd, yyyy}") %>' /><br />
                                <label class="control-label">Duration-To:</label>
                                <asp:Label ID="PROJTOLabel" runat="server" Text='<%# Eval("PROJTO","{0:MMMM dd, yyyy}") %>' /><br />
                                <label class="control-label">Started:</label>
                                <asp:Label ID="STARTDATELabel" runat="server" Text='<%# Eval("STARTDATE","{0:MMMM dd, yyyy}") %>' /><br />
                                <label class="control-label">Ended:</label>
                                <asp:Label ID="ENDDATELabel" runat="server" Text='<%# Eval("ENDDATE","{0:MMMM dd, yyyy}") %>' /><br />
                                <label class="control-label">Status:</label>
                                <asp:Label ID="PROGRESSLabel" runat="server" Text='<%# Eval("PROGRESS") %>' /><br />
                            </div>
                            <div class="col-sm-8">
                                <div class="col-sm-6">
                                    <h5 class="bg-primary text-center" style="padding: 8px">Assigned Equipment</h5>
                                    <asp:BulletedList ID="_bulletlistAssEquip" runat="server" DataSourceID="DataSourceAssEquip" DataTextField="PROJEQUIPQUANT" CssClass="text-left" BulletStyle="Square" Height="100%"></asp:BulletedList>
                                    <asp:SqlDataSource runat="server" ID="DataSourceAssEquip" ConnectionString='<%$ ConnectionStrings:ConnString_WEB_ASSET_DB %>' SelectCommand="SELECT CAST(ASSIGNEDEQUIP.ASSEQUIPQUANT AS VARCHAR(10)) + '  -  ' + EQUIPMENT.EQUIPMENTNAME AS PROJEQUIPQUANT FROM EQUIPMENT INNER JOIN ASSIGNEDEQUIP ON EQUIPMENT.EQUIPMENTID = ASSIGNEDEQUIP.EQUIPMENTID WHERE PROJID=@PROJID">
                                        <SelectParameters>
                                            <asp:ControlParameter ControlID="PROJIDLabel" PropertyName="Text" Name="PROJID"></asp:ControlParameter>
                                        </SelectParameters>
                                    </asp:SqlDataSource>
                                    <asp:Label ID="Label6" runat="server" Text="Label" CssClass="text-info" Font-Size="Larger">Total Equipment Assigned:</asp:Label>
                                    <asp:Label ID="_labelTotalAssEquip" runat="server" Text="Label" CssClass="text-success" Font-Size="Larger"></asp:Label>
                                </div>
                                <div class="col-sm-6">
                                    <h5 class="bg-primary text-center" style="padding: 8px">Assigned Worker</h5>
                                    <asp:BulletedList ID="_bulletlistAssWorker" runat="server" DataSourceID="DataSourceAssWorker" DataTextField="WORKERFULNAME" CssClass="text-left" BulletStyle="Square" Height="100%"></asp:BulletedList>
                                    <asp:SqlDataSource runat="server" ID="DataSourceAssWorker" ConnectionString='<%$ ConnectionStrings:ConnString_WEB_ASSET_DB %>' SelectCommand="SELECT WORKER.WORKERLNAME + ',  ' + WORKER.WORKERFNAME AS WORKERFULNAME FROM WORKER INNER JOIN ASSIGNEDWORKER ON WORKER.WORKERID = ASSIGNEDWORKER.WORKERID WHERE (ASSIGNEDWORKER.PROJID = @PROJID)">
                                        <SelectParameters>
                                            <asp:ControlParameter ControlID="PROJIDLabel" PropertyName="Text" Name="PROJID"></asp:ControlParameter>
                                        </SelectParameters>
                                    </asp:SqlDataSource>
                                    <asp:Label ID="Label5" runat="server" Text="Label" CssClass="text-info" Font-Size="Larger">Total Worker Assigned:</asp:Label>
                                    <asp:Label ID="_labelTotalAssWorker" runat="server" Text="Label" CssClass="text-success" Font-Size="Larger"></asp:Label>
                                </div>
                            </div>
                        </div>
                        <hr />
                        <div class="row">
                            <div class="text-center">
                                <asp:LinkButton ID="EditButton" runat="server" CommandName="Edit" Text="Edit" CssClass="btn btn-link" />
                                <asp:HyperLink ID="_hyperlinkAssignEdit" runat="server" NavigateUrl='<%#"~/ProjectSpecification_CRUD.aspx?id="+Eval("PROJID") %>' Text="" CssClass="btn btn-link">Add/Edit Assigments</asp:HyperLink>
                            </div>
                        </div>
                        <br />
                    </div>
                </asp:Panel>
            </div>
        </ItemTemplate>
        <LayoutTemplate>
            <div runat="server">
                <div runat="server">
                    <div runat="server">
                        <table id="groupPlaceholderContainer" runat="server" border="0" style="">
                            <tr id="groupPlaceholder" runat="server">
                            </tr>
                        </table>
                    </div>
                </div>
                <div runat="server">
                    <div runat="server" style="">
                        <asp:DataPager ID="DataPager1" runat="server" PageSize="6">
                            <Fields>
                                <asp:NextPreviousPagerField ButtonType="Button" ShowFirstPageButton="True" ShowNextPageButton="False" ShowPreviousPageButton="True" ButtonCssClass="btn btn-info btn-sm" />
                                <asp:NumericPagerField NumericButtonCssClass="label label-success" CurrentPageLabelCssClass="badge" />
                                <asp:NextPreviousPagerField ButtonType="Button" ShowLastPageButton="True" ShowNextPageButton="True" ShowPreviousPageButton="False" ButtonCssClass="btn btn-info btn-sm" />
                            </Fields>
                        </asp:DataPager>
                    </div>
                </div>
            </div>
        </LayoutTemplate>
        <%--<SelectedItemTemplate>
            <td runat="server" style="">PROJID:
                <asp:Label ID="PROJIDLabel" runat="server" Text='<%# Eval("PROJID") %>' />
                <br />
                CLIENTPROJECT:
                <asp:Label ID="CLIENTPROJECTLabel" runat="server" Text='<%# Eval("CLIENTPROJECT") %>' />
                <br />
                PROJSITE:
                <asp:Label ID="PROJSITELabel" runat="server" Text='<%# Eval("PROJSITE") %>' />
                <br />
                PROJFROM:
                <asp:Label ID="PROJFROMLabel" runat="server" Text='<%# Eval("PROJFROM") %>' />
                <br />
                PROJTO:
                <asp:Label ID="PROJTOLabel" runat="server" Text='<%# Eval("PROJTO") %>' />
                <br />
                STARTDATE:
                <asp:Label ID="STARTDATELabel" runat="server" Text='<%# Eval("STARTDATE") %>' />
                <br />
                ENDDATE:
                <asp:Label ID="ENDDATELabel" runat="server" Text='<%# Eval("ENDDATE") %>' />
                <br />
                PROGRESS:
                <asp:Label ID="PROGRESSLabel" runat="server" Text='<%# Eval("PROGRESS") %>' />
                <br />
                <asp:Button ID="EditButton" runat="server" CommandName="Edit" Text="Edit" />
                <br />
            </td>
        </SelectedItemTemplate>--%>
    </asp:ListView>
    <asp:SqlDataSource runat="server" ID="DataSourceProjectAssign" ConnectionString='<%$ ConnectionStrings:ConnString_WEB_ASSET_DB %>' SelectCommand="SELECT PROJECT.PROJID, CLIENT.CLIENTNAME + ' - ' + PROJECT.PROJNAME AS CLIENTPROJECT, PROJECT.PROJSITE, PROJECT.PROJFROM, PROJECT.PROJTO, PROJECT.STARTDATE, PROJECT.ENDDATE, PROJECT.PROGRESS FROM PROJECT INNER JOIN CLIENT ON PROJECT.CLIENTID = CLIENT.CLIENTID" UpdateCommand="UPDATE [PROJECT] SET  [STARTDATE] = @STARTDATE, [ENDDATE] = @ENDDATE, [PROGRESS] = @PROGRESS WHERE [PROJID] = @PROJID">
        <UpdateParameters>
            <asp:Parameter Name="STARTDATE" DbType="Date"></asp:Parameter>
            <asp:Parameter Name="ENDDATE" DbType="Date"></asp:Parameter>
            <asp:Parameter Name="PROGRESS" Type="String"></asp:Parameter>
            <asp:Parameter Name="PROJID" Type="Int32"></asp:Parameter>
        </UpdateParameters>
    </asp:SqlDataSource>
    <script type="text/javascript">
        $.validate()
    </script>
</asp:Content>

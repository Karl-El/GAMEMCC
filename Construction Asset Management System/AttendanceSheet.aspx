<%@ Page Title="Attendance Sheet" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="AttendanceSheet.aspx.cs" Inherits="Construction_Asset_Management_System.AttendanceSheet" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <link href="Scripts/Date Picker/datepicker.min.css" rel="stylesheet" type="text/css" />
    <script src="Scripts/Date Picker/bootstrap-datepicker.min.js"></script>
    <div class="container">
        <h4 class="well text-center" style="padding: 8px">Attendance List</h4>
        <br />
        <div class="well">
            <div class="row">
                <div class="col-sm-4">
                    <asp:DropDownList ID="_dropdownProj" runat="server" CssClass="form-control" DataSourceID="DataSourceProjectDDList" AutoPostBack="True" DataTextField="CLIENTPROJ" DataValueField="PROJID"></asp:DropDownList>
                    <asp:SqlDataSource runat="server" ID="DataSourceProjectDDList" ConnectionString='<%$ ConnectionStrings:ConnString_WEB_ASSET_DB %>' SelectCommand="SELECT PROJECT.PROJID, PROJECT.PROJNAME + ', ' + CLIENT.CLIENTNAME AS CLIENTPROJ FROM PROJECT INNER JOIN CLIENT ON PROJECT.CLIENTID = CLIENT.CLIENTID ORDER BY CLIENT.CLIENTNAME"></asp:SqlDataSource>
                </div>
                <div class="col-sm-4">
                    <span class="input-group input-append date" id="datePickerDate">
                        <asp:TextBox ID="_txtDate" runat="server" CssClass="form-control"
                            data-validation="required custom"
                            data-validation-error-msg-required="You must select a End Date"
                            data-validation-regexp="^([0-9/]+)$"
                            data-validation-error-msg-custom="Invalid date."
                            data-validation-error-msg-container="#dateend-error-dialog" />
                        <span class="input-group-addon add-on"><span class="glyphicon glyphicon-calendar"></span></span>
                    </span>
                </div>
                <div class="col-sm-4">
                    <div class="text-center">
                        <asp:LinkButton ID="_btnFilter" runat="server" CssClass="btn btn-info" OnClick="_btnFilter_Click">Filter</asp:LinkButton>
                        <asp:LinkButton ID="_btnAll" runat="server" CssClass="btn btn-success" OnClick="_btnAll_Click">Show All</asp:LinkButton>
                    </div>
                </div>
                <script type="text/javascript">
                    $(function () {
                        $('#datePickerDate').datepicker({
                            format: 'mm/dd/yyyy',
                            todayHighlight: true,
                        });
                    });
                </script>
            </div>
            <hr />
            <div class="row">
                <asp:ListView ID="_listviewAttendance" runat="server" DataKeyNames="DAILYATTENDID" OnItemDataBound="_listviewAttendance_ItemDataBound">
                    <%--<AlternatingItemTemplate>
                    <tr style="">
                        <td>
                            <asp:Button runat="server" CommandName="Delete" Text="Delete" ID="DeleteButton" />
                            <asp:Button runat="server" CommandName="Edit" Text="Edit" ID="EditButton" />
                        </td>
                        <td>
                            <asp:Label Text='<%# Eval("DAILYATTENDID") %>' runat="server" ID="DAILYATTENDIDLabel" /></td>
                        <td>
                            <asp:Label Text='<%# Eval("FULLNAME") %>' runat="server" ID="FULLNAMELabel" /></td>
                        <td>
                            <asp:Label Text='<%# Eval("BADGECODE") %>' runat="server" ID="BADGECODELabel" /></td>
                        <td>
                            <asp:Label Text='<%# Eval("ATTENDDDATE") %>' runat="server" ID="ATTENDDDATELabel" /></td>
                        <td>
                            <asp:Label Text='<%# Eval("ATTENDTIMEIN") %>' runat="server" ID="ATTENDTIMEINLabel" /></td>
                        <td>
                            <asp:Label Text='<%# Eval("ATTENDTIMEOUT") %>' runat="server" ID="ATTENDTIMEOUTLabel" /></td>
                        <td>
                            <asp:Label Text='<%# Eval("TOTALHRS") %>' runat="server" ID="TOTALHRSLabel" /></td>
                    </tr>
                </AlternatingItemTemplate>--%>
                    <EditItemTemplate>
                        <tr style="">
                            <td>
                                <asp:Label Text='<%# Eval("DAILYATTENDID") %>' runat="server" ID="DAILYATTENDIDLabel" Visible="false"/></td>
                            <td>
                                <asp:Label Text='<%# Eval("ATTENDTIMEOUT","{0:h:mm tt}" ) %>' runat="server" ID="ATTENDTIMEOUTLabel" Visible="false" />
                                <asp:Label Text='<%# Eval("ATTENDTIMEIN","{0:h:mm tt}" ) %>' runat="server" ID="ATTENDTIMEINLabel" Visible="false" />
                                <asp:Label Text='<%# Bind("FULLNAME") %>' runat="server" ID="FULLNAMETextBox" Enabled="false" CssClass="control-label" /></td>
                            <td>
                                <asp:Label Text='<%# Bind("BADGECODE") %>' runat="server" ID="BADGECODETextBox" Enabled="false" CssClass="control-label" /></td>
                            <td>
                                <asp:Label Text='<%# Bind("ATTENDDDATE","{0:MM/dd/yyyy}") %>' runat="server" ID="ATTENDDDATETextBox" Enabled="false" CssClass="control-label" /></td>
                            <td>
                                <asp:TextBox Text='<%# Bind("ATTENDTIMEIN","{0:h:mm tt}") %>' runat="server" ID="ATTENDTIMEINTextBox" CssClass="form-control" />
                                <asp:RegularExpressionValidator ID="RegularExpressionValidator1" ControlToValidate="ATTENDTIMEINTextBox" runat="server" ErrorMessage="Invalid input,valid format is HH:MM AM/PM" ValidationExpression="^([0-9]|1[0-2]):[0-5][0-9] (AM|am|PM|pm)$" Display="Static" ForeColor="#FF3535" SetFocusOnError="True"></asp:RegularExpressionValidator>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="Must have an input" ControlToValidate="ATTENDTIMEINTextBox" ForeColor="#FF3535" SetFocusOnError="True"></asp:RequiredFieldValidator></td>
                            <td>
                                <asp:TextBox Text='<%# Bind("ATTENDTIMEOUT","{0:h:mm tt}") %>' runat="server" ID="ATTENDTIMEOUTTextBox" CssClass="form-control" />
                                <asp:RegularExpressionValidator ID="RegularExpressionValidator2" ControlToValidate="ATTENDTIMEOUTTextBox" runat="server" ErrorMessage="Invalid input,valid format is HH:MM AM/PM" ValidationExpression="^([0-9]|1[0-2]):[0-5][0-9] (AM|am|PM|pm)$" Display="Static" ForeColor="#FF3535" SetFocusOnError="True"></asp:RegularExpressionValidator>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="Must have an input" ControlToValidate="ATTENDTIMEOUTTextBox" ForeColor="#FF3535" SetFocusOnError="True"></asp:RequiredFieldValidator></td>
                            <td>
                                <asp:Label Text='<%# Eval("TOTALHRS") %>' runat="server" ID="TOTALHRSLabel" Visible="true" />
                            </td>
                            <td>
                                <asp:Label Text='<%# Eval("ATTENDSTATUS") %>' runat="server" ID="ATTENDSTATUSLabel" /></td>
                            <td>
                                <asp:LinkButton runat="server" CommandName="Update" Text="Save" ID="UpdateButton" CssClass="btn btn-info"
                                    data-toggle="tooltip"
                                    data-placement="top"
                                    data-original-title="Save?" ValidateRequestMode="Enabled"><span class="glyphicon glyphicon-ok"></asp:LinkButton>
                                <asp:LinkButton runat="server" CommandName="Cancel" Text="Cancel" ID="CancelButton" CssClass="btn btn-danger" OnClientClick="this.form.reset();return false;"
                                    data-toggle="tooltip"
                                    data-placement="top"
                                    data-original-title="Cancel" CausesValidation="False"><span class="glyphicon glyphicon-remove"></asp:LinkButton>
                            </td>
                        </tr>
                    </EditItemTemplate>
                    <EmptyDataTemplate>
                        <table runat="server" style="">
                            <tr>
                                <td>No data was returned.</td>
                            </tr>
                        </table>
                    </EmptyDataTemplate>
                    <%--<InsertItemTemplate>
                    <tr style="">
                        <td>
                            <asp:Button runat="server" CommandName="Insert" Text="Insert" ID="InsertButton" />
                            <asp:Button runat="server" CommandName="Cancel" Text="Clear" ID="CancelButton" />
                        </td>
                        <td>&nbsp;</td>
                        <td>
                            <asp:TextBox Text='<%# Bind("FULLNAME") %>' runat="server" ID="FULLNAMETextBox" /></td>
                        <td>
                            <asp:TextBox Text='<%# Bind("BADGECODE") %>' runat="server" ID="BADGECODETextBox" /></td>
                        <td>
                            <asp:TextBox Text='<%# Bind("ATTENDDDATE") %>' runat="server" ID="ATTENDDDATETextBox" /></td>
                        <td>
                            <asp:TextBox Text='<%# Bind("ATTENDTIMEIN") %>' runat="server" ID="ATTENDTIMEINTextBox" /></td>
                        <td>
                            <asp:TextBox Text='<%# Bind("ATTENDTIMEOUT") %>' runat="server" ID="ATTENDTIMEOUTTextBox" /></td>
                        <td>
                            <asp:TextBox Text='<%# Bind("TOTALHRS") %>' runat="server" ID="TOTALHRSTextBox" /></td>
                    </tr>
                </InsertItemTemplate>--%>
                    <ItemTemplate>
                        <tr style="">
                            <td>
                                <asp:Label Text='<%# Eval("DAILYATTENDID") %>' runat="server" ID="DAILYATTENDIDLabel" Visible="false"/></td>
                            <td>
                                <asp:Label Text='<%# Eval("FULLNAME") %>' runat="server" ID="FULLNAMELabel" /></td>
                            <td>
                                <asp:Label Text='<%# Eval("BADGECODE") %>' runat="server" ID="BADGECODELabel" /></td>
                            <td>
                                <asp:Label Text='<%# Eval("ATTENDDDATE","{0:MM/dd/yyyy}") %>' runat="server" ID="ATTENDDDATELabel" /></td>
                            <td>
                                <asp:Label Text='<%# Eval("ATTENDTIMEIN","{0:h:mm tt}" ) %>' runat="server" ID="ATTENDTIMEINLabel" /></td>
                            <td>
                                <asp:Label Text='<%# Eval("ATTENDTIMEOUT","{0:h:mm tt}" ) %>' runat="server" ID="ATTENDTIMEOUTLabel" /></td>
                            <td>
                                <asp:Label Text='<%# Eval("TOTALHRS") %>' runat="server" ID="TOTALHRSLabel" /></td>
                            <td>
                                <asp:Label Text='<%# Eval("ATTENDSTATUS") %>' runat="server" ID="ATTENDSTATUSLabel" /></td>
                            <td>
                                <asp:LinkButton ID="EditButton" runat="server" CommandName="Edit" Text="Edit" CssClass="btn btn-info"
                                    data-toggle="tooltip"
                                    data-placement="top"
                                    data-original-title="Edit Time?"><span class="glyphicon glyphicon-pencil"></span></asp:LinkButton>
                            </td>
                        </tr>
                    </ItemTemplate>
                    <LayoutTemplate>
                        <div runat="server" class="table-responsive col-sm-12">
                            <div runat="server">
                                <div runat="server">
                                    <table id="itemPlaceholderContainer" runat="server" border="0" style="" class="table table-condensed">
                                        <tr runat="server" style="" class="warning">
                                            <th runat="server" visible="true"></th>
                                            <th runat="server">Worker Name</th>
                                            <th runat="server">Badge Code</th>
                                            <th runat="server">Date</th>
                                            <th runat="server">Time In</th>
                                            <th runat="server">Time Out</th>
                                            <th runat="server">Total Hours</th>
                                            <th runat="server">Status</th>
                                            <th runat="server"></th>
                                        </tr>
                                        <tr runat="server" id="itemPlaceholder"></tr>
                                    </table>
                                </div>
                            </div>
                            <tr runat="server">
                                <td runat="server" style="">
                                    <asp:DataPager runat="server" ID="DataPager1" PageSize="20">
                                        <Fields>
                                            <asp:NextPreviousPagerField ButtonType="Button" ShowFirstPageButton="True" ShowNextPageButton="False" ShowPreviousPageButton="True" ButtonCssClass="btn btn-info btn-sm" />
                                            <asp:NumericPagerField NumericButtonCssClass="label label-success" CurrentPageLabelCssClass="badge" />
                                            <asp:NextPreviousPagerField ButtonType="Button" ShowLastPageButton="True" ShowNextPageButton="True" ShowPreviousPageButton="False" ButtonCssClass="btn btn-info btn-sm" />
                                        </Fields>
                                    </asp:DataPager>
                                </td>
                            </tr>
                        </div>
                    </LayoutTemplate>
                    <%--<SelectedItemTemplate>
                    <tr style="">
                        <td>
                            <asp:Button runat="server" CommandName="Delete" Text="Delete" ID="DeleteButton" />
                            <asp:Button runat="server" CommandName="Edit" Text="Edit" ID="EditButton" />
                        </td>
                        <td>
                            <asp:Label Text='<%# Eval("DAILYATTENDID") %>' runat="server" ID="DAILYATTENDIDLabel" /></td>
                        <td>
                            <asp:Label Text='<%# Eval("FULLNAME") %>' runat="server" ID="FULLNAMELabel" /></td>
                        <td>
                            <asp:Label Text='<%# Eval("BADGECODE") %>' runat="server" ID="BADGECODELabel" /></td>
                        <td>
                            <asp:Label Text='<%# Eval("ATTENDDDATE") %>' runat="server" ID="ATTENDDDATELabel" /></td>
                        <td>
                            <asp:Label Text='<%# Eval("ATTENDTIMEIN") %>' runat="server" ID="ATTENDTIMEINLabel" /></td>
                        <td>
                            <asp:Label Text='<%# Eval("ATTENDTIMEOUT") %>' runat="server" ID="ATTENDTIMEOUTLabel" /></td>
                        <td>
                            <asp:Label Text='<%# Eval("TOTALHRS") %>' runat="server" ID="TOTALHRSLabel" /></td>
                    </tr>
                </SelectedItemTemplate>--%>
                </asp:ListView>
                <asp:SqlDataSource runat="server" ID="DataSourceAttendFilter" ConnectionString='<%$ ConnectionStrings:ConnString_WEB_ASSET_DB %>' SelectCommand="SELECT DAILYATTEND.DAILYATTENDID, WORKER.WORKERLNAME + ', ' + WORKER.WORKERFNAME AS FULLNAME, BADGE.BADGECODE, DAILYATTEND.ATTENDDDATE, DAILYATTEND.ATTENDTIMEIN, DAILYATTEND.ATTENDTIMEOUT, DAILYATTEND.TOTALHRS, DAILYATTEND.ATTENDSTATUS FROM DAILYATTEND INNER JOIN PROJECT ON DAILYATTEND.PROJID = PROJECT.PROJID INNER JOIN WORKER ON DAILYATTEND.WORKERID = WORKER.WORKERID INNER JOIN BADGE ON WORKER.WORKERID = BADGE.WORKERID WHERE (DAILYATTEND.PROJID = @PROJID) AND (DAILYATTEND.ATTENDDDATE = @ATTENDDDATE) " DeleteCommand="DELETE FROM [DAILYATTEND] WHERE [DAILYATTENDID] = @DAILYATTENDID" UpdateCommand="UPDATE [DAILYATTEND] SET  [ATTENDTIMEIN] = @ATTENDTIMEIN, [ATTENDTIMEOUT] = @ATTENDTIMEOUT, [TOTALHRS] = @TOTALHRS WHERE [DAILYATTENDID] = @DAILYATTENDID">
                    <DeleteParameters>
                        <asp:Parameter Name="DAILYATTENDID" Type="Int32"></asp:Parameter>
                    </DeleteParameters>
                    <SelectParameters>
                        <asp:ControlParameter ControlID="_dropdownProj" PropertyName="SelectedValue" Name="PROJID" Type="Int32"></asp:ControlParameter>
                        <asp:ControlParameter ControlID="_txtDate" PropertyName="Text" Name="ATTENDDDATE" DbType="Date"></asp:ControlParameter>
                    </SelectParameters>
                    <UpdateParameters>
                        <asp:Parameter Name="ATTENDTIMEIN" Type="DateTime"></asp:Parameter>
                        <asp:Parameter Name="ATTENDTIMEOUT" Type="DateTime"></asp:Parameter>
                        <asp:Parameter Name="TOTALHRS" Type="String"></asp:Parameter>
                        <asp:Parameter Name="DAILYATTENDID" Type="Int32"></asp:Parameter>
                    </UpdateParameters>
                </asp:SqlDataSource>
                <asp:SqlDataSource runat="server" ID="DataSourceAttendAll" ConnectionString='<%$ ConnectionStrings:ConnString_WEB_ASSET_DB %>' SelectCommand="SELECT DAILYATTEND.DAILYATTENDID, WORKER.WORKERLNAME + ', ' + WORKER.WORKERFNAME AS FULLNAME, BADGE.BADGECODE, DAILYATTEND.ATTENDDDATE, DAILYATTEND.ATTENDTIMEIN, DAILYATTEND.ATTENDTIMEOUT, DAILYATTEND.TOTALHRS, DAILYATTEND.ATTENDSTATUS FROM DAILYATTEND INNER JOIN PROJECT ON DAILYATTEND.PROJID = PROJECT.PROJID INNER JOIN WORKER ON DAILYATTEND.WORKERID = WORKER.WORKERID INNER JOIN BADGE ON WORKER.WORKERID = BADGE.WORKERID WHERE (DAILYATTEND.PROJID = @PROJID) ORDER BY DAILYATTEND.ATTENDDDATE" DeleteCommand="DELETE FROM [DAILYATTEND] WHERE [DAILYATTENDID] = @DAILYATTENDID" UpdateCommand="UPDATE [DAILYATTEND] SET  [ATTENDTIMEIN] = @ATTENDTIMEIN, [ATTENDTIMEOUT] = @ATTENDTIMEOUT, [TOTALHRS] = @TOTALHRS WHERE [DAILYATTENDID] = @DAILYATTENDID">
                    <DeleteParameters>
                        <asp:Parameter Name="DAILYATTENDID" Type="Int32"></asp:Parameter>
                    </DeleteParameters>
                    <SelectParameters>
                        <asp:ControlParameter ControlID="_dropdownProj" PropertyName="SelectedValue" Name="PROJID" Type="Int32"></asp:ControlParameter>
                    </SelectParameters>
                    <UpdateParameters>
                        <asp:Parameter Name="ATTENDTIMEIN" Type="DateTime"></asp:Parameter>
                        <asp:Parameter Name="ATTENDTIMEOUT" Type="DateTime"></asp:Parameter>
                        <asp:Parameter Name="TOTALHRS" Type="String"></asp:Parameter>
                        <asp:Parameter Name="DAILYATTENDID" Type="Int32"></asp:Parameter>
                    </UpdateParameters>
                </asp:SqlDataSource>
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

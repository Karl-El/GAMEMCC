<%@ Page Title="Shift" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Shift.aspx.cs" Inherits="Construction_Asset_Management_System.Shift" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <script src="Scripts/Time Picker/bootstrap-timepicker.min.js"></script>
    <link href="Scripts/Time Picker/bootstrap-timepicker.min.css" rel="stylesheet" type="text/css" />
    <script src="Scripts/Form Validator/jquery.form-validator.js"></script>
    <link href="Scripts/Form Validator/theme-default.css" rel="stylesheet" type="text/css" />
    <h4 class="well text-center" style="padding: 8px">Shift Table</h4>
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
        </div>
    </div>
    <br />
    <asp:ListView ID="_listviewShift" runat="server" DataSourceID="DataSourceShift" DataKeyNames="SHIFTID" GroupItemCount="3" >
        <%--<AlternatingItemTemplate>
            <td runat="server" style="">SHIFTID:
                <asp:Label Text='<%# Eval("SHIFTID") %>' runat="server" ID="SHIFTIDLabel" /><br />
                SHIFTNAME:
                <asp:Label Text='<%# Eval("SHIFTNAME") %>' runat="server" ID="SHIFTNAMELabel" /><br />
                SHIFTSTART:
                <asp:Label Text='<%# Eval("SHIFTSTART","{0:h:mm tt}" ) %>' runat="server" ID="SHIFTSTARTLabel" /><br />
                SHIFTEND:
                <asp:Label Text='<%# Eval("SHIFTEND","{0:h:mm tt}" ) %>' runat="server" ID="SHIFTENDLabel" /><br />
                SHIFTTOTAL:
                <asp:Label Text='<%# Eval("SHIFTTOTAL") %>' runat="server" ID="SHIFTTOTALLabel" /><br />
                SHIFTCOLOR:
                <asp:Label Text='<%# Eval("SHIFTCOLOR") %>' runat="server" ID="SHIFTCOLORLabel" /><br />
                <asp:Button runat="server" CommandName="Delete" Text="Delete" ID="DeleteButton" /><br />
                <asp:Button runat="server" CommandName="Edit" Text="Edit" ID="EditButton" /><br />
            </td>
        </AlternatingItemTemplate>--%>
        <EditItemTemplate>
            <div runat="server" style="" class="col-sm-4">
                <div class="well">
                    <h4>Edit Shift</h4>
                    <p>
                        <label class="control-label">Shift Name:</label>
                        <asp:TextBox Text='<%# Bind("SHIFTNAME") %>' runat="server" ID="SHIFTNAMETextBox" CssClass="form-control"
                            data-validation="required custom"
                            data-validation-error-msg-required="You must enter a shift name"
                            data-validation-regexp="^([a-zA-Z-'. ]+)$"
                            data-validation-error-msg-custom="Invalid input letters only. -'. characters is allowed" />
                    </p>
                    <p id="timestart-error-dialog">
                        <label class="control-label">Shift Start Time:</label>
                        <span class="input-group" id="timePickerShiftStart">
                            <asp:TextBox Text='<%# Bind("SHIFTSTART","{0:h:mm tt}") %>' runat="server" ID="SHIFTSTARTTextBox" CssClass="form-control"
                                data-validation="custom"
                                data-validation-regexp="^([0-9]|1[0-2]):[0-5][0-9] (AM|am|PM|pm)$"
                                data-validation-error-msg-custom="valid format is HH:MM AM/PM"
                                data-validation-error-msg-container="#timestart-error-dialog" />
                            <span class="input-group-addon add-on"><span class="glyphicon glyphicon-time"></span></span>
                        </span>
                    </p>
                    <p id="timeend-error-dialog">
                        <label class="control-label">Shift End Time:</label>
                        <span class="input-group" id="timePickerShiftEnd">
                            <asp:TextBox Text='<%# Bind("SHIFTEND","{0:h:mm tt}" ) %>' runat="server" ID="SHIFTENDTextBox" CssClass="form-control"
                                data-validation="custom"
                                data-validation-regexp="^([0-9]|1[0-2]):[0-5][0-9] (AM|am|PM|pm)$"
                                data-validation-error-msg-custom="valid format is HH:MM AM/PM"
                                data-validation-error-msg-container="#timeend-error-dialog" AutoCompleteType="None" />
                            <span class="input-group-addon add-on"><span class="glyphicon glyphicon-time"></span>
                            </span>
                        </span>
                    </p>
                    <label class="control-label">Total-Hours:</label>
                    <asp:TextBox Text='<%# Bind("SHIFTTOTAL") %>' runat="server" ID="SHIFTTOTALTextBox" CssClass="form-control" Enabled="false"/>
                    <label class="control-label">Shift Color Code:</label>
                    <asp:TextBox Text='<%# Bind("SHIFTCOLOR") %>' runat="server" ID="TextBox1" TextMode="Color" CssClass="form-control"/>
                    <hr />
                    <div class="text-center">
                        <asp:LinkButton runat="server" CommandName="Update" Text="Update" ID="UpdateButton" CssClass="btn btn-info" OnClick="UpdateButton_Click"><span class="glyphicon glyphicon-save"></span> Save</asp:LinkButton>
                        <asp:LinkButton runat="server" CommandName="Cancel" Text="Cancel" ID="CancelButton" CssClass="btn btn-danger"><span class="glyphicon glyphicon-remove"></span> Cancel</asp:LinkButton>
                    </div>
                </div>
            </div>
        </EditItemTemplate>
        <EmptyDataTemplate>
            <table runat="server" style="">
                <tr>
                    <td>No data was returned.</td>
                </tr>
            </table>
        </EmptyDataTemplate>
        <EmptyItemTemplate>
            <td runat="server" />
        </EmptyItemTemplate>
        <GroupTemplate>
            <tr runat="server" id="itemPlaceholderContainer">
                <td runat="server" id="itemPlaceholder"></td>
            </tr>
        </GroupTemplate>
        <InsertItemTemplate>
            <div runat="server" style="" class="col-sm-4">
                <div class="well">
                    <h4>Add Shift</h4>
                    <p>
                        <label class="control-label">Shift Name:</label>
                        <asp:TextBox Text='<%# Bind("SHIFTNAME") %>' runat="server" ID="SHIFTNAMETextBox" CssClass="form-control"
                            data-validation="required custom"
                            data-validation-error-msg-required="You must enter a shift name"
                            data-validation-regexp="^([a-zA-Z-'. ]+)$"
                            data-validation-error-msg-custom="Invalid input letters only. -'. characters is allowed" />
                    </p>
                    <p id="timestart-error-dialog">
                        <label class="control-label">Shift Start Time:</label>
                        <span class="input-group" id="timePickerShiftStart">
                            <asp:TextBox Text='<%# Bind("SHIFTSTART","{0:h:mm tt}") %>' runat="server" ID="SHIFTSTARTTextBox" CssClass="form-control"
                                data-validation="custom"
                                data-validation-regexp="^([0-9]|1[0-2]):[0-5][0-9] (AM|am|PM|pm)$"
                                data-validation-error-msg-custom="valid format is HH:MM AM/PM"
                                data-validation-error-msg-container="#timestart-error-dialog" />
                            <span class="input-group-addon add-on"><span class="glyphicon glyphicon-time"></span></span>
                        </span>
                    </p>
                    <p id="timeend-error-dialog">
                        <label class="control-label">Shift End Time:</label>
                        <span class="input-group" id="timePickerShiftEnd">
                            <asp:TextBox Text='<%# Bind("SHIFTEND","{0:h:mm tt}" ) %>' runat="server" ID="SHIFTENDTextBox" CssClass="form-control"
                                data-validation="custom"
                                data-validation-regexp="^([0-9]|1[0-2]):[0-5][0-9] (AM|am|PM|pm)$"
                                data-validation-error-msg-custom="valid format is HH:MM AM/PM"
                                data-validation-error-msg-container="#timeend-error-dialog" AutoCompleteType="None" />
                            <span class="input-group-addon add-on"><span class="glyphicon glyphicon-time"></span>
                            </span>
                        </span>
                    </p>
                    <label class="control-label">Total-Hours:</label>
                    <asp:TextBox Text='<%# Bind("SHIFTTOTAL") %>' runat="server" ID="SHIFTTOTALTextBox" CssClass="form-control" Enabled="false" />
                    <label class="control-label">Shift Color Code:</label>
                    <asp:TextBox Text='<%# Bind("SHIFTCOLOR") %>' runat="server" ID="SHIFTCOLORTextBox" TextMode="Color" CssClass="form-control" />
                    <hr />
                    <div class="text-center">
                        <asp:LinkButton runat="server" CommandName="Insert" Text="Save" ID="InsertButton" CssClass="btn btn-info" OnClick="InsertButton_Click"><span class="glyphicon glyphicon-save"></span> Save</asp:LinkButton>
                        <asp:LinkButton runat="server" CommandName="Cancel" Text="Cancel" ID="CancelButton" CssClass="btn btn-danger"><span class="glyphicon glyphicon-remove"></span> Cancel</asp:LinkButton>
                    </div>
                </div>
            </div>
        </InsertItemTemplate>
        <ItemTemplate>
            <div runat="server" style="" class="col-sm-4">
                <div class="well">
                    <label class="control-label">ID:</label>
                    <asp:Label Text='<%# Eval("SHIFTID") %>' runat="server" ID="SHIFTIDLabel" /><br />
                    <label class="control-label">Shift Name:</label>
                    <asp:Label Text='<%# Eval("SHIFTNAME") %>' runat="server" ID="SHIFTNAMELabel" Font-Bold="true" Font-Size="Large" CssClass="text-info" /><br />
                    <label class="control-label">Shift Start Time:</label>
                    <asp:Label Text='<%# Eval("SHIFTSTART","{0:h:mm tt}" ) %>' runat="server" ID="SHIFTSTARTLabel" CssClass="text-success" Font-Bold="true" DataFormatString="{0:h0:h:mm tt}" /><br />
                    <label class="control-label">Shift End Time:</label>
                    <asp:Label Text='<%# Eval("SHIFTEND","{0:h:mm tt}" ) %>' runat="server" ID="SHIFTENDLabel" CssClass="text-danger" Font-Bold="true" DataFormatString="{0:h0:h:mm tt}" /><br />
                    <label class="control-label">Total-Hours:</label>
                    <asp:Label Text='<%# Eval("SHIFTTOTAL") %>' runat="server" ID="SHIFTTOTALLabel" /><br />
                    <label class="control-label">Shift Color Code:</label><br />
                    <asp:TextBox Text='<%# Eval("SHIFTCOLOR") %>' runat="server" ID="SHIFTCOLORTextBox" TextMode="Color" Enabled="false" CssClass="form-control" />
                    
                    <hr />
                    <div class="text-center">
                        <asp:LinkButton runat="server" CommandName="Edit" Text="Edit" ID="EditButton" CssClass="btn btn-primary"><span class="glyphicon glyphicon-pencil"></span> Edit</asp:LinkButton>
                        <span onclick="return confirm('Are you sure to delete?')">
                            <asp:LinkButton runat="server" CommandName="Delete" Text="Delete" ID="DeleteButton" CssClass="btn btn-danger"><span class="glyphicon glyphicon-trash"></span> Delete</asp:LinkButton>
                        </span>
                    </div>
                </div>
            </div>
        </ItemTemplate>
        <LayoutTemplate>
            <div runat="server">
                <div runat="server">
                    <div runat="server">
                        <div runat="server" id="groupPlaceholderContainer" style="" border="0">
                            <div runat="server" id="groupPlaceholder"></div>
                        </div>
                    </div>
                </div>
                <div runat="server">
                    <div runat="server" style="">
                        <asp:DataPager runat="server" PageSize="6" ID="DataPager2">
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
            <td runat="server" style="">SHIFTID:
                <asp:Label Text='<%# Eval("SHIFTID") %>' runat="server" ID="SHIFTIDLabel" /><br />
                SHIFTNAME:
                <asp:Label Text='<%# Eval("SHIFTNAME") %>' runat="server" ID="SHIFTNAMELabel" /><br />
                SHIFTSTART:
                <asp:Label Text='<%# Eval("SHIFTSTART","{0:h:mm tt}" ) %>' runat="server" ID="SHIFTSTARTLabel" /><br />
                SHIFTEND:
                <asp:Label Text='<%# Eval("SHIFTEND","{0:h:mm tt}" ) %>' runat="server" ID="SHIFTENDLabel" /><br />
                SHIFTTOTAL:
                <asp:Label Text='<%# Eval("SHIFTTOTAL") %>' runat="server" ID="SHIFTTOTALLabel" /><br />
                SHIFTCOLOR:
                <asp:Label Text='<%# Eval("SHIFTCOLOR") %>' runat="server" ID="SHIFTCOLORLabel" /><br />
                <asp:Button runat="server" CommandName="Delete" Text="Delete" ID="DeleteButton" /><br />
                <asp:Button runat="server" CommandName="Edit" Text="Edit" ID="EditButton" /><br />
            </td>
        </SelectedItemTemplate>--%>
    </asp:ListView>
    <asp:SqlDataSource runat="server" ID="DataSourceShift" ConnectionString='<%$ ConnectionStrings:ConnString_WEB_ASSET_DB %>' SelectCommand="SELECT [SHIFTID], [SHIFTNAME], [SHIFTSTART], [SHIFTEND], [SHIFTTOTAL], [SHIFTCOLOR] FROM [SHIFT]" DeleteCommand="DELETE FROM [SHIFT] WHERE [SHIFTID] = @SHIFTID" InsertCommand="INSERT INTO [SHIFT] ([SHIFTNAME], [SHIFTSTART], [SHIFTEND], [SHIFTTOTAL], [SHIFTCOLOR]) VALUES (@SHIFTNAME, @SHIFTSTART, @SHIFTEND, @SHIFTTOTAL, @SHIFTCOLOR)" UpdateCommand="UPDATE [SHIFT] SET [SHIFTNAME] = @SHIFTNAME, [SHIFTSTART] = @SHIFTSTART, [SHIFTEND] = @SHIFTEND, [SHIFTTOTAL] = @SHIFTTOTAL, [SHIFTCOLOR] = @SHIFTCOLOR WHERE [SHIFTID] = @SHIFTID">
        <DeleteParameters>
            <asp:Parameter Name="SHIFTID" Type="Int32"></asp:Parameter>
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="SHIFTNAME" Type="String"></asp:Parameter>
            <asp:Parameter Type="String" Name="SHIFTSTART"></asp:Parameter>
            <asp:Parameter Type="String" Name="SHIFTEND"></asp:Parameter>
            <asp:Parameter Name="SHIFTTOTAL" Type="String"></asp:Parameter>
            <asp:Parameter Name="SHIFTCOLOR" Type="String"></asp:Parameter>
        </InsertParameters>
        <UpdateParameters>
            <asp:Parameter Name="SHIFTNAME" Type="String"></asp:Parameter>
            <asp:Parameter Type="String" Name="SHIFTSTART"></asp:Parameter>
            <asp:Parameter Type="String" Name="SHIFTEND"></asp:Parameter>
            <asp:Parameter Name="SHIFTTOTAL" Type="String"></asp:Parameter>
            <asp:Parameter Name="SHIFTCOLOR" Type="String"></asp:Parameter>
            <asp:Parameter Name="SHIFTID" Type="Int32"></asp:Parameter>
        </UpdateParameters>
    </asp:SqlDataSource>
    <%--<script type="text/javascript">
        $(function () {
            $('#timePickerShiftStart').datetimepicker({
                pickDate: false,
                pick12HourFormat: true,
                format: 'H0:h:mm tt',
            });
            $('#timePickerShiftEnd').datetimepicker({
                pickDate: false,
                pick12HourFormat: true,
                format: 'H0:h:mm tt',
            });
        });
    </script>--%>
    <script type="text/javascript">
        $.validate({
        })
    </script>
</asp:Content>

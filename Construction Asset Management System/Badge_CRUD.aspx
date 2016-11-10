<%@ Page Title="Badge" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Badge_CRUD.aspx.cs" Inherits="Construction_Asset_Management_System.Badge_CRUD" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <link href="Scripts/Date Picker/datepicker.min.css" rel="stylesheet" type="text/css" />
    <script src="Scripts/Date Picker/bootstrap-datepicker.min.js"></script>
    <script src="Scripts/Form Validator/jquery.form-validator.js"></script>
    <link href="Scripts/Form Validator/theme-default.css" rel="stylesheet" type="text/css" />
    <div class="container">
        <div class="col-sm-2">
        </div>
        <div class="col-sm-8">
            <div class="well">
                <asp:Panel ID="Panel1" runat="server">
                    <asp:Image runat="server" CssClass="img-responsive img-thumbnail center-block" AlternateText="Not Available" Width="100" Height="100" ID="_imageWorker" />
                    <div class="row">
                        <h5 class="bg-success" style="padding: 8px">Worker Details</h5>
                        <div class="col-sm-4">
                            <label class="control-label">Worker ID:</label>
                            <asp:Label ID="_labelID" runat="server" CssClass="form-control" />
                        </div>
                        <div class="col-sm-8">
                            <label class="control-label">Worker Name:</label>
                            <asp:DropDownList ID="_dropdownWorker" runat="server" DataSourceID="DataSourceWorkerDDList" DataTextField="WORKERFULLNAME" DataValueField="WORKERID" CssClass="form-control" OnSelectedIndexChanged="_dropdownWorker_SelectedIndexChanged" AutoPostBack="true" AppendDataBoundItems="true" OnPreRender="_dropdownWorker_PreRender"
                                data-validation="required"
                                data-validation-error-msg-required="you must select a worker">
                                <asp:ListItem Value=" "> -- please select a Worker --  </asp:ListItem>
                            </asp:DropDownList>
                            <asp:SqlDataSource runat="server" ID="DataSourceWorkerDDList" ConnectionString='<%$ ConnectionStrings:ConnString_WEB_ASSET_DB %>' SelectCommand="SELECT WORKERID, WORKERLNAME + ', ' + WORKERFNAME AS WORKERFULLNAME FROM WORKER"></asp:SqlDataSource>
                        </div>
                    </div>
                    <div class="row">
                        <h5 class="bg-success" style="padding: 8px">Badge Details</h5>
                        <div class="col-sm-6">
                            <label class="control-label">From:</label>
                            <span class="input-group input-append date" id="datePickerValidFrom">
                                <asp:TextBox ID="_txtValidFrom" runat="server" CssClass="form-control" />
                                <span class="input-group-addon add-on"><span class="glyphicon glyphicon-calendar"></span></span>
                            </span>
                        </div>
                        <div class="col-sm-6">
                            <label class="control-label">To:</label>
                            <span class="input-group input-append date" id="datePickerValidTo">
                                <asp:TextBox ID="_txtValidTo" runat="server" CssClass="form-control" />
                                <span class="input-group-addon add-on"><span class="glyphicon glyphicon-calendar"></span></span>
                            </span>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-sm-6">
                            <label class="control-label">Badge Code:</label>
                            <asp:TextBox ID="_txtBadgeCode" runat="server" CssClass="form-control" Enabled="false" />
                        </div>
                        <div class="col-sm-6">
                            <label class="control-label">Badge Status:</label>
                            <asp:DropDownList ID="_dropdownBadgeStat" runat="server" CssClass="form-control">
                                <asp:ListItem>Available</asp:ListItem>
                                <asp:ListItem>Taken</asp:ListItem>
                                <asp:ListItem>Suspend</asp:ListItem>
                                <asp:ListItem>Dispose</asp:ListItem>
                            </asp:DropDownList>
                        </div>
                    </div>
                    <br />
                    <%--<div class="row text-center">
                        <asp:Image runat="server" CssClass="img-responsive img-thumbnail center-block" AlternateText="Barcode Image"  Height="100" ID="_imageBarcode" />
                    </div>--%>
                </asp:Panel>
                <hr />
                <div class="row">
                    <div class="row col-sm-5 pull-right">
                        <div class="col-xs-6">
                            <asp:Button ID="SaveButton" runat="server" Text="Save" CssClass="btn btn-primary center-block col-sm-12" OnClick="SaveButton_Click" />
                        </div>
                        <div class="col-xs-6">
                            <asp:Button ID="CancelButton" runat="server" Text="Cancel" CssClass="btn btn-danger center-block col-sm-12" OnClientClick=" window.location = '/Badge.aspx';this.form.reset();return false;" />
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-sm-2">
        </div>
    </div>
    <script type="text/javascript">
        $(function () {
            $('#datePickerValidFrom').datepicker({
                format: 'mm/dd/yyyy',
                todayHighlight: true,
                endDate: "today"
            });
            $('#datePickerValidTo').datepicker({
                format: 'mm/dd/yyyy',
                todayHighlight: true,
                startDate: "today"
            });
        });
    </script>
    <script type="text/javascript">
        $.validate()
    </script>
</asp:Content>

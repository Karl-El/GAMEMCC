<%@ Page Title="Trade Handling" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="TradeHandling_CRUD.aspx.cs" Inherits="Construction_Asset_Management_System.images.TradeHandling" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <link href="Content/checkbox.css" rel="stylesheet" type="text/css" />
    <h4 class="well text-center" style="padding: 8px">Worker's Trade Handling</h4>
    <div class="well">
        <div class="row">
            <h4 class="bg-info text-center" style="padding: 8px">Worker Details</h4>
            <p class="col-sm-6">
                <label class="control-label">Worker's Name:</label>
                <asp:DropDownList ID="_dropdownWorkerName" runat="server" AppendDataBoundItems="true" CssClass="form-control" DataSourceID="DataSourceWorkerNameDDList" DataTextField="WORKERFullName" DataValueField="WORKERID" OnSelectedIndexChanged="_dropdownWorkerName_SelectedIndexChanged" AutoPostBack="True" OnPreRender="_dropdownWorkerName_PreRender" >
                    <asp:ListItem Value="0"> -- please select person -- </asp:ListItem>
                </asp:DropDownList>
                <asp:SqlDataSource ID="DataSourceWorkerNameDDList" runat="server" ConnectionString="<%$ ConnectionStrings:ConnString_WEB_ASSET_DB %>" SelectCommand="SELECT [WORKERID], WORKERFNAME+' '+WORKERLNAME AS [WORKERFullName], [LABORTYPEID] FROM [WORKER]">
                    <%--<SelectParameters>
                        <asp:QueryStringParameter Name="WORKERID" QueryStringField="id" Type="Int32" />
                    </SelectParameters>--%>
                </asp:SqlDataSource>
            </p>
            <p class="col-sm-6">
                <label class="control-label">Worker's Career Labor Type:</label>
                <asp:TextBox ID="WorkerLaborTypeTextbox" runat="server" CssClass="form-control" Enabled="false" />
            </p>
        </div>
        <div class="row list-group">
            <h4 class="bg-info text-center" style="padding: 8px">Choose Trade</h4>
            <asp:CheckBoxList ID="_chlbxlistTrade" runat="server" DataSourceID="" DataTextField="TRADENAME" DataValueField="TRADEID" CssClass="checkbox checkbox-info">
                <asp:ListItem></asp:ListItem>
            </asp:CheckBoxList>
            <%--<asp:SqlDataSource ID="DataSourceTradeListChkBxList" runat="server" ConnectionString="<%$ ConnectionStrings:ConnString_WEB_ASSET_DB %>" SelectCommand="SELECT [TRADEID], [TRADENAME], [LABORTYPEID] FROM [TRADE]"></asp:SqlDataSource>--%>

            <asp:SqlDataSource ID="DataSourceTradeChkBxLst" runat="server" ConnectionString="<%$ ConnectionStrings:ConnString_WEB_ASSET_DB %>" DeleteCommand="DELETE FROM [WORKERTRADE] WHERE [WRKRTRADEID] = @WRKRTRADEID" InsertCommand="INSERT INTO [WORKERTRADE] ([WORKERID], [TRADEID]) VALUES (@WORKERID, @TRADEID)" SelectCommand="SELECT [WRKRTRADEID], [WORKERID], [TRADEID] FROM [WORKERTRADE]" UpdateCommand="UPDATE [WORKERTRADE] SET [WORKERID] = @WORKERID, [TRADEID] = @TRADEID WHERE [WRKRTRADEID] = @WRKRTRADEID">
                <DeleteParameters>
                    <asp:Parameter Name="WRKRTRADEID" Type="Int32" />
                </DeleteParameters>
                <InsertParameters>
                    <asp:ControlParameter ControlID="_dropdownWorkerName" Name="WORKERID" PropertyName="SelectedValue" Type="Int32" />
                    <asp:ControlParameter ControlID="_chlbxlistTrade" Name="TRADEID" PropertyName="SelectedValue" Type="Int32" />
                </InsertParameters>
                <UpdateParameters>
                    <asp:Parameter Name="WORKERID" Type="Int32" />
                    <asp:Parameter Name="TRADEID" Type="Int32" />
                    <asp:Parameter Name="WRKRTRADEID" Type="Int32" />
                </UpdateParameters>
            </asp:SqlDataSource>
        </div>
        <hr />
        <div class="row">
            <div class="col-sm-4 pull-right">
                <div class="col-xs-6">
                    <asp:Button ID="SaveButton" runat="server" CommandName="Insert" Text="Save" CssClass="btn btn-primary center-block col-xs-12" OnClick="SaveButton_Click" />
                </div>
                <div class="col-xs-6">
                    <asp:Button ID="CancelButton" runat="server" CommandName="Cancel" Text="Cancel" CssClass="btn btn-danger center-block col-xs-12" OnClientClick=" window.location = '/TradeHandling.aspx';return false;" />
                </div>
            </div>
        </div>
    </div>
</asp:Content>

<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="AvailableWorkerEquip.aspx.cs" Inherits="Construction_Asset_Management_System.AvailableWorkerEquip" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <link href="Content/checkbox.css" rel="stylesheet" type="text/css" />
    <div class="well">
        <div class="row">
            <div class="col-sm-6">
                <h5 class="bg-info text-center" style="padding: 8px">Available Worker</h5>
                <asp:CheckBoxList ID="_chkbxlstAvailWorker" runat="server" CssClass="checkbox checkbox-circle checkbox-info" DataSourceID="DataSourceAvailWorker" DataTextField="WORKERNAME" DataValueField="WORKERNAME" OnPreRender="_chkbxlstAvailWorker_PreRender"></asp:CheckBoxList>
                <asp:SqlDataSource runat="server" ID="DataSourceAvailWorker" ConnectionString='<%$ ConnectionStrings:ConnString_WEB_ASSET_DB %>' SelectCommand="SELECT WORKERFNAME + ' ' + WORKERLNAME AS WORKERNAME FROM WORKER WHERE (ASSWORKER = 'False')"></asp:SqlDataSource>
            </div>
            <div class="col-sm-6">
                <h5 class="bg-success text-center" style="padding: 8px">Available Equipment</h5>
                <asp:CheckBoxList ID="_chkbxlstAvailEquip" runat="server" CssClass="checkbox checkbox-circle checkbox-success" DataSourceID="DataSourceAvailEquip" DataTextField="EQUIPMENTNAME" DataValueField="EQUIPMENTNAME" OnPreRender="_chkbxlstAvailEquip_PreRender"></asp:CheckBoxList>
                <asp:SqlDataSource runat="server" ID="DataSourceAvailEquip" ConnectionString='<%$ ConnectionStrings:ConnString_WEB_ASSET_DB %>' SelectCommand="SELECT EQUIPMENTNAME, STOCK FROM EQUIPMENT WHERE (STOCK > 0)"></asp:SqlDataSource>
            </div>
        </div>
    </div>
</asp:Content>

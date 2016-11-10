<%@ Page Title="Reports" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Reports.aspx.cs" Inherits="Construction_Asset_Management_System.Reports" %>

<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=11.0.0.0, Culture=neutral, PublicKeyToken=89845dcd8080cc91" Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="text-center">
        <rsweb:ReportViewer ID="_reportviewEquip" runat="server" Font-Names="Verdana" Font-Size="8pt" WaitMessageFont-Names="Verdana" WaitMessageFont-Size="14pt" DocumentMapWidth="100%" Width="100%" Height="500px" SizeToReportContent="False">
            <LocalReport ReportPath="Equipment.rdlc">
                <DataSources>
                    <rsweb:ReportDataSource Name="EquipmentDataSet" DataSourceId="datasetEquipment"></rsweb:ReportDataSource>
                </DataSources>
            </LocalReport>
        </rsweb:ReportViewer>
        <asp:ObjectDataSource runat="server" ID="datasetEquipment" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="Construction_Asset_Management_System.datasetEquipmentTableAdapters.EQUIPMENTTableAdapter"></asp:ObjectDataSource>
    </div>

    <rsweb:ReportViewer ID="_reportviewWorker" runat="server" Font-Names="Verdana" Font-Size="8pt" WaitMessageFont-Names="Verdana" WaitMessageFont-Size="14pt" DocumentMapWidth="100%" Width="100%" Height="500px" SizeToReportContent="False">
        <LocalReport ReportPath="Worker.rdlc">
            <DataSources>
                <rsweb:ReportDataSource Name="WorkerDataSet" DataSourceId="datasetWorker"></rsweb:ReportDataSource>
            </DataSources>
        </LocalReport>
    </rsweb:ReportViewer>
    <asp:ObjectDataSource runat="server" SelectMethod="GetData" TypeName="Construction_Asset_Management_System.datasetWorkerTableAdapters.WORKERTableAdapter" ID="datasetWorker" OldValuesParameterFormatString="original_{0}"></asp:ObjectDataSource>

    <rsweb:ReportViewer ID="_reportviewProject" runat="server" Font-Names="Verdana" Font-Size="8pt" WaitMessageFont-Names="Verdana" WaitMessageFont-Size="14pt" DocumentMapWidth="100%" Width="100%" Height="500px" SizeToReportContent="False">
        <LocalReport ReportPath="Project.rdlc">
            <DataSources>
                <rsweb:ReportDataSource Name="ProjectDataSet" DataSourceId="datasetProject"></rsweb:ReportDataSource>
            </DataSources>
        </LocalReport>
    </rsweb:ReportViewer>
    <asp:ObjectDataSource runat="server" ID="datasetProject" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="Construction_Asset_Management_System.ProjectTableAdapters.PROJECTTableAdapter"></asp:ObjectDataSource>
</asp:Content>

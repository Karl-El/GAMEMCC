<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="View_Gdata.aspx.cs" Inherits="Construction_Asset_Management_System.View_Gdata" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <asp:Label ID="MyLiteral" Runat="server" ></asp:Label>
<div>
<br />
<asp:Repeater ID="rptr" Runat="server">
<HeaderTemplate>
<table>
<thead>
<tr>
<th>Enquiry ID</th>
<th>Name</th>
<th>Moblie</th>
<th>Area</th>
</tr>
</thead>
<tbody>
</HeaderTemplate>
<ItemTemplate>
<tr>
<td><%#Eval("WorkerID").ToString()%></td>
<td><%#Eval("Type").ToString()%> </td>
<td><%#Eval("Project").ToString()%></td>
<td><%#Eval("Timestamp").ToString()%></td>
</tr>
</ItemTemplate>
<footertemplate>
</tbody>
</table>
</footertemplate>
</asp:Repeater>
</div>
</asp:Content>

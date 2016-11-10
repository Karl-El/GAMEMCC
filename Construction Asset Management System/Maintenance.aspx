<%@ Page Title="Maintenance" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Maintenance.aspx.cs" Inherits="Construction_Asset_Management_System.fonts.Maintenance" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <link href="../Content/font-awesome.css" rel="stylesheet" type="text/css" />
    <%--<link href="Content/maintenancesite.css" rel="stylesheet" type="text/css">
    <link href="Content/maintenancedarkly.css" rel="stylesheet" type="text/css">--%>
    <div class="col-sm-2">
    </div>
    <div class="col-sm-8">
        <div class="row">
            <%--<h2 class="well text-center" style="padding: 8px">Maintenance</h2>--%>
            <div class="col-sm-4">
                <a href="Client.aspx">
                    <div class="well text-center" style="background-color: rgb(0, 148, 255); color: rgb(75, 75, 75)">
                        <i class="fa fa-building fa-4x"></i>
                        <p style="color: rgb(75, 75, 75); font-size: 17px; font-weight: 700">Client</p>
                    </div>
                </a>
                <a href="ClientStaff.aspx">
                    <div class="well text-center" style="background-color: rgb(170, 204, 84); color: rgb(75, 75, 75)">
                        <i class="fa fa-black-tie fa-4x"></i>
                        <p style="color: rgb(75, 75, 75); font-size: 17px; font-weight: 700">Client Staff</p>
                    </div>
                </a>
                <a href="Worker.aspx">
                    <div class="well text-center" style="background-color: rgb(251, 255, 75); color: rgb(75, 75, 75)">
                        <i class="fa fa-suitcase fa-4x"></i>
                        <p style="color: rgb(75, 75, 75); font-size: 17px; font-weight: 700">Worker</p>
                    </div>
                </a>
                <%--<a href="Material.aspx">
                    <div class="well text-center" style="background-color: rgb(250, 90, 90); color: rgb(75, 75, 75)">
                        <p style="color: rgb(75, 75, 75); font-size: 17px; font-weight: 700">Material</p>
                        <i class="fa fa fa-balance-scale  fa-4x"></i>
                    </div>
                </a>--%>
            </div>

            <div class="col-sm-4">
                <a href="Shift.aspx">
                    <div class="well text-center" style="background-color: rgb(250, 90, 90); color: rgb(75, 75, 75)">
                        <i class="fa fa-spinner fa-pulse fa-4x"></i>
                        <p style="color: rgb(75, 75, 75); font-size: 17px; font-weight: 700">Shift</p>
                    </div>
                </a>
                <a href="Trade.aspx">
                    <div class="well text-center" style="background-color: rgb(254, 177, 94); color: rgb(75, 75, 75)">
                        <p style="color: rgb(75, 75, 75); font-size: 17px; font-weight: 700">Trade</p>
                        <i class="fa fa-hand-peace-o fa-4x"></i>
                    </div>
                </a>
                <a href="Badge.aspx">
                    <div class="well text-center" style="background-color: rgb(215, 75, 242); color: rgb(75, 75, 75)">
                        <p style="color: rgb(75, 75, 75); font-size: 17px; font-weight: 700">Badge</p>
                        <i class="fa fa-qrcode fa-4x"></i>
                    </div>
                </a>
            </div>


            <div class="col-sm-4">
                <a href="Equipment.aspx">
                    <div class="well text-center" style="background-color: rgb(85, 179, 250); color: rgb(75, 75, 75)">
                        <i class="fa fa-truck fa-4x"></i>
                        <p style="color: rgb(75, 75, 75); font-size: 17px; font-weight: 700">Equipment</p>
                    </div>
                </a>
                <a href="EquipmentCategory.aspx">
                    <div class="well text-center" style="background-color: rgb(75, 174, 196); color: rgb(75, 75, 75)">
                        <i class="fa fa-plug fa-4x"></i>
                        <p style="color: rgb(75, 75, 75); font-size: 17px; font-weight: 700">Equip. Category</p>
                    </div>
                </a>
                <a href="CompanyStaff.aspx">
                    <div class="well text-center" style="background-color: rgb(119, 213, 87); color: rgb(75, 75, 75)">
                        <i class="fa fa-briefcase fa-4x"></i>
                        <p style="color: rgb(75, 75, 75); font-size: 17px; font-weight: 700">Company Staff</p>
                    </div>
                </a>
                <%--<a href="MaterialCategory.aspx">
                    <div class="well text-center" style="background-color: rgb(175, 248, 54); color: rgb(75, 75, 75)">
                        <p style="color: rgb(75, 75, 75); font-size: 17px; font-weight: 700">Material Category</p>
                        <i class="fa fa-eyedropper  fa-4x"></i>
                    </div>
                </a>--%>
            </div>
        </div>
    </div>
    <div class="col-sm-2">
    </div>


</asp:Content>

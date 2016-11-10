<%@ Page Title="Transaction" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Transaction.aspx.cs" Inherits="Construction_Asset_Management_System.Transaction" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <link href="../Content/font-awesome.css" rel="stylesheet" type="text/css" />
    <%--<link href="Content/transactionsite.css" rel="stylesheet" type="text/css">
    <link href="Content/transactiondarkly.css" rel="stylesheet" type="text/css">--%>
    <div class="col-sm-2">
    </div>
    <div class="col-sm-8">
        <div class="row">
            <%--<h2 class="well text-center" style="padding: 8px">Transaction</h2>--%>
            <div class="col-sm-4">
                <a href="Project.aspx">
                    <div class="well text-center" style="background-color: rgb(15, 145, 239); color: rgb(75, 75, 75)">
                        <i class="fa fa-newspaper-o  fa-4x"></i>
                        <p style="color: rgb(75, 75, 75); font-size: 17px; font-weight: 700">Inquire Project</p>
                    </div>
                </a>
                <a href="TradeHandling.aspx">
                    <div class="well text-center" style="background-color: rgb(157, 204, 239); color: rgb(75, 75, 75)">
                        <i class="fa fa-hand-paper-o fa-4x"></i>
                        <p style="color: rgb(75, 75, 75); font-size: 17px; font-weight: 700">Trade Handling</p>
                    </div>
                </a>

            </div>
            <div class="col-sm-4">
                <a href="ProjectRequirement.aspx">
                    <div class="well text-center" style="background-color: rgb(246, 186, 77); color: rgb(75, 75, 75)">
                        <i class="fa fa-list-ol fa-4x"></i>
                        <p style="color: rgb(75, 75, 75); font-size: 17px; font-weight: 700">Project Requirement</p>
                    </div>
                </a>
                <a href="AttendanceMenu.aspx" id="AttendMenu">
                    <div class="well text-center" style="background-color: rgb(250, 90, 90); color: rgb(75, 75, 75)">
                        <i class="fa fa-calendar fa-4x"></i>
                        <p style="color: rgb(75, 75, 75); font-size: 17px; font-weight: 700">Attendance</p>
                    </div>
                </a>

                <%--<div class="modal fade" id="AttendModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
                    <div class="modal-dialog" role="document">
                        <div class="modal-content">
                            <div class="modal-header">
                                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                                <h4 class="modal-title" id="myModalLabel">Attendance</h4>
                            </div>
                            <div class="modal-body">   
                            </div>
                            <div class="modal-footer">
                                <div class="col-sm-2">
                                </div>
                                <div class="col-sm-4">
                                    <div class="well text-center" style="background-color: rgb(55, 209, 75); color: rgb(75, 75, 75)">
                                        <i class="fa fa-refresh fa-spin fa-4x"></i>
                                        <p style="color: rgb(75, 75, 75); font-size: 17px; font-weight: 700"></p>
                                        <asp:LinkButton ID="LinkButton1" runat="server" ForeColor="#4b4b4d" Font-Bold="true" Font-Size="17px">Sync Attendance</asp:LinkButton>
                                    </div>
                                </div>
                                <div class="col-sm-4">
                                    <a href="AttendanceSheet.aspx">
                                        <div class="well text-center" style="background-color: rgb(0, 148, 255); color: rgb(75, 75, 75)">
                                            <i class="fa fa-building fa-4x"></i>
                                            <p style="color: rgb(75, 75, 75); font-size: 17px; font-weight: 700">Attendance Sheet</p>
                                        </div>
                                    </a>
                                </div>
                                <asp:UpdateProgress ID="UpdateProgress1" runat="server">

                                </asp:UpdateProgress>
                            </div>
                        </div>
                    </div>
                </div>--%>

            </div>
            <div class="col-sm-4">
                <a href="ProjectSpecification.aspx">
                    <div class="well text-center" style="background-color: rgb(242, 242, 92); color: rgb(75, 75, 75)">
                        <i class="fa fa-check-square-o fa-4x"></i>
                        <p style="color: rgb(75, 75, 75); font-size: 17px; font-weight: 700">Project Specification</p>
                    </div>
                </a>
                <a href="EquipmentStash.aspx">
                    <div class="well text-center" style="background-color: rgb(154, 245, 124); color: rgb(75, 75, 75)">
                        <i class="fa fa-wrench fa-4x"></i>
                        <p style="color: rgb(75, 75, 75); font-size: 17px; font-weight: 700">Equipment Stash</p>
                    </div>
                </a>
            </div>
        </div>
    </div>
    <div class="col-sm-2">
    </div>

</asp:Content>

<%@ Page Title="Attendance" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="AttendanceMenu.aspx.cs" Inherits="Construction_Asset_Management_System.AttendanceMenu" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <link href="../Content/font-awesome.css" rel="stylesheet" type="text/css" />
    <div class="col-sm-2">
    </div>
    <div class="col-sm-8">
        <div class="col-sm-2">
        </div>
        <div class="col-sm-4">
            <a data-toggle="modal" href="#myModal">
                <div class="well text-center" style="background-color: rgb(55, 209, 75); color: rgb(75, 75, 75)">
                    <i class="fa fa-refresh fa-spin fa-4x"></i>
                    <p style="color: rgb(75, 75, 75); font-size: 17px; font-weight: 700">Sync Attendance</p>
                    <%--<asp:LinkButton ID="LinkButton1" runat="server" ForeColor="#4b4b4d" Font-Bold="true" Font-Size="17px">Sync Attendance</asp:LinkButton>--%>
                </div>
            </a>
        </div>
        <div class="col-sm-4">
            <a href="AttendanceSheet.aspx">
                <div class="well text-center" style="background-color: rgb(0, 148, 255); color: rgb(75, 75, 75)">
                    <i class="fa fa-building fa-4x"></i>
                    <p style="color: rgb(75, 75, 75); font-size: 17px; font-weight: 700">Attendance Sheet</p>
                </div>
            </a>
        </div>
        <div class="col-sm-2">
        </div>
    </div>
    <div class="col-sm-2">
    </div>

    <div id="myModal" class="modal fade">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                   <%-- <button type="button" class="close" data-dismiss="modal" aria-hidden="true">x</button>--%>
                    <h4>Syncing...</h4>
                    <div class="progress progress-striped active">
                        <div class="progress-bar" style="width: 100%">
                        </div>
                    </div>
                    <div class="text-center">
                        <%--<i class="fa fa-refresh fa-spin fa-4x"></i>--%>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <script>
        $(function () {
            $('#myModal').on('show.bs.modal', function () {
                var myModal = $(this);
                clearTimeout(myModal.data('hideInterval'));
                myModal.data('hideInterval', setTimeout(function () {
                    myModal.modal('hide');
                }, 5000));
            });
        });
    </script>
</asp:Content>

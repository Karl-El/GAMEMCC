<%@ Page Title="About" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="About.aspx.cs" Inherits="Construction_Asset_Management_System.About" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <div class="well">
        <!-- START THE FEATURETTES -->

        <div class="row">
            <div class="col-md-7">
                <h2 class="featurette-heading">Asset Management. <%--<span class="text-muted">It'll blow your mind.</span>--%></h2>
                <p class="lead">A construction company delivers construction projects and services that meet the local and international standard. They keep their track on their employees performing a specific job on a site they were assigned. Most company currently uses manual forms as a way of transaction. They maintain their inventory on logbook for tracking and monitoring purposes.</p>
            </div>
            <div class="col-md-5">
                <asp:Image ID="Image3" runat="server" class="featurette-image img-responsive center-block" ImageUrl="~/images/backhoe.png" />
            </div>
        </div>

        <div class="row">
            <div class="col-md-7 col-md-push-5">
                <h2 class="featurette-heading">Attedance Monitoring.<%-- <span class="text-muted">See for yourself.</span>--%></h2>
                <p class="lead">This system handles most of the recording tasks, therefore reduces the effort and increases the efficiency of the person who manages the company’s staff attendance..</p>
            </div>
            <div class="col-md-5 col-md-pull-7">
                <asp:Image ID="Image1" runat="server" class="featurette-image img-responsive center-block" ImageUrl="~/images/attend.png" />
            </div>
        </div>

        <%--<div class="row">
            <div class="col-md-7">
                <h2 class="featurette-heading">And lastly, this one. <span class="text-muted">Checkmate.</span></h2>
                <p class="lead">Donec ullamcorper nulla non metus auctor fringilla. Vestibulum id ligula porta felis euismod semper. Praesent commodo cursus magna, vel scelerisque nisl consectetur. Fusce dapibus, tellus ac cursus commodo.</p>
            </div>
            <div class="col-md-5">
                <asp:Image ID="Image2" runat="server" class="featurette-image img-responsive center-block" ImageUrl="~/images/tools.jpg" />
            </div>
        </div>--%>

        <!-- /END THE FEATURETTES -->
    </div>
</asp:Content>

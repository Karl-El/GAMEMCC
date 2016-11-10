<%@ Page Title="Project Requirement" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ProjectRequirement.aspx.cs" Inherits="Construction_Asset_Management_System.ProjectRequirement" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <h4 class="well text-center" style="padding: 8px">Project Requirement List</h4>
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
            <%--<asp:LinkButton runat="server" ID="_btnNoReq" CssClass="btn btn-info" Visible="false" OnClick="_btnNoReq_Click"><span class="glyphicon glyphicon-list-alt"></span> Show Full List</asp:LinkButton>--%>
        </div>
    </div>
    <br />
    <asp:ListView ID="_listviewProjReq" runat="server" DataSourceID="DataSourceProjReq" GroupItemCount="2" OnItemDataBound="_listviewProjReq_ItemDataBound" OnItemCommand="_listviewProjReq_ItemCommand">
        <%--<AlternatingItemTemplate>
            <td runat="server" style="">CLIENTPROJECT:
                <asp:Label Text='<%# Eval("CLIENTPROJECT") %>' runat="server" ID="CLIENTPROJECTLabel" /><br />
                PROJSITE:
                <asp:Label Text='<%# Eval("PROJSITE") %>' runat="server" ID="PROJSITELabel" /><br />
                PROJAPPR:
                <asp:Label Text='<%# Eval("PROJAPPR") %>' runat="server" ID="PROJAPPRLabel" /><br />
            </td>
        </AlternatingItemTemplate>
        <EditItemTemplate>
            <td runat="server" style="">CLIENTPROJECT:
                <asp:TextBox Text='<%# Bind("CLIENTPROJECT") %>' runat="server" ID="CLIENTPROJECTTextBox" /><br />
                PROJSITE:
                <asp:TextBox Text='<%# Bind("PROJSITE") %>' runat="server" ID="PROJSITETextBox" /><br />
                PROJAPPR:
                <asp:TextBox Text='<%# Bind("PROJAPPR") %>' runat="server" ID="PROJAPPRTextBox" /><br />
                <asp:Button runat="server" CommandName="Update" Text="Update" ID="UpdateButton" /><br />
                <asp:Button runat="server" CommandName="Cancel" Text="Cancel" ID="CancelButton" /><br />
            </td>
        </EditItemTemplate>--%>
        <EmptyDataTemplate>
            <div runat="server" style="">
                <div>
                    <div>No data was returned.</div>
                </div>
            </div>
        </EmptyDataTemplate>
        <%--<EmptyItemTemplate>
            <td runat="server" />
        </EmptyItemTemplate>--%>
        <GroupTemplate>
            <div runat="server" id="itemPlaceholderContainer">
                <div runat="server" id="itemPlaceholder"></div>
            </div>
        </GroupTemplate>
        <%--<InsertItemTemplate>
            <td runat="server" style="">CLIENTPROJECT:
                <asp:TextBox Text='<%# Bind("CLIENTPROJECT") %>' runat="server" ID="CLIENTPROJECTTextBox" /><br />
                PROJSITE:
                <asp:TextBox Text='<%# Bind("PROJSITE") %>' runat="server" ID="PROJSITETextBox" /><br />
                PROJAPPR:
                <asp:TextBox Text='<%# Bind("PROJAPPR") %>' runat="server" ID="PROJAPPRTextBox" /><br />
                <asp:Button runat="server" CommandName="Insert" Text="Insert" ID="InsertButton" /><br />
                <asp:Button runat="server" CommandName="Cancel" Text="Clear" ID="CancelButton" /><br />
            </td>
        </InsertItemTemplate>--%>
        <ItemTemplate>
            <div class="col-sm-12">
                <asp:Panel ID="Panel1" runat="server">
                    <div runat="server" style="" class="well">
                        <label class="control-label">ID:</label>
                        <asp:Label Text='<%# Eval("PROJID") %>' runat="server" ID="PROJIDLabel" /><br />
                        <%--<label class="control-label">Client & Project Title:</label>--%>
                        <asp:Label Font-Size="X-Large" Font-Bold="true" CssClass="" Text='<%# Eval("CLIENTPROJECT") %>' runat="server" ID="CLIENTPROJECTLabel" ForeColor="#ffffcc" /><br />
                        <label class="control-label">Project Site/ Address:</label>
                        <asp:Label Text='<%# Eval("PROJSITE") %>' runat="server" ID="PROJSITELabel" /><br />
                        <label class="control-label">Date Approved:</label>
                        <asp:Label Text='<%# Eval("PROJAPPR","{0:MMMM dd, yyyy}") %>' runat="server" ID="PROJAPPRLabel" /><br />
                        <label class="control-label">Attachments:</label>
                        <asp:Label ID="PROJATTACHLabel" runat="server" Text='<%# Eval("PROJATTACH") %>' />
                        <asp:LinkButton ID="_linkbtnDownload" runat="server" CommandName="DownloadFile">Download File</asp:LinkButton>
                        <div class="row">
                            <div class="col-sm-6">
                                <h5 class="bg-primary text-center" style="padding: 8px">Worker Trade Needed</h5>
                                <asp:BulletedList ID="_bulletlistProjTrade" runat="server" DataSourceID="DataSourceProjTradeTOTAL" DataTextField="PROJTRADEQUANT" Height="100%" BulletStyle="Square"></asp:BulletedList>
                                <asp:SqlDataSource runat="server" ID="DataSourceProjTradeTOTAL" ConnectionString='<%$ ConnectionStrings:ConnString_WEB_ASSET_DB %>' SelectCommand="SELECT CAST(PROJREQTRADE.TRADEQUANTITY AS VARCHAR(10)) + '  -  ' + TRADE.TRADENAME AS [PROJTRADEQUANT] FROM PROJREQTRADE INNER JOIN TRADE ON PROJREQTRADE.TRADEID = TRADE.TRADEID WHERE (PROJREQTRADE.PROJID = @PROJID)">
                                    <SelectParameters>
                                        <asp:ControlParameter ControlID="PROJIDLabel" PropertyName="Text" Name="PROJID"></asp:ControlParameter>
                                    </SelectParameters>
                                </asp:SqlDataSource>
                                <asp:Label ID="Label1" runat="server" Text="Label" CssClass="text-info" Font-Size="Larger">Total Worker Needed:</asp:Label>
                                <asp:Label ID="_labelTotalTrade" runat="server" Text="Label" CssClass="text-danger" Font-Size="Larger" Font-Bold="true"></asp:Label>
                            </div>
                            <div class="col-sm-6">
                                <h5 class="bg-primary text-center" style="padding: 8px">Equipment Needed</h5>
                                <asp:BulletedList ID="_bulletlistProjEquip" runat="server" DataSourceID="DataSourceProjEquipTOTAL" DataTextField="PROJEQUIPQUANT" Height="100%" BulletStyle="Square"></asp:BulletedList>
                                <asp:SqlDataSource runat="server" ID="DataSourceProjEquipTOTAL" ConnectionString='<%$ ConnectionStrings:ConnString_WEB_ASSET_DB %>' SelectCommand="SELECT CAST(PROJREQEQUIP.EQUIPQUANTITY AS VARCHAR(10)) + '  -  ' + EQUIPMENT.EQUIPMENTNAME AS PROJEQUIPQUANT FROM EQUIPMENT INNER JOIN PROJREQEQUIP ON EQUIPMENT.EQUIPMENTID = PROJREQEQUIP.EQUIPMENTID WHERE (PROJREQEQUIP.PROJID = @PROJID)">
                                    <SelectParameters>
                                        <asp:ControlParameter ControlID="PROJIDLabel" PropertyName="Text" Name="PROJID"></asp:ControlParameter>
                                    </SelectParameters>
                                </asp:SqlDataSource>
                                <asp:Label ID="Label2" runat="server" Text="Label" CssClass="text-info" Font-Size="Larger">Total Equipment Needed:</asp:Label>
                                <asp:Label ID="_labelTotalEquip" runat="server" Text="Label" CssClass="text-danger" Font-Size="Larger" Font-Bold="true"></asp:Label>
                            </div>
                        </div>
                        <hr />
                        <div class="text-center">
                            <asp:HyperLink ID="_hyperlinkProjectEdit" runat="server" NavigateUrl='<%#"~/Project_CRUD.aspx?id="+Eval("PROJID") %>' CssClass="btn btn-link">Edit Project</asp:HyperLink>
                            <asp:HyperLink ID="_hyperlinkRequireEdit" runat="server" NavigateUrl='<%#"~/ProjectRequirement_CRUD.aspx?id="+Eval("PROJID") %>' Text="" CssClass="btn btn-link"></asp:HyperLink>
                        </div>
                    </div>
                </asp:Panel>
            </div>
        </ItemTemplate>
        <LayoutTemplate>
            <div runat="server">
                <div runat="server">
                    <div runat="server">
                        <div runat="server" id="groupPlaceholderContainer" style="" border="0">
                            <tr runat="server" id="groupPlaceholder"></tr>
                        </div>
                    </div>
                </div>
                <div runat="server">
                    <div runat="server" style="">
                        <asp:DataPager ID="DataPager1" runat="server" PageSize="6">
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
            <td runat="server" style="">CLIENTPROJECT:
                <asp:Label Text='<%# Eval("CLIENTPROJECT") %>' runat="server" ID="CLIENTPROJECTLabel" /><br />
                PROJSITE:
                <asp:Label Text='<%# Eval("PROJSITE") %>' runat="server" ID="PROJSITELabel" /><br />
                PROJAPPR:
                <asp:Label Text='<%# Eval("PROJAPPR") %>' runat="server" ID="PROJAPPRLabel" /><br />
            </td>
        </SelectedItemTemplate>--%>
    </asp:ListView>
    <asp:SqlDataSource runat="server" ID="DataSourceProjReq" ConnectionString='<%$ ConnectionStrings:ConnString_WEB_ASSET_DB %>' SelectCommand="SELECT PROJECT.PROJID, PROJECT.PROJATTACH, CLIENT.CLIENTNAME + ', ' + PROJECT.PROJNAME AS 'CLIENTPROJECT', PROJECT.PROJSITE, PROJECT.PROJAPPR FROM CLIENT INNER JOIN PROJECT ON CLIENT.CLIENTID = PROJECT.CLIENTID"></asp:SqlDataSource>
</asp:Content>

<%@ Page Title="Equipment on Project" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="EquipmentProject.aspx.cs" Inherits="Construction_Asset_Management_System.EquipmentProject" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <asp:ListView ID="_listviewEquipProject" runat="server" DataSourceID="DataSourcEquipProject" GroupItemCount="3" OnItemDataBound="_listviewEquipProject_ItemDataBound">
        <AlternatingItemTemplate>
            <div class="col-sm-12">
                <div runat="server" class="well" style="background-color: rgba(0, 0, 0, 0.66); color: white">
                    <div class="row">
                        <div class="col-sm-3">
                            <asp:Label Text='<%# Eval("EQUIPMENTID") %>' runat="server" ID="EQUIPMENTIDLabel"  Visible="false"/><br />
                            <asp:Image runat="server" ImageUrl='<%# Eval("EQUIPMENTIMG") %>' CssClass="img-responsive img-thumbnail center-block" AlternateText="Not Available" Width="100" Height="100" />
                            <%--<asp:Label Text='<%# Eval("EQUIPMENTIMG") %>' runat="server" ID="EQUIPMENTIMGLabel" /><br />--%>
                            <asp:Label Font-Size="X-Large" Font-Bold="true" CssClass="text-primary" Text='<%# Eval("EQUIPMENTNAME") %>' runat="server" ID="EQUIPMENTNAMELabel" /><br />
                            <label class="control-label">Total Stock:</label>
                            <asp:Label Text='<%# Eval("QUANTITY") %>' runat="server" ID="QUANTITYLabel" /><br />
                            <label class="control-label">Remaining Stock:</label>
                            <asp:Label Text='<%# Eval("STOCK") %>' runat="server" ID="STOCKLabel" /><br />
                            <label class="control-label">On Project:</label>
                            <asp:Label ID="_labelAssEquip" runat="server" Text="Label"></asp:Label>
                        </div>
                        <div class="col-sm-9">
                            <h5 class="bg-success text-center" style="padding: 8px">Project List</h5>
                            <asp:BulletedList ID="_bulletlistEquipProj" runat="server" Height="100%" DataSourceID="DataSourceEquipProjBulletLst" DataTextField="CLIENTPROJECT"></asp:BulletedList>
                            <asp:SqlDataSource runat="server" ID="DataSourceEquipProjBulletLst" ConnectionString='<%$ ConnectionStrings:ConnString_WEB_ASSET_DB %>' SelectCommand="SELECT ASSIGNEDEQUIP.ASSEQUIPQUANT + ' - ' + CLIENT.CLIENTNAME + ' - ' + PROJECT.PROJNAME AS CLIENTPROJECT FROM ASSIGNEDEQUIP INNER JOIN PROJECT ON ASSIGNEDEQUIP.PROJID = PROJECT.PROJID INNER JOIN CLIENT ON PROJECT.CLIENTID = CLIENT.CLIENTID WHERE (ASSIGNEDEQUIP.EQUIPMENTID = @EQUIPMENTID)">
                                <SelectParameters>
                                    <asp:ControlParameter ControlID="EQUIPMENTIDLabel" PropertyName="Text" Name="EQUIPMENTID"></asp:ControlParameter>
                                </SelectParameters>
                            </asp:SqlDataSource>
                        </div>
                    </div>
                </div>
            </div>
        </AlternatingItemTemplate>
        <%--<EditItemTemplate>
            <td runat="server" style="">EQUIPMENTNAME:
                <asp:TextBox Text='<%# Bind("EQUIPMENTNAME") %>' runat="server" ID="EQUIPMENTNAMETextBox" /><br />
                EQUIPMENTIMG:
                <asp:TextBox Text='<%# Bind("EQUIPMENTIMG") %>' runat="server" ID="EQUIPMENTIMGTextBox" /><br />
                QUANTITY:
                <asp:TextBox Text='<%# Bind("QUANTITY") %>' runat="server" ID="QUANTITYTextBox" /><br />
                STOCK:
                <asp:TextBox Text='<%# Bind("STOCK") %>' runat="server" ID="STOCKTextBox" /><br />
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
        <EmptyItemTemplate>
            <td runat="server" />
        </EmptyItemTemplate>
        <GroupTemplate>
            <div runat="server" id="itemPlaceholderContainer">
                <td runat="server" id="itemPlaceholder"></td>
            </div>
        </GroupTemplate>
        <%--<InsertItemTemplate>
            <td runat="server" style="">EQUIPMENTNAME:
                <asp:TextBox Text='<%# Bind("EQUIPMENTNAME") %>' runat="server" ID="EQUIPMENTNAMETextBox" /><br />
                EQUIPMENTIMG:
                <asp:TextBox Text='<%# Bind("EQUIPMENTIMG") %>' runat="server" ID="EQUIPMENTIMGTextBox" /><br />
                QUANTITY:
                <asp:TextBox Text='<%# Bind("QUANTITY") %>' runat="server" ID="QUANTITYTextBox" /><br />
                STOCK:
                <asp:TextBox Text='<%# Bind("STOCK") %>' runat="server" ID="STOCKTextBox" /><br />
                <asp:Button runat="server" CommandName="Insert" Text="Insert" ID="InsertButton" /><br />
                <asp:Button runat="server" CommandName="Cancel" Text="Clear" ID="CancelButton" /><br />
            </td>
        </InsertItemTemplate>--%>
        <ItemTemplate>
            <div class="col-sm-12">
                <div runat="server" class="well" style="background-color: rgba(255, 255, 255, 0.66); color: black">
                    <div class="row">
                        <div class="col-sm-3">
                            <asp:Label Text='<%# Eval("EQUIPMENTID") %>' runat="server" ID="EQUIPMENTIDLabel"  Visible="false"/><br />
                            <asp:Image runat="server" ImageUrl='<%# Eval("EQUIPMENTIMG") %>' CssClass="img-responsive img-thumbnail center-block" AlternateText="Not Available" Width="100" Height="100" />
                            <%--<asp:Label Text='<%# Eval("EQUIPMENTIMG") %>' runat="server" ID="EQUIPMENTIMGLabel" /><br />--%>
                            <asp:Label Font-Size="X-Large" Font-Bold="true" CssClass="text-primary" Text='<%# Eval("EQUIPMENTNAME") %>' runat="server" ID="EQUIPMENTNAMELabel" /><br />
                            <label class="control-label">Total Stock:</label>
                            <asp:Label Text='<%# Eval("QUANTITY") %>' runat="server" ID="QUANTITYLabel" /><br />
                            <label class="control-label">Remaining Stock:</label>
                            <asp:Label Text='<%# Eval("STOCK") %>' runat="server" ID="STOCKLabel" /><br />
                            <label class="control-label">On Project:</label>
                            <asp:Label ID="_labelAssEquip" runat="server" Text="Label"></asp:Label>
                        </div>
                        <div class="col-sm-9">
                            <h5 class="bg-success text-center" style="padding: 8px">Project List</h5>
                            <asp:BulletedList ID="_bulletlistEquipProj" runat="server" Height="100%" DataSourceID="DataSourceEquipProjBulletLst" DataTextField="CLIENTPROJECT"></asp:BulletedList>
                            <asp:SqlDataSource runat="server" ID="DataSourceEquipProjBulletLst" ConnectionString='<%$ ConnectionStrings:ConnString_WEB_ASSET_DB %>' SelectCommand="SELECT ASSIGNEDEQUIP.ASSEQUIPQUANT + ' - ' + CLIENT.CLIENTNAME + ' - ' + PROJECT.PROJNAME AS CLIENTPROJECT FROM ASSIGNEDEQUIP INNER JOIN PROJECT ON ASSIGNEDEQUIP.PROJID = PROJECT.PROJID INNER JOIN CLIENT ON PROJECT.CLIENTID = CLIENT.CLIENTID WHERE (ASSIGNEDEQUIP.EQUIPMENTID = @EQUIPMENTID)">
                                <SelectParameters>
                                    <asp:ControlParameter ControlID="EQUIPMENTIDLabel" PropertyName="Text" Name="EQUIPMENTID"></asp:ControlParameter>
                                </SelectParameters>
                            </asp:SqlDataSource>
                        </div>
                    </div>
                </div>
            </div>
        </ItemTemplate>
        <LayoutTemplate>
            <div runat="server">
                <div runat="server">
                    <div runat="server">
                        <table runat="server" id="groupPlaceholderContainer" style="" border="0">
                            <tr runat="server" id="groupPlaceholder"></tr>
                        </table>
                    </div>
                </div>
                <div runat="server">
                    <div runat="server" style="">
                        <asp:DataPager runat="server" PageSize="10" ID="DataPager1">
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
            <td runat="server" style="">EQUIPMENTNAME:
                <asp:Label Text='<%# Eval("EQUIPMENTNAME") %>' runat="server" ID="EQUIPMENTNAMELabel" /><br />
                EQUIPMENTIMG:
                <asp:Label Text='<%# Eval("EQUIPMENTIMG") %>' runat="server" ID="EQUIPMENTIMGLabel" /><br />
                QUANTITY:
                <asp:Label Text='<%# Eval("QUANTITY") %>' runat="server" ID="QUANTITYLabel" /><br />
                STOCK:
                <asp:Label Text='<%# Eval("STOCK") %>' runat="server" ID="STOCKLabel" /><br />
            </td>
        </SelectedItemTemplate>--%>
    </asp:ListView>
    <asp:SqlDataSource runat="server" ID="DataSourcEquipProject" ConnectionString='<%$ ConnectionStrings:ConnString_WEB_ASSET_DB %>' SelectCommand="SELECT EQUIPMENTID,EQUIPMENTNAME, EQUIPMENTIMG, QUANTITY, STOCK FROM EQUIPMENT"></asp:SqlDataSource>
</asp:Content>

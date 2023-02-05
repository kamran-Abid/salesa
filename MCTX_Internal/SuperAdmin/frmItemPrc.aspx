<%@ Page Language="C#" MasterPageFile="MasterAdmin.master" AutoEventWireup="true"
    CodeFile="frmItemPrc.aspx.cs" Inherits="MCTX_Internal_SuperAdmin_frmItemPrc"
    Title="MCTX_Pricing Info" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <table style="width: 100%; height: 333px;">
        <tr>
            <td valign="top" style="height: 331px">
                <div id="tabs">
                    <ul>
                        <li style="text-align: left"><a href="#tabs-1">Item pricing Information</a></li>
                    </ul>
                    <div id="tabs-1">
                        <table style="width: 100%">
                            <tr>
                                <td align="left" style="width: 153px">
                                    <b>Select Category:</b>
                                </td>
                                <td style="text-align: left; width: 142px;">
                                    <asp:DropDownList ID="ddlCategories" runat="server" Width="127px">
                                    </asp:DropDownList>
                                </td>
                                <td align="left" style="width: 144px">
                                    <b>Select Item:</b>
                                </td>
                                <td style="text-align: left">
                                    <asp:DropDownList ID="ddlItem" runat="server" Width="128px">
                                    </asp:DropDownList>
                                </td>
                            </tr>
                            <tr>
                                <td align="left" style="width: 153px">
                                    <b>Minimum Price: (PKR) </b>
                                </td>
                                <td style="text-align: left; width: 142px;">
                                    <asp:TextBox ID="txtMinPrice" runat="server"></asp:TextBox>
                                </td>
                                <td align="left" style="width: 144px">
                                    <b>Normal Price: (PKR)</b>
                                </td>
                                <td style="text-align: left">
                                    <asp:TextBox ID="txtNormalPrice" runat="server"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td align="left" style="width: 153px">
                                    <b>Maximum Price: (PKR) </b>
                                </td>
                                <td style="text-align: left; width: 142px;">
                                    <asp:TextBox ID="txtMaxPrice" runat="server"></asp:TextBox>
                                </td>
                                <td align="left" style="width: 144px">
                                    <b>Shipment Reference</b>
                                </td>
                                <td style="text-align: left">
                                    <asp:TextBox ID="txtShipmentRef" runat="server"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td style="width: 153px; text-align: left">
                                    <asp:Button ID="btnSaveUser" runat="server" Text="Save" OnClick="btnSaveUser_Click"
                                        BackColor="#ABD3FC" />
                                    &nbsp;<asp:Button ID="btnCancelUser" runat="server" Text="Cancel" OnClick="btnCancelUser_Click"
                                        BackColor="#ABD3FC" />
                                </td>
                                <td colspan="3" align="left">
                                    <b>
                                        <asp:Label ID="lblMessage" runat="server"></asp:Label>
                                    </b>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="4">
                                    <asp:GridView ID="ItemsPriceGrid" runat="server" AutoGenerateColumns="False" Width="100%"
                                        CellPadding="4" ForeColor="#333333" GridLines="None">
                                        <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
                                        <Columns>
                                            <asp:TemplateField HeaderText="Maximum Price">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblMaxPrice" runat="server" Text='<%#Eval("MaximumPrice") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Normal Price">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblNormalPrice" runat="server" Text='<%#Eval("NormalPrice") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Minimum Price">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblMinPrice" runat="server" Text='<%#Eval("MinimumPrice") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Active">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblActive" runat="server" Text='<%#Eval("Active") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Date Entered">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblDateEntered" runat="server" Text='<%#Eval("item_add_date") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                        </Columns>
                                        <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                                        <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
                                        <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
                                        <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                                        <EditRowStyle BackColor="#999999" />
                                        <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                                    </asp:GridView>
                                </td>
                            </tr>
                        </table>
                    </div>
                </div>
            </td>
        </tr>
    </table>
</asp:Content>

<%@ Page Language="C#" MasterPageFile="MasterAdmin.master" AutoEventWireup="true"
    CodeFile="frmCompany.aspx.cs" Inherits="MCTX_Internal_SuperAdmin_frmCompany"
    Title="Mechatronix Company Info" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <table style="width: 100%; height: 193px;">
        <tr>
            <td valign="top" style="height: 46px">
                <div id="tabs">
                    <ul>
                        <li style="text-align: left"><a href="#tabs-1">Company Information</a></li>
                    </ul>
                    <div id="tabs-1">
                        <table style="width: 100%">
                            <tr>
                                <td style="text-align: left; width: 110px">
                                    <b>Company Name:</b>
                                </td>
                                <td style="text-align: left; width: 155px">
                                    <asp:TextBox ID="txtCompanyName" runat="server"></asp:TextBox>
                                </td>
                                <td style="text-align: left; width: 113px">
                                    <b>Web Address:</b>
                                </td>
                                <td style="text-align: left">
                                    <asp:TextBox ID="txtWebsite" runat="server"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td style="text-align: left; width: 110px">
                                    <b>Country:</b>
                                </td>
                                <td style="text-align: left; width: 155px">
                                    <asp:DropDownList ID="ddlCountry" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddlCountry_SelectedIndexChanged"
                                        Width="126px">
                                    </asp:DropDownList>
                                </td>
                                <td style="text-align: left; width: 113px">
                                    <b>City:</b>
                                </td>
                                <td style="text-align: left">
                                    <asp:DropDownList ID="ddlCity" runat="server" Width="126px">
                                    </asp:DropDownList>
                                </td>
                            </tr>
                            <tr>
                                <td style="text-align: left; width: 110px">
                                    <b>Phone:</b>
                                </td>
                                <td style="text-align: left; width: 155px">
                                    <asp:TextBox ID="txtPhone" runat="server"></asp:TextBox>
                                </td>
                                <td style="text-align: left; width: 113px">
                                    <b>Target Products:</b>
                                </td>
                                <td style="text-align: left">
                                    <asp:TextBox ID="txtMultiproducts" runat="server" Width="122px"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td style="text-align: left; width: 110px">
                                    <b>Address:</b>
                                </td>
                                <td colspan="3" style="text-align: left">
                                    <asp:TextBox ID="txtAddress" runat="server" TextMode="MultiLine" Width="303px" Style="margin-left: 0px"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td style="text-align: left;" colspan="4">
                                    <table style="width: 100%">
                                        <tr>
                                            <td style="width: 188px">
                                                <asp:Button ID="btnSaveUser" runat="server" Text="Save" OnClick="btnSaveUser_Click"
                                                    BackColor="#ABD3FC" />
                                                &nbsp;<asp:Button ID="btnUpdate" runat="server" Text="Update" BackColor="#ABD3FC" />
                                                &nbsp;<asp:Button ID="btnCancelUser" runat="server" Text="Cancel" BackColor="#ABD3FC" />
                                            </td>
                                            <td>
                                                <asp:Label ID="lblmessage" runat="server"></asp:Label>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="4">
                                    <asp:GridView ID="DepartmentGrid" runat="server" AutoGenerateColumns="False" Width="100%"
                                        CellPadding="4" ForeColor="#333333" GridLines="None" Height="66px">
                                        <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
                                        <Columns>
                                            <asp:TemplateField HeaderText="Company Name">
                                                <ItemTemplate>
                                                    <asp:HiddenField ID="hdn" runat="server" Value='<%#Eval("") %>' />
                                                    <asp:Label ID="lblBranchName" runat="server" Text='<%#Eval("") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Website">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblDepartment" runat="server" Text='<%#Eval("") %>'></asp:Label>
                                                </ItemTemplate>
                                                <EditItemTemplate>
                                                    <asp:TextBox ID="txtDepartment" runat="server" Text='<%#Eval("") %>'></asp:TextBox>
                                                </EditItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="	Phone">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblDesignation" runat="server" Text='<%#Eval("") %>'></asp:Label>
                                                </ItemTemplate>
                                                <EditItemTemplate>
                                                    <asp:TextBox ID="txtDesignation" runat="server" Text='<%#Eval("") %>'></asp:TextBox>
                                                </EditItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Edit">
                                                <ItemTemplate>
                                                    <asp:LinkButton ID="lnkEdit" runat="server" Text="Edit" CommandArgument='<%#Eval("") %>'
                                                        CommandName="Edit"></asp:LinkButton>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Delete">
                                                <ItemTemplate>
                                                    <asp:LinkButton ID="lnkDelete" runat="server" Text="Delete" CommandArgument='<%#Eval("") %>'
                                                        CommandName="Delete"></asp:LinkButton>
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

<%@ Page Language="C#" MasterPageFile="MasterAdmin.master" AutoEventWireup="true"
    CodeFile="frmClient.aspx.cs" Inherits="MCTX_Internal_SuperAdmin_frmClient" Title="MCTX Client Info" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <table style="width: 100%; height: 193px;">
        <tr>
            <td valign="top" style="height: 331px">
                <div id="tabs">
                    <ul>
                        <li style="text-align: left"><a href="#tabs-1">Client Information</a></li>
                    </ul>
                    <div id="tabs-1" style="height: 302px">
                        <table style="width: 100%">
                            <tr>
                                <td style="text-align: left; width: 122px">
                                    <b>Client Name:</b>
                                </td>
                                <td style="text-align: left; width: 153px">
                                    <asp:TextBox ID="txtClientName" runat="server"></asp:TextBox>
                                </td>
                                <td style="text-align: left; width: 93px">
                                    <b>Mobile No:</b>
                                </td>
                                <td style="text-align: left">
                                    <asp:TextBox ID="txtMobileNo" runat="server"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td style="width: 122px; text-align: left; height: 21px">
                                    <b>E-mail:</b>
                                </td>
                                <td style="text-align: left; width: 153px; height: 21px">
                                    <asp:TextBox ID="txtEmail" runat="server"></asp:TextBox>
                                </td>
                                <td style="text-align: left; width: 93px; height: 21px">
                                    <b>Phone:</b>
                                </td>
                                <td style="text-align: left; height: 21px">
                                    <asp:TextBox ID="txtPhone" runat="server"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td style="width: 122px; text-align: left">
                                    <b>Company Name:</b>
                                </td>
                                <td style="width: 153px; text-align: left">
                                    <asp:DropDownList ID="ddlCompanyName" runat="server" Width="125px">
                                    </asp:DropDownList>
                                </td>
                                <td style="width: 93px; text-align: left">
                                    <b>Designation:</b>
                                </td>
                                <td style="text-align: left">
                                    <asp:TextBox ID="txtDesignation" runat="server"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td style="width: 122px; text-align: left">
                                    <b>Department:</b>
                                </td>
                                <td style="width: 153px; text-align: left">
                                    <asp:TextBox ID="txtDepartment" runat="server"></asp:TextBox>
                                </td>
                                <td style="width: 93px; text-align: left">
                                    <b>Fax No:</b>
                                </td>
                                <td style="text-align: left">
                                    <asp:TextBox ID="txtFaxNo" runat="server"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td style="width: 122px; text-align: left">
                                    <b>Country:</b>
                                </td>
                                <td style="width: 153px; text-align: left">
                                    <asp:DropDownList ID="ddlCountry" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddlCountry_SelectedIndexChanged1"
                                        Width="125px">
                                    </asp:DropDownList>
                                </td>
                                <td style="width: 93px; text-align: left">
                                    <b>City:</b>
                                </td>
                                <td style="text-align: left">
                                    <asp:DropDownList ID="ddlCity" runat="server" Width="125px">
                                    </asp:DropDownList>
                                </td>
                            </tr>
                            <tr>
                                <td style="width: 122px; text-align: left">
                                    <b>Address:</b>
                                </td>
                                <td colspan="3" style="text-align: left">
                                    <asp:TextBox ID="txtAddress" runat="server" TextMode="MultiLine" Width="254px"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="4">
                                    <table style="width: 100%">
                                        <tr>
                                            <td style="width: 201px; text-align: left">
                                                <asp:Button ID="btnSaveUser" runat="server" Text="Save" OnClick="btnSaveUser_Click"
                                                    BackColor="#ABD3FC" />
                                                &nbsp;
                                                <asp:Button ID="btnUpdate" runat="server" Text="Update" BackColor="#ABD3FC" />
                                                &nbsp;
                                                <asp:Button ID="btnCancelUser" runat="server" Text="Cancel" BackColor="#ABD3FC" />
                                            </td>
                                            <td style="text-align: left">
                                                <asp:Label ID="lblmessage" runat="server"></asp:Label>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                        </table>
                    </div>
                </div>
            </td>
        </tr>
    </table>
</asp:Content>

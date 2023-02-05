<%@ Page Language="C#" MasterPageFile="MasterAdmin.master" AutoEventWireup="true"
    CodeFile="frmCountry.aspx.cs" Inherits="MCTX_Internal_SuperAdmin_frmCountry"
    Title="Add Country" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <table style="width: 100%; height: 177px;">
        <tr>
            <td valign="top" style="height: 331px">
                <div id="tabs">
                    <ul>
                        <li style="text-align: left"><a href="#tabs-1">Country Information</a></li>
                    </ul>
                    <div id="tabs-1" style="height: 69px">
                        <table style="width: 100%; height: 71px;">
                            <tr>
                                <td style="vertical-align: top">
                                    <table style="width: 100%" align="center">
                                        <tr>
                                            <td style="width: 108px; text-align: left">
                                                <b>Country Name:</b>
                                            </td>
                                            <td style="text-align: left">
                                                <asp:TextBox ID="txtCounntryName" runat="server"></asp:TextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="2" align="left">
                                                <asp:Label ID="lblMessage" runat="server"></asp:Label>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                            </td>
                                            <td style="text-align: left">
                                                <asp:Button ID="btnSaveCountry" runat="server" Text="Save" OnClick="btnSaveCountry_Click"
                                                    BackColor="#ABD3FC" />
                                                &nbsp;
                                                <asp:Button ID="btnCancelCountry" runat="server" Text="Cancel" OnClick="btnCancelCountry_Click"
                                                    BackColor="#ABD3FC" />
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

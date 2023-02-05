<%@ Page Language="C#" MasterPageFile="MasterAdmin.master" AutoEventWireup="true"
    CodeFile="frmChangePassword.aspx.cs" Inherits="MCTX_Internal_SuperAdmin_frmChangePassword"
    Title="Change Password" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <table align="center" style="width: 100%;">
        <tr>
            <td>
                <div id="tabs">
                    <ul>
                        <li style="text-align: left"><a href="#tabs-1">Change Password</a></li>
                    </ul>
                </div>
                <div id="tabs-1">
                    <table align="center" style="width: 100%; height: 390px;">
                        <tr>
                            <td>
                                <table align="center" style="width: 377px; height: 188px" cellspacing="0">
                                    <tr>
                                        <td style="font-size: small; background-color: #225985; color: #FFFFFF; height: 24px;"
                                            align="left" colspan="2">
                                            <b>&nbsp;Chnage Password::</b>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="border-left: thin none #C0C0C0; border-right: thin dotted #C0C0C0; border-top: thin none #C0C0C0;
                                            border-bottom: thin none #C0C0C0; width: 183px; text-align: left; font-size: small">
                                            User Id:
                                        </td>
                                        <td style="text-align: right">
                                            <asp:DropDownList ID="ddluserids" runat="server" AutoPostBack="True" Enabled="False"
                                                OnSelectedIndexChanged="ddluserids_SelectedIndexChanged" Width="134px">
                                            </asp:DropDownList>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="border-left: thin none #C0C0C0; border-right: thin dotted #C0C0C0; border-top: thin none #C0C0C0;
                                            border-bottom: thin none #C0C0C0; width: 183px; text-align: left; font-size: small">
                                            User Name:
                                        </td>
                                        <td style="text-align: right">
                                            <asp:TextBox ID="txtuserName" runat="server" BorderStyle="Dotted" Enabled="False"
                                                ToolTip="User Name"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="border-left: thin none #C0C0C0; border-right: thin dotted #C0C0C0; border-top: thin none #C0C0C0;
                                            border-bottom: thin none #C0C0C0; width: 183px; text-align: left; font-size: small">
                                            Old Password:
                                        </td>
                                        <td style="text-align: right">
                                            <asp:TextBox ID="txt_oldpassword" runat="server" BorderStyle="Dotted" TextMode="Password"
                                                ToolTip="Enter Old Password"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="border-left: thin none #C0C0C0; border-right: thin dotted #C0C0C0; border-top: thin none #C0C0C0;
                                            border-bottom: thin none #C0C0C0; width: 183px; text-align: left; font-size: small">
                                            New Password:
                                        </td>
                                        <td style="text-align: right">
                                            <asp:TextBox ID="txtnewPassword" runat="server" BorderStyle="Dotted" TextMode="Password"
                                                ToolTip="Enter New Password"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="border-left: thin none #C0C0C0; border-right: thin dotted #C0C0C0; border-top: thin none #C0C0C0;
                                            border-bottom: thin none #C0C0C0; width: 183px; text-align: left; font-size: small">
                                            Confirm Password:
                                        </td>
                                        <td style="text-align: right">
                                            <asp:TextBox ID="txtconfirmPassword" runat="server" BorderStyle="Dotted" TextMode="Password"
                                                ToolTip="Enter New Password Again"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="2" style="border-style: none none dotted none; border-width: thin; border-color: #C0C0C0;
                                            text-align: center">
                                            &nbsp;
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="2" style="text-align: center">
                                            <asp:Button ID="btn_update" runat="server" Text="Update" OnClick="btn_update_Click"
                                                BackColor="#99CCFF" />
                                            &nbsp;<input id="btn_back" style="background-color: #99CCFF; width: 53px;" type="button"
                                                value="Back" onclick="history.go(-1)" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="2" style="text-align: left">
                                            <asp:Label ID="lbl_MSG" runat="server"></asp:Label>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </table>
                </div>
            </td>
        </tr>
    </table>
</asp:Content>

<%@ Page Language="C#" MasterPageFile="MasterAdmin.master" AutoEventWireup="true"
    CodeFile="frmUpdateVisit.aspx.cs" Inherits="MCTX_Internal_SuperAdmin_frmUpdateVisit"
    Title="Untitled Page" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <table style="width: 100%; height: 333px;">
        <tr>
            <td valign="top" style="height: 331px">
                <div id="tabs">
                    <ul>
                        <li style="text-align: left"><a href="#tabs-1">Update Visit Time</a></li>
                    </ul>
                    <div id="tabs-1">
                        <table style="width: 100%; height: 259px; margin-top: 0px;">
                            <tr>
                                <td rowspan="2" style="width: 389px; vertical-align: top">
                                    <table style="width: 100%" align="center">
                                        <tr>
                                            <td style="width: 108px; text-align: left">
                                                Start Time:
                                            </td>
                                            <td align="left">
                                                <asp:TextBox ID="txtStartTime" runat="server"></asp:TextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="width: 108px; text-align: left">
                                                End Time:
                                            </td>
                                            <td align="left">
                                                <asp:TextBox ID="txtEndTime" runat="server"></asp:TextBox>
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
                                            <td align="left">
                                                <asp:Button ID="btnSaveUser" runat="server" Text="Save" />
                                                &nbsp;
                                                <asp:Button ID="btnCancelUser" runat="server" Text="Cancel" />
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                                <td align="left" valign="top">
                                    &nbsp;
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    &nbsp;
                                </td>
                            </tr>
                        </table>
                    </div>
                </div>
            </td>
        </tr>
        <tr>
            <td valign="top">
            </td>
        </tr>
    </table>
</asp:Content>

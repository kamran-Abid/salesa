<%@ Page Language="C#" MasterPageFile="MasterAdmin.master" AutoEventWireup="true"
    CodeFile="frmInboxDetails.aspx.cs" Inherits="MCTX_Internal_SuperAdmin_frmInboxDetails"
    Title="MCTX-InboxDetails" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <table style="width: 100%; height: 333px;">
        <tr>
            <td valign="top" style="height: 331px">
                <div id="tabs">
                    <ul>
                        <li style="text-align: left"><a href="#tabs-1">Inbox Detail Information</a></li>
                    </ul>
                    <div id="tabs-1">
                        <table style="width: 100%; height: 138px;">
                            <tr>
                                <td style="width: 235px" align="left">
                                    <b><span style="font-size: small; text-align: left;">Employee Name</span></b>
                                </td>
                                <td style="text-align: left">
                                    <asp:Label ID="lblEmpName" runat="server" BackColor="White" ForeColor="Black"></asp:Label>
                                </td>
                                <td style="width: 237px" align="left">
                                    <b><span style="font-size: small; text-align: left;">Task Name</span></b>
                                </td>
                                <td>
                                    <asp:Label ID="lblTask" runat="server"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td style="width: 235px" align="left">
                                    <b style="text-align: left">Posted Date</b>
                                </td>
                                <td style="text-align: left">
                                    <asp:Label ID="lblPostDate" runat="server"></asp:Label>
                                </td>
                                <td style="width: 237px" align="left">
                                    <b>Submission Date</b>
                                </td>
                                <td>
                                    <asp:Label ID="lblSubDate" runat="server"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td style="width: 235px" align="left">
                                    <b>Task Detail </b>
                                </td>
                                <td>
                                    <asp:TextBox ID="txtTaskDetail" runat="server" TextMode="MultiLine" Height="63px"
                                        Width="261px"></asp:TextBox>
                                </td>
                                <td style="width: 237px" align="left">
                                    <b>Remarks</b>
                                </td>
                                <td>
                                    <asp:TextBox ID="txtRemarks" runat="server" Height="63px" TextMode="MultiLine" Width="261px"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2" style="text-align: left">
                                    <asp:Label ID="lblTaskID" runat="server" Visible="false"></asp:Label>
                                </td>
                                <td colspan="2" style="text-align: left">
                                    <asp:Label ID="lblUserID" runat="server" Visible="false"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td style="width: 235px; height: 13px;">
                                </td>
                                <td style="height: 13px">
                                </td>
                                <td style="width: 237px; text-align: left; height: 13px;">
                                    
                                         <input type="button" value="Back"  Style="background-color: #2A4062;
                                color: White; width:104px;"
                                        onclick="history.go(-1)" />
                                </td>
                                <td style="height: 13px">
                                </td>
                            </tr>
                            <tr>
                                <td style="height: 152px;" colspan="4">
                                </td>
                            </tr>
                        </table>
                    </div>
                </div>
            </td>
        </tr>
    </table>
</asp:Content>

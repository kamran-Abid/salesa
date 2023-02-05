<%@ Page Language="C#" MasterPageFile="MasterAdmin.master" AutoEventWireup="true"
    CodeFile="TaskDetails.aspx.cs" Inherits="MCTX_Internal_SuperAdmin_TaskDetals"
    Title="MCTX-Task Details" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <table style="width: 100%; height: 333px;">
        <tr>
            <td valign="top" style="height: 331px">
                <div id="tabs">
                    <ul>
                        <li style="text-align: left"><a href="#tabs-1">Task Detail Information</a></li>
                    </ul>
                    <div id="tabs-1">
                        <table width="100%">
                            <tr>
                                <td style="height: 16px; width: 122px; text-align: left; color: #000000;">
                                    <span style="color: #000000"><b>Task Name </b>:</span>
                                </td>
                                <td align="left">
                                    <asp:Label ID="lblTaskName" runat="server"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td style="width: 122px; text-align: left; color: #000000;">
                                    <span style="color: #000000"><b>Task Detail</b> :</span>
                                </td>
                                <td align="left">
                                    <asp:Label ID="lblTaskDetail" runat="server"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td style="height: 17px; width: 122px; text-align: left; color: #000000;">
                                    <b><span style="color: #000000">Completion Date </span></b><span style="color: #000000">
                                        :</span>
                                </td>
                                <td align="left">
                                    <asp:Label ID="lblCompDate" runat="server"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td style="width: 122px; text-align: left; color: #000000;">
                                    <span style="color: #000000"><b>Posting Date</b> :</span>
                                </td>
                                <td align="left">
                                    <asp:Label ID="lblPostingDate" runat="server"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td style="width: 122px; text-align: left; color: #000000;">
                                    <span style="color: #000000"><b>Remarks :</b></span>
                                </td>
                                <td align="left">
                                    <asp:TextBox ID="txtRemarks" runat="server" TextMode="MultiLine" Height="77px" Width="227px"
                                        ReadOnly="True"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2" style="text-align: left">
                                    <asp:Label ID="lblMessage" runat="server" Style="font-size: small"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2" style="text-align: left; height: 17px;">
                                    <asp:Button ID="btnSubmit" runat="server" Text="Submit" BackColor="#ABD3FC" ForeColor="White"
                                        OnClick="btnSubmit_Click1" />
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2" style="text-align: left">
                                    <asp:Label ID="lblUserId" runat="server" Visible="false"></asp:Label>
                                    <asp:Label ID="lblTaskID" runat="server" Visible="false"></asp:Label>
                                </td>
                            </tr>
                        </table>
                    </div>
                </div>
            </td>
        </tr>
    </table>
</asp:Content>

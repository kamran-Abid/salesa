<%@ Page Language="C#" MasterPageFile="MasterAdmin.master" AutoEventWireup="true"
    CodeFile="frmExcuse.aspx.cs" Inherits="MCTX_Internal_SuperAdmin_frmExcuse" Title="MCTX:: Visit Excuse" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    &nbsp;<table width="100%" style="height: 95px">
        <tr>
            <td colspan="2">
                <b>Excuse Information</b>
            </td>
        </tr>
        <tr>
            <td colspan="2">
                <asp:Label ID="lblmessage" runat="server"></asp:Label>
            </td>
        </tr>
        <tr>
            <td align="right">
                <b>Select Company</b>
            </td>
            <td align="left">
                <asp:DropDownList ID="ddlCompanies" runat="server">
                </asp:DropDownList>
            </td>
        </tr>
        <tr>
            <td style="width: 166px" align="right">
                <b>Excuse Subject</b>
            </td>
            <td align="left">
                <asp:TextBox ID="txtSubject" runat="server" Height="16px" Width="461px"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td align="right">
                <b>Description</b>
            </td>
            <td align="left">
                <asp:TextBox ID="txtDescription" runat="server" TextMode="MultiLine" Style="margin-left: 0px"
                    Width="461px" Height="83px"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td colspan="2">
                &nbsp;
            </td>
        </tr>
        <tr>
            <td colspan="2">
                <asp:Button ID="btnSave" runat="server" Text="Save" OnClick="btnSave_Click" BackColor="#99CCFF" />&nbsp;<asp:Button
                    ID="btnClear" runat="server" Text="Clear" OnClick="btnClear_Click" BackColor="#99CCFF" />
            </td>
        </tr>
    </table>
</asp:Content>

<%@ Page Language="C#" MasterPageFile="~/MCTX_Internal/SuperAdmin/MasterAdmin.master"
    AutoEventWireup="true" CodeFile="Accessdenied.aspx.cs" Inherits="MCTX_Internal_SuperAdmin_Accessdenied"
    Title="Access Denied!" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div id="tabs">
        <table width="100%" align="center" style="margin-top: 50px">
            <tr>
                <td align="center">
                    <asp:Image ID="imgStop" ImageUrl="images/Stop.gif" runat="server" Height="162px"
                        Width="174px" />
                </td>
            </tr>
            <tr>
                <td align="center">
                    <asp:Label ID="lblError" Text="ACCESS DENIED!" Style="font-size: 40pt; font-family: Verdana;"
                        Width="100%" ForeColor="Red" runat="server"></asp:Label>
                </td>
            </tr>
            <tr>
                <td>
                </td>
            </tr>
            <tr>
                <td align="center">
                    <asp:Label ID="lblSorry" Text="Unauthorized Access!" Style="font-size: 20pt; font-family: Verdana;"
                        Width="100%" ForeColor="Maroon" runat="server"></asp:Label>
                </td>
            </tr>
            <tr>
                <td align="center" style="margin-top: 10px">
                    <asp:Label ID="Label1" Text="" Style="font-size: 9pt; font-family: Verdana;" Width="100%"
                        ForeColor="Green" runat="server"></asp:Label>
                </td>
            </tr>
            <tr>
                <td align="center" style="margin-top: 10px">
                    <asp:Label ID="Label2" Text="Contact IT section at it@mechatronix.com.pk to obtain the Access. Thank You!"
                        Style="font-size: 9pt; font-family: Verdana;" Width="100%" ForeColor="Black"
                        runat="server"></asp:Label>
                </td>
            </tr>
        </table>
    </div>
</asp:Content>

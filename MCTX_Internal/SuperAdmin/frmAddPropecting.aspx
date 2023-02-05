<%@ Page Language="C#" AutoEventWireup="true" CodeFile="frmAddPropecting.aspx.cs"
    Inherits="MCTX_Internal_GeneralUser_frmAddPropecting" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Prospecting</title>
    <style type="text/css">
        .style2
        {
            width: 508px;
        }
        .style3
        {
        }
        .style4
        {
            width: 491px;
        }
        .style6
        {
            text-decoration: underline;
            text-align: left;
        }
        .style7
        {
        }
        .style8
        {
            width: 523px;
        }
        .style10
        {
            width: 489px;
        }
        #addcomp
        {
            height: 202px;
            width: 496px;
        }
        #addclient
        {
            height: 265px;
            width: 506px;
        }
        .style11
        {
            width: 517px;
        }
        .style12
        {
            font-family: Verdana;
            font-size: small;
            text-decoration: underline;
        }
        .style16
        {
            width: 194px;
            text-align: right;
            font-family: Verdana;
            font-size: 10px;
            background-color: #c1d2ee;
        }
        .style17
        {
            width: 194px;
        }
        .style19
        {
            width: 193px;
        }
        .style20
        {
            width: 193px;
            text-align: right;
            font-family: Verdana;
            font-size: 10px;
            background-color: #c1d2ee;
        }
        .style21
        {
            width: 195px;
            text-align: right;
            font-family: Verdana;
            font-size: 10px;
            background-color: #c1d2ee;
        }
        .style22
        {
            font-family: Verdana;
            font-size: small;
            color: #000066;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <table style="width: 528px">
            <tr>
                <td class="style6" style="background-color: #c1d2ee">
                    <b>Add Propecting :: </b>
                </td>
            </tr>
            <tr>
                <td class="style6" style="border-style: none none dotted none; border-width: thin;
                    border-color: #000066">
                    &nbsp;
                </td>
            </tr>
            <tr>
                <td style="border-style: none none dotted none; border-width: thin; border-color: #000066">
                    <table align="left" class="style2">
                        <tr>
                            <td class="style7">
                                <asp:Button ID="btn_addcomp" runat="server" Height="21px" Text="Click to Add New Company"
                                    Width="197px" OnClick="btn_addcomp_Click" BorderStyle="Solid" />
                                &nbsp;<span class="style22">Please enter company information:</span>
                            </td>
                            <td>
                                &nbsp;
                            </td>
                        </tr>
                        <tr>
                            <td class="style3" colspan="2" align="left">
                                <div id="addcomp" visible="false" runat="server">
                                    <table align="left" class="style4">
                                        <tr>
                                            <td class="style16">
                                                *&nbsp; Company Name:
                                            </td>
                                            <td>
                                                <asp:TextBox ID="txt_compname" runat="server"></asp:TextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="style16">
                                                Web Address:
                                            </td>
                                            <td>
                                                <asp:TextBox ID="txt_compwebadd" runat="server"></asp:TextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="style16">
                                                *&nbsp; Country:
                                            </td>
                                            <td>
                                                <asp:DropDownList ID="ddlCountry" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddlCountry_SelectedIndexChanged">
                                                </asp:DropDownList>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="style16">
                                                *&nbsp; City:
                                            </td>
                                            <td>
                                                <asp:DropDownList ID="ddlCity" runat="server">
                                                </asp:DropDownList>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="style16">
                                                *&nbsp; Phone:
                                            </td>
                                            <td>
                                                <asp:TextBox ID="txt_compphone" runat="server"></asp:TextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="style16">
                                                Address:
                                            </td>
                                            <td>
                                                <asp:TextBox ID="txt_add" runat="server" TextMode="MultiLine" Width="259px"></asp:TextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="left" class="style17">
                                                <asp:Button ID="btn_save" runat="server" Height="21px" Text="Save Company" Width="103px"
                                                    BorderStyle="Solid" OnClick="btn_save_Click" />
                                                &nbsp;<asp:Button ID="btn_cancel" runat="server" Height="21px" Text="Cancel" Width="52px"
                                                    BorderStyle="Solid" OnClick="btn_cancel_Click" />
                                            </td>
                                            <td>
                                                <asp:Label ID="lbl_Msg" runat="server" Font-Names="Verdana" Font-Size="Smaller"></asp:Label>
                                            </td>
                                        </tr>
                                    </table>
                                </div>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td style="border-style: none none dotted none; border-width: thin; border-color: #000066">
                    <table align="left" class="style8">
                        <tr>
                            <td class="style10">
                                <asp:Button ID="btn_addclient" runat="server" Height="21px" Text="Click to Add New Client"
                                    Width="202px" BorderStyle="Solid" OnClick="btn_addclient_Click" />
                                &nbsp;<span class="style22">Please enter client information:</span>
                            </td>
                            <td>
                                &nbsp;
                            </td>
                        </tr>
                        <tr>
                            <td class="style7" colspan="2" valign="top">
                                <div id="addclient" visible="false" runat="server">
                                    <table align="left" style="width: 489px">
                                        <tr>
                                            <td class="style20">
                                                *&nbsp; Client Name:
                                            </td>
                                            <td>
                                                <asp:TextBox ID="txtclientname" runat="server"></asp:TextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="style20">
                                                * Mobile No:
                                            </td>
                                            <td>
                                                <asp:TextBox ID="txtclientmobno" runat="server"></asp:TextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="style20">
                                                &nbsp;E-mail:
                                            </td>
                                            <td>
                                                <asp:TextBox ID="txtclientemail" runat="server"></asp:TextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="style20">
                                                Phone:
                                            </td>
                                            <td>
                                                <asp:TextBox ID="txtclientphone" runat="server"></asp:TextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="style20">
                                                *&nbsp; Company Name:
                                            </td>
                                            <td>
                                                <asp:DropDownList ID="ddlCompanyName" runat="server" Width="200px">
                                                </asp:DropDownList>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="style20">
                                                Designation:
                                            </td>
                                            <td>
                                                <asp:TextBox ID="txtclientdesignation" runat="server"></asp:TextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="style20">
                                                Department:
                                            </td>
                                            <td>
                                                <asp:TextBox ID="txtclientdept" runat="server"></asp:TextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="style20">
                                                * Country:
                                            </td>
                                            <td>
                                                <asp:DropDownList ID="ddlCountry1" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddlCountry1_SelectedIndexChanged">
                                                </asp:DropDownList>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="style20">
                                                * City:
                                            </td>
                                            <td>
                                                <asp:DropDownList ID="ddlCity1" runat="server">
                                                </asp:DropDownList>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="left" class="style19">
                                                <asp:Button ID="btn_saveclient" runat="server" Height="21px" Text="Save Client" Width="90px"
                                                    BorderStyle="Solid" OnClick="btn_saveclient_Click" />
                                                &nbsp;<asp:Button ID="btn_cancel0" runat="server" Height="21px" Text="Cancel" Width="48px"
                                                    BorderStyle="Solid" OnClick="btn_cancel0_Click" />
                                            </td>
                                            <td>
                                                <asp:Label ID="lbl_Msg0" runat="server" Font-Names="Verdana" Font-Size="Smaller"></asp:Label>
                                            </td>
                                        </tr>
                                    </table>
                                </div>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td class="style12">
                Prospecting Information:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            </tr>
            <tr>
                <td>
                    <table align="left" class="style11">
                        <tr>
                            <td class="style21">
                                Company Name:
                            </td>
                            <td>
                                <asp:DropDownList ID="ddlcompanyname3" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddlcompanyname3_SelectedIndexChanged"
                                    Width="200px">
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr>
                            <td class="style21">
                                Client Name:
                            </td>
                            <td>
                                <asp:DropDownList ID="ddlClient" runat="server">
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr>
                            <td class="style21">
                                Target Products:
                            </td>
                            <td>
                                <asp:DropDownList ID="ddlTarProd" Width="124px" runat="server">
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr>
                            <td class="style21">
                                Booking Date:
                            </td>
                            <td valign="bottom">
                                <asp:TextBox ID="txt_todaydate" runat="server" Enabled="False"></asp:TextBox>
                                mm/dd/yyyy
                            </td>
                        </tr>
                        <tr>
                            <td class="style21">
                                Reserverd Days
                            </td>
                            <td>
                                <asp:TextBox ID="txt_reserveddays" runat="server" Enabled="False" Width="45px">10</asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td class="style21">
                                Reserverd Date
                            </td>
                            <td>
                                <asp:TextBox ID="txt_reserverdate" runat="server" Enabled="False"></asp:TextBox>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td>
                    <asp:Button ID="btn_submit" runat="server" BackColor="#000066" BorderStyle="Solid"
                        Font-Bold="True" ForeColor="White" Height="22px" Text="Submit" Width="82px" OnClick="btn_submit_Click" />
                </td>
            </tr>
            <tr>
                <td>
                    <asp:Label ID="lbl_Msg1" runat="server" Font-Names="Verdana" Font-Size="Smaller"></asp:Label>
                </td>
            </tr>
        </table>
    </div>
    </form>
</body>
</html>

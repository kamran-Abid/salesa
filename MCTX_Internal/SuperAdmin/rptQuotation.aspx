<%@ Page Language="C#" AutoEventWireup="true" CodeFile="rptQuotation.aspx.cs" Inherits="MCTX_Internal_SuperAdmin_rptQuotation" %>

<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=9.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
    Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Mechatronix Quotation Report</title>
    <style type="text/css">
        .style2
        {
            height: 399px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <table align="center" style="width: 8.5in; height: 11in">
            <tr>
                <td style="text-align: center">
                    <asp:Button ID="btnBack" runat="server" Text="Back" OnClick="btnBack_Click" Width="82px"
                        Style="text-align: center" />
                </td>
            </tr>
            <tr>
                <td style="text-align: center">
                    <table>
                        <tr>
                            <td>
                                <span style="font-family:Calibri; font-size:10pt">Client's Email:</span>
                                <asp:TextBox ID="txtEmail" runat="server" Height="15px" width="160px"/>
                            </td>
                            <td>
                                <asp:Button ID="btnEmail" runat="server" Text="Send Quotation" Width="100px" Style="text-align: center; font-family:Calibri;
                                    height: 25px;" OnClick="btnEmail_Click" />
                                    <span><asp:Label ID="lblEmail" Text="Quotation has been sent!" style="font-family:Calibri; font-size:10pt; color:Green" runat="server" Visible="false"></asp:Label></span>
                                </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td align="center" style="color: #FFFFFF; background-color: #006699; height: 14px;">
                    MCTX-Quotation Report
                </td>
            </tr>
            <tr>
                <td id="tblReport1" runat="server" align="left" class="style2" height="8.5in">
                    <table id="tblReport" runat="server">
                        <tr>
                            <td>
                                <rsweb:ReportViewer ID="ReportViewer1" runat="server" Style="margin-left: 0px" Width="9.2in"
                                    Height="11in">
                                </rsweb:ReportViewer>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
    </div>
    </form>
</body>
</html>

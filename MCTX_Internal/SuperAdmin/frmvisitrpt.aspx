<%@ Page Language="C#" MasterPageFile="MasterAdmin.master" AutoEventWireup="true"
    CodeFile="frmvisitrpt.aspx.cs" Inherits="MCTX_Internal_SuperAdmin_frmvisitrpt"
    Title="MCTX visit report criteria" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <table align="center" style="width: 100%;">
        <tr>
            <td>
                <div id="tabs">
                    <ul>
                        <li style="text-align: left"><a href="#tabs-1">Visit Report</a></li>
                    </ul>
                </div>
                <div id="tabs-1">
                    <table align="center" style="width: 100%; height: 450px">
                        <tr>
                            <td style="height: 30px">
                                &nbsp;
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <table align="center" style="width: 440px; height: 259px" cellspacing="0">
                                    <tr>
                                        <td colspan="2" style="font-size: small; background-color: #225985; color: #FFFFFF;
                                            height: 24px;">
                                            <b style="text-align: left">&nbsp;::Report Criteria::</b>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width: 220px; text-align: left; font-size: small">
                                            &nbsp;
                                        </td>
                                        <td style="border-left: thin dotted #000000; border-right: thin none #000000; border-top: thin none #000000;
                                            border-bottom: thin none #000000; text-align: right;">
                                            &nbsp;
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width: 220px; text-align: left; font-size: small">
                                            <b>Select User: </b>
                                        </td>
                                        <td style="border-left: thin dotted #000000; border-right: thin none #000000; border-top: thin none #000000;
                                            border-bottom: thin none #000000; text-align: right;">
                                            <asp:DropDownList ID="ddlselectuser" runat="server" Width="132px" AutoPostBack="True"
                                                OnSelectedIndexChanged="ddlselectuser_SelectedIndexChanged" ToolTip="Select User">
                                            </asp:DropDownList>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width: 220px; text-align: left; font-size: small">
                                            <b>User Name: </b>
                                        </td>
                                        <td style="border-left: thin dotted #000000; border-right: thin none #000000; border-top: thin none #000000;
                                            border-bottom: thin none #000000; text-align: right;">
                                            <asp:TextBox ID="txtusername" runat="server"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width: 220px; text-align: left; font-size: small">
                                            <b>Select Visit Type: </b>
                                        </td>
                                        <td style="border-left: thin dotted #000000; border-right: thin none #000000; border-top: thin none #000000;
                                            border-bottom: thin none #000000; text-align: right;">
                                            <asp:DropDownList ID="ddlselectvisit" runat="server" Width="132px">
                                            </asp:DropDownList>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width: 220px; text-align: left; font-size: small">
                                            <b>From Date: </b>
                                        </td>
                                        <td style="border-left: thin dotted #000000; border-right: thin none #000000; border-top: thin none #000000;
                                            border-bottom: thin none #000000; text-align: right;">
                                            <asp:TextBox ID="txtfromdate" runat="server" OnTextChanged="txtfromdate_TextChanged"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width: 220px; text-align: left; font-size: small">
                                            <b>To Date: </b>
                                        </td>
                                        <td style="border-left: thin dotted #000000; border-right: thin none #000000; border-top: thin none #000000;
                                            border-bottom: thin none #000000; text-align: right;">
                                            <asp:TextBox ID="txttodate" runat="server" Height="16px" OnTextChanged="txttodate_TextChanged"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="2">
                                            &nbsp;
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="2" style="border-style: none none dotted none; border-width: thin; border-color: #000000">
                                            &nbsp;
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="2" style="height: 31px">
                                            <asp:Button ID="btn_submit" runat="server" BackColor="#99CCFF" Text="Submit" CssClass="ui-button"
                                                OnClick="btn_submit_Click" />
                                            &nbsp;<asp:Button ID="btnrest" runat="server" Text="Reset" BackColor="#99CCFF" CssClass="ui-button" />
                                            &nbsp;<input id="Button1" type="button" value="Back" onclick="history.go(-1)" style="background-color: #99CCFF;
                                                width: 70px; height: 25px;" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="height: 54px" colspan="2">
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

    <script type="text/javascript" language="javascript">
    $(function() {
                 $("input[id$='txtfromdate']").datepicker({ dateFormat: 'mm/dd/yy' });      
                 }
     );
      $(function() {
                 $("input[id$='txttodate']").datepicker({ dateFormat: 'mm/dd/yy' });      
                 }
     );
    </script>

</asp:Content>

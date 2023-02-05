<%@ Page Language="C#" MasterPageFile="~/MCTX_Internal/SuperAdmin/MasterAdmin.master"
    AutoEventWireup="true" CodeFile="ReceiptsAndExpense.aspx.cs" Inherits="MCTX_Internal_ReceiptsAndExpense"
    Title="Receipts And Expense" %>

<%@ Register Assembly="RJS.Web.WebControl.PopCalendar.Net.2008" Namespace="RJS.Web.WebControl"
    TagPrefix="rjs" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <script src="../../js/jquery.formatCurrency-1.4.0.js" type="text/javascript"></script>

    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <div id="tabs" style="width: 796">
        <ul>
            <li style="text-align: left"><a href="#tabs-1">Account Information</a></li>
            <li style="text-align: left"><a href="#tabs-2">Inward Receipts </a></li>
            <li style="text-align: left"><a href="#tabs-3">Summary Form</a></li>
            <li style="text-align: left"><a href="#tabs-4">Setting Form </a></li>
        </ul>
        <div id="tabs-1" style="width: 804px">
            <table style="width: 100%">
                <tr>
                    <td align="center" style="text-align: center; width: 90%">
                        <span style="font-weight: bold; color: dodgerBlue; text-align: center; font-size: 16px">
                            Receitps / Expense Amount Difference : </span><span style="font-weight: bold; color: darkorange;
                                text-align: center; font-size: 16px" id="lblCashInHandAmount"></span>
                        <asp:Label ID="lblPreDisburseTo" Style="display: none;" runat="server"></asp:Label>
                    </td>
                    <td style="width: 10%;">
                        <asp:Button ID="btnRefresh" Text="Refresh" Style="color: White; font-weight: bold;
                            background-color: Orange;" OnClientClick="return refreshpage();" runat="server" />
                    </td>
                </tr>
            </table>
            <div id="divReceipt" runat="server">
            </div>
            <div id="divCashDispersement" runat="server">
                <fieldset id="fldDespesement" style="width: 780px; margin-top: 5px">
                    <legend>Cash Disbursement</legend>
                    <table style="width: 100%">
                        <tr>
                            <td align="left">
                                Disbursed To
                            </td>
                            <td align="left">
                                <asp:DropDownList ID="ddlDispersedTo" Width="126px" runat="server" Style="border: solid 1px gray">
                                    <asp:ListItem></asp:ListItem>
                                </asp:DropDownList>
                            </td>
                            <td align="left">
                                Disbursed By
                            </td>
                            <td align="left">
                                <asp:DropDownList ID="ddlDispersedBy" Width="118px" runat="server" Style="border: solid 1px gray">
                                </asp:DropDownList>
                            </td>
                            <td align="left">
                                Disbursement Method
                            </td>
                            <td align="left">
                                <asp:DropDownList ID="ddlDispersionMethod" Width="118px" runat="server" Style="border: solid 1px gray">
                                    <asp:ListItem></asp:ListItem>
                                    <asp:ListItem>Cash</asp:ListItem>
                                    <asp:ListItem>Cheque</asp:ListItem>
                                    <asp:ListItem>IBFT</asp:ListItem>
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr>
                            <td align="left">
                                Disbursed Amount
                            </td>
                            <td align="left">
                                <asp:TextBox runat="server" ID="txtDispersedAmt" onkeypress="return keyRestrict(event,'0123456789')"
                                    Style="border: solid 1px gray" MaxLength="11"></asp:TextBox>
                            </td>
                            <td colspan="2">
                                &nbsp;
                            </td>
                            <td>
                                &nbsp;
                            </td>
                            <td>
                                &nbsp;
                            </td>
                        </tr>
                        <tr>
                            <td>
                                &nbsp;
                            </td>
                            <td>
                                &nbsp;
                            </td>
                            <td>
                            </td>
                            <td colspan="3" align="left">
                                <asp:Button ID="btnCashDisSave" runat="server" Text="Save" Width="75px" Style="border: solid 1px gray"
                                    OnClientClick="return saveDispersement();" />
                                <asp:Button ID="btnCashDisClear" runat="server" Text="New" Width="75px" Style="border: solid 1px gray"
                                    OnClientClick="return clearDisp();" />
                                <asp:Button ID="btnDisDetails" runat="server" Text="Details" Width="75px" Style="border: solid 1px gray;"
                                    OnClick="btnDisDetails_Click" />
                                <asp:Button ID="btnDisUpd" runat="server" Text="Update" Width="75px" Style="border: solid 1px gray"
                                    Visible="false" OnClientClick="return updateDispData();" />
                            </td>
                        </tr>
                    </table>
                </fieldset>
            </div>
            <div>
                <fieldset id="fldExpense" style="width: 780px; margin-top: 5px">
                    <legend>Expense </legend>
                    <table style="width: 101%; height: 164px;">
                        <tr>
                            <td>
                                Cash In Hand:
                            </td>
                            <td>
                                <asp:Label ID="lblExpID" runat="server" Text="" Style="display: none;"></asp:Label>
                                <asp:TextBox ID="txtCashInHand" runat="server" ReadOnly="True" Style="border: solid 1px gray"></asp:TextBox>
                            </td>
                            <td>
                                Cash In Branch:
                            </td>
                            <td>
                                <asp:TextBox ID="txtCashinBranch" runat="server" ReadOnly="True" Style="border: solid 1px gray"></asp:TextBox>
                            </td>
                            <td>
                                Expense Date:
                            </td>
                            <td>
                                <asp:TextBox ID="txtExpenseDate" runat="server" Style="border: solid 1px gray"></asp:TextBox>
                                <rjs:PopCalendar ID="PopCalendar1" runat="server" InvalidDateMessage="Invalid Date."
                                    TextMessage="Invalid Date." ShowMessageBox="True" Separator="/" Format="mm dd yyyy"
                                    Control="txtExpenseDate"></rjs:PopCalendar>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                Expense Details:
                            </td>
                            <td>
                                <asp:TextBox ID="txtExpDetails" TextMode="MultiLine" runat="server" onkeypress="return keyRestrict(event,'abcdefghijklmnopqrstuvwxyz0123456789#&()@.,- ^')"
                                    Style="border: solid 1px gray; width: 116px; resize: none;" MaxLength="30"></asp:TextBox>
                            </td>
                            <td>
                                Expense Amount:
                            </td>
                            <td>
                                <asp:TextBox ID="TextExpenseAmt" runat="server" onkeypress="return keyRestrict(event,'0123456789')"
                                    Style="border: solid 1px gray" MaxLength="11"></asp:TextBox>
                            </td>
                            <td>
                                Expense Category:
                            </td>
                            <td>
                                <asp:DropDownList ID="ddlExpenseCategory" runat="server" Style="border: solid 1px gray;
                                    width: 118px" onchange="return BindExpenseType();">
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                Expense Type:
                            </td>
                            <td>
                                <asp:DropDownList ID="ddlExpenseType" Width="120px" runat="server" Style="border: solid 1px gray;
                                    width: 118px">
                                </asp:DropDownList>
                            </td>
                            <td>
                                Mode of Payment:
                            </td>
                            <td>
                                <asp:DropDownList ID="ddlPaymentMode" Width="120px" runat="server" Style="border: solid 1px gray;
                                    width: 118px">
                                    <asp:ListItem></asp:ListItem>
                                    <asp:ListItem>Cash</asp:ListItem>
                                    <asp:ListItem>Cheque</asp:ListItem>
                                    <asp:ListItem>IBFT</asp:ListItem>
                                </asp:DropDownList>
                            </td>
                            <td>
                                For Project:
                            </td>
                            <td>
                                <asp:DropDownList ID="ddlProjectName" runat="server" Width="100px" Style="border: solid 1px gray;
                                    width: 118px">
                                    <asp:ListItem></asp:ListItem>
                                    <asp:ListItem>Non Project</asp:ListItem>
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                Expense Status:
                            </td>
                            <td>
                                <asp:DropDownList runat="server" ID="ddlExpStatus" Style="border: solid 1px gray;
                                    width: 118px">
                                    <asp:ListItem></asp:ListItem>
                                    <asp:ListItem>Receipted</asp:ListItem>
                                    <asp:ListItem>Non Receipted</asp:ListItem>
                                </asp:DropDownList>
                            </td>
                            <td>
                                Approval Status:
                            </td>
                            <td>
                                <asp:DropDownList runat="server" ID="DropDownList4" Style="border: solid 1px gray;
                                    width: 118px" onchange="return EnableDisableDDL();">
                                    <asp:ListItem></asp:ListItem>
                                    <asp:ListItem>Prior Approved</asp:ListItem>
                                    <asp:ListItem>Not Approved</asp:ListItem>
                                </asp:DropDownList>
                            </td>
                            <td>
                                Approving Authority:
                            </td>
                            <td>
                                <asp:DropDownList runat="server" ID="ddlApprovingAuthority" Style="border: solid 1px gray;
                                    width: 118px">
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                &nbsp;
                            </td>
                            <td>
                                &nbsp;
                            </td>
                            <td colspan="3" align="left">
                                <asp:Button ID="btnSaveExpense" runat="server" Text="Save" Width="75px" Style="border: solid 1px gray"
                                    OnClientClick="return SaveExpense();" />
                                <asp:Button ID="btnClearExpense" runat="server" Text="New" Width="75px" Style="border: solid 1px gray"
                                    OnClientClick="return clearExp();" />
                                <asp:Button ID="btnExpenseDetails" runat="server" Text="Details" Width="75px" Style="border: solid 1px gray"
                                    OnClick="btnExpenseDetails_Click" />
                                <asp:Button ID="btnExpUpdate" runat="server" Text="Update" Width="75px" Style="border: solid 1px gray"
                                    OnClientClick="return updateExpense();" />
                            </td>
                            <td>
                                &nbsp;
                            </td>
                            <td>
                                &nbsp;
                            </td>
                        </tr>
                    </table>
                </fieldset>
            </div>
        </div>
        <div id="tabs-2">
            <table style="width: 100%;">
                <tr>
                    <td style="width: 90%;">
                    </td>
                    <td style="width: 10%;">
                        <asp:Button ID="Button1" align="right" Text="Refresh" Style="color: White; font-weight: bold;
                            background-color: Orange;" OnClientClick="return refreshpage();" runat="server" />
                    </td>
                </tr>
            </table>
            <fieldset id="fldRecpt" style="width: 780px">
                <legend>Receipts </legend>
                <table style="width: 100%">
                    <tr>
                        <td colspan="6">
                            <asp:TextBox runat="server" ID="txtUserRole" Style="display: none"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            Date:
                        </td>
                        <td>
                            <asp:TextBox runat="server" ID="txtReceiptDate" Style="border: solid 1px gray"></asp:TextBox>
                            <rjs:PopCalendar ID="PopCalendar2" runat="server" InvalidDateMessage="Invalid Date."
                                TextMessage="Invalid Date." ShowMessageBox="True" Separator="/" Format="mm dd yyyy"
                                Control="txtReceiptDate"></rjs:PopCalendar>
                        </td>
                        <td>
                            Amount:
                        </td>
                        <td>
                            <asp:TextBox runat="server" ID="txtReceiptAmount" onkeypress="return keyRestrict(event,'0123456789')"
                                Style="border: solid 1px gray" MaxLength="11"></asp:TextBox>
                        </td>
                        <td>
                            Receive By:
                        </td>
                        <td>
                            <asp:DropDownList runat="server" ID="ddlReceivedBy" Style="border: solid 1px gray;
                                width: 118px">
                            </asp:DropDownList>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            Received From Cat
                        </td>
                        <td align="left">
                            <asp:DropDownList Width="120px" ID="ddlReceiveFrom0" onchange="return EnableDisabledReceiveFromDDL();"
                                runat="server" Style="border: solid 1px gray; margin-left: 0px;">
                                <asp:ListItem></asp:ListItem>
                                <asp:ListItem>Project</asp:ListItem>
                                <asp:ListItem>Person/Branch</asp:ListItem>
                            </asp:DropDownList>
                        </td>
                        <td>
                            Received From:
                        </td>
                        <td>
                            <asp:DropDownList Width="120px" ID="ddlReceiveFrom" runat="server" Style="border: solid 1px gray;
                                margin-left: 0px;">
                            </asp:DropDownList>
                            <asp:DropDownList Width="120px" ID="ddlReciveFromPro" runat="server" Style="border: solid 1px gray;
                                margin-left: 0px; display: none;">
                            </asp:DropDownList>
                        </td>
                        <td>
                            For Project:
                        </td>
                        <td>
                            <asp:DropDownList ID="ddlProjecName" runat="server" Width="120px" Style="border: solid 1px gray">
                            </asp:DropDownList>
                        </td>
                    </tr>
                    <tr>
                        <td align="left">
                            Mode of Payment:
                        </td>
                        <td align="left">
                            <asp:DropDownList Width="120px" ID="ddlModeOfPayment" runat="server" Style="border: solid 1px gray">
                                <asp:ListItem></asp:ListItem>
                                <asp:ListItem>Cash</asp:ListItem>
                                <asp:ListItem>Cheque</asp:ListItem>
                                <asp:ListItem>IBFT</asp:ListItem>
                            </asp:DropDownList>
                        </td>
                        <td align="left">
                            Payment Nature:
                        </td>
                        <td align="left">
                            <asp:DropDownList Width="120px" ID="ddlPaymentNature" runat="server" Style="border: solid 1px gray" />
                        </td>
                        <td align="left">
                            Disbursed By
                        </td>
                        <td align="left">
                            <asp:DropDownList ID="ddlDisbursedBy_Inward" Width="118px" runat="server" Style="border: solid 1px gray">
                            </asp:DropDownList>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            Disbursed To
                        </td>
                        <td align="left">
                            <asp:DropDownList ID="ddlDisbursedTo_Inward" Width="120px" runat="server" Style="border: solid 1px gray">
                                <asp:ListItem></asp:ListItem>
                            </asp:DropDownList>
                        </td>
                        <td>
                            Disbursement Method
                        </td>
                        <td>
                            <asp:DropDownList ID="ddlDisbursionMethod_Inward" Width="118px" runat="server" Style="border: solid 1px gray">
                                <asp:ListItem></asp:ListItem>
                                <asp:ListItem>Cash</asp:ListItem>
                                <asp:ListItem>Cheque</asp:ListItem>
                                <asp:ListItem>IBFT</asp:ListItem>
                            </asp:DropDownList>
                        </td>
                        <td>
                            Disbursed Amount
                        </td>
                        <td>
                            <asp:TextBox runat="server" ID="txtDesbursedAmt_Inward" onkeypress="return keyRestrict(event,'0123456789')"
                                Style="border: solid 1px gray" MaxLength="11"></asp:TextBox>
                            <%--                            <ajtk:FilteredTextBoxExtender ID="FilteredTextBoxExtender10" runat="server" TargetControlID="txtDesbursedAmt_Inward"
                                FilterType="Numbers">
                            </ajtk:FilteredTextBoxExtender>--%>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            &nbsp;
                        </td>
                        <td>
                            <asp:Label ID="lblRecp_Id" Style="display: none;" runat="server"></asp:Label>
                        </td>
                        <td>
                            <asp:Label ID="lblDesp_Id" Style="display: none;" runat="server"></asp:Label>
                        </td>
                        <td colspan="3" align="left">
                            <asp:Button ID="btnRecSave" runat="server" OnClientClick="return SaveReciept();"
                                Text="Save" Width="75px" Style="border: solid 1px gray" />
                            <asp:Button ID="btnRecClear" runat="server" Text="New" Width="75px" Style="border: solid 1px gray"
                                OnClientClick="return clearRecpt();" />
                            <asp:Button ID="btnViewRecpts" runat="server" Text="Details" Width="75px" Style="border: solid 1px gray;
                                display: none;" OnClick="btnViewRecpts_Click" />
                            <asp:Button ID="btnUpdate" runat="server" Text="Update" OnClientClick="return updateReceipts();"
                                Visible="false" Width="75px" Style="border: solid 1px gray" />
                        </td>
                    </tr>
                </table>
            </fieldset>
            <br />
            <div id="cashreceivables" runat="server">
                <asp:Label ID="lblTotalAmt" Font-Bold="true" Style="font-weight: bold; color: dodgerBlue;
                    text-align: center; font-size: 16px" Text="Total Amount [Receivables]:" runat="server"></asp:Label>
                <asp:Label ID="lblTotalAmount" Style="font-weight: bold; color: darkorange; text-align: center;
                    font-size: 16px" runat="server"></asp:Label><asp:Label ID="lblRecievableID" Style="display: none;"
                        runat="server"></asp:Label>
                <br />
                <fieldset id="fldReceive" style="width: 780px">
                    <legend>Receivables</legend>
                    <table style="width: 100%" align="center">
                        <tr>
                            <td align="left">
                                Invoice To:
                            </td>
                            <td>
                                <asp:DropDownList ID="ddlInvoiceTo" Style="border: solid 1px gray" Width="114px"
                                    runat="server">
                                </asp:DropDownList>
                            </td>
                            <td align="left">
                                PO Date:
                            </td>
                            <td>
                                <asp:TextBox ID="txtPODate" Style="border: solid 1px gray" runat="server"></asp:TextBox>
                                <rjs:PopCalendar ID="PopCalendar5" runat="server" InvalidDateMessage="Invalid Date."
                                    TextMessage="Invalid Date." ShowMessageBox="True" Separator="/" Format="mm dd yyyy"
                                    Control="txtPODate"></rjs:PopCalendar>
                                <%--<ajtk:FilteredTextBoxExtender ID="FilteredTextBoxExtender6" runat="server" TargetControlID="txtPODate"
                                FilterType="Numbers, Custom" ValidChars="/">
                            </ajtk:FilteredTextBoxExtender>--%>
                            </td>
                        </tr>
                        <tr>
                            <td align="left">
                                Invoice Date:
                            </td>
                            <td>
                                <asp:TextBox ID="txtInvoiceDate" Style="border: solid 1px gray" runat="server"></asp:TextBox>
                                <rjs:PopCalendar ID="PopCalendar3" runat="server" InvalidDateMessage="Invalid Date."
                                    TextMessage="Invalid Date." ShowMessageBox="True" Separator="/" Format="mm dd yyyy"
                                    Control="txtInvoiceDate"></rjs:PopCalendar>
                                <%--<ajtk:FilteredTextBoxExtender ID="FilteredTextBoxExtender7" runat="server" TargetControlID="txtInvoiceDate"
                                FilterType="Numbers, Custom" ValidChars="/">
                            </ajtk:FilteredTextBoxExtender>--%>
                            </td>
                            <td align="left">
                                Payment Due On:
                            </td>
                            <td>
                                <asp:TextBox ID="txtPaymentDueon" Style="border: solid 1px gray" runat="server"></asp:TextBox>
                                <rjs:PopCalendar ID="PopCalendar4" runat="server" InvalidDateMessage="Invalid Date."
                                    TextMessage="Invalid Date." ShowMessageBox="True" Separator="/" Format="mm dd yyyy"
                                    Control="txtPaymentDueon"></rjs:PopCalendar>
                                <%--<ajtk:FilteredTextBoxExtender ID="FilteredTextBoxExtender8" runat="server" TargetControlID="txtPaymentDueon"
                                FilterType="Numbers, Custom" ValidChars="/">
                            </ajtk:FilteredTextBoxExtender>--%>
                            </td>
                        </tr>
                        <tr>
                            <td align="left">
                                Invoice No:
                            </td>
                            <td>
                                <asp:TextBox ID="txtInvoiceNo" onkeypress="return keyRestrict(event,'abcdefghijklmnopqrstuvwxyz0123456789 -')"
                                    Style="border: solid 1px gray" runat="server" MaxLength="9"></asp:TextBox>
                                <%--<ajtk:FilteredTextBoxExtender ID="FilteredTextBoxExtender11" runat="server" TargetControlID="txtInvoiceNo"
                                FilterType="Numbers">
                            </ajtk:FilteredTextBoxExtender>--%>
                            </td>
                            <td align="left">
                                PO Number
                            </td>
                            <td>
                                <asp:TextBox ID="txtPONumber" onkeypress="return keyRestrict(event,'abcdefghijklmnopqrstuvwxyz0123456789 -')"
                                    Style="border: solid 1px gray" runat="server" MaxLength="9"></asp:TextBox>
                                <%--<ajtk:FilteredTextBoxExtender ID="FilteredTextBoxExtender12" runat="server" TargetControlID="txtPONumber"
                                FilterType="Numbers">
                            </ajtk:FilteredTextBoxExtender>--%>
                            </td>
                        </tr>
                        <tr>
                            <td align="left">
                                Invoice Amount:
                            </td>
                            <td>
                                <asp:TextBox ID="txtInvoiceAmt" onkeypress="return keyRestrict(event,'0123456789')"
                                    Style="border: solid 1px gray" runat="server" MaxLength="11"></asp:TextBox>
                                <%--                      <ajtk:FilteredTextBoxExtender ID="FilteredTextBoxExtender13" runat="server" TargetControlID="txtInvoiceAmt"
                                FilterType="Numbers">
                            </ajtk:FilteredTextBoxExtender>--%>
                            </td>
                            <td>
                                GST:
                            </td>
                            <td>
                                <asp:TextBox ID="txtGST" onkeypress="return keyRestrict(event,'0123456789)" Style="border: solid 1px gray"
                                    runat="server" MaxLength="9"></asp:TextBox>
                                <%--<ajtk:FilteredTextBoxExtender ID="FilteredTextBoxExtender14" runat="server" TargetControlID="txtGST"
                                FilterType="Numbers">
                            </ajtk:FilteredTextBoxExtender>--%>
                            </td>
                        </tr>
                        <tr>
                            <td>
                            </td>
                            <td>
                            </td>
                            <td>
                                WHT:
                            </td>
                            <td>
                                <asp:TextBox ID="txtWHT" onkeypress="return keyRestrict(event,'0123456789)" Style="border: solid 1px gray"
                                    runat="server" MaxLength="9"></asp:TextBox>
                                <%--                   <ajtk:FilteredTextBoxExtender ID="FilteredTextBoxExtender21" runat="server" TargetControlID="txtWHT"
                                FilterType="Numbers">
                            </ajtk:FilteredTextBoxExtender>--%>
                            </td>
                        </tr>
                        <tr>
                            <td>
                            </td>
                            <td>
                            </td>
                            <td>
                            </td>
                            <td align="left">
                                <asp:Button ID="btnRecableSave" Text="Save" Style="border: solid 1px gray" OnClientClick="return SaveReceivables();"
                                    runat="server" />
                                &nbsp;
                                <asp:Button ID="btnRecableClear" Text="New" Style="border: solid 1px gray" OnClientClick="return clearReceivables();"
                                    runat="server" />
                                &nbsp;
                                <asp:Button ID="btnRecableDetails" Text="Details" Style="border: solid 1px gray"
                                    runat="server" OnClick="btnRecableDetails_Click" />
                                &nbsp;
                                <asp:Button ID="btnRecableUpdate" Text="Update" Style="border: solid 1px gray" Visible="false"
                                    OnClientClick="return updateReceivables();" runat="server" />
                            </td>
                        </tr>
                    </table>
                </fieldset>
            </div>
        </div>
        <div id="tabs-3">
            <fieldset id="fldDisbSummary" style="width: 780px" runat="server">
                <legend>Available Amount</legend>
                <table style="width: 50%;">
                    <tr>
                        <td align="left">
                            Branch:
                        </td>
                        <td align="left">
                            <asp:DropDownList ID="ddlBranch" Style="width: 115px" runat="server">
                            </asp:DropDownList>
                        </td>
                        <td align="left">
                            <asp:Button ID="btnAmtB" Text="Amount" Style="border: solid 1px gray" OnClientClick="return DisbBranch();"
                                runat="server" />
                        </td>
                        <td>
                            <asp:TextBox ID="txtAmountSumB" ReadOnly="true" runat="server"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td align="left">
                            Employee:
                        </td>
                        <td align="left">
                            <asp:DropDownList ID="ddlEmployee" Style="width: 115px" runat="server">
                            </asp:DropDownList>
                        </td>
                        <td align="left">
                            <asp:Button ID="btnAmtE" Text="Amount" Style="border: solid 1px gray" OnClientClick="return DisbEmployee();"
                                runat="server" />
                        </td>
                        <td>
                            <asp:TextBox ID="txtAmountSumE" ReadOnly="true" runat="server"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            Amount:
                        </td>
                        <td>
                            <asp:TextBox ID="txtTotalAmt" ReadOnly="true" runat="server"></asp:TextBox>
                        </td>
                        <td>
                            <asp:Button ID="btnTotalAmtDisb" Text="Amount" Style="border: solid 1px gray" OnClientClick="return SummaryDisbTotal();"
                                runat="server" />
                        </td>
                    </tr>
                </table>
            </fieldset>
        </div>
        <div id="tabs-4">
            <fieldset id="fldSettings" style="width: 780px; margin-top: 5px">
                <legend>Settings Form</legend>
                <table style="width: 100%">
                    <tr>
                        <td width="120px" align="left">
                            Project:
                        </td>
                        <td colspan="3" width="350px" align="left">
                            <asp:TextBox runat="server" ID="txtAddProject" onkeypress="return keyRestrict(event,'abcdefghijklmnopqrstuvwxyz0123456789 -')"
                                Style="border: solid 1px gray" MaxLength="11"></asp:TextBox>
                            &nbsp;<asp:Button ID="btnAddProject" runat="server" Text="Add" OnClientClick="return SaveProject()"
                                Style="border: solid 1px gray" Width="30px" />
                        </td>
                        <td>
                        </td>
                        <td style="white-space: nowrap; text-align: right" align="left">
                            Expense Category:
                        </td>
                        <td colspan="2" align="left">
                            <asp:TextBox runat="server" ID="txtExpenseCategory" onkeypress="return keyRestrict(event,'abcdefghijklmnopqrstuvwxyz0123456789 -')"
                                Style="border: solid 1px gray" MaxLength="11"></asp:TextBox>
                            <asp:Button ID="btnAddExpCatagory" runat="server" OnClientClick="return SaveExpenseCategory();"
                                Text="Add" Style="border: solid 1px gray" Width="30px" />
                        </td>
                    </tr>
                    <tr>
                        <td style="white-space: nowrap" align="left">
                            Expense Type:
                        </td>
                        <td align="left" colspan="3" style="width: 350px">
                            <asp:TextBox runat="server" ID="txtExpenseType" onkeypress="return keyRestrict(event,'abcdefghijklmnopqrstuvwxyz0123456789 -')"
                                Style="border: solid 1px gray"></asp:TextBox>
                            &nbsp;<asp:DropDownList ID="ddlExpenseType0" runat="server" Style="border: solid 1px gray">
                            </asp:DropDownList>
                            <asp:Button ID="btnAddExpense" runat="server" OnClientClick="return SaveExpenseType();"
                                Text="Add" Style="border: solid 1px gray" Width="30px" />
                        </td>
                        <td>
                        </td>
                        <td style="white-space: nowrap" align="left">
                            Approval Authority:
                        </td>
                        <td colspan="2" align="left">
                            <asp:TextBox runat="server" ID="ApprovalAuthority" onkeypress="return keyRestrict(event,'abcdefghijklmnopqrstuvwxyz0123456789 -')"
                                Style="border: solid 1px gray" MaxLength="11"></asp:TextBox>
                            <asp:Button ID="btnAddAU" Width="30px" runat="server" Text="Add" OnClientClick="return SaveApprovalAuthority();"
                                Style="border: solid 1px gray" />
                        </td>
                    </tr>
                    <tr>
                        <td align="left">
                            <span>Payment Nature:</span>
                        </td>
                        <td align="left">
                            <asp:TextBox runat="server" ID="txtPaymentNature" onkeypress="return keyRestrict(event,'abcdefghijklmnopqrstuvwxyz0123456789 -')"
                                Style="border: solid 1px gray" MaxLength="11"></asp:TextBox>
                            &nbsp;<asp:Button ID="btnAdd" runat="server" Text="Add" OnClientClick="return SavePaymentNature()"
                                Style="border: solid 1px gray" Width="30px" Height="16px" />
                        </td>
                        <td colspan="3">
                        </td>
                        <td style="white-space: nowrap" align="left">
                            Received From
                        </td>
                        <td align="right" colspan="2">
                            <asp:TextBox ID="txtReceivedFrom" onkeypress="return keyRestrict(event,'abcdefghijklmnopqrstuvwxyz0123456789 -')"
                                Style="border: solid 1px gray" runat="server" MaxLength="11"></asp:TextBox>
                            <asp:Button ID="btnSaveReceivedFrom" runat="server" Text="Add" Width="30px" Style="border: solid 1px gray"
                                OnClientClick="return SaveReceivedFrom();" />
                        </td>
                    </tr>
                    <tr>
                        <td colspan="8" style="display: none;">
                            <asp:Button ID="Button2" runat="server" Text="Clear" Width="75px" Style="border: solid 1px gray"
                                OnClientClick="return clearSett();" />
                        </td>
                    </tr>
                </table>
            </fieldset>
        </div>
    </div>

    <script type="text/javascript" language="javascript">
        $(document).ready(function() {
            $("#lblCashInHandAmount").html($("input[id$='txtCashInHand']").val())
            $("td").css("text-align", "left");
            $("#fldRecpt td").css("text-align", "left");

            if ($("span[id$='lblExpID']").text() == "") {
                $("input[id$='btnSaveExpense']").show();
                $("input[id$='btnExpUpdate']").hide();
            }
            else {
                $("input[id$='btnExpUpdate']").show();
                $("input[id$='btnSaveExpense']").hide();
            }
            $('.currency').blur(function() {
                $('.currency').formatCurrency();
            });



        });


        function SaveReciept() {
            SaveReciept_Inward();

            return false;

        }

        function SaveReciept_Inward() {

            var txtReceiptDate = $("input[id$='txtReceiptDate']").val();
            var txtReceiptAmount = $("input[id$='txtReceiptAmount']").val();
            var txtReceivedBy = $("select[id$='ddlReceivedBy'] option:selected").val();

            var ddlReceiveFromCat = $("select[id$='ddlReceiveFrom0'] option:selected").val();

            var ddlReceiveFrom = $("select[id$='ddlReceiveFrom'] option:selected").val();
            var ddlReceiveFromPro = $("select[id$='ddlReciveFromPro'] option:selected").val();


            var ddlModeOfPayment = $("select[id$='ddlModeOfPayment'] option:selected").val();
            var ddlProjecName = $("select[id$='ddlProjecName'] option:selected").val();
            var ddlNatureOfPayment = $("select[id$='ddlPaymentNature'] option:selected").val();

            if (txtReceiptDate == "") {
                alert("Please enter receipt date!");
                $("input[id$='txtReceiptDate']").focus();
                return false;
            }
            if (txtReceiptAmount == "") {
                alert("Please enter receipt amount!");
                $("input[id$='txtReceiptAmount']").focus();
                return false;
            }
            if (txtReceivedBy == "") {
                alert("Please enter receipt by!");
                $("input[id$='txtReceivedBy']").focus();
                return false;
            }

            //ddlReceiveFromCat

            if (ddlReceiveFromCat == "") {
                alert("Please select receive from category!");
                $("select[id$='ddlReceiveFrom0']").focus();
                return false;
            }
            if (ddlReceiveFrom == "" && ddlReceiveFromPro == "") {
                alert("Please select receive from!");
                $("select[id$='ddlReceiveFrom']").focus();
                return false;
            }
            if (ddlModeOfPayment == "") {
                alert("Please select mode of payment!");
                $("select[id$='ddlModeOfPayment']").focus();
                return false;
            }
            if (ddlProjecName == "") {
                alert("Please select project name!");
                $("select[id$='ddlProjecName']").focus();
                return false;
            }

            if ($("input[id$='txtReceiptAmount']").val() != $("input[id$='txtDesbursedAmt_Inward']").val()) {
                alert("Receipt Amount and Disburse Amount Should be same!")
                return false;

            }


            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "ReceiptsAndExpense.aspx/SaveReceiptInformation",
                data: "{'txtReceiptDate':'" + txtReceiptDate + "','txtReceiptAmount':'" + txtReceiptAmount + "','txtReceivedBy':'" + txtReceivedBy + "','ddlReceiveFrom':'" + ddlReceiveFrom + "','ddlModeOfPayment':'" + ddlModeOfPayment + "','ddlProjecName':'" + ddlProjecName + "','ddlNatureOfPayment':'" + ddlNatureOfPayment + "'}",
                dataType: "json",
                success: onsuccessSaveData2,
                error: OnretrieveError
            });
            return false;

        }

        function onsuccessSaveData2() {
            return DisbusedData_Inward();
            clearRecpt();
        }

        function DisbusedData_Inward() {
            var ddlDispersedTo = $("select[id$='ddlDisbursedTo_Inward'] option:selected").val();
            var ddlDispersedBy = $("select[id$='ddlDisbursedBy_Inward'] option:selected").val();
            var ddlDispersionMethod = $("select[id$='ddlDisbursionMethod_Inward'] option:selected").val();
            var txtDispersedAmt = $("input[id$='txtDesbursedAmt_Inward']").val();

            if (ddlDispersedTo == "") {
                alert("Please select dispersed to!");
                $("select[id$='ddlDispersedTo'] option:selected").focus();
                return false;
            }
            if (ddlDispersedBy == "") {
                alert("Please select dispersed by!");
                $("select[id$='ddlDispersedBy'] option:selected").focus();
                return false;
            }
            if (ddlDispersionMethod == "") {
                alert("Please select dispersed methoed!");
                $("select[id$='ddlDispersionMethod'] option:selected").focus();
                return false;
            }
            if (ddlDispersedBy == "") {
                alert("Please select dispersed by!");
                $("select[id$='ddlDisbursedBy_Inward'] option:selected").focus();
                return false;
            }


            if (txtDispersedAmt == "") {
                alert("Please enter dispersed amount!");
                $("input[id$='txtDispersedAmt']").focus();
                return false;
            }
            $.ajax({
                type: "POST",
                dataType: "json",
                contentType: "application/json; charset=utf-8",
                url: "ReceiptsAndExpense.aspx/SaveCashDispersement",
                data: "{'ddlDispersedTo':'" + ddlDispersedTo + "', 'ddlDispersedBy':'" + ddlDispersedBy + "', 'ddlDispersionMethod':'" + ddlDispersionMethod + "', 'txtDispersedAmt':'" + txtDispersedAmt + "'}",
                success: onsuccessSaveDispersment,
                error: OnretrieveError
            });
            return false;
        }

        function gotoDetails() {

            var userID = $("input[id$='txtReceiptDate']").val().trim();
            //window.location = '../../MCTX_General/Login.aspx?userID='+userID; 


            window.open('FrmReciptsDetails.aspx?userID=' + userID, null, ' top=50,left=200,center=yes,resizable=no,Width=850px,Height= 700px,status=no,titlebar=no;toolbar=no,menubar=no,location=0,scrollbars=yes');
            return false;
            //window.open


        }



        //------------------------------------------Add Expense Category---------------------------------------------------------------

        function SaveExpenseCategory() {
            var txtExpenseCategory = $("input[id$='txtExpenseCategory']").val();

            if (txtExpenseCategory == "") {
                alert("Please enter expense category!");
                $("input[id$='txtExpenseCategory']").focus();
                return false;
            }
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "ReceiptsAndExpense.aspx/SaveExpCatName",
                data: "{'txtExpenseCategory':'" + txtExpenseCategory + "'}",
                dataType: "json",
                success: onsuccessSaveData,
                error: OnretrieveError
            });
            return false;

        }

        //------------------------------------------------------------------------------------------------------------------------------

        //------------------------------------------Add Expense Type---------------------------------------------------------------

        function SaveExpenseType() {
            var txtExpenseType = $("input[id$='txtExpenseType']").val();

            if (txtExpenseType == "") {
                alert("Please enter expense type!");
                $("input[id$='txtExpenseType']").focus();
                return false;
            }
            var ExpenseCatId = $("select[id$='ddlExpenseType0'] option:selected").val();
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "ReceiptsAndExpense.aspx/SaveExpTypeName",
                data: "{'txtExpenseType':'" + txtExpenseType + "','ExpenseCatId':'" + ExpenseCatId + "'}",
                dataType: "json",
                success: onsuccessSaveData,
                error: OnretrieveError
            });
            return false;

        }

        //------------------------------------------------------------------------------------------------------------------------------

        //------------------------------------------Add Approval Authority---------------------------------------------------------------

        function SaveApprovalAuthority() {

            var txtApprovalAut = $("input[id$='ApprovalAuthority']").val();
            if (txtApprovalAut == "") {
                alert("Please enter approval authority!");
                $("input[id$='ApprovalAuthority']").focus();
                return false;
            }

            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "ReceiptsAndExpense.aspx/SaveApprovalAuthority",
                data: "{'txtApprovalAut':'" + txtApprovalAut + "'}",
                dataType: "json",
                success: onsuccessSaveData,
                error: OnretrieveError
            });
            return false;

        }

        //-------------------------------------------------------Add Received From ------------------------------------------------------
        function SaveReceivedFrom() {

            var txtReceivedFrom = $("input[id$='txtReceivedFrom']").val();
            if (txtReceivedFrom == "") {
                alert("Please enter approval authority!");
                $("input[id$='txtReceivedFrom']").focus();
                return false;
            }

            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "ReceiptsAndExpense.aspx/SaveReceivedFrom",
                data: "{'txtReceivedFrom':'" + txtReceivedFrom + "'}",
                dataType: "json",
                success: onsuccessSaveData,
                error: OnretrieveError
            });
            return false;

        }

        //------------------------------------------Bind Expense Type added By Tahir------------------------------------------------

        function BindExpenseType() {

            var catID = $("select[id$='ddlExpenseCategory'] option:selected").val();

            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "ReceiptsAndExpense.aspx/GetExpenseType",
                data: "{'catID':'" + catID + "'}",
                dataType: "json",
                success: onsuccessPopulateExpenseTypeDate,
                error: OnretrieveError
            });
            return false;

        }

        function onsuccessPopulateExpenseTypeDate(msg) {
            $("select[id$='ddlExpenseType']").empty();
            var data = msg.d;

            for (var i = 0; i < data.Act_ExpenseType.length; i++) {
                $("select[id$='ddlExpenseType']").append('<option value=' + data.Act_ExpenseType[i].expenseType_id + '>' + data.Act_ExpenseType[i].ExpenseType_Name + '</option>');
            }

        }

        //-------------------------------------------------Add Expense-------------------------------------------------------------------

        function SaveExpense() {

            var txtExpenseDate = $("input[id$='txtExpenseDate']").val();
            var TextExpenseAmt = $("input[id$='TextExpenseAmt']").val();
            var txtExpDetails = $("textarea[id$='txtExpDetails']").val();
            var ddlExpenseCategory = $("select[id$='ddlExpenseCategory'] option:selected").val();
            var ddlExpenseType = $("select[id$='ddlExpenseType'] option:selected").val();
            var ddlPaymentMode = $("select[id$='ddlPaymentMode'] option:selected").val();
            var ddlProjectName = $("select[id$='ddlProjectName'] option:selected").val();
            var ddlExpStatus = $("select[id$='ddlExpStatus'] option:selected").val();
            var ddlApprovalStatus = $("select[id$='DropDownList4'] option:selected").val();
            var ddlApprovingAuthority = $("select[id$='ddlApprovingAuthority'] option:selected").val();


            if (txtExpenseDate == "") {
                alert("Please enter expense date!");
                $("input[id$='txtExpenseDate']").focus();
                return false;
            }
            if (TextExpenseAmt == "") {
                alert("Please enter expense amount!");
                $("input[id$='TextExpenseAmt']").focus();
                return false;
            }
            if (txtExpDetails == "") {
                alert("Please enter expense details!");
                $("input[id$='txtExpDetails']").focus();
                return false;
            }
            if (ddlExpenseCategory == "") {
                alert("Please select expense category!");
                $("select[id$='ddlExpenseCategory'] option:selected").focus();
                return false;
            }
            if (ddlExpenseType == "") {
                alert("Please add expense type from Settings!");
                $("select[id$='ddlExpenseType'] option:selected").focus();
                return false;
            }
            if (ddlPaymentMode == "") {
                alert("Please select payment mode!");
                $("select[id$='ddlPaymentMode'] option:selected").focus();
                return false;
            }
            if (ddlProjectName == "") {
                alert("Please select project name!");
                $("select[id$='ddlProjectName'] option:selected").focus();
                return false;
            }
            if (ddlExpStatus == "") {
                alert("Please select expense status!");
                $("select[id$='ddlExpStatus'] option:selected").focus();
                return false;
            }
            if (ddlApprovalStatus == "") {
                alert("Please select approved status!");
                $("select[id$='DropDownList4'] option:selected").focus();
                return false;
            }
            if (ddlApprovingAuthority == "" && $("select[id$='DropDownList4']").val() == "Prior Approved") {
                alert("Please select approving authority!");
                $("select[id$='ddlApprovingAuthority']").focus();
                return false;
            }
            if (parseInt($("input[id$='txtCashInHand']").val()) < parseInt($("input[id$='TextExpenseAmt']").val())) {
                alert("Expense cannot be greater than Cash in Hand!");
                $("select[id$='TextExpenseAmt'] option:selected").focus();
                return false;
            }

            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "ReceiptsAndExpense.aspx/SaveExpense",
                data: "{'txtExpenseDate':'" + txtExpenseDate + "','TextExpenseAmt':'" + TextExpenseAmt + "','txtExpDetails':'" + txtExpDetails + "','ddlExpenseCategory':'" + ddlExpenseCategory + "','ddlExpenseType':'" + ddlExpenseType + "','ddlPaymentMode':'" + ddlPaymentMode + "','ddlProjectName':'" + ddlProjectName + "','ddlExpStatus':'" + ddlExpStatus + "', 'ddlApprovalStatus':'" + ddlApprovalStatus + "','ddlApprovingAuthority':'" + ddlApprovingAuthority + "'}",
                dataType: "json",
                success: onsuccessSaveData,
                error: OnretrieveError
            });
            return false;

        }

        function ExpenseDetailsPage() {


            var userID = $("input[id$='txtReceiptDate']").val().trim();
            //window.location = '../../MCTX_General/Login.aspx?userID='+userID; 


            window.open('../../MCTX_Internal/SuperAdmin/FrmExpenseDetails.aspx?userID=' + userID, null, ' top=50,left=200,center=yes,resizable=no,Width=850px,Height= 700px,status=no,titlebar=no;toolbar=no,menubar=no,location=0,scrollbars=yes');
            return false;
            //window.open


        }

        //------------------------------------------------------------------------------------------------------------------------------

        function onsuccessSaveData() {
            alert("Data Successfully Saved!");
            clearExp();
        }
        function OnretrieveError() {
            alert("Error occured in Saving Data!");
            clearExp();
        }


        function SaveProject() {

            var txtProjectName = $("input[id$='txtAddProject']").val();
            if (txtProjectName == "") {
                alert("Please enter Project name!");
                $("input[id$='txtAddProject']").focus();
                return false;
            }

            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "ReceiptsAndExpense.aspx/SaveProjectName",
                data: "{'txtProjectName':'" + txtProjectName + "'}",
                dataType: "json",
                success: onsuccessSaveProjectData,
                error: OnretrieveErrorProject
            });
            return false;

        }



        //////Save dispersaement

        function saveDispersement() {

            var ddlDispersedTo = $("select[id$='ddlDispersedTo'] option:selected").val();
            var ddlDispersedBy = $("select[id$='ddlDispersedBy'] option:selected").val();
            var ddlDispersionMethod = $("select[id$='ddlDispersionMethod'] option:selected").val();
            var txtDispersedAmt = $("input[id$='txtDispersedAmt']").val();

            if (ddlDispersedTo == "") {
                alert("Please select dispersed to!");
                $("select[id$='ddlDispersedTo']").focus();
                return false;
            }
            if (ddlDispersedBy == "") {
                alert("Please select dispersed by!");
                $("select[id$='ddlDispersedBy']").focus();
                return false;
            }
            if (ddlDispersionMethod == "") {
                alert("Please select dispersed methoed!");
                $("select[id$='ddlDispersionMethod']").focus();
                return false;
            }
            if (txtDispersedAmt == "") {
                alert("Please enter dispersed amount!");
                $("input[id$='txtDispersedAmt']").focus();
                return false;
            }
            $.ajax({
                type: "POST",
                dataType: "json",
                contentType: "application/json; charset=utf-8",
                url: "ReceiptsAndExpense.aspx/SaveCashDispersement",
                data: "{'ddlDispersedTo':'" + ddlDispersedTo + "', 'ddlDispersedBy':'" + ddlDispersedBy + "', 'ddlDispersionMethod':'" + ddlDispersionMethod + "', 'txtDispersedAmt':'" + txtDispersedAmt + "'}",
                success: onsuccessSaveDispersment,
                error: OnretrieveError
            });
            return false;
        }



        function onsuccessSaveDispersment() {
            alert("Dispersement Added Successfully! ");
            clearDisp();
        }

        function onsuccessSaveProjectData() {
            alert("Project Added Successfully! ");
        }
        function OnretrieveErrorProject() {
            alert("Error occured in Project Saving! ");
        }


        ///////clear functions

        function clearRecpt() {
            $("#fldRecpt input[type='text'],select").val("");
            return false;
        }

        function clearDisp() {
            $("#fldDespesement input[type='text'],select").val("");
            $("input[id$='btnCashDisSave']").hide()
            return false;
        }

        function clearSett() {
            $("#fldSettings input[type='text'],select").val("");
            return false;
        }

        function clearExp() {
            $("select[id$='ddlExpenseType']").empty();
            $("#fldExpense input[type='select'], select").val("");
            $("input[id$='txtExpenseDate']").val("");
            $("input[id$='TextExpenseAmt']").val("");
            $("textarea[id$='txtExpDetails']").val("");
            $("select[id$='ddlApprovingAuthority']").attr("disabled", false);

            return false;
        }

        ///////


        ///////////////UpdateExpense
        function updateExpense() {
            var txtExpenseDate = $("input[id$='txtExpenseDate']").val();
            var TextExpenseAmt = $("input[id$='TextExpenseAmt']").val();
            var txtExpDetails = $("textarea[id$='txtExpDetails']").val();
            var ddlExpenseCategory = $("select[id$='ddlExpenseCategory'] option:selected").val();
            var ddlExpenseType = $("select[id$='ddlExpenseType'] option:selected").val();
            var ddlPaymentMode = $("select[id$='ddlPaymentMode'] option:selected").val();
            var ddlProjectName = $("select[id$='ddlProjectName'] option:selected").val();
            var ddlExpStatus = $("select[id$='ddlExpStatus'] option:selected").val();
            var ddlApprovalStatus = $("select[id$='DropDownList4'] option:selected").val();
            var ddlApprovingAuthority = $("select[id$='ddlApprovingAuthority'] option:selected").val();
            var expID = $("span[id$='lblExpID']").text();

            if (txtExpenseDate == "") {
                alert("Please enter expense date!");
                $("input[id$='txtExpenseDate']").focus();
                return false;
            }
            if (TextExpenseAmt == "") {
                alert("Please enter expense amount!");
                $("input[id$='TextExpenseAmt']").focus();
                return false;
            }
            if (ddlExpenseCategory == "") {
                alert("Please select expense category!");
                $("select[id$='ddlExpenseCategory']").focus();
                return false;
            }
            if (ddlExpenseType == "") {
                alert("Please add expense type from Settings!");
                $("select[id$='ddlExpenseType']").focus();
                return false;
            }
            if (ddlPaymentMode == "") {
                alert("Please select payment mode!");
                $("select[id$='ddlPaymentMode']").focus();
                return false;
            }
            if (ddlProjectName == "") {
                alert("Please select project name!");
                $("select[id$='ddlProjectName']").focus();
                return false;
            }
            if (ddlExpStatus == "") {
                alert("Please select expense status!");
                $("select[id$='ddlExpStatus']").focus();
                return false;
            }
            if (ddlApprovalStatus == "") {
                alert("Please select approved status!");
                $("select[id$='DropDownList4']").focus();
                return false;
            }
            if (ddlApprovingAuthority == "" && $("select[id$='DropDownList4']").val() == "Prior Approved") {
                alert("Please select approving authority!");
                $("select[id$='ddlApprovingAuthority']").focus();
                return false;
            }
            if (expID == "") {
                alert("Canot be updated!");
                return false;
            }

            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "ReceiptsAndExpense.aspx/UpdateExpense",
                data: "{'expID':'" + expID + "','txtExpenseDate':'" + txtExpenseDate + "','TextExpenseAmt':'" + TextExpenseAmt + "','txtExpDetails':'" + txtExpDetails + "','ddlExpenseCategory':'" + ddlExpenseCategory + "','ddlExpenseType':'" + ddlExpenseType + "','ddlPaymentMode':'" + ddlPaymentMode + "','ddlProjectName':'" + ddlProjectName + "','ddlExpStatus':'" + ddlExpStatus + "', 'ddlApprovalStatus':'" + ddlApprovalStatus + "','ddlApprovingAuthority':'" + ddlApprovingAuthority + "'}",
                dataType: "json",
                success: onsuccessSaveData,
                error: OnretrieveError
            });
            return false;
        }

        ////////////////////////////

        //------------------------------------------------------------------------------------------------------------------------------


        //-------------------------------------------------Update Receipts--------------------------------------------------------------
        function updateReceipts() {
            var Recp_Id = $("span[id$='lblRecp_Id']").text();
            var Rep_Date = $("input[id$='txtReceiptDate']").val();
            var Rcp_Amount = $("input[id$='txtReceiptAmount']").val();
            var Rcp_Recievedby = $("select[id$='ddlReceivedBy'] option:selected").text();
            var Rcp_Receivedfrom = $("select[id$='ddlReceiveFrom'] option:selected").text();
            var Rcp_PaymentMode = $("select[id$='ddlModeOfPayment'] option:selected").text();
            var Rcp_ForProject = $("select[id$='ddlProjecName'] option:selected").val();

            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "ReceiptsAndExpense.aspx/UpdateReceiptData",
                data: "{'Recp_Id':'" + Recp_Id + "','Rep_Date':'" + Rep_Date + "','Rcp_Amount':'" + Rcp_Amount + "','Rcp_Recievedby':'" + Rcp_Recievedby + "','Rcp_Receivedfrom':'" + Rcp_Receivedfrom + "','Rcp_PaymentMode':'" + Rcp_PaymentMode + "','Rcp_ForProject':'" + Rcp_ForProject + "'}",
                dataType: "json",
                success: onsuccessUpdateReceiptData,
                error: OnretrieveErrorUpdate
            });
            return false;
        }

        function onsuccessUpdateReceiptData() {
            alert("Update successful!");
        }

        function OnretrieveErrorUpdate() {
            alert("Error in update!");
        }

        //------------------------------------------------------------------------------------------------------------------------------


        //-------------------------------------------------Update Disbursement-----------------------------------------------------------

        function updateDispData() {

            var Desp_Id = $("span[id$='lblDesp_Id']").text();
            var PreDesp_To = $("span[id$='lblPreDisburseTo']").text();
            var Desp_To = $("[id*='ddlDispersedTo'] :selected").val();
            //var Desp_To =$("select[id$='ddlDispersedTo'] option:selected").val();
            var Desp_By = $("select[id$='ddlDispersedBy'] option:selected").val();
            var Desp_Method = $("select[id$='ddlDispersionMethod'] option:selected").val();
            var Desp_Amount = $("input[id$='txtDispersedAmt']").val();

            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "ReceiptsAndExpense.aspx/UpdateDespData",
                data: "{'Desp_Id':'" + Desp_Id + "','PreDesp_To':'" + PreDesp_To + "','Desp_To':'" + Desp_To + "','Desp_By':'" + Desp_By + "','Desp_Method':'" + Desp_Method + "','Desp_Amount':'" + Desp_Amount + "'}",
                dataType: "json",
                success: onsuccessUpdateDespData,
                error: onretrieveErrorDespUpdate
            });
            return false;
        }

        function onsuccessUpdateDespData() {
            alert("Update successful!");
        }

        function onretrieveErrorDespUpdate() {
            alert("Error in update!");
        }

        //------------------------------------------------------------------------------------------------------------------------------

        //------------------------------------------------------------------------------------------------------------------------------

        ///////Show/ Hide Fieldsets////////////////

        function showRecieptAndDispersmetn() {
            $("fieldset[id$='fldRecpt']").hide();
            $("fieldset[id$='fldDespesement']").hide();
        }


        function hideRecieptAndDispersmetn() {
            $("fieldset[id$='fldRecpt']").show();
            $("fieldset[id$='fldDespesement']").show();
        }
        //-----------------------------------------------------------------Add Payment Nature-------------------------------------------

        function SavePaymentNature() {
            var PaymentNature = $("input[id$='txtPaymentNature']").val();
            if (PaymentNature == "") {
                alert("Please enter payment nature!");
                $("input[id$='txtPaymentNature']").focus();
                return false;
            }

            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "ReceiptsAndExpense.aspx/InsertPaymentNature",
                data: "{'PaymentNature':'" + PaymentNature + "'}",
                dataType: "json",
                success: onsuccessSaveData,
                error: OnretrieveError
            });
            return false;

        }
        /////////////////////////////////////////////


        //-------------------------------------------------Add Receivables---------------------------------------------------------------
        function SaveReceivables() {
            var InvoiceTo = $("select[id$='ddlInvoiceTo'] option:selected").val();
            var InvoiceAmount = $("input[id$='txtInvoiceAmt']").val();
            var InvoiceDate = $("input[id$='txtInvoiceDate']").val();
            var PaymentDueon = $("input[id$='txtPaymentDueon']").val();
            var InvoiceNo = $("input[id$='txtInvoiceNo']").val();
            var PONumber = $("input[id$='txtPONumber']").val();
            var PODate = $("input[id$='txtPODate']").val();
            var GST = $("input[id$='GST']").val();
            var WHT = $("input[id$='WHT']").val();
            if (InvoiceTo == "") {
                alert("Please select Invoice To!");
                $("select[id$='ddlInvoiceTo'] option:selected").focus();
                return false;
            }
            if (InvoiceAmount == "") {
                alert("Please Enter Amount!");
                $("input[id$='txtInvoiceAmt']").focus();
                return false;
            }
            if (InvoiceDate == "") {
                alert("Please Enter Invoice Date!");
                $("input[id$='txtInvoiceDate']").focus();
                return false;
            }
            if (PaymentDueon == "") {
                alert("Please Enter Payment Due Date!");
                $("input[id$='txtPaymentDueon']").focus();
                return false;
            }
            if (PONumber == "") {
                alert("Please Enter Purchase Order Number!");
                $("input[id$='txtPONumber']").focus();
                return false;
            }
            if (PODate == "") {
                alert("Please Enter Purchase Order Date!");
                $("input[id$='PODate']").focus();
                return false;
            }
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "ReceiptsAndExpense.aspx/SaveReceivables",
                data: "{'InvoiceTo':'" + InvoiceTo + "','InvoiceAmount':'" + InvoiceAmount + "','InvoiceDate':'" + InvoiceDate + "','PaymentDueon':'" + PaymentDueon + "','InvoiceNo':'" + InvoiceNo + "','PONumber':'" + PONumber + "','PODate':'" + PODate + "','GST':'" + GST + "','WHT':'" + WHT + "'}",
                dataType: "json",
                success: onsuccessSaveReceivables,
                error: onretrieveErrorSaveReceivables
            });
            return false;

        }

        function onsuccessSaveReceivables() {
            alert("Record Added Successfully!");
            clearReceivables();
        }

        function onretrieveErrorSaveReceivables() {
            alert("Error in Adding Record!");
        }
        function clearReceivables() {
            $("#fldReceive input[type='text'],select").val("");
            return false;
        }

        //---------------------------------------------------------Update Receivables----------------------------------------------------

        function updateReceivables() {
            var InvoiceID = $("span[id$='lblRecievableID']").text();
            var InvoiceTo = $("[id*='ddlInvoiceTo'] :selected").val();
            var InvoiceAmount = $("input[id$='txtInvoiceAmt']").val();
            var InvoiceDate = $("input[id$='txtInvoiceDate']").val();
            var PaymentDueon = $("input[id$='txtPaymentDueon']").val();
            var InvoiceNo = $("input[id$='txtInvoiceNo']").val();
            var PONumber = $("input[id$='txtPONumber']").val();
            var PODate = $("input[id$='txtPODate']").val();
            var GST = $("input[id$='GST']").val();
            var WHT = $("input[id$='WHT']").val();
            if (InvoiceTo == "") {
                alert("Please select Invoice To!");
                $("select[id$='ddlInvoiceTo'] option:selected").focus();
                return false;
            }
            if (InvoiceAmount == "") {
                alert("Please Enter Amount!");
                $("input[id$='txtInvoiceAmt']").focus();
                return false;
            }
            if (InvoiceDate == "") {
                alert("Please Enter Invoice Date!");
                $("input[id$='txtInvoiceDate']").focus();
                return false;
            }
            if (PaymentDueon == "") {
                alert("Please Enter Payment Due Date!");
                $("input[id$='txtPaymentDueon']").focus();
                return false;
            }
            if (PONumber == "") {
                alert("Please Enter Purchase Order Number!");
                $("input[id$='txtPONumber']").focus();
                return false;
            }
            if (PODate == "") {
                alert("Please Enter Purchase Order Date!");
                $("input[id$='PODate']").focus();
                return false;
            }
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "ReceiptsAndExpense.aspx/UpdateReceivables",
                data: "{'InvoiceID':'" + InvoiceID + "','InvoiceTo':'" + InvoiceTo + "','InvoiceAmount':'" + InvoiceAmount + "','InvoiceDate':'" + InvoiceDate + "','PaymentDueon':'" + PaymentDueon + "','InvoiceNo':'" + InvoiceNo + "','PONumber':'" + PONumber + "','PODate':'" + PODate + "','GST':'" + GST + "','WHT':'" + WHT + "'}",
                dataType: "json",
                success: onsuccessUPDReceivables,
                error: onretrieveErrorUPDReceivables
            });
            return false;
        }
        function onsuccessUPDReceivables() {
            alert("Record Update Successfully!");
            clearReceivables();
        }

        function onretrieveErrorUPDReceivables() {
            alert("Error in Updating Record!");
        }

        //-------------------------------------------------------------------------------------------------------------------------------    


        //----------------------------------------------------------Enable disable ddl---------------------------------------------------

        function EnableDisableDDL() {
            if ($("select[id$='DropDownList4'] option:selected").val() == "Not Approved") {
                $("select[id$='ddlApprovingAuthority']").attr("disabled", true);

            }
            else
                $("select[id$='ddlApprovingAuthority']").attr("disabled", false);

        }

        function EnableDisabledReceiveFromDDL() {
            if ($("select[id$='ddlReceiveFrom0'] option:selected").val() == "Project") {
                $("select[id$='ddlReciveFromPro'] option:selected").val("");
                $("select[id$='ddlReciveFromPro']").show();

                $("select[id$='ddlReceiveFrom']").hide();

            }

            else {
                $("select[id$='ddlReciveFromPro']").hide();
                $("select[id$='ddlReceiveFrom'] option:selected").val("");
                $("select[id$='ddlReceiveFrom']").show();
            }

        }
        ///////////////////////////////////////Disbursement Summary//////////////////////////////////////////////////  
        function DisbBranch() {

            var BranchID = $("select[id$='ddlBranch'] option:selected").val();
            if (BranchID == "") {
                alert("Please Select Branch!");
                return false;
            }
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "ReceiptsAndExpense.aspx/SummaryDisbB",
                data: "{'BranchID':'" + BranchID + "'}",
                dataType: "json",
                success: onsuccessShowSummaryDisbB,
                error: onretrieveErrorSummaryDisbB
            });
            return false;

        }
        function onsuccessShowSummaryDisbB(msg) {
            var data = msg.d;
            var SummaryDisbB = data;
            $("input[id$='txtAmountSumB']").val(SummaryDisbB);
            alert("Record Found!");
        }
        function onretrieveErrorSummaryDisbB() {
            alert("Record Not Found!");
        }
        function DisbEmployee() {
            var EmployeeID = $("select[id$='ddlEmployee'] option:selected").val();
            if (EmployeeID == "") {
                alert("Please Select Employee!");
                return false;
            }
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "ReceiptsAndExpense.aspx/SummaryDisbE",
                data: "{'EmployeeID':'" + EmployeeID + "'}",
                dataType: "json",
                success: onsuccessShowSummaryDisbE,
                error: onretrieveErrorSummaryDisbE
            });
            return false;

        }
        function onsuccessShowSummaryDisbE(msg1) {
            var data1 = msg1.d;
            var SummaryDisbE = data1;
            $("input[id$='txtAmountSumE']").val(SummaryDisbE);
            alert("Record Found!");
        }
        function onretrieveErrorSummaryDisbE() {
            alert("Record Not Found!");
        }

        function SummaryDisbTotal() {
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "ReceiptsAndExpense.aspx/SummaryDisbTotal",
                dataType: "json",
                data: "{}",
                success: onsuccessShowSummaryDisbTotal,
                error: onretrieveErrorSummaryDisbTotal
            });
            return false;

        }
        function onsuccessShowSummaryDisbTotal(msg2) {
            var data2 = msg2.d;
            var SummaryDisbTotal = data2;
            $("input[id$='txtTotalAmt']").val(SummaryDisbTotal);
            alert("Record Found!");
        }
        function onretrieveErrorSummaryDisbTotal() {
            alert("Record Not Found!");
        }


        ////////////////////////////////////////////////////////////////////////////////////////////////////////////

        //----------------------------Key Restrict Function added by Tahir Kazmi (17, Novemeber, 2011)------------


        function keyRestrict(e, validchars, casesensitives, onceevery, onceoneof) {

            onceevery = onceevery ? onceevery : "";
            onceoneof = onceoneof ? onceoneof : "";

            if (!validchars)
                return true;
            var key = '', keychar = '', obj = '', i = 0;
            var key = e.which ? e.which : window.event.keyCode;
            var obj = e.target ? e.target : window.event.srcElement;
            if (key == null)
                return true;
            keychar = String.fromCharCode(key);
            validchars = (validchars + onceevery + onceoneof);
            if (!casesensitives) {
                keychar = keychar.toLowerCase();
                validchars = validchars.toLowerCase();
                onceevery = onceevery.toLowerCase();
                onceoneof = onceoneof.toLowerCase();
            }
            for (i = 0; i < (onceevery + onceoneof).length; i++) {
                if (i < onceevery.length) {
                    if (obj.value.indexOf(onceevery.charAt(i)) != -1 && keychar == onceevery.charAt(i))
                        return false;
                }
                else {
                    if (obj.value.indexOf(onceoneof.charAt(i - onceevery.length)) != -1 && onceoneof.indexOf(keychar) != -1)
                        return false;
                }
            }

            if (validchars.indexOf(keychar) != -1)
                return true;

            if (key == null || key == 0 || key == 8 || key == 9 || key == 13 || key == 27)
                return true;
            return false;
        }
        ////////////////////////////////////////////////////////////////////////////////////////////////////////////     
        ////////////////////////////////////////////////////Refresh////////////////////////////////////////////////
        function refreshpage() {
            //window.location.reload();
            setTimeout("location.reload(true);", timeout);

        }
        ////////////////////////////////////////////////////////////////////////////////////////////////////////////


    </script>

</asp:Content>

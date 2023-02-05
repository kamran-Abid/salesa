<%@ Page Title="" Language="C#" MasterPageFile="~/MCTX_Internal/SuperAdmin/MasterAdmin.master"
    AutoEventWireup="true" CodeFile="ReceiptDetails.aspx.cs" Inherits="MCTX_Internal_SuperAdmin_ReceiptDetails" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script src="../../js/jquery.dataTables.min.js" type="text/javascript"></script>
    <script src="../../js/jquery.fixedheader.js" type="text/javascript"></script>
    <script src="../../js/BlockUI.js" type="text/javascript"></script>

    <style type="text/css">
        .dataTable
        {
            font-family: Verdana, Arial, Helvetica, sans-serif;
            border-collapse: collapse;
            border: 1px solid #999999;
            width: 100%;
            font-size: 12px;
        }
        .dataTable td, .dataTable th
        {
            border: 1px solid #999999;
            padding: 3px 5px;
            margin: 0px;
        }
        .dataTable thead th
        {
            background-color: #cccccc;
            color: #444444;
            font-weight: bold;
            text-align: left;
        }
        .dataTable thead a
        {
            text-decoration: none;
            color: #444444;
        }
        .dataTable thead a:hover
        {
            text-decoration: underline;
        }
        /* Firefox has missing border bug! https://bugzilla.mozilla.org/show_bug.cgi?id=410621 *//* Firefox 2 */html< /**/ /**/ body .dataTable, x:-moz-any-link
        {
            margin: 1px;
        }
        /* Firefox 3 */html< /**/ /**/ body .dataTable, x:-moz-any-link, x:default
        {
            margin: 1px;
        }
        .style2
        {
            width: 189px;
        }
        .style3
        {
            width: 149px;
        }
        .style4
        {
            width: 184px;
        }
    </style>
    <div id="tabs" style="width: 796">
        <ul>
            <li style="text-align: left"><a href="#tabs-1">Receivables Details</a></li>
        </ul>
        <div id="tabs-1">
            <fieldset id="fldRecp" style="margin-bottom: 15px">
                <legend>Search</legend>
                <table width="100%">
                    <tr>
                        <td align="left" width="83px">
                            Receipt ID:
                        </td>
                        <td align="left" width="162px">
                            <asp:TextBox ID="txtReceiptID" Width="162px" runat="server"></asp:TextBox>
                        </td>
                        <td align="left" width="50px">
                            <asp:Button ID="btnSearch" Text="Search" runat="server" OnClientClick="return false;" />
                        </td>
                        <td align="left" width="80px">
                            <asp:Button ID="btnClear" Text="Clear" runat="server" OnClientClick="return false;" />
                        </td>
                        <td align="right">
                            <a href="javascript:history.go(-1)">Back</a>
                        </td>
                    </tr>
                </table>
                <table width="100%">
                    <tr>
                        <td align="left" width="100%">
                            <asp:LinkButton ID="lnkAdvSearch" Text="Advanced Search" Style="color: Blue; text-decoration: underline"
                                OnClientClick="return openAdvancedSearch();" runat="server"></asp:LinkButton>
                        </td>
                    </tr>
                </table>
                <div id="divAdvanceSearch" style="display: none;">
                    <table width="100%">
                    </table>
                </div>
            </fieldset>
            <div style="overflow: auto; width: 990px;">
                <table align='center' id="tblReceiptDetails" class="dataTable" style="width: 1190px;">
                </table>
            </div>
        </div>
    </div>

    <script type="text/javascript" language="javascript">

        //--------------------------------------------------------------------Load Receipts-----------------by Obaid Altaf----------------//

        $(document).ready(function() {
            LoadReciepts();
        });
        function LoadReciepts() {
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "FrmReceivableDetails.aspx/LoadReciepts",
                data: "{}",
                success: onsuccess_LoadReceipts,
                error: onError_LoadReceipts
            });
            return false;
        }

        function onsuccess_LoadReceipts(msg) {
            var data = msg;
            var tblReceipts = "";

            tblReceipts += "<thead>";
            tblReceipts += "<tr>";
            tblReceipts += "<th style='text-align:center; white-space:nowrap;'>Delete</th>";
            tblReceipts += "<th style='text-align:center; white-space:nowrap;'>Edit</th>";
            tblReceipts += "<th style='white-space:nowrap; text-align:left;'>Recp_Id</th>";
            tblReceipts += "<th style='white-space:nowrap; text-align:left;'>Rcp_Recievedby</th>";
            tblReceipts += "<th style='white-space:nowrap; text-align:left;'>Rcp_Amount</th>";
            tblReceipts += "<th style='white-space:nowrap; text-align:left;'>Rcp_PaymentMode</th>";
            tblReceipts += "<th style='white-space:nowrap; text-align:left;'>Rcp_Receivedfrom</th>";
            tblReceipts += "<th style='white-space:nowrap; text-align:left;'>Rep_Date</th>";
            tblReceipts += "<th style='white-space:nowrap; text-align:left;'>Payment_Nature</th>";
            tblReceipts += "<th style='white-space:nowrap; text-align:left;'>Rcp_ForProject</th>";
            tblReceipts += "<th style='white-space:nowrap; text-align:left;'>Created By</th>";
            tblReceipts += "<th style='white-space:nowrap; text-align:left;'>Created Date</th>";
            tblReceipts += "<th style='white-space:nowrap; text-align:left;'>Modified By</th>";
            tblReceipts += "<th style='white-space:nowrap; text-align:left;'>Modified Date</th>";
            tblReceipts += "</tr>";
            tblReceipts += "</thead>";
            tblReceipts += "<tbody>";
            for (var i = 0; i < data.ReceiptsDetails.length; i++) {

                var Rep_Date = ConvertDate(data.ReceiptsDetails[i].Rep_Date);
                var CreatedDate = ConvertDate(data.ReceiptsDetails[i].Created_Date);
                var mdate = ConvertDate(data.ReceiptsDetails[i].Modified_Date);

                tblReceipts += "<td style='cursor:Pointer;' id='txtdelete' align='center' onclick='return DeleteRecord(" + i + ");'><img src='image/Cross.png'> </td>";
                tblReceipts += "<td style='cursor:Pointer;' id='txtUpdate' align='center' onclick='return EditRecord(" + i + ");'><img src='image/Edit.png'></td>";
                tblReceipts += "<td style='text-align:left;' id='txtID" + i + "'>" + data.ReceiptsDetails[i].Recp_Id + "</td>";
                tblReceipts += "<td style='text-align:left;' id='txtInvoiceTo" + i + "'>" + data.ReceiptsDetails[i].Rcp_Recievedby + " </td>";
                tblReceipts += "<td style='text-align:left;' id='txtInvoiceAmount" + i + "'>" + data.ReceiptsDetails[i].Rcp_Amount + " </td>";
                tblReceipts += "<td style='text-align:left;' id='txtInvoiceDate" + i + "'>" + data.ReceiptsDetails[i].Rcp_PaymentMode + " </td>";
                tblReceipts += "<td style='text-align:left;' id='txtPaymentDueon" + i + "'>" + data.ReceiptsDetails[i].Rcp_Receivedfrom + " </td>";
                tblReceipts += "<td style='text-align:left;' id='txtInvoiceNo" + i + "'>" + data.ReceiptsDetails[i].Rcp_Receivedfrom + " </td>";
                tblReceipts += "<td style='text-align:left;' id='txtPONo" + i + "'>" + Rep_Date + " </td>";
                tblReceipts += "<td style='text-align:left;' id='txtPODate" + i + "'>" + data.ReceiptsDetails[i].Payment_Nature + " </td>";
                tblReceipts += "<td style='text-align:left;' id='txtPODate" + i + "'>" + data.ReceiptsDetails[i].Rcp_ForProject + " </td>";
                tblReceipts += "<td style='text-align:left;' id='txtCreatedBy" + i + "'>" + data.ReceiptsDetails[i].Created_By + " </td>";
                tblReceipts += "<td style='text-align:left;' id='txtCreatedDate" + i + "'>" + CreatedDate + " </td>";
                tblReceipts += "<td style='text-align:left;' id='txtModifiedBy" + i + "'>" + data.ReceiptsDetails[i].Modified_By + " </td>";
                tblReceipts += "<td style='text-align:left;' id='txtModifiedDate" + i + "'>" + mdate + " </td>";
                tblReceipts += "</tr>";
            }

            tblReceipts += "</tbody>";
            tblReceipts += "</table>";
            $("#tblReceivableData").html(tblReceipts);
            dataTable();
            return false;
        }

        function onError_LoadReceipts() {
            alert("Error in Loading Receipts!");
        }

        function openAdvancedSearch() {
            $("#divAdvanceSearch").slideToggle();
            return false;
        }

        function Clear() {
            $("input[id$='txtReceiptID']").val('');
        }

        function ConvertDate(dateString) {
            if (dateString != undefined) {
                var date = new Date(parseInt(dateString.replace(/\/Date\((\d+)\)\//, '$1')));
                var month = date.getMonth() + 1;
                if (month < 10)
                    month = '0' + month;
                var day = date.getDate();
                if (day < 10)
                    day = '0' + day;
                var year = date.getFullYear();
                var datet = month + "/" + day + "/" + year;
                return datet;
            }
            else {
                return false;
            }
        } 
    
    
    </script>

</asp:Content>

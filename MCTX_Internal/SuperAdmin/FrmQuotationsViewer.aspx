<%@ Page Title="" Language="C#" MasterPageFile="~/MCTX_Internal/SuperAdmin/MasterAdmin.master"
    AutoEventWireup="true" CodeFile="FrmQuotationsViewer.aspx.cs" Inherits="MCTX_Internal_SuperAdmin_FrmQuotationsViewer" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <script src="../../js/jquery.dataTables.min.js" type="text/javascript"></script>
    <script src="../../js/BlockUI.js" type="text/javascript"></script>

    <style type="text/css">
        .dataTable
        {
            font-family: Arial,Verdana, Calibri, Helvetica, sans-serif;
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
        .a5
        {
            background-color: DimGray;
            background-repeat: repeat;
            border: 1pt none Black;
            color: White;
            direction: ltr;
            font-family: BernhardMod BT;
            font-size: 12pt;
            font-style: normal;
            font-weight: 700;
            padding: 2pt 0 2pt 2pt;
            text-align: right;
            text-decoration: none;
            unicode-bidi: normal;
            vertical-align: top;
        }
    </style>
    <table style="width: 100%; height: 288px;">
        <tr>
            <td valign="top" style="height: 331px">
                <div id="tabs">
                    <ul>
                        <li style="text-align: left"><a href="#tabs-1">Quotation</a></li>
                    </ul>
                    <div id="tabs-1">
                        <table align="right">
                            <tr>
                                <td>
                                    <span>Enter Email:</span> <span>|| </span>
                                    <asp:TextBox ID="txtEmail" Width="160px" runat="server" />
                                    <span>
                                        <asp:RequiredFieldValidator ID="rfEmail" ValidationGroup="vg1" ControlToValidate="txtEmail"
                                            runat="server" ErrorMessage="*"></asp:RequiredFieldValidator>
                                        <asp:Label ID="lblEmail_Quotation" runat="server" Text="Quotation Sent" Visible="false" />
                                        <asp:RegularExpressionValidator ID="regex_Email" ValidationGroup="vg1" ControlToValidate="txtEmail"
                                            runat="server" ErrorMessage="Invalid Email" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"></asp:RegularExpressionValidator></span>
                                    <span>||</span>
                                    <asp:LinkButton ID="lnkEmail" runat="server" ValidationGroup="vg1" title="Export"
                                        OnClientClick="BtnExport_ClientClick();" OnClick="lnkEmail_Click">Send</asp:LinkButton>
                                    <span>||</span>
                                    <asp:LinkButton ID="btnExport" runat="server" title="Export" OnClientClick="BtnExport_ClientClick();"
                                        OnClick="btnExport_Click">Export to PDF</asp:LinkButton>
                                    <span>|| </span>
                                    <asp:LinkButton ID="btnExcel" runat="server" OnClientClick="ExportDivDataToExcel()"
                                        Text="Export to Excel" OnClick="btnExcel_Click" />
                                    <asp:HiddenField ID="HdnValue" runat="server" />
                                    <%--<asp:HiddenField ID="Hf_QuotationName" runat="server" />--%>
                                </td>
                            </tr>
                        </table>
                        <div id="tblExport" style="border: 1px solid #999999">
                            <table width="100%" class="dataTable">
                                <tr>
                                    <td colspan="10">
                                        <table border="0.5" align="left" width="100%" id="tblQuotation" class="dataTable"
                                            style="font-size: 12px; border-color: #999999">
                                            <tr>
                                                <td colspan="2" style="border: 1px solid #999999; font-family: Arial; font-size: 16px;
                                                    margin: 0px; text-align: center">
                                                    Mechatronix
                                                </td>
                                            </tr>
                                            <tr>
                                                <td bgcolor='E3E3E3' class="a5" style="text-align: left; border: 1px solid #999999">
                                                    Quotation
                                                </td>
                                                <td bgcolor='E3E3E3' class="a5" style="text-align: left; border: 1px solid #999999;">
                                                      Our Reference
                                                </td>
                                            </tr>
                                            <tr>
                                                <td colspan="2">
                                                    <table class="dataTable" border="0.5" style="width: 100%; font-family: Arial; text-align: left;
                                                        font-size: 12px">
                                                        <tr style="vertical-align: middle; border-collapse: collapse; border: 1px solid #999999;
                                                            font-size: 12px; padding: 3px 5px; margin: 0px;">
                                                            <td width="5%">
                                                                Attn:
                                                            </td>
                                                            <td width="25%" style="border-collapse: collapse; vertical-align: middle; border: 1px solid #999999;
                                                                padding: 3px 5px; margin: 0px;">
                                                                <asp:Label ID="lblAttention" runat="server" />
                                                            </td>
                                                            <td rowspan="4" style="text-align: center; font-family: Arial; font-weight: bold;
                                                                font-size: 11pt">
                                                                <asp:Label Style="vertical-align: top; text-align: center" ID="lblSubject" Text="Subject:"
                                                                    runat="server" />
                                                            </td>
                                                            <td style="width: 8%; border-collapse: collapse; border: 1px solid #999999; padding: 3px 5px;
                                                                margin: 0px;">
                                                                Date:
                                                            </td>
                                                            <td style="width: 30%; border-collapse: collapse; border: 1px solid #999999; padding: 3px 5px;
                                                                margin: 0px; text-align: left">
                                                                <asp:Label ID="lblDate" runat="server" />
                                                            </td>
                                                        </tr>
                                                        <tr style="vertical-align: middle; border-collapse: collapse; border: 1px solid #999999">
                                                            <td width="5%">
                                                                Designation:
                                                            </td>
                                                            <td width="25%">
                                                                <asp:Label ID="lblDesg" runat="server" />
                                                            </td>
                                                            <td>
                                                                Ref #:
                                                            </td>
                                                            <td>
                                                                <asp:Label ID="lblRef" runat="server" />
                                                            </td>
                                                        </tr>
                                                        <tr style="vertical-align: middle; border-collapse: collapse; border: 1px solid #999999">
                                                            <td width="5%">
                                                                Dept:
                                                            </td>
                                                            <td width="20%">
                                                                <asp:Label ID="lblDept" runat="server" />
                                                            </td>
                                                            <td>
                                                                Sales Rep:
                                                            </td>
                                                            <td>
                                                                <asp:Label ID="lblRep" runat="server" />
                                                            </td>
                                                        </tr>
                                                        <tr style="vertical-align: middle; border-collapse: collapse; border: 1px solid #999999">
                                                            <td width="5%">
                                                                Organization:
                                                            </td>
                                                            <td width="20%">
                                                                <asp:Label ID="lblOrganisation" runat="server" />
                                                            </td>
                                                            <td>
                                                                Contact #:
                                                            </td>
                                                            <td>
                                                                <asp:Label ID="lblRefContact" runat="server" />
                                                            </td>
                                                        </tr>
                                                        <tr style="vertical-align: middle; border-collapse: collapse; border: 1px solid #999999">
                                                            <td width="5%">
                                                                Contact:
                                                            </td>
                                                            <td width="20%">
                                                                <asp:Label ID="lblContact" runat="server" />
                                                            </td>
                                                            <td rowspan="4" style="font-family: Arial; text-align: center; font-weight: bold;
                                                                font-size: 11pt">
                                                                <asp:Label ID="lblTitle" runat="server" />
                                                            </td>
                                                            <td style="white-space: nowrap">
                                                                Technical Person:
                                                            </td>
                                                            <td>
                                                                <asp:Label ID="lblTechPerson" runat="server" />
                                                            </td>
                                                        </tr>
                                                        <tr style="vertical-align: middle; border-collapse: collapse; border: 1px solid #999999">
                                                            <td width="5%">
                                                                Fax:
                                                            </td>
                                                            <td width="20%">
                                                                <asp:Label ID="lblFax" runat="server" />
                                                            </td>
                                                            <td>
                                                                Fax:
                                                            </td>
                                                            <td>
                                                                <asp:Label ID="lblRefFax" runat="server" />
                                                            </td>
                                                           
                                                        </tr>
                                                        <tr style="vertical-align: middle; border-collapse: collapse; border: 1px solid #999999">
                                                            <td width="5%">
                                                                Email:
                                                            </td>
                                                            <td width="20%">
                                                                <asp:Label ID="lblEmail" runat="server" />
                                                            </td>
                                                            
                                                             <td>
                                                                Official Email:
                                                            </td>
                                                            <td>
                                                                <asp:Label ID="lblOffEmail" runat="server" />
                                                            </td>
                                                        </tr>
                                                        <tr style="vertical-align: middle; border-collapse: collapse; border: 1px solid #999999">
                                                            <td width="5%">
                                                            </td>
                                                            <td width="20%">
                                                                <%--<asp:Label ID="lblNoofPages" runat="server" />--%>
                                                            </td>
                                                            <td>
                                                                Sales Rep Email:
                                                            </td>
                                                            <td>
                                                                bsg@mechatronix.com.pk;<asp:Label ID="lblSalesRepEmail" runat="server" />
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td border="0">
                                                </td>
                                                <td border="0">
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                            </table>
                            <table id="tblQuoteItems" border="0.5" style="width: 100%; font-family: Arial; text-align: left;
                                font-size: 12px" width="100%" class="dataTable">
                            </table>
                        </div>
                    </div>
                </div>
            </td>
        </tr>
    </table>

    <script type="text/javascript" language="javascript">
        $(document).ready(function() {
            GetItemQuotes();
            

        })
        var dyn_table = "";
        var data = "";
        var isLoadTerms = 0;
        var grandtotal = 0;
        var grandtotal_GST = 0;
        var GrandTotal_exc_GST = 0;
        var TotalQuantity = 0;

        function GetItemQuotes() {
            $.ajax({
                type: "POST",
                dataType: "json",
                contentType: "application/json; charset=utf-8",
                url: "FrmQuotationsViewer.aspx/GetQuotation",
                data: "{}",
                success: OnSuccessQuotes,
                error: OnErrorQuotes
            });
            return false;
        }

        function OnSuccessQuotes(msg) {

            
             data = msg.d;
            
            var j = 0;
          
            dyn_table += "<thead>";
            dyn_table += "<tr>";
            dyn_table += "<th bgColor='E3E3E3' style='font-weight: bold;cursor:Pointer;text-align:center;border:1px solid #999999'>S. #</th>";
            dyn_table += "<th bgColor='E3E3E3' style='font-weight: bold;cursor:Pointer;text-align:center;border:1px solid #999999'>Item Code</th>";
            if (data.GetQuotation[0].gstPercent == 0) {
                dyn_table += "<th bgColor='E3E3E3' colspan='5' style='font-weight: bold;cursor:Pointer;text-align:center;border:1px solid #999999'>Description</th>";
            }
            else { dyn_table += "<th bgColor='E3E3E3' style='font-weight: bold;cursor:Pointer;text-align:center;border:1px solid #999999'>Description</th>"; }
            dyn_table += "<th bgColor='E3E3E3' style='font-weight: bold;cursor:Pointer;text-align:center;border:1px solid #999999'>QTY</th>";
            dyn_table += "<th bgColor='E3E3E3' style='font-weight: bold;cursor:Pointer;text-align:center;border:1px solid #999999'>Unit Price</th>";
            //alert(data.GetQuotation[0].gstPercent);
            if (data.GetQuotation[0].gstPercent != 0  ) {
            dyn_table += "<th bgColor='E3E3E3' style='font-weight: bold;cursor:Pointer;text-align:center;border:1px solid #999999'>GST %</th>";
            dyn_table += "<th bgColor='E3E3E3' style='font-weight: bold;cursor:Pointer;text-align:center;border:1px solid #999999'>GST Per Unit</th>";
            dyn_table += "<th bgColor='E3E3E3' style='font-weight: bold;cursor:Pointer;text-align:center;border:1px solid #999999'>GST Payable</th>";
            dyn_table += "<th bgColor='E3E3E3' style='font-weight: bold;cursor:Pointer;text-align:center;border:1px solid #999999'>Total Ex. GST</th>";
        }
            dyn_table += "<th bgColor='E3E3E3' style='font-weight: bold;cursor:Pointer;text-align:center;white-space:nowrap;border:1px solid #999999'>Total</th>";
            dyn_table += "</tr>";
            dyn_table += "</thead>";
            dyn_table += "<tbody>";
//debugger;
            for (var i = 0; i < data.GetQuotation.length; i++) {
                j = i + 1;
                var item_price = data.GetQuotation[i].item_price;
                var item_quantity = data.GetQuotation[i].item_quantity;
                var gst = data.GetQuotation[i].gst;
                var total_Price = parseInt(item_price) * parseInt(item_quantity);
                var Total = total_Price + parseInt(gst);
                grandtotal += parseInt(Total);
                grandtotal_GST += parseInt(gst);
                GrandTotal_exc_GST += +parseInt(data.GetQuotation[i].totalprice);
                TotalQuantity += parseInt(data.GetQuotation[i].item_quantity);
                dyn_table += "<tr id='trmain" + i + "' style='cursor:default;border:1px solid #999999;padding: 3px 5px;margin: 0px;'>";
                dyn_table += "<td id='txtProductName" + i + "' align='right'  style='font-weight:bold;border:1px solid #999999;'>" + j + " </td>";
                dyn_table += "<td id='txtProductName" + i + "' align='right'  style='border:1px solid #999999;'>" + data.GetQuotation[i].item_code + " </td>";
                if (data.GetQuotation[0].gstPercent == 0) {
                    dyn_table += "<td align='right' colspan='5' style='border:1px solid #999999;text-align:justify'>" + data.GetQuotation[i].description + " </td>";
                }
                else {
                    dyn_table += "<td align='right'  style='border:1px solid #999999;text-align:justify'>" + data.GetQuotation[i].description + " </td>";
                }
                dyn_table += "<td align='right' style='white-space:nowrap;border:1px solid #999999;;padding: 3px 5px;margin: 0px;'>" + data.GetQuotation[i].item_quantity + " </td>";
                dyn_table += "<td align='right' style='white-space:nowrap;border:1px solid #999999;padding: 3px 5px;margin: 0px;'>" + data.GetQuotation[i].item_price.toLocaleString(); + " </td>";
                if (data.GetQuotation[0].gstPercent != 0 ) {
                    dyn_table += "<td id='txtProductID" + i + "' align='right'  style='white-space:nowrap;border:1px solid #999999;padding: 3px 5px;margin: 0px;'>" + data.GetQuotation[i].gstPercent + "% </td>";
                    dyn_table += "<td id='txtProductID" + i + "' align='right'  style='white-space:nowrap;border:1px solid #999999;padding: 3px 5px;margin: 0px;'>" + (parseFloat(data.GetQuotation[i].gst) / parseFloat(data.GetQuotation[i].item_quantity)).toLocaleString(); + " </td>"; //gst per unit
                    dyn_table += "<td id='txtProductID" + i + "' align='right'  style='border:1px solid #999999;padding: 3px 5px;margin: 0px;'>" + data.GetQuotation[i].gst.toLocaleString(); + " </td>";
                    dyn_table += "<td align='right' style='white-space:nowrap;border:1px solid #999999;padding: 3px 5px;margin: 0px;'>" + data.GetQuotation[i].totalprice.toLocaleString(); + " </td>";
                }
                dyn_table += "<td id='txtProductID" + i + "' align='right'  style='white-space:nowrap;border:1px solid #999999;padding: 3px 5px;margin: 0px;'>" + Total.toLocaleString(); + " </td>";
                dyn_table += "</tr>";
            }
            dyn_table += "<tr id='trmain" + i + "' style='cursor:default;border:1px solid #999999;'>";
            dyn_table += "<td align='center'  style='white-space:nowrap;font-weight:bold;border:1px solid #999999;font-weight:bold'>Total</td>";
            dyn_table += "<td align='left'  style='white-space:nowrap;font-weight:bold;border:1px solid #999999;'></td>";
            if (data.GetQuotation[0].gstPercent == 0) {
                dyn_table += "<td align='left' colspan='5'  style='border:1px solid #999999;text-align:justify'> </td>";
            }
            else { dyn_table += "<td align='left'   style='border:1px solid #999999;text-align:justify'> </td>"; }
            dyn_table += "<td align='right'  style='white-space:nowrap;border:1px solid #999999;'>" + TotalQuantity.toLocaleString(); + " </td>";
            if (data.GetQuotation[0].gstPercent != 0) {
                dyn_table += "<td align='left'  style='white-space:nowrap;border:1px solid #999999;'></td>";
                dyn_table += "<td align='right'  style='white-space:nowrap;border:1px solid #999999;'></td>";
                dyn_table += "<td align='left'  style='white-space:nowrap;border:1px solid #999999'></td>";
                dyn_table += "<td align='right'  style='white-space:nowrap;border:1px solid #999999'> " + grandtotal_GST.toLocaleString(); + "</td>"; //GST per unit
            }
            dyn_table += "<td align='right'  style='border:1px solid #999999'>" + GrandTotal_exc_GST.toLocaleString(); + "  </td>";
            dyn_table += "<td align='right'  style='white-space:nowrap;border:1px solid #999999'>" + grandtotal.toLocaleString(); + " </td>";
            dyn_table += "</tr>";
            var str = "";
            str = "<ul>"
                arr = data.GetQuotation[0].SpecialNotes.split(".");
                for (var i = 0 ; i < arr.length ; i++) {
                    str += "<li>" + arr[i] + "</li>";
                }
            
            str+= "</ul>"           
            dyn_table += "<tr id='trmain" + i + "' style='cursor:default;border:1px solid #999999;'>";
            //dyn_table += "<td colspan='10' align='center'  style='font-weight:bold;border:1px solid #999999;font-weight:bold'>Unit Prices are exclusive of all type of Taxes. In case of any variation in quantity ordered, the total project cost would be calculated on the basis of unit costs.</td>";
            dyn_table += "<td colspan='10'   align='center'  style='font-weight:bold;border:1px solid #999999;white-space:nowrap;font-weight:bold' bgColor='E3E3E3'>Special Notes</td>";
            dyn_table += "</tr>";

            dyn_table += "<tr id='trmain" + i + "' style='cursor:default;border:1px solid #999999;'>";
            //dyn_table += "<td colspan='10' align='center'  style='font-weight:bold;border:1px solid #999999;font-weight:bold'>Unit Prices are exclusive of all type of Taxes. In case of any variation in quantity ordered, the total project cost would be calculated on the basis of unit costs.</td>";
            dyn_table += "<td colspan='10'   style='font-weight:bold;border:1px solid #999999;font-weight:bold'>"+ str+ "</td>";
            dyn_table += "</tr>";
          
            dyn_table += "<tr>";
            dyn_table += "<td <td colspan='10' border='0'></td>";
            dyn_table += "</tr>";
            
            dyn_table += "<tr id='trmain" + i + "' style='cursor:default;border:1px solid #999999;'>";
            dyn_table += "<td colspan='8' align='center'  style='font-weight:bold;border:1px solid #999999;white-space:nowrap;font-weight:bold' bgColor='E3E3E3'>Terms and Condition</td>";
            dyn_table += "<td align='right' style='white-space:nowrap;font-weight:bold;border:1px solid #999999;font-weight:bold' bgColor='E3E3E3'>Total Ex. GST</td>";
            dyn_table += "<td align='right' style='white-space:nowrap;border:1px solid #999999;font-weight:bold' bgColor='E3E3E3'>" + GrandTotal_exc_GST.toLocaleString(); + " </td>";
            dyn_table += "</tr>";
       
          
            //for loop here for terms anc condition
        
            //dyn_table += "<tr id='trmain" + i + "' style='cursor:default;border:1px solid #999999;'>";
            //dyn_table += "<td align='left' colspan='2' style='font-weight:bold;white-space:nowrap;border:1px solid #999999;font-weight:bold'>Payment Terms</td>";
            //if (data.GetQuotation[0].gstPercent == 0) {//75% as an advance 25% after completion delivery and Installation. Or P.O.
            //    dyn_table += "<td align='left' colspan='8' style='border:1px solid #999999'>" + data.GetQuotation[0].PaymentTerms + "</td>";
            //}
            //else { dyn_table += "<td align='left' colspan='6' style='border:1px solid #999999'>" + data.GetQuotation[0].PaymentTerms + "</td>"; }
            //if (data.GetQuotation[0].gstPercent != 0) {
            //    dyn_table += "<td align='right'  style='white-space:nowrap;font-weight:bold;border:1px solid #999999;font-weight:bold' bgColor='E3E3E3'>Total GST</td>";
            //    dyn_table += "<td align='right' style='border:1px solid #999999;font-weight:bold' bgColor='E3E3E3'>" + grandtotal_GST.toLocaleString(); + " </td>";
            //}
            //dyn_table += "</tr>";

            //dyn_table += "<tr id='trmain" + i + "' style='cursor:default;border:1px solid #999999;'>";
            //dyn_table += "<td align='left' colspan='2' style='font-weight:bold;border:1px solid #999999;white-space:nowrap;font-weight:bold'>Warranty Terms</td>";
            //dyn_table += "<td align='left' colspan='6' style='border:1px solid #999999'>" + data.GetQuotation[0].WarrantyTerms + "</td>";
            //dyn_table += "<td align='right'  style='white-space:nowrap;font-weight:bold;border:1px solid #999999;font-weight:bold' bgColor='E3E3E3'>Grand Total</td>";
            //dyn_table += "<td align='right'  style='border:1px solid #999999;font-weight:bold' bgColor='E3E3E3'>" + grandtotal.toLocaleString(); + " </td>";
            //dyn_table += "</tr>";

            //dyn_table += "<tr id='trmain" + i + "' style='cursor:default;border:1px solid #999999;'>";
            //dyn_table += "<td align='left' colspan='2' style='font-weight:bold;border:1px solid #999999;white-space:nowrap;font-weight:bold'>Warranty Exception</td>";
            //dyn_table += "<td align='left' colspan='7' style='border:1px solid #999999'>" + data.GetQuotation[0].WarrantyException + "</td>";
            //dyn_table += "<td align='center' rowspan='3' style='border:1px solid #999999 width:20%'>Image HERE</td>";
            //dyn_table += "</tr>";
            
            //dyn_table += "<tr id='trmain" + i + "' style='cursor:default;border:1px solid #999999;'>";
            //dyn_table += "<td align='left' colspan='2' style='font-weight:bold;white-space:nowrap;border:1px solid #999999;font-weight:bold'>Delivery & Installation</td>";
            //dyn_table += "<td align='left' colspan='7' style='border:1px solid #999999'>" + data.GetQuotation[0].DeliveryInstallation + "</td>";
            //dyn_table += "</tr>";

            //dyn_table += "<tr id='trmain" + i + "' style='cursor:default;border:1px solid #999999;'>";
            //dyn_table += "<td align='left' colspan='2'  style='font-weight:bold;border:1px solid #999999;font-weight:bold'>Validity</td>";
            //dyn_table += "<td align='left' colspan='7' style='border:1px solid #999999'>" + data.GetQuotation[0].Validity + "</td>";
            //dyn_table += "</tr>";

            //dyn_table += "<tr id='trmain" + i + "' style='cursor:default;border:1px solid #999999;'>";
            //dyn_table += "<td align='left' colspan='2' style='font-weight:bold;white-space:nowrap;border:1px solid #999999;font-weight:bold'>Tex Exemption</td>";
            //dyn_table += "<td align='left' colspan='7' style='border:1px solid #999999'>" + data.GetQuotation[0].TexExemption + "</td>";
            //dyn_table += "<td align='center' colspan='3' style='border:1px solid #999999; width:20%;'>Signature and Company Seal</td>";
            //dyn_table += "</tr>";

            //dyn_table += "</tbody>";
            //dyn_table += "</table>";
            //$("#tblQuoteItems").html(dyn_table);
            return loadTerm();
        }

        function OnErrorQuotes() {
            alert("Error in Loading Quoted Items!");
        }
        function ExportDivDataToExcel() {
            var html = $("#tblExport").html();
            html = $.trim(html);
            html = html.replace(/>/g, '&gt;');
            html = html.replace(/</g, '&lt;');
            $("input[id$='HdnValue']").val(html);
        }
        function BtnExport_ClientClick() {
            var html = $("#tblExport").html();
            html = $.trim(html);
            html = html.replace(/>/g, '&gt;');
            html = html.replace(/</g, '&lt;');
            $("input[id$='HdnValue']").attr('value', html)
            //$("input[id$='Hf_QuotationName']").val($("input[id$='txthidden_FileName']").val());




        }
        function loadTerm() {
            $.ajax({
                type: "POST",
                dataType: "json",
                contentType: "application/json; charset=utf-8",
                url: "FrmQuotationsViewer.aspx/GetQuotTermsAndCondtion",
                data: "{}",
                success: OnSuccessQuoteTerm,
                error: OnErrorQuotesTerm
            });
        }
        function OnSuccessQuoteTerm(msg) {
            var isLoadTerms = 1;
            var dataTerm = msg.d;
            for (var k = 0; k < dataTerm.GetQuotTermAndCondition.length; k++) {
                if (k == 0) {
                    dyn_table += "<tr id='trmain' style='cursor:default;border:1px solid #999999;'>";
                    dyn_table += "<td align='left' colspan='2' style='font-weight:bold;white-space:nowrap;border:1px solid #999999;font-weight:bold'>" + dataTerm.GetQuotTermAndCondition[k].TermName + "</td>";
                    if (data.GetQuotation[0].gstPercent == 0) {//75% as an advance 25% after completion delivery and Installation. Or P.O.
                        dyn_table += "<td align='left' colspan='8' style='border:1px solid #999999'>" + dataTerm.GetQuotTermAndCondition[k].TermDiscription + "</td>";
                    }
                    else { dyn_table += "<td align='left' colspan='6' style='border:1px solid #999999'>" + dataTerm.GetQuotTermAndCondition[k].TermDiscription + "</td>"; }

                    if (data.GetQuotation[0].gstPercent != 0) {
                        dyn_table += "<td align='right'  style='white-space:nowrap;font-weight:bold;border:1px solid #999999;font-weight:bold' bgColor='E3E3E3'>Total GST</td>";
                        dyn_table += "<td align='right' style='border:1px solid #999999;font-weight:bold' bgColor='E3E3E3'>" + grandtotal_GST.toLocaleString(); + " </td>";
                    }
                    dyn_table += "</tr>";
                }
                else if (k == 1) {
                    dyn_table += "<tr id='trmain' style='cursor:default;border:1px solid #999999;'>";
                    dyn_table += "<td align='left' colspan='2' style='font-weight:bold;white-space:nowrap;border:1px solid #999999;font-weight:bold'>" + dataTerm.GetQuotTermAndCondition[k].TermName + "</td>";
                    if (data.GetQuotation[0].gstPercent == 0) {//75% as an advance 25% after completion delivery and Installation. Or P.O.
                        dyn_table += "<td align='left' colspan='8' style='border:1px solid #999999'>" + dataTerm.GetQuotTermAndCondition[k].TermDiscription + "</td>";
                    }
                    else { dyn_table += "<td align='left' colspan='6' style='border:1px solid #999999'>" + dataTerm.GetQuotTermAndCondition[k].TermDiscription + "</td>"; }
                    if (data.GetQuotation[0].gstPercent != 0) {
                        dyn_table += "<td align='right'  style='white-space:nowrap;font-weight:bold;border:1px solid #999999;font-weight:bold' bgColor='E3E3E3'>Grand Total</td>";
                        dyn_table += "<td align='right' style='border:1px solid #999999;font-weight:bold' bgColor='E3E3E3'>" + grandtotal.toLocaleString(); + " </td>";
                    }
                    dyn_table += "</tr>";
                }
                else {
                    dyn_table += "<tr id='trmain' style='cursor:default;border:1px solid #999999;'>";
                    dyn_table += "<td align='left' colspan='2' style='font-weight:bold;white-space:nowrap;border:1px solid #999999;font-weight:bold'>" + dataTerm.GetQuotTermAndCondition[k].TermName + "</td>";
                    dyn_table += "<td align='left' colspan='8' style='border:1px solid #999999'>" + dataTerm.GetQuotTermAndCondition[k].TermDiscription + "</td>";

                }
            }
            dyn_table += "</tbody>";
            dyn_table += "</table>";
           
            $("#tblQuoteItems").html(dyn_table);
            return false;          
        }
        function OnErrorQuotesTerm() {
            alert("Error in Loading Quotation Terms!");
        }
    </script>

</asp:Content>

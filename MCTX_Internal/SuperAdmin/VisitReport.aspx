<%@ Page Title="" Language="C#" MasterPageFile="~/MCTX_Internal/SuperAdmin/MasterAdmin.master"
    AutoEventWireup="true" CodeFile="VisitReport.aspx.cs" Inherits="MCTX_Internal_SuperAdmin_VisitReport" %>

<%@ Register Assembly="RJS.Web.WebControl.PopCalendar.Net.2008" Namespace="RJS.Web.WebControl"
    TagPrefix="rjs" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <script src="../../js/jquery.dataTables.min.js" type="text/javascript"></script>

    <script src="../../js/BlockUI.js" type="text/javascript"></script>

    <script src="../../js/jquery.fixedheader.js" type="text/javascript"></script>

    <script src="../../js/jqModal.js" type="text/javascript"></script>

    <link href="../../css1/jqModal.css" rel="stylesheet" type="text/css" />
    <style type="text/css">
        .dataTable
        {
            font-family: Calibri ,Verdana, Arial, Helvetica, sans-serif;
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
            text-align: left;
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
        td
        {
            text-align: left;
        }
        input:focus
        {
            height: 18px;
            font-size: 11pt;
            font-family: Calibri,Verdana, Arial, Helvetica, sans-serif;
            box-shadow: 0 -1px 0 rgba(0, 0, 0, 0.3), 0 1px 2px rgba(0, 0, 0, 0.1) inset, 0 0 10px rgba(255, 255, 255, 0.9);
            border-color: #ABD3FC;
        }
        input
        {
            height: 18px;
            font-size: 10pt;
            font-family: Calibri,Verdana, Arial, Helvetica, sans-serif;
            width: 150px;
            border: 1px solid #CCCCCC;
        }
        textarea:focus
        {
            font-size: 11pt;
            font-family: Calibri,Verdana, Arial, Helvetica, sans-serif;
            width: 150px;
            box-shadow: 0 -1px 0 rgba(0, 0, 0, 0.3), 0 1px 2px rgba(0, 0, 0, 0.1) inset, 0 0 10px rgba(255, 255, 255, 0.9);
            border-color: #ABD3FC;
        }
        textarea
        {
            font-size: 10pt;
            font-family: Calibri,Verdana, Arial, Helvetica, sans-serif;
            width: 150px;
            height: 50px;
            border: 1px solid #CCCCCC;
        }
        span
        {
            font-family: Calibri,Verdana, Arial, Helvetica, sans-serif;
            font-size: 12px;
        }
        SELECT
        {
            font-family: Calibri,Verdana, Arial, Helvetica, sans-serif;
            width: 152px;
            font-size: 11px;
            border: 1px solid #CCCCCC;
            height: 19px;
        }
        SELECT:focus
        {
            font-family: Calibri,Verdana, Arial, Helvetica, sans-serif;
            font-weight: bold;
            width: 152px;
            font-size: 11px;
            box-shadow: 0 -1px 0 rgba(0, 0, 0, 0.3), 0 1px 2px rgba(0, 0, 0, 0.1) inset, 0 0 10px rgba(255, 255, 255, 0.9);
        }
        OPTION
        {
            font-family: Calibri,Verdana, Arial, Helvetica, sans-serif;
            font-weight: normal;
        }
        .CloseButton
        {
            background: none repeat scroll 0 0 transparent;
            border: medium none;
            height: 32px;
            margin-top: -30px;
            position: absolute;
            width: 32px;
            cursor: pointer;
        }
    </style>
    <div id="tabs">
        <ul>
            <li style="text-align: left"><a href="#tabs-1">Visit Reports</a></li>
        </ul>
        <div id="DivSummary" style="margin-bottom: 10px; width: 99%">
            <fieldset style="border: 1px solid #ABD3FC;">
                <legend style="text-align: center; color: Coral; font-size: 13px;">Summary</legend>
                <table class="dataTable" style="margin-bottom: 10px; width: 98%">
                    <tr>
                        <td style="border: 1px solid #ABD3FC; font-weight: bold">
                            Fresh Visits
                        </td>
                        <td style="border: 1px solid #ABD3FC; text-align: right">
                            <span style="font-weight: bold" id="FreshVisits">0</span>
                        </td>
                        <td style="border: 1px solid #ABD3FC; font-weight: bold">
                            Follow Up Visits
                        </td>
                        <td style="border: 1px solid #ABD3FC; text-align: right">
                            <span style="font-weight: bold" id="FollowUpVisits">0</span>
                        </td>
                        <td style="border: 1px solid #ABD3FC; font-weight: bold">
                            Sale Visits
                        </td>
                        <td style="border: 1px solid #ABD3FC; text-align: right">
                            <span style="font-weight: bold" id="SaleVisits">0</span>
                        </td>
                        <td style="border: 1px solid #ABD3FC; font-weight: bold">
                            ColdCall
                        </td>
                        <td style="border: 1px solid #ABD3FC; text-align: right">
                            <span style="font-weight: bold" id="ColdCall">0</span>
                        </td>
                    </tr>
                    <tr>
                        <td style="border: 1px solid #ABD3FC; font-weight: bold">
                            Supervisory Visit
                        </td>
                        <td style="border: 1px solid #ABD3FC; text-align: right">
                            <span style="font-weight: bold" id="SupervisoryVisit">0</span>
                        </td>
                        <td style="border: 1px solid #ABD3FC; font-weight: bold">
                            Letter Marketing
                        </td>
                        <td style="border: 1px solid #ABD3FC; text-align: right">
                            <span style="font-weight: bold" id="LetterMarketing">0</span>
                        </td>
                        <td style="border: 1px solid #ABD3FC; font-weight: bold">
                            Telephone Follow Up
                        </td>
                        <td style="border: 1px solid #ABD3FC; text-align: right">
                            <span style="font-weight: bold" id="TelephoneFollowUp">0</span>
                        </td>
                        <td style="border: 1px solid #ABD3FC; font-weight: bold">
                            Cold Call By Reference
                        </td>
                        <td style="border: 1px solid #ABD3FC; text-align: right">
                            <span style="font-weight: bold" id="ColdCallByReference">0</span>
                        </td>
                    </tr>
                    <tr>
                        <td style="border: 1px solid #ABD3FC; font-weight: bold">
                            Email-Marketing
                        </td>
                        <td style="border: 1px solid #ABD3FC; text-align: right">
                            <span style="font-weight: bold" id="EmailMarketing">0</span>
                        </td>
                        <td style="border: 1px solid #ABD3FC; font-weight: bold">
                            Complaint
                        </td>
                        <td style="border: 1px solid #ABD3FC; text-align: right">
                            <span style="font-weight: bold; text-align: right" id="Complaint">0</span>
                        </td>
                        <td style="border: 1px solid #ABD3FC; font-weight: bold">
                            Quotations
                        </td>
                        <td style="border: 1px solid #ABD3FC; text-align: right">
                            <span style="font-weight: bold" id="Quotations">0</span>
                        </td>
                        <td style="border: 1px solid #ABD3FC; font-weight: bold">
                            Total Visits/ Prospects
                        </td>
                        <td style="border: 1px solid #ABD3FC; text-align: right">
                            <span style="font-weight: bold" id="Total"></span>/&nbsp
                            <span style="font-weight: bold" id="ProspectCount">0</span>
                            
                        </td>
                    </tr>
                </table>
            </fieldset>
        </div>
        <div style="margin-bottom: 10px; width: 99%">
            <fieldset style="border: 1px solid #ABD3FC;">
                <legend style="text-align: center; color: Coral; font-size: 13px;">Search Sales Visits</legend>
                <table style="width: 72%; margin-bottom: 10px">
                    <tr>
                        <td style="text-align: right; width: 18%">
                            <span>From Date: </span>
                        </td>
                        <td style="text-align: left; width: 18%">
                            <asp:TextBox ID="txtFromDate" runat="server"></asp:TextBox><rjs:PopCalendar ID="rjsReportDate"
                                Separator="/" Format="mm dd yyyy" Control="txtFromDate" runat="server" />
                        </td>
                        <td style="text-align: right; width: 18%">
                            <span>To Date: </span>
                        </td>
                        <td style="text-align: left; width: 18%">
                            <asp:TextBox ID="txtToDate" runat="server"></asp:TextBox><rjs:PopCalendar ID="PopCalendar1"
                                Separator="/" Format="mm dd yyyy" Control="txtToDate" runat="server" />
                        </td>
                    </tr>
                    <tr>
                        <td style="text-align: right; width: 18%">
                            <span>Employee: </span>
                        </td>
                        <td style="text-align: left; width: 18%">
                            <asp:DropDownList ID="ddlEmployees" runat="server" />
                        </td>
                        <td style="text-align: right; width: 18%">
                        </td>
                        <td style="text-align: left; width: 18%">
                            <asp:Button ID="btnSearch" runat="server" Width="104px" Style="background-color: #2A4062;
                                color: White;" Text="Search" OnClientClick="return LoadVisits();"
                                 BackColor="#ABD3FC" />
                                <asp:Button ID="btnExportToExcel" Width="104px" Style="background-color: #2A4062;
                                color: White;" runat="server" 
                                BackColor="#ABD3FC" Text="Export to Excel" 
                                onclick="btnExportToExcel_Click"/>
                        </td>
                    </tr>
                </table>
            </fieldset>
        </div>
        <div id="VisitDetails" style="display: none; margin: 89px 0 5px -300px;" class="jqmWindow">
            <table class="dataTable" style="border: 1px solid #ABD3FC;">
                <thead>
                    <tr>
                        <th colspan="3" style="text-align: center; background-color: #ABD3FC;">
                            Visit Details
                        </th>
                    </tr>
                </thead>
                <tr>
                    <td style="text-align: right; border: none">
                        <div id="close">
                            <img src='image/btn_close02.png' style="background: none repeat scroll 0 0 transparent;
                                border: medium none; height: 32px; margin-top: -52px; position: absolute; width: 32px;
                                cursor: pointer; right: 434px; left: 610px;" alt="Close" onclick='return CloseModal();' />
                        </div>
                    </td>
                </tr>
                <tr>
                    <td style="width: 25%; border: 1px solid #ABD3FC">
                        Visited by:
                    </td>
                    <td style="width: 40%; border: 1px solid #ABD3FC">
                        <span id="Visitedby_Details"></span>
                    </td>
                    <td rowspan="13" style="vertical-align: top; width: 35%; border: 1px solid #ABD3FC">
                        <table width="100%" style="height: 100%">
                            <tr>
                                <th style="border: 1px solid #ABD3FC;">
                                    Remarks
                                </th>
                            </tr>
                            <tr>
                                <td style="height: 100%; border: 0px">
                                    <span id="Remarks_Details"></span>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td style="border: 1px solid #ABD3FC">
                        Visit Date:
                    </td>
                    <td style="border: 1px solid #ABD3FC">
                        <span id="VisitedDate_Details"></span>
                    </td>
                </tr>
                <tr>
                    <td style="border: 1px solid #ABD3FC">
                        Visit Type:
                    </td>
                    <td style="border: 1px solid #ABD3FC">
                        <span id="VisitType_Details"></span>
                    </td>
                </tr>
                <tr>
                    <td style="border: 1px solid #ABD3FC">
                        Client Response:
                    </td>
                    <td style="border: 1px solid #ABD3FC">
                        <span id="ClientResponse_Details"></span>
                    </td>
                </tr>
                <tr>
                    <td style="border: 1px solid #ABD3FC">
                        Sales Worth:
                    </td>
                    <td style="border: 1px solid #ABD3FC">
                        <span id="SalesWorth_Details"></span>
                    </td>
                </tr>
                <tr>
                    <td style="border: 1px solid #ABD3FC">
                        Company:
                    </td>
                    <td style="border: 1px solid #ABD3FC">
                        <span id="Company_Details"></span>
                    </td>
                </tr>
                <tr>
                    <td style="border: 1px solid #ABD3FC">
                        Clent Name:
                    </td>
                    <td style="border: 1px solid #ABD3FC">
                        <span id="ClientName_Details"></span>
                    </td>
                </tr>
                <tr>
                    <td style="border: 1px solid #ABD3FC">
                        Client Designation:
                    </td>
                    <td style="border: 1px solid #ABD3FC">
                        <span id="ClientDesignation_Details"></span>
                    </td>
                </tr>
                <tr>
                    <td style="border: 1px solid #ABD3FC">
                        Client Phone No:
                    </td>
                    <td style="border: 1px solid #ABD3FC">
                        <span id="ClientPhoneNo_Details"></span>
                    </td>
                </tr>
                <tr>
                    <td style="border: 1px solid #ABD3FC">
                        Client Cell No:
                    </td>
                    <td style="border: 1px solid #ABD3FC">
                        <span id="ClientCellNo_Details"></span>
                    </td>
                </tr>
                <tr>
                    <td style="border: 1px solid #ABD3FC">
                        Client Email:
                    </td>
                    <td style="border: 1px solid #ABD3FC">
                        <span id="ClientEmail_Details"></span>
                    </td>
                </tr>
                <tr>
                    <td style="border: 1px solid #ABD3FC">
                        Client Address:
                    </td>
                    <td style="border: 1px solid #ABD3FC">
                        <span id="ClientAddress_Details"></span>
                    </td>
                </tr>
                <tr>
                    <td style="border: 1px solid #ABD3FC">
                        City:
                    </td>
                    <td style="border: 1px solid #ABD3FC">
                        <span id="City_Details"></span>
                    </td>
                </tr>
            </table>
        </div>
        <div style="height: 400px; overflow: auto">
            <table id="tblVisits" class="dataTable">
            </table>
        </div>
        
    </div>

    <script language="javascript" type="text/javascript">
        $(document).ajaxStart(blockUI).ajaxStop(unblockUI);

        function blockUI() {
            $.blockUI({ message: '<img src="image/ajax-loader.gif" />',
                css: { borderStyle: 'none', backgroundColor: "Transparent" }
            });
        }

        function unblockUI() {
            $.unblockUI();
        }

        $(document).ready(function() {
            LoadVisits();
        });
        //----------------------------------------------------------------get visits ----------------------------------by Obaid Altaf//
        function LoadVisits() {
            var FrmDate = $("input[id$='txtFromDate']").val().trim();
            var ToDate = $("input[id$='txtToDate']").val().trim();
            
             if (FrmDate != "") {
           
                if (ToDate == "") {
                    alert("Please Select To Date!");
                     
                    return false;
                }
            }
            if (ToDate != "") {
                if (FrmDate == "") {
                    alert("Please Select From Date!");
                    return false;
                }
            }
        
             if(new Date(ToDate) < new Date(FrmDate))
        {
        alert("Date To can not be less than date From!");
       
        return false;

        }  
            var EmployeeId = $("select[id$='ddlEmployees'] option:selected").val();
            $.ajax({
                type: "POST",
                dataType: "json",
                contentType: "application/json; charset=utf-8",
                url: "VisitReport.aspx/GetVisits",
                async: false,
                //data: "{}",
                data: "{'FromDate':'" + FrmDate + "','ToDate':'" + ToDate + "','EmployeeId':'" + EmployeeId + "'}",
                success: OnSuccessGetVisits,
                error: OnErrorGetVisits
            });
            return false;
        }

        function OnSuccessGetVisits(msg) {
            var data = msg.d;

            var dyn_table = "";
            dyn_table += "<thead>";
            dyn_table += "<tr>";

            dyn_table += "<th style='font-weight: bold;cursor:Pointer;text-align:center;border:1px solid #999999'>S. #</th>";
            dyn_table += "<th style='font-weight: bold;cursor:Pointer;text-align:center;border:1px solid #999999'>Visited By</th>";
            dyn_table += "<th style='font-weight: bold;cursor:Pointer;text-align:center;border:1px solid #999999'>Company Name</th>";
            dyn_table += "<th style='font-weight: bold;cursor:Pointer;text-align:center;border:1px solid #999999'>Client Name</th>";
            dyn_table += "<th style='font-weight: bold;cursor:Pointer;text-align:center;border:1px solid #999999'>Visit Type</th>";
            dyn_table += "<th style='font-weight: bold;cursor:Pointer;text-align:center;border:1px solid #999999'>Client Response</th>";
            dyn_table += "<th style='font-weight: bold;cursor:Pointer;text-align:center;border:1px solid #999999'>Sale Worth</th>";
            dyn_table += "<th style='font-weight: bold;cursor:Pointer;text-align:center;border:1px solid #999999'>Visit Date</th>";
            //            dyn_table += "<th style='font-weight: bold;cursor:Pointer;text-align:center;border:1px solid #999999'>Visit Id</th>";
            dyn_table += "<th style='font-weight: bold;cursor:Pointer;text-align:center;border:1px solid #999999'>Details</th>";
            dyn_table += "</tr>";
            dyn_table += "</thead>";
            dyn_table += "<tbody>";

            var j = 0;
            for (var i = 0; i < data.Visits.length; i++) {
                j = i + 1;
                dyn_table += "<tr id='trmain" + i + "' style='cursor:default;border:1px solid #999999;padding: 3px 5px;margin: 0px;'>";
                dyn_table += "<td style='font-weight:bold;border:1px solid #999999;'>" + j + " </td>";
                dyn_table += "<td style='border:1px solid #999999;'>" + data.Visits[i].E_Name + " </td>";
                dyn_table += "<td style='border:1px solid #999999'>" + data.Visits[i].comp_name + " </td>";
                dyn_table += "<td style='border:1px solid #999999;;padding: 3px 5px;margin: 0px;'>" + data.Visits[i].client_name + " </td>";
                dyn_table += "<td style='border:1px solid #999999;padding: 3px 5px;margin: 0px;text-align:center'>" + data.Visits[i].tt_name + " </td>";
                dyn_table += "<td style='border:1px solid #999999;padding: 3px 5px;margin: 0px;text-align:center'>" + data.Visits[i].response_name + " </td>";
                dyn_table += "<td style='border:1px solid #999999;padding: 3px 5px;margin: 0px;text-align:right'>" + data.Visits[i].total_Sale + " </td>";
                dyn_table += "<td style='border:1px solid #999999;padding: 3px 5px;margin: 0px;'>" + data.Visits[i].Visit_Date + " </td>";
                dyn_table += "<td id='visitid" + i + "' style='border:1px solid #999999;padding: 3px 5px;margin: 0px;display:none'>" + data.Visits[i].visit_id + " </td>";
                dyn_table += "<td id='detail_id"+i+"' style='text-align:center'><input type='image' style='height: 24px;width:24px;border:0px;background:transparent;cursor: pointer;' src='image/Details.png' onclick='VisitsDetails(" + i + ");return ShowDetails_Modal();'/></td>";
                dyn_table += "</tr>";
            }
            dyn_table += "</tbody></table>";
            $("#tblVisits").html(dyn_table);
            VisitsSummary();
        }

        function OnErrorGetVisits() {
            alert("Error in loading visit reports");
        }

        //--------------------------------------------------get Visits Summary--------------------by Obaid Altaf-------------//
        function VisitsSummary() {
            var FromDate = $("input[id$='txtFromDate']").val().trim();
            var ToDate = $("input[id$='txtToDate']").val().trim();
            var EmployeeId = $("select[id$='ddlEmployees'] option:selected").val();
            $.ajax({
                type: "POST",
                dataType: "json",
                contentType: "application/json; charset=utf-8",
                url: "VisitReport.aspx/VisitsSummary",
                async: false,
                data: "{'FromDate':'" + FromDate + "','ToDate':'" + ToDate + "','EmployeeId':'" + EmployeeId + "'}",
                success: OnSuccessVisitsSummary,
                error: OnErrorVisitsSummary
            });
            return false;
        }
        function OnSuccessVisitsSummary(msg) {
            var data = msg.d;
            var TotalSales = 0;
            $("span[id$='FollowUpVisits']").text('0');
            $("span[id$='FreshVisits']").text('0');
            $("span[id$='SaleVisits']").text('0');
            $("span[id$='SupervisoryVisit']").text('0');
            $("span[id$='LetterMarketing']").text('0');
            $("span[id$='TelephoneFollowUp']").text('0');
            $("span[id$='ColdCall']").text('0');
            $("span[id$='EmailMarketing']").text('0');
            $("span[id$='Complaint']").text('0');
            $("span[id$='Quotations']").text('0');
            $("span[id$='ColdCallByReference']").text('0');
            $("span[id$='Total']").text('0');

            for (var i = 0; i < data.VisitsSummary.length; i++) {
                TotalSales += parseInt(data.VisitsSummary[i].VisitCount);

                if (data.VisitsSummary[i].VisitType == "Follow Up") {
                    $("span[id$='FollowUpVisits']").text(data.VisitsSummary[i].VisitCount);
                }
                if (data.VisitsSummary[i].VisitType == "Fresh Visits") {
                    $("span[id$='FreshVisits']").text(data.VisitsSummary[i].VisitCount);
                }
                if (data.VisitsSummary[i].VisitType == "Sale") {
                    $("span[id$='SaleVisits']").text(data.VisitsSummary[i].VisitCount);
                }
                if (data.VisitsSummary[i].VisitType == "SuperVisory Visit") {
                    $("span[id$='SupervisoryVisit']").text(data.VisitsSummary[i].VisitCount);
                }
                if (data.VisitsSummary[i].VisitType == "Letter Marketing") {
                    $("span[id$='LetterMarketing']").text(data.VisitsSummary[i].VisitCount);
                }
                if (data.VisitsSummary[i].VisitType == "Telephone Follow Up") {
                    $("span[id$='TelephoneFollowUp']").text(data.VisitsSummary[i].VisitCount);
                }
                if (data.VisitsSummary[i].VisitType == "Cold Call") {
                    $("span[id$='ColdCall']").text(data.VisitsSummary[i].VisitCount);
                }
                if (data.VisitsSummary[i].VisitType == "Email-Marketing") {
                    $("span[id$='EmailMarketing']").text(data.VisitsSummary[i].VisitCount);
                }
                if (data.VisitsSummary[i].VisitType == "Complaint") {
                    $("span[id$='Complaint']").text(data.VisitsSummary[i].VisitCount);
                }
                if (data.VisitsSummary[i].VisitType == "Quotations") {
                    $("span[id$='Quotations']").text(data.VisitsSummary[i].VisitCount);
                }
                if (data.VisitsSummary[i].VisitType == "Cold Call By Reference") {
                    $("span[id$='ColdCallByReference']").text(data.VisitsSummary[i].VisitCount);
                }

            }
            $("span[id$='Total']").text(TotalSales);
            TotalProspects();
            
        }

        function OnErrorVisitsSummary() {
            alert("Error in getting Visits Summary");
        }

        //--------------------------------------------------get Visits Summary--------------------by Obaid Altaf-------------//
        function TotalProspects() {
            var FromDate = $("input[id$='txtFromDate']").val().trim();
            var ToDate = $("input[id$='txtToDate']").val().trim();
            var EmployeeId = $("select[id$='ddlEmployees'] option:selected").val();
            $.ajax({
                type: "POST",
                dataType: "json",
                contentType: "application/json; charset=utf-8",
                url: "VisitReport.aspx/TotalProspects",
                async: false,
                data: "{'FromDate':'" + FromDate + "','ToDate':'" + ToDate + "','EmployeeId':'" + EmployeeId + "'}",
                success: OnSuccessTotalProspects,
                error: OnErrorTotalProspects
            });
            return false;
        }
        function OnSuccessTotalProspects(msg) {
            var data = msg.d;

            $("span[id$='ProspectCount']").text('0');
            $("span[id$='ProspectCount']").text(data.Prospects[0].ProspectCount);
            return false;
        }

        function OnErrorTotalProspects() {
            alert("Error in getting Total Prospects");
            return false;
        }

        //--------------------------------------------------get Visits Details--------------------by Obaid Altaf-------------//
        function VisitsDetails(rowNo) {
            var VisitId = $("td[id$='visitid" + rowNo + "']").text().trim();
            $.ajax({
                type: "POST",
                dataType: "json",
                contentType: "application/json; charset=utf-8",
                url: "VisitReport.aspx/VisitsDetails",
                async: false,
                data: "{'VisitId':'" + VisitId + "'}",
                success: OnSuccessVisitsDetails,
                error: OnErrorVisitsDetails
            });
            return false;
        }

        function OnSuccessVisitsDetails(msg) {
            var data = msg.d;
            for (var i = 0; i < data.VisitDetails.length; i++) {
                $("span[id$='Visitedby_Details']").text(data.VisitDetails[i].E_Name);
                $("span[id$='VisitedDate_Details']").text(data.VisitDetails[i].Visit_Date);
                $("span[id$='VisitType_Details']").text(data.VisitDetails[i].tt_name);
                $("span[id$='ClientResponse_Details']").text(data.VisitDetails[i].response_name);
                $("span[id$='SalesWorth_Details']").text(data.VisitDetails[i].total_Sale);
                $("span[id$='Company_Details']").text(data.VisitDetails[i].comp_name);
                $("span[id$='ClientName_Details']").text(data.VisitDetails[i].client_name);
                $("span[id$='ClientDesignation_Details']").text(data.VisitDetails[i].client_designation);
                $("span[id$='ClientPhoneNo_Details']").text(data.VisitDetails[i].client_phone);
                $("span[id$='ClientCellNo_Details']").text(data.VisitDetails[i].Client_mobile);
                $("span[id$='ClientEmail_Details']").text(data.VisitDetails[i].client_email);
                $("span[id$='ClientAddress_Details']").text(data.VisitDetails[i].comp_address);
                $("span[id$='City_Details']").text(data.VisitDetails[i].city_name);
                $("span[id$='Remarks_Details']").text(data.VisitDetails[i].remarks);
            }
            return false;
        }

        function OnErrorVisitsDetails() {
            alert("Error in visit details");
            return false;
        }

        //-------------------------------------------------------Modal Show and Hide Functions------------------------------------------//
        function ShowDetails_Modal() {

            $('#VisitDetails').jqm({ modal: true, overlay: 75, trigger: false });
            $('#VisitDetails').jqmShow();
            //clear();
            return false;
        }
        function CloseModal() {
            Clear_Details();
            $("#VisitDetails").jqmHide();
            return false;
        }
        function Clear_Details() {
            $("span[id$='Visitedby_Details']").text('');
            $("span[id$='VisitedDate_Details']").text('');
            $("span[id$='VisitType_Details']").text('');
            $("span[id$='ClientResponse_Details']").text('');
            $("span[id$='SalesWorth_Details']").text('');
            $("span[id$='Company_Details']").text('');
            $("span[id$='ClientName_Details']").text('');
            $("span[id$='ClientDesignation_Details']").text('');
            $("span[id$='ClientPhoneNo_Details']").text('');
            $("span[id$='ClientCellNo_Details']").text('');
            $("span[id$='ClientEmail_Details']").text('');
            $("span[id$='ClientAddress_Details']").text('');
            $("span[id$='City_Details']").text('');
            $("span[id$='Remarks_Details']").text('');
            return false;
        }
    </script>

</asp:Content>
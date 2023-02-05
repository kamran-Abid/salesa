<%@ Page Language="C#" MasterPageFile="~/MCTX_Internal/SuperAdmin/MasterAdmin.master"
    AutoEventWireup="true" CodeFile="frmDailyReportChck.aspx.cs" Inherits="MCTX_Internal_SuperAdmin_frmDailyReportChck"
    Title="Daily Report Details" %>

<%@ Register Assembly="RJS.Web.WebControl.PopCalendar.Net.2008" Namespace="RJS.Web.WebControl"
    TagPrefix="rjs" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <script src="../../js/jquery.dataTables.min.js" type="text/javascript"></script>
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
        .style7
        {
            width: 158px;
        }
        .style8
        {
            width: 124px;
        }
        .style9
        {
            width: 266px;
        }
        
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
    </style>
    <div id="tabs" style="width: 100%;">
        <ul>
            <li style="text-align: left"><a href="#tabs-1">Daily Report Details</a></li>
        </ul>
        <div>
            <fieldset id="fldDailyReport" style="width: 96%" runat="server">
                <legend runat="server">Daily Report Details</legend>
                <table style="width: 100%">
                    <tr>
                        <td align="left" style="width: 120px">
                            <asp:Label ID="lblEmpName" Text="Employee Name:" runat="server"></asp:Label>
                        </td>
                        <td align="left" style="width: 140px">
                            <asp:DropDownList ID="ddlEmpName" Width="124px" AutoPostBack="false" runat="server">
                            </asp:DropDownList>
                        </td>
                        <td align="left" style="width: 120px">
                            <asp:Label ID="lblProjects" Text="Project:" runat="server"></asp:Label>
                        </td>
                        <td align="left" style="width: 140px">
                            <asp:DropDownList ID="ddlProject" Width="124px" AutoPostBack="false" runat="server">
                            </asp:DropDownList>
                        </td>
                    </tr>
                    <tr>
                        <td align="left" style="width: 120px">
                            <asp:Label ID="lblFrmDate" Text="From Date:" runat="server"></asp:Label>
                        </td>
                        <td align="left" style="width: 140px">
                            <asp:TextBox ID="txtFrmDate" Width="104px" runat="server"></asp:TextBox>
                            <rjs:PopCalendar ID="rjsFrmDate" Separator="/" Format="mm dd yyyy" Control="txtFrmDate"
                                runat="server" Font-Names="Tahoma" />
                        </td>
                        <td align="left" style="width: 120px">
                            <asp:Label ID="lblToDate" Text="To Date:" runat="server"></asp:Label>
                        </td>
                        <td align="left" style="width: 140px">
                            <asp:TextBox ID="txtToDate" Width="104px" runat="server"></asp:TextBox>
                            <rjs:PopCalendar ID="rjsToDate" Separator="/" Format="mm dd yyyy" Control="txtToDate"
                                runat="server" Font-Names="Tahoma" />
                        </td>
                    </tr>
                    <tr>
                        <td align="left" style="width: 120px">
                        </td>
                        <td align="right" style="width: 140px">
                            <asp:Button ID="btnSearch" Width="104px" Text="Search" Style="background-color: #2A4062;
                                color: White;" OnClientClick="return SearchReportDetails();" runat="server" />
                        </td>
                        <td align="left" style="width: 120px">
                        </td>
                        <td align="left" style="width: 140px">
                        </td>
                    </tr>
                </table>
            </fieldset>
        </div>
        <fieldset style="width: 96%">
            <legend>Details</legend>
            <div style="width: 100%; overflow: scroll; height: 290px;" runat="server">
                <table id="tblDailyReport" style="width: 97%;" class="dataTable">
                </table>
            </div>
        </fieldset>
        <div>
            <asp:Label ID="lblTotalHrs" Text="Total Hrs:" Style="font: calibri; font-size: larger;
                color: Navy;" runat="server"></asp:Label>
            <asp:Label ID="lblHrs" Style="font: calibri; font-size: larger; color: Navy;" runat="server"></asp:Label>
        </div>
    </div>

    <script type="text/javascript" language="javascript">
        var oTable;
        function blockUI() {
            $.blockUI({ message: '<img src="image/ajax-loader.gif" />',
                css: { borderStyle: 'none', backgroundColor: "Transparent" }
            });
        }

        function unblockUI() {
            $.unblockUI();
        }
        $(document).ready(function() {
        SearchReportDetails();
        });
        function dataTable() {
            oTable = $("#tblDailyReport").dataTable({
                bPaginate: false,
                bDestroy: true,
                bJQueryUI: true,
                oLanguage: { "sSearch": "Filter: " }
            }).fixedHeader({ height: 300 });
        }

        function SearchReportDetails() {
            var EmpName = $("select[id$='ddlEmpName'] option:selected").val();
            var FrmDate = $("input[id$='txtFrmDate']").val();
            var ToDate = $("input[id$='txtToDate']").val();
            var Proj = $("select[id$='ddlProject'] option:selected").val();
            if (FrmDate != "") {
            //dateValidation(FrmDate,ToDate);
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
            blockUI();
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "frmDailyReportChck.aspx/SearchRptDetails",
                data: "{'EmpName':'" + EmpName + "','FrmDate':'" + FrmDate + "','ToDate':'" + ToDate + "','Proj':'" + Proj + "'}",
                async: false,
                success: onsuccessSearch,
                error: onretrieveSearchError
            });
            return false;
        }
        function onsuccessSearch(msg) {
            var data = msg.d;
            if (oTable != null) {
                oTable.fnClearTable();
                oTable.fnDestroy();
            }
            var tbl = "";
            tbl += "<thead>";
            tbl += "<tr>";
            tbl += "<th style='white-space:nowrap; text-align:left;display:none;'>Employee ID</th>";
            tbl += "<th style='white-space:nowrap; text-align:left;'>Employee Name</th>";
            tbl += "<th style='white-space:nowrap; text-align:left;'>Check In</th>";
            tbl += "<th style='white-space:nowrap; text-align:left;'>Hour No</th>";
            tbl += "<th style='white-space:nowrap; text-align:left;'>Start Time</th>";
            tbl += "<th style='white-space:nowrap; text-align:left;'>Task Details</th>";
            tbl += "<th style='white-space:nowrap; text-align:left;'>End Time</th>";
            tbl += "<th style='white-space:nowrap; text-align:left;'>Project</th>";
            tbl += "<th style='white-space:nowrap; text-align:left;'>Check Out</th>";
            tbl += "<th style='white-space:nowrap; text-align:left;'>Date</th>";
            tbl += "</tr>";
            tbl += "</thead>";
            tbl += "<tbody>";
            for (var i = 0; i < data.DailyRecordDetails.length; i++) {
                var CurrentDate = (data.DailyRecordDetails[i].CurrentDate);
                tbl += "<td style='text-align:left; white-space:nowrap; display:none;' id='txtESalID" + i + "'>" + data.DailyRecordDetails[i].EmpSal_ID + "</td>";
                tbl += "<td style='text-align:left; white-space:nowrap;' id='txtEName" + i + "'>" + data.DailyRecordDetails[i].E_Name + "</td>";
                tbl += "<td style='text-align:left; white-space:nowrap;' id='txtTimeIn" + i + "'>" + data.DailyRecordDetails[i].TimeIn + " </td>";
                tbl += "<td style='text-align:right; white-space:nowrap;' id='txtHrNo" + i + "'>" + data.DailyRecordDetails[i].hourNo + " </td>";
                tbl += "<td style='text-align:left; white-space:nowrap;' id='txtFrmTime" + i + "'>" + data.DailyRecordDetails[i].fromTime + " </td>";
                tbl += "<td style='text-align:left;' id='txtTaskDetails" + i + "'>" + data.DailyRecordDetails[i].TaskDetails + " </td>";
                tbl += "<td style='text-align:left; white-space:nowrap;' id='txtToTime" + i + "'>" + data.DailyRecordDetails[i].toTime + " </td>";
                tbl += "<td style='text-align:left;' id='txtProject" + i + "'>" + data.DailyRecordDetails[i].Proj_Name + " </td>";
                tbl += "<td style='text-align:left; white-space:nowrap;' id='txtTimeOut" + i + "'>" + data.DailyRecordDetails[i].TimeOut + " </td>";
                tbl += "<td style='text-align:left; white-space:nowrap;' id='txtDate" + i + "'>" + CurrentDate + " </td>";
                tbl += "</tr>";
            }

            tbl += "</tbody>";
            tbl += "</table>";
            $("#tblDailyReport").html(tbl);
            
            CalculateHrs();
             unblockUI();
            //dataTable();
           
            return false;
        }
        function onretrieveSearchError() {
            alert("Error In Loading Details!");
            unblockUI();
            return false;
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
        function CalculateHrs() {
            var Hrs = $("#tblDailyReport tr").length - 1;
            if (Hrs != "-1") {
                $("span[id$='lblHrs']").text(Hrs);
            }
            return false;
        }  
    </script>

</asp:Content>

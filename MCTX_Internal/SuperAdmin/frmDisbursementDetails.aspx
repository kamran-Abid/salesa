<%@ Page Language="C#" MasterPageFile="~/MCTX_Internal/SuperAdmin/MasterAdmin.master"
    AutoEventWireup="true" CodeFile="frmDisbursementDetails.aspx.cs" Inherits="MCTX_Internal_SuperAdmin_frmDispersementDetails"
    Title="Disbursement Details" %>

<%@ Register Assembly="RJS.Web.WebControl.PopCalendar.Net.2008" Namespace="RJS.Web.WebControl"
    TagPrefix="rjs" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <script src="../../js/jquery.dataTables.js" type="text/javascript"></script>
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
            <li style="text-align: left"><a href="#tabs-1">Disbursement Details</a></li>
        </ul>
        <div id="tabs-1">
            <fieldset id="fldDisp" style="margin-bottom: 15px">
                <legend>Search</legend>
                <table width="100%">
                    <tr>
                        <td align="left" width="83px">
                            Date:
                        </td>
                        <td align="left" width="200px">
                            <asp:TextBox ID="txtDisbursedDate" Width="162px" runat="server"></asp:TextBox>
                            <rjs:PopCalendar ID="PopCalendar1" runat="server" InvalidDateMessage="Invalid Date."
                                TextMessage="Invalid Date." ShowMessageBox="True" Separator="/" Format="mm dd yyyy"
                                Control="txtDisbursedDate"></rjs:PopCalendar>
                        </td>
                        <td align="left" width="50px">
                            <asp:Button ID="btnSearch" Text="Search" OnClientClick="return getSearchData();"
                                runat="server" />
                        </td>
                        <td align="left" width="80px">
                            <asp:Button ID="btnClear" Text="Clear" OnClientClick="return clearDispFields();"
                                runat="server" />
                        </td>
                        <td>
                        </td>
                        <td>
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
                        <tr>
                            <td align="left">
                                Disbursed By:
                            </td>
                            <td align="left">
                                <asp:TextBox ID="txtDisbursedBy" Width="162px" runat="server"></asp:TextBox>
                            </td>
                            <td align="left">
                                Disbursed To:
                            </td>
                            <td align="left">
                                <asp:TextBox ID="txtDisbursedTo" Width="162px" runat="server"></asp:TextBox>
                            </td>
                            <td align="left">
                                Disbursement Method:
                            </td>
                            <td align="left">
                                <asp:TextBox ID="txtDisbursementMethod" Width="162px" runat="server"></asp:TextBox>
                            </td>
                        </tr>
                    </table>
                </div>
            </fieldset>
            <div style="overflow: auto; width: 990px; height: 565px">
                <table align='center' class="dataTable" id="tblDispData" style="width: 990px;">
                </table>
            </div>
        </div>
    </div>

    <script language="javascript" type="text/javascript">


        var oTable;

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
            //$("input[id$='txtDisbursedDate']").datepicker({ dateFormat: 'mm/dd/yy' });      
            getDispersementData();
        });

        function dataTable() {
            oTable = $("#tblDispData").dataTable({
                bPaginate: false,
                bJQueryUI: true,
                oLanguage: { "sSearch": "Filter: " }
            }).fixedHeader({ height: 500 });
        }
        function getDispersementData() {
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "frmDisbursementDetails.aspx/DispData",
                data: "{}",
                success: onsuccessLoadData,
                error: onretrieveError
            });
            return false;
        }
        function getSearchData() {
            var Disp_Date = $("input[id$='txtDisbursedDate']").val();
            var Disp_By = $("input[id$='txtDisbursedBy']").val();
            var Disp_To = $("input[id$='txtDisbursedTo']").val();
            var Disp_Method = $("input[id$='txtDisbursementMethod']").val();
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "frmDisbursementDetails.aspx/DispSearchData",
                dataType: "json",
                data: "{'Disp_Date':'" + Disp_Date + "', 'Disp_By':'" + Disp_By + "', 'Disp_To':'" + Disp_To + "', 'Disp_Method':'" + Disp_Method + "'}",
                success: onsuccessLoadData,
                error: onretrieveError
            });
            return false;
        }
        function onsuccessLoadData(msg) {
            var data = msg.d;
            if (oTable != null) {
                oTable.fnClearTable();
                oTable.fnDestroy();
            }
            var tbl = "";
            tbl += "<thead>";
            tbl += "<tr>";
            tbl += "<th style='text-align:center; white-space:nowrap;'>Delete</th>";
            tbl += "<th style='text-align:center; white-space:nowrap;'>Edit</th>";
            tbl += "<th style='white-space:nowrap; text-align:left;'>ID</th>";
            tbl += "<th style='white-space:nowrap; text-align:left;'>Disbursed By</th>";
            tbl += "<th style='white-space:nowrap; text-align:left;'>Disbursed To</th>";
            tbl += "<th style='white-space:nowrap; text-align:left;'>Disbursed Amount</th>";
            tbl += "<th style='white-space:nowrap; text-align:left;'>Disburse Method</th>";

            tbl += "<th style='white-space:nowrap; text-align:left;'>Created By</th>";
            tbl += "<th style='white-space:nowrap; text-align:left;'>Created Date</th>";
            tbl += "<th style='white-space:nowrap; text-align:left;'>Modified By</th>";
            tbl += "<th style='white-space:nowrap; text-align:left;'>Modification Date</th>";
            tbl += "</tr>";
            tbl += "</thead>";
            tbl += "<tbody>";
            for (var i = 0; i < data.DisData.length; i++) {
                datet = ConvertDate(data.DisData[i].Created_Date);
                mdatet = ConvertDate(data.DisData[i].Modified_Date);
                tbl += "<td style='cursor:Pointer;' id='txtdelete' align='center' onclick='return DeleteRecord(" + i + ");'><img src='image/Cross.png'> </td>";
                tbl += "<td style='cursor:Pointer;' id='txtUpdate' align='center' onclick='return EditRecord(" + i + ");'><img src='image/Edit.png'></td>";
                tbl += "<td style='text-align:left;' id='txtID" + i + "'>" + data.DisData[i].Dispersment_Id + "</td>";
                tbl += "<td style='text-align:left;' id='txtDisbursed_By" + i + "'>" + data.DisData[i].ApproveAuth_name + " </td>";
                tbl += "<td style='text-align:left;' id='txtDisbursed_To" + i + "'>" + data.DisData[i].Dispersed_To + " </td>";

                tbl += "<td style='text-align:left;' id='txtDisbursed_Amount" + i + "'>" + data.DisData[i].Dispersed_Amount + " </td>";

                tbl += "<td style='text-align:left;' id='txtDisbursement_Method" + i + "'>" + data.DisData[i].Dispersed_Method + " </td>";

                tbl += "<td style='text-align:left;' id='txtCreated_By" + i + "'>" + data.DisData[i].Created_By + " </td>";
                tbl += "<td style='text-align:left;' id='txtCreated_Date" + i + "'>" + datet + " </td>";
                tbl += "<td style='text-align:left;' id='txtModified_By" + i + "'>" + data.DisData[i].Modified_By + " </td>";
                tbl += "<td style='text-align:left;' id='txtModified_Date" + i + "'>" + mdatet + " </td>";
                tbl += "</tr>";
            }
            tbl += "</tbody>";
            tbl += "</table>";
            $("#tblDispData").html(tbl);
            dataTable();
            return false;
        }
        function DeleteRecord(rowNo) {
            var ID = $("#txtID" + rowNo).html();
            if (confirm("Are you sure you wish to delete this Record?")) {
                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "frmDisbursementDetails.aspx/DeleteDispData",
                    data: "{'Disp_Id':'" + ID + "'}",
                    dataType: "json",
                    success: onsucessDeleteData,
                    error: onretrieveDeleteError
                });
            }
            else {
                return false;
            }
            return false;
        }
        function EditRecord(rowNo) {
            var ID = $("#txtID" + rowNo).html();
            window.location = 'ReceiptsAndExpense.aspx?Disp_Id=' + ID;
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

        function onretrieveError() {
            alert("Error occured in loading details!");
        }
        function clearDispFields() {
            $("#fldDisp input[type='text']").val("");
            return false;
        }
        function openAdvancedSearch() {
            $("#divAdvanceSearch").slideToggle();
            return false;
        }
        function onsucessDeleteData() {
            getDispersementData();
            alert("Record successfully deleted!");
            return false;
        }
        function onretrieveDeleteError() {
            getDispersementData();
            alert("Error occurred in deleting record!");
        }

    </script>

</asp:Content>

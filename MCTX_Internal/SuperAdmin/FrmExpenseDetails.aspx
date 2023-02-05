<%@ Page Language="C#" MasterPageFile="~/MCTX_Internal/SuperAdmin/MasterAdmin.master"
    AutoEventWireup="true" CodeFile="FrmExpenseDetails.aspx.cs" Inherits="MCTX_Internal_FrmExpenseDetails"
    Title="Expense Details" %>

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
        .style10
        {
            width: 116px;
        }
        .style11
        {
            width: 135px;
        }
        .style12
        {
            width: 161px;
        }
    </style>
    <div id="tabs" style="width: 950px">
        <ul>
            <li style="text-align: left"><a href="#tabs-1">Expense Details</a></li>
        </ul>
        <div id="tabs-1">
            <fieldset style="width: 914px;">
                <table style="width: 100%">
                    <tr>
                        <td align="left" class="style11">
                            <asp:Label ID="Label6" runat="server" Text="Expense Date From"></asp:Label>
                        </td>
                        <td align="left" class="style12">
                            <asp:TextBox ID="txtExpenseDate" runat="server" Style="border: solid 1px gray;"></asp:TextBox>
                            <rjs:PopCalendar ID="PopCalendar1" runat="server" InvalidDateMessage="Invalid Date."
                                TextMessage="Invalid Date." ShowMessageBox="True" Separator="/" Format="mm dd yyyy"
                                Control="txtExpenseDate"></rjs:PopCalendar>
                        </td>
                        <td align="left" class="style10">
                            <asp:Label ID="Label1" runat="server" Text="Expense Date To"></asp:Label>
                        </td>
                        <td align="left">
                            <asp:TextBox ID="txtExpenseDateTo" runat="server" Style="border: solid 1px gray;"></asp:TextBox>
                            <rjs:PopCalendar ID="PopCalendar2" runat="server" InvalidDateMessage="Invalid Date."
                                TextMessage="Invalid Date." ShowMessageBox="True" Separator="/" Format="mm dd yyyy"
                                Control="txtExpenseDateTo"></rjs:PopCalendar>
                        </td>
                        <td align="left">
                            <asp:Button ID="btnSimpSearch" runat="server" Text="Search" Width="86px" OnClientClick="return advSearch();"
                                BackColor="#C5C8CC" Font-Bold="False" ForeColor="Black" />
                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                            <asp:Button ID="btnExportToExcel" runat="server" Text="Export To Excel" Width="120px"
                                OnClientClick="return ExportDataTableToExcel();" BackColor="#C5C8CC" Font-Bold="False"
                                ForeColor="Black" OnClick="btnExportToExcel_Click" />
                        </td>
                        <td align="right">
                            <asp:Button ID="btn_back" runat="server" Text="Back" Width="86px" BackColor="#C5C8CC"
                                Font-Bold="False" ForeColor="Black" OnClick="btn_back_Click" />
                        </td>
                    </tr>
                    <tr align="left">
                        <td align="left" class="style11">
                            <asp:Button ID="btnAdvSearch" runat="server" Text="Advance Search" Width="123px"
                                OnClientClick="return toggle();" BackColor="#1B2B56" Font-Bold="True" ForeColor="#E3DDD6" />
                        </td>
                        <td class="style12">
                        </td>
                        <td class="style10">
                        </td>
                        <td>
                        </td>
                    </tr>
                </table>
                <table style="width: 786px" id="SerchOptions">
                    <tr>
                        <td align="left">
                            <asp:Label ID="Label5" runat="server" Text="Expense By"></asp:Label>
                        </td>
                        <td align="left">
                            <%--<asp:TextBox ID="txtExpenseBy" runat="server"></asp:TextBox>--%>
                            <asp:DropDownList runat="server" ID="ddlExpenseBy" Style="border: solid 1px gray;
                                width: 118px">
                            </asp:DropDownList>
                        </td>
                        <td align="left">
                            <asp:Label ID="Label3" runat="server" Text="Expense Category" ForeColor="#333300"></asp:Label>
                        </td>
                        <td align="left">
                            <asp:DropDownList runat="server" ID="ddlExpenseCategory" Style="border: solid 1px gray;
                                width: 124px">
                                <asp:ListItem></asp:ListItem>
                            </asp:DropDownList>
                            <%--<asp:TextBox ID="txtExpenseAmount" runat="server" ForeColor="#333300" Style="border: solid 1px gray;"></asp:TextBox>--%>
                        </td>
                    </tr>
                    <tr>
                        <td align="left" class="style7">
                            <asp:HiddenField ID="hdnExeclInfo" runat="server" />
                            <asp:Label ID="Label2" runat="server" Text="Expense Id:" ForeColor="#333300"></asp:Label>
                        </td>
                        <td align="left" class="style8">
                            <asp:TextBox ID="txtExpenseId" runat="server" ForeColor="#333300" Style="border: solid 1px gray;"></asp:TextBox>
                        </td>
                        <td align="left">
                            <asp:Label ID="Label8" runat="server" Text="Created By"></asp:Label>
                        </td>
                        <td align="left">
                            <%-- <asp:TextBox ID="txtCreatedBy" runat="server"></asp:TextBox>--%>
                            <asp:DropDownList ID="ddlDispersedTo" Width="124px" runat="server" Style="border: solid 1px gray">
                                <asp:ListItem></asp:ListItem>
                            </asp:DropDownList>
                        </td>
                    </tr>
                    <tr>
                        <td align="left">
                            <asp:Label ID="Label4" runat="server" Text="Expense Type" ForeColor="#333300"></asp:Label>
                        </td>
                        <td align="left">
                            <asp:DropDownList ID="ddlExpenseType" Width="120px" runat="server" Style="border: solid 1px gray;
                                width: 124px">
                            </asp:DropDownList>
                            <%--<asp:TextBox ID="txtExpenseType" runat="server" ForeColor="#333300"></asp:TextBox>--%>
                        </td>
                        <td align="left">
                            <asp:Label ID="Label7" runat="server" Text="Project Name"></asp:Label>
                        </td>
                        <td align="left">
                            <%--<asp:TextBox ID="txtExpenseProject" runat="server"></asp:TextBox>--%>
                            <asp:DropDownList ID="ddlProjectName" runat="server" Width="124px" Style="border: solid 1px gray;
                                width: 124px">
                                <asp:ListItem></asp:ListItem>
                            </asp:DropDownList>
                        </td>
                    </tr>
                    <tr>
                        <td align="left">
                            <asp:Label ID="Label9" runat="server" Text="Expense Status" ForeColor="#333300"></asp:Label>
                        </td>
                        <td align="left">
                            <asp:DropDownList runat="server" ID="ddlExpStatus" Style="border: solid 1px gray;
                                width: 124px">
                                <asp:ListItem></asp:ListItem>
                                <asp:ListItem>Receipted</asp:ListItem>
                                <asp:ListItem>Non Receipted</asp:ListItem>
                            </asp:DropDownList>
                            <%--<asp:TextBox ID="txtExpenseStatus" runat="server"></asp:TextBox>--%>
                        </td>
                        <td align="left">
                            <asp:Label ID="Label10" runat="server" Text="Modified By" ForeColor="#333300"></asp:Label>
                        </td>
                        <td align="left">
                            <%--<asp:TextBox ID="txtModifiedBy" runat="server"></asp:TextBox>--%>
                            <asp:DropDownList runat="server" ID="ddlReceivedBy" Style="border: solid 1px gray;
                                width: 124px">
                            </asp:DropDownList>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <td>
                            </td>
                        </td>
                        <td align="left">
                        </td>
                        <td align="left">
                            <%-- <asp:Button ID="btnSearch" runat="server" Text="Search" OnClientClick="return advSearch();" />--%>
                        </td>
                    </tr>
                </table>
            </fieldset>
            <table width="100%">
                <tr>
                    <td>
                        <div id="divExport">
                            <div style="overflow: auto; width: 935px; height: 480px">
                                <table id="tblExpDetails" width="100%" class="dataTable">
                                </table>
                            </div>
                        </div>
                    </td>
                </tr>
            </table>
        </div>
    </div>

    <script type="text/javascript" language="javascript">
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
            $("table[id$='SerchOptions']").slideToggle();
            advSearch();
            //getExpenseDetails();
        });

        function dataTable() {
            oTable = $("#tblExpDetails").dataTable({
                bPaginate: false,
                bJQueryUI: true,
                oLanguage: { "sSearch": "Filter: " }
            }).fixedHeader({ height: 400 });
        }


        function ConvertDate(dateString) {
            var date = new Date(parseInt(dateString.replace(/\/Date\((\d+)\)\//, '$1')));
            var month = date.getMonth() + 1;
            if (month < 10)
                month = '0' + month;
            var day = date.getDate();
            if (day < 10)
                day = '0' + day;
            var year = date.getFullYear();
            var datet = month + "/" + day + "/" + year;
            return datet
        }

        function getRowID(rowID) {
            $("table[id$='tblExpDetails'] tr").css("background-color", "white");
            $("#trmain" + rowID).css("background-color", "#D3D3D3");
            return false;
        }

        function advSearch() {

            //(string expId, string expBy, string expCategory, string expDate, string expType, string expProject, string expStatus, string createdBy, string modifiedBy)
            var expId = $("input[id$='txtExpenseId']").val();
            var expBy = $("select[id$='ddlExpenseBy'] option:selected").val();
            var expCategory = $("select[id$='ddlExpenseCategory'] option:selected").val(); //ddlDispersedTo
            var expDate = $("input[id$='txtExpenseDate']").val();
            var expDateTo = $("input[id$='txtExpenseDateTo']").val();
            var expType = $("select[id$='ddlExpenseType'] option:selected").val();
            var expProject = $("select[id$='ddlProjectName'] option:selected").val();
            var expStatus = $("select[id$='ddlExpStatus'] option:selected").val();
            var createdBy = $("select[id$='ddlDispersedTo'] option:selected").val();
            var modifiedBy = $("select[id$='ddlReceivedBy'] option:selected").val();


            $.ajax({
                type: "POST",
                dataType: "json",
                contentType: "application/json; charset=utf-8",
                url: "FrmExpenseDetails.aspx/GetExpAdvSearch",
                data: "{'expId':'" + expId + "', 'expBy':'" + expBy + "', 'expCategory':'" + expCategory + "', 'expDate':'" + expDate + "', 'expDateTo':'" + expDateTo + "', 'expType':'" + expType + "', 'expProject':'" + expProject + "', 'expStatus':'" + expStatus + "', 'createdBy':'" + createdBy + "', 'modifiedBy':'" + modifiedBy + "'}",
                success: onsuccessAdvSearch,
                error: OnretrieveError
            });
            return false;
        }

        function onsuccessAdvSearch(msg) {
            var TotalAmount = 0;
            var data = msg.d;
            if (oTable != null) {
                oTable.fnClearTable();
                oTable.fnDestroy();
            }
            var tbl = "";

            tbl += "<thead>";
            tbl += "<tr>";


            tbl += "<th id='txtDeleteth' style='cursor:Pointer;text-align:center;white-space:nowrap;border:1px solid #999999;'>Del</th>";
            tbl += "<th id='txtEditth' style='cursor:Pointer;text-align:center;white-space:nowrap;border:1px solid #999999;'>Edit</th>";
            tbl += "<th style='cursor:Pointer;text-align:left;white-space:nowrap;border:1px solid #999999;'>ID</th>";
            tbl += "<th style='cursor:Pointer;text-align:left;white-space:nowrap;border:1px solid #999999;'>Expense By</th>";
            tbl += "<th style='cursor:Pointer;text-align:left;white-space:nowrap;border:1px solid #999999;'>Exp Amt</th>";
            tbl += "<th style='cursor:Pointer;text-align:left;white-space:nowrap;border:1px solid #999999;'>Date</th>";
            tbl += "<th style='cursor:Pointer;text-align:left;white-space:nowrap;border:1px solid #999999;'>Exp Type</th>";
            tbl += "<th style='cursor:Pointer;text-align:left;white-space:nowrap;border:1px solid #999999;'>Project Name</th>";
            tbl += "<th style='cursor:Pointer;text-align:left;white-space:nowrap;border:1px solid #999999;'>Status</th>";
            tbl += "<th style='cursor:Pointer;text-align:left;white-space:nowrap;border:1px solid #999999;'>Exp. Detail</th>";
            tbl += "<th style='cursor:Pointer;text-align:left;white-space:nowrap;border:1px solid #999999;'>Modified By</th>";
            tbl += "<th style='cursor:Pointer;text-align:left;white-space:nowrap;border:1px solid #999999;'>Modified Date</th>";
            tbl += "<th style='cursor:Pointer;text-align:left;white-space:nowrap;border:1px solid #999999;'>Created By</th>";
            tbl += "<th style='cursor:Pointer;text-align:left;white-space:nowrap;border:1px solid #999999;'>Created Date</th>";
            tbl += "</tr>";
            tbl += "</thead>";
            tbl += "<tbody>";
            for (var i = 0; i < data.AdvDetails.length; i++) {
                TotalAmount = TotalAmount + data.AdvDetails[i].Expense_Amount;
                var dattt = ""
                if (data.AdvDetails[i].Expense_Date != null && data.AdvDetails[i].Expense_Date != undefined)
                    dattt = ConvertDate(data.AdvDetails[i].Expense_Date);
                var cdate = "";
                if (data.AdvDetails[i].Created_Date != null && data.AdvDetails[i].Created_Date != undefined)
                    cdate = ConvertDate(data.AdvDetails[i].Created_Date);
                var mdate = "";
                if (data.AdvDetails[i].Modified_Date != null && data.AdvDetails[i].Modified_Date != undefined)
                    mdate = ConvertDate(data.AdvDetails[i].Modified_Date);

                tbl += "<tr id='trmain" + i + "' style='cursor:default;border:1px solid #999999;' onclick='getRowID(" + i + ");'>";
                tbl += "<td id='txtDelete" + i + "' align='center' style='border:1px solid #999999;'> <input  type='image' src='image/Cross.png' onclick='return DeleteExpRecord(" + i + ");'></td>";
                tbl += "<td id='txtEdit" + i + "' align='center' style='border:1px solid #999999;'> <input  type='image' src='image/Edit.png' onclick='return GetRowForUpdation(" + i + ");'></td>";
                tbl += "<td id='txtExpId" + i + "' align='left' style='white-space:nowrap;border:1px solid #999999;'>" + data.AdvDetails[i].Expense_Id + " </td>";
                tbl += "<td id='txtExpBy" + i + "' align='left' style='white-space:nowrap;border:1px solid #999999;'>" + data.AdvDetails[i].Expense_By + " </td>";
                tbl += "<td id='txtExpAmount" + i + "' align='right' style='white-space:nowrap;border:1px solid #999999;'>" + data.AdvDetails[i].Expense_Amount + " </td>";
                tbl += "<td id='txtExpDate" + i + "' align='left' style='white-space:nowrap;border:1px solid #999999;'>" + dattt + " </td>";
                tbl += "<td id='txtExpType" + i + "'  align='left' style='white-space:nowrap;border:1px solid #999999;'>" + data.AdvDetails[i].ExpenseType_Name + " </td>";
                tbl += "<td id='txtExpProject" + i + "' align='left' style='white-space:nowrap;border:1px solid #999999;'>" + data.AdvDetails[i].Pro_Name + " </td>";
                tbl += "<td id='txtExpStatus" + i + "' align='left' style='white-space:nowrap;border:1px solid #999999;'>" + data.AdvDetails[i].Expense_Status + " </td>";
                tbl += "<td id='txtExpStatus" + i + "' align='left' style='white-space:nowrap;border:1px solid #999999;'>" + data.AdvDetails[i].Expense_Detail + " </td>";
                tbl += "<td id='txtModifiedBy" + i + "'  align='left' style='white-space:nowrap;border:1px solid #999999;'>" + data.AdvDetails[i].Modified_By + " </td>";
                tbl += "<td id='txtModiDate" + i + "'  align='left' style='white-space:nowrap;border:1px solid #999999;'>" + mdate + " </td>";
                tbl += "<td id='txtExpCreated" + i + "'  align='left' style='white-space:nowrap;border:1px solid #999999;'>" + data.AdvDetails[i].Created_By + " </td>";
                tbl += "<td id='txtExpCreatedDate" + i + "'  align='left' style='white-space:nowrap;border:1px solid #999999;'>" + cdate + " </td>";
                tbl += "</tr>";
            }
            tbl += "<tr style='cursor:default;border:1px solid #999999;'>";
            tbl += "<td  style='white-space:nowrap;border:1px solid #999999;' >&nbsp;</td>";
            tbl += "<td  style='white-space:nowrap;border:1px solid #999999;'>&nbsp;</td>";
            tbl += "<td style='white-space:nowrap;border:1px solid #999999;'>&nbsp; </td>";
            tbl += "<td  style='white-space:nowrap;border:1px solid #999999;'>&nbsp;</td>";
            tbl += "<td  style='white-space:nowrap;border:1px solid #999999;'>&nbsp;</td>";
            tbl += "<td  style='white-space:nowrap;border:1px solid #999999;'>&nbsp;</td>";
            tbl += "<td  style='white-space:nowrap;border:1px solid #999999;'>&nbsp;</td>";
            tbl += "<td  style='white-space:nowrap;border:1px solid #999999;'>&nbsp;</td>";
            tbl += "<td  style='white-space:nowrap;border:1px solid #999999;'>&nbsp;</td>";
            tbl += "<td  style='white-space:nowrap;border:1px solid #999999;'>&nbsp;</td>";
            tbl += "<td  style='white-space:nowrap;border:1px solid #999999;'>&nbsp;</td>";
            //                tbl += "<td  style='white-space:nowrap;border:1px solid #999999;'>&nbsp;</td>"; 
            //                tbl += "<td >&nbsp; </td>"; 
            tbl += "</tr>";

            tbl += "<tr id='trlastID'>";
            tbl += "<td colspan='4' style='font-weight:bold;color: maroon'>Total Amount </td>";
            tbl += "<td colspan='5' style='color: maroon;font-weight: bold;padding-left: 28px;' align='left'>" + TotalAmount + " </td>";
            tbl += "</tr>";
            tbl += "</tbody>";
            tbl += "</table>";
            $("#tblExpDetails").html(tbl);

            return false;
            dataTable();
        }

        function OnretrieveError() {
            alert("Error occured in loading details! ");
            return false;
        }

        function toggle() {
            $("table[id$='SerchOptions']").slideToggle();
            return false;
        }

        ///////////Deleting expense record
        function DeleteExpRecord(rowNo) {
            var expID = $("#txtExpId" + rowNo).html();
            if (confirm("Are you sure you wish to delete this Record?")) {
                $.ajax({
                    type: "POST",
                    dataType: "json",
                    contentType: "application/json; charset=utf-8",
                    url: "FrmExpenseDetails.aspx/DeleteExpense",
                    data: "{'expID':'" + expID + "'}",
                    success: onSuccessDelete,
                    error: OnretrieveError
                });
            }
            else {
                return false;
            }
            return false;
        }

        function onSuccessDelete() {
            alert("Expense deleted successfully! ");
            getExpenseDetails();
            return false;
        }

        ///////////////////

        //// Updation //////////////

        function GetRowForUpdation(rowNo) {
            //     $("input[id$='btn_save']").hide();
            //     $("input[id$='btnNew']").show();
            //     $("input[id$='btn_update']").show();
            //        var CityID= $("#txtCityID"+rowNo).html(); 
            //        var CityName =$("#txtCityName"+rowNo).html(); 
            //      
            //        $("input[id$='txt_CityId']").val(CityID);
            //        $("input[id$='txtcity']").val(CityName);
            //        
            //    

            var expID = $("#txtExpId" + rowNo).html();
            window.location = 'ReceiptsAndExpense.aspx?ExpID=' + expID;
            return false;
        }

        //**********************************************Export to Excel------------------------------------

        function ExportDataTableToExcel() {
            //<div id="divExport">
            $("#txtDeleteth").remove();
            $("#txtEditth").remove();
            $("td [id^='txtDelete']").remove();
            $("td [id^='txtEdit']").remove();
            //$("#trlastID").remove();
            var html = $("#divExport").html();
            html = $.trim(html);
            html = html.replace(/>/g, '&gt;');
            html = html.replace(/</g, '&lt;');
            $("input[id$='hdnExeclInfo']").val(html);

        }

        function loadAgain() {
            advSearch();

        }


    </script>

</asp:Content>

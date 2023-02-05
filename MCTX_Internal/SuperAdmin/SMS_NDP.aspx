<%@ Page Language="C#" MasterPageFile="~/MCTX_Internal/SuperAdmin/MasterAdmin.master"
    AutoEventWireup="true" CodeFile="SMS_NDP.aspx.cs" Inherits="MCTX_Internal_SuperAdmin_frmProductInfo"
    Title="Mechatronix Employee(s) Planner" %>

<%@ Register Assembly="RJS.Web.WebControl.PopCalendar.Net.2008" Namespace="RJS.Web.WebControl"
    TagPrefix="rjs" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <script src="../../js/jquery.dataTables.min.js" type="text/javascript"></script>
    <script src="../../js/BlockUI.js" type="text/javascript"></script>

    <table style="width: 100%; height: 288px;">
        <tr>
            <td valign="top" style="height: 331px">
                <div id="tabs">
                    <ul>
                        <li style="text-align: left"><a href="#tabs-1">Employee(s) Planner</a></li>
                    </ul>
                    <div id="tabs-1">
                        <fieldset style="border: 1px solid #ABD3FC; padding-bottom: 15px; padding-top: 10px;">
                            <legend>Search Criteria:</legend>
                            <table width="100%">
                                <tr>
                                    <td>
                                        From Date:
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtFromDate" runat="server" BorderStyle="Inset"></asp:TextBox><rjs:PopCalendar
                                            ID="rjsReportDate" Separator="/" Format="mm dd yyyy" Control="txtFromDate" runat="server" />
                                    </td>
                                    <td>
                                        To Date:
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtToDate" runat="server" BorderStyle="Inset"></asp:TextBox><rjs:PopCalendar
                                            ID="PopCalendar1" Separator="/" Format="mm dd yyyy" Control="txtToDate" runat="server" />
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        Employee
                                    </td>
                                    <td>
                                        <asp:DropDownList ID="ddlEmployee" runat="server">
                                        </asp:DropDownList>
                                    </td>
                                    <td>
                                    </td>
                                    <td>
                                        <asp:Button  Width="104px" Style="background-color: #2A4062;
                                color: White;" runat="server" ID="btnSearch" Text="Search" OnClientClick="return GetNDPlans();" />
                                    </td>
                                </tr>
                            </table>
                        </fieldset>
                        <div style="height: 400px; overflow: auto; width: 100%; margin-top: 20px;border:1px solid gray">
                            <table id="NDPlans" style="width: 100%" class="dataTable">
                            </table>
                        </div>
                    </div>
                </div>
            </td>
        </tr>
    </table>
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
        input:focus
        {
            box-shadow: 0 -1px 0 rgba(0, 0, 0, 0.3), 0 1px 2px rgba(0, 0, 0, 0.1) inset, 0 0 10px rgba(255, 255, 255, 0.9);
            border: 1px solid #ABD3FC;
        }
        input
        {
            border: 1px solid gray;
            width: 175px;
            height: 17px;
        }
        select
        {
            border: 1px solid gray;
            width: 194px;
            height: 20px;
        }
    </style>

    <script type="text/javascript" language="javascript">
    
    function blockUI() {
            $.blockUI({ message: '<img src="image/ajax-loader.gif" />',
                css: { borderStyle: 'none', backgroundColor: "Transparent" }
            });
        }

        function unblockUI() {
            $.unblockUI();
        }
        $(document).ready(function() {
            GetNDPlans();
        });


        //-----------------------------------------------------------------------Display Next Day Plans------ Obaid Altaf May 04, 2012
        function GetNDPlans() {
            var FrmDate = $("input[id$='txtFromDate']").val().trim();
            var ToDate = $("input[id$='txtToDate']").val().trim();
            var Emp = $("select[id$='ddlEmployee'] option:selected").val().trim();
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
                dataType: "json",
                contentType: "application/json; charset=utf-8",
                url: "SMS_NDP.aspx/GetNDPlans",
                data: "{'datefrom':'" + FrmDate + "','dateto':'" + ToDate + "','Emp':'" + Emp + "'}",
                success: onsuccessGetNDPlans,
                error: OnretrieveGetNDPlans
            });
            return false;

        }
        function onsuccessGetNDPlans(msg) {
            var data = msg.d;
            var tbl = "";
            tbl += "<thead>";
            tbl += "<tr>";

            tbl += "<th style='cursor:Pointer;text-align:left;white-space:nowrap;border:1px solid #999999;'>Sr. #</th>";
            tbl += "<th style='cursor:Pointer;text-align:left;white-space:nowrap;border:1px solid #999999;'>Name</th>";
            tbl += "<th style='cursor:Pointer;text-align:left;white-space:nowrap;border:1px solid #999999;'>ID</th>";
            tbl += "<th style='cursor:Pointer;text-align:left;white-space:nowrap;border:1px solid #999999;'>Task</th>";
            tbl += "<th style='cursor:Pointer;text-align:left;white-space:nowrap;border:1px solid #999999;'>Department</th>";
            tbl += "<th style='cursor:Pointer;text-align:left;white-space:nowrap;border:1px solid #999999;'>Duration</th>";
            tbl += "<th style='cursor:Pointer;text-align:left;white-space:nowrap;border:1px solid #999999;'>Phone</th>";
            tbl += "<th style='cursor:Pointer;text-align:left;white-space:nowrap;border:1px solid #999999;'>Date</th>";
            tbl += "</tr>";
            tbl += "</thead>";
            tbl += "<tbody>";
            var j = 0;
            for (var i = 0; i < data.NDP.length; i++) {
                j = i + 1;
                tbl += "<tr id='trmain" + i + "' style='cursor:default;border:1px solid #999999;'>";
                tbl += "<td align='left'  style='white-space:nowrap;border:1px solid #999999;'>" + j + " </td>";
                tbl += "<td align='left'  style='white-space:nowrap;border:1px solid #999999;'>" + data.NDP[i].Emp_Name + " </td>";
                tbl += "<td align='left'  style='white-space:nowrap;border:1px solid #999999;'>" + data.NDP[i].Emp_Id + " </td>";
                tbl += "<td align='left'  style='white-space:nowrap;border:1px solid #999999;white-space:no-wrap' title=" + data.NDP[i].Task + ">" + data.NDP[i].Task.substr(0, 30) + " </td>";
                tbl += "<td align='left'  style='white-space:nowrap;border:1px solid #999999;'>" + data.NDP[i].Department + " </td>";
                tbl += "<td align='left'  style='white-space:nowrap;border:1px solid #999999;'>" + data.NDP[i].Duration + " </td>";
                tbl += "<td align='left'  style='white-space:nowrap;border:1px solid #999999;'>" + data.NDP[i].PhoneNo + " </td>";
                tbl += "<td align='left'  style='white-space:nowrap;border:1px solid #999999;'>" + data.NDP[i].Task_Date + " </td>";
                tbl += "</tr>";
            }

            tbl += "</tbody>";
            tbl += "</table>";
            $("#NDPlans").html(tbl);
            unblockUI();
        }
        function OnretrieveGetNDPlans() {
            alert("Error in loading Next Day Plans!");
            return false;
        }

        
    </script>

</asp:Content>

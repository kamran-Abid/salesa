<%@ Page Language="C#" MasterPageFile="~/MCTX_Internal/SuperAdmin/MasterAdmin.master"
    AutoEventWireup="true" CodeFile="DailyReport_Summary.aspx.cs" Inherits="MCTX_Internal_SuperAdmin_DailyReport_Summary"
    Title="Daily Report Summary" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajtk" %>
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
    </style>


    <fieldset style="margin: 5px">
        <legend>Search Criteria</legend>
        <table style="width: 788px">
            <tr>
                <td align="left">
                    From Date:
                </td>
                <td align="left">
                    <asp:TextBox ID="txtFromDate" Width="100px" Text="" runat="server" Style="border: solid 1px gray;
                        background-color: White; height: 14px;" />
                    <rjs:PopCalendar ID="PopCalendar1" runat="server" InvalidDateMessage="Invalid Date."
                        TextMessage="Invalid Date." ShowMessageBox="True" Separator="/" Format="mm dd yyyy"
                        Control="txtFromDate"></rjs:PopCalendar>
                </td>
                <td align="left">
                    Name:
                </td>
                <td align="left">
                    <asp:DropDownList ID="ddlUsers" Width="170px" runat="server" Style="border: solid 1px gray;">
                        <asp:ListItem></asp:ListItem>
                    </asp:DropDownList>
                </td>
            </tr>
            <tr>
                <asp:ScriptManager ID="ScriptManager1" runat="server">
                </asp:ScriptManager>
                <td align="left">
                    To Date:
                </td>
                <td align="left">
                    <asp:TextBox ID="txtToDate" Width="100px" Style="border: solid 1px gray; background-color: White;
                        height: 14px;" Text="" runat="server" />
                    <rjs:PopCalendar ID="PopCalendar2" runat="server" InvalidDateMessage="Invalid Date."
                        TextMessage="Invalid Date." ShowMessageBox="True" Separator="/" Format="mm dd yyyy"
                        Control="txtToDate"></rjs:PopCalendar>
                </td>
                <td>
                    &nbsp;
                </td>
                <td align="left">
                    <br />
                    <asp:Button ID="btnSearch" Text="Search" runat="server" Width="75px" OnClientClick="GetUserDailyReportDetail(); return false;" />
                </td>
            </tr>
            <tr>
                <td align="left" colspan="4">
                    <div id="tdWorkingHours" style="display: block">
                        <span>Your Working Hours: &nbsp;&nbsp;&nbsp;</span> <span id="spnHours" style="font-weight: bold;
                            color: Maroon;"></span><span></span>
                    </div>
                </td>
            </tr>
        </table>
    </fieldset>
    <fieldset style="margin: 5px">
        <%--<table style="width: 788px" class="dataTable">
<tr style='cursor:default;border:1px solid #999999;'>
<th  align='left'  style='white-space:nowrap;border:1px solid #999999;width:114px'>
Employee Name
</th>
<th  align='left'  style='white-space:nowrap;border:1px solid #999999;width:58px'>
Emp ID
</th>
<th  align='left'  style='white-space:nowrap;border:1px solid #999999;width:280px''>
Task Detail
</th>
<th  align='left'  style='white-space:nowrap;border:1px solid #999999;width:70px''>
From Time
</th>
<th  align='left'  style='white-space:nowrap;border:1px solid #999999;width:71px''>
To Time
</th>
<th  align='left'  style='white-space:nowrap;border:1px solid #999999;'>
Date
</th>
</tr>

</table>--%>
        <table id="tblUserDailyReport" style="width: 788px" class="dataTable">
        </table>
    </fieldset>

    <script type="text/javascript" language="javascript">

var oTable;
//    $(document).ajaxStart(blockUI).ajaxStop(unblockUI);

//    function  blockUI() {
//	    $.blockUI({ message: '<img src="image/ajax-loader.gif" />', 
//			    css:{borderStyle:'none',backgroundColor:"Transparent"} });
//    }
//    function unblockUI(){
//    $.unblockUI();
//    }
//    
  function ConvertDate(dateString)
    {
        var date = new Date(parseInt(dateString.replace(/\/Date\((\d+)\)\//, '$1')));
        var month = date.getMonth() + 1;
        if(month <10)
        month ='0'+month ;
        var day = date.getDate();
        if(day<10)
        day='0'+day;
        var year = date.getFullYear();
        var datet=month+"/"+day+"/"+year;
        return datet
    }  
function dataTable() {
        oTable= $("#tblUserDailyReport").dataTable({
                bPaginate: false,
                bJQueryUI: true,
                oLanguage:{"sSearch":"Filter: "}               
            }).fixedHeader({ height: 400});
      }
function GetUserDailyReportDetail()
{
var userID=$("select[id$='ddlUsers'] option:selected").val();
var FromDate=$("input[id$='txtFromDate']").val();
var ToDate=$("input[id$='txtToDate']").val();
$.ajax({
            type: "POST",
             dataType: "json",
            contentType: "application/json; charset=utf-8",
            url: "DailyReport_Summary.aspx/GetUserDailyReport",
            data: "{'userID':'"+userID+"', 'FromDate':'"+FromDate+"', 'ToDate':'"+ToDate+"'}",
            success: onsuccessGetResult,
            error:OnretrieveError 
            });
return false;

}
function onsuccessGetResult(msg)
{

var data = msg.d;
     if(oTable !=null)
     {
          oTable.fnClearTable();
          oTable.fnDestroy();
          } 
          var tbl = "";
var currentDate="";
var TimeFrom="";
var TimeTo="";
          tbl += "<thead>";
    	        tbl += "<tr>";
                    tbl += "<th style='cursor:Pointer;text-align:left;white-space:nowrap;border:1px solid #999999;'>Employee Name</th>";
                    tbl += "<th style='cursor:Pointer;text-align:left;white-space:nowrap;border:1px solid #999999;'>Employee ID</th>";
                    tbl += "<th style='cursor:Pointer;text-align:left;white-space:nowrap;border:1px solid #999999;'>Task Details</th>";
                    tbl += "<th style='cursor:Pointer;text-align:left;white-space:nowrap;border:1px solid #999999;'>From Time</th>";
                    tbl += "<th style='cursor:Pointer;text-align:left;white-space:nowrap;border:1px solid #999999;'>To Time</th>";
                    tbl += "<th style='cursor:Pointer;text-align:left;white-space:nowrap;border:1px solid #999999;'>Date</th>";
                    
                tbl += "</tr>";
    	  tbl += "</thead>";
    	  tbl += "<tbody>";
    	for (var i = 0; i < data.DailyReportDetails.length; i++) {
    	 if( data.DailyReportDetails[i].CurrentDate!=null)
    	 currentDate=ConvertDate( data.DailyReportDetails[i].CurrentDate);
    	 if(data.DailyReportDetails[i].fromTime!=null)
            TimeFrom=data.DailyReportDetails[i].fromTime;
            if( data.DailyReportDetails[i].toTime !=null)
            TimeTo= data.DailyReportDetails[i].toTime;
            tbl += "<tr id='trmain" + i + "' style='cursor:default;border:1px solid #999999;' onclick='getRowID("+i+");'>"; 
            
            tbl += "<td align='left'  style='white-space:nowrap;border:1px solid #999999;'>" + data.DailyReportDetails[i].Emp_Name + " </td>";                    
            tbl += "<td align='left'  style='white-space:nowrap;border:1px solid #999999;'>" + data.DailyReportDetails[i].user_id + " </td>";
            tbl += "<td align='left' title='"+data.DailyReportDetails[i].TaskDetails+"' style='white-space:nowrap;border:1px solid #999999;'>" + data.DailyReportDetails[i].TaskDetails.substr(0,70) + " </td>"; 
             tbl +="<td align='left'  style='white-space:nowrap;border:1px solid #999999;'>" + TimeFrom + " </td>";                    
            tbl += "<td align='left'  style='white-space:nowrap;border:1px solid #999999;'>" + TimeTo + " </td>";
             tbl += "<td align='left'  style='white-space:nowrap;border:1px solid #999999;'>" + currentDate+ " </td>";
            tbl += "</tr>";
          }
         
          tbl += "</tbody>";
    	tbl += "</table>";
    	$("#tblUserDailyReport").html(tbl);
         
        $("span[id$='spnHours']").html($("#tblUserDailyReport tr").length-1);
        // dataTable();
}
function OnretrieveError()
{

}

    </script>

</asp:Content>

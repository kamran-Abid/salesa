<%@ Page Language="C#" MasterPageFile="~/MCTX_Internal/SuperAdmin/MasterAdmin.master"
    AutoEventWireup="true" CodeFile="frmDailyRptSummary.aspx.cs" Inherits="MCTX_Internal_SuperAdmin_frmDailyRptSummary"
    Title="Daily Report Summary" %>

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
    <div id="tabs" style="width: 100%">
        <ul>
            <li style="text-align: left"><a href="#tabs-1">Daily Report Summary</a></li>
        </ul>
        <div>
            <fieldset id="fldDailyRPTSum" runat="server">
                <legend runat="server">Daily Report Summary</legend>
                <table style="width: 99%">
                    <tr>
                        <td align="left" style="width: 120px">
                            <asp:Label ID="lblFromDate" Text="From Date:" runat="server"></asp:Label>
                        </td>
                        <td align="left" style="width: 140px">
                            <asp:TextBox ID="txtFromDate" Width="104px" runat="server"></asp:TextBox>
                            <rjs:PopCalendar ID="rjsFromDate" Separator="/" Format="mm dd yyyy" Control="txtFromDate"
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
                            <asp:Label ID="lblEmpName" Text="Employee Name:" runat="server"></asp:Label>
                        </td>
                        <td align="left" style="width: 140px">
                            <asp:DropDownList ID="ddlEmpName" Width="124px" AutoPostBack="false" runat="server">
                            </asp:DropDownList>
                        </td>
                        <td align="left" style="width: 120px">
                        </td>
                        <td align="left" style="width: 140px">
                            <asp:Button ID="btnSearch" Width="104px" Style="background-color: #2A4062;
                                color: White;" Text="Search" OnClientClick="return showreportsummary();"
                                runat="server" />
                        </td>
                    </tr>
                </table>
            </fieldset>
        </div>
        <div id="divReportSum" style="width: 100%;" runat="server">
            <table style="width: 100%;">
                <tr>
                    <td colspan="10">
                        <table id="tblReportSum" style="width: 100%;" class="dataTable">
                        </table>
                    </td>
                </tr>
                <tr style="background-color: #CCCCCC;">
                    <td align="left" style="width: 120px;">
                        <asp:Label ID="labelName" Text="Employee Name:" Style="font-family: Calibri; font-size: medium;
                            font-weight: bold;" runat="server"></asp:Label>
                    </td>
                    <td align="left" style="width: 140px;">
                        <asp:Label ID="lblName" Style="font-family: Calibri; font-size: medium; font-weight: bold;"
                            runat="server"></asp:Label>
                    </td>
                    <td align="left" style="width: 90px;">
                        <asp:Label ID="labelHrsPerMon" Text="Hours/Month" Style="font-family: Calibri; font-size: medium;
                            font-weight: bold;" runat="server"></asp:Label>
                    </td>
                    <td align="right" style="width: 90px;">
                        <asp:Label ID="lblHrsPerMon" Style="font-family: Calibri; font-size: medium; font-weight: bold;"
                            runat="server"></asp:Label>
                    </td>
                    <td align="left" style="width: 140px;">
                        <asp:Label ID="labelWorkedHrs" Text="Total Worked Hrs:" Style="font-family: Calibri;
                            font-size: medium; font-weight: bold;" runat="server"></asp:Label>
                    </td>
                    <td align="right" style="width: 100px;">
                        <asp:Label ID="lblWorkedHrs" Style="font-family: Calibri; font-size: medium; font-weight: bold;"
                            runat="server"></asp:Label>
                    </td>
                    <td align="left" style="width: 140px;">
                        <asp:Label ID="labelDesiredHrs" Text="Required Work Hrs:" Style="font-family: Calibri;
                            font-size: medium; font-weight: bold;" runat="server"></asp:Label>
                    </td>
                    <td align="right" style="width: 100px;">
                        <asp:Label ID="lblDesiredHrs" Style="font-family: Calibri; font-size: medium; font-weight: bold;"
                            runat="server"></asp:Label>
                    </td>
                    <td align="left" style="width: 120px;">
                        <asp:Label ID="labelExceed" Text="Exceed" Style="font-family: Calibri; color: Green;
                            font-size: medium; font-weight: bold;" runat="server"></asp:Label><b>/</b>
                        <asp:Label ID="labelLess" Text="Less:" Style="font-family: Calibri; color: Red; font-size: medium;
                            font-weight: bold;" runat="server"></asp:Label>
                    </td>
                    <td align="right" style="width: 120px;">
                        <asp:Label ID="lblCount" Style="font-family: Calibri; font-size: medium; font-weight: bold;"
                            runat="server"></asp:Label>
                    </td>
                </tr>
            </table>
        </div>
    </div>

    <script type="text/javascript" language="javascript">
        var oTable;
    $(document).ready(function(){
           
    });
     function dataTable() {
       oTable= $("#tblReportSum").dataTable({
                bPaginate: false,
                bJQueryUI: true,
                oLanguage:{"sSearch":"Filter: "}               
            });
      }
      function showreportsummary()
      {
        var FrmDate = $("input[id$='txtFromDate']").val();
        var ToDate = $("input[id$='txtToDate']").val();
        
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
        var EmpName = $("select[id$='ddlEmpName'] option:selected").val();
                $.ajax({
                type: "POST",
                contentType:"application/json; charset=utf-8",
                url: "frmDailyRptSummary.aspx/showreportsum", 
                data: "{'frmDate':'"+FrmDate+"','toDate':'"+ToDate+"','EmpName':'"+EmpName+"'}", 
                success:onsuccessshowreport,
                error:onerrorshowreport
                });
             return false;  
      }
      function onsuccessshowreport(msg)
      {
        var data = msg.d;
        var HWS="";
        var HWOS="";
        var TH=0;
        var TM=0;
        var SumTH=0;
        var addHFM=0;
        var TMFM=0;
        if(oTable !=null)
            {
              oTable.fnClearTable();
              oTable.fnDestroy();
            }   
            var tbl = "";
                tbl += "<thead>";
                tbl += "<tr>";
                tbl += "<th style='white-space:nowrap; text-align:left;'>Employee Name</th>";
                tbl += "<th style='white-space:nowrap; text-align:left;'>Employee Output</th>";
                tbl += "<th style='white-space:nowrap; text-align:left;'>Worked Hrs</th>";
                tbl += "<th style='white-space:nowrap; text-align:left;'>Req Hrs</th>";
                tbl += "<th style='white-space:nowrap; text-align:left;'>Date</th>";
                tbl += "</tr>";
                tbl += "</thead>";
                tbl += "<tbody>";
                for (var i = 0; i < data.DailyRptSum.length; i++) {
                           if (data.DailyRptSum[0].EmpType_ID == 1)
                            {
                                var  ReqWorkedHrs = 8;
                            }
                           else if(data.DailyRptSum[0].EmpType_ID == 2)
                            {
                                var  ReqWorkedHrs = 4;
                            }  
                            
                           HWS=  data.DailyRptSum[i].WorkedHrs.split(":");
                          HWOS=data.DailyRptSum[i].WorkedHrs;                         
                          if(HWOS!="0")
                          
                          {
                          if(HWS[0]<10)
                          {
                          TH=data.DailyRptSum[i].WorkedHrs.substr(1,2)
                          
                          }
                          else
                          {
                          TH=HWS[0];
                          }
                          SumTH=SumTH+parseInt(TH)
                          TM=TM+parseInt(HWS[1]);
                          }
                                       
                            tbl += "<td style='text-align:left; white-space:nowrap; vertical-align:top;' id='txtEName"+i+"'>" + data.DailyRptSum[i].E_Name + "</td>";
                            tbl += "<td style='text-align:left;' id='txtOutput"+i+"'>" + data.DailyRptSum[i].MyOutput+ "</td>";                    
                            tbl += "<td style='text-align:left; white-space:nowrap;' id='txtWHrs"+i+"'>" + data.DailyRptSum[i].WorkedHrs + " </td>";
                            tbl += "<td style='text-align:right; white-space:nowrap;' id='txtReqWHrs"+i+"'>" + ReqWorkedHrs + " </td>";
                            tbl += "<td style='text-align:left; white-space:nowrap;' id='txtDate"+i+"'>" + data.DailyRptSum[i].CurrentDate + " </td>";
                      tbl += "</tr>";
                }   

                tbl += "</tbody>";
                tbl += "</table>";
                $("#tblReportSum").html(tbl);
                if(TM>=60)
                {
                addHFM=TM/60;
                TMFM=TM%60;
                addHFM=addHFM.toString().split(".");
                SumTH=SumTH+parseInt(addHFM[0])+":"+(TMFM.toString());
                }
                else
                {
                TM=TM.toString().split(".");
                if(TM<10)
                TM=0+TM;
                SumTH=SumTH+":"+(TM);
                }
                $("span[id$='lblWorkedHrs']").html(SumTH);
                var reqhrs=$("#txtReqWHrs0").html().trim();
                var monthhrs=0;
                monthhrs=parseInt(reqhrs)*26;
                $("span[id$='lblHrsPerMon']").text(monthhrs);
                var ReqHrs=0;
                var TotalRHrs=0; 
                for(x=0; x<data.DailyRptSum.length; x++)
                {      
                    ReqHrs=$("#txtReqWHrs"+x).html();
                    TotalRHrs=TotalRHrs+parseInt(ReqHrs);
                }
                $("span[id$='lblDesiredHrs']").text(TotalRHrs);
                $("span[id$='lblName']").html($("#txtEName0").html());  
                calclessExceed();
                return false; 
               
      }
      function onerrorshowreport()
      {
        alert("Error in Loading Details!");
        return false;
      }
      function calclessExceed()
        {
            var TWorkH=$("span[id$='lblWorkedHrs']").text().split(':');
            var WorkHrs=TWorkH[0];
           
            var DWH=$("span[id$='lblDesiredHrs']").text().split(':');
            var DHrs=DWH[0];
            
            var FinalHrs=parseInt(WorkHrs)-parseInt(DHrs);
            var FinalTime=FinalHrs;
            var Check =FinalHrs.toString().substr(0,1);

            if(Check[0]!='-')
                {
                    $("span[id$='lblCount']").css('color', 'green');
                }
            else
                {
                    $("span[id$='lblCount']").css('color', 'red');
                }
            $("span[id$='lblCount']").text(FinalTime);
            return false;
        }   
      
    </script>

</asp:Content>

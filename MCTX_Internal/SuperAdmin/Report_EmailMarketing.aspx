<%@ Page Title="" Language="C#" MasterPageFile="~/MCTX_Internal/SuperAdmin/MasterAdmin.master"
    AutoEventWireup="true" CodeFile="Report_EmailMarketing.aspx.cs" Inherits="MCTX_Internal_SuperAdmin_Report_EmailMarketing" %>

<%@ Register Assembly="RJS.Web.WebControl.PopCalendar.Net.2008" Namespace="RJS.Web.WebControl"
    TagPrefix="rjs" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

  <script src="../../js/BlockUI.js" type="text/javascript"></script>
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
        .button
        {
            border-top: 1px solid #96d1f8;
            background: #65a9d7;
            background: -webkit-gradient(linear, left top, left bottom, from(#3e779d), to(#65a9d7));
            background: -webkit-linear-gradient(top, #3e779d, #65a9d7);
            background: -moz-linear-gradient(top, #3e779d, #65a9d7);
            background: -ms-linear-gradient(top, #3e779d, #65a9d7);
            background: -o-linear-gradient(top, #3e779d, #65a9d7);
            padding: 5px 10px;
            -webkit-border-radius: 8px;
            -moz-border-radius: 8px;
            border-radius: 8px;
            -webkit-box-shadow: rgba(0,0,0,1) 0 1px 0;
            -moz-box-shadow: rgba(0,0,0,1) 0 1px 0;
            box-shadow: rgba(0,0,0,1) 0 1px 0;
            text-shadow: rgba(0,0,0,.4) 0 1px 0;
            color: white;
            font-size: 14px;
            font-family: Georgia, serif;
            text-decoration: none;
            vertical-align: middle;
            height: 30px;
            width: 100px;
        }
        .button:hover
        {
            border-top-color: #28597a;
            background: #28597a;
            color: #ccc;
            height: 30px;
            width: 100px;
        }
        .button:active
        {
            border-top-color: #1b435e;
            background: #1b435e;
            height: 30px;
            width: 100px;
        }
        .success
        {
            background-color: #EEFFEE;
            background-image: url("../../images1/status-success.png");
            border: 1px solid #AADDAA;
            color: #008800;
            background-repeat: no-repeat;
        }
        .alert, .success, .Error, .action
        {
            background-position: 10px 5px;
            background-repeat: no-repeat;
            border-radius: 5px 5px 5px 5px;
            clear: both;
            margin-bottom: 15px;
            min-height: 22px;
            padding: 10px 10px 10px 50px;
        }
        .Error
        {
            background-color: #FFEEEE;
            border: 1px solid #DDAAAA;
            color: #AA0000;
            background-repeat: no-repeat;
        }
        
    </style>
    <div id="tabs">
        <ul>
            <li style="text-align: left"><a href="#tabs-1">Email Log</a></li>
        </ul>
        <div style="margin-bottom: 10px; width: 99%">
            <fieldset style="border: 1px solid #ABD3FC;">
                <legend style="text-align: center; color: Coral; font-size: 13px;">Search Email Logs</legend>
                <table style="width: 72%; margin-bottom: 10px">
                    <tr>
                        <td style="text-align: right; width: 18%">
                            <span>From Date: </span>
                        </td>
                        <td style="text-align: left; width: 18%">
                            <asp:TextBox ID="txtFromDate" runat="server"></asp:TextBox><rjs:popcalendar id="rjsReportDate"
                                separator="/" format="mm dd yyyy" control="txtFromDate" runat="server" />
                        </td>
                        <td style="text-align: right; width: 18%">
                            <span>To Date: </span>
                        </td>
                        <td style="text-align: left; width: 18%">
                            <asp:TextBox ID="txtToDate" runat="server"></asp:TextBox><rjs:popcalendar id="PopCalendar1"
                                separator="/" format="mm dd yyyy" control="txtToDate" runat="server" />
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
                            <asp:Button ID="btnSearch" runat="server" Text="Search" OnClientClick="return LoadVisits();"
                                Width="104px" Style="background-color: #2A4062;
                                color: White;" />
                            <asp:Button ID="btnExportToExcel" Width="104px" Style="background-color: #2A4062;
                                color: White;" runat="server" BackColor="#ABD3FC"
                                Text="Export to Excel" onclick="btnExportToExcel_Click"/>
                        </td>
                    </tr>
                </table>
            </fieldset>
        </div>
        <div style="height: 400px; overflow: auto">
            <table style="margin-top: 0px" id="tblEmailLog" class="dataTable" width="100%">
            </table>
        </div>
    </div>

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
            GetEmailLog();
        });

        function GetEmailLog() {
            var FrmDate = $("input[id$='txtFromDate']").val().trim();
            var ToDate = $("input[id$='txtToDate']").val().trim();
            var EmployeeId = $("select[id$='ddlEmployees'] option:selected").val();
            
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
        blockUI();
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "Report_EmailMarketing.aspx/GetEmailLog",
                data: "{'FromDate':'" + FrmDate + "','ToDate':'" + ToDate + "','EmployeeId':'" + EmployeeId + "'}",
                dataType: "json",
                success: onsuccessEmailLog,
                error: OnretrieveError
            });
        }

        function onsuccessEmailLog(msg) {

            var data = msg.d;
            var tbl = "";

            tbl += "<thead>"
            tbl += "<tr>"

            tbl += "<th style='cursor:Pointer'>Sr.#</th>";
            tbl += "<th style='cursor:Pointer'>To</th>";
            tbl += "<th style='cursor:Pointer'>CC</th>";
            tbl += "<th style='cursor:Pointer'>Subject</th>";
            tbl += "<th style='cursor:Pointer'>Attachment</th>";
            tbl += "<th style='cursor:Pointer'>Attachment Size</th>";
            tbl += "<th style='cursor:Pointer'>Date</th>";
            tbl += "<th style='cursor:Pointer'>User Id</th>";
            tbl += "</tr>"
            tbl += "</thead>"
            tbl += "<tbody>"
            var j = 0;
            for (var i = 0; i < data.EmailLog.length; i++) {
                j = i + 1;
                tbl += "<tr id='trmain" + i + "' style='cursor:default'>";
                tbl += "<td style='border:1px solid #999999;text-align:left'>" + j + " </td>";
                tbl += "<td id='txtTask_Desc" + i + "' style='border:1px solid #999999;text-align:left' title='" + data.EmailLog[i].To_Address + "'>" + data.EmailLog[i].To_Address.substr(0, 35) + " </td>";
                tbl += "<td id='txtTask_Assinged_To" + i + "' style='border:1px solid #999999;text-align:left' title='" + data.EmailLog[i].CC_Address + "'>" + data.EmailLog[i].CC_Address.substr(0, 25) + " </td>";
                tbl += "<td id='txtTask_Assigned_By" + i + "' style='border:1px solid #999999;text-align:left'>" + data.EmailLog[i].Subject + " </td>";
                tbl += "<td id='txtTask_Status" + i + "' style='border:1px solid #999999;text-align:left'>" + data.EmailLog[i].Attachment_Name + " </td>";
                tbl += "<td id='txtTask_Replied" + i + "' style='border:1px solid #999999;text-align:right'>" + data.EmailLog[i].Attachment_Size + " </td>";
                tbl += "<td id='txtTask_Date" + i + "' style='border:1px solid #999999;text-align:right'>" + data.EmailLog[i].Date + " </td>";
                tbl += "<td id='txtTasK_By_User_Id" + i + "' style='border:1px solid #999999;text-align:left'>" + data.EmailLog[i].UserId + " </td>";
                tbl += "</tr>";
            }

            tbl += "</tbody>"
            tbl += "</table>"
            $("#tblEmailLog").html(tbl);
            unblockUI();
        }

        function OnretrieveError(error) {
            var errors = eval("(" + error.responseText + ")");
            alert("Error in Loading Email Log: " + errors.Message);
            unblockUI();
        }
        
    </script>

</asp:Content>

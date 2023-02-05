<%@ Page Title="Project Wise Report" Language="C#" MasterPageFile="~/MCTX_Internal/SuperAdmin/MasterAdmin.master" AutoEventWireup="true" CodeFile="workshp_ProjectWise_Report.aspx.cs" Inherits="MCTX_Internal_SuperAdmin_workshp_ProjectWise_Report" %>
<%@ Register Assembly="RJS.Web.WebControl.PopCalendar.Net.2008" Namespace="RJS.Web.WebControl"
    TagPrefix="rjs" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
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
        table {
    border-collapse: collapse;
}

td {
    padding-top: .5em;
    padding-bottom: .5em;
}
.highlight { background-color: red; }
    </style>

     <div id="tabs" style="width: 95%;">
        <ul>
            <li style="text-align: left"><a href="#tabs-1">Project Wise Report</a></li>
        </ul>
      
        <fieldset id="fldOutPutChart" style="width:94%; padding:2%">
            <legend>Project Wise Report</legend>
            <table style="width: 100%; font-family: Calibri; font-size: 11pt;">
                <tr>
                    <td >
                        
                            <table style="width: 100%; font-family: Calibri; font-size: 11pt;">
                               
                                <tr>
                                      <td width="140px" align="left">
                            <asp:Label ID="Label2" Text="Select Project:" runat="server"></asp:Label>
                        </td>
                                    
                                    <td style="width: 300px;">
                                       <asp:DropDownList ID="ddlProject"  runat="server" >
                                         </asp:DropDownList>
                                    </td>
                                    <td >
                                         
                                        <asp:Button ID="btnSearchProjectWiseReport" Text="Search" Style="background-color: #2A4062;
                                            color: White; width: 84px" OnClientClick="return getProjectWiseReport();" runat="server" />
                                       
                                         </td>
                                </tr>

                           
                               
                                
                                    
                                </table>
                        
                    </td>
                    
                </tr>
            </table>
        </fieldset>

          <br />
        <fieldset style="width: 94%;padding:2%;padding-top: 0%;">
            <legend style="text-align: left;">Project Wise Report</legend>
          
                        <div  style="text-align:right;" align="right">
                             <input type="button" id="btnExport" value="Export to Excel" style="cursor:pointer;background-color:#2A4062;color:white;height:20px;" />

                        </div>
                    
            <div id="Div1" style="overflow: auto; width: 1160px; height: 300px;" runat="server">
                <table id="tblProjectWiseReport" class="dataTable">
                </table>
            </div>
        </fieldset>
    </div>

    <script type="text/javascript">

        var oTable;
        $(document).ready(function () {
           

           
            $("#btnExport").click(function (e) {
                var tab_text = "<table border='2px'><tr bgcolor='#87AFC6'>";
                var textRange; var j = 0;
                tab = document.getElementById('tblProjectWiseReport'); // id of table

                for (j = 0 ; j < tab.rows.length ; j++) {
                    tab_text = tab_text + tab.rows[j].innerHTML + "</tr>";
                    //tab_text=tab_text+"</tr>";
                }

                tab_text = tab_text + "</table>";
                tab_text = tab_text.replace(/<A[^>]*>|<\/A>/g, "");//remove if u want links in your table
                tab_text = tab_text.replace(/<img[^>]*>/gi, ""); // remove if u want images in your table
                tab_text = tab_text.replace(/<input[^>]*>|<\/input>/gi, ""); // reomves input params

                var ua = window.navigator.userAgent;
                var msie = ua.indexOf("MSIE ");

                if (msie > 0 || !!navigator.userAgent.match(/Trident.*rv\:11\./))      // If Internet Explorer
                {
                    txtArea1.document.open("txt/html", "replace");
                    txtArea1.document.write(tab_text);
                    txtArea1.document.close();
                    txtArea1.focus();
                    sa = txtArea1.document.execCommand("SaveAs", true, "Say Thanks to Sumit.xls");
                }
                else                 //other browser not tested on IE 11
                    sa = window.open('data:application/vnd.ms-excel,' + encodeURIComponent(tab_text));

                return (sa);
                //  window.open('data:application/vnd.ms-excel,' + $('#divCompInfo').html());
                //e.preventDefault();
            });

        });
        function dataTable() {
            oTable = $("#tblProjectWiseReport").dataTable({
                bPaginate: true,
               // bJQueryUI: true,
                bSort: true,
                bInfo: true,
                bRetrieve: true,
                bDestroy: true,
                oLanguage: { "sSearch": "Filter: " }
            });
            $("#tblProjectWiseReport_length").css("text-align", "left");
            $("#tblProjectWiseReport_filter").css("text-align", "left");
        }
        function getEmpSalaries() {
           
           var empID= $("select[id$='ddlEmployee']").val();
           $.ajax({
               type: "POST",
               contentType: "application/json; charset=utf-8",
               url: "workshp_outputChart.aspx/getEmpSalary",
               data: "{'empID':'" + empID + "'}",
               success: onsuccessgetEmpInfo,
               error: onerrorEmpInfo
           });
           return false;
        }
        function onsuccessgetEmpInfo(msg) {
            var data = msg.d;
            
            $("input[id$='txtOverTime']").val("0");           
            $("input[id$='txtOverTimeCharges']").val("0");

            $("input[id$='txtMonthlySalary']").val(data.empSalDetails[0].BasicSalary);
            $("input[id$='txtPerDaySalary']").val(data.empSalDetails[0].perDaySal);
            $("input[id$='txtPerHorSalary']").val(data.empSalDetails[0].perHrSal);
        }

        function onerrorEmpInfo() {
            alert("Error In Loading Details!");
            return false;
        }





        function getProgetPriority() {

            var ProjectID = $("select[id$='ddlProject']").val();
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "workshp_outputChart.aspx/getPriority",
                data: "{'ProjectID':'" + ProjectID + "'}",
                success: onsuccessgetPriority,
                error: onerrorPriority
            });
            return false;
        }
        function onsuccessgetPriority(msg) {
            var data = msg.d;

            $("select[id$='ddlPriority']").val(data.PriorityDetails[0].Priority_id);
            
        }

        function onerrorPriority() {
            alert("Error In Loading Project Priority!");
            return false;
        }





        //-----------------------------------------------------Get Project Wise Report-----------------------------------------------------

        function getProjectWiseReport() {
            
            var projectid = $("select[id$='ddlProject']").val();
            
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "workshp_ProjectWise_Report.aspx/getProjectWiseReport",
                data: "{'projectid':'" + projectid + "'}",
                success: onsuccessgetProjectWiseReport,
                error: onretrievegetProjectWiseReport
            });
            return false;
        }
        function onsuccessgetProjectWiseReport(msg) {
           
            var data = msg.d;
            if (oTable != null) {
                oTable.fnClearTable();
                oTable.fnDestroy();
            }
            var tbl = "";
            tbl += "<thead>";
            tbl += "<tr>";

            tbl += "<th style='text-align:center; white-space:nowrap;'>Sr. No.</th>";
            tbl += "<th style='text-align:left; white-space:nowrap; display:none;'>output ID</th>";
            tbl += "<th style='text-align:left; white-space:nowrap; display:none;'>Emp ID</th>";
            tbl += "<th style='white-space:nowrap; text-align:left;'>Employee Name</th>";
            tbl += "<th style='white-space:nowrap; text-align:left;display:none;'>Monthly Salary</th>";


            tbl += "<th style='white-space:nowrap; text-align:left;display:none;'>Per Day Salary</th>";
            tbl += "<th style='white-space:nowrap; text-align:left;display:none;'>Per Hr. Salary</th>";
            tbl += "<th style='white-space:nowrap; text-align:left;display:none;'>Over Time Hr.</th>";
            tbl += "<th style='white-space:nowrap; text-align:left;display:none;'>Over Time charges</th>";

            tbl += "<th style='text-align:left; white-space:nowrap; display:none;'>Project ID</th>";
            tbl += "<th style='white-space:nowrap; text-align:left;'>Project</th>";
            tbl += "<th style='text-align:left; white-space:nowrap; display:none;'>Product ID</th>";
            tbl += "<th style='white-space:nowrap; text-align:left;'>Product</th>";
            tbl += "<th style='text-align:left; white-space:nowrap; display:none;'>Priority ID</th>";
            tbl += "<th style='white-space:nowrap; text-align:left;'>Project Priority</th>";
            tbl += "<th style='white-space:nowrap; text-align:left;'>Loss/Wastage</th>";
            tbl += "<th style='white-space:nowrap; text-align:left;'>Wastage Cost</th>";

            tbl += "<th style='text-align:left; white-space:nowrap; display:none;'>Activity Type ID</th>";
            tbl += "<th style='white-space:nowrap; text-align:left;'>Activity Type</th>";
            tbl += "<th style='white-space:nowrap; text-align:left;'>Activity Type Description</th>";
            tbl += "<th style='text-align:left; white-space:nowrap; display:none;'>Activity Mistake Type ID</th>";
            tbl += "<th style='white-space:nowrap; text-align:left;'>Activity Mistake Type</th>";            
            tbl += "<th style='white-space:nowrap; text-align:left;'>Activity Mistake Type Description</th>";

            tbl += "<th style='white-space:nowrap; text-align:left;'>Activity Target</th>";
            tbl += "<th style='white-space:nowrap; text-align:left;'>Activity Achieved</th>";
            tbl += "<th style='text-align:left; white-space:nowrap; display:none;'>Activity Grade ID</th>";
            tbl += "<th style='white-space:nowrap; text-align:left;'>Activity Grade</th>";

            tbl += "<th style='text-align:left; white-space:nowrap; display:none;'>Activity Start Time ID</th>";
            tbl += "<th style='white-space:nowrap; text-align:left;'>Activity Start Time</th>";
            tbl += "<th style='text-align:left; white-space:nowrap; display:none;'>Activity Estimated Time ID</th>";
            tbl += "<th style='white-space:nowrap; text-align:left;'>Activity Estimated Time</th>";
            tbl += "<th style='text-align:left; white-space:nowrap; display:none;'>Activity End Time ID</th>";
            tbl += "<th style='white-space:nowrap; text-align:left;'>Activity End Time</th>";
            tbl += "<th style='white-space:nowrap; text-align:left;'>Activity Total Hour(s)</th>";
            tbl += "<th style='white-space:nowrap; text-align:left;display:none;'>Created By</th>";
            tbl += "<th style='white-space:nowrap; text-align:left;'>Activity Date</th>";
            tbl += "<th style='white-space:nowrap; text-align:left;display:none;'>Modified By</th>";
            tbl += "<th style='white-space:nowrap; text-align:left;display:none;'>Modified Date</th>";
            tbl += "</tr>";
            tbl += "</thead>";
            tbl += "<tbody>";
            var j = 1;
            var totalHours = 0;
            var totalcost = 0;
            for (var i = 0; i < data.ouputchatrDetails.length; i++) {
                j = j + i;
                var activity_total_hour = data.ouputchatrDetails[i].activity_total_hour;
                if (activity_total_hour.trim() == "") {
                    activity_total_hour = 0;
                    tbl += "<tr id='trproblem' style='background-color:red;color:white;'><td style='cursor:Pointer;'>" + j + "</td>";
                }
                else
                    tbl += "<tr id='trproblem' style='background-color:white;'><td style='cursor:Pointer;'>" + j + "</td>";
                totalHours = totalHours + parseInt(activity_total_hour);
                totalcost = totalcost + parseInt(data.ouputchatrDetails[i].activity_total_hour * data.ouputchatrDetails[i].emp_perhour_salary);

                tbl += "<td style='text-align:right; white-space:nowrap; display:none;' id='txtOutputChart_IDs" + i + "'>" + data.ouputchatrDetails[i].output_chart_id + "</td>";
                tbl += "<td style='text-align:right; white-space:nowrap; display:none;' id='txtEmp_ID" + i + "'>" + data.ouputchatrDetails[i].emp_id + "</td>";
                tbl += "<td style='text-align:left; white-space:nowrap;' id='txtEmpName" + i + "'>" + data.ouputchatrDetails[i].E_Name + "</td>";
                tbl += "<td style='text-align:left; white-space:nowrap;display:none;' id='txtEmpMonthlySalary" + i + "'>" + data.ouputchatrDetails[i].emp_month_salary + "</td>";

                tbl += "<td style='text-align:left; white-space:nowrap;display:none;' id='txtPerDaySalary" + i + "'>" + data.ouputchatrDetails[i].emp_perday_salary + "</td>";
                tbl += "<td style='text-align:left; white-space:nowrap;display:none;' id='txtEmpPerHourSalary" + i + "'>" + data.ouputchatrDetails[i].emp_perhour_salary + "</td>";
                tbl += "<td style='text-align:left; white-space:nowrap;display:none;' id='txtEmpOverTimeHr" + i + "'>" + data.ouputchatrDetails[i].emp_overtime_hour + "</td>";
                tbl += "<td style='text-align:left; white-space:nowrap;display:none;' id='txtEmpOverTimeCharges" + i + "'>" + data.ouputchatrDetails[i].emp_overtimen_chargest + "</td>";



                tbl += "<td style='text-align:right; white-space:nowrap; display:none;' id='txtProject_ID" + i + "'>" + data.ouputchatrDetails[i].project_id + "</td>";
                tbl += "<td style='text-align:left; white-space:nowrap;' id='txtProjectName" + i + "'>" + data.ouputchatrDetails[i].Project_Name + "</td>";
                tbl += "<td style='text-align:right; white-space:nowrap; display:none;' id='txtProduct_ID" + i + "'>" + data.ouputchatrDetails[i].product_id + "</td>";
                tbl += "<td style='text-align:left; white-space:nowrap;' id='txtProductName" + i + "'>" + data.ouputchatrDetails[i].Product_name + "</td>";
                tbl += "<td style='text-align:right; white-space:nowrap; display:none;' id='txtPriority_ID" + i + "'>" + data.ouputchatrDetails[i].Project_priority + "</td>";
                tbl += "<td style='text-align:left; white-space:nowrap;' id='txtProjectPriorityName" + i + "'>" + data.ouputchatrDetails[i].Priority_description + "</td>";

                tbl += "<td style='text-align:left; white-space:nowrap;' id='txtWastageDescription" + i + "'>" + data.ouputchatrDetails[i].waistage_description + "</td>";
                tbl += "<td style='text-align:left; white-space:nowrap;' id='txtWastageCost" + i + "'>" + data.ouputchatrDetails[i].waistage_cost + "</td>";


                tbl += "<td style='text-align:right; white-space:nowrap; display:none;' id='txtActivityType_ID" + i + "'>" + data.ouputchatrDetails[i].activity_type_id + "</td>";
                tbl += "<td style='text-align:left; white-space:nowrap;' id='txtActivityTypeName" + i + "'>" + data.ouputchatrDetails[i].Activity_type_name + "</td>";                
                tbl += "<td style='text-align:left; white-space:nowrap;' id='txtActivityTypeDescription" + i + "'>" + data.ouputchatrDetails[i].activity_description + "</td>";

                tbl += "<td style='text-align:right; white-space:nowrap; display:none;' id='txtActivityMistakeType_ID" + i + "'>" + data.ouputchatrDetails[i].Acrtivity_mistake_type_id + "</td>";
                tbl += "<td style='text-align:left; white-space:nowrap;' id='txtActivityMistakeTypeName" + i + "'>" + data.ouputchatrDetails[i].mistake_type_name + "</td>";                
                tbl += "<td style='text-align:left; white-space:nowrap;' id='txtMistakeTypeDescription" + i + "'>" + data.ouputchatrDetails[i].Activity_mistake_description + "</td>";

                
                tbl += "<td style='text-align:left; white-space:nowrap;' id='txtActivityTarget" + i + "'>" + data.ouputchatrDetails[i].activity_target + "</td>";
                tbl += "<td style='text-align:left; white-space:nowrap;' id='txtActivityAchieved" + i + "'>" + data.ouputchatrDetails[i].activity_achived + "</td>";
                tbl += "<td style='text-align:right; white-space:nowrap; display:none;' id='txtActivityGrade_ID" + i + "'>" + data.ouputchatrDetails[i].activity_grade_id + "</td>";
                tbl += "<td style='text-align:left; white-space:nowrap;' id='txtActivityGrade" + i + "'>" + data.ouputchatrDetails[i].Activity_grade_name + "</td>";


                tbl += "<td style='text-align:right; white-space:nowrap; display:none;' id='txtActivityStartTime_ID" + i + "'>" + data.ouputchatrDetails[i].activity_start_time + "</td>";
                tbl += "<td style='text-align:left; white-space:nowrap;' id='txtActivityStartTime" + i + "'>" + data.ouputchatrDetails[i].activity_startTime_description + "</td>";

                tbl += "<td style='text-align:right; white-space:nowrap; display:none;' id='txtActivityEstimatedTime_ID" + i + "'>" + data.ouputchatrDetails[i].activity_EstimatedTime + "</td>";
                tbl += "<td style='text-align:left; white-space:nowrap;' id='txtActivityEstimatedTime" + i + "'>" + data.ouputchatrDetails[i].activity_EstimatedTime_description + "</td>";

                tbl += "<td style='text-align:right; white-space:nowrap; display:none;' id='txtActivityEndTime_ID" + i + "'>" + data.ouputchatrDetails[i].activity_end_time + "</td>";
                tbl += "<td style='text-align:left; white-space:nowrap;' id='txtActivityEndTime" + i + "'>" + data.ouputchatrDetails[i].activity_EndTime_description + "</td>";
                tbl += "<td style='text-align:left; white-space:nowrap;' id='txtActivityTotalHorus" + i + "'>" + data.ouputchatrDetails[i].activity_total_hour + "</td>";

                tbl += "<td style='text-align:left; white-space:nowrap;display:none;' id='txtCreatedBy" + i + "'>" + data.ouputchatrDetails[i].created_by + "</td>";
                tbl += "<td style='text-align:right; white-space:nowrap;' id='txtCreatedDate" + i + "'>" + data.ouputchatrDetails[i].created_date + " </td>";
                tbl += "<td style='text-align:left; white-space:nowrap;display:none;' id='txtModBy" + i + "'>" + data.ouputchatrDetails[i].modified_by + " </td>";
                tbl += "<td style='text-align:right; white-space:nowrap;display:none;' id='txtModDate" + i + "'>" + data.ouputchatrDetails[i].modified_date + " </td>";
                tbl += "</tr>";
            }
            tbl += "<tr style='background-color:white;'>";
            tbl += "<td style='text-align:center;font-weight:bold;white-space:nowrap;' colspan='2' >Activity Total Hours</td>";
            tbl += "<td style='text-align:left; white-space:nowrap;;font-weight:bold;color:maroon' >" + totalHours + "</td>";
            tbl += "<td style='text-align:center;font-weight:bold;white-space:nowrap;' colspan='2' >Total Cost</td>";
            tbl += "<td style='text-align:left; white-space:nowrap;font-weight:bold;color:maroon' >" + totalcost + "</td>";
            tbl += "<td style='text-align:left; white-space:nowrap;' colspan='30'></td>";

            
            tbl += "</tr>";
            tbl += "</tbody>";
            tbl += "</table>";
            $("#tblProjectWiseReport").html(tbl);
            //dataTable();
            return false;
        }
        function onretrievegetProjectWiseReport() {
            alert("Error In Loading Details!");
            return false;
        }


        function EditOutPutRecord(rowNo) {

           
            var txtOuputChartID = $("#txtOutputChart_IDs" + rowNo).html().trim();
            $("input[id$='txtOuputChartID']").val(txtOuputChartID);

            var EmpID = $("#txtEmp_ID" + rowNo).html().trim();
            $("select[id$='ddlEmployee']").val(EmpID);
            $("select[id$='ddlEmployee']").focus();

            var txtMonthlySalary = $("#txtEmpMonthlySalary" + rowNo).html().trim();
            $("input[id$='txtMonthlySalary']").val(txtMonthlySalary);

            var txtPerDaySalary = $("#txtPerDaySalary" + rowNo).html().trim();
            $("input[id$='txtPerDaySalary']").val(txtPerDaySalary);

            var txtEmpPerHourSalary = $("#txtEmpPerHourSalary" + rowNo).html().trim();
            $("input[id$='txtPerHorSalary']").val(txtEmpPerHourSalary);

            var txtEmpOverTimeHr = $("#txtEmpOverTimeHr" + rowNo).html().trim();
            $("input[id$='txtOverTime']").val(txtEmpOverTimeHr);
            var txtEmpOverTimeCharges = $("#txtEmpOverTimeCharges" + rowNo).html().trim();
            $("input[id$='txtOverTimeCharges']").val(txtEmpOverTimeCharges);


            var txtProject_ID = $("#txtProject_ID" + rowNo).html().trim();
            $("select[id$='ddlProject']").val(txtProject_ID);
            var txtProduct_ID = $("#txtProduct_ID" + rowNo).html().trim();
            $("select[id$='ddlProduct']").val(txtProduct_ID);
            var txtPriority_ID = $("#txtPriority_ID" + rowNo).html().trim();
            $("select[id$='ddlPriority']").val(txtPriority_ID);

            var txtWastageDescription = $("#txtWastageDescription" + rowNo).html().trim();
            $("input[id$='txtLoss']").val(txtWastageDescription);
            var txtWastageCost = $("#txtWastageCost" + rowNo).html().trim();
            $("input[id$='txtCost']").val(txtWastageCost);

            var txtActivityType_ID = $("#txtActivityType_ID" + rowNo).html().trim();
            $("select[id$='ddlActivityType']").val(txtActivityType_ID);

            var txtActivityTypeDescription = $("#txtActivityTypeDescription" + rowNo).html().trim();
           


           
            
            if ($("select[id$='ddlActivityType']").val() == "1") {
                    $("input[id$='txtActivityDescription']").hide();
                    $("select[id$='ddlActivityDescription'] option:selected").text(txtActivityTypeDescription);
                    $("select[id$='ddlActivityDescription']").show();
            }

            else {
                    $("select[id$='ddlActivityDescription']").hide();
                    $("input[id$='txtActivityDescription']").val(txtActivityTypeDescription);
                    $("input[id$='txtActivityDescription']").show();
            }

            
            var txtActivityMistakeType_ID = $("#txtActivityMistakeType_ID" + rowNo).html().trim();
            $("select[id$='ddlMistakeType']").val(txtActivityMistakeType_ID);
            var txtMistakeTypeDescription = $("#txtMistakeTypeDescription" + rowNo).html().trim();
            $("input[id$='txtMistakeDescription']").val(txtMistakeTypeDescription);

            var txtActivityTarget = $("#txtActivityTarget" + rowNo).html().trim();
            $("input[id$='txtActivityTarget']").val(txtActivityTarget);
            var txtActivityAchieved = $("#txtActivityAchieved" + rowNo).html().trim();
            $("input[id$='txtActivityAchieved']").val(txtActivityAchieved);
            var txtActivityGrade_ID = $("#txtActivityGrade_ID" + rowNo).html().trim();
            $("select[id$='ddlActivityGradeId']").val(txtActivityGrade_ID);

            var txtActivityStartTime_ID = $("#txtActivityStartTime_ID" + rowNo).html().trim();
            $("select[id$='ddlStartTime']").val(txtActivityStartTime_ID);
            var txtActivityEndTime_ID = $("#txtActivityEndTime_ID" + rowNo).html().trim();
            $("select[id$='ddlEndTime']").val(txtActivityEndTime_ID);
            var txtActivityTotalHorus = $("#txtActivityTotalHorus" + rowNo).html().trim();
            $("input[id$='txtTotalHour']").val(txtActivityTotalHorus);

            $("input[id$='btnUpdateOutput']").show();
            $("input[id$='btnSearchProjectWiseReport']").attr("disabled", true);
            return false;
        }


        function updateOutputChart() {
            //var txtOuputChartID = $("#txtOutputChart_IDs" + rowNo).html().trim();
           var outputChartID= $("input[id$='txtOuputChartID']").val();
            var empid = $("select[id$='ddlEmployee']").val();
            if (empid == "0") {
                alert("Please Select Employee!");
                $("select[id$='ddlEmployee']").focus();
                return false;
            }

            var monthlySal = $("input[id$='txtMonthlySalary']").val();
            var perdaySal = $("input[id$='txtPerDaySalary']").val();
            var perHourSal = $("input[id$='txtPerHorSalary']").val();
            var overTimeHr = $("input[id$='txtOverTime']").val();
            var overTimecharges = $("input[id$='txtOverTimeCharges']").val();
            var projectid = $("select[id$='ddlProject']").val();

            if (projectid == "0") {
                alert("Please Select Project!");
                $("select[id$='ddlProject']").focus();
                return false;
            }

            var productid = $("select[id$='ddlProduct']").val();
            if (productid == "0") {
                alert("Please Select Project!");
                $("select[id$='ddlProduct']").focus();
                return false;
            }

            var Priorityid = $("select[id$='ddlPriority']").val();
            if (Priorityid == "0") {
                alert("Please Select Project Priority!");
                $("select[id$='ddlPriority']").focus();
                return false;
            }

            var lossName = $("input[id$='txtLoss']").val();
            var lossCost = $("input[id$='txtCost']").val();

            var ActivityTypeid = $("select[id$='ddlActivityType']").val();
            if (ActivityTypeid == "0") {
                alert("Please Select Activity Type!");
                $("select[id$='ddlActivityType']").focus();
                return false;
            }
            var ActivityDescriptin = "";
            if ($("select[id$='ddlActivityDescription']").is(":visible")) {
                if ($("select[id$='ddlActivityDescription']").val() == "") {
                    alert("Please Select Activity Description");
                    $("select[id$='ddlActivityDescription']").focus();
                    return false;
                }
                else

                    ActivityDescriptin = $("select[id$='ddlActivityDescription'] option:selected").text();

            }

            else {
                if ($("input[id$='txtActivityDescription']").val().trim() == "") {
                    alert("Please Enter Activity Description");
                    $("input[id$='txtActivityDescription']").focus();
                    return false;
                }
                else
                    ActivityDescriptin = $("input[id$='txtActivityDescription']").val();
            }

            var mistaketypeid = $("select[id$='ddlMistakeType']").val();
            var mistakeDescription = $("input[id$='txtMistakeDescription']").val();

            var ActivityTarget = $("input[id$='txtActivityTarget']").val();
            var ActivityAchieved = $("input[id$='txtActivityAchieved']").val();


            var ActivityGradeId = $("select[id$='ddlActivityGradeId']").val();
            if (ActivityGradeId == "0") {
                alert("Please Select Activity Grade!");
                $("select[id$='ddlActivityGradeId']").focus();
                return false;
            }
            var ActivitStartTime = $("select[id$='ddlStartTime']").val();
            if (ActivitStartTime == "0") {
                alert("Please Select Activity Start Time!");
                $("select[id$='ddlStartTime']").focus();
                return false;
            }
             var ActivitStartTimeDes=$("select[id$='ddlStartTime'] option:selected").text();
            var ActivitEndTime = $("select[id$='ddlEndTime']").val();
            if (ActivitEndTime == "0") {
                alert("Please Select Activity End Time!");
                $("select[id$='ddlEndTime']").focus();
                return false;
            }
             var ActivitEndTimeDes = $("select[id$='ddlEndTime'] option:selected").text();
            if (parseInt(ActivitEndTime) <= parseInt(ActivitStartTime)) {
                alert("Time End must be greater than Time Start!");
                $("select[id$='ddlEndTime']").val("0");
                $("select[id$='ddlStartTime']").val("0");
                return false;
            }
            var TotalHour = $("input[id$='txtTotalHour']").val();

            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "workshp_outputChart.aspx/updateOutputChart",
                data: "{'outputChartID':'" + outputChartID + "','empid':'" + empid + "','monthlySal':'" + monthlySal + "','perdaySal':'" + perdaySal + "','perHourSal':'"+ perHourSal + "','overTimeHr':'" + overTimeHr + "','overTimecharges':'" + overTimecharges + "','projectid':'" + projectid + "','productid':'" + productid + "','Priorityid':'" + Priorityid + "','lossName':'" + lossName + "','lossCost':'" + lossCost + "' ,'ActivityTypeid':'" + ActivityTypeid + "','ActivityDescriptin':'" + ActivityDescriptin + "','mistaketypeid':'" + mistaketypeid + "','mistakeDescription':'" + mistakeDescription + "','ActivityTarget':'"+ ActivityTarget + "','ActivityAchieved':'" + ActivityAchieved + "','ActivityGradeId':'" + ActivityGradeId + "','ActivitStartTime':'" + ActivitStartTime + "','ActivitStartTimeDes':'" + ActivitStartTimeDes + "','ActivitEndTime':'" + ActivitEndTime + "','ActivitEndTimeDes':'" + ActivitEndTimeDes + "','TotalHour':'" + TotalHour + "'}",
                success: onsuccessupdateOutputChart,
                error: onretrieveupdateOutputChartError
            });

        }
        function onsuccessupdateOutputChart() {
            alert("Data Successfully Updated!");
            $("input[id$='txtOuputChartID']").val("");
           
            getProjectWiseReport();
            return false;
        }
        function onretrieveupdateOutputChartError() {
            alert("Error In Updating Data!");
            return false;
        }



    </script>
</asp:Content>


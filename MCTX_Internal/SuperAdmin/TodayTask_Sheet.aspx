<%@ Page Title="" Language="C#" MasterPageFile="~/MCTX_Internal/SuperAdmin/MasterAdmin.master" AutoEventWireup="true" CodeFile="TodayTask_Sheet.aspx.cs" Inherits="MCTX_Internal_SuperAdmin_TodayTask_Sheet" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <script src="../../js/jquery.dataTables.min.js" type="text/javascript"></script>

    <script src="../../js/BlockUI.js" type="text/javascript"></script>

    <script src="../../js/jquery.fixedheader.js" type="text/javascript"></script>

    <script src="../../js/jqModal.js" type="text/javascript"></script>

   
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
        input[type=text] {
    padding: 0;
    height: 20px;
    position: relative;
    left: 0;
    outline: none;
    border: 1px solid #cdcdcd;
    border-color: rgba(0,0,0,.15);
    background-color: white;
    font-size: 11px;
}
.advancedSearchTextbox {
    width: 526px;
    margin-right: -4px;
}
    </style>
    <div id="tabs" style="width: 100%;">
        <ul>
            <li style="text-align: left"><a href="#tabs-1">Today Tasks</a></li>
           
            
        </ul>
        <div id="tabs-1" style="width: 98%">
          
            <div>
                <table style="width:100%">
                    <tr>
                        <td><label style="font-weight:bold;font-size:16px;">Today's Explicit Cost:</label>
                            <asp:Label ID="lblTodayBasicSalary" runat="server" style="font-weight:bold;color:maroon;font-size:large"></asp:Label></td>
                        <td><label style="font-weight:bold;font-size:16px;">Output Justified Today:</label>
                            <label style="font-weight:bold;color:green;font-size:large" id="lblJustifiedCost">0</label>

                        </td>
                        <td><label style="font-weight:bold;font-size:16px;">Money Turn into Loss:</label>
                            <label style="font-weight:bold;color:red;font-size:large" id="lblTurnintoLossCost">0</label>
                        </td>
                        <td>
                           
                           
                                                        </td>
                    </tr>
                </table>

            </div>
            
            <fieldset id="fldNextDayPlanningDetails"  style="width:92%; padding:2%;  max-height: 400px;">
                <legend>Today Tasks Details</legend>
                <div id="divNextDayPlanningDetails" style="overflow: auto;height: 400px;"  >
                <table id="tblNextDayPlanning" class="dataTable">
                </table>
                    </div>
	</fieldset>
        
        </div>
	
     
     
	
    </div>

    <script type="text/javascript" language="javascript">
        var oTable;
        var OutputJustifiedToday = 0;
        var MoneyTurnintoLoss = 0;
    $(document).ready(function () {
        getTodayTaskDetails();
        
    });
      function dataTable() {
        oTable= $("#tblNextDayPlanning").dataTable({
            bPaginate: true,
            bJQueryUI: true,
            bSort: true,
            bInfo: true,
            bRetrieve: true,
            bDestroy: true,
            oLanguage: { "sSearch": "Filter: " }
            });
             $("#tblNextDayPlanning_length").css("text-align", "left");
        $("#tblNextDayPlanning_filter").css("text-align", "left");
    }
      function getEmpSalaries() {

          var empID = $("select[id$='ddlEmployee']").val();
          $.ajax({
              type: "POST",
              contentType: "application/json; charset=utf-8",
              url: "TodayTask_Sheet.aspx/getEmpSalary",
              data: "{'empID':'" + empID + "'}",
              success: onsuccessgetEmpInfo,
              error: onerrorEmpInfo
          });
          return false;
      }
      function onsuccessgetEmpInfo(msg) {
          var data = msg.d;

                  
          $("input[id$='txtPerHorSalary']").val(data.empSalDetails[0].perHrSal);

          $("input[id$='txtRelativeCost']").val(data.empSalDetails[0].Relative_Cost);

          $("input[id$='txtBranch']").val(data.empSalDetails[0].BRANCHNAME);
          $("input[id$='txtDepartment']").val(data.empSalDetails[0].D_NAME);

          
          
      }

      function onerrorEmpInfo() {
          alert("Error In Loading Details!");
          return false;
      }
   
      function getTotalHrs() {


          var timeFrom = $("select[id$='ddlEndTime']").val();
          var timeTo = $("select[id$='ddlStartTime']").val();
          if (timeTo == '0') {
              alert("Please Select Start Time!");

              return false;
          }
          else if (timeTo == '0' || timeFrom == '0') {
              return false;
          }
          else if (parseInt(timeFrom) <= parseInt(timeTo)) {
              alert("Time End must be greater than Time Start!");
              $("select[id$='ddlEndTime']").val("0");
              $("select[id$='ddlStartTime']").val("0");
              return false;
          }
          var totalHr = timeFrom - timeTo;
          var abcost = $("input[id$='txtPerHorSalary']").val();
          $("input[id$='txtCalculatedHrSalary']").val(totalHr * abcost);
          var relativcost = $("input[id$='txtRelativeCost']").val();
          $("input[id$='txtCalculatedRelativeCost']").val(totalHr * relativcost);

      }

      function SaveTodayTask(rowNo)
      {
         
          var DailyTask_ID = $("#txtDailyTask_ID"+rowNo).text();
          var ActivityStatus = $("select[id$='ddlActivityStatus" + rowNo + "']").val();       
                $.ajax({
                type: "POST",
                contentType:"application/json; charset=utf-8",
                url: "TodayTask_Sheet.aspx/UpdateTodayTask",
                data: "{'DailyTask_ID':'" + DailyTask_ID + "','ActivityStatus':'" + ActivityStatus + "'}",
                success: onsuccessSaveTodayTask,
                error: onretrieveTodayTaskError
                });
        return true; 
      }
      function onsuccessSaveTodayTask(msg)
      {
          
          location.reload();
          alert("Data Successfully Saved!");
        return false;
      }
      function onretrieveTodayTaskError(msg)
      {
          alert("Error In Saving Data!" + msg.responseText);
        return false; 
      }
      function Clear()
      {
          
          $("input[id$='txtDailyTask_IDs']").val("");          
          $("select[id$='ddlEmployee']").val("0");           
          $("select[id$='ddlProject']").val("0");          
          $("input[id$='txtOther']").val("");           
          $("select[id$='ddlStartTime']").val("0");            
          $("select[id$='ddlEndTime']").val("0");
          $("input[id$='txtRelativeCost']").val("");          
          $("input[id$='txtPerHorSalary']").val("");
          $("input[id$='txtCalculatedHrSalary']").val("");          
          $("input[id$='txtCalculatedRelativeCost']").val("");
          $("input[id$='txtOppertunityCost']").val("");  
          $("input[id$='txtOppertunityCost']").css("background-color","");        
          $("input[id$='txtCostIndicator']").val("");
          $("select[id$='ddlTravelingSource']").val("0");          
          $("input[id$='txtTravelingDistance']").val("");
          $("input[id$='txtTravelingCost']").val("");
          $("input[id$='txtActivityCost']").val("");
          $("input[id$='txtBranch']").val("");
          $("input[id$='txtDepartment']").val("");

        $("input[id$='btnUpdate']").hide();
        $("input[id$='btnSave']").attr("disabled", false);
        return false;
      }
     
      function getTodayTaskDetails()
      {
          
        $.ajax({
            type: "POST",
            contentType:"application/json; charset=utf-8",
            url: "TodayTask_Sheet.aspx/getTodayTaskDetails",
            data: "{}", 
            success:onsuccessgetTodayTaskDetails,
            error:onretrievegetTodayTaskDetails 
        });
        return false; 
      }
      
      function onsuccessgetTodayTaskDetails(msg)
      {
          Clear();
        var data = msg.d;
        if(oTable !=null)
                    {
                      oTable.fnClearTable();
                      oTable.fnDestroy();
                    }  
          var tbl = "";
                tbl += "<thead>";
                tbl += "<tr>";
                
                tbl += "<th style='text-align:center; white-space:nowrap;display:none;'>Edit</th>";
                tbl += "<th style='text-align:left; white-space:nowrap; display:none;'>Next Day Planning ID</th>";
                tbl += "<th style='text-align:left; white-space:nowrap; display:none;'>Employee ID</th>";
                tbl += "<th style='white-space:nowrap; text-align:left;'>Employee Name</th>";
                tbl += "<th style='text-align:left; white-space:nowrap; display:none;'>Project ID</th>";
                tbl += "<th style='white-space:nowrap; text-align:left;'>Activity Description</th>";
                tbl += "<th style='white-space:nowrap; text-align:left;'>Project Name</th>";
                tbl += "<th style='white-space:nowrap; text-align:left;'>Other</th>";
                tbl += "<th style='text-align:left; white-space:nowrap; display:none;'>Time From ID</th>";
                tbl += "<th style='white-space:nowrap; text-align:left;'>Time From</th>";
                tbl += "<th style='text-align:left; white-space:nowrap; display:none;'>Time To ID</th>";
                tbl += "<th style='white-space:nowrap; text-align:left;'>Time To</th>";                   
                tbl += "<th style='white-space:nowrap; text-align:left;'>Absolute Cost</th>";
                tbl += "<th style='white-space:nowrap; text-align:left;display:none;'>Relative Cost</th>";
                tbl += "<th style='white-space:nowrap; text-align:left;'>Opportunity Cost</th>";
          tbl += "<th style='text-align:left; white-space:nowrap; display:none;'>Oppertunity Cost Indicator</th>";

                tbl += "<th style='text-align:left; white-space:nowrap; display:none;'>Traveling Source ID</th>";
                tbl += "<th style='white-space:nowrap; text-align:left;'>Traveling Source</th>";
                tbl += "<th style='white-space:nowrap; text-align:left;'>Traveling Distance</th>";
                tbl += "<th style='white-space:nowrap; text-align:left;'>Traveling Cost</th>";
                tbl += "<th style='white-space:nowrap; text-align:left;'>Total Cost</th>";

                tbl += "<th style='white-space:nowrap; text-align:left;display:none;'>Baranch</th>";
                tbl += "<th style='white-space:nowrap; text-align:left;display:none;'>Department</th>";
                tbl += "<th style='white-space:nowrap; text-align:left;'>Task Date</th>";
                tbl += "<th style='white-space:nowrap; text-align:left;'>Activity Status</th>";
                tbl += "<th style='white-space:nowrap; text-align:left;'>Save</th>";

                tbl += "<th style='white-space:nowrap; text-align:left;display:none;'>Created By</th>";
                tbl += "<th style='white-space:nowrap; text-align:left;display:none;'>Created Date</th>";
                tbl += "<th style='white-space:nowrap; text-align:left;display:none;'>Modified By</th>";
                tbl += "<th style='white-space:nowrap; text-align:left;display:none;'>Modified Date</th>";
                tbl += "</tr>";
                tbl += "</thead>";
                tbl += "<tbody>";

                for (var i = 0; i < data.NextDayPlanningDetails.length; i++) {                   
                    
                   
                    tbl += "<tr style='background-color:white'>";
                    tbl += "<td style='cursor:Pointer;display:none;' id='txtUpdate' align='center' onclick='return EditRecord(" + i + ");'><img src='image/Edit.png'></td>";
                            tbl += "<td style='text-align:right; white-space:nowrap; display:none;' id='txtDailyTask_ID" + i + "'>" + data.NextDayPlanningDetails[i].DailyTask_ID + "</td>";
                            tbl += "<td style='text-align:right; white-space:nowrap; display:none;' id='txtEmp_ID" + i + "'>" + data.NextDayPlanningDetails[i].Emp_ID + "</td>";
                            tbl += "<td style='text-align:left; white-space:nowrap;' id='txtEmpName" + i + "'>" + data.NextDayPlanningDetails[i].E_Name + "</td>";
                            tbl += "<td style='text-align:left;' id='txtActivity_Description" + i + "'>" + data.NextDayPlanningDetails[i].Activity_Description + "</td>";
                            tbl += "<td style='text-align:right; white-space:nowrap; display:none;' id='txtProject_ID" + i + "'>" + data.NextDayPlanningDetails[i].Project_ID + "</td>";
                            tbl += "<td style='text-align:left; white-space:nowrap;' id='txtProject_Name" + i + "'>" + data.NextDayPlanningDetails[i].Project_Name + "</td>";
                            tbl += "<td style='text-align:left; white-space:nowrap;' id='txtOther_Description" + i + "'>" + data.NextDayPlanningDetails[i].Other_Description + "</td>";
                            tbl += "<td style='text-align:right; white-space:nowrap; display:none;' id='txtTime_From_ID" + i + "'>" + data.NextDayPlanningDetails[i].Time_From_ID + "</td>";
                            tbl += "<td style='text-align:left; white-space:nowrap;' id='txtTime_From" + i + "'>" + data.NextDayPlanningDetails[i].Time_From + "</td>";
                            tbl += "<td style='text-align:right; white-space:nowrap; display:none;' id='txtTime_To_ID" + i + "'>" + data.NextDayPlanningDetails[i].Time_To_ID + "</td>";
                            tbl += "<td style='text-align:left; white-space:nowrap;' id='txtTime_To" + i + "'>" + data.NextDayPlanningDetails[i].Time_To + "</td>";
                            tbl += "<td style='text-align:left; white-space:nowrap;' id='txtAbsoluteCost" + i + "'>" + data.NextDayPlanningDetails[i].Absolute_Cost + "</td>";
                            tbl += "<td style='text-align:left; white-space:nowrap;display:none;' id='txtRelativeCost" + i + "'>" + data.NextDayPlanningDetails[i].Relative_Cost + "</td>";
                            tbl += "<td style='text-align:left; white-space:nowrap;background-color:" + data.NextDayPlanningDetails[i].Opportunity_Cost_Color + "' id='txtOpportunity_Cost" + i + "'>" + data.NextDayPlanningDetails[i].Opportunity_Cost + "</td>";
                            tbl += "<td style='text-align:right; white-space:nowrap; display:none;' id='txtOpportunity_Cost_Color" + i + "'>" + data.NextDayPlanningDetails[i].Opportunity_Cost_Color + "</td>";
                            tbl += "<td style='text-align:right; white-space:nowrap; display:none;' id='txtTraveling_Source_ID" + i + "'>" + data.NextDayPlanningDetails[i].Traveling_Source_ID + "</td>";
                            tbl += "<td style='text-align:left; white-space:nowrap;' id='txtTraveling_Source_Name" + i + "'>" + data.NextDayPlanningDetails[i].Traveling_Source_Name + "</td>";
                            tbl += "<td style='text-align:left; white-space:nowrap;' id='txtTraveling_Distance" + i + "'>" + data.NextDayPlanningDetails[i].Traveling_Distance + "</td>";
                            tbl += "<td style='text-align:left; white-space:nowrap;' id='txtTraveling_Cost" + i + "'>" + data.NextDayPlanningDetails[i].Traveling_Cost + "</td>";
                            tbl += "<td style='text-align:left; white-space:nowrap;' id='txtTotal_Activity_Cost" + i + "'>" + data.NextDayPlanningDetails[i].Total_Activity_Cost + "</td>";
                            tbl += "<td style='text-align:left; white-space:nowrap;display:none;' id='txtBranch_Name" + i + "'>" + data.NextDayPlanningDetails[i].Branch_Name + "</td>";
                            tbl += "<td style='text-align:left; white-space:nowrap;display:none;' id='txtDepartment_Name" + i + "'>" + data.NextDayPlanningDetails[i].Department_Name + "</td>";
                            tbl += "<td style='text-align:left; white-space:nowrap;' id='txttask_date" + i + "'>" + data.NextDayPlanningDetails[i].task_date + "</td>";

                            tbl += "<td style='text-align:left; white-space:nowrap;' id='txActivity_Statuss" + i + "'><select id='ddlActivityStatus" + i + "'><option value='0'>Incompleted</option><option value='1'>Completed</option></select></td>";
                            tbl += "<td style='text-align:left; white-space:nowrap;' id='txttask_date" + i + "'> <input type='button' id='btnSave' onclick='SaveTodayTask("+i+");' value='Save' style='color:green' /></td>";
                            tbl += "<td style='text-align:left; white-space:nowrap;display:none;' id='txtCreatedBy" + i + "'>" + data.NextDayPlanningDetails[i].created_by + "</td>";
                            tbl += "<td style='text-align:right; white-space:nowrap;display:none;' id='txtCreatedDate" + i + "'>" + data.NextDayPlanningDetails[i].created_date + " </td>";
                            tbl += "<td style='text-align:left; white-space:nowrap;display:none;' id='txtModBy" + i + "'>" + data.NextDayPlanningDetails[i].modified_by + " </td>";
                            tbl += "<td style='text-align:right; white-space:nowrap;display:none;' id='txtModDate" + i + "'>" + data.NextDayPlanningDetails[i].modified_date + " </td>";
                            
                           
                            tbl += "</tr>";
                            
                }   
                tbl += "</tbody>";
                tbl += "</table>";
                $("#tblNextDayPlanning").html(tbl);
                $("label[id$='lblJustifiedCost']").text("0");
                $("label[id$='lblTurnintoLossCost']").text("0");
                var tblLength = $("#tblNextDayPlanning tr").length - 1;
                $("label[id$='lblJustifiedCost']").text("");

                $("label[id$='lblTurnintoLossCost']").text("");
                for (i = 0; i <= tblLength; i++) {
                   
                    var ActivityStatusValue = data.NextDayPlanningDetails[i].Activity_Status;
                   
                    if (ActivityStatusValue == false)
                        ActivityStatusValue = 0;
                    else
                    {
                        var abCost = data.NextDayPlanningDetails[i].Absolute_Cost;
                        OutputJustifiedToday = OutputJustifiedToday + parseInt(abCost);
                        $("label[id$='lblJustifiedCost']").text(OutputJustifiedToday);
                        MoneyTurnintoLoss = parseInt($("span[id$='lblTodayBasicSalary']").text()) - parseInt(OutputJustifiedToday);
                        $("label[id$='lblTurnintoLossCost']").text(MoneyTurnintoLoss);
                        
                        ActivityStatusValue = 1;
                        $("select[id$='ddlActivityStatus" + i + "']").val(ActivityStatusValue);
                        $("select[id$='ddlActivityStatus" + i + "']").attr("disabled", true);
                    }
                   
                    }
                      
               
               
                //dataTable();
                return false; 
      }
      function onretrievegetTodayTaskDetails()
      {
        alert("Error In Loading Details!");
        return false;
      }
      function EditRecord(rowNo)
      {
          var DailyTaskID = $("#txtDailyTask_ID"+rowNo).html().trim();
          $("input[id$='txtDailyTask_IDs']").val(DailyTaskID); 

          var Emp_ID = $("#txtEmp_ID" + rowNo).html().trim();
          $("select[id$='ddlEmployee']").val(Emp_ID);
           var projID = $("#txtProject_ID" + rowNo).html().trim();
          $("select[id$='ddlProject']").val(projID);
          var other = $("#txtOther_Description" + rowNo).html().trim();
          $("input[id$='txtOther']").val(other);

            var txtActivityStartTime_ID = $("#txtTime_From_ID" + rowNo).html().trim();
            $("select[id$='ddlStartTime']").val(txtActivityStartTime_ID);
            var txtActivityEndTime_ID = $("#txtTime_To_ID" + rowNo).html().trim();
            $("select[id$='ddlEndTime']").val(txtActivityEndTime_ID);

           var AbsoluteCost = $("#txtAbsoluteCost"+rowNo).html().trim();
          $("input[id$='txtCalculatedHrSalary']").val(AbsoluteCost);

           var RelativeCost = $("#txtRelativeCost"+rowNo).html().trim();
          $("input[id$='txtCalculatedRelativeCost']").val(RelativeCost);

           var OppertunityCost = $("#txtOpportunity_Cost"+rowNo).html().trim();
          $("input[id$='txtOppertunityCost']").val(OppertunityCost);
          var Opportunity_Cost_Color = $("#txtOpportunity_Cost_Color"+rowNo).html().trim();
          $("input[id$='txtOppertunityCost']").css("background-color",Opportunity_Cost_Color);
                $("input[id$='txtCostIndicator']").val(Opportunity_Cost_Color);
          var travelingSourceID = $("#txtTraveling_Source_ID"+rowNo).html().trim();
          $("select[id$='ddlTravelingSource']").val(travelingSourceID);

          var travelingDistance = $("#txtTraveling_Distance"+rowNo).html().trim();
          $("input[id$='txtTravelingDistance']").val(travelingDistance);

           var Traveling_Cost = $("#txtTraveling_Cost"+rowNo).html().trim();
          $("input[id$='txtTravelingCost']").val(Traveling_Cost);

            var Total_Activity_Cost = $("#txtTotal_Activity_Cost"+rowNo).html().trim();
          $("input[id$='txtActivityCost']").val(Total_Activity_Cost);

          var Branch_Name = $("#txtBranch_Name"+rowNo).html().trim();
          $("input[id$='txtBranch']").val(Branch_Name);
          var Department_Name = $("#txtDepartment_Name"+rowNo).html().trim();
          $("input[id$='txtDepartment']").val(Department_Name);




          
          $("input[id$='btnUpdate']").show();
          $("input[id$='btnSave']").attr("disabled", true);
          getEmpSalaries();
          return false;
      }
      function UpdateNextDayPlanning()
      {

       var DailyTask_ID = $("input[id$='txtDailyTask_IDs']").val(); 
       var Emp_ID = $("select[id$='ddlEmployee']").val().trim();
          if (Emp_ID == "0") {
              alert("Please Select Employee!");
              return false;
          }
          var Project_ID = $("select[id$='ddlProject']").val().trim();
          var Other_Description = $("input[id$='txtOther']").val().trim();

          if (Project_ID == "0" && Other_Description == "")
          {

              alert("Pleae select project or Enter other description");
              return false;
          }
         
          var Time_From_ID = $("select[id$='ddlStartTime']").val();
          if (Time_From_ID == "0") {
              alert("Please Select Activity Start Time!");
              $("select[id$='ddlStartTime']").focus();
              return false;
          }
          var Time_From = $("select[id$='ddlStartTime'] option:selected").text();
          var Time_To_ID = $("select[id$='ddlEndTime']").val();
          if (Time_To_ID == "0") {
              alert("Please Select Activity End Time!");
              $("select[id$='ddlEndTime']").focus();
              return false;
          }
          var Time_To = $("select[id$='ddlEndTime'] option:selected").text();
          var Absolute_Cost = $("input[id$='txtCalculatedHrSalary']").val().trim();
          var Relative_Cost = $("input[id$='txtCalculatedRelativeCost']").val().trim();
          if (Relative_Cost == "0") {
            alert("Please Enter Relative Cast!");
            return false;
          }
          var Opportunity_Cost = $("input[id$='txtOppertunityCost']").val().trim();
          if (Opportunity_Cost == "") {
              alert("Please Enter Opportunity Cast!");
              return false;
          }
          var Opportunity_Cost_Color = $("input[id$='txtCostIndicator']").val().trim();
          var Traveling_Source_ID = $("select[id$='ddlTravelingSource']").val();
          var Traveling_Distance = $("input[id$='txtTravelingDistance']").val().trim();
          var Traveling_Cost = $("input[id$='txtTravelingCost']").val().trim();
          var Total_Activity_Cost = $("input[id$='txtActivityCost']").val().trim();
          var Branch_Name = $("input[id$='txtBranch']").val().trim();
          var Department_Name = $("input[id$='txtDepartment']").val().trim();
        
                $.ajax({
                type: "POST",
                contentType:"application/json; charset=utf-8",
                url: "TodayTask_Sheet.aspx/UpdateNextDayPlanning",               
                data: "{'DailyTask_ID':'" + DailyTask_ID + "','Emp_ID':'" + Emp_ID + "','Project_ID':'" + Project_ID + "','Other_Description':'" + Other_Description + "','Time_From_ID':'" + Time_From_ID + "','Time_From':'" + Time_From + "','Time_To_ID':'" + Time_To_ID + "','Time_To':'" + Time_To + "','Absolute_Cost':'" + Absolute_Cost + "','Relative_Cost':'" + Relative_Cost + "','Opportunity_Cost':'" + Opportunity_Cost + "','Opportunity_Cost_Color':'" + Opportunity_Cost_Color + "' ,'Traveling_Source_ID':'" + Traveling_Source_ID + "','Traveling_Distance':'" + Traveling_Distance + "','Traveling_Cost':'" + Traveling_Cost + "','Total_Activity_Cost':'" + Total_Activity_Cost + "','Branch_Name':'" + Branch_Name + "','Department_Name':'" + Department_Name + "'}",
                success: onsuccessUpdateNextDayPlannings,
                error:onretrieveUpdateNextDayPlannings 
                });
        return false; 
      }
      function onsuccessUpdateNextDayPlannings()
      {
        alert("Record Updated Successfully!");
        getTodayTaskDetails();
        Clear();
        return false;
      }
      function onretrieveUpdateNextDayPlannings()
      {
        alert("Error In Updating Record!");
        return false;
      }
     

      function getColor()
      {
          var OppertunityCostColor = "";
          var OppertunityCost= $("input[id$='txtOppertunityCost']").val();
          var AbsoluteCost = $("input[id$='txtCalculatedHrSalary']").val();
          var RelativeCost = $("input[id$='txtCalculatedRelativeCost']").val();
          if (parseInt(OppertunityCost) >= parseInt(RelativeCost))
        {
              $("input[id$='txtOppertunityCost']").css("background-color", "green");
              OppertunityCostColor = "green";
        }
          if (parseInt(OppertunityCost) < parseInt(RelativeCost) && parseInt(OppertunityCost) >= parseInt(AbsoluteCost)) {
              $("input[id$='txtOppertunityCost']").css("background-color", "yellow");
              OppertunityCostColor = "yellow";
          }

          if (parseInt(OppertunityCost) < parseInt(AbsoluteCost)) {
              $("input[id$='txtOppertunityCost']").css("background-color", "red");
              OppertunityCostColor = "red";
          }

          $("input[id$='txtCostIndicator']").val(OppertunityCostColor);

      }
    
    
      function getTotalActivityCost() {
          var AbsoluteCalculatedCost = $("input[id$='txtCalculatedHrSalary']").val();
          var TravelingCost = $("input[id$='txtTravelingCost']").val();
          $("input[id$='txtActivityCost']").val(parseInt(AbsoluteCalculatedCost) + parseInt(TravelingCost));
      }
    
    </script>
</asp:Content>


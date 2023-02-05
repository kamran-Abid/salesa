<%@ Page Title="" Language="C#" MasterPageFile="~/MCTX_Internal/SuperAdmin/MasterAdmin.master" AutoEventWireup="true" CodeFile="DailyTaskSheet_NextDayPlanning.aspx.cs" Inherits="MCTX_Internal_SuperAdmin_DailyTaskSheet_NextDayPlanning" %>
<%@ Register Assembly="RJS.Web.WebControl.PopCalendar.Net.2008" Namespace="RJS.Web.WebControl"
    TagPrefix="rjs" %>
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

td,p {
    padding-top: .2em;
    padding-bottom: .2em;
}

select {
    height:20px;

}

   .rotateLeft{
                -moz-transform:rotate(90deg);
                -webkit-transform:rotate(90deg);
                transform:rotate(90deg);
            }
			p,h3{
			
			font-family:Calibri;
			}
			 .arrowTopMain{
                -moz-transform: rotate(0deg);
                -webkit-transform: rotate(0deg);
                transform: rotate(0deg);
            }	
            .arrowTopInner{
                -moz-transform: rotate(180deg);
                -webkit-transform: rotate(180deg);
                transform: rotate(180deg);
            }		
    </style>

    
		 
	  
	<div onclick="mainSlide()" style="position: fixed;z-index:9099;float: left;left: 1.4%;
			top: 0%;background-color: #191970;color: white;padding-left:1%;padding-right:1%;padding-top:0.5%;padding-bottom:0.5%;cursor:pointer; border-bottom: 2px solid white;">
Show/Hide Task Type</div>
<div id="divTaskTypes"style="position: fixed;z-index:9099;float: left;left: 1.4%;display:none;overflow:auto;
			top: 4%;background-color:#191970;color: white;padding-left:1%;padding-right:1%;padding-top:0.5%;padding-bottom:0.5%;cursor:pointer; border-bottom: 2px solid white;">



</div>		 
       
    <div id="tabs" style="width: 100%;">
        <ul>
            <li style="text-align: left"><a href="#tabs-1">Add/Modify  Next Day Planning</a></li>
           
            
        </ul>
        <div id="tabs-1" style="width: 98%">
            <fieldset id="fldAddITProj" runat="server" style="width:92%; padding:2%">
                <legend>Add Next Day Planning</legend>
                <table width="100%" style="font-family: Calibri; font-size: 11pt;" >

                                        <tr>
                        <td colspan="2"><label style="font-weight:bold;font-size:16px;">Today's Explicit Cost:</label>
                            <asp:Label ID="lblTodayBasicSalary" runat="server" style="font-weight:bold;color:maroon;font-size:large"></asp:Label></td>
                        <td colspan="2"><label style="font-weight:bold;font-size:16px;">Output Justified Today:</label>
                            <label style="font-weight:bold;color:green;font-size:large" id="lblJustifiedCost">0</label>

                        </td>
                        <td colspan="2"><label style="font-weight:bold;font-size:16px;">Money Turn into Loss:</label>
                            <label style="font-weight:bold;color:red;font-size:large" id="lblTurnintoLossCost">0</label>
                        </td>
                        
                    </tr>
                    <tr>
                        <td width="140px" >
                            <asp:Label ID="Label1" Text="Select Employee:" runat="server"></asp:Label>
                        </td>
                        <td  width="200px" >
                            <asp:DropDownList ID="ddlEmployee" Width="95%" runat="server" onchange="getEmpSalaries();">
                        </asp:DropDownList>
                        </td>

                         <td width="140px">
                             <asp:Label ID="Label3" Text=" Select Project:" runat="server"></asp:Label>
                                       
                           </td>
                          <td  width="200px">
                                        <asp:DropDownList ID="ddlProject" Width="95%" runat="server" onchange="getProgetPriority();" >
                                         </asp:DropDownList>
                          </td>

                        <td width="140px" >
                            <asp:Label ID="Label4" Text="Others:" runat="server"></asp:Label>
                        </td>
                        <td   style="width: 200px;">
                            <asp:TextBox ID="txtOther" Width="95%"  runat="server" BackColor="White" ></asp:TextBox>
                        </td>

                        </tr>
                    <tr>
                                    
                                    <td width="140px">
                                        Select Start Time:
                                    </td>
                                    <td  width="200px">
                                        <asp:DropDownList ID="ddlStartTime" Width="95%" runat="server" onchange="getTotalHrs();" >
                                            <asp:ListItem Value="0">--Select--</asp:ListItem>
                                             <asp:ListItem Value="1"> 08:00 am</asp:ListItem>
                                             <asp:ListItem Value="2"> 09:00 am</asp:ListItem>
                                             <asp:ListItem Value="3"> 10:00 am</asp:ListItem>
                                             <asp:ListItem Value="4"> 11:00 am</asp:ListItem>
                                             <asp:ListItem Value="5"> 12:00 am</asp:ListItem>
                                             <asp:ListItem Value="6"> 01:00 pm</asp:ListItem>
                                             <asp:ListItem Value="7"> 02:00 pm</asp:ListItem>
                                             <asp:ListItem Value="8"> 03:00 pm</asp:ListItem>
                                             <asp:ListItem Value="9"> 04:00 pm</asp:ListItem>
                                             <asp:ListItem Value="10">05:00 pm</asp:ListItem>
                                             <asp:ListItem Value="11">06:00 pm</asp:ListItem>
                                             <asp:ListItem Value="12">07:00 pm</asp:ListItem>
                                             <asp:ListItem Value="13">08:00 pm</asp:ListItem>
                                             <asp:ListItem Value="14">09:00 pm</asp:ListItem>
                                             <asp:ListItem Value="15">10:00 pm</asp:ListItem>
                                             <asp:ListItem Value="16">11:00 pm</asp:ListItem>
                                             <asp:ListItem Value="17">12:00 pm</asp:ListItem>
                                         </asp:DropDownList>
                                    </td>
                                    <td width="140px">
                                        Select End Time:
                                    </td>
                                    
                                    <td style="width: 300px;">
                                        <asp:DropDownList ID="ddlEndTime" Width="95%" runat="server" onchange="getTotalHrs();" >
                                              <asp:ListItem Value="0">--Select--</asp:ListItem>
                                             <asp:ListItem Value="1"> 08:00 am</asp:ListItem>
                                             <asp:ListItem Value="2"> 09:00 am</asp:ListItem>
                                             <asp:ListItem Value="3"> 10:00 am</asp:ListItem>
                                             <asp:ListItem Value="4"> 11:00 am</asp:ListItem>
                                             <asp:ListItem Value="5"> 12:00 am</asp:ListItem>
                                             <asp:ListItem Value="6"> 01:00 pm</asp:ListItem>
                                             <asp:ListItem Value="7"> 02:00 pm</asp:ListItem>
                                             <asp:ListItem Value="8"> 03:00 pm</asp:ListItem>
                                             <asp:ListItem Value="9"> 04:00 pm</asp:ListItem>
                                             <asp:ListItem Value="10">05:00 pm</asp:ListItem>
                                             <asp:ListItem Value="11">06:00 pm</asp:ListItem>
                                             <asp:ListItem Value="12">07:00 pm</asp:ListItem>
                                             <asp:ListItem Value="13">08:00 pm</asp:ListItem>
                                             <asp:ListItem Value="14">09:00 pm</asp:ListItem>
                                             <asp:ListItem Value="15">10:00 pm</asp:ListItem>
                                             <asp:ListItem Value="16">11:00 pm</asp:ListItem>
                                             <asp:ListItem Value="17">12:00 pm</asp:ListItem>
                                    </asp:DropDownList>
                                        <asp:TextBox ID="txtTotalHour" runat="server"  style="display:none" disabled="true"></asp:TextBox>
                                            </td>
                        <td width="140px"><asp:Label ID="Label2" Text="Absolute Cost:" runat="server"></asp:Label>
                                        
                                    </td>
                                    
                                    <td style="width: 200px;">
                                        <asp:TextBox ID="txtCalculatedHrSalary" Width="95%"  runat="server"  disabled="true" ></asp:TextBox>
                                        <asp:TextBox ID="txtPerHorSalary" Width="95%" style="display:none" runat="server"  disabled="true" ></asp:TextBox>
                                    </td>
                                </tr>

                    <tr>

                        <td width="140px">
                            <asp:Label ID="lblRelativeCost" Text="Relative Cost:" runat="server"></asp:Label>
                        </td>
                        <td   style="width: 200px;">
                            <asp:TextBox ID="txtRelativeCost" Width="95%"  runat="server" style="display:none" Enabled="false" BackColor="White" ></asp:TextBox>
                            <asp:TextBox ID="txtCalculatedRelativeCost" Width="95%"  runat="server" Enabled="false" BackColor="White" ></asp:TextBox>
                        </td>
                        <td width="140px">
                            <asp:Label ID="Label5" Text="Opportunity Cost:" runat="server"></asp:Label>
                        </td>   
                         <td   style="width: 200px;">
                            <asp:TextBox ID="txtOppertunityCost" Width="95%"  runat="server" BackColor="White" onblur="getColor();" ></asp:TextBox>
                             <asp:TextBox ID="txtCostIndicator" Width="95%"  runat="server" BackColor="White" style="display:none;" ></asp:TextBox>
                        </td>
                        <td width="140px">
                            <asp:Label ID="Label6" Text="Traveling Distance:" runat="server"></asp:Label>
                        </td>   
                         <td   style="width: 200px;">
                             <asp:TextBox ID="txtTravelingDistance" Width="85%"  runat="server" BackColor="White"  ></asp:TextBox>KM
                            
                        </td>
                        
                    </tr>

                     <tr>

                        <td width="140px">
                            <asp:Label ID="Label7" Text="Traveling Sourct:" runat="server"></asp:Label>
                        </td>
                        <td   style="width: 200px;">
                            <asp:DropDownList ID="ddlTravelingSource" Width="95%" runat="server">
                        </asp:DropDownList>
                        </td>
                        <td width="140px">
                            <asp:Label ID="Label8" Text="Traveling Cost:" runat="server"></asp:Label>
                        </td>   
                         <td   style="width: 200px;">
                            <asp:TextBox ID="txtTravelingCost" Width="95%"  runat="server"  BackColor="White" onblur="getTotalActivityCost()" ></asp:TextBox>
                           
                        </td>
                        <td width="140px">
                            <asp:Label ID="Label9" Text="Total Activity Cost:" runat="server"></asp:Label>
                        </td>   
                         <td   style="width: 200px;">
                             <asp:TextBox ID="txtActivityCost" Width="95%"  runat="server" Enabled="false" BackColor="White"  ></asp:TextBox>
                            
                        </td>
                        
                    </tr>

                    <tr>
                        
                        <td width="140px">
                            <asp:Label ID="Label11" Text="Branch:" runat="server"></asp:Label>
                        </td>
                        <td   style="width: 200px;">
                            <asp:TextBox ID="txtBranch" Width="95%" runat="server" Enabled="false">
                        </asp:TextBox>
                        </td>
                         <td width="140px">
                            <asp:Label ID="Label10" Text="Department:" runat="server"></asp:Label>
                        </td>
                        <td   style="width: 200px;">
                            <asp:TextBox ID="txtDepartment" Width="95%" runat="server" Enabled="false">
                        </asp:TextBox>
                        </td>
                        <td colspan="1">
                            &nbsp;
                        </td>
                         <td  align="left">
                            <asp:TextBox ID="txtDailyTask_IDs" Style="display: none;" runat="server"></asp:TextBox>
                        </td>
                    </tr>

                    <tr>
                        
                        <td width="140px">
                            <asp:Label ID="Label12" Text="Activity Description:" runat="server"></asp:Label>
                        </td>
                        <td colspan="3"  style="width: 200px;">
                            <asp:TextBox ID="txtActivityDescription" Width="98%" runat="server">
                        </asp:TextBox>
                        </td>
                         <td width="140px">
                            <asp:Label ID="Label13" Text="Activity Date:" runat="server"></asp:Label>
                        </td>
                        <td align="left" style="width: 140px;">
                            <asp:TextBox ID="txtStartDate" Width="106px" onkeypress="return keyRestrict(event,'0123456789/')"
                                runat="server"></asp:TextBox>
                            <rjs:PopCalendar ID="rjsStartDate" Separator="/" Format="mm dd yyyy" Control="txtStartDate"
                                runat="server" Font-Names="Tahoma" />
                        </td>
                        
                    </tr>

                    <tr>

                        <td colspan="6">
                            &nbsp;
                        </td>
                        </tr>
                    <tr>

                        <td colspan="4">
                            &nbsp;
                        </td>
                        <td colspan="2"  align="left">
                            <asp:Button ID="btnSave" Text="Add" Style="background-color: #273D5F; color: White;"
                                Width="75px" OnClientClick="getColor(); SaveNextDayPlanning();" runat="server" />
                        
                            <asp:Button ID="btnClear" Text="Clear" Style="background-color: #273D5F; color: White;"
                                Width="75px" OnClientClick="return Clear();" runat="server" />
                        
                            <asp:Button ID="btnUpdate" Text="Update" Style="background-color: #273D5F; color: White;
                                display: none;" Width="75px" OnClientClick="return UpdateNextDayPlanning();" runat="server" />
                        </td>
                    </tr>
                </table>
            </fieldset>

            
            <fieldset id="fldNextDayPlanningDetails"  style="width:92%; padding:2%;  max-height: 400px;">
                <legend>Next Day Planning Details</legend>
                <div id="divNextDayPlanningDetails" style="overflow: auto; width: 1160px;height: 400px;"  >
                <table id="tblNextDayPlanning" class="dataTable">
                </table>
                    </div>
	</fieldset>
        
        </div>
	
     
     
        
	
    </div>

     
        
       

    <script type="text/javascript" language="javascript">
        function mainSlide() {
            $("#divTaskTypes").slideToggle("slow");
        }
       
        var oTable;

        var OutputJustifiedToday = 0;
        var MoneyTurnintoLoss = 0;
    $(document).ready(function () {
        getNextDayPlanningDetails();
        getTaskTypes();
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
              url: "DailyTaskSheet_NextDayPlanning.aspx/getEmpSalary",
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

      function SaveNextDayPlanning()
      {
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
        
          var Activity_Description = $("input[id$='txtActivityDescription']").val().trim();          
          var task_date = $("input[id$='txtStartDate']").val().trim();
          if (Activity_Description == "") {
              alert("Please Enter Activity Description!");
              return false;
          }
          if (task_date == "") {
              alert("Please Enter Task Date!");
              return false;
          }
                $.ajax({
                type: "POST",
                contentType:"application/json; charset=utf-8",
                url: "DailyTaskSheet_NextDayPlanning.aspx/SaveNextDayPlanning",               
                data: "{'Emp_ID':'" + Emp_ID + "','Project_ID':'" + Project_ID + "','Other_Description':'" + Other_Description + "','Time_From_ID':'" + Time_From_ID + "','Time_From':'" + Time_From + "','Time_To_ID':'" + Time_To_ID + "','Time_To':'" + Time_To + "','Absolute_Cost':'" + Absolute_Cost + "','Relative_Cost':'" + Relative_Cost + "','Opportunity_Cost':'" + Opportunity_Cost + "','Opportunity_Cost_Color':'" + Opportunity_Cost_Color + "' ,'Traveling_Source_ID':'" + Traveling_Source_ID + "','Traveling_Distance':'" + Traveling_Distance + "','Traveling_Cost':'" + Traveling_Cost + "','Total_Activity_Cost':'" + Total_Activity_Cost + "','Branch_Name':'" + Branch_Name + "','Department_Name':'" + Department_Name + "','Activity_Description':'" + Activity_Description + "','task_date':'" + task_date + "'}",
                success: onsuccessSaveNextDayPlanning,
                error:onretrieveSaveNextDayPlanningError 
                });
        return false; 
      }
      function onsuccessSaveNextDayPlanning(msg)
      {
        alert("Data Successfully Saved!");
        return false;
      }
      function onretrieveSaveNextDayPlanningError(msg)
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
          $("input[id$='txtActivityDescription']").val("");
          $("input[id$='txtStartDate']").val("");
          

        $("input[id$='btnUpdate']").hide();
        $("input[id$='btnSave']").attr("disabled", false);
        return false;
      }

      function getTaskTypes() {
          $.ajax({
              type: "POST",
              contentType: "application/json; charset=utf-8",
              url: "DailyTaskSheet_NextDayPlanning.aspx/getTaskType",
              data: "{}",
              success: onsuccessgetgetTaskTypeDetails,
              error: onretrievegetgetTaskTypeDetails
          });
          return false;
      }

      function onsuccessgetgetTaskTypeDetails(msg) {
          
          var data = msg.d;
          if (oTable != null) {
              oTable.fnClearTable();
              oTable.fnDestroy();
          }
          var tbl = "";
       

          for (var i = 0; i < data.TaskTypeDetails.length; i++) {
              
              tbl += "<br/><div style='font-size:15px;background-color:gray;' onclick='return getTaskTypeDescription(" + i + ");' id='div" + data.TaskTypeDetails[i].Task_type_id + "'>";
              tbl += "<p style='text-align:right; white-space:nowrap; display:none;' id='txtTask_type_id" + i + "'>" + data.TaskTypeDetails[i].Task_type_id + "</p>";
              tbl += "<p style='text-align:left; white-space:nowrap;' id='txtTask_tpe_Name" + i + "'>" + data.TaskTypeDetails[i].Task_tpe_Name + "</p>";
              tbl += "<div style='text-align:right; white-space:nowrap; display:none;' id='divTask_type_id" + i + "'>" + data.TaskTypeDetails[i].Task_type_id + "</div>";
              
              tbl += "</div>";
              tbl += "<hr/>";
              tbl += "<div id='innererDiv" + data.TaskTypeDetails[i].Task_type_id + "'>";
              tbl += "</div>";
          }
         
          $("#divTaskTypes").html(tbl);
         
          //dataTable();
          return false;
      }
      function onretrievegetgetTaskTypeDetails() {
          alert("Error In Loading Details!");
          return false;
      }

      function getTaskTypeDescription(rowNo)
      {
         
          var Task_type_id = $("#txtTask_type_id" + rowNo).html().trim();
          var Task_tpe_Name = $("#txtTask_tpe_Name" + rowNo).html().trim();
          var empID = $("select[id$='ddlEmployee']").val();
          $.ajax({
              type: "POST",
              contentType: "application/json; charset=utf-8",
              url: "DailyTaskSheet_NextDayPlanning.aspx/getTaskTypeDescription",
              data: "{'Task_type_id':'" + Task_type_id + "'}",
              success: onsuccessgetTaskTypeDescriptionDetails,
              error: onerrorTaskTypeDescriptionDetails
          });
          return false;
      }

      function onsuccessgetTaskTypeDescriptionDetails(msg) {

          var data = msg.d;
          if (oTable != null) {
              oTable.fnClearTable();
              oTable.fnDestroy();
          }
          var tbl = "";
          tbl += "<table id='tbltest' style='background-color:black;color:white;width:100%'>";
          var taskTypeID = "";
          for (var i = 0; i < data.TaskTypeDescriptionDetails.length; i++) {
              tbl += "<tr id='mytr"+i+"'>";
              taskTypeID = data.TaskTypeDescriptionDetails[i].TaskType_id;
              
              tbl += "<td style='background-color:red;'>";
              tbl += "<br/><div  id='div" + data.TaskTypeDescriptionDetails[i].ThingsToDo_id + "'>";
              tbl += "<td style='text-align:left;font-size:12px; ' id='txtTask_tpe_Name" + i + "'>" + data.TaskTypeDescriptionDetails[i].Activity_Description + "</td>";
              tbl += "<td style='text-align:right;  display:none;' id='txtThingsToDo_id" + i + "'>" + data.TaskTypeDescriptionDetails[i].ThingsToDo_id + "</td>";
              tbl += "<td style='text-align:right;  display:none;' id='txtTaskType_id" + i + "'>" + data.TaskTypeDescriptionDetails[i].TaskType_id + "</td>";
              tbl += "<td ><select id='ddlActivityStatuse" + i + "'><option value='0'>Incompleted</option><option value='1'>Completed</option></select></td>";
              tbl += "<td style='text-align:left;' id='txttask_date" + i + "'> <input type='button' id='btnSave' onclick='SaveTodayTask(" + i + ");' value='Save' style='color:green' /></td>";
              tbl += "</div>";
              tbl += "</td>";
              tbl += "</tr>";
          }
          tbl += "</table>";
          $("div[id*='innererDiv']").hide("slow");
          $("#innererDiv" + taskTypeID).show();
          $("#innererDiv" + taskTypeID).html(tbl);
          
         // $("#divTask_type_id0").show();
          //dataTable();
          return false;
      }
      function onerrorTaskTypeDescriptionDetails() {
          alert("Error In Loading Details!");
          return false;
      }


      function SaveTodayTask(rowNo) {
          
          var ThingsToDo_id = $("#txtThingsToDo_id" + rowNo).text();
          var ThingToDo_Status = $("select[id$='ddlActivityStatuse" + rowNo + "']").val();
          if (ThingToDo_Status == "0")
              return false;
          var TaskType_ids = $("#txtTaskType_id" + rowNo).html();
          
          TaskType_ids = parseInt(TaskType_ids);
          
          $.ajax({
              type: "POST",
              contentType: "application/json; charset=utf-8",
              url: "DailyTaskSheet_NextDayPlanning.aspx/UpdateThingToDo",
              data: "{'ThingsToDo_id':'" + ThingsToDo_id + "','ThingToDo_Status':'" + ThingToDo_Status + "'}",
              success: function test() {
                  
                  alert("Data Successfully Saved!");
                  if (ThingToDo_Status == "1")
                  $("#mytr" + rowNo).hide();
                  return false;
              }  ,
              error: onretrieveTodayTaskError
          });
          return true;
      }
      function onsuccessSaveTodayTask(TaskType_id) {

         
      }
      function onretrieveTodayTaskError(msg) {
          alert("Error In Saving Data!" + msg.responseText);
          return false;
      }


      function getNextDayPlanningDetails()
      {
        $.ajax({
            type: "POST",
            contentType:"application/json; charset=utf-8",
            url: "DailyTaskSheet_NextDayPlanning.aspx/getNextDayPlanningDetails",
            data: "{}", 
            success:onsuccessgetNextDayPlanningDetails,
            error:onretrievegetNextDayPlanningDetails 
        });
        return false; 
      }
      function onsuccessgetNextDayPlanningDetails(msg)
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
                
                tbl += "<th style='text-align:center; white-space:nowrap;'>Edit</th>";
                tbl += "<th style='text-align:left; white-space:nowrap; display:none;'>Next Day Planning ID</th>";
                tbl += "<th style='text-align:left; white-space:nowrap; display:none;'>Employee ID</th>";
                tbl += "<th style='white-space:nowrap; text-align:left;'>Employee Name</th>";
                tbl += "<th style='text-align:left; white-space:nowrap; display:none;'>Project ID</th>";
                tbl += "<th style='white-space:nowrap; text-align:left;'>Project Name</th>";
                tbl += "<th style='white-space:nowrap; text-align:left;'>Activity Description</th>";

                tbl += "<th style='white-space:nowrap; text-align:left;'>Other</th>";
                tbl += "<th style='text-align:left; white-space:nowrap; display:none;'>Time From ID</th>";
                tbl += "<th style='white-space:nowrap; text-align:left;'>Time From</th>";
                tbl += "<th style='text-align:left; white-space:nowrap; display:none;'>Time To ID</th>";
                tbl += "<th style='white-space:nowrap; text-align:left;'>Time To</th>";                   
                tbl += "<th style='white-space:nowrap; text-align:left;'>Absolute Cost</th>";
                tbl += "<th style='white-space:nowrap; text-align:left;'>Relative Cost</th>";
                tbl += "<th style='white-space:nowrap; text-align:left;'>Opportunity Cost</th>";
          tbl += "<th style='text-align:left; white-space:nowrap; display:none;'>Oppertunity Cost Indicator</th>";

                tbl += "<th style='text-align:left; white-space:nowrap; display:none;'>Traveling Source ID</th>";
                tbl += "<th style='white-space:nowrap; text-align:left;'>Traveling Source</th>";
                tbl += "<th style='white-space:nowrap; text-align:left;'>Traveling Distance</th>";
                tbl += "<th style='white-space:nowrap; text-align:left;'>Traveling Cost</th>";
                tbl += "<th style='white-space:nowrap; text-align:left;'>Total Cost</th>";

                tbl += "<th style='white-space:nowrap; text-align:left;'>Baranch</th>";
                tbl += "<th style='white-space:nowrap; text-align:left;'>Department</th>";
                tbl += "<th style='white-space:nowrap; text-align:left;'>Task Date</th>";

                tbl += "<th style='white-space:nowrap; text-align:left;'>Created By</th>";
                tbl += "<th style='white-space:nowrap; text-align:left;'>Created Date</th>";
                tbl += "<th style='white-space:nowrap; text-align:left;'>Modified By</th>";
                tbl += "<th style='white-space:nowrap; text-align:left;'>Modified Date</th>";
                tbl += "</tr>";
                tbl += "</thead>";
                tbl += "<tbody>";
                var ProjectNameOrOther = "";

                for (var i = 0; i < data.NextDayPlanningDetails.length; i++) {                   
                    if (data.NextDayPlanningDetails[i].Project_Name == "")
                         {
                            
                        ProjectNameOrOther = data.NextDayPlanningDetails[i].Other_Description;

                    }
                    else
                        ProjectNameOrOther = data.NextDayPlanningDetails[i].Project_Name;
                    tbl += "<tr style='background-color:white'>";
                            tbl += "<td style='cursor:Pointer;' id='txtUpdate' align='center' onclick='return EditRecord("+i+");'><img src='image/Edit.png'></td>";                        
                            tbl += "<td style='text-align:right; white-space:nowrap; display:none;' id='txtDailyTask_ID" + i + "'>" + data.NextDayPlanningDetails[i].DailyTask_ID + "</td>";
                            tbl += "<td style='text-align:right; white-space:nowrap; display:none;' id='txtEmp_ID" + i + "'>" + data.NextDayPlanningDetails[i].Emp_ID + "</td>";
                            tbl += "<td style='text-align:left; white-space:nowrap;' id='txtEmpName" + i + "'>" + data.NextDayPlanningDetails[i].E_Name + "</td>";
                            tbl += "<td style='text-align:right; white-space:nowrap; display:none;' id='txtProject_ID" + i + "'>" + data.NextDayPlanningDetails[i].Project_ID + "</td>";
                            tbl += "<td style='text-align:left; white-space:nowrap;' id='txtProject_Name" + i + "'>" + data.NextDayPlanningDetails[i].Project_Name + "</td>";
                            tbl += "<td style='text-align:left;' id='txtActivity_Description" + i + "'>" + data.NextDayPlanningDetails[i].Activity_Description + "</td>";

                            tbl += "<td style='text-align:left; white-space:nowrap;' id='txtOther_Description" + i + "'>" + data.NextDayPlanningDetails[i].Other_Description + "</td>";
                            tbl += "<td style='text-align:right; white-space:nowrap; display:none;' id='txtTime_From_ID" + i + "'>" + data.NextDayPlanningDetails[i].Time_From_ID + "</td>";
                            tbl += "<td style='text-align:left; white-space:nowrap;' id='txtTime_From" + i + "'>" + data.NextDayPlanningDetails[i].Time_From + "</td>";
                            tbl += "<td style='text-align:right; white-space:nowrap; display:none;' id='txtTime_To_ID" + i + "'>" + data.NextDayPlanningDetails[i].Time_To_ID + "</td>";
                            tbl += "<td style='text-align:left; white-space:nowrap;' id='txtTime_To" + i + "'>" + data.NextDayPlanningDetails[i].Time_To + "</td>";
                            tbl += "<td style='text-align:left; white-space:nowrap;' id='txtAbsoluteCost" + i + "'>" + data.NextDayPlanningDetails[i].Absolute_Cost + "</td>";
                            tbl += "<td style='text-align:left; white-space:nowrap;' id='txtRelativeCost" + i + "'>" + data.NextDayPlanningDetails[i].Relative_Cost + "</td>";
                            tbl += "<td style='text-align:left; white-space:nowrap;background-color:" + data.NextDayPlanningDetails[i].Opportunity_Cost_Color + "' id='txtOpportunity_Cost" + i + "'>" + data.NextDayPlanningDetails[i].Opportunity_Cost + "</td>";
                            tbl += "<td style='text-align:right; white-space:nowrap; display:none;' id='txtOpportunity_Cost_Color" + i + "'>" + data.NextDayPlanningDetails[i].Opportunity_Cost_Color + "</td>";
                            tbl += "<td style='text-align:right; white-space:nowrap; display:none;' id='txtTraveling_Source_ID" + i + "'>" + data.NextDayPlanningDetails[i].Traveling_Source_ID + "</td>";
                            tbl += "<td style='text-align:left; white-space:nowrap;' id='txtTraveling_Source_Name" + i + "'>" + data.NextDayPlanningDetails[i].Traveling_Source_Name + "</td>";
                            tbl += "<td style='text-align:left; white-space:nowrap;' id='txtTraveling_Distance" + i + "'>" + data.NextDayPlanningDetails[i].Traveling_Distance + "</td>";
                            tbl += "<td style='text-align:left; white-space:nowrap;' id='txtTraveling_Cost" + i + "'>" + data.NextDayPlanningDetails[i].Traveling_Cost + "</td>";
                            tbl += "<td style='text-align:left; white-space:nowrap;' id='txtTotal_Activity_Cost" + i + "'>" + data.NextDayPlanningDetails[i].Total_Activity_Cost + "</td>";
                            tbl += "<td style='text-align:left; white-space:nowrap;' id='txtBranch_Name" + i + "'>" + data.NextDayPlanningDetails[i].Branch_Name + "</td>";
                            tbl += "<td style='text-align:left; white-space:nowrap;' id='txtDepartment_Name" + i + "'>" + data.NextDayPlanningDetails[i].Department_Name + "</td>";
                            tbl += "<td style='text-align:left; white-space:nowrap;' id='txttask_date" + i + "'>" + data.NextDayPlanningDetails[i].task_date + "</td>";
                            tbl += "<td style='text-align:left; white-space:nowrap;' id='txtCreatedBy" + i + "'>" + data.NextDayPlanningDetails[i].created_by + "</td>";
                            tbl += "<td style='text-align:right; white-space:nowrap;' id='txtCreatedDate" + i + "'>" + data.NextDayPlanningDetails[i].created_date + " </td>";
                            tbl += "<td style='text-align:left; white-space:nowrap;' id='txtModBy" + i + "'>" + data.NextDayPlanningDetails[i].modified_by + " </td>";
                            tbl += "<td style='text-align:right; white-space:nowrap;' id='txtModDate" + i + "'>" + data.NextDayPlanningDetails[i].modified_date + " </td>";
                      tbl += "</tr>";
                }   
                tbl += "</tbody>";
                tbl += "</table>";
                $("#tblNextDayPlanning").html(tbl);
          //dataTable();


                $("label[id$='lblJustifiedCost']").text("0");
                $("label[id$='lblTurnintoLossCost']").text("0");
                var tblLength = $("#tblNextDayPlanning tr").length - 1;
                $("label[id$='lblJustifiedCost']").text("");

                $("label[id$='lblTurnintoLossCost']").text("");
                for (i = 0; i <= tblLength; i++) {

                    var ActivityStatusValue = data.NextDayPlanningDetails[i].Activity_Status;

                    
                        var abCost = data.NextDayPlanningDetails[i].Absolute_Cost;
                        OutputJustifiedToday = OutputJustifiedToday + parseInt(abCost);
                        $("label[id$='lblJustifiedCost']").text(OutputJustifiedToday);
                        MoneyTurnintoLoss = parseInt($("span[id$='lblTodayBasicSalary']").text()) - parseInt(OutputJustifiedToday);
                        $("label[id$='lblTurnintoLossCost']").text(MoneyTurnintoLoss);

                        ActivityStatusValue = 1;
                        $("select[id$='ddlActivityStatus" + i + "']").val(ActivityStatusValue);
                        $("select[id$='ddlActivityStatus" + i + "']").attr("disabled", true);
                    

                }

                return false; 
      }
      function onretrievegetNextDayPlanningDetails()
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

          
          var Activity_Description = $("#txtActivity_Description" + rowNo).html().trim();
          $("input[id$='txtActivityDescription']").val(Activity_Description);

          var task_date = $("#txttask_date" + rowNo).html().trim();
          $("input[id$='txtStartDate']").val(task_date);

          
          
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

          var Activity_Description = $("input[id$='txtActivityDescription']").val().trim();
          var task_date = $("input[id$='txtStartDate']").val().trim();
          if (Activity_Description == "") {
              alert("Please Enter Activity Description!");
              return false;
          }
          if (task_date == "") {
              alert("Please Enter Task Date!");
              return false;
          }
        
                $.ajax({
                type: "POST",
                contentType:"application/json; charset=utf-8",
                url: "DailyTaskSheet_NextDayPlanning.aspx/UpdateNextDayPlanning",               
                data: "{'DailyTask_ID':'" + DailyTask_ID + "','Emp_ID':'" + Emp_ID + "','Project_ID':'" + Project_ID + "','Other_Description':'" + Other_Description + "','Time_From_ID':'" + Time_From_ID + "','Time_From':'" + Time_From + "','Time_To_ID':'" + Time_To_ID + "','Time_To':'" + Time_To + "','Absolute_Cost':'" + Absolute_Cost + "','Relative_Cost':'" + Relative_Cost + "','Opportunity_Cost':'" + Opportunity_Cost + "','Opportunity_Cost_Color':'" + Opportunity_Cost_Color + "' ,'Traveling_Source_ID':'" + Traveling_Source_ID + "','Traveling_Distance':'" + Traveling_Distance + "','Traveling_Cost':'" + Traveling_Cost + "','Total_Activity_Cost':'" + Total_Activity_Cost + "','Branch_Name':'" + Branch_Name + "','Department_Name':'" + Department_Name + "','Activity_Description':'" + Activity_Description + "','task_date':'" + task_date + "'}",
                success: onsuccessUpdateNextDayPlannings,
                error:onretrieveUpdateNextDayPlannings 
                });
        return false; 
      }
      function onsuccessUpdateNextDayPlannings()
      {
        alert("Record Updated Successfully!");
        getNextDayPlanningDetails();
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


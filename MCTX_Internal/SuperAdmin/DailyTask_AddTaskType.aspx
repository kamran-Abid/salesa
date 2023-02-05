<%@ Page Title="" Language="C#" MasterPageFile="~/MCTX_Internal/SuperAdmin/MasterAdmin.master" AutoEventWireup="true" CodeFile="DailyTask_AddTaskType.aspx.cs" Inherits="MCTX_Internal_SuperAdmin_DailyTask_AddTaskType" %>

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
    border-color: rgb(0,0,0,.15);
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
            <li style="text-align: left"><a href="#tabs-1">Add/Modify  Task Type</a></li>
           
            
        </ul>
        <div id="tabs-1" style="width: 98%">
            <fieldset id="fldAddAdctivities" runat="server" style="width:92%; padding:2%">
                <legend>Add/Modified Task Type</legend>
                <table width="100%" style="font-family: Calibri; font-size: 11pt;" >
                    <tr>
                        <td width="140px" align="left">
                            <asp:Label ID="lblActivityTaskType" Text="Task Type Name:" runat="server"></asp:Label>
                        </td>
                        <td   style="width: 600px;">
                            <asp:TextBox ID="txtTasktypeName" Width="95%"  runat="server" BackColor="White" ></asp:TextBox>
                        </td>
                        
                       
                        <td  align="left">
                            <asp:TextBox ID="txtTaskTypeIDs" Style="display: none;" runat="server"></asp:TextBox>
                        </td>
                        
                   
                        <td align="left">
                            <asp:Button ID="btnSave" Text="Add" Style="background-color: #273D5F; color: White;"
                                Width="75px" OnClientClick="return SaveTaskType();" runat="server" />
                        
                            <asp:Button ID="btnClearTaskType" Text="Clear" Style="background-color: #273D5F; color: White;"
                                Width="75px" OnClientClick="return ClearTaskType();" runat="server" />
                        
                            <asp:Button ID="btnUpdate" Text="Update" Style="background-color: #273D5F; color: White;
                                display: none;" Width="75px" OnClientClick="return UpdateTaskType();" runat="server" />
                        </td>
                    </tr>
                </table>
            </fieldset>

            <div id="divTaskTypeDetails" style="overflow: auto;width:100%;" >
            <fieldset id="fldTaskTypeDetails" runat="server" style="width:92%; padding:2%; height: 400px;">
                <legend>Task Type Details</legend>
                <table id="tbleTaskTypeDetails" class="dataTable">
                </table>
	</fieldset>
        </div>
        </div>
	
     
     
	
    </div>

    <script type="text/javascript" language="javascript">
    var oTable;
    $(document).ready(function () {
        getTaskType();
        
    });
      function dataTable() {
        oTable= $("#tbleTaskTypeDetails").dataTable({
            bPaginate: true,
            bJQueryUI: true,
            bSort: true,
            bInfo: true,
            bRetrieve: true,
            bDestroy: true,
            oLanguage: { "sSearch": "Filter: " }
            });
             $("#tbleTaskTypeDetails_length").css("text-align", "left");
        $("#tbleTaskTypeDetails_filter").css("text-align", "left");
    }

   
      function SaveTaskType()
      {
          var Task_tpe_Name = $("input[id$='txtTasktypeName']").val().trim();
         
          if (Task_tpe_Name == "")
            {
                alert("Please Enter Activity Task Type!");
                return false;
        }
        
                $.ajax({
                type: "POST",
                contentType:"application/json; charset=utf-8",
                url: "DailyTask_AddTaskType.aspx/SaveTaskType",
                data: "{'Task_tpe_Name':'" + Task_tpe_Name + "'}",
                success:onsuccessSaveTaskType,
                error:onretrieveSaveTaskTypeError 
                });
        return false; 
      }
      function onsuccessSaveTaskType()
      {
        alert("Data Successfully Saved!");
        $("input[id$='txtTasktypeName']").val("");
        getTaskType();
        return false;
      }
      function onretrieveSaveTaskTypeError()
      {
        alert("Error In Saving Data!");
        return false; 
      }
      function ClearTaskType()
      {
        $("input[id$='txtTasktypeName']").val("");
         
        $("input[id$='btnUpdate']").hide();
        $("input[id$='btnSave']").attr("disabled", false);
        return false;
      }
      function getTaskType()
      {
        $.ajax({
            type: "POST",
            contentType:"application/json; charset=utf-8",
            url: "DailyTask_AddTaskType.aspx/getTaskTypeDetail",
            data: "{}", 
            success:onsuccessgetTaskType,
            error:onretrievegetTaskType 
        });
        return false; 
      }
      function onsuccessgetTaskType(msg)
      {
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
                tbl += "<th style='text-align:left; white-space:nowrap; display:none;'>Project ID</th>";
                
                tbl += "<th style='white-space:nowrap; text-align:left;'>Activity Task Type</th>";
                
                tbl += "<th style='white-space:nowrap; text-align:left;'>Created By</th>";
                tbl += "<th style='white-space:nowrap; text-align:left;'>Created Date</th>";
                tbl += "<th style='white-space:nowrap; text-align:left;'>Modified By</th>";
                tbl += "<th style='white-space:nowrap; text-align:left;'>Modified Date</th>";
                tbl += "</tr>";
                tbl += "</thead>";
                tbl += "<tbody>";
                for (var i = 0; i < data.TaskTypeDetail.length; i++) {                   
                               
                            tbl += "<td style='cursor:Pointer;' id='txtUpdate' align='center' onclick='return EditRecord("+i+");'><img src='image/Edit.png'></td>";
                            tbl += "<td style='text-align:right; white-space:nowrap; display:none;' id='txtTaskTypeIDs" + i + "'>" + data.TaskTypeDetail[i].Task_type_id + "</td>";
                            
                            tbl += "<td style='text-align:left; white-space:nowrap;' id='txtTasktypeName" + i + "'>" + data.TaskTypeDetail[i].Task_tpe_Name + "</td>";
                            
                            tbl += "<td style='text-align:left; white-space:nowrap;' id='txtCreatedBy" + i + "'>" + data.TaskTypeDetail[i].created_by + "</td>";
                            tbl += "<td style='text-align:right; white-space:nowrap;' id='txtCreatedDate" + i + "'>" + data.TaskTypeDetail[i].created_date + " </td>";
                            tbl += "<td style='text-align:left; white-space:nowrap;' id='txtModBy" + i + "'>" + data.TaskTypeDetail[i].modified_by + " </td>";
                            tbl += "<td style='text-align:right; white-space:nowrap;' id='txtModDate" + i + "'>" + data.TaskTypeDetail[i].modified_date + " </td>";
                      tbl += "</tr>";
                }   
                tbl += "</tbody>";
                tbl += "</table>";
                $("#tbleTaskTypeDetails").html(tbl);
                dataTable();
                return false; 
      }
      function onretrievegetTaskType()
      {
        alert("Error In Loading Details!");
        return false;
      }
      function EditRecord(rowNo)
      {
          var Task_type_id = $("#txtTaskTypeIDs"+rowNo).html().trim();
          $("input[id$='txtTaskTypeIDs']").val(Task_type_id);

          var Task_tpe_Name = $("#txtTasktypeName"+rowNo).html().trim();
          $("input[id$='txtTasktypeName']").val(Task_tpe_Name);
          
          $("input[id$='btnUpdate']").show();
          $("input[id$='btnSave']").attr("disabled", true);
          return false;
      }
      function UpdateTaskType()
      {
        var Task_type_id = $("input[id$='txtTaskTypeIDs']").val();

        var Task_tpe_Name = $("input[id$='txtTasktypeName']").val();
        
          if(Task_tpe_Name=="")
            {
                alert("Please Enter Activity Name!");
                return false;
        }
       
        $.ajax({
            type: "POST",
            contentType:"application/json; charset=utf-8",
            url: "DailyTask_AddTaskType.aspx/UpdateTaskType",
            data: "{'Task_type_id':'"+Task_type_id+"','Task_tpe_Name':'"+Task_tpe_Name+"'}", 
            success:onsuccessUpdateTaskTypes,
            error:onretrieveUpdateTaskTypes 
        });
        return false; 
      }
      function onsuccessUpdateTaskTypes()
      {
        alert("Record Updated Successfully!");

        ClearTaskType();
        getTaskType();
        return false;
      }
      function onretrieveUpdateTaskTypes()
      {
        alert("Error In Updating Record!");
        return false;
      }
     
    
    
    
    </script>
</asp:Content>


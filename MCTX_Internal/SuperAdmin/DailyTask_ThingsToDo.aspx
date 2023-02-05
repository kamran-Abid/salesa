<%@ Page Title="" Language="C#" MasterPageFile="~/MCTX_Internal/SuperAdmin/MasterAdmin.master" AutoEventWireup="true" CodeFile="DailyTask_ThingsToDo.aspx.cs" Inherits="MCTX_Internal_SuperAdmin_DailyTask_ThingsToDo" %>
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
td {
    padding-top: .2em;
    padding-bottom: .2em;
}

select {
    height:20px;

}
    </style>
    <div id="tabs" style="width: 100%;">
        <ul>
           
             <li style="text-align: left"><a href="#tabs-2">Add/Modify Thing To Do </a></li>
          
            
        </ul>
        
      <div id="tabs-2" style="width: 98%">
            <fieldset id="fldAddProduct" runat="server" style="width:92%; padding:2%">
                <legend>Add Thing To Do</legend>
                <table width="100%" style="font-family: Calibri; font-size: 11pt;" >
                    <tr>
                        <td width="140px" align="left">
                            <asp:Label ID="Label2" Text="Activity Description:" runat="server"></asp:Label>
                        </td>
                        <td colspan="3" align="left" style="width: 300px;">
                            <asp:TextBox ID="txtActivityDescription" Width="93.1%"  runat="server" BackColor="White" ></asp:TextBox>
                        </td>
                         <td width="140px" >
                            <asp:Label ID="Label1" Text="Select Task Type:" runat="server"></asp:Label>
                        </td>
                        <td  width="200px" align="left">
                            <asp:DropDownList ID="ddlTaskType" Width="90%" runat="server">
                        </asp:DropDownList>
                        </td>
                         
                        
                    </tr>
                    <tr>
                        <td width="140px" align="left">
                            <asp:Label ID="Label3" Text="Select Project:" runat="server"></asp:Label>
                        </td>
                        <td  width="200px" align="left">
                            <asp:DropDownList ID="ddlProject" Width="95%" runat="server">
                        </asp:DropDownList>
                        </td>

                         <td  style="width: 140px;">
                            <asp:Label ID="lblStartDate" Text="Task Date:" runat="server"></asp:Label>
                        </td>
                        <td align="left" style="width: 140px;">
                            <asp:TextBox ID="txtStartDate" Width="106px" onkeypress="return keyRestrict(event,'0123456789/')"
                                runat="server"></asp:TextBox>
                            <rjs:PopCalendar ID="rjsStartDate" Separator="/" Format="mm dd yyyy" Control="txtStartDate"
                                runat="server" Font-Names="Tahoma" />
                        </td>
                        <td  style="width: 140px;">
                            <asp:Label ID="lblAmountRequired" Text="Amount Required:" runat="server"></asp:Label>
                        </td>
                        <td align="left" style="width: 140px;">
                            <asp:TextBox ID="txtAmountRequired" Width="90%" MaxLength="10" onkeypress="return keyRestrict(event,'0123456789')"
                                runat="server"></asp:TextBox>
                        </td>
                       
                       
                    </tr>
                    <tr>

                        <td colspan="2">
                            &nbsp;
                        </td>
                         <td  align="left">
                            <asp:TextBox ID="txtThingToDoIds" Style="display: none;" runat="server"></asp:TextBox>
                        </td>
                        <td colspan="3"  >
                            <asp:Button ID="btnAddProduct" Text="Add" Style="background-color: #273D5F; color: White;"
                                Width="75px" OnClientClick="return SaveProduct();" runat="server" />
                        
                            <asp:Button ID="btnClearThingToDo" Text="Clear" Style="background-color: #273D5F; color: White;"
                                Width="75px" OnClientClick="return ClearThingToDo();" runat="server" />
                        
                            <asp:Button ID="btnupdateThingToDo" Text="Update" Style="background-color: #273D5F; color: White;
                                display: none;" Width="75px" OnClientClick="return updateThingToDo();" runat="server" />
                        </td>
                    </tr>
                </table>
            </fieldset>

            <div id="divProduct" style="overflow: auto;width:100%;" >
            <fieldset id="fldThingToDoDetails" runat="server" style="width:92%; padding:2%; height: 400px;">
                <legend>Thing To Do Details</legend>
                <table id="tblThingToDoDetails" class="dataTable">
                </table>
	</fieldset>
        </div>
        </div>   
	
    </div>

    <script type="text/javascript" language="javascript">
    var oTable,oTable;
    $(document).ready(function () {
       
        getThingToDo();
    });
      

    function dataTableProduct() {
        oTable = $("#tblThingToDoDetails").dataTable({
            bPaginate: true,
            bJQueryUI: true,
            bSort: true,
            bInfo: true,
            bRetrieve: true,
            bDestroy: true,
            oLanguage: { "sSearch": "Filter: " }
        });
        $("#tblThingToDoDetails_length").css("text-align", "left");
        $("#tblThingToDoDetails_filter").css("text-align", "left");
        
    }
      
    //------------------------------------------------------- Product ---------------------------------------------------------------------------
      function SaveProduct() {

          Activity_Description=  $("input[id$='txtActivityDescription']").val();
          TaskType_id= $("select[id$='ddlTaskType']").val();
          ProjectType_id = $("select[id$='ddlProject']").val();
          Amount_Required = $("input[id$='txtAmountRequired']").val();
          Task_Date=$("input[id$='txtStartDate']").val();
          

          if (Activity_Description == "") {
              alert("Please Enter Activity Description!");
              return false;
          }

          if (TaskType_id == "0") {
              alert("Please Select Task Type!");
              return false;
          }
          if (ProjectType_id == "0") {
              alert("Please Select Project!");
              return false;
          }

          if (Task_Date == "") {
              alert("Please Enter Task Date!");
              return false;
          }
          $.ajax({
              type: "POST",
              contentType: "application/json; charset=utf-8",
              url: "DailyTask_ThingsToDo.aspx/SaveThingToDo",
              data: "{'Activity_Description':'" + Activity_Description + "','TaskType_id':'" + TaskType_id + "','ProjectType_id':'" + ProjectType_id + "','Amount_Required':'" + Amount_Required + "','Task_Date':'" + Task_Date + "'}",
              success: onsuccessSaveProduct,
              error: onretrieveSaveProductError
          });
          return false;
      }
      function onsuccessSaveProduct() {
          alert("Data Successfully Saved!");
          $("input[id$='txtActivityDescription']").val("");
          $("select[id$='ddlProject']").val("-- Select --");
          getThingToDo();
          return false;
      }
      function onretrieveSaveProductError() {
          alert("Error In Saving Data!");
          return false;
      }


      function getThingToDo() {
          $.ajax({
              type: "POST",
              contentType: "application/json; charset=utf-8",
              url: "DailyTask_ThingsToDo.aspx/getThingToDoDetails",
              data: "{}",
              success: onsuccessgetThingToDo,
              error: onretrievegetThingToDo
          });
          return false;
      }
      function onsuccessgetThingToDo(msg) {
          var data = msg.d;
          if (oTable != null) {
              oTable.fnClearTable();
              oTable.fnDestroy();
          }
         
          var tbl = "";
          tbl += "<thead>";
          tbl += "<tr>";

          tbl += "<th style='text-align:center; white-space:nowrap;'>Edit</th>";
          tbl += "<th style='text-align:left; white-space:nowrap; display:none;'>ThingsToDo ID</th>";
          tbl += "<th style='text-align:left; white-space:nowrap; display:none;'>TaskType ID</th>";
          tbl += "<th style='text-align:left; white-space:nowrap; display:none;'>ProjectType ID</th>";
          tbl += "<th style='white-space:nowrap; text-align:left;'>Activity Description</th>";
          tbl += "<th style='white-space:nowrap; text-align:left;'>Task Type Name</th>";
          tbl += "<th style='white-space:nowrap; text-align:left;'>Project Name</th>";
          tbl += "<th style='white-space:nowrap; text-align:left;'>Amount Required</th>";
          tbl += "<th style='white-space:nowrap; text-align:left;'>Task Date</th>";
         
          tbl += "<th style='white-space:nowrap; text-align:left;'>Created By</th>";
          tbl += "<th style='white-space:nowrap; text-align:left;'>Created Date</th>";
          tbl += "<th style='white-space:nowrap; text-align:left;'>Modified By</th>";
          tbl += "<th style='white-space:nowrap; text-align:left;'>Modified Date</th>";
          tbl += "</tr>";
          tbl += "</thead>";
          tbl += "<tbody>";
          for (var i = 0; i < data.ThingToDoDetailss.length; i++) {

              tbl += "<td style='cursor:Pointer;' id='txtUpdate' align='center' onclick='return EditThingToDo(" + i + ");'><img src='image/Edit.png'></td>";
              tbl += "<td style='text-align:right; white-space:nowrap; display:none;' id='txtThingToDoID" + i + "'>" + data.ThingToDoDetailss[i].ThingsToDo_id + "</td>";

              tbl += "<td style='text-align:right; white-space:nowrap; display:none;' id='txtTaskType_id" + i + "'>" + data.ThingToDoDetailss[i].TaskType_id + "</td>";

              tbl += "<td style='text-align:right; white-space:nowrap; display:none;' id='txtProjID" + i + "'>" + data.ThingToDoDetailss[i].ProjectType_id + "</td>";
              tbl += "<td style='text-align:left; white-space:nowrap;' id='txtActivityDescription" + i + "'>" + data.ThingToDoDetailss[i].Activity_Description + "</td>";
              tbl += "<td style='text-align:left; white-space:nowrap;' id='txtTask_tpe_Name" + i + "'>" + data.ThingToDoDetailss[i].Task_tpe_Name + "</td>";
              tbl += "<td style='text-align:left; white-space:nowrap;' id='txtProjectNames" + i + "'>" + data.ThingToDoDetailss[i].Project_Name + "</td>";

              tbl += "<td style='text-align:left; white-space:nowrap;' id='txtAmount_Required" + i + "'>" + data.ThingToDoDetailss[i].Amount_Required + "</td>";
              tbl += "<td style='text-align:left; white-space:nowrap;' id='txtTask_Date" + i + "'>" + data.ThingToDoDetailss[i].Task_Date + "</td>";



              tbl += "<td style='text-align:left; white-space:nowrap;' id='txtCreatedBy" + i + "'>" + data.ThingToDoDetailss[i].created_by + "</td>";
              tbl += "<td style='text-align:right; white-space:nowrap;' id='txtCreatedDate" + i + "'>" + data.ThingToDoDetailss[i].created_date + " </td>";
              tbl += "<td style='text-align:left; white-space:nowrap;' id='txtModBy" + i + "'>" + data.ThingToDoDetailss[i].modified_by + " </td>";
              tbl += "<td style='text-align:right; white-space:nowrap;' id='txtModDate" + i + "'>" + data.ThingToDoDetailss[i].modified_date + " </td>";
              tbl += "</tr>";
          }
          tbl += "</tbody>";
          tbl += "</table>";
          $("#tblThingToDoDetails").html(tbl);
          dataTableProduct();
          return false;
      }
      function onretrievegetThingToDo() {
          alert("Error In Loading Details!");
          return false;
      }

       function ClearThingToDo()
      {
           $("input[id$='txtThingToDoIds']").val("");
           $("input[id$='txtActivityDescription']").val("");
           $("select[id$='ddlTaskType']").val("0");
           $("select[id$='ddlProject']").val("0");
           $("input[id$='txtAmountRequired']").val("");
           $("input[id$='txtStartDate']").val("");
        $("input[id$='btnupdateThingToDo']").hide();
        $("input[id$='btnAddProduct']").attr("disabled", false);
        return false;
      }
   

    function EditThingToDo(rowNo)
      {
        var txtThingToDoIds = $("#txtThingToDoID" + rowNo).html().trim();
        $("input[id$='txtThingToDoIds']").val(txtThingToDoIds);

        var TaskTypeID = $("#txtTaskType_id" + rowNo).html().trim();
          $("select[id$='ddlTaskType']").val(TaskTypeID);

          var ActivityDescription = $("#txtActivityDescription"+rowNo).html().trim();
          $("input[id$='txtActivityDescription']").val(ActivityDescription);

          var Projid = $("#txtProjID" + rowNo).html().trim();
          $("select[id$='ddlProject']").val(Projid);
          var AmountRequired = $("#txtAmount_Required" + rowNo).html().trim();
          $("input[id$='txtAmountRequired']").val(AmountRequired);

          var TaskDate = $("#txtTask_Date" + rowNo).html().trim();
          $("input[id$='txtStartDate']").val(TaskDate);
          
          $("input[id$='btnupdateThingToDo']").show();
          $("input[id$='btnAddProduct']").attr("disabled", true);
          return false;
      }

      function updateThingToDo()
    {
          ThingsToDo_id=$("input[id$='txtThingToDoIds']").val();
          Activity_Description = $("input[id$='txtActivityDescription']").val();
          TaskType_id = $("select[id$='ddlTaskType']").val();
          ProjectType_id = $("select[id$='ddlProject']").val();
          Amount_Required = $("input[id$='txtAmountRequired']").val();
          Task_Date = $("input[id$='txtStartDate']").val();


          if (Activity_Description == "") {
              alert("Please Enter Activity Description!");
              return false;
          }

          if (TaskType_id == "0") {
              alert("Please Select Task Type!");
              return false;
          }
          if (ProjectType_id == "0") {
              alert("Please Select Project!");
              return false;
          }

          if (Task_Date == "") {
              alert("Please Enter Task Date!");
              return false;
          }
        $.ajax({
            type: "POST",
            contentType:"application/json; charset=utf-8",
            url: "DailyTask_ThingsToDo.aspx/UpdateThingToDo",
            data: "{'ThingsToDo_id':'" + ThingsToDo_id + "','Activity_Description':'" + Activity_Description + "','TaskType_id':'" + TaskType_id + "','ProjectType_id':'" + ProjectType_id + "','Amount_Required':'" + Amount_Required + "','Task_Date':'" + Task_Date + "'}",
            success:onsuccessupdateThingToDo,
            error:onretrieveupdateThingToDo 
        });
        return false; 
      }
      function onsuccessupdateThingToDo()
      {
        alert("Record Updated Successfully!");
        getThingToDo();
        ClearThingToDo();
        return false;
      }
      function onretrieveupdateThingToDo()
      {
        alert("Error In Updating Record!");
        return false;
      }
     
    
    </script>
</asp:Content>


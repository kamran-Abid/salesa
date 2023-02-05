<%@ Page Title="" Language="C#" MasterPageFile="~/MCTX_Internal/SuperAdmin/MasterAdmin.master" AutoEventWireup="true" CodeFile="Workshop_Activity_Mistake.aspx.cs" Inherits="MCTX_Internal_SuperAdmin_Workshop_Activity_Mistake" %>

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
            <li style="text-align: left"><a href="#tabs-1">Add/Modify  Activites Mitake Type</a></li>
           
            
        </ul>
        <div id="tabs-1" style="width: 98%">
            <fieldset id="fldAddAdctivities" runat="server" style="width:92%; padding:2%">
                <legend>Add/Modified Activity Mistake Type</legend>
                <table width="100%" style="font-family: Calibri; font-size: 11pt;" >
                    <tr>
                        <td width="140px" align="left">
                            <asp:Label ID="lblActivityMistakeType" Text="Activity Mistake Type:" runat="server"></asp:Label>
                        </td>
                        <td   style="width: 600px;">
                            <asp:TextBox ID="txtActivityMistakeName" Width="95%"  runat="server" BackColor="White" ></asp:TextBox>
                        </td>
                        
                       
                        <td  align="left">
                            <asp:TextBox ID="txtActivityMistakeIDs" Style="display: none;" runat="server"></asp:TextBox>
                        </td>
                        
                   
                        <td align="left">
                            <asp:Button ID="btnSave" Text="Add" Style="background-color: #273D5F; color: White;"
                                Width="75px" OnClientClick="return SaveActivity();" runat="server" />
                        
                            <asp:Button ID="btnClearActivityMistake" Text="Clear" Style="background-color: #273D5F; color: White;"
                                Width="75px" OnClientClick="return ClearActivityMistake();" runat="server" />
                        
                            <asp:Button ID="btnUpdate" Text="Update" Style="background-color: #273D5F; color: White;
                                display: none;" Width="75px" OnClientClick="return UpdateActivityMistake();" runat="server" />
                        </td>
                    </tr>
                </table>
            </fieldset>

            <div id="divActivityDetail" style="overflow: auto;width:100%;" >
            <fieldset id="fldActivityDetail" runat="server" style="width:92%; padding:2%; height: 400px;">
                <legend>Activity Mistake Type Details</legend>
                <table id="tbleActivityMistakeDetails" class="dataTable">
                </table>
	</fieldset>
        </div>
        </div>
	
     
     
	
    </div>

    <script type="text/javascript" language="javascript">
    var oTable;
    $(document).ready(function () {
        getActivityMistakeType();
        
    });
      function dataTable() {
        oTable= $("#tbleActivityMistakeDetails").dataTable({
            bPaginate: true,
            bJQueryUI: true,
            bSort: true,
            bInfo: true,
            bRetrieve: true,
            bDestroy: true,
            oLanguage: { "sSearch": "Filter: " }
            });
             $("#tbleActivityMistakeDetails_length").css("text-align", "left");
        $("#tbleActivityMistakeDetails_filter").css("text-align", "left");
    }

   
      function SaveActivity()
      {
          var ActivityMistakeTypeName = $("input[id$='txtActivityMistakeName']").val().trim();
         
        if(ActivityMistakeTypeName=="")
            {
                alert("Please Enter Activity Mistake Type!");
                return false;
        }
        
                $.ajax({
                type: "POST",
                contentType:"application/json; charset=utf-8",
                url: "Workshop_Activity_Mistake.aspx/SaveActivityMistakeType",
                data: "{'ActivityMistakeTypeName':'" + ActivityMistakeTypeName + "'}",
                success:onsuccessSaveActivity,
                error:onretrieveSaveActivityError 
                });
        return false; 
      }
      function onsuccessSaveActivity()
      {
        alert("Data Successfully Saved!");
        $("input[id$='txtActivityMistakeName']").val("");
        getActivityMistakeType();
        return false;
      }
      function onretrieveSaveActivityError()
      {
        alert("Error In Saving Data!");
        return false; 
      }
      function ClearActivityMistake()
      {
        $("input[id$='txtActivityMistakeName']").val("");
         
        $("input[id$='btnUpdate']").hide();
        $("input[id$='btnSave']").attr("disabled", false);
        return false;
      }
      function getActivityMistakeType()
      {
        $.ajax({
            type: "POST",
            contentType:"application/json; charset=utf-8",
            url: "Workshop_Activity_Mistake.aspx/getActivityDetails",
            data: "{}", 
            success:onsuccessgetActivity,
            error:onretrievegetActivity 
        });
        return false; 
      }
      function onsuccessgetActivity(msg)
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
                
                tbl += "<th style='white-space:nowrap; text-align:left;'>Activity Mistake Type</th>";
                
                tbl += "<th style='white-space:nowrap; text-align:left;'>Created By</th>";
                tbl += "<th style='white-space:nowrap; text-align:left;'>Created Date</th>";
                tbl += "<th style='white-space:nowrap; text-align:left;'>Modified By</th>";
                tbl += "<th style='white-space:nowrap; text-align:left;'>Modified Date</th>";
                tbl += "</tr>";
                tbl += "</thead>";
                tbl += "<tbody>";
                for (var i = 0; i < data.ActivityDetail.length; i++) {                   
                               
                            tbl += "<td style='cursor:Pointer;' id='txtUpdate' align='center' onclick='return EditRecord("+i+");'><img src='image/Edit.png'></td>";
                            tbl += "<td style='text-align:right; white-space:nowrap; display:none;' id='txtActivityMistakeIDs" + i + "'>" + data.ActivityDetail[i].mistake_id + "</td>";
                            
                            tbl += "<td style='text-align:left; white-space:nowrap;' id='txtActivityMistakeName" + i + "'>" + data.ActivityDetail[i].mistake_description + "</td>";
                            
                            tbl += "<td style='text-align:left; white-space:nowrap;' id='txtCreatedBy" + i + "'>" + data.ActivityDetail[i].created_by + "</td>";
                            tbl += "<td style='text-align:right; white-space:nowrap;' id='txtCreatedDate" + i + "'>" + data.ActivityDetail[i].created_date + " </td>";
                            tbl += "<td style='text-align:left; white-space:nowrap;' id='txtModBy" + i + "'>" + data.ActivityDetail[i].modified_by + " </td>";
                            tbl += "<td style='text-align:right; white-space:nowrap;' id='txtModDate" + i + "'>" + data.ActivityDetail[i].modified_date + " </td>";
                      tbl += "</tr>";
                }   
                tbl += "</tbody>";
                tbl += "</table>";
                $("#tbleActivityMistakeDetails").html(tbl);
                dataTable();
                return false; 
      }
      function onretrievegetActivity()
      {
        alert("Error In Loading Details!");
        return false;
      }
      function EditRecord(rowNo)
      {
          var ActivityMistakeTypeID = $("#txtActivityMistakeIDs"+rowNo).html().trim();
          $("input[id$='txtActivityMistakeIDs']").val(ActivityMistakeTypeID);

          var ActivityMistakeTypeName = $("#txtActivityMistakeName"+rowNo).html().trim();
          $("input[id$='txtActivityMistakeName']").val(ActivityMistakeTypeName);
          
          $("input[id$='btnUpdate']").show();
          $("input[id$='btnSave']").attr("disabled", true);
          return false;
      }
      function UpdateActivityMistake()
      {
        var ActivityMistakeTypeID = $("input[id$='txtActivityMistakeIDs']").val();

        var ActivityMistakeTypeName = $("input[id$='txtActivityMistakeName']").val();
        
          if(ActivityMistakeTypeName=="")
            {
                alert("Please Enter Activity Name!");
                return false;
        }
       
        $.ajax({
            type: "POST",
            contentType:"application/json; charset=utf-8",
             url: "Workshop_Activity_Mistake.aspx/UpdateActivityMistake",
            data: "{'ActivityMistakeTypeID':'"+ActivityMistakeTypeID+"','ActivityMistakeTypeName':'"+ActivityMistakeTypeName+"'}", 
            success:onsuccessUpdateActivityMistakes,
            error:onretrieveUpdateActivityMistakes 
        });
        return false; 
      }
      function onsuccessUpdateActivityMistakes()
      {
        alert("Record Updated Successfully!");

        ClearActivityMistake();
        getActivityMistakeType();
        return false;
      }
      function onretrieveUpdateActivityMistakes()
      {
        alert("Error In Updating Record!");
        return false;
      }
     
    
    
    
    </script>
</asp:Content>


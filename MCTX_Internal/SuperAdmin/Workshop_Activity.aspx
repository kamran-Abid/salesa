<%@ Page Title="" Language="C#" MasterPageFile="~/MCTX_Internal/SuperAdmin/MasterAdmin.master" AutoEventWireup="true" CodeFile="Workshop_Activity.aspx.cs" Inherits="MCTX_Internal_SuperAdmin_Workshop_Activity" %>

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
            <li style="text-align: left"><a href="#tabs-1">Add/Modify  Activites</a></li>
           
            
        </ul>
        <div id="tabs-1" style="width: 98%">
            <fieldset id="fldAddAdctivities" runat="server" style="width:92%; padding:2%">
                <legend>Add Activity</legend>
                <table width="100%" style="font-family: Calibri; font-size: 11pt;" >
                    <tr>
                        <td width="140px" align="left">
                            <asp:Label ID="lblActivityName" Text="Activity Name:" runat="server"></asp:Label>
                        </td>
                        <td   style="width: 300px;">
                            <asp:TextBox ID="txtActivityName" Width="95%"  runat="server" BackColor="White" ></asp:TextBox>
                        </td>
                          <td width="140px" align="left">
                            <asp:Label ID="Label1" Text="Select Activity:" runat="server"></asp:Label>
                        </td>
                        <td colspan="1" width="200px" align="left">
                            <asp:DropDownList ID="ddlActivityType" Width="95%" runat="server">
                        </asp:DropDownList>
                        </td>
                        <td  align="left">
                            <asp:TextBox ID="txtActivityIDs" Style="display: none;" runat="server"></asp:TextBox>
                        </td>
                        
                    </tr>
                    <tr>
                        <td colspan="5">
                            &nbsp;
                        </td>
                    </tr>
                    <tr>

                        <td colspan="3">
                            &nbsp;
                        </td>
                        <td colspan="2"  align="left">
                            <asp:Button ID="btnSave" Text="Add" Style="background-color: #273D5F; color: White;"
                                Width="75px" OnClientClick="return SaveActivity();" runat="server" />
                        
                            <asp:Button ID="btnClearActivity" Text="Clear" Style="background-color: #273D5F; color: White;"
                                Width="75px" OnClientClick="return ClearActivity();" runat="server" />
                        
                            <asp:Button ID="btnUpdate" Text="Update" Style="background-color: #273D5F; color: White;
                                display: none;" Width="75px" OnClientClick="return UpdateActivity();" runat="server" />
                        </td>
                    </tr>
                </table>
            </fieldset>

            <div id="divActivityDetail" style="overflow: auto;width:100%;" >
            <fieldset id="fldActivityDetail" runat="server" style="width:92%; padding:2%; height: 400px;">
                <legend>Activity Details</legend>
                <table id="tbleActivityDetails" class="dataTable">
                </table>
	</fieldset>
        </div>
        </div>
	
     
     
	
    </div>

    <script type="text/javascript" language="javascript">
    var oTable;
    $(document).ready(function () {
        getActivity();
        
    });
      function dataTable() {
        oTable= $("#tbleActivityDetails").dataTable({
            bPaginate: true,
            bJQueryUI: true,
            bSort: true,
            bInfo: true,
            bRetrieve: true,
            bDestroy: true,
            oLanguage: { "sSearch": "Filter: " }
            });
             $("#tbleActivityDetails_length").css("text-align", "left");
        $("#tbleActivityDetails_filter").css("text-align", "left");
    }

   
      function SaveActivity()
      {
          var ActivityName = $("input[id$='txtActivityName']").val().trim();
          var Activity_typeID = $("select[id$='ddlActivityType']").val().trim();
        if(ActivityName=="")
            {
                alert("Please Enter Activity Name!");
                return false;
        }
        if (Activity_typeID == "-- Select --") {
            alert("Please Select Activity!");
            return false;
        }
                $.ajax({
                type: "POST",
                contentType:"application/json; charset=utf-8",
                url: "Workshop_Activity.aspx/SaveActivity",
                data: "{'ActivityName':'" + ActivityName + "','Activity_typeID':'" + Activity_typeID + "'}",
                success:onsuccessSaveActivity,
                error:onretrieveSaveActivityError 
                });
        return false; 
      }
      function onsuccessSaveActivity()
      {
        alert("Data Successfully Saved!");
        $("input[id$='txtActivityName']").val("");
        getActivity();
        return false;
      }
      function onretrieveSaveActivityError()
      {
        alert("Error In Saving Data!");
        return false; 
      }
      function ClearActivity()
      {
        $("input[id$='txtActivityName']").val("");
          $("select[id$='ddlActivityType']").val("-- Select --");
        $("input[id$='btnUpdate']").hide();
        $("input[id$='btnSave']").attr("disabled", false);
        return false;
      }
      function getActivity()
      {
        $.ajax({
            type: "POST",
            contentType:"application/json; charset=utf-8",
            url: "Workshop_Activity.aspx/getActivityDetails",
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
                tbl += "<th style='text-align:left; white-space:nowrap; display:none;'>Project ID</th>";
                tbl += "<th style='white-space:nowrap; text-align:left;'>Activity Name</th>";
                tbl += "<th style='white-space:nowrap; text-align:left;'>Project Priority</th>";
                tbl += "<th style='white-space:nowrap; text-align:left;'>Created By</th>";
                tbl += "<th style='white-space:nowrap; text-align:left;'>Created Date</th>";
                tbl += "<th style='white-space:nowrap; text-align:left;'>Modified By</th>";
                tbl += "<th style='white-space:nowrap; text-align:left;'>Modified Date</th>";
                tbl += "</tr>";
                tbl += "</thead>";
                tbl += "<tbody>";
                for (var i = 0; i < data.ActivityDetail.length; i++) {                   
                               
                            tbl += "<td style='cursor:Pointer;' id='txtUpdate' align='center' onclick='return EditRecord("+i+");'><img src='image/Edit.png'></td>";
                            tbl += "<td style='text-align:right; white-space:nowrap; display:none;' id='txtActivityIDs" + i + "'>" + data.ActivityDetail[i].Activity_id + "</td>";
                            tbl += "<td style='text-align:right; white-space:nowrap; display:none;' id='txtProjActivity_typeID" + i + "'>" + data.ActivityDetail[i].Activity_type_id + "</td>";
                            tbl += "<td style='text-align:left; white-space:nowrap;' id='txtActivityName" + i + "'>" + data.ActivityDetail[i].Activity_description + "</td>";
                            tbl += "<td style='text-align:left; white-space:nowrap;' id='txtActivitytypeName" + i + "'>" + data.ActivityDetail[i].Activity_type_name + "</td>";
                            tbl += "<td style='text-align:left; white-space:nowrap;' id='txtCreatedBy" + i + "'>" + data.ActivityDetail[i].created_by + "</td>";
                            tbl += "<td style='text-align:right; white-space:nowrap;' id='txtCreatedDate" + i + "'>" + data.ActivityDetail[i].created_date + " </td>";
                            tbl += "<td style='text-align:left; white-space:nowrap;' id='txtModBy" + i + "'>" + data.ActivityDetail[i].modified_by + " </td>";
                            tbl += "<td style='text-align:right; white-space:nowrap;' id='txtModDate" + i + "'>" + data.ActivityDetail[i].modified_date + " </td>";
                      tbl += "</tr>";
                }   
                tbl += "</tbody>";
                tbl += "</table>";
                $("#tbleActivityDetails").html(tbl);
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
          var ActivityID = $("#txtActivityIDs"+rowNo).html().trim();
          $("input[id$='txtActivityIDs']").val(ActivityID);

          var ActivityName = $("#txtActivityName"+rowNo).html().trim();
          $("input[id$='txtActivityName']").val(ActivityName);

          var ProjActivity_typeID = $("#txtProjActivity_typeID" + rowNo).html().trim();
          $("select[id$='ddlActivityType']").val(ProjActivity_typeID);

          
          $("input[id$='btnUpdate']").show();
          $("input[id$='btnSave']").attr("disabled", true);
          return false;
      }
      function UpdateActivity()
      {
        var ActivityID = $("input[id$='txtActivityIDs']").val();

        var ActivityName = $("input[id$='txtActivityName']").val();
        var Activity_typeID = $("select[id$='ddlActivityType']").val().trim();
          if(ActivityName=="")
            {
                alert("Please Enter Activity Name!");
                return false;
        }
        if (Activity_typeID == "-- Select --") {
            alert("Please Select Activity!");
            return false;
        }
        $.ajax({
            type: "POST",
            contentType:"application/json; charset=utf-8",
             url: "Workshop_Activity.aspx/UpdateActivity",
            data: "{'ActivityID':'"+ActivityID+"','ActivityName':'"+ActivityName+"','Activity_typeID':'"+Activity_typeID+"'}", 
            success:onsuccessUpdateActivitys,
            error:onretrieveUpdateActivitys 
        });
        return false; 
      }
      function onsuccessUpdateActivitys()
      {
        alert("Record Updated Successfully!");

        ClearActivity();
        getActivity();
        return false;
      }
      function onretrieveUpdateActivitys()
      {
        alert("Error In Updating Record!");
        return false;
      }
     
    
    
    
    </script>
</asp:Content>


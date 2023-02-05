<%@ Page Title="" Language="C#" MasterPageFile="~/MCTX_Internal/SuperAdmin/MasterAdmin.master" AutoEventWireup="true" CodeFile="DailyTaskSheet_RelativeCost.aspx.cs" Inherits="MCTX_Internal_SuperAdmin_DailyTaskSheet_RelativeCost" %>

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
            <li style="text-align: left"><a href="#tabs-1">Add/Modify  Relative Cost</a></li>
           
            
        </ul>
        <div id="tabs-1" style="width: 98%">
            <fieldset id="fldAddITProj" runat="server" style="width:92%; padding:2%">
                <legend>Add Relative Cost</legend>
                <table width="100%" style="font-family: Calibri; font-size: 11pt;" >
                    <tr>
                        <td width="140px" align="left">
                            <asp:Label ID="Label1" Text="Select Employee:" runat="server"></asp:Label>
                        </td>
                        <td colspan="1" width="200px" align="left">
                            <asp:DropDownList ID="ddlEmployee" Width="95%" runat="server" onchange="getEmpSalaries();">
                        </asp:DropDownList>
                        </td>
                        <td width="140px" align="left">
                            <asp:Label ID="lblRelativeCost" Text="Relative Cost:" runat="server"></asp:Label>
                        </td>
                        <td   style="width: 200px;">
                            <asp:TextBox ID="txtRelativeCost" Width="95%"  runat="server" BackColor="White" ></asp:TextBox>
                        </td>
                           <td>
                                        Absolute Cost:
                                    </td>
                                    
                                    <td style="width: 200px;">
                                        <asp:TextBox ID="txtPerHorSalary" Width="95%"  runat="server"  disabled="true" ></asp:TextBox>
                                    </td>
                        <td  align="left">
                            <asp:TextBox ID="txtRelativeCostID" Style="display: none;" runat="server"></asp:TextBox>
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
                                Width="75px" OnClientClick="return SaveRelativeCost();" runat="server" />
                        
                            <asp:Button ID="btnClear" Text="Clear" Style="background-color: #273D5F; color: White;"
                                Width="75px" OnClientClick="return Clear();" runat="server" />
                        
                            <asp:Button ID="btnUpdate" Text="Update" Style="background-color: #273D5F; color: White;
                                display: none;" Width="75px" OnClientClick="return UpdateRelativeCost();" runat="server" />
                        </td>
                    </tr>
                </table>
            </fieldset>

            <div id="divRelativeCostDetails" style="overflow: auto;width:100%;" >
            <fieldset id="fldRelativeCostDetails" runat="server" style="width:92%; padding:2%; height: 400px;">
                <legend>Project Details</legend>
                <table id="tblRelativeCostDetails" class="dataTable">
                </table>
	</fieldset>
        </div>
        </div>
	
     
     
	
    </div>

    <script type="text/javascript" language="javascript">
    var oTable;
    $(document).ready(function () {
        getRelativeCost();
        
    });
      function dataTable() {
        oTable= $("#tblRelativeCostDetails").dataTable({
            bPaginate: true,
            bJQueryUI: true,
            bSort: true,
            bInfo: true,
            bRetrieve: true,
            bDestroy: true,
            oLanguage: { "sSearch": "Filter: " }
            });
             $("#tblRelativeCostDetails_length").css("text-align", "left");
        $("#tblRelativeCostDetails_filter").css("text-align", "left");
    }
      function getEmpSalaries() {

          var empID = $("select[id$='ddlEmployee']").val();
          $.ajax({
              type: "POST",
              contentType: "application/json; charset=utf-8",
              url: "DailyTaskSheet_RelativeCost.aspx/getEmpSalary",
              data: "{'empID':'" + empID + "'}",
              success: onsuccessgetEmpInfo,
              error: onerrorEmpInfo
          });
          return false;
      }
      function onsuccessgetEmpInfo(msg) {
          var data = msg.d;

                  
          $("input[id$='txtPerHorSalary']").val(data.empSalDetails[0].perHrSal);
      }

      function onerrorEmpInfo() {
          alert("Error In Loading Details!");
          return false;
      }
   
      function SaveRelativeCost()
      {
          var RelativeCost = $("input[id$='txtRelativeCost']").val().trim();
          var Emp_ID = $("select[id$='ddlEmployee']").val().trim();
          var AbsoluteCost = $("input[id$='txtPerHorSalary']").val().trim();
        if (Emp_ID == "0") {
            alert("Please Select Employee!");
            return false;
        }
        if (RelativeCost == "") {
            alert("Please Enter Relative Cost!");
            return false;
        }
                $.ajax({
                type: "POST",
                contentType:"application/json; charset=utf-8",
                url: "DailyTaskSheet_RelativeCost.aspx/SaveRelativeCost",
                data: "{'RelativeCost':'" + RelativeCost + "','Emp_ID':'" + Emp_ID + "','AbsoluteCost':'" + AbsoluteCost + "'}",
                success:onsuccessSaveRelativeCost,
                error:onretrieveSaveRelativeCostError 
                });
        return false; 
      }
      function onsuccessSaveRelativeCost()
      {
        alert("Data Successfully Saved!");
        $("input[id$='txtRelativeCost']").val("");
        getRelativeCost();
        return false;
      }
      function onretrieveSaveRelativeCostError()
      {
        alert("Error In Saving Data!");
        return false; 
      }
      function Clear()
      {
          $("input[id$='txtRelativeCost']").val("");
          $("input[id$='txtPerHorSalary']").val("");          
          $("select[id$='ddlEmployee']").val("0");
        $("input[id$='btnUpdate']").hide();
        $("input[id$='btnSave']").attr("disabled", false);
        return false;
      }
      function getRelativeCost()
      {
        $.ajax({
            type: "POST",
            contentType:"application/json; charset=utf-8",
            url: "DailyTaskSheet_RelativeCost.aspx/getRelativeCostDetails",
            data: "{}", 
            success:onsuccessgetRelativeCost,
            error:onretrievegetRelativeCost 
        });
        return false; 
      }
      function onsuccessgetRelativeCost(msg)
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
                tbl += "<th style='text-align:left; white-space:nowrap; display:none;'>Relative Cost ID</th>";
                tbl += "<th style='text-align:left; white-space:nowrap; display:none;'>Employee ID</th>";
                tbl += "<th style='white-space:nowrap; text-align:left;'>Employee Name</th>";
                tbl += "<th style='white-space:nowrap; text-align:left;'>Absolute Cost</th>";
                tbl += "<th style='white-space:nowrap; text-align:left;'>Relative Cost</th>";
                tbl += "<th style='white-space:nowrap; text-align:left;'>Created By</th>";
                tbl += "<th style='white-space:nowrap; text-align:left;'>Created Date</th>";
                tbl += "<th style='white-space:nowrap; text-align:left;'>Modified By</th>";
                tbl += "<th style='white-space:nowrap; text-align:left;'>Modified Date</th>";
                tbl += "</tr>";
                tbl += "</thead>";
                tbl += "<tbody>";
                for (var i = 0; i < data.RelativeCostDetails.length; i++) {                   
                               
                            tbl += "<td style='cursor:Pointer;' id='txtUpdate' align='center' onclick='return EditRecord("+i+");'><img src='image/Edit.png'></td>";                        
                            tbl += "<td style='text-align:right; white-space:nowrap; display:none;' id='txtRelativeCostID" + i + "'>" + data.RelativeCostDetails[i].Relative_Cost_ID + "</td>";
                            tbl += "<td style='text-align:right; white-space:nowrap; display:none;' id='txtEmp_ID" + i + "'>" + data.RelativeCostDetails[i].Emp_ID + "</td>";
                            tbl += "<td style='text-align:left; white-space:nowrap;' id='txtEmpName" + i + "'>" + data.RelativeCostDetails[i].E_Name + "</td>";
                            tbl += "<td style='text-align:left; white-space:nowrap;' id='txtAbsoluteCost" + i + "'>" + data.RelativeCostDetails[i].Absolute_Cost + "</td>";
                            tbl += "<td style='text-align:left; white-space:nowrap;' id='txtRelativeCost" + i + "'>" + data.RelativeCostDetails[i].Relative_Cost + "</td>";
                            tbl += "<td style='text-align:left; white-space:nowrap;' id='txtCreatedBy" + i + "'>" + data.RelativeCostDetails[i].created_by + "</td>";
                            tbl += "<td style='text-align:right; white-space:nowrap;' id='txtCreatedDate" + i + "'>" + data.RelativeCostDetails[i].created_date + " </td>";
                            tbl += "<td style='text-align:left; white-space:nowrap;' id='txtModBy" + i + "'>" + data.RelativeCostDetails[i].modified_by + " </td>";
                            tbl += "<td style='text-align:right; white-space:nowrap;' id='txtModDate" + i + "'>" + data.RelativeCostDetails[i].modified_date + " </td>";
                      tbl += "</tr>";
                }   
                tbl += "</tbody>";
                tbl += "</table>";
                $("#tblRelativeCostDetails").html(tbl);
                dataTable();
                return false; 
      }
      function onretrievegetRelativeCost()
      {
        alert("Error In Loading Details!");
        return false;
      }
      function EditRecord(rowNo)
      {
          var RelativeCostIDs = $("#txtRelativeCostID"+rowNo).html().trim();
          $("input[id$='txtRelativeCostID']").val(RelativeCostIDs);

          var RelativeCost = $("#txtRelativeCost"+rowNo).html().trim();
          $("input[id$='txtRelativeCost']").val(RelativeCost);

          var Emp_ID = $("#txtEmp_ID" + rowNo).html().trim();
          $("select[id$='ddlEmployee']").val(Emp_ID);

          
          $("input[id$='btnUpdate']").show();
          $("input[id$='btnSave']").attr("disabled", true);
          getEmpSalaries();
          return false;
      }
      function UpdateRelativeCost()
      {
        var RelativeCostIDs = $("input[id$='txtRelativeCostID']").val();

        var RelativeCost = $("input[id$='txtRelativeCost']").val();
        var Emp_ID = $("select[id$='ddlEmployee']").val().trim();
        
        if (Emp_ID == "0") {
            alert("Please Select Employee!");
            return false;
        }
        if (RelativeCost == "") {
            alert("Please Enter Relative Cost!");
            return false;
        }
        $.ajax({
            type: "POST",
            contentType:"application/json; charset=utf-8",
             url: "DailyTaskSheet_RelativeCost.aspx/UpdateProject",
            data: "{'RelativeCostIDs':'"+RelativeCostIDs+"','RelativeCost':'"+RelativeCost+"','Emp_ID':'"+Emp_ID+"'}", 
            success:onsuccessUpdateRelativeCosts,
            error:onretrieveUpdateRelativeCosts 
        });
        return false; 
      }
      function onsuccessUpdateRelativeCosts()
      {
        alert("Record Updated Successfully!");
        getRelativeCost();
        Clear();
        return false;
      }
      function onretrieveUpdateRelativeCosts()
      {
        alert("Error In Updating Record!");
        return false;
      }
     
    
    
    
    </script>
</asp:Content>


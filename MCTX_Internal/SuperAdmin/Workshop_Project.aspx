<%@ Page Title="" Language="C#" MasterPageFile="~/MCTX_Internal/SuperAdmin/MasterAdmin.master" AutoEventWireup="true" CodeFile="Workshop_Project.aspx.cs" Inherits="MCTX_Internal_SuperAdmin_Workshop_Project" %>

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
            <li style="text-align: left"><a href="#tabs-1">Add/Modify  Projects</a></li>
           
            
        </ul>
        <div id="tabs-1" style="width: 98%">
            <fieldset id="fldAddITProj" runat="server" style="width:92%; padding:2%">
                <legend>Add Projects</legend>
                <table width="100%" style="font-family: Calibri; font-size: 11pt;" >
                    <tr>
                        <td width="140px" align="left">
                            <asp:Label ID="lblProjName" Text="Project Name:" runat="server"></asp:Label>
                        </td>
                        <td   style="width: 300px;">
                            <asp:TextBox ID="txtProjName" Width="95%"  runat="server" BackColor="White" ></asp:TextBox>
                        </td>
                          <td width="140px" align="left">
                            <asp:Label ID="Label1" Text="Select Priority:" runat="server"></asp:Label>
                        </td>
                        <td colspan="1" width="200px" align="left">
                            <asp:DropDownList ID="ddlPriorty" Width="95%" runat="server">
                        </asp:DropDownList>
                        </td>
                        <td  align="left">
                            <asp:TextBox ID="txtProjID" Style="display: none;" runat="server"></asp:TextBox>
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
                                Width="75px" OnClientClick="return SaveProj();" runat="server" />
                        
                            <asp:Button ID="btnClear" Text="Clear" Style="background-color: #273D5F; color: White;"
                                Width="75px" OnClientClick="return Clear();" runat="server" />
                        
                            <asp:Button ID="btnUpdate" Text="Update" Style="background-color: #273D5F; color: White;
                                display: none;" Width="75px" OnClientClick="return updateProjoct();" runat="server" />
                        </td>
                    </tr>
                </table>
            </fieldset>

            <div id="divProjDetails" style="overflow: auto;width:100%;" >
            <fieldset id="fldProjDetails" runat="server" style="width:92%; padding:2%; height: 400px;">
                <legend>Project Details</legend>
                <table id="tblProjDetails" class="dataTable">
                </table>
	</fieldset>
        </div>
        </div>
	
     
     
	
    </div>

    <script type="text/javascript" language="javascript">
    var oTable;
    $(document).ready(function () {
        getProject();
        
    });
      function dataTable() {
        oTable= $("#tblProjDetails").dataTable({
            bPaginate: true,
            bJQueryUI: true,
            bSort: true,
            bInfo: true,
            bRetrieve: true,
            bDestroy: true,
            oLanguage: { "sSearch": "Filter: " }
            });
             $("#tblProjDetails_length").css("text-align", "left");
        $("#tblProjDetails_filter").css("text-align", "left");
    }

   
      function SaveProj()
      {
          var ProjName = $("input[id$='txtProjName']").val().trim();
          var priorityID = $("select[id$='ddlPriorty']").val().trim();
        if(ProjName=="")
            {
                alert("Please Enter Project Name!");
                return false;
        }
        if (priorityID == "-- Select --") {
            alert("Please Select Priority!");
            return false;
        }
                $.ajax({
                type: "POST",
                contentType:"application/json; charset=utf-8",
                url: "Workshop_Project.aspx/SaveProject",
                data: "{'ProjName':'" + ProjName + "','priorityID':'" + priorityID + "'}",
                success:onsuccessSaveProj,
                error:onretrieveSaveProjError 
                });
        return false; 
      }
      function onsuccessSaveProj()
      {
        alert("Data Successfully Saved!");
        $("input[id$='txtProjName']").val("");
        getProject();
        return false;
      }
      function onretrieveSaveProjError()
      {
        alert("Error In Saving Data!");
        return false; 
      }
      function Clear()
      {
        $("input[id$='txtProjName']").val("");
          $("select[id$='ddlPriorty']").val("-- Select --");
        $("input[id$='btnUpdate']").hide();
        $("input[id$='btnSave']").attr("disabled", false);
        return false;
      }
      function getProject()
      {
        $.ajax({
            type: "POST",
            contentType:"application/json; charset=utf-8",
            url: "Workshop_Project.aspx/getProjectDetails",
            data: "{}", 
            success:onsuccessgetProject,
            error:onretrievegetProject 
        });
        return false; 
      }
      function onsuccessgetProject(msg)
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
                tbl += "<th style='white-space:nowrap; text-align:left;'>Project Name</th>";
                tbl += "<th style='white-space:nowrap; text-align:left;'>Project Priority</th>";
                tbl += "<th style='white-space:nowrap; text-align:left;'>Created By</th>";
                tbl += "<th style='white-space:nowrap; text-align:left;'>Created Date</th>";
                tbl += "<th style='white-space:nowrap; text-align:left;'>Modified By</th>";
                tbl += "<th style='white-space:nowrap; text-align:left;'>Modified Date</th>";
                tbl += "</tr>";
                tbl += "</thead>";
                tbl += "<tbody>";
                for (var i = 0; i < data.ProjDetails.length; i++) {                   
                               
                            tbl += "<td style='cursor:Pointer;' id='txtUpdate' align='center' onclick='return EditRecord("+i+");'><img src='image/Edit.png'></td>";                        
                            tbl += "<td style='text-align:right; white-space:nowrap; display:none;' id='txtProjID" + i + "'>" + data.ProjDetails[i].Project_id + "</td>";
                            tbl += "<td style='text-align:right; white-space:nowrap; display:none;' id='txtProjPriorityID" + i + "'>" + data.ProjDetails[i].Priority_id + "</td>";
                            tbl += "<td style='text-align:left; white-space:nowrap;' id='txtProjName" + i + "'>" + data.ProjDetails[i].Project_Name + "</td>";
                            tbl += "<td style='text-align:left; white-space:nowrap;' id='txtProjName" + i + "'>" + data.ProjDetails[i].Priority_description + "</td>";
                            tbl += "<td style='text-align:left; white-space:nowrap;' id='txtCreatedBy" + i + "'>" + data.ProjDetails[i].created_by + "</td>";
                            tbl += "<td style='text-align:right; white-space:nowrap;' id='txtCreatedDate" + i + "'>" + data.ProjDetails[i].created_date + " </td>";
                            tbl += "<td style='text-align:left; white-space:nowrap;' id='txtModBy" + i + "'>" + data.ProjDetails[i].modified_by + " </td>";
                            tbl += "<td style='text-align:right; white-space:nowrap;' id='txtModDate" + i + "'>" + data.ProjDetails[i].modified_date + " </td>";
                      tbl += "</tr>";
                }   
                tbl += "</tbody>";
                tbl += "</table>";
                $("#tblProjDetails").html(tbl);
                dataTable();
                return false; 
      }
      function onretrievegetProject()
      {
        alert("Error In Loading Details!");
        return false;
      }
      function EditRecord(rowNo)
      {
          var ProjID = $("#txtProjID"+rowNo).html().trim();
          $("input[id$='txtProjID']").val(ProjID);

          var ProjName = $("#txtProjName"+rowNo).html().trim();
          $("input[id$='txtProjName']").val(ProjName);

          var ProjPriorityid = $("#txtProjPriorityID" + rowNo).html().trim();
          $("select[id$='ddlPriorty']").val(ProjPriorityid);

          
          $("input[id$='btnUpdate']").show();
          $("input[id$='btnSave']").attr("disabled", true);
          return false;
      }
      function updateProjoct()
      {
        var ProjID = $("input[id$='txtProjID']").val();

        var ProjName = $("input[id$='txtProjName']").val();
        var priorityID = $("select[id$='ddlPriorty']").val().trim();
          if(ProjName=="")
            {
                alert("Please Enter Project Name!");
                return false;
        }
        if (priorityID == "-- Select --") {
            alert("Please Select Priority!");
            return false;
        }
        $.ajax({
            type: "POST",
            contentType:"application/json; charset=utf-8",
             url: "Workshop_Project.aspx/UpdateProject",
            data: "{'ProjID':'"+ProjID+"','ProjName':'"+ProjName+"','priorityID':'"+priorityID+"'}", 
            success:onsuccessupdateProjocts,
            error:onretrieveupdateProjocts 
        });
        return false; 
      }
      function onsuccessupdateProjocts()
      {
        alert("Record Updated Successfully!");
        getProject();
        Clear();
        return false;
      }
      function onretrieveupdateProjocts()
      {
        alert("Error In Updating Record!");
        return false;
      }
     
    
    
    
    </script>
</asp:Content>


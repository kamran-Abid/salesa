<%@ Page Language="C#" MasterPageFile="~/MCTX_Internal/SuperAdmin/MasterAdmin.master"
    AutoEventWireup="true" CodeFile="frmAddITProjects.aspx.cs" Inherits="MCTX_Internal_SuperAdmin_frmAddITProjects"
    Title="Add/Modify IT Projects" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <script src="../../js/jquery.dataTables.min.js" type="text/javascript"></script>
    <script src="../../js/BlockUI.js" type="text/javascript"></script>
    <script src="../../js/FieldValidation.js" type="text/javascript"></script>

    <style type="text/css">
        .dataTable
        {
            font-family: Verdana, Arial, Helvetica, sans-serif;
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
    </style>
    <div id="tabs" style="width: 943px;">
        <ul>
            <li style="text-align: left"><a href="#tabs-1">Add/Modify IT Projects</a></li>
        </ul>
        <div id="AddITProj" style="width: 100%">
            <fieldset id="fldAddITProj" runat="server" style="width: 98%">
                <legend>Add IT Projects</legend>
                <table width="100%" style="font-family: Calibri; font-size: 12px;">
                    <tr>
                        <td width="140px" align="left">
                            <asp:Label ID="lblProjName" Text="Project Name:" runat="server"></asp:Label>
                        </td>
                        <td width="140px" align="left">
                            <asp:TextBox ID="txtProjName" Width="95%" runat="server"></asp:TextBox>
                        </td>
                        <td width="82px" align="left">
                            <asp:Button ID="btnSave" Text="Add" Style="background-color: #273D5F; color: White;"
                                Width="75px" OnClientClick="return SaveProj();" runat="server" />
                        </td>
                        <td width="82px" align="left">
                            <asp:Button ID="btnClear" Text="Clear" Style="background-color: #273D5F; color: White;"
                                Width="75px" OnClientClick="return Clear();" runat="server" />
                        </td>
                        <td width="82px" align="left">
                            <asp:Button ID="btnUpdate" Text="Update" Style="background-color: #273D5F; color: White;
                                display: none;" Width="75px" OnClientClick="return updateITProj();" runat="server" />
                        </td>
                        <td width="82px" align="left">
                            <asp:TextBox ID="txtProjID" Style="display: none;" runat="server"></asp:TextBox>
                        </td>
                        <td>
                        </td>
                    </tr>
                </table>
            </fieldset>
        </div>
	
        <div id="divITProjDetails" style="overflow: auto; width: 940px; height: 400px;" runat="server">
            <fieldset id="fldITProjDetails" runat="server" style="width: 98%">
                <legend>IT Project Details</legend>
                <table id="tblITProjDetails" class="dataTable">
                </table>
	</fieldset>
        </div>
	
    </div>

    <script type="text/javascript" language="javascript">
    var oTable;
    $(document).ready(function(){
            getITProj();
    });
      function dataTable() {
        oTable= $("#tblITProjDetails").dataTable({
                bPaginate: false,
                bJQueryUI: true,
                oLanguage:{"sSearch":"Filter: "}               
            });
      }
      function SaveProj()
      {
        var ProjName = $("input[id$='txtProjName']").val();
        if(ProjName=="")
            {
                alert("Please Enter Project Name!");
                return false;
            }
                $.ajax({
                type: "POST",
                contentType:"application/json; charset=utf-8",
                url: "frmAddITProjects.aspx/SaveITProject", 
                data: "{'ProjName':'"+ProjName+"'}", 
                success:onsuccessSaveProj,
                error:onretrieveSaveProjError 
                });
        return false; 
      }
      function onsuccessSaveProj()
      {
        alert("Data Successfully Saved!");
        $("input[id$='txtProjName']").val("");
        getITProj();
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
        $("input[id$='btnUpdate']").hide();
        $("input[id$='btnSave']").attr("disabled", false);
        return false;
      }
      function getITProj()
      {
        $.ajax({
            type: "POST",
            contentType:"application/json; charset=utf-8",
            url: "frmAddITProjects.aspx/GetITProjDetails", 
            data: "{}", 
            success:onsuccessgetITProj,
            error:onretrievegetITProj 
        });
        return false; 
      }
      function onsuccessgetITProj(msg)
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
                tbl += "<th style='text-align:center; white-space:nowrap;'>Del</th>";
                tbl += "<th style='text-align:center; white-space:nowrap;'>Edit</th>";
                tbl += "<th style='text-align:left; white-space:nowrap; display:none;'>Project ID</th>";
                tbl += "<th style='white-space:nowrap; text-align:left;'>Project Name</th>";
                tbl += "<th style='white-space:nowrap; text-align:left;'>Created By</th>";
                tbl += "<th style='white-space:nowrap; text-align:left;'>Created Date</th>";
                tbl += "<th style='white-space:nowrap; text-align:left;'>Modified By</th>";
                tbl += "<th style='white-space:nowrap; text-align:left;'>Modified Date</th>";
                tbl += "</tr>";
                tbl += "</thead>";
                tbl += "<tbody>";
                for (var i = 0; i < data.ITProjDetails.length; i++) {                   
                            tbl += "<td style='cursor:Pointer;' id='txtdelete' align='center' onclick='return DeleteRecord("+i+");'><img src='image/Cross.png'> </td>";    
                            tbl += "<td style='cursor:Pointer;' id='txtUpdate' align='center' onclick='return EditRecord("+i+");'><img src='image/Edit.png'></td>";                        
                            tbl += "<td style='text-align:right; white-space:nowrap; display:none;' id='txtProjID"+i+"'>" + data.ITProjDetails[i].Proj_IT_ID + "</td>";
                            tbl += "<td style='text-align:left; white-space:nowrap;' id='txtProjName"+i+"'>" + data.ITProjDetails[i].Proj_Name + "</td>"; 
                            tbl += "<td style='text-align:left; white-space:nowrap;' id='txtCreatedBy"+i+"'>" + data.ITProjDetails[i].CreatedBy + "</td>";                    
                            tbl += "<td style='text-align:right; white-space:nowrap;' id='txtCreatedDate"+i+"'>" + data.ITProjDetails[i].CreatedDate + " </td>";
                            tbl += "<td style='text-align:left; white-space:nowrap;' id='txtModBy"+i+"'>" + data.ITProjDetails[i].ModifiedBy + " </td>";
                            tbl += "<td style='text-align:right; white-space:nowrap;' id='txtModDate"+i+"'>" + data.ITProjDetails[i].ModifiedDate + " </td>";
                      tbl += "</tr>";
                }   
                tbl += "</tbody>";
                tbl += "</table>";
                $("#tblITProjDetails").html(tbl);
                dataTable();
                return false; 
      }
      function onretrievegetITProj()
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
          $("input[id$='btnUpdate']").show();
          $("input[id$='btnSave']").attr("disabled", true);
          return false;
      }
      function updateITProj()
      {
        var ProjID = $("input[id$='txtProjID']").val();
        var ProjName = $("input[id$='txtProjName']").val();
        $.ajax({
            type: "POST",
            contentType:"application/json; charset=utf-8",
            url: "frmAddITProjects.aspx/UpdateITProjs", 
            data: "{'ProjID':'"+ProjID+"','ProjName':'"+ProjName+"'}", 
            success:onsuccessUpdateITProjs,
            error:onretrieveUpdateITProjs 
        });
        return false; 
      }
      function onsuccessUpdateITProjs()
      {
        alert("Record Updated Successfully!");
        getITProj();
        Clear();
        return false;
      }
      function onretrieveUpdateITProjs()
      {
        alert("Error In Updating Record!");
        return false;
      }
      function DeleteRecord(rowNo)
      {
          var ProjID = $("#txtProjID"+rowNo).html().trim();
          $.ajax({
            type: "POST",
            contentType:"application/json; charset=utf-8",
            url: "frmAddITProjects.aspx/DeleteITProjs", 
            data: "{'ProjID':'"+ProjID+"'}", 
            success:onsuccessDeleteRecord,
            error:onretrieveDeleteRecord 
        });
        return false;
      }
      function onsuccessDeleteRecord()
      {
        alert("Record Deleted Successfully!");
        getITProj();
        return false;
      }
      function onretrieveDeleteRecord()
      {
        alert("Error In Deleting Record!");
        return false;
      }
    
    </script>

</asp:Content>

<%@ Page Language="C#" MasterPageFile="~/MCTX_Internal/SuperAdmin/MasterAdmin.master"
    AutoEventWireup="true" CodeFile="frmDepartInfo.aspx.cs" Inherits="MCTX_Internal_SuperAdmin_frmDepartInfo"
    Title="Department Info" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <script src="../../js/jquery.dataTables.min.js" type="text/javascript"></script>

    <script src="../../js/BlockUI.js" type="text/javascript"></script>

    <script src="../../js/jquery.fixedheader.js" type="text/javascript"></script>

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
    </style>
    <div id="tabs" style="width: 949px;">
        <ul>
            <li style="text-align: left"><a href="#tabs-1">Department Information</a></li>
        </ul>
        <fieldset style="width: 95%">
            <legend>Add Department Details</legend>
            <table style="width: 100%; font-family: Calibri; font-size: 11pt;">
                <tr>
                    <td align="left" style="width: 140px;">
                        <asp:Label ID="lblBranch" Text="Select Branch:" runat="server"></asp:Label>
                    </td>
                    <td align="left" style="width: 140px;">
                        <asp:DropDownList ID="ddlBranch" Width="95%" runat="server">
                        </asp:DropDownList>
                    </td>
                    <td align="left" style="width: 160px;">
                        <asp:Label ID="lblDepartment" Text="Department Name:" runat="server"></asp:Label>
                    </td>
                    <td align="left" style="width: 140px;">
                        <asp:TextBox ID="txtDepartment" Width="95%" onkeypress="return keyRestrict(event,'abcdefghijklmnopqrstuvwxyz&- ')"
                            runat="server"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td align="left" style="width: 140px;">
                        <asp:Label ID="lblPhn1" Text="Phone Number:" runat="server"></asp:Label>
                    </td>
                    <td align="left" style="width: 140px;">
                        <asp:TextBox ID="txtPhn1" Width="95%" onkeypress="return keyRestrict(event,'+0123456789')"
                            runat="server"></asp:TextBox>
                    </td>
                    <td align="left" style="width: 160px;">
                        <asp:Label ID="lblPhn2" Text="Alternate Phone Number:" runat="server"></asp:Label>
                    </td>
                    <td align="left" style="width: 140px;">
                        <asp:TextBox ID="txtPhn2" Width="95%" onkeypress="return keyRestrict(event,'+0123456789')"
                            runat="server"></asp:TextBox>
                    </td>
                    <td>
                    </td>
                </tr>
                <tr>
                    <td align="left" style="width: 140px;">
                        <asp:Label ID="lblAddress" Text="Address:" runat="server"></asp:Label>
                    </td>
                    <td align="left" style="width: 140px;" colspan="3">
                        <asp:TextBox ID="txtAddress" TextMode="MultiLine" Width="98%" MaxLength="300" onkeypress="return keyRestrict(event,'0123456789abcdefghijklmnopqrstuvwxyz&-#,. ')"
                            Style="resize: none;" runat="server"></asp:TextBox>
                    </td>
                    <td>
                    </td>
                </tr>
                <tr>
                    <td align="left" style="width: 140px;">
                    </td>
                    <td align="right" style="width: 300px;" colspan="2">
                        <asp:Button ID="btnSave" Text="Save" Style="background-color: #2A4062; color: White;
                            width: 60px" OnClientClick="return SaveDepartment();" runat="server" />
                        &nbsp;
                        <asp:Button ID="btnClear" Text="Clear" Style="background-color: #2A4062; color: White;
                            width: 60px" OnClientClick="return ClearFields();" runat="server" />&nbsp;
                        <asp:Button ID="btnUpdate" Text="Update" Style="background-color: #2A4062; color: White;
                            display: none; width: 60px" OnClientClick="return UpdateDeparts();" runat="server" />
                    </td>
                    <td align="left" style="width: 140px;">
                    </td>
                    <td>
                        <asp:TextBox ID="txtDeptID" Style="display: none; width: 95%;" runat="server"></asp:TextBox>
                    </td>
                </tr>
            </table>
        </fieldset>
        <br />
        <fieldset style="width: 95%;">
            <legend>Department Details</legend>
            <div style="overflow: auto; width: 912px; height: 300px;" runat="server">
                <table id="tblDepartInfo" class="dataTable">
                </table>
            </div>
        </fieldset>
    </div>

    <script type="text/javascript" language="javascript">
    var oTable;
    $(document).ready(function()
    {
       GetDepart();
    });
    
    function dataTable() {
        oTable= $("#tblDepartInfo").dataTable({
                bPaginate: false,
                bDestroy: true,
                bJQueryUI: true,
                oLanguage:{"sSearch":"Filter: "}               
            }).fixedHeader({ height: 300});
      }
      
    function SaveDepartment()
    {
        var BranchID = $("select[id$='ddlBranch']").val();
        if (BranchID == "")
        {
            alert("Please Select Appropriate Branch!");
            return false;
        }
        var DeptName = $("input[id$='txtDepartment']").val();
        if (DeptName == "")
        {
            alert("Please Enter Department Name!");
            return false;
        }
        var Phn1 =  $("input[id$='txtPhn1']").val();
        var Phn2 =  $("input[id$='txtPhn2']").val();
        if (Phn1 == "" && Phn2 == "")
        {
            alert("Please Enter Phone Number!");
            return false;
        }
        var Address = $("textarea[id$='txtAddress']").val();
        if (Address == "")
        {
            alert("Please Enter Address!");
            return false;
        }
        $.ajax({
        type: "POST",
        contentType:"application/json; charset=utf-8",
        url: "frmDepartInfo.aspx/SaveDepart", 
        data: "{'BranchID':'"+BranchID+"','DeptName':'"+DeptName+"','Phn1':'"+Phn1+"','Phn2':'"+Phn2+"','Address':'"+Address+"'}", 
        success:onsuccessSaveDept,
        error:onErrorSaveDept 
        });
    return false;
    }
    
    function onsuccessSaveDept()
    {
        alert("Record Saved Successfully!");
        GetDepart();
        ClearFields();
        return false;
    }
    
    function onErrorSaveDept()
    {
        alert("Error In Saving Record!");
        return false;
    }
    
    function ClearFields()
    {
        $("select[id$='ddlBranch']").val("");
        $("input[id$='txtDepartment']").val("");
        $("input[id$='txtPhn1']").val("");
        $("input[id$='txtPhn2']").val("");
        $("textarea[id$='txtAddress']").val("");
        $("input[id$='btnUpdate']").hide();
        $("input[id$='btnSave']").attr("disabled", false);
        return false;
    }
    
    function GetDepart()
    {
       $.ajax({
        type: "POST",
        contentType:"application/json; charset=utf-8",
        url: "frmDepartInfo.aspx/GetDepart", 
        data: "{}", 
        success:onsuccessGetDept,
        error:onErrorGetDept 
        });
    return false; 
    }
    
    function onsuccessGetDept(msg)
    {
        var data = msg.d;
        if(oTable != null)
        {
            oTable.fnClearTable();
            oTable.fnDestroy();
        } 
        var tbl = "";  
        tbl += "<thead>";
                tbl += "<tr>";
                tbl += "<th id='txtDeleteth' style='cursor:Pointer;text-align:center;white-space:nowrap;border:1px solid #999999;'>Del</th>";
                tbl += "<th id='txtEditth' style='cursor:Pointer;text-align:center;white-space:nowrap;border:1px solid #999999;'>Edit</th>";
                tbl += "<th style='white-space:nowrap; text-align:left; display:none;'>Dept ID</th>";
                tbl += "<th style='white-space:nowrap; text-align:left;'>Department Name</th>";
                tbl += "<th style='white-space:nowrap; text-align:left;'>Branch</th>";
                tbl += "<th style='white-space:nowrap; text-align:left; display:none;'>Branch ID</th>";
                tbl += "<th style='white-space:nowrap; text-align:left;'>Phone</th>";
                tbl += "<th style='white-space:nowrap; text-align:left;'>Alt Phone</th>";
                tbl += "<th style='white-space:nowrap; text-align:left;'>Address</th>";
                tbl += "</tr>";
                tbl += "</thead>";
                tbl += "<tbody>";
                for (var i = 0; i < data.DepartDetails.length; i++) {               
                            tbl += "<td id='txtDelete"+i+"' align='center' style='border:1px solid #999999;'> <input  type='image' src='image/Cross.png' style='width:16px; border:0px;' onclick='return Delete("+i+");'></td>";
                            tbl += "<td id='txtEdit"+i+"' align='center' style='border:1px solid #999999;'> <input  type='image' src='image/Edit.png' style='width:16px; border:0px;' onclick='return GetRowForUpdation("+i+");'></td>";
                            tbl += "<td style='text-align:right; white-space:nowrap; display:none;' id='txtDID"+i+"'>" + data.DepartDetails[i].D_ID + "</td>";
                            tbl += "<td style='text-align:left; white-space:nowrap;' id='txtDName"+i+"'>" + data.DepartDetails[i].D_NAME + "</td>";   
                            tbl += "<td style='text-align:left; white-space:nowrap;' id='txtBranchName"+i+"'>" + data.DepartDetails[i].BRANCHNAME + "</td>";                  
                            tbl += "<td style='text-align:right; white-space:nowrap; display:none;' id='txtBranchID"+i+"'>" + data.DepartDetails[i].BRID + "</td>"; 
                            tbl += "<td style='text-align:right; white-space:nowrap;' id='txtPhn"+i+"'>" + data.DepartDetails[i].D_Phone+ " </td>";
                            tbl += "<td style='text-align:right; white-space:nowrap;' id='txtAltPhn"+i+"'>" +  data.DepartDetails[i].D_phone2 + " </td>";
                            tbl += "<td style='text-align:left; white-space:nowrap;' id='txtAddress"+i+"'>" + data.DepartDetails[i].D_Address + " </td>";
                            
                      tbl += "</tr>";
                }   
                tbl += "</tbody>";
                tbl += "</table>";
                $("#tblDepartInfo").html(tbl);
                dataTable();
                return false;         
    }
    
    function onErrorGetDept()
    {
        alert("Error In Loading Details!");
        return false;
    }
    
    function GetRowForUpdation(rowNo)
    {
        var DeptID = $("#txtDID"+rowNo).html().trim();
        $("input[id$='txtDeptID']").val(DeptID);
        var BranchID = $("#txtBranchID"+rowNo).html().trim();
        $("select[id$='ddlBranch']").val(BranchID);
        var DeptName = $("#txtDName"+rowNo).html().trim();
        $("input[id$='txtDepartment']").val(DeptName);
        var Phn1 = $("#txtPhn"+rowNo).html().trim();
        $("input[id$='txtPhn1']").val(Phn1);
        var AltPhn = $("#txtAltPhn"+rowNo).html().trim();
        $("input[id$='txtPhn2']").val(AltPhn);
        var Add = $("#txtAddress"+rowNo).html().trim();
        $("textarea[id$='txtAddress']").val(Add);
        $("input[id$='btnUpdate']").show();
        $("input[id$='btnSave']").attr("disabled", true);
        return false;
    }
    
    function UpdateDeparts()
    {
        var DeptID = $("input[id$='txtDeptID']").val(DeptID);
        var BranchID = $("select[id$='ddlBranch']").val();
        if (BranchID == "")
        {
            alert("Please Select Appropriate Branch!");
            return false;
        }
        var DeptName = $("input[id$='txtDepartment']").val();
        if (DeptName == "")
        {
            alert("Please Enter Department Name!");
            return false;
        }
        var Phn1 =  $("input[id$='txtPhn1']").val();
        var Phn2 =  $("input[id$='txtPhn2']").val();
        if (Phn1 == "" && Phn2 == "")
        {
            alert("Please Enter Phone Number!");
            return false;
        }
        var Address = $("textarea[id$='txtAddress']").val();
        if (Address == "")
        {
            alert("Please Enter Address!");
            return false;
        }
        $.ajax({
        type: "POST",
        contentType:"application/json; charset=utf-8",
        url: "frmDepartInfo.aspx/UpdateDepart", 
        data: "{'DeptID':'"+DeptID+"','BranchID':'"+BranchID+"','DeptName':'"+DeptName+"','Phn1':'"+Phn1+"','Phn2':'"+Phn2+"','Address':'"+Address+"'}", 
        success:onsuccessUpdateDept,
        error:onErrorUpdateDept 
        });
    return false; 
    }
    
    function onsuccessUpdateDept()
    {
        alert("Record Updated Successfully!");
        ClearFields();
        GetDepart();
        return false;
    }
    
    function onErrorUpdateDept()
    {
        alert("Error In Updating Record!");
        return false; 
    }
    
    function Delete(rowNo)
    {
        var ID = $("#txtDID"+rowNo).html().trim();
        if (confirm("Are you sure you wish to delete this Record?"))
        {
            $.ajax({
            type: "POST",
            contentType:"application/json; charset=utf-8",
            url: "frmDepartInfo.aspx/DelDept", 
            data: "{'ID':'"+ID+"'}", 
            success:onsuccessDelDept,
            error:onErrorDelDept
            });
        }
        else
        {
          return false;
        }
    return false;  
    }
    
    function onsuccessDelDept()
    {
        alert("Record Successfully Deleted!");
        GetDepart();
        ClearFields();
        return false;
    }
    
    function onErrorDelDept()
    {
        alert("Error In Deleting Record!");
        return false;
    }
    
     function keyRestrict(e, validchars, casesensitives, onceevery, onceoneof)
     {

        onceevery = onceevery ? onceevery : "";
        onceoneof = onceoneof ? onceoneof : "";
        
        if (!validchars)
        return true;
        var key='', keychar='', obj='', i = 0;
        var key = e.which ? e.which : window.event.keyCode;
        var obj = e.target ? e.target : window.event.srcElement;
        if (key == null)
         return true;
        keychar = String.fromCharCode(key);
        validchars = (validchars + onceevery + onceoneof);
        if (!casesensitives) 
        {
        keychar = keychar.toLowerCase();
        validchars = validchars.toLowerCase();
        onceevery =onceevery.toLowerCase();
        onceoneof = onceoneof.toLowerCase();
        }
        for (i=0; i<(onceevery + onceoneof).length; i++) 
        {
            if (i < onceevery.length) 
            {
            if (obj.value.indexOf(onceevery.charAt(i)) != -1 && keychar == onceevery.charAt(i))
            return false;
            }
            else 
            {
             if (obj.value.indexOf(onceoneof.charAt(i-onceevery.length)) != -1 && onceoneof.indexOf(keychar) != -1)
             return false;
            }
        }
     
        if (validchars.indexOf(keychar) != -1)
        return true;
        
        if ( key==null || key==0 || key==8 || key==9 || key==13 || key==27 )
        return true;
        return false;
    }
    </script>

</asp:Content>

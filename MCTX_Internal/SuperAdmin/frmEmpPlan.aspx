<%@ Page Language="C#" MasterPageFile="~/MCTX_Internal/SuperAdmin/MasterAdmin.master"
    AutoEventWireup="true" CodeFile="frmEmpPlan.aspx.cs" Inherits="frmEmpPlan" Title="Employee Plan Days" %>

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
            <li style="text-align: left"><a href="#tabs-1">Employee Planned Days</a></li>
        </ul>
        <fieldset style="width: 95%">
            <legend style="text-align: left;">Add Information</legend>
            <table style="width: 100%; font-family: Calibri; font-size: 11pt;">
                <tr>
                    <td align="left" style="width: 140px;">
                        <asp:Label ID="lblEmployee" Text="Select Employee:" runat="server"></asp:Label>
                    </td>
                    <td align="left" style="width: 140px;">
                        <asp:DropDownList ID="ddlEmployee" Width="95%" runat="server">
                        </asp:DropDownList>
                    </td>
                    <td align="left" style="width: 140px;">
                        <asp:Label ID="lblPlanDays" Text="Planned Day(s):" runat="server"></asp:Label>
                    </td>
                    <td align="left" style="width: 140px;">
                        <asp:TextBox ID="txtPlanDays" Width="95%" MaxLength="2" onkeypress="return keyRestrict(event,'0123456789')"
                            runat="server"></asp:TextBox>
                    </td>
                    <td align="left" style="width: 155px;">
                        <asp:Button ID="btnSave" Text="Save" Style="background-color: #2A4062; color: White;
                            width: 75px;" OnClientClick="return SavePlanDays();" runat="server" />
                        <asp:Button ID="btnClear" Text="Clear" Style="background-color: #2A4062; color: White;
                            width: 75px;" OnClientClick="return ClearFields();" runat="server" />
                    </td>
                    <td>
                    </td>
                </tr>
            </table>
        </fieldset>
        <fieldset style="width: 95%;">
            <legend>Details</legend>
            <table id="tblDetails" class="dataTable">
            </table>
        </fieldset>
    </div>

    <script type="text/javascript" language="javascript">
    var oTable;
    $(document).ajaxStart(blockUI).ajaxStop(unblockUI);

    function blockUI() {
            $.blockUI({ message: '<img src="image/ajax-loader.gif" />',
                css: { borderStyle: 'none', backgroundColor: "Transparent" }
            });
        }

    function unblockUI() {
            $.unblockUI();
        }
    $(document).ready(function(){
        GetDetails();
    });
    
    function dataTable() {
        oTable= $("#tblDetails").dataTable({
                bPaginate: false,
                bJQueryUI: true,
                bSort: true,
                bInfo: false,
                bRetrieve: true,
                bDestroy: true,
                oLanguage:{"sSearch":"Filter: "}               
            });
    }
    
    function SavePlanDays()
    {
        var User = $("select[id$='ddlEmployee']").val();
        if (User == "")
        {
            alert("Please Select Desired Employee!");
            return false;
        } 
        var PlanDays = $("input[id$='txtPlanDays']").val();
        if (PlanDays == "")
        {
            alert("Please Add Days!");
            return false;
        }
        $.ajax({
                type: "POST",
                contentType:"application/json; charset=utf-8",
                url: "frmEmpPlan.aspx/SavePlanDays", 
                data: "{'User':'"+User+"','PlanDays':'"+PlanDays+"'}", 
                success:onsuccessSave,
                error:onretrieveSaveError 
                });
        return false;
    }
    
    function onsuccessSave()
    {
        alert("Data Successfully Saved!");
        GetDetails();
        ClearFields();
        return false;
    }
    
    function onretrieveSaveError()
    {
        alert("Error In Saving Data!");
        return false;
    }
    
    function ClearFields()
    {
        $("select[id$='ddlEmployee']").val('');
        $("input[id$='txtPlanDays']").val('');
        return false;
    }
    
    function GetDetails()
    {
                $.ajax({
                type: "POST",
                contentType:"application/json; charset=utf-8",
                url: "frmEmpPlan.aspx/GetPlanDays", 
                data: "{}", 
                success:onsuccessGetDetails,
                error:onErrorGetDetails
                });
        return false;
    }
    
    function onsuccessGetDetails(msg)
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
                tbl += "<th id='txtDeleteth' style='cursor:Pointer;text-align:center;white-space:nowrap;border:1px solid #999999;'>Delete</th>";
                tbl += "<th style='white-space:nowrap; text-align:left; display:none;'>ID</th>";
                tbl += "<th style='white-space:nowrap; text-align:left;  display:none;'>User ID</th>";
                tbl += "<th style='white-space:nowrap; text-align:left;'>Emp Name</th>";
                tbl += "<th style='white-space:nowrap; text-align:left;'>Plan Days</th>";
                tbl += "<th style='white-space:nowrap; text-align:left;'>Created By</th>";
                tbl += "<th style='white-space:nowrap; text-align:left;  display:none;'>C By</th>";
                tbl += "<th style='white-space:nowrap; text-align:left;'>Created Date</th>";
                tbl += "<th style='white-space:nowrap; text-align:left;'>Modified By</th>";
                 tbl += "<th style='white-space:nowrap; text-align:left;  display:none;'>M By</th>";
                tbl += "<th style='white-space:nowrap; text-align:left;'>Modified Date</th>";
                tbl += "</tr>";
                tbl += "</thead>";
                tbl += "<tbody>";
                for (var i = 0; i < data.Details.length; i++) {               
                            tbl += "<td id='txtDelete"+i+"' align='center' style='border:1px solid #999999; text-align:center;'> <input  type='image' src='image/Cross.png' style='width:16px; border:0px;' onclick='return Delete("+i+");'></td>";
                            tbl += "<td style='text-align:left; white-space:nowrap;  display:none;' id='txtPlanDayID"+i+"'>" + data.Details[i].PlanDay_ID + "</td>";   
                            tbl += "<td style='text-align:left; white-space:nowrap;  display:none;' id='txtUserID"+i+"'>" + data.Details[i].UserID + "</td>";                  
                            tbl += "<td style='text-align:left; white-space:nowrap;' id='txtEName"+i+"'>" + data.Details[i].E_Name + " </td>";
                            tbl += "<td style='text-align:right; white-space:nowrap;' id='txtPlanDays"+i+"'>" + data.Details[i].PlanDays + " </td>";
                            tbl += "<td style='text-align:left; white-space:nowrap;' id='txtCreatedBy"+i+"'>" +  data.Details[i].CreatedBy + " </td>";
                            tbl += "<td style='text-align:left; white-space:nowrap;  display:none;' id='txtCreatedBy"+i+"'>" +  data.Details[i].CBy + " </td>";
                            tbl += "<td style='text-align:right; white-space:nowrap;' id='txtCreatedDate"+i+"'>" +  data.Details[i].CreatedDate + " </td>";
                            tbl += "<td style='text-align:left; white-space:nowrap;' id='txtModifiedBy"+i+"'>" +  data.Details[i].ModifiedBy + " </td>";
                            tbl += "<td style='text-align:left; white-space:nowrap;  display:none;' id='txtModifiedBy"+i+"'>" +  data.Details[i].ModBy + " </td>";
                            tbl += "<td style='text-align:right; white-space:nowrap;' id='txtModifiedDate"+i+"'>" +  data.Details[i].ModifiedDate + " </td>";
                            tbl += "</tr>";
                }   

                tbl += "</tbody>";
                tbl += "</table>";
                $("#tblDetails").html(tbl);
                dataTable();
                return false; 
    } 
    
    function onErrorGetDetails()
    {
        alert("Error In Loading Details!");
        return false;
    }
    
    function Delete(rowNo)
    {
        var ID = $("#txtPlanDayID"+rowNo).html().trim();
        if (confirm("Are you sure you wish to delete this Record?"))
        {
                    $.ajax({
                    type: "POST",
                    contentType:"application/json; charset=utf-8",
                    url: "frmEmpPlan.aspx/Delete", 
                    data: "{'ID':'"+ID+"'}", 
                    success:onsuccessDelete,
                    error:onErrorDelete
                    });
            return false;
        }
        else
        {
            return false;
        }
    }
    
    function onsuccessDelete()
    {
        alert("Record Deleted Successfully!");
        GetDetails();
        ClearFields();
        return false;
    } 
    
    function onErrorDelete()
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

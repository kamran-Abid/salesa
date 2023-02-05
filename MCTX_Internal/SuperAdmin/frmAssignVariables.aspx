<%@ Page Language="C#" MasterPageFile="~/MCTX_Internal/SuperAdmin/MasterAdmin.master"
    AutoEventWireup="true" CodeFile="frmAssignVariables.aspx.cs" Inherits="MCTX_Internal_SuperAdmin_frmAssignVariables"
    Title="Assign Variables" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <script src="../../js/jquery.dataTables.min.js" type="text/javascript"></script>

    <script src="../../js/BlockUI.js" type="text/javascript"></script>

    <script src="../../js/FieldValidation.js" type="text/javascript"></script>

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
            <li style="text-align: left"><a href="#tabs-1">Assign & View User Variables</a></li>
        </ul>
        <fieldset style="width: 95%">
            <legend>Assign Variable</legend>
            <table style="width: 100%; font-family: Calibri; font-size: 11pt;">
                <tr>
                    <td align="left" style="width: 170px;">
                        <asp:Label ID="lblEmployee" Text="Employee Name:" runat="server"></asp:Label>
                    </td>
                    <td align="left" style="width: 140px;">
                        <asp:DropDownList ID="ddlEmployee" Width="95%" runat="server">
                        </asp:DropDownList>
                    </td>
                    <td>
                    </td>
                </tr>
                <tr>
                    <td align="left" style="width: 170px;">
                        <asp:Label ID="lblVariable" Text="Select Variable:" runat="server"></asp:Label>
                    </td>
                    <td align="left" style="width: 140px;">
                        <asp:DropDownList ID="ddlVariable" Width="95%" runat="server">
                        </asp:DropDownList>
                    </td>
                    <td>
                    </td>
                </tr>
                <tr>
                    <td align="left" style="width: 170px;">
                        <asp:Label ID="lblEvaluation" Text="Evaluation Criteria:" runat="server"></asp:Label>
                    </td>
                    <td align="left" style="width: 140px;">
                        <asp:DropDownList ID="ddlEvaluation" Width="95%" runat="server">
                        </asp:DropDownList>
                    </td>
                    <td>
                    </td>
                </tr>
                <tr>
                    <td align="left" style="width: 170px;">
                        <asp:Label ID="lblIOC" Text="Impact on Commission(%):" runat="server"></asp:Label>
                    </td>
                    <td align="left" style="width: 140px;">
                        <asp:TextBox ID="txtIOC" Width="95%" onkeypress="return keyRestrict(event,'0123456789')"
                            MaxLength="2" runat="server"></asp:TextBox>
                    </td>
                    <td>
                    </td>
                </tr>
                <tr>
                    <td align="left" style="width: 170px;">
                        <asp:Label ID="lblIOS" Text="Impact on Salary(%):" runat="server"></asp:Label>
                    </td>
                    <td align="left" style="width: 140px;">
                        <asp:TextBox ID="txtIOS" Width="95%" onkeypress="return keyRestrict(event,'0123456789')"
                            MaxLength="2" runat="server"></asp:TextBox>
                    </td>
                    <td>
                    </td>
                </tr>
                <tr>
                    <td align="left" colspan="2">
                        <asp:Button ID="btnAssign" Text="Assign" Width="75px" Style="background-color: #2A4062;
                            color: White;" OnClientClick="return AssignVariable();" runat="server" />
                        <asp:Button ID="btnClear" Text="Clear" Width="75px" Style="background-color: #2A4062;
                            color: White;" OnClientClick="return ClearFields();" runat="server" />
                        <asp:Button ID="btnUpdate" Text="Update" Width="75px" Style="background-color: #2A4062;
                            color: White; display: none;" OnClientClick="return UpdateAssignVar();" runat="server" />
                    </td>
                    <td align="left">
                        <asp:TextBox ID="txtVariableID" Style="display: none;" runat="server"></asp:TextBox>
                    </td>
                </tr>
            </table>
        </fieldset>
        <div style="overflow: auto; width: 96%; height: 300px;">
            <fieldset style="width: 99%">
                <legend>Assigned Variables</legend>
                <table id="tblDetails" style="width: 100%;" class="dataTable">
                </table>
            </fieldset>
        </div>
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
        GetAssignVar();
    });
    function dataTable() {
        oTable= $("#tblDetails").dataTable({
                bPaginate: false,
                bJQueryUI: true,
                bSort: true,
                bInfo: true,
                bRetrieve: true,
                bDestroy: true,
                oLanguage:{"sSearch":"Filter: "}               
            });
    }
    function AssignVariable()
    {
    var EmpID = $("select[id$='ddlEmployee'] option:selected").val();
    if(EmpID == "")
    {
        alert("Please Select Employee!");
        return false;
    }
    var VarID = $("select[id$='ddlVariable'] option:selected").val();
    if (VarID == "")
    {
        alert("Please Select Variable!");
        return false;
    }
    var Eval = $("select[id$='ddlEvaluation'] option:selected").text();
    var EvalID = $("select[id$='ddlEvaluation'] option:selected").val();
    if (Eval == "")
    {
        alert("Please Select Evaluation Criteria!");
        return false;
    }
    var IOC = $("input[id$='txtIOC']").val();
    if (IOC == "")
    {
        alert("Please Enter IOC(%)!");
        return false;
    }
    var IOS = $("input[id$='txtIOS']").val();
    if (IOS == "")
    {
        alert("Please Enter IOS(%)!");
        return false;
    }
        $.ajax({
        type: "POST",
        contentType:"application/json; charset=utf-8",
        url: "frmAssignVariables.aspx/AssignVar", 
        data: "{'EmpID':'"+EmpID+"','VarID':'"+VarID+"','Eval':'"+Eval+"','EvalID':'"+EvalID+"','IOC':'"+IOC+"','IOS':'"+IOS+"'}", 
        success:onsuccessAssignVar,
        error:onErrorAssignVar
        });
        return false;
    }
    function onsuccessAssignVar()
    {
        alert("Variable Assigned Successfully!");
        ClearFields();
        GetAssignVar();
        return false;
    }
    function onErrorAssignVar()
    {
        alert("Error In Assigning Variable!");
        return false;
    }
    function GetAssignVar()
    {
        $.ajax({
        type: "POST",
        contentType:"application/json; charset=utf-8",
        url: "frmAssignVariables.aspx/GetVar", 
        data: "{}", 
        success:onsuccessGetVar,
        error:onErrorGetVar
        });
        return false;  
    }
    function onsuccessGetVar(msg)
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
                 tbl += "<th id='txtDeleteth' style='cursor:Pointer;text-align:center;white-space:nowrap;border:1px solid #999999;'>Del</th>";
                tbl += "<th id='txtEditth' style='cursor:Pointer;text-align:center;white-space:nowrap;border:1px solid #999999;'>Edit</th>";
                tbl += "<th style='white-space:nowrap; text-align:left; display:none;'>ID</th>";
                tbl += "<th style='white-space:nowrap; text-align:left; display:none;'>User ID</th>";
                tbl += "<th style='white-space:nowrap; text-align:left;'>Employee Name</th>";
                tbl += "<th style='white-space:nowrap; text-align:left;'>Variable Name</th>";
                tbl += "<th style='white-space:nowrap; text-align:left;'>IOC (%)</th>";
                tbl += "<th style='white-space:nowrap; text-align:left;'>IOS (%)</th>";
                tbl += "<th style='white-space:nowrap; text-align:left; display:none;'>Var ID</th>";
                tbl += "<th style='white-space:nowrap; text-align:left;'>Evaluation Criteria</th>";
                tbl += "<th style='white-space:nowrap; text-align:left; display:none;'>Evaluation ID</th>";
                tbl += "</tr>";
                tbl += "</thead>";
                tbl += "<tbody>";
                for (var i = 0; i < data.Details.length; i++) {  
                            tbl += "<tr  id='rowmain"+i+"'>"; 
                            tbl += "<td id='txtDelete"+i+"' align='center' style='border:1px solid #999999;  text-align:center;'> <input  type='image' src='image/Cross.png' style='width:16px; border:0px;' onclick='return Delete("+i+");'></td>";
                            tbl += "<td id='txtEdit"+i+"' align='center' style='border:1px solid #999999;  text-align:center;'> <input  type='image' src='image/Edit.png' style='width:16px; border:0px;' onclick='return GetRowForUpdation("+i+");'></td>";            
                            tbl += "<td style='text-align:left; white-space:nowrap; display:none;' id='txtID"+i+"'>" + data.Details[i].ID + "</td>";
                            tbl += "<td style='text-align:left; white-space:nowrap; display:none;' id='txtUserID"+i+"'>" + data.Details[i].UserID + "</td>";   
                            tbl += "<td style='text-align:left; white-space:nowrap;' id='txtEmpName"+i+"'>" + data.Details[i].EmpName + "</td>";                  
                            tbl += "<td style='text-align:left; white-space:nowrap;' id='txtVarName"+i+"'>" + data.Details[i].VarName+ " </td>";
                            tbl += "<td style='text-align:right; white-space:nowrap;' id='txtCommission"+i+"'>" + data.Details[i].Commission + " </td>";
                            tbl += "<td style='text-align:right;' id='txtDeduct"+i+"'>" +  data.Details[i].Deduction + " </td>";
                            tbl += "<td style='text-align:right; display:none;' id='txtVarID"+i+"'>" +  data.Details[i].VarID + " </td>";  
                            tbl += "<td style='text-align:left; white-space:nowrap;' id='txtEval"+i+"'>" + data.Details[i].Eval + " </td>";
                            tbl += "<td style='text-align:left; white-space:nowrap; display:none;' id='txtEvalID"+i+"'>" + data.Details[i].EvalID + " </td>";
                      tbl += "</tr>";
                }   

                tbl += "</tbody>";
                tbl += "</table>";
                $("#tblDetails").html(tbl);
                dataTable();
                return false; 
        
    }
    function onErrorGetVar()
    {
        alert("Error In Loading Details!");
        return false;
    }
    function UpdateAssignVar()
    {
        var ID = $("input[id$='txtVariableID']").val();
        var EmpID = $("select[id$='ddlEmployee'] option:selected").val();
        if(EmpID == "")
        {
            alert("Please Select Employee!");
            return false;
        }
        var VarID = $("select[id$='ddlVariable'] option:selected").val();
        if (VarID == "")
        {
            alert("Please Select Variable!");
            return false;
        }
        var Eval = $("select[id$='ddlEvaluation'] option:selected").text();
        var EvalID = $("select[id$='ddlEvaluation'] option:selected").val();
        if (Eval == "")
        {
            alert("Please Select Evaluation Criteria!");
            return false;
        }
        var IOC = $("input[id$='txtIOC']").val();
        if (IOC == "")
        {
            alert("Please Enter IOC(%)!");
            return false;
        }
        var IOS = $("input[id$='txtIOS']").val();
        if (IOS == "")
        {
            alert("Please Enter IOS(%)!");
            return false;
        }
        $.ajax({
        type: "POST",
        contentType:"application/json; charset=utf-8",
        url: "frmAssignVariables.aspx/UpdateVar", 
        data: "{'ID':'"+ID+"','EmpID':'"+EmpID+"','VarID':'"+VarID+"','Eval':'"+Eval+"','EvalID':'"+EvalID+"','IOC':'"+IOC+"','IOS':'"+IOS+"'}", 
        success:onsuccessUpdateVar,
        error:onErrorUpdateVar
        });
        return false;   
    }
    function onsuccessUpdateVar()
    {
     alert("Record Updated Successfully!");
     ClearFields();
     GetAssignVar();
     return false;   
    }
    function onErrorUpdateVar()
    {
     alert("Error In Updating Record!");
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
    function Delete(rowNo)
    {
        var ID = $("#txtID"+rowNo).html().trim();
        if (confirm("Are you sure you wish to delete this Record?"))
        {
            $.ajax({
                   type: "POST",
                   dataType: "json",
                   contentType: "application/json; charset=utf-8",
                   url: "frmAssignVariables.aspx/DeleteAssVar",
                   data: "{'ID':'"+ID+"'}",
                   success: onSuccessDelete,
                   error:OnErrorDelete 
                    });
        }
        else
        {
          return false;
        }
        return false;
    }
    function onSuccessDelete()
    {
        alert("Record Deleted Successfully!");
        GetAssignVar();
        return false;
    }
    function OnErrorDelete()
    {
        alert("Error In Deleting Record!");
        return false;
    }
    function GetRowForUpdation(rowNo)
    {
        var ID = $("#txtID"+rowNo).html().trim();
        $("input[id$='txtVariableID']").val(ID);
        var EmpID = $("#txtUserID"+rowNo).html().trim();
        $("select[id$='ddlEmployee']").val(EmpID);
        var VarID = $("#txtVarID"+rowNo).html().trim();
        $("select[id$='ddlVariable']").val(VarID);
        var Eval = $("#txtEvalID"+rowNo).html().trim();
        $("select[id$='ddlEvaluation']").val(Eval);
        var IOC = $("#txtCommission"+rowNo).html().trim();
        $("input[id$='txtIOC']").val(IOC);
        var IOS = $("#txtDeduct"+rowNo).html().trim();
        $("input[id$='txtIOS']").val(IOS);
        $("input[id$='btnAssign']").attr('disabled',true);
        $("input[id$='btnUpdate']").show();
        return false;
    }
    function ClearFields()
    {
        $("select[id$='ddlEmployee']").val('');
        $("select[id$='ddlVariable']").val('');
        $("select[id$='ddlEvaluation']").val('');
        $("input[id$='txtIOC']").val('');
        $("input[id$='txtIOS']").val('');
        $("input[id$='btnAssign']").attr('disabled',false);
        $("input[id$='btnUpdate']").hide();
        return false;
    }
    </script>

</asp:Content>

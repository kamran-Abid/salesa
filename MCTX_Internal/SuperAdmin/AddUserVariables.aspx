<%@ Page Language="C#" MasterPageFile="~/MCTX_Internal/SuperAdmin/MasterAdmin.master"
    AutoEventWireup="true" CodeFile="AddUserVariables.aspx.cs" Inherits="MCTX_Internal_SuperAdmin_frmEmpVariables"
    Title="Add User Variables" %>

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
            <li style="text-align: left"><a href="#tabs-1">User Variables</a></li>
        </ul>
        <fieldset style="width: 95%">
            <legend>Add Variable</legend>
            <table style="width: 100%; font-family: Calibri; font-size: 11pt;">
                <tr>
                    <td align="left" style="width: 140px;">
                        <asp:Label ID="lblVariableName" Text="Variable Name:" runat="server"></asp:Label>
                    </td>
                    <td align="left" style="width: 140px;">
                        <asp:TextBox ID="txtVariableName" Width="95%" MaxLength="32" onkeypress="return keyRestrict(event,'abcdefghijklmnopqrstuvwxyz0123456789- ')"
                            onblur="return CheckVariable();" runat="server"></asp:TextBox>
                    </td>
                    <td align="left" style="width: 270px;">
                        <asp:Button ID="btnAddVariable" Text="Add Variable" Style="background-color: #2A4062;
                            color: White; width: 85px;" OnClientClick="return SaveVariable();" runat="server" />
                        <asp:Button ID="btnClear" Text="Clear" Style="background-color: #2A4062; color: White;
                            width: 85px;" OnClientClick="return Clear();" runat="server" />
                        <asp:Button ID="btnUpdate" Text="Update" Style="background-color: #2A4062; color: White;
                            width: 85px; display: none;" OnClientClick="return UpdateVariable();" runat="server" />
                    </td>
                    <td align="left">
                        <asp:TextBox ID="txtVariableID" Width="95%" Style="display: none;" runat="server"></asp:TextBox>
                    </td>
                </tr>
            </table>
        </fieldset>
        <div style="overflow: auto; width: 912px; height: 300px;" runat="server">
            <fieldset style="width: 99%">
                <legend>Details</legend>
                <table id="tblDetails" class="dataTable">
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
    $(document).ready(function()
    {
        GetDetails();
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
    function SaveVariable()
    {
        var Variable = $("input[id$='txtVariableName']").val();
        if (Variable == "")
        {
            alert("Please Enter Variable Name!");
            return false;
        }
        $.ajax({
        type: "POST",
        contentType:"application/json; charset=utf-8",
        url: "AddUserVariables.aspx/SaveVar", 
        data: "{'Variable':'"+Variable+"'}", 
        async:false,
        success:onsuccess,
        error:onError
        });
        return false; 
    }
    function onsuccess()
    {
        alert("Variable Successfully Saved!");
        Clear();
        GetDetails();
        return false;
    }
    function onError()
    {
        alert("Error In Saving Record!");
        return false;
    }
    function Clear()
    {
        $("input[id$='txtVariableName']").val('');
        $("input[id$='txtVariableID']").val('');
        $("input[id$='btnAddVariable']").attr("disabled", false);
        $("input[id$='btnUpdate']").hide();
        return false;
    }
    function GetDetails()
    {
        $.ajax({
        type: "POST",
        contentType:"application/json; charset=utf-8",
        url: "AddUserVariables.aspx/GetDetails", 
        data: "{}", 
        async:false,
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
                tbl += "<th id='txtEditth' style='cursor:Pointer;text-align:center;white-space:nowrap;border:1px solid #999999;'>Edit</th>";
                tbl += "<th style='white-space:nowrap; text-align:left; display:none;'>Variable ID</th>";
                tbl += "<th style='white-space:nowrap; text-align:left;'>Variable Name</th>";
                tbl += "</tr>";
                tbl += "</thead>";
                tbl += "<tbody>";
                for (var i = 0; i < data.Details.length; i++) {               
                            tbl += "<td id='txtEdit"+i+"' align='center' style='width:15%; border:1px solid #999999; text-align:center;'> <input  type='image' src='image/Edit.png' style='width:16px; border:0px;' onclick='return GetRowForUpdation("+i+");'></td>";
                            tbl += "<td style='text-align:left; white-space:nowrap; display:none;' id='txtVarID"+i+"'>" + data.Details[i].variable_id + "</td>";   
                            tbl += "<td style='text-align:left; white-space:nowrap;' id='txtVarName"+i+"'>" + data.Details[i].Variablename + "</td>";                  
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
    
    function CheckVariable()
    {
        var Variable = $("input[id$='txtVariableName']").val();
        $.ajax({
        type: "POST",
        contentType:"application/json; charset=utf-8",
        url: "AddUserVariables.aspx/CheckVar", 
        data: "{'Variable':'"+Variable+"'}",
        async:false,
        success:onsuccessChckVar,
        error:onErrorChckVar
        });
        return false;
    }
    function onsuccessChckVar(msg)
    {
        var data = msg.d;
        if (data == 1)
        {
            alert("Variable Already Exists!");
            $("input[id$='txtVariableName']").val('');
            return false;
        }
        return false;
    }
    
    function onErrorChckVar()
    {
        alert("Error In CHecking Variable!");
        return false;
    }
    
    function GetRowForUpdation(rowNo)
    {
        var VariableID = $("#txtVarID"+rowNo).html().trim();
        $("input[id$='txtVariableID']").val(VariableID);
        var VariableName = $("#txtVarName"+rowNo).html().trim();
        $("input[id$='txtVariableName']").val(VariableName);
        $("input[id$='btnAddVariable']").attr("disabled", true);
        $("input[id$='btnUpdate']").show();
        return false;
    }
    
    function UpdateVariable()
    {
        var VarID = $("input[id$='txtVariableID']").val();
        var Variable = $("input[id$='txtVariableName']").val();
        if (Variable == "")
        {
            alert("Please Enter Variable Name!");
            return false;
        }
        $.ajax({
        type: "POST",
        contentType:"application/json; charset=utf-8",
        url: "AddUserVariables.aspx/UpdateVar", 
        data: "{'VarID':'"+VarID+"','Variable':'"+Variable+"'}", 
        async:false,
        success:onsuccessUpdate,
        error:onErrorUpdate
        });
        return false; 
    }
    
    function onsuccessUpdate()
    {
        alert("Record Successfully Updated!");
        GetDetails();
        Clear();
        return false;
    }
    
    function onErrorUpdate()
    {
        alert("Error In Updation!");
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

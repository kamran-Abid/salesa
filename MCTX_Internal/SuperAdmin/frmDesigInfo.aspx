<%@ Page Language="C#" MasterPageFile="~/MCTX_Internal/SuperAdmin/MasterAdmin.master"
    AutoEventWireup="true" CodeFile="frmDesigInfo.aspx.cs" Inherits="MCTX_Internal_SuperAdmin_frmDesigInfo"
    Title="Designation Information" %>

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
            <li style="text-align: left"><a href="#tabs-1">Designation Information</a></li>
        </ul>
        <fieldset style="width: 95%">
            <legend>Designation Info & Details</legend>
            <fieldset style="width: 99%">
                <legend>Add Designation</legend>
                <table style="width: 100%; font-family: Calibri; font-size: 11pt;">
                    <tr>
                        <td align="left" style="width: 140px;">
                            <asp:Label ID="lblDesig" Text="Enter Designation:" runat="server"></asp:Label>
                        </td>
                        <td align="left" style="width: 140px;">
                            <asp:TextBox ID="txtDesignation" Width="95%" MaxLength="35" onkeypress="return keyRestrict(event,'-&0123456789abcdefghijklmnopqrstuvwxyz ')"
                                runat="server"></asp:TextBox>
                        </td>
                        <td align="left">
                            <asp:Button ID="btnSave" Text="Add Designation" Style="background-color: #2A4062;
                                color: White; width: 108px;" OnClientClick="return SaveDesignation();" runat="server" />
                            <asp:Button ID="btnClear" Text="Clear" Style="background-color: #2A4062; color: White;
                                width: 75px;" OnClientClick="return ClearFields();" runat="server" />
                            <asp:Button ID="btnUpdate" Text="Update" Style="background-color: #2A4062; color: White;
                                width: 75px; display: none;" OnClientClick="return UpdateDesg();" runat="server" />
                        </td>
                        <td>
                            <asp:TextBox ID="txtDesgID" Style="display: none" runat="server"></asp:TextBox>
                        </td>
                    </tr>
                </table>
            </fieldset>
            <fieldset style="width: 90%">
                <legend>Designation Details</legend>
                <div style="overflow: auto; width: 904px; height: 390px">
                    <table id="tblDesignations" style="width: 100%;" class="dataTable">
                    </table>
                </div>
            </fieldset>
        </fieldset>
    </div>

    <script type="text/javascript" language="javascript">
        var oTable;
        
         function blockUI() {
            $.blockUI({ message: '<img src="image/ajax-loader.gif" />',
                css: { borderStyle: 'none', backgroundColor: "Transparent" }
            });
        }

        function unblockUI() {
            $.unblockUI();
        }
        $(document).ready(function() {
            DisplayDesg();
        });

        function dataTable() {
            oTable = $("#tblDesignations").dataTable({
                bPaginate: false,
                bJQueryUI: true,
                bSort: true,
                bInfo: false,
                bRetrieve: true,
                bDestroy: true,
                oLanguage: { "sSearch": "Filter: " }
            }).fixedHeader({ height: 400 });
        }

        function SaveDesignation() {
            var DesgName = $("input[id$='txtDesignation']").val();
            if (DesgName == "") {
                alert("Please Enter Designation!");
                return false;
            }
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "frmDesigInfo.aspx/SaveDesig",
                data: "{'DesgName':'" + DesgName + "'}",
                success: onsuccessSaveDesg,
                error: onErrorSaveDesg
            });
            return false;
        }

        function onsuccessSaveDesg() {
            alert("Designation Successfully Added!");
            ClearFields();
            DisplayDesg();
            return false;
        }

        function onErrorSaveDesg() {
            alert("Error In Saving Designation!");
            return false;
        }

        function UpdateDesg() {
            var DesgName = $("input[id$='txtDesignation']").val();
            if (DesgName == "") {
                alert("Please Enter Designation!");
                return false;
            }
            var ID = $("input[id$='txtDesgID']").val();
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "frmDesigInfo.aspx/UpdateDesg",
                data: "{'ID':'" + ID + "','DesgName':'" + DesgName + "'}",
                success: onsuccessUpdateDesg,
                error: onErrorUpdateDesg
            });
            return false;
        }

        function onsuccessUpdateDesg() {
            alert("Record Updated Successfully!");
            ClearFields();
            DisplayDesg();
            return false;
        }

        function onErrorUpdateDesg() {
            alert("Error In Updating Record!");
            return false;
        }

        function GetRowForUpdation(rowNo) {
            var DesgID = $("#txtDesgID" + rowNo).html().trim();
            $("input[id$='txtDesgID']").val(DesgID);
            var DesgName = $("#txtDesgName" + rowNo).html().trim();
            $("input[id$='txtDesignation']").val(DesgName);
            $("input[id$='btnSave']").attr("disabled", true);
            $("input[id$='btnUpdate']").show();
            return false;
        }

        function DisplayDesg() {
        blockUI();
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "frmDesigInfo.aspx/DisplayDesg",
                data: "{}",
                success: onsuccessDesg,
                error: onErrorDesg
            });
            return false;
        }
        function onsuccessDesg(msg) {
            var data = msg.d;
            if (oTable != null) {
                oTable.fnClearTable();
                oTable.fnDestroy();
            }
            var tbl = "";
            tbl += "<thead>";
            tbl += "<tr>";
            tbl += "<th id='txtDeleteth' style='cursor:Pointer;text-align:left;white-space:nowrap;border:1px solid #999999;'>Delete</th>";
            tbl += "<th id='txtEditth' style='cursor:Pointer;text-align:left;white-space:nowrap;border:1px solid #999999;'>Edit</th>";
            tbl += "<th style='white-space:nowrap; text-align:left; display:none; border:1px solid #999999;'>ID</th>";
            tbl += "<th style='white-space:nowrap; text-align:left; border:1px solid #999999;'>Designation</th>";
            tbl += "</tr>";
            tbl += "</thead>";
            tbl += "<tbody>";
            for (var i = 0; i < data.DesgInfo.length; i++) {
                tbl += "<td id='txtDelete" + i + "' align='center' style='border:1px solid #999999; width:80px;'> <input  type='image' src='image/Cross.png' style='width:16px; border:0px;' onclick='return Delete(" + i + ");'></td>";
                tbl += "<td id='txtEdit" + i + "' align='center' style='border:1px solid #999999; width:80px;'> <input  type='image' src='image/Edit.png' style='width:16px; border:0px;' onclick='return GetRowForUpdation(" + i + ");'></td>";
                tbl += "<td style='text-align:right; white-space:nowrap; display:none; border:1px solid #999999;' id='txtDesgID" + i + "'>" + data.DesgInfo[i].ID + "</td>";
                tbl += "<td style='text-align:left; white-space:nowrap; border:1px solid #999999;' id='txtDesgName" + i + "'>" + data.DesgInfo[i].Desig_Name + "</td>";
                tbl += "</tr>";
            }
            tbl += "</tbody>";
            tbl += "</table>";
            $("#tblDesignations").html(tbl);
            dataTable();
            unblockUI();
            return false;
        }
        function onErrorDesg() {
            alert("Error In Loading Records!");
            unblockUI();
            return false;
        }

        function ClearFields() {
            $("input[id$='txtDesignation']").val("");
            $("input[id$='btnSave']").attr("disabled", false);
            $("input[id$='btnUpdate']").hide();
            return false;
        }

        function Delete(rowNo) {
            var DesgID = $("#txtDesgID" + rowNo).html().trim();
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "frmDesigInfo.aspx/DeleteDesg",
                data: "{'DesgID':'" + DesgID + "'}",
                success: onsuccessDelete,
                error: onErrorDelete
            });
            return false;
        }

        function onsuccessDelete() {
            alert("Record Deleted Successfully!");
            DisplayDesg();
            return false;
        }

        function onErrorDelete() {
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

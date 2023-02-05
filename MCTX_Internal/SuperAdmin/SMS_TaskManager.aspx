<%@ Page Language="C#" MasterPageFile="~/MCTX_Internal/SuperAdmin/MasterAdmin.master"
    AutoEventWireup="true" CodeFile="SMS_TaskManager.aspx.cs" Inherits="MCTX_Internal_SuperAdmin_SMS_TaskManager"
    Title="Task Manager (SMS)" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <script src="../../js/jquery.dataTables.min.js" type="text/javascript"></script>

    <script src="../../js/jquery.fixedheader.js" type="text/javascript"></script>

    <style type="text/css">
        .dataTable
        {
            font-family: Calibri,Verdana, Arial, Helvetica, sans-serif;
            border-collapse: collapse;
            border: 1px solid #999999;
            width: 100%;
            font-size: 12px;
        }
        .dataTable td, .dataTable th
        {
            font-family: Calibri,Verdana, Arial, Helvetica, sans-serif;
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
            text-align: center;
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
        html< /**/ /**/ body .dataTable, x:-moz-any-link
        {
            margin: 1px;
        }
        html< /**/ /**/ body .dataTable, x:-moz-any-link, x:default
        {
            margin: 1px;
        }
    </style>
    <div id="tabs">
        <ul>
            <li style="text-align: left"><a href="#tabs-1">SMS Tasks</a></li>
        </ul>
        <div style="height:400px;overflow:auto">
        <table style="margin-top: 15px" id="tblSMS_Tasks" class="dataTable" width="100%">
        </table>
        </div>
    </div>

    <script type="text/javascript" language="javascript">

        var oTable;
        $(document).ready(function() {
            GetSMS_Tasks();
        });

        function dataTable() {
            oTable = $("#tblSMS_Tasks").dataTable({
                bPaginate: false,
                bJQueryUI: true,
                oLanguage: { "sSearch": "Filter: " }
            }).fixedHeader({ height: 400 })
        }
        function GetSMS_Tasks() {

            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "SMS_TaskManager.aspx/GetSMS_Tasks",
                data: "{}",
                dataType: "json",
                success: onsuccessLoadData,
                error: OnretrieveError
            });
        }

        function onsuccessLoadData(msg) {

            //$("#tbladdCity tr").html("");
            if (oTable != null) {
                oTable.fnClearTable();
                oTable.fnDestroy();
            }
            var data = msg.d;
            var tbl = "";

            tbl += "<thead>"
            tbl += "<tr>"

            tbl += "<th style='cursor:Pointer'>Sr.#</th>";
            tbl += "<th style='cursor:Pointer'>Task</th>";
            tbl += "<th style='cursor:Pointer'>Assinged To</th>";
            tbl += "<th style='cursor:Pointer'>Assigned By</th>";
            tbl += "<th style='cursor:Pointer'>Status</th>";
            tbl += "<th style='cursor:Pointer'>Reply</th>";
            tbl += "<th style='cursor:Pointer'>Date</th>";
            tbl += "<th style='cursor:Pointer'>User Id</th>";
            tbl += "<th style='cursor:Pointer'>To User Id</th>";
            tbl += "<th style='display:none'>Task Id</th>";
            tbl += "</tr>"
            tbl += "</thead>"
            tbl += "<tbody>"
            var j = 0;
            for (var i = 0; i < data.SMS_Tasks.length; i++) {
                j = i + 1;
                tbl += "<tr id='trmain" + i + "' style='cursor:default'>";
                tbl += "<td style='border:1px solid #999999;text-align:left'>" + j + " </td>";
                tbl += "<td id='txtTask_Desc" + i + "' style='border:1px solid #999999;text-align:left' title='" + data.SMS_Tasks[i].Task_Desc + "'>" + data.SMS_Tasks[i].Task_Desc.substr(0, 18) + " </td>";
                tbl += "<td id='txtTask_Assinged_To" + i + "' style='border:1px solid #999999;text-align:left' title='" + data.SMS_Tasks[i].Task_Assinged_To + "'>" + data.SMS_Tasks[i].Task_Assinged_To.substr(0, 8) + " </td>";
                tbl += "<td id='txtTask_Assigned_By" + i + "' style='border:1px solid #999999;text-align:left'>" + data.SMS_Tasks[i].Task_Assigned_By + " </td>";
                tbl += "<td id='txtTask_Status" + i + "' style='border:1px solid #999999;text-align:left'>" + data.SMS_Tasks[i].Task_Status + " </td>";
                tbl += "<td id='txtTask_Replied" + i + "' style='border:1px solid #999999;text-align:left' title='" + data.SMS_Tasks[i].Task_Replied + "'>" + data.SMS_Tasks[i].Task_Replied + " </td>";
                tbl += "<td id='txtTask_Date" + i + "' style='border:1px solid #999999;text-align:left'>" + data.SMS_Tasks[i].Task_Date + " </td>";
                tbl += "<td id='txtTasK_By_User_Id" + i + "' style='border:1px solid #999999;text-align:left'>" + data.SMS_Tasks[i].TasK_By_User_Id + " </td>";
                tbl += "<td id='txtTask_To_User_Id" + i + "' style='border:1px solid #999999;text-align:left'>" + data.SMS_Tasks[i].Task_To_User_Id + " </td>";
                tbl += "<td id='txtTask_Id" + i + "' style='display:none'>" + data.SMS_Tasks[i].Task_Id + " </td>";
                tbl += "</tr>";
            }

            tbl += "</tbody>"
            tbl += "</table>"
            $("#tblSMS_Tasks").html(tbl);

            dataTable();
        }

        function OnretrieveError(error) {
            var errors = eval("(" + error.responseText + ")");
            alert("Error in Loading Physician: " + errors.Message);
        }

        function getRowID(rowID) {
            $("table[id$='tblSMS_Tasks'] tr").css("background-color", "white");
            $("#trmain" + rowID).css("background-color", "#D3D3D3");

        }

        //      function GetRowForUpdation(rowNo)
        //     {    
        //     $("input[id$='btn_save']").hide();
        //     $("input[id$='btnNew']").show();
        //     $("input[id$='btn_update']").show();
        //        var CityID= $("#txtCityID"+rowNo).html(); 
        //        var CityName =$("#txtCityName"+rowNo).html(); 
        //      
        //        $("input[id$='txt_CityId']").val(CityID);
        //        $("input[id$='txtcity']").val(CityName);
        //        
        //     }

        //     function clearField()
        //     {
        //     $("input[id$='txt_CityId']").val("");
        //        $("input[id$='txtcity']").val("");
        //        $("input[id$='btn_save']").show();
        //        $("input[id$='btnNew']").show();
        //        $("input[id$='btn_update']").hide();
        //        return false;
        //     }

        function DeleteTask(rowNo) {
            var TaskID = $("#txtTask_Id" + rowNo).html();
            if (confirm("Are you sure to delete this record?")) {
                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "SMSWebMethod.aspx/DeleteTask",
                    data: "{'TaskID':'" + TaskID + "'}",
                    dataType: "json",
                    success: onsuccessDeleteData,
                    error: OnretrieveError
                });
            }
            else {
                return false;
            }
            return false;
        }

        function onsuccessDeleteData(msg) {
            alert("Record Delete Successfully");
            GetSMS_Tasks();
            return false;
        }

        //     function saveUpdateEmpCityRecord()
        //     {
        //     var CityID="";
        //     CityID=$("input[id$='txt_CityId']").val();    
        //     var CityName= $("input[id$='txtcity']").val();

        //     $.ajax({
        //     type: "POST",
        //            contentType: "application/json; charset=utf-8",
        //            url: "WPGWebMethod.aspx/saveUpdateEmpCity",
        //            data: "{'CityID':'"+CityID+"','CityName':'"+CityName+"'}",
        //            dataType: "json",
        //            success: onsuccessSaveUpdateData,
        //            error:OnretrieveError 
        //            });
        //            
        //            return false;
        //     }

        //     function onsuccessSaveUpdateData()
        //     {
        //      alert("Record Save/Update Successfully");
        //    
        //      getCityRecod();
        //     
        //     }

        function OnretrieveError() {
        } 
     
    </script>

</asp:Content>

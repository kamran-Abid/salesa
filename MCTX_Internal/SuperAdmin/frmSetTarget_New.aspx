<%@ Page Language="C#" MasterPageFile="~/MCTX_Internal/SuperAdmin/MasterAdmin.master"
    AutoEventWireup="true" CodeFile="frmSetTarget_New.aspx.cs" Inherits="MCTX_Internal_SuperAdmin_frmSetTarget_New"
    Title="Target Setting" %>

<%@ Register Assembly="RJS.Web.WebControl.PopCalendar.Net.2008" Namespace="RJS.Web.WebControl"
    TagPrefix="rjs" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    
    <link href="../../css1/jqModal.css" rel="stylesheet" type="text/css" />
    <script src="../../js/jquery.dataTables.min.js" type="text/javascript"></script>

    <script src="../../js/BlockUI.js" type="text/javascript"></script>

    <script src="JS/jquery.ajax_upload.0.6.js" type="text/javascript"></script>

    <script src="JS/jqModal.js" type="text/javascript"></script>

    <style type="text/css">
        ul
        {
            list-style: none;
        }
        .example
        {
            padding: 0 20px;
            float: left;
            width: 230px;
        }
        .wrapper
        {
            width: 133px; /* Centering button will not work, so we need to use additional div */
            margin: 0 auto;
        }
        div.button
        {
            height: 29px;
            width: 133px;
            background: url(button.png) 0 0;
            font-size: 14px;
            color: #C7D92C;
            text-align: center;
            padding-top: 15px;
        }
        /* 
    We can't use ":hover" preudo-class because we have
    invisible file input above, so we have to simulate
    hover effect with javascript. 
 */div.button.hover
        {
            background: url(button.png) 0 56px;
            color: #95A226;
        }
    </style>
    <style>
        .container
        {
            width: 333px;
            height: 90px;
            border: #888 4px solid;
            padding: 80px 40px;
            position: absolute;
            top: 50px;
            left: 50%;
            margin-left: -151px;
        }
        .container div.label
        {
            position: absolute;
            left: 0;
            top: 0;
            font-weight: bold;
            font-size: 1.3em;
        }
    </style>
    <style type="text/css">
        input
        {
            border: 1px solid gray;
        }
        select
        {
            border: 1px solid gray;
        }
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
    </style>
    <div id="tabs" style="width: 100%;">
        <ul>
            <li style="text-align: left"><a href="#tabs-1">Target Setting</a></li>
        </ul>
        <fieldset id="fldTargetSetting" style="width: 99%; margin: 5px">
            <legend>Target Setting</legend>
            <table width="950px">
                <tr>
                    <td align="left" style="width: 15%">
                        Employee Name
                    </td>
                    <td colspan="3" align="left">
                        <asp:DropDownList ID="ddlEmployeeName" Style="width: 124px;" runat="server">
                        </asp:DropDownList>
                    </td>
                </tr>
                <tr>
                    <td align="left">
                        Start Date
                    </td>
                    <td align="left" style="width: 325px;">
                        <asp:TextBox ID="txtStartDate" Width="104px" runat="server"></asp:TextBox>
                        <rjs:PopCalendar ID="rjsStartDate" Separator="/" Format="mm dd yyyy" Control="txtStartDate"
                            runat="server" Font-Names="Tahoma" />
                    </td>
                    <td align="left">
                        End Date
                    </td>
                    <td align="left">
                        <asp:TextBox ID="txtEndDate" Width="104px" runat="server"></asp:TextBox>
                        <rjs:PopCalendar ID="rjsEndDate" Separator="/" Format="mm dd yyyy" Control="txtEndDate"
                            runat="server" Font-Names="Tahoma" />
                    </td>
                </tr>
                <tr>
                    <td colspan="4">
                        <fieldset style="width: 99%; margin: 3px">
                            <legend>Visit Entry Time</legend>
                            <table width="98%">
                                <tr>
                                    <td align="left" style="width: 14%">
                                        Start Time
                                    </td>
                                    <td align="left">
                                        <asp:DropDownList ID="ddlhourStartTime" runat="server" Height="16px" Width="127px">
                                            <asp:ListItem>08:00 AM</asp:ListItem>
                                            <asp:ListItem>08:30 AM</asp:ListItem>
                                            <asp:ListItem>09:00 AM</asp:ListItem>
                                            <asp:ListItem>09:30 AM</asp:ListItem>
                                            <asp:ListItem>10:00 AM</asp:ListItem>
                                            <asp:ListItem>10:30 AM</asp:ListItem>
                                            <asp:ListItem>11:00 AM</asp:ListItem>
                                        </asp:DropDownList>
                                    </td>
                                    <td align="left" style="width: 137px">
                                        End Time
                                    </td>
                                    <td align="left">
                                        <asp:DropDownList ID="ddlhourEndTime" runat="server" Height="16px" Width="127px">
                                            <asp:ListItem>04:00 PM</asp:ListItem>
                                            <asp:ListItem>04:30 PM</asp:ListItem>
                                            <asp:ListItem>05:00 PM</asp:ListItem>
                                            <asp:ListItem>05:30 PM</asp:ListItem>
                                            <asp:ListItem>06:00 PM</asp:ListItem>
                                            <asp:ListItem>06:30 PM</asp:ListItem>
                                            <asp:ListItem>07:00 PM</asp:ListItem>
                                            <asp:ListItem>07:30 PM</asp:ListItem>
                                            <asp:ListItem>08:00 PM</asp:ListItem>
                                            <asp:ListItem>08:30 PM</asp:ListItem>
                                            <asp:ListItem>09:00 PM</asp:ListItem>
                                        </asp:DropDownList>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="left">
                                        Target Type
                                    </td>
                                    <td align="left">
                                        <asp:DropDownList ID="ddlTargetType" runat="server" AutoPostBack="false" Height="16px"
                                            Width="127px">
                                            <asp:ListItem></asp:ListItem>
                                        </asp:DropDownList>
                                    </td>
                                    <td align="left">
                                        Evaluation on
                                    </td>
                                    <td align="left">
                                        <asp:DropDownList ID="ddlEvalOn" runat="server" Height="16px" Width="127px">
                                            <asp:ListItem>--Select--</asp:ListItem>
                                            <asp:ListItem>Monthly</asp:ListItem>
                                            <asp:ListItem>Weekly</asp:ListItem>
                                            <asp:ListItem>Daily</asp:ListItem>
                                        </asp:DropDownList>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:TextBox ID="txtTagerSettingID" runat="server" Style="display: none"></asp:TextBox>
                                    </td>
                                    <td align="right" colspan="2" style="padding-right: 62px;">
                                        No Of Visits/Target Amount
                                    </td>
                                    <td align="left">
                                        <asp:TextBox ID="txtNoOfVisits" runat="server" Width="110px" CssClass="numberinput"
                                            MaxLength="9"></asp:TextBox>
                                    </td>
                                    <%--<td align="left">
                Target Amount
                </td>
                <td align="left">
                <asp:TextBox ID="txtTargetAmount" runat="server" Width="110px"></asp:TextBox>
                </td>--%>
                                </tr>
                            </table>
                        </fieldset>
                    </td>
                </tr>
                <tr>
                    <td colspan="2" align="center">
                        <asp:Button ID="btnAdd" runat="server" Text="Add" Width="75px" OnClientClick="addTargetSetting(); return false;" />
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        <asp:Button ID="Button2" runat="server" Text="New" Width="75px" OnClientClick="ClearAllField(); return false;" />
                    </td>
                    <td colspan="2" align="center">
                    </td>
                </tr>
            </table>
        </fieldset>
        <div id="divAddTarget" style="display: none; width: 99%">
            <fieldset style="width: 99%; margin: 5px">
                <legend>Targets</legend>
                <table id="tbleEmpTitle" width="99%">
                    <tr>
                        <th>
                            Targets Detail of <span id="spnEmpName" style="color: Maroon; font-weight: bold">
                            </span>
                        </th>
                        <th align="right">
                            <img src='image/Cross.png' onclick="HideDiv();" />
                        </th>
                    </tr>
                </table>
                <table id="tblAddTarget" width="99%" style="background: white" class="dataTable">
                    <tr>
                        <th align="left">
                            Delete
                        </th>
                        <th align="left">
                            Edit
                        </th>
                        <%--            <th align="left">User Name</th>--%>
                        <th align="left">
                            Start Date
                        </th>
                        <th align="left">
                            End Date
                        </th>
                        <th align="left">
                            Start Time
                        </th>
                        <th align="left">
                            End Time
                        </th>
                        <th align="left">
                            Target Name
                        </th>
                        <th align="left">
                            No. Of Target(s)
                        </th>
                        <th align="left">
                            Evaluation On
                        </th>
                    </tr>
                </table>
                <table width="100%" class="dataTable">
                    <tr>
                        <td>
                            <asp:Button ID="btnSave" OnClientClick="return SaveTargetNew(); " runat="server" Text="Save"
                                Width="75px" />
                            <asp:Button ID="Button1" OnClientClick="UpdateEmpTargetDetail();" Style="display: none"
                                runat="server" Text="Update" Width="75px" />
                        </td>
                    </tr>
                </table>
            </fieldset>
        </div>
        <table id="tblEmployeeList" class="dataTable" width="100%">
        </table>
    </div>
    <div id="divJQModal" class="jqmWindow" style="min-height: 190px; display: none; width: 850px;
        text-align: center;">
        <table width="50%">
            <tr>
                <th>
                    Targets Detail of <span id="spnEmpName2" style="color: Maroon; font-weight: bold">
                    </span>
                </th>
                <th align="right">
                    <img src='image/Cross.png' onclick="HideDiv();" />
                </th>
            </tr>
        </table>
        <br />
        <table id="tblDetailEmpTarget" width="50%" class="dataTable">
        </table>
    </div>

    <script type="text/javascript" language="javascript">
        function HideDiv() {
            // $("#divJQModal").jqmHide();
            // $("#divAddTarget").hide();
            ClearAllField();
        }

        function ClearAllField() {
            // $("#tblAddTarget tr").html("");
            $("#tblAddTarget tbody").remove();
            $("iput[id$='spnEmpName']").val("");
            //$("#tbleEmpTitle tr").html("");
            $("#divAddTarget").hide();
            $("input[id$='txtTagerSettingID']").val("");
            $("#fldTargetSetting select").val("--Select--");
            $("#fldTargetSetting input[type='text']").val("");


        }


        //---------------------------------------allow only Number--------------------------------------------------------------------------------------

        jQuery.fn.forceNumeric = function() {

            return this.each(function() {
                $(this).keydown(function(e) {
                    var key = e.which || e.keyCode;

                    if (!e.shiftKey && !e.altKey && !e.ctrlKey &&
                    // numbers   
                         key >= 48 && key <= 57 ||
                    // Numeric keypad
                         key >= 96 && key <= 105 ||
                    // comma, period and minus, . on keypad
                        key == 190 || key == 188 || key == 109 || key == 110 ||
                    // Backspace and Tab and Enter
                        key == 8 || key == 9 || key == 13 ||
                    // Home and End
                        key == 35 || key == 36 ||
                    // left and right arrows
                        key == 37 || key == 39 ||
                    // Del and Ins
                        key == 46 || key == 45)
                        return true;

                    return false;
                });
            });
        }

        $(document).ready(function() {
            $(".numberinput").forceNumeric();
            GetEmployeeTargetList();
        });


        function GetEmpName(id) {

            $("#spnEmpName").html($("#txtEmpName" + id).html());
        }

        function GetEmployeeTargetList() {
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "frmSetTarget_New.aspx/GetUserList",
                data: "{}",
                success: onsuccessLoadData,
                error: onretrieveError
            });
            return false;
        }


        function onsuccessLoadData(msg) {
            var data = msg.d;
            var tbl = "";
            tbl += "<thead>";
            tbl += "<tr>";
            tbl += "<th style='text-align:center; white-space:nowrap;'>Delete</th>";
            tbl += "<th style='text-align:center; white-space:nowrap;'>View</th>";
            tbl += "<th style='white-space:nowrap; text-align:left;'>User Name</th>";
            tbl += "<th style='white-space:nowrap; text-align:left;'>Start Date</th>";
            tbl += "<th style='white-space:nowrap; text-align:left;'>End Date</th>";
            tbl += "<th style='white-space:nowrap; text-align:left;'>Created Date</th>";
            tbl += "<th style='white-space:nowrap; text-align:left;'>Created By</th>";
            tbl += "<th style='white-space:nowrap; text-align:left;'>Modified Date</th>";
            tbl += "<th style='white-space:nowrap; text-align:left;'>Modified By</th>";

            tbl += "</tr>";
            tbl += "</thead>";
            tbl += "<tbody>";
            for (var i = 0; i < data.EmpTargetList.length; i++) {
                var CreatedDate = data.EmpTargetList[i].Creted_Date;
                if (CreatedDate == null || CreatedDate == "null")
                    CreatedDate = "";
                var CreatedBy = data.EmpTargetList[i].Created_By;
                if (CreatedBy == null || CreatedBy == "null")
                    CreatedBy = "";
                var ModifiedDate = data.EmpTargetList[i].Modified_Date;
                if (ModifiedDate == null || ModifiedDate == "null")
                    ModifiedDate = "";
                var ModifiedBy = data.EmpTargetList[i].Modified_By;
                if (ModifiedBy == null || ModifiedBy == "null")
                    ModifiedBy = "";
                tbl += "<td style='cursor:Pointer;' id='txtdelete' align='center' onclick='return DeleteMaiEmpTargetList(" + data.EmpTargetList[i].setting_id + ");'><img src='image/Cross.png'> </td>";
                tbl += "<td style='cursor:Pointer;' id='txtUpdate' align='center' onclick='GetEmpName(" + i + ");showDetailEmpTarget(" + data.EmpTargetList[i].setting_id + ");'><img src='image/Edit.png'></td>";
                tbl += "<td style='text-align:left;' id='txtEmpName" + i + "'>" + data.EmpTargetList[i].E_Name + " </td>";
                tbl += "<td style='text-align:left;' id='txtStartDate" + i + "'>" + data.EmpTargetList[i].startdate + " </td>";
                tbl += "<td style='text-align:left;' id='txtEndDate" + i + "'>" + data.EmpTargetList[i].enddate + " </td>";

                tbl += "<td style='text-align:left;' id='txtCreatedDate" + i + "'>" + CreatedDate + "</td>";
                tbl += "<td style='text-align:left;display:nones' id='txtCreatedBy" + i + "'>" + CreatedBy + "</td>";
                tbl += "<td style='text-align:left;' id='txtModifiedDate" + i + "'>" + ModifiedDate + "</td>";
                tbl += "<td style='text-align:left;' id='txtModifiedBy" + i + "'>" + ModifiedBy + "</td>";
                tbl += "</tr>";
            }

            tbl += "</tbody>";
            tbl += "</table>";
            $("#tblEmployeeList").html(tbl);

            return false;
        }

        //---------------------------------------------Add Target Setting------------------------------------------------------------------------------      
        function addTargetSetting() {

            var uname = $("select[id$='ddlEmployeeName'] option:selected").val();
            if (uname == "--Select--") {
                alert("Please Select Employee!");
                $("select[id$='ddlEmployeeName']").focus();
                return false;
            }
            var startDate = $("input[id$='txtStartDate']").val().trim();
            if (startDate == "") {
                alert("Please Enter Start Date!");
                $("input[id$='txtStartDate']").focus();
                return false;
            }

            var endDate = $("input[id$='txtEndDate']").val().trim();
            if (endDate == "") {
                alert("Please Enter End Date!");
                $("input[id$='txtEndDate']").focus();
                return false;
            }
            var startTime = $("select[id$='ddlhourStartTime'] option:selected").val();
            var endTime = $("select[id$='ddlhourEndTime'] option:selected").val();

            var TargetTypeID = $("select[id$='ddlTargetType'] option:selected").val();
            if (TargetTypeID == "--Select--") {
                alert("Please Select Target Type!");
                $("select[id$='ddlTargetType']").focus();
                return false;
            }

            var EvaluationOn = $("select[id$='ddlEvalOn'] option:selected").val();
            if (EvaluationOn == "--Select--") {
                alert("Please Select Evaluation On!");
                $("select[id$='ddlEvalOn']").focus();
                return false;
            }
            var NoOFTarget = $("input[id$='txtNoOfVisits']").val().trim();
            if (NoOFTarget == "") {
                alert("Please Enter No Of Visits!");
                $("input[id$='txtNoOfVisits']").focus();
                return false;
            }

            $("#divAddTarget").show();
            if (rowNo == -1) {
                var id = $("#tblAddTarget tr").length - 1;
                var tbl = "";
                tbl += "</tr>";
                tbl += "</thead>";
                tbl += "<tbody >";
                tbl += "<td style='cursor:Pointer;' id='txtdelete' align='center' onclick='return DeleteRecord(" + id + ");'><img src='image/Cross.png'> </td>";
                tbl += "<td style='cursor:Pointer;' id='txtUpdate' align='center'><img src='image/Edit.png'></td>";
                tbl += "<td style='text-align:left;display:none' id='txtUserID" + id + "'>" + $("select[id$='ddlEmployeeName'] option:selected").val(); +" </td>";
                tbl += "<td style='text-align:left;' id='txtStartDt" + id + "'>" + $("input[id$='txtStartDate']").val().trim(); +" </td>";
                tbl += "<td style='text-align:left;' id='txtEndDt" + id + "'>" + $("input[id$='txtEndDate']").val().trim(); +" </td>";
                tbl += "<td style='text-align:left;' id='txtStartTM" + id + "'>" + $("select[id$='ddlhourStartTime'] option:selected").val(); +" </td>";
                tbl += "<td style='text-align:left;' id='txtEndTM" + id + "'>" + $("select[id$='ddlhourEndTime'] option:selected").val(); +" </td>";
                tbl += "<td style='text-align:left;' id='txtTargetName" + id + "'>" + $("select[id$='ddlTargetType'] option:selected").text(); +" </td>";
                tbl += "<td style='text-align:left;display:none' id='txtTargetID" + id + "'>" + $("select[id$='ddlTargetType'] option:selected").val(); +" </td>";
                tbl += "<td style='text-align:left;' id='txtNoOfTarget" + id + "'>" + $("input[id$='txtNoOfVisits']").val().trim(); +" </td>";
                tbl += "<td style='text-align:left;' id='txtEvaluationOn" + id + "'>" + $("select[id$='ddlEvalOn'] option:selected").val(); +" </td>";

                tbl += "</tbody>";
                tbl += "</table>";
                $("#tblAddTarget").append(tbl);
            }
            else {

                $("#txtTargetName" + rowNo).html($("select[id$='ddlTargetType'] option:selected").text());
                $("#txtNoOfTarget" + rowNo).html($("input[id$='txtNoOfVisits']").val().trim());
                $("#txtEvaluationOn" + rowNo).html($("select[id$='ddlEvalOn'] option:selected").val());
                $("#txtTargetID" + rowNo).html($("select[id$='ddlTargetType'] option:selected").val());
                rowNo = -1;



            }
        }

        ////------------------------------------Show Employee Detail--------------------------------------------------------------------------
        var TID = 0;
        function showDetailEmpTarget(TargetID) {
            $("input[id$='txtTagerSettingID']").val("");
            $("#fldTargetSetting select").val("--Select--");
            $("#fldTargetSetting input[type='text']").val("");

            $("input[id$='txtTagerSettingID']").val(TargetID);
            TID = TargetID;
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "frmSetTarget_New.aspx/GetEmpTargetDetail",
                data: "{'TargetID':'" + TargetID + "'}",
                success: onsuccessLoadEmpDetail,
                error: onretrieveError
            });
        }
        function onsuccessLoadEmpDetail(msg) {
            $("#divAddTarget").show();
            $("#tblAddTarget").html("");
            var data = msg.d;
            var tbl = "";
            tbl += "<thead>";
            tbl += "<tr>";
            tbl += "<th style='text-align:center; white-space:nowrap;'>Delete</th>";
            tbl += "<th style='text-align:center; white-space:nowrap;'>Edit</th>";
            tbl += "<th style='white-space:nowrap; text-align:left;'>Start Date</th>";
            tbl += "<th style='white-space:nowrap; text-align:left;'>End Date</th>";
            tbl += "<th style='white-space:nowrap; text-align:left;'>Start Time</th>";
            tbl += "<th style='white-space:nowrap; text-align:left;'>End Time</th>";
            tbl += "<th style='white-space:nowrap; text-align:left;'>Target Name</th>";
            tbl += "<th style='white-space:nowrap; text-align:left;'>No. Of Target(s)</th>";
            tbl += "<th style='white-space:nowrap; text-align:left;'>Evaluation On</th>";
            tbl += "<th style='white-space:nowrap; text-align:left;'>ID</th>";
            tbl += "</tr>";
            tbl += "</thead>";
            tbl += "<tbody>";
            for (var i = 0; i < data.EmpTargetDetail.length; i++) {
                tbl += "<tr id='trDetailTarget" + i + "'>";
                tbl += "<td style='cursor:Pointer;' id='txtdelete' align='center' onclick='return DeleteEmpTargetDetail(" + i + ");'><img src='image/Cross.png'> </td>";
                tbl += "<td style='cursor:Pointer;' id='txtUpdate' align='center' onclick='return EditEmpTargetDetail(" + i + ");'><img src='image/Edit.png'></td>";
                tbl += "<td style='text-align:left;display:none;' id='txtUsrID" + i + "'>" + data.EmpTargetDetail[i].user_id + " </td>";
                tbl += "<td style='text-align:left; display:none' id='txtE_Name" + i + "'>" + data.EmpTargetDetail[i].E_Name + " </td>";
                tbl += "<td style='text-align:left;' id='txtstartdate" + i + "'>" + data.EmpTargetDetail[i].startdate + " </td>";
                tbl += "<td style='text-align:left;' id='txtenddate" + i + "'>" + data.EmpTargetDetail[i].enddate + " </td>";
                tbl += "<td style='text-align:left;' id='StartTimes" + i + "'>" + data.EmpTargetDetail[i].StartTime + " </td>";
                tbl += "<td style='text-align:left;' id='EndTimes" + i + "'>" + data.EmpTargetDetail[i].EndTime + " </td>";
                tbl += "<td style='text-align:left;' id='txtTargetName" + i + "'>" + data.EmpTargetDetail[i].tt_name + " </td>";
                tbl += "<td style='text-align:left;' id='txtNoOfTarget" + i + "'>" + data.EmpTargetDetail[i].actual_target + " </td>";
                tbl += "<td style='text-align:left;' id='txtEvaluationOn" + i + "'>" + data.EmpTargetDetail[i].Evaluation_on + " </td>";
                tbl += "<td style='text-align:left;' id='txtTargetSettingID" + i + "'>" + data.EmpTargetDetail[i].ts_id + "</td>";
                tbl += "<td style='text-align:left;display:none' id='txtTargetID" + i + "'>" + data.EmpTargetDetail[i].tt_id + "</td>";
                tbl += "</tr>";
            }

            tbl += "</tbody>";
            tbl += "</table>";

            $("#tblAddTarget").html(tbl);

        }


        //-----------------------------------------------------Save Target---------------------------------------------------------------------------      
        function SaveTargetNew() {

            var tblLength = $("#tblAddTarget tr").length - 1;
            var result = "";
            var settingID = $("input[id$='txtTagerSettingID']").val();
            for (i = 0; i < tblLength; i++) {
                result += $("#txtUserID" + i).html() + "*" + $("#txtStartDt" + i).html() + "*" + $("#txtEndDt" + i).html() + "*" + $("#txtStartTM" + i).html() + "*" + $("#txtEndTM" + i).html() + "*" + $("#txtNoOfTarget" + i).html() + "*" + $("#txtTargetID" + i).html() + "*" + $("#txtEvaluationOn" + i).html() + "*" + $("#txtTargetSettingID" + i).html() + "~";
            }
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "frmSetTarget_New.aspx/SaveEmpTargetNew",
                data: "{'result':'" + result + "','settingID':'" + settingID + "'}",
                success: onsaveTargetNew,
                error: onretrieveErrorNew
            });
            return false;
        }

        function onsaveTargetNew() {
            alert("Recorded Successfully Saved!");
                HideDiv();
             GetEmployeeTargetList();
            return false;

        }
        function onretrieveErrorNew(){
        
        alert("Error in Saving data!");
            return false;
        }
        function SaveTarget() {
            var uname = $("select[id$='ddlEmployeeName'] option:selected").val();
            if (uname == "--Select--") {
                alert("Please Select Employee!");
                return false;
            }
            var startDate = $("input[id$='txtStartDate']").val().trim();
            if (startDate == "") {
                alert("Please Enter Start Date!");
                return false;
            }

            var endDate = $("input[id$='txtEndDate']").val().trim();
            if (endDate == "") {
                alert("Please Enter End Date!");
                return false;
            }
            var startTime = $("select[id$='ddlhourStartTime'] option:selected").val();
            var endTime = $("select[id$='ddlhourEndTime'] option:selected").val();

            var TargetTypeID = $("select[id$='ddlTargetType'] option:selected").val();
            if (TargetTypeID == "--Select--") {
                alert("Please Select Target Type!");
                return false;
            }

            var EvaluationOn = $("select[id$='ddlEvalOn'] option:selected").val();
            if (EvaluationOn == "--Select--") {
                alert("Please Select Evaluation On!");
                return false;
            }
            var NoOFTarget = $("input[id$='txtNoOfVisits']").val().trim();
            if (NoOFTarget == "") {
                alert("Please Enter No Of Visits!");
                return false;
            }

            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "frmSetTarget_New.aspx/SaveEmpTarget",
                data: "{'uname':'" + uname + "','startDate':'" + startDate + "','endDate':'" + endDate + "','startTime':'" + startTime + "','endTime':'" + endTime + "','TargetTypeID':'" + TargetTypeID + "','EvaluationOn':'" + EvaluationOn + "','NoOFTarget':'" + NoOFTarget + "','insertionFlag':'1'}",
                success: onsave,
                error: onretrieveError
            });
            return false;
        }

        function onsave() {
        }

        function onretrieveError() {
        }

        //-----------------------------------------------------Delete Main Employee List-------------------------------------------------------------       
        function DeleteMaiEmpTargetList(setting_id) {
            $("#divAddTarget").hide();
            if (confirm("Are you sure you want to delete this record?")) {
                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "frmSetTarget_New.aspx/DeleteEmpTarget",
                    data: "{'setting_id':'" + setting_id + "'}",
                    success: onDelete,
                    error: onretrieveError
                });
                return false;
            }
            else
                return false;

        }
        function onDelete() {
            alert("Record Deleted Successfully!");
            GetEmployeeTargetList();
        }

        //---------------------------------------------------Edit Employee Target Detail-----------------------------------------------------------
        var rowNo = -1;
        function EditEmpTargetDetail(rowID) {
            rowNo = rowID;
            $("#tblAddTarget tr").css("background-color", "")
            $("#trDetailTarget" + rowID).css("background-color", "#f7b64b")
            $("select[id$='ddlEmployeeName']").val($("#txtUsrID" + rowID).html().trim());
            $("input[id$='txtStartDate']").val($("#txtstartdate" + rowID).html());
            $("input[id$='txtEndDate']").val($("#txtenddate" + rowID).html());
            $("select[id$='ddlhourStartTime']").val($("#StartTimes" + rowID).html().trim());
            $("select[id$='ddlhourEndTime']").val($("#EndTimes" + rowID).html().trim());
            $("select[id$='ddlTargetType']").val($("#txtTargetID" + rowID).html().trim());
            $("select[id$='ddlEvalOn']").val($("#txtEvaluationOn" + rowID).html().trim());
            $("input[id$='txtNoOfVisits']").val($("#txtNoOfTarget" + rowID).html());
            // $("input[id$='txtTagerSettingID']").val($("#txtTargetSettingID"+rowID).html())
            //$("#divJQModal").jqmHide();
        }

        function DeleteEmpTargetDetail(rowID) {
            var ts_id = $("#txtTargetSettingID" + rowID).html();
            if (confirm("Are you sure you want to delete this record?")) {
                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "frmSetTarget_New.aspx/DeleteEmpTargetDetail",
                    data: "{'ts_id':'" + ts_id + "'}",
                    success: onDeleteEmpTargetDtail,
                    error: onretrieveError
                });
                return false;
            }
            else
                return false;
        }

        function onDeleteEmpTargetDtail() {
            alert("Record Deleted Successfully!");
            return showDetailEmpTarget(TID);
            TID = 0;
        }



        //---------------------------------------------------------Update Employee Target Deatil------------------------------------------------- 
        function UpdateEmpTargetDetail() {
            var TargetSettingID = $("input[id$='txtTagerSettingID']").val();
            var TargetTypeID = $("select[id$='ddlTargetType'] option:selected").val();
            if (TargetTypeID == "--Select--") {
                alert("Please Select Target Type!");
                return false;
            }

            var EvaluationOn = $("select[id$='ddlEvalOn'] option:selected").val();
            if (EvaluationOn == "--Select--") {
                alert("Please Select Evaluation On!");
                return false;
            }
            var NoOFTarget = $("input[id$='txtNoOfVisits']").val().trim();
            if (NoOFTarget == "") {
                alert("Please Enter No Of Visits!");
                return false;
            }

            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "frmSetTarget_New.aspx/UpdateEmpTarget",
                data: "{'TargetSettingID':'" + TargetSettingID + "','TargetTypeID':'" + TargetTypeID + "','EvaluationOn':'" + EvaluationOn + "','NoOFTarget':'" + NoOFTarget + "'}",
                success: onUpdate,
                error: onretrieveError
            });
            return false;

        }
        function onUpdate() {
            alert("Record Update Successfully!");
            return false;

        }
    </script>

</asp:Content>

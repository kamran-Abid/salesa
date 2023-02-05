<%@ Page Language="C#" MasterPageFile="~/MCTX_Internal/SuperAdmin/MasterAdmin.master"
    AutoEventWireup="true" CodeFile="frmEmpUser.aspx.cs" Inherits="MCTX_Internal_SuperAdmin_frmEmpUser"
    Title="Users Information" %>

<%@ Register Assembly="RJS.Web.WebControl.PopCalendar.Net.2008" Namespace="RJS.Web.WebControl"
    TagPrefix="rjs" %>
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
            <li style="text-align: left"><a href="#tabs-1">User Information</a></li>
        </ul>
        <fieldset style="width: 95%">
            <legend style="text-align: left;">Add User Information</legend>
            <table style="width: 100%; font-family: Calibri; font-size: 11pt;">
                <tr>
                    <td align="left" style="width: 140px;">
                        <asp:Label ID="lblEmployee" Text="Select Employee:" runat="server"></asp:Label>
                    </td>
                    <td align="left" style="width: 140px;">
                        <asp:DropDownList ID="ddlEmployee" OnChange="return CheckUser();" Width="90%" runat="server">
                        </asp:DropDownList>
                    </td>
                    <td align="left" style="width: 140px;">
                        <asp:Label ID="lblRole" Text="Select Role:" runat="server"></asp:Label>
                    </td>
                    <td align="left" style="width: 140px;">
                        <asp:DropDownList ID="ddlRole" Width="90%" runat="server">
                        </asp:DropDownList>
                    </td>
                    <td>
                    </td>
                </tr>
                <tr>
                    <td align="left" style="width: 140px;">
                        <asp:Label ID="lblUsername" Text="Username:" runat="server"></asp:Label>
                    </td>
                    <td align="left" style="width: 140px;">
                        <asp:TextBox ID="txtUsername" Width="90%" MaxLength="8" onkeypress="return keyRestrict(event,'abcdefghijklmnopqrstuvwxyz0123456789-')"
                            runat="server"></asp:TextBox>
                    </td>
                    <td align="left" style="width: 140px;">
                        <asp:Button ID="btnAvailable" Text="Check Availability" Style="background-color: Green;
                            color: White; height: 18px;" OnClientClick="return checkUsername();" runat="server" />
                    </td>
                    <td align="left" style="width: 140px;">
                    </td>
                    <td>
                    </td>
                </tr>
                <tr>
                    <td align="left" style="width: 140px;">
                        <asp:Label ID="lblPassword" Text="Password:" runat="server"></asp:Label>
                    </td>
                    <td align="left" style="width: 140px;">
                        <asp:TextBox ID="txtPassword" TextMode="Password" onchange="return PasswordStrength();"
                            MaxLength="16" onkeypress="return keyRestrict(event,'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789-@#$!%')"
                            Width="90%" runat="server"></asp:TextBox>
                    </td>
                    <td align="left" style="width: 140px;">
                        <asp:Label ID="lblConfirmPswd" Text="Confirm Password:" runat="server"></asp:Label>
                    </td>
                    <td align="left" style="width: 140px;">
                        <asp:TextBox ID="txtConfirmPswd" TextMode="Password" MaxLength="16" onkeypress="return keyRestrict(event,'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789-@#$!%')"
                            Width="90%" runat="server"></asp:TextBox>
                    </td>
                    <td style="text-align:left;font-weight:bold">
                        <span id="lblPwd" runat="server"></span>
                    </td>
                </tr>
                <tr>
                    <td align="left" style="width: 140px;">
                    </td>
                    <td align="left" style="width: 140px;">
                    </td>
                    <td align="left" style="width: 140px;">
                        <asp:Button ID="btnSave" Text="Save" Style="background-color: #2A4062; color: White;
                            width: 65px;" OnClientClick="return saveUser();" runat="server" />
                        &nbsp;
                        <asp:Button ID="btnClear" Text="Clear" Style="background-color: #2A4062; color: White;
                            width: 65px;" OnClientClick="return ClearFields();" runat="server" />
                    </td>
                    <td align="left" style="width: 140px;">
                        <asp:Button ID="btnUpdate" Text="Update" Style="background-color: #2A4062; color: White;
                            display: none; width: 65px;" OnClientClick="return updateUser();" runat="server" />
                    </td>
                    <td>
                    </td>
                </tr>
            </table>
        </fieldset>
        <br />
        <fieldset style="width: 95%">
            <legend style="text-align: left;">User Details</legend>
            <div id="divUser" style="overflow: auto; width: 902px; height: 300px;" runat="server">
                <table id="tblUser" class="dataTable">
                </table>
            </div>
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

        $(document).ready(function() {
            getUserDetails();
        });
        function dataTable() {
            oTable = $("#tblUser").dataTable({
                bPaginate: false,
                bJQueryUI: true,
                bSort: true,
                bInfo: false,
                bRetrieve: true,
                bDestroy: true,
                oLanguage: { "sSearch": "Filter: " }
            });
        }
        function CheckUser() {
            var EmployeeID = $("select[id$='ddlEmployee']").val();
            if (EmployeeID != '') {
                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "frmEmpUser.aspx/CheckUser",
                    data: "{'EmployeeID':'" + EmployeeID + "'}",
                    success: onsuccessCheckUser,
                    error: onErrorCheckUser
                });
            }
            return false;
        }
        function onsuccessCheckUser(msg) {
            var data = msg.d;
            if (data == 1) {
                alert("Employee Is Already User!");
                $("select[id$='ddlEmployee']").val('');
                return false;
            }
            return false;
        }
        function onErrorCheckUser() {
            alert("Error In Checking Employee!");
            return false;
        }
        function checkUsername() {
            var Username = $("input[id$='txtUsername']").val();
            if (Username == "") {
                alert("Please Enter Desired Username!");
                return false;
            }
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "frmEmpUser.aspx/CheckEmpUsername",
                data: "{'Username':'" + Username + "'}",
                success: onsuccesscheckUsername,
                error: onErrorcheckUsername
            });
            return false;
        }
        function onsuccesscheckUsername(msg) {
            var data = msg.d;
            var Result = data;
            if (Result == 1) {
                alert("Username Not Available!");
                $("input[id$='txtUsername']").val("");
                return false;
            }
            if (Result == 0) {
                alert("Username Available!");
                return false;
            }
        }
        function onErrorcheckUsername() {
            alert("Error In Checking Data!");
            return false;
        }
        function saveUser() {
            var EmpID = $("select[id$='ddlEmployee'] option:selected").val();
            if (EmpID == "") {
                alert("Please Select Employee!");
                return false;
            }
            var RoleID = $("select[id$='ddlRole'] option:selected").val();
            if (RoleID == "") {
                alert("Please Select Employee Role!");
                return false;
            }
            var Username = $("input[id$='txtUsername']").val();
            if (Username == "") {
                alert("Please Enter Desired Username!");
                return false;
            }
            var Password = $("input[id$='txtPassword']").val();
            if (Password == "") {
                alert("Please Enter Password!");
                return false;
            }
            var ConfirmPswd = $("input[id$='txtConfirmPswd']").val();
            if (ConfirmPswd == "") {
                alert("Please Confirm Password!");
                return false;
            }
            if (Password != ConfirmPswd) {
                alert("Passwords Don't Match!");
                return false;
            }
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "frmEmpUser.aspx/SaveUser",
                data: "{'EmpID':'" + EmpID + "','RoleID':'" + RoleID + "','Username':'" + Username + "','Password':'" + Password + "'}",
                success: onsuccessSaveUser,
                error: onErrorSaveUser
            });
            return false;
        }
        function onsuccessSaveUser() {
            alert("User Saved Successfully!");
            getUserDetails();
            ClearFields();
            return false;
        }
        function onErrorSaveUser() {
            alert("Error In Saving Record!");
            return false;
        }
        function ClearFields() {
            $("select[id$='ddlEmployee']").val("");
            $("select[id$='ddlRole']").val("");
            $("input[id$='txtUsername']").val("");
            $("input[id$='txtPassword']").val("");
            $("input[id$='txtConfirmPswd']").val("");
            $("input[id$='btnSave']").attr("disabled", false);
            $("input[id$='btnAvailable']").attr("disabled", false);
            $("input[id$='btnUpdate']").hide();
            return false;
        }
        function getUserDetails() {
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "frmEmpUser.aspx/GetUserDetails",
                data: "{}",
                success: onsuccessgetUser,
                error: onErrorgetUser
            });
            return false;
        }
        function onsuccessgetUser(msg) {
            var data = msg.d;
            if (oTable != null) {
                oTable.fnClearTable();
                oTable.fnDestroy();
            }
            var tbl = "";
            tbl += "<thead>";
            tbl += "<tr>";
            tbl += "<th id='txtDeleteth' style='cursor:Pointer;text-align:center;white-space:nowrap;border:1px solid #999999;'>Del</th>";
            tbl += "<th id='txtEditth' style='cursor:Pointer;text-align:center;white-space:nowrap;border:1px solid #999999;'>Edit</th>";
            tbl += "<th style='white-space:nowrap; text-align:left;'>Employee Name</th>";
            tbl += "<th style='white-space:nowrap; text-align:left;'>Username</th>";
            tbl += "<th style='white-space:nowrap; text-align:left; display:none;'>Emp ID</th>";
            tbl += "<th style='white-space:nowrap; text-align:left; display:none;'>Role ID</th>";
            tbl += "<th style='white-space:nowrap; text-align:left;'>Role</th>";
            tbl += "</tr>";
            tbl += "</thead>";
            tbl += "<tbody>";
            for (var i = 0; i < data.UserDetails.length; i++) {
                tbl += "<td id='txtDelete" + i + "' align='center' style='border:1px solid #999999;'> <input  type='image' src='image/Cross.png' style='width:16px; border:0px;' onclick='return DeleteUser(" + i + ");'></td>";
                tbl += "<td id='txtEdit" + i + "' align='center' style='border:1px solid #999999;'> <input  type='image' src='image/Edit.png' style='width:16px; border:0px;' onclick='return GetRowForUpdation(" + i + ");'></td>";
                tbl += "<td style='text-align:left; white-space:nowrap;' id='txtEmpName" + i + "'>" + data.UserDetails[i].E_name + "</td>";
                tbl += "<td style='text-align:left; white-space:nowrap;' id='txtUserID" + i + "'>" + data.UserDetails[i].user_id + "</td>";
                tbl += "<td style='text-align:left; white-space:nowrap; display:none;' id='txtEBadge" + i + "'>" + data.UserDetails[i].E_badge + " </td>";
                tbl += "<td style='text-align:right; white-space:nowrap; display:none;' id='txtRoleID" + i + "'>" + data.UserDetails[i].role_id + " </td>";
                tbl += "<td style='text-align:left; white-space:nowrap;' id='txtRoleName" + i + "'>" + data.UserDetails[i].role_name + " </td>";
                tbl += "</tr>";
            }

            tbl += "</tbody>";
            tbl += "</table>";
            $("#tblUser").html(tbl);
            dataTable();
            return false;
        }
        function onErrorgetUser() {
            alert("Error In Loading Details!");
            return false;
        }
        function GetRowForUpdation(rowNo) {
            var EmpID = $("#txtEBadge" + rowNo).html().trim();
            $("select[id$='ddlEmployee']").val(EmpID);
            var RoleID = $("#txtRoleID" + rowNo).html().trim();
            $("select[id$='ddlRole']").val(RoleID);
            var Username = $("#txtUserID" + rowNo).html().trim();
            $("input[id$='txtUsername']").val(Username);
            $("input[id$='btnSave']").attr("disabled", true);
            $("input[id$='btnAvailable']").attr("disabled", true);
            $("input[id$='btnUpdate']").show();
            return false;
        }
        function DeleteUser(rowNo) {
            var ID = $("#txtEBadge" + rowNo).html().trim();
            var username = $("#txtUserID" + rowNo).html().trim();
            if (confirm("Are you sure you wish to delete this Record?")) {
                $.ajax({
                    type: "POST",
                    dataType: "json",
                    contentType: "application/json; charset=utf-8",
                    url: "frmEmpUser.aspx/DeleteUserData",
                    data: "{'ID':'" + ID + "','username':'" + username + "'}",
                    success: onSuccessDelete,
                    error: OnretrieveDelError
                });
            }
            else {
                return false;
            }
            return false;
        }
        function onSuccessDelete() {
            alert("Record Successfully Deleted!");
            getUserDetails();
            ClearFields();
            return false;
        }
        function OnretrieveDelError() {
            alert("Error In Deleting Record!");
            return false;
        }
        function updateUser() {
            var EmpID = $("select[id$='ddlEmployee'] option:selected").val();
            if (EmpID == "") {
                alert("Please Select Employee!");
                return false;
            }
            var RoleID = $("select[id$='ddlRole'] option:selected").val();
            if (RoleID == "") {
                alert("Please Select Employee Role!");
                return false;
            }
            var Username = $("input[id$='txtUsername']").val();
            if (Username == "") {
                alert("Please Enter Desired Username!");
                return false;
            }
            var Password = $("input[id$='txtPassword']").val();
            if (Password == "") {
                alert("Please Enter Password!");
                return false;
            }
            var ConfirmPswd = $("input[id$='txtConfirmPswd']").val();
            if (ConfirmPswd == "") {
                alert("Please Confirm Password!");
                return false;
            }
            if (Password != ConfirmPswd) {
                alert("Passwords Don't Match!");
                return false;
            }
            if ($("span[id$='lblPwd']").text() == "Weak Password") {
                alert("Please Enter Strong Password!");
                return false;
            }
            
            $.ajax({
                type: "POST",
                dataType: "json",
                contentType: "application/json; charset=utf-8",
                url: "frmEmpUser.aspx/UpdateUserData",
                data: "{'EmpID':'" + EmpID + "','RoleID':'" + RoleID + "','Username':'" + Username + "','Password':'" + Password + "'}",
                success: onSuccessUpdate,
                error: OnretrieveUpdateError
            });
            return false;
        }
        function onSuccessUpdate() {
            alert("Record Updated Successfully!");
            getUserDetails();
            ClearFields();
            return false;
        }
        function OnretrieveUpdateError() {
            alert("Error In Updating Record!");
            return false;
        }
        function keyRestrict(e, validchars, casesensitives, onceevery, onceoneof) {

            onceevery = onceevery ? onceevery : "";
            onceoneof = onceoneof ? onceoneof : "";

            if (!validchars)
                return true;
            var key = '', keychar = '', obj = '', i = 0;
            var key = e.which ? e.which : window.event.keyCode;
            var obj = e.target ? e.target : window.event.srcElement;
            if (key == null)
                return true;
            keychar = String.fromCharCode(key);
            validchars = (validchars + onceevery + onceoneof);
            if (!casesensitives) {
                keychar = keychar.toLowerCase();
                validchars = validchars.toLowerCase();
                onceevery = onceevery.toLowerCase();
                onceoneof = onceoneof.toLowerCase();
            }
            for (i = 0; i < (onceevery + onceoneof).length; i++) {
                if (i < onceevery.length) {
                    if (obj.value.indexOf(onceevery.charAt(i)) != -1 && keychar == onceevery.charAt(i))
                        return false;
                }
                else {
                    if (obj.value.indexOf(onceoneof.charAt(i - onceevery.length)) != -1 && onceoneof.indexOf(keychar) != -1)
                        return false;
                }
            }

            if (validchars.indexOf(keychar) != -1)
                return true;

            if (key == null || key == 0 || key == 8 || key == 9 || key == 13 || key == 27)
                return true;
            return false;
        }

        function PasswordStrength() {
            var pw = $("input[id$='txtPassword']").val();
            if (pw.match(/^((?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])|(?=.*[a-z])(?=.*[A-Z])(?=.*[!@#$%&\/=?_.,:;\\-])|(?=.*[a-z])(?=.*[0-9])(?=.*[!@#$%&\/=?_.,:;\\-])|(?=.*[A-Z])(?=.*[0-9])(?=.*[!@#$%&\/=?_.,:;\\-])).{8,}$/)) {

                $("span[id$='lblPwd']").text("Strong Password");
                $("span[id$='lblPwd']").css("color", "green");
            }
            else {
                $("span[id$='lblPwd']").text("Weak Password");
                $("span[id$='lblPwd']").css("color", "red");
                return false;
            }
        }
    </script>

</asp:Content>

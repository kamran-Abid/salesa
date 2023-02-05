<%@ Page Language="C#" MasterPageFile="~/MCTX_Internal/SuperAdmin/MasterAdmin.master"
    AutoEventWireup="true" CodeFile="frmReportSetting.aspx.cs" Inherits="MCTX_Internal_SuperAdmin_frmReportSetting"
    Title="Attendance Setting Form" %>

<%@ Register Assembly="RJS.Web.WebControl.PopCalendar.Net.2008" Namespace="RJS.Web.WebControl"
    TagPrefix="rjs" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
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
    <div id="tabs" style="width: auto;">
        <ul>
            <li style="text-align: left"><a href="#tabs-1">Attendance Setting</a></li>
        </ul>
        <div id="settings" style="width: 100%;">
            <table width="100%">
                <tr>
                    <td style="width: 120px;" align="left">
                        <asp:Label ID="lblEmpName" Text="Employee Name:" runat="server"></asp:Label>
                    </td>
                    <td style="width: 140px;" align="left">
                        <asp:DropDownList ID="ddlEmpName" Width="124px" runat="server">
                        </asp:DropDownList>
                    </td>
                    <td style="width: 120px;" align="left">
                        <asp:Label ID="lblReason" Text="Reason of Leave:" runat="server"></asp:Label>
                    </td>
                    <td style="width: 140px;" align="left">
                        <asp:DropDownList ID="ddlReason" Width="124px" runat="server">
                            <asp:ListItem></asp:ListItem>
                            <asp:ListItem>Medical Leave</asp:ListItem>
                            <asp:ListItem>Casual Leave</asp:ListItem>
                            <asp:ListItem>Off Day</asp:ListItem>
                            <asp:ListItem>On Project</asp:ListItem>
                        </asp:DropDownList>
                    </td>
                </tr>
                <tr>
                    <td style="width: 120px;" align="left">
                        <asp:Label ID="lblDate" Text="Date:" runat="server"></asp:Label>
                    </td>
                    <td style="width: 140px;" align="left">
                        <asp:TextBox ID="txtDate" Width="103px" runat="server"></asp:TextBox>
                        <rjs:PopCalendar ID="rjsDate" Separator="/" Format="mm dd yyyy" Control="txtDate"
                            runat="server" Font-Names="Tahoma" />
                    </td>
                    <td style="width: 120px;" align="left">
                    </td>
                    <td style="width: 140px;" align="left">
                        <asp:Button ID="btnSubmit" Text="Submit" OnClientClick="return reportinsert();" runat="server" Style="background-color: #2A4062;
                                color: White;" Width="104px" />
                    </td>
                </tr>
            </table>
        </div>

        <script type="text/javascript" language="javascript">
    var oTable;
    $(document).ready(function(){
            
    });
        function reportinsert()
        {
            var EmpName = $("select[id$='ddlEmpName'] option:selected").val();
            var Reason = $("select[id$='ddlReason'] option:selected").val();
            var Date = $("input[id$='txtDate']").val();
            if (EmpName == "")
            {
                alert("Please Select Employee!");
                return false;
            }
            if (Reason == "")
            {
                alert("Please Select Appropriate Reason!");
                return false;
            }
            if (Date == "")
            {
                alert("Please Provide Desired Date!");
                return false;
            }
            $.ajax({
                type: "POST",
                contentType:"application/json; charset=utf-8",
                url: "frmReportSetting.aspx/ReportInsert", 
                data: "{'EmpName':'"+EmpName+"','Reason':'"+Reason+"','Date':'"+Date+"'}", 
                success:onsuccessinsert,
                error:onretrieveinsertError 
                });
             return false; 
        }
        function onsuccessinsert()
        {
            alert("Data Submitted Successfully!");
            return false;
        }
        function onretrieveinsertError()
        {
            alert("Error In Data Insertion!");
            return false;
        } 
        
        </script>

    </div>
</asp:Content>

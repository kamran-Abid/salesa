<%@ Page Title="" Language="C#" MasterPageFile="~/MCTX_Internal/SuperAdmin/MasterAdmin.master" AutoEventWireup="true" CodeFile="DailyWorkingReport.aspx.cs" Inherits="MCTX_Internal_SuperAdmin_DailyWorkingReport" %>


<%@ Register Assembly="RJS.Web.WebControl.PopCalendar.Net.2008" Namespace="RJS.Web.WebControl"
    TagPrefix="rjs" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    
    <script src="../../js/jquery.dataTables.min.js" type="text/javascript"></script>
    <script src="../../js/BlockUI.js" type="text/javascript"></script>



    <br />
    <br />
    <br />


            <table style="width: 100%" >
                <tr>
                    <td>Employee Name:</td>
                    <td> <asp:DropDownList ID="empddl" runat="server" Style="width:200px; height:30px;"></asp:DropDownList></td>

                   <td> Date:</td>
                    <td>
                        <asp:TextBox ID="txtDate" runat="server" Class="attenDate" Style="width:200px; height:30px;"></asp:TextBox>
                         <rjs:PopCalendar ID="rjsToDate" Separator="/" Format="mm dd yyyy" Control="txtDate"
                                runat="server" Font-Names="Tahoma" />
                    </td>
                   
                </tr>
               
            </table>
         <%--<asp:Button ID="btnSearch" runat="server" Text="Search" OnClientClick="workingSearch()" Width="74px"/>--%>

    <input type="button" id="btnSearch" onclick="workingSearch()" value ="Search" />
    <br />
    <br />
    <input type="button" id="btnExport" onclick="fnExcelReport('tblRecord')" value ="Export to Excel" />
    <br />
    <br />
    <table id="tblRecord" style="align-content:center;width:100%; border: 1px solid black;  text-align: left;border-collapse: collapse">
<%--        <tr>
            <th>No.</th>
            <th>Employee Name</th>
            <th>Time In</th>
            <th>Time Out</th>
            <th>My Output</th>
            <th>Current Time</th>
            <th>Contact Seniour</th>
        </tr>--%>
    </table>
         
    <script type="text/javascript"> 


        function fnExcelReport(Table_id) {
            var tab_text = "<table border='2px'><tr bgcolor='#87AFC6'>";
            var textRange; var j = 0;
            tab = document.getElementById(Table_id); // id of table
            for (j = 0 ; j < tab.rows.length ; j++) {
                tab_text = tab_text + tab.rows[j].innerHTML + "</tr>";
                //tab_text=tab_text+"</tr>";
            }
            tab_text = tab_text + "</table>";
            tab_text = tab_text.replace(/<A[^>]*>|<\/A>/g, "");//remove if u want links in your table
            tab_text = tab_text.replace(/<img[^>]*>/gi, ""); // remove if u want images in your table
            tab_text = tab_text.replace(/<input[^>]*>|<\/input>/gi, ""); // reomves input params
            var ua = window.navigator.userAgent;
            var msie = ua.indexOf("MSIE ");
            if (msie > 0 || !!navigator.userAgent.match(/Trident.*rv\:11\./))      // If Internet Explorer
            {
                txtArea1.document.open("txt/html", "replace");
                txtArea1.document.write(tab_text);
                txtArea1.document.close();
                txtArea1.focus();
                sa = txtArea1.document.execCommand("SaveAs", true, "Say Thanks to Sumit.xls");
            }
            else                 //other browser not tested on IE 11
                sa = window.open('data:application/vnd.ms-excel,' + encodeURIComponent(tab_text));
            return (sa);
        }

        function workingSearch() {

           var EmployeeId = $("select[id$='empddl'] option:selected").val();
            var Date = $("input[id$='txtDate']").val();
          //  alert(EmployeeId+':'+Date);


            $.ajax({
                 type: "POST",
                dataType: "json",
                contentType: "application/json; charset=utf-8",
                url: "DailyWorkingReport.aspx/NewGetData",
                async: false,
                //data: "{}",
                data: "{'employee_id':'" + EmployeeId + "','Date':'" + Date + "'}",
                success: OnSuccessEmpRecords,
                error: OnErrorGetVisits
            });
            return false;
        }


        function OnSuccessEmpRecords(msg) {

            var data = msg.d;
            var tbl = "";
            tbl += "<thead>";
            tbl += "<tr>";

            tbl += " <th style='border: 1px solid black;'>No.</th>";
            tbl += " <th style='border: 1px solid black;'>Name</th>";
            tbl += " <th style='border: 1px solid black;'>Check In</th>";
            tbl += " <th style='border: 1px solid black;'>Check Out</th>";
            tbl += "<th style='border: 1px solid black;'>My Output</th>";
            tbl += " <th style='border: 1px solid black;'>Date</th>";
            tbl += " <th style='border: 1px solid black;'>From</th>";
            tbl += " <th style='border: 1px solid black;'>To </th>";
            tbl += " <th style='border: 1px solid black;'>Project</th>";
            tbl += " <th style='border: 1px solid black;'>Task Detail</th>";
            tbl += "<th style='border: 1px solid black;'>Contact Seniour</th>";
            tbl += "</tr>";
            tbl += "</thead>";

            tbl += "<tbody>";
            var sum=1;
            for (var i = 0; i < data.employeeRecord.length; i++) {
                //sum = i + 1;
                tbl += "<tr>";
                tbl += "<td style='border: 1px solid black;'> " + sum + "</td>";
                tbl += "<td style='border: 1px solid black;'> " + data.employeeRecord[i].Empl_id + "</td>";
                tbl += "<td style='border: 1px solid black;'> " + data.employeeRecord[i].Time_in + "</td>";
                tbl += "<td style='border: 1px solid black;'> " + data.employeeRecord[i].Time_out + "</td>";
                tbl += "<td style='border: 1px solid black;'> " + data.employeeRecord[i].My_ouput + "</td>";
                tbl += "<td style='border: 1px solid black;'> " + data.employeeRecord[i].Current_date1 + "</td>";
                tbl += "<td style='border: 1px solid black;'> " + data.employeeRecord[i].fromTime + "</td>";
                tbl += "<td style='border: 1px solid black;'> " + data.employeeRecord[i].toTime + "</td>";
                tbl += "<td style='border: 1px solid black;'> " + data.employeeRecord[i].Proj_Name + "</td>";
                tbl += "<td style='border: 1px solid black;'> " + data.employeeRecord[i].TaskDetails + "</td>";
                tbl += "<td style='border: 1px solid black;'> " + data.employeeRecord[i].contacted_seniour + "</td>";
                tbl += "</tr>";
                sum++

            }
          
            tbl += "</tbody>";
            $("#tblRecord").html(tbl);
            
           // $("#tblRecord").show();

        }

        function OnErrorGetVisits(msg) {
            alert("Error in loading  reports   " + msg.responseText);
        }

    </script>
  

</asp:Content>


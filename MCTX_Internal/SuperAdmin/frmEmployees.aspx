<%@ Page Language="C#" MasterPageFile="~/MCTX_Internal/SuperAdmin/MasterAdmin.master"
    AutoEventWireup="true" CodeFile="frmEmployees.aspx.cs" Inherits="MCTX_Internal_SuperAdmin_frmEmployees"
    Title="Employee Information" %>

<%@ Register Assembly="RJS.Web.WebControl.PopCalendar.Net.2008" Namespace="RJS.Web.WebControl"
    TagPrefix="rjs" %>
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
        td
        {
            text-align: left;
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
            width: 190px;
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
    <div id="tabs" style="width: 100%;">
        <ul>
            <li style="text-align: left"><a href="#tabs-1">Employee Information</a></li>
        </ul>
        <fieldset style="width: 95%">
            <legend style="text-align: left;">Add Employee Information</legend>
            <fieldset style="width: 95%">
                <legend>Personal Info</legend>
                <table style="width: 100%; font-family: Calibri; font-size: 11pt;">
                    <tr>
                        <td align="left" style="width: 140px;">
                            <asp:Label ID="lblEmpID" Text="Employee ID:" runat="server"></asp:Label>
                        </td>
                        <td align="left" style="width: 140px;">
                            <asp:TextBox ID="txtEmpID" Width="90%" MaxLength="20" Text="MCTX-City-XXXX" onkeypress="return keyRestrict(event,'abcdefghijklmnopqrstuvwxyz0123456789- ')"
                                onBlur="return checkEBadge();" runat="server"></asp:TextBox>
                        </td>
                        <td align="left" style="width: 140px;">
                            <asp:Label ID="lblEmpName" Text="Employee Name:" runat="server"></asp:Label>
                        </td>
                        <td align="left" style="width: 140px;">
                            <asp:TextBox ID="txtEmpName" Width="90%" MaxLength="30" onkeypress="return keyRestrict(event,'abcdefghijklmnopqrstuvwxyz ')"
                                runat="server"></asp:TextBox>
                        </td>
                        <td align="left" style="width: 140px;">
                            <asp:Label ID="lblGender" Text="Select Gender:" runat="server"></asp:Label>
                        </td>
                        <td align="left" style="width: 140px;">
                            <asp:DropDownList ID="ddlGender" Width="90%" runat="server">
                                <asp:ListItem></asp:ListItem>
                                <asp:ListItem Text="Male" Value="1"></asp:ListItem>
                                <asp:ListItem Text="Female" Value="2"></asp:ListItem>
                            </asp:DropDownList>
                        </td>
                    </tr>
                    <tr>
                        <td align="left" style="width: 140px;">
                            <asp:Label ID="lblDOB" Text="DOB:" runat="server"></asp:Label>
                        </td>
                        <td align="left" style="width: 140px;">
                            <asp:TextBox ID="txtDOB" Width="106px" runat="server"></asp:TextBox>
                            <rjs:PopCalendar ID="rjsDOB" Separator="/" Format="mm dd yyyy" Control="txtDOB" runat="server"
                                Font-Names="Tahoma" />
                        </td>
                        <td align="left" style="width: 140px;">
                            <asp:Label ID="lblEducation" Text="Education:" runat="server"></asp:Label>
                        </td>
                        <td align="left" style="width: 140px;">
                            <asp:TextBox ID="txtEducation" MaxLength="18" Width="90%" onkeypress="return keyRestrict(event,'abcdefghijklmnopqrstuvwxyz.() ')"
                                runat="server"></asp:TextBox>
                        </td>
                        <td align="left" style="width: 140px;">
                            <asp:Label ID="lblPhone" Text="Phone Number:" runat="server"></asp:Label>
                        </td>
                        <td align="left" style="width: 140px;">
                            <asp:TextBox ID="txtPhone" Width="90%" MaxLength="16" onkeypress="return keyRestrict(event,'0123456789+')"
                                runat="server"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td align="left" style="width: 140px;">
                            <asp:Label ID="lblCell" Text="Cell Phone:" runat="server"></asp:Label>
                        </td>
                        <td align="left" style="width: 140px;">
                            <asp:TextBox ID="txtCell" Width="90%" MaxLength="16" onkeypress="return keyRestrict(event,'0123456789+')"
                                runat="server"></asp:TextBox>
                        </td>
                        <td align="left" style="width: 140px;">
                            <asp:Label ID="lblCNIC" Text="CNIC:" runat="server"></asp:Label>
                        </td>
                        <td align="left" style="width: 140px;">
                            <asp:TextBox ID="txtCNIC" Width="90%" MaxLength="20" onkeypress="return keyRestrict(event,'0123456789-')"
                                runat="server"></asp:TextBox>
                        </td>
                        <td align="left" style="width: 140px;">
                            <asp:Label ID="lblGuardPhn" Text="Guardian Phone:" runat="server"></asp:Label>
                        </td>
                        <td align="left" style="width: 140px;">
                            <asp:TextBox ID="txtGuardPhn" Width="90%" MaxLength="16" onkeypress="return keyRestrict(event,'0123456789+')"
                                runat="server"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td align="left" style="width: 140px; vertical-align: top;">
                            <asp:Label ID="lblEmergPhn" Text="Emergency Phone:" runat="server"></asp:Label>
                        </td>
                        <td align="left" style="width: 140px; vertical-align: top;">
                            <asp:TextBox ID="txtEmergPhn" Width="90%" MaxLength="16" onkeypress="return keyRestrict(event,'0123456789+')"
                                runat="server"></asp:TextBox>
                        </td>
                        <td align="left" style="width: 140px; vertical-align: top;">
                            <asp:Label ID="lblAddress" Text="Address:" runat="server"></asp:Label>
                        </td>
                        <td align="left" style="width: 140px;">
                            <asp:TextBox ID="txtAddress" Width="90%" Height="30px" TextMode="MultiLine" Style="resize: none;"
                                onkeypress="textCounter(this,this.form.counter,300); return keyRestrict(event,'abcdefghijklmnopqrstuvwxyz0123456789#.,-  /');"
                                runat="server"></asp:TextBox>
                            <input type="text" name="counter" maxlength="3" size="3" value="300" style="width: 22px;"
                                onblur="textCounter(this.form.counter,this,300);">
                            Remaining Chars
                        </td>
                    </tr>
                </table>
            </fieldset>
            <fieldset style="width: 95%">
                <legend style="text-align: left;">Official Info</legend>
                <table style="width: 100%; font-family: Calibri; font-size: 11pt;">
                    <tr>
                        <td align="left" style="width: 140px;">
                            <asp:Label ID="lblStartDate" Text="Start Date:" runat="server"></asp:Label>
                        </td>
                        <td align="left" style="width: 140px;">
                            <asp:TextBox ID="txtStartDate" Width="106px" onkeypress="return keyRestrict(event,'0123456789/')"
                                runat="server"></asp:TextBox>
                            <rjs:PopCalendar ID="rjsStartDate" Separator="/" Format="mm dd yyyy" Control="txtStartDate"
                                runat="server" Font-Names="Tahoma" />
                        </td>
                        <td align="left" style="width: 140px;">
                            <asp:Label ID="lblDept" Text="Select Department:" runat="server"></asp:Label>
                        </td>
                        <td align="left" style="width: 140px;">
                            <asp:DropDownList ID="ddlDept" Width="90%" runat="server">
                            </asp:DropDownList>
                        </td>
                        <td align="left" style="width: 140px;">
                            <asp:Label ID="lblDesg" Text="Select Designation:" runat="server"></asp:Label>
                        </td>
                        <td align="left" style="width: 140px;">
                            <asp:DropDownList ID="ddlDesg" Width="90%" runat="server">
                            </asp:DropDownList>
                        </td>
                    </tr>
                    <tr>
                        <td align="left" style="width: 140px;">
                            <asp:Label ID="lblBranch" Text="Select Branch:" runat="server"></asp:Label>
                        </td>
                        <td align="left" style="width: 140px;">
                            <asp:DropDownList ID="ddlBranch" Width="90%" runat="server">
                            </asp:DropDownList>
                        </td>
                        <td align="left" style="width: 140px;">
                            <asp:Label ID="lblBasicSal" Text="Basic Salary:" runat="server"></asp:Label>
                        </td>
                        <td align="left" style="width: 140px;">
                            <asp:TextBox ID="txtBasicSal" Width="90%" MaxLength="10" onkeypress="return keyRestrict(event,'0123456789')"
                                runat="server"></asp:TextBox>
                        </td>
                        <td align="left" style="width: 140px;">
                            <asp:Label ID="lblTravelAllow" Text="Travel Allowance:" runat="server"></asp:Label>
                        </td>
                        <td align="left" style="width: 140px;">
                            <asp:TextBox ID="txtTravelAllow" Width="90%" MaxLength="10" onkeypress="return keyRestrict(event,'0123456789')"
                                runat="server"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td align="left" style="width: 140px;">
                            <asp:Label ID="lblMobAllow" Text="Mobile Allowance:" runat="server"></asp:Label>
                        </td>
                        <td align="left" style="width: 140px;">
                            <asp:TextBox ID="txtMobAllow" Width="90%" MaxLength="10" onkeypress="return keyRestrict(event,'0123456789')"
                                runat="server"></asp:TextBox>
                        </td>
                        <td align="left" style="width: 140px;">
                            <asp:Label ID="lblOtherAllow" Text="Other Allowances:" runat="server"></asp:Label>
                        </td>
                        <td align="left" style="width: 140px;">
                            <asp:TextBox ID="txtOtherAllow" Width="90%" MaxLength="10" onkeypress="return keyRestrict(event,'0123456789')"
                                runat="server"></asp:TextBox>
                        </td>
                        <td align="left" style="width: 140px;">
                            <asp:Label ID="lblEmpType" Text="Employee Type:" runat="server"></asp:Label>
                        </td>
                        <td align="left" style="width: 140px;">
                            <asp:DropDownList ID="ddlEmpType" Width="90%" runat="server">
                            </asp:DropDownList>
                            <asp:ScriptManager ID="ScriptManager1" runat="server">
                            </asp:ScriptManager>
                        </td>
                    </tr>
                    <tr>
                        <td align="left" style="width: 140px;">
                            <asp:Label ID="Label1" Text="Employee Offical Number:" runat="server"></asp:Label>
                        </td>
                        <td align="left" style="width: 140px;">
                             <asp:TextBox ID="empOfficalNumber" Width="90%" MaxLength="11" onkeypress="return keyRestrict(event,'0123456789')"
                                runat="server"></asp:TextBox>
                        </td>

                         <td align="left" style="width: 140px;">
                            <asp:Label ID="lblEmployeeType" Text="Employee Type:" runat="server"></asp:Label>
                        </td>
                        <td align="left" style="width: 140px;">
                                 <asp:DropDownList ID="ddlEmployeeType" Width="90%" runat="server">
                                     <asp:listItem  text="Office" value="1"></asp:listItem>
                                     <asp:listItem  text="Non-Office" value="2"></asp:listItem>
                                 </asp:DropDownList>
                        </td>

                    </tr>
                    <tr>
                        <td align="left" style="width: 140px;">
                        </td>
                        <td align="left" style="width: 140px;">
                        </td>
                        <td align="left" style="width: 140px;" colspan="2">
                            <asp:Button ID="btnSave" Text="Save" Width="75px" OnClientClick="return saveEmployee();"
                                Style="background-color: #2A4062; color: White;" runat="server" />
                            <asp:Button ID="btnClear" Text="Clear" Width="75px" OnClientClick="return ClearFields();"
                                Style="background-color: #2A4062; color: White;" runat="server" />
                            <asp:Button ID="btnUpdate" Text="Update" Style="display: none; background-color: #2A4062;
                                color: White;" Width="75px" OnClientClick="return updateEmployeeData();" runat="server" />
                        </td>
                        <td align="left" style="width: 140px;">
                        </td>
                        <td align="left" style="width: 140px;">
                            <asp:TextBox ID="txtIDEmp" Style="display: none" runat="server"></asp:TextBox>
                            
                        </td>
                    </tr>
                    <tr>
                        <td colspan="5" style="text-align:right;" align="right">
                             <input type="button" id="btnExport" value=" Export Information into Excel" style="cursor:pointer" />

                        </td> <br />
                    </tr>
                </table>
            </fieldset>
            <br />
        </fieldset>
        <br />
        <fieldset style="width: 95%">
            <legend style="text-align: left;">Employee Details</legend>
           
            <div id="Div1" style="overflow: auto; width: 1200px; height: 300px;" runat="server">
                <table id="tblEmployee" class="dataTable">
                </table>
            </div>
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
        
         // $(document).ajaxStart(blockUI).ajaxStop(unblockUI);
    $(document).ready(function()
    {
        getEmployee();
        $("#btnExport").click(function (e) {
            var tab_text = "<table border='2px'><tr bgcolor='#87AFC6'>";
            var textRange; var j = 0;
            tab = document.getElementById('tblEmployee'); // id of table

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
            //  window.open('data:application/vnd.ms-excel,' + $('#divCompInfo').html());
            //e.preventDefault();
        });
    });
    
    function dataTable() {
    oTable= $("#tblEmployee").dataTable({
            bPaginate: false,
            bJQueryUI: true,
            bSort: true,
            bInfo: true,
            bRetrieve: true,
            bDestroy: true,
            oLanguage:{"sSearch":"Filter: "}               
        }).fixedHeader({ height: 300});
    }
    function saveEmployee()
    {
        var EmpID = $("input[id$='txtEmpID']").val();
        if (EmpID == "MCTX-City-XXXX")
            {
                alert("Please Enter Employee ID With Displayed Format");
                return false;  
            }
        if (EmpID == "")
            {
                alert("Please Enter Employee ID With Displayed Format");
                return false;    
            } 
        var EmpName = $("input[id$='txtEmpName']").val();
        if (EmpName == "")
            {
                alert("Please Enter Employee Name");
                return false;    
            } 
        var BranchID = $("select[id$='ddlBranch'] option:selected").val();
        if (BranchID == "")
            {
                alert("Please Select Desired Branch!");
                return false;
            }   
        var DeptID = $("select[id$='ddlDept'] option:selected").val();     
        if (DeptID == "")
            {
                alert("Please Select Desired Department!");
                return false;
            }
        var DesgID = $("select[id$='ddlDesg'] option:selected").val();
        if (DesgID == "")
            {
                alert("Please Select Desired Designation!");
                return false;
            }
        var Phone = $("input[id$='txtPhone']").val();
        var CellPhone = $("input[id$='txtCell']").val();
        if (Phone == "" && CellPhone == "")
            {
                alert("Please Enter Either Phone or Cell Phone Number!");
                return false;
            }
        var StartDate = $("input[id$='txtStartDate']").val();
        if(StartDate == "")
            {
                alert("Please Enter Start Date!");
                return false;
            }    
        var Gender = $("select[id$='ddlGender'] option:selected").text();
        if(Gender == "")
            {
                alert("Please Select Employee's Gender!");
                return false;
            }
        var Edu = $("input[id$='txtEducation']").val();
        if(Edu == "")
            {
                alert("Please Enter Employee's Education!");
                return false;
            }
        var CNIC = $("input[id$='txtCNIC']").val();
        if(CNIC == "")
            {
                alert("Please Enter Employee's CNIC!");
                return false;
            }
        var DOB = $("input[id$='txtDOB']").val();
        if(DOB == "")
            {
                alert("Please Enter Employee's DOB!");
                return false;
            }
        var Address = $("textarea[id$='txtAddress']").val();
        if (Address == "")
            {
                alert("Please Enter Address!");
                return false;
            }
        var BasicSal = $("input[id$='txtBasicSal']").val();
        if (BasicSal == "")
            {
                alert("Please Enter Basic Salary!");
                return false;
            }
        var TravelAllow = $("input[id$='txtTravelAllow']").val();
        var MobAllow = $("input[id$='txtMobAllow']").val();
        var OtherAllow = $("input[id$='txtOtherAllow']").val();
        var EmergPhone = $("input[id$='txtEmergPhn']").val();
        var GuardPhone = $("input[id$='txtGuardPhn']").val();
        var EmpType = $("select[id$='ddlEmpType'] option:selected").val();
        var Emp_officalNumber = $("input[id$='empOfficalNumber']").val();
        var Employee_Type = $("select[id$='ddlEmployeeType'] option:selected").val();
        if (EmpType == "")
            {
                alert("Please Select Employee Type!");
                return false;
            }
        $.ajax({
        type: "POST",
        contentType:"application/json; charset=utf-8",
        url: "frmEmployees.aspx/SaveEmployeeData", 
        data: "{'EmpID':'" + EmpID + "','EmpName':'" + EmpName + "','BranchID':'" + BranchID + "','DeptID':'" + DeptID + "','DesgID':'" + DesgID + "','Phone':'" + Phone + "','CellPhone':'" + CellPhone + "','StartDate':'" + StartDate + "','Gender':'" + Gender + "','Edu':'" + Edu + "','CNIC':'" + CNIC + "','DOB':'" + DOB + "','Address':'" + Address + "','BasicSal':'" + BasicSal + "','TravelAllow':'" + TravelAllow + "','MobAllow':'" + MobAllow + "','OtherAllow':'" + OtherAllow + "','EmergPhone':'" + EmergPhone + "','GuardPhone':'" + GuardPhone + "','EmpType':'" + EmpType + "','Emp_officalNumber':'" + Emp_officalNumber + "','Employee_Type':'" + Employee_Type + "'}",
        success:onsuccessSaveEmp,
        error:onErrorSaveEmp
        });
    return false;
    }
    function onsuccessSaveEmp()
    {
        alert("Data Saved Successfully!");
        getEmployee();
        ClearFields();
        return false; 
    }
    function onErrorSaveEmp()
    {
        alert("Error In Saving Data!");
        return false; 
    }
    function getEmployee()
    {
     blockUI();
        $.ajax({
        type: "POST",
        contentType:"application/json; charset=utf-8",
        url: "frmEmployees.aspx/getEmployeeData", 
        data: "{}", 
        success:onsuccessgetEmp,
        error:onErrorgetEmp
        });
        return false;
    }
    function onsuccessgetEmp(msg)
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
                tbl += "<th style='white-space:nowrap; text-align:left; display:none;'>ID</th>";
                tbl += "<th id='txtDeleteth' style='cursor:Pointer;text-align:center;white-space:nowrap;border:1px solid #999999;'>Del</th>";
                tbl += "<th id='txtEditth' style='cursor:Pointer;text-align:center;white-space:nowrap;border:1px solid #999999;'>Edit</th>";
                tbl += "<th style='white-space:nowrap; text-align:left;'>Emp ID</th>";
                tbl += "<th style='white-space:nowrap; text-align:left;'>Emp Name</th>";
                tbl += "<th style='white-space:nowrap; text-align:left;'>Gender</th>";
                tbl += "<th style='white-space:nowrap; text-align:left;'>DOB</th>";
                tbl += "<th style='white-space:nowrap; text-align:left;'>Education</th>";
                tbl += "<th style='white-space:nowrap; text-align:left;'>Phone</th>";
                tbl += "<th style='white-space:nowrap; text-align:left;'>Cell Number</th>";
                tbl += "<th style='white-space:nowrap; text-align:left;'>CNIC</th>";
                tbl += "<th style='white-space:nowrap; text-align:left;'>Address</th>";
                tbl += "<th style='white-space:nowrap; text-align:left;'>Guardian Phone</th>";
                tbl += "<th style='white-space:nowrap; text-align:left;'>Emergency Phone</th>";
                tbl += "<th style='white-space:nowrap; text-align:left;'>Start Date</th>";
                tbl += "<th style='white-space:nowrap; text-align:left; display:none;'>Dept ID</th>";
                tbl += "<th style='white-space:nowrap; text-align:left;'>Department</th>";
                tbl += "<th style='white-space:nowrap; text-align:left; display:none;'>Desg ID</th>";
                tbl += "<th style='white-space:nowrap; text-align:left;'>Designation</th>";
                tbl += "<th style='white-space:nowrap; text-align:left; display:none;'>Branch ID</th>";
                tbl += "<th style='white-space:nowrap; text-align:left;'>Branch Name</th>";
                tbl += "<th style='white-space:nowrap; text-align:left;'>Basic Sal</th>";
                tbl += "<th style='white-space:nowrap; text-align:left;'>Travel Allow</th>";
                tbl += "<th style='white-space:nowrap; text-align:left;'>Mobile Allow</th>";
                tbl += "<th style='white-space:nowrap; text-align:left;'>Other Allow</th>";
                tbl += "<th style='white-space:nowrap; text-align:left;'>Official Number</th>";
                tbl += "<th style='white-space:nowrap; text-align:left; display:none;'>Employee Type ID</th>";
                tbl += "<th style='white-space:nowrap; text-align:left;'>Employee Type</th>";
                tbl += "</tr>";
                tbl += "</thead>";
                tbl += "<tbody>";
                for (var i = 0; i < data.EmployeeDetails.length; i++) {               
                            tbl += "<td style='text-align:left; white-space:nowrap; display:none;' id='txtID"+i+"'>" + data.EmployeeDetails[i].ID + "</td>";
                            tbl += "<td id='txtDelete"+i+"' align='center' style='border:1px solid #999999;'> <input  type='image' src='image/Cross.png'  style='width:16px; border:0px;' onclick='return DeleteEmployee("+i+");'></td>";
                            tbl += "<td id='txtEdit"+i+"' align='center' style='border:1px solid #999999;'> <input  type='image' src='image/Edit.png' style='width:16px; border:0px;' onclick='return GetRowForUpdation("+i+");'></td>";
                            tbl += "<td style='text-align:left; white-space:nowrap;' id='txtEmpID"+i+"'>" + data.EmployeeDetails[i].EmpID + "</td>";   
                            tbl += "<td style='text-align:left; white-space:nowrap;' id='txtEmpName"+i+"'>" + data.EmployeeDetails[i].EmpName + "</td>";                  
                            tbl += "<td style='text-align:left; white-space:nowrap;' id='txtGender"+i+"'>" + data.EmployeeDetails[i].Gender + " </td>";
                            tbl += "<td style='text-align:right; white-space:nowrap;' id='txtDOB"+i+"'>" + data.EmployeeDetails[i].DOB + " </td>";
                            tbl += "<td style='text-align:left; white-space:nowrap;' id='txtEducation"+i+"'>" +  data.EmployeeDetails[i].Education + " </td>";
                            tbl += "<td style='text-align:right; white-space:nowrap;' id='txtPhone"+i+"'>" +  data.EmployeeDetails[i].Phone + " </td>";  
                            tbl += "<td style='text-align:right; white-space:nowrap;' id='txtCellNumber"+i+"'>" + data.EmployeeDetails[i].CellNumber + " </td>";
                            tbl += "<td style='text-align:right; white-space:nowrap;' id='txtCNIC"+i+"'>" +  data.EmployeeDetails[i].CNIC + " </td>";
                            tbl += "<td style='text-align:left; white-space:nowrap;' id='txtAddress"+i+"'>" + data.EmployeeDetails[i].Address + " </td>";  
                            tbl += "<td style='text-align:right; white-space:nowrap;' id='txtGuardPhone"+i+"'>" +  data.EmployeeDetails[i].GaurdPhone + " </td>";                
                            tbl += "<td style='text-align:right; white-space:nowrap;' id='txtEmergPhone"+i+"'>" +  data.EmployeeDetails[i].EmergPhone + " </td>";
                            tbl += "<td style='text-align:right; white-space:nowrap;' id='txtStartDate"+i+"'>" + data.EmployeeDetails[i].StartDate + " </td>";
                            tbl += "<td style='text-align:right; white-space:nowrap; display:none;' id='txtDeptID"+i+"'>" +  data.EmployeeDetails[i].DeptID + " </td>";
                            tbl += "<td style='text-align:left; white-space:nowrap;' id='txtDeptName"+i+"'>" +  data.EmployeeDetails[i].DeptName + " </td>";
                            tbl += "<td style='text-align:right; white-space:nowrap; display:none;' id='txtDesgID"+i+"'>" +  data.EmployeeDetails[i].DesgID + " </td>";
                            tbl += "<td style='text-align:left; white-space:nowrap;' id='txtDesg"+i+"'>" +  data.EmployeeDetails[i].Desg + " </td>";
                            tbl += "<td style='text-align:right; white-space:nowrap; display:none;' id='txtBranchID"+i+"'>" +  data.EmployeeDetails[i].BranchID + " </td>";
                            tbl += "<td style='text-align:left; white-space:nowrap;' id='txtBranchName"+i+"'>" +  data.EmployeeDetails[i].BranchName + " </td>";
                            tbl += "<td style='text-align:right; white-space:nowrap;' id='txtBasicSal"+i+"'>" +  data.EmployeeDetails[i].BasicSal + " </td>";
                            tbl += "<td style='text-align:right; white-space:nowrap;' id='txtTravelAllow"+i+"'>" +  data.EmployeeDetails[i].TravelAllow + " </td>";
                            tbl += "<td style='text-align:right; white-space:nowrap;' id='txtMobAllow"+i+"'>" + data.EmployeeDetails[i].MobAllow + " </td>";
                            tbl += "<td style='text-align:right; white-space:nowrap;' id='txtOtherAllow" + i + "'>" + data.EmployeeDetails[i].OtherAllow + " </td>";
                            tbl += "<td style='text-align:right; white-space:nowrap;' id='Emp_offcial_Number" + i + "'>" + data.EmployeeDetails[i].Emp_offcial_Number + " </td>";
                            tbl += "<td style='text-align:right; white-space:nowrap; display:none;' id='txtEmpTypeID"+i+"'>" + data.EmployeeDetails[i].EmpTypeID + " </td>";
                            tbl += "<td style='text-align:left; white-space:nowrap;' id='txtEmpType"+i+"'>" + data.EmployeeDetails[i].EmpType + " </td>";
                      tbl += "</tr>";
                }   

                tbl += "</tbody>";
                tbl += "</table>";
                $("#tblEmployee").html(tbl);
                unblockUI();
                dataTable();
                return false;   
    }
    function onErrorgetEmp()
    {
        alert("Error In Loading Employee Details!");
        return false;
    }
    function DeleteEmployee(rowNo)
    {
        var ID = $("#txtID"+rowNo).html().trim();
        if (confirm("Are you sure you wish to delete this Record?"))
        {
            $.ajax({
                   type: "POST",
                   dataType: "json",
                   contentType: "application/json; charset=utf-8",
                   url: "frmEmployees.aspx/DeleteEmployeeData",
                   data: "{'ID':'"+ID+"'}",
                   success: onSuccessDelete,
                   error:OnretrieveError 
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
        alert("Record Successfully Deleted!");
        getEmployee();
        ClearFields();
        return false;
    }
    function OnretrieveError()
    {
        alert("Error In Deleting Record!");
        return false;
    }
    function ClearFields()
    {
        $("input[id$='txtEmpID']").val("MCTX-City-XXXX");
        $("input[id$='txtEmpName']").val("");
        $("input[id$='txtEmpID']").attr("disabled", false);
        $("select[id$='ddlBranch']").val("");
        $("select[id$='ddlDept']").val("");
        $("select[id$='ddlDesg']").val("");
        $("input[id$='txtPhone']").val("");
        $("input[id$='txtCell']").val("");
        $("input[id$='txtStartDate']").val("");
        $("select[id$='ddlGender']").val("");
        $("input[id$='txtEducation']").val(""); 
        $("input[id$='txtCNIC']").val("");
        $("input[id$='txtDOB']").val("");
        $("textarea[id$='txtAddress']").val("");
        $("input[id$='txtBasicSal']").val("");
        $("input[id$='txtTravelAllow']").val("");
        $("input[id$='txtMobAllow']").val("");
        $("input[id$='txtOtherAllow']").val("");
        $("input[id$='txtEmergPhn']").val("");
        $("input[id$='txtGuardPhn']").val("");
        $("select[id$='ddlEmpType']").val("");
        $("input[id$='btnUpdate']").hide();
        $("input[id$='empOfficalNumber']").val("");
        $("input[id$='btnSave']").attr("disabled", false);
        
        return false;
    }
    function GetRowForUpdation(rowNo)
    {
        var ID = $("#txtID"+rowNo).html().trim();
        $("input[id$='txtIDEmp']").val(ID);
        var EmpID = $("#txtEmpID"+rowNo).html().trim();
        $("input[id$='txtEmpID']").val(EmpID);
        $("input[id$='txtEmpID']").attr("disabled", true);
        var EmpName = $("#txtEmpName"+rowNo).html().trim();
        $("input[id$='txtEmpName']").val(EmpName);
        var Gender = $("#txtGender"+rowNo).html().trim();
        var Sex = "";
        if (Gender == "Male")
            {
                Sex = 1;
            }
        if (Gender == "Female")
            {
                Sex = 2;
            }
        $("select[id$='ddlGender']").val(Sex);
        var DOB = $("#txtDOB"+rowNo).html().trim();
        $("input[id$='txtDOB']").val(DOB);
        var Edu = $("#txtEducation"+rowNo).html().trim();
        $("input[id$='txtEducation']").val(Edu); 
        var Phone = $("#txtPhone"+rowNo).html().trim();
        $("input[id$='txtPhone']").val(Phone);
        var CellPhone = $("#txtCellNumber"+rowNo).html().trim();
        $("input[id$='txtCell']").val(CellPhone);
        var CNIC = $("#txtCNIC"+rowNo).html().trim();
        $("input[id$='txtCNIC']").val(CNIC);
        var Address = $("#txtAddress"+rowNo).html().trim();
        $("textarea[id$='txtAddress']").val(Address);
        var GuardPhone = $("#txtGuardPhone"+rowNo).html().trim();
        $("input[id$='txtGuardPhn']").val(GuardPhone);
        var EmergPhone = $("#txtEmergPhone"+rowNo).html().trim();
        $("input[id$='txtEmergPhn']").val(EmergPhone);
        var StartDate = $("#txtStartDate"+rowNo).html().trim();
        $("input[id$='txtStartDate']").val(StartDate);
        var DeptID = $("#txtDeptID"+rowNo).html().trim();
        $("select[id$='ddlDept']").val(DeptID);
        var DesgID = $("#txtDesgID"+rowNo).html().trim();
        $("select[id$='ddlDesg']").val(DesgID);
        var BranchID = $("#txtBranchID"+rowNo).html().trim();
        $("select[id$='ddlBranch']").val(BranchID);
        var BasicSal = $("#txtBasicSal"+rowNo).html().trim();
        $("input[id$='txtBasicSal']").val(BasicSal);
        var TravelAllow = $("#txtTravelAllow"+rowNo).html().trim();
        $("input[id$='txtTravelAllow']").val(TravelAllow);
        var MobAllow = $("#txtMobAllow"+rowNo).html().trim();
        $("input[id$='txtMobAllow']").val(MobAllow);
        var OtherAllow = $("#txtOtherAllow"+rowNo).html().trim();
        $("input[id$='txtOtherAllow']").val(OtherAllow);
        var EmpTypeID = $("#txtEmpTypeID"+rowNo).html().trim();
        $("select[id$='ddlEmpType']").val(EmpTypeID);
        $("input[id$='empOfficalNumber']").val($("#Emp_offcial_Number" + rowNo).html().trim());
        $("input[id$='btnUpdate']").show();
        $("input[id$='btnSave']").attr("disabled", true);
        return false;
    }
    function updateEmployeeData()
    {
        var ID = $("input[id$='txtIDEmp']").val();
        var EmpID = $("input[id$='txtEmpID']").val();
        if (EmpID == "MCTX-City-XXXX")
            {
                alert("Please Enter Employee ID With Displayed Format");
                return false;  
            }
        if (EmpID == "")
            {
                alert("Please Enter Employee ID With Displayed Format");
                return false;    
            } 
        var EmpName = $("input[id$='txtEmpName']").val();
        if (EmpName == "")
            {
                alert("Please Enter Employee Name");
                return false;    
            } 
        var BranchID = $("select[id$='ddlBranch'] option:selected").val();
        if (BranchID == "")
            {
                alert("Please Select Desired Branch!");
                return false;
            }   
        var DeptID = $("select[id$='ddlDept'] option:selected").val();     
        if (DeptID == "")
            {
                alert("Please Select Desired Department!");
                return false;
            }
        var DesgID = $("select[id$='ddlDesg'] option:selected").val();
        if (DesgID == "")
            {
                alert("Please Select Desired Designation!");
                return false;
            }
        var Phone = $("input[id$='txtPhone']").val();
        var CellPhone = $("input[id$='txtCell']").val();
        if (Phone == "" && CellPhone == "")
            {
                alert("Please Enter Either Phone or Cell Phone Number!");
                return false;
            }
        var StartDate = $("input[id$='txtStartDate']").val();
        if(StartDate == "")
            {
                alert("Please Enter Start Date!");
                return false;
            }    
        var Gender = $("select[id$='ddlGender'] option:selected").text();
        if(Gender == "")
            {
                alert("Please Select Employee's Gender!");
                return false;
            }
        var Edu = $("input[id$='txtEducation']").val();
        if(Edu == "")
            {
                alert("Please Enter Employee's Education!");
                return false;
            }
        var CNIC = $("input[id$='txtCNIC']").val();
        if(CNIC == "")
            {
                alert("Please Enter Employee's CNIC!");
                return false;
            }
        var DOB = $("input[id$='txtDOB']").val();
        if(DOB == "")
            {
                alert("Please Enter Employee's DOB!");
                return false;
            }
        var Address = $("textarea[id$='txtAddress']").val();
        if (Address == "")
            {
                alert("Please Enter Address!");
                return false;
            }
        var BasicSal = $("input[id$='txtBasicSal']").val();
        if (BasicSal == "")
            {
                alert("Please Enter Basic Salary!");
                return false;
            }
        var TravelAllow = $("input[id$='txtTravelAllow']").val();
        var MobAllow = $("input[id$='txtMobAllow']").val();
        var OtherAllow = $("input[id$='txtOtherAllow']").val();
        var EmergPhone = $("input[id$='txtEmergPhn']").val();
        var GuardPhone = $("input[id$='txtGuardPhn']").val();
        var EmpType = $("select[id$='ddlEmpType'] option:selected").val();
        var Emp_officalNumber = $("input[id$='empOfficalNumber']").val();

        var Employee_type = $("select[id$='ddlEmployeeType'] option:selected").val();
        if (EmpType == "")
            {
                alert("Please Select Employee Type!");
                return false;
            }
        $.ajax({
        type: "POST",
        contentType:"application/json; charset=utf-8",
        url: "frmEmployees.aspx/UpdateEmployeeData", 
        data: "{'ID':'" + ID + "','EmpID':'" + EmpID + "','EmpName':'" + EmpName + "','BranchID':'" + BranchID + "','DeptID':'" + DeptID + "','DesgID':'" + DesgID + "','Phone':'" + Phone + "','CellPhone':'" + CellPhone + "','StartDate':'" + StartDate + "','Gender':'" + Gender + "','Edu':'" + Edu + "','CNIC':'" + CNIC + "','DOB':'" + DOB + "','Address':'" + Address + "','BasicSal':'" + BasicSal + "','TravelAllow':'" + TravelAllow + "','MobAllow':'" + MobAllow + "','OtherAllow':'" + OtherAllow + "','EmergPhone':'" + EmergPhone + "','GuardPhone':'" + GuardPhone + "','EmpType':'" + EmpType + "','Emp_officalNumber':'" + Emp_officalNumber + "','Employee_type':'" + Employee_type + "'}",
        success:onsuccessUpdateEmp,
        error:onErrorUpdateEmp
        });
    return false;
    }
    function onsuccessUpdateEmp()
    {
        alert("Employee Record Updated Successfully!");
        ClearFields();
        getEmployee();
        return false;
    }
    function onErrorUpdateEmp()
    {
        alert("Error In Updating Record!");
        return false;
    }
    function checkEBadge()
    {
        var EmpID = $("input[id$='txtEmpID']").val();
        $.ajax({
        type: "POST",
        contentType:"application/json; charset=utf-8",
        url: "frmEmployees.aspx/CheckEmpID", 
        data: "{'EmpID':'"+EmpID+"'}", 
        success:onsuccesscheckEBadge,
        error:onErrorcheckEBadge
        });
    return false; 
    }
    function onsuccesscheckEBadge(msg)
    {
        var data = msg.d;
        var Result = data;
        if (Result == 1)
        {
            alert("Employee ID Not Available!");
            $("input[id$='txtEmpID']").val("");
            return false;
        }
    }
    function onErrorcheckEBadge()
    {
        return false;
    }
    
    function textCounter( field, countfield, maxlimit ) 
    {
        if ( field.value.length > maxlimit )
        {
            field.value = field.value.substring( 0, maxlimit );
            return false;
        }
        else
        {
            countfield.value = maxlimit - field.value.length;
        }
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

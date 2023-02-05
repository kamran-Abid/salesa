<%@ Page Language="C#" MasterPageFile="~/MCTX_Internal/SuperAdmin/MasterAdmin.master"
    AutoEventWireup="true" CodeFile="frmSalary.aspx.cs" Inherits="MCTX_Internal_SuperAdmin_frmSalary"
    Title="Employee Salary" %>

<%@ Register Assembly="RJS.Web.WebControl.PopCalendar.Net.2008" Namespace="RJS.Web.WebControl"
    TagPrefix="rjs" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <script src="../../js/jquery.dataTables.min.js" type="text/javascript"></script>
    <script src="../../js/BlockUI.js" type="text/javascript"></script>
    <script src="../../js/FieldValidation.js" type="text/javascript"></script>

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
    <div id="tabs" style="width: 943px;">
        <ul>
            <li style="text-align: left"><a href="#tabs-1">Salary Calculation & Details</a></li>
        </ul>
        <div id="SalarlyCalc" style="width: 100%">
            <fieldset id="fldSalaryMain" runat="server" style="width: 98%">
                <legend>Salary Calculation</legend>
                <table width="100%">
                    <tr>
                        <td align="left" style="width: 120px">
                            <asp:Label ID="lblEmpName" Text="Employee Name:" runat="server"></asp:Label>
                        </td>
                        <td align="left" style="width: 140px">
                            <asp:DropDownList ID="ddlEmpName" AutoPostBack="true" Width="124px" runat="server"
                                OnSelectedIndexChanged="ddlEmpName_SelectedIndexChanged">
                            </asp:DropDownList>
                        </td>
                        <td align="left" style="width: 120px">
                            <asp:Label ID="lblDepartment" Text="Department:" runat="server"></asp:Label>
                        </td>
                        <td align="left" style="width: 140px">
                            <asp:DropDownList ID="ddlDepartment" Width="124px" runat="server">
                            </asp:DropDownList>
                        </td>
                    </tr>
                    <tr>
                        <td align="left" style="width: 120px">
                            <asp:Label ID="lblDesg" Text="Designation:" runat="server"></asp:Label>
                        </td>
                        <td align="left" style="width: 140px">
                            <asp:DropDownList ID="ddlDesignation" Width="124px" runat="server">
                            </asp:DropDownList>
                        </td>
                        <td align="left" style="width: 120px">
                            <asp:Label ID="lblBasicSal" Text="Basic Salary:" runat="server"></asp:Label>
                        </td>
                        <td align="left" style="width: 140px">
                            <asp:TextBox ID="txtBasicSal" Width="124px" ReadOnly="true" runat="server"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td align="left" style="width: 120px">
                            <asp:Label ID="lblSalMon" Text="Salary Month:" runat="server"></asp:Label>
                        </td>
                        <td align="left" style="width: 140px">
                            <asp:DropDownList ID="ddlSalMon" Width="38px" runat="server">
                                <asp:ListItem></asp:ListItem>
                                <asp:ListItem>1</asp:ListItem>
                                <asp:ListItem>2</asp:ListItem>
                                <asp:ListItem>3</asp:ListItem>
                                <asp:ListItem>4</asp:ListItem>
                                <asp:ListItem>5</asp:ListItem>
                                <asp:ListItem>6</asp:ListItem>
                                <asp:ListItem>7</asp:ListItem>
                                <asp:ListItem>8</asp:ListItem>
                                <asp:ListItem>9</asp:ListItem>
                                <asp:ListItem>10</asp:ListItem>
                                <asp:ListItem>11</asp:ListItem>
                                <asp:ListItem>12</asp:ListItem>
                            </asp:DropDownList>
                            &nbsp<asp:Label ID="lblYear" Text="Year:" runat="server"></asp:Label>
                            &nbsp<asp:TextBox ID="txtYear" Width="41px" CssClass="numberinput" runat="server"></asp:TextBox>
                        </td>
                        <td align="left" style="width: 120px">
                            <asp:Label ID="lblDaysWork" Text="Days Worked:" runat="server"></asp:Label>
                        </td>
                        <td align="left" style="width: 140px">
                            <asp:DropDownList ID="ddlDaysWorked" Width="124px" runat="server">
                                <asp:ListItem></asp:ListItem>
                                <asp:ListItem>1</asp:ListItem>
                                <asp:ListItem>2</asp:ListItem>
                                <asp:ListItem>3</asp:ListItem>
                                <asp:ListItem>4</asp:ListItem>
                                <asp:ListItem>5</asp:ListItem>
                                <asp:ListItem>6</asp:ListItem>
                                <asp:ListItem>7</asp:ListItem>
                                <asp:ListItem>8</asp:ListItem>
                                <asp:ListItem>9</asp:ListItem>
                                <asp:ListItem>10</asp:ListItem>
                                <asp:ListItem>11</asp:ListItem>
                                <asp:ListItem>12</asp:ListItem>
                                <asp:ListItem>13</asp:ListItem>
                                <asp:ListItem>14</asp:ListItem>
                                <asp:ListItem>15</asp:ListItem>
                                <asp:ListItem>16</asp:ListItem>
                                <asp:ListItem>17</asp:ListItem>
                                <asp:ListItem>18</asp:ListItem>
                                <asp:ListItem>19</asp:ListItem>
                                <asp:ListItem>20</asp:ListItem>
                                <asp:ListItem>21</asp:ListItem>
                                <asp:ListItem>22</asp:ListItem>
                                <asp:ListItem>23</asp:ListItem>
                                <asp:ListItem>24</asp:ListItem>
                                <asp:ListItem>25</asp:ListItem>
                                <asp:ListItem>26</asp:ListItem>
                            </asp:DropDownList>
                        </td>
                    </tr>
                    <tr>
                        <td align="left" style="width: 120px">
                            <asp:Label ID="lblPaidLeaves" Text="Paid Leaves:" runat="server"></asp:Label>
                        </td>
                        <td align="left" style="width: 140px">
                            <asp:TextBox ID="txtPaidLeaves" Width="124px" CssClass="numberinput" runat="server"></asp:TextBox>
                        </td>
                        <td align="left" style="width: 120px">
                            <asp:Label ID="lblUnPaidLeaves" Text="Unpaid Leaves:" runat="server"></asp:Label>
                        </td>
                        <td align="left" style="width: 140px">
                            <asp:TextBox ID="txtUnPaidLeave" Width="124px" CssClass="numberinput" runat="server"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td align="left" style="width: 120px">
                            <asp:Label ID="lblTelAllow" Text="Telephone Allowance:" runat="server"></asp:Label>
                        </td>
                        <td align="left" style="width: 140px">
                            <asp:TextBox ID="txtTelAllow" Width="124px" onBlur="return CalAllowance();" CssClass="numberinput"
                                runat="server"></asp:TextBox>
                        </td>
                        <td align="left" style="width: 120px">
                            <asp:Label ID="lblConAllow" Text="Conveyance Allowance:" runat="server"></asp:Label>
                        </td>
                        <td align="left" style="width: 140px">
                            <asp:TextBox ID="txtConAllow" Width="124px" onBlur="return CalAllowance();" CssClass="numberinput"
                                runat="server"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td align="left" style="width: 120px">
                            <asp:Label ID="lblSunAllow" Text="Sunday Allowance:" runat="server"></asp:Label>
                        </td>
                        <td align="left" style="width: 140px">
                            <asp:TextBox ID="txtSunAllow" Width="124px" onBlur="return CalAllowance();" CssClass="numberinput"
                                runat="server"></asp:TextBox>
                        </td>
                        <td align="left" style="width: 120px">
                            <asp:Label ID="lblOtherAllow" Text="Other Allowances" runat="server"></asp:Label>
                        </td>
                        <td align="left" style="width: 140px">
                            <asp:TextBox ID="txtOtherAllow" Width="124px" onBlur="return CalAllowance();" CssClass="numberinput"
                                runat="server"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td align="left" style="width: 120px">
                            <asp:Label ID="lblAllowance" Text="Allowance Amount:" runat="server"></asp:Label>
                        </td>
                        <td align="left" style="width: 140px">
                            <asp:TextBox ID="txtAllowance" Width="124px" ReadOnly="true" CssClass="numberinput"
                                runat="server"></asp:TextBox>
                        </td>
                        <td align="left" style="width: 120px">
                            <asp:Label ID="lblPaidAllow" Text="Paid Allowance:" runat="server"></asp:Label>
                        </td>
                        <td align="left" style="width: 140px">
                            <asp:TextBox ID="txtPaidAllow" Width="124px" onBlur="return CalAllowance();" CssClass="numberinput"
                                runat="server"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td align="left" style="width: 120px">
                            <asp:Label ID="lblDueAllow" Text="Due Allowance:" runat="server"></asp:Label>
                        </td>
                        <td align="left" style="width: 140px">
                            <asp:TextBox ID="txtDueAllow" Width="124px" ReadOnly="true" CssClass="numberinput"
                                runat="server"></asp:TextBox>
                        </td>
                        <td align="left" style="width: 120px">
                            <asp:Label ID="lblLoan" Text="Loan:" runat="server"></asp:Label>
                        </td>
                        <td align="left" style="width: 140px">
                            <asp:TextBox ID="txtLoan" Width="124px" onBlur="return CalDeduction();" CssClass="numberinput"
                                runat="server"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td align="left" style="width: 120px">
                            <asp:Label ID="lblOtherDeduct" Text="Other Deductions:" runat="server"></asp:Label>
                        </td>
                        <td align="left" style="width: 140px">
                            <asp:TextBox ID="txtOtherDeduct" Width="124px" onBlur="return CalDeduction();" CssClass="numberinput"
                                runat="server"></asp:TextBox>
                        </td>
                        <td align="left" style="width: 120px">
                            <asp:Label ID="lblTotalDeduct" Text="Total Deduction:" runat="server"></asp:Label>
                        </td>
                        <td align="left" style="width: 140px">
                            <asp:TextBox ID="txtTotalDeduct" Width="124px" onBlur="return CalDeduction();" CssClass="numberinput"
                                ReadOnly="true" runat="server"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td align="left" style="width: 120px">
                            <asp:Label ID="lblPaidDeduct" Text="Paid Deduction:" runat="server"></asp:Label>
                        </td>
                        <td align="left" style="width: 140px">
                            <asp:TextBox ID="txtPaidDeduct" Width="124px" onBlur="return CalDeduction();" CssClass="numberinput"
                                runat="server"></asp:TextBox>
                        </td>
                        <td align="left" style="width: 120px">
                            <asp:Label ID="lblDueDeduct" Text="Due Deduction:" runat="server"></asp:Label>
                        </td>
                        <td align="left" style="width: 140px">
                            <asp:TextBox ID="txtDueDeduct" Width="124px" onBlur="return CalcSal();" CssClass="numberinput"
                                ReadOnly="true" runat="server"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td align="left" style="width: 120px">
                            <asp:Label ID="lblFinalSal" Text="Final Salary:" runat="server"></asp:Label>
                        </td>
                        <td align="left" style="width: 140px">
                            <asp:TextBox ID="txtFinalSal" Width="124px" onBlur="return CalcSal();" CssClass="numberinput"
                                ReadOnly="true" runat="server"></asp:TextBox>
                        </td>
                        <td align="left" style="width: 120px">
                            <asp:Label ID="lblPaidSal" Text="Paid Salary:" runat="server"></asp:Label>
                        </td>
                        <td align="left" style="width: 140px">
                            <asp:TextBox ID="txtPaidSal" Width="124px" onBlur="return CalcSal();" CssClass="numberinput"
                                runat="server"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td align="left" style="width: 120px">
                            <asp:Label ID="lblDueSal" Text="Due Salary:" runat="server"></asp:Label>
                        </td>
                        <td align="left" style="width: 140px">
                            <asp:TextBox ID="txtDueSal" Width="124px" ReadOnly="true" CssClass="numberinput"
                                runat="server"></asp:TextBox>
                        </td>
                        <td align="left" style="width: 120px">
                            <asp:Label ID="lblSalDate" Text="Salary Paid On:" runat="server"></asp:Label>
                        </td>
                        <td align="left" style="width: 140px">
                            <asp:TextBox ID="txtSalDate" Width="104px" runat="server"></asp:TextBox>
                            <rjs:PopCalendar ID="rjsSalDate" Separator="/" Format="mm dd yyyy" Control="txtSalDate"
                                runat="server" Font-Names="Tahoma" />
                        </td>
                    </tr>
                    <tr>
                        <td align="left" style="width: 120px">
                            <asp:Label ID="lblDetailsHide" Visible="false" runat="server"></asp:Label>
                        </td>
                        <td colspan="2" align="center">
                            <asp:Button ID="btnUpdate" Text="Update" Style="display: none; background-color: #273D5F;
                                color: White;" OnClientClick="return UpdateRecord();" runat="server" />
                            &nbsp
                            <asp:Button ID="btSave" Text="Save" Style="background-color: #273D5F; color: White;"
                                OnClientClick="return Save_SalData();" runat="server" />
                            &nbsp
                            <asp:Button ID="btnClear" Text="Clear" Style="background-color: #273D5F; color: White;"
                                OnClientClick="return Clear();" runat="server" />
                        </td>
                        <td align="left" style="width: 140px">
                            <asp:TextBox ID="txtSalID" Style="display: none;" runat="server"></asp:TextBox>
                        </td>
                    </tr>
                </table>
            </fieldset>
        </div>
        <div id="SalaryDetail" style="width: 100%;" runat="server">
            <fieldset id="fldSalDetail" style="width: 98%">
                <legend>Salary Details:</legend>
                <table align="left" style="width: 50%">
                    <tr>
                        <td align="left" style="width: 120px">
                            <asp:Label ID="lblEmpNameS" Text="Employee Name:" runat="server"></asp:Label>
                        </td>
                        <td align="left" style="width: 140px">
                            <asp:DropDownList ID="ddlEmpNameS" Width="124px" runat="server">
                            </asp:DropDownList>
                        </td>
                        <td align="left" style="width: 140px">
                            <asp:Button ID="btnSearch" Text="Search" Style="background-color: #273D5F; color: White;"
                                runat="server" />
                        </td>
                    </tr>
                    <tr>
                        <td align="left" style="width: 120px">
                            <asp:LinkButton ID="lnkBAdvSearch" Text="Advanced Search" OnClientClick="toggle(); return false;"
                                BackColor="#1B2B56" Font-Names="Tahoma" ForeColor="#E3DDD6" runat="server"></asp:LinkButton>
                        </td>
                    </tr>
                </table>
                <table id="tblAdvSearch" align="left" style="display: none;">
                    <tr>
                        <td align="left" style="width: 120px">
                            <asp:Label ID="lblDeptS" Text="Department:" runat="server"></asp:Label>
                        </td>
                        <td align="left" style="width: 140px">
                            <asp:DropDownList ID="ddlDeptS" Width="124px" runat="Server">
                            </asp:DropDownList>
                        </td>
                        <td align="left" style="width: 120px">
                            <asp:Label ID="lblDesign" Text="Designation:" runat="server"></asp:Label>
                        </td>
                        <td align="left" style="width: 140px">
                            <asp:DropDownList ID="ddlDesign" Width="124px" runat="Server">
                            </asp:DropDownList>
                        </td>
                    </tr>
                    <tr>
                        <td align="left" style="width: 120px">
                            <asp:Label ID="lblSalMonS" Text="Salary Month:" runat="server"></asp:Label>
                        </td>
                        <td align="left" style="width: 140px">
                            <asp:DropDownList ID="ddlSalMonS" Width="124px" runat="server">
                                <asp:ListItem></asp:ListItem>
                                <asp:ListItem>1</asp:ListItem>
                                <asp:ListItem>2</asp:ListItem>
                                <asp:ListItem>3</asp:ListItem>
                                <asp:ListItem>4</asp:ListItem>
                                <asp:ListItem>5</asp:ListItem>
                                <asp:ListItem>6</asp:ListItem>
                                <asp:ListItem>7</asp:ListItem>
                                <asp:ListItem>8</asp:ListItem>
                                <asp:ListItem>9</asp:ListItem>
                                <asp:ListItem>10</asp:ListItem>
                                <asp:ListItem>11</asp:ListItem>
                                <asp:ListItem>12</asp:ListItem>
                            </asp:DropDownList>
                        </td>
                        <td align="left" style="width: 120px">
                            <asp:Label ID="lblSalYearS" Text="Year:" runat="server"></asp:Label>
                        </td>
                        <td align="left" style="width: 140px">
                            <asp:TextBox ID="txtSalYearS" Width="124px" runat="server"></asp:TextBox>
                        </td>
                    </tr>
                </table>
            </fieldset>
            <div style="overflow: auto; width: 940px; height: 300px;" runat="server">
                <table id="tblShowSalDetail" class="dataTable">
                </table>
            </div>
        </div>
    </div>

    <script type="text/javascript" language="javascript">
  
    var oTable;
    $(document).ready(function(){
            SalDetails();
    });
    function dataTable() {
       oTable= $("#tblShowSalDetail").dataTable({
                bPaginate: false,
                bJQueryUI: true,
                oLanguage:{"sSearch":"Filter: "}               
            }).fixedHeader({ height: 500 });;
      }
    function Save_SalData()
        {
            var EmpName = $("select[id$='ddlEmpName']").val();
            var Dept = $("select[id$='ddlDepartment'] option:selected").val();
            var Desg = $("select[id$='ddlDesignation'] option:selected").val();
            var BSal = $("input[id$='txtBasicSal']").val();
            var SalMon = $("select[id$='ddlSalMon'] option:selected").val();
            var SalYear = $("input[id$='txtYear']").val();
            var DaysWork = $("select[id$='ddlDaysWorked'] option:selected").val();
            var PLeaves = $("input[id$='txtPaidLeaves']").val();
            var UPLeaves = $("input[id$='txtUnPaidLeave']").val();
            var TelAllow = $("input[id$='txtTelAllow']").val();
            var ConAllow = $("input[id$='txtConAllow']").val();
            var SunAllow = $("input[id$='txtSunAllow']").val();
            var OtherAllow = $("input[id$='txtOtherAllow']").val();
            var TotalAllow = $("input[id$='txtAllowance']").val();
            var PaidAllow = $("input[id$='txtPaidAllow']").val();
            var DueAllow = $("input[id$='txtDueAllow']").val();
            var Loan = $("input[id$='txtLoan']").val();
            var OtherDeduct = $("input[id$='txtOtherDeduct']").val();
            var TotalDeduct = $("input[id$='txtTotalDeduct']").val();
            var PaidDeduct = $("input[id$='txtPaidDeduct']").val();
            var DueDeduct = $("input[id$='txtDueDeduct']").val();
            var FinalSal = $("input[id$='txtFinalSal']").val();
            var PaidSal = $("input[id$='txtPaidSal']").val();
            var DueSal = $("input[id$='txtDueSal']").val();
            var PaidDate = $("input[id$='txtSalDate']").val();
            if(EmpName == "")
                {
                    alert("Please Select Employee Name!");
                    $("select[id$='ddlEmpName'] option:selected").focus();
                    return false;
                }
            if(Dept == "")
                {
                    alert("Please Select Department Name!");
                    $("select[id$='ddlDepartment'] option:selected").focus();
                    return false;   
                }  
            if(Desg == "")
                {
                    alert("Please Select Designation!");
                    $("select[id$='ddlDesignation'] option:selected").focus();
                    return false;
                }    
            if(BSal == "")
                {
                    alert("Please Enter Basic Salary!");
                    $("input[id$='txtBasicSal']").focus();
                    return false;
                }  
            if(SalMon == "")
                {
                    alert("Please Select Salary Month!");
                    $("select[id$='ddlSalMon'] option:selected").focus();
                    return false;
                }         
            if(SalYear == "")
                {
                    alert("Please Enter Salary Year!");
                    $("input[id$='txtYear']").focus();
                    return false;
                }
            if(DaysWork == "")
                {
                    alert("Please Select Worked Days!");
                    $("select[id$='ddlDaysWorked']").focus();
                    return false;
                } 
            if(PaidDate == "")
                {
                    alert("Please Enter Payment Date!");
                    $("input[id$='txtSalDate']").focus();
                    return false;
                }
            if(parseInt(TotalAllow)<parseInt(PaidAllow))
                {
                    alert("Paid Allownace Cannot Be Greater Than Allowance Amount!");
                    return false;
                }
            if(parseInt(TotalDeduct)<parseInt(PaidDeduct))
                {
                    alert("Paid Deduction Cannot Be Greater Than Total Deduction!");
                    return false;
                }
            if(parseInt(PaidSal)>parseInt(FinalSal))
                {
                    alert("Paid Salary Cannot Be Greater Than Final Salary!");
                    return false;
                }
                
             $.ajax({
                type: "POST",
                contentType:"application/json; charset=utf-8",
                url: "frmSalary.aspx/SaveSalData", 
                data: "{'EmpName':'"+EmpName+"','Dept':'"+Dept+"','Desg':'"+Desg+"','BSal':'"+BSal+"','SalMon':'"+SalMon+"','SalYear':'"+SalYear+"','DaysWork':'"+DaysWork+"','PLeaves':'"+PLeaves+"','UPLeaves':'"+UPLeaves+"','TelAllow':'"+TelAllow+"','ConAllow':'"+ConAllow+"','SunAllow':'"+SunAllow+"','OtherAllow':'"+OtherAllow+"','TotalAllow':'"+TotalAllow+"','PaidAllow':'"+PaidAllow+"','DueAllow':'"+DueAllow+"','Loan':'"+Loan+"','OtherDeduct':'"+OtherDeduct+"','TotalDeduct':'"+TotalDeduct+"','PaidDeduct':'"+PaidDeduct+"','DueDeduct':'"+DueDeduct+"','FinalSal':'"+FinalSal+"','PaidSal':'"+PaidSal+"','DueSal':'"+DueSal+"','PaidDate':'"+PaidDate+"'}", 
                success:onsuccessSave,
                error:onretrieveSaveError 
                });
             return false;                    
        }
        function onsuccessSave()
        {
            alert("Record Saved Successfully!");
            SalDetails();
            Clear();
            return false;
        }   
        function onretrieveSaveError()
        {
            alert("Error In Saving Record!");
            return false;
        }
        function toggle()
        {
            $("table[id$='tblAdvSearch']").slideToggle();
            return false;
        } 
        function SalDetails()
        {
            var EmpNameS = $("select[id$='ddlEmpNameS'] option:selected").val();
            var DeptS = $("select[id$='ddlDeptS'] option:selected").val();
            var DesgS = $("select[id$='ddlDesign'] option:selected").val();
            var MonS = $("select[id$='ddlSalMonS'] option:selected").val();
            var YearS = $("input[id$='txtSalYearS']").val();
            if (EmpNameS == undefined)
            {
                return false;
            }
            if (DeptS == undefined)
            {
                return false;
            }
            if (DesgS == undefined)
            {
                return false;  
            }
            if(MonS == undefined)
            {
                return false;
            }
            if (YearS == undefined)
            {
                return false;
            }
            if(YearS != "")
            {
                if (MonS == "")
                {
                    alert("Please Select Salary Month!");
                    return false;
                }
            }
            if (MonS != "")
            {
                if (YearS == "")
                {
                    alert("Please Enter Salary Year!");
                    return false;
                }
            }
            $.ajax({
                type: "POST",
                contentType:"application/json; charset=utf-8",
                url: "frmSalary.aspx/GetSalDetails", 
                data: "{'EmpNameS':'"+EmpNameS+"','DeptS':'"+DeptS+"','DesgS':'"+DesgS+"','MonS':'"+MonS+"','YearS':'"+YearS+"'}", 
                success:onsuccessSalDetails,
                error:onerrorSalDetails 
                });
                return false;
        }
        function onsuccessSalDetails(msg)
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
                tbl += "<th style='text-align:center; white-space:nowrap;'>Del</th>";
                tbl += "<th style='text-align:center; white-space:nowrap;'>Edit</th>";
                tbl += "<th style='text-align:center; display:none; white-space:nowrap;'>ID</th>";
                tbl += "<th style='white-space:nowrap; text-align:left;'>Name</th>";
                tbl += "<th style='white-space:nowrap; display:none; text-align:left;'>Name ID</th>";
                tbl += "<th style='white-space:nowrap; text-align:left;'>Department</th>";
                tbl += "<th style='white-space:nowrap; display:none; text-align:left;'>Dept ID</th>";
                tbl += "<th style='white-space:nowrap; text-align:left;'>Designation</th>";
                tbl += "<th style='white-space:nowrap; display:none; text-align:left;'>Designation ID</th>";
                tbl += "<th style='white-space:nowrap; text-align:left;'>Basic Sal</th>";
                tbl += "<th style='white-space:nowrap; text-align:left;'>Mon</th>";
                tbl += "<th style='white-space:nowrap; text-align:left;'>Year</th>";
                tbl += "<th style='white-space:nowrap; text-align:left;'>W-Days</th>";
                tbl += "<th style='white-space:nowrap; text-align:left;'>Paid Leaves</th>";
                tbl += "<th style='white-space:nowrap; text-align:left;'>Unpaid Leaves</th>";
                tbl += "<th style='white-space:nowrap; text-align:left;'>Telephone Allowance</th>";
                tbl += "<th style='white-space:nowrap; text-align:left;'>Conveyance Allowance</th>";
                tbl += "<th style='white-space:nowrap; text-align:left;'>Sunday Allowance</th>";
                tbl += "<th style='white-space:nowrap; text-align:left;'>Other Allowances</th>";
                tbl += "<th style='white-space:nowrap; text-align:left;'>Total Allowance</th>";
                tbl += "<th style='white-space:nowrap; text-align:left;'>Paid Allowance</th>";
                tbl += "<th style='white-space:nowrap; text-align:left;'>Due Allowance</th>";
                tbl += "<th style='white-space:nowrap; text-align:left;'>Loan</th>";
                tbl += "<th style='white-space:nowrap; text-align:left;'>Other Deductions</th>";
                tbl += "<th style='white-space:nowrap; text-align:left;'>Total Deduction</th>";
                tbl += "<th style='white-space:nowrap; text-align:left;'>Paid Deduction</th>";
                tbl += "<th style='white-space:nowrap; text-align:left;'>Due Deduction</th>";
                tbl += "<th style='white-space:nowrap; text-align:left;'>Final Salary</th>";
                tbl += "<th style='white-space:nowrap; text-align:left;'>Paid Salary</th>";
                tbl += "<th style='white-space:nowrap; text-align:left;'>Due Salary</th>";
                tbl += "<th style='white-space:nowrap; text-align:left;'>Paid On</th>";
                tbl += "<th style='white-space:nowrap; text-align:left;'>Created By</th>";
                tbl += "<th style='white-space:nowrap; text-align:left;'>Created Date</th>";
                tbl += "<th style='white-space:nowrap; text-align:left;'>Mod By</th>";
                tbl += "<th style='white-space:nowrap; text-align:left;'>Mod Date</th>";
                tbl += "</tr>";
                tbl += "</thead>";
                tbl += "<tbody>";
                for (var i = 0; i < data.SalDetails.length; i++) {               
                            var PaidDate=ConvertDate(data.SalDetails[i].Paid_On); 
                            var CreatedDate=ConvertDate(data.SalDetails[i].Created_Date);   
                            var ModDate=ConvertDate(data.SalDetails[i].Modified_Date);     
                            tbl += "<td style='cursor:Pointer;' id='txtdelete' align='center' onclick='return DeleteRecord("+i+");'><img src='image/Cross.png'> </td>";    
                            tbl += "<td style='cursor:Pointer;' id='txtUpdate' align='center' onclick='return EditRecord("+i+");'><img src='image/Edit.png'></td>";                        
                            tbl += "<td style='text-align:left; white-space:nowrap; display:none;' id='txtESalID"+i+"'>" + data.SalDetails[i].EmpSal_ID + "</td>";
                            tbl += "<td style='text-align:left; white-space:nowrap;' id='txtEName"+i+"'>" + data.SalDetails[i].E_Name + "</td>"; 
                            tbl += "<td style='text-align:right; display:none; white-space:nowrap;' id='txtEmpName_ID"+i+"'>" + data.SalDetails[i].EmpName_ID + "</td>";                    
                            tbl += "<td style='text-align:left; white-space:nowrap;' id='txtDName"+i+"'>" + data.SalDetails[i].D_NAME + " </td>";
                            tbl += "<td style='text-align:right; display:none; white-space:nowrap;' id='txtDept_ID"+i+"'>" + data.SalDetails[i].Dept_ID + " </td>";
                            tbl += "<td style='text-align:left; white-space:nowrap;' id='txtDesgName"+i+"'>" + data.SalDetails[i].Desig_Name + " </td>";
                            tbl += "<td style='text-align:right; display:none; white-space:nowrap;' id='txtDesg_ID"+i+"'>" + data.SalDetails[i].Desg_ID + " </td>";
                            tbl += "<td style='text-align:right; white-space:nowrap;' id='txtBasicSal"+i+"'>" + data.SalDetails[i].BasicSal + " </td>";
                            tbl += "<td style='text-align:right; white-space:nowrap;' id='txtSalMon"+i+"'>" + data.SalDetails[i].SalMon + " </td>";                    
                            tbl += "<td style='text-align:right; white-space:nowrap;' id='txtSalYear"+i+"'>" + data.SalDetails[i].SalYear + " </td>";
                            tbl += "<td style='text-align:right; white-space:nowrap;' id='txtDaysWorked"+i+"'>" + data.SalDetails[i].DaysWorked + " </td>";
                            tbl += "<td style='text-align:right; white-space:nowrap;' id='txtPaid_Leaves"+i+"'>" + data.SalDetails[i].Paid_Leaves + " </td>";
                            tbl += "<td style='text-align:right; white-space:nowrap;' id='txtUnpaid_Leaves"+i+"'>" + data.SalDetails[i].Unpaid_Leaves + " </td>";
                            tbl += "<td style='text-align:right; white-space:nowrap;' id='txtTelAllow"+i+"'>" + data.SalDetails[i].TelAllow + " </td>";
                            tbl += "<td style='text-align:right; white-space:nowrap;' id='txtConAllow"+i+"'>" + data.SalDetails[i].ConAllow + " </td>";
                            tbl += "<td style='text-align:right; white-space:nowrap;' id='txtSunAllow"+i+"'>" + data.SalDetails[i].SunAllow + " </td>";
                            tbl += "<td style='text-align:right; white-space:nowrap;' id='txtOtherAllow"+i+"'>" + data.SalDetails[i].OtherAllow + " </td>";
                            tbl += "<td style='text-align:right; white-space:nowrap;' id='txtTotalAllow"+i+"'>" + data.SalDetails[i].TotalAllow + " </td>";
                            tbl += "<td style='text-align:right; white-space:nowrap;' id='txtPaidAllow"+i+"'>" + data.SalDetails[i].PaidAllow + " </td>";
                            tbl += "<td style='text-align:right; white-space:nowrap;' id='txtDueAllow"+i+"'>" + data.SalDetails[i].DueAllow + " </td>";
                            tbl += "<td style='text-align:right; white-space:nowrap;' id='txtLoan"+i+"'>" + data.SalDetails[i].Loan + " </td>";
                            tbl += "<td style='text-align:right; white-space:nowrap;' id='txtOtherDeduct"+i+"'>" + data.SalDetails[i].OtherDeduct + " </td>";
                            tbl += "<td style='text-align:right; white-space:nowrap;' id='txtTotalDeduct"+i+"'>" + data.SalDetails[i].TotalDeduct + " </td>";
                            tbl += "<td style='text-align:right; white-space:nowrap;' id='txtPaidDeduct"+i+"'>" + data.SalDetails[i].PaidDeduct + " </td>";
                            tbl += "<td style='text-align:right; white-space:nowrap;' id='txtDueDeduct"+i+"'>" + data.SalDetails[i].DueDeduct + " </td>";
                            tbl += "<td style='text-align:right; white-space:nowrap;' id='txtFinal_Sal"+i+"'>" + data.SalDetails[i].Final_Sal + " </td>";
                            tbl += "<td style='text-align:right; white-space:nowrap;' id='txtPaidSal"+i+"'>" + data.SalDetails[i].PaidSal + " </td>";
                            tbl += "<td style='text-align:right; white-space:nowrap;' id='txtDueSal"+i+"'>" + data.SalDetails[i].DueSal + " </td>";
                            tbl += "<td style='text-align:right; white-space:nowrap;' id='txtPaid_On"+i+"'>" + PaidDate + " </td>";
                            tbl += "<td style='text-align:left; white-space:nowrap;' id='txtCreated_By"+i+"'>" + data.SalDetails[i].Created_By + " </td>";
                            tbl += "<td style='text-align:left; white-space:nowrap;' id='txtCreated_Date"+i+"'>" + CreatedDate + " </td>";
                            tbl += "<td style='text-align:left; white-space:nowrap;' id='txtModified_By"+i+"'>" + data.SalDetails[i].Modified_By + " </td>";
                            tbl += "<td style='text-align:right; white-space:nowrap;' id='txtModified_Date"+i+"'>" + ModDate + " </td>";
                      tbl += "</tr>";
                }   

                tbl += "</tbody>";
                tbl += "</table>";
                $("#tblShowSalDetail").html(tbl);
                //dataTable();
                return false;   
        } 
        function onerrorSalDetails()
        {
            alert("Error In Loading Details!");
            return false;
        }
        function EditRecord(rowno)
        {
            var SalID = $("#txtESalID"+rowno).html().trim();
            $("input[id$='txtSalID']").val(SalID);
            var EmpID = $("#txtEmpName_ID"+rowno).html().trim();
            $("select[id$='ddlEmpName']").val(EmpID);
            var DeptID = $("#txtDept_ID"+rowno).html().trim();
            $("select[id$='ddlDepartment']").val(DeptID);
            var DesgID = $("#txtDesg_ID"+rowno).html().trim();
            $("select[id$='ddlDesignation']").val(DesgID);
            var BSal = $("#txtBasicSal"+rowno).html().trim();
            $("input[id$='txtBasicSal']").val(BSal);
            var Mon = $("#txtSalMon"+rowno).html().trim();
            $("select[id$='ddlSalMon']").val(Mon);
            var Year = $("#txtSalYear"+rowno).html().trim();
            $("input[id$='txtYear']").val(Year);
            var WDays = $("#txtDaysWorked"+rowno).html().trim();
            $("select[id$='ddlDaysWorked']").val(WDays);
            var PLeaves = $("#txtPaid_Leaves"+rowno).html().trim();
            $("input[id$='txtPaidLeaves']").val(PLeaves);
            var ULeaves = $("#txtUnpaid_Leaves"+rowno).html().trim();
            $("input[id$='txtUnPaidLeave']").val(ULeaves);
            var TelAllow = $("#txtTelAllow"+rowno).html().trim();
            $("input[id$='txtTelAllow']").val(TelAllow);
            var ConAllow = $("#txtConAllow"+rowno).html().trim();
            $("input[id$='txtConAllow']").val(ConAllow);
            var SunAllow = $("#txtSunAllow"+rowno).html().trim();
            $("input[id$='txtSunAllow']").val(SunAllow);
            var OtherAllow = $("#txtOtherAllow"+rowno).html().trim();
            $("input[id$='txtOtherAllow']").val(OtherAllow);
            var TotalAllow = $("#txtTotalAllow"+rowno).html().trim();
            $("input[id$='txtAllowance']").val(TotalAllow);
            var PaidAllow = $("#txtPaidAllow"+rowno).html().trim();
            $("input[id$='txtPaidAllow']").val(PaidAllow);
            var DueAllow = $("#txtDueAllow"+rowno).html().trim();
            $("input[id$='txtDueAllow']").val(DueAllow);
            var Loan = $("#txtLoan"+rowno).html().trim();
            $("input[id$='txtLoan']").val(Loan);
            var OtherDeduct = $("#txtOtherDeduct"+rowno).html().trim();
            $("input[id$='txtOtherDeduct']").val(OtherDeduct);
            var TotalDeduct = $("#txtTotalDeduct"+rowno).html().trim();
            $("input[id$='txtTotalDeduct']").val(TotalDeduct);
            var PaidDeduct = $("#txtPaidDeduct"+rowno).html().trim();
            $("input[id$='txtPaidDeduct']").val(PaidDeduct);
            var DueDeduct = $("#txtDueDeduct"+rowno).html().trim();
            $("input[id$='txtDueDeduct']").val(DueDeduct);
            var FinalSal = $("#txtFinal_Sal"+rowno).html().trim();
            $("input[id$='txtFinalSal']").val(FinalSal);
            var PaidSal = $("#txtPaidSal"+rowno).html().trim();
            $("input[id$='txtPaidSal']").val(PaidSal);
            var DueSal = $("#txtDueSal"+rowno).html().trim();
            $("input[id$='txtDueSal']").val(DueSal);
            var PaidOn = $("#txtPaid_On"+rowno).html().trim();
            $("input[id$='txtSalDate']").val(PaidOn);
            $("input[id$='btnUpdate']").show();
            $("input[id$='btSave']").hide();
            return false;
        }
        function ConvertDate(dateString)
        {   
            if(dateString !=undefined)
            {
                var date = new Date(parseInt(dateString.replace(/\/Date\((\d+)\)\//, '$1')));
                var month = date.getMonth() + 1;
                if(month <10)
                month ='0'+month ;
                var day = date.getDate();
                if(day<10)
                day='0'+day;
                var year = date.getFullYear();
                var datet=month+"/"+day+"/"+year;
                return datet;
                }
                else
                {
                return false;
                }
        } 
        function DeleteRecord(rowNo)
        {
            var SalID = $("#txtESalID"+rowNo).html();
            if (confirm("Are you sure you wish to delete this Record?"))
            {
                $.ajax({
                        type: "POST",
                        dataType: "json",
                        contentType: "application/json; charset=utf-8",
                        url: "frmSalary.aspx/DeleteSalary",
                        data: "{'SalID':'"+SalID+"'}",
                        success: onSuccessDelete,
                        error:OnDeleteError 
            });
            return false;
            }
        }
        function onSuccessDelete()
        {
            alert("Record Deleted Successfully!");
            SalDetails();
            return false;
        } 
        function OnDeleteError()
        {
            alert("Error In Deleting Record!");
            return false;
        }
        function CalAllowance()
        {
            var TelAllow = $("input[id$='txtTelAllow']").val();
            if(TelAllow=="")
                {
                    TelAllow="0";   
                }
            var ConAllow = $("input[id$='txtConAllow']").val();
            if(ConAllow=="")
                {
                    ConAllow="0";
                }
            var SunAllow = $("input[id$='txtSunAllow']").val();
            if(SunAllow=="")
                {
                    SunAllow="0";
                }
            var otherAllow = $("input[id$='txtOtherAllow']").val();
            if(otherAllow=="")
                {
                    otherAllow="0";
                }    
            var TotalAllow = parseInt(TelAllow)+parseInt(ConAllow)+parseInt(SunAllow)+parseInt(otherAllow);
            $("input[id$='txtAllowance']").val(TotalAllow);
            var AllowAmt = $("input[id$='txtAllowance']").val();
            if(AllowAmt == "")
                {
                    AllowAmt = "0";
                }
            var PaidAllow = $("input[Id$='txtPaidAllow']").val();
            if(PaidAllow=="")
                {
                    PaidAllow = "0";
                }
            if(parseInt(AllowAmt)<parseInt(PaidAllow))
                {
                    alert("Paid Allownace Cannot Be Greater Than Allowance Amount!");
                    return false;
                }
            else
            {
                var TotalAllow = parseInt(AllowAmt)-parseInt(PaidAllow);
                $("input[Id$='txtDueAllow']").val(TotalAllow );
            }
            return false;
        }
        function CalDeduction()
        {
            var Loan = $("input[id$='txtLoan']").val();
            if(Loan=="")
                {
                    Loan = "0";
                }
            var OtherDeduct = $("input[id$='txtOtherDeduct']").val();
            if(OtherDeduct=="")
                {
                    OtherDeduct = "0";
                }
            var TotalDeduct = parseInt(Loan)+parseInt(OtherDeduct);
            $("input[id$='txtTotalDeduct']").val(TotalDeduct);
            $("input[id$='txtDueDeduct']").val(TotalDeduct);
            var PaidDeduct = $("input[id$='txtPaidDeduct']").val();
            if (PaidDeduct=="")
                {
                    PaidDeduct = "0";
                } 
            if(parseInt(TotalDeduct)<parseInt(PaidDeduct))
                {
                    alert("Paid Deduction Cannot Be Greater Than Total Deduction!");
                    return false;
                }
            else
                {
                    var DueDeduct = parseInt(TotalDeduct)-parseInt(PaidDeduct);
                    $("input[id$='txtDueDeduct']").val(DueDeduct);
                }
            return false;    
        }
        function CalcSal()
        {
            var BasicSal = $("input[id$='txtBasicSal']").val();
            var PaidAllow = $("input[id$='txtPaidAllow']").val();
            if(PaidAllow=="")
                {
                    PaidAllow = "0";
                }
            var PaidDeduct = $("input[id$='txtPaidDeduct']").val();
            if(PaidDeduct=="")
                {
                    PaidDeduct = "0";
                }
            var TotalSal = parseInt(BasicSal)+parseInt(PaidAllow)-parseInt(PaidDeduct);
            $("input[id$='txtFinalSal']").val(TotalSal);
            $("input[id$='txtDueSal']").val(TotalSal);
            var FinalSal = $("input[id$='txtFinalSal']").val();
            var PaidSal = $("input[id$='txtPaidSal']").val();
                if(PaidSal=="")
                {
                    PaidSal = "0";
                }
            if(parseInt(PaidSal)>parseInt(FinalSal))
                {
                    alert("Paid Salary Cannot Be Greater Than Final Salary!");
                    return false;
                }
            var DueSal = parseInt(TotalSal)-parseInt(PaidSal);
            $("input[id$='txtDueSal']").val(DueSal);
            return false;
        }
        function UpdateRecord()
        {
            var SalID = $("input[id$='txtSalID']").val();
            var EmpName = $("select[id$='ddlEmpName']").val();
            var Dept = $("select[id$='ddlDepartment'] option:selected").val();
            var Desg = $("select[id$='ddlDesignation'] option:selected").val();
            var BSal = $("input[id$='txtBasicSal']").val();
            var SalMon = $("select[id$='ddlSalMon'] option:selected").val();
            var SalYear = $("input[id$='txtYear']").val();
            var DaysWork = $("select[id$='ddlDaysWorked'] option:selected").val();
            var PLeaves = $("input[id$='txtPaidLeaves']").val();
            var UPLeaves = $("input[id$='txtUnPaidLeave']").val();
            var TelAllow = $("input[id$='txtTelAllow']").val();
            var ConAllow = $("input[id$='txtConAllow']").val();
            var SunAllow = $("input[id$='txtSunAllow']").val();
            var OtherAllow = $("input[id$='txtOtherAllow']").val();
            var TotalAllow = $("input[id$='txtAllowance']").val();
            var PaidAllow = $("input[id$='txtPaidAllow']").val();
            var DueAllow = $("input[id$='txtDueAllow']").val();
            var Loan = $("input[id$='txtLoan']").val();
            var OtherDeduct = $("input[id$='txtOtherDeduct']").val();
            var TotalDeduct = $("input[id$='txtTotalDeduct']").val();
            var PaidDeduct = $("input[id$='txtPaidDeduct']").val();
            var DueDeduct = $("input[id$='txtDueDeduct']").val();
            var FinalSal = $("input[id$='txtFinalSal']").val();
            var PaidSal = $("input[id$='txtPaidSal']").val();
            var DueSal = $("input[id$='txtDueSal']").val();
            var PaidDate = $("input[id$='txtSalDate']").val();
            if(EmpName == "")
                {
                    alert("Please Select Employee Name!");
                    $("select[id$='ddlEmpName'] option:selected").focus();
                    return false;
                }
            if(Dept == "")
                {
                    alert("Please Select Department Name!");
                    $("select[id$='ddlDepartment'] option:selected").focus();
                    return false;   
                }  
            if(Desg == "")
                {
                    alert("Please Select Designation!");
                    $("select[id$='ddlDesignation'] option:selected").focus();
                    return false;
                }    
            if(BSal == "")
                {
                    alert("Please Enter Basic Salary!");
                    $("input[id$='txtBasicSal']").focus();
                    return false;
                }  
            if(SalMon == "")
                {
                    alert("Please Select Salary Month!");
                    $("select[id$='ddlSalMon'] option:selected").focus();
                    return false;
                }         
            if(SalYear == "")
                {
                    alert("Please Enter Salary Year!");
                    $("input[id$='txtYear']").focus();
                    return false;
                }
            if(DaysWork == "")
                {
                    alert("Please Select Worked Days!");
                    $("select[id$='ddlDaysWorked']").focus();
                    return false;
                } 
            if(PaidDate == "")
                {
                    alert("Please Enter Payment Date!");
                    $("input[id$='txtSalDate']").focus();
                    return false;
                }
             $.ajax({
                type: "POST",
                contentType:"application/json; charset=utf-8",
                url: "frmSalary.aspx/UpdateSalary", 
                data: "{'SalID':'"+SalID+"','EmpName':'"+EmpName+"','Dept':'"+Dept+"','Desg':'"+Desg+"','BSal':'"+BSal+"','SalMon':'"+SalMon+"','SalYear':'"+SalYear+"','DaysWork':'"+DaysWork+"','PLeaves':'"+PLeaves+"','UPLeaves':'"+UPLeaves+"','TelAllow':'"+TelAllow+"','ConAllow':'"+ConAllow+"','SunAllow':'"+SunAllow+"','OtherAllow':'"+OtherAllow+"','TotalAllow':'"+TotalAllow+"','PaidAllow':'"+PaidAllow+"','DueAllow':'"+DueAllow+"','Loan':'"+Loan+"','OtherDeduct':'"+OtherDeduct+"','TotalDeduct':'"+TotalDeduct+"','PaidDeduct':'"+PaidDeduct+"','DueDeduct':'"+DueDeduct+"','FinalSal':'"+FinalSal+"','PaidSal':'"+PaidSal+"','DueSal':'"+DueSal+"','PaidDate':'"+PaidDate+"'}", 
                success:onsuccessUpdateSal,
                error:onretrieveUpdateError 
                });
             return false; 
        }
        function onsuccessUpdateSal()
        {
            alert("Record Updated Successfully!");
            Clear();
            SalDetails();
            return false;
        }
        function onretrieveUpdateError()
        {
            alert("Error In Record Updation!");
            return false;
        }
        function Clear()
        {
            $("input id=['fldSalaryMain'] input,select").val("");
            $("input[id$='txtBasicSal']").val("");
            $("input[id$='txtYear']").val("");
            $("input[id$='txtPaidLeaves']").val("");
            $("input[id$='txtUnPaidLeave']").val("");
            $("input[id$='txtAllowance']").val("");
            $("input[id$='txtDeduct']").val("");
            $("input[id$='txtUnPaidLeave']").val("");
            $("input[id$='txtFinalSal']").val("");
            $("input[id$='txtSalDate']").val("");
            $("input[id$='txtTelAllow']").val('');
            $("input[id$='txtConAllow']").val('');
            $("input[id$='txtSunAllow']").val('');
            $("input[id$='txtOtherAllow']").val('');
            $("input[id$='txtAllowance']").val('');
            $("input[id$='txtPaidAllow']").val('');
            $("input[id$='txtDueAllow']").val('');
            $("input[id$='txtLoan']").val('');
            $("input[id$='txtOtherDeduct']").val('');
            $("input[id$='txtTotalDeduct']").val('');
            $("input[id$='txtPaidDeduct']").val('');
            $("input[id$='txtDueDeduct']").val('');
            $("input[id$='txtPaidSal']").val('');
            $("input[id$='txtDueSal']").val('');
            $("input[id$='btnUpdate']").hide();
            $("input[id$='btSave']").show();
            return false;
        }
       
    </script>

</asp:Content>

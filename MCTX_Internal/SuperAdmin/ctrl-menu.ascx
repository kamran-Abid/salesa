<%@ Control Language="C#" AutoEventWireup="true" CodeFile="ctrl-menu.ascx.cs" Inherits="MCTX_Internal_SuperAdmin_ctrl_menu" %>
<div id="menu">
                            <ul class="menu">
                                <li><a href="Welcome.aspx" class="parent"><span>Home</span></a> </li>
                                <li id="MIS"><a href="#" class="parent"><span>MIS</span></a>
                                    <div>
                                        <ul>
                                            <li><a href="frmEmployees.aspx"><span>Employee(s) Registration</span></a></li>
                                            <li><a href="frmEmpUser.aspx"><span>User(s) Registration</span></a></li>
                                            <li><a href="frmProductInfo.aspx"><span>Product(s)</span></a></li>
                                            <li><a href="frmPricingInfo.aspx"><span>Product(s) Pricing</span></a></li>
                                            <li><a href="frmDepartInfo.aspx"><span>Department(s)</span></a></li>
                                            <li><a href="frmDesigInfo.aspx"><span>Designation(s)</span></a></li>
                                        </ul>
                                    </div>
                                </li>
                                <li><a href="#" class="parent"><span>Sales</span></a>
                                    <div>
                                        <ul>
                                            <li><a href="frmCompanyInfo.aspx"><span>Company</span></a></li>
                                            <li><a href="frmClientsInfo.aspx"><span>Client(s)</span></a></li>
                                            <li><a href="AddSalesVisits.aspx"><span>Add Sales Visits</span></a></li>
                                            <li><a href="frmProspectingList.aspx"><span>Prospecting List</span></a></li>
                                            <li><a href="frmQuotations.aspx"><span>Quotation</span></a></li>
                                            <li><a href="EmailMarketing.aspx"><span>Email Marketing</span></a></li>
                                            <li id="TargetSettings"><a href="frmSetTarget_New.aspx"><span>Target Setting</span></a></li>

                                        </ul>
                                    </div>
                                </li>
                                <li id="Reports_Admin"><a href="#" class="parent"><span>Reports</span></a>
                                    <div>
                                        <ul>
                                            <li><a href="frmDailyReportChck.aspx"><span>Daily Report Details</span></a></li>
                                            <li><a href="frmDailyRptSummary.aspx"><span>Daily Report Summary</span></a></li>
                                            <li><a href="SMS_TaskManager.aspx"><span>SMS Task Report</span></a></li>
                                            <li><a href="SMS_NDP.aspx"><span>Planner (SMS)</span></a></li>
                                        </ul>
                                    </div>
                                </li>
                                <li id="VisitReports"><a href="#" class="parent"><span>Sales Reports</span></a>
                                    <div>
                                        <ul>
                                            <li><a href="VisitReport.aspx"><span>Visit Reports</span></a></li>
                                            <li><a href="report_EmailMarketing.aspx"><span>Email Log Reports</span></a></li>
                                        </ul>
                                    </div>
                                </li>
                                <li><a href="#" class="parent"><span>Tasks</span></a>
                                    <div>
                                        <ul>
                                            <li><a href="frmUserTask.aspx"><span>View Tasks</span></a></li>
                                            <li><a href="frmInbox.aspx"><span>View Inbox</span></a></li>
                                            <li id="AssignTasks"><a href="frmAssignTask.aspx"><span>Assign Tasks</span></a></li>
                                        </ul>
                                    </div>
                                </li>
                                <li id="Settings"><a href="#" class="parent"><span>Settings</span></a>
                                    <div>
                                        <ul>
                                            <li><a href="frmReportSetting.aspx"><span>Attendance Settings</span></a></li>
                                            <li><a href="frmEmpPlan.aspx"><span>Sales Plan Days</span></a></li>
                                            <li><a href="home-settings.aspx"><span>Home News Settings</span></a></li>
                                            <li><a href="#" class="parent"><span>Salary Variables</span></a>
                                                <div>
                                                    <ul>
                                                        <li><a href="AddUserVariables.aspx"><span>Add Variables</span></a></li>
                                                        <li><a href="frmAssignVariables.aspx"><span>Assign Variables</span></a></li>
                                                    </ul>
                                                </div>
                                            </li>
                                            <%--<li><a href="frmTermSetting.aspx"><span>Term & Description Setting</span></a></li>--%>
                                        </ul>
                                    </div>
                                </li>
                                <li id="AccountsSection"><a href="#" class="parent"><span>Accounts Section</span></a>
                                    <div>
                                        <ul>
                                            <li><a href="ReceiptsAndExpense.aspx"><span>Accounts Information</span></a></li>
                                            <li><a href="frmSalary.aspx"><span>Salary Calculation & Details</span></a></li>
                                            <li><a href="SMS_AccountManager.aspx"><span>Expense Details (SMS)</span></a></li>
                                        </ul>
                                    </div>
                                </li>
                                <li id="CostingIndex"><a href="#" class="parent"><span>Costing Index</span></a>
                                    <div>
                                        <ul>
                                            <li><a href="CostingIndexCategory.aspx"><span>Casting Index Category</span></a></li>
                                            <li><a href="CostingIndexItems.aspx"><span>Casting Index Items</span></a></li>
                                           
                                        </ul>
                                    </div>
                                </li>
                                <li id="WebLogin"><a href="WebLogin.aspx"><span>Web Login</span></a></li>
                                <li><a href="#" class="parent"><span>Account</span></a>
                                    <div>
                                        <ul>
                                            <li><a href="frmDailyOutputReport.aspx"><span>Daily Output Report</span></a></li>
                                            <li><a href="DailyWorkingReport.aspx"><span>Daily Working  Report</span></a></li>
                                            <li><a href="Emp_SharedArea.aspx"><span>Employee(s) Shared Area</span></a></li>
                                            <li><a href="frmChangePassword.aspx"><span>Change Password</span></a></li>
                                            <li><a href="../../MCTX_General/Logout.aspx"><span>Logout</span></a></li>
                                        </ul>
                                    </div>
                                </li>
                            </ul>
                        </div>
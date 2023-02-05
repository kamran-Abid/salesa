<%@ Page Language="C#" MasterPageFile="MasterAdmin.master" AutoEventWireup="true"
    CodeFile="frmUserTask.aspx.cs" Inherits="MCTX_Internal_SuperAdmin_frmUserTask"
    Title="User Task" %>
<%@ Register Assembly="RJS.Web.WebControl.PopCalendar.Net.2008" Namespace="RJS.Web.WebControl"
    TagPrefix="rjs" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
 <script src="../../js/BlockUI.js" type="text/javascript"></script>
    <table style="width: 100%; height: 333px;">
        <tr>
            <td valign="top" style="height: 331px">
                <div id="tabs">
                    <ul>
                        <li style="text-align: left"><a href="#tabs-1">User Task</a></li>
                    </ul>
                    <div id="tabs-1">
                        <table style="width: 100%; height: 259px;">
                            <tr>
                                <td valign="top">
                                    <table align="left" style="width: 100%">
                                        <tr>
                                            <td colspan="4" style="border-style: groove">
                                                <table align="left" style="width: 725px; height: 37px;">
                                                    <tr>
                                                        <td style="text-align: left; text-decoration: underline; color: #FF9900;" colspan="2">
                                                            <b>Search Criteria:</b>
                                                        </td>
                                                        <td style="text-align: left;" colspan="3">
                                                            &nbsp;&nbsp;
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td style="width: 101px; text-align: left">
                                                            From Date
                                                        </td>
                                                        <td style="width: 200px; text-align: left;">
                                                            
                                                            <asp:TextBox ID="txtFromDate" runat="server"></asp:TextBox><rjs:popcalendar id="rjsReportDate"
                                separator="/" format="mm dd yyyy" control="txtFromDate" runat="server" />
                                                        </td>
                                                        <td style="text-align: left; width: 87px">
                                                            To Date
                                                        </td>
                                                        <td style="width: 200px; text-align: left;">
                                                            
                                                             <asp:TextBox ID="txtToDate" runat="server"></asp:TextBox><rjs:popcalendar id="PopCalendar1"
                                separator="/" format="mm dd yyyy" control="txtToDate" runat="server" />
                                                        </td>
                                                        <td style="text-align: left">
                                                            &nbsp;
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td style="width: 101px; text-align: left">
                                                            Task Status
                                                        </td>
                                                        <td style="width: 200px; text-align: left;">
                                                            <asp:DropDownList ID="ddlTaskStatus" runat="server" Width="168px">
                                                            </asp:DropDownList>
                                                        </td>
                                                        <td style="width: 87px; text-align: left;">
                                                            Assigned by
                                                        </td>
                                                        <td style="width: 200px; text-align: left;">
                                                            <asp:DropDownList ID="ddlAssigBy" runat="server" Width="168px">
                                                            </asp:DropDownList>
                                                        </td>
                                                         <td style="text-align: left">
                                                            &nbsp;
                                                        </td>
                                                        </tr>
                                                        <tr>
                                                        <td colspan="4" style="text-align: right" align="right">
                                                            <asp:Button ID="btnViewTask" runat="server" Text="Search" OnClick="btnViewTask_Click"
                                                                Width="104px" Style="background-color: #2A4062;margin-right:5.3%; color: White;" OnClientClick="return ValidateDate();"  />
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td style="text-align: left" colspan="5">
                                                            <b>Total Tasks</b> =
                                                            <asp:Label ID="lblCounter" runat="server" Font-Bold="True">0</asp:Label>
                                                            &nbsp;
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="text-align: left">
                                                &nbsp; Completed Task =
                                                <asp:Label ID="lblcompletedtasks" runat="server" Font-Bold="True" ForeColor="#006600"
                                                    Text="0"></asp:Label>
                                            </td>
                                            <td style="text-align: left; width: 139px;">
                                                New Tasks =
                                                <asp:Label ID="lblNewtasks" runat="server" Font-Bold="True" ForeColor="Red" Text="0"></asp:Label>
                                            </td>
                                            <td style="text-align: left; width: 145px;">
                                                Inprogress Tasks =
                                                <asp:Label ID="lblinprogresstasks" runat="server" Font-Bold="True" ForeColor="#FF9900"
                                                    Text="0"></asp:Label>
                                            </td>
                                            <td style="text-align: left">
                                                Re-Opened Tasks
                                                <asp:Label ID="lblReOpenedTasks" runat="server" Font-Bold="True" ForeColor="Brown"
                                                    Text="0"></asp:Label>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="4">
                                                <div id="gridheader" visible="true" runat="server">
                                                    <table style="width: 100%">
                                                        <tr>
                                                            <td style="color: #FFFFFF; background-color: #006699; height: 14px;">
                                                                <b>User ID</b>
                                                            </td>
                                                            <td style="color: #FFFFFF; background-color: #006699; height: 14px;">
                                                                <b>Task Name</b>
                                                            </td>
                                                            <td style="color: #FFFFFF; background-color: #006699; height: 14px;">
                                                                <b>Task Preiority</b>
                                                            </td>
                                                            <td style="color: #FFFFFF; background-color: #006699; height: 14px;">
                                                                <b>Task Date</b>
                                                            </td>
                                                            <td style="color: #FFFFFF; background-color: #006699; height: 14px;">
                                                                <b>Detail</b>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td colspan="6" style="background-color: #FFFFFF">
                                                                ...No Record Found...
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </div>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="4">
                                                <asp:GridView ID="GridTasks" runat="server" CellPadding="3" AutoGenerateColumns="False"
                                                    Width="744px" OnRowCommand="GridTasks_RowCommand1" OnSelectedIndexChanging="GridTasks_SelectedIndexChanging"
                                                    BackColor="White" BorderColor="#CCCCCC" BorderStyle="None" BorderWidth="1px"
                                                    Style="font-size: 10px; width:100%;">
                                                    <Columns>
                                                        <asp:TemplateField HeaderText="Task Status">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lbltaaskId" runat="server" Text='<%#Eval("TaskStatus_Name") %>'></asp:Label>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="User ID">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lbluserid" runat="server" Text='<%#Eval("UserID") %>'></asp:Label>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Task Name">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblTaskName" runat="server" Text='<%#Eval("TaskName") %>'></asp:Label>
                                                            </ItemTemplate>
                                                            <ItemStyle HorizontalAlign="Left" />
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Task Preiority">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblPreiority" runat="server" Text='<%#Eval("TaskPriority") %>'></asp:Label>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Task Date">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblTaskDate" runat="server" Text='<%#Eval("TaskDate") %>'></asp:Label>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Detail">
                                                            <ItemTemplate>
                                                                <%--<asp:LinkButton ID="lnkview" runat="server" CommandArgument='<%#Eval("PostalCode") + "," + Eval("City") + "," + Eval("Country") %>' CommandName="View" Text="View"></asp:LinkButton>--%>
                                                                <asp:ImageButton ID="imgbtnDetail" runat="server" CommandArgument='<%#Eval("TaskID")+","+Eval("UserID") %>'
                                                                    CommandName="Detail" ImageUrl="~/images1/view3.png" />
                                                                <%--<asp:LinkButton ID="LinkDetail" runat="server" CommandArgument='<%#Eval("TaskID") %>' CommandName="Detail" Text="Detail" ></asp:LinkButton>--%>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                    </Columns>
                                                    <RowStyle ForeColor="#000066" />
                                                    <FooterStyle BackColor="White" ForeColor="#000066" />
                                                    <PagerStyle BackColor="White" ForeColor="#000066" HorizontalAlign="Left" />
                                                    <SelectedRowStyle BackColor="#669999" Font-Bold="True" ForeColor="White" />
                                                    <HeaderStyle BackColor="#006699" Font-Bold="True" ForeColor="White" />
                                                </asp:GridView>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr>
                                <td style="text-align: left">
                                    <asp:Label ID="lblUserName" runat="server" Visible="False"></asp:Label>
                                </td>
                            </tr>
                        </table>
                    </div>
                </div>
            </td>
        </tr>
        <tr>
            <td valign="top" style="height: 15px">
            </td>
        </tr>
    </table>

    <script type="text/javascript" language="javascript">
    
    function ValidateDate(){
    
     var FrmDate = $("input[id$='txtFromDate']").val().trim();
            var ToDate = $("input[id$='txtToDate']").val().trim();
            
             if (FrmDate != "") {
           
                if (ToDate == "") {
                    alert("Please Select To Date!");
                     
                    return false;
                }
            }
            if (ToDate != "") {
                if (FrmDate == "") {
                    alert("Please Select From Date!");
                    return false;
                }
            }
        
             if(new Date(ToDate) < new Date(FrmDate))
        {
        alert("Date To can not be less than date From!");
       
        return false;

        }  
    
    }

    </script>

</asp:Content>

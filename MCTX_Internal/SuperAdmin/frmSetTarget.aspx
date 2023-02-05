<%@ Page Language="C#" MasterPageFile="MasterAdmin.master" AutoEventWireup="true" CodeFile="frmSetTarget.aspx.cs" Inherits="MCTX_Internal_SuperAdmin_frmSetTarget" Title="MCTX Target Setting" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <table style="width: 100%">
        <tr>
            <td valign="top" style="width: 52%">
                <table style="width: 100%; height: 130px">
                    <tr>
                        <td style="height: 15px;background-color:#FF9900; text-align: left; background-image: url('../../image/bar.JPG'); background-repeat: repeat;" 
                            valign="top">
                        &nbsp;&nbsp;&nbsp;<b>USERS LIST</b>
                        </td>
                         
                     </tr>
                     <tr><td colspan="2" align="left"><asp:Button ID="btnRefresh" runat="server" Text="Refresh Grid" 
                             onclick="btnRefresh_Click" /></td></tr>
                    <tr>
                     <td>
                     <div id="grid" style="height:340px; overflow:auto;">
                     <asp:GridView ID="GridAllTargets" runat="server" Width="316px" 
                             PagerSettings-Mode="NextPreviousFirstLast" PageSize="6" 
                             AutoGenerateColumns="False" onrowcommand="GridAllTargets_RowCommand" 
                             CellPadding="4" ForeColor="#333333" GridLines="None">
                    <PagerSettings Mode="NextPreviousFirstLast"></PagerSettings>

                         <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
                     <Columns>
                     
                     <asp:TemplateField HeaderText="View">
                     <ItemTemplate>
                     
                     <asp:ImageButton ID="imgbtnView" runat="server" ImageUrl="~/images1/view3.png" CommandName="View" CommandArgument='<%#Eval("setting_id") %>' />
                     </ItemTemplate>
                     <ControlStyle Width="15px" />
                     </asp:TemplateField>
                                                            
                     <asp:TemplateField HeaderText="User Name">
                     <ItemTemplate>
                     <asp:HiddenField ID="lbltid" runat="server" Value='<%#Eval("setting_id") %>' />
                     <asp:Label ID="lblUserName" runat="server" Text='<%#Eval("E_Name") %>'></asp:Label>
                     </ItemTemplate>
                      <EditItemTemplate>
                      <asp:HiddenField ID="lbltid" runat="server" Value='<%#Eval("setting_id") %>' />
                        <asp:TextBox ID="txtUserName" runat="server"></asp:TextBox>
                        </EditItemTemplate>
                     </asp:TemplateField>
                     
                     <asp:TemplateField HeaderText="Start Date">
                     <ItemTemplate>
                     <asp:Label ID="lblStartDate" runat="server" Text='<%#Eval("startdate") %>'></asp:Label>
                     </ItemTemplate>
                      <EditItemTemplate>
                        <asp:TextBox ID="txtStartDate" runat="server"></asp:TextBox>
                        </EditItemTemplate>
                     </asp:TemplateField>
                     
                     <asp:TemplateField HeaderText="End Date">
                     <ItemTemplate>
                     <asp:Label ID="lblEndDate" runat="server" Text='<%#Eval("enddate") %>'></asp:Label>
                     </ItemTemplate>
                      <EditItemTemplate>
                        <asp:TextBox ID="txtEndDate" runat="server"></asp:TextBox>
                        </EditItemTemplate>
                     </asp:TemplateField>
                     
                     <%--<asp:TemplateField HeaderText="Edit">
                     <ItemTemplate>
                     <asp:ImageButton ID="imgbtnEdit" runat="server" ImageUrl="~/images1/Edit.gif" />
                     </ItemTemplate>
                     </asp:TemplateField>--%>
                     
                     </Columns>

                         <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                         <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
                         <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
                         <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                         <EditRowStyle BackColor="#999999" />
                         <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                     </asp:GridView>
                     </div>
                     
                     </td>
                    </tr>
                    <tr>
                    <td style="text-align: left;">
                        &nbsp;</td>
                    </tr>
                    <tr>
                    <td></td>
                    </tr>
                </table>
                </td>
            <td valign="top">
                <div id="tabs">
                 <ul>
				 <li style="text-align: left"><a href="#tabs-2">Target Details</a></li>
			     </ul>
                <%--<div id="tabs-1">
                <table align="center" style="width: 491px; height: 300px;">
                <tr>
                    <td valign="top">
                    
                        Graph</td>
                </tr>
                </table>
                </div>--%>
                <div id="tabs-2">
                <table align="center" style="width: 445px; height: 300px;">
                <tr><td colspan="2" align="right">&nbsp;<asp:Button ID="btnSetVariables" runat="server" 
                        BackColor="#ABD3FC" Text="Salary Variables" 
                        onclick="btnSetVariables_Click" />
&nbsp;<asp:Button ID="btnAddNewTarget" runat="server" 
                        Text="Add New Target" onclick="btnAddNewTarget_Click" 
                        BackColor="#ABD3FC" /></td></tr>
                <tr>
                    <td valign="top" align="center">
                    <asp:ScriptManager ID="ScriptManager1" runat="server">
                    </asp:ScriptManager> 
                        
                    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                    <ContentTemplate>         
                    <table style="width: 100%" align="center">
                           
                            <tr>
                                <td style="width:21%; text-align: left;">
                                    Login Name</td>
                                <td style="width:30%; text-align: left;">
                                    <asp:DropDownList ID="ddlLoginName" runat="server" Height="16px" Width="85px" 
                                        onselectedindexchanged="ddlLoginName_SelectedIndexChanged" AutoPostBack="true">
                                    </asp:DropDownList>
                                </td>
                                <td style="width:94px; text-align: left;">
                                    User Full Name</td>
                                <td style="width:15%; text-align: left;">
                                    <asp:TextBox ID="txtUserName" runat="server" Width="110px"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td style="width:21%; text-align: left;">
                                    Start Date</td>
                                <td style="width:30%; text-align: left;">
                                    <asp:TextBox ID="txtStartDate" runat="server" CssClass="mydatepickerclass" 
                                        Width="83px" Height="17px"></asp:TextBox>
                                    <%--<a href="#" id="dialog_link" >...</a>--%>
                                    <div id="dialog" title="Dialog Title">
	                                <div id="datepicker"></div>
		                            </div>

                                   

                                </td>
                                <td style="width:94px; text-align: left;">
                                    End Date</td>
                                <td style="width:15%; text-align: left;">
                                    <asp:TextBox ID="txtEndDate" runat="server" CssClass="mydatepickerclass" Width="110px"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td style="width:21%; text-align: left;">
                                    &nbsp;</td>
                                <td style="width:30%; text-align: left;">
                                    mm/dd/yyyy</td>
                                <td style="width:94px; text-align: left;">
                                    &nbsp;</td>
                                <td style="width:15%; text-align: left;">
                                    mm/dd/yyyy</td>
                            </tr>
                            <tr><td colspan="4" align="center"><b>:::Visit Entry Time:::</b></td></tr>
                            <tr>
                            <td align="left" style="width: 21%">Start Time</td>
                            <td align="left" style="width: 30%">
                                <asp:DropDownList ID="ddlhourStartTime" runat="server" Height="16px" Width="85px">
                                    <asp:ListItem>08:00 AM</asp:ListItem>
                                    <asp:ListItem>08:30 AM</asp:ListItem>
                                    <asp:ListItem>09:00 AM</asp:ListItem>
                                    <asp:ListItem>09:30 AM</asp:ListItem>
                                    <asp:ListItem>10:00 AM</asp:ListItem>
                                </asp:DropDownList>
                                                               
                                </td>
                            <td align="left" style="width: 94px">End Time</td>
                            <td align="left"><asp:DropDownList ID="ddlhourEndTime" runat="server" Height="16px" Width="85px">
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
                            
                            <td style="width:21%; text-align: left;">
                                Target Type</td>
                                
                                <td style="width:30%; text-align: left;">
                                    <asp:DropDownList ID="ddlTargetType" runat="server" AutoPostBack="true" 
                                        Height="16px" onselectedindexchanged="ddlTargetType_SelectedIndexChanged" 
                                        Width="85px" Enabled="False">
                                        <asp:ListItem></asp:ListItem>
                                    </asp:DropDownList>
                                </td>
                                <td style="width:94px; text-align: left;">
                                    Evaluation on</td>
                                <td style="width:15%; text-align: left;">
                                    <asp:DropDownList ID="ddlEvalOn" runat="server" Height="16px" Width="85px" 
                                        Enabled="False">
                                        <asp:ListItem>--Select--</asp:ListItem>
                                        <asp:ListItem>Monthly</asp:ListItem>
                                        <asp:ListItem>Weekly</asp:ListItem>
                                        <asp:ListItem>Daily</asp:ListItem>
                                    </asp:DropDownList>
                                </td>
                            </tr>
                            <tr>
                            
                            <td style="width:21%; text-align: left;">
                                No Of Visits</td>
                            <td style="width:30%; text-align: left;">
                                <asp:TextBox ID="txtNoOfVisits" runat="server" Width="110px" Enabled="False"></asp:TextBox>
                            </td>
                            <td style="width: 94px; text-align: left;">Target Amount </td>
                            <td style="width: 81px; text-align: left;">
                                <asp:TextBox ID="txtTargetAmount" runat="server" Width="110px" Enabled="False"></asp:TextBox>
                                </td>
                            </tr>
                            <%--<tr>
                            <td align="left" colspan="4"><%--Deduction %-age--%><%--<asp:DropDownList ID="ddlDeductionPercentage" runat="server" Height="16px" 
                                    Width="40px" Enabled="False">
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
                                    <asp:ListItem>27</asp:ListItem>
                                    <asp:ListItem>28</asp:ListItem>
                                    <asp:ListItem>29</asp:ListItem>
                                    <asp:ListItem>30</asp:ListItem>
                                </asp:DropDownList>--%> <%--Visit %-age--%><%-- <asp:DropDownList ID="ddlVisitPercentage" runat="server" Width="40px" 
                                    Height="16px" Enabled="False">
                                    <asp:ListItem>1</asp:ListItem>
                                    <asp:ListItem>2</asp:ListItem>
                                    <asp:ListItem>3</asp:ListItem>
                                    <asp:ListItem>4</asp:ListItem>
                                    <asp:ListItem>5</asp:ListItem>
                                    <asp:ListItem>6</asp:ListItem>
                                    <asp:ListItem>7
                                    </asp:ListItem>
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
                                    <asp:ListItem>27</asp:ListItem>
                                    <asp:ListItem>28</asp:ListItem>
                                    <asp:ListItem>29</asp:ListItem>
                                    <asp:ListItem>30</asp:ListItem>
                                </asp:DropDownList>--%> </td>
                            </tr>--%>
                            <tr><td colspan="4" style="height: 15px" align="left">
                                <asp:Label ID="lblMessage" runat="server"></asp:Label>
                                </td></tr>
                            <tr><td colspan="4">
                            <div id="Table_Targets" runat="server">
                            <table width="100%">
                           <tr>
                           <td align="center" style="background-color:#FF9933">
                               <b><asp:Label ID="lblTarget" runat="server" Text="Target"></asp:Label></b>
                               </td>
                           </tr>
                            <tr>
                           <td align="center">
                           <div id="divGridAddTarget" runat="server">
                           <asp:GridView ID="GridTargetAdd" runat="server" CellPadding="4" ForeColor="#333333" 
                                   GridLines="None" Width="324px">
                         
                               <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
                               <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                               <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
                               <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
                               <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                               <EditRowStyle BackColor="#999999" />
                               <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                         
                           </asp:GridView></div>
                           </td>
                           </tr><tr><td></td></tr>
                           <tr><td align="center"><div id="target_details" runat="server">
                           
                           <asp:GridView ID="DetailsGrid" runat="server" AutoGenerateColumns="False" 
                            CellPadding="4" ForeColor="#333333" GridLines="None" Width="396px" 
                                   onrowcommand="DetailsGrid_RowCommand" 
                                   onrowcancelingedit="DetailsGrid_RowCancelingEdit" 
                                   onrowediting="DetailsGrid_RowEditing" 
                                   onrowupdating="DetailsGrid_RowUpdating">
                            <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
                        <Columns>
                                                                     
                        <asp:TemplateField HeaderText="Target Name">
                        <ItemTemplate>
                        <asp:HiddenField ID="hdnTT_id" runat="server" Value='<%#Eval("ts_id") %>' />
                        <asp:Label ID="lblTargetName" runat="server" Text='<%#Eval("tt_name") %>'></asp:Label>
                        </ItemTemplate>
                        <EditItemTemplate>
                        <asp:DropDownList ID="ddltt_name" runat="server" DataSource="<%# PopulateTTDropDownList() %>" DataTextField="tt_name" DataValueField="tt_id"></asp:DropDownList>
                        </EditItemTemplate>
                        </asp:TemplateField>
                        
                        <asp:TemplateField HeaderText="Actual Target">
                        <ItemTemplate>
                        <asp:Label ID="lblActualTarget" runat="server" Text='<%#Eval("actual_target") %>'></asp:Label>
                        </ItemTemplate>
                        <EditItemTemplate>
                        <asp:TextBox ID="txtActualTarget" runat="server" Text='<%#Eval("actual_target") %>'></asp:TextBox>
                        </EditItemTemplate>
                        </asp:TemplateField>
                        
                        <asp:TemplateField HeaderText="Task Type">
                        <ItemTemplate>
                        <asp:Label ID="lblTaskType" runat="server" Text='<%#Eval("Evaluation_on") %>'></asp:Label>
                        </ItemTemplate>
                        <EditItemTemplate>
                        <asp:DropDownList ID="ddlEvalOn" runat="server">
                        <asp:ListItem>Daily</asp:ListItem>
                        <asp:ListItem>Weekly</asp:ListItem>
                        <asp:ListItem>Monthly</asp:ListItem>
                        </asp:DropDownList>
                        </EditItemTemplate>
                        </asp:TemplateField>
                        
                        <asp:TemplateField HeaderText="Actions">
                        <ItemTemplate>
                        <asp:ImageButton ID="imgbtnEdit1" runat="server" CommandName="Edit" CommandArgument='<%#Eval("ts_id") %>' ImageUrl="~/images1/Edit.gif" />
                        </ItemTemplate>
                        <EditItemTemplate>
                        <asp:ImageButton ID="imgbtnUpdte" runat="server" CommandName="Update" CommandArgument='<%#Eval("ts_id") %>' ImageUrl="~/images1/upload1.gif"  />
                       <asp:ImageButton ID="imgbtncancel" runat="server" CommandName="Cancel" CommandArgument='<%#Eval("ts_id") %>' ImageUrl="~/images1/delete.gif"  />
                      
                        </EditItemTemplate>
                        </asp:TemplateField>
                        
                        </Columns>
                            <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                            <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
                            <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
                            <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                            <EditRowStyle BackColor="#999999" />
                            <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                        </asp:GridView>
                           
                           </div></td></tr>
                           <tr>
                            <td align="center">
                            <div id="divButtonsNewTarget" runat="server">
                            <asp:Button ID="btnAdd" runat="server" Text="Add" onclick="btnAdd_Click" 
                                    BackColor="#ABD3FC" />
                            &nbsp;&nbsp;<asp:Button ID="btnDone" runat="server" Text="Target Done" 
                                    onclick="btnDone_Click1" BackColor="#ABD3FC" />
                            
                            
                            &nbsp;
                            
                            
                            <asp:Button ID="btnSave" runat="server" Text="Save" onclick="btnSave_Click" 
                                    BackColor="#ABD3FC" />
                            &nbsp;
                            <asp:Button ID="btnCancel" runat="server" Text="Cancel" onclick="btnCancel_Click" 
                                    BackColor="#ABD3FC" />
                            </div></td>
                            </tr>
                            <tr><td align="center"><div id="divEditUpdate" runat="server">&nbsp; 
                                </div></td></tr>
                        </table>
                        </div>
                        </ContentTemplate>
                        </asp:UpdatePanel> 
                    </td>
                </tr>
                </table>
                </div>
                
                </div>
                
                
                </td>
        </tr>
    </table> 
    <script type="text/javascript">
            Sys.WebForms.PageRequestManager.getInstance().add_endRequest(EndRequestHandler);
            function EndRequestHandler(sender, args) {
                $('.mydatepickerclass').datepicker({ dateFormat: 'mm/dd/yy' });
            }
    </script>
<%--    <script type="text/javascript">
    
    function Showcalender()
    {
    $('#dialog_link').click(function(){

    
    // Datepicker
				$('#datepicker').datepicker({
					inline: true
				});
				
				}

    
    }
      $(function() {
                 $(alert('This is Calender'));

                 $("input[id$='txtStartDate']").datepicker();      

        });
        
     

     $(function() {

      $("input[id$='txtEndDate']").datepicker();      

       }); 
    

</script>--%>

   
</asp:Content>


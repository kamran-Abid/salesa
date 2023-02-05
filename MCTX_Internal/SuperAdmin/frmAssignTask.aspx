<%@ Page Language="C#" MasterPageFile="MasterAdmin.master" AutoEventWireup="true"
    CodeFile="frmAssignTask.aspx.cs" Inherits="MCTX_Internal_SuperAdmin_frmAssignTask"
    Title="Assign Task" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <table style="width: 100%; height: 210px;">
        <tr>
            <td valign="top" style="height: 331px">
                <div id="tabs">
                    <ul>
                        <li style="text-align: left"><a href="#tabs-1">Assign Task</a></li>
                    </ul>
                    <div id="tabs-1">
                        <table style="border-style: groove; width: 100%; height: 90px;">
                            <tr>
                                <td style="text-align: left; width: 93px">
                                    <b><span style="font-size: small">Task Name:</span></b>
                                </td>
                                <td align="left" style="width: 226px">
                                    <asp:TextBox ID="txtTaskName" runat="server" Width="171px" Height="16px"></asp:TextBox>
                                </td>
                                <td style="text-align: left; width: 103px">
                                    <b><span style="font-size: small">User Name:</span></b>
                                </td>
                                <td align="left" style="width: 350px">
                                    <asp:DropDownList ID="ddlUserName" runat="server" Height="16px" Width="105px">
                                    </asp:DropDownList>
                                </td>
                            </tr>
                            <tr>
                                <td style="text-align: left; width: 93px">
                                    <b>Enter Task:</b>
                                </td>
                                <td align="left" style="width: 226px">
                                    <asp:TextBox ID="txtEnterTask" runat="server" TextMode="MultiLine" Width="173px"
                                        Height="35px"></asp:TextBox>
                                </td>
                                <td style="text-align: left; width: 103px">
                                    <b>Priority: </b>
                                </td>
                                <td align="left" style="width: 350px">
                                    <asp:RadioButtonList ID="RBtnPriority" runat="server" Width="64px">
                                        <asp:ListItem>High</asp:ListItem>
                                        <asp:ListItem>Low</asp:ListItem>
                                    </asp:RadioButtonList>
                                </td>
                            </tr>
                            <tr>
                                <td style="text-align: left; width: 93px">
                                    <b>Select Time:</b>
                                </td>
                                <td align="left" colspan="3">
                                    <asp:DropDownList ID="ddlDays" runat="server" Height="18px" Width="70px">
                                        <asp:ListItem>Day(s)</asp:ListItem>
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
                                        <asp:ListItem>31</asp:ListItem>
                                    </asp:DropDownList>
                                </td>
                            </tr>
                            <tr>
                                <td style="text-align: left; width: 93px">
                                    &nbsp;
                                </td>
                                <td align="left" colspan="3">
                                    <asp:Label ID="lblMessage" runat="server" Style="font-size: small"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td style="text-align: center;" colspan="4">
                                    <asp:Button ID="btnAddTask" runat="server" Text="Add Task" BackColor="#ABD3FC" ForeColor="Black"
                                        OnClick="btnAddTask_Click" />
                                </td>
                            </tr>
                            <tr>
                                <td style="border-style: inherit; height: 157px; text-align: left;" colspan="4">
                                </td>
                            </tr>
                        </table>
                    </div>
                </div>
            </td>
        </tr>
    </table>
</asp:Content>

<%@ Page Language="C#" MasterPageFile="MasterAdmin.master" AutoEventWireup="true"
    CodeFile="frmUservariables.aspx.cs" Inherits="MCTX_Internal_SuperAdmin_frmUservariables"
    Title="MCTX- User Variable" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <table style="width: 100%;">
        <tr>
            <td>
                <div id="tabs">
                    <ul>
                        <li style="text-align: left"><a href="#tabs-1">User Variables</a></li>
                    </ul>
                </div>
                <div id="tabs-1">
                    <table style="width: 100%; height: 66px">
                        <tr>
                            <td>
                                <table style="width: 100%; height: 166px">
                                    <tr>
                                        <td align="left" valign="top">
                                            <table align="center" style="width: 100%">
                                                <tr>
                                                    <td style="text-align: right">
                                                        <asp:Button ID="btnViewUserVariables" runat="server" BackColor="#A6D1FD" OnClick="btnViewUserVariables_Click"
                                                            Text="View Variables For User" />
                                                        &nbsp;
                                                        <asp:Button ID="btnWorkingDays" runat="server" BackColor="#A6D1FD" OnClick="btnWorkingDays_Click"
                                                            Text="Add Working Days" />
                                                        &nbsp;<asp:Button ID="btnsetvariable" runat="server" BackColor="#A6D1FD" Text="Set Variable"
                                                            Width="107px" OnClick="btnsetvariable_Click" />
                                                        &nbsp;<asp:Button ID="btnaddvariable" runat="server" BackColor="#A6D1FD" Text="Add Variable"
                                                            Width="106px" OnClick="btnaddvariable_Click" />
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td style="text-align: left">
                                                        <div id="addvariable" visible="false" runat="server">
                                                            <table style="width: 575px">
                                                                <tr>
                                                                    <td style="width: 27px">
                                                                        &nbsp;
                                                                    </td>
                                                                    <td style="border-style: none none dotted none; border-width: thin; border-color: #000000;
                                                                        color: #FF9900;" colspan="2">
                                                                        <b>Add Variable:</b>
                                                                    </td>
                                                                    <td>
                                                                        &nbsp;
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td style="width: 27px">
                                                                        &nbsp;
                                                                    </td>
                                                                    <td style="width: 131px">
                                                                        <b>Variable Name:</b>
                                                                    </td>
                                                                    <td style="width: 149px">
                                                                        <asp:TextBox ID="txtaddvariablename" runat="server"></asp:TextBox>
                                                                    </td>
                                                                    <td>
                                                                        <asp:Label ID="lblErrorMessage" runat="server"></asp:Label>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td style="width: 27px">
                                                                        &nbsp;
                                                                    </td>
                                                                    <td colspan="3">
                                                                        <asp:Label ID="lblmessage1" runat="server"></asp:Label>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td style="width: 27px">
                                                                        &nbsp;
                                                                    </td>
                                                                    <td style="text-align: center;" colspan="2">
                                                                        <asp:Button ID="btnsavenewvariable" runat="server" BackColor="#ABD3FC" Text="Save"
                                                                            OnClick="btnsavenewvariable_Click" />
                                                                        &nbsp;<asp:Button ID="btncancelnewvariable" runat="server" BackColor="#ABD3FC" Text="Cancel"
                                                                            OnClick="btncancelnewvariable_Click" />
                                                                    </td>
                                                                    <td>
                                                                        &nbsp;
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </div>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td style="text-align: left">
                                                        <div id="userdays" runat="server" visible="false">
                                                            <table style="width: 575px">
                                                                <tr>
                                                                    <td style="border-left: thin none #000000; border-right: thin none #000000; border-top: thin none #000000;
                                                                        border-bottom: thin dotted #000000; color: #FF9900; width: 25px;">
                                                                        &nbsp;
                                                                    </td>
                                                                    <td style="border-style: none none dotted none; border-width: thin; border-color: #000000;
                                                                        color: #FF9900;" colspan="2">
                                                                        <b>Users Working Days</b>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td style="color: #FF9900; width: 25px;">
                                                                    </td>
                                                                    <td style="color: #FF9900;" colspan="2">
                                                                        &nbsp;
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td style="width: 25px">
                                                                        &nbsp;
                                                                    </td>
                                                                    <td style="width: 107px">
                                                                        <b>Users: </b>
                                                                    </td>
                                                                    <td>
                                                                        <asp:DropDownList ID="ddlusers" runat="server" Width="121px" OnSelectedIndexChanged="ddlusers_SelectedIndexChanged"
                                                                            AutoPostBack="True">
                                                                        </asp:DropDownList>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td style="width: 25px; height: 17px;">
                                                                    </td>
                                                                    <td style="width: 107px; height: 17px;">
                                                                    </td>
                                                                    <td style="height: 17px">
                                                                        &nbsp;
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td style="width: 25px">
                                                                        &nbsp;
                                                                    </td>
                                                                    <td style="width: 107px" valign="top">
                                                                        <b>Working Days:</b>
                                                                    </td>
                                                                    <td>
                                                                        &nbsp;<table style="width: 100%; margin-bottom: 0px">
                                                                            <tr>
                                                                                <td style="width: 131px">
                                                                                    <asp:TextBox ID="txtWorkDays" runat="server" BackColor="#CCCCCC"></asp:TextBox>
                                                                                </td>
                                                                                <td>
                                                                                    <asp:RangeValidator ID="RVWorkDays" runat="server" ControlToValidate="txtWorkDays"
                                                                                        ErrorMessage="Please Enter only Integer Values" MaximumValue="31" MinimumValue="0"
                                                                                        Type="Integer"></asp:RangeValidator>
                                                                                </td>
                                                                            </tr>
                                                                        </table>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td style="width: 25px">
                                                                        &nbsp;
                                                                    </td>
                                                                    <td colspan="2">
                                                                        <asp:Label ID="lblmessage2" runat="server"></asp:Label>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td style="width: 25px">
                                                                        &nbsp;
                                                                    </td>
                                                                    <td style="width: 107px">
                                                                        &nbsp;
                                                                    </td>
                                                                    <td>
                                                                        <asp:Button ID="btnSave" runat="server" Text="Save" Height="17px" OnClick="btnSave_Click" />
                                                                        &nbsp;<asp:Button ID="btnBack" runat="server" OnClientClick="history.go(-1)" Text="Back" />
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </div>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td style="text-align: left">
                                                        <div id="setvariable" visible="false" runat="server">
                                                            <table style="width: 575px" align="left">
                                                                <tr>
                                                                    <td style="width: 27px">
                                                                        &nbsp;
                                                                    </td>
                                                                    <td style="border-style: none none dotted none; border-width: thin; border-color: #000000;
                                                                        color: #FF9900;" colspan="2">
                                                                        <b>Set Variable:
                                                                    </td>
                                                                    <td>
                                                                        &nbsp;
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td style="width: 27px">
                                                                        &nbsp;
                                                                    </td>
                                                                    <td style="width: 189px">
                                                                        <b>User Login Name:</b>
                                                                    </td>
                                                                    <td style="width: 150px">
                                                                        <asp:DropDownList ID="ddladduserid" runat="server" Width="131px" AutoPostBack="True"
                                                                            OnSelectedIndexChanged="ddladduserid_SelectedIndexChanged" BackColor="#CCCCCC">
                                                                        </asp:DropDownList>
                                                                    </td>
                                                                    <td>
                                                                        &nbsp;
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td style="width: 27px">
                                                                        &nbsp;
                                                                    </td>
                                                                    <td style="width: 189px">
                                                                        <b>User Full Name:</b>
                                                                    </td>
                                                                    <td style="width: 150px" align="left">
                                                                        <asp:TextBox ID="txtaddusername" runat="server"></asp:TextBox>
                                                                    </td>
                                                                    <td>
                                                                        &nbsp;
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td style="width: 27px">
                                                                        &nbsp;
                                                                    </td>
                                                                    <td style="width: 189px">
                                                                        <b>Select Variable:</b>
                                                                    </td>
                                                                    <td style="width: 150px">
                                                                        <asp:DropDownList ID="ddlselectvariable" runat="server" Width="131px" BackColor="#CCCCCC">
                                                                        </asp:DropDownList>
                                                                    </td>
                                                                    <td>
                                                                        &nbsp;
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td style="width: 27px">
                                                                        &nbsp;
                                                                    </td>
                                                                    <td style="width: 189px">
                                                                        <b>Evalution Criteria:</b>
                                                                    </td>
                                                                    <td style="width: 150px">
                                                                        <asp:DropDownList ID="ddlEvalCriteria" runat="server" Width="131px" BackColor="#CCCCCC">
                                                                        </asp:DropDownList>
                                                                    </td>
                                                                    <td>
                                                                        &nbsp;
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td style="width: 27px">
                                                                        &nbsp;
                                                                    </td>
                                                                    <td style="width: 189px">
                                                                        <b>Impact on Commission(%) :</b>
                                                                    </td>
                                                                    <td style="width: 150px">
                                                                        <asp:TextBox ID="txtcommissionpercent" runat="server"></asp:TextBox>
                                                                    </td>
                                                                    <td>
                                                                        <asp:RangeValidator ID="RVCommisionRange" runat="server" ControlToValidate="txtcommissionpercent"
                                                                            ErrorMessage="Range could only be from 0-100" MaximumValue="100" MinimumValue="0"
                                                                            Type="Integer"></asp:RangeValidator>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td style="width: 27px">
                                                                        &nbsp;
                                                                    </td>
                                                                    <td style="width: 189px">
                                                                        <b>Impact on Salary (%) :</b>
                                                                    </td>
                                                                    <td style="width: 150px">
                                                                        <asp:TextBox ID="txtdeductionpercent" runat="server"></asp:TextBox>
                                                                    </td>
                                                                    <td>
                                                                        <asp:RangeValidator ID="RangeValidator1" runat="server" ControlToValidate="txtdeductionpercent"
                                                                            ErrorMessage="Range could only be from 0-100" MaximumValue="100" MinimumValue="0"
                                                                            Type="Integer"></asp:RangeValidator>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td style="width: 27px">
                                                                        &nbsp;
                                                                    </td>
                                                                    <td colspan="3">
                                                                        <asp:Label ID="lblmessage" runat="server"></asp:Label>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td style="width: 27px">
                                                                        &nbsp;
                                                                    </td>
                                                                    <td style="text-align: center;" colspan="2">
                                                                        <asp:Button ID="btnsavevariable" runat="server" BackColor="#ABD3FC" Text="Save" Width="50px"
                                                                            OnClick="btnsavevariable_Click" />
                                                                        &nbsp;<asp:Button ID="btncancel" runat="server" BackColor="#ABD3FC" Text="Cancel"
                                                                            Width="50px" OnClick="btncancel_Click" />
                                                                    </td>
                                                                    <td>
                                                                        &nbsp;
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </div>
                </div>
            </td>
        </tr>
        <tr>
            <td>
                <div id="viewUserVariables" runat="server">
                    <table style="width: 781px" align="center">
                        <tr>
                            <td style="width: 27px">
                                &nbsp;
                            </td>
                            <td style="border-style: none none dotted none; border-width: thin; border-color: #000000;
                                color: #FF9900;" colspan="2">
                                <b>View Variables
                            </td>
                            <td>
                                &nbsp;
                            </td>
                            <td>
                                &nbsp;
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 27px">
                                &nbsp;
                            </td>
                            <td>
                                <b>User Id:</b>
                            </td>
                            <td style="width: 226px">
                                <asp:DropDownList ID="ddldisplayuserid" runat="server" Width="97px" AutoPostBack="True"
                                    OnSelectedIndexChanged="ddldisplayuserid_SelectedIndexChanged">
                                </asp:DropDownList>
                            </td>
                            <td>
                                <b>User Name:</b>
                            </td>
                            <td>
                                <asp:TextBox ID="txtDisplayusername" runat="server"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td style="text-align: left; width: 27px;">
                                &nbsp;
                            </td>
                            <td colspan="4" style="text-align: left">
                                <asp:GridView ID="Variablegrid" runat="server" BackColor="White" AutoGenerateColumns="false"
                                    BorderColor="#CCCCCC" BorderStyle="None" BorderWidth="1px" CellPadding="3" Width="629px"
                                    OnRowCommand="Variablegrid_RowCommand" OnRowCreated="Variablegrid_RowCreated"
                                    OnRowDeleting="Variablegrid_RowDeleting" OnRowEditing="Variablegrid_RowEditing"
                                    OnRowUpdating="Variablegrid_RowUpdating" Style="margin-left: 0px">
                                    <RowStyle ForeColor="#000066" />
                                    <FooterStyle BackColor="White" ForeColor="#000066" />
                                    <PagerStyle BackColor="White" ForeColor="#000066" HorizontalAlign="Left" />
                                    <SelectedRowStyle BackColor="#669999" Font-Bold="True" ForeColor="White" />
                                    <HeaderStyle BackColor="#006699" Font-Bold="True" ForeColor="White" />
                                    <Columns>
                                        <asp:TemplateField HeaderText="User Name">
                                            <ItemTemplate>
                                                <asp:Label ID="lblUserName" runat="server" Text='<%#Eval("[User Name]") %>'></asp:Label>
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <asp:TextBox ID="txtEname" runat="server" Text='<%#Eval("[User Name]") %>'></asp:TextBox>
                                            </EditItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Variable Name">
                                            <ItemTemplate>
                                                <asp:Label ID="lblVariable" runat="server" Text='<%#Eval("Variable") %>'></asp:Label>
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <asp:TextBox ID="txtVariable" runat="server" Text='<%#Eval("Variable") %>'></asp:TextBox>
                                            </EditItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="IOC">
                                            <ItemTemplate>
                                                <asp:Label ID="lblIOC" runat="server" Text='<%#Eval("[IOC %]") %>'></asp:Label>
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <asp:TextBox ID="txtIOC" runat="server" Text='<%#Eval("[IOC %]") %>'></asp:TextBox>
                                            </EditItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="IOS">
                                            <ItemTemplate>
                                                <asp:Label ID="lblIOS" runat="server" Text='<%#Eval("[IOS%]") %>'></asp:Label>
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <asp:TextBox ID="txtIOS" runat="server" Text='<%#Eval("[IOS%]") %>'></asp:TextBox>
                                            </EditItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Evaluation Criteria">
                                            <ItemTemplate>
                                                <asp:Label ID="lblEvalOn" runat="server" Text='<%#Eval("[Evaluation On]") %>'></asp:Label>
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <asp:TextBox ID="txtEvalOn" runat="server" Text='<%#Eval("[Evaluation On]") %>'></asp:TextBox>
                                            </EditItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Edit">
                                            <ItemTemplate>
                                                <asp:ImageButton ID="imgbtnEdit" runat="server" ImageUrl="~/images1/Edit.gif" CommandArgument='<%#Eval("UserVariable_Id") %>'
                                                    CommandName="Edit" />
                                            </ItemTemplate>
                                            <EditItemTemplate>
                                                <asp:ImageButton ID="imgbtnUpdate" runat="server" CommandArgument='<%#Eval("UserVariable_Id") %>'
                                                    CommandName="Update" ImageUrl="~/images1/view3.png" />
                                            </EditItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Delete">
                                            <ItemTemplate>
                                                <asp:ImageButton ID="imgbtnDelete" runat="server" ImageUrl="~/images1/delete.gif"
                                                    CommandArgument='<%#Eval("UserVariable_Id") %>' CommandName="Delete" OnClientClick="javascript:return confirm('Are You Sure You want to delete Record !');" />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                    </Columns>
                                </asp:GridView>
                            </td>
                        </tr>
                    </table>
                </div>
            </td>
        </tr>
    </table>
    </td> </tr> </table> </td> </tr> </table> </div> </td> </tr> </table>
</asp:Content>

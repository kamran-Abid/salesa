<%@ Page Language="C#" MasterPageFile="MasterAdmin.master" AutoEventWireup="true"
    CodeFile="frmInbox.aspx.cs" Inherits="MCTX_Internal_SuperAdmin_frmInbox" Title="Inbox" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <table style="width: 100%; height: 333px;">
        <tr>
            <td valign="top" style="height: 331px">
                <div id="tabs">
                    <ul>
                        <li style="text-align: left"><a href="#tabs-1">Tasks Inbox</a></li>
                    </ul>
                    <div id="tabs-1">
                        <table width="100%">
                            <tr>
                                <td align="right">
                                    <asp:Label ID="lblCounter" runat="server"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td align="right">
                                    <asp:Label ID="lblUserId" runat="server"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td align="center">
                                    <asp:GridView ID="GridInbox" runat="server" AutoGenerateColumns="False" Width="100%"
                                        CellPadding="4" ForeColor="#333333" GridLines="None" OnRowCommand="GridInbox_RowCommand"
                                        Style="margin-left: 0px">
                                        <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
                                        <Columns>
                                            <asp:TemplateField HeaderText="Task Name">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblTaskName" runat="server" Text='<%#Eval("TaskName") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Employee Name">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblEName" runat="server" Text='<%#Eval("E_Name") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Posted Date">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblTaskDate" runat="server" Text='<%#Eval("TaskDate") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Submission Date">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblEndDate" runat="server" Text='<%#Eval("EndDate") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Task Status">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblTaskStatus" runat="server" Text='<%#Eval("TaskStatus_Name") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Detail">
                                                <ItemTemplate>
                                                    <asp:ImageButton ID="imgbtnDetail" runat="server" CommandArgument='<%#Eval("TaskID")+","+Eval("E_Name")+","+Eval("TaskDate")+","+Eval("EndDate")+","+Eval("TaskRemarks")+","+Eval("TaskName")+","+Eval("TaskDetail") %>'
                                                        CommandName="Detail" ImageUrl="~/images1/view3.png" />
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                        </Columns>
                                        <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                                        <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
                                        <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
                                        <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                                        <EditRowStyle BackColor="#999999" />
                                        <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                                    </asp:GridView>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <input type="button" value="Back" Style="background-color: #2A4062;
                                color: White; width:104px;"
                                        onclick="history.go(-1)" />
                                </td>
                            </tr>
                        </table>
                    </div>
                </div>
            </td>
        </tr>
    </table>
</asp:Content>

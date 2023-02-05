<%@ Page Language="C#" MasterPageFile="MasterAdmin.master" AutoEventWireup="true"
    CodeFile="frmUser.aspx.cs" Inherits="MCTX_Internal_SuperAdmin_frmUser" Title="MCTX Create New User" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <script language="javascript" type="text/javascript">
        function confirmation() {
            if (confirm('Are you sure to want to delete?')) {
                alert('ok press')
                return true;
            }
            else {
                alert('Cancel Press')
                return false;
            }
        }
    </script>

    <table style="width: 100%; height: 333px;">
        <tr>
            <td valign="top" style="height: 331px">
                <div id="tabs">
                    <ul>
                        <li style="text-align: left"><a href="#tabs-1">User Information</a></li>
                    </ul>
                    <div id="tabs-1">
                        <table style="width: 100%">
                            <tr>
                                <td style="width: 117px; text-align: left">
                                    <b>Select Employee:</b>
                                </td>
                                <td style="width: 98px">
                                    <asp:DropDownList ID="ddlEmpFullName" runat="server" Height="15px" Width="125px">
                                    </asp:DropDownList>
                                </td>
                                <td style="width: 122px; text-align: left">
                                    <b>User Role:</b>
                                </td>
                                <td align="left">
                                    <asp:DropDownList ID="ddlRoles" runat="server" Height="15px" Width="125px">
                                    </asp:DropDownList>
                                </td>
                            </tr>
                            <tr>
                                <td style="width: 117px; text-align: left">
                                    <b>UserName:</b>
                                </td>
                                <td style="width: 98px">
                                    <asp:TextBox ID="txtUserName" runat="server" Height="15px" Width="125px"></asp:TextBox>
                                </td>
                                <td style="width: 122px">
                                    <asp:Button ID="btnCheckAvailable" runat="server" Text="Check Available" Width="124px"
                                        BackColor="#ABD3FC" OnClick="btnCheckAvailable_Click" />
                                </td>
                                <td style="text-align: left">
                                    <asp:Label ID="lblAvailable" runat="server"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td style="width: 117px; text-align: left">
                                    <b>Password:</b>
                                </td>
                                <td style="width: 98px">
                                    <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" Height="15px" Width="125px"></asp:TextBox>
                                </td>
                                <td style="width: 122px">
                                    <b style="text-align: left">Confirm Password:</b>
                                </td>
                                <td align="left">
                                    <asp:TextBox ID="txtConfirmPassword" runat="server" TextMode="Password" Height="15px"
                                        Width="125px"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td style="width: 117px; text-align: left">
                                    <asp:Button ID="btnSaveUser" runat="server" Text="Save" OnClick="btnSaveUser_Click"
                                        Width="53px" BackColor="#ABD3FC" />
                                    &nbsp;<asp:Button ID="btnCancelUser" runat="server" Text="Cancel" OnClick="btnCancelUser_Click"
                                        BackColor="#ABD3FC" />
                                </td>
                                <td colspan="3" style="text-align: left">
                                    <asp:Label ID="lblMessage" runat="server"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="4" style="text-align: left">
                                    <asp:GridView ID="UsersGrid" runat="server" AutoGenerateColumns="False" Width="100%"
                                        CellPadding="4" ForeColor="#333333" GridLines="None" OnRowCommand="UsersGrid_RowCommand"
                                        OnRowDeleting="UsersGrid_RowDeleting">
                                        <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
                                        <Columns>
                                            <asp:TemplateField HeaderText="Employee Name">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblEname" runat="server" Text='<%#Eval("E_Name") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Login Id">
                                                <ItemTemplate>
                                                    <asp:Label ID="lbluserid" runat="server" Text='<%#Eval("user_id") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Role Name">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblrolename" runat="server" Text='<%#Eval("role_name") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <%-- <asp:TemplateField HeaderText="Status">
                                        <ItemTemplate>
                                        
                                        <asp:Label ID="lblstatusname" Visible="false" runat="server" Text='<%#Eval("status_name") %>'></asp:Label>
                                        </ItemTemplate>
                                        </asp:TemplateField>--%>
                                            <asp:TemplateField HeaderText="Delete">
                                                <ItemTemplate>
                                                    <asp:ImageButton ID="lnkDelete" runat="server" OnClientClick="return confirmation();"
                                                        Text="Delete" CommandName="Delete" CommandArgument='<%#Eval("user_id") %>' ImageUrl="~/images1/delete.gif">
                                                    </asp:ImageButton>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <%--<asp:TemplateField HeaderText="Approve">
                                        <ItemTemplate>
                                        <asp:LinkButton ID="lnkApprove" runat="server" Text="Approve" CommandName="Delete"></asp:LinkButton>
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
                                </td>
                            </tr>
                        </table>
                    </div>
                </div>
            </td>
        </tr>
    </table>
</asp:Content>

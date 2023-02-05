<%@ Page Language="C#" MasterPageFile="MasterAdmin.master" AutoEventWireup="true"
    CodeFile="frmDeptInfo.aspx.cs" Inherits="MCTX_Internal_SuperAdmin_frmDeptInfo"
    Title="MCTX Department Info" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <table style="width: 100%; height: 586px;">
        <tr>
            <td valign="top" style="height: 331px">
                <div id="tabs">
                    <ul>
                        <li style="text-align: left"><a href="#tabs-1">Department Information</a></li>
                        <li style="text-align: left"><a href="#tabs-2">Add New Designation</a></li>
                    </ul>
                    <div id="tabs-1">
                        <table style="width: 100%; height: 259px;">
                            <tr>
                                <td style="width: 389px">
                                    <table style="width: 202%" align="center">
                                        <tr>
                                            <td style="width: 150px; text-align: left">
                                                <b>Select Branch:</b>
                                            </td>
                                            <td align="left">
                                                <asp:DropDownList ID="ddlSelectBranch" runat="server">
                                                </asp:DropDownList>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="width: 150px; text-align: left">
                                                <b>Department Name:</b>
                                            </td>
                                            <td align="left">
                                                <asp:TextBox ID="txtDeptName" runat="server"></asp:TextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="width: 150px; text-align: left">
                                                <b>Phone1:</b>
                                            </td>
                                            <td align="left">
                                                <asp:TextBox ID="txtPhone1" runat="server"></asp:TextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="width: 150px; text-align: left">
                                                <b>Phone2:</b>
                                            </td>
                                            <td align="left">
                                                <asp:TextBox ID="txtPhone2" runat="server"></asp:TextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="width: 150px; text-align: left">
                                                <b>Address:</b>
                                            </td>
                                            <td align="left">
                                                <asp:TextBox ID="txtAddress" runat="server" TextMode="MultiLine"></asp:TextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="2" align="left">
                                                <asp:Label ID="lblMessage1" runat="server"></asp:Label>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="width: 150px">
                                            </td>
                                            <td align="left">
                                                <asp:Button ID="btnSave" runat="server" Text="Save" OnClick="btnSave_Click" BackColor="#99CCFF" />&nbsp;
                                                <asp:Button ID="btnCancel" runat="server" Text="Cancel" OnClick="btnCancel_Click"
                                                    BackColor="#99CCFF" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="2">
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="2">
                                                <div id="DeptGrid">
                                                    <asp:GridView ID="DepartmentGrid" runat="server" AutoGenerateColumns="false" Width="100%">
                                                        <Columns>
                                                            <asp:TemplateField HeaderText="Branch Name">
                                                                <ItemTemplate>
                                                                    <asp:HiddenField ID="hdn" runat="server" Value='<%#Eval("") %>' />
                                                                    <asp:Label ID="lblBranchName" runat="server" Text='<%#Eval("") %>'></asp:Label>
                                                                </ItemTemplate>
                                                            </asp:TemplateField>
                                                            <asp:TemplateField HeaderText="Department Name">
                                                                <ItemTemplate>
                                                                    <asp:Label ID="lblDepartment" runat="server" Text='<%#Eval("Desig_Name") %>'></asp:Label>
                                                                </ItemTemplate>
                                                                <EditItemTemplate>
                                                                    <asp:TextBox ID="txtDepartment" runat="server" Text='<%#Eval("Desig_Name") %>'></asp:TextBox>
                                                                </EditItemTemplate>
                                                            </asp:TemplateField>
                                                            <asp:TemplateField HeaderText="Branch Address">
                                                                <ItemTemplate>
                                                                    <asp:Label ID="lblDesignation" runat="server" Text='<%#Eval("D_NAME") %>'></asp:Label>
                                                                </ItemTemplate>
                                                                <EditItemTemplate>
                                                                    <asp:TextBox ID="txtDesignation" runat="server" Text='<%#Eval("D_NAME") %>'></asp:TextBox>
                                                                </EditItemTemplate>
                                                            </asp:TemplateField>
                                                            <asp:TemplateField HeaderText="Edit">
                                                                <ItemTemplate>
                                                                    <asp:LinkButton ID="lnkEdit" runat="server" Text="Edit" CommandArgument='<%#Eval("") %>'
                                                                        CommandName="Edit"></asp:LinkButton>
                                                                </ItemTemplate>
                                                            </asp:TemplateField>
                                                            <asp:TemplateField HeaderText="Delete">
                                                                <ItemTemplate>
                                                                    <asp:LinkButton ID="lnkDelete" runat="server" Text="Delete" CommandArgument='<%#Eval("") %>'
                                                                        CommandName="Delete"></asp:LinkButton>
                                                                </ItemTemplate>
                                                            </asp:TemplateField>
                                                        </Columns>
                                                    </asp:GridView>
                                                </div>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                                <%--<td>
                            &nbsp;</td>--%>
                            </tr>
                        </table>
                    </div>
                    <div id="tabs-2">
                        <table style="width: 100%; height: 259px;">
                            <tr>
                                <td style="width: 389px" valign="top">
                                    <table style="width: 205%; vertical-align: top; height: 113px;" align="center">
                                        <tr>
                                            <td style="width: 108px; text-align: left">
                                                <b>Designation:</b>
                                            </td>
                                            <td align="left">
                                                <asp:TextBox ID="txtdesignation" runat="server"></asp:TextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="2" align="left">
                                                <asp:Label ID="lblMessage2" runat="server"></asp:Label>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="2" align="center" style="text-align: left; height: 7px">
                                                <asp:Button ID="btnSaveDesignation" runat="server" Text="Save" OnClick="btnSaveDesignation_Click"
                                                    BackColor="#99CCFF" />
                                                &nbsp;
                                                <asp:Button ID="btnCancelDesig" runat="server" Text="Cancel" OnClick="btnCancelDesig_Click"
                                                    BackColor="#99CCFF" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="center" colspan="2">
                                                <div id="GridDesig">
                                                    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="false" Width="50%">
                                                        <Columns>
                                                            <asp:TemplateField HeaderText="Designation">
                                                                <ItemTemplate>
                                                                    <asp:HiddenField ID="hdn" runat="server" Value='<%#Eval("") %>' />
                                                                    <asp:Label ID="lblDesignation" runat="server" Text='<%#Eval("") %>'></asp:Label>
                                                                </ItemTemplate>
                                                            </asp:TemplateField>
                                                            <asp:TemplateField HeaderText="Delete">
                                                                <ItemTemplate>
                                                                    <asp:LinkButton ID="lnkDelete" runat="server" Text="Delete" CommandArgument='<%#Eval("") %>'
                                                                        CommandName="Delete"></asp:LinkButton>
                                                                </ItemTemplate>
                                                            </asp:TemplateField>
                                                        </Columns>
                                                    </asp:GridView>
                                                </div>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                                <%-- <td>
                            &nbsp;</td>--%>
                            </tr>
                        </table>
                    </div>
                </div>
            </td>
        </tr>
    </table>
</asp:Content>

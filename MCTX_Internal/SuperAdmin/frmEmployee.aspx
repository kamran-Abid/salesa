<%@ Page Language="C#" MasterPageFile="MasterAdmin.master" AutoEventWireup="true"
    CodeFile="frmEmployee.aspx.cs" Inherits="MCTX_Internal_SuperAdmin_frmEmployee"
    Title="Mechatronix Employee Information" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <table style="width: 100%; height: 333px;">
        <tr>
            <td valign="top" style="height: 331px; width: 100%">
                <div id="tabs">
                    <ul>
                        <li style="text-align: left"><a href="#tabs-1">Personal Information</a></li>
                    </ul>
                    <div id="tabs-1">
                        <table style="width: 100%; height: 359px;">
                            <tr>
                                <td colspan="2" align="right">
                                    <asp:Button ID="btnAddNewEmployee" runat="server" Text="Add New Employee" OnClick="btnAddNewEmployee_Click" />
                                </td>
                            </tr>
                            <tr>
                                <td valign="top" style="border-color: #000000; border-style: none none dotted none;
                                    border-width: thin; width: 373px">
                                    <table style="width: 96%" align="center">
                                        <tr>
                                            <td style="text-align: left" colspan="2">
                                                <span style="color: #FF9900">*Enter Employee Information:</span>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="width: 118px; text-align: left">
                                                Empoyee Id:
                                            </td>
                                            <td align="left" style="color: Red">
                                                <asp:TextBox ID="txtEmpID" runat="server" BorderStyle="Dotted" CausesValidation="True"></asp:TextBox>
                                                &nbsp;mctx-city-xxxx
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="width: 118px; text-align: left">
                                                Employee Name:
                                            </td>
                                            <td align="left">
                                                <asp:TextBox ID="txtEmpName" runat="server" BorderStyle="Dotted"></asp:TextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="width: 118px; text-align: left">
                                                Phone:
                                            </td>
                                            <td align="left" style="color: Red">
                                                <asp:TextBox ID="txtPhone" runat="server" BorderStyle="Dotted"></asp:TextBox>
                                                &nbsp;92-xx-xxxxxxx
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="width: 118px; text-align: left">
                                                Mobile:
                                            </td>
                                            <td align="left" style="color: Red">
                                                <asp:TextBox ID="txtMobile" runat="server" BorderStyle="Dotted"></asp:TextBox>
                                                &nbsp;92-xxx-xxxxxxx
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="width: 118px; text-align: left">
                                                Gender:
                                            </td>
                                            <td align="left">
                                                <asp:DropDownList ID="ddlGender" runat="server">
                                                    <asp:ListItem>--Select--</asp:ListItem>
                                                    <asp:ListItem>Male</asp:ListItem>
                                                    <asp:ListItem>Female</asp:ListItem>
                                                </asp:DropDownList>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="width: 118px; text-align: left; height: 20px;">
                                                Education:
                                            </td>
                                            <td align="left" style="height: 20px">
                                                <asp:TextBox ID="txtEducation" runat="server" BorderStyle="Dotted"></asp:TextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="width: 118px; text-align: left">
                                                CNIC:
                                            </td>
                                            <td align="left" style="color: Red">
                                                <asp:TextBox ID="txtCNIC" runat="server" BorderStyle="Dotted"></asp:TextBox>
                                                &nbsp;xxxxx-xxxxxxx-x
                                            </td>
                                        </tr>
                                        <%--<tr>
                                    <td style="width: 118px; text-align: left">
                                        Upload Image:</td>
                                    <td align="left" style="height:18px">
                                        <asp:FileUpload ID="FUImageEmp" runat="server" BorderStyle="Dotted" 
                                            Width="183px" />
                                    </td>
                                </tr>--%>
                                        <tr>
                                            <td style="width: 118px; text-align: left">
                                                D.O.B
                                            </td>
                                            <td align="left">
                                                <asp:TextBox ID="txtDOB" runat="server"></asp:TextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="width: 118px; text-align: left">
                                                Home Address:
                                            </td>
                                            <td align="left">
                                                <asp:TextBox ID="txtAddress" runat="server" TextMode="MultiLine" BorderStyle="Dotted"></asp:TextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="text-align: left" colspan="2">
                                                <span style="color: #FF9900">*Emergency Contact information:</span>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="width: 118px; text-align: left">
                                                Phone-1:
                                            </td>
                                            <td align="left" style="color: Red;">
                                                <asp:TextBox ID="txtPhone1" runat="server" BorderStyle="Dotted"></asp:TextBox>
                                                &nbsp;92-xx-xxxxxxx
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="width: 118px; text-align: left;">
                                                Gaurdian Mobile:
                                            </td>
                                            <td align="left" style="color: Red">
                                                <asp:TextBox ID="txtGaurdianMobile" runat="server" BorderStyle="Dotted"></asp:TextBox>
                                                &nbsp;92-xxx-xxxxxxx
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="2" align="left">
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                                <td valign="top" style="border-color: #000000; border-style: none none dotted dotted;
                                    border-width: thin;">
                                    <table style="width: 322px; height: 94px;" align="center">
                                        <tr>
                                            <td style="text-align: left" colspan="2">
                                                <span style="color: #FF9900">*Enter Employee Official Information:</span>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="width: 148px; text-align: left">
                                                Branch:
                                            </td>
                                            <td align="left">
                                                <asp:DropDownList ID="ddlBranch" runat="server" Width="100px">
                                                </asp:DropDownList>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="width: 148px; text-align: left">
                                                Department:
                                            </td>
                                            <td align="left">
                                                <asp:DropDownList ID="ddlDepartment" runat="server" Width="100px">
                                                </asp:DropDownList>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="width: 148px; text-align: left; height: 16px;">
                                                Designation:
                                            </td>
                                            <td style="height: 16px" align="left">
                                                <asp:DropDownList ID="ddlDesignation" runat="server" Width="100px">
                                                </asp:DropDownList>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="width: 148px; text-align: left">
                                                Start Date:
                                            </td>
                                            <td align="left">
                                                <asp:TextBox ID="txtStartDate" runat="server" BorderStyle="Dotted"></asp:TextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="text-align: left" colspan="2">
                                                &nbsp;
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="text-align: left" colspan="2">
                                                <span style="color: #FF9900">*Salary Information:</span>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="width: 148px; text-align: left">
                                                Basic Salary:
                                            </td>
                                            <td align="left">
                                                <asp:TextBox ID="txtBasicSalary" runat="server" BorderStyle="Dotted"></asp:TextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="width: 148px; text-align: left">
                                                Travlling Allowence:
                                            </td>
                                            <td align="left">
                                                <asp:TextBox ID="txtTravllingAllow" runat="server" BorderStyle="Dotted"></asp:TextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="width: 148px; text-align: left">
                                                Mobile Allowence:
                                            </td>
                                            <td align="left">
                                                <asp:TextBox ID="txtMobileAllow" runat="server" BorderStyle="Dotted"></asp:TextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="width: 148px; text-align: left">
                                                Other Allowences:
                                            </td>
                                            <td align="left">
                                                <asp:TextBox ID="txtOtherAllow" runat="server" BorderStyle="Dotted"></asp:TextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="text-align: left" colspan="2">
                                                &nbsp;
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="text-align: left" colspan="2">
                                                &nbsp;
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="width: 148px; text-align: left">
                                                <asp:Button ID="btnSave" runat="server" Text="Save" OnClick="btnSave_Click" />
                                                &nbsp;<asp:Button ID="btnCancel" runat="server" Text="Cancel" OnClick="btnCancel_Click" />
                                            </td>
                                            <td align="left">
                                                &nbsp;
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="width: 148px; text-align: left">
                                                &nbsp;
                                            </td>
                                            <td align="left">
                                                &nbsp;
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="width: 148px; text-align: left">
                                                &nbsp;
                                            </td>
                                            <td align="left">
                                                &nbsp;
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="text-align: right" colspan="2">
                                                <asp:Label ID="lblMessage" runat="server"></asp:Label>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                        </table>
                    </div>
                    <div id="tabs-5">
                        <table style="width: 100%; height: 259px;">
                            <tr>
                                <td>
                                    <table style="width: 100%" align="center">
                                        <tr>
                                            <td style="width: 100%; text-align: left" valign="top">
                                                <div style="overflow: auto">
                                                    <asp:GridView ID="EmployeesGrid" runat="server" AutoGenerateColumns="False" Width="100%"
                                                        OnRowCancelingEdit="EmployeesGrid_RowCancelingEdit" OnRowCommand="EmployeesGrid_RowCommand"
                                                        OnRowDeleting="EmployeesGrid_RowDeleting" OnRowEditing="EmployeesGrid_RowEditing"
                                                        OnRowUpdating="EmployeesGrid_RowUpdating" CellPadding="4" ForeColor="#333333"
                                                        GridLines="None">
                                                        <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
                                                        <Columns>
                                                            <asp:TemplateField HeaderText="Employee ID">
                                                                <ItemTemplate>
                                                                    <asp:Label ID="lblEmpNo" runat="server" Text='<%#Eval("E_badge") %>'></asp:Label>
                                                                </ItemTemplate>
                                                            </asp:TemplateField>
                                                            <asp:TemplateField HeaderText="Name">
                                                                <ItemTemplate>
                                                                    <asp:Label ID="lblName" runat="server" Text='<%#Eval("E_Name") %>'></asp:Label>
                                                                </ItemTemplate>
                                                            </asp:TemplateField>
                                                            <asp:TemplateField HeaderText="Department">
                                                                <ItemTemplate>
                                                                    <asp:Label ID="lblDepartment" runat="server" Text='<%#Eval("Desig_Name") %>'></asp:Label>
                                                                </ItemTemplate>
                                                                <%--<EditItemTemplate>
                                        <asp:TextBox ID="txtDepartment" runat="server" Text='<%#Eval("Desig_Name") %>'></asp:TextBox>
                                        </EditItemTemplate>--%>
                                                            </asp:TemplateField>
                                                            <asp:TemplateField HeaderText="Designation">
                                                                <ItemTemplate>
                                                                    <asp:Label ID="lblDesignation" runat="server" Text='<%#Eval("D_NAME") %>'></asp:Label>
                                                                </ItemTemplate>
                                                                <%--<EditItemTemplate>
                                        <asp:TextBox ID="txtDesignation" runat="server" Text='<%#Eval("D_NAME") %>'></asp:TextBox>
                                        </EditItemTemplate>--%>
                                                            </asp:TemplateField>
                                                            <asp:TemplateField HeaderText="Edit">
                                                                <ItemTemplate>
                                                                    <asp:ImageButton ID="imgbtnEdit" runat="server" ImageUrl="~/images1/Edit.gif" Text="Edit"
                                                                        CommandArgument='<%#Eval("E_badge") %>' CommandName="Edit"></asp:ImageButton>
                                                                </ItemTemplate>
                                                            </asp:TemplateField>
                                                            <asp:TemplateField HeaderText="Delete">
                                                                <ItemTemplate>
                                                                    <asp:ImageButton ID="imgbtnDelete" runat="server" ImageUrl="~/images1/delete.gif"
                                                                        Text="Delete" CommandArgument='<%#Eval("E_badge") %>' CommandName="Delete"></asp:ImageButton>
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
                                                </div>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                        </table>
                    </div>
                </div>
            </td>
        </tr>
        <tr>
            <td valign="top">
                <div id="Buttons">
                    &nbsp;
                </div>
            </td>
        </tr>
    </table>

    <script type="text/javascript" language="javascript">
    $(function() {
                 $("input[id$='txtDOB']").datepicker();      
                 }
     );
    </script>

    <script type="text/javascript" language="javascript">
    function validate()
    {
         if (document.getElementById("<%=txtEmpID.ClientID%>").value=="")
            {
                 alert("Employee ID Feild can not be blank");
                 //document.getElementById("<%=txtEmpID.ClientID%>").focus();
                 return false;
            }
    }
    </script>

</asp:Content>

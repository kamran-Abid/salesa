<%@ Page Language="C#" MasterPageFile="~/MCTX_Internal/SuperAdmin/MasterAdmin.master"
    AutoEventWireup="true" CodeFile="frmVisits.aspx.cs" Inherits="MCTX_Internal_SuperAdmin_frmVisits"
    Title="MCTX Visit Information" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <script language="javascript" type="text/javascript">
function validate()
{
      if (document.getElementById("<%=txtRemarks.ClientID%>").value=="")
      {
                 alert("Remarks feild can not be blank");
                 document.getElementById("<%=txtRemarks.ClientID%>").focus();
                 return false;
      }
}
    </script>

    <table style="width: 100%; height: 631px;" cellpadding="0">
        <tr>
            <td valign="top" style="height: 331px">
                <div id="tabs">
                    <ul>
                        <li style="text-align: left"><a href="#tabs-1">Add Visit Information</a></li>
                    </ul>
                    <div id="tabs-1">
                        <table style="width: 97%; height: 259px;">
                            <tr>
                                <td style="width: 389px">
                                    <table style="width: 97%" align="center">
                                        <tr>
                                            <td style="height: 22px; width: 175px; text-align: left;">
                                                <img alt="" src="image/blinkingArrow.gif" style="height: 17px; width: 39px" /><asp:LinkButton
                                                    ID="txt_linkedbutton" runat="server" OnClick="txt_linkedbutton_Click">Hide upcoming visits</asp:LinkButton>
                                            </td>
                                            <%--<td style="height: 22px; text-align: right;" align="left" 
                                    colspan="4">
                                        &nbsp;<asp:Button ID="btnAddClient" runat="server" 
                                        style="BACKGROUND-COLOR: #99ccff" Text="Add Client" Width="155px" 
                                            onclick="btnAddClient_Click" />
                                    &nbsp;<asp:Button ID="btnAddCompany" runat="server" 
                                            style="BACKGROUND-COLOR: #99ccff" Text="Add Company" Width="155px" 
                                            onclick="btnAddCompany_Click" />
                                    &nbsp;<asp:Button ID="btnAddproduct" runat="server" 
                                            style="BACKGROUND-COLOR: #99ccff" Text="Add Product" Width="155px" onclick="btnAddproduct_Click" 
                                            />
                                                                                    </td>--%></tr>
                                        <tr>
                                            <td style="height: 22px;" colspan="5" valign="top">
                                                <div id="upcomingvisits" visible="false" runat="server">
                                                    <table style="border: thin dotted #000000; width: 100%">
                                                        <tr>
                                                            <td>
                                                                <asp:GridView ID="GridView_UCVisit" runat="server" BackColor="White" BorderColor="#CCCCCC"
                                                                    BorderStyle="None" BorderWidth="1px" CellPadding="3" Style="text-align: left;
                                                                    font-size: x-small" Width="100%" Height="1px">
                                                                    <RowStyle ForeColor="#000066" />
                                                                    <FooterStyle BackColor="White" ForeColor="#000066" />
                                                                    <PagerStyle BackColor="White" ForeColor="#000066" HorizontalAlign="Left" />
                                                                    <SelectedRowStyle BackColor="#669999" Font-Bold="True" ForeColor="White" />
                                                                    <HeaderStyle BackColor="#006699" Font-Bold="True" ForeColor="White" Font-Names="Verdana" />
                                                                </asp:GridView>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                <div id="emptyupcomingvisits" visible="false" runat="server">
                                                                    <table bgcolor="White" style="width: 100%">
                                                                        <tr>
                                                                            <td style="color: #FFFFFF; font-size: x-small; text-align: left; background-color: #006699">
                                                                                <b>Remind date
                                                                            </td>
                                                                            <td style="color: #FFFFFF; text-align: left; background-color: #006699">
                                                                                <span style="font-size: x-small">Company name
                                                                            </td>
                                                                            <td style="color: #FFFFFF; text-align: left; background-color: #006699">
                                                                                Client name
                                                                            </td>
                                                                            <td style="color: #FFFFFF; text-align: left; background-color: #006699">
                                                                                Client mobile
                                                                            </td>
                                                                            <td style="color: #FFFFFF; text-align: left; background-color: #006699">
                                                                                Client email
                                                                            </td>
                                                                            <td style="color: #FFFFFF; text-align: left; background-color: #006699">
                                                                                Last visit</span></b>
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td colspan="6">
                                                                                <span style="color: #006600">No upcoming visits for you within next <b>05</b> days</span>
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </div>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </div>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="5" style="font-size: small; color: #FF9900; text-align: left;">
                                                <b>Visit Information:</b>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="width: 175px; text-align: left; font-size: small;">
                                                Company Name:
                                            </td>
                                            <td align="left" style="width: 190px">
                                                <asp:DropDownList ID="ddlCompanyName" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddlCompanyName_SelectedIndexChanged"
                                                    Width="150px" CssClass="myselect">
                                                </asp:DropDownList>
                                            </td>
                                            <td align="left" style="font-size: small;" colspan="2">
                                                Client Name:
                                            </td>
                                            <td align="left">
                                                <asp:DropDownList ID="ddlClientName" runat="server" Width="156px" OnSelectedIndexChanged="ddlClientName_SelectedIndexChanged"
                                                    AutoPostBack="True">
                                                </asp:DropDownList>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="width: 175px; text-align: left; font-size: small;">
                                                Type of call:
                                            </td>
                                            <td align="left" style="width: 190px">
                                                <asp:DropDownList ID="ddlTypeofCall" runat="server" Width="150px">
                                                </asp:DropDownList>
                                            </td>
                                            <td align="left" style="font-size: small;" colspan="2">
                                                Add Excuse
                                            </td>
                                            <td align="left">
                                                <asp:ImageButton ID="ImgbtnExcuse" OnClick="ImageButton1_Click" runat="server" ImageUrl="~/images1/excuse5.jpg"
                                                    Height="25px" Width="37px"></asp:ImageButton>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="width: 175px; text-align: left; font-size: small; height: 22px;">
                                                Total Sales Amount:
                                            </td>
                                            <td align="left" style="height: 22px; width: 190px;">
                                                <asp:TextBox ID="txtSaleAmount" runat="server" Enabled="False"></asp:TextBox>
                                            </td>
                                            <td style="font-size: small;" align="left" colspan="2">
                                                Client Response:
                                            </td>
                                            <td align="left">
                                                <asp:DropDownList ID="ddlClientResponse" runat="server" Width="156px">
                                                </asp:DropDownList>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="width: 175px; text-align: left; font-size: small;">
                                                Remind date:
                                            </td>
                                            <td align="left" style="width: 190px">
                                                <asp:TextBox ID="txtreminderdate" runat="server"></asp:TextBox>
                                            </td>
                                            <td style="font-size: small; width: 111px;" align="left">
                                                Remarks:
                                            </td>
                                            <td style="font-size: small; width: 77px;" align="left">
                                                &nbsp;
                                            </td>
                                            <td align="left">
                                                <asp:TextBox ID="txtRemarks" runat="server" TextMode="MultiLine" Width="171px"></asp:TextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="5" style="font-size: small; color: #FF9900; text-align: left;">
                                                <b>Item Information:</b><table align="center" style="width: 96%">
                                                    <tr>
                                                        <td style="border-width: thin; border-style: dotted none none none; border-color: #000000">
                                                            <table align="left" style="width: 101%; border-left-style: none; border-left-width: thin;
                                                                border-right-style: none; border-right-width: thin; border-top-style: dotted;
                                                                border-top-width: thin; border-bottom-style: none; border-bottom-width: thin;">
                                                                <tr>
                                                                    <td style="border-style: none none dotted none; border-width: thin; border-color: #000000;
                                                                        width: 307px" valign="top">
                                                                        <table align="left" style="width: 334px" width="120">
                                                                            <tr>
                                                                                <td style="width: 114px; color: #333300">
                                                                                    Category
                                                                                </td>
                                                                                <td style="width: 174px">
                                                                                    <asp:DropDownList ID="ddlCategory" runat="server" Width="150px" AutoPostBack="True"
                                                                                        OnSelectedIndexChanged="ddlCategory_SelectedIndexChanged1" ToolTip="Select Category">
                                                                                    </asp:DropDownList>
                                                                                </td>
                                                                            </tr>
                                                                            <tr>
                                                                                <td style="width: 114px; color: #333300">
                                                                                    Item
                                                                                </td>
                                                                                <td style="width: 174px">
                                                                                    <span style="color: #333300">
                                                                                        <asp:DropDownList ID="ddlItem" runat="server" Width="150px">
                                                                                        </asp:DropDownList>
                                                                                    </span>
                                                                                </td>
                                                                            </tr>
                                                                            <tr>
                                                                                <td style="width: 114px; color: #333300">
                                                                                    Sales
                                                                                </td>
                                                                                <td style="width: 174px">
                                                                                    <asp:TextBox ID="txtitemsales" runat="server" ToolTip="Enter Item Sales Amount" Width="94px"></asp:TextBox>
                                                                                </td>
                                                                            </tr>
                                                                            <tr>
                                                                                <td colspan="2" style="text-align: left">
                                                                                    <asp:Button ID="btnAdd" runat="server" Text="Add Item " Style="background-color: #99ccff"
                                                                                        OnClick="btnAdd_Click" />
                                                                                    &nbsp;<asp:Button ID="clearall" runat="server" Text="Clear All" Style="background-color: #99ccff"
                                                                                        OnClick="clearall_Click" />
                                                                                </td>
                                                                            </tr>
                                                                            <tr>
                                                                                <td colspan="2" style="text-align: center">
                                                                                    <div id="itemsheader" visible="true" runat="server">
                                                                                        <table align="left" style="width: 331px">
                                                                                            <tr style="font-size: x-small; color: #FFFFFF; background-color: #5D7B9D;">
                                                                                                <td style="height: 15px; width: 104px;">
                                                                                                    Category
                                                                                                </td>
                                                                                                <td style="height: 15px; width: 100px;">
                                                                                                    Item Name
                                                                                                </td>
                                                                                                <td style="height: 15px">
                                                                                                    Sales Amount
                                                                                                </td>
                                                                                            </tr>
                                                                                            <tr>
                                                                                                <td colspan="3" style="font-size: x-small; color: #FF0000;">
                                                                                                    No Items selected...
                                                                                                </td>
                                                                                            </tr>
                                                                                        </table>
                                                                                    </div>
                                                                                </td>
                                                                            </tr>
                                                                            <tr>
                                                                                <td colspan="2" style="text-align: center">
                                                                                    <asp:GridView ID="GridView3" runat="server" CellPadding="4" ForeColor="#333333" AutoGenerateColumns="false"
                                                                                        GridLines="None" Width="340px" Style="font-size: x-small">
                                                                                        <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
                                                                                        <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                                                                                        <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
                                                                                        <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
                                                                                        <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                                                                                        <EditRowStyle BackColor="#999999" />
                                                                                        <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                                                                                        <Columns>
                                                                                            <asp:TemplateField HeaderText="Category">
                                                                                                <ItemTemplate>
                                                                                                    <asp:Label ID="lblCategory" runat="server" Text='<%#Eval("Category") %>'></asp:Label>
                                                                                                </ItemTemplate>
                                                                                            </asp:TemplateField>
                                                                                            <asp:TemplateField HeaderText="Item Name">
                                                                                                <ItemTemplate>
                                                                                                    <asp:Label ID="lblItemName" runat="server" Text='<%#Eval("Item Name") %>'></asp:Label>
                                                                                                </ItemTemplate>
                                                                                            </asp:TemplateField>
                                                                                            <asp:TemplateField HeaderText="Sales Amount">
                                                                                                <ItemTemplate>
                                                                                                    <asp:Label ID="lblItemSales" runat="server" Text='<%#Eval("Sale Amount") %>'></asp:Label>
                                                                                                </ItemTemplate>
                                                                                            </asp:TemplateField>
                                                                                        </Columns>
                                                                                    </asp:GridView>
                                                                                </td>
                                                                            </tr>
                                                                        </table>
                                                                    </td>
                                                                    <td style="border-color: #000000; border-style: none none dotted dotted; border-width: thin;">
                                                                        &nbsp;&nbsp;&nbsp;&nbsp; &nbsp;<table align="center" style="width: 100%">
                                                                            <tr>
                                                                                <td style="width: 215px; height: 20px; text-align: center;">
                                                                                    <b>Month to date Sales Amount</b>
                                                                                </td>
                                                                                <td style="border-style: none none none dotted; border-width: thin; border-color: #000000;
                                                                                    height: 20px; text-align: center;">
                                                                                    &nbsp;<b>Total Sales Amount&nbsp;</b>
                                                                                </td>
                                                                            </tr>
                                                                            <tr>
                                                                                <td style="width: 215px; height: 20px; text-align: center;">
                                                                                    <asp:Label ID="lblMTDsalesamount" runat="server" Text="0" Font-Bold="True" ForeColor="#006600"></asp:Label>
                                                                                </td>
                                                                                <td style="border-color: #000000; border-style: none none none dotted; border-width: thin;
                                                                                    height: 20px; text-align: center;">
                                                                                    <asp:Label ID="lblTotalSalesAmount" runat="server" Text="0" Font-Bold="True" Font-Underline="False"
                                                                                        ForeColor="#006600"></asp:Label>
                                                                                </td>
                                                                            </tr>
                                                                            <tr>
                                                                                <td valign="top" style="width: 215px; height: 36px; text-align: center;">
                                                                                </td>
                                                                                <td style="height: 36px; text-align: center;">
                                                                                </td>
                                                                            </tr>
                                                                            <tr>
                                                                                <td style="height: 41px; text-align: center;" colspan="2">
                                                                                    <asp:Button ID="btnSave" runat="server" Text="Save Visit" Style="background-color: #99ccff;"
                                                                                        OnClick="btnSave_Click" Height="24px" ToolTip="Save Visit" Width="92px" />
                                                                                </td>
                                                                            </tr>
                                                                            <tr>
                                                                                <td style="height: 22px; text-align: center;" colspan="2">
                                                                                    <asp:Label ID="lblMessage1" runat="server"></asp:Label>
                                                                                    <asp:Label ID="lblmsg" runat="server" Font-Names="Verdana"></asp:Label>
                                                                                </td>
                                                                            </tr>
                                                                            <tr>
                                                                                <td style="height: 28px; text-align: center; color: #006600;" colspan="2">
                                                                                    <asp:LinkButton ID="todayvisitlink" runat="server" OnClick="todayvisitlink_Click">Click Here !</asp:LinkButton>
                                                                                    &nbsp;to see your today&#39;s visits.
                                                                                </td>
                                                                            </tr>
                                                                        </table>
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td style="text-align: left;">
                                                            <span style="font-size: 10pt; color: #FF9900; font-weight: bold;">Client Information:</span>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td style="text-align: right;">
                                                            <table align="left" style="width: 740px">
                                                                <tr>
                                                                    <td style="text-align: left; width: 112px; color: #000000">
                                                                        Company Name
                                                                    </td>
                                                                    <td style="text-align: left; width: 271px">
                                                                        <asp:TextBox ID="txtCompName" runat="server" ReadOnly="True"></asp:TextBox>
                                                                    </td>
                                                                    <td style="text-align: left; color: #000000">
                                                                        Designation
                                                                    </td>
                                                                    <td style="text-align: left">
                                                                        <asp:TextBox ID="txtDesignation" runat="server"></asp:TextBox>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td style="text-align: left; width: 112px; color: #000000">
                                                                        Mobile
                                                                    </td>
                                                                    <td style="text-align: left; width: 271px">
                                                                        <asp:TextBox ID="txtMobile" runat="server" ReadOnly="True"></asp:TextBox>
                                                                    </td>
                                                                    <td style="text-align: left; color: #000000">
                                                                        Department
                                                                    </td>
                                                                    <td style="text-align: left">
                                                                        <asp:TextBox ID="txtDepartment" runat="server" ReadOnly="True"></asp:TextBox>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td style="text-align: left; width: 112px; color: #000000">
                                                                        Phone
                                                                    </td>
                                                                    <td style="text-align: left; width: 271px">
                                                                        <asp:TextBox ID="txtPhone" runat="server" ReadOnly="True"></asp:TextBox>
                                                                    </td>
                                                                    <td style="text-align: left; color: #000000">
                                                                        City
                                                                    </td>
                                                                    <td style="text-align: left">
                                                                        <asp:TextBox ID="txtCity" runat="server" ReadOnly="True"></asp:TextBox>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td style="text-align: left; width: 112px; color: #000000">
                                                                        Email
                                                                    </td>
                                                                    <td style="text-align: left; width: 271px">
                                                                        <asp:TextBox ID="txtEmail" runat="server" ReadOnly="True"></asp:TextBox>
                                                                    </td>
                                                                    <td style="text-align: left; color: #000000">
                                                                        Fax
                                                                    </td>
                                                                    <td style="text-align: left">
                                                                        <asp:TextBox ID="txtFax" runat="server" ReadOnly="True"></asp:TextBox>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td style="text-align: left; width: 112px; color: #000000">
                                                                        Address
                                                                    </td>
                                                                    <td colspan="3" style="text-align: left">
                                                                        <asp:TextBox ID="txtAddress" runat="server" TextMode="MultiLine" Enabled="False"
                                                                            Width="534px" Height="47px"></asp:TextBox>
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="5" align="left" style="text-align: right">
                                                &nbsp;
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="5">
                                                &nbsp;
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
    </table>

    <script type="text/javascript" language="javascript">
    $(function() {
                 $("input[id$='txtreminderdate']").datepicker({ dateFormat: 'mm/dd/yy' });      
                 }
     );
    </script>

</asp:Content>

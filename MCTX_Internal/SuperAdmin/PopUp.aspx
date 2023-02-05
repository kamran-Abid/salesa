<%@ Page Language="C#" AutoEventWireup="true" CodeFile="PopUp.aspx.cs" Inherits="MCTX_Internal_SuperAdmin_PopUp" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>POPUP PAGE</title>
</head>
<body>
    <form id="form1" runat="server" style="width:100%;height:60%">
    <div>
    <table align="center" style="width: 99%">
    <tr>
    <td align="center" style="table-layout:auto" bgcolor="#FF9900">TARGET & SALARRY INFORMATION</td>
    </tr>
    <tr>
    <td>
    <table width="100%">
    <tr>
    <td style="width:40%">Welcome Mr.</td>
    <td style="width:60%"><asp:Label ID="lblUserName" runat="server"></asp:Label></td>
    </tr>
    <tr>
    <td style="width:40%">Date:</td>
    <td style="width:60%"><asp:Label ID="lblDate" runat="server"></asp:Label></td>
    </tr>
    <tr>
    <td style="width:40%">Total Bonus:</td>
    <td style="width:60%"><asp:Label ID="lblTotCompTargets" runat="server"></asp:Label></td>
    </tr>
    <tr>
    <td style="width:40%">Total Deductions</td>
    <td style="width:60%">&nbsp;</td>
    </tr>
    <tr>
    <td style="width:40%">Basic Salary:</td>
    <td style="width:60%"><asp:Label ID="lblBasicSalary" runat="server"></asp:Label></td>
    </tr>
    <tr>
    <td style="width:40%">Salary Till Today:</td>
    <td style="width:60%"><asp:Label ID="lblSalary" runat="server"></asp:Label></td>
    </tr>
    </table>
    </td>
    </tr>
    <tr>
    <td style="width:100%">
    <asp:GridView ID="PopUpGrid" runat="server" AutoGenerateColumns="false" 
            Width="100%" Height="160px">
    <Columns>
    
    <asp:TemplateField HeaderText="Visit Name">
    <ItemTemplate>
    <asp:Label ID="lblTarget" runat="server"></asp:Label>
    </ItemTemplate>
    </asp:TemplateField>
    
    <asp:TemplateField HeaderText="Total Visits Completed">
    <ItemTemplate>
    <asp:Label ID="lblTotVisits" runat="server"></asp:Label>
    </ItemTemplate>
    </asp:TemplateField>
    
    <asp:TemplateField HeaderText="Start Date">
    <ItemTemplate>
    <asp:Label ID="lblStartDate" runat="server"></asp:Label>
    </ItemTemplate>
    </asp:TemplateField>
    
    <asp:TemplateField HeaderText="End Date">
    <ItemTemplate>
    <asp:Label ID="lblEndDate" runat="server"></asp:Label>
    </ItemTemplate>
    </asp:TemplateField>
    
    <asp:TemplateField HeaderText="Commission Percentage">
    <ItemTemplate>
    <asp:Label ID="lblCommPercentage" runat="server"></asp:Label>
    </ItemTemplate>
    </asp:TemplateField>
    
    <asp:TemplateField HeaderText="Deduction Percentage">
    <ItemTemplate>
    <asp:Label ID="lblEndDate" runat="server"></asp:Label>
    </ItemTemplate>
    </asp:TemplateField>
    
    <asp:TemplateField HeaderText="Checked">
    <ItemTemplate>
    <asp:CheckBox ID="chkTask" runat="server" AutoPostBack="true" />
    </ItemTemplate>
    </asp:TemplateField>    
    
    </Columns>
    </asp:GridView>
    </td>
    </tr>
    <tr><td></td></tr>
    <tr><td align="center" bgcolor="#FF9900">
        -GRAPHICAL REPRESENTATION OF FIGURES
    </td></tr>
    <tr>
    <td style="width:50%" align="center" valign="middle">
        <br />
        <br />
        <br />
        <br />
        <br />
        <br />
        <br />
        <br />
        <br />
        <br />
        <br />
        <br />
        <br />
        <br />
        <br />
        <br />
        <br />
        </td>
    </tr>
    <tr><td></td></tr>
    <tr><td align="center" bgcolor="White">
    <asp:Button ID="btnClose" runat="server" Text="Close" BackColor="#99CCFF" OnClientClick="window.close();" 
            onclick="btnClose_Click" style="height: 26px" />
    </td></tr>
    </table>
    </div>
    </form>
</body>
</html>

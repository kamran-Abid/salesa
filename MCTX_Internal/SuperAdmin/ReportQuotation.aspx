<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ReportQuotation.aspx.cs" Inherits="MCTX_Internal_SuperAdmin_ReportQuotation" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>Mechatronix Quotation Report</title>
    
    <script language="javascript" type="text/javascript">
    function Clickheretoprint()
    { 
          var disp_setting="toolbar=yes,location=no,directories=yes,menubar=yes,"; 
              disp_setting+="scrollbars=yes,width=650, height=600, left=100, top=25"; 
          var content_vlue = document.getElementById("print_content").innerHTML; 
          
          var docprint=window.open("","",disp_setting); 
           docprint.document.open(); 
           docprint.document.write('<html><head><title>MCTX-Quotation Report</title>'); 
           docprint.document.write('</head><body onLoad="self.print()"><center>');          
           docprint.document.write(content_vlue);          
           docprint.document.write('</center></body></html>'); 
           docprint.document.close(); 
           docprint.focus(); 
        }
    </script>

    
    <style type="text/css">
        .style1
        {
            width: 100%;
            height: 128px;
        }
        .style2
        {
            font-size: large;
            font-weight: bold;
            width: 411px;
        }
        .style3
        {
            font-size: large;
            width: 53px;
        }
        .style4
        {
        }
        .style5
        {
            font-size: large;
            font-weight: bold;
            text-align: left;
        }
        .style7
        {
            height: 4px;
            text-align: left;
        }
        .style8
        {
            width: 60px;
        }
        .style9
        {
            width: 73px;
        }
        .style11
        {
            width: 60px;
            font-weight: bold;
        }
        .style12
        {
            width: 73px;
            font-weight: bold;
        }
        .style16
        {
            width: 60px;
            font-weight: bold;
            height: 22px;
        }
        .style17
        {
            height: 22px;
            width: 210px;
        }
        .style18
        {
            width: 73px;
            font-weight: bold;
            height: 22px;
        }
        .style19
        {
        }
        .style20
        {
            height: 22px;
            width: 117px;
        }
        .style21
        {
            width: 60px;
            font-weight: bold;
            height: 21px;
        }
        .style22
        {
            height: 21px;
            width: 117px;
        }
        .style23
        {
            width: 73px;
            font-weight: bold;
            height: 21px;
        }
        .style24
        {
            height: 21px;
            width: 210px;
        }
        .style25
        {
            width: 60px;
            font-weight: bold;
            height: 25px;
        }
        .style26
        {
            height: 25px;
        }
        .style27
        {
            width: 112px;
            font-weight: 700;
        }
        .style28
        {
            width: 72px;
        }
        .style30
        {
        }
        .style31
        {
            width: 72px;
            font-weight: bold;
        }
        .style34
        {
            width: 100%;
        }
        .style37
        {
            width: 58px;
        }
        .style38
        {
            width: 128px;
        }
        .style39
        {
            width: 126px;
            text-align: left;
        }
        .style40
        {
            height: 121px;
        }
        .style42
        {
            height: 121px;
        }
        .style45
        {
            width: 109px;
        }
        .style46
        {
            width: 59px;
        }
        .style47
        {
            width: 59px;
            font-weight: bold;
        }
        .style48
        {
            background-color: #666666;
            text-align: left;
        }
        .style49
        {
            width: 60px;
            font-weight: bold;
            height: 11px;
        }
        .style50
        {
            height: 11px;
            width: 117px;
        }
        .style51
        {
            width: 73px;
            font-weight: bold;
            height: 11px;
        }
        .style52
        {
            height: 11px;
            width: 210px;
        }
        .style53
        {
            width: 210px;
        }
        .style54
        {
            width: 53px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
     <div align="right"><a href="javascript:Clickheretoprint()"> Click here to print</a></div>
    <div id="print_content" runat="server">
    
        <table class="style1" width="100%">
            <tr style="font-size: x-small">
                <td bgcolor="#CCCCCC" class="style2">
                    &nbsp;<span class="style48">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
                    Q</span>uotation&nbsp;</td>
                <td bgcolor="#CCCCCC" class="style3">
                    &nbsp;</td>
                <td align="right" bgcolor="#CCCCCC" class="style5">
                    Our References &amp; Contacts</td>
            </tr>
            <tr style="font-size: small">
                <td align="right" class="style7" colspan="3">
                    <b>Subject: </b>&nbsp;<asp:Label ID="lblSubject" runat="server"></asp:Label></td>
            </tr>
            <tr>
                <td class="style40" colspan="2" valign="top" style="border-style: groove">
                    <table class="style1" height="100%"
                        style="border-width: thin; border-style: none; font-size: small;">
                        <tr>
                            <td class="style8">
                                <b>Attn:</b></td>
                            <td class="style19">
                                <asp:Label ID="lblAttn" runat="server"></asp:Label>
                            </td>
                            <td class="style9">
                                <b>Desig:</b></td>
                            <td class="style53">
                                <asp:Label ID="lblDesig" runat="server"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td class="style16">
                                Depart:</td>
                            <td class="style20">
                                <asp:Label ID="lbldepart" runat="server"></asp:Label>
                            </td>
                            <td class="style18">
                                Company:</td>
                            <td class="style17">
                                <asp:Label ID="lblcomp" runat="server"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td class="style25">
                                Address:</td>
                            <td class="style26" colspan="3">
                                <asp:Label ID="lbladdress" runat="server"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td class="style11">
                                Site:</td>
                            <td class="style19">
                                <asp:Label ID="lblsite" runat="server"></asp:Label>
                            </td>
                            <td class="style12">
                                Mobile:</td>
                            <td class="style53">
                                <asp:Label ID="lblmobile" runat="server"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td class="style21">
                                Phone:</td>
                            <td class="style22">
                                <asp:Label ID="lblphone" runat="server"></asp:Label>
                            </td>
                            <td class="style23">
                                Email:</td>
                            <td class="style24">
                                <asp:Label ID="lblemail" runat="server"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td class="style49">
                                </td>
                            <td class="style50">
                            </td>
                            <td class="style51">
                                </td>
                            <td class="style52">
                            </td>
                        </tr>
                    </table>
                </td>
                <td class="style42" valign="top" 
                    style="border-style: groove groove groove none">
                    <table class="style1" height="100%"
                        style="border-width: thin; border-style: none; font-size: small;">
                        <tr>
                            <td class="style27">
                                <b>Quot No:</b></td>
                            <td class="style38">
                                <asp:Label ID="lblquotno" runat="server"></asp:Label>
                            </td>
                            <td class="style28">
                                <b>Date:</b></td>
                            <td colspan="3">
                                <asp:Label ID="Label7" runat="server" Text="Label"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td class="style27">
                                Representative:</td>
                            <td class="style38">
                                <asp:Label ID="lblRepresentative" runat="server"></asp:Label>
                            </td>
                            <td class="style31">
                                Mobile:</td>
                            <td class="style45">
                                <asp:Label ID="lblMobRep" runat="server"></asp:Label>
                            </td>
                            <td class="style46">
                                <b>Email:</b></td>
                            <td>
                                <asp:Label ID="lblEmailRep" runat="server" ></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td class="style27">
                                Sale Manager:</td>
                            <td class="style38">
                                <asp:Label ID="lblSalManager" runat="server" ></asp:Label>
                            </td>
                            <td class="style31">
                                Mobile:</td>
                            <td class="style45">
                                <asp:Label ID="lblMobManager" runat="server" ></asp:Label>
                            </td>
                            <td class="style47">
                                Email:</td>
                            <td>
                                <asp:Label ID="lblEmailManager" runat="server"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td class="style27">
                                Tech Person:</td>
                            <td class="style38">
                                <asp:Label ID="lbltechPerson" runat="server" ></asp:Label>
                            </td>
                            <td class="style31">
                                Mobile:</td>
                            <td class="style45">
                                <asp:Label ID="lblMobTech" runat="server" ></asp:Label>
                            </td>
                            <td class="style47">
                                Email:</td>
                            <td>
                                <asp:Label ID="lblEmailTech" runat="server" ></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td class="style27">
                                Office:</td>
                            <td class="style30" colspan="5">
                                <asp:Label ID="lblOffice" runat="server" ></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td class="style27">
                                Email:</td>
                            <td class="style30" colspan="5">
                                <table class="style34">
                                    <tr>
                                        <td class="style39">
                                            <asp:Label ID="lblemailoffice" runat="server" ></asp:Label>
                                        </td>
                                        <td class="style37">
                                            <b>Fax:</b></td>
                                        <td>
                                            <asp:Label ID="lblFax" runat="server"></asp:Label>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td class="style4" colspan="3">
                    <asp:GridView ID="GridQuotReport" runat="server" Width="100%" 
                        AutoGenerateColumns="False">
                        <SelectedRowStyle 
                            Font-Size="Small" />
                        
                        <Columns>
                        
                        <asp:TemplateField HeaderText="Item Code">
                        <ItemTemplate>
                        <asp:Label ID="lblItemCode" runat="server" Text='<%#Eval("item_code") %>'></asp:Label>
                        </ItemTemplate>
                            <ControlStyle Font-Size="Small" BorderWidth="0px" />
                            <HeaderStyle Font-Size="Small" />
                        </asp:TemplateField>
                        
                        <asp:TemplateField HeaderText="Description">
                        <ItemTemplate>
                        <asp:Label ID="lblDescryption" runat="server" Text='<%#Eval("description") %>'></asp:Label>
                        </ItemTemplate>
                            <ControlStyle Font-Size="Small" BorderWidth="0px" />
                            <HeaderStyle Font-Size="Small" />
                        </asp:TemplateField>
                        
                        <asp:TemplateField HeaderText="Origin">
                        <ItemTemplate>
                        <asp:Label ID="lblOrigin" runat="server" Text='<%#Eval("country_name") %>'></asp:Label>
                        </ItemTemplate>
                            <ControlStyle Font-Size="Small" BorderWidth="0px" />
                            <HeaderStyle Font-Size="Small" />
                        </asp:TemplateField>
                        
                        <asp:TemplateField HeaderText="Image">
                        <ItemTemplate>
                        <asp:Image ID="PrImage" runat="server" ImageUrl='<%#Eval("image_url") %>'></asp:Image>
                        </ItemTemplate>
                            <ControlStyle BorderWidth="0px" />
                            <HeaderStyle Font-Size="Small" />
                        </asp:TemplateField>
                        
                        <asp:TemplateField HeaderText="QTY">
                        <ItemTemplate>
                        <asp:Label ID="lblQTY" runat="server" Text='<%#Eval("item_quantity") %>'></asp:Label>
                        </ItemTemplate>
                            <ControlStyle Font-Size="Small" BorderWidth="0px" />
                            <HeaderStyle Font-Size="Small" />
                        </asp:TemplateField>
                        
                        <asp:TemplateField HeaderText="U.O.M">
                        <ItemTemplate>
                        <asp:Label ID="lblUOM" runat="server" Text='<%#Eval("Iunit") %>'></asp:Label>
                        </ItemTemplate>
                            <ControlStyle Font-Size="Small" BorderWidth="0px" />
                            <HeaderStyle Font-Size="Small" />
                        </asp:TemplateField>
                        
                        <asp:TemplateField HeaderText="Unit Price">
                        <ItemTemplate>
                        <asp:Label ID="lblUnitPrice" runat="server" Text='<%#Eval("item_price") %>'></asp:Label>
                        </ItemTemplate>
                            <ControlStyle Font-Size="Small" BorderWidth="0px" />
                            <HeaderStyle Font-Size="Small" />
                        </asp:TemplateField>
                        
                        <asp:TemplateField HeaderText="Excl.GST">
                        <ItemTemplate>
                        <asp:Label ID="lblValueExclGST" runat="server" Text='<%#Eval("totalprice") %>'></asp:Label>
                        </ItemTemplate>
                            <ControlStyle Font-Size="Small" BorderWidth="0px" />
                            <HeaderStyle Font-Size="Small" />
                        </asp:TemplateField>
                        
                        <asp:TemplateField HeaderText="GST %">
                        <ItemTemplate>
                        <asp:Label ID="lblRateofGST" runat="server" Text='<%#Eval("gstPercent") %>'></asp:Label>
                        </ItemTemplate>
                            <ControlStyle Font-Size="Small" BorderWidth="0px" />
                            <HeaderStyle Font-Size="Small" />
                        </asp:TemplateField>
                        
                        <asp:TemplateField HeaderText="GST / Unit">
                        <ItemTemplate>
                        <asp:Label ID="lblGSTperUnit" runat="server" Text='<%#Eval("gst") %>'></asp:Label>
                        </ItemTemplate>
                            <ControlStyle Font-Size="Small" BorderWidth="0px" />
                            <HeaderStyle Font-Size="Small" />
                        </asp:TemplateField>
                        
                        <asp:TemplateField HeaderText="GST Payable">
                        <ItemTemplate>
                        <asp:Label ID="lblGSTPayable" runat="server" Text='<%#Eval("sumgst") %>'></asp:Label>
                        </ItemTemplate>
                            <ControlStyle Font-Size="Small" BorderWidth="0px" />
                            <HeaderStyle Font-Size="Small" />
                        </asp:TemplateField>
                        
                        <asp:TemplateField HeaderText="Total Price">
                        <ItemTemplate>
                        <asp:Label ID="lblTotalPrice" runat="server" Text='<%#Eval("NetTotal") %>'></asp:Label>
                        </ItemTemplate>
                            <ControlStyle Font-Size="Small" BorderWidth="0px" />
                            <HeaderStyle Font-Size="Small" />
                        </asp:TemplateField>
                        
                        </Columns>
                        
                        <HeaderStyle Font-Names="Arial Narrow" Font-Size="Small" />
                        
                    </asp:GridView>
                </td>
            </tr>
            <tr>
                <td class="style4" align="right" colspan="3">
                    &nbsp;</td>
            </tr>
            <tr>
                <td class="style4">
                    <asp:Label ID="lblDate" runat="server"></asp:Label>
                </td>
                <td class="style54">
                    &nbsp;</td>
                <td align="right">
                <%--<asp:Button ID="btnprint" runat="server" Text="Print Report"
                        style="background-color: #99CCFF" onclick="btnprint_Click" />
                <asp:Button ID="btnback" runat="server" BackColor="#99CCFF" Text="Back" onclick="btnBack_Click1" />--%></td>
            </tr>
        </table>
    
    </div>
    </form>
</body>
</html>

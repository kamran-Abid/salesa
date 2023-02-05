<%@ Page Language="C#" AutoEventWireup="true" CodeFile="rptVisits.aspx.cs" Inherits="MCTX_Internal_SuperAdmin_rptVisits" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Mechatronix Visit Report</title>

    <script src="../../js/jquery-1.3.2.min.js" type="text/javascript"></script>
    <script src="../../js/BlockUI.js" type="text/javascript"></script>
    
    <style type="text/css">
        .style1
        {
            width: 100%;
        }
        .style3
        {
            width: 1014px;
        }
        .style5
        {
            text-align: center;
            font-family: Verdana;
            font-size: small;
            background-color: #EEEEEE;
        }
        .style6
        {
            width: 796px;
        }
        .style7
        {
            text-align: center;
        }
        .style8
        {
            text-align: center;
        }
        .style12
        {
            width: 156px;
            text-align: left;
            height: 20px;
            font-family: "Book Antiqua";
            font-size: small;
            background-color: #DFEFFF;
            font-weight: bold;
        }
        .style14
        {
        }
        .style17
        {
            background-color: #DFEFFF;
            text-align: left;
            font-size: small;
            font-family: "Book Antiqua";
        }
        .style18
        {
            width: 156px;
            text-align: left;
            font-family: "Book Antiqua";
            font-size: small;
            background-color: #DFEFFF;
            font-weight: bold;
        }
        .style20
        {
            text-align: center;
            font-weight: bold;
        }
        .style23
        {
            height: 31px;
        }
        .style24
        {
            background-color: #EEEEEE;
        }
        .style26
        {
            background-color: #DFEFFF;
            text-align: left;
            width: 322px;
            font-size: small;
            font-family: "Book Antiqua";
        }
        .style27
        {
            background-color: #DFEFFF;
            text-align: center;
            font-weight: bold;
            font-size: small;
            font-family: "Book Antiqua";
        }
        .style28
        {
            font-family: "Courier New", Courier, monospace;
        }
        .style29
        {
            width: 707px;
        }
        .style31
        {
            width: 247px;
            background-color: #FFFFFF;
        }
        .style32
        {
            text-align: center;
            font-family: Verdana;
            font-size: small;
            background-color: #EEEEEE;
            font-weight: bold;
        }
        .style33
        {
            width: 112px;
            background-color: #CCCCCC;
            text-align: left;
            font-family: "Book Antiqua";
        }
        .style34
        {
            background-color: #FFFFFF;
            font-family: "Book Antiqua";
        }
        .style35
        {
            font-size: x-small;
        }
        .style36
        {
            width: 112px;
            font-size: x-small;
            background-color: #CCCCCC;
            text-align: left;
            font-family: "Book Antiqua";
        }
        .style37
        {
            width: 247px;
            font-size: x-small;
            background-color: #FFFFFF;
        }
        .style38
        {
            color: #FFFFFF;
            font-weight: bold;
            text-decoration: underline;
        }
        .style39
        {
            width: 100%;
        }
        .style40
        {
            width: 139px;
            text-align: left;
            background-color: #CCCCCC;
        }
        .style41
        {
            background-color: #FFFFFF;
        }
        .style42
        {
            width: 139px;
            text-align: center;
            background-color: #CCCCCC;
        }
    </style>
    <script type="text/javascript">
    
//    $(document).ready(function() 
//    { 
//            $('asdemo').click(function() 
//            { 
//            ShowLoginDiv();  
//            })
//    
//    }); 
    
   function ShowLoginDiv()
    {
    //$("").blockUI();
    $.blockUI({
                    message:$("#loginForm"),css:{'height':'auto','cursor':'default','left':'15%','top':'12%','width':'auto'}
                });
    } 
    
    
    
    </script>
</head>
<body style="font-family: Calibri;  margin-top:0.5;">
    <form id="form1" runat="server">
    <div>
    
        <table align="center" class="style1" cellspacing="0">
            <tr>
                <td style="background-image: url('image/bar.JPG'); background-repeat: repeat-x; font-size:large; font-weight:bold; text-align: center;" 
                    class="style23">
                    
                       &lt;&lt;Cumulative Visit Report&gt;&gt;</td>
                    
                      
                    
                    </tr>
            <tr>
                <td class="style32">
                    &nbsp;</td>
            </tr>
            <tr>
                <td class="style5" valign="top">
                    <table align="center" class="style29" cellspacing="1" 
                        
                        style="border-style: none; border-width: thin; border-color: #000000; background-color: #000000;">
                        <tr>
                            <td colspan="3" style="background-color: #006699" class="style38">
                                Summary Report</td>
                        </tr>
                        <tr>
                            <td class="style36">
                                &nbsp;
                                Current Date:</td>
                            <td class="style37">
                                <asp:Label ID="lbldate" runat="server" style="text-align: right; font-family: Verdana; font-size: x-small;" 
                        Text=""></asp:Label>
                            </td>
                            <td rowspan="4" class="style34">
                                <table align="center" cellspacing="1" class="style39" 
                                    style="background-color: #000000">
                                    <tr>
                                        <td class="style40">
&nbsp; Fresh visits</td>
                                        <td class="style41">
                                            <asp:Label ID="lblfreshvisit" runat="server" Text="0"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="style40">
&nbsp; Follow up visits</td>
                                        <td class="style41">
                                            <asp:Label ID="lbFUvisit" runat="server" Text="0"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="style40">
&nbsp; Sales visits</td>
                                        <td class="style41">
                                            <asp:Label ID="lblsalvisit" runat="server" Text="0"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="style42">
                                Total Visit =
                                <asp:Label ID="lblTotalvisits" runat="server" Font-Bold="True" 
                                    ForeColor="#006600" Text="0"></asp:Label>
                                        </td>
                                        <td class="style41">
                                            Total Sales Amt =Rs.
                                            <asp:Label ID="lblsaleamt" runat="server" Font-Bold="True" ForeColor="#006600" 
                                                Text="0"></asp:Label>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr class="style35">
                            <td class="style33">
                    &nbsp;
                    Date Range:</td>
                            <td class="style31">
                                <asp:Label ID="lbldaterange" runat="server"></asp:Label>
                            </td>
                        </tr>
                        <tr class="style35">
                            <td class="style33">
                    &nbsp;
                    User Name:</td>
                            <td class="style31">
                                <asp:Label ID="lbl_username" runat="server"></asp:Label>
                            </td>
                        </tr>
                        <tr class="style35">
                            <td class="style33">
                    &nbsp;
                    Visit Types:</td>
                            <td class="style31">
                                <asp:Label ID="lbl_visittype" runat="server"></asp:Label>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td class="style5">
                    <asp:Button ID="btnview_details" OnClientClick="ShowLoginDiv(); return false" 
                        runat="server" Height="20px" 
                        Text="Visits Details" Width="134px" BackColor="#99CCFF" 
                        BorderStyle="Outset" onclick="btnview_details_Click" />
                    <asp:Button ID="btnback" runat="server" Height="20px" Text="Back" 
                        Width="134px" onclick="btnback_Click" BackColor="#99CCFF" 
                        BorderStyle="Outset" />
                    <asp:Button ID="btn_export" runat="server" Height="20px" Text="Export to Excel" 
                        Width="134px" BackColor="#99CCFF" 
                        BorderStyle="Outset" onclick="btn_export_Click" />
                    </td>
            </tr>
            <tr>
                <td style="text-align: center; " class="style24">
                    <table align="center" class="style3">
                        <tr>
                            <td align="center">
                    <asp:GridView ID="GridViewVisitReport" runat="server" CellPadding="3" 
                                    onrowcommand="GridView1_RowCommand" AutoGenerateColumns="False" 
                                    Width="974px" AllowPaging="True" 
                                    onpageindexchanging="GridViewVisitReport_PageIndexChanging" PageSize="25" 
                                    style="font-family: Verdana; font-size: x-small" BackColor="White" 
                                    BorderColor="#CCCCCC" BorderStyle="None" BorderWidth="1px" 
                                    CssClass="style24" 
                                    onselectedindexchanged="GridViewVisitReport_SelectedIndexChanged" onrowdatabound="GridViewVisitReport_RowDataBound">
                        <PagerSettings Mode="NumericFirstLast" />
                        <RowStyle ForeColor="#000066" />
                        <Columns>
                        
                        <asp:TemplateField HeaderText="Select">
                        <ItemTemplate>
                        <asp:HiddenField ID="hdnId" runat="server" Value='<%#Eval("visit_id") %>' />
                        <asp:ImageButton ID="imgbtnView" runat="server" ImageUrl="~/images1/select2.jpeg" CommandArgument='<%#Eval("visit_id") %>' CommandName="details" />
                        </ItemTemplate>
                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                        </asp:TemplateField>
                        
                        <asp:TemplateField HeaderText="Visit Date">
                        <ItemTemplate>
                        <asp:Label ID="lblVisitDate0" runat="server" Text='<%#Eval("Visit_Date") %>'></asp:Label>
                        </ItemTemplate>
                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                        </asp:TemplateField>
                        
                        <asp:TemplateField HeaderText="Company Name">
                        <ItemTemplate>
                        <asp:Label ID="lblCompName" runat="server" Text='<%#Eval("comp_name") %>'></asp:Label>
                        </ItemTemplate>
                        <ItemStyle HorizontalAlign="left" VerticalAlign="Middle" />
                        </asp:TemplateField>
                        
                        <asp:TemplateField HeaderText="Client Name">
                        <ItemTemplate>
                        <asp:Label ID="lblClientName" runat="server" Text='<%#Eval("client_name") %>'></asp:Label>
                        </ItemTemplate>
                        <ItemStyle HorizontalAlign="left" VerticalAlign="Middle" />
                        </asp:TemplateField>
                        
                        
                        <asp:TemplateField HeaderText="Visit Type">
                        <ItemTemplate>
                        <asp:Label ID="lblVisitType" runat="server" Text='<%#Eval("tt_name") %>'></asp:Label>
                        </ItemTemplate>
                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                        </asp:TemplateField>
                        
                        <asp:TemplateField HeaderText="Total Sales">
                        <ItemTemplate>
                        <asp:Label ID="lblTotalSales" runat="server" Text='<%#Eval("total_Sale") %>'></asp:Label>
                        </ItemTemplate>
                            <ControlStyle Font-Bold="True" ForeColor="#0000CC" />
                            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                        </asp:TemplateField>
                        
                        <asp:TemplateField HeaderText="Client Response">
                        <ItemTemplate>
                        <asp:Label ID="lblClientResponse" runat="server" Text='<%#Eval("response_name") %>'></asp:Label>
                        </ItemTemplate>
                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                        </asp:TemplateField>
                        
                        <asp:TemplateField HeaderText="Visited By">
                        <ItemTemplate>
                        <asp:Label ID="lblUser" runat="server" Text='<%#Eval("E_Name") %>' ></asp:Label>
                        </ItemTemplate>
                        <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                        </asp:TemplateField>
                        
                        <asp:TemplateField HeaderText="IP Address">
                        <ItemTemplate>
                        <asp:Label ID="lblclientaddress" runat="server" Text='<%#Eval("client_IpAdress") %>' ></asp:Label>
                        </ItemTemplate>
                        <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                        </asp:TemplateField>
                        
                        </Columns>
                        <FooterStyle BackColor="White" ForeColor="#000066" />
                        <PagerStyle BackColor="#DDF4FF" ForeColor="#000066" HorizontalAlign="Right" 
                            BorderStyle="Outset" BorderWidth="1px" />
                        <SelectedRowStyle BackColor="#669999" Font-Bold="True" ForeColor="White" />
                        <HeaderStyle BackColor="#006699" Font-Bold="True" ForeColor="White" 
                            Font-Size="X-Small" Font-Underline="True" />
                        
                    </asp:GridView>
                            </td>
                        </tr>
                        <tr><td style="background: url('image/bg.png') repeat-x; height: 18px;color:#014E86; width: 878px;">
                                   Copyrights &copy; 2010. All rights reserved. 
                                   <a href="http://www.mechatronix.com.pk">Mechatronix Inc</a></td></tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td>
                
                <div id="loginForm" style="display:none;">
            
               <table align="center" class="style6" style="background-color: #99CCFF">
                        <tr>
                            <td class="style7">
                                <table align="left" class="style1">
                                    <tr>
                                        <td class="style14" colspan="3">
                                            <asp:Image ID="Image1" runat="server" style="margin-bottom: 0px" />
                                            <b>Visit Detail Information</b></td>
                                    </tr>
                                    <tr class="style28">
                                        <td class="style18">
                                            &nbsp;Visit Id:</td>
                                                <td 
                                            class="style26">
                                                    <asp:Label ID="lbl_visitid" runat="server"></asp:Label>
                                        </td>
                                                <td 
                                            class="style27">
                                                    Remarks:</td>
                                            </tr>
                                            <tr class="style28">
                                        <td class="style18">
                                            &nbsp;Visited By:</td>
                                        <td class="style26">
                                            <asp:Label ID="lblvisitby" runat="server"></asp:Label>
                                                </td>
                                        <td class="style17" rowspan="12" valign="top">
                                            <asp:Label ID="lblremarks" runat="server"></asp:Label>
                                                </td>
                                    </tr>
                                    <tr class="style28">
                                        <td class="style12">
                                            &nbsp;Visit Date:</td>
                                        <td class="style26">
                                            <asp:Label ID="lblvisitdate" runat="server"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr class="style28">
                                        <td class="style18">
                                            &nbsp;Visit Type:</td>
                                        <td  
                                            class="style26">
                                            <asp:Label ID="lbl_type" runat="server"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr class="style28">
                                        <td class="style18">
                                            &nbsp;Client Response:</td>
                                        <td  
                                            class="style26">
                                            <asp:Label ID="lbl_clientreponse" runat="server"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr class="style28">
                                        <td class="style18">
                                            &nbsp;Sales Amount:&nbsp;</td>
                                        <td  
                                            class="style26">
                                            <asp:Label ID="lbl_salesamt" runat="server" Font-Bold="True" 
                                                ForeColor="#009999"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr class="style28">
                                        <td class="style18">
                                            &nbsp;Company Name:</td>
                                        <td 
                                            class="style26">
                                            <asp:Label ID="lbl_compname" runat="server"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr class="style28">
                                        <td class="style18">
                                            &nbsp;Client Name:</td>
                                        <td 
                                            class="style26">
                                            <asp:Label ID="lblclname" runat="server"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr class="style28">
                                        <td class="style18">
                                            &nbsp;Client Designation:</td>
                                        <td 
                                            class="style26">
                                            <asp:Label ID="lblclientdesig" runat="server"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr class="style28">
                                        <td class="style18">
                                            &nbsp;Client Phone#:</td>
                                        <td 
                                            class="style26">
                                            <asp:Label ID="lblclientphone" runat="server"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr class="style28">
                                        <td class="style18">
                                            &nbsp;Client Mobile#:</td>
                                        <td  
                                            class="style26">
                                            <asp:Label ID="lblclientmobile" runat="server"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr class="style28">
                                        <td class="style18">
                                            &nbsp;Client Email:</td>
                                        <td 
                                            class="style26">
                                            <asp:Label ID="lblclientemail" runat="server"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr class="style28">
                                        <td class="style18">
                                            &nbsp;Address:</td>
                                        <td
                                            class="style26">
                                            <asp:Label ID="lblAddress" runat="server"></asp:Label>
                                                </td>
                                    </tr>
                                    <tr class="style28">
                                        <td class="style18">
                                            &nbsp;City</td>
                                        <td
                                            class="style26">
                                            <asp:Label ID="lbl_city" runat="server"></asp:Label>
                                                </td>
                                        <td
                                            class="style17">
                                            &nbsp;</td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
               <td class="style20" 
                                style="border-style: dotted none none none; border-width: thin; border-color: #000000; background-color: #99CCFF;"> Items Information </td>
                                
                        </tr>
                        <tr>
                            <td align="center">
                                <asp:Label ID="lblnorecord" runat="server" Font-Size="Small" 
                                    Text="...No Record Found..." Visible="False" ForeColor="#FF3300"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td align="center">
                                <asp:GridView ID="Gridveiw_visitdetails" runat="server" BorderStyle="Dotted" 
                                    Width="493px" BackColor="#DFEFFF" Font-Size="Small">
                                    <HeaderStyle Font-Bold="True" Font-Underline="True" />
                                </asp:GridView>
                            </td>
                        </tr>
                        <tr>
                            <td class="style8">
                
            
                                &nbsp;</td>
                        </tr>
                        <tr>
                            <td class="style8">
                
            
               <input type="button" value="OK" onclick="$.unblockUI();" 
                                    
                                    style="border-style: outset; width: 79px; height: 20px; background-color: #99CCFF;" /></td>
                        </tr>
                        </table>
                    </div>
                </td>
            </tr>
        </table>
    
    </div>
    </form>
</body>
</html>

<%@ Page Language="C#" MasterPageFile="~/MCTX_Internal/SuperAdmin/MasterAdmin.master"
    AutoEventWireup="true" CodeFile="frmQuotations.aspx.cs" Inherits="MCTX_Internal_SuperAdmin_Quotations"
    Title="MCTX-Quotation" %>
 <%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <script src="../../js/FieldValidation.js" type="text/javascript"> </script>

    <style type="text/css">
        fieldset
        {
            border: 1px solid #006699;
            width: 100%;
            padding: 3px;
        }
        fieldset legend
        {
            padding: 6px;
            font-weight: bold;
            color: #FF9900;
        }
        input
        {
            font-size: 10pt;
            font-family: Calibri,Verdana, Arial, Helvetica, sans-serif;
            border: 1px solid #CCCCCC;
        }
        SELECT
        {
            font-family: Calibri,Verdana, Arial, Helvetica, sans-serif;
            font-size: 11px;
            border: 1px solid #CCCCCC;
            height: 19px;
            width: 205px;
        }
         #overlay

        {

            position: fixed;

            z-index: 99;

            top: 0px;

            left: 0px;

            background-color:#726E6D;

            width: 100%;

            height: 100%;

            filter: Alpha(Opacity=80);

            opacity: 0.80;

            -moz-opacity: 0.80;

        }       

        #progresstwo

        {

            background-color: #726E6D;

            width: 110px;

            height: 24px;

            text-align: center;

            filter: Alpha(Opacity=100);

            opacity: 1;

            -moz-opacity: 1;

        }

        #progressone

        {

            position: absolute;

            top: 50%;

            left: 50%;

            margin: -11px 0 0 -55px;

            color: white;

        }

        body > #progressone

        {

            position: fixed;

        }

        .style5
        {
            font-size: large;
        }

        .style6
        {
            height: 15px;
        }

    </style>
    
    <script type="text/javascript" language="javascript">
    
    function GetTermDescription(){
    
    alert("I am term");
    }
    </script>
    <div id="tabs">
        <ul>
            <li style="text-align: left"><a href="#tabs-1">Quotations</a></li>
        </ul>
        <asp:ScriptManager ID="ScriptManager1" runat="server">
        </asp:ScriptManager>
        <asp:UpdateProgress ID="UpdateProgress1" DisplayAfter="3" 
            runat="server" AssociatedUpdatePanelID="UpdatePanel1">
            <ProgressTemplate>
               <div id="overlay">

                <div id="progressone">

                    <div id="progresstwo">

                        <img src="image/ajax-loader.gif" alt="" />

                    </div>

                </div>

            </div>
            </ProgressTemplate>
            </asp:UpdateProgress>
        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate>
                <table style="width: 100%; height: 333px;">
                    <tr>
                        <td valign="top" style="height: 331px">
                      
                            <div id="tabs-1">
                                <%--</fieldset>--%>
                                <table style="width: 100%">
                                    <tr>
                                        <td colspan="2" style="text-align: right; height: 0px; vertical-align:top;">
                                        <table>
                                            <tr style="position: absolute; right: 30px; top: 10px;">
                                                <td style="border-style: none solid none none"> <a target="_blank" href="frmCompanyInfo.aspx"><span>Companies</span></a> &nbsp;&nbsp;&nbsp; </td>
                                                <td style="border-style: none solid none none">&nbsp;&nbsp;&nbsp; <a target="_blank" href="frmClientsInfo.aspx"><span>Client(s)</span></a> &nbsp;&nbsp;&nbsp;</td>
                                                <td>&nbsp;&nbsp;&nbsp; <a target="_blank" href="frmProductInfo.aspx"><span>Product(s)</span></a> </td>
                                            </tr>
                                        </table>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="2" style="color: #FFFFFF; background-color: #006699; height: 14px;">
                                            <strong><span style="font-size: small">Quotation Management</span></strong>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="2">
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="color: #FF9900;" colspan="2" align="left" class="style5">
                                            <strong>Client and Employee Information (Quote Header) </strong>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width: 272px; font-size: small; text-align: left;">
                                            <b>Quotation Subject</b>
                                        </td>
                                        <td align="left">
                                            <asp:TextBox ID="txtQuotationSubject" runat="server" Height="16px" Width="200px"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="2">
                                            &nbsp;
                                        </td>
                                    </tr>
                                         <tr>
                                        <td style="width: 272px; font-size: small; text-align: left;">
                                            <b>Customer</b>
                                        </td>
                                        <td align="left">
                                            <asp:DropDownList ID="ddlCompany" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddlCompany_SelectedIndexChanged">
                                            </asp:DropDownList>
                                           <a target="_blank" href="frmCompanyInfo.aspx"><span>Add Companies</span></a>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width: 272px; font-size: small; text-align: left;">
                                            <b>Attention</b>
                                        </td>
                                        <td align="left">
                                            <asp:DropDownList ID="ddlClient" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddlClient_SelectedIndexChanged">
                                            </asp:DropDownList>
                                            <a target="_blank" href="frmClientsInfo.aspx"><span>Add Client(s)</span></a> 
                                           <%-- <asp:Button ID="en" runat="server" onclick="en_Click" Text="R" />--%>
                                            
                                        </td>
                                    </tr>
                               
                                    <tr>
                                        <td style="width: 272px; font-size: small; text-align: left;">
                                            <b>Designation</b>
                                        </td>
                                        <td align="left">
                                            <asp:TextBox ID="txtDesignation" runat="server" Enabled="False"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width: 272px; font-size: small; text-align: left;">
                                            <b>Department</b>
                                        </td>
                                        <td align="left">
                                            <asp:TextBox ID="txtDepartment" runat="server" Enabled="False"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width: 272px; font-size: small; height: 19px; text-align: left;">
                                            <b>Customer Site</b>
                                        </td>
                                        <td align="left" style="height: 19px">
                                            <asp:TextBox ID="txtCustomerSite" runat="server"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width: 272px; font-size: small; text-align: left;">
                                            <b>Select Sales Person</b>
                                        </td>
                                        <td align="left">
                                            <asp:DropDownList ID="ddlSaleManager" runat="server">
                                            </asp:DropDownList>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width: 272px; font-size: small; text-align: left;">
                                            <b>Select Technical Person</b>
                                        </td>
                                        <td align="left">
                                            <asp:DropDownList ID="ddlTechPerson" runat="server">
                                            </asp:DropDownList>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="2" align="left" 
                                            style="border-style: none none solid none; border-width: medium; border-color: #FF0000; font-size: small; color: #FF9900;">
                                            &nbsp;</td>
                                    </tr>
                                    <tr>
                                        <td align="left" class="style5" colspan="2" style="color: #FF9900;">
                                            <strong>Items Informatinon (Quote Details (Item Lines)) </strong>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width: 272px; font-size: small; text-align: left;">
                                            <b>Select Category</b>
                                        </td>
                                        <td align="left">
                                            <asp:DropDownList ID="ddlItemCat" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddlItemCat_SelectedIndexChanged">
                                            </asp:DropDownList>
                                            <asp:Button ID="btnRefreshItemCat" runat="server" Text="R" 
                                                onclick="btnRefreshItemCat_Click" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width: 272px; font-size: small; text-align: left;">
                                            <b>Select Item</b>
                                        </td>
                                        <td align="left">
                                            <asp:DropDownList ID="ddlItem" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddlItem_SelectedIndexChanged">
                                            </asp:DropDownList>
                                            <asp:Button ID="btnRefreah" runat="server" Text="R" 
                                                onclick="btnRefreah_Click" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width: 272px; font-size: small; text-align: left;">
                                            <b>Price Type</b>
                                        </td>
                                        <td align="left">
                                            <asp:DropDownList ID="ddlPriceType" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddlPriceType_SelectedIndexChanged">
                                                <asp:ListItem Value="0">-- Select --</asp:ListItem>
                                                <asp:ListItem>Normal</asp:ListItem>
                                                <asp:ListItem>Minimum</asp:ListItem>
                                                <asp:ListItem>Maximum</asp:ListItem>
                                                <asp:ListItem>Special</asp:ListItem>
                                            </asp:DropDownList>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width: 272px; font-size: small; text-align: left;">
                                            <b>Price</b>
                                        </td>
                                        <td align="left">
                                            <asp:TextBox ID="txtPrice" runat="server" Width="200px"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width: 272px; font-size: small; text-align: left;">
                                            <b>Quantity</b>
                                        </td>
                                        <td align="left">
                                            <asp:TextBox ID="txtQuantity" runat="server" Height="16px" Width="90px"></asp:TextBox>
                                            &nbsp;-
                                            <asp:DropDownList ID="ddlIUnit" runat="server" Width="100px">
                                                <asp:ListItem>Pcs</asp:ListItem>
                                                <asp:ListItem>Rft</asp:ListItem>
                                                <asp:ListItem>Job</asp:ListItem>
                                            </asp:DropDownList>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width: 272px; font-size: small; text-align: left;">
                                            <b>With GST</b>
                                        </td>
                                        <td align="left">
                                            <asp:CheckBox ID="cboxGST" runat="server" Style="vertical-align: middle" AutoPostBack="true" OnCheckedChanged="cboxGST_CheckedChanged"/>
                                            &nbsp;<asp:TextBox onKeyPress="allowOnlyNumaric(event);" MaxLength="5" ID="txtGST" runat="server"
                                                Width="39px"></asp:TextBox>
                                            &nbsp;%
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width: 272px; font-size: small;">
                                            &nbsp;
                                        </td>
                                        <td align="left">
                                            <asp:Label ID="lblmessage" runat="server" Style="font-size: small"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width: 272px">
                                        </td>
                                        <td align="left">
                                            <asp:Button ID="btnAdd" runat="server" Width="200px" Text="Add Item Line in this Quotation" OnClick="btnAdd_Click"
                                                BackColor="#ABD3FC" />
                                            &nbsp;
                                            <asp:Button ID="btnUpdate" runat="server"  Width="150px" Text="Item Line Edit Done! " OnClick="btnUpdate_Click"
                                                BackColor="#ABD3FC" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="2" align="left" 
                                            style="border-style: none none solid none; border-width: thin; border-color: #FF0000; font-size: small; color: #FF9900;">
                                            &nbsp;</td>
                                    </tr>
                                    <tr>
                                        <td colspan="2">
                                            <div style="overflow: auto; height: auto; text-align: left">
                                                <asp:GridView ID="GridQuotItems" runat="server" CellPadding="5" AutoGenerateColumns="False"
                                                    ForeColor="#333333" Width="100%" OnRowCommand="GridQuotItems_RowCommand"
                                                    OnRowDeleting="GridQuotItems_RowDeleting" 
                                                    OnRowEditing="GridQuotItems_RowEditing" CellSpacing="5" 
                                                    EnableModelValidation="True">
                                                    <Columns>
                                                         
                                                        <asp:TemplateField HeaderText="Item Name">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblitem" runat="server" Text='<%#Eval("itemname") %>'></asp:Label>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Equipment & Service Description">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lbleqserdes" runat="server" Text='<%#Eval("description") %>'></asp:Label>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Quantity">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblQuantity" runat="server" Text='<%#Eval("quantity") %>'></asp:Label>
                                                            </ItemTemplate>
                                                            <ItemStyle HorizontalAlign="Center" />
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Unit">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblUnit" runat="server" Text='<%#Eval("unit") %>'></asp:Label>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Unit Price">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblUnitPrice" runat="server" Text='<%#Eval("price") %>'></asp:Label>
                                                            </ItemTemplate>
                                                            <HeaderStyle HorizontalAlign="Center" />
                                                            <ItemStyle HorizontalAlign="Right" />
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="GST">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblGST" runat="server" Text='<%#Eval("gst") %>'></asp:Label>
                                                            </ItemTemplate>
                                                            <HeaderStyle HorizontalAlign="Center" />
                                                            <ItemStyle HorizontalAlign="Right" />
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Total Price">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblTotalPrice" runat="server" Text='<%#Eval("totalprice") %>'></asp:Label>
                                                            </ItemTemplate>
                                                            <HeaderStyle HorizontalAlign="Center" />
                                                            <ItemStyle HorizontalAlign="Right" />
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Edit">
                                                            <ItemTemplate>
                                                                <asp:ImageButton ID="imgbtnEdit" runat="server" CommandArgument='<%#Eval("itemid") %>'
                                                                    CommandName="Edit" ImageUrl="~/images1/Edit.gif" />
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Delete">
                                                            <ItemTemplate>
                                                                <asp:ImageButton ID="imgbtnDelete" runat="server" CommandArgument='<%#Eval("itemid") %>'
                                                                    CommandName="Delete" ImageUrl="~/images1/delete.gif" />
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                    </Columns>
                                                    <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
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
                                    
                                    <%--add by saqib--%>
                                    <tr>
                                        <td colspan="2" align="left" 
                                            style="border-style: none none solid none; border-width: medium; border-color: #FF0000; font-size: small; color: #FF9900;">
                                            &nbsp;</td>
                                    </tr>
                                      <tr>
                                        <td align="left" class="style5" colspan="2" style="color: #FF9900;">
                                            <strong>Special Notes </strong>
                                        </td>
                                    </tr>

                                     <tr>
                                        
                                        <td align="left" colspan="2">
                                            
                                            <textarea id="textAreaSpecialNotes" runat="server" cols="20" rows="2" style="margin: 0px; width: 1238px; height: 127px;"
                                                value="Unit Price are exclusive of all type of Taxes.
GST Applicable On hardware system In case of any variation in quantity order, the total project cost would be calculated on the basis of unit costs.
3-Phase Electric Power and water for civil works will be clients responsibility.
Valuation: The price mentioned in this quotation is based on current value of USD i e Rs 162, any appreciation or depreciation in currency will be charged accordingly, the value will be reassessed on date of delivery of equipment.
Govt Taxes & Duties : The Price mentioned in this quotation is based on Current Govt Taxes and Custom Duties and Tariff Structure, any change in it by FBR will be directly effect the prices in same magnitude, the value will be reassessed on date of delivery of equipment in case of change in Tariff & Taxes structure. 
Civil work related to turnstile is clients responsibility"></textarea>
                                        </td>
                                    </tr>

                                      <tr>
                                        <td colspan="2" align="left" 
                                            style="border-style: none none solid none; border-width: medium; border-color: #FF0000; font-size: small; color: #FF9900;">
                                            &nbsp;</td>
                                    </tr>

                                    <tr>
                                        <td align="left" class="style5" colspan="2" style="color: #FF9900;">
                                            <strong>Terms And Condition </strong>
                                        </td>
                                    </tr>
                                    <tr>
                                      <td style="text-align:right;" >
                                          Type Name:
                                      </td>
                                      <td>
                                        <asp:DropDownList ID="ddlType"  Style="height:20px; background-color:white;float:left;" OnSelectedIndexChanged="ddlType_SelectedIndexChanged" AutoPostBack="true" runat="server"></asp:DropDownList>
                                      <a target="_blank" Style="float:left;"  href="TermsAndConditionType.aspx"><span>Add Terms And Condition Type</span></a>
                                      </td>
                                  </tr>
                                  <tr>
                                      <td style="text-align:right;" >
                                         Terms and Condition Name:
                                      </td>
                                      <td>
                                          <asp:DropDownList ID="ddlTermName"  Style="height:20px; background-color:white;float:left;" onchange="getDiscription();"   runat="server"></asp:DropDownList>
                                      <a target="_blank"  Style="float:left;" href="TermDiscription.aspx"><span>Add Terms And Condition Name</span></a>
                                      </td>
                                  </tr>
                                      <tr>
                                      <td style="text-align:right;" >
                                         Discription:
                                      </td>
                                      <td>
                                          <textarea id="txtDiscription" cols="50" runat="server" readonly="readonly" style="float:left;" rows="10"></textarea>
                                      </td>
                                       </tr>
                                    <tr>
                                        <td></td>
                                        <td align="left"><asp:label runat="server" ID="lblTermsAndDiscription"></asp:label></td>
                                    </tr>
                                     <tr>
                                        <td style="width: 272px">
                                        </td>
                                        <td align="left">
                                            <asp:Button ID="btnAddTermsAndCondition" runat="server" Width="200px" Text="Add Terms And Condition" OnClick="btnAddTermsAndCondition_Click"
                                                BackColor="#ABD3FC" />
                                            &nbsp;
                                            <asp:Button ID="btnUpdateTermsAndCondition" runat="server"  Width="150px" Text="Update Terms And Condition " OnClick="btnUpdateTermsAndCondition_Click"
                                                BackColor="#ABD3FC" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="2">
                                            <div style="overflow: auto; height: auto; text-align: left">
                                                <asp:GridView ID="GVTermsAndCondition" runat="server" CellPadding="5" AutoGenerateColumns="False"
                                                    ForeColor="#333333" Width="100%" OnRowCommand="GVTermsAndCondition_RowCommand"
                                                    OnRowDeleting="GVTermsAndCondition_RowDeleting" 
                                                    OnRowEditing="GVTermsAndCondition_RowEditing" CellSpacing="5" 
                                                    EnableModelValidation="True">
                                                    <Columns>
                                                        <asp:TemplateField HeaderText="Term Type">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblTermType" runat="server" Text='<%#Eval("TermType") %>'></asp:Label>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                         <%--<asp:TemplateField HeaderText="Term Type">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblTermType" runat="server" Text='<%#Eval("TermTypeID") %>'></asp:Label>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>--%>

                                                        <asp:TemplateField HeaderText="Term Name">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblTermName" runat="server" Text='<%#Eval("TermName") %>'></asp:Label>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                        <%-- <asp:TemplateField HeaderText="Term Name">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblTermName" runat="server" Text='<%#Eval("TermNameID") %>'></asp:Label>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>--%>


                                                        <asp:TemplateField HeaderText="Discription">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblTermDiscription" runat="server" Text='<%#Eval("TermDiscription") %>'></asp:Label>
                                                            </ItemTemplate>   
                                                        </asp:TemplateField>                                                        
                                                        <asp:TemplateField HeaderText="Edit">
                                                            <ItemTemplate>
                                                                <asp:ImageButton ID="imgbtnEdit" runat="server" CommandArgument='<%#Eval("TermNameID") %>'
                                                                    CommandName="Edit" ImageUrl="~/images1/Edit.gif" />
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Delete">
                                                            <ItemTemplate>
                                                                <asp:ImageButton ID="imgbtnDelete" runat="server" CommandArgument='<%#Eval("TermNameID") %>'
                                                                    CommandName="Delete" ImageUrl="~/images1/delete.gif" />
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                    </Columns>
                                                    <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
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

                                    <tr style="display:none;">
                                        <td style="width: 272px; font-size: small; text-align: left;">
                                            <b>Payment Terms</b>
                                        </td>
                                        <td align="left">
                                            <asp:TextBox ID="txtPaymentTerms" runat="server" Text="50% In advance , 25% on delivery and 25% on task completion" Width="100%"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr style="display:none;">
                                        <td style="width: 272px; font-size: small; text-align: left;">
                                            <b>Warranty Terms</b>
                                        </td>
                                        <td align="left">
                                            <asp:TextBox ID="txtWarrantyTerms" Text="1 year Electrical and Mechnical Waranty" runat="server" Width="100%"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr style="display:none;">
                                        <td style="width: 272px; font-size: small; text-align: left;">
                                            <b>Warranty Exception</b>
                                        </td>
                                        <td align="left">
                                            <asp:TextBox ID="txtWarrantyException" runat="server"  Text="Warranty does not cover the losses incurred due to negligence misuse, unprotected power supply. DC Power supply & consumable items." Width="100%"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr style="display:none;">
                                        <td style="width: 272px; font-size: small; text-align: left;">
                                            <b>Delivery & Installation</b>
                                        </td>
                                        <td align="left">
                                            <asp:TextBox ID="txtDeliveryInstallation" Text="30 Working days after confirm purchase order." runat="server" Width="100%"></asp:TextBox>
                                        </tr>
                                    <tr style="display:none;">
                                        <td style="width: 272px; font-size: small; text-align: left;">
                                            <b>Validity</b>
                                        </td>
                                        <td align="left">
                                            <asp:TextBox ID="txtValidity"  Text="Prices are valid for 30 days." runat="server" Width="100%"></asp:TextBox>
                                        </tr>
                                    <tr style="display:none;">
                                        <td style="width: 272px; font-size: small; text-align: left;">
                                            <b>Civil and Electrical Work</b>
                                        </td>
                                        <td align="left">
                                            <asp:TextBox ID="TextBox1"  Text="Client will provide three phase power and LAN connectivity at installation site." runat="server" Width="100%"></asp:TextBox>
                                        </tr>
                                    <tr style="display:none;">
                                        <td style="width: 272px; font-size: small; text-align: left;">
                                            <b>Tex Exemption</b>
                                        </td>
                                        <td align="left">
                                            <asp:TextBox ID="txtTexExemption" runat="server" Text="Tex exemption/certificates has to be provided if applicable." Width="100%"></asp:TextBox>
                                        </tr>
                                    <tr>
                                        <td colspan="2" align="center" class="style6">
                                            <asp:Label ID="lblmessage1" runat="server"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr style="margin:3%; display:none;">
                                    <td>
                                    Select Term
                                    </td>
                                    <td>
                                  
                                    <asp:DropDownList ID="ddlSelectTerm" runat="server" AutoPostBack="True"
                                            onselectedindexchanged="ddlSelectTerm_SelectedIndexChanged">
                                    
                                    </asp:DropDownList>
                                      </td>
                                    </tr>
                                    <tr style="display:none;">
                                    <td>
                                    Term Description
                                    </td>
                                    <td><asp:DropDownList ID="ddlTermDescription" runat="server"></asp:DropDownList>
                                    
                                    </td>
                                    </tr>
                                    <tr>
                                        <td colspan="2" align="left" 
                                            style="border-style: none none solid none; border-width: thin; border-color: #FF0000; font-size: small; color: #FF9900;">
                                            Note: Please Save/update Quotation after every item line (adding, editing, deleting). </td>
                                    </tr>
                                    <tr>
                                        <td colspan="2">
                                            <asp:Button ID="btnSave" runat="server" Text="Save Quotation" Width="120px" OnClick="btnSave_Click"
                                                BackColor="#ABD3FC" />
                                            &nbsp;
                                            <asp:Button ID="btnUpdate1" runat="server" Width="120px" Text="Update Quotation" OnClick="btnUpdate1_Click"
                                                BackColor="#ABD3FC" />
                                            &nbsp;
                                            <asp:Button ID="btnClear" runat="server" Width="58px" Text="Clear" OnClientClick="RELOAD()"
                                                OnClick="btnClear_Click" BackColor="#ABD3FC" /> 
                                            <asp:Label ID="lblQuotation" runat="server"  Style="font-size: small"></asp:Label>
                                        </td>
                                    </tr>
                                  
                                    <tr>
                                        <td colspan="2">
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="2" align="left" 
                                            style="border-style: none none solid none; border-width: medium; border-color: #FF0000; font-size: small; color: #FF9900;">
                                            &nbsp;</td>
                                    </tr>
                                    <tr>
                                        <td colspan="2">
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="2" align="center">
                                            <asp:Button ID="btnViewQot" Width="179px" runat="server" 
                                                Text="Search/View All Quotations" OnClick="btnViewQot_Click"
                                                BackColor="#ABD3FC" Height="35px" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="2">
                                            <div style="overflow: auto; height: auto">
                                                <asp:GridView ID="GridQuotations" runat="server" CellPadding="4"
                                                    AutoGenerateColumns="False" Width="100%" OnRowCommand="GridQuotations_RowCommand"
                                                    OnRowEditing="GridQuotations_RowEditing" BackColor="White" 
                                                    BorderColor="#3366CC" BorderStyle="None" BorderWidth="1px" 
                                                    EnableModelValidation="True" PageSize="2">
                                                    <Columns>
                                                        <asp:TemplateField HeaderText="Ref No">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblRefNo" runat="server" Text='<%#Eval("Ref") %>'></asp:Label>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Client Name">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblClientName" runat="server" Text='<%#Eval("client_name") %>'></asp:Label>
                                                            </ItemTemplate>
                                                            <ItemStyle HorizontalAlign="Left" />
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Designation">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblDesignation" runat="server" Text='<%#Eval("client_designation") %>'></asp:Label>
                                                            </ItemTemplate>
                                                            <ItemStyle HorizontalAlign="Left" />
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Organization">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblOrganization" runat="server" Text='<%#Eval("comp_name") %>'></asp:Label>
                                                            </ItemTemplate>
                                                            <ItemStyle HorizontalAlign="Left" />
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Quotation Date">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblQuotDate" runat="server" Text='<%#Eval("quo_date") %>'></asp:Label>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Status">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblStatus" runat="server" Text='<%#Eval("status") %>'></asp:Label>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="View Quot">
                                                            <ItemTemplate>
                                                               <%-- <asp:ImageButton ID="imgbtnView" runat="server" CommandArgument='<%#Eval("quo_id") %>'
                                                                    CommandName="View" ImageUrl="~/images1/view3.png" />--%>
                                                                     <asp:HyperLink ID="HyperLink1" runat="server" 
                                                                       navigateUrl = '<%# "FrmQuotationsViewer.aspx?QuotID=" + Eval("quo_id")%>'
                                                                        Target="_blank">
                                                                View
                                                            </asp:HyperLink>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Edit">
                                                            <ItemTemplate>
                                                                <asp:ImageButton ID="imgbtnEdits1" runat="server" CommandArgument='<%#Eval("quo_id") %>'
                                                                    CommandName="Edit" ImageUrl="~/images1/Edit.gif" />
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Approve">
                                                            <ItemTemplate>
                                                                <asp:ImageButton ID="imgbtnApprove" runat="server" CommandArgument='<%#Eval("quo_id") %>'
                                                                    CommandName="Approve" ImageUrl="~/images1/Approve.png" />
                                                                    <%-- NavigateUrl="FrmQuotationsViewer.aspx?QuotID=" +'<%#Eval("quo_id") %>'--%>
                                                                   
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                    </Columns>
                                                    <FooterStyle BackColor="#99CCCC" ForeColor="#003399" />
                                                    <HeaderStyle BackColor="#003399" Font-Bold="True" ForeColor="#CCCCFF" />
                                                    <PagerStyle BackColor="#99CCCC" ForeColor="#003399" HorizontalAlign="Left" />
                                                    <RowStyle BackColor="White" ForeColor="#003399" />
                                                    <SelectedRowStyle BackColor="#009999" Font-Bold="True" ForeColor="#CCFF99" />
                                                </asp:GridView>
                                            </div>
                                        </td>
                                    </tr>
                                </table>
                                <%--</fieldset>--%>
                            </div>

                          
                        </td>
                    </tr>
                </table>
            </ContentTemplate>
        </asp:UpdatePanel>
    </div>

    <script type="text/javascript" language="javascript">
        function getDiscription() {
            var term_ID = $("select[id$='ddlTermName']").val();
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "frmQuotations.aspx/LoadTermDiscription",
                data: "{term_ID:'" + term_ID + "'}",
                success: onsuccessLoadComp,
                error: onErrorLoadComp
            });
            return false;
        }
        function onsuccessLoadComp(msg) {
            var data = msg.d;
            $("textarea[id$='txtDiscription']").val(data.TermDiscription[0].term_discription);
            return false;
        }
        function onErrorLoadComp() {
            alert("Error In Loading Details!");
            return false;
        }
    </script>

</asp:Content>

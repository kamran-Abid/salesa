<%@ Page Language="C#" MasterPageFile="~/MCTX_Internal/SuperAdmin/MasterAdmin.master"
    AutoEventWireup="true" CodeFile="AddSalesVisits.aspx.cs" Inherits="MCTX_Internal_SuperAdmin_frmVisitReports"
    EnableEventValidation="false" Title="Sales Visits" %>

<%@ Register Assembly="RJS.Web.WebControl.PopCalendar.Net.2008" Namespace="RJS.Web.WebControl"
    TagPrefix="rjs" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <script src="../../js/jquery.dataTables.min.js" type="text/javascript"></script>

    <script src="../../js/BlockUI.js" type="text/javascript"></script>

    <script src="../../js/jquery.fixedheader.js" type="text/javascript"></script>

    <script src="../../js/jqModal.js" type="text/javascript"></script>

    <link href="../../css1/jqModal.css" rel="stylesheet" type="text/css" />
    <style type="text/css">
        .dataTable
        {
            font-family: Calibri ,Verdana, Arial, Helvetica, sans-serif;
            border-collapse: collapse;
            border: 1px solid #999999;
            width: 100%;
            font-size: 12px;
        }
        .dataTable td, .dataTable th
        {
            border: 1px solid #999999;
            padding: 3px 5px;
            margin: 0px;
            text-align: left;
        }
        .dataTable thead th
        {
            background-color: #cccccc;
            color: #444444;
            font-weight: bold;
            text-align: left;
        }
        .dataTable thead a
        {
            text-decoration: none;
            color: #444444;
        }
        .dataTable thead a:hover
        {
            text-decoration: underline;
        }
        /* Firefox has missing border bug! https://bugzilla.mozilla.org/show_bug.cgi?id=410621 *//* Firefox 2 */html< /**/ /**/ body .dataTable, x:-moz-any-link
        {
            margin: 1px;
        }
        /* Firefox 3 */html< /**/ /**/ body .dataTable, x:-moz-any-link, x:default
        {
            margin: 1px;
        }
        .style2
        {
            width: 189px;
        }
        .style3
        {
            width: 149px;
        }
        .style4
        {
            width: 184px;
        }
        td
        {
            text-align: left;
        }
        input:focus
        {
            height: 18px;
            font-size: 11pt;
            font-family: Calibri,Verdana, Arial, Helvetica, sans-serif;
            box-shadow: 0 -1px 0 rgba(0, 0, 0, 0.3), 0 1px 2px rgba(0, 0, 0, 0.1) inset, 0 0 10px rgba(255, 255, 255, 0.9);
            border-color: #ABD3FC;
        }
        input
        {
            height: 18px;
            font-size: 10pt;
            font-family: Calibri,Verdana, Arial, Helvetica, sans-serif;
            width: 150px;
            border: 1px solid #CCCCCC;
        }
        textarea:focus
        {
            font-size: 11pt;
            font-family: Calibri,Verdana, Arial, Helvetica, sans-serif;
            width: 150px;
            box-shadow: 0 -1px 0 rgba(0, 0, 0, 0.3), 0 1px 2px rgba(0, 0, 0, 0.1) inset, 0 0 10px rgba(255, 255, 255, 0.9);
            border-color: #ABD3FC;
        }
        textarea
        {
            font-size: 10pt;
            font-family: Calibri,Verdana, Arial, Helvetica, sans-serif;
            width: 150px;
            height: 50px;
            border: 1px solid #CCCCCC;
        }
        span
        {
            font-family: Calibri,Verdana, Arial, Helvetica, sans-serif;
            font-size: 12px;
        }
        SELECT
        {
            font-family: Calibri,Verdana, Arial, Helvetica, sans-serif;
            width: 152px;
            font-size: 11px;
            border: 1px solid #CCCCCC;
            height: 19px;
        }
        SELECT:focus
        {
            font-family: Calibri,Verdana, Arial, Helvetica, sans-serif;
            font-weight: bold;
            width: 152px;
            font-size: 11px;
            box-shadow: 0 -1px 0 rgba(0, 0, 0, 0.3), 0 1px 2px rgba(0, 0, 0, 0.1) inset, 0 0 10px rgba(255, 255, 255, 0.9);
        }
        OPTION
        {
            font-family: Calibri,Verdana, Arial, Helvetica, sans-serif;
            font-weight: normal;
        }
        .CloseButton
        {
            background: none repeat scroll 0 0 transparent;
            border: medium none;
            height: 32px;
            margin-top: -30px;
            position: absolute;
            width: 32px;
            cursor: pointer;
        }
    </style>
    <div id="tabs" style="width: 949px;">
        <ul>
            <li style="text-align: left"><a href="#tabs-1">Visits Info & Details</a></li>
        </ul>
        <fieldset style="width: 96%">
            <legend>Add Visits Details</legend>
            <table style="width: 100%; font-family: Calibri; font-size: 11pt;">
                <tr>
                    <td align="left" style="width: 140px;">
                        <asp:Label ID="lblCompany" Text="Select Company:" runat="server"></asp:Label>
                    </td>
                    <td align="left" style="width: 140px;">
                        <asp:DropDownList ID="ddlCompany" Width="95%" OnChange="return PopulateClient();"
                            runat="server">
                        </asp:DropDownList>
                    </td>
                    <td align="left" style="width: 140px;">
                        <asp:Label ID="lblClient" Text="Client Name:" runat="server"></asp:Label>
                    </td>
                    <td align="left" style="width: 140px;">
                        <asp:DropDownList ID="ddlClient" Width="95%" runat="server">
                        </asp:DropDownList>
                    </td>
                    <td>
                    </td>
                </tr>
                <tr>
                    <td align="left" style="width: 140px;">
                    </td>
                    <td align="left" style="width: 140px;">
                        <asp:TextBox ID="txtCurrDate" Width="95%" Style="display: none;" runat="server"></asp:TextBox>
                    </td>
                    <td align="left" style="width: 140px;">
                    </td>
                    <td align="left" style="width: 140px;">
                    </td>
                    <td>
                    </td>
                </tr>
                <tr>
                    <td align="left" style="width: 140px;">
                    </td>
                    <td align="left" style="width: 140px;">
                        <asp:TextBox ID="txtCreatedDate" Width="95%" Style="display: none;" runat="server"></asp:TextBox>
                    </td>
                    <td align="left" style="width: 140px;">
                    </td>
                    <td align="left" style="width: 140px;">
                    </td>
                    <td>
                    </td>
                </tr>
                <tr>
                    <td align="left" style="width: 140px;">
                    </td>
                    <td align="left" style="width: 140px;">
                        <asp:TextBox ID="txtPlanDays" Width="95%" Style="display: none;" runat="server"></asp:TextBox>
                    </td>
                    <td align="left" style="width: 140px;">
                    </td>
                    <td align="left" style="width: 140px;">
                    </td>
                    <td>
                    </td>
                </tr>
                <tr>
                    <td align="left" style="width: 140px;">
                        <asp:Label ID="lblCallType" Text="Call Type:" runat="server"></asp:Label>
                    </td>
                    <td align="left" style="width: 140px;">
                        <asp:DropDownList ID="ddlCallType" Width="95%" runat="server">
                        </asp:DropDownList>
                    </td>
                    <td align="left" style="width: 140px;">
                        <asp:Label ID="lblExcuse" Text="Add Excuse:" runat="server"></asp:Label>
                    </td>
                    <td align="left" style="width: 140px;">
                        <asp:LinkButton ID="lnkExcuse" Text="Add Excuse" Width="95%" OnClientClick="return AddExcuse();"
                            BackColor="Gray" ForeColor="White" Style="font-family: Calibri; font-size: small;"
                            runat="server"></asp:LinkButton>
                    </td>
                    <td align="left">
                        <asp:LinkButton ID="lnkAddClientComp" Text="Add Company/Client" BackColor="Gray"
                            ForeColor="White" Style="font-family: Calibri; font-size: small;" OnClientClick="return AddNewClientorCompany(); "
                            runat="server"></asp:LinkButton>
                    </td>
                </tr>
                <tr>
                    <td align="left" style="width: 140px;">
                        <asp:Label ID="lblTotalSaleAmt" Text="Total Sale Amount:" runat="server"></asp:Label>
                    </td>
                    <td align="left" style="width: 140px;">
                        <asp:TextBox ID="txtTotalSaleAmt" Width="95%" onkeypress="return keyRestrict(event,'0123456789')"
                            ReadOnly="true" runat="server"></asp:TextBox>
                    </td>
                    <td align="left" style="width: 140px;">
                        <asp:Label ID="lblClientRes" Text="Client Response:" runat="server"></asp:Label>
                    </td>
                    <td align="left" style="width: 140px;">
                        <asp:DropDownList ID="ddlClientRes" Width="95%" runat="server">
                        </asp:DropDownList>
                    </td>
                    <td>
                    </td>
                </tr>
                <tr>
                    <td align="left" style="width: 140px;">
                        <asp:Label ID="lblRemindDate" Text="Remind Date:" runat="server"></asp:Label>
                    </td>
                    <td align="left" style="width: 140px;">
                        <asp:TextBox ID="txtRemindDate" Width="81%" onkeypress="return keyRestrict(event,'0123456789/ ')"
                            runat="server"></asp:TextBox>
                        <rjs:PopCalendar ID="rjsPCRemindDate" runat="server" InvalidDateMessage="Invalid Date"
                            TextMessage="Invalid Date" ShowMessageBox="True" Separator="/" Format="mm dd yyyy"
                            Control="txtRemindDate"></rjs:PopCalendar>
                    </td>
                    <td align="left" style="width: 140px;">
                        <asp:Label ID="lblRemarks" Text="Remarks:" runat="server"></asp:Label>
                    </td>
                    <td align="left" style="width: 140px;">
                        <asp:TextBox ID="txtRemarks" TextMode="MultiLine" Style="resize: none;" onkeypress="return keyRestrict(event,'abcdefghijklmnopqrstuvwxyz0123456789,-# ')"
                            Width="95%" runat="server"></asp:TextBox>
                    </td>
                    <td align="left">
                        <asp:Button ID="btnAddVisit" Text="Add Visit" Style="background-color: #2A4062; color: White;
                            width: 84px" OnClientClick="return CheckCompBooked();" runat="server" />
                        <asp:Button ID="btnAddClear" Text="Clear" Style="background-color: #2A4062; color: White;
                            width: 84px" OnClientClick="return ClearFields();" runat="server" />
                    </td>
                </tr>
            </table>
        </fieldset>
        <fieldset style="width: 96%">
            <legend>Other Information</legend>
            <table style="width: 100%; font-family: Calibri; font-size: 11pt;">
                <tr>
                    <td style="width: 50%;">
                        <fieldset style="width: 90%">
                            <table style="width: 100%; font-family: Calibri; font-size: 11pt;">
                                <tr>
                                    <td align="left" style="width: 140px;">
                                        <asp:Label ID="lblCategory" Text="Select Category:" runat="server"></asp:Label>
                                    </td>
                                    <td align="left" style="width: 140px;">
                                        <asp:DropDownList ID="ddlCategory" OnChange="return ItemDDL();" Width="95%" runat="server">
                                        </asp:DropDownList>
                                    </td>
                                    <td>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="left" style="width: 140px;">
                                        <asp:Label ID="lblItem" Text="Item:" runat="server"></asp:Label>
                                    </td>
                                    <td align="left" style="width: 140px;">
                                        <asp:DropDownList ID="ddlItem" Width="95%" runat="server">
                                        </asp:DropDownList>
                                    </td>
                                    <td>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="left" style="width: 140px;">
                                        <asp:Label ID="lblSales" Text="Sales:" runat="server"></asp:Label>
                                    </td>
                                    <td align="left" style="width: 140px;">
                                        <asp:TextBox ID="txtSales" Width="95%" MaxLength="8" onkeypress="return keyRestrict(event,'0123456789')"
                                            runat="server"></asp:TextBox>
                                    </td>
                                    <td>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="left" style="width: 98%;" colspan="2">
                                        <asp:Button ID="btnAddSaleItem" Text="Add Item" Style="background-color: #2A4062;
                                            color: White; width: 84px" OnClientClick="return AddSalesItem();" runat="server" />
                                    </td>
                                </tr>
                            </table>
                        </fieldset>
                    </td>
                    <td style="width: 50%;">
                        <fieldset style="width: 90%">
                            <table style="width: 100%; font-family: Calibri; font-size: 11pt;">
                                <tr>
                                    <td align="left" style="width: 50%;">
                                        <asp:Label ID="lblMonthlySaleToDate" Text="Month Sale Upto Today:" runat="server"></asp:Label>
                                    </td>
                                    <td align="left" style="width: 50%;">
                                        <asp:Label ID="lblMonSaleToDate" Width="95%" Style="color: Navy" runat="server"></asp:Label>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="left" style="width: 50%;">
                                        <asp:Label ID="lblTotalSaleAmount" Text="Total Sales Amount:" runat="server"></asp:Label>
                                    </td>
                                    <td align="left" style="width: 50%;">
                                        <asp:Label ID="lblTotalSalAmt" Width="95%" Style="color: Navy" runat="server"></asp:Label>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="left" style="width: 100%;" colspan="2">
                                        <asp:Label ID="lblmsg" Text="Report Between 08:00 AM - 10:00 AM and 04:00 PM - 08:00 PM"
                                            ForeColor="DarkBlue" runat="server"></asp:Label>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="left" style="width: 100%;" colspan="2">
                                        <asp:LinkButton ID="lnkTodayVisit" Text="Today's Visits" BackColor="Gray" ForeColor="White"
                                            Style="font-family: Calibri; font-size: small;" OnClientClick="return TodayVisit();"
                                            runat="server"></asp:LinkButton>
                                    </td>
                                </tr>
                            </table>
                        </fieldset>
                    </td>
                </tr>
            </table>
        </fieldset>
    </div>
    <div style="width:92%;">
        <fieldset style="width:100%;margin-top:2%">
            <legend>All Visits</legend>
<table id="tblAllvisits" style="width:100%;" class="dataTable">

</table>

        </fieldset>

    </div>

    <div id="divAddExcuse" class="jqmWindow" style="display: none; width: 900px; height: 400px;
        left: 40%; top: 25%;">
        <table style="width: 100%">
            <tr>
                <td style="text-align: right">
                    <div id="close">
                        <img src='image/btn_close02.png' style="background: none repeat scroll 0 0 transparent;
                            border: medium none; height: 32px; margin-top: -30px; position: absolute; width: 32px;
                            cursor: pointer;" alt="Close" onclick='return ClosePopUp();' />
                        <table style="width: 100%; font-family: Calibri; font-size: 11pt;">
                            <tr>
                                <td align="left" style="width: 140px;">
                                    <asp:Label ID="lblSelCompany" Text="Selected Company:" runat="server"></asp:Label>
                                </td>
                                <td align="left">
                                    <asp:DropDownList ID="ddlSelCompany" Enabled="false" Width="30%" runat="server">
                                    </asp:DropDownList>
                                </td>
                            </tr>
                            <tr>
                                <td align="left" style="width: 140px;">
                                    <asp:Label ID="lblSubject" Text="Subject:" runat="server"></asp:Label>
                                </td>
                                <td align="left">
                                    <asp:TextBox ID="txtSubject" Width="30%" onkeypress="return keyRestrict(event,'abcdefghijklmnopqrstuvwxyz0123456789,- ')"
                                        MaxLength="30" runat="server"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td align="left" style="width: 140px;">
                                    <asp:Label ID="lblDetails" Text="Details:" runat="server"></asp:Label>
                                </td>
                                <td align="left">
                                    <asp:TextBox ID="txtDetails" Width="30%" Height="100px" MaxLength="300" TextMode="MultiLine"
                                        Style="resize: none;" onkeypress="return keyRestrict(event,'abcdefghijklmnopqrstuvwxyz0123456789,-#. ')"
                                        runat="server"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td align="left" style="width: 140px;">
                                </td>
                                <td align="left">
                                    <asp:Button ID="btnAddExcuse" Text="Add Excuse" Style="background-color: #2A4062;
                                        color: White; width: 84px" OnClientClick="return AddExc();" runat="server" />
                                    <asp:Button ID="btnClearExcuse" Text="Clear" Style="background-color: #2A4062; color: White;
                                        width: 84px" OnClientClick="return ClearPop();" runat="server" />
                                </td>
                            </tr>
                        </table>
                    </div>
                </td>
            </tr>
        </table>
    </div>
    <div id="divTodayVisits" class="jqmWindow" style="display: none; width: 900px; height: 400px;
        left: 40%; top: 25%;">
        <div id="CloseDiv">
            <img src='image/btn_close02.png' style="background: none repeat scroll 0 0 transparent;
                border: medium none; height: 32px; margin-top: -30px; margin-left: 894px; position: absolute;
                width: 32px; cursor: pointer;" alt="Close" onclick='return CloseTodayVisits();' />
        </div>
        <div style="overflow: auto;">
            <table style="width: 100%">
                <tr>
                    <td>
                        <table style="width: 100%; font-family: Calibri; font-size: 11pt;">
                            <tr>
                                <td style="text-align: center; width: 100%">
                                    <table id="tblTodayVisits" style="width: 100%;" class="dataTable">
                                    </table>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
        </div>
    </div>
    <div id="divAddClient_Prospecting" class="jqmWindow" style="display: none; width: 900px;
        height: 400px; left: 40%; top: 25%;">
        <table style="width: 100%">
            <tr>
                <td style="text-align: right">
                    <div id="Div1">
                        <img src='image/btn_close02.png' style="background: none repeat scroll 0 0 transparent;
                            border: medium none; height: 32px; margin-top: -30px; position: absolute; width: 32px;
                            cursor: pointer;" alt="Close" onclick='return ClosePopUpClient();' />
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                    <fieldset style="border: 1px solid #ABD3FC">
                        <legend>New Company Information</legend>
                        <table style="width: 100%; font-family: Calibri; font-size: 11pt;">
                            <tr>
                                <td>
                                    <asp:Label ID="lblCompName" Text="Company Name:" Width="100%" runat="server"></asp:Label>
                                </td>
                                <td>
                                    <asp:TextBox onkeypress="return keyRestrict(event,'0123456789abcdefghijklmnopqrstuvwxyz& ')"
                                        ID="txtCompName" MaxLength="40" runat="server"></asp:TextBox>
                                </td>
                                <td>
                                    <asp:Label ID="lblCity" Text="Select City:" runat="server"></asp:Label>
                                </td>
                                <td>
                                    <asp:DropDownList ID="ddlCity" AutoPostBack="false" runat="server">
                                    </asp:DropDownList>
                                </td>
                                <td>
                                </td>
                                <td>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="lblEmail" Text="Email Address:" runat="server" onblur=""></asp:Label>
                                </td>
                                <td>
                                    <asp:TextBox ID="txtEmail" onkeypress="return keyRestrict(event,'@_1234567890-.abcdefghijklmnopqrstuvwxyz')"
                                        MaxLength="40" runat="server"></asp:TextBox>
                                </td>
                                <td>
                                    <asp:Label ID="lblWeb" Text="Web Address:" runat="server"></asp:Label>
                                </td>
                                <td>
                                    <asp:TextBox ID="txtWeb" MaxLength="40" onkeypress="return keyRestrict(event,'/-_.0123456789abcdefghijklmnopqrstuvwxyz ')"
                                        runat="server"></asp:TextBox>
                                </td>
                                <td>
                                </td>
                                <td>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="lblPhone" Text="Phone Number:" runat="server"></asp:Label>
                                </td>
                                <td>
                                    <asp:TextBox ID="txtPhone" onkeypress="return keyRestrict(event,'+0123456789')" MaxLength="16"
                                        runat="server"></asp:TextBox>
                                </td>
                                <td>
                                    <asp:Label ID="Label1" Text="Category:" runat="server"></asp:Label>
                                </td>
                                <td>
                                    <asp:DropDownList ID="ddlCategoryCompany" OnChange="return GetCategory_Products_DDL_Company();"
                                        runat="server">
                                    </asp:DropDownList>
                                </td>
                                <td>
                                </td>
                                <td>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="lblTarProd" Text="Target Product:" runat="server"></asp:Label>
                                </td>
                                <td align="left">
                                    <asp:DropDownList ID="ddlTarProd" AutoPostBack="false" runat="server">
                                    </asp:DropDownList>
                                </td>
                                <td>
                                    <asp:Label ID="lblAddress" Text="Address:" runat="server"></asp:Label>
                                </td>
                                <td colspan="2">
                                    <asp:TextBox ID="txtAddress" MaxLength="200" TextMode="MultiLine" onkeypress="textCounter(this,this.form.counter,200);return keyRestrict(event,'0123456789abcdefghijklmnopqrstuvwxyz-#, ');"
                                        runat="server"></asp:TextBox>
                                    <input type="text" style="width: 25px;" disabled="disabled" name="counter" maxlength="3"
                                        size="3" value="200" onblur="textCounter(this.form.counter,this,200);">
                                    chars remaining
                                </td>
                                <td>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                </td>
                                <td colspan="2" style="text-align: right">
                                </td>
                                <td>
                                    <asp:Button ID="btnSave" Text="Save" Width="75px" BackColor="#ABD3FC" OnClientClick="return SaveCompInfo();"
                                        runat="server" />&nbsp;
                                    <asp:Button ID="btnClear" Text="Clear" Width="75px" BackColor="#ABD3FC" OnClientClick="return ClearComp();"
                                        runat="server" />
                                </td>
                                <td>
                                </td>
                            </tr>
                        </table>
                    </fieldset>
                </td>
            </tr>
            <tr>
                <td>
                    <fieldset style="border: 1px solid #ABD3FC">
                        <legend>New Client Information</legend>
                        <table width="100%">
                            <tr>
                                <td>
                                    <span>Company Name:</span>
                                </td>
                                <td>
                                    <asp:DropDownList ID="ddlCompanyName_Client" runat="server" />
                                </td>
                                <td>
                                    <span>Client Name:</span>
                                </td>
                                <td>
                                    <asp:TextBox onkeypress="return keyRestrict(event,'abcdefghijklmnopqrstuvwxyz ')"
                                        ID="txtClientName_Client" MaxLength="40" runat="server" />
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <span>Department:</span>
                                </td>
                                <td>
                                    <asp:TextBox ID="txtDept_Client" onkeypress="return keyRestrict(event,'0123456789abcdefghijklmnopqrstuvwxyz-& ')"
                                        MaxLength="40" runat="server" />
                                </td>
                                <td>
                                    <span>Designation:</span>
                                </td>
                                <td>
                                    <asp:TextBox ID="txtDesg_Client" onkeypress="return keyRestrict(event,'0123456789abcdefghijklmnopqrstuvwxyz-& ')"
                                        MaxLength="40" runat="server" />
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <span>Mobile No:</span>
                                </td>
                                <td>
                                    <asp:TextBox ID="txtMobileNo_Client" onkeypress="return keyRestrict(event,'+0123456789')"
                                        MaxLength="16" runat="server" />
                                </td>
                                <td>
                                    <span>E-mail:</span>
                                </td>
                                <td>
                                    <asp:TextBox ID="txtEmail_Client" onkeypress="return keyRestrict(event,'@_1234567890-.abcdefghijklmnopqrstuvwxyz')"
                                        runat="server" MaxLength="40" />
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <span>Phone:</span>
                                </td>
                                <td>
                                    <asp:TextBox onkeypress="return keyRestrict(event,'+0123456789')" ID="txtPhone_Client"
                                        MaxLength="16" runat="server" />
                                </td>
                                <td>
                                    <span>Country:</span>
                                </td>
                                <td>
                                    <asp:DropDownList ID="ddlCountry_Client" runat="server" OnChange="return OnChange_Country_Client();" />
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <span>City:</span>
                                </td>
                                <td>
                                    <select id="ddlCity_Client" name="ddlCity_Client">
                                        <option></option>
                                    </select>
                                </td>
                                <td>
                                    <span>Address:</span>
                                </td>
                                <td>
                                    <asp:TextBox ID="txtAddress_Client" onkeypress="textCounter(this,this.form.counter_ClientAddress,200);return keyRestrict(event,'0123456789abcdefghijklmnopqrstuvwxyz.#,- ')"
                                        runat="server" TextMode="MultiLine" Width="150px" MaxLength="200" />
                                    <input type="text" style="width: 25px;" disabled="disabled" name="counter_ClientAddress"
                                        maxlength="3" size="3" value="200" onblur="textCounter(this.form.counter_ClientAddress,this,200);">
                                    chars remaining
                                </td>
                            </tr>
                            <tr>
                                <td>
                                </td>
                                <td>
                                </td>
                                <td>
                                </td>
                                <td style="text-align: left">
                                    <asp:Button ID="btnAddClientInfo" runat="server" Width="75px" BackColor="#ABD3FC"
                                        OnClientClick="return Add_ClientInfo();" Text="Save" />
                                    <asp:Button ID="btnClear_Client" runat="server" Width="75px" BackColor="#ABD3FC"
                                        OnClientClick="return Clear_Client();" Text="Clear" />
                                </td>
                            </tr>
                        </table>
                    </fieldset>
                    &nbsp;
                </td>
            </tr>
        </table>
    </div>

    <script type="text/javascript" language="javascript">
        var oTable;
        var oTable1;
    $(document).ajaxStart(blockUI).ajaxStop(unblockUI);

    function blockUI() {
            $.blockUI({ message: '<img src="image/ajax-loader.gif" />',
                css: { borderStyle: 'none', backgroundColor: "Transparent" }
            });
        }

    function unblockUI() {
            $.unblockUI();
        }
    $(document).ready(function()
    {
       var Amount = 0;
       $("input[id$='txtTotalSaleAmt']").val(Amount);
       PopulateCompanyDDL();
       CatDDL();
       CallDLL();
       ClientResDDL();
       Load_CategoriesDDL();
       Load_Companies();
       LoadMonSale();
       LoadTotalSale();
       GetTodaysVisits();
       GetAllVisits();
    });
    
    function dataTable() {
        oTable= $("#tblTodayVisits").dataTable({
                bPaginate: false,
                bDestroy: true,
                bJQueryUI: true,
                oLanguage:{"sSearch":"Filter: "}               
            });
      }
      
    function dataTableForAllVisits() {
        oTable = $("#tblAllvisits").dataTable({
            bPaginate: false,
            bDestroy: true,
            bJQueryUI: true,
            oLanguage: { "sSearch": "Filter: " }
        });
    }
       function Add_ClientInfo() {
            var CompanyId = $("select[id$='ddlCompanyName_Client'] option:selected").val().trim();
            var ClientName = $("input[id$='txtClientName_Client']").val().trim();
            var Department = $("input[id$='txtDept_Client']").val().trim();
            var Address = $("textarea[id$='txtAddress_Client']").val().trim();
            var Designation = $("input[id$='txtDesg_Client']").val().trim();
            var Mobile = $("input[id$='txtMobileNo_Client']").val().trim();
            var Email = $("input[id$='txtEmail_Client']").val().trim();

            var Phone = $("input[id$='txtPhone_Client']").val().trim();
            var CountryId = $("select[id$='ddlCountry_Client'] option:selected").val().trim();
            var CityId = $("select[id$='ddlCity_Client'] option:selected").val().trim();

            if (CompanyId == "") {
                alert("Please select company!");
                return false;
            }
            if (ClientName == "") {
                alert("Please enter client name!");
                return false;
            }
            if (Department == "") {
                alert("Please enter department name!");
                return false;
            }
            if (Designation == "") {
                alert("Please enter designation!");
                return false;
            }
            if (Mobile == "" && Phone == "" && Email == "") {
                alert("Please enter either mobile no, phone no or email!");
                return false;
            }

            if (CountryId == "") {
                alert("Please select Country!");
                return false;
            }
            if (CityId == "") {
                alert("Please select city!");
                return false;
            }


            $.ajax({
                type: "POST",
                dataType: "json",
                contentType: "application/json; charset=utf-8",
                url: "AddSalesVisits.aspx/Add_ClientInfo",
                async: false,
                data: "{'client_name':'" + ClientName + "','client_address':'" + Address + "','client_dept':'" + Department + "','client_designation':'" + Designation + "','client_email':'" + Email + "','Client_mobile':'" + Mobile + "','client_phone':'" + Phone + "','city_id':'" + CityId + "','comp_id':'" + CompanyId + "'}",
                success: OnSuccessAdd_ClientInfo,
                error: OnErrorAdd_ClientInfo
            });
            return false;
        }
        function OnSuccessAdd_ClientInfo() {
            alert("New Client Saved!");
            
            Clear_Client();
            return false;
        }
        function OnErrorAdd_ClientInfo() {
            alert("Error in Saving Client!");
            return false;
        }
        function Clear_Client() {
            $("input[id$='txtDept_Client']").val('');
            $("input[id$='txtClientName_Client']").val('');
            $("input[id$='txtDesg_Client']").val('');
            $("input[id$='txtMobileNo_Client']").val('');
            $("input[id$='txtEmail_Client']").val('');
            $("input[id$='txtPhone_Client']").val('');
            $("input[id$='txtAddress_Client']").val('');
            $("textarea[id$='txtAddress_Client']").val('');
            $("select[id$='ddlCountry_Client']").val('');
            $("select[id$='ddlCity_Client']").val('');
            $("select[id$='ddlCompanyName_Client']").val('');
            return false;
        }
        //-------------------------------------------Save Company Info------------------------------------------//
        function SaveCompInfo() {
            //checkEmail($("input[id$='txtEmail']").val());
            var CompName = $("input[id$='txtCompName']").val().trim();
            var CityID = $("select[id$='ddlCity']").val().trim();
            var Email = $("input[id$='txtEmail']").val().trim();
            var WebAdd = $("input[id$='txtWeb']").val().trim();
            var PhoneNum = $("input[id$='txtPhone']").val().trim();
            var TarProd = "";
            var TarProdId = "";
            var Category_Product = $("select[id$='ddlCategoryCompany'] option:selected").val().trim();
            var Address = $("textarea[id$='txtAddress']").val().trim();
            
            if (CompName == "") {
                alert("Please enter company name!");
                return false;
            }
            if (CityID == "") {
                alert("Please select city!");
                return false;
            }
            if (Email == "" && WebAdd == "" && PhoneNum == "") {
                alert("Please enter either email, web address or phone number!");
                return false;
            }

            if (Category_Product == "") {
                alert("Please select product category");
                return false;
            }

            if (Category_Product != "") {
                TarProd = $("select[id$='ddlTarProd'] option:selected").text().trim();
                TarProdId = $("select[id$='ddlTarProd'] option:selected").val().trim();
            }

            if (TarProd == "") {
                alert("Please select target product");
                return false;
            }
            
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "AddSalesVisits.aspx/SaveCompanyInfo",
                async: false,
                data: "{'CompName':'" + CompName + "','CityID':'" + CityID + "','Email':'" + Email + "','WebAdd':'" + WebAdd + "','PhoneNum':'" + PhoneNum + "','TarProd':'" + TarProd + "','TarProdId':'" + TarProdId + "','Address':'" + Address + "','Cat_Id':'" + Category_Product + "'}",
                success: onsuccessSaveComp,
                error: onErrorSaveComp
            });
            return false;
        }
        function onsuccessSaveComp() {
            alert("New company added!");
            Load_Companies();
            ClearComp();
            return false;
        }
        function onErrorSaveComp() {
            alert("Error In Saving Record!");
            return false;
        }
        function ClearComp() {
            $("select[id$='ddlCity']").val('');
            $("input[id$='txtCompName']").val('');
            $("select[id$='ddlCity']").val('');
            $("input[id$='txtEmail']").val('');
            $("input[id$='txtWeb']").val('');
            $("input[id$='txtPhone']").val('');
            $("textarea[id$='txtAddress']").val('');
            $("select[id$='ddlTarProd']").val('');
            $("select[id$='ddlCategoryCompany']").val('');
            $("input[id$='btnUpdate']").hide();
            $("input[id$='btnSave']").attr("disabled", false);
            return false;
        }

        function checkEmail(email) {
            if (/^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/.test(email)) {
                return true;
            }
            alert("Invalid e-mail address!");
            return false;
        }

         //-------------------------------------------------------------------------------------------------------------//
        function Clear() {
            $("select[id$='ddlCity']").val('');
            $("input[id$='txtCompName']").val('');
            $("select[id$='ddlCity']").val('');
            $("input[id$='txtEmail']").val('');
            $("input[id$='txtWeb']").val('');
            $("input[id$='txtPhone']").val('');
            $("textarea[id$='txtAddress']").val('');
            $("select[id$='ddlTarProd']").val('');
            $("input[id$='btnUpdate']").hide();
            $("input[id$='btnSave']").attr("disabled", false);
            return false;
        }

        function checkEmail(email) {
            if (/^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/.test(email)) {
                return true;
            }
            alert("Invalid e-mail address!");
            return false;
        }
        function ClosePopUpClient() {
            $("#divAddClient_Prospecting").jqmHide();
            return false;
        }
        function AddNewClientorCompany() {

            $('#divAddClient_Prospecting').jqm({ modal: true, overlay: 75, trigger: false });
            $('#divAddClient_Prospecting').jqmShow();
            return false;
        }
        var ba = $.browser;
        if (ba.msie) {
            $("#close").css('margin-left', '900px');
        }
        function Load_CategoriesDDL() {
            $.ajax({
                type: "POST",
                dataType: "json",
                contentType: "application/json; charset=utf-8",
                url: "AddSalesVisits.aspx/Load_CategoriesDDL",
                data: "",
                success: OnSuccessLoad_CategoriesDDL,
                error: OnErrorLoad_CategoriesDDL
            });
            return false;
        }

        function OnSuccessLoad_CategoriesDDL(msg) {
            var data = msg.d;
            $("select[id$=ddlCategory]> option").remove();
            $("select[id$=ddlCategoryCompany]> option").remove();
            for (var i = 0; i <= data.Categories.length - 1; i++) {

                $("select[id$='ddlCategory']").append("<option value=" + data.Categories[i].cat_id + ">" + data.Categories[i].cat_name + "</option>");
                $("select[id$='ddlCategoryCompany']").append("<option value=" + data.Categories[i].cat_id + ">" + data.Categories[i].cat_name + "</option>");
            }
            $("select[id$='ddlCategory']").prepend("<option></option>");
            $("select[id$='ddlCategoryCompany']").prepend("<option></option>");

            $("select[id$='ddlCategory']").val('');
            $("select[id$='ddlCategoryCompany']").val('');
            return false;
        }
        function OnErrorLoad_CategoriesDDL() {
            alert("Error in loading Categories!");
        }
        function GetCategory_Products_DDL_Company() {
            var Cat_id = $("select[id$='ddlCategoryCompany'] option:selected").val().trim();
            $.ajax({
                type: "POST",
                dataType: "json",
                contentType: "application/json; charset=utf-8",
                url: "AddSalesVisits.aspx/GetCategory_Products_DDL",
                data: "{'Cat_Id':" + Cat_id + "}",
                success: OnSuccessLoad_Products_DDL_Company,
                error: OnErrorLoad_Products_DDL_Company
            });
            return false;
        }

        function OnSuccessLoad_Products_DDL_Company(msg) {
            var data = msg.d;
            $("select[id$=ddlTarProd]> option").remove();
            for (var i = 0; i <= data.Products.length - 1; i++) {

                $("select[id$='ddlTarProd']").append("<option value=" + data.Products[i].item_id + ">" + data.Products[i].Item_name + "</option>");
            }
            $("select[id$='ddlTarProd']").prepend("<option></option>");
            $("select[id$='ddlTarProd']").val('');
            return false;
        }
        function OnErrorLoad_Products_DDL_Company() {
            alert("Error in loading Products!");
        }
        function Load_Companies() {
            $.ajax({
                type: "POST",
                dataType: "json",
                contentType: "application/json; charset=utf-8",
                url: "AddSalesVisits.aspx/Load_Companies",
                data: "{}",
                success: OnSuccessLoad_Companies,
                error: OnErrorLoad_Companies
            });
            return false;
        }

        function OnSuccessLoad_Companies(msg) {
            var data = msg.d;
            $("select[id$=ddlCompanyName_Client]> option").remove();
            
            for (var i = 0; i <= data.Companies.length - 1; i++) {

                $("select[id$='ddlCompanyName_Client']").append("<option value=" + data.Companies[i].comp_id + ">" + data.Companies[i].comp_name + "</option>");
                
            }
            $("select[id$='ddlCompanyName_Client']").prepend("<option></option>");
           
            
            $("select[id$='ddlCompanyName_Client']").val('');
            
            return false;
        }
        function OnErrorLoad_Companies() {
            alert("Error in loading companies!");
        }
        function OnChange_Country_Client() {
            var CountryId = $("select[id$='ddlCountry_Client'] option:selected").val().trim();
            $.ajax({
                type: "POST",
                dataType: "json",
                contentType: "application/json; charset=utf-8",
                url: "AddSalesVisits.aspx/LoadCity_Client",
                data: "{'countryid':'" + CountryId + "'}",
                success: OnSuccessCity_Client,
                error: OnErrorCity_Client
            });
            return false;
        }

        function OnSuccessCity_Client(msg) {
            var data = msg.d;

            $("select[id$=ddlCity_Client]> option").remove();
            for (var i = 0; i <= data.City_Client.length - 1; i++) {

                $("select[id$='ddlCity_Client']").append("<option value=" + data.City_Client[i].city_id + ">" + data.City_Client[i].city_name + "</option>");
            }
            $("select[id$='ddlCity_Client']").prepend("<option></option>");
            return false;
        }

        function OnErrorCity_Client() {
            alert("Error in Loading Cities (Client)");
        }

    function GetDateDifferance()
    {

        var CompCreatedDate = $("input[id$='txtCreatedDate']").val();
        var CurrDate = $("input[id$='txtCurrDate']").val();
        var one_day=1000*60*60*24; 
        var AddCompDate = new Date(CompCreatedDate);
        var CurrentDate = new Date(CurrDate);
        var _DateDifference = Math.ceil((CurrentDate.getTime()-AddCompDate.getTime())/(one_day));
        var PlanDays = $("input[id$='txtPlanDays']").val();
        if(PlanDays!=0)
        {
            if(_DateDifference<parseInt(NoOFDays))
                {
                    alert("Sorry , you have not prospected this customer earlier.\n You are supposed to prospects the customer atleast " +PlanDays+ " days in advance.\n Thanks for making planned visits.\n but you can not add this visit before " +_DateDifference+" days!");
                    return false;
                }
        }
    }
  
    function PopulateCompanyDDL()
    {
        $.ajax({
        type: "POST",
        contentType:"application/json; charset=utf-8",
        url: "AddSalesVisits.aspx/PopulateComp", 
        data: "{}", 
        success:onsuccessPopulate,
        error:onErrorPopulate
        });
    return false;  
    }
    function onsuccessPopulate(msg)
    {
        var data = msg.d;
        $("select[id$='ddlCompany']> option").remove();
        for (var i = 0; i <= data.Company.length - 1; i++) 
            {
                $("select[id$='ddlCompany']").append("<option value=" + data.Company[i].comp_id + ">" + data.Company[i].comp_name + " </option>");
            }
            $("select[id$='ddlCompany']").prepend("<option></option>");
            $("select[id$='ddlCompany']").val('');
        return false;
    }
    function onErrorPopulate()
    {
        alert("Failed To Populate Company!");
        return false;
    }  
    
    function PopulateClient()
    {
        var CompanyID = $("select[id$='ddlCompany']").val();
        if(CompanyID == "")
        {
            $("select[id$='ddlClient']> option").remove();
            return false;
        }
        GetCompanyCreated();
        if (CompanyID != "")
        {
         $.ajax({
            type: "POST",
            contentType:"application/json; charset=utf-8",
            url: "AddSalesVisits.aspx/PopClient", 
            data: "{'CompanyID':'"+CompanyID+"'}", 
            async:false,
            success:onsuccessPopulateClient,
            error:onErrorPopulateClient 
            });
        }
        return false; 
     }
     
     function onsuccessPopulateClient(msg)
     {
            var data = msg.d;
            $("select[id$='ddlClient']> option").remove();
            for (var i = 0; i <= data.Clients.length - 1; i++) 
                {
                    $("select[id$='ddlClient']").append("<option value=" + data.Clients[i].client_id + ">" + data.Clients[i].client_name + " </option>");
                }
                $("select[id$='ddlClient']").prepend("<option></option>");
                $("select[id$='ddlClient']").val('');
                GetCompanyCreated();
                var ComID = $("select[id$='ddlCompany']").val();
                $("select[id$='ddlSelCompany']").val(ComID);
            return false;
     }
     function onErrorPopulateClient ()
     {
        alert("Failed To Populate Related Clients!");
        return false;
     }
     function GetCompanyCreated()
     {
        var CompanyID = $("select[id$='ddlCompany']").val();
        if (CompanyID != "" || CompanyID != undefined)
        {
            $.ajax({
            type: "POST",
            contentType:"application/json; charset=utf-8",
            url: "AddSalesVisits.aspx/CompCreated", 
            data: "{'CompanyID':'"+CompanyID+"'}", 
            async:false,
            success:onsuccessGetCompCreated,
            error:onErrorGetCompCreated 
            });
        }
        return false;
     }
     function onsuccessGetCompCreated(msg)
     {
        var data = msg.d;
        $("input[id$='txtCreatedDate']").val(data);
     } 
     function onErrorGetCompCreated()
     {
        alert("Error In Checking Company Created Date!");
        return false;
     }
     function AddExc()
     {
        var MainCompID = $("select[id$='ddlCompany']").val();
        if (MainCompID == "")
        {
            $("select[id$='ddlSelCompany']").val('');
        }
        var CompID = $("select[id$='ddlSelCompany']").val();
        if(CompID == "")
        {
            alert("Please Select Company From Main Page!");
            return false;
        }
        return CheckExcuse();
        var Subject = $("input[id$='txtSubject']").val();
        if (Subject == "")
        {
            alert("Please Write Down Subject!");
            return false;
        }
        var Details = $("textarea[id$='txtDetails']").val();
        if (Details == "")
        {
            alert("Please Enter Excuse Details!");
            return false;    
        }
        $.ajax({
            type: "POST",
            contentType:"application/json; charset=utf-8",
            url: "AddSalesVisits.aspx/AddExcuse", 
            data: "{'CompID':'"+CompID+"','Subject':'"+Subject+"','Details':'"+Details+"'}", 
            async:false,
            success:onsuccessAddExc,
            error:oneErrorAddExc 
            });
        return false;
     }
     function onsuccessAddExc()
     {
        alert("Excuse Added Successfully!");
        ClearPop();
        return false;
     }
     function oneErrorAddExc()
     {
        alert("Error In Adding Excuse!");
        return false;
     }
     function CatDDL()
     {
         $.ajax({
            type: "POST",
            contentType:"application/json; charset=utf-8",
            url: "AddSalesVisits.aspx/PopulateCat", 
            data: "{}", 
            success:onsuccessCatDDL,
            error:oneErrorCatDDL 
            });
        return false; 
     } 
     function onsuccessCatDDL(msg)
     {
        var data = msg.d;
        $("select[id$='ddlCategory']> option").remove();
        for (var i = 0; i <= data.Category.length - 1; i++) 
            {
                $("select[id$='ddlCategory']").append("<option value=" + data.Category[i].cat_id + ">" + data.Category[i].cat_name + " </option>");
            }
            $("select[id$='ddlCategory']").prepend("<option></option>");
            $("select[id$='ddlCategory']").val('');
        return false;
     }
     function oneErrorCatDDL()
     {
        alert("Failed To Populate Category!");
        return false;
     }
     function ItemDDL()
     {
        var CatID = $("select[id$='ddlCategory']").val();
        if(CatID == "")
        {
            $("select[id$='ddlItem']> option").remove();
            return false;
        }
        if (CatID != "")
        {
         $.ajax({
            type: "POST",
            contentType:"application/json; charset=utf-8",
            url: "AddSalesVisits.aspx/PopulateItems", 
            data: "{'CatID':'"+CatID+"'}", 
            async:false,
            success:onsuccessItemDDL,
            error:oneErrorItemDDL 
            });
        }
        return false; 
     }
     function onsuccessItemDDL(msg)
     {
            var data = msg.d;
            $("select[id$='ddlItem']> option").remove();
            for (var i = 0; i <= data.Items.length - 1; i++) 
                {
                    $("select[id$='ddlItem']").append("<option value=" + data.Items[i].item_id + ">" + data.Items[i].item_name + " </option>");
                }
                $("select[id$='ddlItem']").prepend("<option></option>");
                $("select[id$='ddlItem']").val('');
               
            return false;
     }
     function oneErrorItemDDL()
     {
        alert("Failed To Populate Related Items!");
        return false;
     }
     
     function ClientResDDL()
     {
         $.ajax({
            type: "POST",
            contentType:"application/json; charset=utf-8",
            url: "AddSalesVisits.aspx/PopulateResponse", 
            data: "{}", 
            success:onsuccessClientResDDL,
            error:oneErrorClientResDDL 
            });
        return false; 
     } 
     function onsuccessClientResDDL(msg)
     {
        var data = msg.d;
        $("select[id$='ddlClientRes']> option").remove();
        for (var i = 0; i <= data.Response.length - 1; i++) 
            {
                $("select[id$='ddlClientRes']").append("<option value=" + data.Response[i].response_id + ">" + data.Response[i].response_name + " </option>");
            }
            $("select[id$='ddlClientRes']").prepend("<option></option>");
            $("select[id$='ddlClientRes']").val('');
        return false;
     }
     function oneErrorClientResDDL()
     {
        alert("Failed To Populate Category!");
        return false;
     }
     
     function CallDLL()
     {
         $.ajax({
            type: "POST",
            contentType:"application/json; charset=utf-8",
            url: "AddSalesVisits.aspx/PopulateCall", 
            data: "{}", 
            success:onsuccessCallDLL,
            error:oneErrorCallDLL 
            });
        return false; 
     } 
     function onsuccessCallDLL(msg)
     {
        var data = msg.d;
        $("select[id$='ddlCallType']> option").remove();
        for (var i = 0; i <= data.Call.length - 1; i++) 
            {
                $("select[id$='ddlCallType']").append("<option value=" + data.Call[i].tt_id + ">" + data.Call[i].tt_name + " </option>");
            }
            $("select[id$='ddlCallType']").prepend("<option></option>");
            $("select[id$='ddlCallType']").val('');
        return false;
     }
     function oneErrorCallDLL()
     {
        alert("Failed To Populate Category!");
        return false;
     }
     function AddVisit()
     {
        var CompID = $("select[id$='ddlCompany']").val();
        if (CompID == "")
        {
            alert("Please Select Desired Company!");
            return false;
        }
        var ClientID = $("select[id$='ddlClient']").val();
        if (ClientID == "")
        {
            alert("Please Select Client!");
            return false;
        }
        
        var CallType = $("select[id$='ddlCallType']").val();
        if (CallType == "")
        {
            alert("Please Select Call Type!");
            return false;
        }
        var SaleAmt = $("input[id$='txtTotalSaleAmt']").val();
        var ClientRes = $("select[id$='ddlClientRes']").val();
        if (ClientRes == "")
        {
            alert("Please Select Client Response!");
            return false;
        }
        var RemindDate = $("input[id$='txtRemindDate']").val();
        if (RemindDate == "")
        {
            alert("Please Enter Reminder Date!");
            return false;
        }
        var Remarks = $("textarea[id$='txtRemarks']").val(); 
        if (Remarks == "")
        {
            alert("Please Enter Remarks!");
            return false;
        }
        if (confirm("Please Check All Fields Before Adding Visit!"))
        {
            $.ajax({
                type: "POST",
                contentType:"application/json; charset=utf-8",
                url: "AddSalesVisits.aspx/AddVisit", 
                data: "{'ClientID':'"+ClientID+"','CallType':'"+CallType+"','SaleAmt':'"+SaleAmt+"','ClientRes':'"+ClientRes+"','RemindDate':'"+RemindDate+"','Remarks':'"+Remarks+"'}",
                async:false, 
                success:onsuccessAddvisit,
                error:onErrorAddvisit 
                });
           return false;
       }
       else
       {
            return false;
       }
     }
     function onsuccessAddvisit()
     {
        alert("Visit Successfully Added!"); 
        SendEmail();
        GetTodaysVisits();
        ClearFields();
        return false;
     }
     function onErrorAddvisit()
     {
        alert("Error In Saving Record!"); 
        return false;
     }
     function ClosePopUp() {
        $("#divAddExcuse").jqmHide();
        return false;
        }
     function CloseTodayVisits() {
        $("#divTodayVisits").jqmHide();
        return false;
        }
     function AddExcuse() {
        $('#divAddExcuse').jqm({ modal: true, overlay: 75, trigger: false });
        $('#divAddExcuse').jqmShow();
        return false;
     }
     function TodayVisit() {
        $('#divTodayVisits').jqm({ modal: true, overlay: 75, trigger: false });
        $('#divTodayVisits').jqmShow();
        return false;
     }
     
     function LoadMonSale()
     {
            $.ajax({
            type: "POST",
            contentType:"application/json; charset=utf-8",
            url: "AddSalesVisits.aspx/GetMonthSal", 
            data: "{}", 
            success:onsuccessLoadMonSale,
            error:onErrorLoadMonSale 
            });
        return false;    
     }
     
     function onsuccessLoadMonSale(msg)
     {
        var data = msg.d;
        $("span[id$='lblMonSaleToDate']").text(data);
        return false;
     }
     
     function onErrorLoadMonSale()
     {
        alert("Error In Loading This Month's Sales!");
        return false;
     } 
     function LoadTotalSale()
     {
            $.ajax({
            type: "POST",
            contentType:"application/json; charset=utf-8",
            url: "AddSalesVisits.aspx/GetTotalSal", 
            data: "{}", 
            success:onsuccessLoadTotalSale,
            error:onErrorLoadTotalSale 
            });
        return false;    
     }
     
     function onsuccessLoadTotalSale(msg)
     {
        var data = msg.d;
        $("span[id$='lblTotalSalAmt']").text(data);
        return false;
     }
     
     function onErrorLoadTotalSale()
     {
        alert("Error In Loading Total Sales!");
        return false;
     } 
     
     function keyRestrict(e, validchars, casesensitives, onceevery, onceoneof)
     {

        onceevery = onceevery ? onceevery : "";
        onceoneof = onceoneof ? onceoneof : "";
        
        if (!validchars)
        return true;
        var key='', keychar='', obj='', i = 0;
        var key = e.which ? e.which : window.event.keyCode;
        var obj = e.target ? e.target : window.event.srcElement;
        if (key == null)
         return true;
        keychar = String.fromCharCode(key);
        validchars = (validchars + onceevery + onceoneof);
        if (!casesensitives) 
        {
        keychar = keychar.toLowerCase();
        validchars = validchars.toLowerCase();
        onceevery =onceevery.toLowerCase();
        onceoneof = onceoneof.toLowerCase();
        }
        for (i=0; i<(onceevery + onceoneof).length; i++) 
        {
            if (i < onceevery.length) 
            {
            if (obj.value.indexOf(onceevery.charAt(i)) != -1 && keychar == onceevery.charAt(i))
            return false;
            }
            else 
            {
             if (obj.value.indexOf(onceoneof.charAt(i-onceevery.length)) != -1 && onceoneof.indexOf(keychar) != -1)
             return false;
            }
        }
     
        if (validchars.indexOf(keychar) != -1)
        return true;
        
        if ( key==null || key==0 || key==8 || key==9 || key==13 || key==27 )
        return true;
        return false;
    }
    function ClearFields()
    {
        $("select[id$='ddlCompany']").val('');
        $("select[id$='ddlClient']").val('');
        $("input[id$='txtCreatedDate']").val('');
        $("select[id$='ddlCallType']").val('');
        $("select[id$='ddlClientRes']").val('');
        $("input[id$='txtRemindDate']").val('');
        $("textarea[id$='txtRemarks']").val('');
        return false;
    }
    function ClearPop()
    {
        $("input[id$='txtSubject']").val('');
        $("textarea[id$='txtDetails']").val('');
        return false;
    }
    function CheckExcuse()
    {
        var CompID = $("select[id$='ddlSelCompany']").val();
        if (CompID != "")
        {
            $.ajax({
            type: "POST",
            contentType:"application/json; charset=utf-8",
            url: "AddSalesVisits.aspx/GetCheckExcuse", 
            data: "{'CompID':'"+CompID+"'}", 
            async:false,
            success:onsuccessCheckExcuse,
            error:onErrorCheckExcuse
            });
        return false;  
        } 
        return false;
    }
    function onsuccessCheckExcuse(msg)
    {
        var data = msg.d;
        if (data == 1)
        {
            alert("Excuse Already Added Against This Company Today!");
            ClearPop();
            return false;
        }
        return false;
    } 
    function onErrorCheckExcuse()
    {
         alert("Error In Checking Excuse For This Company!");
         return false;   
    }
    function GetTodaysVisits()
    {
         $.ajax({
            type: "POST",
            contentType:"application/json; charset=utf-8",
            url: "AddSalesVisits.aspx/GetTodaysVisit", 
            data: "{}", 
            async:false,
            success:onsuccessGetTodaysVisits,
            error:onErrorGetTodaysVisits 
            });
        return false;   
    }
    function onsuccessGetTodaysVisits(msg)
    {
        var data = msg.d;
        if(oTable !=null)
                    {
                      oTable.fnClearTable();
                      oTable.fnDestroy();
                    }
        var tbl = "";  
        tbl += "<thead>";
                tbl += "<tr>";
                tbl += "<th style='white-space:nowrap; text-align:left;'>Visit Date</th>";
                tbl += "<th style='white-space:nowrap; text-align:left;'>Company Name</th>";
                tbl += "<th style='white-space:nowrap; text-align:left;'>Client Name</th>";
                tbl += "<th style='white-space:nowrap; text-align:left;'>Call Type</th>";
                tbl += "<th style='white-space:nowrap; text-align:left;'>Total Sale</th>";
                tbl += "<th style='white-space:nowrap; text-align:left;'>Client Response</th>";
                tbl += "<th style='white-space:nowrap; text-align:left;'>Employee Name</th>";
                tbl += "<th style='white-space:nowrap; text-align:left;'>IP Address</th>";
                tbl += "</tr>";
                tbl += "</thead>";
                tbl += "<tbody>";
                for (var i = 0; i < data.VisitsToday.length; i++) {  
                            tbl += "<tr  id='rowmain"+i+"'>";             
                            tbl += "<td style='text-align:right; white-space:nowrap;' id='txtCompID"+i+"'>" + data.VisitsToday[i].Visit_Date + "</td>";
                            tbl += "<td style='text-align:left; white-space:nowrap;' id='txtCompName"+i+"'>" + data.VisitsToday[i].CompName + "</td>";   
                            tbl += "<td style='text-align:left; white-space:nowrap;' id='txtClientName"+i+"'>" + data.VisitsToday[i].ClientName + "</td>";                  
                            tbl += "<td style='text-align:right; white-space:nowrap;' id='txtCallType"+i+"'>" + data.VisitsToday[i].TypeName + " </td>";
                            tbl += "<td style='text-align:right; white-space:nowrap;' id='txtTotSale"+i+"'>" + data.VisitsToday[i].TotalSale + " </td>";
                            tbl += "<td style='text-align:left;' id='txtClientRes"+i+"'>" +  data.VisitsToday[i].ClientRes + " </td>";
                            tbl += "<td style='text-align:left;' id='txtEmpName"+i+"'>" +  data.VisitsToday[i].EName + " </td>";  
                            tbl += "<td style='text-align:left; white-space:nowrap;' id='txtIPAdd"+i+"'>" + data.VisitsToday[i].IPAddress + " </td>";
                      tbl += "</tr>";
                }   

                tbl += "</tbody>";
                tbl += "</table>";
                $("#tblTodayVisits").html(tbl);
                dataTable();
                return false; 
    }
    function onErrorGetTodaysVisits()
    {
        alert("Error In Loading Details!");
        return false;
    }
    
        //------------------------------------------Get All Visits----------------------------------------------------------------------------

    function GetAllVisits() {
        $.ajax({
            type: "POST",
            contentType: "application/json; charset=utf-8",
            url: "AddSalesVisits.aspx/GetAllVisit",
            data: "{}",
            async: false,
            success: onsuccessGetAllVisits,
            error: onErrorGetAllVisits
        });
        return false;
    }
    function onsuccessGetAllVisits(msg) {
        var data = msg.d;
        if (oTable1 != null) {
            oTable1.fnClearTable();
            oTable1.fnDestroy();
        }
        var tbl = "";
        tbl += "<thead>";
        tbl += "<tr>";
        tbl += "<th style='white-space:nowrap; text-align:left;'>Visit Date</th>";
        tbl += "<th style='white-space:nowrap; text-align:left;'>Company Name</th>";
        tbl += "<th style='white-space:nowrap; text-align:left;'>Client Name</th>";
        tbl += "<th style='white-space:nowrap; text-align:left;'>Call Type</th>";
        tbl += "<th style='white-space:nowrap; text-align:left;'>Total Sale</th>";
        tbl += "<th style='white-space:nowrap; text-align:left;'>Client Response</th>";
        tbl += "<th style='white-space:nowrap; text-align:left;'>Remarks</th>";
        tbl += "<th style='white-space:nowrap; text-align:left;'>Employee Name</th>";
        
        tbl += "</tr>";
        tbl += "</thead>";
        tbl += "<tbody>";
        for (var i = 0; i < data.AllVisits.length; i++) {
            tbl += "<tr  id='rowmain" + i + "'>";
            tbl += "<td style='text-align:right; white-space:nowrap;' id='txtCompID" + i + "'>" + data.AllVisits[i].Visit_Date + "</td>";
            tbl += "<td style='text-align:left; white-space:nowrap;' id='txtCompName" + i + "'>" + data.AllVisits[i].CompName + "</td>";
            tbl += "<td style='text-align:left; white-space:nowrap;' id='txtClientName" + i + "'>" + data.AllVisits[i].ClientName + "</td>";
            tbl += "<td style='text-align:right; white-space:nowrap;' id='txtCallType" + i + "'>" + data.AllVisits[i].TypeName + " </td>";
            tbl += "<td style='text-align:right; white-space:nowrap;' id='txtTotSale" + i + "'>" + data.AllVisits[i].TotalSale + " </td>";
            tbl += "<td style='text-align:left;' id='txtClientRes" + i + "'>" + data.AllVisits[i].ClientRes + " </td>";
            tbl += "<td style='text-align:left;' id='txtIPAdd" + i + "'>" + data.AllVisits[i].remarks + " </td>";
            tbl += "<td style='text-align:left;' id='txtEmpName" + i + "'>" + data.AllVisits[i].EName + " </td>";
          
            tbl += "</tr>";
        }

        tbl += "</tbody>";
        tbl += "</table>";
        $("#tblAllvisits").html(tbl);
        dataTableForAllVisits();
        return false;
    }
    function onErrorGetAllVisits() {
        alert("Error In Loading Details!");
        return false;
    }

        //------------------------------------------End All Visits-----------------------------------------------------------------------------


    function AddSalesItem()
    {
        var CatID = $("select[id$='ddlCategory']").val();
        if (CatID == "")
        {
            alert("Please Select Category!");
            return false;
        }
        var ItemID = $("select[id$='ddlItem']").val();
        if (ItemID == "")
        {
            alert("Please Select Item!");
            return false;
        }
        var SaleAmt = $("input[id$='txtSales']").val();
        if (SaleAmt == "")
        {
            alert("Please Enter Amount!");
            return false;
        } 
        var Amount = 0;
        Amount = $("input[id$='txtTotalSaleAmt']").val();
        Amount = parseInt(SaleAmt)+parseInt(Amount);
        $("input[id$='txtTotalSaleAmt']").val(Amount);
        $("select[id$='ddlCategory']").val('');
        $("select[id$='ddlItem']").val('');
        $("input[id$='txtSales']").val('');
        return false;
    }

    function ClearItems()
    {
        $("select[id$='ddlCategory']").val('');
        $("select[id$='ddlItem']").val('');
        $("input[id$='txtSales']").val('');
        return false;
    }
    
    function CheckCompBooked()
    {
        var CompID = $("select[id$='ddlCompany']").val();
        if (CompID == "")
        {
            return false;
        }
        else
        {
            $.ajax({
                    type: "POST",
                    contentType:"application/json; charset=utf-8",
                    url: "AddSalesVisits.aspx/GetBookedComp", 
                    data: "{'CompID':'"+CompID+"'}", 
                    async:false,
                    success:onsuccessCompBooked,
                    error:onErrorCompBooked
                    });
            return false;    
        }
    }
    function onsuccessCompBooked(msg)
    {
        var data = msg.d;
        if (data == "1")
        {
            alert("Company Already Booked!");
            return false;
        }
        return CheckAlreadyEntered();
    }
    function onErrorCompBooked()
    {
        alert("Error In Checking Comapany!");
        return false;
    }
    function CheckAlreadyEntered()
    {
        var CompID = $("select[id$='ddlCompany']").val();
        if (CompID == "")
        {
            return false;
        }
        else
        {
            $.ajax({
                    type: "POST",
                    contentType:"application/json; charset=utf-8",
                    url: "AddSalesVisits.aspx/CheckEntered", 
                    data: "{'CompID':'"+CompID+"'}", 
                    async:false,
                    success:onsuccessCheckEntered,
                    error:onErrorCheckEntered
                    });
                return false;
        }
    }
    function onsuccessCheckEntered(msg)
    {
        var data = msg.d;
        if (data == "1")
        {
            alert("Company Already Entered!");
            return false;
        }
        return AddVisit();
    }
    function onErrorCheckEntered()
    {
        alert("Error In Checking Comapany!");
        return false;
    }
    
    function textCounter(field, countfield, maxlimit) {
        if (field.value.length > maxlimit) {
            field.value = field.value.substring(0, maxlimit);
            return false;
        }
        else {
            countfield.value = maxlimit - field.value.length;
        }
    }
    function SendEmail()
    {
        var CompName = $("select[id$='ddlCompany'] option:selected").text();
        var ClientName = $("select[id$='ddlClient'] option:selected").text();
        var CallType = $("select[id$='ddlCallType'] option:selected").text();
        var ClientResponse = $("select[id$='ddlClientRes'] option:selected").text();
        var TotalAmt = $("input[id$='txtTotalSaleAmt']").val();
        var Remarks = $("textarea[id$='txtRemarks']").val(); 
        $.ajax({
                    type: "POST",
                    contentType:"application/json; charset=utf-8",
                    url: "AddSalesVisits.aspx/SendEmail", 
                    data: "{'CompName':'"+CompName+"','ClientName':'"+ClientName+"','CallType':'"+CallType+"','ClientResponse':'"+ClientResponse+"','TotalAmt':'"+TotalAmt+"','Remarks':'"+Remarks+"'}", 
                    async:false,
                    success:onsuccessSendEmail,
                    error:onErrorSendEmail
                    });
                return false;
    }
    function onsuccessSendEmail()
    {
        alert("E-Mail Send Successfully!");
        return false;
    }
    function onErrorSendEmail()
    {
        alert("Error In Sending E-Mail!");
        return false;
    }
    </script>

</asp:Content>

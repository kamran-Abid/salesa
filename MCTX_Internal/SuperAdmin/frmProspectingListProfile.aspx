<%@ Page Language="C#" MasterPageFile="~/MCTX_Internal/SuperAdmin/MasterAdmin.master"
    AutoEventWireup="true" CodeFile="frmProspectingListProfile.aspx.cs" Inherits="MCTX_Internal_SuperAdmin_frmProspectingList"
    Title="Prospecting List" %>

<%@ Register Assembly="RJS.Web.WebControl.PopCalendar.Net.2008" Namespace="RJS.Web.WebControl"
    TagPrefix="rjs" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <script src="../../js/jquery.dataTables.min.js" type="text/javascript"></script>

    <script src="../../js/BlockUI.js" type="text/javascript"></script>

    <script src="../../js/jquery.fixedheader.js" type="text/javascript"></script>

    <script src="../../js/jqModal.js" type="text/javascript"></script>

    <link href="../../css1/jqModal.css" rel="stylesheet" type="text/css" />
    <!--[if lt IE 8]>
      .CloseButton
        {
         margin-left:900px;
        }
    <![endif]-->
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
    <div id="tabs">
        <ul>
            <li style="text-align: left"><a href="#tabs-1">Prospecting List</a></li>
        </ul>
        <table width="100%">
            <tr>
                <td style="text-align: right">
                    <asp:LinkButton ID="lnkb_toggleDiv" Style="text-decoration: underline;" runat="server"
                        Text="Add Company/Client" OnClientClick="return AddNewClientorCompany();" />
                </td>
            </tr>
        </table>
        <div id="divAddClient_Prospecting" class="jqmWindow" style="display: none; width: 900px;
            height: 400px; left: 40%; top: 25%;">
            <table style="width: 100%">
                <tr>
                    <td style="text-align: right">
                        <div id="close">
                            <img src='image/btn_close02.png' style="background: none repeat scroll 0 0 transparent;
                                border: medium none; height: 32px; margin-top: -30px; position: absolute; width: 32px;
                                cursor: pointer;" alt="Close" onclick='return ClosePopUp();' />
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
                                        <asp:TextBox onkeypress="return keyRestrict(event,',-_&/. 0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ')"
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
                                        <asp:TextBox ID="txtEmail" onkeypress="return keyRestrict(event,'@_1234567890-.abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ')"
                                            MaxLength="40" runat="server"></asp:TextBox>
                                    </td>
                                    <td>
                                        <asp:Label ID="lblWeb" Text="Web Address:" runat="server"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtWeb" MaxLength="40" onkeypress="return keyRestrict(event,'/-.0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ')"
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
                                        <asp:TextBox ID="txtPhone" onkeypress="return keyRestrict(event,'-.+0123456789')"
                                            MaxLength="16" runat="server"></asp:TextBox>
                                    </td>
                                    <td>
                                        <asp:Label ID="lblCategory" Text="Category:" runat="server"></asp:Label>
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
                                        <asp:TextBox ID="txtAddress" MaxLength="200" TextMode="MultiLine" onkeypress="textCounter(this,this.form.counter,200);return keyRestrict(event,'~@/\_:#,-&. 0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ');"
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
                                        <asp:Button ID="btnClear" Text="Clear" Width="75px" BackColor="#ABD3FC" OnClientClick="return Clear();"
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
                                        <asp:TextBox onkeypress="return keyRestrict(event,',/\-_&. 0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ')"
                                            ID="txtClientName_Client" MaxLength="40" runat="server" />
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <span>Department:</span>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtDept_Client" onkeypress="return keyRestrict(event,',_-/&. 0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ')"
                                            MaxLength="40" runat="server" />
                                    </td>
                                    <td>
                                        <span>Designation:</span>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtDesg_Client" onkeypress="return keyRestrict(event,',-_/&. 0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ')"
                                            MaxLength="40" runat="server" />
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <span>Mobile No:</span>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtMobileNo_Client" onkeypress="return keyRestrict(event,'-.+0123456789')"
                                            MaxLength="16" runat="server" />
                                    </td>
                                    <td>
                                        <span>E-mail:</span>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtEmail_Client" onkeypress="return keyRestrict(event,'@_1234567890-.abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ')"
                                            runat="server" MaxLength="40" />
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <span>Phone:</span>
                                    </td>
                                    <td>
                                        <asp:TextBox onkeypress="return keyRestrict(event,'-.+0123456789')" ID="txtPhone_Client"
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
                                        <asp:TextBox ID="txtAddress_Client" onkeypress="textCounter(this,this.form.counter_ClientAddress,200);return keyRestrict(event,'~@/\:#,-&. 0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ')"
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
        <table style="width: 99%">
            <tr>
                <td>
                    <fieldset style="border: 1px solid #ABD3FC">
                        <legend>Prospecting Information</legend>
                        <table width="100%">
                            <tr>
                                <td>
                                    <span>Company Name:</span>
                                </td>
                                <td>
                                    <asp:DropDownList ID="ddlCompanyName_Prospecting" runat="server" OnChange="return OnChange_CompanyList_Prospecting();" />
                                </td>
                                <td>
                                    <span>Client Name:</span>
                                </td>
                                <td>
                                    <asp:DropDownList ID="ddlClientName_Prospecting" runat="server" />
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <span>Product Category:</span>
                                </td>
                                <td>
                                    <asp:DropDownList ID="ddlCategory" OnChange="return GetCategory_Products_DDL();"
                                        runat="server" />
                                </td>
                                <td>
                                    <span>Target Product:</span>
                                </td>
                                <td>
                                    <asp:DropDownList ID="txtTargetProduct_Prospecting" runat="server" />
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <span>Booking Date:</span>
                                </td>
                                <td>
                                    <asp:TextBox ID="txtBookingDate_Prospecting" runat="server" />
                                    <rjs:PopCalendar ID="PopCalendar2" Separator="/" Format="mm dd yyyy" Control="txtBookingDate_Prospecting"
                                        runat="server" />
                                </td>
                                <td visible="false">
                                    <span>Reserverd Date:</span>
                                </td>
                                <td>
                                    <asp:TextBox ID="txtReservedDate_Prospecting" runat="server" />
                                    <rjs:PopCalendar ID="PopCalendar3" Separator="/" Format="mm dd yyyy" Control="txtReservedDate_Prospecting"
                                        runat="server" />
                                    <asp:TextBox Visible="false" ID="txtReservedDays_Prospecting" runat="server" />
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
                                    <asp:Button ID="btnAddProspecting" runat="server" Width="75px" BackColor="#ABD3FC"
                                        OnClientClick="return Add_Prospecting();" Text="Save" />
                                    <asp:Button ID="btnClear_Prospect" runat="server" Width="75px" BackColor="#ABD3FC"
                                        OnClientClick="return Clear_Prospect();" Text="Clear" />
                                </td>
                            </tr>
                        </table>
                    </fieldset>
                </td>
            </tr>
            <tr>
                <td>
                    <table width="100%">
                        <tr>
                            <td>
                                <fieldset style="border: 1px solid #ABD3FC">
                                    <legend>Search Prospects: </legend>
                                    <table align="center" style="width: 100%">
                                        <tr>
                                            <td style="text-align: right">
                                                <span>From Date: </span>
                                            </td>
                                            <td>
                                                <asp:TextBox ID="txtFromDate" runat="server"></asp:TextBox><rjs:PopCalendar ID="rjsReportDate"
                                                    Separator="/" Format="mm dd yyyy" Control="txtFromDate" runat="server" />
                                            </td>
                                            <td>
                                                <span>To Date</span>
                                                <asp:TextBox ID="txtToDate" runat="server"></asp:TextBox><rjs:PopCalendar ID="PopCalendar1"
                                                    Separator="/" Format="mm dd yyyy" Control="txtToDate" runat="server" />
                                            </td>
                                            <td>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="text-align: right">
                                                <span>Employee: </span>
                                            </td>
                                            <td style="text-align: left">
                                                <asp:DropDownList ID="ddlEmployees" runat="server" />
                                            </td>
                                            <td style="text-align: center; padding-right: 78px;">
                                                <asp:Button ID="btnSearchDateWise" runat="server" Text="Search" OnClientClick="return GetProspects(); return false;"
                                                    Width="66px" BackColor="#ABD3FC" />
                                                <%--<asp:Button ID="btn_add" runat="server" Text="Add Propecting" Width="100px" OnClick="btn_add_Click"
                                                    BackColor="#ABD3FC" />--%>
                                            </td>
                                            <td>
                                            </td>
                                        </tr>
                                    </table>
                                </fieldset>
                                &nbsp;
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <div style="height: 480px; overflow: auto">
                                    <table id="tblProspecting" width="100%" class="dataTable">
                                    </table>
                                </div>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
    </div>

    <script language="javascript" type="text/javascript">
        var oTable;
        $(document).ajaxStart(blockUI).ajaxStop(unblockUI);

        function blockUI() {
            $.blockUI({ message: '<img src="image/ajax-loader.gif" />',
                css: { borderStyle: 'none', backgroundColor: "Transparent" }
            });
        }

        function unblockUI() {
            $.unblockUI();
        }
        $(document).ready(function() {
            //OpenDiv();
            GetProspects();
            Load_CategoriesDDL();
        });

        function dataTable() {
            oTable = $("#tblProspecting").dataTable({
                bPaginate: false,
                bJQueryUI: true,
                oLanguage: { "sSearch": "Filter: " }
            }).fixedHeader({ height: 400 })
        }
        //    ---------------------- Get & Search .... Prospects by Obaid on 24th April-----------------------------------------///
        function GetProspects() {

            var FromDate = $("input[id$='txtFromDate']").val().trim();
            var ToDate = $("input[id$='txtToDate']").val().trim();
            var EmployeeId = $("select[id$='ddlEmployees'] option:selected").val();
            $.ajax({
                type: "POST",
                dataType: "json",
                contentType: "application/json; charset=utf-8",
                url: "frmProspectingListProfile.aspx/GetProspects",
                data: "{'FromDate':'" + FromDate + "','ToDate':'" + ToDate + "','EmployeeId':'" + EmployeeId + "'}",
                success: OnSuccessProspects,
                error: OnErrorProspects
            });
            return false;
        }

        function OnSuccessProspects(msg) {

            if (oTable != null) {
                oTable.fnClearTable();
                oTable.fnDestroy();
            }
            var data = msg.d;
            var dyn_table = "";
            dyn_table += "<thead>";
            dyn_table += "<tr>";

            dyn_table += "<th style='font-weight: bold;cursor:Pointer;text-align:center;border:1px solid #999999'>S. #</th>";
            dyn_table += "<th style='font-weight: bold;cursor:Pointer;text-align:center;border:1px solid #999999'>Comapany Name</th>";
            dyn_table += "<th style='font-weight: bold;cursor:Pointer;text-align:center;border:1px solid #999999'>Client Name</th>";
            dyn_table += "<th style='font-weight: bold;cursor:Pointer;text-align:center;border:1px solid #999999'>Client Designation</th>";
            dyn_table += "<th style='font-weight: bold;cursor:Pointer;text-align:center;border:1px solid #999999'>Clinet Phone</th>";

            dyn_table += "<th style='font-weight: bold;cursor:Pointer;text-align:center;border:1px solid #999999'>Target Items</th>";
            dyn_table += "<th style='font-weight: bold;cursor:Pointer;text-align:center;border:1px solid #999999'>Booking date</th>";
            dyn_table += "<th style='font-weight: bold;cursor:Pointer;text-align:center;border:1px solid #999999'>Reserved Date</th>";
            dyn_table += "<th style='font-weight: bold;cursor:Pointer;text-align:center;border:1px solid #999999'>Visit Status</th>";
            dyn_table += "<th style='font-weight: bold;cursor:Pointer;text-align:center;border:1px solid #999999'>Created By</th>";
            dyn_table += "</tr>";
            dyn_table += "</thead>";
            dyn_table += "<tbody>";
            var j = 0;
            for (var i = 0; i < data.Prospects.length; i++) {
                j = i + 1;
                dyn_table += "<tr id='trmain" + i + "' style='cursor:default;border:1px solid #999999;padding: 3px 5px;margin: 0px;'>";
                dyn_table += "<td id='txtSNo" + i + "' align='right'  style='font-weight:bold;border:1px solid #999999;'>" + j + " </td>";
                dyn_table += "<td id='txtcomp_name" + i + "' align='right'  style='border:1px solid #999999;'>" + data.Prospects[i].comp_name + " </td>";
                dyn_table += "<td align='right' style='border:1px solid #999999'>" + data.Prospects[i].client_name + " </td>";
                dyn_table += "<td align='right' style='border:1px solid #999999;;padding: 3px 5px;margin: 0px;'>" + data.Prospects[i].client_designation + " </td>";
                dyn_table += "<td align='right' style='border:1px solid #999999;padding: 3px 5px;margin: 0px;'>" + data.Prospects[i].client_phone + " </td>";

                dyn_table += "<td id='txtTarget_products" + i + "'  style='border:1px solid #999999;padding: 3px 5px;margin: 0px;'>" + data.Prospects[i].Target_products + " </td>";
                dyn_table += "<td id='txtBookingdate" + i + "' style='border:1px solid #999999;padding: 3px 5px;margin: 0px;'>" + data.Prospects[i].Bookingdate + " </td>"; //gst per unit
                dyn_table += "<td id='txtreserverddate" + i + "' style='border:1px solid #999999;padding: 3px 5px;margin: 0px;'>" + data.Prospects[i].reserverddate + " </td>";
                dyn_table += "<td align='right' style='border:1px solid #999999;padding: 3px 5px;margin: 0px;'>" + data.Prospects[i].visit_status + " </td>";
                dyn_table += "<td id='txtE_Name" + i + "'style='border:1px solid #999999;padding: 3px 5px;margin: 0px;'>" + data.Prospects[i].E_Name + " </td>";
                dyn_table += "</tr>";
            }
            dyn_table += "</tbody></table>";
            $("#tblProspecting").html(dyn_table);
            //            dataTable();
        }

        function OnErrorProspects() {
            alert("Error in Loading Prospects!");
        }
        //-------------------------- End Get Prospects by Obaid on 24th April-----------------------------------------///

        //------------------------------Load and Bind Drop Downlists-------------------------------------//

        ///----------------------------------------------Load Company's Cities Drop down list----------------------------//

        function OnChange_Country_Company() {
            var CountryId = $("select[id$='ddlCountry_Company'] option:selected").val().trim();
            $.ajax({
                type: "POST",
                dataType: "json",
                contentType: "application/json; charset=utf-8",
                url: "frmProspectingListProfile.aspx/LoadCity_Company",
                data: "{'countryid':'" + CountryId + "'}",
                success: OnSuccessCity_Company,
                error: OnErrorCity_Company
            });
            return false;
        }

        function OnSuccessCity_Company(msg) {
            var Result = msg.d;
            $("select[id$=ddlCity_Company] > option").remove();
            for (var i = 0; i <= Result.City_Company.length - 1; i++) {
                $("select[id$='ddlCity_Company']").append("<option value=" + Result.City_Company[i].city_id + ">" + Result.City_Company[i].city_name + " </option>");
            }
            $("select[id$='ddlCity_Company']").prepend("<option></option>");
            //            $("select[id$='ddlCity_Company'] option:first").attr("selected", true);
            return false;
        }

        function OnErrorCity_Company() {
            alert("Error in Loading Cities (Company)")

        }
        ///----------------------------------------------Load Company's Cities Drop down list------------------------------------//
        function OnChange_Country_Client() {
            var CountryId = $("select[id$='ddlCountry_Client'] option:selected").val().trim();
            $.ajax({
                type: "POST",
                dataType: "json",
                contentType: "application/json; charset=utf-8",
                url: "frmProspectingListProfile.aspx/LoadCity_Client",
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

        //------------------------------------------------Load Company's respective Clients---------------------------------------//

        function OnChange_CompanyList_Prospecting() {
            var CompanyId = $("select[id$='ddlCompanyName_Prospecting'] option:selected").val().trim();
            $.ajax({
                type: "POST",
                dataType: "json",
                contentType: "application/json; charset=utf-8",
                url: "frmProspectingListProfile.aspx/LoadClients_Prospecting",
                data: "{'Comp_id':'" + CompanyId + "'}",
                success: OnSuccessCompanyList_Prospecting,
                error: OnErrorCompanyList_Prospecting
            });
            return false;
        }

        function OnSuccessCompanyList_Prospecting(msg) {
            var data = msg.d;
            $("select[id$=ddlClientName_Prospecting]> option").remove();
            for (var i = 0; i <= data.Client_List_Prospecting.length - 1; i++) {

                $("select[id$='ddlClientName_Prospecting']").append("<option value=" + data.Client_List_Prospecting[i].client_id + ">" + data.Client_List_Prospecting[i].client_name + "</option>");
            }
            $("select[id$='ddlClientName_Prospecting']").prepend("<option></option>");
            $("select[id$='ddlClientName_Prospecting']").val('');
            return false;
        }

        function OnErrorCompanyList_Prospecting() {
            alert("Error in Loading Clients");
        }

        //--------------------------------------------- Add Prospecting ---------------------------------------//

        function Add_Prospecting() {

            var CompanyId = $("select[id$='ddlCompanyName_Prospecting'] option:selected").val().trim();
            var ClientId = "";
            var Category = $("select[id$='ddlCategory'] option:selected").val().trim();
            var TargetProduct = "";
            var BookingDate = $("input[id$='txtBookingDate_Prospecting']").val();
            var ReserveDate = $("input[id$='txtReservedDate_Prospecting']").val();
            var Product_Id = "";

            if (CompanyId == "") {
                alert("Please select company name");
                return false;
            }
            if (CompanyId != "") {

                ClientId = $("select[id$='ddlClientName_Prospecting'] option:selected").val().trim();
            }
            else {
                alert("Please select client name");
                return false;
            }

            if (ClientId == "") {
                alert("Please select client name");
                return false;
            }

            if (Category == "") {
                alert("Please select product category");
                return false;
            }

            if (Category != "") {

                TargetProduct = $("select[id$='txtTargetProduct_Prospecting'] option:selected").text().trim();
                Product_Id = $("select[id$='txtTargetProduct_Prospecting'] option:selected").val().trim();
            }
            else {
                alert("Please select target product");
                return false;
            }

            if (TargetProduct == "") {
                alert("Please select target product");
                return false;
            }

            if (BookingDate == "") {
                alert("Please select booking date");
                return false;
            }
            if (ReserveDate == "") {
                alert("Please select reserve date");
                return false;
            }

            var startdate = $("input[id$='txtBookingDate_Prospecting']").val();
            var enddate = $("input[id$='txtReservedDate_Prospecting']").val();

            var d1 = Date.parse(startdate);
            var d2 = Date.parse(enddate);

            if (d1 > d2) {
                alert("Booking date must be earlier then reserved date!");
                return false;
            }


            $.ajax({
                type: "POST",
                dataType: "json",
                contentType: "application/json; charset=utf-8",
                url: "frmProspectingListProfile.aspx/Add_Prospecting",
                async: false,
                data: "{'comp_id':'" + CompanyId + "','client_id':'" + ClientId + "','Target_products':'" + TargetProduct + "','Booking_date':'" + BookingDate + "','Reserverd_date':'" + ReserveDate + "','Cat_Id':" + Category + ",'Product_Id':" + Product_Id + "}",
                success: OnSuccessAdd_Prospecting,
                error: OnErrorAdd_Prospecting
            });
            return false;
        }
        function OnSuccessAdd_Prospecting() {
            alert("New Prospect Added!");
            GetProspects();
            Clear_Prospect();
            return false;
        }
        function OnErrorAdd_Prospecting() {
            alert("Error in saving prospect, Login again and then add prospect!");
            return false;
        }
        function Clear_Prospect() {
            $("select[id$='ddlCompanyName_Prospecting']").val('');
            $("select[id$='ddlClientName_Prospecting']").val('');
            $("select[id$='txtTargetProduct_Prospecting']").val('');
            $("select[id$='ddlCategory']").val('');
            $("input[id$='txtBookingDate_Prospecting']").val('');
            $("input[id$='txtReservedDate_Prospecting']").val('');
            return false;
        }
        //--------------------------------------------End Prospecting info------------------------------------------//

        //---------------------------------------------  Add New Client Info -------------------------------------------//

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
                url: "frmProspectingListProfile.aspx/Add_ClientInfo",
                async: false,
                data: "{'client_name':'" + ClientName + "','client_address':'" + Address + "','client_dept':'" + Department + "','client_designation':'" + Designation + "','client_email':'" + Email + "','Client_mobile':'" + Mobile + "','client_phone':'" + Phone + "','city_id':'" + CityId + "','comp_id':'" + CompanyId + "'}",
                success: OnSuccessAdd_ClientInfo,
                error: OnErrorAdd_ClientInfo
            });
            return false;
        }
        function OnSuccessAdd_ClientInfo() {
            alert("New Client Saved!");
            $("select[id$=ddlClientName_Prospecting]> option").remove();
            $("select[id$='ddlCompanyName_Prospecting']").val('');
            GetProspects();
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
        //--------------------------------------------End Client info------------------------------------------//
        function OpenDiv() {
            $("#divAddClient_Prospecting").slideToggle();
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
                url: "frmProspectingListProfile.aspx/SaveCompanyInfo",
                async: false,
                data: "{'CompName':'" + CompName + "','CityID':'" + CityID + "','Email':'" + Email + "','WebAdd':'" + WebAdd + "','PhoneNum':'" + PhoneNum + "','TarProd':'" + TarProd + "','TarProdId':'" + TarProdId + "','Address':'" + Address + "','Cat_Id':'" + Category_Product + "'}",
                success: onsuccessSaveComp,
                error: onErrorSaveComp
            });
            return false;
        }
        function onsuccessSaveComp() {
            alert("New company added!");
            //ClosePopUp();
            Load_Companies();
            Clear();
            return false;
        }
        function onErrorSaveComp() {
            alert("Error In Saving Record!");
            return false;
        }
        function Clear() {
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

        //-----------------------------------------Modal popup on may 03, 2012 by Obaid Altaf---------------------------------------------//
        function ClosePopUp() {
            $("#divAddClient_Prospecting").jqmHide();
            //            Load_Companies();
            return false;
            //GetApps();
        }
        function AddNewClientorCompany() {

            $('#divAddClient_Prospecting').jqm({ modal: true, overlay: 75, trigger: false });
            $('#divAddClient_Prospecting').jqmShow();
            //clear();
            return false;
        }

        var ba = $.browser;
        if (ba.msie) {
            $("#close").css('margin-left', '900px');
        }

        //------------------------------------------------Load Companies on two DDL's ;)--- by Obaid Altaf------------------------------------//

        function Load_Companies() {
            $.ajax({
                type: "POST",
                dataType: "json",
                contentType: "application/json; charset=utf-8",
                url: "frmProspectingListProfile.aspx/Load_Companies",
                data: "{}",
                success: OnSuccessLoad_Companies,
                error: OnErrorLoad_Companies
            });
            return false;
        }

        function OnSuccessLoad_Companies(msg) {
            var data = msg.d;
            $("select[id$=ddlCompanyName_Client]> option").remove();
            $("select[id$=ddlCompanyName_Prospecting]> option").remove();
            for (var i = 0; i <= data.Companies.length - 1; i++) {

                $("select[id$='ddlCompanyName_Client']").append("<option value=" + data.Companies[i].comp_id + ">" + data.Companies[i].comp_name + "</option>");
                $("select[id$='ddlCompanyName_Prospecting']").append("<option value=" + data.Companies[i].comp_id + ">" + data.Companies[i].comp_name + "</option>");
            }
            $("select[id$='ddlCompanyName_Client']").prepend("<option></option>");
            $("select[id$='ddlCompanyName_Prospecting']").prepend("<option></option>");

            $("select[id$='ddlCompanyName_Client']").val('');
            $("select[id$='ddlCompanyName_Prospecting']").val('');
            return false;
        }
        function OnErrorLoad_Companies() {
            alert("Error in loading companies!");
        }
        //--------------------------------------------------------------text are counter--------------------------//
        function textCounter(field, countfield, maxlimit) {
            if (field.value.length > maxlimit) {
                field.value = field.value.substring(0, maxlimit);
                return false;
            }
            else {
                countfield.value = maxlimit - field.value.length;
            }
        }

        //------------------------------------------------Load Categories ;)--- by Obaid Altaf------------------------------------//

        function Load_CategoriesDDL() {
            $.ajax({
                type: "POST",
                dataType: "json",
                contentType: "application/json; charset=utf-8",
                url: "frmProspectingListProfile.aspx/Load_CategoriesDDL",
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
        //------------------------------------------------Load Products against Category ;)--- by Obaid Altaf------------------------------------//

        function GetCategory_Products_DDL() {
            var Cat_id = 0;
            Cat_id = $("select[id$='ddlCategory']").val().trim();

            $.ajax({
                type: "POST",
                dataType: "json",
                contentType: "application/json; charset=utf-8",
                url: "frmProspectingListProfile.aspx/GetCategory_Products_DDL",
                data: "{'Cat_Id':" + Cat_id + "}",
                success: OnSuccessLoad_Products,
                error: OnErrorLoad_Products
            });
            return false;
        }

        function OnSuccessLoad_Products(msg) {
            var data = msg.d;
            $("select[id$=txtTargetProduct_Prospecting]> option").remove();
            for (var i = 0; i <= data.Products.length - 1; i++) {

                $("select[id$='txtTargetProduct_Prospecting']").append("<option value=" + data.Products[i].item_id + ">" + data.Products[i].Item_name + "</option>");
            }
            $("select[id$='txtTargetProduct_Prospecting']").prepend("<option></option>");
            $("select[id$='txtTargetProduct_Prospecting']").val('');
            return false;
        }
        function OnErrorLoad_Products() {
            alert("Error in loading Products!");
        }

        //------------------------------------------------Load Products against Category _ Company ;)--- by Obaid Altaf------------------------------------//

        function GetCategory_Products_DDL_Company() {
            var Cat_id = $("select[id$='ddlCategoryCompany'] option:selected").val().trim();
            $.ajax({
                type: "POST",
                dataType: "json",
                contentType: "application/json; charset=utf-8",
                url: "frmProspectingListProfile.aspx/GetCategory_Products_DDL",
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

        //---------------------------------------------------------------Key Restriction-------------------------------------//
        function keyRestrict(e, validchars, casesensitives, onceevery, onceoneof) {

            onceevery = onceevery ? onceevery : "";
            onceoneof = onceoneof ? onceoneof : "";

            if (!validchars)
                return true;
            var key = '', keychar = '', obj = '', i = 0;
            var key = e.which ? e.which : window.event.keyCode;
            var obj = e.target ? e.target : window.event.srcElement;
            if (key == null)
                return true;
            keychar = String.fromCharCode(key);
            validchars = (validchars + onceevery + onceoneof);
            if (!casesensitives) {
                keychar = keychar.toLowerCase();
                validchars = validchars.toLowerCase();
                onceevery = onceevery.toLowerCase();
                onceoneof = onceoneof.toLowerCase();
            }
            for (i = 0; i < (onceevery + onceoneof).length; i++) {
                if (i < onceevery.length) {
                    if (obj.value.indexOf(onceevery.charAt(i)) != -1 && keychar == onceevery.charAt(i))
                        return false;
                }
                else {
                    if (obj.value.indexOf(onceoneof.charAt(i - onceevery.length)) != -1 && onceoneof.indexOf(keychar) != -1)
                        return false;
                }
            }

            if (validchars.indexOf(keychar) != -1)
                return true;

            if (key == null || key == 0 || key == 8 || key == 9 || key == 13 || key == 27)
                return true;
            return false;
        }

    </script>

</asp:Content>

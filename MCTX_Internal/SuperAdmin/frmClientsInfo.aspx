<%@ Page Language="C#" MasterPageFile="~/MCTX_Internal/SuperAdmin/MasterAdmin.master"
    AutoEventWireup="true" CodeFile="frmClientsInfo.aspx.cs" Inherits="MCTX_Internal_SuperAdmin_frmClientsInfo"
    Title="Clients Information" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <script src="../../js/jquery.dataTables.min.js" type="text/javascript"></script>

    <script src="../../js/BlockUI.js" type="text/javascript"></script>

    <script src="../../js/FieldValidation.js" type="text/javascript"></script>

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
            <li style="text-align: left"><a href="#tabs-1">Client Info & Details</a></li>
        </ul>
        <fieldset style="width: 96%">
            <legend>Add Client Details</legend>
            <table style="width: 100%; font-family: Calibri; font-size: 11pt;">
                <tr>
                    <td align="left" style="width: 140px;">
                        <asp:Label ID="lblClientName" Text="Client Name:" runat="server"></asp:Label>
                    </td>
                    <td align="left" style="width: 140px;">
                        <asp:TextBox ID="txtClientName" Width="95%" MaxLength="30" onkeypress="return keyRestrict(event,'abcdefghijklmnopqrstuvwxyz ')"
                            runat="server"></asp:TextBox>
                    </td>
                    <td align="left" style="width: 140px;">
                        <asp:Label ID="lbl" Text="Company Name:" runat="server"></asp:Label>
                    </td>
                    <td align="left" style="width: 140px;">
                        <asp:DropDownList ID="ddlCompanyName" Width="95%" runat="server">
                        </asp:DropDownList>
                    </td>
                    <td>
                    </td>
                </tr>
                <tr>
                    <td align="left" style="width: 140px;">
                        <asp:Label ID="lblDepart" Text="Department:" runat="server"></asp:Label>
                    </td>
                    <td align="left" style="width: 140px;">
                        <asp:TextBox ID="txtDepart" Width="95%" MaxLength="30" onkeypress="return keyRestrict(event,'abcdefghijklmnopqrstuvwxyz&- ')"
                            runat="server"></asp:TextBox>
                    </td>
                    <td align="left" style="width: 140px;">
                        <asp:Label ID="lblDesig" Text="Designation" runat="server"></asp:Label>
                    </td>
                    <td align="left" style="width: 140px;">
                        <asp:TextBox ID="txtDesig" Width="95%" MaxLength="30" onkeypress="return keyRestrict(event,'abcdefghijklmnopqrstuvwxyz&- ')"
                            runat="server"></asp:TextBox>
                    </td>
                    <td>
                    </td>
                </tr>
                <tr>
                    <td align="left" style="width: 140px;">
                        <asp:Label ID="lblPhone" Text="Phone:" runat="server"></asp:Label>
                    </td>
                    <td align="left" style="width: 140px;">
                        <asp:TextBox ID="txtPhone" Width="95%" onkeypress="return keyRestrict(event,'+0123456789')"
                            MaxLength="20" runat="server"></asp:TextBox>
                    </td>
                    <td align="left" style="width: 140px;">
                        <asp:Label ID="lblCell" Text="Cell Number:" runat="server"></asp:Label>
                    </td>
                    <td align="left" style="width: 140px;">
                        <asp:TextBox ID="txtCell" Width="95%" onkeypress="return keyRestrict(event,'+0123456789')"
                            MaxLength="20" runat="server"></asp:TextBox>
                    </td>
                    <td>
                    </td>
                </tr>
                <tr>
                    <td align="left" style="width: 140px;">
                        <asp:Label ID="lblFax" Text="Fax Number:" runat="server"></asp:Label>
                    </td>
                    <td align="left" style="width: 140px;">
                        <asp:TextBox ID="txtFax" Width="95%" onkeypress="return keyRestrict(event,'+0123456789')"
                            MaxLength="20" runat="server"></asp:TextBox>
                    </td>
                    <td align="left" style="width: 140px;">
                        <asp:Label ID="lblEmail" Text="Email Address:" runat="server"></asp:Label>
                    </td>
                    <td align="left" style="width: 140px;">
                        <asp:TextBox ID="txtEmail" Width="95%" onblur="return CheckEmail();" onkeypress="return keyRestrict(event,'abcdefghijklmnopqrstuvwxyz0123456789@._-')"
                            MaxLength="50" runat="server"></asp:TextBox>
                    </td>
                    <td>
                    </td>
                </tr>
                <tr>
                    <td align="left" style="width: 140px;">
                        <asp:Label ID="lblCity" Text="City:" runat="server"></asp:Label>
                    </td>
                    <td align="left" style="width: 140px;">
                        <asp:DropDownList ID="ddlCity" Width="95%" runat="server">
                        </asp:DropDownList>
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
                        <asp:Label ID="lblAddress" Text="Address:" runat="server"></asp:Label>
                    </td>
                    <td align="left" colspan="2">
                        <asp:TextBox ID="txtAddress" TextMode="MultiLine" Width="99%" MaxLength="300" onkeypress="return keyRestrict(event,'abcdefghijklmnopqrstuvwxyz0123456789-#., ')"
                            Style="resize: none;" runat="server"></asp:TextBox>
                    </td>
                    <td align="left" style="width: 140px;">
                        <asp:TextBox ID="txtClientID" Style="display: none; width: 95%;" runat="server"></asp:TextBox>
                    </td>
                    <td>
                    </td>
                </tr>
                <tr>
                    <td align="left" colspan="2">
                        <asp:Button ID="btnSave" Text="Save" Style="background-color: #2A4062; color: White;
                            width: 75px;" OnClientClick="return SaveClients();" runat="server" />
                        <asp:Button ID="btnClear" Text="Clear" Style="background-color: #2A4062; color: White;
                            width: 75px;" OnClientClick="return ClearFields();" runat="server" />
                        <asp:Button ID="btnUpdate" Text="Update" Style="background-color: #2A4062; color: White;
                            display: none; width: 75px;" OnClientClick="return UpdateClients();" runat="server" />
                    </td>
                    <td align="left" style="width: 140px;">
                    </td>
                    <td align="left" style="width: 140px;">
                    </td>
                    <td align="left" style="width: 140px;">
                    </td>
                </tr>
            </table>
        </fieldset>
        <fieldset style="width: 95%">
            <legend>Clients</legend>
            <fieldset style="width: 99%">
                <legend>Search Criteria</legend>
                <table style="width: 100%; font-family: Calibri; font-size: 11pt;">
                    <tr>
                        <td align="left" style="width: 140px;">
                            <asp:Label ID="lblComanySearch" Text="Company Name:" runat="server"></asp:Label>
                        </td>
                        <td align="left" style="width: 140px;">
                            <asp:TextBox ID="txtCompanySearch" Width="95%" MaxLength="30" runat="server"></asp:TextBox>
                        </td>
                        <td align="left" style="width: 140px;">
                            <asp:Label ID="lblSearchCity" Text="Select City:" runat="server"></asp:Label>
                        </td>
                        <td align="left" style="width: 140px;">
                            <asp:DropDownList ID="ddlSearchCity" Width="95%" runat="server">
                            </asp:DropDownList>
                        </td>
                        <td align="left" style="width: 140px;">
                            <asp:Button ID="btnSearch" Text="Search" Style="background-color: #2A4062; color: White;
                                width: 75px;" OnClientClick="return GetClients();" runat="server" />
                        </td>
                        <td>
                        </td>
                    </tr>
                    <tr>
                        <td align="left" style="width: 140px;" colspan="2">
                            <asp:Label ID="lblmsg" Text="Partial Company Name Is Acceptable!" Style="color: Green;"
                                runat="server"></asp:Label>
                        </td>
                        <td align="left" style="width: 140px;">
                        </td>
                        <td align="left" style="width: 140px;">
                        </td>
                        <td align="left" style="width: 140px;">
                        </td>
                        <td>
                        </td>
                    </tr>
                </table>
            </fieldset>
            <fieldset style="width: 99%">
                <legend>Details</legend>
                <div style="overflow: auto; width: 912px; height: 300px;" runat="server">
                    <table id="tblClient" class="dataTable">
                    </table>
                </div>
            </fieldset>
        </fieldset>
    </div>

    <script type="text/javascript" language="javascript">
    var oTable;
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
    
        GetClients();
    });
    
    function dataTable() {
        oTable= $("#tblClient").dataTable({
                bPaginate: false,
                bJQueryUI: true,
                bSort: true,
                bInfo: false,
                bRetrieve: true,
                bDestroy: true,
                oLanguage:{"sSearch":"Filter: "}               
            }).fixedHeader({ height: 400});
    }
    
    function GetClients()
    {
        var SearchComp = $("input[id$='txtCompanySearch']").val();
        var SearchCity = $("select[id$='ddlSearchCity']").val();
        blockUI();
        $.ajax({
        type: "POST",
        contentType:"application/json; charset=utf-8",
        url: "frmClientsInfo.aspx/GetDetails", 
        data: "{'SearchComp':'"+SearchComp+"','SearchCity':'"+SearchCity+"'}", 
        success:onsuccessGetClients,
        error:onErrorGetClients 
        });
        return false;
    }
    
    function onsuccessGetClients(msg)
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
                tbl += "<th id='txtDeleteth' style='cursor:Pointer;text-align:center;white-space:nowrap;border:1px solid #999999;'>Del</th>";
                tbl += "<th id='txtEditth' style='cursor:Pointer;text-align:center;white-space:nowrap;border:1px solid #999999;'>Edit</th>";
                tbl += "<th style='white-space:nowrap; text-align:left; display:none; border:1px solid #999999;'>Client ID</th>";
                tbl += "<th style='white-space:nowrap; text-align:left; border:1px solid #999999;'>Client Name</th>";
                tbl += "<th style='white-space:nowrap; text-align:left; display:none; border:1px solid #999999;'>Company ID</th>";
                tbl += "<th style='white-space:nowrap; text-align:left; border:1px solid #999999;'>Company Name</th>";
                tbl += "<th style='white-space:nowrap; text-align:left; border:1px solid #999999;'>Department</th>";
                tbl += "<th style='white-space:nowrap; text-align:left; border:1px solid #999999;'>Designation</th>";
                tbl += "<th style='white-space:nowrap; text-align:left; border:1px solid #999999;'>Phone</th>";
                tbl += "<th style='white-space:nowrap; text-align:left; border:1px solid #999999;'>Cell</th>";
                tbl += "<th style='white-space:nowrap; text-align:left; border:1px solid #999999;'>Fax Number</th>";
                tbl += "<th style='white-space:nowrap; text-align:left; border:1px solid #999999;'>Email</th>";
                tbl += "<th style='white-space:nowrap; text-align:left; display:none; border:1px solid #999999;'>City ID</th>";
                tbl += "<th style='white-space:nowrap; text-align:left; border:1px solid #999999;'>City Name</th>";
                tbl += "<th style='white-space:nowrap; text-align:left; border:1px solid #999999;'>Address</th>";
                tbl += "</tr>";
                tbl += "</thead>";
                tbl += "<tbody>";
                for (var i = 0; i < data.ClientDetails.length; i++) {               
                            tbl += "<td id='txtDelete"+i+"' align='center' style='border:1px solid #999999;'> <input  type='image' src='image/Cross.png' style = 'width:16px; border:0px;' onclick='return Delete("+i+");'></td>";
                            tbl += "<td id='txtEdit"+i+"' align='center' style='border:1px solid #999999;'> <input  type='image' src='image/Edit.png' style = 'width:16px; border:0px;' onclick='return GetRowForUpdation("+i+");'></td>";
                            tbl += "<td style='text-align:right; white-space:nowrap; border:1px solid #999999; display:none;' id='txtClientID"+i+"'>" + data.ClientDetails[i].ClientID + "</td>";
                            tbl += "<td style='text-align:left; white-space:nowrap; border:1px solid #999999;' id='txtClientName"+i+"'>" + data.ClientDetails[i].ClientName + "</td>";
                            tbl += "<td style='text-align:right; white-space:nowrap; border:1px solid #999999; display:none;' id='txtCompID"+i+"'>" + data.ClientDetails[i].CompanyID + "</td>";
                            tbl += "<td style='text-align:left; border:1px solid #999999;' id='txtCompName"+i+"'>" + data.ClientDetails[i].CompanyName + "</td>";
                            tbl += "<td style='text-align:left; white-space:nowrap; border:1px solid #999999;' id='txtDept"+i+"'>" + data.ClientDetails[i].Dept + "</td>";
                            tbl += "<td style='text-align:left; white-space:nowrap; border:1px solid #999999;' id='txtDesg"+i+"'>" + data.ClientDetails[i].Desg + "</td>";
                            tbl += "<td style='text-align:right; white-space:nowrap; border:1px solid #999999;' id='txtPhone"+i+"'>" + data.ClientDetails[i].Phone + "</td>";
                            tbl += "<td style='text-align:right; white-space:nowrap; border:1px solid #999999;' id='txtCell"+i+"'>" + data.ClientDetails[i].Cell + "</td>";
                            tbl += "<td style='text-align:right; white-space:nowrap; border:1px solid #999999;' id='txtFax"+i+"'>" + data.ClientDetails[i].Fax + "</td>";
                            tbl += "<td style='text-align:left; white-space:nowrap; border:1px solid #999999;' id='txtEmail"+i+"'>" + data.ClientDetails[i].Email + "</td>";
                            tbl += "<td style='text-align:right; white-space:nowrap; border:1px solid #999999; display:none;' id='txtCityID"+i+"'>" + data.ClientDetails[i].CityID + "</td>";
                            tbl += "<td style='text-align:left; white-space:nowrap; border:1px solid #999999;' id='txtCityName"+i+"'>" + data.ClientDetails[i].CityName + "</td>";
                            tbl += "<td style='text-align:left; border:1px solid #999999;' id='txtAddress"+i+"'>" + data.ClientDetails[i].Address + "</td>";
                      tbl += "</tr>";
                }   
                tbl += "</tbody>";
                tbl += "</table>";
                $("#tblClient").html(tbl);
                //dataTable();
                unblockUI();
                return false;  
    }
    
    function onErrorGetClients()
    {
        alert("Error In Loading Details!");
        unblockUI();
        return false;
    }
    
    function GetRowForUpdation(rowNo)
    {
        var ClientID = $("#txtClientID"+rowNo).html().trim();
        $("input[id$='txtClientID']").val(ClientID);
        var ClientName = $("#txtClientName"+rowNo).html().trim();
        $("input[id$='txtClientName']").val(ClientName);
        var CompanyID = $("#txtCompID"+rowNo).html().trim();
        $("select[id$='ddlCompanyName']").val(CompanyID);
        var Depart = $("#txtDept"+rowNo).html().trim();
        $("input[id$='txtDepart']").val(Depart);
        var Desig = $("#txtDesg"+rowNo).html().trim();
        $("input[id$='txtDesig']").val(Desig);
        var Phone = $("#txtPhone"+rowNo).html().trim();
        $("input[id$='txtPhone']").val(Phone);
        var Cell = $("#txtCell"+rowNo).html().trim();
        $("input[id$='txtCell']").val(Cell);
        var Fax = $("#txtFax"+rowNo).html().trim();
        $("input[id$='txtFax']").val(Fax);
        var Email = $("#txtEmail"+rowNo).html().trim();
        $("input[id$='txtEmail']").val(Email);
        var CityID = $("#txtCityID"+rowNo).html().trim();
        $("select[id$='ddlCity']").val(CityID);
        var Address = $("#txtAddress"+rowNo).html().trim();
        $("textarea[id$='txtAddress']").val(Address);        
        $("input[id$='btnSave']").attr("disabled",true);
        $("input[id$='btnUpdate']").show();
        return false; 
    }
    
    function UpdateClients()
    {
        var ClientID = $("input[id$='txtClientID']").val();
        var ClientName = $("input[id$='txtClientName']").val();
        if (ClientName == "")
        {
            alert("Please Enter Client Name!");
            return false;
        }
        var CompanyID = $("select[id$='ddlCompanyName'] option:selected").val();
        if (CompanyID == "")
        {
            alert("Please Select Appropriate Company!");
            return false;
        }
        var Dept = $("input[id$='txtDepart']").val();
        if (Dept == "")
        {
            alert("Please Enter Relevant Department!");
            return false;
        }
        var Desg = $("input[id$='txtDesig']").val();
        if (Desg == "")
        {
            alert("Please Enter Appropriate Designation!");
            return false;
        }
        var Phone = $("input[id$='txtPhone']").val();
        var Cell = $("input[id$='txtCell']").val();
        if (Phone == "" && Cell == "")
        {
            alert("Please Enter Either Phone or Cell Number!");
            return false;
        }
        var Fax = $("input[id$='txtFax']").val();
        var Email = $("input[id$='txtEmail']").val();
        var CityID = $("select[id$='ddlCity'] option:selected").val();
        if (CityID == "")
        {
            alert("Please Select Appropriate City!");
            return false;
        }
        var Address = $("textarea[id$='txtAddress']").val();
        if (Address == "")
        {
            alert("Please Enter Address!");
            return false;
        }
        $.ajax({
        type: "POST",
        contentType:"application/json; charset=utf-8",
        url: "frmClientsInfo.aspx/UpdateClients", 
        data: "{'ClientID':'"+ClientID+"','ClientName':'"+ClientName+"','CompanyID':'"+CompanyID+"','Dept':'"+Dept+"','Desg':'"+Desg+"','Phone':'"+Phone+"','Cell':'"+Cell+"','Fax':'"+Fax+"','Email':'"+Email+"','CityID':'"+CityID+"','Address':'"+Address+"'}", 
        success:onsuccessUpdateClients,
        error:onErrorUpdateClients 
        });
        return false;
    }
    
    function onsuccessUpdateClients()
    {
        alert("Record Updated Successfully!");
        ClearFields();
        GetClients();
        return false;
    }
    
    function onErrorUpdateClients()
    {
        alert("Error Updating Record!");
        return false;
    }
    
    function Delete(rowNo)
    {
        var ClientID = $("#txtClientID"+rowNo).html().trim();
          if (confirm("Are you sure you wish to delete this Record?")) {
        $.ajax({
        type: "POST",
        contentType:"application/json; charset=utf-8",
        url: "frmClientsInfo.aspx/DeleteClients", 
        data: "{'ClientID':'"+ClientID+"'}", 
        success:onsuccessDelete,
        error:onErrorDelete
        });
        }
        else
        return false;
        
    }
    
    function onsuccessDelete()
    {
        alert("Record Successfully Deleted!");
        GetClients();
        return false;
    }
    
    function onErrorDelete()
    {
        alert("Error Deleting Record!");
        return false;
    }
    
    function ClearFields()
    {
        $("input[id$='txtClientName']").val("");
        $("select[id$='ddlCompanyName']").val("");
        $("input[id$='txtDepart']").val("");
        $("input[id$='txtDesig']").val("");
        $("input[id$='txtPhone']").val("");
        $("input[id$='txtCell']").val("");
        $("input[id$='txtFax']").val("");
        $("input[id$='txtEmail']").val("");
        $("select[id$='ddlCity']").val("");
        $("textarea[id$='txtAddress']").val("");
        $("input[id$='btnSave']").attr("disabled",false);
        $("input[id$='btnUpdate']").hide();
        return false;
    }
    
    function SaveClients()
    {
        var ClientName = $("input[id$='txtClientName']").val();
        if (ClientName == "")
        {
            alert("Please Enter Client Name!");
            return false;
        }
        var CompanyID = $("select[id$='ddlCompanyName'] option:selected").val();
        if (CompanyID == "")
        {
            alert("Please Select Appropriate Company!");
            return false;
        }
        var Dept = $("input[id$='txtDepart']").val();
        if (Dept == "")
        {
            alert("Please Enter Relevant Department!");
            return false;
        }
        var Desg = $("input[id$='txtDesig']").val();
        if (Desg == "")
        {
            alert("Please Enter Appropriate Designation!");
            return false;
        }
        var Phone = $("input[id$='txtPhone']").val();
        var Cell = $("input[id$='txtCell']").val();
        if (Phone == "" && Cell == "")
        {
            alert("Please Enter Either Phone or Cell Number!");
            return false;
        }
        var Fax = $("input[id$='txtFax']").val();
        var Email = $("input[id$='txtEmail']").val();
        var CityID = $("select[id$='ddlCity'] option:selected").val();
        if (CityID == "")
        {
            alert("Please Select Appropriate City!");
            return false;
        }
        var Address = $("textarea[id$='txtAddress']").val();
        if (Address == "")
        {
            alert("Please Enter Address!");
            return false;
        }
        $.ajax({
        type: "POST",
        contentType:"application/json; charset=utf-8",
        url: "frmClientsInfo.aspx/SaveClients", 
        data: "{'ClientName':'"+ClientName+"','CompanyID':'"+CompanyID+"','Dept':'"+Dept+"','Desg':'"+Desg+"','Phone':'"+Phone+"','Cell':'"+Cell+"','Fax':'"+Fax+"','Email':'"+Email+"','CityID':'"+CityID+"','Address':'"+Address+"'}", 
        success:onsuccessSaveClients,
        error:onErrorSaveClients 
        });
        return false;
    }
    
    function onsuccessSaveClients()
    {
        alert("Record Successfully Saved!");
        GetClients();
        ClearFields();
        return false;
    }
    
    function onErrorSaveClients()
    {
        alert("Error In Saving!");
        return false;
    }
    
    function CheckEmail() 
    {
        if (/^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/.test($("input[id$='txtEmail']").val())) 
        {
            return (true);
        }
        var Email = $("input[id$='txtEmail']").val();
        if (Email != "")
        {
            alert("Invalid Email Address!");
            $("input[id$='txtEmail']").val("");
            return (false);
        }
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
    
    </script>

</asp:Content>

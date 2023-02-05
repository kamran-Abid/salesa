<%@ Page Language="C#" MasterPageFile="~/MCTX_Internal/SuperAdmin/MasterAdmin.master"
    AutoEventWireup="true" CodeFile="frmCompanyInfo.aspx.cs" Inherits="MCTX_Internal_SuperAdmin_frmCompanyInfo"
    EnableEventValidation="false" Title="Company Information" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <script src="../../js/jquery.dataTables.min.js" type="text/javascript"></script>

    <script src="../../js/BlockUI.js" type="text/javascript"></script>

    <script src="../../js/jquery.fixedheader.js" type="text/javascript"></script>

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
            font-size: 11px;
            border: 1px solid #CCCCCC;
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
        .style3
        {
            width: 176px;
        }
    </style>
    <div id="tabs" style="width: 949px;">
        <ul>
            <li style="text-align: left"><a href="#tabs-1">Company Information</a></li>
        </ul>
        <fieldset id="fldMain" style="width: 95%">
            <legend>Add Company Information</legend>
            <table style="width: 100%; font-family: Calibri; font-size: 11pt;">
                <tr>
                    <td align="left" style="width: 140px;">
                        <asp:Label ID="lblCompName" Text="Company Name:" Width="100%" runat="server"></asp:Label>
                    </td>
                    <td align="left" style="width: 140px;">
                        <asp:TextBox ID="txtCompName" Width="95%" MaxLength="35" onkeypress="return keyRestrict(event,'0123456789abcdefghijklmnopqrstuvwxyz- ')"
                            runat="server"></asp:TextBox>
                    </td>
                    <td align="left" style="width: 140px;">
                        <asp:Label ID="lblCity" Text="Select City:" Width="100%" runat="server"></asp:Label>
                    </td>
                    <td align="left" class="style3">
                        <asp:DropDownList ID="ddlCity" Width="95%" AutoPostBack="false" onChange="return CheckCompany();"
                            runat="server">
                        </asp:DropDownList>
                    </td>
                    <td>
                    </td>
                    <td>
                    </td>
                </tr>
                <tr>
                    <td align="left" style="width: 140px;">
                        <asp:Label ID="lblEmail" Text="Email Address:" Width="100%" runat="server"></asp:Label>
                    </td>
                    <td align="left" style="width: 140px;">
                        <asp:TextBox ID="txtEmail" Width="95%" MaxLength="40" onkeypress="return keyRestrict(event,'-_.@0123456789abcdefghijklmnopqrstuvwxyz')"
                            onblur="return CheckEmail();" runat="server"></asp:TextBox>
                    </td>
                    <td align="left" style="width: 140px;">
                        <asp:Label ID="lblWeb" Text="Web Address:" Width="100%" runat="server"></asp:Label>
                    </td>
                    <td align="left" class="style3">
                        <asp:TextBox ID="txtWeb" Width="95%" MaxLength="40" onkeypress="return keyRestrict(event,'-_.@0123456789abcdefghijklmnopqrstuvwxyz')"
                            runat="server"></asp:TextBox>
                    </td>
                    <td>
                    </td>
                    <td>
                    </td>
                </tr>
                <tr>
                    <td align="left" style="width: 140px;">
                        <asp:Label ID="lblPhone" Text="Phone Number:" Width="100%" runat="server"></asp:Label>
                    </td>
                    <td align="left" style="width: 140px;">
                        <asp:TextBox ID="txtPhone" Width="95%" MaxLength="16" onkeypress="return keyRestrict(event,'+0123456789')"
                            runat="server"></asp:TextBox>
                    </td>
                    <td align="left" style="width: 140px;">
                        &nbsp;</td>
                    <td align="left" class="style3">
                        <asp:DropDownList ID="ddlCategory" Width="95%" OnChange="return ItemDDL();" AutoPostBack="false"
                            runat="server" Visible="False">
                        </asp:DropDownList>
                    </td>
                    <td>
                    </td>
                    <td>
                    </td>
                </tr>
                <tr>
                    <td align="left" style="width: 140px;">
                        <asp:Label ID="lblComapnyKey" Text="Company Key:" Width="100%" runat="server"></asp:Label>
                    </td>
                     <td align="left" style="width: 140px;">
                        <asp:TextBox ID="txtBoxCompanyKey" Width="95%" MaxLength="8" runat="server"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td align="left" style="width: 140px;">
                        &nbsp;</td>
                    <td align="left" style="width: 140px;">
                        <asp:DropDownList ID="ddlItem" Width="90%" runat="server" Visible="False">
                        </asp:DropDownList>
                    </td>
                    <td align="left" style="width: 140px;">
                        <asp:Label ID="lblAddress" Text="Address:" Width="100%" runat="server"></asp:Label>
                    </td>
                    <td align="left" class="style3">
                        <asp:TextBox ID="txtAddress" onkeypress="textCounter(this,this.form.counter,300);        "
                            Height="70px" TextMode="MultiLine" Style="resize: none; "
                            runat="server" Width="168px"></asp:TextBox>
                        <input type="text" name="counter" maxlength="3" size="3" value="300" style="width: 25px;"
                            onblur="textCounter(this.form.counter,this,300);">
                        Characters Remaining
                    </td>
                </tr>
                <tr>
                    <td align="left" style="width: 140px;">
                    </td>
                    <td align="left" colspan="3">
                        <asp:Button ID="btnSave" Text="Save" Style="background-color: #2A4062; color: White;
                            width: 75px;" OnClientClick="return SaveCompInfo();" runat="server" />&nbsp;
                        <asp:Button ID="btnClear" Text="Clear" Style="background-color: #2A4062; color: White;
                            width: 75px;" OnClientClick="return Clear();" runat="server" />&nbsp;
                        <asp:Button ID="btnUpdate" Text="Update" Style="background-color: #2A4062; color: White;
                            display: none; width: 75px;" OnClientClick="return UpdateComp();" runat="server" />
                    </td>
                    <td>
                    </td>
                    <td>
                    </td>
                </tr>
            </table>
        </fieldset>
        <div style="overflow: auto; width: 940px;" runat="server">
            <fieldset id="fldSearch" style="width: 96%">
                <legend>Search Criteria</legend>
                <table width="100%">
                    <tr>
                        <td align="left" style="width: 100px;">
                            <asp:Label ID="lblComapanyName" Text="Company Name:" runat="server"></asp:Label>
                        </td>
                        <td align="left" style="width: 140px;">
                            <asp:TextBox ID="txtCompanyName" runat="server"></asp:TextBox>
                        </td>
                        <td align="left" style="width: 50px;">
                            <asp:Label ID="lblCityName" Text="City:" runat="server"></asp:Label>
                        </td>
                        <td align="left" style="width: 140px;">
                            <asp:DropDownList ID="ddlCityName" Width="90%" AutoPostBack="false" runat="server">
                            </asp:DropDownList>
                        </td>
                        <td align="left" style="width: 120px;">
                            <asp:Button ID="btnSearch" Text="Search" Style="background-color: #2A4062; color: White;"
                                OnClientClick="return LoadCompInfo();" runat="server" />
                        </td>
                        <td align="left" style="width: 100px;">
                            <asp:TextBox ID="txtCompID" Style="display: none;" runat="server"></asp:TextBox>
                            <asp:DropDownList ID="ddlCompanyName" Width="60%" AutoPostBack="false" 
                                runat="server" Visible="False">
                            </asp:DropDownList>
                        </td>
                        <td>
                        </td>
                    </tr>
                </table>
            </fieldset>
        </div>
        <br />
        <div style="overflow: auto; width: 912px; height: 300px;" runat="server">
            <table id="tblCompInfo" class="dataTable">
            </table>
        </div>
    </div>

    <script type="text/javascript" language="javascript">
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

    $(document).ready(function()
    {
        CatDDL();
        PopulateCompanyDDL();
        LoadCompInfo();
    });
    
    function SaveCompInfo()
    {
        var CompName = $("input[id$='txtCompName']").val();
        var CityID = $("select[id$='ddlCity']").val();
        var Email = $("input[id$='txtEmail']").val();
        var WebAdd = $("input[id$='txtWeb']").val();
        var PhoneNum = $("input[id$='txtPhone']").val();
        var CatID = $("select[id$='ddlCategory']").val();
        var TarProd = $("select[id$='ddlItem'] option:selected").text();
        var TarProdID = $("select[id$='ddlItem'] option:selected").val();
        var Address = $("textarea[id$='txtAddress']").val();
        var CompanyKey = $("input[id$='txtBoxCompanyKey']").val();
        if (CompName == "")
        {
            alert("Please Enter Company Name!");
            return false;
        }
        if (CityID == "")
        {
            alert("Please Select Desired City!");
            return false;
        }
        CheckEmail();
        if (Email == "" && WebAdd=="" && PhoneNum == "")
        {
            alert("Please Enter Either Email Address, Web Address or Phone Number!");
            return false;
        }
//        if (CatID == "")
//        {
//            alert("Please Select Desired Category!");
//            return false;
//        }
//        if (TarProd == "")
//        {
//            alert("Please Select Target Product!");
//            return false;
//        }
        $.ajax({
        type: "POST",
        contentType:"application/json; charset=utf-8",
        url: "frmCompanyInfo.aspx/SaveCompanyInfo", 
        data: "{'CompName':'" + CompName + "','CityID':'" + CityID + "','Email':'" + Email + "','WebAdd':'" + WebAdd + "','PhoneNum':'" + PhoneNum + "','CatID':'" + CatID + "','TarProd':'" + TarProd + "','TarProdID':'" + TarProdID + "','Address':'" + Address + "','CompanyKey':'" + CompanyKey + "'}",
        success:onsuccessSaveComp,
        error:onErrorSaveComp 
        });
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
    function onsuccessSaveComp(msg)
    {
        var data = msg.d;
        if (data == "Added Successfully") { alert("Record Saved Successfully!"); }
        else { alert("Already Exist Company key"); }
        
        Clear();
        LoadCompInfo();
        return false;
    }
    function onErrorSaveComp()
    {
        alert("Error In Saving Record!");
        return false;
    }
    
    function Clear()
    {
        $("input[id$='txtCompName']").val('');
        $("select[id$='ddlCity']").val('');
        $("input[id$='txtEmail']").val('');
        $("input[id$='txtWeb']").val('');
        $("input[id$='txtPhone']").val('');
        $("input[id$='txtBoxCompanyKey']").val('');
        $("textarea[id$='txtAddress']").val('');
        $("select[id$='ddlCategory']").val('');
        $("select[id$='ddlItem']").val('');
        $("input[id$='btnUpdate']").hide();
        $("input[id$='btnSave']").attr("disabled", false);
        return false;
    }
    function LoadCompInfo()
    {
        //var CompID = $("select[id$='ddlCompanyName'] option:selected").val();
        var CompID = $("input[id$='txtCompanyName']").val(); 
        var CityID = $("select[id$='ddlCityName'] option:selected").val();
        $.ajax({
        type: "POST",
        contentType:"application/json; charset=utf-8",
        url: "frmCompanyInfo.aspx/LoadCompanyInfo", 
        data: "{'CompID':'"+CompID+"','CityID':'"+CityID+"'}", 
        success:onsuccessLoadComp,
        error:onErrorLoadComp 
        });
        return false;
    }
    function onsuccessLoadComp(msg)
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
                tbl += "<th id='txtDeleteth' style='cursor:Pointer;text-align:center;white-space:nowrap;border:1px solid #999999;'>Delete</th>";
                tbl += "<th id='txtEditth' style='cursor:Pointer;text-align:center;white-space:nowrap;border:1px solid #999999;'>Edit</th>";
                tbl += "<th style='white-space:nowrap; text-align:left; display:none;'>Company ID</th>";
                tbl += "<th style='white-space:nowrap; text-align:left;'>Company Name</th>";
                tbl += "<th style='white-space:nowrap; text-align:left;'>Company Address</th>";
                tbl += "<th style='white-space:nowrap; text-align:left;'>Company Phone</th>";
                tbl += "<th style='white-space:nowrap; text-align:left; display:none;'>City ID</th>";
                tbl += "<th style='white-space:nowrap; text-align:left;'>City Name</th>";
                tbl += "<th style='white-space:nowrap; text-align:left;'>Company Website</th>";
                tbl += "<th style='white-space:nowrap; text-align:left;'>Company Email</th>";
                tbl += "<th style='white-space:nowrap; text-align:left;'>Company Key</th>";
                tbl += "<th style='white-space:nowrap; text-align:left; display:none;'>Category ID</th>";
                tbl += "<th style='white-space:nowrap; text-align:left;'>Category Name</th>";
                tbl += "<th style='white-space:nowrap; text-align:left;'>Target Products</th>";
                tbl += "<th style='white-space:nowrap; text-align:left; display:none;'>Target Products ID</th>";
                tbl += "<th style='white-space:nowrap; text-align:left;'>Created By</th>";
                tbl += "<th style='white-space:nowrap; text-align:left;'>Created Date</th>";
                tbl += "<th style='white-space:nowrap; text-align:left;'>Modified By</th>";
                tbl += "<th style='white-space:nowrap; text-align:left;'>Modified Date</th>";
                tbl += "</tr>";
                tbl += "</thead>";
                tbl += "<tbody>";
                for (var i = 0; i < data.CompDetails.length; i++) {  
                            tbl += "<tr  id='rowmain"+i+"'>";  
                    
                            tbl += "<td id='txtDelete"+i+"' align='center' style='border:1px solid #999999;'> <input  type='image' src='image/Cross.png' style='width:16px; border:0px;' onclick='return DeleteComp("+i+");'></td>";
                            tbl += "<td id='txtEdit"+i+"' align='center' style='border:1px solid #999999;'> <input  type='image' src='image/Edit.png' style='width:16px; border:0px;' onclick='return GetRowForUpdation("+i+");'></td>";
                            tbl += "<td style='text-align:right; white-space:nowrap; display:none;' id='txtCompID"+i+"'>" + data.CompDetails[i].comp_id + "</td>";
                            tbl += "<td style='text-align:left; white-space:nowrap;' id='txtCompName"+i+"'>" + data.CompDetails[i].comp_name + "</td>";   
                            tbl += "<td style='text-align:left;' id='txtCompAdd"+i+"'>" + data.CompDetails[i].comp_address + "</td>";                  
                            tbl += "<td style='text-align:right; white-space:nowrap;' id='txtCompPhone"+i+"'>" + data.CompDetails[i].comp_phone + " </td>";
                            tbl += "<td style='text-align:right; white-space:nowrap; display:none;' id='txtCityID"+i+"'>" + data.CompDetails[i].comp_city_id + " </td>";
                            tbl += "<td style='text-align:left;' id='txtCity"+i+"'>" +  data.CompDetails[i].city_name + " </td>";
                            tbl += "<td style='text-align:left;' id='txtWebsite"+i+"'>" +  data.CompDetails[i].comp_website + " </td>";  
                            tbl += "<td style='text-align:left; white-space:nowrap;' id='txtCompEmail" + i + "'>" + data.CompDetails[i].comp_email + " </td>";
                            tbl += "<td style='text-align:left; white-space:nowrap;' id='comp_Key" + i + "'>" + data.CompDetails[i].comp_Key + " </td>";
                            tbl += "<td style='text-align:left; white-space:nowrap; display:none;' id='txtCatID"+i+"'>" + data.CompDetails[i].CategoryID + " </td>";
                            tbl += "<td style='text-align:left; white-space:nowrap;' id='txtCatID"+i+"'>" + data.CompDetails[i].CatName + " </td>";
                            tbl += "<td style='text-align:left;' id='txtTarProd"+i+"'>" +  data.CompDetails[i].comp_targted_products + " </td>";
                            tbl += "<td style='text-align:right; display:none;' id='txtTarProdID"+i+"'>" +  data.CompDetails[i].comp_TarProdID + " </td>";
                            tbl += "<td style='text-align:left; white-space:nowrap;' id='txtCreatedBy"+i+"'>" + data.CompDetails[i].Created_By + " </td>";  
                            tbl += "<td style='text-align:right;' id='txtCreatedDate"+i+"'>" +  data.CompDetails[i].Created_Date + " </td>";                
                            tbl += "<td style='text-align:left; white-space:nowrap;' id='txtModBy"+i+"'>" +  data.CompDetails[i].Modified_By + " </td>";
                            tbl += "<td style='text-align:right; white-space:nowrap;' id='txtcreateddate"+i+"'>" + data.CompDetails[i].Modified_Date + " </td>";
                            
                      tbl += "</tr>";
                }   

                tbl += "</tbody>";
                tbl += "</table>";
                $("#tblCompInfo").html(tbl);
                //dataTable();
                return false; 
        
    }
    
    function onErrorLoadComp()
    {
        alert("Error In Loading Details!");
        return false;
    }
    
    function CheckCompany()
    {
        var CompName = $("input[id$='txtCompName']").val();
        var CityID = $("select[id$='ddlCity']").val();
        $.ajax({
                        type: "POST",
                        dataType: "json",
                        contentType: "application/json; charset=utf-8",
                        url: "frmCompanyInfo.aspx/CheckCompany",
                        data: "{'CompName':'"+CompName+"','CityID':'"+CityID+"'}",
                        success: onSuccessCheckCompany,
                        error:OnErrorCheckCompany 
                        });
        return false;
    }
    
    function onSuccessCheckCompany(msg)
    {
        var data = msg.d;
        if (data == 1)
        {
            alert("Company Already Exists!");
            $("input[id$='txtCompName']").val('');
            return false;
        }
        else
        {
            return false;
        }
        return false;
    }
    
    function OnErrorCheckCompany()
    {
        alert("Error In Checking Company!");
        return false;
    }
    
    function DeleteComp(rowNo)
    {
        var CompID = $("#txtCompID"+rowNo).html().trim();
        if (confirm("Are you sure you wish to delete this Record?"))
            {
                $.ajax({
                        type: "POST",
                        dataType: "json",
                        contentType: "application/json; charset=utf-8",
                        url: "frmCompanyInfo.aspx/DeleteComp",
                        data: "{'CompID':'"+CompID+"'}",
                        success: onSuccessDelete,
                        error:OnDeleteError 
                        });
                return false;
             }
        return false;
    }
    function onSuccessDelete()
    {
        alert("Record Successfully Deleted!");
        PopulateCompanyDDL();
        LoadCompInfo();
        return false;
    }
    function OnDeleteError()
    {
        alert("Error In Deleting Record!");
        return false;
    }
    function GetRowForUpdation(rowNo)
    {
        $("#tblCompInfo tr").css("background-color","");
        $("#rowmain"+rowNo).css("background-color","#F3EFE0");
        var CatID = $("#txtCatID"+rowNo).html().trim();
        $("select[id$='ddlCategory']").val(CatID);
        ItemDDL();
        var ProdID = $("#txtTarProdID"+rowNo).html().trim();  
        $("select[id$='ddlItem']").val(ProdID);
        var CompID = $("#txtCompID"+rowNo).html().trim();
        $("input[id$='txtCompID']").val(CompID);
        var CompName = $("#txtCompName"+rowNo).html().trim();
        $("input[id$='txtCompName']").val(CompName);
        var City = $("#txtCityID"+rowNo).html().trim();
        $("select[id$='ddlCity']").val(City);
        var Email = $("#txtCompEmail"+rowNo).html().trim();
        $("input[id$='txtEmail']").val(Email);

        $("input[id$='txtBoxCompanyKey']").val($("#comp_Key" + rowNo).html().trim());
        var WebAdd = $("#txtWebsite"+rowNo).html().trim();
        $("input[id$='txtWeb']").val(WebAdd);
        var CompPhone = $("#txtCompPhone"+rowNo).html().trim();
        $("input[id$='txtPhone']").val(CompPhone);
        var Address = $("#txtCompAdd"+rowNo).html().trim();
        $("textarea[id$='txtAddress']").val(Address);
        var TarProd = $("#txtTarProdID"+rowNo).html().trim();
        $("select[id$='ddlItem']").val(TarProd);
        $("input[id$='btnUpdate']").show();
        $("input[id$='btnSave']").attr("disabled", true);
        return false; 
    }
    function UpdateComp()
    {
        var texto = "";
        var CompID = $("input[id$='txtCompID']").val(); 
        var CompName = $("input[id$='txtCompName']").val();
        var CityID = $("select[id$='ddlCity']").val();
        var Email = $("input[id$='txtEmail']").val();
        var WebAdd = $("input[id$='txtWeb']").val();
        var CompPhone = $("input[id$='txtPhone']").val();
        var CatID = $("select[id$='ddlCategory']").val();
        var TarProd = $("select[id$='ddlItem'] option:selected").text();
        var TarProdID = $("select[id$='ddlItem'] option:selected").val();
        var Address = $("textarea[id$='txtAddress']").val();
        var CompanyKey = $("input[id$='txtBoxCompanyKey']").val();

        

        for (var i = 0; i < ($('#tblCompInfo tr')).length; i++) {
            for (var j = 0; j < ($('#tblCompInfo td').length) ; j++) {
                //texto = [[row[i].sectionRowIndex, cell[j].cellIndex, $(this).find("#comp_Key" + i).html()]];//this doesn't work
                texto = $("#comp_Key" + i).html();
                if(texto!='' || texto!=null)
                if (texto == CompanyKey) {
                    alert("Already Added");
                    return;
                }
            }
        }
        debugger
        if (CompName == "")
        {
            alert("Please Enter Company Name!");
            return false;
        }
        if (CityID == "")
        {
            alert("Please Select Desired City!");
            return false;
        }
        CheckEmail();
        if (Email == "" && WebAdd=="" && CompPhone == "")
        {
            alert("Please Enter Either Email Address, Web Address or Phone Number!");
            return false;
        }
       
        $.ajax({
        type: "POST",
        contentType:"application/json; charset=utf-8",
        url: "frmCompanyInfo.aspx/UpdateComp", 
        data: "{'CompID':'" + CompID + "','CompName':'" + CompName + "','CityID':'" + CityID + "','Email':'" + Email + "','WebAdd':'" + WebAdd + "','CompPhone':'" + CompPhone + "','CatID':'" + CatID + "','TarProd':'" + TarProd + "','TarProdID':'" + TarProdID + "','Address':'" + Address + "','CompanyKey':'" + CompanyKey + "'}",
        success:onsuccessUpdateComp,
        error:onErrorUpdateComp 
        });
    return false;   
    }
    function onsuccessUpdateComp(msg)
    {
        var data = msg.d;
        if (data == "Added Successfully") {
            alert("Record Updated Successfully!");
        }
        //else { alert("Already Exist Company key"); }
        
        LoadCompInfo();
        Clear();
        return false;
    }
    function onErrorUpdateComp()
    {
        alert("Error In Updating!");
        return false;
    }
    
    function PopulateCompanyDDL()
    {
//        $.ajax({
//        type: "POST",
//        contentType:"application/json; charset=utf-8",
//        url: "frmCompanyInfo.aspx/PopulateComp", 
//        data: "{}", 
//        success:onsuccessPopulate,
//        error:onErrorPopulate
//        });
    return false;  
    }
    function onsuccessPopulate(msg)
    {
        var data = msg.d;
        $("select[id$='ddlCompanyName']> option").remove();
        for (var i = 0; i <= data.Company.length - 1; i++) 
            {
                $("select[id$='ddlCompanyName']").append("<option value=" + data.Company[i].comp_id + ">" + data.Company[i].comp_name + " </option>");
            }
            $("select[id$='ddlCompanyName']").prepend("<option></option>");
            $("select[id$='ddlCompanyName']").val('');
        return false;
    }
    function onErrorPopulate()
    {
        alert("Failed To Populate Company!");
        return false;
    }
    function textCounter( field, countfield, maxlimit ) {
        if ( field.value.length > maxlimit )
        {
            field.value = field.value.substring( 0, maxlimit );
            return false;
        }
        else
        {
            countfield.value = maxlimit - field.value.length;
        }
    }

     function CatDDL()
     {
         $.ajax({
            type: "POST",
            contentType:"application/json; charset=utf-8",
            url: "frmCompanyInfo.aspx/PopulateCat", 
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
//        var CatID = $("select[id$='ddlCategory']").val();
//        if(CatID == "")
//        {
//            $("select[id$='ddlItem']> option").remove();
//            return false;
//        }
//        if (CatID != "")
//        {
//         $.ajax({
//            type: "POST",
//            contentType:"application/json; charset=utf-8",
//            url: "frmCompanyInfo.aspx/PopulateItems", 
//            data: "{'CatID':'"+CatID+"'}", 
//            async:false,
//            success:onsuccessItemDDL,
//            error:oneErrorItemDDL 
//            });
//        }
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

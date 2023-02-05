<%@ Page Language="C#" MasterPageFile="~/MCTX_Internal/SuperAdmin/MasterAdmin.master"
    AutoEventWireup="true" CodeFile="frmPricingInfo.aspx.cs" Inherits="MCTX_Internal_SuperAdmin_frmPricingInfo"
    Title="Product Pricing" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <script src="../../js/jquery.dataTables.js" type="text/javascript"></script>

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
            <li style="text-align: left"><a href="#tabs-1">Pricing Information</a></li>
        </ul>
        <fieldset style="width: 95%">
            <legend>Add Price Information</legend>
            <table style="width: 100%; font-family: Calibri; font-size: 11pt;">
                <tr>
                    <td align="left" style="width: 140px;">
                        <asp:Label ID="lblCategory" Text="Select Category:" Width="100%" runat="server"></asp:Label>
                    </td>
                    <td align="left" style="width: 168px;">
                        <asp:DropDownList ID="ddlCategory" OnChange="return ItemDDL();" Width="90%" runat="server">
                            
                        </asp:DropDownList>
                    </td>
                    <td align="left" style="width: 150px;">
                    </td>
                    <td>
                    </td>
                </tr>
                <tr>
                    <td align="left" style="width: 140px;">
                        <asp:Label ID="lblItem" Text="Select Item:" Width="100%" runat="server"></asp:Label>
                    </td>
                    <td align="left" style="width: 168px;">
                        <asp:DropDownList ID="ddlItem" Width="90%" runat="server">
                              
                        </asp:DropDownList>
                    </td>
                    <td align="left" style="width: 150px;">
                    </td>
                    <td>
                    </td>
                </tr>
                <tr>
                    <td align="left" style="width: 140px;">
                        <asp:Label ID="lblMinPrice" Text="Minimum Price (PKR):" Width="100%" runat="server"></asp:Label>
                    </td>
                    <td align="left" style="width: 168px;">
                        <asp:TextBox ID="txtMinPrice" Width="90%" onkeypress="return keyRestrict(event,'0123456789')"
                            runat="server" MaxLength="8"></asp:TextBox>
                    </td>
                    <td align="left" style="width: 150px;">
                        <asp:Label ID="lblMinPercent" Text="Commission:" runat="server"></asp:Label>&nbsp;
                        <asp:TextBox ID="txtMinPercent" Width="30%" MaxLength="2" onkeypress="return keyRestrict(event,'0123456789')"
                            runat="server"></asp:TextBox>
                        <asp:Label ID="lblMin" Text="%" runat="server"></asp:Label>
                    </td>
                    <td>
                    </td>
                </tr>
                <tr>
                    <td align="left" style="width: 140px;">
                        <asp:Label ID="lblNormalPrice" Text="Normal Price (PKR):" Width="100%" runat="server"></asp:Label>
                    </td>
                    <td align="left" style="width: 168px;">
                        <asp:TextBox ID="txtNormPrice" Width="90%" onkeypress="return keyRestrict(event,'0123456789')"
                            runat="server" MaxLength="8"></asp:TextBox>
                    </td>
                    <td align="left" style="width: 150px;">
                        <asp:Label ID="lblNormPercent" Text="Commission:" runat="server"></asp:Label>&nbsp;
                        <asp:TextBox ID="txtNormPercent" Width="30%" MaxLength="2" onkeypress="return keyRestrict(event,'0123456789')"
                            runat="server"></asp:TextBox>
                        <asp:Label ID="lblNorm" Text="%" runat="server"></asp:Label>
                    </td>
                    <td>
                    </td>
                </tr>
                <tr>
                    <td align="left" style="width: 140px;">
                        <asp:Label ID="lblMaxPrice" Text="Maximum Price (PKR):" Width="100%" runat="server"></asp:Label>
                    </td>
                    <td align="left" style="width: 168px;">
                        <asp:TextBox ID="txtMaxPrice" Width="90%" onkeypress="return keyRestrict(event,'0123456789')"
                            runat="server" MaxLength="8"></asp:TextBox>
                    </td>
                    <td align="left" style="width: 150px;">
                        <asp:Label ID="lblMaxPercent" Text="Commission:" runat="server"></asp:Label>&nbsp;
                        <asp:TextBox ID="txtMaxPercent" Width="30%" MaxLength="2" onkeypress="return keyRestrict(event,'0123456789')"
                            runat="server"></asp:TextBox>
                        <asp:Label ID="lblMax" Text="%" runat="server"></asp:Label>
                    </td>
                    <td>
                        <asp:TextBox ID="txtPriceID" Width="90%" Style="display: none;" runat="server"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td align="left" style="width: 140px;">
                    </td>
                    <td align="left" style="width: 318px;" colspan="2">
                        <asp:Button ID="btnSave" Text="Save" Style="background-color: #2A4062; color: White;
                            width: 75px;" OnClientClick="return SavePrice();" runat="server" />
                        <asp:Button ID="btnClear" Text="Clear" Style="background-color: #2A4062; color: White;
                            width: 75px;" OnClientClick="return ClearFields();" runat="server" />
                        <asp:Button ID="btnUpdate" Text="Update" Style="background-color: #2A4062; color: White;
                            width: 75px; display: none;" OnClientClick="return updatePriceData();" runat="server" />
                    </td>
                    <td>
                    </td>
                </tr>
            </table>
        </fieldset>
        <fieldset style="width: 95%">
            <legend>Item Price Details</legend>
            <div style="overflow: auto; width: 904px; height: 390px">
                <table id="tblPriceDetails" style="width: 90%;" class="dataTable">
                </table>
            </div>
        </fieldset>
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
    $(document).ready(function(){
        CatDDL();
        RetrieveData();
    });
    function dataTable() {
        oTable= $("#tblPriceDetails").dataTable({
                bPaginate: false,
                bJQueryUI: true,
                bSort: true,
                bInfo: false,
                bRetrieve: true,
                bDestroy: true,
                oLanguage:{"sSearch":"Filter: "}               
            }).fixedHeader({ height: 400});
    }
    function ClearFields()
    {
        $("select[id$='ddlCategory']").val('0');
        $("select[id$='ddlItem']").val('0');
        $("input[id$='txtMinPrice']").val("");
        $("input[id$='txtNormPrice']").val("");
        $("input[id$='txtMaxPrice']").val("");
        $("input[id$='txtShipment']").val("");
        $("input[id$='txtMinPercent']").val("");
        $("input[id$='txtNormPercent']").val("");
        $("input[id$='txtMaxPercent']").val("");
        $("input[id$='btnUpdate']").hide();
        $("input[id$='btnSave']").attr("disabled", false);
        return false;
    }
    function SavePrice()
    {
        var catid = $("select[id$='ddlCategory'] option:selected").val();
        var itemid = $("select[id$='ddlItem'] option:selected").val();
        var MinPrice = $("input[id$='txtMinPrice']").val();
        var MinPercent = $("input[id$='txtMinPercent']").val();
        var NormPrice = $("input[id$='txtNormPrice']").val();
        var NormPercent = $("input[id$='txtNormPercent']").val();
        var MaxPrice = $("input[id$='txtMaxPrice']").val();
        var MaxPercent = $("input[id$='txtMaxPercent']").val();
        if (catid == "")
        {
            alert("Please Select Desired Category!");
            $("input[id$='ddlCategory']").focus();
            return false;
        }
        if (itemid == "")
        {
            alert("Please Select Desired Item!");
            $("input[id$='ddlItem']").focus();
            return false;
        }
        if (MinPrice == "")
        {
            alert("Please Enter Minimum Price!");
            $("input[id$='txtMinPrice']").focus();
            return false;
        }
        if (MinPercent == "")
        {
            alert("Please Enter Profit Percentage on Minimum Price!");
            $("input[id$='txtMinPercent']").focus();
            return false;
        }  
        if (NormPrice == "")
        {
            alert("Please Enter Normal Price!");
            $("input[id$='txtNormPrice']").focus();
            return false;
        }
        if (NormPercent == "")
        {
            alert("Please Enter Profit Percentage on Normal Price!");
            $("input[id$='txtNormPercent']").focus();
            return false;
        }
        if (MaxPrice == "")
        {
            alert("Please Enter Maximum Price!");
            $("input[id$='txtMaxPrice']").focus();
            return false;
        } 
        if (MaxPercent == "")
        {
            alert("Please Enter Profit Percentage on Maximum Price!");
            $("input[id$='txtMaxPercent']").focus();
            return false;
        }       
                $.ajax({
                type: "POST",
                contentType:"application/json; charset=utf-8",
                url: "frmPricingInfo.aspx/SavePriceData", 
                data: "{'catid':'"+catid+"','itemid':'"+itemid+"','MinPrice':'"+MinPrice+"','MinPercent':'"+MinPercent+"','NormPrice':'"+NormPrice+"','NormPercent':'"+NormPercent+"','MaxPrice':'"+MaxPrice+"','MaxPercent':'"+MaxPercent+"'}", 
                success:onsuccessSave,
                error:onretrieveSaveError 
                });
        return false;
    }
    function onsuccessSave()
    {
        ClearFields();
        alert("Record Added Successfully!");
        RetrieveData();
        return false;
    }
    function onretrieveSaveError()
    {
        alert("Error In Saving Data!");
        return false;
    }
    function RetrieveData()
    {
            $.ajax({
            type: "POST",
            contentType:"application/json; charset=utf-8",
            url: "frmPricingInfo.aspx/RetrievePriceData", 
            data: "{}", 
            success:onsuccessRetrieve,
            error:onretrieveError 
            });
        return false;
    }
    function onsuccessRetrieve(msg)
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
                tbl += "<th style='white-space:nowrap; text-align:left; display:none;'>Item Price ID</th>";
                tbl += "<th id='txtDeleteth' style='cursor:Pointer;text-align:center;white-space:nowrap;border:1px solid #999999;'>Del</th>";
                tbl += "<th id='txtEditth' style='cursor:Pointer;text-align:center;white-space:nowrap;border:1px solid #999999;'>Edit</th>";
                tbl += "<th style='white-space:nowrap; text-align:left;'>Item Name</th>";
                tbl += "<th style='white-space:nowrap; text-align:left; display:none;'>Item ID</th>";
                tbl += "<th style='white-space:nowrap; text-align:left;'>Cat Name</th>";
                tbl += "<th style='white-space:nowrap; text-align:left; display:none;'>Cat ID</th>";
                tbl += "<th style='white-space:nowrap; text-align:left;'>Min Price</th>";
                tbl += "<th style='white-space:nowrap; text-align:left;'>Commission</th>";
                tbl += "<th style='white-space:nowrap; text-align:left;'>Normal Price</th>";
                tbl += "<th style='white-space:nowrap; text-align:left;'>Commission</th>";
                tbl += "<th style='white-space:nowrap; text-align:left;'>Max Price</th>";
                tbl += "<th style='white-space:nowrap; text-align:left;'>Commission</th>";
                tbl += "<th style='white-space:nowrap; text-align:left;'>Created By</th>";
                tbl += "<th style='white-space:nowrap; text-align:left;'>Created Date</th>";
                tbl += "<th style='white-space:nowrap; text-align:left;'>Mod By</th>";
                tbl += "<th style='white-space:nowrap; text-align:left;'>Mod Date</th>";
                tbl += "</tr>";
                tbl += "</thead>";
                tbl += "<tbody>";
                for (var i = 0; i < data.PriceDetails.length; i++) {               
                            tbl += "<td style='text-align:left; white-space:nowrap; display:none;' id='txtItemPriceID"+i+"'>" + data.PriceDetails[i].ItemPrice_ID + "</td>";
                            tbl += "<td id='txtDelete"+i+"' align='center' style='border:1px solid #999999;'> <input  type='image' src='image/Cross.png' style='width:16px; border:0px;' onclick='return DeletePrice("+i+");'></td>";
                            tbl += "<td id='txtEdit"+i+"' align='center' style='border:1px solid #999999;'> <input  type='image' src='image/Edit.png' style='width:16px; border:0px;' onclick='return GetRowForUpdation("+i+");'></td>";
                            tbl += "<td style='text-align:left; white-space:nowrap;' id='txtitemname"+i+"'>" + data.PriceDetails[i].item_name + "</td>";   
                            tbl += "<td style='text-align:left; white-space:nowrap; display:none;' id='txtitemid"+i+"'>" + data.PriceDetails[i].item_id + "</td>";                  
                            tbl += "<td style='text-align:left; white-space:nowrap;' id='txtcatname"+i+"'>" + data.PriceDetails[i].cat_name + " </td>";
                            tbl += "<td style='text-align:left; white-space:nowrap; display:none;' id='txtcatid"+i+"'>" + data.PriceDetails[i].cat_id + " </td>";
                            tbl += "<td style='text-align:right;' id='txtminprice"+i+"'>" +  data.PriceDetails[i].MinimumPrice + " </td>";
                            tbl += "<td style='text-align:right;' id='txtminperc"+i+"'>" +  data.PriceDetails[i].MinPercent + " </td>";  
                            tbl += "<td style='text-align:right; white-space:nowrap;' id='txtnormprice"+i+"'>" + data.PriceDetails[i].NormalPrice + " </td>";
                            tbl += "<td style='text-align:right;' id='txtnormperc"+i+"'>" +  data.PriceDetails[i].NormPercent + " </td>";
                            tbl += "<td style='text-align:right; white-space:nowrap;' id='txtmaxprice"+i+"'>" + data.PriceDetails[i].MaximumPrice + " </td>";  
                            tbl += "<td style='text-align:right;' id='txtmaxperc"+i+"'>" +  data.PriceDetails[i].MaxPercent + " </td>";                
                            tbl += "<td style='text-align:left; white-space:nowrap;' id='txtcreatedby"+i+"'>" +  data.PriceDetails[i].CreatedBy + " </td>";
                            tbl += "<td style='text-align:right; white-space:nowrap;' id='txtcreateddate"+i+"'>" + data.PriceDetails[i].CreatedDate + " </td>";
                            tbl += "<td style='text-align:left; white-space:nowrap;' id='txtmodby"+i+"'>" +  data.PriceDetails[i].ModifiedBy + " </td>";
                            tbl += "<td style='text-align:right; white-space:nowrap;' id='txtmoddate"+i+"'>" + data.PriceDetails[i].ModifiedDate + " </td>";
                      tbl += "</tr>";
                }   

                tbl += "</tbody>";
                tbl += "</table>";
                $("#tblPriceDetails").html(tbl);
                //dataTable();
                return false;   
    }
    function onretrieveError()
    {
       alert("Error In Loading Details!");
       return false; 
    }
    function DeletePrice(rowNo)
    {
        var PriceID = $("#txtItemPriceID"+rowNo).html().trim();
        if (confirm("Are you sure you wish to delete this Record?"))
        {
            $.ajax({
                   type: "POST",
                   dataType: "json",
                   contentType: "application/json; charset=utf-8",
                   url: "frmPricingInfo.aspx/DeletePriceDetails",
                   data: "{'PriceID':'"+PriceID+"'}",
                   success: onSuccessDelete,
                   error:OnretrieveError 
                    });
        }
        else
        {
          return false;
        }
        return false;
    }
    function onSuccessDelete()
    {
        alert("Record Successfully Deleted!");
        RetrieveData();
        return false;
    }
    function OnretrieveError()
    {
        alert("Error In Deleting Record!");
        return false;
    }
     function GetRowForUpdation(rowNo)
     {
        var catid = $("#txtcatid"+rowNo).html().trim();
        $("select[id$='ddlCategory']").val(catid);
        ItemDDL();
        var itemid = $("#txtitemid"+rowNo).html().trim();
        $("select[id$='ddlItem']").val(itemid);
        var MaxPrice = $("#txtmaxprice"+rowNo).html().trim();
        $("input[id$='txtMaxPrice']").val(MaxPrice);
        var MaxPerc = $("#txtmaxperc"+rowNo).html().trim();
        $("input[id$='txtMaxPercent']").val(MaxPerc);
        var NormPrice = $("#txtnormprice"+rowNo).html().trim();
        $("input[id$='txtNormPrice']").val(NormPrice);
        var NormPerc = $("#txtnormperc"+rowNo).html().trim()
        $("input[id$='txtNormPercent']").val(NormPerc);
        var MinPrice = $("#txtminprice"+rowNo).html().trim();
        $("input[id$='txtMinPrice']").val(MinPrice);
        var MinPerc = $("#txtminperc"+rowNo).html().trim();
        $("input[id$='txtMinPercent']").val(MinPerc);
        var PriceID = $("#txtItemPriceID"+rowNo).html().trim();
        $("input[id$='txtPriceID']").val(PriceID);
        $("input[id$='btnUpdate']").show();
        $("input[id$='btnSave']").attr("disabled", true);
        return false;
     }
     function updatePriceData()
     {
        var PriceID = $("input[id$='txtPriceID']").val(PriceID);
        var catid = $("select[id$='ddlCategory'] option:selected").val();
        var itemid = $("select[id$='ddlItem'] option:selected").val();
        var MinPrice = $("input[id$='txtMinPrice']").val();
        var MinPercent = $("input[id$='txtMinPercent']").val();
        var NormPrice = $("input[id$='txtNormPrice']").val();
        var NormPercent = $("input[id$='txtNormPercent']").val();
        var MaxPrice = $("input[id$='txtMaxPrice']").val();
        var MaxPercent = $("input[id$='txtMaxPercent']").val();
        if (catid == "")
        {
            alert("Please Select Desired Category!");
            return false;
        }
        if (itemid == "")
        {
            alert("Please Select Desired Item!");
            return false;
        }
        if (MinPrice == "")
        {
            alert("Please Enter Minimum Price!");
            return false;
        }
        if (MinPercent == "")
        {
            alert("Please Enter Profit Percentage on Minimum Price!");
            return false;
        }  
        if (NormPrice == "")
        {
            alert("Please Enter Normal Price!");
            return false;
        }
        if (NormPercent == "")
        {
            alert("Please Enter Profit Percentage on Normal Price!");
            return false;
        }
        if (MaxPrice == "")
        {
            alert("Please Enter Maximum Price!");
            return false;
        } 
        if (MaxPercent == "")
        {
            alert("Please Enter Profit Percentage on Maximum Price!");
            return false;
        }   
            $.ajax({
            type: "POST",
            contentType:"application/json; charset=utf-8",
            url: "frmPricingInfo.aspx/UpdatePriceData", 
            data: "{'PriceID':'"+PriceID+"','catid':'"+catid+"','itemid':'"+itemid+"','MinPrice':'"+MinPrice+"','MinPercent':'"+MinPercent+"','NormPrice':'"+NormPrice+"','NormPercent':'"+NormPercent+"','MaxPrice':'"+MaxPrice+"','MaxPercent':'"+MaxPercent+"'}", 
            success:onsuccessUpdateData,
            error:oneErrorUpdateData 
            });
        return false; 
     }
     function onsuccessUpdateData()
     {
        alert("Record Successfully Updated!");
        RetrieveData();
        ClearFields();
        return false;
     }
     function oneErrorUpdateData()
     {
        alert("Error In Record Updation!");
        RetrieveData();
        return false;
     }
     function CatDDL()
     {
         $.ajax({
            type: "POST",
            contentType:"application/json; charset=utf-8",
            url: "frmPricingInfo.aspx/PopulateCat", 
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
            url: "frmPricingInfo.aspx/PopulateItems", 
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

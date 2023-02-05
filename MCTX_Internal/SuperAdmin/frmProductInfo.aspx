<%@ Page Language="C#" MasterPageFile="~/MCTX_Internal/SuperAdmin/MasterAdmin.master"
    AutoEventWireup="true" CodeFile="frmProductInfo.aspx.cs" Inherits="MCTX_Internal_SuperAdmin_frmProductInfo"
    Title="Mechatronix Product(s)" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajtk" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <script src="../../js/jquery.dataTables.min.js" type="text/javascript"></script>

    <script src="../../js/BlockUI.js" type="text/javascript"></script>

    <script src="../../js/jquery.ajax_upload.0.6.js" type="text/javascript"></script>

    <style type="text/css">
        ul
        {
            list-style: none;
        }
        .example
        {
            padding: 0 20px;
            float: left;
            width: 230px;
        }
        .wrapper
        {
            width: 133px; /* Centering button will not work, so we need to use additional div */
            margin: 0 auto;
        }
        div.button
        {
            height: 29px;
            width: 133px;
            background: url(button.png) 0 0;
            font-size: 14px;
            color: #C7D92C;
            text-align: center;
            padding-top: 15px;
        }
        /* 
    We can't use ":hover" preudo-class because we have
    invisible file input above, so we have to simulate
    hover effect with javascript. 
 */div.button.hover
        {
            background: url(button.png) 0 56px;
            color: #95A226;
        }
        .TextBoxes:focus
        {
            height: 18px;
            font-size: 11pt;
            font-family: Calibri,Verdana, Arial, Helvetica, sans-serif;
            box-shadow: 0 -1px 0 rgba(0, 0, 0, 0.3), 0 1px 2px rgba(0, 0, 0, 0.1) inset, 0 0 10px rgba(255, 255, 255, 0.9);
            border-color: #ABD3FC;
        }
        .TextBoxes
        {
            height: 18px;
            font-size: 10pt;
            font-family: Calibri,Verdana, Arial, Helvetica, sans-serif;
            width: 185px;
            border: 1px solid #CCCCCC;
        }
        textarea:focus
        {
            font-size: 11pt;
            font-family: Calibri,Verdana, Arial, Helvetica, sans-serif;
            box-shadow: 0 -1px 0 rgba(0, 0, 0, 0.3), 0 1px 2px rgba(0, 0, 0, 0.1) inset, 0 0 10px rgba(255, 255, 255, 0.9);
            border-color: #ABD3FC;
        }
        textarea
        {
            font-size: 10pt;
            font-family: Calibri,Verdana, Arial, Helvetica, sans-serif;
            width: 185px;
            height: 50px;
            border: 1px solid #CCCCCC;
        }
        SELECT
        {
            font-family: Calibri,Verdana, Arial, Helvetica, sans-serif;
            width: 187px;
            font-size: 11px;
            border: 1px solid #CCCCCC;
            height: 19px;
        }
        SELECT:focus
        {
            border-color: #ABD3FC;
            font-family: Calibri,Verdana, Arial, Helvetica, sans-serif;
            font-weight: bold;
            font-size: 11px;
            box-shadow: 0 -1px 0 rgba(0, 0, 0, 0.3), 0 1px 2px rgba(0, 0, 0, 0.1) inset, 0 0 10px rgba(255, 255, 255, 0.9);
        }
        OPTION
        {
            font-family: Calibri,Verdana, Arial, Helvetica, sans-serif;
            font-weight: normal;
        }
    </style>
    <%-- <script type="text/javascript">        /*<![CDATA[*/
        $(document).ready(function() {

            /* example 1 */
            var button = $('#button1'), interval;

            $.ajax_upload(button, {
                action: 'FileHandler.ashx',
                name: 'myfile',
                onSubmit: function(file, ext) {
                    // change button text, when user selects file			
                    button.text('Uploading');

                    // If you want to allow uploading only 1 file at time,
                    // you can disable upload button
                    this.disable();

                    // Uploding -> Uploading. -> Uploading...
                    interval = window.setInterval(function() {
                        var text = button.text();
                        if (button.text().length < 13) {
                            button.text(button.text() + '.');
                        } else {
                            button.text('Uploading');
                        }
                    }, 200);
                },
                onComplete: function(file, response) {
                    button.text('Upload');
                    var Image = "";
                    // Although plugins emulates hover effect automatically,
                    // it doens't work when button is disabled
                    button.removeClass('hover');

                    window.clearInterval(interval);

                    // enable upload button
                    this.enable();

                    // add file to the list
                    $('<li></li>').appendTo('#example1 .files').text(file);
                }
            });


        });   /*]]>*/</script>--%>
    <table style="width: 100%; height: 288px;">
        <tr>
            <td valign="top" style="height: 331px">
                <div id="tabs">
                    <ul>
                        <li style="text-align: left"><a href="#tabs-1">Categories</a></li>
                        <li style="text-align: left"><a href="#tabs-2">Products</a></li>
                    </ul>
                    <div id="tabs-1">
                        <table style="width: 950px; height: 224px;">
                            <tr>
                                <td style="width: 100%; vertical-align: top">
                                    <table style="width: 100%" align="center">
                                        <tr>
                                            <td>
                                                <fieldset>
                                                    <legend>Category</legend>
                                                    <table align="center" style="width: 35%">
                                                        <tr>
                                                            <td style="width: 104px; text-align: left;">
                                                                <b>Category Name</b>
                                                            </td>
                                                            <td style="text-align: left; border-width: 0px">
                                                                <asp:TextBox CssClass="TextBoxes" onkeypress="return keyRestrict(event,',-_&/. 0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ')"
                                                                    ID="txtCategory" MaxLength="25" runat="server"></asp:TextBox>
                                                            </td>
                                                            <td style="text-align: left; display: none">
                                                                <asp:TextBox ID="txtProductID" runat="server"></asp:TextBox>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td style="text-align: left;" colspan="2">
                                                                <asp:Label ID="lblMessage" runat="server"></asp:Label>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                            </td>
                                                            <td style="text-align: left">
                                                                <asp:Button ID="btnNew" runat="server" BackColor="#ABD3FC" Text="New" OnClientClick="return ClearAll();" />
                                                                <asp:Button ID="btnSaveProduct" runat="server" Text="Save/ Update" BackColor="#ABD3FC"
                                                                    OnClientClick="SaveProduct(); return false;" />
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </fieldset>
                                            </td>
                                            <td align="left" rowspan="2">
                                                &nbsp;
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <fieldset style="width: 100">
                                                    <legend>Main Product Infomation</legend>
                                                    <div>
                                                        <table id="tblProductInfo" width="100%" class="dataTable">
                                                            <tr>
                                                                <th>
                                                                    Delete
                                                                </th>
                                                                <th>
                                                                    Edit
                                                                </th>
                                                                <th>
                                                                    Product Name
                                                                </th>
                                                                <th>
                                                                    Created By
                                                                </th>
                                                                <th>
                                                                    Created Date
                                                                </th>
                                                                <th>
                                                                    Modified By
                                                                </th>
                                                                <th>
                                                                    Modified Date
                                                                </th>
                                                            </tr>
                                                        </table>
                                                    </div>
                                                </fieldset>
                                            </td>
                                            <%--<td style="vertical-align: top; width: 618px; text-align: left;" align="center">
                                            </td>--%>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                        </table>
                    </div>
                    <div id="tabs-2">
                        <table style="width: 100%; height: 20px;">
                            <tr>
                                <td style="width: 100%; vertical-align: top">
                                    <fieldset>
                                        <legend>New Products</legend>
                                        <table align="center" style="width: 100%">
                                            <tr>
                                                <td style="text-align: left; width: 128px">
                                                    <b>Category</b>
                                                </td>
                                                <td align="left">
                                                    <asp:DropDownList ID="ddlCategory" runat="server">
                                                    </asp:DropDownList>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="text-align: left; width: 128px">
                                                    <b>Brand</b>
                                                </td>
                                                <td align="left">
                                                    <asp:TextBox onkeypress="return keyRestrict(event,',-_#&/. 0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ')"
                                                        ID="txtBrand_Name" CssClass="TextBoxes" MaxLength="25" runat="server"></asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="text-align: left; width: 128px">
                                                    <b>Product Name</b>
                                                </td>
                                                <td align="left">
                                                    <asp:TextBox ID="txtBrand" onkeypress="return keyRestrict(event,',-_#&/. 0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ')"
                                                        CssClass="TextBoxes" MaxLength="35" runat="server"></asp:TextBox>
                                                </td>
                                                <td style="display: none">
                                                    <asp:TextBox CssClass="TextBoxes" ID="txthiddenItem_Id" runat="server"></asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="text-align: left; width: 128px">
                                                    <b>Origin</b>
                                                </td>
                                                <td align="left">
                                                    <asp:DropDownList ID="ddlOrigin" runat="server">
                                                    </asp:DropDownList>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="text-align: left; width: 128px">
                                                    <b>Model No</b>
                                                </td>
                                                <td align="left">
                                                    <asp:TextBox ID="txtModelNo" onkeypress="return keyRestrict(event,',-_#&/. 0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ')"
                                                        MaxLength="30" CssClass="TextBoxes" runat="server"></asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="text-align: left; width: 128px">
                                                    <b>Item Code</b>
                                                </td>
                                                <td align="left">
                                                    <asp:TextBox ID="txtItemCode" onkeypress="return keyRestrict(event,',-_#&/. 0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ')"
                                                        MaxLength="30" CssClass="TextBoxes" runat="server"></asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="text-align: left; width: 128px">
                                                    <b>Mechatronix Code</b>
                                                </td>
                                                <td align="left">
                                                    <asp:TextBox ID="txtMctx_Item_Code" MaxLength="30" onkeypress="return keyRestrict(event,',-_#&/. 0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ')"
                                                        CssClass="TextBoxes" runat="server"></asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="text-align: left; width: 128px">
                                                    <b>Warranty (Months)</b>
                                                </td>
                                                <td align="left">
                                                    <asp:TextBox ID="txtWarrenty" onkeypress="return keyRestrict(event,'0123456789')"
                                                        CssClass="TextBoxes" MaxLength="6" runat="server"></asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="text-align: left; width: 128px">
                                                    <b>Warranty (With Parts)</b>
                                                </td>
                                                <td align="left">
                                                    <asp:DropDownList ID="ddl_Warranty_With_Parts" runat="server">
                                                        <asp:ListItem Value="Yes" Text="Yes"></asp:ListItem>
                                                        <asp:ListItem Value="No" Text="No"></asp:ListItem>
                                                    </asp:DropDownList>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="text-align: left; width: 128px">
                                                    <b>Lead Time (Weeks)</b>
                                                </td>
                                                <td align="left">
                                                    <asp:TextBox ID="txtLeaveTime" onkeypress="return keyRestrict(event,',-_&/. 0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ')"
                                                        CssClass="TextBoxes" MaxLength="35" runat="server"></asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="text-align: left; width: 128px">
                                                    <b>Technology Officer</b>
                                                </td>
                                                <td align="left">
                                                    <asp:DropDownList ID="ddlEmlpoyees_Officer" runat="server">
                                                    </asp:DropDownList>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="text-align: left; width: 128px; display: none">
                                                    <b>Product Image</b>
                                                </td>
                                                <td align="left" style="display: none">
                                                    <ul>
                                                        <li id="example1" class="example">
                                                            <p>
                                                                You can style button as you want</p>
                                                            <div class="wrapper">
                                                                <div id="button1" class="button">
                                                                    Upload</div>
                                                            </div>
                                                            <p>
                                                                Uploaded files:</p>
                                                            <ol class="files">
                                                            </ol>
                                                        </li>
                                                    </ul>
                                                    <%-- <asp:FileUpload ID="fuProduct_Image" runat="server" Height="21px" />--%>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="text-align: left; width: 128px">
                                                    <b>Item Description</b>
                                                </td>
                                                <td align="left">
                                                    <asp:TextBox onkeypress="textCounter(this,this.form.counter,1000);return keyRestrict(event,',-_&#/. 0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ')"
                                                        ID="txtEqSerDes" MaxLength="1000" runat="server" Height="65px" TextMode="MultiLine"></asp:TextBox>
                                                    <input type="text" style="width: 25px;" disabled="disabled" name="counter" maxlength="3"
                                                        size="3" value="1000" onblur="textCounter(this.form.counter,this,1000);">
                                                    chars remaining
                                                </td>
                                            </tr>
                                            <tr>
                                                <td colspan="2" style="text-align: left">
                                                    <asp:Label ID="lblMessage1" runat="server"></asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td colspan="2" style="">
                                                    <asp:Button ID="btnNewItem" runat="server" Style="width:60px;height:30px;" BackColor="#ABD3FC" OnClientClick="return ClearItems();"
                                                        Text="New" />
                                                    <asp:Button ID="btnSave1" runat="server"  Style="width:60px;height:30px;" BackColor="#ABD3FC" OnClientClick="return SaveItem();"
                                                        Text="Save" />
                                                </td>
                                            </tr>
                                        </table>
                                    </fieldset>
                                    <table>
                                        <tr>
                                            <td align="center" colspan="2">
                                                <div style="overflow: auto; height: 500px; width: 950px">
                                                    <table id="tblItems" width="100%" class="dataTable">
                                                    </table>
                                                </div>
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
    <style type="text/css">
        .dataTable
        {
            font-family: Verdana, Arial, Helvetica, sans-serif;
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
        .style7
        {
            width: 158px;
        }
        .style8
        {
            width: 124px;
        }
        .style9
        {
            width: 266px;
        }
        input:focus
        {
            box-shadow: 0 -1px 0 rgba(0, 0, 0, 0.3), 0 1px 2px rgba(0, 0, 0, 0.1) inset, 0 0 10px rgba(255, 255, 255, 0.9);
        }
        textarea:focus
        {
            box-shadow: 0 -1px 0 rgba(0, 0, 0, 0.3), 0 1px 2px rgba(0, 0, 0, 0.1) inset, 0 0 10px rgba(255, 255, 255, 0.9);
        }
    </style>

    <script type="text/javascript" language="javascript">

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
            
            loadProductInfo();
            LoadCategoryItems();
            Load_CategoriesDDL();
            var flag = "";
            var deleted = "";
        });


        //-----------------------------------------------------------------------Add Display update and Delete Categories------ Obaid Altaf March 15, 2012
        function loadProductInfo() {

            $.ajax({
                type: "POST",
                dataType: "json",
                contentType: "application/json; charset=utf-8",
                url: "frmProductInfo.aspx/GetProductInfo",
                data: "{}",
                success: onsuccessGetResult,
                error: OnretrieveError
            });
            return false;

        }
        function onsuccessGetResult(msg) {
            var data = msg.d;
            var tbl = "";
            var currentDate = "";
            var TimeFrom = "";
            var TimeTo = "";
            tbl += "<thead>";
            tbl += "<tr>";
            tbl += "<th id='txtDeleteth' style='cursor:Pointer;text-align:center;white-space:nowrap;border:1px solid #999999;'>Delete</th>";
            tbl += "<th id='txtEditth' style='cursor:Pointer;text-align:center;white-space:nowrap;border:1px solid #999999;'>Edit</th>";
            tbl += "<th style='cursor:Pointer;text-align:left;white-space:nowrap;border:1px solid #999999;'>Product Name</th>";
            tbl += "<th style='cursor:Pointer;text-align:left;white-space:nowrap;border:1px solid #999999;'>Created By</th>";
            tbl += "<th style='cursor:Pointer;text-align:left;white-space:nowrap;border:1px solid #999999;'>Created Date</th>";
            tbl += "<th style='cursor:Pointer;text-align:left;white-space:nowrap;border:1px solid #999999;'>Modified By</th>";
            tbl += "<th style='cursor:Pointer;text-align:left;white-space:nowrap;border:1px solid #999999;'>Modified Date</th>";
            tbl += "</tr>";
            tbl += "</thead>";
            tbl += "<tbody>";
            for (var i = 0; i < data.ProductDetails.length; i++) {
                tbl += "<tr id='trmain" + i + "' style='cursor:default;border:1px solid #999999;'>";
                tbl += "<td id='txtDelete" + i + "' align='center' style='border:1px solid #999999;'> <input  type='image' src='image/Cross.png' onclick='return DeleteExpRecord(" + i + ");'></td>";
                tbl += "<td id='txtEdit" + i + "' align='center' style='border:1px solid #999999;'> <input  type='image' src='image/Edit.png' onclick='return GetRowForUpdation(" + i + ");'></td>";
                tbl += "<td id='txtProductName" + i + "' align='left'  style='white-space:nowrap;font-weight:bold;border:1px solid #999999;'>" + data.ProductDetails[i].CAT_NAME + " </td>";
                tbl += "<td align='left'  style='white-space:nowrap;border:1px solid #999999;'>" + data.ProductDetails[i].CREATED_BY + " </td>";
                tbl += "<td align='left'  style='white-space:nowrap;border:1px solid #999999;'>" + data.ProductDetails[i].CREATED_DATE + " </td>";
                tbl += "<td align='left'  style='white-space:nowrap;border:1px solid #999999;'>" + data.ProductDetails[i].MODIFIED_BY + " </td>";
                tbl += "<td align='left'  style='white-space:nowrap;border:1px solid #999999;'>" + data.ProductDetails[i].MODIFIED_DATE + " </td>";
                tbl += "<td id='txtProductID" + i + "' align='left'  style='white-space:nowrap;border:1px solid #999999;display:none'>" + data.ProductDetails[i].CAT_ID + " </td>";
                tbl += "</tr>";
            }

            tbl += "</tbody>";
            tbl += "</table>";
            $("#tblProductInfo").html(tbl);
        }
        function OnretrieveError() {

        }

        function SaveProduct() { //save update and delete Categories
            var ProductID = "0";

            if ($("input[id$='txtProductID']").val() == "") { //insert case
                ProductID = $("input[id$='txtProductID']").val();
                var ProductName = $("input[id$='txtCategory']").val().trim();
                deleted = "0";
                flag = "true";
                SaveUpdateORDeleteMainProduct(ProductID, ProductName, deleted, flag);
                $("input[id$='txtCategory']").val("");
                $("input[id$='txtProductID']").val("");
                //$("input[id$='txtProductID']").val() = "";
            }
            else if ($("input[id$='txtProductID']").val() != "") {
                if (flag == "delete") { //delete case
                    ProductID = $("input[id$='txtProductID']").val();
                    var ProductName = $("input[id$='txtCategory']").val().trim();
                    deleted = "1";
                    flag = "delete";
                    SaveUpdateORDeleteMainProduct(ProductID, ProductName, deleted, flag);
                    //After Deletion empty text boxes
                    $("input[id$='txtCategory']").val("");
                    $("input[id$='txtProductID']").val("");
                }
                else // update case
                {
                    if (confirm("You are about to update product?")) {
                        ProductID = $("input[id$='txtProductID']").val();
                        var ProductName = $("input[id$='txtCategory']").val().trim();
                        deleted = "0";
                        flag = "false";
                        SaveUpdateORDeleteMainProduct(ProductID, ProductName, deleted, flag);
                        //After Updation empty text boxes
                        $("input[id$='txtCategory']").val("");
                        $("input[id$='txtProductID']").val("");
                    }
                    else
                        return false;
                }
            }
        }

        function GetRowForUpdation(rowNo) {
            flag = "false";
            deleted = "0";
            $("input[id$='txtCategory']").val($("#txtProductName" + rowNo).html().trim());
            $("input[id$='txtProductID']").val($("#txtProductID" + rowNo).html().trim());
            return false;
        }


        function DeleteExpRecord(rowNo) {

            if (confirm("You are about to delete this item?")) {

                $("input[id$='txtCategory']").val($("#txtProductName" + rowNo).html().trim());
                $("input[id$='txtProductID']").val($("#txtProductID" + rowNo).html().trim());
                flag = "delete";
                deleted = "1";
                SaveProduct();
                LoadCategoryItems();
                return false;
            }
            else
                return false;
        }

        function SaveUpdateORDeleteMainProduct(ProductID, cat_name, deleted, flag) {
            $.ajax({
                type: "POST",
                dataType: "json",
                contentType: "application/json; charset=utf-8",
                url: "frmProductInfo.aspx/SaveMainProduct",
                data: "{'ProductID':'" + ProductID + "','cat_name':'" + cat_name + "','deleted':'" + deleted + "','flag':'" + flag + "'}",
                success: onsuccessSaveMainProduct,
                error: OnretrieveError
            });
            return false;

        }

        function onsuccessSaveMainProduct() {
            alert("Done.");
            loadProductInfo();
            Load_CategoriesDDL();
            LoadCategoryItems();
            return false;
        }
        function ClearAll() {
            $("input[id$=txtCategory]").val("");
            $("input[id$=txtProductID]").val("");
            return false;
        }

        //--------------------------------------------------------Save & Retrive Items -------Against Category-------by Obaid-------------------



        //-------------------------Load Items -----------------------
        function LoadCategoryItems() {

            $.ajax({
                type: "POST",
                dataType: "json",
                contentType: "application/json; charset=utf-8",
                url: "frmProductInfo.aspx/LoadCategoryItems",
                data: "{}",
                success: onsuccessGetItems,
                error: OnErrorGetItems
            });
            return false;

        }

        function onsuccessGetItems(msg) {

            var data = msg.d;
            var tblItems = "";

            tblItems += "<thead>";
            tblItems += "<tr>";
            tblItems += "<th id='txtDeleteth' style='cursor:Pointer;text-align:center;white-space:nowrap;border:1px solid #999999;'>Delete</th>";
            tblItems += "<th id='txtEditth' style='cursor:Pointer;text-align:center;white-space:nowrap;border:1px solid #999999;'>Edit</th>";
            tblItems += "<th style='cursor:Pointer;text-align:left;white-space:nowrap;border:1px solid #999999;display:none'>OrigionId</th>";
            tblItems += "<th style='cursor:Pointer;text-align:left;white-space:nowrap;border:1px solid #999999;display:none'>ItemId</th>";
            tblItems += "<th style='cursor:Pointer;text-align:left;white-space:nowrap;border:1px solid #999999;display:none'>CatId</th>";
            tblItems += "<th style='cursor:Pointer;text-align:left;white-space:nowrap;border:1px solid #999999;'>Product</th>";
            tblItems += "<th style='cursor:Pointer;text-align:left;white-space:nowrap;border:1px solid #999999;'>Category</th>";
            tblItems += "<th style='cursor:Pointer;text-align:left;white-space:nowrap;border:1px solid #999999;'>Model</th>";

            tblItems += "<th style='cursor:Pointer;text-align:left;white-space:nowrap;border:1px solid #999999;'>Brand</th>";
            tblItems += "<th style='cursor:Pointer;text-align:left;white-space:nowrap;border:1px solid #999999;'>Mctx Code</th>";
            tblItems += "<th style='cursor:Pointer;text-align:left;white-space:nowrap;border:1px solid #999999;display:none'>Technical Officer</th>";
            tblItems += "<th style='cursor:Pointer;text-align:left;white-space:nowrap;border:1px solid #999999;'>Technology Officer</th>";
            tblItems += "<th style='cursor:Pointer;text-align:left;white-space:nowrap;border:1px solid #999999;'>Warranty W/Parts</th>";
            tblItems += "<th style='cursor:Pointer;text-align:left;white-space:nowrap;border:1px solid #999999;'>Lead Time</th>";

            tblItems += "<th style='cursor:Pointer;text-align:left;white-space:nowrap;border:1px solid #999999;'>Description</th>";
            tblItems += "<th style='cursor:Pointer;text-align:left;white-space:nowrap;border:1px solid #999999;display:none'>Description</th>";
            tblItems += "<th style='cursor:Pointer;text-align:left;white-space:nowrap;border:1px solid #999999;'>Item Code</th>";
            tblItems += "<th style='cursor:Pointer;text-align:left;white-space:nowrap;border:1px solid #999999;'>Warranty</th>";
            tblItems += "</tr>";
            tblItems += "</thead>";
            tblItems += "<tbody>";

            var desc = "";
            for (var i = 0; i < data.Get_Items.length; i++) {

                if (data.Get_Items[i].description == "" || data.Get_Items[i].description == null) {
                    desc = "";
                }
                else
                    desc = data.Get_Items[i].description.toString().substring(0, 25);

                tblItems += "<tr id='trmain" + i + "' style='cursor:default;border:1px solid #999999;'>";
                tblItems += "<td id='txtDelete_Item" + i + "' align='center' style='border:1px solid #999999;'> <input  type='image' src='image/Cross.png' onclick='return DeleteItem(" + i + ")'></td>";
                tblItems += "<td id='txtEdit_Item" + i + "' align='center' style='border:1px solid #999999;'> <input  type='image' src='image/Edit.png' onclick='return EditItem(" + i + ")'></td>";
                tblItems += "<td id='txtOrigionId_Item" + i + "' align='left'  style='white-space:nowrap;border:1px solid #999999;display:none'>" + data.Get_Items[i].origin_id + " </td>";
                tblItems += "<td id='txtItemId_Item" + i + "' align='left'  style='white-space:nowrap;border:1px solid #999999;display:none'>" + data.Get_Items[i].item_id + " </td>";
                tblItems += "<td id='txtCategoryId_Item" + i + "' align='left'  style='white-space:nowrap;border:1px solid #999999;display:none'>" + data.Get_Items[i].cat_id + " </td>";
                tblItems += "<td id='txtitem_name_Item" + i + "' align='left'  style='white-space:nowrap;border:1px solid #999999;font-weight:bold'>" + data.Get_Items[i].item_name + " </td>";
                tblItems += "<td id='txtCat_Name_Item" + i + "' align='left'  style='white-space:nowrap;border:1px solid #999999;'>" + data.Get_Items[i].cat_name + " </td>";
                tblItems += "<td id='txtmodel_no_Item" + i + "' align='left'  style='white-space:nowrap;border:1px solid #999999;'>" + data.Get_Items[i].model_no + " </td>";

                tblItems += "<td id='tdBrand_Name_Item" + i + "' align='left'  style='white-space:nowrap;border:1px solid #999999;'>" + data.Get_Items[i].Brand_Name + " </td>";
                tblItems += "<td id='tdMctx_Code_Item" + i + "' align='left'  style='white-space:nowrap;border:1px solid #999999;'>" + data.Get_Items[i].Mctx_Code + " </td>";
                tblItems += "<td id='tdTechnical_Officer_Item" + i + "' align='left'  style='white-space:nowrap;border:1px solid #999999;display:none'>" + data.Get_Items[i].Technical_Officer + " </td>";
                tblItems += "<td id='tdTechnical_Name_Item" + i + "' align='left'  style='white-space:nowrap;border:1px solid #999999;'>" + data.Get_Items[i].E_Name + " </td>";
                tblItems += "<td id='tdWarranty_With_Parts_Item" + i + "' align='left'  style='white-space:nowrap;border:1px solid #999999;'>" + data.Get_Items[i].Warranty_With_Parts + " </td>";
                tblItems += "<td id='tdLeave_Time_Item" + i + "' align='left'  style='white-space:nowrap;border:1px solid #999999;'>" + data.Get_Items[i].Leave_Time + " </td>";

                tblItems += "<td id='txtdescription_Item" + i + "' align='left'  style='white-space:nowrap;border:1px solid #999999' title=" + data.Get_Items[i].description + ">" + desc + " </td>";
                tblItems += "<td id='txtitem_Description_Item_Update" + i + "' align='left'  style='white-space:nowrap;border:1px solid #999999;display:none'>" + data.Get_Items[i].description + " </td>";
                tblItems += "<td id='txtitem_code_Item" + i + "' align='left'  style='white-space:nowrap;border:1px solid #999999'>" + data.Get_Items[i].item_code + " </td>";
                tblItems += "<td id='txtwarrenty_Item" + i + "' align='left'  style='white-space:nowrap;border:1px solid #999999'>" + data.Get_Items[i].warrenty + " </td>";
                tblItems += "</tr>";
            }
            tblItems += "</tbody>";
            tblItems += "</table>";
            $("#tblItems").html(tblItems);

        }

        function OnErrorGetItems() {
            alert("Problem in loading Items");
        }
        //-------------------------Delete Items -----------------------
        function DeleteItem(rowid) {
            if (confirm("You are about to delete this record?")) {
                $("input[id$='txthiddenItem_Id']").val($("#txtItemId_Item" + rowid).text().trim());
                var flagItems = "delete";
                SaveItem(flagItems);

            }
            return false;
            //var Description = $("#txtitem_Description_Item_Update").text().trim();
        }

        //-------------------------Update Items -----------------------
        function ClearItems() {
            $("[id$='ddlCategory'] :selected").val();
            $("input[id$=txtBrand]").val("");
            $("[id$='ddlOrigin'] :selected").val();
            $("input[id$=txtModelNo]").val("");
            $("input[id$=txtItemCode]").val("");
            $("input[id$=txtWarrenty]").val("");
            $("textarea[id$='txtEqSerDes']").val("");
            $("input[id$='txthiddenItem_Id']").val("");

            $("input[id$='txtBrand_Name']").val("");
            $("input[id$='txtMctx_Item_Code']").val("");
            //            $("[id$='ddl_Warranty_With_Parts'] :selected").text();
            //            $("[id$='ddlEmlpoyees_Officer'] :selected").text();
            $("input[id$='txtLeaveTime']").val("");
            return false;
        }

        function EditItem(rowno) {
            $("[id$='ddlCategory']").val($('#txtCategoryId_Item' + rowno).text().trim());
            $("input[id$='txthiddenItem_Id']").val($("#txtItemId_Item" + rowno).text().trim());
            $("input[id$=txtBrand]").val($('#txtitem_name_Item' + rowno).text().trim());
            $("[id$='ddlOrigin']").val($('#txtOrigionId_Item' + rowno).text().trim());
            $("input[id$=txtModelNo]").val($('#txtmodel_no_Item' + rowno).text().trim());
            $("input[id$=txtItemCode]").val($('#txtitem_code_Item' + rowno).text().trim());
            $("input[id$=txtWarrenty]").val($('#txtwarrenty_Item' + rowno).text().trim());
            $("textarea[id$='txtEqSerDes']").val($('#txtitem_Description_Item_Update' + rowno).text().trim());

            $("input[id$=txtBrand_Name]").val($('#tdBrand_Name_Item' + rowno).text().trim());
            $("input[id$=txtMctx_Item_Code]").val($('#tdMctx_Code_Item' + rowno).text().trim());
            $("[id$='ddl_Warranty_With_Parts']").val($('#tdWarranty_With_Parts_Item' + rowno).text().trim());
            $("[id$='ddlEmlpoyees_Officer']").val($('#tdTechnical_Officer_Item' + rowno).text().trim());
            $("input[id$=txtLeaveTime]").val($('#tdLeave_Time_Item' + rowno).text().trim());
            return false;
        }

        function SaveItem(flagItems) //Save Update and Delete Items
        {
            var ItemId = $("input[id$='txthiddenItem_Id']").val().trim();
            var deleted = "";
            if (ItemId == "" || ItemId == null) //Insert case
            {
                var Category_Id = $("[id$='ddlCategory'] :selected").val().trim();
                var ItemName = $("input[id$=txtBrand]").val().trim();
                var Origion = $("[id$='ddlOrigin'] :selected").val().trim();
                var ModelNo = $("input[id$=txtModelNo]").val().trim();
                var ItemCode = $("input[id$=txtItemCode]").val().trim();
                var Warrenty = $("input[id$=txtWarrenty]").val().trim();
                var Description = $("textarea[id$='txtEqSerDes']").val().trim();

                var BrandName = $("input[id$='txtBrand_Name']").val().trim();
                var Mctx_Item_Code = $("input[id$='txtMctx_Item_Code']").val().trim();
                var Warranty_With_Parts = $("[id$='ddl_Warranty_With_Parts'] :selected").text();
                var Technical_Officer = $("[id$='ddlEmlpoyees_Officer'] :selected").val();
                var Item_Leave_Time = $("input[id$='txtLeaveTime']").val().trim();
                var Image = "";

                deleted = "0";
                flagItems = "true";
                Save_Up_Del_Items(ItemId, Category_Id, ItemName, ModelNo, Description, Warrenty, ItemCode, Origion, BrandName, Mctx_Item_Code, Warranty_With_Parts, Technical_Officer, Item_Leave_Time, deleted, flagItems);
                ClearItems();
                return false;
            }

            else if ($("input[id$='txthiddenItem_Id']").val().trim() != "") {
                if (flagItems == "delete") { //delete case
                    var Category_Id = $("[id$='ddlCategory'] :selected").val().trim();
                    var ItemName = $("input[id$=txtBrand]").val().trim();
                    var Origion = $("[id$='ddlOrigin'] :selected").val().trim();
                    var ModelNo = $("input[id$=txtModelNo]").val().trim();
                    var ItemCode = $("input[id$=txtItemCode]").val().trim();
                    var Warrenty = $("input[id$=txtWarrenty]").val().trim();
                    var Description = $("textarea[id$='txtEqSerDes']").val().trim();
                    var BrandName = $("input[id$='txtBrand_Name']").val().trim();
                    var Mctx_Item_Code = $("input[id$='txtMctx_Item_Code']").val().trim();
                    var Warranty_With_Parts = $("[id$='ddl_Warranty_With_Parts'] :selected").text();
                    var Technical_Officer = $("[id$='ddlEmlpoyees_Officer'] :selected").val();
                    var Item_Leave_Time = $("input[id$='txtLeaveTime']").val().trim();

                    deleted = "1";
                    flagItems = "delete";
                    Save_Up_Del_Items(ItemId, Category_Id, ItemName, ModelNo, Description, Warrenty, ItemCode, Origion, BrandName, Mctx_Item_Code, Warranty_With_Parts, Technical_Officer, Item_Leave_Time, deleted, flagItems);
                    ClearItems();
                    return false;
                }
                else // update case
                {
                    if (confirm("You are about to update Item?")) {
                        var Category_Id = $("[id$='ddlCategory'] :selected").val().trim();
                        var ItemName = $("input[id$=txtBrand]").val().trim();
                        var Origion = $("[id$='ddlOrigin'] :selected").val().trim();
                        var ModelNo = $("input[id$=txtModelNo]").val().trim();
                        var ItemCode = $("input[id$=txtItemCode]").val().trim();
                        var Warrenty = $("input[id$=txtWarrenty]").val().trim();
                        var Description = $("textarea[id$='txtEqSerDes']").val().trim();

                        var BrandName = $("input[id$='txtBrand_Name']").val().trim();
                        var Mctx_Item_Code = $("input[id$='txtMctx_Item_Code']").val().trim();
                        var Warranty_With_Parts = $("[id$='ddl_Warranty_With_Parts'] :selected").text();
                        var Technical_Officer = $("[id$='ddlEmlpoyees_Officer'] :selected").val();
                        var Item_Leave_Time = $("input[id$='txtLeaveTime']").val().trim();

                        deleted = "0";
                        flagItems = "false";
                        Save_Up_Del_Items(ItemId, Category_Id, ItemName, ModelNo, Description, Warrenty, ItemCode, Origion, BrandName, Mctx_Item_Code, Warranty_With_Parts, Technical_Officer, Item_Leave_Time, deleted, flagItems);
                        ClearItems();
                        return false;
                    }
                }
            }
        }


        function Save_Up_Del_Items(item_id, cat_id, item_name, modelno, description, Warrenty, Itemcode, Origin, BrandName, Mctx_Item_Code, Warranty_With_Parts, Technical_Officer, Item_Leave_Time, deleted, flag) {
            $.ajax({
                type: "POST",
                dataType: "json",
                contentType: "application/json; charset=utf-8",
                url: "frmProductInfo.aspx/SaveProduct",
                data: "{'item_id':'" + item_id + "','cat_id':'" + cat_id + "','item_name':'" + item_name + "','modelno':'" + modelno + "','description':'" + description + "','Warrenty':'" + Warrenty + "','Itemcode':'" + Itemcode + "','Origin':'" + Origin + "','BrandName':'" + BrandName + "','Mctx_Item_Code':'" + Mctx_Item_Code + "','Warranty_With_Parts':'" + Warranty_With_Parts + "','Technical_Officer':'" + Technical_Officer + "','Item_Leave_Time':'" + Item_Leave_Time + "','deleted':'" + deleted + "','flag':'" + flag + "'}",
                success: onsuccessItem,
                error: OnErrorItem
            });
            return false;
        }

        function onsuccessItem() {
            alert("Done.");
            LoadCategoryItems();
            return false;
        }

        function OnErrorItem() {
            alert("Error in Saving Product!");
            return false;
        }

        //------------------------------------------------Load Categories ;)--- by Obaid Altaf------------------------------------//

        function Load_CategoriesDDL() {
            $.ajax({
                type: "POST",
                dataType: "json",
                contentType: "application/json; charset=utf-8",
                url: "frmProductInfo.aspx/Load_CategoriesDDL",
                data: "",
                success: OnSuccessLoad_CategoriesDDL,
                error: OnErrorLoad_CategoriesDDL
            });
            return false;
        }

        function OnSuccessLoad_CategoriesDDL(msg) {
            var data = msg.d;
            $("select[id$=ddlCategory]> option").remove();
            for (var i = 0; i <= data.Categories.length - 1; i++) {

                $("select[id$='ddlCategory']").append("<option value=" + data.Categories[i].cat_id + ">" + data.Categories[i].cat_name + "</option>");
            }
            $("select[id$='ddlCategory']").prepend("<option></option>");
            return false;
        }
        function OnErrorLoad_CategoriesDDL() {
            alert("Error in loading Categories!");
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
    </script>

</asp:Content>

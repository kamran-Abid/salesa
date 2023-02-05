<%@ Page Title="" Language="C#" MasterPageFile="~/MCTX_Internal/SuperAdmin/MasterAdmin.master" AutoEventWireup="true" CodeFile="CostingIndexItems.aspx.cs" Inherits="MCTX_Internal_SuperAdmin_CostingIndexItem_" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

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
    <script type="text/javascript">
        var oTable;

        $(document).ready(function () {
            $("input[id$='btnUpdateItem']").hide();
            getCostingItem();
        });

        function dataTable() {
            oTable = $("#tblitemDetail").dataTable({
                bPaginate: true,
                bJQueryUI: true,
                bSort: true,
                bInfo: true,
                bRetrieve: true,
                bDestroy: true,
                oLanguage: { "sSearch": "Filter: " }
            });
        }

        function blockUI() {
            $.blockUI({
                message: '<img src="image/ajax-loader.gif" />',
                css: { borderStyle: 'none', backgroundColor: "Transparent" }
            });
        }

        function unblockUI() {
            $.unblockUI();
        }

        function AddCategoryItem() {
            var catId = $("select[id$='ddlCatName']").val();          
            var ItemName = $("input[id$='txtItemName']").val().trim();           
            var ItemRate = $("input[id$='txtItemRate']").val().trim();
            var ItemUnit = $("input[id$='txtItemUnit']").val().trim();
            var SourceName = $("input[id$='txtSourceName']").val().trim();
            var SourcePhone = $("input[id$='txtPhoneNo']").val().trim();
            var SourceAddress = $("input[id$='txtSourceAddress']").val().trim();

            if (catId == "") {
                alert("Please enter Category name!");
                return false;
            }
            
           
            $.ajax({
                type: "POST",
                dataType: "json",
                contentType: "application/json; charset=utf-8",
                url: "CostingIndexItems.aspx/AddCostingItem",
                async: false,               
                data: "{'catId':'" + catId + "','ItemName':'" + ItemName + "','ItemRate':'" + ItemRate + "','ItemUnit':'" + ItemUnit + "','SourceName':'" + SourceName + "','SourcePhone':'" + SourcePhone + "','SourceAddress':'" + SourceAddress + "'}",
                success: OnSuccessAddCostingItem,
                error: OnErrorAddCostingItem
            });
            return false;
        }
        function OnSuccessAddCostingItem() {
            alert("New Item Saved!");

            Clear_Client();
            return false;
        }
        function OnErrorAddCostingItem() {
            alert("Error in Saving Item!");
            return false;
        }


        function getCostingItem()
        {
           // blockUI();
            $.ajax({
                type: "POST",
                contentType:"application/json; charset=utf-8",
                url: "CostingIndexItems.aspx/GetCostingIndexItem",
                data: "{}", 
                success:onsuccessgetCostingItem,
                error:onErrorgetCostingItem
            });
            return false;
        }
        function onsuccessgetCostingItem(msg)
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

            tbl += "<th  style='white-space:nowrap; text-align:left; display:none;'>ID</th>";
            tbl += "<th  style='white-space:nowrap; text-align:left; display:none;'>ID</th>";
            tbl += "<th id='txtEditth' style='cursor:Pointer;text-align:center;white-space:nowrap;border:1px solid #999999;'>Edit</th>";
            tbl += "<th style='white-space:nowrap; text-align:left;'>Item Name</th>";
            tbl += "<th style='white-space:nowrap; text-align:left;'>Category Name</th>";
            tbl += "<th style='white-space:nowrap; text-align:left;'>Item Rate</th>";
            tbl += "<th style='white-space:nowrap; text-align:left;'>Item Unit</th>";
            tbl += "<th style='white-space:nowrap; text-align:left;'>Source Name</th>";
            tbl += "<th style='white-space:nowrap; text-align:left;'>Source Phone No</th>";
            tbl += "<th style='white-space:nowrap; text-align:left;'>Source Address</th>";
            tbl += "<th style='white-space:nowrap; text-align:left;'>Creation Date</th>";
            tbl += "<th style='white-space:nowrap; text-align:left;'>Created By</th>";

            tbl += "</tr>";
            tbl += "</thead>";

            tbl += "<tbody>";
            for (var i = 0; i < data.itemDiscription.length; i++) {
                tbl += "<tr><td style='text-align:left; white-space:nowrap; display:none;' id='txtitemID" + i + "'>" + data.itemDiscription[i].costing_item__Id + "</td>";
                tbl += "<td style='text-align:left; white-space:nowrap; display:none;' id='txtCatID" + i + "'>" + data.itemDiscription[i].category_item__Id + "</td>";
                tbl += "<td id='txtEdit"+i+"' align='center' style='border:1px solid #999999;'> <input  type='image' src='image/Edit.png' style='width:16px; border:0px;' onclick='return GetRowForUpdation("+i+");'></td>";
                tbl += "<td style='text-align:left; white-space:nowrap;' id='txtitemName" + i + "'>" + data.itemDiscription[i].costing_item__Name + "</td>";
                tbl += "<td style='text-align:left; white-space:nowrap;' id='txtitemCatDate" + i + "'>" + data.itemDiscription[i].costing_item_category_Name + "</td>";
                tbl += "<td style='text-align:left; white-space:nowrap;' id='txtitemRate" + i + "'>" + data.itemDiscription[i].costing_item__rate + "</td>";
                tbl += "<td style='text-align:left; white-space:nowrap;' id='txtitemUnit" + i + "'>" + data.itemDiscription[i].costing_item__units + "</td>";
                tbl += "<td style='text-align:left; white-space:nowrap;' id='txtitemSourceName" + i + "'>" + data.itemDiscription[i].costing_item__source_name + "</td>";
                tbl += "<td style='text-align:left; white-space:nowrap;' id='txtsourcPhoneNo" + i + "'>" + data.itemDiscription[i].costing_item__source_phone_no + "</td>";
                tbl += "<td style='text-align:left; white-space:nowrap;' id='txtsourceAddress" + i + "'>" + data.itemDiscription[i].costing_item__source_address + "</td>";
                tbl += "<td style='text-align:left; white-space:nowrap;' id='txtitemCreationDate" + i + "'>" + data.itemDiscription[i].costing_item__date + "</td>";
                tbl += "<td style='text-align:left; white-space:nowrap;' id='txtitemCreatedBy" + i + "'>" + data.itemDiscription[i].costing_item_category_created_by + "</td>";

                tbl += "</tr>";
            }   

            tbl += "</tbody>";
            tbl += "</table>";
            $("#tblitemDetail").html(tbl);
            //unblockUI();
            dataTable();
            return false;   
        }
        function onErrorgetCostingItem()
        {
            alert("Error In items Details!");
            return false;
        }


        function GetRowForUpdation(rowNo) {
            var itemID = $("#txtitemID" + rowNo).html().trim();
            $("input[id$='txtitemID']").val(itemID);
            var catID = $("#txtCatID" + rowNo).html().trim();
            $("select[id$='ddlCatName']").val(catID);
            var itemName = $("#txtitemName" + rowNo).html().trim();
            $("input[id$='txtItemName']").val(itemName);
            var itemRate = $("#txtitemRate" + rowNo).html().trim();
            $("input[id$='txtItemRate']").val(itemRate);
            var itemUnit = $("#txtitemUnit" + rowNo).html().trim();
            $("input[id$='txtItemUnit']").val(itemUnit);
            var sourceName = $("#txtitemSourceName" + rowNo).html().trim();
            $("input[id$='txtSourceName']").val(sourceName);

            var phoneNo = $("#txtsourcPhoneNo" + rowNo).html().trim();
            $("input[id$='txtPhoneNo']").val(phoneNo);
            var address = $("#txtsourceAddress" + rowNo).html().trim();
            $("input[id$='txtSourceAddress']").val(address);




            $("input[id$='btnAddItem']").hide();
            $("input[id$='btnUpdateItem']").show();
            return false;
        }

        function ClearData()
        {
            
            $("input[id$='txtitemID']").val('');           
            $("select[id$='ddlCatName']").val(0);          
            $("input[id$='txtItemName']").val('');         
            $("input[id$='txtItemRate']").val('');          
            $("input[id$='txtItemUnit']").val('');          
            $("input[id$='txtSourceName']").val('');         
            $("input[id$='txtPhoneNo']").val('');           
            $("input[id$='txtSourceAddress']").val('');
            $("input[id$='btnAddItem']").show();
            $("input[id$='btnUpdateItem']").hide();
            return false;

        }

        function UpdateItem() {
            var itemId = $("input[id$='txtitemID']").val().trim();
         
          
            var catId = $("select[id$='ddlCatName']").val();
            var ItemName = $("input[id$='txtItemName']").val().trim();
            var ItemRate = $("input[id$='txtItemRate']").val().trim();
            var ItemUnit = $("input[id$='txtItemUnit']").val().trim();
            var SourceName = $("input[id$='txtSourceName']").val().trim();
            var SourcePhone = $("input[id$='txtPhoneNo']").val().trim();
            var SourceAddress = $("input[id$='txtSourceAddress']").val().trim();         

          

            $.ajax({
                type: "POST",
                dataType: "json",
                contentType: "application/json; charset=utf-8",
                url: "CostingIndexItems.aspx/UpdateCostingItem",
                async: false,
                data: "{'itemId':'" + itemId + "','catId':'" + catId + "','ItemName':'" + ItemName + "','ItemRate':'" + ItemRate + "','ItemUnit':'" + ItemUnit + "','SourceName':'" + SourceName + "','SourcePhone':'" + SourcePhone + "','SourceAddress':'" + SourceAddress + "'}",
                success: OnSuccessUpdateCostingItem,
                error: OnErrorUpdateCostingItem
            });
            return false;
        }
        function OnSuccessUpdateCostingItem() {
            alert("Item Description Updated!");
            getCostingItem();
            $("input[id$='txtitemID']").val('');
            $("select[id$='ddlCatName']").val(0);
            $("input[id$='txtItemName']").val('');
            $("input[id$='txtItemRate']").val('');
            $("input[id$='txtItemUnit']").val('');
            $("input[id$='txtSourceName']").val('');
            $("input[id$='txtPhoneNo']").val('');
            $("input[id$='txtSourceAddress']").val('');
            $("input[id$='btnAddItem']").show();
            $("input[id$='btnUpdateItem']").hide();

            return false;
        }
        function OnErrorUpdateCostingItem() {
            alert("Error in Updating Category!");
            return false;
        }
      
    </script>
     <div id="tabs" style="width: 95%;">
        <ul>
            <li style="text-align: left"><a href="#tabs-1">Costing Category & Details</a></li>
        </ul>
      
        <fieldset style="width:100%; padding:2%">
            <legend>Add/Update Costing Index Category</legend>
            <table style="width: 100%; font-family: Calibri; font-size: 11pt;">
                <tr>
                    <td style="width: 50%;">
                        <fieldset style="width: 90%">
                            <table style="width: 100%; font-family: Calibri; font-size: 11pt;">
                               <tr>
                                    <td align="left" style="width: 140px;">
                                        <asp:Label ID="Label1" Text="Select Category:" runat="server"></asp:Label>
                                    </td>
                                    <td align="left" style="width: 300px;">
                                       <asp:DropDownList ID="ddlCatName" runat="server"></asp:DropDownList>
                                    </td>
                                    <td align="left" style="width: 140px;">
                                        <asp:Label ID="Label2" Text="Item Name:" runat="server"></asp:Label>
                                    </td>
                                    <td align="left" style="width: 300px;">
                                        <asp:TextBox ID="txtItemName" Width="95%"  runat="server" BackColor="White"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="left" style="width: 140px;">
                                        <asp:Label ID="lblSales" Text="Item Rate:" runat="server"></asp:Label>
                                    </td>
                                    <td align="left" style="width: 300px;">
                                        <asp:TextBox ID="txtItemRate" Width="95%"  runat="server" BackColor="White"></asp:TextBox>
                                    </td>
                                     <td align="left" style="width: 140px;">
                                        <asp:Label ID="Label3" Text="Item Unit:" runat="server"></asp:Label>
                                    </td>
                                    <td align="left" style="width: 300px;">
                                        <asp:TextBox ID="txtItemUnit" Width="95%"  runat="server" BackColor="White"></asp:TextBox>
                                    </td>
                                   
                                </tr>
                                 <tr>
                                    <td align="left" style="width: 140px;">
                                        <asp:Label ID="Label4" Text="Source Name:" runat="server"></asp:Label>
                                    </td>
                                    <td align="left" style="width: 300px;">
                                        <asp:TextBox ID="txtSourceName" Width="95%"  runat="server" BackColor="White"></asp:TextBox>
                                    </td>
                                     <td align="left" style="width: 140px;">
                                        <asp:Label ID="Label5" Text="Phone No:" runat="server"></asp:Label>
                                    </td>
                                    <td align="left" style="width: 300px;">
                                        <asp:TextBox ID="txtPhoneNo" Width="95%"  runat="server" BackColor="White"></asp:TextBox>
                                    </td>
                                   
                                </tr>
                                <tr>
                                     <td align="left" style="width: 140px;">
                                        <asp:Label ID="Label6" Text="Source Address:" runat="server"></asp:Label>
                                    </td>
                                    <td align="left" style="width: 300px;">
                                        <asp:TextBox ID="txtSourceAddress" Width="95%"  runat="server" BackColor="White"></asp:TextBox>
                                    </td>
                                     <td align="left" colspan="2"  >
                                          <asp:TextBox ID="txtitemID" Style="display: none" runat="server"></asp:TextBox>
                                        <asp:Button ID="btnAddItem" Text="Add Items" Style="background-color: #2A4062;
                                            color: White; width: 84px" OnClientClick="return AddCategoryItem();" runat="server"  />
                                        <asp:Button ID="btnUpdateItem" Text="Update Item" Style="background-color: #2A4062;
                                            color: White; width: 100px" OnClientClick="return UpdateItem();" runat="server"   />
                                   
                                         <asp:Button ID="Button1" Text="Clear" Style="background-color: #2A4062;
                                            color: White; width: 100px" OnClientClick="return ClearData();" runat="server"  />

                                    </td>
                                </tr>
                                </table>
                        </fieldset>
                    </td>
                    
                </tr>
            </table>
        </fieldset>

          <br />
        <fieldset style="width: 100%;padding:2%">
            <legend style="text-align: left;">Category Details</legend>
           
            <div id="Div1" style="overflow: auto; width: 100%; height: 300px;" runat="server">
                <table id="tblitemDetail" class="dataTable">
                </table>
            </div>
        </fieldset>
    </div>
</asp:Content>


<%@ Page Title="" Language="C#" MasterPageFile="~/MCTX_Internal/SuperAdmin/MasterAdmin.master" AutoEventWireup="true" CodeFile="CostingIndexItem.aspx.cs" Inherits="MCTX_Internal_CostingIndexItem" %>



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
            $("input[id$='btnUpdateCategory']").hide();
            getCategoryName();
        });

        function dataTable() {
            oTable = $("#tblCategory").dataTable({
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
          
            var catName = $("input[id$='txtCategory']").val().trim();
           

           
            if (catName == "") {
                alert("Please enter Category name!");
                return false;
            }
            

            $.ajax({
                type: "POST",
                dataType: "json",
                contentType: "application/json; charset=utf-8",
                url: "CostingIndexCategory.aspx/AddCostingCategory",
                async: false,
                data: "{'catName':'" + catName + "'}",
                success: OnSuccessAdd_Category,
                error: OnErrorAdd_Category
            });
            return false;
        }
        function OnSuccessAdd_Category() {
            alert("New Category Saved!");

            Clear_Client();
            return false;
        }
        function OnErrorAdd_Category() {
            alert("Error in Saving Category!");
            return false;
        }


        function getCategoryName()
        {
           // blockUI();
            $.ajax({
                type: "POST",
                contentType:"application/json; charset=utf-8",
                url: "CostingIndexCategory.aspx/GetCategory",
                data: "{}", 
                success:onsuccessgetCategoryName,
                error:onErrorgetCategoryName
            });
            return false;
        }
        function onsuccessgetCategoryName(msg)
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
            tbl += "<th id='txtEditth' style='cursor:Pointer;text-align:center;white-space:nowrap;border:1px solid #999999;'>Edit</th>";
            tbl += "<th style='white-space:nowrap; text-align:left;'>Category Name</th>";            
            tbl += "<th style='white-space:nowrap; text-align:left;'>Creation Date</th>";
            tbl += "<th style='white-space:nowrap; text-align:left;'>Created By</th>";

            tbl += "</tr>";
            tbl += "</thead>";

            tbl += "<tbody>";
            for (var i = 0; i < data.CatDiscription.length; i++) {
                tbl += "<tr><td style='text-align:left; white-space:nowrap; display:none;' id='txtCatID" + i + "'>" + data.CatDiscription[i].costing_item_category_Id + "</td>";
                tbl += "<td id='txtEdit"+i+"' align='center' style='border:1px solid #999999;'> <input  type='image' src='image/Edit.png' style='width:16px; border:0px;' onclick='return GetRowForUpdation("+i+");'></td>";
                tbl += "<td style='text-align:left; white-space:nowrap;width:60%;' id='txtCatName" + i + "'>" + data.CatDiscription[i].costing_item_category_Name + "</td>";
                tbl += "<td style='text-align:left; white-space:nowrap;' id='txtCatCreationDate" + i + "'>" + data.CatDiscription[i].costing_item_category_created_date + "</td>";
                tbl += "<td style='text-align:left; white-space:nowrap;' id='txtCatCreatedBy" + i + "'>" + data.CatDiscription[i].costing_item_category_created_by + "</td>";

              
                tbl += "</tr>";
            }   

            tbl += "</tbody>";
            tbl += "</table>";
            $("#tblCategory").html(tbl);
            //unblockUI();
            dataTable();
            return false;   
        }
        function onErrorgetCategoryName()
        {
            alert("Error In Loading Employee Details!");
            return false;
        }


        function GetRowForUpdation(rowNo) {
            var ID = $("#txtCatID" + rowNo).html().trim();
            $("input[id$='txtCatID']").val(ID);
            var EmpID = $("#txtCatName" + rowNo).html().trim();
            $("input[id$='txtCategory']").val(EmpID);
            $("input[id$='btnAddCategory']").hide();
            $("input[id$='btnUpdateCategory']").show();
            return false;
        }

        function ClearData()
        {
            $("input[id$='txtCatID']").val('');
            $("input[id$='txtCategory']").val('');
            $("input[id$='btnAddCategory']").show();
            $("input[id$='btnUpdateCategory']").hide();
            return false;

        }

        function UpdateCategory() {
            var catID = $("input[id$='txtCatID']").val().trim();
            var catName = $("input[id$='txtCategory']").val().trim();
          


            if (catName == "") {
                alert("Please enter Category name!");
                return false;
            }


            $.ajax({
                type: "POST",
                dataType: "json",
                contentType: "application/json; charset=utf-8",
                url: "CostingIndexCategory.aspx/UpdateCostingCategory",
                async: false,
                data: "{'catID':'" + catID + "','catName':'" + catName + "'}",
                success: OnSuccessUpdate_Category,
                error: OnErrorUpdate_Category
            });
            return false;
        }
        function OnSuccessUpdate_Category() {
            alert("Category Updated!");
            getCategoryName();
            $("input[id$='txtCatID']").val('');
            $("input[id$='txtCategory']").val('');
            $("input[id$='btnAddCategory']").show();
            $("input[id$='btnUpdateCategory']").hide();
            return false;
        }
        function OnErrorUpdate_Category() {
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
                                        <asp:Label ID="lblSales" Text="Category Description:" runat="server"></asp:Label>
                                    </td>
                                    <td align="left" style="width: 300px;">
                                        <asp:TextBox ID="txtCategory" Width="95%"  runat="server" BackColor="White"></asp:TextBox>
                                    </td>
                                     <td align="left" style="width: 140px;">
                                        <asp:Label ID="Label1" Text="Select Category:" runat="server"></asp:Label>
                                    </td>
                                    <td align="left" style="width: 300px;">
                                       <asp:DropDownList ID="ddlCategory" runat="server"></asp:DropDownList>
                                    </td>
                                    
                                </tr>
                                <tr>
                                    <td align="left" colspan="2">
                                          <asp:TextBox ID="txtCatID" Style="display: none" runat="server"></asp:TextBox>
                                        <asp:Button ID="btnAddCategory" Text="Add Category" Style="background-color: #2A4062;
                                            color: White; width: 84px" OnClientClick="return AddCategoryItem();" runat="server"  />
                                        <asp:Button ID="btnUpdateCategory" Text="Update Category" Style="background-color: #2A4062;
                                            color: White; width: 100px" OnClientClick="return UpdateCategory();" runat="server"  />                                    
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
                <table id="tblCategory" class="dataTable">
                </table>
            </div>
        </fieldset>
    </div>
</asp:Content>
<%@ Page Title="" Language="C#" MasterPageFile="~/MCTX_Internal/SuperAdmin/MasterAdmin.master" AutoEventWireup="true" CodeFile="Workshop_Product.aspx.cs" Inherits="MCTX_Internal_SuperAdmin_Workshop_Product" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <script src="../../js/jquery.dataTables.min.js" type="text/javascript"></script>

    <script src="../../js/BlockUI.js" type="text/javascript"></script>

    <script src="../../js/jquery.fixedheader.js" type="text/javascript"></script>

    <script src="../../js/jqModal.js" type="text/javascript"></script>

   
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
        input[type=text] {
    padding: 0;
    height: 20px;
    position: relative;
    left: 0;
    outline: none;
    border: 1px solid #cdcdcd;
    border-color: rgba(0,0,0,.15);
    background-color: white;
    font-size: 11px;
}
.advancedSearchTextbox {
    width: 526px;
    margin-right: -4px;
}
    </style>
    <div id="tabs" style="width: 100%;">
        <ul>
           
             <li style="text-align: left"><a href="#tabs-2">Add/Modify  Product</a></li>
          
            
        </ul>
        
      <div id="tabs-2" style="width: 98%">
            <fieldset id="fldAddProduct" runat="server" style="width:92%; padding:2%">
                <legend>Add Product</legend>
                <table width="100%" style="font-family: Calibri; font-size: 11pt;" >
                    <tr>
                        <td width="140px" align="left">
                            <asp:Label ID="Label2" Text="Product Name:" runat="server"></asp:Label>
                        </td>
                        <td   style="width: 300px;">
                            <asp:TextBox ID="txtProductName" Width="95%"  runat="server" BackColor="White" ></asp:TextBox>
                        </td>
                          <td width="140px" align="left">
                            <asp:Label ID="Label3" Text="Select Project:" runat="server"></asp:Label>
                        </td>
                        <td colspan="1" width="200px" align="left">
                            <asp:DropDownList ID="ddlProject" Width="95%" runat="server">
                        </asp:DropDownList>
                        </td>
                        <td  align="left">
                            <asp:TextBox ID="txtProductIds" Style="display: none;" runat="server"></asp:TextBox>
                        </td>
                        
                    </tr>
                    <tr>
                        <td colspan="5">
                            &nbsp;
                        </td>
                    </tr>
                    <tr>

                        <td colspan="3">
                            &nbsp;
                        </td>
                        <td colspan="2"  align="left">
                            <asp:Button ID="btnAddProduct" Text="Add" Style="background-color: #273D5F; color: White;"
                                Width="75px" OnClientClick="return SaveProduct();" runat="server" />
                        
                            <asp:Button ID="btnClearProduct" Text="Clear" Style="background-color: #273D5F; color: White;"
                                Width="75px" OnClientClick="return ClearProduct();" runat="server" />
                        
                            <asp:Button ID="btnUpdateProduct" Text="Update" Style="background-color: #273D5F; color: White;
                                display: none;" Width="75px" OnClientClick="return updateProduct();" runat="server" />
                        </td>
                    </tr>
                </table>
            </fieldset>

            <div id="divProduct" style="overflow: auto;width:100%;" >
            <fieldset id="fldProductDetail" runat="server" style="width:92%; padding:2%; height: 400px;">
                <legend>Product Details</legend>
                <table id="tblProductDetail" class="dataTable">
                </table>
	</fieldset>
        </div>
        </div>   
	
    </div>

    <script type="text/javascript" language="javascript">
    var oTable,oTable;
    $(document).ready(function () {
       
        getProduct();
    });
      

    function dataTableProduct() {
        oTable = $("#tblProductDetail").dataTable({
            bPaginate: true,
            bJQueryUI: true,
            bSort: true,
            bInfo: true,
            bRetrieve: true,
            bDestroy: true,
            oLanguage: { "sSearch": "Filter: " }
        });
        $("#tblProductDetail_length").css("text-align", "left");
        $("#tblProductDetail_filter").css("text-align", "left");
        
    }
      
    //------------------------------------------------------- Product ---------------------------------------------------------------------------
      function SaveProduct() {
          var PrductName = $("input[id$='txtProductName']").val().trim();
          var ProjectID = $("select[id$='ddlProject']").val().trim();
          if (PrductName == "") {
              alert("Please Enter Product Name!");
              return false;
          }
          if (ProjectID == "-- Select --") {
              alert("Please Select Project!");
              return false;
          }
          $.ajax({
              type: "POST",
              contentType: "application/json; charset=utf-8",
              url: "Workshop_Product.aspx/SaveProduct",
              data: "{'PrductName':'" + PrductName + "','ProjectID':'" + ProjectID + "'}",
              success: onsuccessSaveProduct,
              error: onretrieveSaveProductError
          });
          return false;
      }
      function onsuccessSaveProduct() {
          alert("Data Successfully Saved!");
          $("input[id$='txtProductName']").val("");
          $("select[id$='ddlProject']").val("-- Select --");
          getProduct();
          return false;
      }
      function onretrieveSaveProductError() {
          alert("Error In Saving Data!");
          return false;
      }


      function getProduct() {
          $.ajax({
              type: "POST",
              contentType: "application/json; charset=utf-8",
              url: "Workshop_Product.aspx/getProductDetails",
              data: "{}",
              success: onsuccessgetProduct,
              error: onretrievegetProduct
          });
          return false;
      }
      function onsuccessgetProduct(msg) {
          var data = msg.d;
          if (oTable != null) {
              oTable.fnClearTable();
              oTable.fnDestroy();
          }
         
          var tbl = "";
          tbl += "<thead>";
          tbl += "<tr>";

          tbl += "<th style='text-align:center; white-space:nowrap;'>Edit</th>";
          tbl += "<th style='text-align:left; white-space:nowrap; display:none;'>Project ID</th>";
          tbl += "<th style='text-align:left; white-space:nowrap; display:none;'>Product ID</th>";
          tbl += "<th style='white-space:nowrap; text-align:left;'>Product Name</th>";
          tbl += "<th style='white-space:nowrap; text-align:left;'>Project Name</th>";
         
          tbl += "<th style='white-space:nowrap; text-align:left;'>Created By</th>";
          tbl += "<th style='white-space:nowrap; text-align:left;'>Created Date</th>";
          tbl += "<th style='white-space:nowrap; text-align:left;'>Modified By</th>";
          tbl += "<th style='white-space:nowrap; text-align:left;'>Modified Date</th>";
          tbl += "</tr>";
          tbl += "</thead>";
          tbl += "<tbody>";
          for (var i = 0; i < data.ProductDetails.length; i++) {

              tbl += "<td style='cursor:Pointer;' id='txtUpdate' align='center' onclick='return EditProductRecord(" + i + ");'><img src='image/Edit.png'></td>";
              tbl += "<td style='text-align:right; white-space:nowrap; display:none;' id='txtProductID" + i + "'>" + data.ProductDetails[i].Product_id + "</td>";
              tbl += "<td style='text-align:right; white-space:nowrap; display:none;' id='txtProjID" + i + "'>" + data.ProductDetails[i].Project_id + "</td>";
              tbl += "<td style='text-align:left; white-space:nowrap;' id='txtProductName" + i + "'>" + data.ProductDetails[i].Product_name + "</td>";
              tbl += "<td style='text-align:left; white-space:nowrap;' id='txtProjectNames" + i + "'>" + data.ProductDetails[i].Project_Name + "</td>";
              tbl += "<td style='text-align:left; white-space:nowrap;' id='txtCreatedBy" + i + "'>" + data.ProductDetails[i].created_by + "</td>";
              tbl += "<td style='text-align:right; white-space:nowrap;' id='txtCreatedDate" + i + "'>" + data.ProductDetails[i].created_date + " </td>";
              tbl += "<td style='text-align:left; white-space:nowrap;' id='txtModBy" + i + "'>" + data.ProductDetails[i].modified_by + " </td>";
              tbl += "<td style='text-align:right; white-space:nowrap;' id='txtModDate" + i + "'>" + data.ProductDetails[i].modified_date + " </td>";
              tbl += "</tr>";
          }
          tbl += "</tbody>";
          tbl += "</table>";
          $("#tblProductDetail").html(tbl);
          dataTableProduct();
          return false;
      }
      function onretrievegetProduct() {
          alert("Error In Loading Details!");
          return false;
      }

       function ClearProduct()
      {
        $("input[id$='txtProductName']").val("");
          $("select[id$='ddlProject']").val("-- Select --");
        $("input[id$='btnUpdateProduct']").hide();
        $("input[id$='btnAddProduct']").attr("disabled", false);
        return false;
      }
   

    function EditProductRecord(rowNo)
      {
          var ProductID = $("#txtProductID"+rowNo).html().trim();
          $("input[id$='txtProductIds']").val(ProductID);

          var ProductName = $("#txtProductName"+rowNo).html().trim();
          $("input[id$='txtProductName']").val(ProductName);

          var Projid = $("#txtProjID" + rowNo).html().trim();
          $("select[id$='ddlProject']").val(Projid);

          
          $("input[id$='btnUpdateProduct']").show();
          $("input[id$='btnAddProduct']").attr("disabled", true);
          return false;
      }

      function updateProduct()
      {
        var ProductID =  $("input[id$='txtProductIds']").val();;

       var PrductName = $("input[id$='txtProductName']").val().trim();
          var ProjectID = $("select[id$='ddlProject']").val().trim();
          if (PrductName == "") {
              alert("Please Enter Product Name!");
              return false;
          }
          if (ProjectID == "-- Select --") {
              alert("Please Select Project!");
              return false;
          }
        $.ajax({
            type: "POST",
            contentType:"application/json; charset=utf-8",
             url: "Workshop_Product.aspx/UpdateProduct",
            data: "{'ProductID':'"+ProductID+"','PrductName':'"+PrductName+"','ProjectID':'"+ProjectID+"'}", 
            success:onsuccessupdateProduct,
            error:onretrieveupdateProduct 
        });
        return false; 
      }
      function onsuccessupdateProduct()
      {
        alert("Record Updated Successfully!");
        getProduct();
        Clear();
        return false;
      }
      function onretrieveupdateProduct()
      {
        alert("Error In Updating Record!");
        return false;
      }
     
    
    </script>
</asp:Content>


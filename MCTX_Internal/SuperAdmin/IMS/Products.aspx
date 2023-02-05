<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Products.aspx.cs" Inherits="MCTX_Internal_SuperAdmin_IMS_Products"  %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Products Detail</title>
     <script src="js/jquery-2.1.4.min.js"></script>
     <%--<script src="js/jquery.blockUI.js"></script>--%>
    <script src="js/jquery.dataTables.min.js"></script>
    <link href="css/jquery.dataTables.min.css" rel="stylesheet" />
    <link href="css/modal-popup.css" rel="stylesheet" />
</head>
<body>
    <form id="form1" runat="server">
        <div id="main"  style="background-color:#fafafa;">
        <div>
        <a class="js-open-modal" href="#" data-modal-id="stock">
            <img src="img/add_items.jpg"  style="width:20px;" />Add Stock </a>&nbsp;
        <a class="js-open-modal" href="#" data-modal-id="Items">
            <img src="img/add_items.jpg"  style="width:20px;" />Add New Items </a><br /><br />
            </div>
        <div id="imsproducts">
        </div>
        <div id="stock" class="modal-box">
            <header>
                <a href="#" class="js-modal-close close" onclick="dataupdated();">×</a>
                <h3>Stock</h3>
            </header>
            <div class="modal-body">
                <asp:Label runat="server" Text="Produts"></asp:Label>
                <asp:DropDownList ID="ddlProductName" Width="24%" runat="server">
                        </asp:DropDownList>
                <asp:Label runat="server" Text="Category"></asp:Label>
                  <asp:DropDownList ID="ddlCategory" Width="24%" runat="server">
                        </asp:DropDownList>
                <asp:Label runat="server" Text="Stock In"></asp:Label>
                <asp:TextBox runat="server" ID="TxtStockIn"></asp:TextBox>
            </div>
            <footer>
          
                <input type="button" value="Clear" onclick="popupclearbutton();" />
                <input type="button" value="Add Category" onclick="updatestock();" />
        
            </footer>
        </div>
        <div id="Items" class="modal-box">
            <header>
                <a href="#" class="js-modal-close close" onclick="dataupdated();">×</a>
                <h3>Add New Items</h3>
            </header>
            <div class="modal-body">
                <asp:Label runat="server" Text="Produts"></asp:Label>
                <asp:TextBox runat="server" ID="TxtInsProducts"></asp:TextBox>
                <asp:Label runat="server" Text="Category"></asp:Label>
                <asp:TextBox runat="server" ID="TxtInsCategory"></asp:TextBox>
                <asp:Label runat="server" Text="Stock In"></asp:Label>
                <asp:TextBox runat="server" ID="TxtInsStockin"></asp:TextBox>
            </div>
            <footer>
                <input type="button" value="Clear" onclick="popupclearbutton();" />
                <input type="button" value="Add Category" onclick="insertstock();" />
        
            </footer>
        </div>
            </div>
    </form>
</body>
</html>

<script lang="ja" type="text/javascript">
    $(window).load(function () {   
        getdata();
        setTimeout(
  function () {
      $('#myTable').DataTable();
  }, 900);     
    });

    //spinner code------------------------------------------------------------------------------------------------------------------------------------
  //  $(document).ajaxStart(BlockUI).ajaxStop(UnblockUI);

    //------------------------------------------------------------------------------------------------------------------------------------------------
  //  function BlockUI() {
   //     $("Div.boxcenter-content").block({ message: "<img src='../img/spinner.gif'>", css: { border: '0 Transparent', backgroundColor: 'Transparent' } })
   // }
    //--------------------------------------------------------------------------------------------------------------------------------------------
  //  function UnblockUI() {
   //     $("Div.boxcenter-content").unblock();
  //  }
    //spinner code End----------------------------------------------------------------------------------------------------------------------------

    function getdata() {
        $.ajax({
            type: "POST",
            dataType: "json",
            contentType: "application/json; charset=utf-8",
            url: "Products.aspx/getvalues",
            data: {},
            success: OnGetMessages,
            error: function (x) {
                alert(x.responseText);
            }
        });
    }
    function OnGetMessages(data) {
        data = data.d;
        var quantity_remaining = '';
        var tableproducts = '';

        tableproducts += "<table id='myTable' class='display' cellspacing='0' cellpadding='0' width='100%'>";
        tableproducts += "<thead><tr>";
        tableproducts += "<th>Products</th><th>Category</th><th>Total Stock</th><th>Quantity Issue</th><th>Quantity in Stock</th>";
        tableproducts += "</tr></thead><tbody>";

        for (var i = 0; i < data.ims.length; i++) {
            quantity_remaining = (data.ims[i].TOTAL_STOCK - data.ims[i].QUANTITY_ISSUE);
            tableproducts += "<tr><td>" + data.ims[i].PRODUCTS_NAME + "</td><td>" + data.ims[i].CATEGORY_ID + "</td><td>" + data.ims[i].TOTAL_STOCK + "</td><td>" + data.ims[i].QUANTITY_ISSUE + "</td><td>" + quantity_remaining + "</td></tr>";
        }
        tableproducts += "</tbody></table>";
        $('#imsproducts').html(tableproducts);
    }
       ////////////////////////////////////Update Stock//////////////////////////////////////////////////////////////

    function popupclearbutton() {
        $("select[id$='ddlProductName']").val('');
        $("select[id$='ddlCategory']").val('');
        $("#TxtCategory").val('');
        $("#TxtStockIn").val('');
        $("#TxtInsProducts").val('');
        $("#TxtInsCategory").val('');
        $("#TxtInsStockin").val('');
    }
    
    function updatestock() {
        //var FromDate = $("input[id$='txtFromDate']").val().trim();
        //var ToDate = $("input[id$='txtToDate']").val().trim();

         var new_stock = '';
        var remaining_Quantity = '';
        var Product_name = '';
        var updateProduct_name = '';
        var TxtStockIn = '';

        $('#imsproducts').each(function () {
            debugger;               
            remaining_Quantity = $(this).find('td:eq(4)').text().trim();
            Product_name = $(this).find('td:eq(0)').text().trim();
            updateProduct_name=$("select[id$='ddlProductName']").val().trim();
            TxtStockIn=$("#TxtStockIn").val().trim();
            alert(updateProduct_name +' '+ Product_name);

            if(updateProduct_name == Product_name)
            {
                new_stock = TxtStockIn + remaining_Quantity;
            }        
        //else 
       // {
        //    alert("Please select the correct option.")
       // }
        });

        var products = $("select[id$='ddlProductName'] option:selected").val();
        var category = $("select[id$='ddlCategory'] option:selected").val();

        $.ajax({
            type: "POST",
            dataType: "json",
            contentType: "application/json; charset=utf-8",
            url: "Products.aspx/updatestock",
            data: "{'PRODUCTS_NAME':'" + products + "','CATEGORY_ID':'" + category + "','TOTAL_STOCK':'" + new_stock + "'}"
        });
    }
    function dataupdated() {
        getdata();
        setTimeout(
function () {
    $('#myTable').DataTable();
}, 1000);
        popupclearbutton();
    }

    ///////////////////////////////////////////////////////Add New products/////////////////////////////////////////////////////

    function insertstock() {
        debugger;
        var productsIns = $("#TxtInsProducts").val().trim();
        var categoryIns = $("#TxtInsCategory").val().trim();
        var stockinIns = $("#TxtInsStockin").val().trim();

        $.ajax({
            type: "POST",
            dataType: "json",
            contentType: "application/json; charset=utf-8",
            url: "Products.aspx/insertstock",
            data: "{'PRODUCTS_NAME':'" + productsIns + "','CATEGORY_ID':'" + categoryIns + "','TOTAL_STOCK':'" + stockinIns + "'}"
        });
    }
    //////////////////////////////////////////////////////// Modal Popup////////////////////////////////////////////////

    $(function () {

        var appendthis = ("<div class='modal-overlay js-modal-close'></div>");

        $('a[data-modal-id]').click(function (e) {
            e.preventDefault();
            $("body").append(appendthis);
            $(".modal-overlay").fadeTo(500, 0.7);
            var modalBox = $(this).attr('data-modal-id');
            $('#' + modalBox).fadeIn($(this).data());
        });


        $(".js-modal-close, .modal-overlay").click(function () {
            $(".modal-box, .modal-overlay").fadeOut(500, function () {
                $(".modal-overlay").remove();
            });
        });

        $(window).resize(function () {
            $(".modal-box").css({
                top: ($(window).height() - $(".modal-box").outerHeight()) / 2,
                left: ($(window).width() - $(".modal-box").outerWidth()) / 2
            });
        });

        $(window).resize();

    });

    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

</script>

<%@ Page Language="C#" AutoEventWireup="true" CodeFile="product-issue-details.aspx.cs" Inherits="MCTX_Internal_SuperAdmin_IMS_product_issue_details" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
         <script src="js/jquery-2.1.4.min.js"></script>
    <script src="js/jquery.dataTables.min.js"></script>
    <link href="css/jquery.dataTables.min.css" rel="stylesheet" />
</head>
<body>
    <form id="form1" runat="server">
    <div id="imsproductsissue">
    </div>
    </form>
</body>
</html>
<script lang="ja" type="text/javascript">
    $(window).load(function () {
        getissuedate();
        setTimeout(
  function () {
      $('#productissue').DataTable();
  }, 900);
    });

    function getissuedate() {
        $.ajax({
            type: "POST",
            dataType: "json",
            contentType: "application/json; charset=utf-8",
            url: "product-issue-details.aspx/getissuedate",
            data: {},
            success: Ongetdata,
            error: function (x) {
                alert(x.responseText);
            }
        });
        function Ongetdata(data) {
            data = data.d;
            var tableproductsissue = '';

            tableproductsissue += "<table id='productissue' class='display' cellspacing='0' cellpadding='0' width='100%'>";
            tableproductsissue += "<thead><tr>";
            tableproductsissue += "<th>Employee Name</th><th>Product Name</th><th>Category</th><th>Quantity Issue</th><th>Quantity InStock</th><th>Issue Date</th>";
            tableproductsissue += "</tr></thead><tbody>";

            for (var i = 0; i < data.ims.length; i++) {



                var str = window.JSON.stringify({ myDate: new Date(data.ims[i].DATE) });

                // str == "{"myDate":"2010-12-27T11:59:18.119Z"}"

                var obj = window.JSON.parse(str);
                alert(str);
                // obj.myDate == "2010-12-27T11:59:18.119Z"



               // alert(data.ims[i].DATE);
                //var date = new Date(data.ims[i].DATE);
               // alert(date);

                tableproductsissue += "<tr><td>" + data.ims[i].EMPLOYEE_NAME + "</td><td>" + data.ims[i].PRODUCT_NAME + "</td><td>" + data.ims[i].CATEGORY + "</td><td>" + data.ims[i].QUANTITY_ISSUE + "</td><td>" + data.ims[i].QUANTITY_INSTOCK + "</td><td>" + obj + "</td></tr>";
            }
            tableproductsissue += "</tbody></table>";
            $('#imsproductsissue').html(tableproductsissue);
        }

    }



</script>

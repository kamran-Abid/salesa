<%@ Page Title="" Language="C#" MasterPageFile="~/MCTX_Internal/SuperAdmin/MasterAdmin.master" AutoEventWireup="true" CodeFile="Workshop_Management_FeedBack.aspx.cs" Inherits="MCTX_Internal_SuperAdmin_Workshop_Management_FeedBack" %>

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
           
             <li style="text-align: left"><a href="#tabs-2">Add/Modify  Feedback</a></li>
          
            
        </ul>
        
      <div id="tabs-2" style="width: 98%">
            <fieldset id="fldAddProduct" runat="server" style="width:92%; padding:2%">
                <legend>Add Product</legend>
                <table width="100%" style="font-family: Calibri; font-size: 11pt;" >
                    <tr>
                        <td width="140px" align="left">
                            <asp:Label ID="Label2" Text="Select Project:" runat="server"></asp:Label>
                        </td>
                        <td   style="width: 300px;">
                            <asp:DropDownList ID="ddlProject" Width="95%" runat="server">
                        </asp:DropDownList>
                        </td>
                          <td width="140px" align="left">
                            <asp:Label ID="Label3" Text="Select Product:" runat="server"></asp:Label>
                        </td>
                        <td colspan="1" width="200px" align="left">
                            <asp:DropDownList ID="ddlProduct" Width="95%" runat="server">
                        </asp:DropDownList>
                        </td>
                        <td  align="left">
                            <asp:TextBox ID="txtFeedbackids" Style="display: none;" runat="server"></asp:TextBox>
                        </td>
                        
                    </tr>
                    <tr>
                        <td  width="140px" align="left">
                            <asp:Label ID="Label1" Text="Feedback Description:" runat="server"></asp:Label>
                        </td>
                        <td >
                            <asp:TextBox ID="txtFeedBack" Style="resize: none;" TextMode="MultiLine" Width="98%" Height="70px" MaxLength="300"  runat="server" BackColor="White" ></asp:TextBox>
                        </td colspan="3">
                        <td>&nbsp;</td>
                    </tr>
                    <tr>

                        <td colspan="3">
                            &nbsp;
                        </td>
                        <td colspan="5"  align="left">
                            <asp:Button ID="btnAddFeedback" Text="Add" Style="background-color: #273D5F; color: White;"
                                Width="75px" OnClientClick="return SaveFeedBack();" runat="server" />
                        
                            <asp:Button ID="btnClearFeedBack" Text="Clear" Style="background-color: #273D5F; color: White;"
                                Width="75px" OnClientClick="return ClearFeedBack();" runat="server" />
                        
                            <asp:Button ID="btnUpdateFeedBack" Text="Update" Style="background-color: #273D5F; color: White;
                                display: none;" Width="75px" OnClientClick="return UpdateFeedBack();" runat="server" />
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
       
        getFeedBack();
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
      function SaveFeedBack() {
          var FeedbackDescription = $("textarea[id$='txtFeedBack']").val().trim();
          var ProjectID = $("select[id$='ddlProject']").val().trim();
          var ProductID = $("select[id$='ddlProduct']").val().trim();
          if (FeedbackDescription == "") {
              alert("Please Enter Feed Back Descriptio!");
              return false;
          }
          if (ProjectID == "-- Select --") {
              alert("Please Select Project!");
              return false;
          }

          if (ProjectID == "-- Select --") {
              alert("Please Select Product!");
              return false;
          }
          $.ajax({
              type: "POST",
              contentType: "application/json; charset=utf-8",
              url: "Workshop_Management_FeedBack.aspx/SaveFeedBack",
              data: "{'FeedbackDescription':'" + FeedbackDescription + "','ProjectID':'" + ProjectID + "','ProductID':'" + ProductID + "'}",
              success: onsuccessSaveFeedBack,
              error: onretrieveSaveFeedBackError
          });
          return false;
      }
      function onsuccessSaveFeedBack() {
          alert("Data Successfully Saved!");
          $("textarea[id$='txtFeedBack']").val("");
          $("select[id$='ddlProject']").val("-- Select --");
          getFeedBack();
          return false;
      }
      function onretrieveSaveFeedBackError() {
          alert("Error In Saving Data!");
          return false;
      }


      function getFeedBack() {
          $.ajax({
              type: "POST",
              contentType: "application/json; charset=utf-8",
              url: "Workshop_Management_FeedBack.aspx/getFeedBackDetails",
              data: "{}",
              success: onsuccessgetFeedBack,
              error: onretrievegetFeedBack
          });
          return false;
      }
      function onsuccessgetFeedBack(msg) {
          var data = msg.d;
          if (oTable != null) {
              oTable.fnClearTable();
              oTable.fnDestroy();
          }
         
          var tbl = "";
          tbl += "<thead>";
          tbl += "<tr>";

          tbl += "<th style='text-align:center; white-space:nowrap;'>Edit</th>";
          tbl += "<th style='text-align:left; white-space:nowrap; display:none;'>FeedBack ID</th>";
          tbl += "<th style='text-align:left; white-space:nowrap; display:none;'>Project ID</th>";
          tbl += "<th style='text-align:left; white-space:nowrap; display:none;'>Product ID</th>";
          tbl += "<th style='white-space:nowrap; text-align:left;width:30%'>Feedback Description</th>";
          tbl += "<th style='white-space:nowrap; text-align:left;'>Project Name</th>";
          tbl += "<th style='white-space:nowrap; text-align:left;'>Product Name</th>";
          
         
          tbl += "<th style='white-space:nowrap; text-align:left;'>Created By</th>";
          tbl += "<th style='white-space:nowrap; text-align:left;'>Created Date</th>";
          tbl += "<th style='white-space:nowrap; text-align:left;'>Modified By</th>";
          tbl += "<th style='white-space:nowrap; text-align:left;'>Modified Date</th>";
          tbl += "</tr>";
          tbl += "</thead>";
          tbl += "<tbody>";
          for (var i = 0; i < data.FeedBackDetails.length; i++) {

              tbl += "<td style='cursor:Pointer;' id='txtUpdate' align='center' onclick='return EditFeedbackRecord(" + i + ");'><img src='image/Edit.png'></td>";
              tbl += "<td style='text-align:right; white-space:nowrap; display:none;' id='txtFeedBackID" + i + "'>" + data.FeedBackDetails[i].Workshop_FeedBak_ID + "</td>";
              tbl += "<td style='text-align:right; white-space:nowrap; display:none;' id='txtProjID" + i + "'>" + data.FeedBackDetails[i].Workshop_Project_id + "</td>";
              tbl += "<td style='text-align:right; white-space:nowrap; display:none;' id='txtProductID" + i + "'>" + data.FeedBackDetails[i].Workshop_Product_id + "</td>";
              
              tbl += "<td style='text-align:left; white-space:nowrap;' id='txtFeedBack" + i + "'>" + data.FeedBackDetails[i].Workshop_FeedBak_Description + "</td>";
              tbl += "<td style='text-align:left; white-space:nowrap;' id='txtProjectNames" + i + "'>" + data.FeedBackDetails[i].Project_Name + "</td>";
              tbl += "<td style='text-align:left; white-space:nowrap;' id='txtProductName" + i + "'>" + data.FeedBackDetails[i].Product_name + "</td>";
              tbl += "<td style='text-align:left; white-space:nowrap;' id='txtCreatedBy" + i + "'>" + data.FeedBackDetails[i].created_by + "</td>";
              tbl += "<td style='text-align:right; white-space:nowrap;' id='txtCreatedDate" + i + "'>" + data.FeedBackDetails[i].created_date + " </td>";
              tbl += "<td style='text-align:left; white-space:nowrap;' id='txtModBy" + i + "'>" + data.FeedBackDetails[i].modified_by + " </td>";
              tbl += "<td style='text-align:right; white-space:nowrap;' id='txtModDate" + i + "'>" + data.FeedBackDetails[i].modified_date + " </td>";
              tbl += "</tr>";
          }
          tbl += "</tbody>";
          tbl += "</table>";
          $("#tblProductDetail").html(tbl);
          dataTableProduct();
          return false;
      }
      function onretrievegetFeedBack() {
          alert("Error In Loading Details!");
          return false;
      }

       function ClearFeedBack()
      {
           $("textarea[id$='txtFeedBack']").val("");
           $("input[id$='txtFeedbackids']").val("");
        $("select[id$='ddlProject']").val("-- Select --");
        $("select[id$='ddlProduct']").val("-- Select --")
        $("input[id$='btnUpdateFeedBack']").hide();
        $("input[id$='btnAddFeedback']").attr("disabled", false);
        return false;
      }
   

    function EditFeedbackRecord(rowNo)
       {

        var FeedbackId = $("#txtFeedBackID" + rowNo).html().trim();
        $("input[id$='txtFeedbackids']").val(FeedbackId);
          var ProductID = $("#txtProductID"+rowNo).html().trim();
          $("select[id$='ddlProduct']").val(ProductID);

          var Projid = $("#txtProjID" + rowNo).html().trim();
          $("select[id$='ddlProject']").val(Projid);

          var FeedbackDescription = $("#txtFeedBack" + rowNo).html().trim();
          $("textarea[id$='txtFeedBack']").val(FeedbackDescription);

          
          $("input[id$='btnUpdateFeedBack']").show();
          $("input[id$='btnAddFeedback']").attr("disabled", true);
          return false;
      }

      function UpdateFeedBack()
      {
        var Feedbackid =  $("input[id$='txtFeedbackids']").val();

       var FeedbackDescription = $("textarea[id$='txtFeedBack']").val().trim();
       var ProjectID = $("select[id$='ddlProject']").val().trim();
       var ProductID = $("select[id$='ddlProduct']").val().trim();
          if (FeedbackDescription == "") {
              alert("Please Enter Feedback Description!");
              return false;
          }
          if (ProjectID == "-- Select --") {
              alert("Please Select Project!");
              return false;
          }

          if (ProductID == "-- Select --") {
              alert("Please Select Product!");
              return false;
          }
        $.ajax({
            type: "POST",
            contentType:"application/json; charset=utf-8",
             url: "Workshop_Management_FeedBack.aspx/UpdateFeedBack",
             data: "{'Feedbackid':'" + Feedbackid + "','FeedbackDescription':'" + FeedbackDescription + "','ProjectID':'" + ProjectID + "','ProductID':'" + ProductID + "'}",
            success:onsuccessUpdateFeedBack,
            error:onretrieveUpdateFeedBack 
        });
        return false; 
      }
      function onsuccessUpdateFeedBack()
      {
        alert("Record Updated Successfully!");
        getFeedBack();
        ClearFeedBack();
        return false;
      }
      function onretrieveUpdateFeedBack()
      {
        alert("Error In Updating Record!");
        return false;
      }
     
    
    </script>
</asp:Content>


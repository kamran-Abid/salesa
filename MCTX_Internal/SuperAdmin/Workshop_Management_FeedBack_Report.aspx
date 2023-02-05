<%@ Page Title="" Language="C#" MasterPageFile="~/MCTX_Internal/SuperAdmin/MasterAdmin.master" AutoEventWireup="true" CodeFile="Workshop_Management_FeedBack_Report.aspx.cs" Inherits="MCTX_Internal_SuperAdmin_Workshop_Management_FeedBack_Report" %>

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
           
             <li style="text-align: left"><a href="#tabs-2">Feedback Report</a></li>
          
            
        </ul>
        
      <div id="tabs-2" style="width: 98%">
            <fieldset id="fldAddProduct" runat="server" style="width:92%; padding:2%">
                <legend>Feedback Report</legend>
                <table width="100%" style="font-family: Calibri; font-size: 11pt;" >
                    <tr>
                        <td width="140px" align="left">
                            <asp:Label ID="Label2" Text="Select Project:" runat="server"></asp:Label>
                        </td>
                        <td style="width: 300px;">
                            <asp:DropDownList Width="60%" ID="ddlProject" runat="server">
                        </asp:DropDownList>
                        </td>
                          <td  align="left">
                            <asp:Button ID="btnSearch" Text="Search" Style="background-color: #273D5F; color: White;"
                                Width="75px" OnClientClick="return GetFeedBackReport();" runat="server" />
                        </td>
                        
                        
                    </tr>
                  
                  
                </table>
            </fieldset>

            <div id="divProduct" style="overflow: auto;width:100%;" >
            <fieldset id="fldProductDetail" runat="server" style="width:92%; padding:2%; height: 400px;">
                <legend>Feedback Report</legend>
                <div  style="text-align:right;" align="right">
                             <input type="button" id="btnExport" value="Export to Excel" style="cursor:pointer;background-color:#2A4062;color:white;height:20px;" />

                        </div>
                <table id="tblFeedBackReporst" class="dataTable">
                </table>
	</fieldset>
        </div>
        </div>   
	
    </div>

    <script type="text/javascript" language="javascript">
    var oTable,oTable;
    $(document).ready(function () {
        GetFeedBackReport();
        $("#btnExport").click(function (e) {
            var tab_text = "<table border='2px'><tr bgcolor='#87AFC6'>";
            var textRange; var j = 0;
            tab = document.getElementById('tblFeedBackReporst'); // id of table

            for (j = 0 ; j < tab.rows.length ; j++) {
                tab_text = tab_text + tab.rows[j].innerHTML + "</tr>";
                //tab_text=tab_text+"</tr>";
            }

            tab_text = tab_text + "</table>";
            tab_text = tab_text.replace(/<A[^>]*>|<\/A>/g, "");//remove if u want links in your table
            tab_text = tab_text.replace(/<img[^>]*>/gi, ""); // remove if u want images in your table
            tab_text = tab_text.replace(/<input[^>]*>|<\/input>/gi, ""); // reomves input params

            var ua = window.navigator.userAgent;
            var msie = ua.indexOf("MSIE ");

            if (msie > 0 || !!navigator.userAgent.match(/Trident.*rv\:11\./))      // If Internet Explorer
            {
                txtArea1.document.open("txt/html", "replace");
                txtArea1.document.write(tab_text);
                txtArea1.document.close();
                txtArea1.focus();
                sa = txtArea1.document.execCommand("SaveAs", true, "Say Thanks to Sumit.xls");
            }
            else                 //other browser not tested on IE 11
                sa = window.open('data:application/vnd.ms-excel,' + encodeURIComponent(tab_text));

            return (sa);
            //  window.open('data:application/vnd.ms-excel,' + $('#divCompInfo').html());
            //e.preventDefault();
        });
       
    });
      

    function dataTableProduct() {
        oTable = $("#tblFeedBackReporst").dataTable({
            bPaginate: true,
            bJQueryUI: true,
            bSort: true,
            bInfo: true,
            bRetrieve: true,
            bDestroy: true,
            oLanguage: { "sSearch": "Filter: " }
        });
        $("#tblFeedBackReporst_length").css("text-align", "left");
        $("#tblFeedBackReporst_filter").css("text-align", "left");
        
    }
      
    //------------------------------------------------------- Feedback Report ---------------------------------------------------------------------------
    


    function GetFeedBackReport() {
        var projectID = $("select[id$='ddlProject']").val();
       
          $.ajax({
              type: "POST",
              contentType: "application/json; charset=utf-8",
              url: "Workshop_Management_FeedBack_Report.aspx/getFeedBackDetails",
              data: "{'projectID':'" + projectID + "'}",
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

          tbl += "<th style='text-align:center; white-space:nowrap;'>Sr. #</th>";
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
          var j = 1;
          for (var i = 0; i < data.FeedBackDetails.length; i++) {
              j=j+i;
              tbl += "<td style='cursor:Pointer;' id='txtUpdate' align='center'>"+j+"</td>";
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
          $("#tblFeedBackReporst").html(tbl);
          //dataTableProduct();
          return false;
      }
      function onretrievegetFeedBack() {
          alert("Error In Loading Details!");
          return false;
      }

      
     
    
    </script>
</asp:Content>


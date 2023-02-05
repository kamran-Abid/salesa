<%@ Page Language="C#" MasterPageFile="~/MCTX_Internal/SuperAdmin/MasterAdmin.master"
    AutoEventWireup="true" CodeFile="FrmReceivableDetails.aspx.cs" Inherits="MCTX_Internal_SuperAdmin_FrmReceivableDetails"
    Title="Receivables Detail" %>

<%@ Register Assembly="RJS.Web.WebControl.PopCalendar.Net.2008" Namespace="RJS.Web.WebControl"
    TagPrefix="rjs" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <script src="../../js/jquery.dataTables.min.js" type="text/javascript"></script>
    <script src="../../js/jquery.fixedheader.js" type="text/javascript"></script>
    <script src="../../js/BlockUI.js" type="text/javascript"></script>

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
    </style>
    <div id="tabs" style="width: 796">
        <ul>
            <li style="text-align: left"><a href="#tabs-1">Receivables Details</a></li>
        </ul>
        <div id="tabs-1">
            <fieldset id="fldRecp" style="margin-bottom: 15px">
                <legend>Search</legend>
                <table width="100%">
                    <tr>
                        <td align="left" width="83px">
                            Invoice ID:
                        </td>
                        <td align="left" width="162px">
                            <asp:TextBox ID="txtInvoiceID" Width="162px" runat="server"></asp:TextBox>
                        </td>
                        <td align="left" width="50px">
                            <asp:Button ID="btnSearch" Text="Search" runat="server" OnClientClick="return SearchReceivableData();" />
                        </td>
                        <td align="left" width="80px">
                            <asp:Button ID="btnClear" Text="Clear" runat="server" OnClientClick="return ClearRecpField();" />
                        </td>
                        <td align="right">
                            <a href="javascript:history.go(-1)">Back</a>
                        </td>
                    </tr>
                </table>
                <table width="100%">
                    <tr>
                        <td align="left" width="100%">
                            <asp:LinkButton ID="lnkAdvSearch" Text="Advanced Search" Style="color: Blue; text-decoration: underline"
                                OnClientClick="return openAdvancedSearch();" runat="server"></asp:LinkButton>
                        </td>
                    </tr>
                </table>
                <div id="divAdvanceSearch" style="display: none;">
                    <table width="100%">
                        <tr>
                            <td align="left">
                                Invoice No:
                            </td>
                            <td align="left">
                                <asp:TextBox ID="txtInvoiceNo" Width="162px" runat="server"></asp:TextBox>
                            </td>
                            <td align="left">
                                Invoice To:
                            </td>
                            <td align="left">
                                <asp:TextBox ID="txtInvoiceTo" Width="162px" runat="server"></asp:TextBox>
                            </td>
                            <td align="left">
                                Invoice Date:
                            </td>
                            <td align="left">
                                <asp:TextBox ID="txtInvoiceDate" Width="162px" runat="server"></asp:TextBox>
                                <rjs:PopCalendar ID="PopCalendar" runat="server" InvalidDateMessage="Invalid Date."
                                    TextMessage="Invalid Date." ShowMessageBox="True" Separator="/" Format="mm dd yyyy"
                                    Control="txtInvoiceDate"></rjs:PopCalendar>
                            </td>
                        </tr>
                        <tr>
                            <td align="left">
                                PO Number:
                            </td>
                            <td align="left">
                                <asp:TextBox ID="txtPONumber" Width="162px" runat="server"></asp:TextBox>
                            </td>
                            <td align="left">
                                PO Date:
                            </td>
                            <td align="left">
                                <asp:TextBox ID="txtPODate" Width="162px" runat="server"></asp:TextBox>
                                <rjs:PopCalendar ID="PopCalendar1" runat="server" InvalidDateMessage="Invalid Date."
                                    TextMessage="Invalid Date." ShowMessageBox="True" Separator="/" Format="mm dd yyyy"
                                    Control="txtPODate"></rjs:PopCalendar>
                            </td>
                            <td align="left">
                            </td>
                            <td align="left">
                            </td>
                        </tr>
                    </table>
                </div>
            </fieldset>
            <div style="overflow: auto; width: 990px;">
                <table align='center' class="dataTable" id="tblReceivableData" style="width: 1190px;">
                </table>
            </div>
        </div>
    </div>

    <script language="javascript" type="text/javascript">
            
            var oTable;
            
            $(document).ajaxStart(blockUI).ajaxStop(unblockUI);
 
        function  blockUI() {
	            $.blockUI({ message: '<img src="image/ajax-loader.gif" />', 
			    css:{borderStyle:'none',backgroundColor:"Transparent"} });
            }
        
        function unblockUI(){
                $.unblockUI();
            }
        
        $(document).ready(function(){
                           
//    $(function() {
//                 $("input[id$='txtInvoiceDate']").datepicker({ dateFormat: 'mm/dd/yy' });      
//                 }
//                    );
//    $(function() {
//                 $("input[id$='txtPODate']").datepicker({ dateFormat: 'mm/dd/yy' });      
//                 }
//                    );
     
                    
                 getReceivableData();
            });
         function dataTable() {
       oTable= $("#tblReceivableData").dataTable({
                bPaginate: false,
                bJQueryUI: true,
                oLanguage:{"sSearch":"Filter: "}               
            }).fixedHeader({ height: 200 });
      }
        function getReceivableData()
            {
                $.ajax({
                type: "POST",
                contentType:"application/json; charset=utf-8",
                url: "FrmReceivableDetails.aspx/ReceivableData", 
                data: "{}", 
                success: onsuccessLoadData,
                error:onretrieveError 
                });
                return false;
            }
        function SearchReceivableData()
            {
                
                var InvID=$("input[id$='txtInvoiceID']").val();    
                var InvNo=$("input[id$='txtInvoiceNo']").val();
                var InvTo= $("input[id$='txtInvoiceTo']").val();
                var InvDate=$("input[id$='txtInvoiceDate']").val();    
                var PONum= $("input[id$='txtPONumber']").val();
                var PODate=$("input[id$='txtPODate']").val();    
                    $.ajax({
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        url: "FrmReceivableDetails.aspx/SearchReceivablesData",
                        dataType: "json",
                        data: "{'InvID':'"+InvID+"','InvNo':'"+InvNo+"','InvTo':'"+InvTo+"','InvDate':'"+InvDate+"','PONum':'"+PONum+"','PODate':'"+PODate+"'}",
                        success:onsuccessLoadData,
                        error:onretrieveError 
            });
                return false;
            } 
            
        function onsuccessLoadData(msg)
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
                tbl += "<th style='text-align:center; white-space:nowrap;'>Delete</th>";
                tbl += "<th style='text-align:center; white-space:nowrap;'>Edit</th>";
                tbl += "<th style='white-space:nowrap; text-align:left;'>Invoice ID</th>";
                tbl += "<th style='white-space:nowrap; text-align:left;'>Invoice To</th>";
                tbl += "<th style='white-space:nowrap; text-align:left;'>Invoice Amount</th>";
                tbl += "<th style='white-space:nowrap; text-align:left;'>Invoice Date</th>";
                tbl += "<th style='white-space:nowrap; text-align:left;'>Payment Due On</th>";
                tbl += "<th style='white-space:nowrap; text-align:left;'>Invoice No</th>";
                tbl += "<th style='white-space:nowrap; text-align:left;'>PO No</th>";
                tbl += "<th style='white-space:nowrap; text-align:left;'>PO Date</th>";
                tbl += "<th style='white-space:nowrap; text-align:left;'>Created By</th>";
                tbl += "<th style='white-space:nowrap; text-align:left;'>Created Date</th>";
                tbl += "<th style='white-space:nowrap; text-align:left;'>Modified By</th>";
                tbl += "<th style='white-space:nowrap; text-align:left;'>Modified Date</th>";
                tbl += "</tr>";
                tbl += "</thead>";
                tbl += "<tbody>";
                for (var i = 0; i < data.ReceivableDetails.length; i++) {   
                      var InvoiceDate=ConvertDate(data.ReceivableDetails[i].Invoice_Date); 
                      var PaymentDate=ConvertDate(data.ReceivableDetails[i].Payment_Due_On ); 
                      var PODate=ConvertDate(data.ReceivableDetails[i].PO_Date);   
                      var CreatedDate=ConvertDate(data.ReceivableDetails[i].Created_Date);   
                      var mdate=ConvertDate(data.ReceivableDetails[i].Modified_Date);  
                                
                            tbl += "<td style='cursor:Pointer;' id='txtdelete' align='center' onclick='return DeleteRecord("+i+");'><img src='image/Cross.png'> </td>";    
                            tbl += "<td style='cursor:Pointer;' id='txtUpdate' align='center' onclick='return EditRecord("+i+");'><img src='image/Edit.png'></td>";                        
                            tbl += "<td style='text-align:left;' id='txtID"+i+"'>" + data.ReceivableDetails[i].invoice_id + "</td>";                    
                            tbl += "<td style='text-align:left;' id='txtInvoiceTo"+i+"'>" + data.ReceivableDetails[i].Pro_Name + " </td>";
                            tbl += "<td style='text-align:left;' id='txtInvoiceAmount"+i+"'>" + data.ReceivableDetails[i].Invoice_Amount + " </td>";
                            tbl += "<td style='text-align:left;' id='txtInvoiceDate"+i+"'>" + InvoiceDate + " </td>";
                            tbl += "<td style='text-align:left;' id='txtPaymentDueon"+i+"'>" +PaymentDate + " </td>";                    
                            tbl += "<td style='text-align:left;' id='txtInvoiceNo"+i+"'>" + data.ReceivableDetails[i].Invoice_No + " </td>";
                            tbl += "<td style='text-align:left;' id='txtPONo"+i+"'>" + data.ReceivableDetails[i].PO_No + " </td>";
                            tbl += "<td style='text-align:left;' id='txtPODate"+i+"'>" + PODate + " </td>";
                            tbl += "<td style='text-align:left;' id='txtCreatedBy"+i+"'>" + data.ReceivableDetails[i].Created_By + " </td>";
                            tbl += "<td style='text-align:left;' id='txtCreatedDate"+i+"'>" + CreatedDate + " </td>";
                            tbl += "<td style='text-align:left;' id='txtModifiedBy"+i+"'>" + data.ReceivableDetails[i].Modified_By + " </td>";
                            tbl += "<td style='text-align:left;' id='txtModifiedDate"+i+"'>" + mdate + " </td>";
                      tbl += "</tr>";
                }   

                tbl += "</tbody>";
                tbl += "</table>";
                $("#tblReceivableData").html(tbl);
                dataTable();
                return false;
            }   
        function DeleteRecord(rowNo)
            {
                var ID = $("#txtID"+rowNo).html();
                if (confirm("Are you sure you wish to delete this Record?"))
                    { 
                        $.ajax({
                            type: "POST",
                            contentType:"application/json; charset=utf-8",
                            url: "FrmReceivableDetails.aspx/DeleteRecpData", 
                            data: "{'Inv_Id':'"+ID+"'}", 
                            dataType:"json",
                            success:onsucessDeleteData,
                            error:onretrieveDeleteError 
                     });
                     }
                else  
                     {
                        return false;
                     }
                return false;
            }   
        function EditRecord(rowNo)
            {
               var ID = $("#txtID"+rowNo).html();
               window.location = 'ReceiptsAndExpense.aspx?invoice_id='+ID;  
            } 
        function ConvertDate(dateString)
            {   
            if(dateString !=undefined)
            {
                var date = new Date(parseInt(dateString.replace(/\/Date\((\d+)\)\//, '$1')));
                var month = date.getMonth() + 1;
                if(month <10)
                month ='0'+month ;
                var day = date.getDate();
                if(day<10)
                day='0'+day;
                var year = date.getFullYear();
                var datet=month+"/"+day+"/"+year;
                return datet;
                }
                else
                {
                return false;
                }
            }   
            
        function onretrieveError()
            {
                alert("Error occured in loading details!");
            }  
        function ClearRecpField()
            {
                $("#fldRecp input[type='text']").val("");
                return false;
            }
        function onsucessDeleteData()
            {
                getReceivableData();
                alert("Record successfully deleted!");
                return false;
            } 
        function onretrieveDeleteError()
            {
                alert("Error occurred in deleting record!");
                getReceivableData();
            }        
        function openAdvancedSearch()
            {
                $("#divAdvanceSearch").slideToggle();
                return false;
            }
     
    </script>

</asp:Content>

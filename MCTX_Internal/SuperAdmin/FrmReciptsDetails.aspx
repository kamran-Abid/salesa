<%@ Page Language="C#" MasterPageFile="~/MCTX_Internal/SuperAdmin/MasterAdmin.master"
    AutoEventWireup="true" CodeFile="FrmReciptsDetails.aspx.cs" Inherits="MCTX_Internal_FrmReciptsDetails"
    Title="Receipt Details" %>
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
            <li style="text-align: left"><a href="#tabs-1">Receipt Details</a></li>
        </ul>
        <div id="tabs-1">
            <fieldset id="fldRecp" style="margin-bottom: 15px">
                <legend>Search</legend>
                <table width="100%">
                    <tr>
                        <td align="left" width="83px">
                            Receipt ID:
                        </td>
                        <td align="left" width="162px">
                            <asp:TextBox ID="txtReceiptID" Width="162px" runat="server"></asp:TextBox>
                        </td>
                        <td align="left" width="50px">
                            <asp:Button ID="btnSearch" Text="Search" runat="server" OnClientClick="return SearchReceiptData();" />
                        </td>
                        <td align="left" width="80px">
                            <asp:Button ID="btnClear" Text="Clear" runat="server" OnClientClick="return ClearRecpField();" />
                        </td>
                        <td>
                        
                        </td>
                        <td align="right">
                          <%--<asp:Button ID="btn_back" Text="Back" runat="server" Width="75px" onClick="history.go(-1)" />--%>
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
                                Date:
                            </td>
                            <td align="left">
                                <asp:TextBox ID="txtDate" Width="162px" runat="server"></asp:TextBox>
                                <rjs:PopCalendar ID="PopCalendar1" runat="server" InvalidDateMessage="Invalid Date."
                                TextMessage="Invalid Date." ShowMessageBox="True" Separator="/" Format="mm dd yyyy"
                                Control="txtDate"></rjs:PopCalendar>
                            </td>
                            <td align="left">
                                Project:
                            </td>
                            <td align="left">
                                <asp:TextBox ID="txtProject" Width="162px" runat="server"></asp:TextBox>
                            </td>
                            <td align="left">
                                Paid By:
                            </td>
                            <td align="left">
                                <asp:TextBox ID="txtPaidBy" Width="162px" runat="server"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td align="left">
                                Received By:
                            </td>
                            <td align="left">
                                <asp:TextBox ID="txtReceivedBy" Width="162px" runat="server"></asp:TextBox>
                            </td>
                            <td align="left">
                                Payment Mode:
                            </td>
                            <td align="left">
                                <asp:TextBox ID="txtPayementMode" Width="162px" runat="server"></asp:TextBox>
                            </td>
                            <td align="left">
                            </td>
                            <td align="left">
                            </td>
                        </tr>
                    </table>
                </div>
            </fieldset>
            <div style="overflow: auto; width: 990px; height:568px">
                <table align='center' class="dataTable" id="tblReceiptData" style="width: 1190px;">
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
                           
                
                 //$("input[id$='txtDate']").datepicker({ dateFormat: 'mm/dd/yy' });      
                getReceiptData();
            });
         function dataTable() {
       oTable= $("#tblReceiptData").dataTable({
                bPaginate: false,
                bJQueryUI: true,
                oLanguage:{"sSearch":"Filter: "}               
            }).fixedHeader({ height: 564 });
      }
        function getReceiptData()
            {
                $.ajax({
                type: "POST",
                contentType:"application/json; charset=utf-8",
                url: "FrmReciptsDetails.aspx/RecpData", 
                data: "{}", 
                success: onsuccessLoadData,
                error:onretrieveError 
                });
                return false;
            }
        function SearchReceiptData()
            {
                var RecID=$("input[id$='txtReceiptID']").val();    
                var RecDate= $("input[id$='txtDate']").val();
                var RecProject=$("input[id$='txtProject']").val();    
                var RecPaidBy= $("input[id$='txtPaidBy']").val();
                var RecReceivedBy=$("input[id$='txtReceivedBy']").val();    
                var RecPaymentMode= $("input[id$='txtPayementMode']").val();
                    $.ajax({
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        url: "FrmReciptsDetails.aspx/SearchRecpData",
                        dataType: "json",
                        data: "{'Recp_Id':'"+RecID+"','Rep_Date':'"+RecDate+"','Rcp_ForProject':'"+RecProject+"','Rcp_Receivedfrom':'"+RecPaidBy+"','Rcp_Recievedby':'"+RecReceivedBy+"','Rcp_PaymentMode':'"+RecPaymentMode+"'}",
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
                tbl += "<th style='white-space:nowrap; text-align:left;'>ID</th>";
                tbl += "<th style='white-space:nowrap; text-align:left;'>Date</th>";
                tbl += "<th style='white-space:nowrap; text-align:left;'>Amount</th>";
                tbl += "<th style='white-space:nowrap; text-align:left;'>Received By</th>";
                tbl += "<th style='white-space:nowrap; text-align:left;'>Paid By</th>";
                tbl += "<th style='white-space:nowrap; text-align:left;'>Payment Mode </th>";
                tbl += "<th style='white-space:nowrap; text-align:left;'>Project</th>";
                tbl += "<th style='white-space:nowrap; text-align:left;'>Created By</th>";
                tbl += "<th style='white-space:nowrap; text-align:left;'>Created Date</th>";
                tbl += "<th style='white-space:nowrap; text-align:left;'>Modified By</th>";
                tbl += "<th style='white-space:nowrap; text-align:left;'>Modified Date</th>";
                tbl += "</tr>";
                tbl += "</thead>";
                tbl += "<tbody>";
                for (var i = 0; i < data.RecDetails.length; i++) {               
                      datet=ConvertDate(data.RecDetails[i].Created_Date);    
                      mdatet=ConvertDate(data.RecDetails[i].Modified_Date);            
                            tbl += "<td style='cursor:Pointer;' id='txtdelete' align='center' onclick='return DeleteRecord("+i+");'><img src='image/Cross.png'> </td>";    
                            tbl += "<td style='cursor:Pointer;' id='txtUpdate' align='center' onclick='return EditRecord("+i+");'><img src='image/Edit.png'></td>";                        
                            tbl += "<td style='text-align:left;' id='txtID"+i+"'>" + data.RecDetails[i].Recp_Id + "</td>";                    
                            tbl += "<td style='text-align:left;' id='txtDate"+i+"'>" + data.RecDetails[i].Rep_Date + " </td>";
                            tbl += "<td style='text-align:left;' id='txtAmount"+i+"'>" + data.RecDetails[i].Rcp_Amount + " </td>";
                            tbl += "<td style='text-align:left;' id='txtReceivedBy"+i+"'>" + data.RecDetails[i].Rcp_Recievedby + " </td>";
                            tbl += "<td style='text-align:left;' id='txtPaidBy"+i+"'>" + data.RecDetails[i].ApproveAuth_name + " </td>";                    
                            tbl += "<td style='text-align:left;' id='txtPaymentMode"+i+"'>" + data.RecDetails[i].Rcp_PaymentMode + " </td>";
                            tbl += "<td style='text-align:left;' id='txtProject"+i+"'>" + data.RecDetails[i].Pro_Name + " </td>";
                            tbl += "<td style='text-align:left;' id='txtCreatedBy"+i+"'>" + data.RecDetails[i].Created_By + " </td>";
                            tbl += "<td style='text-align:left;' id='txtCreatedDate"+i+"'>" + datet + " </td>";
                            tbl += "<td style='text-align:left;' id='txtModifiedBy"+i+"'>" + data.RecDetails[i].Modified_By + " </td>";
                            tbl += "<td style='text-align:left;' id='txtModifiedDate"+i+"'>" + mdatet + " </td>";
                      tbl += "</tr>";
                }   

                tbl += "</tbody>";
                tbl += "</table>";
                $("#tblReceiptData").html(tbl);
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
                            url: "FrmReciptsDetails.aspx/DeleteRecpData", 
                            data: "{'Recp_Id':'"+ID+"'}", 
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
               window.location = 'ReceiptsAndExpense.aspx?Recp_Id='+ID;  
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
                getReceiptData();
                alert("Record successfully deleted!");
                return false;
            } 
        function onretrieveDeleteError()
            {
                alert("Error occurred in deleting record!");
                getReceiptData();
            }        
        function openAdvancedSearch()
            {
                $("#divAdvanceSearch").slideToggle();
                return false;
            }
     
    </script>

</asp:Content>

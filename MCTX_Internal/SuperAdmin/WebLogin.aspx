<%@ Page Language="C#" MasterPageFile="~/MCTX_Internal/SuperAdmin/MasterAdmin.master"
    AutoEventWireup="true" CodeFile="WebLogin.aspx.cs" Inherits="MCTX_Internal_SuperAdmin_WebLogin"
    Title="Web Login" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <script src="../../js/jquery.dataTables.min.js" type="text/javascript"></script>
    <script src="../../js/BlockUI.js" type="text/javascript"></script>
    <script src="../../js/FieldValidation.js" type="text/javascript"></script>

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
        input
        {
        	border:1px solid #CCCCCC;
        }
    </style>
    <div id="tabs" style="width: 949px;">
        <ul>
            <li style="text-align: left"><a href="#tabs-1">Web Login</a></li>
        </ul>
        <fieldset style="width: 95%">
            <legend>Web Login</legend>
            <table width="100%">
                <tr>
                    <td style="width: 100%">
                        <fieldset style="width: 95%">
                            <legend>Search:</legend>
                            <table width="60%" style="margin: 15px;">
                                <tr>
                                    <td>
                                        User Name:
                                    </td>
                                    <td align="left">
                                        <asp:TextBox ID="txtUserName" runat="server"></asp:TextBox>
                                    </td>
                                    <td align="left">
                                        <asp:Button ID="btnSearch" runat="server" Text="Search" OnClientClick="return getUsers();" />
                                    </td>
                                </tr>
                            </table>
                        </fieldset>
                        <br />
                        <fieldset style="width: 95%">
                            <table id="tblUserInfo" width="60%" class="dataTable">
                            </table>
                        </fieldset>
                    </td>
                </tr>
            </table>
        </fieldset>
    </div>

    <script type="text/javascript" language="javascript">
   
   $(document).ready(function(){
   getUsers();
   
   });
   
   function getUsers()
    {
     var userName=$("input[id$='txtUserName']").val();
    $.ajax({
            type: "POST",
            contentType: "application/json; charset=utf-8",
            url: "WebLogin.aspx/getWebUsers",
            data: "{'userName':'"+userName+"'}",
            dataType: "json",
            success: onsuccessLoadData,
            error:OnretrieveError 
            });
    }
    
    function onsuccessLoadData(msg)
    { 
        var data = msg.d;
            var tbl = "";
                tbl += "<thead>"
                    tbl += "<tr>"
                        tbl += "<th style='cursor:Pointer'>User Name</th>";
                        tbl += "<th style='cursor:Pointer'>User ID</th>"; 
                        tbl += "<th style='cursor:Pointer'>Role</th>";  
                     tbl += "</tr>"
                tbl += "</thead>"
                tbl += "<tbody>"
                    for (var i = 0; i < data.user1.length; i++) {
                        tbl += "<tr id='trmain" + i + "' style='cursor:pointer' onclick='return gotoConnect("+i+");'>"; 
                            tbl += "<td align='left' id='txtuserName"+i+"'>" + data.user1[i].E_name + " </td>";                    
                            tbl += "<td align='left' id='txtUserID"+i+"'>" + data.user1[i].user_id + " </td>";
                            tbl += "<td align='left' id='txtPwd"+i+"'>" + data.user1[i].role_name + " </td>";
                        tbl += "</tr>";          
                    }
                tbl += "</tbody>"
            tbl += "</table>"          
        $("#tblUserInfo").html(tbl);
    }
    
    function OnretrieveError(error) {
    var errors = eval("(" + error.responseText + ")");
    alert("Error in Loading Data: " + errors.Message);
      }
      
      function gotoConnect(rowNo)
      {
     
      userID=$("#txtUserID"+rowNo).html().trim();    
      //window.location = '../../MCTX_General/Login.aspx?userID='+userID; 
      
      
      window.open('../../MCTX_General/Login.aspx?userID='+userID, null, 'top=50,left=200,center=yes,resizable=no,Width=850px,Height= 700px,status=no,titlebar=no;toolbar=no,menubar=no,location=0,scrollbars=yes');
                	return false;
       //window.open

      
      }
   
    </script>

</asp:Content>

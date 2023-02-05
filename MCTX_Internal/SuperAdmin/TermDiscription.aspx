<%@ Page Title="" Language="C#" MasterPageFile="~/MCTX_Internal/SuperAdmin/MasterAdmin.master" AutoEventWireup="true" CodeFile="TermDiscription.aspx.cs" Inherits="MCTX_Internal_SuperAdmin_TermDiscription" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <table style="width:80%;">
        <tr>
            <td style="text-align:right;" >
                Type Name:
            </td>
            <td>
              <asp:DropDownList ID="ddlType"  Style="width:50%; height:20px; background-color:white;float:left;"  runat="server"></asp:DropDownList>
            </td>

        </tr>
        <tr>
            <td style="text-align:right;" >
               Terms and Condition Name:
            </td>
            <td>
               <asp:TextBox ID="txtTermName"  runat="server" Style="width:50%; height:20px; background-color:white;float:left;"></asp:TextBox>
            </td>

        </tr>
            <tr>
            <td style="text-align:right;" >
               Discription:
            </td>
            <td>
                <textarea id="txtDiscription" cols="50" runat="server" style="float:left;" rows="3"></textarea>
            </td>

        </tr>
        <tr>
            <td></td>
            <td>
                 <asp:Button ID="btnTermsAndCondition" runat="server" Text="Add/Update" Style="float:left;" BackColor="#ABD3FC" ForeColor="Black" OnClick="btnTermsAndCondition_Click"/>
            </td>
        </tr>
    </table>
   <asp:TextBox ID="txtID"  runat="server" text="0" style="display:none;" ></asp:TextBox>
    <table id="tblType" border="1" class="dataTable" style="width:100%;"></table>

    <script type="text/javascript">

        $(document).ready(function () {

            LoadTypeInfo();
        });
        function LoadTypeInfo() {
            //var CompID = $("select[id$='ddlCompanyName'] option:selected").val();

            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "TermDiscription.aspx/LoadTermDiscription",
                data: "{}",
                success: onsuccessLoadComp,
                error: onErrorLoadComp
            });
            return false;
        }
        function onsuccessLoadComp(msg) {
            var data = msg.d;
            //if (oTable != null) {
            //    oTable.fnClearTable();
            //    oTable.fnDestroy();
            //}

            var tbl = "";
            tbl += "<thead>";
            tbl += "<tr>";
            tbl += "<th id='txtEditth' style='cursor:Pointer;text-align:center;white-space:nowrap;border:1px solid #999999;'>Edit</th>";
            tbl += "<th style='white-space:nowrap; text-align:left; display:none;'>Term ID</th>";
            tbl += "<th style='white-space:nowrap; text-align:left; display:none;'>Type ID</th>";
            tbl += "<th style='white-space:nowrap; text-align:left;'>Type Name</th>";
            tbl += "<th style='white-space:nowrap; text-align:left;'>Term Discription</th>";
            tbl += "<th style='white-space:nowrap; text-align:left;'>Created By</th>";
            tbl += "<th style='white-space:nowrap; text-align:left;'>Created Date</th>";
            tbl += "<th style='white-space:nowrap; text-align:left;'>Modified By</th>";
            tbl += "<th style='white-space:nowrap; text-align:left;'>Modified Date</th>";
            tbl += "</tr>";
            tbl += "</thead>";
            tbl += "<tbody>";
            for (var i = 0; i < data.TermDiscription.length; i++) {
                tbl += "<tr  id='rowmain" + i + "'>";
                tbl += "<td id='txtEdit" + i + "' align='center' style='border:1px solid #999999;'> <input  type='image' src='image/Edit.png' style='width:16px; border:0px;' onclick='return GetRowForUpdation(" + i + ");'></td>";
                tbl += "<td style='text-align:left; white-space:nowrap; display:none; ' id='txtID" + i + "'>" + data.TermDiscription[i].Term_ID + "</td>";
                tbl += "<td style='text-align:left; white-space:nowrap; display:none; ' id='txtTypeID" + i + "'>" + data.TermDiscription[i].id + "</td>";
                tbl += "<td style='text-align:left; ' id='txtTypeName" + i + "'>" + data.TermDiscription[i].typeName + " </td>";
                tbl += "<td style='text-align:left; ' id='txtDiscription" + i + "'>" + data.TermDiscription[i].Term_Discription + " </td>";
                tbl += "<td style='text-align:left; white-space:nowrap;' id='txtCreatedBy" + i + "'>" + data.TermDiscription[i].created_By + " </td>";
                tbl += "<td style='text-align:left;' id='txtCreatedDate" + i + "'>" + data.TermDiscription[i].created_date + " </td>";
                tbl += "<td style='text-align:left; white-space:nowrap;' id='txtModBy" + i + "'>" + data.TermDiscription[i].modify_By + " </td>";
                tbl += "<td style='text-align:left; white-space:nowrap;' id='txtcreateddate" + i + "'>" + data.TermDiscription[i].modify_Date + " </td>";
                tbl += "</tr>";
            }
            tbl += "</tbody>";
            $("#tblType").html(tbl);
            //dataTable();
            return false;
        }
        function onErrorLoadComp() {
            alert("Error In Loading Details!");
            return false;
        }
        function GetRowForUpdation(rowNo) {
            $("#tblType tr").css("background-color", "");
            $("#rowmain" + rowNo).css("background-color", "#F3EFE0");
            var ID = $("#txtTypeID" + rowNo).html().trim();
            $("input[id$='txtID']").val($("#txtID" + rowNo).html().trim());
            $("select[id$='ddlType']").val($("#txtTypeID" + rowNo).html().trim());
            $("input[id$='txtTermName']").val($("#txtTypeName" + rowNo).html().trim());
            $("TextArea[id$='txtDiscription']").val($("#txtDiscription" + rowNo).html().trim());
            return false;
        }

    </script>
</asp:Content>


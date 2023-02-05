<%@ Page Language="C#" MasterPageFile="~/MCTX_Internal/SuperAdmin/MasterAdmin.master"
    AutoEventWireup="true" CodeFile="home-settings.aspx.cs" Inherits="MCTX_Internal_SuperAdmin_home_settings"
    Title="Home Admin" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <script src="../../js/jquery-1.7.js" type="text/javascript"></script>

    <style type="text/css">
        .button
        {
            background-image: url(         'images/green_glossy_button.png' );
            height: 25px;
            width: 80px;
            cursor: pointer;
            -moz-border-radius: 8px;
        }
        textarea
        {
            text-align: justify;
            font-family: Calibri;
            font-size: 10pt;
            width: 300px;
            box-shadow: 0 -1px 0 rgba(0, 0, 0, 0.3), 0 1px 2px rgba(0, 0, 0, 0.1) inset, 0 0 10px rgba(255, 255, 255, 0.9);
        }
    </style>
    <br />
    <table id="sales">
        <%--<tr>
            <td style="width: 150px" align="left">
                <br />
                <asp:Label ID="LblSales" runat="server" Text="Sales Person"></asp:Label>
            </td>
            <td>
                <br />
                <asp:TextBox ID="TxtSales" runat="server" BackColor="White" BorderColor="#cecece"
                    BorderStyle="Solid"></asp:TextBox>
            </td>
        </tr>--%>
        <tr>
            <td colspan="4">
                <h3>
                    News Settings
                </h3>
            </td>
        </tr>
        <tr>
            <td style="width: 120px" align="left">
                <img src="images/Alarm-Arrow-Right-icon.png" width="19px" height="18px" alt="" style="vertical-align: middle;" />
                <asp:Label ID="LblNewtitle" runat="server" Text="News Title"></asp:Label><br />
                <br />
                <img src="images/Alarm-Arrow-Right-icon.png" width="19px" height="18px" alt="" style="vertical-align: middle;" />
                <asp:Label ID="LblNewupdate" runat="server" Text="News Update"></asp:Label>
            </td>
            <td align="left">
                <br />
                <asp:TextBox ID="title" runat="server" BorderColor="#cecece" BorderStyle="Solid"
                    Width="300px" BorderWidth="2px" BackColor="White"></asp:TextBox>
                <br />
                <asp:TextBox ID="TxtNewupdate" onKeyPress="return keyRestrict(event,'abcdefghijklmnopqrstuvwxyz1234567890.,:@#&-_!+/ ()*')"
                    runat="server" TextMode="MultiLine" BorderColor="#cecece" BorderStyle="Solid"></asp:TextBox>
            </td>
            <td style="width: 120px; padding-left: 10px" align="left">
                <img src="images/Alarm-Arrow-Right-icon.png" width="19px" height="18px" alt="" style="vertical-align: middle;" />
                <asp:Label ID="LblNewtitle1" runat="server" Text="News Title"></asp:Label><br />
                <br />
                <img src="images/Alarm-Arrow-Right-icon.png" width="18px" height="18px" alt="" style="vertical-align: middle" />
                <asp:Label ID="Label1" runat="server" Text="News Update"></asp:Label>
            </td>
            <td>
                <br />
                <asp:TextBox ID="title1" runat="server" BorderColor="#cecece" BorderStyle="Solid"
                    Width="300px" BorderWidth="2px" BackColor="White"></asp:TextBox>
                <br />
                <asp:TextBox ID="TxtNewupdate1" onKeyPress="return keyRestrict(event,'abcdefghijklmnopqrstuvwxyz1234567890.,:@#&-_!+/ ()*')"
                    runat="server" TextMode="MultiLine" BorderColor="#cecece" BorderStyle="Solid"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td style="width: 120px" align="left">
                <img src="images/Alarm-Arrow-Right-icon.png" width="19px" height="18px" alt="" style="vertical-align: middle" />
                <asp:Label ID="lbltitle1" runat="server" Text="News Title"></asp:Label><br />
                <br />
                <img src="images/Alarm-Arrow-Right-icon.png" width="19px" height="18px" alt="" style="vertical-align: middle" />
                <asp:Label ID="LblNewupdate2" runat="server" Text="News Update"></asp:Label>
            </td>
            <td>
                <br />
                <asp:TextBox ID="title2" runat="server" BorderColor="#cecece" BorderStyle="Solid"
                    Width="300px" BorderWidth="2px" BackColor="White"></asp:TextBox>
                <br />
                <asp:TextBox ID="TxtNewupdate2" onKeyPress="return keyRestrict(event,'abcdefghijklmnopqrstuvwxyz1234567890.,:@#&-_!+/ ()*')"
                    runat="server" TextMode="MultiLine" BorderColor="#cecece" BorderStyle="Solid"></asp:TextBox>
            </td>
            <td style="width: 120px; padding-left: 10px" align="left">
                <img src="images/Alarm-Arrow-Right-icon.png" width="19px" height="18px" alt="" style="vertical-align: middle" />
                <asp:Label ID="Label5" runat="server" Text="News Title"></asp:Label><br />
                <br />
                <img src="images/Alarm-Arrow-Right-icon.png" width="18px" height="18px" alt="" style="vertical-align: middle" />
                <asp:Label ID="Label2" runat="server" Text="News Update"></asp:Label>
            </td>
            <td>
                <br />
                <asp:TextBox ID="title3" runat="server" BorderColor="#cecece" BorderStyle="Solid"
                    Width="300px" BorderWidth="2px" BackColor="White"></asp:TextBox>
                <br />
                <asp:TextBox ID="TxtNewupdate3" onKeyPress="return keyRestrict(event,'abcdefghijklmnopqrstuvwxyz1234567890.,:@#&-_!+/ ()*')"
                    runat="server" TextMode="MultiLine" BorderColor="#cecece" BorderStyle="Solid"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td style="width: 120px" align="left">
                <img src="images/Alarm-Arrow-Right-icon.png" width="19px" height="18px" alt="" style="vertical-align: middle" />
                <asp:Label ID="Label6" runat="server" Text="News Title"></asp:Label><br />
                <br />
                <img src="images/Alarm-Arrow-Right-icon.png" width="18px" height="18px" alt="" style="vertical-align: middle" />
                <asp:Label ID="LblNewupdate4" runat="server" Text="News Update"></asp:Label>
            </td>
            <td>
                <br />
                <asp:TextBox ID="title4" runat="server" BorderColor="#cecece" BorderStyle="Solid"
                    Width="300px" BorderWidth="2px" BackColor="White"></asp:TextBox>
                <br />
                <asp:TextBox ID="TxtNewupdate4" onKeyPress="return keyRestrict(event,'abcdefghijklmnopqrstuvwxyz1234567890.,:@#&-_!+/ ()*')"
                    runat="server" TextMode="MultiLine" BorderColor="#cecece" BorderStyle="Solid"></asp:TextBox>
            </td>
            <td style="width: 120px; padding-left: 10px" align="left">
                <img src="images/Alarm-Arrow-Right-icon.png" width="19px" height="18px" alt="" style="vertical-align: middle" />
                <asp:Label ID="Label7" runat="server" Text="News Title"></asp:Label><br />
                <br />
                <img src="images/Alarm-Arrow-Right-icon.png" width="18px" height="18px" alt="" style="vertical-align: middle" />
                <asp:Label ID="Label3" runat="server" Text="News Update"></asp:Label>
            </td>
            <td>
                <br />
                <asp:TextBox ID="title5" runat="server" BorderColor="#cecece" BorderStyle="Solid"
                    Width="300px" BorderWidth="2px" BackColor="White"></asp:TextBox>
                <br />
                <asp:TextBox ID="TxtNewupdate5" onKeyPress="return keyRestrict(event,'abcdefghijklmnopqrstuvwxyz1234567890.,:@#&-_!+/ ()*')"
                    runat="server" TextMode="MultiLine" BorderColor="#cecece" BorderStyle="Solid"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td style="width: 120px" align="left">
                <img src="images/Alarm-Arrow-Right-icon.png" width="19px" height="18px" alt="" style="vertical-align: middle" />
                <asp:Label ID="Label8" runat="server" Text="News Title"></asp:Label><br />
                <br />
                <img src="images/Alarm-Arrow-Right-icon.png" width="18px" height="18px" alt="" style="vertical-align: middle" />
                <asp:Label ID="LblNewupdate6" runat="server" Text="News Update"></asp:Label>
            </td>
            <td>
                <br />
                <asp:TextBox ID="title6" runat="server" BorderColor="#cecece" BorderStyle="Solid"
                    Width="300px" BorderWidth="2px" BackColor="White"></asp:TextBox>
                <br />
                <asp:TextBox ID="TxtNewupdate6" onKeyPress="return keyRestrict(event,'abcdefghijklmnopqrstuvwxyz1234567890.,:@#&-_!+/ ()*')"
                    runat="server" TextMode="MultiLine" BorderColor="#cecece" BorderStyle="Solid"></asp:TextBox>
            </td>
            <td style="width: 120px; padding-left: 10px" align="left">
                <img src="images/Alarm-Arrow-Right-icon.png" width="19px" height="18px" alt="" style="vertical-align: middle" />
                <asp:Label ID="Label9" runat="server" Text="News Title"></asp:Label><br />
                <br />
                <img src="images/Alarm-Arrow-Right-icon.png" width="18px" height="18px" alt="" style="vertical-align: middle" />
                <asp:Label ID="Label4" runat="server" Text="News Update"></asp:Label>
            </td>
            <td>
                <br />
                <asp:TextBox ID="title7" runat="server" BorderColor="#cecece" BorderStyle="Solid"
                    Width="300px" BorderWidth="2px" BackColor="White"></asp:TextBox>
                <br />
                <asp:TextBox ID="TxtNewupdate7" onKeyPress="return keyRestrict(event,'abcdefghijklmnopqrstuvwxyz1234567890.,:@#&-_!+/ ()*')"
                    runat="server" TextMode="MultiLine" BorderColor="#cecece" BorderStyle="Solid"></asp:TextBox>
                <br />
                <br />
            </td>
        </tr>
        <tr>
            <%-- <td colspan="2" style="cursor: pointer; padding-top: 10px;display:none;" align="right">
                <asp:Button ID="BtnEdit" CssClass="button" ForeColor="#357204" Font-Bold="true" Text="Edit"
                    ToolTip="Edit" runat="server" OnClientClick="return GetRowForUpdation();" />
                <br />
                <br />
            </td>--%>
            <td colspan="4" style="cursor: pointer; padding-top: 10px; padding-left: 10px" align="center">
                <asp:Button ID="BtnSubmit" CssClass="button" ForeColor="#357204" Font-Bold="true"
                    Text="Update" ToolTip="Submit" runat="server" OnClientClick="addNews(); return false;" />
                <br />
                <br />
            </td>
        </tr>
    </table>
    <table width="100%">
        <tr>
            <td>
                <div id="tblHomeInfo" class="dataTable">
                </div>
            </td>
        </tr>
    </table>
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
        input:focus
        {
            box-shadow: 0 -1px 0 rgba(0, 0, 0, 0.3), 0 1px 2px rgba(0, 0, 0, 0.1) inset, 0 0 10px rgba(255, 255, 255, 0.9);
        }
        textarea:focus
        {
            box-shadow: 0 -1px 0 rgba(0, 0, 0, 0.3), 0 1px 2px rgba(0, 0, 0, 0.1) inset, 0 0 10px rgba(255, 255, 255, 0.9);
        }
    </style>

    <script type="text/javascript" language="javascript">

        function addNews() {


            var newupdate = $("textarea[id$='TxtNewupdate']").val();
            var newupdate1 = $("textarea[id$='TxtNewupdate1']").val();
            var newupdate2 = $("textarea[id$='TxtNewupdate2']").val();
            var newupdate3 = $("textarea[id$='TxtNewupdate3']").val();
            var newupdate4 = $("textarea[id$='TxtNewupdate4']").val();
            var newupdate5 = $("textarea[id$='TxtNewupdate5']").val();
            var newupdate6 = $("textarea[id$='TxtNewupdate6']").val();
            var newupdate7 = $("textarea[id$='TxtNewupdate7']").val();


            if ($("textarea[id$='TxtNewupdate']").val() == "") {
                alert("Please Enter News Update");

            }
            else if ($("textarea[id$='TxtNewupdate1']").val() == "") {
                alert("Please Enter News Update1");

            }
            else if ($("textarea[id$='TxtNewupdate2']").val() == "") {
                alert("Please Enter News Update2");

            }
            else if ($("textarea[id$='TxtNewupdate3']").val() == "") {
                alert("Please Enter News Update3");

            }
            else if ($("textarea[id$='TxtNewupdate4']").val() == "") {
                alert("Please Enter News Update4");

            }
            else if ($("textarea[id$='TxtNewupdate5']").val() == "") {
                alert("Please Enter News Update5");

            }
            else if ($("textarea[id$='TxtNewupdate6']").val() == "") {
                alert("Please Enter News Update6");

            }
            else if ($("textarea[id$='TxtNewupdate7']").val() == "") {
                alert("Please Enter News Update7");

            }
            else {
                var request = "{'newupdate':'" + newupdate + "','newupdate1':'" + newupdate1 + "','newupdate2':'" + newupdate2 + "','newupdate3':'" + newupdate3 + "','newupdate4':'" + newupdate4 + "','newupdate5':'" + newupdate5 + "','newupdate6':'" + newupdate6 + "','newupdate7':'" + newupdate7 + "'}";

                $.ajax({
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    url: "home-settings.aspx/senddata",
                    data: request,
                    async:false,
                    success: onSuccessSubmit,
                    error: onErrorMessageSubmit

                });
                return false;
            }
        }

        function onSuccessSubmit() {
            addtitle();
            alert('News has been updated');
            return false;
        }

        function onErrorMessageSubmit() {
            alert('error');
            return false;
        }

        function addtitle() {
            var addtitle = $("input[id$='title']").val();
            var addtitle1 = $("input[id$='title1']").val();
            var addtitle2 = $("input[id$='title2']").val();
            var addtitle3 = $("input[id$='title3']").val();
            var addtitle4 = $("input[id$='title4']").val();
            var addtitle5 = $("input[id$='title5']").val();
            var addtitle6 = $("input[id$='title6']").val();
            var addtitle7 = $("input[id$='title7']").val();

            var request = "{'newstitle':'" + addtitle + "','newstitle1':'" + addtitle1 + "','newstitle2':'" + addtitle2 + "','newstitle3':'" + addtitle3 + "','newstitle4':'" + addtitle4 + "','newstitle5':'" + addtitle5 + "','newstitle6':'" + addtitle6 + "','newstitle7':'" + addtitle7 + "'}";

            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "home-settings.aspx/titledata",
                data: request,
                success: onSuccessSubmitTitle,
                error: onErrorMessageSubmitTitle

            });
            return false;
        }
        function onSuccessSubmitTitle() {
            //alert("News Submitted!");
            return false;
        }

        function onErrorMessageSubmitTitle() {
            alert("Error in updating News titles");
        }

        function gettitle() {

            $.ajax({
                type: "POST",
                dataType: "json",
                contentType: "application/json; charset=utf-8",
                url: "Welcome.aspx/gettitle",
                data: {},
                success: GetMessages,
                error: Error
            });
            return false;
        }

        function GetMessages(msg) {

            var data = msg.d;
            $("input[id$='title']").val(data.title[0].news_title);
            $("input[id$='title1']").val(data.title[0].news_title1);
            $("input[id$='title2']").val(data.title[0].news_title2);
            $("input[id$='title3']").val(data.title[0].news_title3);
            $("input[id$='title4']").val(data.title[0].news_title4);
            $("input[id$='title5']").val(data.title[0].news_title5);
            $("input[id$='title6']").val(data.title[0].news_title6);
            $("input[id$='title7']").val(data.title[0].news_title7);
        }
        function Error() {
            alert("Error");
            return false;
        }



        function getdata() {

            $.ajax({
                type: "POST",
                dataType: "json",
                contentType: "application/json; charset=utf-8",
                url: "home-settings.aspx/getdata",
                data: {},
                success: OnGetMessages,
                error: OnretrieveError
            });
            return false;
        }

        function OnGetMessages(msg) {
            var data = msg.d;
            $("textarea[id$='TxtNewupdate']").val(data.settings[0].new_update);
            $("textarea[id$='TxtNewupdate1']").val(data.settings[0].new_update1);
            $("textarea[id$='TxtNewupdate2']").val(data.settings[0].new_update2);
            $("textarea[id$='TxtNewupdate3']").val(data.settings[0].new_update3);
            $("textarea[id$='TxtNewupdate4']").val(data.settings[0].new_update4);
            $("textarea[id$='TxtNewupdate5']").val(data.settings[0].new_update5);
            $("textarea[id$='TxtNewupdate6']").val(data.settings[0].new_update6);
            $("textarea[id$='TxtNewupdate7']").val(data.settings[0].new_update7);
            var tbl = "";
            tbl += "<thead>";
            tbl += "<tr>";
            tbl += "<th style='cursor:Pointer;text-align:center;white-space:nowrap;border:1px solid #999999;'>News Description</th>";
            tbl += "</tr>";
            tbl += "</thead>";
            tbl += "<tbody>";
            for (var i = 0; i < data.settings.length; i++) {
                tbl += "<tr id='trmain' style='cursor:default;border:1px solid #999999;'>"
                tbl += "<td id='txtDescriptionID' align='left' style='border:1px solid #999999;'>" + data.settings[i].new_update + " </td>";
                tbl += "</tr>";
                tbl += "<tr>";
                tbl += "<td id='txtDescriptionID1' align='left' style='border:1px solid #999999;'>" + data.settings[i].new_update1 + " </td>";
                tbl += "</tr>";
                tbl += "<tr>";
                tbl += "<td id='txtDescriptionID2' align='left' style='border:1px solid #999999;'>" + data.settings[i].new_update2 + " </td>";
                tbl += "</tr>";
                tbl += "<tr>";
                tbl += "<td id='txtDescriptionID3' align='left' style='border:1px solid #999999;'>" + data.settings[i].new_update3 + " </td>";
                tbl += "</tr>";
                tbl += "<tr>";
                tbl += "<td id='txtDescriptionID4' align='left' style='border:1px solid #999999;'>" + data.settings[i].new_update4 + " </td>";
                tbl += "</tr>";
                tbl += "<tr>";
                tbl += "<td id='txtDescriptionID5' align='left' style='border:1px solid #999999;'>" + data.settings[i].new_update5 + " </td>";
                tbl += "</tr>";
                tbl += "<tr>";
                tbl += "<td id='txtDescriptionID6' align='left' style='border:1px solid #999999;'>" + data.settings[i].new_update6 + " </td>";
                tbl += "</tr>";
                tbl += "<tr>";
                tbl += "<td id='txtDescriptionID7' align='left' style='border:1px solid #999999;'>" + data.settings[i].new_update7 + " </td>";
                tbl += "</tr>";
            }
            tbl += "</tbody>";
            tbl += "</table>";
            $("#tblHomeInfo").html(tbl);

        }
        function OnretrieveError() {
            alert(" Error");
        }

        function GetRowForUpdation() {
            var rowNo = 0;
            $("textarea[id$='TxtNewupdate']").val($("#txtDescriptionID").html().trim());
            $("textarea[id$='TxtNewupdate1']").val($("#txtDescriptionID1").html().trim());
            $("textarea[id$='TxtNewupdate2']").val($("#txtDescriptionID2").html().trim());
            $("textarea[id$='TxtNewupdate3']").val($("#txtDescriptionID3").html().trim());
            $("textarea[id$='TxtNewupdate4']").val($("#txtDescriptionID4").html().trim());
            $("textarea[id$='TxtNewupdate5']").val($("#txtDescriptionID5").html().trim());
            $("textarea[id$='TxtNewupdate6']").val($("#txtDescriptionID6").html().trim());
            $("textarea[id$='TxtNewupdate7']").val($("#txtDescriptionID7").html().trim());
            return false;
        }



        $(document).ready(function() {
            getdata();
            gettitle();
        });

        function keyRestrict(e, validchars, casesensitives, onceevery, onceoneof) {

            onceevery = onceevery ? onceevery : "";
            onceoneof = onceoneof ? onceoneof : "";

            if (!validchars)
                return true;
            var key = '', keychar = '', obj = '', i = 0;
            var key = e.which ? e.which : window.event.keyCode;
            var obj = e.target ? e.target : window.event.srcElement;
            if (key == null)
                return true;
            keychar = String.fromCharCode(key);
            validchars = (validchars + onceevery + onceoneof);
            if (!casesensitives) {
                keychar = keychar.toLowerCase();
                validchars = validchars.toLowerCase();
                onceevery = onceevery.toLowerCase();
                onceoneof = onceoneof.toLowerCase();
            }
            for (i = 0; i < (onceevery + onceoneof).length; i++) {
                if (i < onceevery.length) {
                    if (obj.value.indexOf(onceevery.charAt(i)) != -1 && keychar == onceevery.charAt(i))
                        return false;
                }
                else {
                    if (obj.value.indexOf(onceoneof.charAt(i - onceevery.length)) != -1 && onceoneof.indexOf(keychar) != -1)
                        return false;
                }
            }

            if (validchars.indexOf(keychar) != -1)
                return true;

            if (key == null || key == 0 || key == 8 || key == 9 || key == 13 || key == 27)
                return true;
            return false;
        }

    </script>

</asp:Content>

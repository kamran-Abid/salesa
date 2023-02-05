<%@ Page Language="C#" AutoEventWireup="true" CodeFile="testing.aspx.cs" Inherits="testing" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <script src="js/jquery-1.4.2.min.js"></script>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <table>
                <tr>
                    <td>
                        <input type="text" id="a" runat="server" name="text" /></td>
                    <td>
                        <input type="text" id="b" runat="server" name="text" /></td>
                    <td>
                        <input type="text" id="c" runat="server" name="text" /></td>

                </tr>
                <tr>
                    <td>
                        <input type="button" runat="server" name="button" title="Submit" onclick='submitdata();' />
                 
                    </td>
                </tr>
            </table>
        </div>
    </form>
</body>
</html>
<script type="text/javascript">

    function submitdata() {
     
        var a = $("input#a").val();
        var b = $("input#b").val();
        var c = $("input#c").val();

        $.ajax({
            type: "POST",
            contentType: "application/json; charset=utf-8",
            url: "testing.aspx/managament",
            data: "{'a':'" + a + "','b':'" + b + "','c':'" + c + "'}",
            success: onsuccessdata,
            error: errordata
        });
    }
    function onsuccessdata() {
        alert("Sucessful");
    }
    function errordata() {
        alert("Error");
    }
</script>

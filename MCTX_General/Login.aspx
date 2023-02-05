<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Login.aspx.cs" Inherits="MCTX_General_Login" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajtk" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Mechatronix Employee Area</title>
</head>
<body>
    <link href="../css1/stylelog.css" rel="stylesheet" type="text/css" />
    <form id="form1" runat="server">
    <div id="layer01_holder">
        <div id="left">
        </div>
        <div id="center">
        </div>
        <div id="right">
        </div>
    </div>
    <div id="layer02_holder">
        <div id="left">
        </div>
        <div id="center">
        </div>
        <div id="right">
        </div>
    </div>
    <div id="layer03_holder">
        <div id="left">
            
        </div>
        <div id="center">
            <table border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td>
                        LOGIN<br />
                        <br />
                    </td>
                    <td>
                    </td>
                </tr>
                <tr>
                    <td>
                        <form id="form2" name="form1" method="post" action="">
                        <table>
                            <tr>
                                <td>
                                    Name
                                </td>
                                <td>
                                    <asp:TextBox ID="textfield" runat="server" Width="143px" />
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    Password
                                </td>
                                <td>
                                    <asp:TextBox ID="textfield2" TextMode="Password" runat="server" Width="143px" Style="margin-top: 5px;" />
                                </td>
                            </tr>
                            <tr>
                                <td>
                                </td>
                                <td align="right">
                                    <asp:Button runat="server" ID="button" Text="Submit" Width="65px" OnClick="btn_login_Click" />
                                </td>
                            </tr>
                        </table>
                        </form>
                    </td>
                    <td>
                        <asp:Label ID="lbl_Msg" runat="server" ForeColor="#FF3300"></asp:Label>
                    </td>
                </tr>
            </table>
        </div>
        <div id="right">
        </div>
    </div>
    <div id="layer04_holder">
        <div id="left">
        </div>
        <div id="center">
            If you forgot your password, please contact IT department it@mechatronix.com.pk</div>
        <div id="right">
        </div>
    </div>
    <div id="layer05_holder">
        <%--<div align="left" style="display:none;">
            Copyright © 2012, Mechatronix</div>--%>
      
          <div  style="text-align:left;color:white;">
                Copyrights &copy; 2012 -
                <script type="text/javascript">var d = new Date(); document.write(d.getFullYear());</script>
                Mechatronix. All rights reserved
            </div>

    </div>




    </form>
</body>
</html>

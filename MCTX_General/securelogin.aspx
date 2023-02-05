<%@ Page Language="C#" AutoEventWireup="true" CodeFile="securelogin.aspx.cs" Inherits="MCTX_General_securelogin" %>

<!DOCTYPE html>
<!--[if lt IE 7 ]> <html lang="en" class="ie6 ielt8"> <![endif]-->
<!--[if IE 7 ]>    <html lang="en" class="ie7 ielt8"> <![endif]-->
<!--[if IE 8 ]>    <html lang="en" class="ie8"> <![endif]-->
<!--[if (gte IE 9)|!(IE)]><!-->
<html>
<!--<![endif]-->
<head>
    <meta charset="utf-8">
    <title>Secure Login</title>
    <link href="../css1/securelogin.css" rel="stylesheet" />

</head>
<body>
    <div class="container">
        <section id="content">
            <form id="form1" runat="server">
                <h1>Employees Login</h1>
                <div>
                    <asp:TextBox ID="username" runat="server" placeholder="Username" />
                </div>
                <div>
                    <asp:TextBox ID="password" TextMode="Password" runat="server" placeholder="Password" />
                </div>
                <div>
                    <asp:Button runat="server" ID="button" Text="Submit" OnClick="btn_login_Click" />
                    <div style="font-size: 11px; padding-top: 25px;">
                        &nbsp;
                     If you forgot your password, please contact IT department <a style="float: none; font-size: 11px" href="mailto:it@mechatronix.com.pk">it@mechatronix.com.pk</a>
                    </div>
                </div>
                <div>
                    <asp:Label ID="lbl_Msg" runat="server" ForeColor="#FF3300"></asp:Label>
                </div>
            </form>
            <!-- form -->
            <div class="button">
                <div style="font-size: 12px;">
                    Copyrights &copy; 2003 -
               
                    <script type="text/javascript">var d = new Date(); document.write(d.getFullYear());</script>
                    <a href="http://www.mechatronix.com.pk">Mechatronix </a>. All rights reserved
           
                </div>
            </div>
            <!-- button -->
        </section>
        <!-- content -->
    </div>
    <!-- container -->
</body>
</html>

<%@ Page Language="C#" MasterPageFile="~/MCTX_Internal/SuperAdmin/MasterAdmin.master" AutoEventWireup="true" CodeFile="Welcome.aspx.cs" Inherits="MCTX_Internal_SuperAdmin_Administrator" Title="::Welcome::" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <script src="../../js/BlockUI.js" type="text/javascript"></script>

    <table border="0" cellpadding="0" cellspacing="0" width="100%" style="height: 100%">
        <tr>
            <td style="width: 87px; height: 19px;"></td>
            <td style="text-align: left; height: 19px; padding-top: 15px;">Welcome,
                <asp:label id="lblUser" runat="server" font-bold="True"></asp:label>
            </td>
        </tr>
        <tr>
            <td colspan="2" style="text-align: center;">
                <strong><span style="font-size: 10pt; text-decoration: underline;">Mechatronix News</span></strong><br />
                <br />
            </td>
        </tr>
        This is running Fine FFO
        <tr>
            <td style="width: 87px; height: 12px;"></td>
            <td style="height: 12px; text-align: left;">

                <span id="newupdate"></span>
            </td>
        </tr>
        <tr>
            <td style="width: 87px; height: 12px;"></td>
            <td style="height: 12px; text-align: left;"></td>
        </tr>
        <tr>
            <td style="width: 87px; height: 26px;">
                <ul style="list-style-type: disc; text-align: right;">
                    <li></li>
                </ul>
            </td>
            <td style="height: 26px; text-align: left;">

                <span id="title1" style="font-weight: bold">
                    <br />
                </span>
                <br />
                <span id="newupdate1"></span>
            </td>
        </tr>
        <tr>
            <td style="width: 87px; height: 12px;"></td>
            <td style="height: 12px; text-align: left;"></td>
        </tr>
        <tr>
            <td style="width: 87px; height: 26px;">
                <ul style="list-style-type: disc; text-align: right;">
                    <li></li>
                </ul>
            </td>
            <td style="height: 26px; text-align: left;">
                <span id="title2" style="font-weight: bold"></span>
                <br />

                <span id="newupdate2"></span>&nbsp;
                  
            </td>
        </tr>
        <tr>
            <td style="width: 87px; height: 15px"></td>
            <td style="height: 15px; text-align: left"></td>
        </tr>
        <tr>
            <td style="width: 87px; height: 15px">
                <ul style="list-style-type: disc; text-align: right;">
                    <li></li>
                </ul>
            </td>
            <td style="height: 15px; text-align: left">
                <span id="title3" style="font-weight: bold"></span><span style="color: Red;">
                    <br />
                </span><span id="newupdate3"></span>&nbsp;
            </td>
        </tr>
        <tr>
            <td style="width: 87px; height: 15px">&nbsp;</td>
            <td style="height: 15px; text-align: left">&nbsp;</td>
        </tr>
        <tr>
            <td style="width: 87px;">
                <ul style="list-style-type: disc; text-align: right;">
                    <li></li>
                </ul>
            </td>
            <td style="text-align: left; height: 46px;">
                <span id="title4" style="font-weight: bold">
                    <br />
                </span>
                <br />
                <span id="newupdate4"></span>&nbsp;
            </td>
        </tr>
        <tr>
            <td style="width: 87px; height: 15px"></td>
            <td style="height: 15px; text-align: left"></td>
        </tr>
        <tr>
            <td style="width: 87px;">
                <ul style="list-style-type: disc; text-align: right;">
                    <li></li>
                </ul>
            </td>
            <td style="height: 6px; text-align: left">
                <span id="title5" style="font-weight: bold">
                    <br />
                </span>
                <br />
                <span id="newupdate5"></span>
            </td>
        </tr>
        <tr style="font-size: 8.3pt; font-family: Verdana">
            <td style="width: 87px; height: 15px"></td>
            <td style="height: 15px; text-align: left"></td>
        </tr>
        <tr style="font-size: 8.3pt; font-family: Verdana">
            <td style="width: 87px;">
                <ul style="list-style-type: disc; text-align: right;">
                    <li></li>
                </ul>
            </td>
            <td style="text-align: left; height: 53px;">
                <span id="title6" style="font-weight: bold;">
                    <br />
                </span>
                <br />
                <span id="newupdate6"></span>

            </td>
        </tr>
        <tr style="color: #000000; font-size: 8.3pt; font-family: Verdana;">
            <td style="width: 87px; height: 15px; text-align: justify"></td>
            <td style="height: 15px"></td>
        </tr>
        <tr style="color: #000000; font-size: 8.3pt; font-family: Verdana;">
            <td style="width: 87px;">
                <ul style="list-style-type: disc; text-align: right;">
                    <li></li>
                </ul>
            </td>
            <td style="height: 26px; text-align: left;">
                <span id="title7" style="font-weight: bold">
                    <br />
                </span>
                <br />
                <span id="newupdate7"></span>&nbsp;
                
            </td>
        </tr>
        <tr style="font-size: 8.3pt; color: #000000; font-family: Verdana">
            <td style="width: 87px; height: 15px; text-align: justify"></td>
            <td style="height: 15px; text-align: left"></td>
        </tr>
        <tr style="font-size: 8.3pt; color: #000000; font-family: Verdana">
            <td colspan="2">
                <div id="SalaryCalculator" style="display: none">
                    <table align="center" style="width: 734px">
                        <tr>
                            <td style="height: 20px; text-align: left; background-image: url('image/bg.png'); background-repeat: repeat-x;">
                                <table style="width: 100%" cellspacing="0">
                                    <tr>
                                        <td style="font-size: small">
                                            <b>MCTX - Salary Calculator:</b></td>
                                        <td style="text-align: right; cursor: pointer">
                                            <img alt="cross" height="16" src="image/cross.png"
                                                width="16" onclick="logout()" /></td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td style="height: 200px">
                                <table align="center" style="width: 100%; height: 192px">
                                    <tr>
                                        <td valign="top"
                                            style="border-left: thin none #000000; border-right: thin dotted #000000; border-top: thin none #000000; border-bottom: thin dotted #000000; width: 363px;">
                                            <table align="left" style="width: 100%">
                                                <tr>
                                                    <td colspan="4"
                                                        style="border-style: dotted none dotted none; border-width: thin; border-color: #000000; text-align: left; color: #FF9900;">
                                                        <b>Information (<asp:label id="lbl_name" runat="server"></asp:label>):</b></td>
                                                </tr>
                                                <tr>
                                                    <td style="text-align: left; width: 154px; font-size: xx-small;">
                                                        <b>Working Days:</b></td>
                                                    <td style="text-align: left; width: 158px;">
                                                        <asp:label id="lbluserworkingdays" runat="server"></asp:label>
                                                    </td>
                                                    <td style="text-align: left; width: 30px;" rowspan="7">
                                                        <img alt="" src="image/pending_prospecting.jpg"
                                                            style="width: 17px; height: 119px" /></td>
                                                    <td style="text-align: center" rowspan="7">
                                                        <asp:label id="lbl_pen_Pros" runat="server" font-bold="True" font-italic="True"
                                                            font-size="72px" text="0"></asp:label>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td style="text-align: left; width: 154px; font-size: xx-small;">
                                                        <b>Basic Salary:</b></td>
                                                    <td style="text-align: left; width: 158px;">
                                                        <asp:label id="lbl_basicsal" runat="server"></asp:label>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td style="text-align: left; width: 154px; font-size: xx-small;">
                                                        <b>Sum of Allowences: </b></td>
                                                    <td style="text-align: left; width: 158px;">
                                                        <asp:label id="lbl_sumofallowences" runat="server">0</asp:label>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td style="text-align: left; width: 154px; font-size: xx-small;">
                                                        <b>Deduction on Salary:</b></td>
                                                    <td style="text-align: left; width: 158px;">
                                                        <asp:label id="lbldeductonsal" runat="server"></asp:label>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td style="text-align: left; width: 154px; font-size: xx-small;">
                                                        <b>Deduction on Commisson:</b></td>
                                                    <td style="text-align: left; width: 158px;">
                                                        <asp:label id="lbldeductiononcomm" runat="server">0</asp:label>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td style="text-align: left; width: 154px; font-size: xx-small;">
                                                        <b>Total Deductions:</b></td>
                                                    <td style="text-align: left; width: 158px;">
                                                        <asp:label id="lbltotaldeduct" runat="server" text="0"></asp:label>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td style="text-align: left; width: 154px; font-size: xx-small;">
                                                        <b>Grand Total:</b></td>
                                                    <td style="text-align: left; width: 158px;">
                                                        <asp:label id="lblGtotal" runat="server">0</asp:label>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td valign="top"
                                            style="border-style: none none dotted none; border-width: thin; border-color: #000000">
                                            <table style="width: 100%">
                                                <tr>
                                                    <td style="border-style: dotted none dotted none; border-width: thin; border-color: #000000; text-align: left; color: #FF9900;">

                                                        <b>Your Salary Variables:</b></td>
                                                    <td style="border-style: dotted none dotted none; border-width: thin; border-color: #000000; text-align: left; color: #FF9900;">&nbsp;</td>
                                                </tr>
                                                <tr>
                                                    <td colspan="2">
                                                        <asp:gridview id="gridtargetdetails" runat="server" backcolor="White"
                                                            bordercolor="#CCCCCC" borderstyle="None" borderwidth="1px" cellpadding="3"
                                                            width="352px" style="text-align: left">
                                                        <RowStyle ForeColor="#000066" />
                                                        <FooterStyle BackColor="White" ForeColor="#000066" />
                                                        <PagerStyle BackColor="White" ForeColor="#000066" HorizontalAlign="Left" />
                                                        <SelectedRowStyle BackColor="#669999" Font-Bold="True" ForeColor="White" />
                                                        <HeaderStyle BackColor="#BEE4EE" Font-Bold="True" ForeColor="Black" />
                                                    </asp:gridview>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="border-left: thin none #000000; border-right: thin dotted #000000; border-top: thin none #000000; border-bottom: thin dotted #000000; width: 363px;">
                                            <table align="left" style="width: 100%">
                                                <tr>
                                                    <td style="border-style: none none dotted none; border-width: thin; border-color: #000000; text-align: left; color: #FF9900;">
                                                        <b>&nbsp;Target Details:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </b>
                                                        <asp:label id="StartEnddate" runat="server"></asp:label>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <asp:gridview id="gridvariables" runat="server" backcolor="White"
                                                            bordercolor="#CCCCCC" borderstyle="None" borderwidth="1px" cellpadding="3"
                                                            width="350px" style="text-align: left">
                                                        <RowStyle ForeColor="#000066" />
                                                        <FooterStyle BackColor="White" ForeColor="#000066" />
                                                        <PagerStyle BackColor="White" ForeColor="#000066" HorizontalAlign="Left" />
                                                        <SelectedRowStyle BackColor="#669999" Font-Bold="True" ForeColor="White" />
                                                        <HeaderStyle BackColor="#BEE4EE" Font-Bold="True" ForeColor="Black" />
                                                    </asp:gridview>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td valign="top"
                                            style="border-style: none none dotted none; border-width: thin; border-color: #000000">
                                            <table align="left" style="width: 100%">
                                                <tr>
                                                    <td style="border-style: none none dotted none; border-width: thin; border-color: #000000; text-align: left; color: #FF9900;">
                                                        <b>Your Acheived Targets:</b></td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <asp:gridview id="gridacheivements" runat="server" backcolor="White"
                                                            bordercolor="#CCCCCC" borderstyle="None" borderwidth="1px" cellpadding="3"
                                                            width="352px" style="text-align: left">
                                                        <RowStyle ForeColor="#000066" />
                                                        <FooterStyle BackColor="White" ForeColor="#000066" />
                                                        <PagerStyle BackColor="White" ForeColor="#000066" HorizontalAlign="Left" />
                                                        <SelectedRowStyle BackColor="#669999" Font-Bold="True" ForeColor="White" />
                                                        <HeaderStyle BackColor="#BEE4EE" Font-Bold="True" ForeColor="Black" />
                                                    </asp:gridview>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="2">
                                            <input id="Button1" style="background-color: #60C1D9" type="button"
                                                value="Accept" onclick="$.unblockUI();"
                                                onclick="return Button1_onclick()" />
                                            <asp:button id="btn_decline" runat="server" backcolor="#70C5DE"
                                                onclick="btn_decline_Click" onclientclick="logout()" text="Decline" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="2" style="text-align: left">&nbsp;1. <span style="color: #3333FF">Please feel free to inform at </span>
                                            <a href="mailto:it@mechatronix.com.pk" style="color: #3333FF">it@mechatronix.com.pk</a><span style="color: #3333FF"> if you feel that 
                                        salary calculator is not working according to&nbsp;&nbsp;&nbsp;<br />
                                                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;above mentioned 
                                        criteria.&nbsp;<br />
                                                &nbsp;2. </span><span style="color: #FF3300">By Clicking &quot;Accept&quot; button you are 
                                        accepting the above mentioned salary calculator criteria</span><span style="color: #3333FF">.<br />
                                            &nbsp;3.
                                        </span><span style="color: #006600">You should have at least <span style="font-size: small; font-weight: bold">50</span>
                                            Pending Prospecting from last 03 Months
                                        </span><span style="color: #3333FF"><span style="color: #FF3300">&nbsp;
                                                                <img alt="" src="image/New_blinking.gif" style="width: 25px; height: 9px" />
                                        </span>.<br />
                                        </span>
                                        </td>
                                    </tr>

                                </table>
                            </td>
                        </tr>
                    </table>
                </div>
            </td>
        </tr>
    </table>
    <script type="text/javascript">
        $(document).ready(function () {
            getvalue();
            gettitle();

            $.blockUI({
                message: $("#SalaryCalculator"), css: { 'background-color': 'White', 'height': 'auto', 'cursor': 'default', 'left': '18%', 'top': '18%', 'width': 'auto' }
            });

        });

        function logout() {
            window.location = "../../MCTX_General/Logout.aspx";
        }


    </script>
    <script type="text/javascript" lang="ja">
        function getvalue() {

            $.ajax({
                type: "POST",
                dataType: "json",
                contentType: "application/json; charset=utf-8",
                url: "Welcome.aspx/getvalues",
                data: {},
                success: OnGetMessages,
                error: OnretrieveError
            });
        }

        function OnGetMessages(msg) {
            var data = msg.d;
            $("#newupdate").text(data.settings[0].new_update);
            $("#newupdate1").text(data.settings[0].new_update1);
            $("#newupdate2").text(data.settings[0].new_update2);
            $("#newupdate3").text(data.settings[0].new_update3);
            $("#newupdate4").text(data.settings[0].new_update4);
            $("#newupdate5").text(data.settings[0].new_update5);
            $("#newupdate6").text(data.settings[0].new_update6);
            $("#newupdate7").text(data.settings[0].new_update7);
        }
        function OnretrieveError() {
         //   alert("Error");
        }

    </script>
    <script type="text/javascript" language="javascript">
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
        }

        function GetMessages(msg) {
            var data = msg.d;
            $("#title").text(data.title[0].news_title);
            $("#title1").text(data.title[0].news_title1);
            $("#title2").text(data.title[0].news_title2);
            $("#title3").text(data.title[0].news_title3);
            $("#title4").text(data.title[0].news_title4);
            $("#title5").text(data.title[0].news_title5);
            $("#title6").text(data.title[0].news_title6);
            $("#title7").text(data.title[0].news_title7);

        }
        function Error() {
            alert("Error");
            return false;
        }

    </script>
</asp:Content>

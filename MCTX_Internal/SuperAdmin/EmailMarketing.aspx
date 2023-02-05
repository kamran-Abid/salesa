<%@ Page Title="" Language="C#" MasterPageFile="~/MCTX_Internal/SuperAdmin/MasterAdmin.master"
    AutoEventWireup="true" CodeFile="EmailMarketing.aspx.cs" Inherits="MCTX_Internal_SuperAdmin_EmailMarketing" %>

<%@ Register Assembly="CKEditor.NET" Namespace="CKEditor.NET" TagPrefix="CKEditor" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
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
        input:focus
        {
            height: 18px;
            font-size: 11pt;
            font-family: Calibri,Verdana, Arial, Helvetica, sans-serif;
            box-shadow: 0 -1px 0 rgba(0, 0, 0, 0.3), 0 1px 2px rgba(0, 0, 0, 0.1) inset, 0 0 10px rgba(255, 255, 255, 0.9);
            border-color: #ABD3FC;
        }
        input
        {
            font-size: 10pt;
            font-family: Calibri,Verdana, Arial, Helvetica, sans-serif;
            width: 550px;
            border: 1px solid #CCCCCC;
        }
        .button
        {
            border-top: 1px solid #96d1f8;
            background: #65a9d7;
            background: -webkit-gradient(linear, left top, left bottom, from(#3e779d), to(#65a9d7));
            background: -webkit-linear-gradient(top, #3e779d, #65a9d7);
            background: -moz-linear-gradient(top, #3e779d, #65a9d7);
            background: -ms-linear-gradient(top, #3e779d, #65a9d7);
            background: -o-linear-gradient(top, #3e779d, #65a9d7);
            padding: 5px 10px;
            -webkit-border-radius: 8px;
            -moz-border-radius: 8px;
            border-radius: 8px;
            -webkit-box-shadow: rgba(0,0,0,1) 0 1px 0;
            -moz-box-shadow: rgba(0,0,0,1) 0 1px 0;
            box-shadow: rgba(0,0,0,1) 0 1px 0;
            text-shadow: rgba(0,0,0,.4) 0 1px 0;
            color: white;
            font-size: 14px;
            font-family: Georgia, serif;
            text-decoration: none;
            vertical-align: middle;
            height: 30px;
            width: 100px;
        }
        .button:hover
        {
            border-top-color: #28597a;
            background: #28597a;
            color: #ccc;
            height: 30px;
            width: 100px;
        }
        .button:active
        {
            border-top-color: #1b435e;
            background: #1b435e;
            height: 30px;
            width: 100px;
        }
        .success
        {
            background-color: #EEFFEE;
            background-image: url("../../images1/status-success.png");
            border: 1px solid #AADDAA;
            color: #008800;
            background-repeat: no-repeat;
        }
        .alert, .success, .Error, .action
        {
            background-position: 10px 5px;
            background-repeat: no-repeat;
            border-radius: 5px 5px 5px 5px;
            clear: both;
            margin-bottom: 15px;
            min-height: 22px;
            padding: 10px 10px 10px 50px;
        }
        .Error
        {
            background-color: #FFEEEE;
            border: 1px solid #DDAAAA;
            color: #AA0000;
            background-repeat: no-repeat;
        }
        textarea:focus
        {
            font-size: 11pt;
            font-family: Calibri,Verdana, Arial, Helvetica, sans-serif;
            box-shadow: 0 -1px 0 rgba(0, 0, 0, 0.3), 0 1px 2px rgba(0, 0, 0, 0.1) inset, 0 0 10px rgba(255, 255, 255, 0.9);
            border-color: #ABD3FC;
        }
        textarea
        {
            font-size: 10pt;
            font-family: Calibri,Verdana, Arial, Helvetica, sans-serif;
            width: 550px;
            height: 50px;
            border: 1px solid #CCCCCC;
            height: 85px;
        }
    </style>

    <script type="text/javascript" language="javascript">
        function DisplayDiv() {
            $('#DivEmail_label').fadeIn(4000);
        }
    </script>

    <div id="tabs">
        <ul>
            <li style="text-align: left"><a href="#tabs-1">Email Marketing</a></li>
        </ul>
        <table class="dataTable">
            <tr>
                <td colspan="2">
                    <div id="Confirmation" visible="false" runat="server">
                        <p class="success">
                            <b>Confirmation:</b> Your email has been successfully sent to the below mentioned
                            email addresses.</p>
                    </div>
                    <div id="DivError" visible="false" runat="server">
                        <p class="Error">
                            <b>Error:</b> Only 1 Email Address Allowed.</p>
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                    To:
                </td>
                <td>
                    <table>
                        <tr>
                            <td style="width: 60%">
                                <asp:TextBox ID="txtTo" onclick="return DisplayDiv(); return false;" runat="server"
                                    TextMode="MultiLine" />
                            </td>
                            <td style="width: 40%; vertical-align: middle">
                                <asp:RequiredFieldValidator Display="Dynamic" ValidationGroup="vg1" ControlToValidate="txtTo"
                                    ID="regReqTo" runat="server" ErrorMessage="*"></asp:RequiredFieldValidator>
                                <div id="DivEmail_label" style="display: none; border: 1px solid #AADDAA; color: #008800;
                                    margin-left: 10px;font-weight:bold;">
                                    <ul>
                                         <li>Just <strong>1</strong> email addresse allowed.</li>
                                        <li style="display:none;">Use <strong>semicolon ;</strong> as a seperator in case of multiple email addresses.</li>
                                        <li style="display:none;">Don't write <strong>Dear Sir/ Ma'am</strong> as its already written in it.</li>
                                      </ul> 
                                </div>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td>
                    Subject:
                </td>
                <td>
                    <asp:TextBox ID="txtSubject" runat="server" />
                    <asp:RequiredFieldValidator Display="Dynamic" ControlToValidate="txtSubject" ValidationGroup="vg1"
                        ID="RegexSubject" runat="server" ErrorMessage="*"></asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td>
                    Attachment:
                </td>
                <td>
                    <asp:FileUpload ID="fuAttachment" Height="22px" runat="server" />
                </td>
            </tr>
            <tr>
                <td>
                    Email:
                </td>
                <td>
                    <CKEditor:CKEditorControl ID="CKEditor1" runat="server"></CKEditor:CKEditorControl>
                </td>
            </tr>
            <tr>
                <td style="text-align: right" colspan="2">
                    <asp:Button ID="btnSendEmail" ValidationGroup="vg1" CssClass="button" runat="server"
                        Text="Send" OnClick="btnSendEmail_Click" />
                </td>
            </tr>
        </table>
    </div>
</asp:Content>

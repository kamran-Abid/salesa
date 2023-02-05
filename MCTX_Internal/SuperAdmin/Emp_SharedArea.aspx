<%@ Page Title="" Language="C#" MasterPageFile="~/MCTX_Internal/SuperAdmin/MasterAdmin.master"
    AutoEventWireup="true" CodeFile="Emp_SharedArea.aspx.cs" Inherits="MCTX_Internal_SuperAdmin_TEstframe" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <script src="../../js/BlockUI.js" type="text/javascript"></script>

    <script type="text/javascript" language="javascript">
        $(document).ajaxStart(blockUI).ajaxStop(unblockUI);

        function blockUI() {
            $.blockUI({ message: '<img src="image/ajax-loader.gif" />',
                css: { borderStyle: 'none', backgroundColor: "Transparent" }
            });
        }

        function unblockUI() {
            $.unblockUI();
        }
    </script>

    <style type="text/css">
        .divstyle
        {
            background-color: Transparent;
            border: 2px solid #CCCDCF;
            border-radius: 5px 5px 5px 5px;
            display: block;
            float: left;
            padding: 15px;
            width: 96.5%;
        }
        p
        {
            clear: both;
            color: #888888;
            font-size: 13px;
            line-height: 1.3;
            padding: 10px 0;
        }
    </style>
    <div id="tabs">
        <ul>
            <li style="text-align: left"><a href="#tabs-1">Employee(s) Shared Area</a></li>
        </ul>
        <div class="divstyle">
            <h2>
                Employee(s) Shared Area</h2>
            <p>
                Please use <strong>Username: </strong><span style="color: -moz-nativehyperlinktext;
                    font-size: 15px">mechatronix</span> & <strong>Password: </strong><span style="color: -moz-nativehyperlinktext;
                        font-size: 15px">user@mctx</span>. Employee(s) can share data by using the
                shared area.<br />
                <strong>Note: </strong>Employee can not delete the data untill get permission from
                the concerned <strong>authorties</strong>.
            </p>
        </div>
        <iframe style="border: 2px solid #CCCDCF;" id="iframe1" height="600px" width="945px" src="https://www.cx.com/mycx/files/">
        </iframe>
    </div>
</asp:Content>

<%@ Page Title="" Language="C#" MasterPageFile="~/MCTX_Internal/SuperAdmin/MasterAdmin.master"
    AutoEventWireup="true" CodeFile="FrmQuotationsViewer_CR.aspx.cs" Inherits="MCTX_Internal_SuperAdmin_FrmQuotationsViewer" %>

<%--<%@ Register Assembly="CrystalDecisions.Web, Version=10.5.3700.0, Culture=neutral, PublicKeyToken=692fbea5521e1304"
    Namespace="CrystalDecisions.Web" TagPrefix="CR" %>--%>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <script src="../../js/jquery.dataTables.min.js" type="text/javascript"></script>
    <script src="../../js/BlockUI.js" type="text/javascript"></script>

    <style type="text/css">
        .dataTable
        {
            font-family: Calibri,Verdana, Arial, Helvetica, sans-serif;
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
        .a5
        {
            background-color: DimGray;
            background-repeat: repeat;
            border: 1pt none Black;
            color: White;
            direction: ltr;
            font-family: BernhardMod BT;
            font-size: 12pt;
            font-style: normal;
            font-weight: 700;
            padding: 2pt 0 2pt 2pt;
            text-align: right;
            text-decoration: none;
            unicode-bidi: normal;
            vertical-align: top;
        }
    </style>
    <table width="100%" style="background-color:White">
        <tr>
            <td>
               <%-- <CR:CrystalReportViewer ID="CRVAC" runat="server" AutoDataBind="true" />--%>
            </td>
        </tr>
    </table>
</asp:Content>

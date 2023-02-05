<%@ Page Language="C#" MasterPageFile="~/MCTX_Internal/SuperAdmin/MasterAdmin.master"
    AutoEventWireup="true" CodeFile="frmDailyOutputReport.aspx.cs" Inherits="MCTX_Internal_SuperAdmin_frmDailyOutputReport"
    Title="Daily Output Report" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

        <script src="../../js/jquery.dataTables.min.js" type="text/javascript"></script>
    <script src="../../js/BlockUI.js" type="text/javascript"></script>
    

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
        .style7
        {
            width: 158px;
        }
        .style8
        {
            width: 124px;
        }
        .style9
        {
            width: 266px;
        }
    </style>
    <div id="tabs" style="width: auto;">
        <ul>
            <li style="text-align: left"><a href="#tabs-1">Daily Output Details</a></li>
        </ul>
        <table style="width: 100%">
            <tr>
                <td align="center" style="background-color: DarkBlue;">
                    <asp:Label ID="lblHead" Text="My Daily Output For The Company" Style="font-family: Calibri;
                        color: White;" runat="server"></asp:Label>
                </td>
            </tr>
            <tr>
                <td align="center" style="background-color: Gray;">
                    <asp:Label ID="labelEmpName" Style="font-family: Calibri; color: Orange;" Text="Employee Name:"
                        runat="server"></asp:Label>&nbsp;
                    <asp:Label ID="lblEmpName" Style="font-family: Calibri; color: DarkBlue;" runat="server"></asp:Label>&nbsp;|&nbsp;
                    <asp:Label ID="label1" Style="font-family: Calibri; color: Orange;" Text="Report ID:"
                        runat="server"></asp:Label>&nbsp;
                    <asp:Label ID="lblReportID" Style="font-family: Calibri; color: DarkBlue;" runat="server"></asp:Label>&nbsp;|&nbsp;
                    <asp:Label ID="labelTimeIn" Style="font-family: Calibri; color: Orange;" Text="Time-In:"
                        runat="server"></asp:Label>&nbsp;
                    <asp:Label ID="lblTimeIn" Style="font-family: Calibri; color: DarkBlue;" runat="server"></asp:Label>
                </td>
            </tr>
            <tr>
                <td align="left" style="background-color: ThreeDLightShadow;">
                    <asp:Label ID="lblNote" Style="font-family: Calibri; color: Red;" Text="Note: You Must Fill Each & Every Entry Of The Following Form"
                        runat="server"></asp:Label>
                </td>
            </tr>
            <tr>
                <td align="left" style="background-color: ThreeDLightShadow;">
                    <asp:Label ID="lblOfficeTimeIn" Style="font-family: Calibri; color: DarkBlue;" Text="My Today's Check-In:"
                        runat="server"></asp:Label>&nbsp;
                    <asp:DropDownList ID="ddlCInHrs" Style="font-family: Calibri; width: 50px; color: DarkBlue;"
                        AutoPostBack="true" onChange="return timein();" runat="server">
                        <asp:ListItem>Hrs</asp:ListItem>
                        <asp:ListItem>00</asp:ListItem>
                        <asp:ListItem>01</asp:ListItem>
                        <asp:ListItem>02</asp:ListItem>
                        <asp:ListItem>03</asp:ListItem>
                        <asp:ListItem>04</asp:ListItem>
                        <asp:ListItem>05</asp:ListItem>
                        <asp:ListItem>06</asp:ListItem>
                        <asp:ListItem>07</asp:ListItem>
                        <asp:ListItem>08</asp:ListItem>
                        <asp:ListItem>09</asp:ListItem>
                        <asp:ListItem>10</asp:ListItem>
                        <asp:ListItem>11</asp:ListItem>
                        <asp:ListItem>12</asp:ListItem>
                        <asp:ListItem>13</asp:ListItem>
                        <asp:ListItem>14</asp:ListItem>
                        <asp:ListItem>15</asp:ListItem>
                        <asp:ListItem>16</asp:ListItem>
                        <asp:ListItem>17</asp:ListItem>
                        <asp:ListItem>18</asp:ListItem>
                        <asp:ListItem>19</asp:ListItem>
                        <asp:ListItem>20</asp:ListItem>
                        <asp:ListItem>21</asp:ListItem>
                        <asp:ListItem>22</asp:ListItem>
                        <asp:ListItem>23</asp:ListItem>
                    </asp:DropDownList>
                    <asp:DropDownList ID="ddlCInMins" Style="font-family: Calibri; width: 50px; color: DarkBlue;"
                        AutoPostBack="true" onChange="return timein();" runat="server">
                        <asp:ListItem>Mins</asp:ListItem>
                        <asp:ListItem>00</asp:ListItem>
                        <asp:ListItem>01</asp:ListItem>
                        <asp:ListItem>02</asp:ListItem>
                        <asp:ListItem>03</asp:ListItem>
                        <asp:ListItem>04</asp:ListItem>
                        <asp:ListItem>05</asp:ListItem>
                        <asp:ListItem>06</asp:ListItem>
                        <asp:ListItem>07</asp:ListItem>
                        <asp:ListItem>08</asp:ListItem>
                        <asp:ListItem>09</asp:ListItem>
                        <asp:ListItem>10</asp:ListItem>
                        <asp:ListItem>11</asp:ListItem>
                        <asp:ListItem>12</asp:ListItem>
                        <asp:ListItem>13</asp:ListItem>
                        <asp:ListItem>14</asp:ListItem>
                        <asp:ListItem>15</asp:ListItem>
                        <asp:ListItem>16</asp:ListItem>
                        <asp:ListItem>17</asp:ListItem>
                        <asp:ListItem>18</asp:ListItem>
                        <asp:ListItem>19</asp:ListItem>
                        <asp:ListItem>20</asp:ListItem>
                        <asp:ListItem>21</asp:ListItem>
                        <asp:ListItem>22</asp:ListItem>
                        <asp:ListItem>23</asp:ListItem>
                        <asp:ListItem>24</asp:ListItem>
                        <asp:ListItem>25</asp:ListItem>
                        <asp:ListItem>26</asp:ListItem>
                        <asp:ListItem>27</asp:ListItem>
                        <asp:ListItem>28</asp:ListItem>
                        <asp:ListItem>29</asp:ListItem>
                        <asp:ListItem>30</asp:ListItem>
                        <asp:ListItem>31</asp:ListItem>
                        <asp:ListItem>32</asp:ListItem>
                        <asp:ListItem>33</asp:ListItem>
                        <asp:ListItem>34</asp:ListItem>
                        <asp:ListItem>35</asp:ListItem>
                        <asp:ListItem>36</asp:ListItem>
                        <asp:ListItem>37</asp:ListItem>
                        <asp:ListItem>38</asp:ListItem>
                        <asp:ListItem>39</asp:ListItem>
                        <asp:ListItem>40</asp:ListItem>
                        <asp:ListItem>41</asp:ListItem>
                        <asp:ListItem>42</asp:ListItem>
                        <asp:ListItem>43</asp:ListItem>
                        <asp:ListItem>44</asp:ListItem>
                        <asp:ListItem>45</asp:ListItem>
                        <asp:ListItem>46</asp:ListItem>
                        <asp:ListItem>47</asp:ListItem>
                        <asp:ListItem>48</asp:ListItem>
                        <asp:ListItem>49</asp:ListItem>
                        <asp:ListItem>50</asp:ListItem>
                        <asp:ListItem>51</asp:ListItem>
                        <asp:ListItem>52</asp:ListItem>
                        <asp:ListItem>53</asp:ListItem>
                        <asp:ListItem>54</asp:ListItem>
                        <asp:ListItem>55</asp:ListItem>
                        <asp:ListItem>56</asp:ListItem>
                        <asp:ListItem>57</asp:ListItem>
                        <asp:ListItem>58</asp:ListItem>
                        <asp:ListItem>59</asp:ListItem>
                    </asp:DropDownList>
                </td>
            </tr>
            <tr>
                <td align="left" style="background-color: ThreeDLightShadow;">
                    <asp:Label ID="lblActMsg" Text="My Today's Tasks/Activities Are:" Style="font-family: Calibri;
                        color: DarkBlue;" runat="server"></asp:Label>
                </td>
            </tr>
        </table>
        <table id="tblDailyReport" style="width: 100%">
            <tr>
                <td style="width: 5%; background-color: Orange; font-weight: bold; font-family: Calibri;
                    color: White; text-align: left;">
                    Hr No
                </td>
                <td style="width: 10%; background-color: Orange; font-weight: bold; font-family: Calibri;
                    color: White; text-align: left;">
                    Start Time
                </td>
                <td style="width: 10%; background-color: Orange; font-weight: bold; font-family: Calibri;
                    color: White; text-align: left;">
                    End Time
                </td>
                <td style="width: 10%; background-color: Orange; font-weight: bold; font-family: Calibri;
                    color: White; text-align: left;">
                    Report Time
                </td>
                <td style="width: 15%; background-color: Orange; font-weight: bold; font-family: Calibri;
                    color: White; text-align: left;">
                    Project
                </td>
                <td style="width: 45%; background-color: Orange; font-weight: bold; font-family: Calibri;
                    color: White; text-align: left;">
                    Task Description
                </td>
                <td style="width: 5%; background-color: Orange; font-weight: bold; font-family: Calibri;
                    color: White; text-align: center;">
                    Save
                </td>
            </tr>
            <tr style="background-color: ButtonFace;">
                <td style="width: 5%; background-color: -moz-field; font-family: Calibri; color: DarkBlue;
                    text-align: center;">
                    1st
                </td>
                <td style="width: 10%; background-color: -moz-field; font-family: Calibri; color: DarkBlue;
                    text-align: left;">
                    <asp:TextBox ID="txtFrmTime1" Style="width: 100%; background-color: Lavender;" ReadOnly="true"
                        runat="server"></asp:TextBox>
                </td>
                <td style="width: 10%; background-color: -moz-field; font-family: Calibri; color: DarkBlue;
                    text-align: left;">
                    <asp:TextBox ID="txtToTime1" Style="width: 100%; background-color: Lavender;" ReadOnly="true"
                        runat="server"></asp:TextBox>
                </td>
                <td style="width: 10%; background-color: -moz-field; font-family: Calibri; color: DarkBlue;
                    text-align: left;">
                    <asp:TextBox ID="txtRPTTime1" Style="width: 100%; background-color: Lavender;" ReadOnly="true"
                        runat="server"></asp:TextBox>
                </td>
                <td style="width: 15%; background-color: -moz-field; font-family: Calibri; color: DarkBlue;
                    text-align: left;">
                    <asp:DropDownList ID="ddlProj1" AutoPostBack="false" Style="width: 99%; background-color: Lavender;
                        font-family: Calibri;" runat="server">
                    </asp:DropDownList>
                </td>
                <td style="width: 45%; background-color: -moz-field; font-family: Calibri; color: DarkBlue;
                    text-align: left;">
                    <asp:TextBox ID="txtOutput1" Style="width: 100%; background-color: Lavender;" runat="server"></asp:TextBox>
                </td>
                <td style="width: 5%; background-color: -moz-field; font-family: Calibri; color: DarkBlue;
                    text-align: center;">
                    <asp:Button ID="btnSave1" Text="Save" Style="background-color: Lavender; width: 100%;"
                        OnClientClick="return saveHr1();" runat="server"></asp:Button>
                </td>
            </tr>
            <tr>
                <td style="width: 5%; background-color: -moz-field; font-family: Calibri; color: DarkBlue;
                    text-align: center;">
                    2nd
                </td>
                <td style="width: 10%; background-color: -moz-field; font-family: Calibri; color: DarkBlue;
                    text-align: left;">
                    <asp:TextBox ID="txtFrmTime2" Style="width: 100%; background-color: Lavender;" ReadOnly="true"
                        runat="server"></asp:TextBox>
                </td>
                <td style="width: 10%; background-color: -moz-field; font-family: Calibri; color: DarkBlue;
                    text-align: left;">
                    <asp:TextBox ID="txtToTime2" Style="width: 100%; background-color: Lavender;" ReadOnly="true"
                        runat="server"></asp:TextBox>
                </td>
                <td style="width: 10%; background-color: -moz-field; font-family: Calibri; color: DarkBlue;
                    text-align: left;">
                    <asp:TextBox ID="txtRPTTime2" Style="width: 100%; background-color: Lavender;" ReadOnly="true"
                        runat="server"></asp:TextBox>
                </td>
                <td style="width: 15%; background-color: -moz-field; font-family: Calibri; color: DarkBlue;
                    text-align: left;">
                    <asp:DropDownList ID="ddlProj2" AutoPostBack="false" Style="width: 99%; background-color: Lavender;
                        font-family: Calibri;" runat="server">
                    </asp:DropDownList>
                </td>
                <td style="width: 45%; background-color: -moz-field; font-family: Calibri; color: DarkBlue;
                    text-align: left;">
                    <asp:TextBox ID="txtOutput2" Style="width: 100%; background-color: Lavender;" runat="server"></asp:TextBox>
                </td>
                <td style="width: 5%; background-color: -moz-field; font-family: Calibri; color: DarkBlue;
                    text-align: center;">
                    <asp:Button ID="btnSave2" Text="Save" Style="background-color: Lavender; width: 100%;"
                        OnClientClick="return saveHr2();" runat="server"></asp:Button>
                </td>
            </tr>
            <tr>
                <td style="width: 5%; background-color: -moz-field; font-family: Calibri; color: DarkBlue;
                    text-align: center;">
                    3rd
                </td>
                <td style="width: 10%; background-color: -moz-field; font-family: Calibri; color: DarkBlue;
                    text-align: left;">
                    <asp:TextBox ID="txtFrmTime3" Style="width: 100%; background-color: Lavender;" ReadOnly="true"
                        runat="server"></asp:TextBox>
                </td>
                <td style="width: 10%; background-color: -moz-field; font-family: Calibri; color: DarkBlue;
                    text-align: left;">
                    <asp:TextBox ID="txtToTime3" Style="width: 100%; background-color: Lavender;" ReadOnly="true"
                        runat="server"></asp:TextBox>
                </td>
                <td style="width: 10%; background-color: -moz-field; font-family: Calibri; color: DarkBlue;
                    text-align: left;">
                    <asp:TextBox ID="txtRPTTime3" Style="width: 100%; background-color: Lavender;" ReadOnly="true"
                        runat="server"></asp:TextBox>
                </td>
                <td style="width: 15%; background-color: -moz-field; font-family: Calibri; color: DarkBlue;
                    text-align: left;">
                    <asp:DropDownList ID="ddlProj3" AutoPostBack="false" Style="width: 99%; background-color: Lavender;
                        font-family: Calibri;" runat="server">
                    </asp:DropDownList>
                </td>
                <td style="width: 45%; background-color: -moz-field; font-family: Calibri; color: DarkBlue;
                    text-align: left;">
                    <asp:TextBox ID="txtOutput3" Style="width: 100%; background-color: Lavender;" runat="server"></asp:TextBox>
                </td>
                <td style="width: 5%; background-color: -moz-field; font-family: Calibri; color: DarkBlue;
                    text-align: center;">
                    <asp:Button ID="btnSave3" Text="Save" Style="background-color: Lavender; width: 100%;"
                        OnClientClick="return saveHr3();" runat="server" />
                </td>
            </tr>
            <tr>
                <td style="width: 5%; background-color: -moz-field; font-family: Calibri; color: DarkBlue;
                    text-align: center;">
                    4th
                </td>
                <td style="width: 10%; background-color: -moz-field; font-family: Calibri; color: DarkBlue;
                    text-align: left;">
                    <asp:TextBox ID="txtFrmTime4" Style="width: 100%; background-color: Lavender;" ReadOnly="true"
                        runat="server"></asp:TextBox>
                </td>
                <td style="width: 10%; background-color: -moz-field; font-family: Calibri; color: DarkBlue;
                    text-align: left;">
                    <asp:TextBox ID="txtToTime4" Style="width: 100%; background-color: Lavender;" ReadOnly="true"
                        runat="server"></asp:TextBox>
                </td>
                <td style="width: 10%; background-color: -moz-field; font-family: Calibri; color: DarkBlue;
                    text-align: left;">
                    <asp:TextBox ID="txtRPTTime4" Style="width: 100%; background-color: Lavender;" ReadOnly="true"
                        runat="server"></asp:TextBox>
                </td>
                <td style="width: 15%; background-color: -moz-field; font-family: Calibri; color: DarkBlue;
                    text-align: left;">
                    <asp:DropDownList ID="ddlProj4" AutoPostBack="false" Style="width: 99%; background-color: Lavender;
                        font-family: Calibri;" runat="server">
                    </asp:DropDownList>
                </td>
                <td style="width: 45%; background-color: -moz-field; font-family: Calibri; color: DarkBlue;
                    text-align: left;">
                    <asp:TextBox ID="txtOutput4" Style="width: 100%; background-color: Lavender;" runat="server"></asp:TextBox>
                </td>
                <td style="width: 5%; background-color: -moz-field; font-family: Calibri; color: DarkBlue;
                    text-align: center;">
                    <asp:Button ID="btnSave4" Text="Save" Style="background-color: Lavender; width: 100%;"
                        OnClientClick="return saveHr4();" runat="server" />
                </td>
            </tr>
            <tr>
                <td style="width: 5%; background-color: -moz-field; font-family: Calibri; color: DarkBlue;
                    text-align: center;">
                    5th
                </td>
                <td style="width: 10%; background-color: -moz-field; font-family: Calibri; color: DarkBlue;
                    text-align: left;">
                    <asp:TextBox ID="txtFrmTime5" Style="width: 100%; background-color: Lavender;" ReadOnly="true"
                        runat="server"></asp:TextBox>
                </td>
                <td style="width: 10%; background-color: -moz-field; font-family: Calibri; color: DarkBlue;
                    text-align: left;">
                    <asp:TextBox ID="txtToTime5" Style="width: 100%; background-color: Lavender;" ReadOnly="true"
                        runat="server"></asp:TextBox>
                </td>
                <td style="width: 10%; background-color: -moz-field; font-family: Calibri; color: DarkBlue;
                    text-align: left;">
                    <asp:TextBox ID="txtRPTTime5" Style="width: 100%; background-color: Lavender;" ReadOnly="true"
                        runat="server"></asp:TextBox>
                </td>
                <td style="width: 15%; background-color: -moz-field; font-family: Calibri; color: DarkBlue;
                    text-align: left;">
                    <asp:DropDownList ID="ddlProj5" AutoPostBack="false" Style="width: 99%; background-color: Lavender;
                        font-family: Calibri;" runat="server">
                    </asp:DropDownList>
                </td>
                <td style="width: 45%; background-color: -moz-field; font-family: Calibri; color: DarkBlue;
                    text-align: left;">
                    <asp:TextBox ID="txtOutput5" Style="width: 100%; background-color: Lavender;" runat="server"></asp:TextBox>
                </td>
                <td style="width: 5%; background-color: -moz-field; font-family: Calibri; color: DarkBlue;
                    text-align: center;">
                    <asp:Button ID="btnSave5" Text="Save" Style="background-color: Lavender; width: 100%;"
                        OnClientClick="return saveHr5();" runat="server" />
                </td>
            </tr>
            <tr>
                <td style="width: 5%; background-color: -moz-field; font-family: Calibri; color: DarkBlue;
                    text-align: center;">
                    6th
                </td>
                <td style="width: 10%; background-color: -moz-field; font-family: Calibri; color: DarkBlue;
                    text-align: left;">
                    <asp:TextBox ID="txtFrmTime6" Style="width: 100%; background-color: Lavender;" ReadOnly="true"
                        runat="server"></asp:TextBox>
                </td>
                <td style="width: 10%; background-color: -moz-field; font-family: Calibri; color: DarkBlue;
                    text-align: left;">
                    <asp:TextBox ID="txtToTime6" Style="width: 100%; background-color: Lavender;" ReadOnly="true"
                        runat="server"></asp:TextBox>
                </td>
                <td style="width: 10%; background-color: -moz-field; font-family: Calibri; color: DarkBlue;
                    text-align: left;">
                    <asp:TextBox ID="txtRPTTime6" Style="width: 100%; background-color: Lavender;" ReadOnly="true"
                        runat="server"></asp:TextBox>
                </td>
                <td style="width: 15%; background-color: -moz-field; font-family: Calibri; color: DarkBlue;
                    text-align: left;">
                    <asp:DropDownList ID="ddlProj6" AutoPostBack="false" Style="width: 99%; background-color: Lavender;
                        font-family: Calibri;" runat="server">
                    </asp:DropDownList>
                </td>
                <td style="width: 45%; background-color: -moz-field; font-family: Calibri; color: DarkBlue;
                    text-align: left;">
                    <asp:TextBox ID="txtOutput6" Style="width: 100%; background-color: Lavender;" runat="server"></asp:TextBox>
                </td>
                <td style="width: 5%; background-color: -moz-field; font-family: Calibri; color: DarkBlue;
                    text-align: center;">
                    <asp:Button ID="btnSave6" Text="Save" Style="background-color: Lavender; width: 100%;"
                        OnClientClick="return saveHr6();" runat="server" />
                </td>
            </tr>
            <tr>
                <td style="width: 5%; background-color: -moz-field; font-family: Calibri; color: DarkBlue;
                    text-align: center;">
                    7th
                </td>
                <td style="width: 10%; background-color: -moz-field; font-family: Calibri; color: DarkBlue;
                    text-align: left;">
                    <asp:TextBox ID="txtFrmTime7" Style="width: 100%; background-color: Lavender;" ReadOnly="true"
                        runat="server"></asp:TextBox>
                </td>
                <td style="width: 10%; background-color: -moz-field; font-family: Calibri; color: DarkBlue;
                    text-align: left;">
                    <asp:TextBox ID="txtToTime7" Style="width: 100%; background-color: Lavender;" ReadOnly="true"
                        runat="server"></asp:TextBox>
                </td>
                <td style="width: 10%; background-color: -moz-field; font-family: Calibri; color: DarkBlue;
                    text-align: left;">
                    <asp:TextBox ID="txtRPTTime7" Style="width: 100%; background-color: Lavender;" ReadOnly="true"
                        runat="server"></asp:TextBox>
                </td>
                <td style="width: 15%; background-color: -moz-field; font-family: Calibri; color: DarkBlue;
                    text-align: left;">
                    <asp:DropDownList ID="ddlProj7" AutoPostBack="false" Style="width: 99%; background-color: Lavender;
                        font-family: Calibri;" runat="server">
                    </asp:DropDownList>
                </td>
                <td style="width: 45%; background-color: -moz-field; font-family: Calibri; color: DarkBlue;
                    text-align: left;">
                    <asp:TextBox ID="txtOutput7" Style="width: 100%; background-color: Lavender;" runat="server"></asp:TextBox>
                </td>
                <td style="width: 5%; background-color: -moz-field; font-family: Calibri; color: DarkBlue;
                    text-align: center;">
                    <asp:Button ID="btnSave7" Text="Save" Style="background-color: Lavender; width: 100%;"
                        OnClientClick="return saveHr7();" runat="server" />
                </td>
            </tr>
            <tr>
                <td style="width: 5%; background-color: -moz-field; font-family: Calibri; color: DarkBlue;
                    text-align: center;">
                    8th
                </td>
                <td style="width: 10%; background-color: -moz-field; font-family: Calibri; color: DarkBlue;
                    text-align: left;">
                    <asp:TextBox ID="txtFrmTime8" Style="width: 100%; background-color: Lavender;" ReadOnly="true"
                        runat="server"></asp:TextBox>
                </td>
                <td style="width: 10%; background-color: -moz-field; font-family: Calibri; color: DarkBlue;
                    text-align: left;">
                    <asp:TextBox ID="txtToTime8" Style="width: 100%; background-color: Lavender;" ReadOnly="true"
                        runat="server"></asp:TextBox>
                </td>
                <td style="width: 10%; background-color: -moz-field; font-family: Calibri; color: DarkBlue;
                    text-align: left;">
                    <asp:TextBox ID="txtRPTTime8" Style="width: 100%; background-color: Lavender;" ReadOnly="true"
                        runat="server"></asp:TextBox>
                </td>
                <td style="width: 15%; background-color: -moz-field; font-family: Calibri; color: DarkBlue;
                    text-align: left;">
                    <asp:DropDownList ID="ddlProj8" AutoPostBack="false" Style="width: 99%; background-color: Lavender;
                        font-family: Calibri;" runat="server">
                    </asp:DropDownList>
                </td>
                <td style="width: 45%; background-color: -moz-field; font-family: Calibri; color: DarkBlue;
                    text-align: left;">
                    <asp:TextBox ID="txtOutput8" Style="width: 100%; background-color: Lavender;" runat="server"></asp:TextBox>
                </td>
                <td style="width: 5%; background-color: -moz-field; font-family: Calibri; color: DarkBlue;
                    text-align: center;">
                    <asp:Button ID="btnSave8" Text="Save" Style="background-color: Lavender; width: 100%;"
                        OnClientClick="return saveHr8();" runat="server" />
                </td>
            </tr>
            <tr>
                <td style="width: 5%; background-color: -moz-field; font-family: Calibri; color: DarkBlue;
                    text-align: center;">
                    9th
                </td>
                <td style="width: 10%; background-color: -moz-field; font-family: Calibri; color: DarkBlue;
                    text-align: left;">
                    <asp:TextBox ID="txtFrmTime9" Style="width: 100%; background-color: Lavender;" ReadOnly="true"
                        runat="server"></asp:TextBox>
                </td>
                <td style="width: 10%; background-color: -moz-field; font-family: Calibri; color: DarkBlue;
                    text-align: left;">
                    <asp:TextBox ID="txtToTime9" Style="width: 100%; background-color: Lavender;" ReadOnly="true"
                        runat="server"></asp:TextBox>
                </td>
                <td style="width: 10%; background-color: -moz-field; font-family: Calibri; color: DarkBlue;
                    text-align: left;">
                    <asp:TextBox ID="txtRPTTime9" Style="width: 100%; background-color: Lavender;" ReadOnly="true"
                        runat="server"></asp:TextBox>
                </td>
                <td style="width: 15%; background-color: -moz-field; font-family: Calibri; color: DarkBlue;
                    text-align: left;">
                    <asp:DropDownList ID="ddlProj9" AutoPostBack="false" Style="width: 99%; background-color: Lavender;
                        font-family: Calibri;" runat="server">
                    </asp:DropDownList>
                </td>
                <td style="width: 45%; background-color: -moz-field; font-family: Calibri; color: DarkBlue;
                    text-align: left;">
                    <asp:TextBox ID="txtOutput9" Style="width: 100%; background-color: Lavender;" runat="server"></asp:TextBox>
                </td>
                <td style="width: 5%; background-color: -moz-field; font-family: Calibri; color: DarkBlue;
                    text-align: center;">
                    <asp:Button ID="btnSave9" Text="Save" Style="background-color: Lavender; width: 100%;"
                        OnClientClick="return saveHr9();" runat="server" />
                </td>
            </tr>
            <tr>
                <td style="width: 5%; background-color: -moz-field; font-family: Calibri; color: DarkBlue;
                    text-align: center;">
                    10th
                </td>
                <td style="width: 10%; background-color: -moz-field; font-family: Calibri; color: DarkBlue;
                    text-align: left;">
                    <asp:TextBox ID="txtFrmTime10" Style="width: 100%; background-color: Lavender;" ReadOnly="true"
                        runat="server"></asp:TextBox>
                </td>
                <td style="width: 10%; background-color: -moz-field; font-family: Calibri; color: DarkBlue;
                    text-align: left;">
                    <asp:TextBox ID="txtToTime10" Style="width: 100%; background-color: Lavender;" ReadOnly="true"
                        runat="server"></asp:TextBox>
                </td>
                <td style="width: 10%; background-color: -moz-field; font-family: Calibri; color: DarkBlue;
                    text-align: left;">
                    <asp:TextBox ID="txtRPTTime10" Style="width: 100%; background-color: Lavender;" ReadOnly="true"
                        runat="server"></asp:TextBox>
                </td>
                <td style="width: 15%; background-color: -moz-field; font-family: Calibri; color: DarkBlue;
                    text-align: left;">
                    <asp:DropDownList ID="ddlProj10" AutoPostBack="false" Style="width: 99%; background-color: Lavender;
                        font-family: Calibri;" runat="server">
                    </asp:DropDownList>
                </td>
                <td style="width: 45%; background-color: -moz-field; font-family: Calibri; color: DarkBlue;
                    text-align: left;">
                    <asp:TextBox ID="txtOutput10" Style="width: 100%; background-color: Lavender;" runat="server"></asp:TextBox>
                </td>
                <td style="width: 5%; background-color: -moz-field; font-family: Calibri; color: DarkBlue;
                    text-align: center;">
                    <asp:Button ID="btnSave10" Text="Save" Style="background-color: Lavender; width: 100%;"
                        OnClientClick="return saveHr10();" runat="server" />
                </td>
            </tr>
            <tr>
                <td style="width: 5%; background-color: -moz-field; font-family: Calibri; color: DarkBlue;
                    text-align: center;">
                    11th
                </td>
                <td style="width: 10%; background-color: -moz-field; font-family: Calibri; color: DarkBlue;
                    text-align: left;">
                    <asp:TextBox ID="txtFrmTime11" Style="width: 100%; background-color: Lavender;" ReadOnly="true"
                        runat="server"></asp:TextBox>
                </td>
                <td style="width: 10%; background-color: -moz-field; font-family: Calibri; color: DarkBlue;
                    text-align: left;">
                    <asp:TextBox ID="txtToTime11" Style="width: 100%; background-color: Lavender;" ReadOnly="true"
                        runat="server"></asp:TextBox>
                </td>
                <td style="width: 10%; background-color: -moz-field; font-family: Calibri; color: DarkBlue;
                    text-align: left;">
                    <asp:TextBox ID="txtRPTTime11" Style="width: 100%; background-color: Lavender;" ReadOnly="true"
                        runat="server"></asp:TextBox>
                </td>
                <td style="width: 15%; background-color: -moz-field; font-family: Calibri; color: DarkBlue;
                    text-align: left;">
                    <asp:DropDownList ID="ddlProj11" AutoPostBack="false" Style="width: 99%; background-color: Lavender;
                        font-family: Calibri;" runat="server">
                    </asp:DropDownList>
                </td>
                <td style="width: 45%; background-color: -moz-field; font-family: Calibri; color: DarkBlue;
                    text-align: left;">
                    <asp:TextBox ID="txtOutput11" Style="width: 100%; background-color: Lavender;" runat="server"></asp:TextBox>
                </td>
                <td style="width: 5%; background-color: -moz-field; font-family: Calibri; color: DarkBlue;
                    text-align: center;">
                    <asp:Button ID="btnSave11" Text="Save" Style="background-color: Lavender; width: 100%;"
                        OnClientClick="return saveHr11();" runat="server" />
                </td>
            </tr>
            <tr>
                <td style="width: 5%; background-color: -moz-field; font-family: Calibri; color: DarkBlue;
                    text-align: center;">
                    12th
                </td>
                <td style="width: 10%; background-color: -moz-field; font-family: Calibri; color: DarkBlue;
                    text-align: left;">
                    <asp:TextBox ID="txtFrmTime12" Style="width: 100%; background-color: Lavender;" ReadOnly="true"
                        runat="server"></asp:TextBox>
                </td>
                <td style="width: 10%; background-color: -moz-field; font-family: Calibri; color: DarkBlue;
                    text-align: left;">
                    <asp:TextBox ID="txtToTime12" Style="width: 100%; background-color: Lavender;" ReadOnly="true"
                        runat="server"></asp:TextBox>
                </td>
                <td style="width: 10%; background-color: -moz-field; font-family: Calibri; color: DarkBlue;
                    text-align: left;">
                    <asp:TextBox ID="txtRPTTime12" Style="width: 100%; background-color: Lavender;" ReadOnly="true"
                        runat="server"></asp:TextBox>
                </td>
                <td style="width: 15%; background-color: -moz-field; font-family: Calibri; color: DarkBlue;
                    text-align: left;">
                    <asp:DropDownList ID="ddlProj12" AutoPostBack="false" Style="width: 99%; background-color: Lavender;
                        font-family: Calibri;" runat="server">
                    </asp:DropDownList>
                </td>
                <td style="width: 45%; background-color: -moz-field; font-family: Calibri; color: DarkBlue;
                    text-align: left;">
                    <asp:TextBox ID="txtOutput12" Style="width: 100%; background-color: Lavender;" runat="server"></asp:TextBox>
                </td>
                <td style="width: 5%; background-color: -moz-field; font-family: Calibri; color: DarkBlue;
                    text-align: center;">
                    <asp:Button ID="btnSave12" Text="Save" Style="background-color: Lavender; width: 100%;"
                        OnClientClick="return saveHr12();" runat="server" />
                </td>
            </tr>
        </table>
        <br />
        <br />
        <table width="100%">
            <tr>
                <td style="width: 25%; font-family: Calibri; color: DarkBlue; text-align: left;">
                    Overall Benefit To Company:
                </td>
                <td style="width: 75%; text-align: left;">
                    <asp:TextBox ID="txtOveralloutput" Width="85%" Height="75px" TextMode="MultiLine"
                        runat="server"></asp:TextBox>
                </td>
            </tr>
        </table>
        <table width="100%">
            <tr>
                <td style="width: 82%; font-family: Calibri; color: DarkBlue; text-align: left;">
                    If there is no task assigned/pending for you, have you contacted your seniors to
                    assign you the new task(s)?
                </td>
                <td style="width: 18%; font-family: Calibri; text-align: left;">
                    <asp:CheckBox ID="CByes" Checked="false" Text="Yes" runat="server" />
                    <%--<asp:CheckBox ID="CBNo" Checked="false" Text="No" runat="server" />--%>
                </td>
            </tr>
            <br />
            <tr>
                <td style="width: 82%; font-family: Calibri; color: DarkBlue; text-align: left;">
                    I have checked my tasks inbox and confirm that there are no unchecked task(s) assigned
                    to me for today.
                </td>
                <td style="width: 18%; font-family: Calibri; text-align: left;">
                    <asp:CheckBox ID="CBAgree" Text="Agree" runat="server" />
                </td>
            </tr>
        </table>
        <br />
        <table width="100%">
            <tr>
                <td style="font-family: Calibri; color: DarkBlue; text-align: left; width: 20%;">
                    My Today's Check-Out:
                </td>
                <td style="font-family: Calibri; color: DarkBlue; text-align: left; width: 80%;">
                    <asp:DropDownList ID="ddlCOutHrs" Style="font-family: Calibri; width: 50px; color: DarkBlue;"
                        runat="server">
                        <asp:ListItem>Hrs</asp:ListItem>
                        <asp:ListItem>00</asp:ListItem>
                        <asp:ListItem>01</asp:ListItem>
                        <asp:ListItem>02</asp:ListItem>
                        <asp:ListItem>03</asp:ListItem>
                        <asp:ListItem>04</asp:ListItem>
                        <asp:ListItem>05</asp:ListItem>
                        <asp:ListItem>06</asp:ListItem>
                        <asp:ListItem>07</asp:ListItem>
                        <asp:ListItem>08</asp:ListItem>
                        <asp:ListItem>09</asp:ListItem>
                        <asp:ListItem>10</asp:ListItem>
                        <asp:ListItem>11</asp:ListItem>
                        <asp:ListItem>12</asp:ListItem>
                        <asp:ListItem>13</asp:ListItem>
                        <asp:ListItem>14</asp:ListItem>
                        <asp:ListItem>15</asp:ListItem>
                        <asp:ListItem>16</asp:ListItem>
                        <asp:ListItem>17</asp:ListItem>
                        <asp:ListItem>18</asp:ListItem>
                        <asp:ListItem>19</asp:ListItem>
                        <asp:ListItem>20</asp:ListItem>
                        <asp:ListItem>21</asp:ListItem>
                        <asp:ListItem>22</asp:ListItem>
                        <asp:ListItem>23</asp:ListItem>
                    </asp:DropDownList>
                    <asp:DropDownList ID="ddlCOutMins" Style="font-family: Calibri; width: 50px; color: DarkBlue;"
                        runat="server">
                        <asp:ListItem>Mins</asp:ListItem>
                        <asp:ListItem>00</asp:ListItem>
                        <asp:ListItem>01</asp:ListItem>
                        <asp:ListItem>02</asp:ListItem>
                        <asp:ListItem>03</asp:ListItem>
                        <asp:ListItem>04</asp:ListItem>
                        <asp:ListItem>05</asp:ListItem>
                        <asp:ListItem>06</asp:ListItem>
                        <asp:ListItem>07</asp:ListItem>
                        <asp:ListItem>08</asp:ListItem>
                        <asp:ListItem>09</asp:ListItem>
                        <asp:ListItem>10</asp:ListItem>
                        <asp:ListItem>11</asp:ListItem>
                        <asp:ListItem>12</asp:ListItem>
                        <asp:ListItem>13</asp:ListItem>
                        <asp:ListItem>14</asp:ListItem>
                        <asp:ListItem>15</asp:ListItem>
                        <asp:ListItem>16</asp:ListItem>
                        <asp:ListItem>17</asp:ListItem>
                        <asp:ListItem>18</asp:ListItem>
                        <asp:ListItem>19</asp:ListItem>
                        <asp:ListItem>20</asp:ListItem>
                        <asp:ListItem>21</asp:ListItem>
                        <asp:ListItem>22</asp:ListItem>
                        <asp:ListItem>23</asp:ListItem>
                        <asp:ListItem>24</asp:ListItem>
                        <asp:ListItem>25</asp:ListItem>
                        <asp:ListItem>26</asp:ListItem>
                        <asp:ListItem>27</asp:ListItem>
                        <asp:ListItem>28</asp:ListItem>
                        <asp:ListItem>29</asp:ListItem>
                        <asp:ListItem>30</asp:ListItem>
                        <asp:ListItem>31</asp:ListItem>
                        <asp:ListItem>32</asp:ListItem>
                        <asp:ListItem>33</asp:ListItem>
                        <asp:ListItem>34</asp:ListItem>
                        <asp:ListItem>35</asp:ListItem>
                        <asp:ListItem>36</asp:ListItem>
                        <asp:ListItem>37</asp:ListItem>
                        <asp:ListItem>38</asp:ListItem>
                        <asp:ListItem>39</asp:ListItem>
                        <asp:ListItem>40</asp:ListItem>
                        <asp:ListItem>41</asp:ListItem>
                        <asp:ListItem>42</asp:ListItem>
                        <asp:ListItem>43</asp:ListItem>
                        <asp:ListItem>44</asp:ListItem>
                        <asp:ListItem>45</asp:ListItem>
                        <asp:ListItem>46</asp:ListItem>
                        <asp:ListItem>47</asp:ListItem>
                        <asp:ListItem>48</asp:ListItem>
                        <asp:ListItem>49</asp:ListItem>
                        <asp:ListItem>50</asp:ListItem>
                        <asp:ListItem>51</asp:ListItem>
                        <asp:ListItem>52</asp:ListItem>
                        <asp:ListItem>53</asp:ListItem>
                        <asp:ListItem>54</asp:ListItem>
                        <asp:ListItem>55</asp:ListItem>
                        <asp:ListItem>56</asp:ListItem>
                        <asp:ListItem>57</asp:ListItem>
                        <asp:ListItem>58</asp:ListItem>
                        <asp:ListItem>59</asp:ListItem>
                    </asp:DropDownList>
                </td>
                <asp:Label ID="lblHidden" Visible="false" runat="server"></asp:Label>
            </tr>
            <tr>
                <td colspan="2" align="center">
                    <asp:Button ID="btnSubmit" Text="Send Final Report" Style="width: 120px; height: 40px;
                        background-color: DarkBlue; color: White; font-family: Calibri; font-size: medium;"
                        OnClientClick="return finalReport();" runat="server" />
                </td>
            </tr>
        </table>
    </div>

    <script type="text/javascript" language="javascript">
        $(document).ready(function () {
            reportTime();
            assignValues();
            var CheckIn = "";
            CheckIn = $("span[id$='lblTimeIn']").text();
            var HrMins = "";
            HrsMins = CheckIn.split(":");
            if (CheckIn != "") {
                $("select[id$='ddlCInHrs']").val(HrsMins[0].trim());
                $("select[id$='ddlCInMins']").val(HrsMins[1].trim());
            }
            timein();
            userDept();
            ProjOption();
        });
        var DeptID = "";
        function CheckBox() {
            var chck = "";
            chck = $("input[id$='CByes']").is(':checked');
            chck1 = $("input[id$='CBNo']").is(':checked');
            if (chck == true || chck1 == true) {
                if (chck == true) {
                    $("input[id$='CBNo']").attr('checked', false);
                }
                else if (chck1 == true) {
                    $("input[id$='CByes']").attr('checked', false);
                }
            }
            return false;
        }

        function assignValues() {
            var EmpName = $("span[id$='lblUserName']").text();
            $("span[id$='lblEmpName']").text(EmpName);
            return false;
        }

        function timein() {
            var CInHrs;
            CInHrs = $("select[id$='ddlCInHrs'] option:selected").val();
            var CInMins;
            CInMins = $("select[id$='ddlCInMins'] option:selected").val();
            if (CInHrs != "Hrs" && CInMins != "Mins") {
                var Time = CInHrs + ":" + CInMins;
                $("span[id$='lblTimeIn']").text(Time);
            }
            setTime();
            return false;
        }

        function reportTime() {
            var now = new Date();
            var Hrs = now.getHours();
            var Mins = now.getMinutes();
            var RPTTime = Hrs + ":" + Mins;
            var RPTTime1 = $("input[id$='txtRPTTime1']").val();
            if (RPTTime1 == "") {
                $("input[id$='txtRPTTime1']").val(RPTTime);
            }
            var RPTTime2 = $("input[id$='txtRPTTime2']").val();
            if (RPTTime2 == "") {
                $("input[id$='RPTTime2']").val(RPTTime);
            }
            var RPTTime3 = $("input[id$='txtRPTTime3']").val();
            if (RPTTime3 == "") {
                $("input[id$='txtRPTTime3']").val(RPTTime);
            }
            var RPTTime4 = $("input[id$='txtRPTTime4']").val();
            if (RPTTime4 == "") {
                $("input[id$='txtRPTTime4']").val(RPTTime);
            }
            var RPTTime5 = $("input[id$='txtRPTTime5']").val();
            if (RPTTime5 == "") {
                $("input[id$='txtRPTTime5']").val(RPTTime);
            }
            var RPTTime6 = $("input[id$='txtRPTTime6']").val();
            if (RPTTime6 == "") {
                $("input[id$='txtRPTTime6']").val(RPTTime);
            }
            var RPTTime7 = $("input[id$='txtRPTTime7']").val();
            if (RPTTime7 == "") {
                $("input[id$='txtRPTTime7']").val(RPTTime);
            }
            var RPTTime8 = $("input[id$='txtRPTTime8']").val();
            if (RPTTime8 == "") {
                $("input[id$='txtRPTTime8']").val(RPTTime);
            }
            var RPTTime9 = $("input[id$='txtRPTTime9']").val();
            if (RPTTime9 == "") {
                $("input[id$='txtRPTTime9']").val(RPTTime);
            }
            var RPTTime10 = $("input[id$='txtRPTTime10']").val();
            if (RPTTime10 == "") {
                $("input[id$='txtRPTTime10']").val(RPTTime);
            }
            var RPTTime11 = $("input[id$='txtRPTTime11']").val();
            if (RPTTime11 == "") {
                $("input[id$='txtRPTTime11']").val(RPTTime);
            }
            var RPTTime12 = $("input[id$='txtRPTTime12']").val();
            if (RPTTime12 == "") {
                $("input[id$='txtRPTTime12']").val(RPTTime);
            }
            return false;
        }

        function setTime() {
            var TimeIn;
            TimeIn = $("span[id$='lblTimeIn']").text();
            if (TimeIn != "") {
                $("input[id$='txtFrmTime1']").val(TimeIn);
                var Time = "";
                Time = TimeIn.toString().split(':');
                var Hrs = Time[0];
                var NewHrs;
                if (Hrs == 08 || Hrs == 09) {
                    NewHrs = parseInt(Hrs, 10) + 1;
                }
                else {
                    NewHrs = parseInt(Hrs) + 1;
                }
                var Time2;
                if (NewHrs == 24) {
                    NewHrs = 0;
                }
                if (NewHrs.toString().length == 1) {
                    Time2 = '0' + NewHrs + ':' + Time[1];
                }
                else {
                    Time2 = NewHrs + ':' + Time[1];
                }
                $("input[id$='txtFrmTime2']").val(Time2);
                $("input[id$='txtToTime1']").val(Time2);
                var NewHrs1 = parseInt(NewHrs) + 1;
                var Time3;
                if (NewHrs1 == 24) {
                    NewHrs1 = 0;
                }
                if (NewHrs1.toString().length == 1) {
                    Time3 = '0' + NewHrs1 + ':' + Time[1];
                }
                else {
                    Time3 = NewHrs1 + ':' + Time[1];
                }
                $("input[id$='txtToTime2']").val(Time3);
                $("input[id$='txtFrmTime3']").val(Time3);
                var NewHrs2 = parseInt(NewHrs1) + 1;
                var Time4;
                if (NewHrs2 == 24) {
                    NewHrs2 = 0;
                }
                if (NewHrs2.toString().length == 1) {
                    Time4 = '0' + NewHrs2 + ':' + Time[1];
                }
                else {
                    Time4 = NewHrs2 + ':' + Time[1];
                }
                $("input[id$='txtToTime3']").val(Time4);
                $("input[id$='txtFrmTime4']").val(Time4);
                var NewHrs3 = parseInt(NewHrs2) + 1;
                var Time5;
                if (NewHrs3 == 24) {
                    NewHrs3 = 0;
                }
                if (NewHrs3.toString().length == 1) {
                    Time5 = '0' + NewHrs3 + ':' + Time[1];
                }
                else {
                    Time5 = NewHrs3 + ':' + Time[1];
                }
                $("input[id$='txtToTime4']").val(Time5);
                $("input[id$='txtFrmTime5']").val(Time5);
                var NewHrs4 = parseInt(NewHrs3) + 1;
                var Time6;
                if (NewHrs4 == 24) {
                    NewHrs4 = 0;
                }
                if (NewHrs4.toString().length == 1) {
                    Time6 = '0' + NewHrs4 + ':' + Time[1];
                }
                else {
                    Time6 = NewHrs4 + ':' + Time[1];
                }
                $("input[id$='txtToTime5']").val(Time6);
                $("input[id$='txtFrmTime6']").val(Time6);
                var NewHrs5 = parseInt(NewHrs4) + 1;
                var Time7;
                if (NewHrs5 == 24) {
                    NewHrs5 = 0;
                }
                if (NewHrs5.toString().length == 1) {
                    Time7 = '0' + NewHrs5 + ':' + Time[1];
                }
                else {
                    Time7 = NewHrs5 + ':' + Time[1];
                }
                $("input[id$='txtToTime6']").val(Time7);
                $("input[id$='txtFrmTime7']").val(Time7);
                var NewHrs6 = parseInt(NewHrs5) + 1;
                var Time8;
                if (NewHrs6 == 24) {
                    NewHrs6 = 0;
                }
                if (NewHrs6.toString().length == 1) {
                    Time8 = '0' + NewHrs6 + ':' + Time[1];
                }
                else {
                    Time8 = NewHrs6 + ':' + Time[1];
                }
                $("input[id$='txtToTime7']").val(Time8);
                $("input[id$='txtFrmTime8']").val(Time8);
                var NewHrs7 = parseInt(NewHrs6) + 1;
                var Time9;
                if (NewHrs7 == 24) {
                    NewHrs7 = 0;
                }
                if (NewHrs7.toString().length == 1) {
                    Time9 = '0' + NewHrs7 + ':' + Time[1];
                }
                else {
                    Time9 = NewHrs7 + ':' + Time[1];
                }
                $("input[id$='txtToTime8']").val(Time9);
                $("input[id$='txtFrmTime9']").val(Time9);
                var NewHrs8 = parseInt(NewHrs7) + 1;
                var Time10;
                if (NewHrs8 == 24) {
                    NewHrs8 = 0;
                }
                if (NewHrs8.toString().length == 1) {
                    Time10 = '0' + NewHrs8 + ':' + Time[1];
                }
                else {
                    Time10 = NewHrs8 + ':' + Time[1];
                }
                $("input[id$='txtToTime9']").val(Time10);
                $("input[id$='txtFrmTime10']").val(Time10);
                var NewHrs9 = parseInt(NewHrs8) + 1;
                var Time11;
                if (NewHrs9 == 24) {
                    NewHrs9 = 0;
                }
                if (NewHrs9.toString().length == 1) {
                    Time11 = '0' + NewHrs9 + ':' + Time[1];
                }
                else {
                    Time11 = NewHrs9 + ':' + Time[1];
                }
                $("input[id$='txtToTime10']").val(Time11);
                $("input[id$='txtFrmTime11']").val(Time11);
                var NewHrs10 = parseInt(NewHrs9) + 1;
                var Time12;
                if (NewHrs10 == 24) {
                    NewHrs10 = 0;
                }
                if (NewHrs10.toString().length == 1) {
                    Time12 = '0' + NewHrs10 + ':' + Time[1];
                }
                else {
                    Time12 = NewHrs10 + ':' + Time[1];
                }
                $("input[id$='txtToTime11']").val(Time12);
                $("input[id$='txtFrmTime12']").val(Time12);
                var NewHrs11 = parseInt(NewHrs10) + 1;
                var Time13;
                if (NewHrs11 == 24) {
                    NewHrs11 = 0;
                }
                if (NewHrs11.toString().length == 1) {
                    Time13 = '0' + NewHrs11 + ':' + Time[1];
                }
                else {
                    Time13 = NewHrs11 + ':' + Time[1];
                }
                $("input[id$='txtToTime12']").val(Time13);
                return false;
            }
        }

        function saveHr1() {
            debugger;
            var EmpName = $("span[id$='lblEmpName']").text();
            var TimeIn = $("input[id$='txtFrmTime1']").val();
            var FrmTime1 = $("input[id$='txtFrmTime1']").val();
            var ToTime1 = $("input[id$='txtToTime1']").val();
            var RPTTime1 = $("input[id$='txtRPTTime1']").val()
            var Proj1 = $("select[id$='ddlProj1']").val();
            var Task1 = $("input[id$='txtOutput1']").val();
            var Hr1 = 1;
            var toTime1 = ToTime1.toString().split(':');
            var currDate = new Date();
            var Hrs = currDate.getHours();
            var Mins = currDate.getMinutes();
            if (FrmTime1 == "") {
                alert("Please Select Check-In Time!");
                return false;
            }
            if (Hrs < toTime1[0]) {
                alert("Report Time Must Be Greater Than End Time!");
                return false;
            }
            if (Hrs == toTime1[0]) {
                if (Mins < toTime1[1]) {
                    alert("Report Time Must Be Greater Than End Time!");
                    return false;
                }
            }
            if (RPTTime1 == "") {
                alert("Please Refresh This Page!");
                return false;
            }
            if (DeptID == 10) {
                if (Proj1 == "") {
                    alert("Please Select Project For The 1st Hour!");
                    return false;
                }
            }
            if (Task1 == "") {
                alert("Please Write Your Output For The 1st Hour!");
                return false;
            }
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "frmDailyOutputReport.aspx/SaveRPTData",
                data: "{'EmpName':'" + EmpName + "','TimeIn':'" + TimeIn + "','FrmTime1':'" + FrmTime1 + "','ToTime1':'" + ToTime1 + "','RPTTime1':'" + RPTTime1 + "','Proj1':'" + Proj1 + "','Task1':'" + Task1 + "','Hr1':'" + Hr1 + "'}",
                success: onsuccessSave,
                error: onretrieveSaveError
            });
            return false;
        }
        function onsuccessSave(msg) {
            var data = msg.d;
            $("span[id$='lblReportID']").text(data[0]);
            var ua = $.browser;
            if (ua.msie) {
                alert("First Hour Successfully Saved!");
                window.location('../../MCTX_Internal/SuperAdmin/frmDailyOutputReport.aspx');
            }
            else {
                alert("First Hour Successfully Saved!");
                location.reload();
            }
            return false;
        }
        function onretrieveSaveError() {
            alert("Error In Saving First Hour!");
            $("input[id$='txtOutput1']").val("");
            return false;
        }

        function saveHr2() {
            var EmpName = $("span[id$='lblEmpName']").text();
            var DailyReport_ID = $("span[id$='lblReportID']").text();
            var TimeIn = $("input[id$='txtFrmTime1']").val();
            var FrmTime2 = $("input[id$='txtFrmTime2']").val();
            var ToTime2 = $("input[id$='txtToTime2']").val();
            var RPTTime2 = $("input[id$='txtRPTTime2']").val();
            var Proj2 = $("select[id$='ddlProj2']").val();
            var Task1 = $("input[id$='txtOutput1']").val();
            var Task2 = $("input[id$='txtOutput2']").val();
            var Hr2 = 2;
            var toTime2 = ToTime2.toString().split(':');
            var currDate = new Date();
            var Hrs = currDate.getHours();
            var Mins = currDate.getMinutes();
            if (FrmTime2 == "") {
                alert("Please Select Check-In Time!");
                return false;
            }
            if (Hrs < toTime2[0]) {
                alert("Report Time Must Be Greater Than End Time!");
                return false;
            }
            if (Hrs == toTime2[0]) {
                if (Mins < toTime2[1]) {
                    alert("Report Time Must Be Greater Than End Time!");
                    return false;
                }
            }
            if (RPTTime2 == "") {
                alert("Please Refresh This Page!");
                return false;
            }
            if (DeptID == 10) {
                if (Proj2 == "") {
                    alert("Please Select Project For The 2nd Hour!");
                    return false;
                }
            }
            if (Task1 == "") {
                alert("Please Save Previous Hour First!");
                return false;
            }
            if (Task2 == "") {
                alert("Please Write Your Output For The 2nd Hour!");
                return false;
            }
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "frmDailyOutputReport.aspx/SaveRPTData1",
                data: "{'EmpName':'" + EmpName + "','TimeIn':'" + TimeIn + "','FrmTime2':'" + FrmTime2 + "','ToTime2':'" + ToTime2 + "','RPTTime2':'" + RPTTime2 + "','Proj2':'" + Proj2 + "','Task2':'" + Task2 + "','Hr2':'" + Hr2 + "','DailyReport_ID':'" + DailyReport_ID + "'}",
                success: onsuccessSave1,
                error: onretrieveSaveError1
            });
            return false;
        }
        function onsuccessSave1() {
            alert("Second Hour Saved Successfully!");
            return false;
        }
        function onretrieveSaveError1() {
            alert("Error In Saving Second Hour!");
            $("input[id$='txtOutput2']").val("");
            return false;
        }

        function saveHr3() {
            var EmpName = $("span[id$='lblEmpName']").text();
            var DailyReport_ID = $("span[id$='lblReportID']").text();
            var TimeIn = $("input[id$='txtFrmTime1']").val();
            var FrmTime3 = $("input[id$='txtFrmTime3']").val();
            var ToTime3 = $("input[id$='txtToTime3']").val();
            var RPTTime3 = $("input[id$='txtRPTTime3']").val();
            var Proj3 = $("select[id$='ddlProj3']").val();
            var Task2 = $("input[id$='txtOutput2']").val();
            var Task3 = $("input[id$='txtOutput3']").val();
            var Hr3 = 3;
            var toTime3 = ToTime3.toString().split(':');
            var currDate = new Date();
            var Hrs = currDate.getHours();
            var Mins = currDate.getMinutes();
            if (FrmTime3 == "") {
                alert("Please Select Check-In Time!");
                return false;
            }
            if (Hrs < toTime3[0]) {
                alert("Report Time Must Be Greater Than End Time!");
                return false;
            }
            if (Hrs == toTime3[0]) {
                if (Mins < toTime3[1]) {
                    alert("Report Time Must Be Greater Than End Time!");
                    return false;
                }
            }
            if (RPTTime3 == "") {
                alert("Please Refresh This Page!");
                return false;
            }
            if (DeptID == 10) {
                if (Proj3 == "") {
                    alert("Please Select Project For The 3rd Hour!");
                    return false;
                }
            }
            if (Task2 == "") {
                alert("Please Save Previous Hour First!");
                return false;
            }
            if (Task3 == "") {
                alert("Please Write Your Output For The 3rd Hour!");
                return false;
            }
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "frmDailyOutputReport.aspx/SaveRPTData2",
                data: "{'EmpName':'" + EmpName + "','TimeIn':'" + TimeIn + "','FrmTime3':'" + FrmTime3 + "','ToTime3':'" + ToTime3 + "','RPTTime3':'" + RPTTime3 + "','Proj3':'" + Proj3 + "','Task3':'" + Task3 + "','Hr3':'" + Hr3 + "','DailyReport_ID':'" + DailyReport_ID + "'}",
                success: onsuccessSave2,
                error: onretrieveSaveError2
            });
            return false;
        }
        function onsuccessSave2() {
            alert("Third Hour Saved Successfully!");
            return false;
        }
        function onretrieveSaveError2() {
            alert("Error In Saving Third Hour!");
            $("input[id$='txtOutput3']").val("");
            return false;
        }

        function saveHr4() {
            var EmpName = $("span[id$='lblEmpName']").text();
            var DailyReport_ID = $("span[id$='lblReportID']").text();
            var TimeIn = $("input[id$='txtFrmTime1']").val();
            var FrmTime4 = $("input[id$='txtFrmTime4']").val();
            var ToTime4 = $("input[id$='txtToTime4']").val();
            var RPTTime4 = $("input[id$='txtRPTTime4']").val();
            var Proj4 = $("select[id$='ddlProj4']").val();
            var Task3 = $("input[id$='txtOutput3']").val();
            var Task4 = $("input[id$='txtOutput4']").val();
            var Hr4 = 4;
            var toTime4 = ToTime4.toString().split(':');
            var currDate = new Date();
            var Hrs = currDate.getHours();
            var Mins = currDate.getMinutes();
            if (FrmTime4 == "") {
                alert("Please Select Check-In Time!");
                return false;
            }
            if (Hrs < toTime4[0]) {
                alert("Report Time Must Be Greater Than End Time!");
                return false;
            }
            if (Hrs == toTime4[0]) {
                if (Mins < toTime4[1]) {
                    alert("Report Time Must Be Greater Than End Time!");
                    return false;
                }
            }
            if (RPTTime4 == "") {
                alert("Please Refresh This Page!");
                return false;
            }
            if (DeptID == 10) {
                if (Proj4 == "") {
                    alert("Please Select Project For The 4th Hour!");
                    return false;
                }
            }
            if (Task3 == "") {
                alert("Please Save Previous Hour First!");
                return false;
            }
            if (Task4 == "") {
                alert("Please Write Your Output For The 4th Hour!");
                return false;
            }
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "frmDailyOutputReport.aspx/SaveRPTData3",
                data: "{'EmpName':'" + EmpName + "','TimeIn':'" + TimeIn + "','FrmTime4':'" + FrmTime4 + "','ToTime4':'" + ToTime4 + "','RPTTime4':'" + RPTTime4 + "','Proj4':'" + Proj4 + "','Task4':'" + Task4 + "','Hr4':'" + Hr4 + "','DailyReport_ID':'" + DailyReport_ID + "'}",
                success: onsuccessSave3,
                error: onretrieveSaveError3
            });
            return false;
        }
        function onsuccessSave3() {
            alert("Fourth Hour Saved Successfully!");
            return false;
        }
        function onretrieveSaveError3() {
            alert("Error In Saving Fourth Hour!");
            $("input[id$='txtOutput4']").val("");
            return false;
        }

        function saveHr5() {
            var EmpName = $("span[id$='lblEmpName']").text();
            var DailyReport_ID = $("span[id$='lblReportID']").text();
            var TimeIn = $("input[id$='txtFrmTime1']").val();
            var FrmTime5 = $("input[id$='txtFrmTime5']").val();
            var ToTime5 = $("input[id$='txtToTime5']").val();
            var RPTTime5 = $("input[id$='txtRPTTime5']").val();
            var Proj5 = $("select[id$='ddlProj5']").val();
            var Task4 = $("input[id$='txtOutput4']").val();
            var Task5 = $("input[id$='txtOutput5']").val();
            var Hr5 = 5;
            var toTime5 = ToTime5.toString().split(':');
            var currDate = new Date();
            var Hrs = currDate.getHours();
            var Mins = currDate.getMinutes();
            if (FrmTime5 == "") {
                alert("Please Select Check-In Time!");
                return false;
            }
            if (Hrs < toTime5[0]) {
                alert("Report Time Must Be Greater Than End Time!");
                return false;
            }
            if (Hrs == toTime5[0]) {
                if (Mins < toTime5[1]) {
                    alert("Report Time Must Be Greater Than End Time!");
                    return false;
                }
            }
            if (RPTTime5 == "") {
                alert("Please Refresh This Page!");
                return false;
            }
            if (DeptID == 10) {
                if (Proj5 == "") {
                    alert("Please Select Project For The 5th Hour!");
                    return false;
                }
            }
            if (Task4 == "") {
                alert("Please Save Previous Hour First!");
                return false;
            }
            if (Task5 == "") {
                alert("Please Write Your Output For The 5th Hour!");
                return false;
            }
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "frmDailyOutputReport.aspx/SaveRPTData4",
                data: "{'EmpName':'" + EmpName + "','TimeIn':'" + TimeIn + "','FrmTime5':'" + FrmTime5 + "','ToTime5':'" + ToTime5 + "','RPTTime5':'" + RPTTime5 + "','Proj5':'" + Proj5 + "','Task5':'" + Task5 + "','Hr5':'" + Hr5 + "','DailyReport_ID':'" + DailyReport_ID + "'}",
                success: onsuccessSave4,
                error: onretrieveSaveError4
            });
            return false;
        }
        function onsuccessSave4() {
            alert("Fifth Hour Saved Successfully!");
            return false;
        }
        function onretrieveSaveError4() {
            alert("Error In Saving Fifth Hour!");
            $("input[id$='txtOutput5']").val("");
            return false;
        }

        function saveHr6() {
            var EmpName = $("span[id$='lblEmpName']").text();
            var DailyReport_ID = $("span[id$='lblReportID']").text();
            var TimeIn = $("input[id$='txtFrmTime1']").val();
            var FrmTime6 = $("input[id$='txtFrmTime6']").val();
            var ToTime6 = $("input[id$='txtToTime6']").val();
            var RPTTime6 = $("input[id$='txtRPTTime6']").val();
            var Proj6 = $("select[id$='ddlProj6']").val();
            var Task5 = $("input[id$='txtOutput5']").val();
            var Task6 = $("input[id$='txtOutput6']").val();
            var Hr6 = 6;
            var toTime6 = ToTime6.toString().split(':');
            var currDate = new Date();
            var Hrs = currDate.getHours();
            var Mins = currDate.getMinutes();
            if (FrmTime6 == "") {
                alert("Please Select Check-In Time!");
                return false;
            }
            if (Hrs < toTime6[0]) {
                alert("Report Time Must Be Greater Than End Time!");
                return false;
            }
            if (Hrs == toTime6[0]) {
                if (Mins < toTime6[1]) {
                    alert("Report Time Must Be Greater Than End Time!");
                    return false;
                }
            }
            if (RPTTime6 == "") {
                alert("Please Refresh This Page!");
                return false;
            }
            if (DeptID == 10) {
                if (Proj6 == "") {
                    alert("Please Select Project For The 6th Hour!");
                    return false;
                }
            }
            if (Task5 == "") {
                alert("Please Save Previous Hour First!");
                return false;
            }
            if (Task6 == "") {
                alert("Please Write Your Output For The 6th Hour!");
                return false;
            }
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "frmDailyOutputReport.aspx/SaveRPTData5",
                data: "{'EmpName':'" + EmpName + "','TimeIn':'" + TimeIn + "','FrmTime6':'" + FrmTime6 + "','ToTime6':'" + ToTime6 + "','RPTTime6':'" + RPTTime6 + "','Proj6':'" + Proj6 + "','Task6':'" + Task6 + "','Hr6':'" + Hr6 + "','DailyReport_ID':'" + DailyReport_ID + "'}",
                success: onsuccessSave5,
                error: onretrieveSaveError5
            });
            return false;
        }
        function onsuccessSave5() {
            alert("Sixth Hour Saved Successfully!");
            return false;
        }
        function onretrieveSaveError5() {
            alert("Error In Saving Sixth Hour!");
            $("input[id$='txtOutput6']").val("");
            return false;
        }

        function saveHr7() {
            var EmpName = $("span[id$='lblEmpName']").text();
            var DailyReport_ID = $("span[id$='lblReportID']").text();
            var TimeIn = $("input[id$='txtFrmTime1']").val();
            var FrmTime7 = $("input[id$='txtFrmTime7']").val();
            var ToTime7 = $("input[id$='txtToTime7']").val();
            var RPTTime7 = $("input[id$='txtRPTTime7']").val();
            var Proj7 = $("select[id$='ddlProj7']").val();
            var Task6 = $("input[id$='txtOutput6']").val();
            var Task7 = $("input[id$='txtOutput7']").val();
            var Hr7 = 7;
            var toTime7 = ToTime7.toString().split(':');
            var currDate = new Date();
            var Hrs = currDate.getHours();
            var Mins = currDate.getMinutes();
            if (FrmTime7 == "") {
                alert("Please Select Check-In Time!");
                return false;
            }
            if (Hrs < toTime7[0]) {
                alert("Report Time Must Be Greater Than End Time!");
                return false;
            }
            if (Hrs == toTime7[0]) {
                if (Mins < toTime7[1]) {
                    alert("Report Time Must Be Greater Than End Time!");
                    return false;
                }
            }
            if (RPTTime7 == "") {
                alert("Please Refresh This Page!");
                return false;
            }
            if (DeptID == 10) {
                if (Proj7 == "") {
                    alert("Please Select Project For The 7th Hour!");
                    return false;
                }
            }
            if (Task6 == "") {
                alert("Please Save Previous Hour First!");
                return false;
            }
            if (Task7 == "") {
                alert("Please Write Your Output For The 7th Hour!");
                return false;
            }
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "frmDailyOutputReport.aspx/SaveRPTData6",
                data: "{'EmpName':'" + EmpName + "','TimeIn':'" + TimeIn + "','FrmTime7':'" + FrmTime7 + "','ToTime7':'" + ToTime7 + "','RPTTime7':'" + RPTTime7 + "','Proj7':'" + Proj7 + "','Task7':'" + Task7 + "','Hr7':'" + Hr7 + "','DailyReport_ID':'" + DailyReport_ID + "'}",
                success: onsuccessSave6,
                error: onretrieveSaveError6
            });
            return false;
        }
        function onsuccessSave6() {
            alert("Seventh Hour Saved Successfully!");
            return false;
        }
        function onretrieveSaveError6() {
            alert("Error In Saving Seventh Hour!");
            $("input[id$='txtOutput7']").val("");
            return false;
        }

        function saveHr8() {
            var EmpName = $("span[id$='lblEmpName']").text();
            var DailyReport_ID = $("span[id$='lblReportID']").text();
            var TimeIn = $("input[id$='txtFrmTime1']").val();
            var FrmTime8 = $("input[id$='txtFrmTime8']").val();
            var ToTime8 = $("input[id$='txtToTime8']").val();
            var RPTTime8 = $("input[id$='txtRPTTime8']").val();
            var Proj8 = $("select[id$='ddlProj8']").val();
            var Task7 = $("input[id$='txtOutput7']").val();
            var Task8 = $("input[id$='txtOutput8']").val();
            var Hr8 = 8;
            var toTime8 = ToTime8.toString().split(':');
            var currDate = new Date();
            var Hrs = currDate.getHours();
            var Mins = currDate.getMinutes();
            if (FrmTime8 == "") {
                alert("Please Select Check-In Time!");
                return false;
            }
            if (Hrs < toTime8[0]) {
                alert("Report Time Must Be Greater Than End Time!");
                return false;
            }
            if (Hrs == toTime8[0]) {
                if (Mins < toTime8[1]) {
                    alert("Report Time Must Be Greater Than End Time!");
                    return false;
                }
            }
            if (RPTTime8 == "") {
                alert("Please Refresh This Page!");
                return false;
            }
            if (DeptID == 10) {
                if (Proj8 == "") {
                    alert("Please Select Project For The 8th Hour!");
                    return false;
                }
            }
            if (Task7 == "") {
                alert("Please Save Previous Hour First!");
                return false;
            }
            if (Task8 == "") {
                alert("Please Write Your Output For The 8th Hour!");
                return false;
            }
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "frmDailyOutputReport.aspx/SaveRPTData7",
                data: "{'EmpName':'" + EmpName + "','TimeIn':'" + TimeIn + "','FrmTime8':'" + FrmTime8 + "','ToTime8':'" + ToTime8 + "','RPTTime8':'" + RPTTime8 + "','Proj8':'" + Proj8 + "','Task8':'" + Task8 + "','Hr8':'" + Hr8 + "','DailyReport_ID':'" + DailyReport_ID + "'}",
                success: onsuccessSave7,
                error: onretrieveSaveError7
            });
            return false;
        }
        function onsuccessSave7() {
            alert("Eigth Hour Saved Successfully!");
            return false;
        }
        function onretrieveSaveError7() {
            alert("Error In Saving Eigth Hour!");
            $("input[id$='txtOutput8']").val("");
            return false;
        }

        function saveHr9() {
            var EmpName = $("span[id$='lblEmpName']").text();
            var DailyReport_ID = $("span[id$='lblReportID']").text();
            var TimeIn = $("input[id$='txtFrmTime1']").val();
            var FrmTime9 = $("input[id$='txtFrmTime9']").val();
            var ToTime9 = $("input[id$='txtToTime9']").val();
            var RPTTime9 = $("input[id$='txtRPTTime9']").val();
            var Proj9 = $("select[id$='ddlProj9']").val();
            var Task8 = $("input[id$='txtOutput8']").val();
            var Task9 = $("input[id$='txtOutput9']").val();
            var Hr9 = 9;
            var toTime9 = ToTime9.toString().split(':');
            var currDate = new Date();
            var Hrs = currDate.getHours();
            var Mins = currDate.getMinutes();
            if (FrmTime9 == "") {
                alert("Please Select Check-In Time!");
                return false;
            }
            if (Hrs < toTime9[0]) {
                alert("Report Time Must Be Greater Than End Time!");
                return false;
            }
            if (Hrs == toTime9[0]) {
                if (Mins < toTime9[1]) {
                    alert("Report Time Must Be Greater Than End Time!");
                    return false;
                }
            }
            if (RPTTime9 == "") {
                alert("Please Refresh This Page!");
                return false;
            }
            if (DeptID == 10) {
                if (Proj9 == "") {
                    alert("Please Select Project For The 9th Hour!");
                    return false;
                }
            }
            if (Task8 == "") {
                alert("Please Save Previous Hour First!");
                return false;
            }
            if (Task9 == "") {
                alert("Please Write Your Output For The 9th Hour!");
                return false;
            }
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "frmDailyOutputReport.aspx/SaveRPTData8",
                data: "{'EmpName':'" + EmpName + "','TimeIn':'" + TimeIn + "','FrmTime9':'" + FrmTime9 + "','ToTime9':'" + ToTime9 + "','RPTTime9':'" + RPTTime9 + "','Proj9':'" + Proj9 + "','Task9':'" + Task9 + "','Hr9':'" + Hr9 + "','DailyReport_ID':'" + DailyReport_ID + "'}",
                success: onsuccessSave8,
                error: onretrieveSaveError8
            });
            return false;
        }
        function onsuccessSave8() {
            alert("Ninth Hour Saved Successfully!");
            return false;
        }
        function onretrieveSaveError8() {
            alert("Error In Saving Ninth Hour!");
            $("input[id$='txtOutput9']").val("");
            return false;
        }

        function saveHr10() {
            var EmpName = $("span[id$='lblEmpName']").text();
            var DailyReport_ID = $("span[id$='lblReportID']").text();
            var TimeIn = $("input[id$='txtFrmTime1']").val();
            var FrmTime10 = $("input[id$='txtFrmTime10']").val();
            var ToTime10 = $("input[id$='txtToTime10']").val();
            var RPTTime10 = $("input[id$='txtRPTTime10']").val();
            var Proj10 = $("select[id$='ddlProj10']").val();
            var Task9 = $("input[id$='txtOutput9']").val();
            var Task10 = $("input[id$='txtOutput10']").val();
            var Hr10 = 10;
            var toTime10 = ToTime10.toString().split(':');
            var currDate = new Date();
            var Hrs = currDate.getHours();
            var Mins = currDate.getMinutes();
            if (FrmTime10 == "") {
                alert("Please Select Check-In Time!");
                return false;
            }
            if (Hrs < toTime10[0]) {
                alert("Report Time Must Be Greater Than End Time!");
                return false;
            }
            if (Hrs == toTime10[0]) {
                if (Mins < toTime10[1]) {
                    alert("Report Time Must Be Greater Than End Time!");
                    return false;
                }
            }
            if (RPTTime10 == "") {
                alert("Please Refresh This Page!");
                return false;
            }
            if (DeptID == 10) {
                if (Proj10 == "") {
                    alert("Please Select Project For The 10th Hour!");
                    return false;
                }
            }
            if (Task9 == "") {
                alert("Please Save Previous Hour First!");
                return false;
            }
            if (Task10 == "") {
                alert("Please Write Your Output For The 10th Hour!");
                return false;
            }
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "frmDailyOutputReport.aspx/SaveRPTData9",
                data: "{'EmpName':'" + EmpName + "','TimeIn':'" + TimeIn + "','FrmTime10':'" + FrmTime10 + "','ToTime10':'" + ToTime10 + "','RPTTime10':'" + RPTTime10 + "','Proj10':'" + Proj10 + "','Task10':'" + Task10 + "','Hr10':'" + Hr10 + "','DailyReport_ID':'" + DailyReport_ID + "'}",
                success: onsuccessSave9,
                error: onretrieveSaveError9
            });
            return false;
        }
        function onsuccessSave9() {
            alert("Tenth Hour Saved Successfully!");
            return false;
        }
        function onretrieveSaveError9() {
            alert("Error In Saving Tenth Hour!");
            $("input[id$='txtOutput10']").val("");
            return false;
        }

        function saveHr11() {
            var EmpName = $("span[id$='lblEmpName']").text();
            var DailyReport_ID = $("span[id$='lblReportID']").text();
            var TimeIn = $("input[id$='txtFrmTime1']").val();
            var FrmTime11 = $("input[id$='txtFrmTime11']").val();
            var ToTime11 = $("input[id$='txtToTime11']").val();
            var RPTTime11 = $("input[id$='txtRPTTime11']").val();
            var Proj11 = $("select[id$='ddlProj11']").val();
            var Task10 = $("input[id$='txtOutput10']").val();
            var Task11 = $("input[id$='txtOutput11']").val();
            var Hr11 = 11;
            var toTime11 = ToTime11.toString().split(':');
            var currDate = new Date();
            var Hrs = currDate.getHours();
            var Mins = currDate.getMinutes();
            if (FrmTime11 == "") {
                alert("Please Select Check-In Time!");
                return false;
            }
            if (Hrs < toTime11[0]) {
                alert("Report Time Must Be Greater Than End Time!");
                return false;
            }
            if (Hrs == toTime11[0]) {
                if (Mins < toTime11[1]) {
                    alert("Report Time Must Be Greater Than End Time!");
                    return false;
                }
            }
            if (RPTTime11 == "") {
                alert("Please Refresh This Page!");
                return false;
            }
            if (DeptID == 10) {
                if (Proj11 == "") {
                    alert("Please Select Project For The 11th Hour!");
                    return false;
                }
            }
            if (Task10 == "") {
                alert("Please Save Previous Hour First!");
                return false;
            }
            if (Task11 == "") {
                alert("Please Write Your Output For The 11th Hour!");
                return false;
            }
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "frmDailyOutputReport.aspx/SaveRPTData10",
                data: "{'EmpName':'" + EmpName + "','TimeIn':'" + TimeIn + "','FrmTime11':'" + FrmTime11 + "','ToTime11':'" + ToTime11 + "','RPTTime11':'" + RPTTime11 + "','Proj11':'" + Proj11 + "','Task11':'" + Task11 + "','Hr11':'" + Hr11 + "','DailyReport_ID':'" + DailyReport_ID + "'}",
                success: onsuccessSave10,
                error: onretrieveSaveError10
            });
            return false;
        }
        function onsuccessSave10() {
            alert("Eleventh Hour Saved Successfully!");
            return false;
        }
        function onretrieveSaveError10() {
            alert("Error In Saving Eleventh Hour!");
            $("input[id$='txtOutput11']").val("");
            return false;
        }

        function saveHr12() {
            var EmpName = $("span[id$='lblEmpName']").text();
            var DailyReport_ID = $("span[id$='lblReportID']").text();
            var TimeIn = $("input[id$='txtFrmTime1']").val();
            var FrmTime12 = $("input[id$='txtFrmTime12']").val();
            var ToTime12 = $("input[id$='txtToTime12']").val();
            var RPTTime12 = $("input[id$='txtRPTTime12']").val();
            var Proj12 = $("select[id$='ddlProj12']").val();
            var Task11 = $("input[id$='txtOutput11']").val();
            var Task12 = $("input[id$='txtOutput12']").val();
            var Hr12 = 12;
            var toTime12 = ToTime12.toString().split(':');
            var currDate = new Date();
            var Hrs = currDate.getHours();
            var Mins = currDate.getMinutes();
            if (FrmTime12 == "") {
                alert("Please Select Check-In Time!");
                return false;
            }
            if (toTime12[0] > Hrs) {
                alert("Report Time Must Be Greater Than End Time!");
                return false;
            }
            if (toTime12[0] > Mins) {
                alert("Report Time Must Be Greater Than End Time!");
                return false;
            }
            if (RPTTime12 == "") {
                alert("Please Refresh This Page!");
                return false;
            }
            if (DeptID == 10) {
                if (Proj12 == "") {
                    alert("Please Select Project For The 12th Hour!");
                    return false;
                }
            }
            if (Task11 == "") {
                alert("Please Save Previous Hour First!");
                return false;
            }
            if (Task12 == "") {
                alert("Please Write Your Output For The 12th Hour!");
                return false;
            }
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "frmDailyOutputReport.aspx/SaveRPTData11",
                data: "{'EmpName':'" + EmpName + "','TimeIn':'" + TimeIn + "','FrmTime12':'" + FrmTime12 + "','ToTime12':'" + ToTime12 + "','RPTTime12':'" + RPTTime12 + "','Proj12':'" + Proj12 + "','Task12':'" + Task12 + "','Hr12':'" + Hr12 + "','DailyReport_ID':'" + DailyReport_ID + "'}",
                success: onsuccessSave11,
                error: onretrieveSaveError11
            });
            return false;
        }
        function onsuccessSave11() {
            alert("Twelfth Hour Saved Successfully!");
            return false;
        }
        function onretrieveSaveError11() {
            alert("Error In Saving Twelfth Hour!");
            $("input[id$='txtOutput12']").val("");
            return false;
        }
        function finalReport() {
            var COHrs = "";
            COHrs = $("select[id$='ddlCOutHrs']").val();
            if (COHrs == "Hrs") {
                alert("Incorrect Checkout Time!");
                return false;
            }
            var COMins = "";
            COMins = $("select[id$='ddlCOutMins']").val();
            if (COMins == "Mins") {
                alert("Incorrect Checkout Time!");
                return false;
            }
            var Checkout = "";
            CheckOut = COHrs + ":" + COMins;
            var Output = "";
            Output = $("textarea[id$='txtOveralloutput']").val();
            if (Output == "") {
                alert("Please Write Your Overall Benefit To The Company!");
                return false;
            }
            var ContactSenior = ""
            ContactSenior = $("input[id$='CByes']").attr('checked');
            if ($("input[id$='CByes']").attr('checked') == false) {
                alert("Please Check Contacted Seniors!");
                return false;
            }
            var ContSenior = "";
            if (ContactSenior == true) {
                ContSenior = "Yes";
            }
            var Agreement;
            Agreement = $("input[id$='CBAgree']").attr('checked');
            if (Agreement == false) {
                alert("Please Check The Agreement!");
                return false;
            }
            var DailyReport_ID = $("span[id$='lblReportID']").text();
            var CInHrs = $("select[id$='ddlCInHrs']").val();
            if (CInHrs > COHrs) {
                alert("Check-Out Time Cannot Be Less Than Check-In Time!");
                return false;
            }
            if (CInHrs == COHrs) {
                var CInMins = $("select[id$='ddlCInMins']").val();
                if (CInMins > COMins) {
                    alert("Check-Out Time Cannot Be Less Than Check-In Time!");
                    return false;
                }
            }
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "frmDailyOutputReport.aspx/SendFinalReport",
                data: "{'CheckOut':'" + CheckOut + "','Output':'" + Output + "','ContSenior':'" + ContSenior + "','DailyReport_ID':'" + DailyReport_ID + "'}",
                success: onsuccessSaveFinal,
                error: onretrieveSaveErrorFinal
            });
            return false;
        }
        function onsuccessSaveFinal() {
            SendEmail();
            alert("Report Sent Successfully!");
            return false;
        }
        function onretrieveSaveErrorFinal() {
            alert("Error In Sending Report!");
            return false;
        }
        function SendEmail() {
            var TimeIn = $("span[id$='lblTimeIn']").text();
            var frmTime1 = $("input[id$='txtFrmTime1']").val();
            var frmTime2 = $("input[id$='txtFrmTime2']").val();
            var frmTime3 = $("input[id$='txtFrmTime3']").val();
            var frmTime4 = $("input[id$='txtFrmTime4']").val();
            var frmTime5 = $("input[id$='txtFrmTime5']").val();
            var frmTime6 = $("input[id$='txtFrmTime6']").val();
            var frmTime7 = $("input[id$='txtFrmTime7']").val();
            var frmTime8 = $("input[id$='txtFrmTime8']").val();
            var frmTime9 = $("input[id$='txtFrmTime9']").val();
            var frmTime10 = $("input[id$='txtFrmTime10']").val();
            var frmTime11 = $("input[id$='txtFrmTime11']").val();
            var frmTime12 = $("input[id$='txtFrmTime12']").val();
            var totime1 = $("input[id$='txtToTime1']").val();
            var totime2 = $("input[id$='txtToTime2']").val();
            var totime3 = $("input[id$='txtToTime3']").val();
            var totime4 = $("input[id$='txtToTime4']").val();
            var totime5 = $("input[id$='txtToTime5']").val();
            var totime6 = $("input[id$='txtToTime6']").val();
            var totime7 = $("input[id$='txtToTime7']").val();
            var totime8 = $("input[id$='txtToTime8']").val();
            var totime9 = $("input[id$='txtToTime9']").val();
            var totime10 = $("input[id$='txtToTime10']").val();
            var totime11 = $("input[id$='txtToTime11']").val();
            var totime12 = $("input[id$='txtToTime12']").val();
            var RPTtime1 = $("input[id$='txtRPTTime1']").val();
            var RPTtime2 = $("input[id$='txtRPTTime2']").val();
            var RPTtime3 = $("input[id$='txtRPTTime3']").val();
            var RPTtime4 = $("input[id$='txtRPTTime4']").val();
            var RPTtime5 = $("input[id$='txtRPTTime5']").val();
            var RPTtime6 = $("input[id$='txtRPTTime6']").val();
            var RPTtime7 = $("input[id$='txtRPTTime7']").val();
            var RPTtime8 = $("input[id$='txtRPTTime8']").val();
            var RPTtime9 = $("input[id$='txtRPTTime9']").val();
            var RPTtime10 = $("input[id$='txtRPTTime10']").val();
            var RPTtime11 = $("input[id$='txtRPTTime11']").val();
            var RPTtime12 = $("input[id$='txtRPTTime12']").val();
            var Proj1 = $("select[id$='ddlProj1'] option:selected").text();
            var Proj2 = $("select[id$='ddlProj2'] option:selected").text();
            var Proj3 = $("select[id$='ddlProj3'] option:selected").text();
            var Proj4 = $("select[id$='ddlProj4'] option:selected").text();
            var Proj5 = $("select[id$='ddlProj5'] option:selected").text();
            var Proj6 = $("select[id$='ddlProj6'] option:selected").text();
            var Proj7 = $("select[id$='ddlProj7'] option:selected").text();
            var Proj8 = $("select[id$='ddlProj8'] option:selected").text();
            var Proj9 = $("select[id$='ddlProj9'] option:selected").text();
            var Proj10 = $("select[id$='ddlProj10'] option:selected").text();
            var Proj11 = $("select[id$='ddlProj11'] option:selected").text();
            var Proj12 = $("select[id$='ddlProj12'] option:selected").text();
            var Task1 = $("input[id$='txtOutput1']").val();
            var Task2 = $("input[id$='txtOutput2']").val();
            var Task3 = $("input[id$='txtOutput3']").val();
            var Task4 = $("input[id$='txtOutput4']").val();
            var Task5 = $("input[id$='txtOutput5']").val();
            var Task6 = $("input[id$='txtOutput6']").val();
            var Task7 = $("input[id$='txtOutput7']").val();
            var Task8 = $("input[id$='txtOutput8']").val();
            var Task9 = $("input[id$='txtOutput9']").val();
            var Task10 = $("input[id$='txtOutput10']").val();
            var Task11 = $("input[id$='txtOutput11']").val();
            var Task12 = $("input[id$='txtOutput12']").val();
            var MyOutput = $("textarea[id$='txtOveralloutput']").val();
            var EmpName = $("span[id$='lblEmpName']").text();
            var Checkout = "";
            var COHrs = "";
            COHrs = $("select[id$='ddlCOutHrs']").val();
            var COMins = "";
            COMins = $("select[id$='ddlCOutMins']").val();
            CheckOut = COHrs + ":" + COMins;
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "frmDailyOutputReport.aspx/SendEmail",
                data: "{'TimeIn':'" + TimeIn + "','frmTime1':'" + frmTime1 + "','frmTime2':'" + frmTime2 + "','frmTime3':'" + frmTime3 + "','frmTime4':'" + frmTime4 + "','frmTime5':'" + frmTime5 + "','frmTime6':'" + frmTime6 + "','frmTime7':'" + frmTime7 + "','frmTime8':'" + frmTime8 + "','frmTime9':'" + frmTime9 + "','frmTime10':'" + frmTime10 + "','frmTime11':'" + frmTime11 + "','frmTime12':'" + frmTime12 + "','totime1':'" + totime1 + "','totime2':'" + totime2 + "','totime3':'" + totime3 + "','totime4':'" + totime4 + "','totime5':'" + totime5 + "','totime6':'" + totime6 + "','totime7':'" + totime7 + "','totime8':'" + totime8 + "','totime9':'" + totime9 + "','totime10':'" + totime10 + "','totime11':'" + totime11 + "','totime12':'" + totime12 + "','RPTtime1':'" + RPTtime1 + "','RPTtime2':'" + RPTtime2 + "','RPTtime3':'" + RPTtime3 + "','RPTtime4':'" + RPTtime4 + "','RPTtime5':'" + RPTtime5 + "','RPTtime6':'" + RPTtime6 + "','RPTtime7':'" + RPTtime7 + "','RPTtime8':'" + RPTtime8 + "','RPTtime9':'" + RPTtime9 + "','RPTtime10':'" + RPTtime10 + "','RPTtime11':'" + RPTtime11 + "','RPTtime12':'" + RPTtime12 + "','Proj1':'" + Proj1 + "','Proj2':'" + Proj2 + "','Proj3':'" + Proj3 + "','Proj4':'" + Proj4 + "','Proj5':'" + Proj5 + "','Proj6':'" + Proj6 + "','Proj7':'" + Proj7 + "','Proj8':'" + Proj8 + "','Proj9':'" + Proj9 + "','Proj10':'" + Proj10 + "','Proj11':'" + Proj11 + "','Proj12':'" + Proj12 + "','Task1':'" + Task1 + "','Task2':'" + Task2 + "','Task3':'" + Task3 + "','Task4':'" + Task4 + "','Task5':'" + Task5 + "','Task6':'" + Task6 + "','Task7':'" + Task7 + "','Task8':'" + Task8 + "','Task9':'" + Task9 + "','Task10':'" + Task10 + "','Task11':'" + Task11 + "','Task12':'" + Task12 + "','MyOutput':'" + MyOutput + "','CheckOut':'" + CheckOut + "','EmpName':'" + EmpName + "'}",
                success: onsuccessSendEmail,
                error: onretrieveSendEmail
            });
            return false;
        }
        function onsuccessSendEmail() {
            return false;
        }
        function onretrieveSendEmail() {
            alert("Error In Sending Email!");
            return false;
        }
        function userDept() {
            var EmpName = $("span[id$='lblEmpName']").text();
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "frmDailyOutputReport.aspx/UserDeptType",
                data: "{'EmpName':'" + EmpName + "'}",
                success: onsuccessuserDept,
                async: false,
                error: onretrieveuserDeptError
            });
            return false;
        }
        function onsuccessuserDept(msg) {
            var data = msg.d;
            DeptID = data;
            return false;
        }
        function onretrieveuserDeptError() {
            return false;
        }
        function ProjOption() {
            return false;
            if (DeptID != 10) {
                $("select[id$='ddlProj1']").attr('disabled', true);
                $("select[id$='ddlProj2']").attr('disabled', true);
                $("select[id$='ddlProj3']").attr('disabled', true);
                $("select[id$='ddlProj4']").attr('disabled', true);
                $("select[id$='ddlProj5']").attr('disabled', true);
                $("select[id$='ddlProj6']").attr('disabled', true);
                $("select[id$='ddlProj7']").attr('disabled', true);
                $("select[id$='ddlProj8']").attr('disabled', true);
                $("select[id$='ddlProj9']").attr('disabled', true);
                $("select[id$='ddlProj10']").attr('disabled', true);
                $("select[id$='ddlProj11']").attr('disabled', true);
                $("select[id$='ddlProj12']").attr('disabled', true);
            }

        }

    </script>

</asp:Content>

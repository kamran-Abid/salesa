<%@ Page Language="C#" MasterPageFile="MasterAdmin.master" AutoEventWireup="true"
    CodeFile="DailyOutput.aspx.cs" Inherits="MCTX_Internal_SuperAdmin_DailyOutput"
    Title="Employee Daily OutPut" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <table style="width: 100%; height: 333px;">
        <tr>
            <td valign="top" style="height: 331px">
                <div id="tabs">
                    <ul>
                        <li style="text-align: left"><a href="#tabs-1">My Daily Output</a></li>
                    </ul>
                    <div id="tabs-1">
                        <table style="width: 100%; height: 298px;">
                            <tr>
                                <td style="vertical-align: top">
                                    <table style="width: 100%">
                                        <tr>
                                            <td style="color: #FFFFFF; background-color: #006699; height: 14px;">
                                                <b>My Daily Output For The Company</b>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="height: 15px" align="center">
                                                <asp:Label ID="lblEmpName" runat="server"></asp:Label>
                                                &nbsp;| Report Id =
                                                <asp:Label ID="ReportId" runat="server" Text="New Report"></asp:Label>
                                                &nbsp;|
                                                <asp:Label ID="TimeIn" runat="server"></asp:Label>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="height: 18px" align="left">
                                                <b style="text-decoration: underline">NOTE: You Must Fill Each &amp; Every Entry Of
                                                    The Following Form :</b>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="left">
                                                My Today&#39;s Time-In in the Office&nbsp;:&nbsp;
                                                <asp:DropDownList ID="ddlHour" runat="server" Width="53px" BackColor="#CCCCCC" AutoPostBack="True"
                                                    OnSelectedIndexChanged="ddlHour_SelectedIndexChanged">
                                                    <asp:ListItem>Hour</asp:ListItem>
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
                                                &nbsp;<asp:DropDownList ID="ddlMinutes" runat="server" Width="64px" BackColor="#CCCCCC"
                                                    Height="16px" AutoPostBack="True" OnSelectedIndexChanged="ddlMinutes_SelectedIndexChanged">
                                                    <asp:ListItem>Minute</asp:ListItem>
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
                                                &nbsp;&nbsp; &nbsp;
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="left" style="color: #339933">
                                                My Today&#39;s Tasks/Activities are Following:
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <table style="width: 100%">
                                                    <tr>
                                                        <td style="width: 77px" align="left">
                                                            <b>Hours:</b>
                                                        </td>
                                                        <td align="left" style="width: 77px">
                                                            <b>Start Time:</b>
                                                        </td>
                                                        <td align="left" style="width: 74px">
                                                            <b>End Time:</b>
                                                        </td>
                                                        <td align="left" style="width: 79px">
                                                            <b>Rpt Time:</b>
                                                        </td>
                                                        <td align="left" style="width: 375px">
                                                            <b>Description:</b>
                                                        </td>
                                                        <td align="left">
                                                            Save
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td style="width: 77px; height: 10px;" align="left">
                                                            <b>1st Hour:</b>
                                                        </td>
                                                        <td align="left" style="height: 10px; width: 77px;">
                                                            <asp:TextBox ID="TextBox1" runat="server" ReadOnly="True" Width="65px"></asp:TextBox>
                                                        </td>
                                                        <td align="left" style="height: 10px; width: 74px;">
                                                            <asp:TextBox ID="TextBox2" runat="server" Height="16px" Width="65px" ReadOnly="True"></asp:TextBox>
                                                        </td>
                                                        <td align="left" style="height: 10px; width: 79px;">
                                                            <asp:TextBox ID="TextBox25" runat="server" Height="16px" Width="65px" ReadOnly="True"></asp:TextBox>
                                                        </td>
                                                        <td align="left" style="height: 10px; width: 375px;">
                                                            <asp:TextBox ID="txtNActivity" runat="server" Width="350px" BackColor="#CCCCCC"></asp:TextBox>
                                                        </td>
                                                        <td align="left" style="height: 10px">
                                                            <asp:Button ID="Button1" runat="server" OnClick="Button1_Click" Text="Save" />
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td style="width: 77px" align="left">
                                                            <b>2nd Hour:</b>
                                                        </td>
                                                        <td align="left" style="width: 77px">
                                                            <asp:TextBox ID="TextBox3" runat="server" ReadOnly="True" Width="65px"></asp:TextBox>
                                                        </td>
                                                        <td align="left" style="width: 74px">
                                                            <asp:TextBox ID="TextBox4" runat="server" Width="65px" ReadOnly="True"></asp:TextBox>
                                                        </td>
                                                        <td align="left" style="width: 79px">
                                                            <asp:TextBox ID="TextBox26" runat="server" Height="16px" Width="65px" ReadOnly="True"></asp:TextBox>
                                                        </td>
                                                        <td align="left" style="width: 375px">
                                                            <asp:TextBox ID="txtNActivity0" runat="server" Width="350px" BackColor="#CCCCCC"
                                                                Height="16px"></asp:TextBox>
                                                        </td>
                                                        <td align="left">
                                                            <asp:Button ID="Button2" runat="server" OnClick="Button2_Click" Text="Save" />
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td style="width: 77px" align="left">
                                                            <b>3rd Hour:</b>
                                                        </td>
                                                        <td align="left" style="width: 77px">
                                                            <asp:TextBox ID="TextBox5" runat="server" ReadOnly="True" Width="65px"></asp:TextBox>
                                                        </td>
                                                        <td align="left" style="width: 74px">
                                                            <asp:TextBox ID="TextBox6" runat="server" Width="65px" ReadOnly="True"></asp:TextBox>
                                                        </td>
                                                        <td align="left" style="width: 79px">
                                                            <asp:TextBox ID="TextBox27" runat="server" Height="16px" Width="65px" ReadOnly="True"></asp:TextBox>
                                                        </td>
                                                        <td align="left" style="width: 375px">
                                                            <asp:TextBox ID="txtNActivity1" runat="server" Width="350px" BackColor="#CCCCCC"></asp:TextBox>
                                                        </td>
                                                        <td align="left">
                                                            <asp:Button ID="Button3" runat="server" OnClick="Button3_Click" Text="Save" />
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td style="width: 77px" align="left">
                                                            <b>4th Hour:</b>
                                                        </td>
                                                        <td align="left" style="width: 77px">
                                                            <asp:TextBox ID="TextBox7" runat="server" Width="65px" ReadOnly="True"></asp:TextBox>
                                                        </td>
                                                        <td align="left" style="width: 74px">
                                                            <asp:TextBox ID="TextBox8" runat="server" Width="65px" ReadOnly="True"></asp:TextBox>
                                                        </td>
                                                        <td align="left" style="width: 79px">
                                                            <asp:TextBox ID="TextBox28" runat="server" Height="16px" Width="65px" ReadOnly="True"></asp:TextBox>
                                                        </td>
                                                        <td align="left" style="width: 375px">
                                                            <asp:TextBox ID="txtNActivity2" runat="server" Width="350px" BackColor="#CCCCCC"></asp:TextBox>
                                                        </td>
                                                        <td align="left">
                                                            <asp:Button ID="Button4" runat="server" OnClick="Button4_Click" Text="Save" />
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td style="width: 77px" align="left">
                                                            <b>5th Hour:</b>
                                                        </td>
                                                        <td align="left" style="width: 77px">
                                                            <asp:TextBox ID="TextBox9" runat="server" Width="65px" ReadOnly="True"></asp:TextBox>
                                                        </td>
                                                        <td align="left" style="width: 74px">
                                                            <asp:TextBox ID="TextBox10" runat="server" Width="65px" ReadOnly="True"></asp:TextBox>
                                                        </td>
                                                        <td align="left" style="width: 79px">
                                                            <asp:TextBox ID="TextBox29" runat="server" Height="16px" Width="65px" ReadOnly="True"></asp:TextBox>
                                                        </td>
                                                        <td align="left" style="width: 375px">
                                                            <asp:TextBox ID="txtNActivity3" runat="server" Width="350px" BackColor="#CCCCCC"></asp:TextBox>
                                                        </td>
                                                        <td align="left">
                                                            <asp:Button ID="Button5" runat="server" OnClick="Button5_Click" Text="Save" />
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td style="width: 77px" align="left">
                                                            <b>6th Hour:</b>
                                                        </td>
                                                        <td align="left" style="width: 77px">
                                                            <asp:TextBox ID="TextBox11" runat="server" Width="65px" ReadOnly="True"></asp:TextBox>
                                                        </td>
                                                        <td align="left" style="width: 74px">
                                                            <asp:TextBox ID="TextBox12" runat="server" Width="65px" ReadOnly="True"></asp:TextBox>
                                                        </td>
                                                        <td align="left" style="width: 79px">
                                                            <asp:TextBox ID="TextBox30" runat="server" Height="16px" Width="65px" ReadOnly="True"></asp:TextBox>
                                                        </td>
                                                        <td align="left" style="width: 375px">
                                                            <asp:TextBox ID="txtNActivity4" runat="server" Width="350px" BackColor="#CCCCCC"></asp:TextBox>
                                                        </td>
                                                        <td align="left">
                                                            <asp:Button ID="Button6" runat="server" OnClick="Button6_Click" Text="Save" />
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td style="width: 77px" align="left">
                                                            <b>7th Hour:</b>
                                                        </td>
                                                        <td align="left" style="width: 77px">
                                                            <asp:TextBox ID="TextBox13" runat="server" Width="65px" ReadOnly="True"></asp:TextBox>
                                                        </td>
                                                        <td align="left" style="width: 74px">
                                                            <asp:TextBox ID="TextBox14" runat="server" Width="65px" ReadOnly="True"></asp:TextBox>
                                                        </td>
                                                        <td align="left" style="width: 79px">
                                                            <asp:TextBox ID="TextBox31" runat="server" Height="16px" Width="65px" ReadOnly="True"></asp:TextBox>
                                                        </td>
                                                        <td align="left" style="width: 375px">
                                                            <asp:TextBox ID="txtNActivity5" runat="server" Width="350px" BackColor="#CCCCCC"></asp:TextBox>
                                                        </td>
                                                        <td align="left">
                                                            <asp:Button ID="Button7" runat="server" OnClick="Button7_Click" Text="Save" />
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td style="width: 77px" align="left">
                                                            <b>8th Hour:</b>
                                                        </td>
                                                        <td align="left" style="width: 77px">
                                                            <asp:TextBox ID="TextBox15" runat="server" Width="65px" ReadOnly="True"></asp:TextBox>
                                                        </td>
                                                        <td align="left" style="width: 74px">
                                                            <asp:TextBox ID="TextBox16" runat="server" Width="65px" ReadOnly="True"></asp:TextBox>
                                                        </td>
                                                        <td align="left" style="width: 79px">
                                                            <asp:TextBox ID="TextBox32" runat="server" Height="16px" Width="65px" ReadOnly="True"></asp:TextBox>
                                                        </td>
                                                        <td align="left" style="width: 375px">
                                                            <asp:TextBox ID="txtNActivity6" runat="server" Width="350px" BackColor="#CCCCCC"></asp:TextBox>
                                                        </td>
                                                        <td align="left">
                                                            <asp:Button ID="Button8" runat="server" OnClick="Button8_Click" Text="Save" />
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td style="width: 77px" align="left">
                                                            <b>9th Hour:</b>
                                                        </td>
                                                        <td align="left" style="width: 77px">
                                                            <asp:TextBox ID="TextBox17" runat="server" Width="65px" ReadOnly="True"></asp:TextBox>
                                                        </td>
                                                        <td align="left" style="width: 74px">
                                                            <asp:TextBox ID="TextBox18" runat="server" Width="65px" ReadOnly="True"></asp:TextBox>
                                                        </td>
                                                        <td align="left" style="width: 79px">
                                                            <asp:TextBox ID="TextBox33" runat="server" Height="16px" Width="65px" ReadOnly="True"></asp:TextBox>
                                                        </td>
                                                        <td align="left" style="width: 375px">
                                                            <asp:TextBox ID="txtNActivity7" runat="server" Width="350px" BackColor="#CCCCCC"></asp:TextBox>
                                                        </td>
                                                        <td align="left">
                                                            <asp:Button ID="Button9" runat="server" OnClick="Button9_Click" Text="Save" />
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td style="width: 77px" align="left">
                                                            <b>10th Hour:</b>
                                                        </td>
                                                        <td align="left" style="width: 77px">
                                                            <asp:TextBox ID="TextBox19" runat="server" Width="65px" ReadOnly="True"></asp:TextBox>
                                                        </td>
                                                        <td align="left" style="width: 74px">
                                                            <asp:TextBox ID="TextBox20" runat="server" Width="65px" ReadOnly="True"></asp:TextBox>
                                                        </td>
                                                        <td align="left" style="width: 79px">
                                                            <asp:TextBox ID="TextBox34" runat="server" Height="16px" Width="65px" ReadOnly="True"></asp:TextBox>
                                                        </td>
                                                        <td align="left" style="width: 375px">
                                                            <asp:TextBox ID="txtNActivity8" runat="server" Width="350px" BackColor="#CCCCCC"></asp:TextBox>
                                                        </td>
                                                        <td align="left">
                                                            <asp:Button ID="Button10" runat="server" OnClick="Button10_Click" Text="Save" />
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td style="width: 77px" align="left">
                                                            <b>11th Hour:</b>
                                                        </td>
                                                        <td align="left" style="width: 77px">
                                                            <asp:TextBox ID="TextBox21" runat="server" Width="65px" ReadOnly="True"></asp:TextBox>
                                                        </td>
                                                        <td align="left" style="width: 74px">
                                                            <asp:TextBox ID="TextBox22" runat="server" Width="65px" ReadOnly="True"></asp:TextBox>
                                                        </td>
                                                        <td align="left" style="width: 79px">
                                                            <asp:TextBox ID="TextBox35" runat="server" Height="16px" Width="65px" ReadOnly="True"></asp:TextBox>
                                                        </td>
                                                        <td align="left" style="width: 375px">
                                                            <asp:TextBox ID="txtNActivity9" runat="server" Width="350px" BackColor="#CCCCCC"></asp:TextBox>
                                                        </td>
                                                        <td align="left">
                                                            <asp:Button ID="Button11" runat="server" OnClick="Button11_Click" Text="Save" />
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td style="width: 77px" align="left">
                                                            <b>12th Hour:</b>
                                                        </td>
                                                        <td align="left" style="width: 77px">
                                                            <asp:TextBox ID="TextBox23" runat="server" Width="65px" ReadOnly="True"></asp:TextBox>
                                                        </td>
                                                        <td align="left" style="width: 74px">
                                                            <asp:TextBox ID="TextBox24" runat="server" Width="65px" ReadOnly="True"></asp:TextBox>
                                                        </td>
                                                        <td align="left" style="width: 79px">
                                                            <asp:TextBox ID="TextBox36" runat="server" Height="16px" Width="65px" ReadOnly="True"></asp:TextBox>
                                                        </td>
                                                        <td align="left" style="width: 375px">
                                                            <asp:TextBox ID="txtNActivity10" runat="server" Width="350px" BackColor="#CCCCCC"></asp:TextBox>
                                                        </td>
                                                        <td align="left">
                                                            <asp:Button ID="Button12" runat="server" OnClick="Button12_Click" Text="Save" />
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="left">
                                                <table style="width: 100%">
                                                    <tr>
                                                        <td style="width: 277px">
                                                            How my output was benificial to the Company!
                                                        </td>
                                                        <td>
                                                            <asp:TextBox ID="txtPerformanceRemarks" runat="server" Height="68px" TextMode="MultiLine"
                                                                Width="475px" BackColor="#CCCCCC"></asp:TextBox>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td style="width: 277px">
                                                            &nbsp;
                                                        </td>
                                                        <td>
                                                            &nbsp;
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="left">
                                                If there is no Task Assigned/Pending Work For you, Have You asked/contacted your
                                                Higher-ups to assign you the Task?<br />
                                                <asp:CheckBox ID="CBoxAskForWorkYes" runat="server" AutoPostBack="True" Text="Yes"
                                                    OnCheckedChanged="CBoxAskForWorkYes_CheckedChanged" />
                                                <br />
                                                <asp:CheckBox ID="CBoxAskForWorkNo" runat="server" AutoPostBack="True" Text="No"
                                                    OnCheckedChanged="CBoxAskForWorkNo_CheckedChanged" />
                                                -
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="left">
                                                <span style="color: rgb(51, 51, 255);">I have Checked my Tasks Inbox and Confirmed that
                                                    there are no unchecked Tasks Assigned to me for today : </span>
                                                <asp:CheckBox ID="cboxAgree" runat="server" Text="I Agree" Font-Bold="True" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="left">
                                                &nbsp;&nbsp;
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="left">
                                                My Today&#39;s Time-Out from the Office&nbsp;:&nbsp;&nbsp;
                                                <asp:DropDownList ID="ddlHourOut" runat="server" Width="53px" BackColor="#CCCCCC"
                                                    AutoPostBack="True" OnSelectedIndexChanged="ddlHourOut_SelectedIndexChanged">
                                                    <asp:ListItem>Hour</asp:ListItem>
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
                                                &nbsp;<asp:DropDownList ID="ddlMinOut" runat="server" Width="64px" BackColor="#CCCCCC"
                                                    AutoPostBack="True" OnSelectedIndexChanged="ddlMinOut_SelectedIndexChanged">
                                                    <asp:ListItem>Minute</asp:ListItem>
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
                                            <td align="left">
                                                &nbsp;
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="text-align: left">
                                                <asp:Label ID="lblMessage" runat="server"></asp:Label>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:Button ID="btnSave" runat="server" BackColor="#ABD3FC" Text="Send Final Report"
                                                    OnClick="btnCheckOut_Click" Width="161px" Font-Bold="True" ForeColor="#006699"
                                                    Height="42px" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                &nbsp;
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <div id="DivTodaysActivities" runat="server">
                                                    <asp:GridView ID="GridTodayActivities" runat="server" AutoGenerateColumns="False"
                                                        CellPadding="4" ForeColor="#333333" GridLines="None" Width="762px">
                                                        <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
                                                        <Columns>
                                                            <asp:TemplateField HeaderText="Task">
                                                                <ItemTemplate>
                                                                    <asp:Label ID="lblTask" runat="server" Text='<%#Eval("") %>'></asp:Label>
                                                                </ItemTemplate>
                                                            </asp:TemplateField>
                                                            <asp:TemplateField HeaderText="Task Status">
                                                                <ItemTemplate>
                                                                    <asp:Label ID="lblTask" runat="server" Text='<%#Eval("") %>'></asp:Label>
                                                                </ItemTemplate>
                                                            </asp:TemplateField>
                                                            <asp:TemplateField HeaderText="Time In">
                                                                <ItemTemplate>
                                                                    <asp:Label ID="lblTask" runat="server" Text='<%#Eval("") %>'></asp:Label>
                                                                </ItemTemplate>
                                                            </asp:TemplateField>
                                                            <asp:TemplateField HeaderText="Time Out">
                                                                <ItemTemplate>
                                                                    <asp:Label ID="lblTask" runat="server" Text='<%#Eval("") %>'></asp:Label>
                                                                </ItemTemplate>
                                                            </asp:TemplateField>
                                                        </Columns>
                                                        <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                                                        <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
                                                        <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
                                                        <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                                                        <EditRowStyle BackColor="#999999" />
                                                        <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                                                    </asp:GridView>
                                                </div>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                        </table>
                    </div>
                </div>
            </td>
        </tr>
    </table>
    <%--<script type="text/javascript">
    function onUncheked()
    {
        document.getElementById("<=#cboxPendingTaslk>");
    }
    </script>--%>
</asp:Content>

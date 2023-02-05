using System;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Xml.Linq;
using Sales_BOL;
using System.Web.Mail;

public partial class MCTX_Internal_SuperAdmin_DailyOutput : System.Web.UI.Page
{
    #region Variables
    _DailyOutput objDO = new _DailyOutput();
    int hourflag = 0;

    #endregion

    #region Methods
    public void GetEmpName()
    {
        DataTable dt_Name = objDO.fnGetEmpName((string)Session["Username"]);
        lblEmpName.Text = dt_Name.Rows[0]["E_Name"].ToString();
        lblEmpName.ForeColor = System.Drawing.Color.Magenta;
    }
    public int Validate(string TimeIn, string TimeOut, string IsPendingTask, string requiredTime, string pendingActivityDesc, string TimeStartP, string TimeEndP, string PendingTaskRemarks, string NewActivity, string TimeStartN, string TimeEndN, string RemarksNew, string MyPerformance, string AskToSenior)
    {
        if (TimeIn != "")
        {
            if (TimeOut != "")
            {
                if (IsPendingTask != "")
                {
                    if (requiredTime != "")
                    {
                        if (pendingActivityDesc != "")
                        {
                            if (TimeStartP != "")
                            {
                                if (TimeEndP != "")
                                {
                                    if (PendingTaskRemarks != "")
                                    {
                                        if (NewActivity != "")
                                        {
                                            if (TimeStartN != "")
                                            {
                                                if (TimeEndN != "")
                                                {
                                                    if (RemarksNew != "")
                                                    {
                                                        if (MyPerformance != "")
                                                        {
                                                            if (AskToSenior != "")
                                                            {
                                                                return 1;
                                                            }
                                                            lblMessage.Text = "Check That Wether You Ask You Senior For Task";
                                                            lblMessage.ForeColor = System.Drawing.Color.Red;
                                                            return 0;
                                                        }
                                                        lblMessage.Text = "Please Tell that How Company is benifiting From You Performance";
                                                        lblMessage.ForeColor = System.Drawing.Color.Red;
                                                        return 0;
                                                    }
                                                    lblMessage.Text = "Enter The Remarks For Todays Tasks";
                                                    lblMessage.ForeColor = System.Drawing.Color.Red;
                                                    return 0;
                                                }
                                                lblMessage.Text = "Enter The Correct Ending Time for New Task";
                                                lblMessage.ForeColor = System.Drawing.Color.Red;
                                                return 0;
                                            }
                                            lblMessage.Text = "Enter The Correct Start Time For New Task";
                                            lblMessage.ForeColor = System.Drawing.Color.Red;
                                            return 0;
                                        }
                                        lblMessage.Text = "Enter The Today's Activity Description";
                                        lblMessage.ForeColor = System.Drawing.Color.Red;
                                        return 0;
                                    }
                                    lblMessage.Text = "Enter The Pending Task Remarks";
                                    lblMessage.ForeColor = System.Drawing.Color.Red;
                                    return 0;
                                }
                                lblMessage.Text = "Enter The Correct Ending Time For Pending Task";
                                lblMessage.ForeColor = System.Drawing.Color.Red;
                                return 0;
                            }
                            lblMessage.Text = "Enter The Correct Starting Time For Pending Task";
                            lblMessage.ForeColor = System.Drawing.Color.Red;
                            return 0;
                        }
                        lblMessage.Text = "Enter The Pending Activities Description";
                        lblMessage.ForeColor = System.Drawing.Color.Red;
                        return 0;
                    }
                    lblMessage.Text = "Enter The Time Required For Pending Tasks";
                    lblMessage.ForeColor = System.Drawing.Color.Red;
                    return 0;
                }
                lblMessage.Text = "Check For Any Pendng Tasks";
                lblMessage.ForeColor = System.Drawing.Color.Red;
                return 0;
            }
            lblMessage.Text = "Enter The Correct Time-Out";
            lblMessage.ForeColor = System.Drawing.Color.Red;
            return 0;
        }
        lblMessage.Text = "Enter The Correct Time-In";
        lblMessage.ForeColor = System.Drawing.Color.Red;
        return 0;
    }
    #endregion

    #region Events
    protected void Page_Load(object sender, EventArgs e)
    {

        
        
        try
        {
            if (!IsPostBack)
            {
                GetEmpName();
                GetReportTimeinFields();
                GetReportOfUser();
            }
        }
        catch (Exception ex)
        {

        }
    }
    public void GetReportOfUser()
    {
        try
        {

            DataTable dtReportId = new DataTable();
            dtReportId = objDO.ReturnTodayReport(Session["UserName"].ToString());
            ReportId.Text = dtReportId.Rows[0]["DailyReport_ID"].ToString();
            TimeIn.Text = dtReportId.Rows[0]["Time-In"].ToString();

            string[] str = TimeIn.Text.Split(' ');
            string time = str[1].ToString();

            string[] TimePart = time.Split(':');

            if (TimePart[0].Length < 2)
            {
                ddlHour.Text = "0" + TimePart[0].ToString();
            }
            else
            {
                ddlHour.Text = TimePart[0].ToString(); ;
            }


            if (TimePart[1].Length < 2)
            {
                ddlMinutes.Text = "0" + TimePart[1].ToString();
            }
            else
            {
                ddlMinutes.Text = TimePart[1].ToString(); ;
            }

            InsertTimeinTextBox(ddlHour.Text, ddlMinutes.Text, "", "");

            DataTable dt_RPTDetails = new DataTable();
            dt_RPTDetails = objDO.ReturnTodayDetailReport(ReportId.Text);

            try
            {
                TextBox1.Text = dt_RPTDetails.Rows[0]["fromTime"].ToString();
                TextBox2.Text = dt_RPTDetails.Rows[0]["toTime"].ToString();
                TextBox25.Text = dt_RPTDetails.Rows[0]["rptTime"].ToString();
                txtNActivity.Text = dt_RPTDetails.Rows[0]["TaskDetails"].ToString();
                hourflag = int.Parse(dt_RPTDetails.Rows[0]["hourNo"].ToString());
                //txtNActivity.ReadOnly = true;

                TextBox3.Text = dt_RPTDetails.Rows[1]["fromTime"].ToString();
                TextBox4.Text = dt_RPTDetails.Rows[1]["toTime"].ToString();
                TextBox26.Text = dt_RPTDetails.Rows[1]["rptTime"].ToString();
                txtNActivity0.Text = dt_RPTDetails.Rows[1]["TaskDetails"].ToString();
                hourflag = int.Parse(dt_RPTDetails.Rows[1]["hourNo"].ToString());
                //txtNActivity0.ReadOnly = true;

                TextBox5.Text = dt_RPTDetails.Rows[2]["fromTime"].ToString();
                TextBox6.Text = dt_RPTDetails.Rows[2]["toTime"].ToString();
                TextBox27.Text = dt_RPTDetails.Rows[2]["rptTime"].ToString();
                txtNActivity1.Text = dt_RPTDetails.Rows[2]["TaskDetails"].ToString();
                hourflag = int.Parse(dt_RPTDetails.Rows[2]["hourNo"].ToString());
                //txtNActivity1.ReadOnly = true;

                TextBox7.Text = dt_RPTDetails.Rows[3]["fromTime"].ToString();
                TextBox8.Text = dt_RPTDetails.Rows[3]["toTime"].ToString();
                TextBox28.Text = dt_RPTDetails.Rows[3]["rptTime"].ToString();
                txtNActivity2.Text = dt_RPTDetails.Rows[3]["TaskDetails"].ToString();
                hourflag = int.Parse(dt_RPTDetails.Rows[3]["hourNo"].ToString());
                //txtNActivity2.ReadOnly = true;

                TextBox9.Text = dt_RPTDetails.Rows[4]["fromTime"].ToString();
                TextBox10.Text = dt_RPTDetails.Rows[4]["toTime"].ToString();
                TextBox29.Text = dt_RPTDetails.Rows[4]["rptTime"].ToString();
                txtNActivity3.Text = dt_RPTDetails.Rows[4]["TaskDetails"].ToString();
                hourflag = int.Parse(dt_RPTDetails.Rows[4]["hourNo"].ToString());
                //txtNActivity3.ReadOnly = true;

                TextBox11.Text = dt_RPTDetails.Rows[5]["fromTime"].ToString();
                TextBox12.Text = dt_RPTDetails.Rows[5]["toTime"].ToString();
                TextBox29.Text = dt_RPTDetails.Rows[5]["rptTime"].ToString();
                txtNActivity4.Text = dt_RPTDetails.Rows[5]["TaskDetails"].ToString();
                hourflag = int.Parse(dt_RPTDetails.Rows[5]["hourNo"].ToString());
                //txtNActivity4.ReadOnly = true;


                TextBox13.Text = dt_RPTDetails.Rows[6]["fromTime"].ToString();
                TextBox14.Text = dt_RPTDetails.Rows[6]["toTime"].ToString();
                TextBox30.Text = dt_RPTDetails.Rows[6]["rptTime"].ToString();
                txtNActivity5.Text = dt_RPTDetails.Rows[6]["TaskDetails"].ToString();
                hourflag = int.Parse(dt_RPTDetails.Rows[6]["hourNo"].ToString());
                //txtNActivity5.ReadOnly = true;

                TextBox15.Text = dt_RPTDetails.Rows[7]["fromTime"].ToString();
                TextBox16.Text = dt_RPTDetails.Rows[7]["toTime"].ToString();
                TextBox31.Text = dt_RPTDetails.Rows[7]["rptTime"].ToString();
                txtNActivity6.Text = dt_RPTDetails.Rows[7]["TaskDetails"].ToString();
                hourflag = int.Parse(dt_RPTDetails.Rows[7]["hourNo"].ToString());
                //txtNActivity6.ReadOnly = true;

                TextBox17.Text = dt_RPTDetails.Rows[8]["fromTime"].ToString();
                TextBox18.Text = dt_RPTDetails.Rows[8]["toTime"].ToString();
                TextBox32.Text = dt_RPTDetails.Rows[8]["rptTime"].ToString();
                txtNActivity7.Text = dt_RPTDetails.Rows[8]["TaskDetails"].ToString();
                hourflag = int.Parse(dt_RPTDetails.Rows[8]["hourNo"].ToString());
                //txtNActivity7.ReadOnly = true;

                TextBox19.Text = dt_RPTDetails.Rows[9]["fromTime"].ToString();
                TextBox20.Text = dt_RPTDetails.Rows[9]["toTime"].ToString();
                TextBox32.Text = dt_RPTDetails.Rows[9]["rptTime"].ToString();
                txtNActivity8.Text = dt_RPTDetails.Rows[9]["TaskDetails"].ToString();
                hourflag = int.Parse(dt_RPTDetails.Rows[9]["hourNo"].ToString());
                //txtNActivity8.ReadOnly = true;

                TextBox21.Text = dt_RPTDetails.Rows[10]["fromTime"].ToString();
                TextBox22.Text = dt_RPTDetails.Rows[10]["toTime"].ToString();
                TextBox33.Text = dt_RPTDetails.Rows[10]["rptTime"].ToString();
                txtNActivity9.Text = dt_RPTDetails.Rows[10]["TaskDetails"].ToString();
                hourflag = int.Parse(dt_RPTDetails.Rows[10]["hourNo"].ToString());
                //txtNActivity9.ReadOnly = true;

                TextBox23.Text = dt_RPTDetails.Rows[11]["fromTime"].ToString();
                TextBox24.Text = dt_RPTDetails.Rows[11]["toTime"].ToString();
                TextBox34.Text = dt_RPTDetails.Rows[11]["rptTime"].ToString();
                txtNActivity10.Text = dt_RPTDetails.Rows[11]["TaskDetails"].ToString();
                hourflag = int.Parse(dt_RPTDetails.Rows[11]["hourNo"].ToString());
                //txtNActivity10.ReadOnly = true;
                            
            }
            catch (Exception ex)
            {
                
                //throw;
            }
            




        }
        catch (Exception ex)
        {

            //throw;
        }


    }

    public void GetReportTimeinFields()
    {

        try
        {
            if (TextBox25.Text == "")
            {
                TextBox25.Text = DateTime.Now.Hour.ToString() + ":" + DateTime.Now.Minute.ToString();
            }
            if (TextBox26.Text == "")
            {
                TextBox26.Text = DateTime.Now.Hour.ToString() + ":" + DateTime.Now.Minute.ToString();
            }
            if (TextBox27.Text == "")
            {
                TextBox27.Text = DateTime.Now.Hour.ToString() + ":" + DateTime.Now.Minute.ToString();
            }
            if (TextBox28.Text == "")
            {
                TextBox28.Text = DateTime.Now.Hour.ToString() + ":" + DateTime.Now.Minute.ToString();
            }
            if (TextBox29.Text == "")
            {
                TextBox29.Text = DateTime.Now.Hour.ToString() + ":" + DateTime.Now.Minute.ToString();
            }
            if (TextBox30.Text == "")
            {
                TextBox30.Text = DateTime.Now.Hour.ToString() + ":" + DateTime.Now.Minute.ToString();
            }
            if (TextBox31.Text == "")
            {
                TextBox31.Text = DateTime.Now.Hour.ToString() + ":" + DateTime.Now.Minute.ToString();
            }
            if (TextBox32.Text == "")
            {
                TextBox32.Text = DateTime.Now.Hour.ToString() + ":" + DateTime.Now.Minute.ToString();
            }
            if (TextBox33.Text == "")
            {
                TextBox33.Text = DateTime.Now.Hour.ToString() + ":" + DateTime.Now.Minute.ToString();
            }
            if (TextBox34.Text == "")
            {
                TextBox34.Text = DateTime.Now.Hour.ToString() + ":" + DateTime.Now.Minute.ToString();
            }
            if (TextBox35.Text == "")
            {
                TextBox35.Text = DateTime.Now.Hour.ToString() + ":" + DateTime.Now.Minute.ToString();
            }
            if (TextBox36.Text == "")
            {
                TextBox36.Text = DateTime.Now.Hour.ToString() + ":" + DateTime.Now.Minute.ToString();
            }

        }
        catch (Exception ex)
        {

            //throw;
        }


    }
    protected void btnCheckOut_Click(object sender, EventArgs e)
    {


        string IsPendingTask = "";
        string AskToSenior = "";
        string TimeStartP = "";
        string TimeEndP = "";
        string PendingTaskRemarks = "";
        // Time-In //
        string hourIn = ddlHour.SelectedItem.Text;
        string MinuteIn = ddlMinutes.SelectedItem.Text;

        if (txtPerformanceRemarks.Text == "")
        {
            lblMessage.Text = "Please write down the benefit to Mechatronix by your today's working";
            lblMessage.ForeColor = System.Drawing.Color.Red;
            return;
        }


        if (hourIn == "Hour" || MinuteIn == "Minute")
        {
            lblMessage.Text = "Time-in is not in correct format";
            lblMessage.ForeColor = System.Drawing.Color.Red;
            return;
        }



        //string ModeIn = ddlMode.SelectedItem.Text;
        // Making Time-In from above variables
        // = hourIn + ":" + MinuteIn + " " + ModeIn;

        DateTime dt_time_in = new DateTime(DateTime.Now.Year, DateTime.Now.Month, DateTime.Now.Day, int.Parse(hourIn), int.Parse(MinuteIn), 00);
        string TimeIn = dt_time_in.ToString();
        //-----------------------------------------------------
        // Time-Out //
        string hourOut = ddlHourOut.SelectedItem.Text;
        string MinuteOut = ddlMinOut.SelectedItem.Text;



        if (hourOut == "Hour" || MinuteOut == "Minute")
        {
            lblMessage.Text = "Time-Out is not in correct format";
            lblMessage.ForeColor = System.Drawing.Color.Red;
            return;

        }

        if (int.Parse(hourOut) < int.Parse(hourIn))
        {
            lblMessage.Text = "Time-Out is not in correct format";
            lblMessage.ForeColor = System.Drawing.Color.Red;
            return;

        }

        //string ModeOut = ddlModeOut.SelectedItem.Text;
        // Making Time-Out from above variables
        DateTime dt_time_out = new DateTime(DateTime.Now.Year, DateTime.Now.Month, DateTime.Now.Day, int.Parse(hourOut), int.Parse(MinuteOut), 00);
        string TimeOut = dt_time_out.ToString();
        //-----------------------------------------------------
        //if (CBoxPTaskYes.Checked == true)
        //{
        //    IsPendingTask = CBoxPTaskYes.Text;
        //}
        //else
        //{
        //    IsPendingTask = CBoxPTaskNo.Text;
        //}
        //string requiredTime = txtTimeRequired.Text+" "+ddlTimeRequired.SelectedValue;
        // string pendingActivityDesc = txtPAvtivity.Text;
        // Making Time-Start Pending Task
        //if (CBoxPTaskYes.Checked == true)
        //{
        //    string hourStartP = ddlStarHour.SelectedItem.Text;
        //    string MinuteStartP = ddlStartMin.SelectedItem.Text;
        //    string ModeStartP = ddlStartMode.SelectedItem.Text;
        //    // Making Time-Start from above variables
        //    TimeStartP = hourStartP + ":" + MinuteStartP + " " + ModeStartP;
        //    //----------------------------------------------------------------
        //    // Making Time-End Pending Task
        //    string hourEndP = ddlEndHour.SelectedItem.Text;
        //    string MinuteEndP = ddlEndMin.SelectedItem.Text;
        //    string ModeEndP = ddlEndMode.SelectedItem.Text;
        //    // Making Time-In from above variables
        //    TimeEndP = hourEndP + ":" + MinuteEndP + " " + ModeEndP;
        //    //----------------------------------------------------------------
        //    PendingTaskRemarks = txtPRemarks.Text;
        //}
        //else
        //{
        //    string hourStartP = ddlStarHour.SelectedItem.Text;
        //    string MinuteStartP = ddlStartMin.SelectedItem.Text;
        //    string ModeStartP = ddlStartMode.SelectedItem.Text;
        //    // Making Time-Start from above variables
        //    TimeStartP = hourStartP + ":" + MinuteStartP + " " + ModeStartP;
        //    //----------------------------------------------------------------
        //    // Making Time-End Pending Task
        //    string hourEndP = ddlEndHour.SelectedItem.Text;
        //    string MinuteEndP = ddlEndMin.SelectedItem.Text;
        //    string ModeEndP = ddlEndMode.SelectedItem.Text;
        //    // Making Time-In from above variables
        //    TimeEndP = hourEndP + ":" + MinuteEndP + " " + ModeEndP;
        //    //----------------------------------------------------------------
        //    PendingTaskRemarks = txtPRemarks.Text;
        //}





        // Making Time-Start New Task
        //string hourStartN = ddlStartHourN.SelectedItem.Text;
        //string MinuteStartN = ddlStartMinN.SelectedItem.Text;
        //string ModeStartN = ddlStartModeN.SelectedItem.Text;
        // Making Time-Start from above variables
        //DateTime WorkStart_Time = new DateTime(DateTime.Now.Year, DateTime.Now.Month, DateTime.Now.Day, int.Parse(hourStartN), int.Parse(MinuteStartN), 00);

        //string TimeStartN = WorkStart_Time.ToString(); 
        //string TimeStartN = hourStartN + ":" + MinuteStartN + " " + ModeStartN;
        //----------------------------------------------------------------
        // Making Time-End New Task
        //string hourEndN = ddlEndHourN.SelectedItem.Text;
        //string MinuteEndN = ddlEndMinN.SelectedItem.Text;
        //string ModeEndN = ddlEndModeN.SelectedItem.Text;
        // Making Time-In from above variables
        //DateTime WorkEnd_Time = new DateTime(DateTime.Now.Year, DateTime.Now.Month, DateTime.Now.Day, int.Parse(hourStartN), int.Parse(MinuteStartN), 00);
        //string TimeEndN = WorkStart_Time.ToString(); 
        //string TimeEndN = hourEndN + ":" + MinuteEndN + " " + ModeEndN;
        //----------------------------------------------------------------
        string RemarksNew = txtNActivity.Text;
        string MyPerformance = txtPerformanceRemarks.Text;
        if (CBoxAskForWorkYes.Checked == true)
        {
            AskToSenior = CBoxAskForWorkYes.Text;
        }
        else
        {
            AskToSenior = CBoxAskForWorkNo.Text;
        }
        //----------------------------------------------------------------
        // Inserting User Daily Register Entry
        if (cboxAgree.Checked)
        {
            //int result = Validate(TimeIn, TimeOut, IsPendingTask, requiredTime, pendingActivityDesc, TimeStartP, TimeEndP, PendingTaskRemarks, NewActivity, TimeStartN, TimeEndN, RemarksNew, MyPerformance, AskToSenior);
            int status = objDO.fnAddDailyOutputFinal(TimeOut, ReportId.Text, MyPerformance, AskToSenior);
            if (status == 1)
            {
                lblMessage.Text = "Daily OutPut Completed Successfuly";
                lblMessage.ForeColor = System.Drawing.Color.Green;
                sendemail(TimeIn, TimeOut, MyPerformance, AskToSenior);
            }
            else
            {
                lblMessage.Text = "Daily OutPut Not completed Successfully";
                lblMessage.ForeColor = System.Drawing.Color.Red;
            }
        }
        else
        {
            lblMessage.Text = "Please Check The Agreement";
            lblMessage.ForeColor = System.Drawing.Color.Red;
        }
    }
    //protected void CBoxPTaskYes_CheckedChanged(object sender, EventArgs e)
    //{
    //    if (CBoxPTaskNo.Checked == true)
    //    {
    //        CBoxPTaskNo.Checked = false;
    //    }
    //    //pendingwork.Visible = true;
    //    pendingwork1.Visible = true;
    //    PendingWork2.Visible = true;
    //}
    //protected void CBoxPTaskNo_CheckedChanged(object sender, EventArgs e)
    //{
    //    if (CBoxPTaskYes.Checked == true)
    //    {
    //        CBoxPTaskYes.Checked = false;
    //    }
    //    //pendingwork.Visible = false;
    //    pendingwork1.Visible = false;
    //    PendingWork2.Visible = false;
    //}
    protected void CBoxAskForWorkYes_CheckedChanged(object sender, EventArgs e)
    {
        if (CBoxAskForWorkNo.Checked == true)
        {
            CBoxAskForWorkNo.Checked = false;
        }
    }
    protected void CBoxAskForWorkNo_CheckedChanged(object sender, EventArgs e)
    {
        if (CBoxAskForWorkYes.Checked == true)
        {
            CBoxAskForWorkYes.Checked = false;
        }
    }
    #endregion

    public void sendemail(string TimeIn, string TimeOut, string MyPerformance, string AskToSenior)
    {
        try
        {

            DateTime dattime = DateTime.Now;
            string dateandtime = dattime.ToLongDateString() + "  " + dattime.ToLongTimeString();
            MailMessage sms = new MailMessage();
            sms.To = "ceo@mechatronix.com.pk";
            sms.From = "info@mechatronix.com.pk";
            sms.Cc = "khalidrafique@mechatronix.com.pk";
            sms.Subject = Session["UserFullName"].ToString() + " - Report Added!";
            sms.BodyFormat = MailFormat.Html;
            sms.Body = "<table style='width:800px'>" +
                       "<tr>" +
                       "<td style='font-weight: bold; font-family: Verdana; font-size: small; background-color: #006699; color: #FFFFFF;'> MCTX Report details:</td>" +
                       "</tr>" +
                       "<tr>" +
                       "<td>" +
                       "<p> This is System Generated Email Please don not Reply!</p></td>" +
                       "</tr>" +
                       "<tr>" +
                       "<td style='background-color: #006699; color: #FFFFFF;'>" +
                            "<table style='width:100%'> " +
                            "<tr>" +
                            "<td style='width:100px; font-family:Verdana; color: #FFFFFF; font-size:small'>Report Date:</td><td style='font-family:Verdana; color: #FFFFFF; font-size:small'>" + dateandtime + " </td>" +
                            "</tr>" +
                            "<tr>" +
                            "<td style='width:100px; font-family:Verdana; color: #FFFFFF; font-size:small'>Reported By:</td><td style='font-family:Verdana; color: #FFFFFF; font-size:small'>" + Session["UserFullName"].ToString() + " </td>" +
                            "</tr>" +
                            "<tr>" +
                            "<td style='width:100px; font-family:Verdana; color: #FFFFFF; font-size:small'>Check In Time: </td><td style='font-family:Verdana; color: #FFFFFF; font-size:small'>" + TimeIn + " </td>" +
                            "</tr>" +
                            "<tr>" +
                            "<td style='width:100px; font-family:Verdana; color: #FFFFFF; font-size:small'>Check Out Time: </td><td style='font-family:Verdana; color: #FFFFFF; font-size:small'>" + TimeOut + " </td>" +
                            "</tr>" +
                            "</table>" +
                       "</td>" +
                       "</tr>" +
                       "<tr>" +
                       "<td>" +
                            "<table border='1' align='left' width='100%'>" +
                            "<tr>" +
                                "<td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td>" +
                            "</tr>" +
                            "<tr>" +
                                "<td style='background-color: #B8DBFF'>Hour</td><td style='background-color: #B8DBFF'>From Time</td><td style='background-color: #B8DBFF'>To Time</td><td style='background-color: #B8DBFF'>Report Time</td><td style='background-color: #B8DBFF'>Activity</td>" +
                            "</tr>" +
                            "<tr>" +
                                "<td>1</td><td>" + TextBox1.Text + "</td><td>" + TextBox2.Text + "</td><td>" + TextBox25.Text + "</td><td>" + txtNActivity.Text + "</td>" +
                            "</tr>" +
                            "<tr>" +
                                "<td>1</td><td>" + TextBox3.Text + "</td><td>" + TextBox4.Text + "</td><td>" + TextBox26.Text + "</td><td>" + txtNActivity0.Text + "</td>" +
                            "</tr>" +
                            "<tr>" +
                                "<td>1</td><td>" + TextBox5.Text + "</td><td>" + TextBox6.Text + "</td><td>" + TextBox27.Text + "</td><td>" + txtNActivity1.Text + "</td>" +
                            "</tr>" +
                            "<tr>" +
                                "<td>1</td><td>" + TextBox7.Text + "</td><td>" + TextBox8.Text + "</td><td>" + TextBox28.Text + "</td><td>" + txtNActivity2.Text + "</td>" +
                            "</tr>" +
                            "<tr>" +
                                "<td>1</td><td>" + TextBox9.Text + "</td><td>" + TextBox10.Text + "</td><td>" + TextBox29.Text + "</td><td>" + txtNActivity3.Text + "</td>" +
                            "</tr>" +
                            "<tr>" +
                                "<td>1</td><td>" + TextBox11.Text + "</td><td>" + TextBox12.Text + "</td><td>" + TextBox30.Text + "</td><td>" + txtNActivity4.Text + "</td>" +
                            "</tr>" +
                            "<tr>" +
                                "<td>1</td><td>" + TextBox13.Text + "</td><td>" + TextBox14.Text + "</td><td>" + TextBox31.Text + "</td><td>" + txtNActivity5.Text + "</td>" +
                            "</tr>" +
                            "<tr>" +
                                "<td>1</td><td>" + TextBox15.Text + "</td><td>" + TextBox16.Text + "</td><td>" + TextBox32.Text + "</td><td>" + txtNActivity6.Text + "</td>" +
                            "</tr>" +
                            "<tr>" +
                                "<td>1</td><td>" + TextBox17.Text + "</td><td>" + TextBox18.Text + "</td><td>" + TextBox33.Text + "</td><td>" + txtNActivity7.Text + "</td>" +
                            "</tr>" +
                            "<tr>" +
                                "<td>1</td><td>" + TextBox19.Text + "</td><td>" + TextBox20.Text + "</td><td>" + TextBox34.Text + "</td><td>" + txtNActivity8.Text + "</td>" +
                            "</tr>" +
                            "<tr>" +
                                "<td>1</td><td>" + TextBox21.Text + "</td><td>" + TextBox22.Text + "</td><td>" + TextBox35.Text + "</td><td>" + txtNActivity9.Text + "</td>" +
                            "</tr>" +
                            "<tr>" +
                                "<td>1</td><td>" + TextBox23.Text + "</td><td>" + TextBox24.Text + "</td><td>" + TextBox36.Text + "</td><td>" + txtNActivity10.Text + "</td>" +
                            "</tr>" +

                            "</table>" +

                       "</td>" +
                       "</tr>" +
                       "<tr>" +
                       "<td>My Out Benefit >>  " + MyPerformance + "</td>" +
                       "</tr>" +
                       "</table>";
                       

            //sms.Body = "MCTX Report details .... " + Environment.NewLine + Environment.NewLine +
            //           "This is System Generated Email Please don not Reply!" + Environment.NewLine + Environment.NewLine +
            //           "Report Date                             " + dateandtime + Environment.NewLine +
            //           "Reported By                             " + Session["UserFullName"].ToString() + Environment.NewLine +
            //           "Check In Time                           " + TimeIn + Environment.NewLine +
            //           "Check Out Time                          " + TimeOut + Environment.NewLine +
            //           "-------------------------------------------------------------------" + Environment.NewLine +
            //           "<table><tr>" +
            //           "<td>Hour No</td><td>Time-From</td><td>Time To</td><td>Rpt Time</td><td>Description</td>" +
            //           "<td>1</td><td>" + TextBox1.Text + "</td><td>" + TextBox2.Text + "</td><td>" + TextBox25.Text + "</td><td>" + txtNActivity.Text + "</td>" +
            //           "<td>2</td><td>" + TextBox3.Text + "</td><td>" + TextBox4.Text + "</td><td>" + TextBox26.Text + "</td><td>" + txtNActivity0.Text + "</td>" +
            //           "<td>3</td><td>" + TextBox5.Text + "</td><td>" + TextBox6.Text + "</td><td>" + TextBox27.Text + "</td><td>" + txtNActivity1.Text + "</td>" +
            //           "<td>3</td><td>" + TextBox7.Text + "</td><td>" + TextBox8.Text + "</td><td>" + TextBox28.Text + "</td><td>" + txtNActivity2.Text + "</td>" +
            //           "<td>3</td><td>" + TextBox9.Text + "</td><td>" + TextBox10.Text + "</td><td>" + TextBox29.Text + "</td><td>" + txtNActivity3.Text + "</td>" +
            //           "<td>3</td><td>" + TextBox11.Text + "</td><td>" + TextBox12.Text + "</td><td>" + TextBox30.Text + "</td><td>" + txtNActivity4.Text + "</td>" +
            //           "<td>3</td><td>" + TextBox13.Text + "</td><td>" + TextBox14.Text + "</td><td>" + TextBox31.Text + "</td><td>" + txtNActivity5.Text + "</td>" +
            //           "<td>3</td><td>" + TextBox15.Text + "</td><td>" + TextBox16.Text + "</td><td>" + TextBox32.Text + "</td><td>" + txtNActivity6.Text + "</td>" +
            //           "<td>3</td><td>" + TextBox17.Text + "</td><td>" + TextBox18.Text + "</td><td>" + TextBox33.Text + "</td><td>" + txtNActivity7.Text + "</td>" +
            //           "<td>3</td><td>" + TextBox19.Text + "</td><td>" + TextBox20.Text + "</td><td>" + TextBox34.Text + "</td><td>" + txtNActivity8.Text + "</td>" +
            //           "<td>3</td><td>" + TextBox21.Text + "</td><td>" + TextBox22.Text + "</td><td>" + TextBox35.Text + "</td><td>" + txtNActivity9.Text + "</td>" +
            //           "<td>3</td><td>" + TextBox23.Text + "</td><td>" + TextBox24.Text + "</td><td>" + TextBox36.Text + "</td><td>" + txtNActivity10.Text + "</td>" +
            //           "<tr></table>" +
            //           "------------------------------------------------------------------" + Environment.NewLine +
            //           "My Out Benefit      :       " + Environment.NewLine +
            //           "------------------------------------------------------------------" + Environment.NewLine +
            //           " " + MyPerformance + "" + Environment.NewLine + Environment.NewLine +
            //           "This is System Generated Email Please do not Reply!";
            

            SmtpMail.SmtpServer = "mail.mechatronix.com.pk";
            SmtpMail.Send(sms);
            //lblmsg.Text = " + E-Mail Sent....";

        }
        catch (Exception ex)
        {
            //lblmsg.Text = " + " + ex.Message.ToString();
        }

    }



    protected void ddlHour_SelectedIndexChanged(object sender, EventArgs e)
    {

        InsertTimeinTextBox(ddlHour.SelectedItem.ToString(), ddlMinutes.SelectedItem.ToString(), ddlHourOut.SelectedItem.Text, ddlMinOut.SelectedItem.Text);

    }

    public void InsertTimeinTextBox(string startHr, string startMin, string EndHr, string EndMin)
    {

        if (startHr == "Hour" || startMin == "Minute")
        {
            lblMessage.Text = "start time is not correct";
            lblMessage.ForeColor = System.Drawing.Color.Red;
            return;
        }
        //else if (int.Parse(startHr) > int.Parse(EndHr))
        //{
        //    lblMessage.Text = "Start time should be less then end time";
        //    lblMessage.ForeColor = System.Drawing.Color.Red;
        //}

        else
        {

            lblMessage.Text = "";
            clear_textboxs();
            TextBox1.Text = int.Parse(startHr) + " : " + startMin;

            if (int.Parse(startHr) + 1 < 24) TextBox2.Text = int.Parse(startHr) + 1 + " : " + startMin;
            else
            { TextBox2.Text = "23 : 59"; return; };
            if (int.Parse(startHr) + 1 < 24) TextBox3.Text = int.Parse(startHr) + 1 + " : " + startMin;
            if (int.Parse(startHr) + 2 < 24) TextBox4.Text = int.Parse(startHr) + 2 + " : " + startMin;
            else
            { TextBox4.Text = "23 : 59"; return; };
            //if (int.Parse(startHr) + 2 > int.Parse(EndHr)) { TextBox4.Text = int.Parse(EndHr) + " : " + EndMin; return; } else TextBox4.Text = int.Parse(startHr) + 2 + " : " + startMin;
            if (int.Parse(startHr) + 2 < 24) TextBox5.Text = int.Parse(startHr) + 2 + " : " + startMin; else TextBox5.Text = "";
            if (int.Parse(startHr) + 3 < 24) TextBox6.Text = int.Parse(startHr) + 3 + " : " + startMin;
            else
            { TextBox6.Text = "23 : 59"; return; };
            //if (int.Parse(startHr) + 3 > int.Parse(EndHr)) { TextBox6.Text = int.Parse(EndHr) + " : " + EndMin; return; } else TextBox6.Text = int.Parse(startHr) + 3 + " : " + startMin;
            if (int.Parse(startHr) + 3 < 24) TextBox7.Text = int.Parse(startHr) + 3 + " : " + startMin; else TextBox7.Text = "";
            //if (int.Parse(startHr) + 4 > int.Parse(EndHr)) { TextBox8.Text = int.Parse(EndHr) + " : " + EndMin; return; } else TextBox8.Text = int.Parse(startHr) + 4 + " : " + startMin;
            if (int.Parse(startHr) + 4 < 24) TextBox8.Text = int.Parse(startHr) + 4 + " : " + startMin;
            else
            { TextBox8.Text = "23 : 59"; return; };
            if (int.Parse(startHr) + 4 < 24) TextBox9.Text = int.Parse(startHr) + 4 + " : " + startMin; else TextBox9.Text = "";
            //if (int.Parse(startHr) + 5 > int.Parse(EndHr)) { TextBox10.Text = int.Parse(EndHr) + " : " + EndMin; return; } else TextBox10.Text = int.Parse(startHr) + 5 + " : " + startMin;
            if (int.Parse(startHr) + 5 < 24) TextBox10.Text = int.Parse(startHr) + 5 + " : " + startMin;
            else
            { TextBox10.Text = "23 : 59"; return; };
            if (int.Parse(startHr) + 5 < 24) TextBox11.Text = int.Parse(startHr) + 5 + " : " + startMin; else TextBox11.Text = "";
            //if (int.Parse(startHr) + 6 > int.Parse(EndHr)) { TextBox12.Text = int.Parse(EndHr) + " : " + EndMin; return; } else TextBox12.Text = int.Parse(startHr) + 6 + " : " + startMin;
            if (int.Parse(startHr) + 6 < 24) TextBox12.Text = int.Parse(startHr) + 6 + " : " + startMin;
            else
            { TextBox12.Text = "23 : 59"; return; };
            if (int.Parse(startHr) + 6 < 24) TextBox13.Text = int.Parse(startHr) + 6 + " : " + startMin; else TextBox13.Text = "";
            //if (int.Parse(startHr) + 7 > int.Parse(EndHr)) { TextBox14.Text = int.Parse(EndHr) + " : " + EndMin; return; } else TextBox14.Text = int.Parse(startHr) + 7 + " : " + startMin;
            if (int.Parse(startHr) + 7 < 24) TextBox14.Text = int.Parse(startHr) + 7 + " : " + startMin;
            else
            { TextBox14.Text = "23 : 59"; return; };
            if (int.Parse(startHr) + 7 < 24) TextBox15.Text = int.Parse(startHr) + 7 + " : " + startMin; else TextBox15.Text = "";
            //if (int.Parse(startHr) + 8 > int.Parse(EndHr)) { TextBox16.Text = int.Parse(EndHr) + " : " + EndMin; return; } else TextBox16.Text = int.Parse(startHr) + 8 + " : " + startMin;
            if (int.Parse(startHr) + 8 < 24) TextBox16.Text = int.Parse(startHr) + 8 + " : " + startMin;
            else
            { TextBox16.Text = "23 : 59"; return; };
            if (int.Parse(startHr) + 8 < 24) TextBox17.Text = int.Parse(startHr) + 8 + " : " + startMin; else TextBox17.Text = "";
            //if (int.Parse(startHr) + 9 > int.Parse(EndHr)) { TextBox18.Text = int.Parse(EndHr) + " : " + EndMin; return; } else TextBox18.Text = int.Parse(startHr) + 9 + " : " + startMin;
            if (int.Parse(startHr) + 9 < 24) TextBox18.Text = int.Parse(startHr) + 9 + " : " + startMin;
            else
            { TextBox18.Text = "23 : 59"; return; };
            if (int.Parse(startHr) + 9 < 24) TextBox19.Text = int.Parse(startHr) + 9 + " : " + startMin; else TextBox19.Text = "";
            //if (int.Parse(startHr) + 10 > int.Parse(EndHr)) { TextBox20.Text = int.Parse(EndHr) + " : " + EndMin; return; } else TextBox20.Text = int.Parse(startHr) + 10 + " : " + startMin;
            if (int.Parse(startHr) + 10 < 24) TextBox20.Text = int.Parse(startHr) + 10 + " : " + startMin;
            else
            { TextBox20.Text = "23 : 59"; return; };
            if (int.Parse(startHr) + 10 < 24) TextBox21.Text = int.Parse(startHr) + 10 + " : " + startMin; else TextBox21.Text = "";
            //if (int.Parse(startHr) + 11 > int.Parse(EndHr)) { TextBox22.Text = int.Parse(EndHr) + " : " + EndMin; return; } else TextBox22.Text = int.Parse(startHr) + 11 + " : " + startMin;
            if (int.Parse(startHr) + 12 < 24) TextBox22.Text = int.Parse(startHr) + 11 + " : " + startMin;
            else
            { TextBox22.Text = "23 : 59"; return; };
            if (int.Parse(startHr) + 12 < 24) TextBox23.Text = int.Parse(startHr) + 11 + " : " + startMin; else TextBox23.Text = "";
            //if (int.Parse(startHr) + 13 > int.Parse(EndHr)) { TextBox24.Text = int.Parse(EndHr) + " : " + EndMin; return; } else TextBox24.Text = int.Parse(startHr) + 12 + " : " + startMin;
            if (int.Parse(startHr) + 13 < 24) TextBox24.Text = int.Parse(startHr) + 13 + " : " + startMin;
            else
            { TextBox24.Text = "23 : 59"; return; };
            GetReportTimeinFields();

        }
    }
    public void TimeDifference(string RptHr, string RptMin, string TimeDiffHr, string TimeDiffMin)
    {
        //TextBox25.Text 

    }

    public void clear_textboxs()
    {
        TextBox2.Text = "";
        TextBox3.Text = "";
        TextBox4.Text = "";
        TextBox5.Text = "";
        TextBox6.Text = "";
        TextBox7.Text = "";
        TextBox8.Text = "";
        TextBox9.Text = "";
        TextBox10.Text = "";
        TextBox11.Text = "";
        TextBox12.Text = "";
        TextBox13.Text = "";
        TextBox14.Text = "";
        TextBox15.Text = "";
        TextBox16.Text = "";
        TextBox17.Text = "";
        TextBox18.Text = "";
        TextBox19.Text = "";
        TextBox20.Text = "";
        TextBox21.Text = "";
        TextBox22.Text = "";
        TextBox23.Text = "";
        TextBox24.Text = "";


    }


    protected void ddlMinutes_SelectedIndexChanged(object sender, EventArgs e)
    {
        InsertTimeinTextBox(ddlHour.SelectedItem.ToString(), ddlMinutes.SelectedItem.ToString(), ddlHourOut.SelectedItem.Text, ddlMinOut.SelectedItem.Text);
        // abc();
    }
    protected void ddlHourOut_SelectedIndexChanged(object sender, EventArgs e)
    {
        InsertTimeinTextBox(ddlHour.SelectedItem.ToString(), ddlMinutes.SelectedItem.ToString(), ddlHourOut.SelectedItem.Text, ddlMinOut.SelectedItem.Text);

    }
    protected void ddlMinOut_SelectedIndexChanged(object sender, EventArgs e)
    {
        InsertTimeinTextBox(ddlHour.SelectedItem.ToString(), ddlMinutes.SelectedItem.ToString(), ddlHourOut.SelectedItem.Text, ddlMinOut.SelectedItem.Text);

    }

    public void checkhour()
    {

        DataTable dt_RPTDetails = new DataTable();
        dt_RPTDetails = objDO.ReturnTodayDetailReport(ReportId.Text);

        try
        {
            hourflag = dt_RPTDetails.Rows.Count;
        }
        catch (Exception ex)
        {

            //throw;
        }
    

    }

    protected void Button1_Click(object sender, EventArgs e)
    {
        string startHr = ddlHour.SelectedItem.ToString();
        string startMin = ddlMinutes.SelectedItem.ToString();

        if (ReportId.Text != "New Report")
        {

            lblMessage.Text = "";
            lblMessage.ForeColor = System.Drawing.Color.Red;
            return;
            
        }

        if (TextBox1.Text == "" || TextBox2.Text == "" || TextBox25.Text == "" || txtNActivity.Text == "")
        {
            lblMessage.Text = "From/To/Rpt time or activity description cannot be empty";
            lblMessage.ForeColor = System.Drawing.Color.Red;
            return;
        }
        if (int.Parse(startHr) + 1 > int.Parse(DateTime.Now.Hour.ToString()))
        {
            lblMessage.Text = "Reporting time cannot be less then hour end time";
            lblMessage.ForeColor = System.Drawing.Color.Red;
            return;
        }
        else if (int.Parse(startHr) + 1 == int.Parse(DateTime.Now.Hour.ToString()) && int.Parse(startMin) > int.Parse(DateTime.Now.Minute.ToString()))
        {
            lblMessage.Text = "Reporting time cannot be less then hour end minute";
            lblMessage.ForeColor = System.Drawing.Color.Red;
            return;
        }

        DateTime dt_time_in = new DateTime(DateTime.Now.Year, DateTime.Now.Month, DateTime.Now.Day, int.Parse(startHr), int.Parse(startMin), 00);
        string TimeIn = dt_time_in.ToString();
        int result = objDO.fnAddDailyOutput(TimeIn, Session["UserName"].ToString(), TextBox1.Text, TextBox2.Text, TextBox25.Text, txtNActivity.Text, "1");
        if (result > 0)
        {
            lblMessage.Text = "First Hour Record Saved";
            lblMessage.ForeColor = System.Drawing.Color.Green;
            GetReportOfUser();

        }
        else
        {
            lblMessage.Text = "First Hour Record Not Saved";
            lblMessage.ForeColor = System.Drawing.Color.Red;

        }



    }
    protected void Button2_Click(object sender, EventArgs e)
    {
        string startHr = ddlHour.SelectedItem.ToString();
        string startMin = ddlMinutes.SelectedItem.ToString();

        checkhour();
        if (hourflag < 1)
        {
            lblMessage.Text = "Previous Hours are not save, save them first";
            lblMessage.ForeColor = System.Drawing.Color.Red;
            return;
        }
     
        if (TextBox3.Text == "" || TextBox4.Text == "" || TextBox26.Text == "" || txtNActivity0.Text == "")
        {
            lblMessage.Text = "From/To/Rpt time or activity description cannot be empty";
            lblMessage.ForeColor = System.Drawing.Color.Red;
            return;
        }
        if (int.Parse(startHr) + 2 > int.Parse(DateTime.Now.Hour.ToString()))
        {
            lblMessage.Text = "Reporting time cannot be less then hour end time";
            lblMessage.ForeColor = System.Drawing.Color.Red;
            return;
        }
        else if (int.Parse(startHr) + 2 == int.Parse(DateTime.Now.Hour.ToString()) && int.Parse(startMin) > int.Parse(DateTime.Now.Minute.ToString()))
        {
            lblMessage.Text = "Reporting time cannot be less then hour end minute";
            lblMessage.ForeColor = System.Drawing.Color.Red;
            return;
        }

        DateTime dt_time_in = new DateTime(DateTime.Now.Year, DateTime.Now.Month, DateTime.Now.Day, int.Parse(startHr), int.Parse(startMin), 00);
        string TimeIn = dt_time_in.ToString();
        int result = objDO.fnAddDailyOutput1(TextBox3.Text, TextBox4.Text, TextBox26.Text, txtNActivity0.Text, "2",ReportId.Text);
        if (result > 0)
        {
            lblMessage.Text = "Second Hour Record Saved";
            lblMessage.ForeColor = System.Drawing.Color.Green;


        }
        else
        {
            lblMessage.Text = "Second Hour Record Not Saved";
            lblMessage.ForeColor = System.Drawing.Color.Red;

        }


    }
    protected void Button3_Click(object sender, EventArgs e)
    {
        string startHr = ddlHour.SelectedItem.ToString();
        string startMin = ddlMinutes.SelectedItem.ToString();

        checkhour();
        if (hourflag < 2)
        {
            lblMessage.Text = "Previous Hours are not save, save them first";
            lblMessage.ForeColor = System.Drawing.Color.Red;
            return;
        }

        if (TextBox5.Text == "" || TextBox6.Text == "" || TextBox27.Text == "" || txtNActivity1.Text == "")
        {
            lblMessage.Text = "From/To/Rpt time or activity description cannot be empty";
            lblMessage.ForeColor = System.Drawing.Color.Red;
            return;
        }
        if (int.Parse(startHr) + 3 > int.Parse(DateTime.Now.Hour.ToString()))
        {
            lblMessage.Text = "Reporting time cannot be less then hour end time";
            lblMessage.ForeColor = System.Drawing.Color.Red;
            return;
        }
        else if (int.Parse(startHr) + 3 == int.Parse(DateTime.Now.Hour.ToString()) && int.Parse(startMin) > int.Parse(DateTime.Now.Minute.ToString()))
        {
            lblMessage.Text = "Reporting time cannot be less then hour end minute";
            lblMessage.ForeColor = System.Drawing.Color.Red;
            return;
        }

        DateTime dt_time_in = new DateTime(DateTime.Now.Year, DateTime.Now.Month, DateTime.Now.Day, int.Parse(startHr), int.Parse(startMin), 00);
        string TimeIn = dt_time_in.ToString();
        int result = objDO.fnAddDailyOutput1(TextBox5.Text, TextBox6.Text, TextBox27.Text, txtNActivity1.Text, "3",ReportId.Text);
        if (result > 0)
        {
            lblMessage.Text = "Third Hour Record Saved";
            lblMessage.ForeColor = System.Drawing.Color.Green;

        }
        else
        {
            lblMessage.Text = "Third Hour Record Not Saved";
            lblMessage.ForeColor = System.Drawing.Color.Red;

        }
        
    }


    protected void Button4_Click(object sender, EventArgs e)
    {
        string startHr = ddlHour.SelectedItem.ToString();
        string startMin = ddlMinutes.SelectedItem.ToString();

        checkhour();
        if (hourflag < 3)
        {
            lblMessage.Text = "Previous Hours are not save, save them first";
            lblMessage.ForeColor = System.Drawing.Color.Red;
            return;
        }


        if (TextBox7.Text == "" || TextBox8.Text == "" || TextBox28.Text == "" || txtNActivity2.Text == "")
        {
            lblMessage.Text = "From/To/Rpt time or activity description cannot be empty";
            lblMessage.ForeColor = System.Drawing.Color.Red;
            return;
        }
        if (int.Parse(startHr) + 4 > int.Parse(DateTime.Now.Hour.ToString()))
        {
            lblMessage.Text = "Reporting time cannot be less then hour end time";
            lblMessage.ForeColor = System.Drawing.Color.Red;
            return;
        }
        else if (int.Parse(startHr) + 4 == int.Parse(DateTime.Now.Hour.ToString()) && int.Parse(startMin) > int.Parse(DateTime.Now.Minute.ToString()))
        {
            lblMessage.Text = "Reporting time cannot be less then hour end minute";
            lblMessage.ForeColor = System.Drawing.Color.Red;
            return;
        }

        DateTime dt_time_in = new DateTime(DateTime.Now.Year, DateTime.Now.Month, DateTime.Now.Day, int.Parse(startHr), int.Parse(startMin), 00);
        string TimeIn = dt_time_in.ToString();
        int result = objDO.fnAddDailyOutput1(TextBox7.Text, TextBox8.Text, TextBox28.Text, txtNActivity2.Text, "4",ReportId.Text);
        if (result > 0)
        {
            lblMessage.Text = "Fourth Hour Record Saved";
            lblMessage.ForeColor = System.Drawing.Color.Green;

        }
        else
        {
            lblMessage.Text = "Fourth Hour Record Not Saved";
            lblMessage.ForeColor = System.Drawing.Color.Red;

        }
    }
    protected void Button5_Click(object sender, EventArgs e)
    {
        string startHr = ddlHour.SelectedItem.ToString();
        string startMin = ddlMinutes.SelectedItem.ToString();

        checkhour();
        if (hourflag < 4)
        {
            lblMessage.Text = "Previous Hours are not save, save them first";
            lblMessage.ForeColor = System.Drawing.Color.Red;
            return;
        }

        if (TextBox9.Text == "" || TextBox10.Text == "" || TextBox29.Text == "" || txtNActivity3.Text == "")
        {
            lblMessage.Text = "From/To/Rpt time or activity description cannot be empty";
            lblMessage.ForeColor = System.Drawing.Color.Red;
            return;

        }
        if (int.Parse(startHr) + 5 > int.Parse(DateTime.Now.Hour.ToString()))
        {
            lblMessage.Text = "Reporting time cannot be less than hour end time";
            lblMessage.ForeColor = System.Drawing.Color.Red;
            return;
        }
        int result = objDO.fnAddDailyOutput1(TextBox9.Text, TextBox10.Text, TextBox29.Text, txtNActivity3.Text, "5", ReportId.Text);
        if (result > 0)
        {
            lblMessage.Text = "Fifth Hour Record Saved";
            lblMessage.ForeColor = System.Drawing.Color.Green;
        }
        else
        {
            lblMessage.Text = "Fifth Hour Not Saved";
            lblMessage.ForeColor = System.Drawing.Color.Red;
        }

    }
    protected void Button6_Click(object sender, EventArgs e)
    {
        string startHr = ddlHour.SelectedItem.ToString();
        string startMin = ddlMinutes.SelectedItem.ToString();

        checkhour();
        if (hourflag < 5)
        {
            lblMessage.Text = "Previous Hours are not save, save them first";
            lblMessage.ForeColor = System.Drawing.Color.Red;
            return;
        }

        if (TextBox11.Text == "" || TextBox12.Text == "" || TextBox30.Text == "" || txtNActivity4.Text == "")
        {
            lblMessage.Text = "From/To/Rpt time or activity description cannot be empty";
            lblMessage.ForeColor = System.Drawing.Color.Red;
            return;
        }
        if (int.Parse(startHr) + 6 > int.Parse(DateTime.Now.Hour.ToString()))
        {
            lblMessage.Text = "Reporting time cannot be less than hour end time";
            lblMessage.ForeColor = System.Drawing.Color.Red;
            return;
        }
        int result = objDO.fnAddDailyOutput1(TextBox11.Text, TextBox12.Text, TextBox30.Text, txtNActivity4.Text, "6", ReportId.Text);
        if (result > 0)
        {
            lblMessage.Text = "Sixth Hour Record Saved";
            lblMessage.ForeColor = System.Drawing.Color.Green;
        }
        else
        {
            lblMessage.Text = "Sixth Hour Not Saved";
            lblMessage.ForeColor = System.Drawing.Color.Red;
        }

    }
    protected void Button7_Click(object sender, EventArgs e)
    {
        string startHr = ddlHour.SelectedItem.ToString();
        string startMin = ddlMinutes.SelectedItem.ToString();

        checkhour();
        if (hourflag < 6)
        {
            lblMessage.Text = "Previous Hours are not save, save them first";
            lblMessage.ForeColor = System.Drawing.Color.Red;
            return;
        }

        if (TextBox13.Text == "" || TextBox14.Text == "" || TextBox31.Text == "" || txtNActivity5.Text == "")
        {
            lblMessage.Text = "From/To/Rpt time or activity description cannot be empty";
            lblMessage.ForeColor = System.Drawing.Color.Red;
            return;
        }
        if (int.Parse(startHr) + 7 > int.Parse(DateTime.Now.Hour.ToString()))
        {
            lblMessage.Text = "Reporting time cannot be less than hour end time";
            lblMessage.ForeColor = System.Drawing.Color.Red;
            return;
        }
        int result = objDO.fnAddDailyOutput1(TextBox13.Text, TextBox14.Text, TextBox31.Text, txtNActivity5.Text, "7", ReportId.Text);
        if (result > 0)
        {
            lblMessage.Text = "Seventh Hour Record Saved";
            lblMessage.ForeColor = System.Drawing.Color.Green;
        }
        else
        {
            lblMessage.Text = "Seventh Hour Not Saved";
            lblMessage.ForeColor = System.Drawing.Color.Red;
        }

    }
    protected void Button8_Click(object sender, EventArgs e)
    {
        string startHr = ddlHour.SelectedItem.ToString();
        string startMin = ddlMinutes.SelectedItem.ToString();

        checkhour();
        if (hourflag < 7)
        {
            lblMessage.Text = "Previous Hours are not save, save them first";
            lblMessage.ForeColor = System.Drawing.Color.Red;
            return;
        }

        if (TextBox15.Text == "" || TextBox16.Text == "" || TextBox32.Text == "" || txtNActivity6.Text == "")
        {
            lblMessage.Text = "From/To/Rpt time or activity description cannot be empty";
            lblMessage.ForeColor = System.Drawing.Color.Red;
            return;
        }
        if (int.Parse(startHr) + 8 > int.Parse(DateTime.Now.Hour.ToString()))
        {
            lblMessage.Text = "Reporting time cannot be less than hour end time";
            lblMessage.ForeColor = System.Drawing.Color.Red;
            return;
        }
        int result = objDO.fnAddDailyOutput1(TextBox15.Text, TextBox16.Text, TextBox32.Text, txtNActivity6.Text, "8", ReportId.Text);
        if (result > 0)
        {
            lblMessage.Text = "Eighth Hour Record Saved";
            lblMessage.ForeColor = System.Drawing.Color.Green;
        }
        else
        {
            lblMessage.Text = "Eighth Hour Not Saved";
            lblMessage.ForeColor = System.Drawing.Color.Red;
        }
    }
    protected void Button9_Click(object sender, EventArgs e)
    {
        string startHr = ddlHour.SelectedItem.ToString();
        string startMin = ddlMinutes.SelectedItem.ToString();

        checkhour();
        if (hourflag < 8)
        {
            lblMessage.Text = "Previous Hours are not save, save them first";
            lblMessage.ForeColor = System.Drawing.Color.Red;
            return;
        }

        if (TextBox17.Text == "" || TextBox18.Text == "" || TextBox33.Text == "" || txtNActivity7.Text == "")
        {
            lblMessage.Text = "From/To/Rpt time or activity description cannot be empty";
            lblMessage.ForeColor = System.Drawing.Color.Red;
            return;
        }
        if (int.Parse(startHr) + 9 > int.Parse(DateTime.Now.Hour.ToString()))
        {
            lblMessage.Text = "Reporting time cannot be less than hour end time";
            lblMessage.ForeColor = System.Drawing.Color.Red;
            return;
        }
        int result = objDO.fnAddDailyOutput1(TextBox17.Text, TextBox18.Text, TextBox33.Text, txtNActivity7.Text, "9", ReportId.Text);
        if (result > 0)
        {
            lblMessage.Text = "Ninth Hour Record Saved";
            lblMessage.ForeColor = System.Drawing.Color.Green;
        }
        else
        {
            lblMessage.Text = "Ninth Hour Not Saved";
            lblMessage.ForeColor = System.Drawing.Color.Red;
        }

    }
    protected void Button10_Click(object sender, EventArgs e)
    {
        string startHr = ddlHour.SelectedItem.ToString();
        string startMin = ddlMinutes.SelectedItem.ToString();

        checkhour();
        if (hourflag < 9)
        {
            lblMessage.Text = "Previous Hours are not save, save them first";
            lblMessage.ForeColor = System.Drawing.Color.Red;
            return;
        }

        if (TextBox19.Text == "" || TextBox20.Text == "" || TextBox34.Text == "" || txtNActivity8.Text == "")
        {
            lblMessage.Text = "From/To/Rpt time or activity description cannot be empty";
            lblMessage.ForeColor = System.Drawing.Color.Red;
            return;
        }
        if (int.Parse(startHr) + 10 > int.Parse(DateTime.Now.Hour.ToString()))
        {
            lblMessage.Text = "Reporting time cannot be less than hour end time";
            lblMessage.ForeColor = System.Drawing.Color.Red;
            return;
        }
        int result = objDO.fnAddDailyOutput1(TextBox19.Text, TextBox20.Text, TextBox34.Text, txtNActivity8.Text, "10", ReportId.Text);
        if (result > 0)
        {
            lblMessage.Text = "Tenth Hour Record Saved";
            lblMessage.ForeColor = System.Drawing.Color.Green;
        }
        else
        {
            lblMessage.Text = "Tenth Hour Not Saved";
            lblMessage.ForeColor = System.Drawing.Color.Red;
        }
    }
    protected void Button11_Click(object sender, EventArgs e)
    {
        string startHr = ddlHour.SelectedItem.ToString();
        string startMin = ddlMinutes.SelectedItem.ToString();

        checkhour();
        if (hourflag < 10)
        {
            lblMessage.Text = "Previous Hours are not save, save them first";
            lblMessage.ForeColor = System.Drawing.Color.Red;
            return;
        }

        if (TextBox21.Text == "" || TextBox22.Text == "" || TextBox35.Text == "" || txtNActivity9.Text == "")
        {
            lblMessage.Text = "From/To/Rpt time or activity description cannot be empty";
            lblMessage.ForeColor = System.Drawing.Color.Red;
            return;
        }
        if (int.Parse(startHr) + 11 > int.Parse(DateTime.Now.Hour.ToString()))
        {
            lblMessage.Text = "Reporting time cannot be less than hour end time";
            lblMessage.ForeColor = System.Drawing.Color.Red;
            return;
        }
        int result = objDO.fnAddDailyOutput1(TextBox21.Text, TextBox22.Text, TextBox35.Text, txtNActivity9.Text, "11", ReportId.Text);
        if (result > 0)
        {
            lblMessage.Text = "Eleventh Hour Record Saved";
            lblMessage.ForeColor = System.Drawing.Color.Green;
        }
        else
        {
            lblMessage.Text = "Eleventh Hour Not Saved";
            lblMessage.ForeColor = System.Drawing.Color.Red;
        }

    }
    protected void Button12_Click(object sender, EventArgs e)
    {
        string startHr = ddlHour.SelectedItem.ToString();
        string startMin = ddlMinutes.SelectedItem.ToString();

        checkhour();
        if (hourflag < 11)
        {
            lblMessage.Text = "Previous Hours are not save, save them first";
            lblMessage.ForeColor = System.Drawing.Color.Red;
            return;
        }

        if (TextBox23.Text == "" || TextBox24.Text == "" || TextBox36.Text == "" || txtNActivity10.Text == "")
        {
            lblMessage.Text = "From/To/Rpt time or activity description cannot be empty";
            lblMessage.ForeColor = System.Drawing.Color.Red;
            return;
        }
        if (int.Parse(startHr) + 12 > int.Parse(DateTime.Now.Hour.ToString()))
        {
            lblMessage.Text = "Reporting time cannot be less than hour end time";
            lblMessage.ForeColor = System.Drawing.Color.Red;
            return;
        }
        int result = objDO.fnAddDailyOutput1(TextBox23.Text, TextBox24.Text, TextBox36.Text, txtNActivity10.Text, "12", ReportId.Text);
        if (result > 0)
        {
            lblMessage.Text = "Twelfth Hour Record Saved";
            lblMessage.ForeColor = System.Drawing.Color.Green;
        }
        else
        {
            lblMessage.Text = "Twelfth Hour Not Saved";
            lblMessage.ForeColor = System.Drawing.Color.Red;
        }

    }

    //public void abc()
    //{
    //    string[] time = TextBox25.Text.Split(':');
    //    int hr = int.Parse(time[0].ToString());
    //    int min = int.Parse(time[1].ToString());
    //    string[] time1 = TextBox2.Text.Split(':');
    //    int hr1 = int.Parse(time1[0].ToString());
    //    int min1 = int.Parse(time1[1].ToString());
    //    int hrDiff1 = hr - hr1;
    //    int minDiff1 = min - min1;
    //    string str1 = (hrDiff1+":"+minDiff1);
    //    txtTimeDiff1.Text = str1;

    //    string[] time2 = TextBox26.Text.Split(':');
    //    int hr2 = int.Parse(time2[0].ToString());
    //    int min2 = int.Parse(time2[1].ToString());
    //    string[] time3 = TextBox4.Text.Split(':');
    //    int hr3 = int.Parse(time3[0].ToString());
    //    int min3 = int.Parse(time3[1].ToString());
    //    int hrDiff2 = hr2 - hr3;
    //    int minDiff2 = min2 - min3;
    //    string str2 = (hrDiff2+":"+minDiff2);
    //    txtTimeDiff2.Text = str2;

    //    string[] time4 = TextBox27.Text.Split(':');
    //    int hr4 = int.Parse(time4[0].ToString());
    //    int min4 = int.Parse(time4[1].ToString());
    //    string[] time5 = TextBox6.Text.Split(':');
    //    int hr5 = int.Parse(time5[0].ToString());
    //    int min5 = int.Parse(time5[1].ToString());
    //    int hrDiff3 = hr4 - hr5;
    //    int minDiff3 = min4 - min5;
    //    string str3 = (hrDiff3+":"+minDiff3);
    //    txtTimeDiff3.Text = str3;

    //    string[] time6 = TextBox28.Text.Split(':');
    //    int hr6 = int.Parse(time6[0].ToString());
    //    int min6 = int.Parse(time6[1].ToString());
    //    string[] time7 = TextBox8.Text.Split(':');
    //    int hr7 = int.Parse(time7[0].ToString());
    //    int min7 = int.Parse(time7[1].ToString());
    //    int hrDiff4 = hr6 - hr7;
    //    int minDiff4 = min6 - min7;
    //    string str4 = (hrDiff4+":"+minDiff4);
    //    txtTimeDiff4.Text = str4;

    //    string[] time8 = TextBox29.Text.Split(':');
    //    int hr8 = int.Parse(time8[0].ToString());
    //    int min8 = int.Parse(time8[1].ToString());
    //    string[] time9 = TextBox10.Text.Split(':');
    //    int hr9 = int.Parse(time9[0].ToString());
    //    int min9 = int.Parse(time9[1].ToString());
    //    int hrDiff5 = hr8 - hr9;
    //    int minDiff5 = min8 - min9;
    //    string str5 = (hrDiff5 + ":" + minDiff5);
    //    txtTimeDiff5.Text = str5;

    //    string[] time10 = TextBox30.Text.Split(':');
    //    int hr10 = int.Parse(time10[0].ToString());
    //    int min10 = int.Parse(time10[1].ToString());
    //    string[] time11 = TextBox12.Text.Split(':');
    //    int hr11 = int.Parse(time11[0].ToString());
    //    int min11 = int.Parse(time11[1].ToString());
    //    int hrDiff6 = hr10 - hr11;
    //    int minDiff6 = min10 - min11;
    //    string str6 = (hrDiff6+":"+minDiff6);
    //    txtTimeDiff6.Text = str6;

    //    string[] time12 = TextBox31.Text.Split(':');
    //    int hr12 = int.Parse(time12[0].ToString());
    //    int min12 = int.Parse(time12[1].ToString());
    //    string[] time13 = TextBox14.Text.Split(':');
    //    int hr13 = int.Parse(time13[0].ToString());
    //    int min13 = int.Parse(time13[1].ToString());
    //    int hrDiff7 = hr12 - hr13;
    //    int minDiff7 = min13 - min13;
    //    string str7 = (hrDiff7+":"+minDiff7);
    //    txtTimeDiff7.Text = str7;

    //    string[] time14 = TextBox32.Text.Split(':');
    //    int hr14 = int.Parse(time14[0].ToString());
    //    int min14 = int.Parse(time14[1].ToString());
    //    string[] time15 = TextBox16.Text.Split(':');
    //    int hr15 = int.Parse(time15[0].ToString());
    //    int min15 = int.Parse(time15[1].ToString());
    //    int hrDiff8 = hr14 - hr15;
    //    int minDiff8 = min14 - min15;
    //    string str8 = (hrDiff8+":"+minDiff8);
    //    txtTimeDiff8.Text = str8;

    //    string[] time16 = TextBox33.Text.Split(':');
    //    int hr16 = int.Parse(time16[0].ToString());
    //    int min16 = int.Parse(time16[1].ToString());
    //    string[] time17 = TextBox18.Text.Split(':');
    //    int hr17 = int.Parse(time17[0].ToString());
    //    int min17 = int.Parse(time17[1].ToString());
    //    int hrDiff9 = hr16 - hr17;
    //    int minDiff9 = min16 - min17;
    //    string str9 = (hrDiff9 + ":" + minDiff9);
    //    txtTimeDiff9.Text = str9;

    //    string[] time18 = TextBox34.Text.Split(':');
    //    int hr18 = int.Parse(time18[0].ToString());
    //    int min18 = int.Parse(time18[1].ToString());
    //    string[] time19 = TextBox20.Text.Split(':');
    //    int hr19 = int.Parse(time11[0].ToString());
    //    int min19 = int.Parse(time19[1].ToString());
    //    int hrDiff10 = hr18 - hr19;
    //    int minDiff10 = min19 - min19;
    //    string str10 = (hrDiff10 + ":" + minDiff10);
    //    txtTimeDiff10.Text = str10;

    //    string[] time20 = TextBox35.Text.Split(':');
    //    int hr20 = int.Parse(time20[0].ToString());
    //    int min20 = int.Parse(time20[1].ToString());
    //    string[] time21 = TextBox22.Text.Split(':');
    //    int hr21 = int.Parse(time21[0].ToString());
    //    int min21 = int.Parse(time21[1].ToString());
    //    int hrDiff11 = hr20 - hr21;
    //    int minDiff11 = min20 - min21;
    //    string str11 = (hrDiff11 + ":" + minDiff11);
    //    txtTimeDiff11.Text = str11;

    //    string[] time22 = TextBox36.Text.Split(':');
    //    int hr22 = int.Parse(time22[0].ToString());
    //    int min22 = int.Parse(time22[1].ToString());
    //    string[] time23 = TextBox24.Text.Split(':');
    //    int hr23 = int.Parse(time23[0].ToString());
    //    int min23 = int.Parse(time23[1].ToString());
    //    int hrDiff12 = hr22 - hr23;
    //    int minDiff12 = min22 - min23;
    //    string str12 = (hrDiff12 + ":" + minDiff12);
    //    txtTimeDiff12.Text = str12;
    //}
}

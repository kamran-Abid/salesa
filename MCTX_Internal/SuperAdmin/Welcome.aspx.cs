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
using System.Text.RegularExpressions;
using Sales_BOL;
using System.IO;
using System.Drawing;
using System.Data.SqlClient;
using System.Runtime.Serialization.Json;
using System.Web.Script.Serialization;
using System.Collections.Generic;
using System.Web.Services;

public partial class MCTX_Internal_SuperAdmin_Administrator : System.Web.UI.Page
{
    _Welcome objwelcome = new _Welcome();
    _Variables objvar = new _Variables();
    string userworkingdays = "26";
    string userbasicpay = "1";


    protected void Page_Load(object sender, EventArgs e)
    {
        // getacheivements();
        getvalues();
        try
        
        {
            if (Request.Cookies["userName"] == null)
            {
                Response.Redirect("../../MCTX_General/securelogin.aspx");
                return;
            }
            else
            {
                lblUser.Visible = true;
                lblUser.Text = Request.Cookies["Username"].Value.ToString() + " As " + Request.Cookies["Role"].Value + " ! ";
                Session["Username"] = Request.Cookies["Username"].Value.ToString();
            }
        }
        catch (Exception ex)
        {
            Response.Redirect("../../MCTX_General/securelogin.aspx");
        }

        lbl_name.Text = Request.Cookies["UserFullName"].Value.ToString();
        if (!IsPostBack)
        {
            //Page.ClientScript.RegisterStartupScript(this.GetType(), "op", "window.open ('PopUp.aspx', null,'top=1,left=1,center=yes,resizable=no,Width=550px,Height= 550px,status=no,titlebar=no;toolbar=no,menubar=no,location=no,scrollbars=yes');", true);

            try
            {

                try
                {
                    lbl_pen_Pros.Text = objwelcome.get_Pending_Prospecting(Session["Username"].ToString());
                    int pen_pros_count = int.Parse(lbl_pen_Pros.Text);

                    if (pen_pros_count > 40)
                    {
                        lbl_pen_Pros.ForeColor = System.Drawing.Color.Green;
                    }
                    else if (pen_pros_count > 20 && pen_pros_count < 40)
                    {
                        lbl_pen_Pros.ForeColor = System.Drawing.Color.Yellow;
                    }
                    else if (pen_pros_count < 20)
                    {
                        lbl_pen_Pros.ForeColor = System.Drawing.Color.Red;
                    }

                }
                catch (Exception ex)
                { }

                objwelcome.getTargetdetails(Session["Username"].ToString());
                gridvariables.DataSource = objwelcome.dt_targetdetails;
                gridvariables.DataBind();
                StartEnddate.Text = objwelcome.startenddate;
                objvar.getuservariables(Session["Username"].ToString(), 1);
                gridtargetdetails.DataSource = objvar.dt_variables;
                gridtargetdetails.DataBind();
                objwelcome.getbasicpay(Session["Username"].ToString());
                lbl_basicsal.Text = objwelcome.dt_userinfo.Rows[0]["BasicSalary"].ToString();
                lbluserworkingdays.Text = objwelcome.dt_userinfo.Rows[0]["WorkingDays"].ToString();

                int sumofallowences = 0;
                try
                {
                    if (objwelcome.dt_userinfo.Rows[0]["ConvenceAllowence"].ToString() != "")
                    {
                        sumofallowences = sumofallowences + int.Parse(objwelcome.dt_userinfo.Rows[0]["ConvenceAllowence"].ToString());
                    }
                    if (objwelcome.dt_userinfo.Rows[0]["MobileAllowence"].ToString() != "")
                    {
                        sumofallowences = sumofallowences + int.Parse(objwelcome.dt_userinfo.Rows[0]["MobileAllowence"].ToString());
                    }
                    if (objwelcome.dt_userinfo.Rows[0]["MiscAllowence"].ToString() != "")
                    {
                        sumofallowences = sumofallowences + int.Parse(objwelcome.dt_userinfo.Rows[0]["MiscAllowence"].ToString());
                    }

                }
                catch (Exception ex)
                { }

                lbl_sumofallowences.Text = sumofallowences.ToString();
                userworkingdays = lbluserworkingdays.Text;
                userbasicpay = lbl_basicsal.Text;

                if (userbasicpay == "")
                {
                    userbasicpay = "1";
                }
                if (userworkingdays == "")
                {
                    userworkingdays = "26";
                }
                getacheivements();
                salarycalculator();

                lbltotaldeduct.Text = objwelcome.gettotaldeductions(Session["Username"].ToString());
                int grandtotal = int.Parse(userbasicpay.ToString()) - int.Parse(lbltotaldeduct.Text);
                lblGtotal.Text = grandtotal.ToString();
                lbldeductonsal.Text = objwelcome.get_deduction_on_sal(Session["Username"].ToString());

                //

            }
            catch (Exception ex)
            {

            }

        }


    }

    public static Dictionary<string, object> ToJson(DataTable table)
    {
        Dictionary<string, object> j = new Dictionary<string, object>();
        j.Add(table.TableName, RowsToDictionary(table));
        return j;
    }

    private static List<Dictionary<string, object>> RowsToDictionary(DataTable table)
    {
        List<Dictionary<string, object>> objs =
            new List<Dictionary<string, object>>();
        foreach (DataRow dr in table.Rows)
        {
            Dictionary<string, object> drow = new Dictionary<string, object>();
            for (int i = 0; i < table.Columns.Count; i++)
            {
                drow.Add(table.Columns[i].ColumnName, dr[i]);
            }
            objs.Add(drow);
        }

        return objs;
    }

    public void getacheivements()
    {
        DataTable dt_acheivment = new DataTable();
        DataRow dr;
        string lastdate = getlastdate();
        string month = lastdate.Substring(0, 2);
        //string day = lastdate.Substring(3, 2);

        try
        {
            dt_acheivment.Columns.Add("Target", typeof(string));
            dt_acheivment.Columns.Add("LDay Acheived", typeof(string));
            dt_acheivment.Columns.Add("MTD Acheived", typeof(string));
        }
        catch (Exception ex)
        { }



        for (int i = 0; i < objwelcome.dt_targetdetails.Rows.Count; i++)
        {
            string target = objwelcome.dt_targetdetails.Rows[i][0].ToString();
            string LdayAcheived = objwelcome.get_ldayTargetAmount(target, lastdate, Session["Username"].ToString()).ToString();
            string MTDAcheived = objwelcome.get_MTDTargetamount(target, lastdate, Session["Username"].ToString()).ToString();
            dr = dt_acheivment.NewRow();
            dr[0] = target;
            dr[1] = LdayAcheived;
            dr[2] = MTDAcheived;
            dt_acheivment.Rows.Add(dr);

        }

        gridacheivements.DataSource = dt_acheivment;
        gridacheivements.DataBind();

    }
    public string getlastdate()
    {
        DateTime dt = DateTime.Now;
        TimeSpan TS = new TimeSpan(1, 0, 0, 0);
        string date = dt.Subtract(TS).ToShortDateString();
        DateTime Lday = DateTime.Parse(date);

        string mon = Lday.Month.ToString();
        string day = Lday.Day.ToString();
        string year = Lday.Year.ToString();

        if (mon.Length != 2)
            mon = "0" + mon;
        if (day.Length != 2)
            day = "0" + day;

        string LastDate = mon + "/" + day + "/" + year;

        return LastDate;
    }

    public void salarycalculator()
    {
        string strsalarydate = "";
        string lastdate = objwelcome.getlastsaldate(Session["Username"].ToString());
        DateTime salarystartdate = DateTime.Parse(lastdate);
        int startday = int.Parse(salarystartdate.Day.ToString());
        int startmonth = int.Parse(salarystartdate.Month.ToString());
        int startyear = int.Parse(salarystartdate.Year.ToString());


        DateTime todate = DateTime.Now;
        int today = int.Parse(todate.Day.ToString());
        int tomonth = int.Parse(todate.Month.ToString());
        int toyear = int.Parse(todate.Year.ToString());
        if (startmonth == tomonth)
        {

            for (int i = startday + 1; i < today; i++)
            {

                if (i < 10)
                {
                    strsalarydate = startmonth + "/0" + i + "/" + startyear;
                }
                else
                {
                    strsalarydate = startmonth + "/" + i + "/" + startyear;
                }
                calculate_salaryofday(strsalarydate);
            }
        }
        else
        {
            for (int k = startday + 1; k < 33; k++)
            {
                if (k < 10)
                {
                    strsalarydate = startmonth + "/0" + k + "/" + startyear;
                }
                else
                {
                    strsalarydate = startmonth + "/" + k + "/" + startyear;
                }

                try
                {
                    DateTime salarydate = DateTime.Parse(strsalarydate);
                    calculate_salaryofday(strsalarydate);
                }
                catch (Exception ex)
                {
                    for (int m = 1; m < today; m++)
                    {
                        if (m < 10)
                        {
                            strsalarydate = tomonth + "/0" + m + "/" + toyear;
                        }
                        else
                        {
                            strsalarydate = tomonth + "/" + m + "/" + toyear;
                        }
                        calculate_salaryofday(strsalarydate);

                    }
                    k = 32;
                }

            }

        }
    }

    //calculate salary date function added by (khalid - 0333-5761509)
    public void calculate_salaryofday(string salarydate)
    {
        string lastsalary = objwelcome.getlastsalary(Session["Username"].ToString());
        if (lastsalary == "")
        {
            lastsalary = userbasicpay.ToString();
        }
        if (salarydate.IndexOf("/") == 1)
        {
            salarydate = "0" + salarydate;
        }
        if (salarydate.Substring(3, 2).ToString() == "01")
        {
            lastsalary = userbasicpay.ToString();
        }


        int deduction_on_sal = 0;
        int dedcution_on_comm = 0;
        int total_deductions = 0;
        int saltilltoday = 0;




        for (int i = 0; i < objwelcome.dt_targetdetails.Rows.Count; i++)
        {
            int deduction = 0;
            string target = objwelcome.dt_targetdetails.Rows[i][0].ToString();
            string targetamt = objwelcome.dt_targetdetails.Rows[i][1].ToString();
            string targetevalon = objwelcome.dt_targetdetails.Rows[i][2].ToString();
            deduction = getdeductiontarget(target, targetamt, targetevalon, salarydate);
            deduction_on_sal = deduction_on_sal + deduction;
        }

        //lbldeductonsal.Text = deduction_on_sal.ToString();
        total_deductions = deduction_on_sal + dedcution_on_comm;
        saltilltoday = int.Parse(lastsalary.ToString()) - total_deductions;


        try
        {
            int status = 0;
            status = objwelcome.insert_deductions(salarydate, deduction_on_sal.ToString(), dedcution_on_comm.ToString(),
total_deductions.ToString(), saltilltoday.ToString(), Session["Username"].ToString());

            if (status > 0)
            {


            }

        }
        catch (Exception ex)
        { }



    }
    public int getdeductiontarget(string target, string targetamt, string targetevalon, string salarydate)
    {
        int rtdeduction = 0;
        float fltdeductions = 0;
        int target_deduction_percentage = 0;
        string evalon = "";
        int amountoftarget_achieved = 0;
        int amountoftarget_not_acheived = 0;
        int perdaypay = int.Parse(userbasicpay) / int.Parse(userworkingdays);
        float notachivedPercent = 0;

        int perday_target = 0;
        int perweak_target = 0;
        int permon_tagert = 0;



        for (int i = 0; i < objvar.dt_variables.Rows.Count; i++)
        {
            if (objvar.dt_variables.Rows[i]["Variable"].ToString() == target)
            {
                target_deduction_percentage = int.Parse(objvar.dt_variables.Rows[i][2].ToString());
                evalon = objvar.dt_variables.Rows[i][3].ToString();
                i = objvar.dt_variables.Rows.Count;
            }

        }



        if (evalon == "Working Day")
        {
            float perdayweightage_amount = 0;
            perdayweightage_amount = ((float)perdaypay * (float)target_deduction_percentage) / 100;
            amountoftarget_achieved = objwelcome.gettarget_achievedcount(target, salarydate, Session["UserName"].ToString(), "");

            DateTime saldate = DateTime.Parse(salarydate);
            string dayofweak1 = saldate.DayOfWeek.ToString();
            if (dayofweak1 == "Sunday")
            {
                return 0;
            }

            if (targetevalon == "Daily")
            {

                try
                {
                    if (amountoftarget_achieved > (int.Parse(targetamt) - 1))
                    {
                        return 0;
                    }

                    amountoftarget_not_acheived = int.Parse(targetamt) - amountoftarget_achieved;
                    notachivedPercent = (float)amountoftarget_not_acheived / float.Parse(targetamt);

                    fltdeductions = perdayweightage_amount * notachivedPercent;
                    rtdeduction = (int)fltdeductions;

                    return rtdeduction;

                }
                catch (Exception ex)
                { }
            }
            if (targetevalon == "Weekly")
            {

                double dbperdaytarget = double.Parse(targetamt) / 6;
                perday_target = (int)Math.Round(dbperdaytarget, 0);

                try
                {
                    if (amountoftarget_achieved > (perday_target - 1))
                    {
                        return 0;
                    }

                    amountoftarget_not_acheived = perday_target - amountoftarget_achieved;
                    notachivedPercent = (float)amountoftarget_not_acheived / (float)(perday_target);

                    fltdeductions = perdayweightage_amount * notachivedPercent;
                    rtdeduction = (int)fltdeductions;

                    return rtdeduction;

                }
                catch (Exception ex)
                { }



            }
            if (targetevalon == "Monthly")
            {
                double dbperdaytarget = double.Parse(targetamt) / double.Parse(userworkingdays);
                perday_target = (int)Math.Round(dbperdaytarget, 0);
                try
                {
                    if (amountoftarget_achieved > (perday_target - 1))
                    {
                        return 0;
                    }

                    amountoftarget_not_acheived = perday_target - amountoftarget_achieved;
                    notachivedPercent = (float)amountoftarget_not_acheived / (float)(perday_target);

                    fltdeductions = perdayweightage_amount * notachivedPercent;
                    rtdeduction = (int)fltdeductions;

                    return rtdeduction;

                }
                catch (Exception ex)
                { }
            }

        }

        if (evalon == "Weekly")
        {

            float perweakweightage_amount = ((float.Parse(userbasicpay) / 4) * (float)target_deduction_percentage) / 100;



            string dayofweak = "";
            string day = "";
            int weakdays = 6;
            string initialdate = "";
            string startdate = "";
            int intstartdate = 0;
            DateTime saldate = DateTime.Parse(salarydate);
            dayofweak = saldate.DayOfWeek.ToString();
            if (dayofweak != "Sunday")
            {
                return 0;
            }

            day = saldate.Day.ToString();


            if (int.Parse(day) < 7)
            {
                weakdays = (int.Parse(day) - 1);
                startdate = "01";
                intstartdate = 1;
            }
            else
            {
                intstartdate = int.Parse(day) - 7;
            }
            string mon = salarydate.Substring(0, 3);
            if (intstartdate < 10)
            {
                startdate = "0" + intstartdate;
            }
            else
            {
                startdate = intstartdate.ToString();
            }
            string year = salarydate.Substring(5);

            initialdate = mon + startdate + year;

            amountoftarget_achieved = objwelcome.gettarget_achievedcount(target, salarydate, Session["UserName"].ToString(), initialdate);




            if (targetevalon == "Daily")
            {
                double perweaktaramt = 0;
                perweaktaramt = (double.Parse(targetamt) * weakdays);
                perweak_target = (int)Math.Round(perweaktaramt, 0);

                try
                {
                    if (amountoftarget_achieved > ((perweak_target) - 1))
                    {
                        return 0;
                    }

                    amountoftarget_not_acheived = perweak_target - amountoftarget_achieved;
                    notachivedPercent = (float)amountoftarget_not_acheived / (float)(perweak_target);

                    fltdeductions = perweakweightage_amount * notachivedPercent;
                    rtdeduction = (int)fltdeductions;

                    return rtdeduction;

                }
                catch (Exception ex)
                { }


            }
            if (targetevalon == "Weekly")
            {
                double perweaktaramt = 0;
                perweaktaramt = (double.Parse(targetamt) / 6) * (double)(weakdays);
                perweak_target = (int)Math.Round(perweaktaramt, 0);

                try
                {
                    if (amountoftarget_achieved > ((perweak_target) - 1))
                    {
                        return 0;
                    }

                    amountoftarget_not_acheived = perweak_target - amountoftarget_achieved;
                    notachivedPercent = (float)amountoftarget_not_acheived / (float)(perweak_target);

                    fltdeductions = perweakweightage_amount * notachivedPercent;
                    rtdeduction = (int)fltdeductions;

                    return rtdeduction;

                }
                catch (Exception ex)
                { }


            }
            if (targetevalon == "Monthly")
            {
                double perweaktaramt = 0;
                perweaktaramt = (double.Parse(targetamt) / 4);
                perweak_target = (int)Math.Round(perweaktaramt, 0);


                try
                {
                    if (amountoftarget_achieved > ((perweak_target) - 1))
                    {
                        return 0;
                    }

                    amountoftarget_not_acheived = perweak_target - amountoftarget_achieved;
                    notachivedPercent = (float)amountoftarget_not_acheived / (float)(perweak_target);

                    fltdeductions = perweakweightage_amount * notachivedPercent;
                    rtdeduction = (int)fltdeductions;

                    return rtdeduction;

                }
                catch (Exception ex)
                { }

            }

        }

        if (evalon == "Monthly")
        {

            float permonweightage_amount = ((float.Parse(userbasicpay)) * (float)target_deduction_percentage) / 100;

            string mon = salarydate.Substring(0, 2);
            string day = salarydate.Substring(3, 2);
            if (mon == "02")
            {
                if (day != "28")
                {
                    return 0;
                }

            }
            if (mon == "01" || mon == "03" || mon == "05" || mon == "07" || mon == "08" || mon == "10" || mon == "12")
            {
                if (day != "31")
                {
                    return 0;
                }

            }
            else
            {
                if (day != "30")
                {
                    return 0;
                }

            }

            amountoftarget_achieved = objwelcome.gettarget_achievedcount(target, salarydate, Session["UserName"].ToString(), "monthly");



            if (targetevalon == "Daily")
            {
                double permontaramt = 0;
                permontaramt = (double.Parse(targetamt) * double.Parse(userworkingdays));
                permon_tagert = (int)Math.Round(permontaramt, 0);

                try
                {
                    if (amountoftarget_achieved > ((permon_tagert) - 1))
                    {
                        return 0;
                    }

                    amountoftarget_not_acheived = permon_tagert - amountoftarget_achieved;
                    notachivedPercent = (float)amountoftarget_not_acheived / (float)(permon_tagert);

                    fltdeductions = permonweightage_amount * notachivedPercent;
                    rtdeduction = (int)fltdeductions;

                    return rtdeduction;

                }
                catch (Exception ex)
                { }


            }
            if (targetevalon == "Weekly")
            {
                double permontaramt = 0;
                permontaramt = (double.Parse(targetamt) * 4);
                permon_tagert = (int)Math.Round(permontaramt, 0);

                try
                {
                    if (amountoftarget_achieved > ((permon_tagert) - 1))
                    {
                        return 0;
                    }

                    amountoftarget_not_acheived = permon_tagert - amountoftarget_achieved;
                    notachivedPercent = (float)amountoftarget_not_acheived / (float)(permon_tagert);

                    fltdeductions = permonweightage_amount * notachivedPercent;
                    rtdeduction = (int)fltdeductions;

                    return rtdeduction;

                }
                catch (Exception ex)
                { }


            }
            if (targetevalon == "Monthly")
            {
                double permontaramt = 0;
                permontaramt = (double.Parse(targetamt));
                permon_tagert = (int)Math.Round(permontaramt, 0);

                try
                {
                    if (amountoftarget_achieved > ((permon_tagert) - 1))
                    {
                        return 0;
                    }

                    amountoftarget_not_acheived = permon_tagert - amountoftarget_achieved;
                    notachivedPercent = (float)amountoftarget_not_acheived / (float)(permon_tagert);

                    fltdeductions = permonweightage_amount * notachivedPercent;
                    rtdeduction = (int)fltdeductions;

                    return rtdeduction;

                }
                catch (Exception ex)
                { }

            }

        }

        return rtdeduction;
    }


    protected void btn_decline_Click(object sender, EventArgs e)
    {
        Response.Redirect("../../MCTX_General/Logout.aspx");

    }


    #region welcomescreen add by mubashir

    [WebMethod]
    public static Dictionary<string, object> getvalues()
    {

        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionstring2"].ToString()))
        {

            SqlCommand cmd = new SqlCommand("select * from tbl_homesettings order by 1 desc", cn);
            cn.Open();
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataSet ds = new DataSet();
            da.Fill(ds, "settings");
            DataTable dt = new DataTable();
            dt = ds.Tables["settings"];
            return ToJson(dt);
        }
    }

    [WebMethod]
    public static Dictionary<string, object> gettitle()
    {

        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionstring2"].ToString()))
        {

            SqlCommand cmd = new SqlCommand("select * from tbl_homesettingstitle order by 1 desc", cn);
            cn.Open();
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataSet ds = new DataSet();
            da.Fill(ds, "title");
            DataTable dt = new DataTable();
            dt = ds.Tables["title"];
            return ToJson(dt);
        }
    }
    #endregion
}

using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Sales_DAL;
using System.Collections;
using System.Data;

namespace Sales_BOL
{
    public class _Welcome
    {
        Dlayer objDA = new Dlayer();
        public DataTable dt_targetdetails = new DataTable();
        public DataTable dt_userinfo = new DataTable();
        public string startenddate = "";

        public void getTargetdetails(string userid)
        {
            string query = "select tt.tt_name as [Target Type],tts.actual_target as [Target Amount],tts.Evaluation_on as [Evaluation On] " +
                           "from setting as st Join tbl_TargetSetting as tts on st.setting_id = tts.setting_id " +
                           "Join tbl_targettype as tt on  tts.tt_id = tt.tt_id " +
                           "where user_id = '" + userid + "' and isnull(st.deleted,0)<>1";

            dt_targetdetails = objDA.DA_getTable(query);

            string query2 = "select top 1 convert(varchar(12),startdate,101) as [Start Date], " +
                            "convert(varchar(12),enddate,101) as [End Date] from setting " +
                            "where user_id ='" + userid + "' and isnull(deleted,0)<>1 order by startdate desc";

            DataTable dt = objDA.DA_getTable(query2);
            if (dt.Rows.Count != 0)
            {
                startenddate = dt.Rows[0][0].ToString() + " - to - " + dt.Rows[0][1].ToString();
            }
        }
        public int gettarget_achievedcount(string target, string salarydate, string userid, string initaildate)
        {
            int acheivedcount = 0;

            string querydaily = "";
            string queryweekly = "";
            string querymonthly = "";
            DataTable dt = new DataTable();

            if (target != "Sale" && target != "Reporting")
            {

                querydaily = "select count(*) as AchievedCount from visit as v " +
                               "join tbl_TargetType as tt on tt.tt_id = v.typeofvisit_id " +
                               "where v.userid = '" + userid + "' " +
                               "and tt.tt_name = '" + target + "' " +
                               "and convert(varchar(15),VisitDate,101) = '" + salarydate + "'";

                queryweekly = "select count(*) as AchievedCount from visit as v " +
                               "join tbl_TargetType as tt on tt.tt_id = v.typeofvisit_id " +
                               "where v.userid = '" + userid + "' " +
                               "and tt.tt_name = '" + target + "' " +
                               "and convert(varchar(15),VisitDate,101) between '" + initaildate + "' and '" + salarydate + "'";

                querymonthly = "select count(*) as AchievedCount from visit as v " +
                                "join tbl_TargetType as tt on tt.tt_id = v.typeofvisit_id " +
                                "where v.userid = '" + userid + "' " +
                                "and tt.tt_name = '" + target + "' " +
                                "and DATEPART(mm,VisitDate) = DATEPART(mm," + salarydate + ") ";
            }
            else if (target == "Reporting")
            {
                querydaily = "select * from DailyReport " +
                             "where user_id = '" + userid + "' " +
                             "and Convert(varchar(20),CurrentDate,101) = '" + salarydate + "'";
            }

            else
            {
                querydaily = "select isnull(sum(total_Sale),0) as AchievedCount from visit as v " +
                             "join tbl_TargetType as tt on tt.tt_id = v.typeofvisit_id " +
                             "where v.userid = '" + userid + "' " +
                             "and convert(varchar(15),VisitDate,101) = '" + salarydate + "'";

                queryweekly = "select isnull(sum(total_Sale),0) as AchievedCount from visit as v " +
                                     "join tbl_TargetType as tt on tt.tt_id = v.typeofvisit_id " +
                                     "where v.userid = '" + userid + "' " +
                                     "and convert(varchar(15),VisitDate,101) between '" + initaildate + "' and '" + salarydate + "'";

                querymonthly = "select isnull(sum(total_Sale),0) as AchievedCount from visit as v " +
                                       "join tbl_TargetType as tt on tt.tt_id = v.typeofvisit_id " +
                                       "where v.userid = '" + userid + "' " +
                                       "and DATEPART(mm,VisitDate) = DATEPART(mm,'" + salarydate + "') ";

            }

            if (initaildate == "")
            {
                dt = objDA.DA_getTable(querydaily);
            }
            else if (initaildate == "monthly")
            {
                dt = objDA.DA_getTable(querymonthly);
            }
            else
            {
                dt = objDA.DA_getTable(queryweekly);
            }

            try
            {
                if (target != "Sale" && target != "Reporting")
                {
                    acheivedcount = int.Parse(dt.Rows[0][0].ToString());
                }
                else if (target == "Reporting")
                {
                    try
                    {
                        acheivedcount = dt.Rows.Count;
                    }
                    catch (Exception ex)
                    {

                        //throw;
                    }

                }
                else
                {
                    float ach_count = float.Parse(dt.Rows[0][0].ToString());
                    acheivedcount = (int)ach_count;
                }
            }
            catch (Exception Ex)
            { }
            return acheivedcount;

        }

        public int get_ldayTargetAmount(string target, string date, string userid)
        {
            int amount = 0;
            string query = "";
            DataTable dt = new DataTable();

            if (target != "Sale" && target != "Reporting")
            {

                query = "select count(*) as AchievedCount from visit as v " +
                        "join tbl_TargetType as tt on tt.tt_id = v.typeofvisit_id " +
                        "where v.userid = '" + userid + "' " +
                        "and tt.tt_name = '" + target + "' " +
                        "and convert(varchar(15),VisitDate,101) = '" + date + "'";
            }
            else if (target == "Reporting")
            {
                query = "select * from DailyReport " +
                             "where user_id = '" + userid + "' " +
                             "and Convert(varchar(20),CurrentDate,101) = '" + date + "'";
            }
            else
            {
                query = "select isnull(sum(total_Sale),0) as AchievedCount from visit as v " +
                        "join tbl_TargetType as tt on tt.tt_id = v.typeofvisit_id " +
                        "where v.userid = '" + userid + "' " +
                        "and convert(varchar(15),VisitDate,101) = '" + date + "'";

            }

            dt = objDA.DA_getTable(query);
            try
            {
                if (target != "Sale" && target != "Reporting")
                {
                    amount = int.Parse(dt.Rows[0][0].ToString());
                }
                else if (target == "Reporting")
                {
                    try
                    {
                        amount = dt.Rows.Count;
                    }
                    catch (Exception ex)
                    {

                        //throw;
                    }

                }
                else
                {
                    float ach_count = float.Parse(dt.Rows[0][0].ToString());
                    amount = (int)ach_count;
                }
            }
            catch (Exception Ex)
            { }
            return amount;


        }

        public int get_MTDTargetamount(string target, string date, string userid)
        {
            int amount = 0;
            string query = "";
            DataTable dt = new DataTable();

            if (target != "Sale" && target != "Reporting")
            {

                query = "select count(*) as AchievedCount from visit as v " +
                               "join tbl_TargetType as tt on tt.tt_id = v.typeofvisit_id " +
                               "where v.userid = '" + userid + "' " +
                               "and tt.tt_name = '" + target + "' " +
                               "and DATEPART(mm,VisitDate) = DATEPART(mm,'" + date + "') ";
            }
            else if (target == "Reporting")
            {
                query = "select * from DailyReport " +
                             "where user_id = '" + userid + "' " +
                             "and DATEPART(mm,CurrentDate) = DATEPART(mm,'" + date + "') ";
            }
            else
            {
                query = "select isnull(sum(total_Sale),0) as AchievedCount from visit as v " +
                        "join tbl_TargetType as tt on tt.tt_id = v.typeofvisit_id " +
                        "where v.userid = '" + userid + "' " +
                        "and DATEPART(mm,VisitDate) = DATEPART(mm,'" + date + "') ";

            }

            dt = objDA.DA_getTable(query);
            try
            {
                if (target != "Sale" && target != "Reporting")
                {
                    amount = int.Parse(dt.Rows[0][0].ToString());
                }
                else if (target == "Reporting")
                {
                    try
                    {
                        amount = dt.Rows.Count;
                    }
                    catch (Exception ex)
                    {

                        //throw;
                    }

                }
                else
                {
                    float ach_count = float.Parse(dt.Rows[0][0].ToString());
                    amount = (int)ach_count;
                }
            }
            catch (Exception Ex)
            { }
            return amount;

        }

        public void getbasicpay(string userid)
        {

            string query = "select e.BasicSalary,e.ConvenceAllowence,e.MobileAllowence,e.MiscAllowence,e.WorkingDays " +
                           "from Tbl_Employee as e " +
                           "Join user1 as u on u.E_badge = e.E_badge " +
                           "where u.user_id = '" + userid + "'";

            dt_userinfo = objDA.DA_getTable(query);


        }

        public string getlastsaldate(string userid)
        {
            string lastdate = "";

            string query = "select top 1 convert(varchar(15),salary_date,101) as saldate from tbl_salary where isnull(today_salary,0) <> 0 " +
                           " and user_id = '" + userid + "' order by salary_date desc";
            DataTable dt = objDA.DA_getTable(query);



            try
            {
                lastdate = dt.Rows[0][0].ToString();
                //if (dt.Rows.Count < 0)

            }
            catch (Exception ex)
            { lastdate = "08/15/2010"; }
            return lastdate;

        }


        public string getlastsalary(string userid)
        {
            string lastsal = "";

            string query = "select top 1 today_salary from tbl_salary where user_id = '" + userid + "' and isnull(today_salary,0) <> 0 " +
                           "order by salary_date desc ";
            DataTable dt = objDA.DA_getTable(query);

            try
            {
                lastsal = dt.Rows[0][0].ToString();

            }
            catch (Exception ex)
            { lastsal = ""; }
            return lastsal;

        }

        public int insert_deductions(string salary_date, string deduction_on_salary, string deduction_on_commission,
string total_deductions, string today_salary, string user_id)
        {
            int flag = 0;
            int status = 0;

            string checkquery = "select * from tbl_salary where convert(varchar(15),salary_date,101) = '" + salary_date + "' and user_id = '" + user_id + "'";
            DataTable dt_new = objDA.DA_getTable(checkquery);
            if (dt_new.Rows.Count > 0)
            {
                flag = 1;
            }

            string insertquery = "insert into tbl_salary(salary_date,deduction_on_salary,deduction_on_commission, " +
                           "total_deductions,today_salary,user_id,user_Holiday) " +
                           "Values('" + salary_date + "'," + deduction_on_salary + "," + deduction_on_commission + "," + total_deductions +
                           "," + today_salary + ",'" + user_id + "',0)";
            string updatequery = "update tbl_salary " +
                                 "set deduction_on_salary = " + deduction_on_salary + ", " +
                                 "deduction_on_commission = " + deduction_on_commission + ", " +
                                 "total_deductions = " + total_deductions + ", " +
                                 "today_salary = " + today_salary + " " +
                                 "where convert(varchar(15),salary_date,101) = '" + today_salary + "' and user_id = '" + user_id + "'";

            if (flag == 0)
            {
                status = objDA.insertquery(insertquery);
            }
            else
            {
                status = objDA.insertquery(updatequery);
            }

            return status;
        }

        public string gettotaldeductions(string userid)
        {
            string totaldedcut = "";

            string query = "select sum(total_deductions) from tbl_salary where user_Holiday = 0 and user_id = '" + userid + "' and Datepart(mm,salary_date)= Datepart(mm,getdate())";
            DataTable dt = objDA.DA_getTable(query);

            try
            {
                totaldedcut = dt.Rows[0][0].ToString();

            }
            catch (Exception ex)
            { totaldedcut = ""; }

            return totaldedcut;



        }
        public string get_deduction_on_sal(string userid)
        {
            string deduction_on_sal = "";

            string query = "select sum(deduction_on_salary) from tbl_salary where user_Holiday = 0 and user_id = '" + userid + "'and Datepart(mm,salary_date)= Datepart(mm,getdate())";
            DataTable dt = objDA.DA_getTable(query);

            try
            {
                deduction_on_sal = dt.Rows[0][0].ToString();

            }
            catch (Exception ex)
            { deduction_on_sal = ""; }

            return deduction_on_sal;

        }
        public string get_Pending_Prospecting(string userid)
        {
            string pending_Pros = "0";

            string query = "select count(*) as Pending_Prospecting from tbl_Prospecting " +
                           "where [user_id] like '" + userid + "' and " +
                           "Visit_Status = 'Pending' and " +
                           "convert(varchar(15),Booking_date,101) > DATEADD(day,-90,convert(varchar(15),getdate(),101))";

            DataTable dt = objDA.DA_getTable(query);
            try
            {
                pending_Pros = dt.Rows[0][0].ToString();

            }
            catch (Exception ex)
            { pending_Pros = "0"; }

            return pending_Pros;

        }




    }
}

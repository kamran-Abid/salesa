using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Sales_DAL;
using System.Data;
using System.Collections;

namespace Sales_BOL
{
    public class _DailyOutput
    {
        #region Variables
        string query = "";
        Dlayer objDA = new Dlayer();
        #endregion

        #region Methods
        public DataTable fnGetEmpName(string userid)
        {
            query = "Select E_Name from Tbl_Employee Where E_badge = (Select E_badge From user1 where user_id = '"+userid+"')";
            DataTable dt_Name = objDA.DA_getTable(query);
            return dt_Name;
        }
        public int fnAddDailyOutput(string TimeIn, string UserId, string timeFrom, string timeTo, string Actualtime, 
            string activity, string hour)
        {

            query = "insert into DailyReport([Time-In],user_id,CurrentDate)" +
                  " values('" + TimeIn + "','" + UserId + "',getdate())";

            int result = objDA.insertquery(query);

            if( result > 0)
            {
                query = "select top 1 DailyReport_ID from DailyReport order by 1 desc";
                DataTable dt_Name = objDA.DA_getTable(query);

                string reportId = dt_Name.Rows[0][0].ToString();

                
                    //query = "insert into ReportDetails(TaskDetails,DailyReport_ID) values('" + activities[i] + "', " + reportId + " )";
                int result2 = fnAddDailyOutput1(timeFrom, timeTo, Actualtime, activity, hour, reportId);
                
            }
            return result;
        }

        public int fnAddDailyOutput1(string timeFrom, string timeTo, string Actualtime, 
            string activity, string hour, string reportid)
        {
            int Result = 0;
            string query = "insert into ReportDetails(TaskDetails,DailyReport_ID,fromTime,toTime,rptTime,hourNo) " +
                            "values ('" + activity + "'," + reportid + ",'" + timeFrom + "','" + timeTo + "','" + Actualtime + "'," + hour + ")";
            string delQuery = "delete from ReportDetails where DailyReport_Id = " + reportid + " and hourNo = " + hour + "";

            Result = objDA.insertquery(delQuery);
            Result = objDA.insertquery(query);
            return Result;
        }
        //public int fnAddDailyOutput2(string timeFrom, string timeTo, string Actualtime,
        //    string activity, string hour, string reportid)
        //{
        //    int Result = 0;
        //    string query = "insert into ReportDetails(TaskDetails, DailyReport_ID, fromTime, toTime, rptTime, hourNo) " +
        //        "values ('" + activity + "', '" + reportid + "','" + timeFrom + "','" + timeTo + "','" + Actualtime + "'," + hour + ")";
        //    Result = objDA.insertquery(query);
        //    return Result;
        //}

        public int fnAddDailyOutputFinal(string TimeOut, string reportid, string MyPerformance, string AskToSenior)
        {
            int Result = 0;
            string query = "update DailyReport set [Time-Out] = '"+TimeOut+"',MyOutPut = '"+MyPerformance+"',ContactedSenior = '"+AskToSenior+"' where DailyReport_ID = "+reportid+"";
            Result = objDA.insertquery(query);
            return Result;
        }


        public DataTable UserOutPut(string userid, string fromdate, string todate)
        {
            DataTable dt_new = new DataTable();
            string query = " select DR.DailyReport_ID, Convert(varchar(25),DR.[Time-In],108) as [Time-In] ,DR.MyOutput"+
                ",Convert(varchar(25),DR.[Time-Out],108) as [Time-Out] ,DR.[user_id],te.E_Name from DailyReport as DR Join user1 as ur on DR.user_id = ur.user_id " +
                           " Join tbl_employee as te on te.E_badge = ur.E_badge "+
                           " where DR.user_id = '"+userid+"'"+
                           " and DR.CurrentDate between '"+fromdate+"' and '"+todate+"' ";
            dt_new = objDA.DA_getTable(query);
            return dt_new;
        
        }
        public DataTable ReturnTodayReport(string userid)
        {
            DataTable dt = new DataTable();
            string query = "select * from DailyReport where user_id = '"+userid+"' and convert(varchar(20),currentdate,101) = convert(varchar(20),getdate(),101)";
            dt = objDA.DA_getTable(query);
            return dt;
        }

        public DataTable ReturnTodayDetailReport(string RptId)
        {
            DataTable dt = new DataTable();
            string query = "select * from ReportDetails where DailyReport_Id = " + RptId + " order by hourNo";
            dt = objDA.DA_getTable(query);
            return dt;
        }

        public int fnAddDailyOutput1(string timeFrom, string timeTo, string Actualtime,
            string activity, string hour, string reportid, string ReportTimeDifference)
        {
            int Result = 0;
            string query = "insert into ReportDetails(TaskDetails,DailyReport_ID,fromTime,toTime,rptTime,hourNo,rptTimeDifference) " +
                            "values ('" + activity + "'," + reportid + ",'" + timeFrom + "','" + timeTo + "','" + Actualtime + "','" + hour + "','"+ReportTimeDifference+"' )";
            Result = objDA.insertquery(query);
            return Result;
        }

        #endregion
    }
}

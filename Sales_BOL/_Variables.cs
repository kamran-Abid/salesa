using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using Sales_DAL;

namespace Sales_BOL
{
    public class _Variables
    {
        #region Variables
        Dlayer objDA = new Dlayer();
        public DataTable dt_variables = new DataTable();
        string query = "";
        #endregion

        #region Methods
        public int fnAddNewVariable(string variablename)
        {
            query = "Insert Into tbl_variables (Variablename) Values ('" + variablename + "')";
            int status = objDA.insertquery(query);
            return status;
        }
        public int fnSetVariable()
        {
            int status = 0;
            return status;
        }
        public DataTable fnGetVariables()
        {
            query = "Select * From tbl_variables";
            DataTable dt_Vars = objDA.DA_getTable(query);
            return dt_Vars;
        }
        public int fnAddVarToUser(string userid,int selectvariable,int commissionpercent,int deductionpercent, string evaluationon)
        {
            query = "Insert Into tble_uservariables (user_id,Variable_commission,variable_deduction,variable_id,Evaluation_on) Values ('" + userid + "'," + commissionpercent + "," + deductionpercent + "," + selectvariable + ",'" + evaluationon + "')";
            int result = objDA.insertquery(query);
            return result;
        }
        public int fnAddWorkingDays(string userid,int days)
        {
            query = "Update user1 Set WorkingDays = "+days+" Where user_id = '"+userid+"'";
            int result = objDA.Updatequery(query);
            return result;
        }
        public DataTable fnGetDuration()
        {
            query = "Select * From T_TargetDuration";
            DataTable dt_Duration = objDA.DA_getTable(query);
            return dt_Duration;
        }
        public void getuservariables(string userid)
        {
            string query = "select tuv.UserVariable_Id,te.E_Name as [User Name],tv.Variablename as Variable,tuv.Variable_commission as [IOC %],tuv.variable_deduction as [IOS%], tuv.Evaluation_on as [Evaluation On] " +
                            "from tble_uservariables as tuv "+
                            "join tbl_variables as tv on tv.variable_id = tuv.variable_id "+
                            "Join user1 as u on u.user_id = tuv.user_id "+
                            "Join tbl_Employee as te on te.E_badge = u.E_badge "+
                            "where tuv.user_id = '" + userid + "'";

            dt_variables = new DataTable();
            dt_variables = objDA.DA_getTable(query);
                    
        }
        public void getuservariables(string userid,int welcome)
        {
            string query = "select tv.Variablename as Variable,tuv.Variable_commission as [IOC %],tuv.variable_deduction as [IOS %], tuv.Evaluation_on as [Eval On] " +
                            "from tble_uservariables as tuv " +
                            "join tbl_variables as tv on tv.variable_id = tuv.variable_id " +
                            "Join user1 as u on u.user_id = tuv.user_id " +
                            "Join tbl_Employee as te on te.E_badge = u.E_badge " +
                            "where tuv.user_id = '" + userid + "'";

            dt_variables = new DataTable();
            dt_variables = objDA.DA_getTable(query);

        }
        public int fnDeleteVariable(int row_id)
        {
            query = "Delete From tble_uservariables Where UserVariable_Id = "+row_id;
            int result = objDA.DeleteQuery(query);
            return result;
        }
        public int fnAddUserWorkingDays(string userID,string Day,int StatusValue,int weekID)
        {
            query = "Insert Into WorkingDays (user_id,Day,Status,week) Values ('" + userID +"','"+Day+"',"+StatusValue+","+weekID+")";
            int result = objDA.insertquery(query);
            return result;
        }
        public DataTable fnGetUserNames()
        {
            query = "Select te.E_Name,tu.user_id From Tbl_Employee as te Join user1 as tu on te.E_badge = tu.E_badge Where tu.role_id in (1,2,3)";
            DataTable dt_Users = objDA.DA_getTable(query);
            return dt_Users;
        }
        public int fnGetRows(string userid)
        {
            query = "Select * From WorkingDays Where user_id = '" + userid + "'";
            DataTable dt_Rows = objDA.DA_getTable(query);
            int rows = dt_Rows.Rows.Count;
            return rows;
        }
        public int fnUpdateWorkingDays(string userID,string Day,int StatusValue)
        {
            //query = "Update WorkingDays Set Day ='"+Day+"', Status = "+StatusValue+", week = "+weekID+" Where user_id = '"+userID+"' AND week = "+weekID+"";
            query = "Update WorkingDays Set Status = " + StatusValue + " Where user_id = '" + userID + "' And Day = '"+Day+"'";
            int result = objDA.Updatequery(query);
            return result;
        }
        public DataTable fnGetWorkDaysData(string user)
        {
            query = "Select Day,Status From WorkingDays Where user_id = '" + user + "'";
            DataTable dt_WorkData = objDA.DA_getTable(query);
            return dt_WorkData;
        }
        public int fnAddDays(string userid,int days)
        {
            query = "Update user1 Set WorkingDays = "+days+" Where user_id = '"+userid+"'";
            int result = objDA.insertquery(query);
            return result;
        }
        public int fnAddHoliday(string userid,string holiday)
        {
            query = "Insert Into tbl_salary (salary_date,user_id,user_Holiday) Values (Convert(Varchar(10),'" + holiday + "',101),'" + userid + "',1)";
            int result = objDA.Updatequery(query);
            return result;
        }
        public int fnUpdateHoliday(string userid, string holiday)
        {
            query = "Update tbl_salary Set user_Holiday = 1 Where user_id = '" + userid + "' And salary_date = Convert(Varchar(10),'" + holiday + "',101)";
            int result = objDA.Updatequery(query);
            return result;
        }
        public int fnGetLeaveRows(string userid,string date)
        {
            int result = 0;
            query = "Select salary_date from tbl_salary Where user_id = '"+userid+"' And salary_date = Convert(Varchar(10),'"+date+"',101)";
            DataTable dt_Leaves = objDA.DA_getTable(query);
            result = dt_Leaves.Rows.Count;
            return result;
        }
        public int fnCheckDays(string userID)
        {
            int result = 0;
            query = "Select WorkingDays From user1 Where user_id = '" + userID + "'";
            DataTable dt_Days = objDA.DA_getTable(query);
            result = dt_Days.Rows.Count;
            return result;
        }
        public int fnUpdateDays(string userID,int numberofdays)
        {
            query = "Update user1 Set WorkingDays = "+numberofdays+" Where user_id = '" + userID + "'";
            int result = objDA.Updatequery(query);
            return result;
        }
        #endregion
    }
}

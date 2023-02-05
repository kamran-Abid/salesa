using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using Sales_DAL;

namespace Sales_BOL
{
    public class _UserTask
    {
        #region Variables
        Dlayer objDA = new Dlayer();
        string query = "";

        #endregion

        #region Methods
        public DataTable fnGetCount(string user)
        {
            query = "Select Count(at.TaskID) as [Count],te.E_Name From AssignTask as at Right Join user1 as u on at.UserID = u.user_id Join Tbl_Employee as te on te.E_badge = u.E_badge  Group By te.E_Name";
            DataTable dt_Count = objDA.DA_getTable(query);
            return dt_Count;
        }
        public DataTable fnGetTasks(string user_id, string fromDate, string toDate, int taskStatus, string AssignBy, string statustask)
        {
            query = @" Select at.TaskID,at.UserID,at.TaskName,Convert(Varchar(10),at.TaskDate,101) as TaskDate," +
                        "at.TaskPriority,at.TaskDetail,at.AllowedTime,ts.TaskStatus_Name  ,ts.TaskStatusID " +
                        " From AssignTask as at" +
                        " Join TaskStatus as ts on at.TaskStatusID = ts.TaskStatusID " +
                        " Where ('" + user_id + "'='' or UserID = '" + user_id + "') " +
             " And ( '" + taskStatus + "'='0' or ts.TaskStatusID = '" + taskStatus + "') and ('" + AssignBy + "'='All' or TaskAssignBy = '" + AssignBy + "')" +
            " and ('' IS NULL OR  cast(at.taskDate  as date)>= CAST('" + fromDate + "' AS date) AND cast(at.EndDate  as date) < DATEADD(DD,1,CAST('" + toDate + "' AS DATE)) )";
            //if (statustask == "All" && AssignBy == "All")
            //{
            //    query = "Select at.TaskID,at.UserID,at.TaskName,Convert(Varchar(10),at.TaskDate,101) as TaskDate,"+
            //            "at.TaskPriority,at.TaskDetail,at.AllowedTime,ts.TaskStatus_Name From AssignTask as at "+
            //            "Join TaskStatus as ts on at.TaskStatusID = ts.TaskStatusID "+
            //            "Where UserID = '" + user_id + "'";
            //    //And Convert(Varchar(10),at.TaskDate,101) Between '" + fromDate + "' And '" + toDate + "'";
            //}
            //else if (statustask != "All" && AssignBy == "All")
            //{
            //    query = "Select at.TaskID,at.UserID,at.TaskName,Convert(Varchar(10),at.TaskDate,101) as TaskDate," +
            //            "at.TaskPriority,at.TaskDetail,at.AllowedTime,ts.TaskStatus_Name From AssignTask as at " +
            //            "Join TaskStatus as ts on at.TaskStatusID = ts.TaskStatusID " +
            //            "Where UserID = '"+ user_id +"'And ts.TaskStatusID = "+taskStatus+"";
            //    //And Convert(Varchar(10),at.TaskDate,101) Between '" + fromDate + "' And '" + toDate + "'";
            //}
            //else if (statustask == "All" && AssignBy != "All")
            //{
            //    query = "Select at.TaskID,at.UserID,at.TaskName,Convert(Varchar(10),at.TaskDate,101) as TaskDate," +
            //            "at.TaskPriority,at.TaskDetail,at.AllowedTime,ts.TaskStatus_Name From AssignTask as at " +
            //            "Join TaskStatus as ts on at.TaskStatusID = ts.TaskStatusID " +
            //            "Where UserID = '" + user_id + "' And at.TaskAssignBy = '" + AssignBy + "' ";
            //    //And Convert(Varchar(10),at.TaskDate,101) Between '" + fromDate + "' And '" + toDate + "'";
            //}
            //else if (statustask != "All" && AssignBy != "All")
            //{
            //    query = "Select at.TaskID,at.UserID,at.TaskName,Convert(Varchar(10),at.TaskDate,101) as TaskDate," +
            //            "at.TaskPriority,at.TaskDetail,at.AllowedTime,ts.TaskStatus_Name From AssignTask as at " +
            //            "Join TaskStatus as ts on at.TaskStatusID = ts.TaskStatusID " +
            //            "Where UserID = '" + user_id + "' And ts.TaskStatusID = " + taskStatus + "And at.TaskAssignBy = '" + AssignBy + "'";
            //    //And Convert(Varchar(10),at.TaskDate,101) Between '" + fromDate + "' And '" + toDate + "'";
            //}
            //if (toDate != "" && fromDate != "") {
            //    query = query + " and  at.TaskDate>= '"+fromDate+"'  AND at.TaskDate <= '"+toDate+"' ";
            //}
            //// Executing Query & Getting Data
            DataTable dt_Tasks = objDA.DA_getTable(query);
            return dt_Tasks;

        }
        public DataTable fnGetSpecific(string u_id, string t_id)
        {
            query = "Select TaskID,UserID,TaskName,TaskDate,EndDate,TaskPriority,TaskDetail,AllowedTime From AssignTask Where UserID = '" + u_id + "' And TaskID = '" + t_id+"'";
            DataTable dt_SPTask = objDA.DA_getTable(query);
            return dt_SPTask;
        }
        public int AddTaskRemarks(string Remarks,int TaskID,string UserId,string time)
        {
            query = "Insert Into UserRemarks (TaskID,UserId,TaskRemarks,RemarksTime) Values ("+TaskID+",'"+UserId+"','"+Remarks+"','"+time+"')";
            int result = objDA.insertquery(query);
            return result;
        }
        public DataTable fnGetAllTasks()
        {
            query = "Select distinct at.TaskID,at.TaskDetail,at.TaskName,at.AllowedTime,ur.TaskRemarks,"+
                    "Convert(Varchar(10),at.TaskDate,101) as TaskDate,Convert(Varchar(10),at.EndDate,101) "+
                    "as EndDate,te.E_Name,ts.TaskStatus_Name From AssignTask as at "+
                    "Join user1 as u on at.UserID = u.user_id "+
                    "Join Tbl_Employee as te on u.E_badge = te.E_badge "+
                    "Join TaskStatus as ts on at.TaskStatusID = ts.TaskStatusID "+
                    "Left Join UserRemarks as ur on at.TaskID = ur.TaskID";
            
            DataTable dt = objDA.DA_getTable(query);
            return dt;
        }
        public int fnAddNewTask(string TaskName,string EnterTask,string UserName,string Priority,string Time, string user_id)
        {
            query = "Insert Into AssignTask (TaskName,TaskDetail,UserID,TaskDate,TaskPriority,AllowedTime,EndDate,TaskStatusID,TaskAssignBy) Values ('" + TaskName + "','" + EnterTask + "','" + UserName + "',GetDate(),'" + Priority + "','" + Time + "'," + "DATEADD(day," + Time + ", GetDate())," + 3 + ",'"+user_id+"')";
            int result = objDA.insertquery(query);
            return result;
        }
        public DataTable fnGetUsers()
        {
            query = "Select user_id From user1";
            DataTable dt_Users = objDA.DA_getTable(query);
            return dt_Users;
        }
        public DataTable fnGetTaskStatus()
        {
            query = "Select * from TaskStatus";
            DataTable dt_TaskStatus = objDA.DA_getTable(query);
            return dt_TaskStatus;
        }

        public DataTable getTermType()
        {
            query = "select * from tbl_termsAndCondition";
            DataTable dt_TaskStatus = objDA.DA_getTable(query);
            return dt_TaskStatus;
        }

        public DataTable getTermName( int TypeName)
        {
            query = "select * from tbl_Term_Discription where TypeID="+TypeName+"";
            DataTable dt_TaskStatus = objDA.DA_getTable(query);
            return dt_TaskStatus;
        }
        public DataTable fnGetAdmins()
        {
            query = "Select user_id from user1 where role_id in (2,3)";
            DataTable dt_Admins = objDA.DA_getTable(query);
            return dt_Admins;
        }
       
        #endregion
    }
}

using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Sales_DAL;
using System.Data;
using System.Collections;

namespace Sales_BOL
{
    public class _User
    {
        #region Variables
        Dlayer objDA = new Dlayer();
        string query = "";
        public DataTable DT_Users = new DataTable();
        public DataTable DT_EmpNames = new DataTable();
        public DataTable DT_GetRoles = new DataTable();
        //public ArrayList AL_Data = new ArrayList();
        #endregion

        #region Methods
        public void fnGetUserList()
        {
            query = "Select e.E_Name,u.user_id,u.logName,st.status_name,r.role_name From user1 as u Join Tbl_Employee as e on u.E_badge = e.E_badge Join T_status as st on u.Status = st.status_id Join tbl_role as r on u.role_id = r.role_id "+  
                    "where u.Deleted = 0";
            DT_Users = objDA.DA_getTable(query);
        }
        public void fnGetRoles()
        {
            query = "Select role_name, role_id from tbl_role";
            DT_GetRoles = objDA.DA_getTable(query);
        }
        public void fnGetEmpFullName()
        {
            query = "Select E_badge,E_Name From Tbl_Employee where E_badge in (select E_badge from user1 where Deleted = 1) and Deleted = 0 or E_badge not in (select E_badge from user1)";
            //query = "Select e.E_badge,e.E_Name,u.user_id From Tbl_Employee as e Join user1 as u On e.E_badge = u.E_badge Where e.Deleted = 0 And u.Deleted = 1";
            DT_EmpNames = objDA.DA_getTable(query);
        }
        public int fnAddUser(string Emp_Id, string UserName, string Password, string ConfPwd, int Role_id)
        {
            query = "Insert Into user1 (user_id,E_badge,user_pwd,role_id,Status,Deleted) Values ('" + UserName + "','" + Emp_Id + "','" + Password + "'," + Role_id + "," + 1 + ","+ 0 +")";
            int result = objDA.insertquery(query);
            return result;
        }
        public int BoldeleteUser(string userid)
        {
            query = "Update user1 set Deleted = 2 where user_id = '" + userid + "'";
            int result = objDA.Updatequery(query);
            return result;
        
        }
        public void fnCheckUser()
        {
            query = "Select user_id from user1 where Deleted = 0 OR Deleted = 2";
            DT_Users = objDA.DA_getTable(query);
        }
        public int fnCheckAvailable(string userid)
        {
            query = "Select user_id from user1 Where user_id = '"+userid+"'";
            DataTable dt = objDA.DA_getTable(query);
            int result = dt.Rows.Count;
            return result;
        }
        #endregion
    }
}

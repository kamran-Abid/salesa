using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Sales_DAL;
using System.Data;

namespace Sales_BOL
{
    public class _changepassword
    {
        Dlayer DA = new Dlayer();
        public DataTable dt_userid = new DataTable();
        public DataTable dt_username = new DataTable();
       

        public void getUserid()
        {
            string query = "select user_id from user1 where deleted <> 1";
            dt_userid = DA.DA_getTable(query);
        }
       
        public void GETusername(string userid)
        {
            string query = "select te.E_Name from user1 as u Join Tbl_Employee as te "+
                           "on u.E_Badge = te.E_Badge "+
                           "where u.user_id = '" + userid + "' and u.Deleted <> 1 ";

            dt_username = DA.DA_getTable(query);
            
        }

        public int updatepassword(string userid, string newpass)
        {

            string query = "update user1 set user_pwd = '"+newpass+"' where user_id = '"+userid+"'";
            int status = DA.Updatequery(query);
            return status;
                    
        }


    }
}

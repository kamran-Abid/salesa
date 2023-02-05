using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Sales_DAL;
using System.Data;

namespace Sales_BOL
{
    public class _Login
    {
        #region Variables
        Dlayer obj_Dlayer = new Dlayer();
        public DataSet ds_User = new DataSet();
        DataTable dt_user = new DataTable();
        #endregion



        #region Methods
        public void connect()
        {
            obj_Dlayer.connect_to_database();
        }
        public void user_atuhentication(string username, string password)
        {
            try
            {
                ds_User = obj_Dlayer.DA_userauthentication(username, password);
            
            }
            catch (Exception ex)
            { 
                
            }
        }

       
//Implemented By Tahir Kazmi for WebLogin Authentication
  public void userAuthViaWebLogin(string userName)
        {
            try
            {
                ds_User = obj_Dlayer.UserAuthenticationViaWebLogin(userName);
            
            }
            catch (Exception ex)
            { 
                
            }
        }

        #endregion
    }
}

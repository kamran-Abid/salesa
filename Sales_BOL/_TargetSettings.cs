using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Collections;
using Sales_DAL;
using System.Data;

namespace Sales_BOL
{
    public class _TargetSettings
    {
        #region Variables
        Dlayer DA = new Dlayer();
        public ArrayList AL_Target_Types = new ArrayList();
        public ArrayList AL_Users = new ArrayList();
        ArrayList AL_TargetDuration = new ArrayList();
        public DataTable dt_DetailsTarget = new DataTable();
        public DataTable dt_targExist = new DataTable();
        string query = "";
        //public int count=0;
        #endregion

        #region Methods
        public void get_TargetTypes()
        {
            AL_Target_Types = DA.DA_getTargetstypes();
        }
        public void get_Users()
        {
            AL_Users = DA.DA_getUsers();
        }
        public string getUserName(string lname)
        {
            string FullName = DA.DA_getUserName(lname);
            return FullName;
        }
        public int fnInsertSetting(string startdate,string enddate,string user_id,string StartTime,string EndTime)
        {
            int result = 0;
            result = DA.DA_fnInsertSetting(startdate, enddate, user_id, StartTime, EndTime);
            return result;
        }
        public DataTable fnGetSettingId()
        {
            DataTable setting_id = DA.DA_fnGetSettingId();
            return setting_id;
        }
        public int fnInsertTarget(int targtype, float amount,int settingId, string EvalutionOn)
        {
            int status;
            status = DA.DA_InsertTarget(targtype, amount, settingId, EvalutionOn);
            return status;
        }
        public DataTable fnGetUsersList()
        {
            DataTable dt = DA.DA_fnGetUsersList(); 
            return dt;
        }
        public DataSet fnGetDetails(int settingid)
        {
            DataSet ds = DA.DA_fnGetDetails(settingid);
            return ds;
        }
        public ArrayList get_TarDuration()
        {
            AL_TargetDuration = DA.DA_get_TarDuration();
            return AL_TargetDuration;
        }
        public void fngetTargetSettingData(int setTar_id)
        {
            query = "select tt.tt_name,tts.actual_target,tts.Evaluation_on from setting as st Join tbl_TargetSetting as tts on st.setting_id = tts.setting_id Join tbl_targettype as tt on  tts.tt_id = tt.tt_id where st.setting_id = " + setTar_id;
            dt_DetailsTarget = DA.DA_getTable(query);
        }
        public int fnUpdateSetting(string uname,string startdate,string enddate,string starttime,string endtime,int setting_id)
        {
            query = "Update setting Set user_id = '" + uname + "'," + "startdate = '" + startdate + "'," + "enddate = '" + enddate + "'," + "StartTime = '" + starttime + "', EndTime = '" + endtime + "'"+" Where setting_id = " + setting_id;
            int result = DA.Updatequery(query);
            return result;
        }
        public int fnUpdateTarget(int tt_id, float actual_target, string Eval_on, int targetSetting_id)
        {
            query = "Update tbl_TargetSetting Set tt_id = " + tt_id + "," + "actual_target = " + actual_target + "," + "Evaluation_on = '" + Eval_on + "' Where ts_id = " + targetSetting_id;
            int result = DA.Updatequery(query);
            return result;
        }
        public DataTable fnGeTargetTypes()
        {
            query = "Select tt_id,tt_name From tbl_TargetType";
            DataTable dt = DA.DA_getTable(query);
            return dt;
        }
        public void checkexistancetarget(string username, string date)
        {
            query = "select top 1 setting_id,user_id,convert(Varchar(10),enddate,101) as enddate from setting "+
                    "where user_id = '" + username + "' and convert(Varchar(10),enddate,101) > '" + date + "' " +
                    "order by setting_id desc ";
            dt_targExist = DA.DA_getTable(query);
            
        }
        //public int fnGetTargetSettingID(int setting_id,int tt_id)
        //{
        //    query = "Select ts_id From dbo.tbl_TargetSetting Where setting_id = " + setting_id + " AND tt_id =  " + tt_id;
        //    int Value = DA.DA_SingleValue(query);
        //    return Value;
        //}
        #endregion
    }
}

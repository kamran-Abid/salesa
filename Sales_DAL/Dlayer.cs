using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data.SqlClient;
using System.Data;
using System.Collections;



namespace Sales_DAL
{
    public class Dlayer
    {
        #region Variables
        //string constr = @"Data Source= MECHATRONIX-PC\SQLEXPRESS;Initial Catalog=mechatronixlive;Integrated Security=True";
        //  string constr = @"Data Source=MECHATRONIX-PC\SQLEXPRESS;Initial Catalog=mechatronixlivedb;Integrated Security=True";
      //  string constr = @"Data Source=173.212.235.40;Initial Catalog=mechatronix_com_mechatronix;Persist Security Info=True;User Id = mecha_mechatronix; Password = mctx@1234";

        string constr = @"Data Source=MCTX-ZAFEER\SQLEXPRESS;Initial Catalog=mechatronix_com_mechatronix;User Id = sa; Password = sa@1234";

        //string constr = @"Data Source= HOME;Initial Catalog=mctx_db;Integrated Security=true";
        SqlConnection sqlcon = new SqlConnection();
        SqlCommand sqlcom = new SqlCommand();
        SqlDataAdapter sqlda = new SqlDataAdapter();
        SqlDataReader sqlrdr;
        DataSet ds = new DataSet();
        DataTable dt = new DataTable();
        ArrayList AL = new ArrayList();
        ArrayList AL_Users = new ArrayList();
        ArrayList AL_TrType = new ArrayList();
        public int totalRows = 0;
        
        #endregion

        #region Methods
        public void connect_to_database()
        {
            try
            {
                sqlcon = new SqlConnection(constr);
                sqlcon.Open();
            }
            catch (Exception ex)
            {
                ex.Message.ToString();
            }
        }
        public void dc_database()
        {
            try
            {
                sqlcon.Close();
            }
            catch (Exception ex)
            {
                ex.Message.ToString();
            }
        }
        //User Authentication Modified by Khalid 07/05/2010
        public DataSet DA_userauthentication(string username, string password)
        {
            try
            {
                connect_to_database();
                //Query Added By Khalid on 07-06-2010
                sqlda = new SqlDataAdapter("select  te.id as employeeID, u.user_id,u.user_pwd,u.role_id,te.E_name," +
                                           "u.Status,u.logName,r.role_id,r.role_name from user1 as u " +
                                           "join tbl_role as r on u.role_id=r.role_id " +
                                           "join tbl_Employee as te on u.E_badge = te.E_badge " +
                                           "where u.user_id = '" + username + "'" +
                                           "and u.status <> 3 " +
                                           "and u.user_pwd = '" + password + "' " +
                                           "and u.Deleted = 0 and te.deleted = 0", sqlcon);
                sqlda.Fill(ds, "User_information");
                dc_database();
            }
            catch (Exception ex)
            {
                ex.Message.ToString();
            }
            return ds;
        }

        //User Authentication via web login Implemented by Tahir Kazmi 17/08/2011
        public DataSet UserAuthenticationViaWebLogin(string username)
        {
            try
            {
                connect_to_database();
                
                sqlda = new SqlDataAdapter("select u.user_id,u.user_pwd,u.role_id,te.E_name," +
                                           "u.Status,u.logName,r.role_id,r.role_name from user1 as u " +
                                           "join tbl_role as r on u.role_id=r.role_id " +
                                           "join tbl_Employee as te on u.E_badge = te.E_badge " +
                                           "where u.user_id = '" + username + "'" +
                                           "and u.status <> 3 " +                                           
                                           "and u.Deleted = 0 and te.deleted = 0", sqlcon);
                sqlda.Fill(ds, "UserViaWebLogin");
                dc_database();
            }
            catch (Exception ex)
            {
                ex.Message.ToString();
            }
            return ds;
        }



        public DataSet DA_GETPopUpGridData()
        {
            try
            {
                connect_to_database();
                // Query Added by Awais on 09-06-2010
                sqlda = new SqlDataAdapter("Select tbl_TargetType.tt_name,count(tbl_TargetType.tt_name),setting.startdate,setting.enddate From tbl_TargetSetting INNER JOIN setting ON tbl_TargetSetting.setting_id=setting.setting_id INNER JOIN tbl_TargetType ON tbl_TargetType.tt_id=tbl_TargetSetting.tt_id GROUP BY tbl_TargetType.tt_name", sqlcon);
                sqlda.Fill(ds, "User_Target_information");
                dc_database();
                //The objects "tbl_TargetSetting" and "tbl_TargetSetting" in the FROM clause have the same exposed names. Use correlation names to distinguish them.
            }
            catch(Exception ex)
            {
                ex.Message.ToString();
            }
            return ds;
        }
        public ArrayList DA_getTargetstypes()
        {
            try
            {
                connect_to_database();
                sqlcom.CommandType = CommandType.Text;
                sqlcom = new SqlCommand("select tt_name from tbl_TargetType where Deleted = 1", sqlcon);

                sqlrdr = sqlcom.ExecuteReader();

                if (sqlrdr.HasRows)
                {
                    while(sqlrdr.Read())
                    AL.Add(sqlrdr[0].ToString());
                }
                dc_database();
            }
            catch (Exception ex)
            {
                dc_database();
                ex.Message.ToString();
            }

            return AL;
        }
        public ArrayList DA_getUsers()
        {
            try
            {
                connect_to_database();
                sqlcom.CommandType = CommandType.Text;
                sqlcom = new SqlCommand("select user_id from user1 where Deleted = 0", sqlcon);
                sqlrdr = sqlcom.ExecuteReader();

                if (sqlrdr.HasRows)
                {
                    while (sqlrdr.Read())
                        AL_Users.Add(sqlrdr[0].ToString());
                }
                dc_database();
            }
            catch (Exception ex)
            {
                dc_database();
                ex.Message.ToString();
            }

            return AL_Users;
        }
        public string DA_getUserName(string lname)
        {
            string FullName = "";
            try
            {
                connect_to_database();
                sqlcom.CommandType = CommandType.Text;
                sqlcom = new SqlCommand("select te.E_Name From Tbl_Employee as te join user1 as u on te.E_badge = u.E_badge where u.user_id = '" + lname + "'", sqlcon);
                sqlrdr = sqlcom.ExecuteReader();

                if (sqlrdr.HasRows)
                {
                    while (sqlrdr.Read())
                        FullName = sqlrdr[0].ToString();
                }
                dc_database();
            }
            catch (Exception ex)
            {
                dc_database();
                ex.Message.ToString();
            }
            return FullName;
        }
        public int DA_fnInsertSetting(string startDate, string endDate, string uname, string startTime, string endTime)
        {
            int status = 0;
            try
            {
                connect_to_database();
                sqlcom.CommandType = System.Data.CommandType.Text;
                sqlcom.CommandText = "INSERT INTO setting (startdate, enddate,user_id,StartTime,EndTime) VALUES ('" + startDate + "','" + endDate + "','" + uname + "','" + startTime + "','" + endTime + "'" + ")";
                sqlcom.Connection = sqlcon;
                // Executing Query
                status = sqlcom.ExecuteNonQuery();
                return status;
            }
            catch (Exception ex)
            {
                ex.Message.ToString();
            }
            return status;
        }
        public DataTable DA_fnGetSettingId()
        {
            try
            {
                sqlcon = new SqlConnection(constr);
                string query = "Select MAX(setting_id) from setting";
                sqlda = new SqlDataAdapter(query, sqlcon);
                sqlda.Fill(ds, "Setting_ID");
            }
            catch (Exception ex)
            {
                ex.Message.ToString();
            }
            return ds.Tables[0];
        }
        public int DA_InsertTarget(int targtype, float amount,int settingId, string EvalutionOn)
        {
            int status = 0;
            try
            {
                connect_to_database();
                sqlcom.CommandType = System.Data.CommandType.Text;
                sqlcom.CommandText = "INSERT INTO tbl_TargetSetting (tt_id,actual_target,setting_id,Evaluation_on) VALUES (" + targtype + "," + amount + "," + settingId + ",'" + EvalutionOn + "'" + ")";
                sqlcom.Connection = sqlcon;
                // Executing Query
                status = sqlcom.ExecuteNonQuery();
                dc_database();
                return status;
            }
            catch(Exception ex)
            {
                ex.Message.ToString();
            }
            return status;
        }
        public DataTable DA_fnGetUsersList()
        {
            try
            {
                ds = new DataSet();
                sqlcon = new SqlConnection(constr);
                sqlda = new SqlDataAdapter("select st.setting_id,CONVERT(VARCHAR(10),startdate,101) as startdate,CONVERT(VARCHAR(10),enddate,101) as enddate,E_Name from dbo.user1 as usr join setting as st on st.user_id = usr.user_id join Tbl_Employee as emp on emp.E_badge = usr.e_badge where usr.deleted=0 order by st.setting_id desc ", sqlcon);
                //sqlda = new SqlDataAdapter("Select setting.user_id,setting.startdate,setting.enddate,tbl_Employee.E_Name From setting INNER JOIN tbl_Employee ON setting.user_id=tbl_Employee.logname", sqlcon);
                sqlda.Fill(ds, "User_List_information");
            }
            catch (Exception ex)
            {
                ex.Message.ToString();
                return null;
            }
            return ds.Tables[0];

        }
        public DataSet DA_fnGetDetails(int settingid)
        {
            try
            {
                sqlcon = new SqlConnection(constr);
                //string query = "select actual_target,td_name,tt.tt_name,st.startdate,st.enddate from dbo.tbl_TargetSetting as ts join dbo.tbl_TargetType as tt on tt.tt_id = ts.tt_id join dbo.T_TargetDuration as td on td.td_id = ts.tt_id join setting as st on st.setting_id = ts.setting_id where st.user_id = '" + username + "' AND (st.startdate <= getdate()) AND (st.enddate >= getdate())";
                string query = "select u.user_id,te.E_Name,Convert(varchar(15),st.startdate,101) as startdate,Convert(varchar(15),st.enddate,101) as enddate, " +
                                "IsNull(Convert(varchar(10),st.StartTime,108),'09:30:00') as StartTime,IsNull(Convert(varchar(10),st.EndTime,108),'17:30:00') as EndTime from tbl_Employee as te " +
                                "Join user1 as u on te.E_badge = u.E_badge " +
                                "Join setting as st on u.user_id = st.user_id " +
                                "where st.setting_id = " + settingid + "";
                
                sqlda = new SqlDataAdapter(query, sqlcon);
                sqlda.Fill(ds, "Target_information");

                query = "select tt.tt_name,tts.actual_target,tts.ts_id,tts.Evaluation_on " +
                        "from setting as st "+
                        "Join tbl_TargetSetting as tts on st.setting_id = tts.setting_id "+
                        "Join tbl_targettype as tt on  tts.tt_id = tt.tt_id "+
                        "where st.setting_id = " + settingid + "";

                sqlda = new SqlDataAdapter(query, sqlcon);
                sqlda.Fill(ds, "Targetdetails_information");


            }
            catch (Exception ex)
            {
                ex.Message.ToString();
                return null;
            }
            return ds;
            //return null;
        }
        public DataTable DA_fnGetProspecting()
        {
            try
            {
                sqlcon = new SqlConnection(constr);
                string query = "select com.comp_name, cl.client_name, cl.client_designation," +
               "client_phone,pr.Target_products,convert(Varchar(10),pr.booking_date,101) as Bookingdate," +
               "convert(Varchar(10),pr.Reserverd_date,101) as reserverddate ,pr.visit_status,te.E_Name " +
               "from tbl_prospecting as pr " +
               "Join tbl_company as com on pr.comp_id = com.comp_id " +
               "Join client as cl on pr.client_id = cl.client_id " +
               "Join user1 as u on pr.user_id = u.user_id " +
               "Join tbl_employee as te on u.E_badge = te.E_badge " +
               "where cl.client_name <> '' " +
               "order by pr.Prospecting_id desc";
                sqlda = new SqlDataAdapter(query, sqlcon);
                sqlda.Fill(ds, "Prospecting_List_information");
            }
            catch (Exception ex)
            {
                ex.Message.ToString();
                return null;
            }
            return ds.Tables[0];
        }
        public ArrayList DA_get_TarDuration()
        {
            try
            {
                connect_to_database();
                sqlcom.CommandType = CommandType.Text;
                sqlcom = new SqlCommand("select td_name from T_TargetDuration", sqlcon);
                sqlrdr = sqlcom.ExecuteReader();

                if (sqlrdr.HasRows)
                {
                    while (sqlrdr.Read())
                        AL_TrType.Add(sqlrdr[0].ToString());
                    
                }
                dc_database();
            }
            catch (Exception ex)
            {
                dc_database();
                ex.Message.ToString();
            }

            return AL_TrType;
        }
        public int DA_fnGetDoneTargets()
        {
            int targets = 0;
            try
            {
                connect_to_database();
                sqlcom.CommandType = CommandType.Text;
                sqlcom = new SqlCommand("", sqlcon);
                sqlrdr = sqlcom.ExecuteReader();
                if (sqlrdr.HasRows)
                {
                    targets = int.Parse(sqlrdr[0].ToString());
                }
                dc_database();
            }
            catch (Exception ex)
            {
                dc_database();
                ex.Message.ToString();
            }
            return targets;
        }
        
        public int DA_fnInsertDept(int br_id, string DeptName, string Phone1, string Phone2, string Address)
        {
            int status = 0;
            try
            {
                connect_to_database();
                sqlcom.CommandType = System.Data.CommandType.Text;
                sqlcom.CommandText = "INSERT INTO Tbl_Department (D_NAME,D_Address,D_Phone,D_Phone2,BRID) VALUES ('" + DeptName + "','" + Address + "','" + Phone1 + "','" + Phone2 + "','" + br_id + "')";
                sqlcom.Connection = sqlcon;
                // Executing Query
                status = sqlcom.ExecuteNonQuery();
                dc_database();
                return status;
            }
            catch (Exception ex)
            {
                ex.Message.ToString();
            }
            return status;
        }
        public int DA_fnInsertDesignation(string desgnation)
        {
            int status = 0;
            try
            {
                connect_to_database();
                sqlcom.CommandType = System.Data.CommandType.Text;
                sqlcom.CommandText = "INSERT INTO Tbl_Designation (Desig_Name) VALUES ('" + desgnation + "')";
                sqlcom.Connection = sqlcon;
                // Executing Query
                status = sqlcom.ExecuteNonQuery();
                dc_database();
                return status;
            }
            catch (Exception ex)
            {
                ex.Message.ToString();
            }
            return status;
        }
        public DataTable DA_fnGetEmployees()
        {
            try
            {
                sqlcon = new SqlConnection(constr);
                sqlda = new SqlDataAdapter("Select emp.E_badge,emp.E_Name,des.Desig_Name,dep.D_NAME From Tbl_Employee as emp join Tbl_Designation as des on emp.Ds_id = des.ID join Tbl_Department as dep on emp.Dp_id = dep.D_ID", sqlcon);
                sqlda.Fill(ds, "Employees_information");
            }
            catch (Exception ex)
            {
                ex.Message.ToString();
                return null;
            }
            return ds.Tables[0];
        }
        public ArrayList DA_fnGetDepartments()
        {
            ArrayList AL_Departments = new ArrayList();
            try
            {
                connect_to_database();
                sqlcom.CommandType = CommandType.Text;
                sqlcom = new SqlCommand("Select D_NAME From Tbl_Department", sqlcon);
                sqlrdr = sqlcom.ExecuteReader();
                if (sqlrdr.HasRows)
              {
                    while (sqlrdr.Read())
                        AL_Departments.Add(sqlrdr[0].ToString());
                }
                dc_database();
            }
            catch (Exception ex)
            {
                ex.Message.ToString();
            }

            return AL_Departments;
        }
        public ArrayList DA_fnGetDesignations()
        {
            ArrayList AL_Designations = new ArrayList();
            try
            {
                connect_to_database();
                sqlcom.CommandType = CommandType.Text;
                sqlcom = new SqlCommand("Select Desig_Name From Tbl_Designation", sqlcon);
                sqlrdr = sqlcom.ExecuteReader();
                if (sqlrdr.HasRows)
                {
                    while (sqlrdr.Read())
                        AL_Designations.Add(sqlrdr[0].ToString());
                }
                dc_database();
            }
            catch (Exception ex)
            {
                ex.Message.ToString();
            }

            return AL_Designations;
        }

        public int insertquery(string query)
        {
            int status = 0;
            try
            {
                connect_to_database();
                sqlcom.CommandType = System.Data.CommandType.Text;
                sqlcom.CommandText = query;
                sqlcom.Connection = sqlcon;
                // Executing Query
                status = sqlcom.ExecuteNonQuery();
                //dc_database();
            }
            catch (Exception ex)
            {
                //dc_database();
                ex.Message.ToString();
            }
            return status;
        }

        public DataTable DA_getTable(string query)
        {
            DataSet ds_new = new DataSet();
            try
            {
                sqlcon = new SqlConnection(constr);
                sqlda = new SqlDataAdapter(query, sqlcon);
                //sqlda = new SqlDataAdapter("Select setting.user_id,setting.startdate,setting.enddate,tbl_Employee.E_Name From setting INNER JOIN tbl_Employee ON setting.user_id=tbl_Employee.logname", sqlcon);
                sqlda.Fill(ds_new, "countries");
            }
            catch (Exception ex)
            {
                ex.Message.ToString();
                return null;
            }
            return ds_new.Tables[0];
        }
        public ArrayList DA_GetArrayList(string query)
        {
            ArrayList AL_Data = new ArrayList();
            try
            {
                connect_to_database();
                sqlcom.CommandType = CommandType.Text;
                sqlcom = new SqlCommand(query , sqlcon);
                sqlrdr = sqlcom.ExecuteReader();
                if (sqlrdr.HasRows)
                {
                    while (sqlrdr.Read())
                        AL_Data.Add(sqlrdr[0].ToString());
                }
                dc_database();
            }
            catch (Exception ex)
            {
                ex.Message.ToString();
            }
            return AL_Data;
        }

 	public int Updatequery(string query)
       	 {
            int status = 0;
            try
            {
                connect_to_database();
                sqlcom.CommandType = System.Data.CommandType.Text;
                sqlcom.CommandText = query;
                sqlcom.Connection = sqlcon;
                // Executing Query
                status = sqlcom.ExecuteNonQuery();
                return status;
            }
            catch (Exception ex)
            {
                ex.Message.ToString();
            }
            return status;

        }
    public int DeleteQuery(string query)
    {
        int status = 0;
        try
        {
            connect_to_database();
            sqlcom.CommandType = System.Data.CommandType.Text;
            sqlcom.CommandText = query;
            sqlcom.Connection = sqlcon;
            // Executing Query
            status = sqlcom.ExecuteNonQuery();
            return status;
        }
        catch (Exception ex)
        {
            ex.Message.ToString();
        }
        return status;
    }
    public DataSet ExecuteProc(int quotId)
    {
        try
        {
            sqlcon = new SqlConnection(constr);
            sqlcom = new SqlCommand("QuotData", sqlcon);
            sqlcom.CommandType = CommandType.StoredProcedure;
            SqlParameter Param1 = new SqlParameter("@quot_id", SqlDbType.Int);
            Param1.Value = quotId;
            sqlcom.Parameters.Add(Param1);
            sqlda = new SqlDataAdapter(sqlcom);
            sqlda.Fill(ds);
        }
        catch (Exception ex)
        {

        }
        return ds;
    }
    public int insertProduct(string query, string brand, string eqserdes, string Itemcode, string modelno, int Warrenty, int Origin, int category, byte[] imgbin)
    {
        int status = 0;
        try
        {
            connect_to_database();
            sqlcom = new SqlCommand(query, sqlcon);
            //Adding Parameters
            SqlParameter slp1 = new SqlParameter("@imgbin", SqlDbType.Binary);
            slp1.Value = imgbin;
            sqlcom.Parameters.Add(slp1);

            SqlParameter slp2 = new SqlParameter("@brand", SqlDbType.VarChar);
            slp2.Value = brand;
            sqlcom.Parameters.Add(slp2);

            SqlParameter slp3 = new SqlParameter("@eqserdes", SqlDbType.VarChar);
            slp3.Value = eqserdes;
            sqlcom.Parameters.Add(slp3);

            SqlParameter slp4 = new SqlParameter("@Itemcode", SqlDbType.VarChar);
            slp4.Value = Itemcode;
            sqlcom.Parameters.Add(slp4);

            SqlParameter slp5 = new SqlParameter("@modelno", SqlDbType.VarChar);
            slp5.Value = modelno;
            sqlcom.Parameters.Add(slp5);

            SqlParameter slp6 = new SqlParameter("@Warrenty", SqlDbType.Int);
            slp6.Value = Warrenty;
            sqlcom.Parameters.Add(slp6);

            SqlParameter slp7 = new SqlParameter("@Origin", SqlDbType.VarChar);
            slp7.Value = Origin;
            sqlcom.Parameters.Add(slp7);

            SqlParameter slp8 = new SqlParameter("@category", SqlDbType.VarChar);
            slp8.Value = category;
            sqlcom.Parameters.Add(slp8);


            sqlcom.CommandType = System.Data.CommandType.Text;
            sqlcom.CommandText = query;
            //sqlcom.Connection = sqlcon;
            // Executing Query
            //rdr = sqlcom.ExecuteReader();
            status = sqlcom.ExecuteNonQuery();
            dc_database();
        }
        catch (Exception ex)
        {
            //dc_database();
            ex.Message.ToString();
        }
        return status;
    }
        #endregion
    }
}

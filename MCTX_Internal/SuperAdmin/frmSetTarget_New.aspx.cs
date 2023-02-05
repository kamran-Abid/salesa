using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Services;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Runtime.Serialization.Json;
using System.Web.Script.Serialization;

public partial class MCTX_Internal_SuperAdmin_frmSetTarget_New : System.Web.UI.Page
{
    static string Username = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        Session["Username"] = Request.Cookies["username"].Value.ToString();
        Username = HttpContext.Current.Session["Username"].ToString();
        if (!IsPostBack)
        {
            LoadEmp();
            LoadTargetTypes();
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

    public void LoadEmp()
    {
        try
        {
            using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionstring2"].ToString()))
            {
                SqlCommand cmdEmp = new SqlCommand("SELECT distinct user1.User_Id, tbl_Employee.E_Name from user1 inner join tbl_Employee on " +
                    "user1.E_badge=tbl_Employee.E_badge where isnull(tbl_Employee.deleted,0)<>1 and isnull(user1.deleted,0)<>1 order " +
                    "by E_Name asc", cn);
                cn.Open();
                SqlDataAdapter daEmp = new SqlDataAdapter(cmdEmp);
                DataTable dtEmp = new DataTable();
                daEmp.Fill(dtEmp);
                ddlEmployeeName.DataSource = dtEmp;
                ddlEmployeeName.DataTextField = "E_Name";
                ddlEmployeeName.DataValueField = "User_Id";
                ddlEmployeeName.DataBind();
                ddlEmployeeName.Items.Insert(0, "--Select--");
            }

        }
        catch (Exception ex)
        {

            throw ex;
        }
    }


    public void LoadTargetTypes()
    {
        try
        {
            using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionstring2"].ToString()))
            {
                SqlCommand cmdTargetType =  new SqlCommand("select tt_id,tt_name from tbl_TargetType where Deleted = 1", cn);
                cn.Open();
                SqlDataAdapter daTargetType = new SqlDataAdapter(cmdTargetType);
                DataTable dtTargetType = new DataTable();
                daTargetType.Fill(dtTargetType);
                ddlTargetType.DataSource = dtTargetType;
                ddlTargetType.DataTextField = "tt_name";
                ddlTargetType.DataValueField = "tt_id";
                ddlTargetType.DataBind();
                ddlTargetType.Items.Insert(0, "--Select--");
            }

        }
        catch (Exception ex)
        {

            throw ex;
        }
    }


    [WebMethod]
    public static Dictionary<string, object> GetUserList()
    {
        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionstring2"].ToString()))
        {
            SqlCommand cmd = new SqlCommand("select distinct st.setting_id,CONVERT(VARCHAR(10),startdate,101) as startdate, " +
                    "CONVERT(VARCHAR(10),enddate,101) as enddate,E_Name,st.Created_By, "+
                    "CONVERT(VARCHAR(10),st.Created_Date,101) as Creted_Date,st.Modified_By,CONVERT(VARCHAR(10),st.Modified_Date,101) as Modified_Date "+
                    "from dbo.user1 as usr "+
                    "join setting as st on st.user_id = usr.user_id "+
                    "join Tbl_Employee as emp on emp.E_badge = usr.e_badge where usr.deleted=0 "+
                    "and isnull(st.deleted,0)<>1 order by st.setting_id desc ", cn);
            cn.Open();
            SqlDataAdapter DA = new SqlDataAdapter(cmd);
            DataSet ds = new DataSet();
            DA.Fill(ds, "EmpTargetList");
            DataTable dt = new DataTable();
            dt = ds.Tables["EmpTargetList"];
            return ToJson(dt);
        }
    }
    //

    [WebMethod]
    public static Dictionary<string, object> GetEmpTargetDetail(string TargetID)
    {
        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionstring2"].ToString()))
        {
            //SqlCommand cmd = new SqlCommand("select tt.tt_name,tts.actual_target,tts.ts_id,tts.Evaluation_on from setting as st Join tbl_TargetSetting as tts on st.setting_id = tts.setting_id Join tbl_targettype as tt on  tts.tt_id = tt.tt_id where st.setting_id = " + TargetID + " ", cn);
            SqlCommand cmd = new SqlCommand("select distinct tts.tt_id,st.setting_id,u.user_id,te.E_Name,Convert(varchar(15),st.startdate,101) as startdate,Convert(varchar(15),st.enddate,101) as enddate," +
                 " IsNull(Convert(varchar(10),st.StartTime,108),'09:30:00') as StartTime," +
                 "IsNull(Convert(varchar(10),st.EndTime,108),'17:30:00') as EndTime , tt.tt_name,tts.actual_target" +
                 ",tts.ts_id,tts.Evaluation_on from tbl_Employee as te Join user1 as u on te.E_badge = u.E_badge " +
                 " Join setting as st on u.user_id = st.user_id Join tbl_TargetSetting as tts on st.setting_id = tts.setting_id " +
                 " Join tbl_targettype as tt on  tts.tt_id = tt.tt_id  where isnull(st.deleted,0)<>1 and st.setting_id = " + TargetID + " ", cn);
            
            cn.Open();
            SqlDataAdapter DA = new SqlDataAdapter(cmd);
            DataSet ds = new DataSet();
            DA.Fill(ds, "EmpTargetDetail");
            DataTable dt = new DataTable();
            dt = ds.Tables["EmpTargetDetail"];
            return ToJson(dt);
        }
    }

    [WebMethod]
    public static void DeleteEmpTargetDetail(string ts_id)
    {


        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionstring2"].ToString()))
        {
            SqlCommand cmd = new SqlCommand("delete from tbl_TargetSetting where ts_id=" + ts_id + "", cn);
            cn.Open();
            cmd.ExecuteNonQuery();
        }

    }


    

         [WebMethod]
    public static void DeleteEmpTarget(string setting_id)
    {
      
        
            using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionstring2"].ToString()))
            {
                SqlCommand cmd = new SqlCommand("update setting set deleted=1 where setting_id=" + setting_id + "", cn);
                cn.Open();
                cmd.ExecuteNonQuery();
            }
        
     }

    [WebMethod]
    public static void SaveEmpTarget(string uname, string startDate, string endDate, string startTime, string endTime, string TargetTypeID, string EvaluationOn, string NoOFTarget, string insertionFlag)
    {
        if (insertionFlag == "1")
        {
            using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionstring2"].ToString()))
            {
                SqlCommand cmd = new SqlCommand("INSERT INTO setting (startdate, enddate,user_id,StartTime,EndTime,Deleted,Created_By,Created_Date,Modified_By,Modified_Date)"+
                    " VALUES ('" + startDate + "','" + endDate + "','" + uname + "','" + startTime + "','" + endTime + "',"+0+",'"+Username+"','"+DateTime.Now+"','"+Username+"','"+DateTime.Now+"')", cn);
                cn.Open();
                cmd.ExecuteNonQuery();
                cn.Close();
            }
        }
        string settingID = "0";
        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionstring2"].ToString()))
        {
            SqlCommand cmd = new SqlCommand("Select MAX(setting_id) as setting_id  from setting ", cn);
            cn.Open();
            SqlDataAdapter DA = new SqlDataAdapter(cmd);
            DataSet ds = new DataSet();
            DA.Fill(ds, "EmpTargetList");
            DataTable dt = new DataTable();
            dt = ds.Tables["EmpTargetList"];
            settingID = dt.Rows[0]["setting_id"].ToString(); //ToJson(dt);//.Columns["setting_id"].ToString());
            cn.Close();
        }


        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionstring2"].ToString()))
        {
            SqlCommand cmd = new SqlCommand("INSERT INTO tbl_TargetSetting (tt_id,actual_target,setting_id,Evaluation_on) VALUES ('" + TargetTypeID + "','" + NoOFTarget + "','" + settingID + "','" + EvaluationOn + "')", cn);
            cn.Open();
            cmd.ExecuteNonQuery();
            cn.Close();
        }
        
    }


    [WebMethod]
    public static void UpdateEmpTarget(string TargetSettingID, string TargetTypeID, string EvaluationOn, string NoOFTarget)
    {
        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionstring2"].ToString()))
        {
            SqlCommand cmd = new SqlCommand("update tbl_TargetSetting set tt_id=" + TargetTypeID + ",actual_target= " + NoOFTarget + ",Evaluation_on='" + EvaluationOn + "' where ts_id=" + TargetSettingID + "", cn);
            cn.Open();
            cmd.ExecuteNonQuery();
            cn.Close();
        }
    }

    [WebMethod]
    public static void SaveEmpTargetNew(string result, string settingID)
    {

        string[] array = result.Split('~');
        for (int x = 0; x < array.Length-1; x++)
        {
            string[] innerArray = array[x].Split('*');

            string uname = innerArray[0];
            string startDate = innerArray[1];
            string endDate = innerArray[2];            
            string startTime = innerArray[3];
            string endTime = innerArray[4];
            string NoOFTarget = innerArray[5];
            string TargetTypeID = innerArray[6];           
            string EvaluationOn = innerArray[7];
            string TargetSetID = innerArray[8];

            if (settingID == "" || settingID == null)
            {

                if (x == 0)
                {
                    using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionstring2"].ToString()))
                    {
                        SqlCommand cmd = new SqlCommand("INSERT INTO setting (startdate, enddate,user_id,StartTime,EndTime,Deleted,Created_By,Created_Date,Modified_By,Modified_Date)" +
                            " VALUES ('" + startDate + "','" + endDate + "','" + uname + "','" + startTime + "','" + endTime + "'," + 0 + ",'" + Username + "','" + DateTime.Now + "','" + Username + "','" + DateTime.Now + "')", cn);
                        cn.Open();
                        cmd.ExecuteNonQuery();
                        cn.Close();
                    }
                }

                settingID = "0";
                using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionstring2"].ToString()))
                {
                    SqlCommand cmd = new SqlCommand("Select MAX(setting_id) as setting_id  from setting ", cn);
                    cn.Open();
                    SqlDataAdapter DA = new SqlDataAdapter(cmd);
                    DataSet ds = new DataSet();
                    DA.Fill(ds, "EmpTargetList");
                    DataTable dt = new DataTable();
                    dt = ds.Tables["EmpTargetList"];
                    settingID = dt.Rows[0]["setting_id"].ToString(); //ToJson(dt);//.Columns["setting_id"].ToString());
                    cn.Close();
                }
            }
            if (TargetSetID != "" && TargetSetID !="null")
            {
                using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionstring2"].ToString()))
                {
                    SqlCommand cmd = new SqlCommand("update tbl_TargetSetting set tt_id=" + TargetTypeID + ",actual_target= " + NoOFTarget + ",Evaluation_on='" + EvaluationOn + "' where ts_id=" + TargetSetID + "", cn);
                    cn.Open();
                    cmd.ExecuteNonQuery();
                    cn.Close();
                }

            }
            else
            {

                using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionstring2"].ToString()))
                {
                    SqlCommand cmd = new SqlCommand("INSERT INTO tbl_TargetSetting (tt_id,actual_target,setting_id,Evaluation_on) VALUES ('" + TargetTypeID + "','" + NoOFTarget + "','" + settingID + "','" + EvaluationOn + "')", cn);
                    cn.Open();
                    cmd.ExecuteNonQuery();
                    cn.Close();
                }
            }
        
        }





        

    }

    [WebMethod]
    public static Dictionary<string, object> ViewEmpTargetDetail(string settingID)
    {
        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionstring2"].ToString()))
        {

            SqlCommand cmd = new SqlCommand("select distinct st.setting_id,u.user_id,te.E_Name,Convert(varchar(15),st.startdate,101) as startdate,Convert(varchar(15),st.enddate,101) as enddate," +
                " IsNull(Convert(varchar(10),st.StartTime,108),'09:30:00') as StartTime," +
                "IsNull(Convert(varchar(10),st.EndTime,108),'17:30:00') as EndTime , tt.tt_name,tts.actual_target" +
                ",tts.ts_id,tts.Evaluation_on from tbl_Employee as te Join user1 as u on te.E_badge = u.E_badge " +
                " Join setting as st on u.user_id = st.user_id Join tbl_TargetSetting as tts on st.setting_id = tts.setting_id " +
                " Join tbl_targettype as tt on  tts.tt_id = tt.tt_id  where st.setting_id = " + settingID + " ", cn);
            cn.Open();
            SqlDataAdapter DA = new SqlDataAdapter(cmd);
            DataSet ds = new DataSet();
            DA.Fill(ds, "ViewTargetDetail");
            DataTable dt = new DataTable();
            dt = ds.Tables["ViewTargetDetail"];
            return ToJson(dt);
        }
    }

    
}

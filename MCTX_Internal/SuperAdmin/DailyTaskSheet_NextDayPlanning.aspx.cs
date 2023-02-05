using System;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Xml.Linq;
using System.Text.RegularExpressions;
using Sales_BOL;
using System.IO;
using System.Drawing;
using System.Data.SqlClient;
using System.Runtime.Serialization.Json;
using System.Web.Script.Serialization;
using System.Collections.Generic;
using System.Web.Services;
using System.Xml.Linq;
using System.Web.Mail;
using Org.BouncyCastle.Asn1.Ocsp;

public partial class MCTX_Internal_SuperAdmin_DailyTaskSheet_NextDayPlanning : System.Web.UI.Page
{
    static string UserID = "";
    static string CurrentDate = "";
    static string nextDay = "";
    static string SyncTimeLocandServer = "";

    protected void Page_Load(object sender, EventArgs e)
    {
       // CurrentDate = DateTime.Now.ToShortDateString();
        CurrentDate = DateTime.Now.AddHours(11).ToShortDateString();
        //SyncTimeLocandServer = DateTime.Now.AddHours(11).ToShortDateString();
        nextDay = DateTime.Now.AddDays(1).ToShortDateString();
        if (Session["Username"] == null)
        {
            Response.Redirect("../../MCTX_General/Login.aspx");
            //return;
        }
        else
        {
            UserID = Session["Username"].ToString();

            using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionstring2"].ToString()))
            {
                string Query = "select BasicSalary, (BasicSalary/30) as perDaySal,(BasicSalary/30)/10 as perHrSal,E_Name,id from tbl_employee where deleted=0";
                SqlDataAdapter da = new SqlDataAdapter(Query, cn);
                DataSet ds = new DataSet();
                DataTable dt = new DataTable();
                da.Fill(ds);
                ddlEmployee.DataSource = ds;
                ddlEmployee.DataValueField = "id";
                ddlEmployee.DataTextField = "E_Name";
                ddlEmployee.DataBind();
                ddlEmployee.Items.Insert(0, new ListItem("-- Select --", "0"));

            }
            using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionstring2"].ToString()))
            {
                string Query = "SELECT  Project_id,Project_Name   FROM [workshop_project] where is_deleted=1";
                SqlDataAdapter da = new SqlDataAdapter(Query, cn);
                DataSet ds = new DataSet();
                DataTable dt = new DataTable();
                da.Fill(ds);
                ddlProject.DataSource = ds;
                ddlProject.DataValueField = "Project_id";
                ddlProject.DataTextField = "Project_Name";
                ddlProject.DataBind();
                ddlProject.Items.Insert(0, new ListItem("-- Select --", "0"));

            }

            using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionstring2"].ToString()))
            {
                string Query = "SELECT  [Traveling_Source_ID],[Traveling_Source_Name]   FROM [DailyTaskSheet_Traveling_Source]";
                SqlDataAdapter da = new SqlDataAdapter(Query, cn);
                DataSet ds = new DataSet();
                DataTable dt = new DataTable();
                da.Fill(ds);
                ddlTravelingSource.DataSource = ds;
                ddlTravelingSource.DataValueField = "Traveling_Source_ID";
                ddlTravelingSource.DataTextField = "Traveling_Source_Name";
                ddlTravelingSource.DataBind();
                ddlTravelingSource.Items.Insert(0, new ListItem("-- Select --", "0"));

            }

            using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionstring2"].ToString()))
            {
                string Query = "select sum( convert( int, BasicSalary/26) ) as totalBasicSalary from tbl_employee where Deleted=0";
                SqlDataAdapter da = new SqlDataAdapter(Query, cn);
                DataSet ds = new DataSet();
                DataTable dt = new DataTable();
                da.Fill(ds);
                lblTodayBasicSalary.Text = ds.Tables[0].Rows[0][0].ToString();

            }

           

        }

    }

   

    #region Save Next Day Planning
    [WebMethod]
    public static void SaveNextDayPlanning(string Emp_ID, string Project_ID, string Other_Description, string Time_From_ID, string Time_From, string Time_To_ID, string Time_To,
        string Absolute_Cost, string Relative_Cost, string Opportunity_Cost, string Opportunity_Cost_Color, string Traveling_Source_ID, string Traveling_Distance, string Traveling_Cost,
        string Total_Activity_Cost, string Branch_Name, string Department_Name, string Activity_Description, string task_date)
    
    
    {

        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionstring2"].ToString()))
        {

                 cn.Open();
            string query = "INSERT INTO [DailyTask_Sheet] "+
                            "([Emp_ID],[Project_ID],[Other_Description],[Time_From_ID],[Time_From],[Time_To_ID],[Time_To],[Absolute_Cost] "+
                            ",[Relative_Cost],[Opportunity_Cost],[Opportunity_Cost_Color],[Traveling_Source_ID],[Traveling_Distance],[Traveling_Cost] "+
                            ",[Total_Activity_Cost],[Branch_Name],[Department_Name],[Activity_Description],[task_date],[created_date],[created_by],[modified_date],[modified_by],[Activity_Status],[is_deleted])" +
                         "VALUES('" + Emp_ID + "','" + Project_ID + "','" + Other_Description + "','" + Time_From_ID + "','" + Time_From + "','" + Time_To_ID + "','" + Time_To +
                         "','" + Absolute_Cost + "','" + Relative_Cost + "','" + Opportunity_Cost + "','" + Opportunity_Cost_Color + "','" + Traveling_Source_ID + "','" + Traveling_Distance +
                         "','" + Traveling_Cost + "','" + Total_Activity_Cost + "','" + Branch_Name + "','" + Department_Name + "','" + Activity_Description + "','" + task_date + "','" + CurrentDate + "','" + UserID + "','" + CurrentDate + "','" + UserID + "', '" + 0 + "', '" + 1 + "' )";
            SqlCommand cmd = new SqlCommand(query, cn);
            cmd.ExecuteNonQuery();
        }
    }
    #endregion

    #region Update Next Day Planning
    [WebMethod]
    public static void UpdateNextDayPlanning(string DailyTask_ID, string Emp_ID, string Project_ID, string Other_Description, string Time_From_ID, string Time_From, string Time_To_ID, string Time_To,
        string Absolute_Cost, string Relative_Cost, string Opportunity_Cost, string Opportunity_Cost_Color, string Traveling_Source_ID, string Traveling_Distance, string Traveling_Cost,
        string Total_Activity_Cost, string Branch_Name, string Department_Name, string Activity_Description, string task_date)
    {

        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionstring2"].ToString()))
        {

            cn.Open();
            string query = "UPDATE [DailyTask_Sheet] "+
  " SET  [Emp_ID] = " +Emp_ID+ ",[Project_ID] = '" +Project_ID+ "',[Other_Description] = '" +Other_Description+ "'"+
     " ,[Time_From_ID] = '" +Time_From_ID+ "',[Time_From] = '" +Time_From+ "',[Time_To_ID] = '" +Time_To_ID+ "'"+
      " ,[Time_To] = '" +Time_To+ "',[Absolute_Cost] = '" +Absolute_Cost+ "',[Relative_Cost] = '" +Relative_Cost+ "'"+
      " ,[Opportunity_Cost] = '" +Opportunity_Cost+ "',[Opportunity_Cost_Color] = '" +Opportunity_Cost_Color+ "'"+
      " ,[Traveling_Source_ID] = '" +Traveling_Source_ID+ "',[Traveling_Distance] = '" +Traveling_Distance+ "'"+
      " ,[Traveling_Cost] = '" +Traveling_Cost+ "',[Total_Activity_Cost] = '" +Total_Activity_Cost+ "'"+
       ",[Branch_Name] = '" +Branch_Name+ "',[Department_Name] ='" +Department_Name+ "'"+
       ",[Activity_Description] = '" + Activity_Description + "',[task_date] ='" + task_date + "'" +
      " ,[modified_date] = '" + CurrentDate + "',[modified_by] = '" + UserID + "' "+     
  " WHERE DailyTask_ID=" +DailyTask_ID+ "";
            SqlCommand cmd = new SqlCommand(query, cn);
            cmd.ExecuteNonQuery();
        }
    }
    #endregion
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

    #region Get Employee Info
    [WebMethod]
    public static Dictionary<string, object> getEmpSalary(string empID)
    {
       using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionstring2"].ToString()))
        {
            string Query = "select (tbl_employee.BasicSalary/30)/10 as perHrSal,tbl_employee.E_Name,tbl_employee.id,Tbl_Department.D_ID,Tbl_Department.D_NAME,tbl_BRANCHES.BRANCHNAME,ISNULL(DailyTaskSheet_Relative_Cost.Relative_Cost,'0') Relative_Cost from Tbl_Department " +
                         " inner join tbl_employee on tbl_employee.Dp_Id=Tbl_Department.D_ID inner join tbl_BRANCHES on tbl_BRANCHES.BRID=tbl_employee.BRID  left join DailyTaskSheet_Relative_Cost on DailyTaskSheet_Relative_Cost.Emp_ID=tbl_employee.id " +
                         " where tbl_employee.Deleted=0  and tbl_employee.id ='" + empID + "' ";
            SqlDataAdapter da = new SqlDataAdapter(Query, cn);
            DataSet ds = new DataSet();
            DataTable dt = new DataTable();
            da.Fill(ds, "empSalDetails");
            dt = ds.Tables["empSalDetails"];
            return ToJson(dt);
        }
    }
    #endregion


    #region Get Task Type
    [WebMethod]
    public static Dictionary<string, object> getTaskType()
    {
        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionstring2"].ToString()))
        {
            string Query = "SELECT TOP 1000 [Task_type_id],[Task_tpe_Name] FROM [DailTask_AddTaskType]";
            SqlDataAdapter da = new SqlDataAdapter(Query, cn);
            DataSet ds = new DataSet();
            DataTable dt = new DataTable();
            da.Fill(ds, "TaskTypeDetails");
            dt = ds.Tables["TaskTypeDetails"];
            return ToJson(dt);
        }
    }
    #endregion

    #region Get Task Type Description
    [WebMethod]
    public static Dictionary<string, object> getTaskTypeDescription(string Task_type_id)
    {
        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionstring2"].ToString()))
        {
            string Query = "SELECT  [ThingsToDo_id] ,[Activity_Description],isnull(ThingToDo_Status,'0') as [ThingToDo_Status] ,TaskType_id "+
 " FROM [DailyTask_ThingsToDo] where TaskType_id='" + Task_type_id + "' and ThingToDo_Status<>1";
            SqlDataAdapter da = new SqlDataAdapter(Query, cn);
            DataSet ds = new DataSet();
            DataTable dt = new DataTable();
            da.Fill(ds, "TaskTypeDescriptionDetails");
            dt = ds.Tables["TaskTypeDescriptionDetails"];
            return ToJson(dt);
        }
    }
    #endregion
    #region Get Next Day Planning
    [WebMethod]
    public static Dictionary<string, object> getNextDayPlanningDetails()
    {
        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionstring2"].ToString()))
        {
            string Query = "SELECT DTS.[DailyTask_ID],DTS.[Emp_ID],emp.E_Name,DTS.[Project_ID],isnull(wpj.Project_Name,'') as Project_Name,DTS.[Other_Description],DTS.[Time_From_ID] " +
      ",DTS.[Time_From],DTS.[Time_To_ID],DTS.[Time_To],DTS.[Absolute_Cost],DTS.[Relative_Cost],DTS.[Opportunity_Cost] "+
      ",DTS.[Opportunity_Cost_Color],DTS.[Traveling_Source_ID],isnull(DTSS.Traveling_Source_Name,'') as Traveling_Source_Name,DTS.[Traveling_Distance],DTS.[Traveling_Cost] " +
            ",DTS.[Total_Activity_Cost],DTS.[Branch_Name],DTS.[Department_Name],DTS.Activity_Description,isnull(CONVERT(varchar(20), DTS.[task_date],101),'') as task_date,isnull(CONVERT(varchar(20), DTS.[created_date],101),'') as created_date, " +
	  " DTS.[created_by],isnull(CONVERT(varchar(20),DTS.[modified_date],101),'') as modified_date,DTS.[modified_by],DTS.[Activity_Status],DTS.[is_deleted] "+
  " FROM [DailyTask_Sheet] DTS  "+
  " INNER JOIN tbl_employee emp ON DTS.Emp_ID=emp.id "+
  " left JOIN DailyTaskSheet_Traveling_Source DTSS ON DTS.Traveling_Source_ID=DTSS.Traveling_Source_ID   left join workshop_project wpj on DTS.Project_ID=wpj.Project_id WHERE DTS.is_deleted=1 order by 1 desc";
            SqlDataAdapter da = new SqlDataAdapter(Query, cn);
            DataSet ds = new DataSet();
            DataTable dt = new DataTable();
            da.Fill(ds, "NextDayPlanningDetails");
            dt = ds.Tables["NextDayPlanningDetails"];
            return ToJson(dt);
        }
    }
    #endregion


    #region Update Today Task
    [WebMethod]
    public static void UpdateThingToDo(string ThingsToDo_id, string ThingToDo_Status)
    {

        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionstring2"].ToString()))
        {

            cn.Open();
            string query = "UPDATE [DailyTask_ThingsToDo] " +
  " SET  [ThingToDo_Status] = " + ThingToDo_Status + ",[modified_date] = '" + CurrentDate + "',[modified_by] = '" + UserID + "' " +
  " WHERE [ThingsToDo_id]=" + ThingsToDo_id + "";
            SqlCommand cmd = new SqlCommand(query, cn);
            cmd.ExecuteNonQuery();
        }
    }
    #endregion

   
}
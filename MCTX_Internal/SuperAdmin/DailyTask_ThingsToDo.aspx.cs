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

public partial class MCTX_Internal_SuperAdmin_DailyTask_ThingsToDo : System.Web.UI.Page
{
    static string UserID = "";
    static string CurrentDate = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        CurrentDate = DateTime.Now.ToShortDateString();
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
                string Query = "SELECT [Task_type_id],[Task_tpe_Name] FROM [DailTask_AddTaskType] where is_deleted=1";
                SqlDataAdapter da = new SqlDataAdapter(Query, cn);
                DataSet ds = new DataSet();
                DataTable dt = new DataTable();
                da.Fill(ds);
                ddlTaskType.DataSource = ds;
                ddlTaskType.DataValueField = "Task_type_id";
                ddlTaskType.DataTextField = "Task_tpe_Name";
                ddlTaskType.DataBind();
                ddlTaskType.Items.Insert(0, new ListItem("-- Select --", "0"));

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
    #region Get Project
    [WebMethod]
    public static Dictionary<string, object> getProjectDetails()
    {
        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionstring2"].ToString()))
        {
            string Query = "SELECT  [Project_id],wpj.Priority_id,wpt.[Priority_description],[Project_Name],isnull (CONVERT(varchar(20), [created_date],101),'') as [created_date]" +
      ",[created_by],ISNULL(CONVERT(varchar(20), [modified_date],101),'') as [modified_date]"+
      ",[modified_by],[is_deleted]  FROM [workshop_project] wpj inner join [workshop_priority] wpt"+
      " on wpj.[Priority_id]=wpt.Priority_id  where is_deleted=1 order by 1 desc";
            SqlDataAdapter da = new SqlDataAdapter(Query, cn);
            DataSet ds = new DataSet();
            DataTable dt = new DataTable();
            da.Fill(ds, "ProjDetails");
            dt = ds.Tables["ProjDetails"];
            return ToJson(dt);
        }
    }
    #endregion


    #region Save Thing To Do
    [WebMethod]
    public static void SaveThingToDo(string Activity_Description, string TaskType_id, string ProjectType_id, string Amount_Required, string Task_Date)
    {

        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionstring2"].ToString()))
        {

            cn.Open();
            string query = "INSERT INTO [DailyTask_ThingsToDo] "+                       
          "([Activity_Description],[TaskType_id],[ProjectType_id],[Amount_Required] "+
          " ,[Task_Date],[created_date],[created_by],[modified_date],[modified_by],[is_deleted],[ThingToDo_Status])" +
            "VALUES('" + Activity_Description + "','" + TaskType_id + "','" + ProjectType_id + "','" + Amount_Required + "','" + Task_Date + "','" + CurrentDate + "','" + UserID + "','" + CurrentDate + "','" + UserID + "', '" + 1 + "', '" + 0 + "' )";
            SqlCommand cmd = new SqlCommand(query, cn);
            cmd.ExecuteNonQuery();
        }
    }
    #endregion
    #region Get Thing To Do
    [WebMethod]
    public static Dictionary<string, object> getThingToDoDetails()
    {
        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionstring2"].ToString()))
        {
            string Query = "SELECT  [ThingsToDo_id],[Activity_Description],[TaskType_id],DTATT.Task_tpe_Name,[ProjectType_id],WPJ.Project_Name,[Amount_Required],isnull(CONVERT(varchar(20),[Task_Date],101),'') as Task_Date, " +
	  " isnull(CONVERT(varchar(20),DTTTD.[created_date],101),'') as created_date,DTTTD.[created_by],isnull(CONVERT(varchar(20),DTTTD.[modified_date],101),'') as modified_date "+
      " ,DTTTD.[modified_by],DTTTD.[is_deleted]  FROM [DailyTask_ThingsToDo] DTTTD inner join DailTask_AddTaskType DTATT "+
  " on DTTTD.TaskType_id=DTATT.Task_type_id  INNER JOIN workshop_project WPJ ON   WPJ.Project_id=DTTTD.ProjectType_id WHERE DTTTD.is_deleted=1 order by 1 desc";
            SqlDataAdapter da = new SqlDataAdapter(Query, cn);
            DataSet ds = new DataSet();
            DataTable dt = new DataTable();
            da.Fill(ds, "ThingToDoDetailss");
            dt = ds.Tables["ThingToDoDetailss"];
            return ToJson(dt);
        }
    }
    #endregion
   

    #region Update Thing To Do
    [WebMethod]
    public static void UpdateThingToDo(string ThingsToDo_id,string Activity_Description, string TaskType_id, string ProjectType_id, string Amount_Required, string Task_Date)
    {

        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionstring2"].ToString()))
        {

            cn.Open();
            string query = "UPDATE [DailyTask_ThingsToDo] " +
   "SET [Activity_Description] = '" + Activity_Description + "',[TaskType_id] = '" + TaskType_id + "',[ProjectType_id] = '" + ProjectType_id + "',[Amount_Required] = '" + Amount_Required + "',[Task_Date] = '" + Task_Date + "',[modified_date] = '" + CurrentDate + "'" +
     " ,[modified_by] = '" + UserID + "' WHERE ThingsToDo_id='" + ThingsToDo_id + "'";
            SqlCommand cmd = new SqlCommand(query, cn);
            cmd.ExecuteNonQuery();
        }
    }
    #endregion
}
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

using System.Web.Mail;
using Org.BouncyCastle.Asn1.Ocsp;
public partial class MCTX_Internal_SuperAdmin_workshp_outputChart : System.Web.UI.Page
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
                string Query = "select BasicSalary, (BasicSalary/30) as perDaySal,(BasicSalary/30)/10 as perHrSal,E_Name,id from tbl_employee where Dp_Id in (24,7)";
                SqlDataAdapter da = new SqlDataAdapter(Query, cn);
                DataSet ds = new DataSet();
                DataTable dt = new DataTable();
                da.Fill(ds);
                ddlEmployee.DataSource = ds;
                ddlEmployee.DataValueField = "id";
                ddlEmployee.DataTextField = "E_Name";
                ddlEmployee.DataBind();
                //ddlEmployee.Items.Insert(0, "-- Select --");
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
                string Query = "SELECT  Product_id,Product_name   FROM [workshop_product] where is_deleted=1";
                SqlDataAdapter da = new SqlDataAdapter(Query, cn);
                DataSet ds = new DataSet();
                DataTable dt = new DataTable();
                da.Fill(ds);
                ddlProduct.DataSource = ds;
                ddlProduct.DataValueField = "Product_id";
                ddlProduct.DataTextField = "Product_name";
                ddlProduct.DataBind();
                ddlProduct.Items.Insert(0, new ListItem("-- Select --", "0"));


            }

            using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionstring2"].ToString()))
            {
                string Query = "SELECT  [Activity_type_id],[Activity_type_name]  FROM [workshop_activity_type]";
                SqlDataAdapter da = new SqlDataAdapter(Query, cn);
                DataSet ds = new DataSet();
                DataTable dt = new DataTable();
                da.Fill(ds);
                ddlActivityType.DataSource = ds;
                ddlActivityType.DataValueField = "Activity_type_id";
                ddlActivityType.DataTextField = "Activity_type_name";
                ddlActivityType.DataBind();
                ddlActivityType.Items.Insert(0, new ListItem("-- Select --", "0"));


            }
            using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionstring2"].ToString()))
            {
                string Query = "SELECT  [Activity_id],[Activity_description] FROM [workshop_activity] where is_deleted=1";
                SqlDataAdapter da = new SqlDataAdapter(Query, cn);
                DataSet ds = new DataSet();
                DataTable dt = new DataTable();
                da.Fill(ds);
                ddlActivityDescription.DataSource = ds;
                ddlActivityDescription.DataValueField = "Activity_id";
                ddlActivityDescription.DataTextField = "Activity_description";
                ddlActivityDescription.DataBind();
                ddlActivityDescription.Items.Insert(0, new ListItem("-- Select --", "0"));


            }

            using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionstring2"].ToString()))
            {
                string Query = "SELECT  [Priority_id],[Priority_description]  FROM [workshop_priority]";
                SqlDataAdapter da = new SqlDataAdapter(Query, cn);
                DataSet ds = new DataSet();
                DataTable dt = new DataTable();
                da.Fill(ds);
                ddlPriority.DataSource = ds;
                ddlPriority.DataValueField = "Priority_id";
                ddlPriority.DataTextField = "Priority_description";
                ddlPriority.DataBind();
                ddlPriority.Items.Insert(0, new ListItem("-- Select --", "0"));


            }
            using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionstring2"].ToString()))
            {
                string Query = "SELECT [Activity_grade_id],[Activity_grade_name]  FROM [workshop_activity_grade]";
                SqlDataAdapter da = new SqlDataAdapter(Query, cn);
                DataSet ds = new DataSet();
                DataTable dt = new DataTable();
                da.Fill(ds);
                ddlActivityGradeId.DataSource = ds;
                ddlActivityGradeId.DataValueField = "Activity_grade_id";
                ddlActivityGradeId.DataTextField = "Activity_grade_name";
                ddlActivityGradeId.DataBind();
                ddlActivityGradeId.Items.Insert(0, new ListItem("-- Select --", "0"));


            }

            using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionstring2"].ToString()))
            {
                string Query = "SELECT [mistake_id],[mistake_description] FROM [workshop_activity_mistake]  where is_deleted=1";
                SqlDataAdapter da = new SqlDataAdapter(Query, cn);
                DataSet ds = new DataSet();
                DataTable dt = new DataTable();
                da.Fill(ds);
                ddlMistakeType.DataSource = ds;
                ddlMistakeType.DataValueField = "mistake_id";
                ddlMistakeType.DataTextField = "mistake_description";
                ddlMistakeType.DataBind();
                ddlMistakeType.Items.Insert(0, new ListItem("-- Select --", "0"));


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

    #region Get Employee Info
    [WebMethod]
    public static Dictionary<string, object> getEmpSalary(string empID)
    {
        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionstring2"].ToString()))
        {
            string Query = "select BasicSalary, (BasicSalary/30) as perDaySal,(BasicSalary/30)/10 as perHrSal,E_Name,id from tbl_employee where Dp_Id in (24,7) and id='"+empID+"' ";
            SqlDataAdapter da = new SqlDataAdapter(Query, cn);
            DataSet ds = new DataSet();
            DataTable dt = new DataTable();
            da.Fill(ds, "empSalDetails");
            dt = ds.Tables["empSalDetails"];
            return ToJson(dt);
        }
    }
    #endregion

    #region Get Project Priority
    [WebMethod]
    public static Dictionary<string, object> getPriority(string ProjectID)
    {
        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionstring2"].ToString()))
        {
            string Query = "SELECT  Priority_id  FROM workshop_project where is_deleted=1 and Project_id='" + ProjectID + "' ";
            SqlDataAdapter da = new SqlDataAdapter(Query, cn);
            DataSet ds = new DataSet();
            DataTable dt = new DataTable();
            da.Fill(ds, "PriorityDetails");
            dt = ds.Tables["PriorityDetails"];
            return ToJson(dt);
        }
    }
    #endregion

    #region Save OutputChart    

     //data: "{'empid':'" + empid + "','monthlySal':'" + monthlySal + "','perdaySal':'" + perdaySal + "','perHourSal':'" + perHourSal + "','overTimeHr':'" + overTimeHr + "','overTimecharges':'" + overTimecharges + "','projectid':'" + projectid + "','productid':'" + productid + "','Priorityid':'" + Priorityid + "','ActivityTypeid':'" + ActivityTypeid + "','ActivityDescriptin':'" + ActivityDescriptin + "'
                                                                                                                                                                                            //,'mistaketypeid':'" + mistaketypeid + "','mistakeDescription':'" + mistakeDescription + "','ActivityTarget':'" + ActivityTarget + "','ActivityAchieved':'" + ActivityAchieved + "','ActivityGradeId':'" + ActivityGradeId + "','ActivitStartTime':'" + ActivitStartTime + "','ActivitEndTime':'" + ActivitEndTime + "','TotalHour':'" + TotalHour + "'}",
    [WebMethod]
    public static void SaveOutPutChart(string empid, string monthlySal, string perdaySal, string perHourSal, string overTimeHr, string overTimecharges, string projectid, string productid, string Priorityid,string lossName,string lossCost, string ActivityTypeid, string ActivityDescriptin, string mistaketypeid,
        string mistakeDescription, string ActivityTarget, string ActivityAchieved, string ActivityGradeId, string ActivitStartTime,string ActivitStartTimeDes,string ActivitEstimatedTime,string ActivitEstimatedTimeDes, string ActivitEndTime,string ActivitEndTimeDes, string TotalHour)
    {

        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionstring2"].ToString()))
        {

           

            cn.Open();
            string query = "INSERT INTO [workshop_output_chart]"+
           "([emp_id],[emp_month_salary]"+
           ",[emp_perday_salary],[emp_perhour_salary]"+
           ",[emp_overtime_hour],[emp_overtimen_chargest]"+
           ",[project_id],[product_id]"+
           ",[Project_priority],[waistage_description]"+
           ",[waistage_cost]"+
           ",[activity_type_id],[activity_description]"+
           ",[Acrtivity_mistake_type_id]"+
           ",[Activity_mistake_description],[activity_target]"+
           ",[activity_achived],[activity_grade_id]"+
           ",[activity_start_time],[activity_startTime_description],[activity_EstimatedTime],[activity_EstimatedTime_description],[activity_end_time],[activity_EndTime_description]" +
           ",[activity_total_hour],[created_date],[created_by],[modified_date],[modified_by],[is_deleted])" +
    " VALUES('" + empid + "','" + monthlySal + "','" + perdaySal + "','" + perHourSal + "','" + overTimeHr + "','" + overTimecharges + "', '" + projectid + "'"+
            ",'" + productid + "','" + Priorityid + "','" + lossName + "','" + lossCost + "','" + ActivityTypeid + "', '" + ActivityDescriptin + "', '" + mistaketypeid + "'"+
            ",'" + mistakeDescription + "','" + ActivityTarget + "','" + ActivityAchieved + "','" + ActivityGradeId + "','" + ActivitStartTime + "','" + ActivitStartTimeDes + "','" + ActivitEstimatedTime + "','" + ActivitEstimatedTimeDes + "','" + ActivitEndTime + "','" + ActivitEndTimeDes + "','" + TotalHour + "','" + CurrentDate + "','" + UserID + "','" + CurrentDate + "','" + UserID + "', '" + 1 + "')";
            SqlCommand cmd = new SqlCommand(query, cn);
            cmd.ExecuteNonQuery();
        }
    }

     #region Get Output chart    
    [WebMethod]
    public static Dictionary<string, object> getOutputDetails()
    {
        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionstring2"].ToString()))
        {
            string Query = "SELECT  [output_chart_id]"+
      ",[workshop_output_chart].[emp_id],emp.E_Name"+
      ",[emp_month_salary]"+
      ",[emp_perday_salary]"+
      ",[emp_perhour_salary]"+
      ",[emp_overtime_hour]"+
      ",[emp_overtimen_chargest]"+
      ",[workshop_output_chart].[project_id],[workshop_project].Project_Name"+
      ",[workshop_output_chart].[product_id],[workshop_product].Product_name"+
      ",[workshop_output_chart].[Project_priority],[workshop_priority].Priority_description"+
      ",[waistage_description]"+
      ",[waistage_cost]"+
      ",[workshop_output_chart].[activity_type_id],[workshop_activity_type].Activity_type_name"+
      ",[activity_description]"+
      ",[Acrtivity_mistake_type_id],isnull([workshop_activity_mistake].mistake_description,'') as mistake_type_name"+
      ",[Activity_mistake_description]"+
      ",[activity_target]"+
      ",[activity_achived]"+
      ",[workshop_output_chart].[activity_grade_id],isnull([workshop_activity_grade].Activity_grade_name,'') Activity_grade_name"+
      ",[activity_start_time]"+
      ",[activity_startTime_description]" +
      ",[activity_EstimatedTime]" +
      ",isnull([activity_EstimatedTime_description],'') activity_EstimatedTime_description" +  
      ",[activity_end_time]"+
      ",[activity_EndTime_description]" +
      ",[activity_total_hour]"+
      ",isnull(CONVERT(varchar(20), [workshop_output_chart].[created_date],101),'') as created_date" +
      ",[workshop_output_chart].[created_by]"+
      ",isnull(CONVERT(varchar(20), [workshop_output_chart].[modified_date],101),'') as modified_date" +
      ",[workshop_output_chart].[modified_by]"+
      ",[workshop_output_chart].[is_deleted]"+
  " FROM [workshop_output_chart]"+
  " inner join tbl_employee emp  on [workshop_output_chart].[emp_id]=emp.id "+
  " inner join workshop_project [workshop_project] on [workshop_output_chart].[project_id]=[workshop_project].Project_id"+
 " inner join workshop_product  on [workshop_output_chart].[product_id]=[workshop_product].Product_id"+
 " inner join workshop_priority on workshop_priority.Priority_id=[workshop_output_chart].[Project_priority]"+
 " inner join workshop_activity_type on workshop_activity_type.Activity_type_id=[workshop_output_chart].[activity_type_id]"+
 " LEFT join workshop_activity_mistake on workshop_activity_mistake.mistake_id=[workshop_output_chart].[Acrtivity_mistake_type_id]"+
 " LEFT join [workshop_activity_grade] on [workshop_activity_grade].Activity_grade_id=[workshop_output_chart].[activity_grade_id] where [workshop_output_chart].[created_date]='" + CurrentDate + "' order by 1 desc";
            SqlDataAdapter da = new SqlDataAdapter(Query, cn);
            DataSet ds = new DataSet();
            DataTable dt = new DataTable();
            da.Fill(ds, "ouputchatrDetails");
            dt = ds.Tables["ouputchatrDetails"];
            return ToJson(dt);
        }
    }
    #endregion

//    /****** Script for SelectTopNRows command from SSMS  ******/

    #endregion


    #region Update OutputChart
    [WebMethod]
    public static void updateOutputChart(string outputChartID, string empid, string monthlySal, string perdaySal, string perHourSal, string overTimeHr, string overTimecharges,
        string projectid, string productid, string Priorityid, string lossName, string lossCost, string ActivityTypeid, string ActivityDescriptin, string mistaketypeid,
        string mistakeDescription, string ActivityTarget, string ActivityAchieved, string ActivityGradeId, string ActivitStartTime, string ActivitStartTimeDes, string ActivitEndTime, string ActivitEndTimeDes, string TotalHour)
    {

        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionstring2"].ToString()))
        { 
            cn.Open();
        string query = "UPDATE [mecha_mechatronix].[workshop_output_chart]" +
        "SET [emp_id] = '" + empid + "',[emp_month_salary] = '" + monthlySal + "',[emp_perday_salary] = '" + perdaySal + "',[emp_perhour_salary] = '" + perHourSal + "'"+
        ",[emp_overtime_hour] = '" + overTimeHr + "',[emp_overtimen_chargest] = '" + overTimecharges + "',[project_id] = '" + projectid + "',[product_id] = '" + productid + "'" +
        ", [Project_priority] = '" + Priorityid + "',[waistage_description] = '" + lossName + "',[waistage_cost] = '" + lossCost + "',[activity_type_id] = '" + ActivityTypeid + "'" +
        ", [activity_description] = '" + ActivityDescriptin + "',[Acrtivity_mistake_type_id] = '" + mistaketypeid + "',[Activity_mistake_description] = '" + mistakeDescription + "',[activity_target] = '" + ActivityTarget + "'" +
        ", [activity_achived] = '" + ActivityAchieved + "',[activity_grade_id] = '" + ActivityGradeId + "',[activity_start_time] = '" + ActivitStartTime + "',[activity_startTime_description] = '" + ActivitStartTimeDes + "',[activity_end_time] = '" + ActivitEndTime + "',[activity_EndTime_description] = '" + ActivitEndTimeDes + "',[activity_total_hour] = '" + TotalHour + "'" +
        ",[modified_date] = '" + CurrentDate + "'" +
        " ,[modified_by] = '" + UserID + "' WHERE [output_chart_id]='" + outputChartID + "'";
            SqlCommand cmd = new SqlCommand(query, cn);
            cmd.ExecuteNonQuery();
        }
    }
    #endregion
}
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
public partial class MCTX_Internal_SuperAdmin_workshp_ProjectWise_Report : System.Web.UI.Page
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

  

  


    #region Get Worker Wise Report
    [WebMethod]
    public static Dictionary<string, object> getProjectWiseReport(string projectid)
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
      ",[workshop_output_chart].[activity_grade_id],isnull([workshop_activity_grade].Activity_grade_name,'') Activity_grade_name" +
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
 " LEFT join [workshop_activity_grade] on [workshop_activity_grade].Activity_grade_id=[workshop_output_chart].[activity_grade_id] where 1=1";


 if (projectid != "0")
 {
     Query += " and [workshop_output_chart].[project_id]=" + projectid + " ";
 }

 Query += "order by 1 desc";
          
           

 
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

   


   
}
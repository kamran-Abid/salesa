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

public partial class MCTX_Internal_SuperAdmin_TodayTask_Sheet : System.Web.UI.Page
{
    static string UserID = "";
    static string CurrentDate = "";
    static string nextDay = "";
   // static string SyncTimeLocandServer = "";

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

          // select sum( convert( int, BasicSalary/26) ) as totalBasicSalary from tbl_employee where Deleted=0 and id not in(6,77,173)
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
   
    #region Update Today Task
    [WebMethod]
    public static void UpdateTodayTask(string DailyTask_ID, string ActivityStatus)
    {

        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionstring2"].ToString()))
        {

            cn.Open();
            string query = "UPDATE [DailyTask_Sheet] "+
  " SET  [Activity_Status] = " + ActivityStatus + ",[modified_date] = '" + CurrentDate + "',[modified_by] = '" + UserID + "' "+
  " WHERE DailyTask_ID=" + DailyTask_ID + "";
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
    #region Get Relative Cost
    [WebMethod]
    public static Dictionary<string, object> getTodayTaskDetails()
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


   
}
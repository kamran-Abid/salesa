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

public partial class MCTX_Internal_SuperAdmin_DailyTaskSheet_RelativeCost : System.Web.UI.Page
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
                ddlEmployee.Items.Insert(0, new ListItem("-- Select --", "0"));

            }

           

        }

    }

   

    #region Save Relative Cost
    [WebMethod]
    public static void SaveRelativeCost(string Emp_ID, string RelativeCost, string AbsoluteCost)
    {

        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionstring2"].ToString()))
        {

            cn.Open();
            string query = "INSERT INTO [DailyTaskSheet_Relative_Cost]" +
           "([Emp_ID] ,[Relative_Cost],[Absolute_Cost],[created_date],[created_by],[modified_date],[modified_by],[is_deleted])" +
           "VALUES('" + Emp_ID + "','" + RelativeCost + "','" + AbsoluteCost + "','" + CurrentDate + "','" + UserID + "','" + CurrentDate + "','" + UserID + "', '" + 1 + "' )";
            SqlCommand cmd = new SqlCommand(query, cn);
            cmd.ExecuteNonQuery();
        }
    }
    #endregion

    #region Update Relative Cost
    [WebMethod]
    public static void UpdateProject(string RelativeCostIDs, string RelativeCost, string Emp_ID)
    {

        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionstring2"].ToString()))
        {

            cn.Open();
            string query = "UPDATE .[DailyTaskSheet_Relative_Cost]" +
   "SET [Emp_ID] = '" + Emp_ID + "',[Relative_Cost] = '" + RelativeCost + "',[modified_date] = '" + CurrentDate + "'" +
     " ,[modified_by] = '" + UserID + "' WHERE Relative_Cost_ID='" + RelativeCostIDs + "'";
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
            string Query = "select BasicSalary, (BasicSalary/30) as perDaySal,(BasicSalary/30)/10 as perHrSal,E_Name,id from tbl_employee where Dp_Id in (24,7) and id='" + empID + "' ";
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
    public static Dictionary<string, object> getRelativeCostDetails()
    {
        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionstring2"].ToString()))
        {
            string Query = "SELECT DTSRC.[Relative_Cost_ID],DTSRC.[Absolute_Cost],DTSRC.[Relative_Cost],DTSRC.[Emp_ID],EMP.E_Name,isnull(CONVERT(varchar(20),DTSRC.[created_date],101),'') as created_date,DTSRC.[created_by] " +
     " ,isnull(CONVERT(varchar(20),DTSRC.[modified_date],101),'') as modified_date,DTSRC.[modified_by],DTSRC.[is_deleted] FROM [DailyTaskSheet_Relative_Cost] DTSRC INNER JOIN tbl_employee EMP " +
  " ON DTSRC.Emp_ID=EMP.id WHERE DTSRC.is_deleted=1 order by 1 desc";
            SqlDataAdapter da = new SqlDataAdapter(Query, cn);
            DataSet ds = new DataSet();
            DataTable dt = new DataTable();
            da.Fill(ds, "RelativeCostDetails");
            dt = ds.Tables["RelativeCostDetails"];
            return ToJson(dt);
        }
    }
    #endregion


   
}
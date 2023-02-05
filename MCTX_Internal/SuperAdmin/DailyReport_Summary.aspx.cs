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

public partial class MCTX_Internal_SuperAdmin_DailyReport_Summary : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            GetEmployee();
        }
    }

    #region [Oct 27, 2011] by Obaid

    public void GetEmployee()
    {
        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionstring2"].ToString()))
        {

            SqlCommand cmd = new SqlCommand("select U.user_id,E.E_Name from user1 U inner join tbl_Employee E on U.E_badge=E.E_badge where isnull(E.deleted,0)<>1  order by E.E_Name", cn);
            cn.Open();
            SqlDataReader ddlValues;
            ddlValues = cmd.ExecuteReader();
            ddlUsers.DataSource = ddlValues;
            ddlUsers.DataValueField = "user_id";
            ddlUsers.DataTextField = "E_Name";
            ddlUsers.DataBind();
            ddlUsers.Items.Insert(0, "");
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


    [WebMethod]
    public static Dictionary<string, object> GetUserDailyReport(string userID, string FromDate,string ToDate)
    {
        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionstring2"].ToString()))
        {
            //SqlCommand cmd = new SqlCommand("Web_Proc_GetEmpDailOutPutReport", cn);
            SqlCommand cmd = new SqlCommand();
            cmd.CommandText = "Web_Proc_GetEmpDailOutPutReport";
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Add("@UserID", userID);
            cmd.Parameters.Add("@FromDate", DateTime.Parse(FromDate));
            cmd.Parameters.Add("@TODATE", DateTime.Parse(ToDate));
            cmd.Connection = cn;
            //SqlCommand cmd = new SqlCommand("SELECT Act_Expense.Expense_Id, Act_Expense.Expense_By, Act_Expense.Expense_Amount,Act_Expense.Expense_Date,Act_ExpenseType.ExpenseType_Name, Act_Projects.Pro_Name,Act_Expense.Expense_Status, Act_Expense.Created_By, Act_Expense.Created_Date,Act_Expense.Modified_By, Act_Expense.Modified_Date from Act_Expense inner join Act_ExpenseType on Act_Expense.Expense_Type = Act_ExpenseType.ExpenseType_Id inner join Act_Projects on Act_Expense.Expense_Project = Act_Projects.Project_Id where Act_Expense.deleted=0 order by Expense_Id desc", cn);
            cn.Open();
            SqlDataAdapter DA = new SqlDataAdapter(cmd);
            DataSet ds = new DataSet();
            DA.Fill(ds, "DailyReportDetails");
            // string json = JsonConvert.SerializeObject(Picture);
            DataTable dt = new DataTable();
            dt = ds.Tables["DailyReportDetails"];
            return ToJson(dt);


        }

        
    }

}

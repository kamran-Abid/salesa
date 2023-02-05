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

public partial class MCTX_Internal_FrmExpenseDetails : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        PopulateExpanseType();
        PopulateProjectName2();
        PopulateEmployee1();
        PopulateEmployee2();
        PopulateExpenseBy();
        PopulateExpenseCategory();
        //try
        //{
        //   using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionstring2"].ToString()))
        //{
        //    SqlCommand cmd = new SqlCommand("select top 50 Expense_Id, Expense_Amount, Expense_Date, Expense_Type, Expense_Project, Expense_Status, Expense_By, Created_By from Act_Expense order by Expense_Id desc", cn);
        //    cn.Open();
        //    SqlDataAdapter DA = new SqlDataAdapter(cmd);
        //    DataSet ds = new DataSet();
        //    DA.Fill(ds, "ExpDetails");
        //    // string json = JsonConvert.SerializeObject(Picture);
        //    DataTable dt = new DataTable();
        //    dt = ds.Tables["ExpDetails"];
        //    return ToJson(dt);


        //}
        //}
        //catch (Exception ex)
        //{

        //    //throw;
        //}

    }


    public void PopulateExpanseType()
    {

        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionstring2"].ToString()))
        {

            SqlCommand cmd = new SqlCommand("SELECT ExpenseType_Id,ExpenseType_Name FROM Act_ExpenseType order by ExpenseType_Name", cn);
            cn.Open();
            SqlDataReader ddlValues;
            ddlValues = cmd.ExecuteReader();
            ddlExpenseType.DataSource = ddlValues;
            ddlExpenseType.DataValueField = "ExpenseType_Id";
            ddlExpenseType.DataTextField = "ExpenseType_Name";
            ddlExpenseType.DataBind();
            ddlExpenseType.Items.Insert(0, "");
        }
    }

    public void PopulateProjectName2()
    {

        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionstring2"].ToString()))
        {

            SqlCommand cmd = new SqlCommand("SELECT  Project_Id,Pro_Name FROM Act_Projects where isnull(deleted,1)<>0 order by Pro_Name", cn);
            cn.Open();
            SqlDataReader ddlValues;
            ddlValues = cmd.ExecuteReader();
            ddlProjectName.DataSource = ddlValues;
            ddlProjectName.DataValueField = "Project_Id";
            ddlProjectName.DataTextField = "Pro_Name";
            ddlProjectName.DataBind();
            ddlProjectName.Items.Insert(0, "");
        }
    }

    public void PopulateEmployee1()
    {

        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionstring2"].ToString()))
        {

            SqlCommand cmd = new SqlCommand("select U.user_id,E.E_Name from user1 U inner join tbl_Employee E on U.E_badge=E.E_badge where isnull(E.deleted,0)<>1  order by E.E_Name", cn);
            cn.Open();
            SqlDataReader ddlValues;
            ddlValues = cmd.ExecuteReader();
            ddlDispersedTo.DataSource = ddlValues;
            ddlDispersedTo.DataValueField = "user_id";
            ddlDispersedTo.DataTextField = "E_Name";
            ddlDispersedTo.DataBind();
            ddlDispersedTo.Items.Insert(0, "");
        }
    }

    public void PopulateEmployee2()
    {

        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionstring2"].ToString()))
        {

            SqlCommand cmd = new SqlCommand("select U.user_id,E.E_Name from user1 U inner join tbl_Employee E on U.E_badge=E.E_badge where isnull(E.deleted,0)<>1  order by E.E_Name", cn);
            cn.Open();
            SqlDataReader ddlValues;
            ddlValues = cmd.ExecuteReader();
            ddlReceivedBy.DataSource = ddlValues;
            ddlReceivedBy.DataValueField = "user_id";
            ddlReceivedBy.DataTextField = "E_Name";
            ddlReceivedBy.DataBind();
            ddlReceivedBy.Items.Insert(0, "");
        }
    }//ddlExpenseBy


    public void PopulateExpenseBy()
    {

        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionstring2"].ToString()))
        {

            SqlCommand cmd = new SqlCommand("select U.user_id,E.E_Name from user1 U inner join tbl_Employee E on U.E_badge=E.E_badge where isnull(E.deleted,0)<>1  order by E.E_Name", cn);
            cn.Open();
            SqlDataReader ddlValues;
            ddlValues = cmd.ExecuteReader();
            ddlExpenseBy.DataSource = ddlValues;
            ddlExpenseBy.DataValueField = "user_id";
            ddlExpenseBy.DataTextField = "E_Name";
            ddlExpenseBy.DataBind();
            ddlExpenseBy.Items.Insert(0, "");
        }
    }

    public void PopulateExpenseCategory()
    {

        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionstring2"].ToString()))
        {

            SqlCommand cmd = new SqlCommand("SELECT ExpenseCat_Id,ExpenseCat_Name FROM Act_ExpenseCategory", cn);
            cn.Open();
            SqlDataReader ddlValues;
            ddlValues = cmd.ExecuteReader();

            ddlExpenseCategory.DataSource = ddlValues;
            ddlExpenseCategory.DataValueField = "ExpenseCat_Id";
            ddlExpenseCategory.DataTextField = "ExpenseCat_Name";
            ddlExpenseCategory.DataBind();
            ddlExpenseCategory.Items.Insert(0, "");
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


    [WebMethod]
    public static Dictionary<string, object> GetExpenseDetails()
    {
        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionstring2"].ToString()))
        {
            SqlCommand cmd = new SqlCommand("SELECT Act_Expense.Expense_Id, Act_Expense.Expense_By, Act_Expense.Expense_Amount,Act_Expense.Expense_Date,Act_ExpenseType.ExpenseType_Name, Act_Projects.Pro_Name,Act_Expense.Expense_Status, Act_Expense.Created_By, Act_Expense.Created_Date,Act_Expense.Modified_By, Act_Expense.Modified_Date from Act_Expense inner join Act_ExpenseType on Act_Expense.Expense_Type = Act_ExpenseType.ExpenseType_Id inner join Act_Projects on Act_Expense.Expense_Project = Act_Projects.Project_Id where Act_Expense.deleted=0 order by Expense_Id desc", cn);
            cn.Open();
            SqlDataAdapter DA = new SqlDataAdapter(cmd);
            DataSet ds = new DataSet();
            DA.Fill(ds, "ExpDetails");
            // string json = JsonConvert.SerializeObject(Picture);
            DataTable dt = new DataTable();
            dt = ds.Tables["ExpDetails"];
            return ToJson(dt);


        }
    }


    [WebMethod]
    public static Dictionary<string, object> GetExpAdvSearch(string expId, string expBy, string expCategory, string expDate,string expDateTo, string expType, string expProject, string expStatus, string createdBy, string modifiedBy)
    {
        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionstring2"].ToString()))
        {
            //string cmd = "select top 100 Expense_Id, Expense_By, Expense_Amount, Expense_Date, Expense_Type, Expense_Project, Expense_Status, Created_By  from Act_Expense where Deleted='" + 0 + "'";

            string cmd = "select top 500  Expen.Expense_Id, Expen.Expense_By, Expen.Expense_Amount,Expen.Expense_Detail, Expen.Expense_Date," +
                "ExpT.ExpenseType_Name, pro.Pro_Name,Expen.Expense_Status,ExCate.ExpenseCat_Name , Expen.Created_By,Expen.Created_Date,Expen.Modified_By,Expen.Modified_Date" +
                " from Act_Expense Expen"+
                " inner join Act_Projects pro"+
                " on pro.Project_id=Expen.Expense_Project"+
                " inner join Act_ExpenseType ExpT"+
                " on ExpT.ExpenseType_ID=Expen.Expense_Type"+
                " inner join Act_ExpenseCategory ExCate"+
                " on ExCate.ExpenseCat_Id=Expen.Expense_Category"+
                " where isnull(Expen.deleted,0)<>1";

            if (expId != "")
            {
                cmd += " and Expen.Expense_Id like '" + expId + "%'  ";
            }

            if (expBy != "")
            {
                cmd += " and Expen.Expense_By = '" + expBy + "'";
            }
            if (expCategory != "")
            {
                cmd += " and Expen.Expense_Category  = '" + expCategory + "'  ";
            }
            if (expDate != "" && expDateTo!="")
            {
                cmd += " and Expense_Date  between convert(datetime,'" + expDate + "') and convert(datetime,'" + expDateTo + "')  ";
            }
            if (expType != "")
            {
                cmd += " and Expen.Expense_Type ='" + expType + "'  ";
            }
            if (expProject != "")
            {
                cmd += " and Expen.Expense_Project = '" + expProject + "'  ";
            }
            if (expStatus != "")
            {
                cmd += " and Expen.Expense_Status = '" + expStatus + "' ";
            }
            if (createdBy != "")
            {
                cmd += " and Expen.Created_By like '" + createdBy + "'  ";
            }
            if (modifiedBy != "")
            {
                cmd += " and Expen.Modified_By = '" + modifiedBy + "'  ";
            }

            cmd += "order by Expense_Id desc";
            SqlCommand sqlcmd = new SqlCommand(cmd, cn);
            cn.Open();
            SqlDataAdapter DA = new SqlDataAdapter(sqlcmd);
            DataSet ds = new DataSet();
            DA.Fill(ds, "AdvDetails");
            cn.Close();
            DataTable dt = new DataTable();
            dt = ds.Tables["AdvDetails"];
            return ToJson(dt);
        }


    }


    [WebMethod]
    public static void DeleteExpense(string expID)
    {
        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionstring2"].ToString()))
        {
            SqlCommand sqlcmd = new SqlCommand("update Act_Expense set deleted=1 where Expense_Id=" + expID + "", cn);
            cn.Open();
            sqlcmd.ExecuteNonQuery();
            cn.Close();
        }
    }

    protected void btn_back_Click(object sender, EventArgs e)
    {
        Response.Redirect("ReceiptsAndExpense.aspx");
    }
    protected void btnExportToExcel_Click(object sender, EventArgs e)
    {
        string html = hdnExeclInfo.Value;
        ExportToExcel(ref html, "MyReport");
    }

    public void ExportToExcel(ref string html, string fileName)
    {
        html = html.Replace("&gt;", ">");
        html = html.Replace("&lt;", "<");
        HttpContext.Current.Response.ClearContent();
        HttpContext.Current.Response.AddHeader("content-disposition", "attachment;filename=" + fileName + "_" + DateTime.Now.ToString("M_dd_yyyy_H_M_s") + ".xls");
        HttpContext.Current.Response.ContentType = "application/xls";
        HttpContext.Current.Response.Write(html);
        HttpContext.Current.Response.End();
    }
}

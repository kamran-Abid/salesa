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

public partial class MCTX_Internal_SuperAdmin_frmAssignVariables : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        LoadEmp();
        LoadVariables();
        LoadTarget();
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

    #region LoadDDLS
    public void LoadEmp()
    {
        try
        {
            using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionstring2"].ToString()))
            {
                SqlCommand cmd = new SqlCommand("SELECT user1.User_Id, tbl_Employee.E_Name from user1 inner join tbl_Employee on " +
                                    "user1.E_badge=tbl_Employee.E_badge where isnull(tbl_Employee.deleted,0)<>1 and isnull(user1.deleted,0)<>1 order " +
                                    "by E_Name asc", cn);
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);
                ddlEmployee.DataSource = dt;
                ddlEmployee.DataValueField = "User_Id";
                ddlEmployee.DataTextField = "E_Name";
                ddlEmployee.DataBind();
                ddlEmployee.Items.Insert(0, "");
            }
        }
        catch (Exception)
        {

            //throw;
        }
    }
    public void LoadVariables()
    {
        try
        {
            using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionstring2"].ToString()))
            {
                SqlCommand cmd = new SqlCommand("select variable_id, Variablename from tbl_variables where Deleted = '" + false + "' order by Variablename asc", cn);
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);
                ddlVariable.DataSource = dt;
                ddlVariable.DataValueField = "variable_id";
                ddlVariable.DataTextField = "Variablename";
                ddlVariable.DataBind();
                ddlVariable.Items.Insert(0, "");
            }
        }
        catch (Exception)
        {
            //throw;;
        }
    }
    public void LoadTarget()
    {
        try
        {
            using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionstring2"].ToString()))
            {
                SqlCommand cmd = new SqlCommand("Select td_id,td_name From T_TargetDuration", cn);
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);
                ddlEvaluation.DataSource = dt;
                ddlEvaluation.DataValueField = "td_id";
                ddlEvaluation.DataTextField = "td_name";
                ddlEvaluation.DataBind();
                ddlEvaluation.Items.Insert(0, "");
            }
        }
        catch (Exception)
        {
            //throw;"Select * From T_TargetDuration";
        }
    }
    #endregion

    #region AssignVariable
    [WebMethod]
    public static void AssignVar(string EmpID, string VarID, string Eval, string EvalID, string IOC, string IOS)
    {
        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionstring2"].ToString()))
        {
            SqlCommand cmd = new SqlCommand("INSERT INTO [tble_uservariables]" +
                                           "([Variable_commission],[variable_deduction],[user_id]," +
                                           "[variable_id],[Evaluation_on],[EvalID],[Deleted])VALUES" +
                                           "('" + IOC + "','" + IOS + "','" + EmpID + "','" + VarID + "','" + Eval + "','" + EvalID + "','" + false + "')", cn);
            cn.Open();
            cmd.ExecuteNonQuery();
        }
    }
    #endregion

    #region GetAssignedVariable
    [WebMethod]
    public static Dictionary<string, object> GetVar()
    {
        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionstring2"].ToString()))
        {
            string Query = "SELECT distinct [tble_uservariables].[UserVariable_Id] as ID,isnull([tble_uservariables].[user_id],'') as UserID" +
                           ",isnull([tbl_employee].[E_Name],'') as EmpName ,isnull([tbl_variables].[Variablename],'') as VarName" +
                           ",isnull([tble_uservariables].[Variable_commission],0) as Commission" +
                           ",isnull([tble_uservariables].[variable_deduction],0) as Deduction" +
                           ",isnull([tble_uservariables].[variable_id],0) as VarID" +
                           ",isnull([tble_uservariables].[Evaluation_on],0) as Eval" +
                           ",isnull([tble_uservariables].[EvalID],0) as EvalID " +
                           "FROM [tble_uservariables] inner join " +
                           "[tbl_variables] on [tble_uservariables].[variable_id] = [tbl_variables].[variable_id] " +
                           "inner join [user1] on [tble_uservariables].[user_id] = [user1].[user_id] " +
                           "inner join [tbl_employee] on [user1].[E_badge] = [tbl_employee].[E_badge] " +
                           "where ISNULL([tble_uservariables].[Deleted],0)<>1 order by [tble_uservariables].[UserVariable_Id] desc";
            cn.Open();
            SqlCommand cmd = new SqlCommand(Query, cn);
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataSet ds = new DataSet();
            da.Fill(ds, "Details");
            DataTable dt = new DataTable();
            dt = ds.Tables["Details"];
            return ToJson(dt);
        }
    }
    #endregion

    #region DelAssignedVariable
    [WebMethod]
    public static void DeleteAssVar(string ID)
    {
        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionstring2"].ToString()))
        {
            SqlCommand cmd = new SqlCommand("Delete From [tble_uservariables] where [UserVariable_Id] = '" + ID + "'  ", cn);
            cn.Open();
            cmd.ExecuteNonQuery();
        }
    }
    #endregion

    #region Update
    [WebMethod]
    public static void UpdateVar(string ID, string EmpID, string VarID, string Eval, string EvalID, string IOC, string IOS)
    {
        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionstring2"].ToString()))
        {
            SqlCommand cmd = new SqlCommand("UPDATE [tble_uservariables] " +
                                            "SET [Variable_commission] = '" + IOC + "'" +
                                              ",[variable_deduction] = '" + IOS + "'" +
                                              ",[user_id] = '" + EmpID + "'" +
                                              ",[variable_id] = '" + VarID + "'" +
                                              ",[Evaluation_on] = '" + Eval + "'" +
                                              ",[EvalID] = '" + EvalID + "'" +
                                              ",[Deleted] = '" + false + "'" +
                                            "WHERE [UserVariable_Id] = '" + ID + "'", cn);
            cn.Open();
            cmd.ExecuteNonQuery();
        }
    }
    #endregion

}

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


public partial class MCTX_Internal_SuperAdmin_frmDepartInfo : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        GetBranch();
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

    #region LoadDDL
    public void GetBranch()
    {
        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionstring2"].ToString()))
        {
            SqlCommand cmd = new SqlCommand("select BRID, BRANCHNAME from tbl_Branches order by BRANCHNAME asc", cn);
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);
            ddlBranch.DataSource = dt;
            ddlBranch.DataValueField = "BRID";
            ddlBranch.DataTextField = "BRANCHNAME";
            ddlBranch.DataBind();
            ddlBranch.Items.Insert(0, "");
        }
    }
    #endregion

    #region SaveDept
    [WebMethod]
    public static void SaveDepart(string BranchID, string DeptName, string Phn1, string Phn2, string Address)
    {
        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionstring2"].ToString()))
        {
            SqlCommand cmd = new SqlCommand();
            cmd.CommandText = "Web_Proc_SaveDeparts";
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Add("@BranchID", int.Parse(BranchID));
            cmd.Parameters.Add("@DeptName", DeptName);
            cmd.Parameters.Add("@Phn1", Phn1);
            cmd.Parameters.Add("@Phn2", Phn2);
            cmd.Parameters.Add("@Address", Address);
            cmd.Parameters.Add("@Deleted", false);
            cmd.Connection = cn;
            cn.Open();
            cmd.ExecuteNonQuery();
        }
    }
    #endregion

    #region GetDepart
    [WebMethod]
    public static Dictionary<string, object> GetDepart()
    {
        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionstring2"].ToString()))
        {
            SqlCommand cmd = new SqlCommand();
            cmd.CommandText = "Web_Proc_GetDepartmentDetails";
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Connection = cn;
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataSet ds = new DataSet();
            da.Fill(ds, "DepartDetails");
            DataTable dt = new DataTable();
            dt = ds.Tables["DepartDetails"];
            return ToJson(dt);
        }
    }
    #endregion

    #region UpdateDepart
    [WebMethod]
    public static void UpdateDepart(string DeptID, string BranchID, string DeptName, string Phn1, string Phn2, string Address)
    {
        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionstring2"].ToString()))
        {
            SqlCommand cmd = new SqlCommand();
            cmd.CommandText = "Web_Proc_UpdateDepartmentDetails";
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Add("@DeptName", DeptName);
            cmd.Parameters.Add("@Address", Address);
            cmd.Parameters.Add("@Phn1", Phn1);
            cmd.Parameters.Add("@Phn2", Phn2);
            cmd.Parameters.Add("@BranchID", int.Parse(BranchID));
            cmd.Parameters.Add("@Deleted", false);
            cmd.Parameters.Add("@DeptID", int.Parse(DeptID));
            cmd.Connection = cn;
            cn.Open();
            cmd.ExecuteNonQuery();
        }
    }
    #endregion

    #region DeleteDepart
    [WebMethod]
    public static void DelDept(string ID)
    {
        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionstring2"].ToString()))
        {
            SqlCommand cmd = new SqlCommand("Update Tbl_Department Set Deleted = 1 where D_ID = '" + ID + "'", cn);
            cn.Open();
            cmd.ExecuteNonQuery();
        }
    }
    #endregion

}

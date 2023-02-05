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

public partial class MCTX_Internal_SuperAdmin_frmEmpVariables : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

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

    #region SaveVariables
    [WebMethod]
    public static void SaveVar(string Variable)
    {
        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionstring2"].ToString()))
        {
            SqlCommand cmd = new SqlCommand("INSERT INTO [tbl_variables]([Variablename],[Deleted])" +
                                            "VALUES('" + Variable + "','" + false + "')", cn);
            cn.Open();
            cmd.ExecuteNonQuery();
        }
    }
    #endregion

    #region GetDetails
    [WebMethod]
    public static Dictionary<string, object> GetDetails()
    {
        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionstring2"].ToString()))
        {
            SqlCommand cmd = new SqlCommand("Select distinct * from [tbl_variables] where [Deleted] = '" + false + "' order by [Variablename] asc", cn);
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataSet ds = new DataSet();
            da.Fill(ds, "Details");
            DataTable dt = new DataTable();
            dt = ds.Tables["Details"];
            return ToJson(dt);
        }
    }
    #endregion

    #region CheckVariable
    [WebMethod]
    public static int CheckVar(string Variable)
    {
        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionstring2"].ToString()))
        {
            SqlCommand cmd = new SqlCommand("Select * from [tbl_variables] where [Variablename] = '" + Variable + "' and [Deleted] = '" + false + "'", cn);
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataSet ds = new DataSet();
            da.Fill(ds, "Details");
            DataTable dt = new DataTable();
            dt = ds.Tables["Details"];
            int result = 0;
            if (dt.Rows.Count > 0)
            {
                result = 1;
            }
            return result;
        }
    }
    #endregion

    #region UpdateVariable
    [WebMethod]
    public static void UpdateVar(string VarID, string Variable)
    {
        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionstring2"].ToString()))
        {
            SqlCommand cmd = new SqlCommand("UPDATE tbl_variables SET [Variablename] = '" + Variable + "' where variable_id = '" + VarID + "'", cn);
            cn.Open();
            cmd.ExecuteNonQuery();
        }
    }
    #endregion

}

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

public partial class MCTX_Internal_SuperAdmin_frmAddITProjects : System.Web.UI.Page
{
    static string userid = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Request.Cookies["userName"] == null)
        {
            Response.Redirect("../../MCTX_General/Login.aspx");
            return;
        }
        else
        {
            userid = Request.Cookies["Username"].Value.ToString();
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
    #region SaveProject
    [WebMethod]
    public static void SaveITProject(string ProjName)
    {
        DateTime Date = DateTime.Parse(DateTime.Now.ToShortDateString());
        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionstring2"].ToString()))
        {
            SqlCommand cmd = new SqlCommand();
            cmd.CommandText = "Web_Proc_SaveITProjects";
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Add("@ProjName", ProjName);
            cmd.Parameters.Add("@CreatedBy", userid);
            cmd.Parameters.Add("@CreatedDate", Date);
            cmd.Parameters.Add("@ModBy", userid);
            cmd.Parameters.Add("@ModDate", Date);
            cmd.Parameters.Add("@Deleted", false);
            cmd.Connection = cn;
            cn.Open();
            cmd.ExecuteNonQuery();
        }
    }
    #endregion
    #region GetProjectDetails
    [WebMethod]
    public static Dictionary<string, object> GetITProjDetails()
    {
        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionstring2"].ToString()))
        {
            SqlCommand cmd = new SqlCommand();
            cmd.CommandText = "Web_Proc_GetITProjDetails";
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Connection = cn;
            cn.Open();
            SqlDataAdapter DA = new SqlDataAdapter(cmd);
            DataSet ds = new DataSet();
            DA.Fill(ds, "ITProjDetails");
            DataTable dt = new DataTable();
            dt = ds.Tables["ITProjDetails"];
            return ToJson(dt);
        }
    }
    #endregion
    #region UpdateITProjects
    [WebMethod]
    public static void UpdateITProjs(string ProjID, string ProjName)
    {
        DateTime Date = DateTime.Parse(DateTime.Now.ToShortDateString());
        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionstring2"].ToString()))
        {
            SqlCommand cmd = new SqlCommand();
            cmd.CommandText = "Web_Proc_UpdateITProjs";
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Add("@ProjID", int.Parse(ProjID));
            cmd.Parameters.Add("@ProjName", ProjName);
            cmd.Parameters.Add("@ModBy", userid);
            cmd.Parameters.Add("@ModDate", Date);
            cmd.Parameters.Add("@Deleted", false);
            cmd.Connection = cn;
            cn.Open();
            cmd.ExecuteNonQuery();
        }
    }
    #endregion
    #region DeleteITProjects
    [WebMethod]
    public static void DeleteITProjs(string ProjID)
    {
        DateTime Date = DateTime.Parse(DateTime.Now.ToShortDateString());
        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionstring2"].ToString()))
        {
            SqlCommand cmd = new SqlCommand("UPDATE [tbl_IT_Projects] SET [Deleted] = '" + true + "', [ModifiedBy] = '" + userid + "', [ModifiedDate] = '" + Date + "' where [Proj_IT_ID] = '" + ProjID + "'", cn);
            cn.Open();
            cmd.ExecuteNonQuery();
        }
    }
    #endregion
}

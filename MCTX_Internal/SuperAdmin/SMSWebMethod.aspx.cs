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
using System.Data.SqlClient;
using System.Runtime.Serialization.Json;
using System.Web.Script.Serialization;
using System.Web.Services;
using System.Collections.Generic;

public partial class MCTX_Internal_SMS_TaskManager_SMSWebMethod : System.Web.UI.Page
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
        List<Dictionary<string, object>> objs = new List<Dictionary<string, object>>();
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
    #region Get SMS_Tasks

    [WebMethod]
    public static Dictionary<string, object> GetSMS_Tasks()
    {
        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["Connection"].ToString()))
        {
            SqlCommand cmd = new SqlCommand("select * from SMS_tasks where task_deleted!=1 order by task_id desc", cn);
            cn.Open();
            SqlDataAdapter DA = new SqlDataAdapter(cmd);
            DataSet ds = new DataSet();
            DA.Fill(ds, "SMS_Tasks");
            // string json = JsonConvert.SerializeObject(Picture);
            DataTable dt = new DataTable();
            dt = ds.Tables["SMS_Tasks"];
            return ToJson(dt);
        }
    }

#endregion

    #region Delete SMS Tasks

    [WebMethod]
    public static void DeleteTask(string TaskID)
    {
        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["Connection"].ToString()))
        {
            SqlCommand cmd = new SqlCommand("update SMS_tasks set task_deleted=1 where task_Id="+TaskID+"", cn);
            cn.Open();
            cmd.ExecuteNonQuery();
        }
    }
#endregion

    #region Get Account SMS
    [WebMethod]
    public static Dictionary<string, object> Get_AccountSMS()
    {
        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["Connection"].ToString()))
        {
            SqlCommand cmd = new SqlCommand("select * FROM [SMS_Accounts] order by id desc", cn);
            cn.Open();
            SqlDataAdapter DA = new SqlDataAdapter(cmd);
            DataSet ds = new DataSet();
            DA.Fill(ds, "SMS_Tasks");
            // string json = JsonConvert.SerializeObject(Picture);
            DataTable dt = new DataTable();
            dt = ds.Tables["SMS_Tasks"];
            return ToJson(dt);
        }
    }

    #endregion
}

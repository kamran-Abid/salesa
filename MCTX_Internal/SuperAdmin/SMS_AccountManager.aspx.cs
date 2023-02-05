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
using Sales_BOL;
using System.Runtime.Serialization.Json;
using System.Web.Script.Serialization;
using System.Web.Services;
using System.Collections.Generic;
using System.Data.SqlClient;

public partial class MCTX_Internal_SuperAdmin_SMS_TaskManager : System.Web.UI.Page
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

    #region Get Account SMS
    [WebMethod]
    public static Dictionary<string, object> Get_AccountSMS()
    {
        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionstring2"].ToString()))
        {
            SqlCommand cmd = new SqlCommand("select top 200 SC.Name, SC.Department, SA.UserID, SA.Project, SA.Time,convert(varchar(20),SA.Time,101) as Date, SA.PhoneNo, SA.Expense from SMS_Accounts SA join SMS_Contact SC on SA.UserID=SC.ID order by SA.ID desc", cn);
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

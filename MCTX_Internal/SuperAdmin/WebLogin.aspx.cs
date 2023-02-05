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
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Runtime.Serialization.Json;
using System.Web.Script.Serialization;

using Sales_BOL;
using System.Web.Services;

public partial class MCTX_Internal_SuperAdmin_WebLogin : System.Web.UI.Page
{
    #region Variables
    _Login BL_login = new Sales_BOL._Login();
    DataSet ds_userinfo = new DataSet();
    DataTable dt_userinfo = new DataTable();
    #endregion

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

    [WebMethod]
    public static Dictionary<string, object> getWebUsers(string userName)
    {
        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionstring2"].ToString()))
        {
            if (userName != "")
            {
                SqlCommand cmd = new SqlCommand("select u.user_id,u.user_pwd,u.role_id,te.E_name,u.Status,u.logName,r.role_id,r.role_name from user1 as u join tbl_role as r on u.role_id=r.role_id join tbl_Employee as te on u.E_badge = te.E_badge where  u.Deleted = 0 and te.deleted = 0 and te.E_name like'"+userName+"%'", cn);
                cn.Open();
                SqlDataAdapter DA = new SqlDataAdapter(cmd);
                DataSet ds = new DataSet();
                DA.Fill(ds, "user1");
                DataTable dt = new DataTable();
                dt = ds.Tables["user1"];
                return ToJson(dt);
            }
            else
            {

                SqlCommand cmd = new SqlCommand("select u.user_id,u.user_pwd,u.role_id,te.E_name,u.Status,u.logName,r.role_id,r.role_name from user1 as u join tbl_role as r on u.role_id=r.role_id join tbl_Employee as te on u.E_badge = te.E_badge where  u.Deleted = 0 and te.deleted = 0", cn);
                cn.Open();
                SqlDataAdapter DA = new SqlDataAdapter(cmd);
                DataSet ds = new DataSet();
                DA.Fill(ds, "user1");
                DataTable dt = new DataTable();
                dt = ds.Tables["user1"];
                return ToJson(dt);
            }
           


        }
    }
}

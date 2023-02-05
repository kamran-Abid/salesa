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
using System.Runtime.Serialization.Json;
using System.Web.Script.Serialization;
using System.Web.Services;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Text;

public partial class MCTX_Internal_SuperAdmin_IMS_product_issue_details : System.Web.UI.Page
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

    #region Issue products mubashir

    [WebMethod]
    public static Dictionary<string, object> getissuedate()
    {

        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionstring2"].ToString()))
        {

            SqlCommand cmd = new SqlCommand("SELECT * FROM TBL_IMS_PRODUCTS_ISSUE", cn);
            cn.Open();
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataSet ds = new DataSet();
            da.Fill(ds, "ims");
            DataTable dt = new DataTable();
            dt = ds.Tables["ims"];
            return ToJson(dt);
        }
    }
    #endregion
}
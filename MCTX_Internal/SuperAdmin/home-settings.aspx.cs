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

public partial class MCTX_Internal_SuperAdmin_home_settings : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        //getdata();
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

    #region Mubashir wellcome setting

    [WebMethod]
    public static void senddata(string newupdate, string newupdate1, string newupdate2, string newupdate3, string newupdate4, string newupdate5, string newupdate6, string newupdate7)
    {
        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionstring2"].ToString()))
        {
            string date;
            date = DateTime.Now.ToString();
            SqlCommand cmd = new SqlCommand("insert into tbl_homesettings values('" + newupdate + "','" + newupdate1 + "','" + newupdate2 + "','" + newupdate3 + "','" + newupdate4 + "','" + newupdate5 + "','" + newupdate6 + "','" + newupdate7 + "','"+ date +"')", cn);
            cn.Open();
            cmd.ExecuteNonQuery();


        }
    }
    [WebMethod]
    public static Dictionary<string, object> getdata()
    {
        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionstring2"].ToString()))
        {
            SqlCommand cmd = new SqlCommand("select top 1 * from tbl_homesettings order by 1 desc", cn);
            cn.Open();
            DataTable dt = new DataTable();
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataSet ds = new DataSet();
            da.Fill(ds, "settings");
            dt = ds.Tables["settings"];
            return ToJson(dt);
        }
    }

    [WebMethod]
    public static void titledata(string newstitle, string newstitle1, string newstitle2, string newstitle3, string newstitle4, string newstitle5, string newstitle6, string newstitle7)
    {
        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionstring2"].ToString()))
        {
            //insert into tbl_homesettingstitle values('New Update:--(Nov 01,2010)','	New Update:--(Oct 05,2010)','New Update:--(September 28,2010)','New Update:--(August 05,2010)','New Update:--(Aug 01,2010)','New Update :- (Jun 03,2008)','New Update:--(May 23,2008)','New Update:--(May 20,2008)',getdate())
            string date;
            date = DateTime.Now.ToString();
            SqlCommand cmd = new SqlCommand("insert into tbl_homesettingstitle values('" + newstitle + "','" + newstitle1 + "','" + newstitle2 + "','" + newstitle3 + "','" + newstitle4 + "','" + newstitle5 + "','" + newstitle6 + "','" + newstitle7 + "','" + date + "')", cn);
            cn.Open();
            cmd.ExecuteNonQuery();


        }
    }  


    #endregion
}

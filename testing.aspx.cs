using System;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;
using System.Drawing;
using System.Data.SqlClient;
using System.Collections.Generic;
using System.Web.Services;


public partial class testing : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    //public static Dictionary<string, object> ToJson(DataTable table)
    //{
    //    Dictionary<string, object> j = new Dictionary<string, object>();
    //    j.Add(table.TableName, RowsToDictionary(table));
    //    return j;
    //}
    //private static List<Dictionary<string, object>> RowsToDictionary(DataTable table)
    //{
    //    List<Dictionary<string, object>> objs =
    //        new List<Dictionary<string, object>>();
    //    foreach (DataRow dr in table.Rows)
    //    {
    //        Dictionary<string, object> drow = new Dictionary<string, object>();
    //        for (int i = 0; i < table.Columns.Count; i++)
    //        {
    //            drow.Add(table.Columns[i].ColumnName, dr[i]);
    //        }
    //        objs.Add(drow);
    //    }

    //    return objs;
    //}

    [WebMethod]
    public static void managament(string a,string b,string c) {
      string data="";
      try
        {
            using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionstring2"].ToString()))
            {
                SqlCommand cmd = new SqlCommand("select * from tbl_homesettings order by 1 desc", cn);
                cn.Open();
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataSet ds = new DataSet();
                da.Fill(ds, "settings");
                DataTable dt = new DataTable();
                dt = ds.Tables["tbl_homesettings"];
                SqlDataReader myreader;
                myreader = cmd.ExecuteReader();
               //return data;
          }

           // = "";
      }        
    catch (Exception) { 
        
        }
     // return data;
    }
}




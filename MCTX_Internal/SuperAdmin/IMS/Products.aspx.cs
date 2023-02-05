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

public partial class MCTX_Internal_SuperAdmin_IMS_Products : System.Web.UI.Page
{

    protected void Page_Load(object sender, EventArgs e)
    {
        GetProduts();
        GetCategory();
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

    #region products mubashir
 
    [WebMethod]
    public static Dictionary<string, object> getvalues()
    {

        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionstring2"].ToString()))
        {

            SqlCommand cmd = new SqlCommand("SELECT PRODUCTS_NAME,TOTAL_STOCK,QUANTITY_ISSUE,CATEGORY_ID FROM TBL_IMS_PRODUCTS ", cn);
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

    #region Update Stock 
    [WebMethod]
    public static void updatestock(string PRODUCTS_NAME, string CATEGORY_ID, string TOTAL_STOCK)
    {
        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionstring2"].ToString()))
        {
            DataTable dt = new DataTable();
            DataSet ds = new DataSet();
            cn.Open();
            string query = "update TBL_IMS_PRODUCTS set PRODUCTS_NAME= '" + PRODUCTS_NAME + "',CATEGORY_ID='" + CATEGORY_ID + "',TOTAL_STOCK='" + TOTAL_STOCK + "' where PRODUCTS_NAME = '" + PRODUCTS_NAME + "' ";

            SqlCommand cmd = new SqlCommand(query, cn);
            cmd.ExecuteNonQuery();
        }
    }
    #endregion

    #region Insert New Stock
    [WebMethod]
    public static void insertstock(string PRODUCTS_NAME, string CATEGORY_ID, string TOTAL_STOCK)
    {
        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionstring2"].ToString()))
        {
            DataTable dt = new DataTable();
            DataSet ds = new DataSet();
            cn.Open();
            string query = "INSERT INTO TBL_IMS_PRODUCTS  VALUES('" + PRODUCTS_NAME + "','" + CATEGORY_ID + "','','" + TOTAL_STOCK + "','')";
            SqlCommand cmd = new SqlCommand(query, cn);
            cmd.ExecuteNonQuery();
        }
    }
    #endregion

    #region product Drop down 
    public void GetProduts()
    {
        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionstring2"].ToString()))
        {
            SqlCommand cmd = new SqlCommand("SELECT PRODUCTS_NAME FROM TBL_IMS_PRODUCTS", cn);
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);
            ddlProductName.DataSource = dt;
           // ddlProductName.DataValueField = "comp_id";
           // ddlProductName.SelectedValue = "-- Select --";
            ddlProductName.DataTextField = "PRODUCTS_NAME";
            ddlProductName.DataBind();
            ddlProductName.Items.Insert(0, "");
        }
    }
    #endregion

    #region category Drop down
    public void GetCategory()
    {
        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionstring2"].ToString()))
        {
            SqlCommand cmd = new SqlCommand("SELECT CATEGORY_ID FROM TBL_IMS_PRODUCTS", cn);
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);
            ddlCategory.DataSource = dt;
            ddlCategory.DataTextField = "CATEGORY_ID";
            ddlCategory.DataBind();
            ddlCategory.Items.Insert(0, "");
        }
    }
    #endregion
}
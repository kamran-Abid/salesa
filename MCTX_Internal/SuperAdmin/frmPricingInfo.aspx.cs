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

public partial class MCTX_Internal_SuperAdmin_frmPricingInfo : System.Web.UI.Page
{
    _ItemsPrice objItmPrc = new _ItemsPrice();
    static string userid = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {

        }
        try
        {
            userid = Request.Cookies["Username"].Value.ToString();
        }
        catch (Exception)
        {

            //throw;
        }

        if (userid == "")
        {
            Response.Redirect("../../MCTX_General/Login.aspx");
            return;
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

    #region PoulateDDLs
    [WebMethod]
    public static Dictionary<string, object> PopulateCat()
    {
        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionstring2"].ToString()))
        {
            string query = "select cat_name,cat_id From tbl_category where isnull(Deleted,0)<>1 order by cat_name asc";
            SqlDataAdapter da = new SqlDataAdapter(query, cn);
            DataSet ds = new DataSet();
            da.Fill(ds, "Category");
            DataTable dt = new DataTable();
            dt = ds.Tables["Category"];
            return ToJson(dt);
        }
    }
    [WebMethod]
    public static Dictionary<string, object> PopulateItems(string CatID)
    {
        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionstring2"].ToString()))
        {
            string query = "select item_id,item_name From tbl_item where isnull(Deleted,0)<>1 and cat_id = '" + CatID + "' order by item_name asc";
            SqlDataAdapter da = new SqlDataAdapter(query, cn);
            DataSet ds = new DataSet();
            da.Fill(ds, "Items");
            DataTable dt = new DataTable();
            dt = ds.Tables["Items"];
            return ToJson(dt);
        }
    }
    #endregion

    #region SavePriceData
    [WebMethod]
    public static void SavePriceData(string catid, string itemid, string MinPrice, string MinPercent, string NormPrice, string NormPercent, string MaxPrice, string MaxPercent)
    {
        DateTime Date = DateTime.Parse(DateTime.Now.ToShortDateString());
        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionstring2"].ToString()))
        {
            SqlCommand cmd = new SqlCommand();
            cmd.CommandText = "Web_Proc_InsertPrice";
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Add("@catid", int.Parse(catid));
            cmd.Parameters.Add("@itemid", int.Parse(itemid));
            cmd.Parameters.Add("@MinPrice", MinPrice);
            cmd.Parameters.Add("@MinPercent", MinPercent);
            cmd.Parameters.Add("@NormPrice", NormPrice);
            cmd.Parameters.Add("@NormPercent", NormPercent);
            cmd.Parameters.Add("@MaxPrice", MaxPrice);
            cmd.Parameters.Add("@MaxPercent", MaxPercent);
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

    #region GetPriceData
    [WebMethod]
    public static Dictionary<string, object> RetrievePriceData()
    {
        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionstring2"].ToString()))
        {
            SqlCommand cmd = new SqlCommand();
            cmd.CommandText = "Web_Proc_GetPriceDetails";
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Connection = cn;
            cn.Open();
            SqlDataAdapter DA = new SqlDataAdapter(cmd);
            DataSet ds = new DataSet();
            DA.Fill(ds, "PriceDetails");
            DataTable dt = new DataTable();
            dt = ds.Tables["PriceDetails"];
            return ToJson(dt);
        }
    }

    #endregion

    #region DeletePriceData
    [WebMethod]
    public static void DeletePriceDetails(string PriceID)
    {
        DateTime Date = DateTime.Parse(DateTime.Now.ToShortDateString());
        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionstring2"].ToString()))
        {
            SqlCommand cmd = new SqlCommand("UPDATE [tbl_ItemsPrices] SET Deleted = " + 1 + " where ItemPrice_ID = " + int.Parse(PriceID) + "", cn);
            cn.Open();
            cmd.ExecuteNonQuery();
        }
    }
    #endregion

    #region UpdatePriceData
    [WebMethod]
    public static void UpdatePriceData(string PriceID, string catid, string itemid, string MinPrice, string MinPercent, string NormPrice, string NormPercent, string MaxPrice, string MaxPercent)
    {
        DateTime Date = DateTime.Parse(DateTime.Now.ToShortDateString());
        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionstring2"].ToString()))
        {
            SqlCommand cmd = new SqlCommand();
            cmd.CommandText = "Web_Proc_UpdatePrice";
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Add("@PriceID", int.Parse(PriceID));
            cmd.Parameters.Add("@catid", int.Parse(catid));
            cmd.Parameters.Add("@itemid", int.Parse(itemid));
            cmd.Parameters.Add("@MinPrice", MinPrice);
            cmd.Parameters.Add("@MinPercent", MinPercent);
            cmd.Parameters.Add("@NormPrice", NormPrice);
            cmd.Parameters.Add("@NormPercent", NormPercent);
            cmd.Parameters.Add("@MaxPrice", MaxPrice);
            cmd.Parameters.Add("@MaxPercent", MaxPercent);
            cmd.Parameters.Add("@ModBy", userid);
            cmd.Parameters.Add("@ModDate", Date);
            cmd.Parameters.Add("@Deleted", false);
            cmd.Connection = cn;
            cn.Open();
            cmd.ExecuteNonQuery();
        }
    }
    #endregion

}

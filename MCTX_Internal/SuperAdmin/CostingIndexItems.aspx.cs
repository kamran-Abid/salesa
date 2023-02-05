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
using System.Xml.Linq;
using System.Web.Mail;
using Org.BouncyCastle.Asn1.Ocsp;

public partial class MCTX_Internal_SuperAdmin_CostingIndexItem_ : System.Web.UI.Page
{
    static string UserID = "";
    static string CurrentDate = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        CurrentDate = DateTime.Now.ToShortDateString();
        if (Session["Username"] == null)
        {
            Response.Redirect("../../MCTX_General/Login.aspx");
            //return;
        }
        else
        {
            UserID = Session["Username"].ToString();

            using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionstring2"].ToString()))
            {
                string Query = "select costing_item_category_Id,costing_item_category_Name from [tbl_costing_item_category] where costing_item_category_is_deleted=1";
                SqlDataAdapter da = new SqlDataAdapter(Query, cn);
                DataSet ds = new DataSet();
                DataTable dt = new DataTable();
                da.Fill(ds);
                ddlCatName.DataSource = ds;
                ddlCatName.DataValueField = "costing_item_category_Id";
                ddlCatName.DataTextField = "costing_item_category_Name";
                ddlCatName.DataBind();                
                ddlCatName.Items.Insert(0, "-- Select --");
                
            }
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
    #region Add Costing Category
    [WebMethod]
    // data: "{'catId':'" + catId + "','ItemName':'" + ItemName + "','ItemRate':'" + ItemRate + "','ItemUnit':'" + ItemUnit + "','SourceName':'" + SourceName + "','SourcePhone':'" + SourcePhone + "','SourceAddress':'" + SourceAddress + "'}",
    public static void AddCostingItem(string catId,string ItemName,string ItemRate,string ItemUnit,string SourceName, string SourcePhone,string SourceAddress)
    {
        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionstring2"].ToString()))
        {
           
            cn.Open();
            string query = "Insert INTO tbl_costing_items(category_item__Id , costing_item__Name , costing_item__rate,costing_item__units , costing_item__source_name,costing_item__source_phone_no,costing_item__source_address,costing_item__date, costing_item_category_created_by,costing_item_category_isdeleted" +
                           ") Values ('" + catId + "','" + ItemName + "','" + ItemRate + "','" + ItemUnit + "','" + SourceName + "','" + SourcePhone + "' ,'" + SourceAddress + "','" + CurrentDate + "','" + UserID + "','" + 1 + "')";
            SqlCommand cmd = new SqlCommand(query, cn);
            cmd.ExecuteNonQuery();
        }
    }
    #endregion

    #region Update Costing Category
    [WebMethod]
    public static void UpdateCostingItem(string itemId, string catId, string ItemName, string ItemRate, string ItemUnit, string SourceName, string SourcePhone, string SourceAddress)
    {
        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionstring2"].ToString()))
        {
           
            cn.Open();
            string query = "update tbl_costing_items set category_item__Id='" + catId + "', costing_item__Name='" + ItemName + "',costing_item__rate='" + ItemRate + "',costing_item__units='" + ItemUnit + "',costing_item__source_name='" + SourceName + "',costing_item__source_phone_no='" + SourcePhone + "',costing_item__source_address='" + SourceAddress + "' where costing_item__Id=" + itemId;
            SqlCommand cmd = new SqlCommand(query, cn);
            cmd.ExecuteNonQuery();
        }
    }
    #endregion

    #region Get Category
    [WebMethod]
    public static Dictionary<string, object> GetCostingIndexItem()
    {
        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionstring2"].ToString()))
        {
            string Query = "select it.costing_item__Id,it.category_item__Id,it.costing_item__Name,ct.costing_item_category_Name,it.costing_item__rate,it.costing_item__units,it.costing_item__source_name,it.costing_item__source_phone_no,it.costing_item__source_address,isnull (convert(varchar(20),it.costing_item__date,101),'') as costing_item__date,it.costing_item_category_created_by from tbl_costing_items it inner join tbl_costing_item_category ct on it.category_item__Id=ct.costing_item_category_Id where it.costing_item_category_isdeleted=1 order by 1 desc";
            SqlDataAdapter da = new SqlDataAdapter(Query, cn);
            DataSet ds = new DataSet();
            DataTable dt = new DataTable();
            da.Fill(ds, "itemDiscription");
            dt = ds.Tables["itemDiscription"];
            return ToJson(dt);
        }
    }
    #endregion
}
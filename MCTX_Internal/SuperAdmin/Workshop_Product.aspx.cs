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

public partial class MCTX_Internal_SuperAdmin_Workshop_Product : System.Web.UI.Page
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
                string Query = "SELECT  Project_id,Project_Name   FROM [workshop_project] where is_deleted=1";
                SqlDataAdapter da = new SqlDataAdapter(Query, cn);
                DataSet ds = new DataSet();
                DataTable dt = new DataTable();
                da.Fill(ds);
                ddlProject.DataSource = ds;
                ddlProject.DataValueField = "Project_id";
                ddlProject.DataTextField = "Project_Name";
                ddlProject.DataBind();
                ddlProject.Items.Insert(0, "-- Select --");

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
    #region Get Project
    [WebMethod]
    public static Dictionary<string, object> getProjectDetails()
    {
        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionstring2"].ToString()))
        {
            string Query = "SELECT  [Project_id],wpj.Priority_id,wpt.[Priority_description],[Project_Name],isnull (CONVERT(varchar(20), [created_date],101),'') as [created_date]" +
      ",[created_by],ISNULL(CONVERT(varchar(20), [modified_date],101),'') as [modified_date]"+
      ",[modified_by],[is_deleted]  FROM [workshop_project] wpj inner join [workshop_priority] wpt"+
      " on wpj.[Priority_id]=wpt.Priority_id  where is_deleted=1 order by 1 desc";
            SqlDataAdapter da = new SqlDataAdapter(Query, cn);
            DataSet ds = new DataSet();
            DataTable dt = new DataTable();
            da.Fill(ds, "ProjDetails");
            dt = ds.Tables["ProjDetails"];
            return ToJson(dt);
        }
    }
    #endregion


    #region SaveProduct
    [WebMethod]
    public static void SaveProduct(string PrductName, string ProjectID)
    {

        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionstring2"].ToString()))
        {

            cn.Open();
            string query = "INSERT INTO [workshop_product]"+ 
                 "([Product_name],[Project_id],[created_date],[created_by] ,[modified_date] ,[modified_by],[is_deleted])" +
            "VALUES('" + PrductName + "','" + ProjectID + "','" + CurrentDate + "','" + UserID + "','" + CurrentDate + "','" + UserID + "', '" + 1 + "' )";
            SqlCommand cmd = new SqlCommand(query, cn);
            cmd.ExecuteNonQuery();
        }
    }
    #endregion
    #region Get Product
    [WebMethod]
    public static Dictionary<string, object> getProductDetails()
    {
        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionstring2"].ToString()))
        {
            string Query = "SELECT [Product_id],[Product_name],wpj.Project_Name,wpd.[Project_id],ISNULL(CONVERT(varchar(20),wpd.[created_date],101),'') as created_date ,wpd.[created_by]," +
"ISNULL(CONVERT(varchar(20),wpd.[modified_date],101),'') as modified_date,wpd.[modified_by] ,wpd.[is_deleted]   FROM [workshop_product] wpd" + 
  " inner join [workshop_project] wpj on  wpd.Project_id=wpj.Project_id"+   
   " where wpd.is_deleted=1 ";
            SqlDataAdapter da = new SqlDataAdapter(Query, cn);
            DataSet ds = new DataSet();
            DataTable dt = new DataTable();
            da.Fill(ds, "ProductDetails");
            dt = ds.Tables["ProductDetails"];
            return ToJson(dt);
        }
    }
    #endregion
   

    #region Update Product
    [WebMethod]
    public static void UpdateProduct(string ProductID, string PrductName, string ProjectID)
    {

        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionstring2"].ToString()))
        {

            cn.Open();
            string query = "UPDATE [workshop_product]" +
   "SET [Project_id] = '" + ProjectID + "',[Product_name] = '" + PrductName + "',[modified_date] = '" + CurrentDate + "'" +
     " ,[modified_by] = '" + UserID + "' WHERE Product_id='" + ProductID + "'";
            SqlCommand cmd = new SqlCommand(query, cn);
            cmd.ExecuteNonQuery();
        }
    }
    #endregion
}
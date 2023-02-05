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

public partial class MCTX_Internal_SuperAdmin_Workshop_Management_FeedBack : System.Web.UI.Page
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

            using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionstring2"].ToString()))
            {
                string Query = "SELECT  Product_id,Product_name   FROM [workshop_product] where is_deleted=1";
                SqlDataAdapter da = new SqlDataAdapter(Query, cn);
                DataSet ds = new DataSet();
                DataTable dt = new DataTable();
                da.Fill(ds);
                ddlProduct.DataSource = ds;
                ddlProduct.DataValueField = "Product_id";
                ddlProduct.DataTextField = "Product_name";
                ddlProduct.DataBind();
                ddlProduct.Items.Insert(0, new ListItem("-- Select --", "0"));


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
    #region Get FeedBack Details
    [WebMethod]
    public static Dictionary<string, object> getFeedBackDetails()
    {
        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionstring2"].ToString()))
        {
            string Query = "SELECT  [Workshop_FeedBak_ID]"+
      ",[Workshop_FeedBak_Description]"+
      ",[Workshop_Project_id],prj.[Project_Name]"+
      ",[Workshop_Product_id],prd.[Product_name]"+
      ",ISNULL(CONVERT(varchar(20), fd.[created_date],101),'') as [created_date]"+
      ",fd.[created_by]"+
      ",ISNULL(CONVERT(varchar(20), fd.[modified_date],101),'') as [modified_date]"+
      ",fd.[modified_by]"+
      ",fd.[is_deleted]"+
  " FROM [workshop_FeedBack] fd inner join [workshop_project] prj on fd.Workshop_Project_id=prj.Project_id" +
  " inner join [workshop_product] prd on fd.Workshop_Product_id=prd.Product_id where fd.is_deleted=1 order by 1 desc";
            SqlDataAdapter da = new SqlDataAdapter(Query, cn);
            DataSet ds = new DataSet();
            DataTable dt = new DataTable();
            da.Fill(ds, "FeedBackDetails");
            dt = ds.Tables["FeedBackDetails"];
            return ToJson(dt);
        }
    }
    #endregion


    #region SaveFeedBack
    [WebMethod]
    public static void SaveFeedBack(string FeedbackDescription, string ProjectID, string ProductID)
    {

        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionstring2"].ToString()))
        {

            cn.Open();
            string query = "INSERT INTO [workshop_FeedBack]" +
                 "([Workshop_FeedBak_Description],[Workshop_Project_id],[Workshop_Product_id],[created_date],[created_by] ,[modified_date] ,[modified_by],[is_deleted])" +
            "VALUES('" + FeedbackDescription + "','" + ProjectID + "','" + ProductID + "','" + CurrentDate + "','" + UserID + "','" + CurrentDate + "','" + UserID + "', '" + 1 + "' )";
            SqlCommand cmd = new SqlCommand(query, cn);
            cmd.ExecuteNonQuery();
        }
    }
    #endregion
   
   

    #region Update Product
    [WebMethod]
    public static void UpdateFeedBack(string Feedbackid, string FeedbackDescription, string ProjectID, string ProductID)
    {

        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionstring2"].ToString()))
        {

            cn.Open();
            string query = "UPDATE [workshop_FeedBack]" +
   "SET [Workshop_FeedBak_Description] = '" + FeedbackDescription + "',[Workshop_Project_id] = '" + ProjectID + "',[Workshop_Product_id] = '" + ProductID + "',[modified_date] = '" + CurrentDate + "'" +
     " ,[modified_by] = '" + UserID + "' WHERE [Workshop_FeedBak_ID]='" + Feedbackid + "'";
            SqlCommand cmd = new SqlCommand(query, cn);
            cmd.ExecuteNonQuery();
        }
    }
    #endregion
}
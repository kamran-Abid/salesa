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

public partial class MCTX_Internal_SuperAdmin_Workshop_Project : System.Web.UI.Page
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
                string Query = "SELECT  Priority_id,Priority_description  FROM [workshop_priority]";
                SqlDataAdapter da = new SqlDataAdapter(Query, cn);
                DataSet ds = new DataSet();
                DataTable dt = new DataTable();
                da.Fill(ds);
                ddlPriorty.DataSource = ds;
                ddlPriorty.DataValueField = "Priority_id";
                ddlPriorty.DataTextField = "Priority_description";
                ddlPriorty.DataBind();
                ddlPriorty.Items.Insert(0, "-- Select --");

            }

           

        }

    }

   

    #region Save Project
    [WebMethod]
    public static void SaveProject(string ProjName, string priorityID)
    {

        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionstring2"].ToString()))
        {

            cn.Open();
            string query = "INSERT INTO [workshop_project]" +
           "([Priority_id] ,[Project_Name],[created_date],[created_by],[modified_date],[modified_by],[is_deleted])" +
           "VALUES('" + priorityID + "','" + ProjName + "','" + CurrentDate + "','" + UserID + "','" + CurrentDate + "','" + UserID + "', '" + 1 + "' )";
            SqlCommand cmd = new SqlCommand(query, cn);
            cmd.ExecuteNonQuery();
        }
    }
    #endregion

    #region Update Project
    [WebMethod]
    public static void UpdateProject(string ProjID, string ProjName, string priorityID)
    {

        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionstring2"].ToString()))
        {

            cn.Open();
            string query = "UPDATE [workshop_project]" +
   "SET [Priority_id] = '" + priorityID + "',[Project_Name] = '" + ProjName + "',[modified_date] = '" + CurrentDate + "'" +
     " ,[modified_by] = '" + UserID + "' WHERE Project_id='" + ProjID + "'";
            SqlCommand cmd = new SqlCommand(query, cn);
            cmd.ExecuteNonQuery();
        }
    }
    #endregion
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


   
}
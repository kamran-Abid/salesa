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

public partial class MCTX_Internal_SuperAdmin_Workshop_Activity_Mistake : System.Web.UI.Page
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
         
           

        }

    }

   

    #region Save Activity
    [WebMethod]
    public static void SaveActivityMistakeType(string ActivityMistakeTypeName)
    {

        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionstring2"].ToString()))
        {

            cn.Open();
            string query = "INSERT INTO [workshop_activity_mistake]" +
           "([mistake_description],[created_date],[created_by],[modified_date],[modified_by],[is_deleted])" +
           "VALUES('" + ActivityMistakeTypeName + "','" + CurrentDate + "','" + UserID + "','" + CurrentDate + "','" + UserID + "', '" + 1 + "' )";
            SqlCommand cmd = new SqlCommand(query, cn);
            cmd.ExecuteNonQuery();
        }
    }
    #endregion

    #region Update Activity
    [WebMethod]
    public static void UpdateActivityMistake(string ActivityMistakeTypeID, string ActivityMistakeTypeName)
    {

        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionstring2"].ToString()))
        {

            cn.Open();
            string query = "UPDATE [workshop_activity_mistake]" +
   " SET [mistake_description] = '" + ActivityMistakeTypeName + "',[modified_date] = '" + CurrentDate + "'" +
     " ,[modified_by] = '" + UserID + "' WHERE [mistake_id]='" + ActivityMistakeTypeID + "'";
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
    #region Get Activity    
    [WebMethod]
    public static Dictionary<string, object> getActivityDetails()
    {
        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionstring2"].ToString()))
        {
            string Query = "SELECT [mistake_id],[mistake_description],isnull(CONVERT(varchar(20), [created_date],101),'') as created_date" +
            " ,[created_by],isnull(CONVERT(varchar(20), [modified_date],101),'') as modified_date "+
            "  ,[modified_by],[is_deleted]"+
            " FROM [workshop_activity_mistake] where is_deleted=1 order by 1 desc";
            SqlDataAdapter da = new SqlDataAdapter(Query, cn);
            DataSet ds = new DataSet();
            DataTable dt = new DataTable();
            da.Fill(ds, "ActivityDetail");
            dt = ds.Tables["ActivityDetail"];
            return ToJson(dt);
        }
    }
    #endregion


   
}
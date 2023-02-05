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

public partial class MCTX_Internal_SuperAdmin_Workshop_Activity : System.Web.UI.Page
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
                string Query = "SELECT  Activity_type_id,Activity_type_name  FROM [workshop_activity_type]";
                SqlDataAdapter da = new SqlDataAdapter(Query, cn);
                DataSet ds = new DataSet();
                DataTable dt = new DataTable();
                da.Fill(ds);
                ddlActivityType.DataSource = ds;
                ddlActivityType.DataValueField = "Activity_type_id";
                ddlActivityType.DataTextField = "Activity_type_name";
                ddlActivityType.DataBind();
                ddlActivityType.Items.Insert(0, "-- Select --");

            }

           

        }

    }

   

    #region Save Activity
    [WebMethod]
    public static void SaveActivity(string ActivityName, string Activity_typeID)
    {

        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionstring2"].ToString()))
        {

            cn.Open();
            string query = "INSERT INTO [workshop_activity]" +
           "([Activity_type_id] ,[Activity_description],[created_date],[created_by],[modified_date],[modified_by],[is_deleted])" +
           "VALUES('" + Activity_typeID + "','" + ActivityName + "','" + CurrentDate + "','" + UserID + "','" + CurrentDate + "','" + UserID + "', '" + 1 + "' )";
            SqlCommand cmd = new SqlCommand(query, cn);
            cmd.ExecuteNonQuery();
        }
    }
    #endregion

    #region Update Activity
    [WebMethod]
    public static void UpdateActivity(string ActivityID, string ActivityName, string Activity_typeID)
    {

        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionstring2"].ToString()))
        {

            cn.Open();
            string query = "UPDATE [workshop_activity]" +
   "SET [Activity_type_id] = '" + Activity_typeID + "',[Activity_description] = '" + ActivityName + "',[modified_date] = '" + CurrentDate + "'" +
     " ,[modified_by] = '" + UserID + "' WHERE Activity_id='" + ActivityID + "'";
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
            string Query = "SELECT ac.[Activity_id],ac.[Activity_type_id],act.Activity_type_name,ac.[Activity_description],isnull(CONVERT(varchar(20), ac.[created_date],101),'') as created_date"+
            " ,ac.[created_by],isnull(CONVERT(varchar(20), ac.[modified_date],101),'') as modified_date "+
            "  ,ac.[modified_by],ac.[is_deleted]"+
            " FROM [workshop_activity] ac inner join [workshop_activity_type] act"+
            " on ac.Activity_type_id=act.Activity_type_id where ac.is_deleted=1 order by 1 desc";
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
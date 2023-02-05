using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Runtime.Serialization.Json;
using System.Web.Script.Serialization;
using System.Web.Services;

using System.Data.SqlClient;
using System.Data;
using System.Configuration;

public partial class MCTX_Internal_SuperAdmin_DailyWorkingReport : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            fillddl();
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

     [WebMethod]
    public static Dictionary<string, object> NewGetData(string employee_id, string Date)
    {


        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionstring2"].ToString()))
        {
            string query = @"SELECT distinct user_id as Empl_id,[Time-In] as Time_in,[Time-Out] as Time_out,
dr.MyOutput as My_ouput,(convert(varchar , CurrentDate,101)) as Current_date1,ContactedSenior as contacted_seniour ,
rd.TaskDetails,RD.fromTime,RD.toTime,pID.Proj_Name
from DailyReport DR 
inner join  ReportDetails RD on rd.DailyReport_ID=DR.DailyReport_ID 
inner join tbl_IT_Projects pID on pID.Proj_IT_ID=rd.Proj_IT_ID
where (DR.user_id='" + employee_id + "' or '" + employee_id + "'='0')  and (convert(varchar , DR.CurrentDate,101)=  '" + Date + "' or '" + Date + "'='')";

            DataTable dt = new DataTable();
            DataSet ds = new DataSet();
            cn.Open();
            SqlCommand cmd = new SqlCommand(query, cn);
            SqlDataAdapter ad = new SqlDataAdapter(cmd);
            ad.Fill(ds, "employeeRecord");
            dt = ds.Tables["employeeRecord"];
            return ToJson(dt);
        }
    
    }



    public void fillddl()
    {
        //string str = "Data Source=.; uid=sa; pwd=wintellect;database=rohatash;";
        //SqlConnection con = new SqlConnection(@"Data Source=HAIER-PC\SQLEXPRESS;Initial Catalog=mechatronix_com_mechatronix;User Id = sa; Password = sa@1234");
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionstring2"].ToString());  
        string com = "select distinct(user_id) from DailyReport order by user_id";  
        SqlDataAdapter adpt = new SqlDataAdapter(com, con);  
        DataTable dt = new DataTable();  
        adpt.Fill(dt);  
        empddl.DataSource = dt;  
        empddl.DataBind();
        empddl.DataTextField = "user_id";
        empddl.DataValueField = "user_id";  
        empddl.DataBind();
        empddl.Items.Insert(0, new ListItem("All", "0"));

        }
    
}
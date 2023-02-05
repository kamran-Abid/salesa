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


public partial class MCTX_Internal_SuperAdmin_frmDailyReportChck : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            LoadEmp();
            LoadProj();
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

    #region LoadDDLs
    public void LoadEmp()
    {
        try
        {
            using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionstring2"].ToString()))
            {
                SqlCommand cmdEmp = new SqlCommand("SELECT user1.User_Id, tbl_Employee.E_Name from user1 inner join tbl_Employee on " +
                    "user1.E_badge=tbl_Employee.E_badge where isnull(tbl_Employee.deleted,0)<>1 and isnull(user1.deleted,0)<>1 order " +
                    "by E_Name asc", cn);
                cn.Open();
                SqlDataAdapter daEmp = new SqlDataAdapter(cmdEmp);
                DataTable dtEmp = new DataTable();
                daEmp.Fill(dtEmp);
                ddlEmpName.DataSource = dtEmp;
                ddlEmpName.DataTextField = "E_Name";
                ddlEmpName.DataValueField = "User_Id";
                ddlEmpName.DataBind();
                ddlEmpName.Items.Insert(0, "");
            }

        }
        catch (Exception)
        {

            //throw;
        }
    }

    public void LoadProj()
    {
        try
        {
            using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionstring2"].ToString()))
            {
                SqlCommand cmd = new SqlCommand("select Proj_IT_ID, Proj_Name from tbl_IT_Projects where Deleted = 0 order by Proj_Name asc", cn);
                cn.Open();
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);
                ddlProject.DataSource = dt;
                ddlProject.DataTextField = "Proj_Name";
                ddlProject.DataValueField = "Proj_IT_ID";
                ddlProject.DataBind();
                ddlProject.Items.Insert(0, "");
            }
        }
        catch (Exception)
        {

            //throw;
        }
    }
    #endregion

    #region ReportDetails
    [WebMethod]
    public static Dictionary<string, object> SearchRptDetails(string EmpName, string FrmDate, string ToDate, string Proj)
    {
        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionstring2"].ToString()))
        {
            string query = "SELECT distinct tbl_employee.E_Name," +
                           "convert(varchar, convert(datetime,DailyReport.[Time-In]),108) as TimeIn," +
                           "isnull(ReportDetails.hourNo, '') as hourNo," +
                           "isnull(ReportDetails.TaskDetails, '') as TaskDetails," +
                           "isnull(ReportDetails.fromTime, '') as fromTime," +
                           "isnull(ReportDetails.toTime, '') as toTime," +
                           "isnull(tbl_IT_Projects.Proj_Name, '') as Proj_Name," +
                           "isnull(convert(varchar, convert(datetime,DailyReport.[Time-Out]),108),'') as TimeOut," +
                           "convert(varchar, DailyReport.CurrentDate,101) as CurrentDate " +
                           "from ReportDetails " +
                           "inner join DailyReport on " +
                           "ReportDetails.DailyReport_ID = DailyReport.DailyReport_ID " +
                           "inner join user1 on " +
                           "DailyReport.user_id = user1.user_id " +
                           "inner join tbl_employee on " +
                           "user1.E_badge = tbl_employee.E_badge " +
                           "left join tbl_IT_Projects on " +
                           "ReportDetails.Proj_IT_ID = tbl_IT_Projects.Proj_IT_ID where tbl_employee.Deleted = 0";

            if (EmpName != "")
            {
                query += " and DailyReport.user_id = '" + EmpName + "'";
            }
            if (FrmDate != "" && ToDate != "")
            {
                query += " and convert(varchar,CurrentDate,101) between '" + FrmDate + "' and '" + ToDate + "'";
            }
            if (Proj != "")
            {
                query += " and ReportDetails.Proj_IT_ID = '" + Proj + "'";
            }
            query += " order by tbl_employee.E_Name,CurrentDate asc";
            SqlCommand cmd = new SqlCommand(query, cn);
            cn.Open();
            SqlDataAdapter DA = new SqlDataAdapter(cmd);
            DataSet ds = new DataSet();
            DA.Fill(ds, "DailyRecordDetails");
            DataTable dt = new DataTable();
            dt = ds.Tables["DailyRecordDetails"];
            return ToJson(dt);
        }
    }
    #endregion

}

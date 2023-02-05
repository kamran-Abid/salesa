using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Runtime.Serialization.Json;
using System.Web.Script.Serialization;
using System.Web.Services;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Configuration;

public partial class MCTX_Internal_SuperAdmin_VisitReport : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            LoadEmp();
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

    public void LoadEmp()
    {
        try
        {
            using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionstring2"].ToString()))
            {
                SqlCommand cmdEmp = new SqlCommand("SELECT distinct user1.User_Id, tbl_Employee.E_Name from user1 inner join tbl_Employee on " +
                    "user1.E_badge=tbl_Employee.E_badge where isnull(tbl_Employee.deleted,0)<>1 and isnull(user1.deleted,0)<>1 order " +
                    "by E_Name asc", cn);
                cn.Open();
                SqlDataAdapter daEmp = new SqlDataAdapter(cmdEmp);
                DataTable dtEmp = new DataTable();
                daEmp.Fill(dtEmp);
                ddlEmployees.DataSource = dtEmp;
                ddlEmployees.DataTextField = "E_Name";
                ddlEmployees.DataValueField = "User_Id";
                ddlEmployees.DataBind();
                ddlEmployees.Items.Insert(0, "");
            }
        }
        catch (Exception)
        {
            //throw;
        }
    }

    public DataTable GetVisits_forExcel(string FromDate, string ToDate, string EmployeeId)
    {
        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionstring2"].ToString()))
        {
            string query = "select distinct top 200 convert(Varchar(20),V.Visitdate,101) as [Visit_Date] ,tc.comp_name ,cl.client_name ,vt.tt_name ,v.total_Sale ,cr.response_name ,te.E_Name,v.client_IpAdress " +
                            "from visit as v " +
                            "join user1 as u on v.userId = u.user_id " +
                            "Join tbl_Employee as te on u.E_badge = te.E_badge " +
                            "Join client as cl on v.client_id = cl.client_id " +
                            "Join tbl_company as tc on cl.comp_id = tc.comp_id " +
                            "Join T_ClientResponse as cr on v.clientresponse_id = cr.response_id " +
                            "Join tbl_TargetType as vt on v.typeofvisit_id = vt.tt_id where v.visit_id<>'' ";

            if (FromDate != "" && ToDate != "")
            {
                query += " and V.Visitdate between '" + FromDate + "' and '" + ToDate + "'";
            }

            if (EmployeeId != "")
            {
                query += " and u.user_id ='" + EmployeeId + "'";
            }
            query += " order by v.visit_id desc";
            DataTable dt = new DataTable();
            DataSet ds = new DataSet();
            cn.Open();
            SqlCommand cmd = new SqlCommand(query, cn);
            SqlDataAdapter ad = new SqlDataAdapter(cmd);
            ad.Fill(ds, "Visits");
            dt = ds.Tables["Visits"];
            return dt;
        }
    }

    [WebMethod]
    public static Dictionary<string, object> GetVisits(string FromDate, string ToDate, string EmployeeId)
    {
        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionstring2"].ToString()))
        {
            string query = "select distinct top 200 v.visit_id ,convert(Varchar(20),V.Visitdate,101) as [Visit_Date] ,tc.comp_name ,cl.client_name ,vt.tt_name ,v.total_Sale ,cr.response_name ,te.E_Name,v.client_IpAdress " +
                            "from visit as v " +
                            "join user1 as u on v.userId = u.user_id " +
                            "Join tbl_Employee as te on u.E_badge = te.E_badge " +
                            "Join client as cl on v.client_id = cl.client_id " +
                            "Join tbl_company as tc on cl.comp_id = tc.comp_id " +
                            "Join T_ClientResponse as cr on v.clientresponse_id = cr.response_id " +
                            "Join tbl_TargetType as vt on v.typeofvisit_id = vt.tt_id where v.visit_id<>'' ";

            if (FromDate != "" && ToDate != "")
            {
                query += " and V.Visitdate between '" + FromDate + "' and '" + ToDate + "'";
            }

            if (EmployeeId != "")
            {
                query += " and u.user_id ='" + EmployeeId + "'";
            }
            query += " order by v.visit_id desc";
            DataTable dt = new DataTable();
            DataSet ds = new DataSet();
            cn.Open();
            SqlCommand cmd = new SqlCommand(query, cn);
            SqlDataAdapter ad = new SqlDataAdapter(cmd);
            ad.Fill(ds, "Visits");
            dt = ds.Tables["Visits"];
            return ToJson(dt);
        }
    }

    [WebMethod]
    public static Dictionary<string, object> VisitsSummary(string FromDate, string ToDate, string EmployeeId)
    {
        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionstring2"].ToString()))
        {
            string query = "";

            query = "SELECT distinct vt.tt_name VisitType,count(vt.tt_name) VisitCount,isnull(sum(v.total_Sale),0) TotalSale " +
                    " FROM visit AS v JOIN tbl_TargetType AS vt " +
                    " ON v.typeofvisit_id = vt.tt_id AND visit_id<>'' ";

            if (FromDate != "" && ToDate != "")
            {
                query += " and v.Visitdate between '" + FromDate + "' and '" + ToDate + "' ";
            }
            if (EmployeeId != "")
            {
                query += " and userid ='" + EmployeeId + "'";
            }

            query += " GROUP BY vt.tt_name order by 1";
            DataTable dt = new DataTable();
            DataSet ds = new DataSet();
            cn.Open();
            SqlCommand cmd = new SqlCommand(query, cn);
            SqlDataAdapter ad = new SqlDataAdapter(cmd);
            ad.Fill(ds, "VisitsSummary");
            dt = ds.Tables["VisitsSummary"];
            return ToJson(dt);
        }
    }

    [WebMethod]
    public static Dictionary<string, object> TotalProspects(string FromDate, string ToDate, string EmployeeId)
    {
        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionstring2"].ToString()))
        {
            string query2 = "";
            query2 = "select count(*) ProspectCount from tbl_prospecting where user_id <>'' ";

            if (FromDate != "" && ToDate != "")
            {
                query2 += " and Booking_date between '" + FromDate + "' and '" + ToDate + "' ";
            }
            if (EmployeeId != "")
            {
                query2 += " and user_id ='" + EmployeeId + "'";
            }
            DataTable dt = new DataTable();
            DataSet ds = new DataSet();
            cn.Open();
            SqlCommand cmd = new SqlCommand(query2, cn);
            SqlDataAdapter ad = new SqlDataAdapter(cmd);
            ad.Fill(ds, "Prospects");
            dt = ds.Tables["Prospects"];
            return ToJson(dt);
        }
    }

    [WebMethod]
    public static Dictionary<string, object> VisitsDetails(string VisitId)
    {
        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionstring2"].ToString()))
        {
            string query = "";

            query = "select distinct v.visit_id ,convert(varchar(20),V.Visitdate,101) as [Visit_Date] ,tc.comp_name ," +
                    "cl.client_name , vt.tt_name ,v.total_Sale ,cr.response_name ,te.E_Name, cl.client_phone,"+
                    "cl.Client_mobile, cl.client_email,cl.client_designation,tc.comp_address,v.remarks,"+
                    "cty.city_name from visit as v join user1 as u on v.userId = u.user_id "+
                    "Join tbl_Employee as te on u.E_badge = te.E_badge "+
                    "Join client as cl on v.client_id = cl.client_id "+
                    "Join tbl_company as tc on cl.comp_id = tc.comp_id "+
                    "Join T_ClientResponse as cr on v.clientresponse_id = cr.response_id "+
                    "Join tbl_TargetType as vt on v.typeofvisit_id = vt.tt_id "+
                    "Join city as cty on tc.comp_city_id = cty.city_id where v.visit_id = "+VisitId+"";
            DataTable dt = new DataTable();
            DataSet ds = new DataSet();
            cn.Open();
            SqlCommand cmd = new SqlCommand(query, cn);
            SqlDataAdapter ad = new SqlDataAdapter(cmd);
            ad.Fill(ds, "VisitDetails");
            dt = ds.Tables["VisitDetails"];
            return ToJson(dt);
        }
    }
    protected void btnExportToExcel_Click(object sender, EventArgs e)
    {
        DataTable table = GetVisits_forExcel(txtFromDate.Text, txtToDate.Text, ddlEmployees.SelectedItem.Value);
        if (table.Rows.Count > 0)
        {
            string filename = "VisitReport.xls";
            System.IO.StringWriter tw = new System.IO.StringWriter();
            System.Web.UI.HtmlTextWriter hw = new System.Web.UI.HtmlTextWriter(tw);
            DataGrid dgGrid = new DataGrid();
            dgGrid.DataSource = table;
            dgGrid.DataBind();

            dgGrid.RenderControl(hw);
            Response.ContentType = "application/vnd.ms-excel";
            Response.AppendHeader("Content-Disposition", "attachment; filename=" + filename + "");
            this.EnableViewState = false;
            Response.Write(tw.ToString());
            Response.End();
        }
    }
}

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

public partial class MCTX_Internal_SuperAdmin_Report_EmailMarketing : System.Web.UI.Page
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
                SqlCommand cmdEmp = new SqlCommand("SELECT user1.User_Id, tbl_Employee.E_Name from user1 inner join tbl_Employee on " +
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

    #region Get Email Log by Obaid Altaf June 11, 2012

    [WebMethod]
    public static Dictionary<string, object> GetEmailLog(string FromDate, string ToDate, string EmployeeId)
    {
        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionstring2"].ToString()))
        {
            string query = "select distinct top 200 To_Address,CC_Address,[Subject],Attachment_Name,Attachment_Size, convert(varchar(20),Date,101) Date,UserId " +
                                            "from tbl_EmailMarketing where To_Address<>'' ";
            if (FromDate != "" && ToDate != "")
            {
                query += " and Date between '" + FromDate + "' and '" + ToDate + "'";
            }

            if (EmployeeId != "")
            {
                query += " and userid ='" + EmployeeId + "'";
            }
            query += " order by 1 desc";
            SqlCommand cmd = new SqlCommand(query, cn);
            cn.Open();
            SqlDataAdapter DA = new SqlDataAdapter(cmd);
            DataSet ds = new DataSet();
            DA.Fill(ds, "EmailLog");
            DataTable dt = new DataTable();
            dt = ds.Tables["EmailLog"];
            return ToJson(dt);
        }
    }

    #endregion
    protected void btnExportToExcel_Click(object sender, EventArgs e)
    {
        DataTable table = GetEmailLog_forExcel(txtFromDate.Text, txtToDate.Text, ddlEmployees.SelectedItem.Value);
        if (table.Rows.Count > 0)
        {
            string filename = "EmailLog.xls";
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

    public DataTable GetEmailLog_forExcel(string FromDate, string ToDate, string EmployeeId)
    {
        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionstring2"].ToString()))
        {
            string query = "select distinct top 200 To_Address,CC_Address,[Subject],Attachment_Name,Attachment_Size, convert(varchar(20),Date,101) Date,UserId " +
                                            "from tbl_EmailMarketing where To_Address<>'' ";

            if (FromDate != "" && ToDate != "")
            {
                query += " and Date between '" + FromDate + "' and '" + ToDate + "'";
            }

            if (EmployeeId != "")
            {
                query += " and userid ='" + EmployeeId + "'";
            }
            query += " order by 1 desc";
            DataTable dt = new DataTable();
            DataSet ds = new DataSet();
            cn.Open();
            SqlCommand cmd = new SqlCommand(query, cn);
            SqlDataAdapter ad = new SqlDataAdapter(cmd);
            ad.Fill(ds, "EmailLog");
            dt = ds.Tables["EmailLog"];
            return dt;
        }
    }
}

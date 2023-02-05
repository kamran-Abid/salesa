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

public partial class MCTX_Internal_SuperAdmin_frmProductInfo : System.Web.UI.Page
{
    #region Methods

    #endregion

    #region Events
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            if (Session["Username"].ToString() == "logout")
            {
                Response.Redirect("../../MCTX_General/Login.aspx");
                return;
            }
            string role = Session["Role"].ToString();
            if (role == "Employee")
            {
                Response.Redirect("Accessdenied.aspx");
                return;
            }
            if (!IsPostBack)
            {
                LoadEmp();
            }
        }
        catch (Exception ex)
        {

        }
    }


    #endregion

    #region Next Day Plans may 05, 2012  by Obaid Altaf

    public void LoadEmp()
    {
        try
        {
            using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionstring2"].ToString()))
            {
                SqlCommand cmdEmp = new SqlCommand("select ID, Name  from SMS_contact order by 2", cn);
                cn.Open();
                SqlDataAdapter daEmp = new SqlDataAdapter(cmdEmp);
                DataTable dtEmp = new DataTable();
                daEmp.Fill(dtEmp);
                ddlEmployee.DataSource = dtEmp;
                ddlEmployee.DataTextField = "Name";
                ddlEmployee.DataValueField = "ID";
                ddlEmployee.DataBind();
                ddlEmployee.Items.Insert(0, "");
            }
        }
        catch (Exception)
        {
            //throw;
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
    public static Dictionary<string, object> GetNDPlans(string datefrom, string dateto, string Emp)
    {
        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionstring2"].ToString()))
        {
            string query = "select distinct top 150 ID,Emp_Id,Emp_Name,Task,Duration,convert(varchar(20),Task_Date,110) Task_Date,Department,PhoneNo from [SMS_NextDayPlanner] where Duration<>'' ";
            if (datefrom != "" && dateto != "")
            {
                query += " and task_date between '" + datefrom + "' and '" + dateto + "'";
            }
            if(Emp!="")
            {
                query += " and emp_id='"+Emp+"' ";
            }

            query += "order by Task_Date desc";
            SqlCommand cmd = new SqlCommand(query, cn);
            cn.Open();
            SqlDataAdapter DA = new SqlDataAdapter(cmd);
            DataSet ds = new DataSet();
            DA.Fill(ds, "NDP");
            DataTable dt = new DataTable();
            dt = ds.Tables["NDP"];
            return ToJson(dt);
        }
    }
    #endregion
}

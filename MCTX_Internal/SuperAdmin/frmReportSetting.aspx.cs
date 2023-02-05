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

public partial class MCTX_Internal_SuperAdmin_frmReportSetting : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            LoadEmp();
        }
    }
    #region Employee
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
    #endregion
    #region InsertReportAlternative()
    [WebMethod]
    public static void ReportInsert(string EmpName, string Reason, string Date)
    {
        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionstring2"].ToString()))
        {
            SqlCommand query = new SqlCommand("SELECT EmpType_ID from DailyReport where user_id = '" + EmpName + "'", cn);
            cn.Open();
            SqlDataAdapter da = new SqlDataAdapter(query);
            DataTable dt = new DataTable();
            da.Fill(dt);
            int EmpType = 0;
            EmpType = int.Parse(dt.Rows[0]["EmpType_ID"].ToString());
            string TimeIn = "";
            string TimeOut = "";
            if (EmpType == 1)
            {
                TimeIn = Date + " " + "09:00";
                TimeOut = Date + " " + "17:00";
            }
            else
            {
                TimeIn = Date + " " + "17:00";
                TimeOut = Date + " " + "21:00";
            }
            SqlCommand cmd = new SqlCommand();
            cmd.CommandText = "Web_Proc_AddReportAlternative";
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Connection = cn;
            cmd.Parameters.Add("@Reason", Reason);
            cmd.Parameters.Add("@EmpName", EmpName);
            cmd.Parameters.Add("@TimeIn", Convert.ToDateTime(TimeIn));
            cmd.Parameters.Add("@TimeOut", Convert.ToDateTime(TimeOut));
            cmd.Parameters.Add("@Date", Date);
            cmd.Parameters.Add("@EmpType", EmpType);
            cmd.ExecuteNonQuery();

        }
    }
    #endregion
}

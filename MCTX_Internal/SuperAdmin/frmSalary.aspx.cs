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

public partial class MCTX_Internal_SuperAdmin_frmSalary : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["Role"] == null)
        {
            Response.Redirect("../../MCTX_General/Login.aspx");
            return;
        }
        else
        {
            string role = Session["Role"].ToString();
            if (role == "Admin")
            {
                SalaryDetail.Visible = true;
            }
            else
            {
                SalaryDetail.Visible = false;
                lblDetailsHide.Visible = true;
                lblDetailsHide.Text = "Salary Details Available To Admins Only!";
                lblDetailsHide.ForeColor = System.Drawing.Color.Red;
            }
        }
        if (Request.Cookies["userName"] == null)
        {
            Response.Redirect("../../MCTX_General/Login.aspx");
            return;
        }
        else
        {

            if (!IsPostBack)
            {
                LoadDDLs();
            }

            #region Server Side Code
            //string EmpSalID = Request.Params["SalID"];
            //SalID = Request.Params["SalID"];
            //if (EmpSalID != null)
            //{
            //    using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionstring2"].ToString()))
            //    {
            //        btnUpdate.Visible = true;
            //        try
            //        {
            //            SqlCommand cmd = new SqlCommand();
            //            cmd.CommandText = "Web_Proc_GetEmpSalRecForUpd";
            //            cmd.CommandType = CommandType.StoredProcedure;
            //            cmd.Parameters.Add("@EmpSalID", EmpSalID);
            //            cmd.Connection = cn;
            //            cn.Open();
            //            SqlDataAdapter DA = new SqlDataAdapter(cmd);
            //            DataSet ds = new DataSet();
            //            DA.Fill(ds, "EmpSalRec");
            //            DataTable dt = new DataTable();
            //            dt = ds.Tables["EmpSalRec"];
            //            ddlEmpName.Items.FindByValue(dt.Rows[0]["EmpName_ID"].ToString()).Selected = true;
            //            ddlDepartment.Items.FindByValue(dt.Rows[0]["Dept_ID"].ToString()).Selected = true;
            //            ddlDesignation.Items.FindByValue(dt.Rows[0]["Desg_ID"].ToString()).Selected = true;
            //            txtBasicSal.Text = dt.Rows[0]["BasicSal"].ToString();
            //            ddlSalMon.Items.FindByValue(dt.Rows[0]["SalMon"].ToString()).Selected = true;
            //            txtYear.Text = dt.Rows[0]["SalYear"].ToString();
            //            ddlDaysWorked.Items.FindByValue(dt.Rows[0]["DaysWorked"].ToString()).Selected = true;
            //            txtPaidLeaves.Text = dt.Rows[0]["Paid_Leaves"].ToString();
            //            txtUnPaidLeave.Text = dt.Rows[0]["Unpaid_Leaves"].ToString();
            //            txtTelAllow.Text = dt.Rows[0]["TelAllow"].ToString();
            //            txtConAllow.Text = dt.Rows[0]["ConAllow"].ToString();
            //            txtSunAllow.Text = dt.Rows[0]["SunAllow"].ToString();
            //            txtOtherAllow.Text = dt.Rows[0]["OtherAllow"].ToString();
            //            txtAllowance.Text = dt.Rows[0]["TotalAllow"].ToString();
            //            txtPaidAllow.Text = dt.Rows[0]["PaidAllow"].ToString();
            //            txtDueAllow.Text = dt.Rows[0]["DueAllow"].ToString();
            //            txtLoan.Text = dt.Rows[0]["Loan"].ToString();
            //            txtOtherDeduct.Text = dt.Rows[0]["OtherDeduct"].ToString();
            //            txtTotalDeduct.Text = dt.Rows[0]["TotalDeduct"].ToString();
            //            txtPaidDeduct.Text = dt.Rows[0]["PaidDeduct"].ToString();
            //            txtDueDeduct.Text = dt.Rows[0]["DueDeduct"].ToString();
            //            txtFinalSal.Text = dt.Rows[0]["Final_sal"].ToString();
            //            txtPaidSal.Text = dt.Rows[0]["PaidSal"].ToString();
            //            txtDueSal.Text = dt.Rows[0]["DueSal"].ToString();
            //            txtSalDate.Text = DateTime.Parse(dt.Rows[0]["Paid_On"].ToString()).ToShortDateString();
            //        }
            //        catch (Exception)
            //        {

            //            //throw;
            //        }
            //    }
            //}
            #endregion
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

    #region Events

    protected void ddlEmpName_SelectedIndexChanged(object sender, EventArgs e)
    {
        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionstring2"].ToString()))
        {
            try
            {
                string EmpName = ddlEmpName.SelectedItem.Text;
                SqlCommand cmd = new SqlCommand("SELECT BasicSalary from tbl_employee where E_Name = '" + EmpName + "'", cn);
                SqlDataAdapter DA = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                DA.Fill(dt);
                txtBasicSal.Text = dt.Rows[0]["BasicSalary"].ToString();
            }
            catch (Exception)
            {

                //throw;
            }

        }
    }
    #endregion
    #region LoadDDLs

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
    public void LoadEmpS()
    {
        try
        {
            using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionstring2"].ToString()))
            {
                SqlCommand cmdEmpS = new SqlCommand("SELECT distinct user1.User_Id, tbl_Employee.E_Name from user1 inner join tbl_Employee on " +
                    "user1.E_badge=tbl_Employee.E_badge where isnull(tbl_Employee.deleted,0)<>1 and isnull(user1.deleted,0)<>1 order " +
                    "by E_Name asc", cn);
                cn.Open();
                SqlDataAdapter daEmpS = new SqlDataAdapter(cmdEmpS);
                DataTable dtEmpS = new DataTable();
                daEmpS.Fill(dtEmpS);
                ddlEmpNameS.DataSource = dtEmpS;
                ddlEmpNameS.DataTextField = "E_Name";
                ddlEmpNameS.DataValueField = "User_Id";
                ddlEmpNameS.DataBind();
                ddlEmpNameS.Items.Insert(0, "");
            }

        }
        catch (Exception)
        {

            //throw;
        }
    }
    public void LoadDept()
    {
        try
        {
            using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionstring2"].ToString()))
            {
                SqlCommand cmdDept = new SqlCommand("SELECT distinct D_ID, D_Name from Tbl_Department order by D_Name asc", cn);
                cn.Open();
                SqlDataAdapter daDept = new SqlDataAdapter(cmdDept);
                DataTable dtDept = new DataTable();
                daDept.Fill(dtDept);
                ddlDepartment.DataSource = dtDept;
                ddlDepartment.DataTextField = "D_Name";
                ddlDepartment.DataValueField = "D_ID";
                ddlDepartment.DataBind();
                ddlDepartment.Items.Insert(0, "");
            }
        }
        catch (Exception)
        {

            //throw;
        }
    }
    public void LoadDeptS()
    {
        try
        {
            using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionstring2"].ToString()))
            {
                SqlCommand cmdDeptS = new SqlCommand("SELECT distinct D_ID, D_Name from Tbl_Department order by D_Name asc", cn);
                cn.Open();
                SqlDataAdapter daDeptS = new SqlDataAdapter(cmdDeptS);
                DataTable dtDeptS = new DataTable();
                daDeptS.Fill(dtDeptS);
                ddlDeptS.DataSource = dtDeptS;
                ddlDeptS.DataTextField = "D_Name";
                ddlDeptS.DataValueField = "D_ID";
                ddlDeptS.DataBind();
                ddlDeptS.Items.Insert(0, "");
            }
        }
        catch (Exception)
        {

            //throw;
        }
    }
    public void LoadDesg()
    {
        try
        {
            using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionstring2"].ToString()))
            {
                SqlCommand cmdDesg = new SqlCommand("SELECT distinct ID,Desig_Name from Tbl_Designation order by Desig_Name asc", cn);
                cn.Open();
                SqlDataAdapter daDesg = new SqlDataAdapter(cmdDesg);
                DataTable dtDesg = new DataTable();
                daDesg.Fill(dtDesg);
                ddlDesignation.DataSource = dtDesg;
                ddlDesignation.DataTextField = "Desig_Name";
                ddlDesignation.DataValueField = "ID";
                ddlDesignation.DataBind();
                ddlDesignation.Items.Insert(0, "");
            }
        }
        catch (Exception)
        {

            //throw;
        }
    }
    public void LoadDesgS()
    {
        try
        {
            using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionstring2"].ToString()))
            {
                SqlCommand cmdDesgS = new SqlCommand("SELECT distinct ID,Desig_Name from Tbl_Designation order by Desig_Name asc", cn);
                cn.Open();
                SqlDataAdapter daDesgS = new SqlDataAdapter(cmdDesgS);
                DataTable dtDesgS = new DataTable();
                daDesgS.Fill(dtDesgS);
                ddlDesign.DataSource = dtDesgS;
                ddlDesign.DataTextField = "Desig_Name";
                ddlDesign.DataValueField = "ID";
                ddlDesign.DataBind();
                ddlDesign.Items.Insert(0, "");
            }
        }
        catch (Exception)
        {

            //throw;
        }
    }
    public void LoadDDLs()
    {
        LoadEmp();
        LoadEmpS();
        LoadDept();
        LoadDeptS();
        LoadDesg();
        LoadDesgS();
    }
    #endregion
    #region SaveSal
    [WebMethod]
    public static void SaveSalData(string EmpName, string Dept, string Desg, string BSal, string SalMon, string SalYear, string DaysWork, string PLeaves, string UPLeaves, string TelAllow, string ConAllow, string SunAllow, string OtherAllow, string TotalAllow, string PaidAllow, string DueAllow, string Loan, string OtherDeduct, string TotalDeduct, string PaidDeduct, string DueDeduct, string FinalSal, string PaidSal, string DueSal, string PaidDate)
    {
        string EmpSalID = "0";
        string userName = HttpContext.Current.Session["UserFullName"].ToString();
        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionstring2"].ToString()))
        {
            SqlCommand cmd = new SqlCommand();
            cmd.CommandText = "Web_Proc_SaveUpdateEmpSalary";
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Add("@EmpSal_ID", int.Parse(EmpSalID));
            cmd.Parameters.Add("@EmpName_ID", EmpName);
            cmd.Parameters.Add("@Dept_ID", int.Parse(Dept));
            cmd.Parameters.Add("@Desg_ID", int.Parse(Desg));
            cmd.Parameters.Add("@BasicSal", int.Parse(BSal));
            cmd.Parameters.Add("@SalMon", int.Parse(SalMon));
            cmd.Parameters.Add("@SalYear", int.Parse(SalYear));
            cmd.Parameters.Add("@DaysWorked", int.Parse(DaysWork));
            cmd.Parameters.Add("@Paid_Leaves", int.Parse(PLeaves));
            cmd.Parameters.Add("@Unpaid_Leaves", int.Parse(UPLeaves));
            cmd.Parameters.Add("@TelAllow", int.Parse(TelAllow));
            cmd.Parameters.Add("@ConAllow", int.Parse(ConAllow));
            cmd.Parameters.Add("@SunAllow", int.Parse(SunAllow));
            cmd.Parameters.Add("@OtherAllow", int.Parse(OtherAllow));
            cmd.Parameters.Add("@TotalAllow", int.Parse(TotalAllow));
            cmd.Parameters.Add("@PaidAllow", int.Parse(PaidAllow));
            cmd.Parameters.Add("@DueAllow", int.Parse(DueAllow));
            cmd.Parameters.Add("@Loan", int.Parse(Loan));
            cmd.Parameters.Add("@OtherDeduct", int.Parse(OtherDeduct));
            cmd.Parameters.Add("@TotalDeduct", int.Parse(TotalDeduct));
            cmd.Parameters.Add("@PaidDeduct", int.Parse(PaidDeduct));
            cmd.Parameters.Add("@DueDeduct", int.Parse(DueDeduct));
            cmd.Parameters.Add("@FinalSal", int.Parse(FinalSal));
            cmd.Parameters.Add("@PaidSal", int.Parse(PaidSal));
            cmd.Parameters.Add("@DueSal", int.Parse(DueSal));
            cmd.Parameters.Add("@Paid_On", Convert.ToDateTime(PaidDate));
            cmd.Parameters.Add("@Created_By", userName);
            cmd.Parameters.Add("@Created_Date", DateTime.Now);
            cmd.Parameters.Add("@Modified_By", userName);
            cmd.Parameters.Add("@Modified_Date", DateTime.Now);
            cmd.Parameters.Add("@Deleted", "0");
            cmd.Connection = cn;
            cn.Open();
            cmd.ExecuteNonQuery();
        }
    }
    #endregion
    #region LoadSalDetails
    [WebMethod]
    public static Dictionary<string, object> GetSalDetails(string EmpNameS, string DeptS, string DesgS, string MonS, string YearS)
    {
        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionstring2"].ToString()))
        {
            SqlCommand cmd = new SqlCommand();
            cmd.CommandText = "Web_Proc_LoadEmpSalDetails";
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Add("@EmpName", EmpNameS);
            cmd.Parameters.Add("@DeptID", DeptS);
            cmd.Parameters.Add("@DesgID", DesgS);
            cmd.Parameters.Add("@Month", MonS);
            cmd.Parameters.Add("@Year", YearS);
            cmd.Connection = cn;
            cn.Open();
            SqlDataAdapter DA = new SqlDataAdapter(cmd);
            DataSet ds = new DataSet();
            DA.Fill(ds, "SalDetails");
            DataTable dt = new DataTable();
            dt = ds.Tables["SalDetails"];
            return ToJson(dt);
        }
    }
    #endregion
    #region DeleteSalary
    [WebMethod]
    public static void DeleteSalary(string SalID)
    {
        string userName = HttpContext.Current.Session["UserFullName"].ToString();
        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionstring2"].ToString()))
        {
            SqlCommand cmd = new SqlCommand();
            cmd.CommandText = "Web_Proc_DeleteEmpSalary";
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Add("@SalID", int.Parse(SalID));
            cmd.Parameters.Add("@ModBy", userName);
            cmd.Parameters.Add("@ModDate", DateTime.Now);
            cmd.Parameters.Add("@Deleted", "1");
            cmd.Connection = cn;
            cn.Open();
            cmd.ExecuteNonQuery();
        }
    }
    #endregion
    #region UpdateSal
    [WebMethod]
    public static void UpdateSalary(string SalID, string EmpName, string Dept, string Desg, string BSal, string SalMon, string SalYear, string DaysWork, string PLeaves, string UPLeaves, string TelAllow, string ConAllow, string SunAllow, string OtherAllow, string TotalAllow, string PaidAllow, string DueAllow, string Loan, string OtherDeduct, string TotalDeduct, string PaidDeduct, string DueDeduct, string FinalSal, string PaidSal, string DueSal, string PaidDate)
    {
        string userName = HttpContext.Current.Session["UserFullName"].ToString();
        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionstring2"].ToString()))
        {
            SqlCommand cmd = new SqlCommand();
            cmd.CommandText = "Web_Proc_SaveUpdateEmpSalary";
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Add("@EmpSal_ID", int.Parse(SalID));
            cmd.Parameters.Add("@EmpName_ID", EmpName);
            cmd.Parameters.Add("@Dept_ID", int.Parse(Dept));
            cmd.Parameters.Add("@Desg_ID", int.Parse(Desg));
            cmd.Parameters.Add("@BasicSal", int.Parse(BSal));
            cmd.Parameters.Add("@SalMon", int.Parse(SalMon));
            cmd.Parameters.Add("@SalYear", int.Parse(SalYear));
            cmd.Parameters.Add("@DaysWorked", int.Parse(DaysWork));
            cmd.Parameters.Add("@Paid_Leaves", int.Parse(PLeaves));
            cmd.Parameters.Add("@Unpaid_Leaves", int.Parse(UPLeaves));
            cmd.Parameters.Add("@TelAllow", int.Parse(TelAllow));
            cmd.Parameters.Add("@ConAllow", int.Parse(ConAllow));
            cmd.Parameters.Add("@SunAllow", int.Parse(SunAllow));
            cmd.Parameters.Add("@OtherAllow", int.Parse(OtherAllow));
            cmd.Parameters.Add("@TotalAllow", int.Parse(TotalAllow));
            cmd.Parameters.Add("@PaidAllow", int.Parse(PaidAllow));
            cmd.Parameters.Add("@DueAllow", int.Parse(DueAllow));
            cmd.Parameters.Add("@Loan", int.Parse(Loan));
            cmd.Parameters.Add("@OtherDeduct", int.Parse(OtherDeduct));
            cmd.Parameters.Add("@TotalDeduct", int.Parse(TotalDeduct));
            cmd.Parameters.Add("@PaidDeduct", int.Parse(PaidDeduct));
            cmd.Parameters.Add("@DueDeduct", int.Parse(DueDeduct));
            cmd.Parameters.Add("@FinalSal", int.Parse(FinalSal));
            cmd.Parameters.Add("@PaidSal", int.Parse(PaidSal));
            cmd.Parameters.Add("@DueSal", int.Parse(DueSal));
            cmd.Parameters.Add("@Paid_On", Convert.ToDateTime(PaidDate));
            cmd.Parameters.Add("@Created_By", userName);
            cmd.Parameters.Add("@Created_Date", DateTime.Now);
            cmd.Parameters.Add("@Modified_By", userName);
            cmd.Parameters.Add("@Modified_Date", DateTime.Now);
            cmd.Parameters.Add("@Deleted", "0");
            cmd.Connection = cn;
            cn.Open();
            cmd.ExecuteNonQuery();
        }
    }
    #endregion

}

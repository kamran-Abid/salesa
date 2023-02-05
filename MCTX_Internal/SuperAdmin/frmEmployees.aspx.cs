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

public partial class MCTX_Internal_SuperAdmin_frmEmployees : System.Web.UI.Page
{
    static string UserID = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["Username"] == null)
        {
            Response.Redirect("../../MCTX_General/Login.aspx");
            //return;
        }
        else
        {
            UserID = Session["Username"].ToString();
            LoadDDLS();
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
    #region LoadDDLS
    public void GetBranches()
    {
        try
        {
            using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionstring2"].ToString()))
            {
                SqlCommand cmd = new SqlCommand("select * from tbl_BRANCHES order by BRANCHNAME asc", cn);
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);
                ddlBranch.DataSource = dt;
                ddlBranch.DataValueField = "BRID";
                ddlBranch.DataTextField = "BRANCHNAME";
                ddlBranch.DataBind();
                ddlBranch.Items.Insert(0, "");
            }
        }
        catch (Exception)
        {

            //throw;
        }
    }
    public void GetDepart()
    {
        try
        {
            using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionstring2"].ToString()))
            {
                SqlCommand cmd = new SqlCommand("select * from Tbl_Department  where isnull(Deleted,0)<>1 order by D_Name", cn);
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);
                ddlDept.DataSource = dt;
                ddlDept.DataValueField = "D_ID";
                ddlDept.DataTextField = "D_Name";
                ddlDept.DataBind();
                ddlDept.Items.Insert(0, "");
            }
        }
        catch (Exception)
        {

            //throw;
        }
    }
    public void GetDesg()
    {
        try
        {
            using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionstring2"].ToString()))
            {
                SqlCommand cmd = new SqlCommand("select * from Tbl_Designation where status = 1", cn);
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);
                ddlDesg.DataSource = dt;
                ddlDesg.DataValueField = "ID";
                ddlDesg.DataTextField = "Desig_Name";
                ddlDesg.DataBind();
                ddlDesg.Items.Insert(0, "");
            }
        }
        catch (Exception)
        {

            //throw;
        }
    }
    public void GetEmpType()
    {
        try
        {
            using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionstring2"].ToString()))
            {
                SqlCommand cmd = new SqlCommand("select * from tblEmp_Type order by Emp_Type asc", cn);
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);
                ddlEmpType.DataSource = dt;
                ddlEmpType.DataValueField = "EmpType_ID";
                ddlEmpType.DataTextField = "Emp_Type";
                ddlEmpType.DataBind();
                ddlEmpType.Items.Insert(0, "");
            }
        }
        catch (Exception)
        {

            //throw;
        }
    }
    public void LoadDDLS()
    {
        GetBranches();
        GetDepart();
        GetDesg();
        GetEmpType();
    }
    #endregion

    #region SaveEmployee
    [WebMethod]
    public static void SaveEmployeeData(string EmpID, string EmpName, string BranchID, string DeptID, string DesgID, string Phone, string CellPhone, string StartDate, string Gender, string Edu, string CNIC, string DOB, string Address, string BasicSal, string TravelAllow, string MobAllow, string OtherAllow, string EmergPhone, string GuardPhone, string EmpType, string Emp_officalNumber, string Employee_Type)
    {
        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionstring2"].ToString()))
        {
            SqlCommand cmd = new SqlCommand();

            cmd.CommandText = "select * from tbl_employee where E_badge ='" + EmpID + "'";
            cmd.CommandType = CommandType.Text;
            cmd.Connection = cn;
            cn.Open();
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataSet ds = new DataSet();
            da.Fill(ds, "EmployeeDetails");
            DataTable dt = new DataTable();
            dt = ds.Tables["EmployeeDetails"];
            if (dt.Rows.Count > 0)
            {

                //already exist employeeID
            }

            else
            {

                cmd.CommandText = "Web_Proc_SaveEmployeeData";
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add("@EmpID", EmpID);
                cmd.Parameters.Add("@EmpName", EmpName);
                cmd.Parameters.Add("@BranchID", int.Parse(BranchID));
                cmd.Parameters.Add("@DeptID", int.Parse(DeptID));
                cmd.Parameters.Add("@DesgID", int.Parse(DesgID));
                cmd.Parameters.Add("@Phone", Phone);
                cmd.Parameters.Add("@CellPhone", CellPhone);
                cmd.Parameters.Add("@StartDate", StartDate);
                cmd.Parameters.Add("@Gender", Gender);
                cmd.Parameters.Add("@Edu", Edu);
                cmd.Parameters.Add("@CNIC", CNIC);
                cmd.Parameters.Add("@DOB", DateTime.Parse(DOB));
                cmd.Parameters.Add("@Address", Address);
                cmd.Parameters.Add("@BasicSal", BasicSal);
                cmd.Parameters.Add("@TravelAllow", TravelAllow);
                cmd.Parameters.Add("@MobAllow", MobAllow);
                cmd.Parameters.Add("@OtherAllow", OtherAllow);
                cmd.Parameters.Add("@EmergPhone", EmergPhone);
                cmd.Parameters.Add("@GuardPhone", GuardPhone);
                cmd.Parameters.Add("@EmpType", int.Parse(EmpType));
                cmd.Parameters.Add("@CreatedBy", UserID);
                cmd.Parameters.Add("@CreatedDate", DateTime.Now.ToShortDateString());
                cmd.Parameters.Add("@ModBy", UserID);
                cmd.Parameters.Add("@ModDate", DateTime.Now.ToShortDateString());
                cmd.Parameters.Add("@WorkDays", 26);
                cmd.Parameters.Add("@Deleted", false);
                cmd.Parameters.Add("@Emp_offcial_Numer", Emp_officalNumber);
                cmd.Parameters.Add("@Employee_type", Employee_Type);
                cmd.Connection = cn;
                cn.Open();
                cmd.ExecuteNonQuery();
            }
        }
    }
    #endregion

    #region GetEmpDetails
    [WebMethod]
    public static Dictionary<string, object> getEmployeeData()
    {
        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionstring2"].ToString()))
        {
            SqlCommand cmd = new SqlCommand();
            cmd.CommandText = "Web_Proc_GetEmployeeData";
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Connection = cn;
            cn.Open();
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataSet ds = new DataSet();
            da.Fill(ds, "EmployeeDetails");
            DataTable dt = new DataTable();
            dt = ds.Tables["EmployeeDetails"];
            return ToJson(dt);
        }
    }
    #endregion

    #region DeleteEmployee
    [WebMethod]
    public static void DeleteEmployeeData(string ID)
    {
        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionstring2"].ToString()))
        {
            try
            {
                SqlCommand cmd = new SqlCommand("Update tbl_Employee SET Deleted = 1, ModifiedBy = '" + UserID + "', ModifiedDate = '" + DateTime.Now.ToShortDateString() + "' where id = '" + ID + "'", cn);
                cn.Open();
                cmd.ExecuteNonQuery();
            }
            catch (Exception)
            {

                //throw;
            }
        }
    }
    #endregion

    #region UpdateEmployee
    [WebMethod]
    public static void UpdateEmployeeData(string ID, string EmpID, string EmpName, string BranchID, string DeptID, string DesgID, string Phone, string CellPhone, string StartDate, string Gender, string Edu, string CNIC, string DOB, string Address, string BasicSal, string TravelAllow, string MobAllow, string OtherAllow, string EmergPhone, string GuardPhone, string EmpType, string Emp_officalNumber , string Employee_type)
    {
        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionstring2"].ToString()))
        {
            SqlCommand cmd = new SqlCommand();
            cmd.CommandText = "Web_Proc_UpdateEmployeeData";
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Add("@ID", ID);
            cmd.Parameters.Add("@EmpID", EmpID);
            cmd.Parameters.Add("@EmpName", EmpName);
            cmd.Parameters.Add("@BranchID", int.Parse(BranchID));
            cmd.Parameters.Add("@DeptID", int.Parse(DeptID));
            cmd.Parameters.Add("@DesgID", int.Parse(DesgID));
            cmd.Parameters.Add("@Phone", Phone);
            cmd.Parameters.Add("@CellPhone", CellPhone);
            cmd.Parameters.Add("@StartDate", StartDate);
            cmd.Parameters.Add("@Gender", Gender);
            cmd.Parameters.Add("@Edu", Edu);
            cmd.Parameters.Add("@CNIC", CNIC);
            cmd.Parameters.Add("@DOB", DateTime.Parse(DOB));
            cmd.Parameters.Add("@Address", Address);
            cmd.Parameters.Add("@BasicSal", BasicSal);
            cmd.Parameters.Add("@TravelAllow", TravelAllow);
            cmd.Parameters.Add("@MobAllow", MobAllow);
            cmd.Parameters.Add("@OtherAllow", OtherAllow);
            cmd.Parameters.Add("@EmergPhone", EmergPhone);
            cmd.Parameters.Add("@GuardPhone", GuardPhone);
            cmd.Parameters.Add("@EmpType", int.Parse(EmpType));
            cmd.Parameters.Add("@ModBy", UserID);
            cmd.Parameters.Add("@ModDate", DateTime.Now.ToShortDateString());
            cmd.Parameters.Add("@WorkDays", 26);
            cmd.Parameters.Add("@Deleted", false);
            cmd.Parameters.Add("@Emp_offcial_Numer", Emp_officalNumber);
            cmd.Parameters.Add("@Employee_type", Employee_type);
            cmd.Connection = cn;
            cn.Open();
            cmd.ExecuteNonQuery();
        }
    }
    #endregion

    #region CheckEBadge
    [WebMethod]
    public static int CheckEmpID(string EmpID)
    {
        int result = 0;
        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionstring2"].ToString()))
        {
            SqlCommand cmd = new SqlCommand("select * from tbl_employee where E_badge = '" + EmpID + "'", cn);
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);
            result = dt.Rows.Count;
        }
        return result;
    }
    #endregion

}

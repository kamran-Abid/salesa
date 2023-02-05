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

public partial class MCTX_Internal_SuperAdmin_frmEmpUser : System.Web.UI.Page
{
    static string UserID = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            UserID = Session["Username"].ToString();
           
        }
        catch (Exception)
        {

            //throw;
        }
        //if (UserID != "")

        if (UserID == "mctxit")
        {

            LoadEmp();
            LoadRole();

        }
        else
        {
            Response.Redirect("../../MCTX_General/Login.aspx");

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
    public void LoadEmp()
    {
        try
        {
            using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionstring2"].ToString()))
            {
                SqlCommand cmd = new SqlCommand("select E_badge,E_Name from tbl_employee where deleted = 0 order by E_Name asc", cn);
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);
                ddlEmployee.DataSource = dt;
                ddlEmployee.DataValueField = "E_badge";
                ddlEmployee.DataTextField = "E_Name";
                ddlEmployee.DataBind();
                ddlEmployee.Items.Insert(0, "");
            }
        }
        catch (Exception)
        {

            //throw;
        }
    }
    public void LoadRole()
    {
        try
        {
            using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionstring2"].ToString()))
            {
                SqlCommand cmd = new SqlCommand("select * from tbl_role order by role_name asc", cn);
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);
                ddlRole.DataSource = dt;
                ddlRole.DataValueField = "role_id";
                ddlRole.DataTextField = "role_name";
                ddlRole.DataBind();
                ddlRole.Items.Insert(0, "");
            }
        }
        catch (Exception)
        {

            //throw;
        }

    }
    #endregion

    #region CheckUsername
    [WebMethod]
    public static int CheckEmpUsername(string Username)
    {
        DataTable dt = new DataTable();
        int result = 0;
        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionstring2"].ToString()))
        {
            SqlCommand cmd = new SqlCommand("select * from user1 where user_id = '" + Username + "'", cn);
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            da.Fill(dt);
            result = dt.Rows.Count;
        }
        return result;
    }
    #endregion

    #region SaveUser
    [WebMethod]
    public static void SaveUser(string EmpID, string RoleID, string Username, string Password)
    {
        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionstring2"].ToString()))
        {
            SqlCommand cmd = new SqlCommand("select * from user1 where E_badge ='" + EmpID + "'", cn);
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);
            int flag = 0;
            if (dt.Rows.Count > 0)
            {
                flag = 1;
            }
            string Pass = "";
            Pass = Password.GetHashCode().ToString();
            if (flag == 1)
            {
                SqlCommand cmdupdate = new SqlCommand("update user1 set user_id = '" + Username + "',role_id = '" + RoleID + "', user_pwd = '" + Password + "', Deleted = " + 0 + ", ModBy = '" + UserID + "', ModDate = '" + DateTime.Now.ToShortDateString() + "' where E_badge = '" + EmpID + "'", cn);
                cn.Open();
                cmdupdate.ExecuteNonQuery();
            }
            else
            {
                SqlCommand query = new SqlCommand();
                query.CommandText = "Web_Proc_SaveUserData";
                query.CommandType = CommandType.StoredProcedure;
                query.Parameters.Add("@EmpID", EmpID);
                query.Parameters.Add("@RoleID", int.Parse(RoleID));
                query.Parameters.Add("@Username", Username);
                query.Parameters.Add("@Password", Pass);
                query.Parameters.Add("@Status", 1);
                query.Parameters.Add("@Deleted", false);
                query.Parameters.Add("@WorkDays", 26);
                query.Parameters.Add("@CreatedBy", UserID);
                query.Parameters.Add("@CreatedDate", DateTime.Now.ToShortDateString());
                query.Parameters.Add("@ModBy", UserID);
                query.Parameters.Add("@ModDate", DateTime.Now.ToShortDateString());
                query.Connection = cn;
                cn.Open();
                query.ExecuteNonQuery();
            }
        }
    }
    #endregion

    #region GetUser
    [WebMethod]
    public static Dictionary<string, object> GetUserDetails()
    {
        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionstring2"].ToString()))
        {
            SqlCommand cmd = new SqlCommand("select distinct tbl_employee.E_name,user1.user_id, user1.E_badge, user1.role_id, tbl_role.role_name " +
                                            "from user1 inner join tbl_employee on user1.E_badge = tbl_employee.E_badge inner join tbl_role " +
                                            "on user1.role_id = tbl_role.role_id where user1.Deleted = 0 order by tbl_employee.E_name", cn);
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataSet ds = new DataSet();
            da.Fill(ds, "UserDetails");
            DataTable dt = new DataTable();
            dt = ds.Tables["UserDetails"];
            return ToJson(dt);
        }
    }
    #endregion

    #region DeleteUser
    [WebMethod]
    public static void DeleteUserData(string ID, string username)
    {
        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionstring2"].ToString()))
        {
            SqlCommand cmd;
            if (ID != "")
            {
                cmd = new SqlCommand("Update user1 set Deleted = 1 where E_badge = '" + ID + "'", cn);
                cn.Open();
                cmd.ExecuteNonQuery();
                Membership.DeleteUser(username);
            }
            else
            {
                cmd = new SqlCommand("Update user1 set Deleted = 1 where user_id = '" + username + "'", cn);
                cn.Open();
                cmd.ExecuteNonQuery();
                Membership.DeleteUser(username);
            }
        }
    }
    #endregion

    #region UpdateUser
    [WebMethod]
    public static void UpdateUserData(string EmpID, string RoleID, string Username, string Password)
    {
        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionstring2"].ToString()))
        {
            string Pass = "";
            Pass = Password.GetHashCode().ToString();
            SqlCommand cmd = new SqlCommand("update user1 set user_id = '" + Username + "',role_id = '" + RoleID + "', user_pwd = '" + Pass + "', ModBy = '" + UserID + "', ModDate = '" + DateTime.Now.ToShortDateString() + "' where E_badge = '" + EmpID + "'", cn);
            cn.Open();
            cmd.ExecuteNonQuery();
            Membership.DeleteUser(Username);
        }
    }
    #endregion

    #region CheckEmployeeUser
    [WebMethod]
    public static int CheckUser(string EmployeeID)
    {
        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionstring2"].ToString()))
        {
            SqlCommand cmd = new SqlCommand("select * from user1 where E_badge ='" + EmployeeID + "' and Deleted = 0", cn);
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);
            int flag = 0;
            if (dt.Rows.Count > 0)
            {
                flag = 1;
            }
            return flag;
        }
    }
    #endregion

}

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
public partial class frmEmpPlan : System.Web.UI.Page
{
    static string UserID = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["Role"] == null)
        {
            Response.Redirect("../../MCTX_General/Login.aspx");
            return;
        }
        else
        {
            LoadEmp();
            UserID = Request.Cookies["Username"].Value.ToString();
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
                ddlEmployee.DataSource = dtEmp;
                ddlEmployee.DataTextField = "E_Name";
                ddlEmployee.DataValueField = "User_Id";
                ddlEmployee.DataBind();
                ddlEmployee.Items.Insert(0, "");
            }
        }
        catch (Exception)
        {

            //throw;
        }
    }
    #region SavePlanDays
    [WebMethod]
    public static void SavePlanDays(string User, string PlanDays)
    {
        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionstring2"].ToString()))
        {

            SqlCommand query = new SqlCommand("SELECT * from tbl_VisitPlaningDays where UserID = '" + User + "'", cn);
            SqlDataAdapter da = new SqlDataAdapter(query);
            DataTable dt = new DataTable();
            da.Fill(dt);
            SqlCommand cmd;
            if (dt.Rows.Count > 0)
            {
                cmd = new SqlCommand("UPDATE [tbl_VisitPlaningDays] " +
                                       "SET [PlanDays] = '" + PlanDays + "'" +
                                          ",[UserID] = '" + User + "'" +
                                          ",[ModifiedBy] = '" + UserID + "'" +
                                          ",[ModifiedDate] = '" + DateTime.Now.ToShortDateString() + "'" +
                                          ",[Deleted] = '" + false + "'" +
                                          "WHERE [UserID] = '" + User + "'", cn);
            }
            else
            {
                cmd = new SqlCommand("INSERT INTO [tbl_VisitPlaningDays]" +
                                               "([PlanDays]" +
                                               ",[UserID]" +
                                               ",[Deleted]" +
                                               ",[CreatedBy]" +
                                               ",[CreatedDate]" +
                                               ",[ModifiedBy]" +
                                               ",[ModifiedDate])" +
                                         "VALUES('" + PlanDays + "'" +
                                               ",'" + User + "'" +
                                               ",'" + false + "'" +
                                               ",'" + UserID + "'" +
                                               ",'" + DateTime.Now.ToShortDateString() + "'" +
                                               ",'" + UserID + "'" +
                                               ",'" + DateTime.Now.ToShortDateString() + "')", cn);
            }
            cn.Open();
            cmd.ExecuteNonQuery();
        }
    }
    #endregion

    #region Delete
    [WebMethod]
    public static void Delete(string ID)
    {
        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionstring2"].ToString()))
        {
            SqlCommand cmd = new SqlCommand("UPDATE [tbl_VisitPlaningDays] Set Deleted = '" + true + "' where PlanDay_ID = '" + ID + "' ", cn);
            cn.Open();
            cmd.ExecuteNonQuery();
        }
    }
    #endregion

    #region GetPlanDays
    [WebMethod]
    public static Dictionary<string, object> GetPlanDays()
    {
        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionstring2"].ToString()))
        {
            SqlCommand cmd = new SqlCommand("select tbl_VisitPlaningDays.PlanDay_ID,tbl_VisitPlaningDays.UserID,tbl_employee.E_Name," +
                                            "tbl_VisitPlaningDays.PlanDays," +
                                            "tbl_VisitPlaningDays.CreatedBy as CBy,tblEmp.E_Name as CreatedBy,Convert(varchar(20)," +
                                            "tbl_VisitPlaningDays.CreatedDate,101) as CreatedDate," +
                                            "tbl_VisitPlaningDays.ModifiedBy as ModBy,tblEmp1.E_Name as ModifiedBy," +
                                            "convert(varchar(20),tbl_VisitPlaningDays.ModifiedDate,101) as ModifiedDate " +
                                            "from tbl_VisitPlaningDays inner join " +
                                            "user1 on tbl_VisitPlaningDays.UserID = user1.user_id inner join " +
                                            "tbl_employee on  user1.E_badge = tbl_employee.E_badge inner join " +
                                            "user1 as u1 on tbl_VisitPlaningDays.CreatedBy = u1.user_id inner join " +
                                            "tbl_employee as tblEmp on  u1.E_badge = tblEmp.E_badge inner join " +
                                            "user1 as u2 on tbl_VisitPlaningDays.ModifiedBy = u2.user_id inner join " +
                                            "tbl_employee as tblEmp1 on  u2.E_badge = tblEmp1.E_badge " +
                                            "where tbl_VisitPlaningDays.Deleted = '" + false + "'", cn);
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataSet ds = new DataSet();
            da.Fill(ds, "Details");
            DataTable dt = new DataTable();
            dt = ds.Tables["Details"];
            return ToJson(dt);
        }
    }
    #endregion
}

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

public partial class MCTX_Internal_SuperAdmin_frmClientsInfo : System.Web.UI.Page
{
    static string User = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Request.Cookies["userName"] == null)
        {
            Response.Redirect("../../MCTX_General/Login.aspx");
            return;
        }
        else
        {
            User = Request.Cookies["Username"].Value.ToString();
            GetCompany();
            GetCity();
            GetSearchCity();
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

    #region LoadDLL
    public void GetCity()
    {
        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionstring2"].ToString()))
        {
            SqlCommand cmd = new SqlCommand("SELECT * from city order by city_name asc", cn);
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);
            ddlCity.DataSource = dt;
            ddlCity.DataValueField = "city_id";
            ddlCity.DataTextField = "city_name";
            ddlCity.DataBind();
            ddlCity.Items.Insert(0, "");

        }
    }
    public void GetCompany()
    {
        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionstring2"].ToString()))
        {
            //SqlCommand cmd = new SqlCommand("select [comp_id],[comp_name] from [tbl_company] where [Deleted] = 0 order by [comp_name] asc", cn);
            SqlCommand cmd = new SqlCommand("select top 300 [comp_id],[comp_name] from [tbl_company] where isnull([Deleted],0)<>1 order by [created_date] desc", cn);
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);
            ddlCompanyName.DataSource = dt;
            ddlCompanyName.DataValueField = "comp_id";
            ddlCompanyName.DataTextField = "comp_name";
            ddlCompanyName.DataBind();
            ddlCompanyName.Items.Insert(0, "");
        }
    }
    public void GetSearchCity()
    {
        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionstring2"].ToString()))
        {
            SqlCommand cmd = new SqlCommand("SELECT * from city order by city_name asc", cn);
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);
            ddlSearchCity.DataSource = dt;
            ddlSearchCity.DataValueField = "city_id";
            ddlSearchCity.DataTextField = "city_name";
            ddlSearchCity.DataBind();
            ddlSearchCity.Items.Insert(0, "");

        }
    }

    #endregion

    #region GetClientDetails
    [WebMethod]
    public static Dictionary<string, object> GetDetails(string SearchComp, string SearchCity)
    {
        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionstring2"].ToString()))
        {
            string query = "select distinct top 300 client.client_id as ClientID,isnull(client.client_name,'') as ClientName," +
                           "isnull(client.comp_id,'') as CompanyID, isnull(tbl_Company.comp_name,'') as  CompanyName," +
                           "isnull(client.client_dept,'') as Dept,isnull(client.client_designation,'') as Desg," +
                           "isnull(client.client_phone,'') as Phone,isnull(client.Client_mobile,'') as Cell," +
                           "isnull(client.client_fax,'') as Fax,isnull(client.client_email,'') as Email," +
                           "isnull(client.city_id,'') as CityID, isnull(city.city_name,'') as CityName," +
                           "isnull(client.client_address,'') as Address from client " +
                           "inner join tbl_Company on client.comp_id=tbl_Company.comp_id " +
                           "inner join city on client.city_id=city.city_id " +
                           "where client.Deleted = 0";
            if (SearchComp != "")
            {
                query += " and tbl_Company.comp_name like '%" + SearchComp + "%'";
            }
            if (SearchCity != "")
            {
                query += " and client.city_id = '" + SearchCity + "'";
            }
            query += " order by client.client_id desc";
            SqlCommand cmd = new SqlCommand(query, cn);
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataSet ds = new DataSet();
            da.Fill(ds, "ClientDetails");
            DataTable dt = new DataTable();
            dt = ds.Tables["ClientDetails"];
            return ToJson(dt);
        }
    }
    #endregion

    #region SaveClientInfo
    [WebMethod]
    public static void SaveClients(string ClientName, string CompanyID, string Dept, string Desg, string Phone, string Cell, string Fax, string Email, string CityID, string Address)
    {
        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionstring2"].ToString()))
        {
            SqlCommand cmd = new SqlCommand();
            cmd.CommandText = "Web_Proc_SaveClientInfo";
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Add("@ClientName", ClientName);
            cmd.Parameters.Add("@CompanyID", int.Parse(CompanyID));
            cmd.Parameters.Add("@Dept", Dept);
            cmd.Parameters.Add("@Desg", Desg);
            cmd.Parameters.Add("@Phone", Phone);
            cmd.Parameters.Add("Cell", Cell);
            cmd.Parameters.Add("@Fax", Fax);
            cmd.Parameters.Add("@Email", Email);
            cmd.Parameters.Add("@CityID", int.Parse(CityID));
            cmd.Parameters.Add("@Address", Address);
            cmd.Parameters.Add("@CreatedBy", User);
            cmd.Parameters.Add("@Deleted", false);
            cmd.Connection = cn;
            cn.Open();
            cmd.ExecuteNonQuery();
        }
    }
    #endregion

    #region DeleteClients
    [WebMethod]
    public static void DeleteClients(string ClientID)
    {
        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionstring2"].ToString()))
        {
            SqlCommand cmd = new SqlCommand("Update client set Deleted = 'true' where client_id = '" + ClientID + "'", cn);
            cn.Open();
            cmd.ExecuteNonQuery();
        }
    }
    #endregion

    #region UpdateClientInfo
    [WebMethod]
    public static void UpdateClients(string ClientID, string ClientName, string CompanyID, string Dept, string Desg, string Phone, string Cell, string Fax, string Email, string CityID, string Address)
    {
        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionstring2"].ToString()))
        {
            SqlCommand cmd = new SqlCommand();
            cmd.CommandText = "Web_Proc_UpdateClientInfo";
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Add("@ClientID", int.Parse(ClientID));
            cmd.Parameters.Add("@ClientName", ClientName);
            cmd.Parameters.Add("@CompanyID", int.Parse(CompanyID));
            cmd.Parameters.Add("@Dept", Dept);
            cmd.Parameters.Add("@Desg", Desg);
            cmd.Parameters.Add("@Phone", Phone);
            cmd.Parameters.Add("Cell", Cell);
            cmd.Parameters.Add("@Fax", Fax);
            cmd.Parameters.Add("@Email", Email);
            cmd.Parameters.Add("@CityID", int.Parse(CityID));
            cmd.Parameters.Add("@Address", Address);
            cmd.Parameters.Add("@CreatedBy", User);
            cmd.Parameters.Add("@Deleted", false);
            cmd.Connection = cn;
            cn.Open();
            cmd.ExecuteNonQuery();
        }
    }
    #endregion
}

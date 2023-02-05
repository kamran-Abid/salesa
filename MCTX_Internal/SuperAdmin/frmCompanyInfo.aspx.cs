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

public partial class MCTX_Internal_SuperAdmin_frmCompanyInfo : System.Web.UI.Page
{
    static string userid = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            GetCity();
            GetCityS();
        }
        try
        {
            userid = Request.Cookies["Username"].Value.ToString();
        }
        catch (Exception)
        {

            //throw;
        }

        if (userid == "")
        {
            Response.Redirect("../../MCTX_General/Login.aspx");
            return;
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

    #region CheckCompany
    [WebMethod]
    public static int CheckCompany(string CompName, string CityID)
    {
        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionstring2"].ToString()))
        {
            SqlCommand cmd = new SqlCommand("select * from tbl_Company where comp_name = '" + CompName + "' and comp_city_id = '" + CityID + "' and Deleted = '" + false + "'", cn);
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

    public void GetCityS()
    {
        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionstring2"].ToString()))
        {
            SqlCommand cmd = new SqlCommand("SELECT * from city order by city_name asc", cn);
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);
            ddlCityName.DataSource = dt;
            ddlCityName.DataValueField = "city_id";
            ddlCityName.DataTextField = "city_name";
            ddlCityName.DataBind();
            ddlCityName.Items.Insert(0, "");

        }
    }
    [WebMethod]
    public static Dictionary<string, object> PopulateCat()
    {
        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionstring2"].ToString()))
        {
            string query = "select cat_name,cat_id From tbl_category where isnull(Deleted,0)<>1 order by cat_name asc";
            SqlDataAdapter da = new SqlDataAdapter(query, cn);
            DataSet ds = new DataSet();
            da.Fill(ds, "Category");
            DataTable dt = new DataTable();
            dt = ds.Tables["Category"];
            return ToJson(dt);
        }
    }
    [WebMethod]
    public static Dictionary<string, object> PopulateItems(string CatID)
    {
        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionstring2"].ToString()))
        {
            string query = "select item_id,item_name From tbl_item where isnull(Deleted,0)<>1 and cat_id = '" + CatID + "' order by item_name asc";
            SqlDataAdapter da = new SqlDataAdapter(query, cn);
            DataSet ds = new DataSet();
            da.Fill(ds, "Items");
            DataTable dt = new DataTable();
            dt = ds.Tables["Items"];
            return ToJson(dt);
        }
    }
    [WebMethod]
    public static Dictionary<string, object> PopulateComp()
    {
        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionstring2"].ToString()))
        {
            SqlCommand cmd = new SqlCommand("select [comp_id],[comp_name] from [tbl_company] where [Deleted] = 0 order by [comp_name] asc", cn);
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataSet ds = new DataSet();
            da.Fill(ds, "Company");
            DataTable dt = new DataTable();
            dt = ds.Tables["Company"];
            return ToJson(dt);
        }
    }
    #endregion

    #region LoadProducts
    [WebMethod]
    public static Dictionary<string, object> GetProducts()
    {
        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionstring2"].ToString()))
        {
            SqlCommand cmd = new SqlCommand("SELECT item_id,item_name from tbl_item where Deleted = 0 order by item_name asc", cn);
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataSet ds = new DataSet();
            da.Fill(ds, "ProductInfo");
            DataTable dt = new DataTable();
            dt = ds.Tables["ProductInfo"];
            return ToJson(dt);
        }
    }
    #endregion

    #region SaveCompanyInfo
    [WebMethod]
    public static string SaveCompanyInfo(string CompName, string CityID, string Email, string WebAdd, string PhoneNum, string CatID, string TarProd, string TarProdID, string Address, string CompanyKey)
    {
        string r_str = "";
        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionstring2"].ToString()))
        {
        DateTime Date = DateTime.Parse(DateTime.Now.ToShortDateString());
        string Query = "select * from tbl_company where comp_Key= '"+CompanyKey.Trim()+"'";
        SqlDataAdapter da = new SqlDataAdapter(Query, cn);
        DataSet ds = new DataSet();
        da.Fill(ds, "CompDetails");

        DataTable dt = new DataTable();
        dt = ds.Tables["CompDetails"];
        if (dt.Rows.Count > 0)
        {
            r_str = "Already Exist Company key";
        }
        else
        {

            SqlCommand cmd = new SqlCommand();
            cmd.CommandText = "Web_Proc_SaveCompInfo";
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Add("@CompName", CompName);
            cmd.Parameters.Add("@CityID", int.Parse(CityID));
            cmd.Parameters.Add("@Email", Email);
            cmd.Parameters.Add("@WebAdd", WebAdd);
            cmd.Parameters.Add("@PhoneNum", PhoneNum);
            //cmd.Parameters.Add("@Category_Id", int.Parse(CatID));
            //cmd.Parameters.Add("@TarProd", TarProd);
            //cmd.Parameters.Add("@TarProdID", int.Parse(TarProdID));
            cmd.Parameters.Add("@Address", Address);
            cmd.Parameters.Add("@CreatedBy", userid);
            cmd.Parameters.Add("@CreatedDate", Date);
            cmd.Parameters.Add("@ModBy", userid);
            cmd.Parameters.Add("@ModDate", Date);
            cmd.Parameters.Add("@Deleted", false);
            cmd.Parameters.Add("@companyKey", CompanyKey);
            cmd.Connection = cn;
            cn.Open();
            cmd.ExecuteNonQuery();
            r_str = "Added Successfully";
        }
            return r_str;
        }
    }
    #endregion

    #region GetCompDetails
    [WebMethod]
    public static Dictionary<string, object> LoadCompanyInfo(string CompID, string CityID)
    {
        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionstring2"].ToString()))
        {
            string query = "SELECT distinct Top 200 [comp_id]" +
                           ",isnull([tbl_company].[comp_name],'') as [comp_name]" +
                           ",isnull([tbl_company].[comp_address],'') as [comp_address]" +
                           ",isnull([tbl_company].[comp_phone],'') as [comp_phone]" +
                           ",isnull([tbl_company].[comp_city_id],'') as [comp_city_id]" +
                           ",isnull([City].[city_name],'') as [city_name]" +
                           ",isnull([tbl_company].[comp_website],'') as [comp_website]" +
                           ",isnull([tbl_company].[comp_email],'') as [comp_email]" +
                           ",isnull([tbl_company].[Category_Id],'') as [CategoryID]" +
                           ",isnull([tbl_category].[cat_name],'') as [CatName]" +
                           ",isnull([tbl_company].[comp_targted_products],'') as [comp_targted_products]" +
                           ",isnull([tbl_company].[comp_TarProdID],'') as [comp_TarProdID]" +
                           ",isnull([tbl_company].[Created_By],'') as [Created_By] , comp_Key" +
                           ",isnull(convert(varchar(20),[tbl_company].[Created_Date],101),'') as [Created_Date]" +
                           ",isnull([tbl_company].[Modified_By],'') as [Modified_By]" +
                           ",isnull(convert(varchar(20),[tbl_company].[Modified_Date],101),'') as [Modified_Date] " +
                           " FROM [tbl_company] " +
                           " inner join [City] on [tbl_company].[comp_city_id]=[City].[city_id] " +
                           " left join [tbl_category] on [tbl_company].[Category_Id] = [tbl_category].[cat_id] " +
                           " where [tbl_company].[Deleted] = 0";
            if (CompID == "undefined")
            {
                CompID = "";
            }
            if (CompID != "")
            {
                query += " AND [tbl_company].[comp_name] like '%" + CompID + "%'";
            }
            if (CityID != "")
            {
                query += " AND [tbl_company].[comp_city_id]= '" + CityID + "'";
            }
            query += " order by [tbl_company].[comp_id] desc";
            SqlDataAdapter da = new SqlDataAdapter(query, cn);
            DataSet ds = new DataSet();
            da.Fill(ds, "CompDetails");

            DataTable dt = new DataTable();
            dt = ds.Tables["CompDetails"];
            return ToJson(dt);
        }
    }
    #endregion

    #region DeleteCompany
    [WebMethod]
    public static void DeleteComp(string CompID)
    {
        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionstring2"].ToString()))
        {
            SqlCommand cmd = new SqlCommand();
            cmd.CommandText = "Web_Proc_DeleteCompData";
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Add("@CompID", int.Parse(CompID));
            cmd.Parameters.Add("@ModBy", userid);
            cmd.Parameters.Add("@ModDate", DateTime.Now);
            cmd.Parameters.Add("@Deleted", "1");
            cmd.Connection = cn;
            cn.Open();
            cmd.ExecuteNonQuery();
        }
    }
    #endregion

    #region UpdateCompany
    [WebMethod]
    public static string UpdateComp(string CompID, string CompName, string CityID, string Email, string WebAdd, string CompPhone, string CatID, string TarProd, string TarProdID, string Address, string CompanyKey)
    {
        string r_str = "";
        DateTime Date = DateTime.Parse(DateTime.Now.ToShortDateString());
        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionstring2"].ToString()))
        {
            //string Query = "select * from tbl_company where comp_Key= '" + CompanyKey.Trim() + "'";
            //SqlDataAdapter da = new SqlDataAdapter(Query, cn);
            //DataSet ds = new DataSet();
            //da.Fill(ds, "CompDetails");

            //DataTable dt = new DataTable();
            //dt = ds.Tables["CompDetails"];
            //if (dt.Rows.Count > 0)
            //{
            //    r_str = "Already Exist Company key";
            //}
           // else
            //{
                SqlCommand cmd = new SqlCommand();
                cmd.CommandText = "Web_Proc_UpdateCompInfo";
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add("@CompID", int.Parse(CompID));
                cmd.Parameters.Add("@CompName", CompName);
                cmd.Parameters.Add("@CityID", int.Parse(CityID));
                cmd.Parameters.Add("@Email", Email);
                cmd.Parameters.Add("@WebAdd", WebAdd);
                cmd.Parameters.Add("@PhoneNum", CompPhone);
                cmd.Parameters.Add("@Address", Address);
                cmd.Parameters.Add("@ModBy", userid);
                cmd.Parameters.Add("@ModDate", Date);
                cmd.Parameters.Add("@Deleted", false);
                cmd.Parameters.Add("@companyKey", CompanyKey);
                cmd.Connection = cn;
                cn.Open();
                cmd.ExecuteNonQuery();
                r_str = "Added Successfully";
            //}
        }
        return r_str;
    }
    #endregion

}

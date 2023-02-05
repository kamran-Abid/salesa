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
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Runtime.Serialization.Json;
using System.Web.Script.Serialization;

using Sales_BOL;
using System.Web.Services;

public partial class MCTX_Internal_SuperAdmin_MCTXWebMethod : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

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
    public static Dictionary<string, object> getComPanyInfo(string companyName, string companyWebSite, string countryName, string cityName, string companyPhone, string targetProduct, string Address)
    {
        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionstring2"].ToString()))
        {
            //if (userName != "")
            {
                string query = "select top 100  comp.comp_id,comp.comp_name, comp.comp_address,comp.comp_phone,comp.comp_mobile,cnt.country_name,cit.city_name,comp.comp_website,comp.comp_email,comp.user_id,comp.comp_created_date,isnull(comp.comp_targted_products,'') as comp_targted_products from tbl_company comp join country cnt on comp.comp_country_id=cnt.country_id join city cit on comp.comp_city_id=cit.city_id where isnull(deleted,'')<>1";
                if (companyName != "")
                    query += " and comp_name like'" + companyName + "%'";

                if (companyWebSite != "")
                    query += " and comp_website like'" + companyWebSite + "%'";

                if (countryName != "")
                    query += " and cnt.country_name like'" + countryName + "%'";

                if (cityName != "")
                    query += " and cit.city_name like'" + cityName + "%'";

                if (companyPhone != "")
                    query += " and comp_phone like'" + companyPhone + "%'";

                if (targetProduct != "")
                    query += " and comp_targted_products like'" + targetProduct + "%'";

                if (Address != "")
                    query += " and comp_address like'" + Address + "%'";

                SqlCommand cmd = new SqlCommand(query, cn);
                cn.Open();
                SqlDataAdapter DA = new SqlDataAdapter(cmd);
                DataSet ds = new DataSet();
                DA.Fill(ds, "companyInfo");
                DataTable dt = new DataTable();
                dt = ds.Tables["companyInfo"];
                return ToJson(dt);
            }


        }
    }

    [WebMethod]

    public static void UpdateCompInfo(string compID, string companyName, string companyWebSite, string countryName, string cityName, string companyPhone, string targetProduct, string Address)
    {
        //string userName = HttpContext.Current.Session["UserFullName"].ToString();
        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionstring2"].ToString()))
        {


            string query = "update [tbl_company] " +
                              "set [comp_name]='" + companyName + "',[comp_address]='" + Address + "',[comp_phone]=" + companyPhone + "" +
                              ",[comp_country_id]=" + int.Parse(countryName) + ",[comp_city_id]=" + int.Parse(cityName) + ",[comp_website]='" + companyWebSite + "'" +
                              ",[comp_targted_products]='" + targetProduct + "' where comp_id=" + compID;

            SqlCommand cmd = new SqlCommand(query, cn);
            cn.Open();
            cmd.ExecuteNonQuery();



        }
    }


    [WebMethod]

    public static void DeleteCompanyInfo(string compID)
    {
        //string userName = HttpContext.Current.Session["UserFullName"].ToString();
        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionstring2"].ToString()))
        {


            string query = "update [tbl_company] " +
                              "set [deleted]='1'  where comp_id=" + compID;

            SqlCommand cmd = new SqlCommand(query, cn);
            cn.Open();
            cmd.ExecuteNonQuery();



        }
    }


    [WebMethod]
    public static Dictionary<string, object> getClientInfo(string txtClientName, string txtMobileNo, string txtEmail, string txtPhone, string txtDesignation, string txtDepartment, string txtFaxNo, string ddlCountry, string ddlCity, string Address, string ddlCompanyName)
    {
        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionstring2"].ToString()))
        {

            {
                string query = "select top 100 CL.client_id,CL.client_name,CL.client_designation,CL.client_mobile,CL.client_phone,CL.client_dept,CL.client_email,cnt.country_id,CIT.city_id,CMP.comp_id,CL.client_address,CL.client_fax,CMP.comp_name,CNT.country_name,CIT.city_name from client CL  join tbl_company CMP on CL.comp_id=CMP.comp_id join country CNT on  CMP.comp_country_id=cnt.country_id join city CIT ON CL.city_id=CIT.city_id where isnull(CL.Deleted,0)<>1";

                if (txtClientName != "")
                    query += " and client_name like'" + txtClientName + "%'";

                if (txtMobileNo != "")
                    query += " and client_mobile like'" + txtMobileNo + "%'";

                if (txtEmail != "")
                    query += " and client_email like'" + txtEmail + "%'";

                if (txtPhone != "")
                    query += " and client_phone like'" + txtPhone + "%'";

                if (txtDesignation != "")
                    query += " and client_designation like'" + txtDesignation + "%'";

                if (txtDepartment != "")
                    query += " and CL.client_dept like'" + txtDepartment + "%'";

                if (txtFaxNo != "")
                    query += " and CL.client_fax like'" + txtFaxNo + "%'";
                if (ddlCountry != "")
                    query += " and CNT.country_name like'" + ddlCountry + "%'";

                if (ddlCity != "")
                    query += " and CIT.city_name like'" + ddlCity + "%'";

                if (Address != "")
                    query += " and client_address like'" + Address + "%'";

                if (ddlCompanyName != "")
                    query += " and CMP.comp_name like'" + ddlCompanyName + "%'";

                SqlCommand cmd = new SqlCommand(query, cn);
                cn.Open();
                SqlDataAdapter DA = new SqlDataAdapter(cmd);
                DataSet ds = new DataSet();
                DA.Fill(ds, "ClientInfo");
                DataTable dt = new DataTable();
                dt = ds.Tables["ClientInfo"];
                return ToJson(dt);
            }


        }
    }

    [WebMethod]

    public static void DeleteClientInfo(string txtClientID)
    {

        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionstring2"].ToString()))
        {
            string query = "update [client] " +
                              "set [deleted]='1'  where client_ID=" + txtClientID;

            SqlCommand cmd = new SqlCommand(query, cn);
            cn.Open();
            cmd.ExecuteNonQuery();



        }
    }


    [WebMethod]

    public static void UpdateClientInfo(string txtClientID, string txtClientName, string txtMobileNo, string txtEmail, string txtPhone, string txtDesignation, string txtDepartment, string txtFaxNo, string ddlCountry, string ddlCity, string Address, string ddlCompanyName)
    {
        //string userName = HttpContext.Current.Session["UserFullName"].ToString();
        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionstring2"].ToString()))
        {


            string query = "update [client] " +
                              "set [client_name]='" + txtClientName + "',[client_mobile]='" + txtMobileNo + "',[client_email]='" + txtEmail + 
                              "',[client_phone]='" + txtPhone + "',[client_designation]='" + txtDesignation + "',[client_dept]='" + txtDepartment + "',[country_id]=" + int.Parse(ddlCountry) + ",[city_id]=" + int.Parse(ddlCity) + ",[comp_id]=" + int.Parse(ddlCompanyName) + ",[client_address]='" + Address + "'" +
                              " where client_id  =" + txtClientID;

            SqlCommand cmd = new SqlCommand(query, cn);
            cn.Open();
            cmd.ExecuteNonQuery();



        }
    }

}

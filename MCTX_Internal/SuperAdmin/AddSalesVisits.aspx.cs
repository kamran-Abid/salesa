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
using System.Xml.Linq;
using System.Web.Mail;
using Org.BouncyCastle.Asn1.Ocsp;

public partial class MCTX_Internal_SuperAdmin_frmVisitReports : System.Web.UI.Page
{
    static string UserID = "";
    static string UserFullName = "";
    static string ThisMon = "";
    static string IPAddress = "";
    static string SalesAmount = "";
    static string TotalSaleAmount = "";
    static string CurrentDate = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            UserID = Session["Username"].ToString();
            UserFullName = Session["UserFullName"].ToString();
            string CurrMon = DateTime.Now.Month.ToString();
            if (CurrMon.Length == 1)
            {
                CurrMon = '0' + CurrMon;
            }
            string CurrYear = DateTime.Now.Year.ToString();
            ThisMon = CurrMon + "/" + "01" + "/" + CurrYear;
            IPAddress = Request.UserHostAddress;
            CurrentDate = DateTime.Now.ToShortDateString();
            if (CurrentDate.Length == 9)
            {
                CurrentDate = '0' + CurrentDate;
            }
            txtCurrDate.Text = CurrentDate;
            GetSelComp();
            GetCity();
            LoadCountries();
            lblMonSaleToDate.Text = SalesAmount;
        }
        catch (Exception)
        {

            //throw;
        }
        try
        {
            using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionstring2"].ToString()))
            {
                SqlCommand cmd = new SqlCommand("Select PlanDays from tbl_VisitPlaningDays where UserID = '" + UserID + "' and Deleted = '" + false + "'", cn);
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);
                string PlanDays = "0";
                if (dt.Rows.Count > 0)
                {
                    PlanDays = dt.Rows[0]["PlanDays"].ToString();
                }
                txtPlanDays.Text = PlanDays;
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

    #region LoadDDLs
    [WebMethod]
    public static Dictionary<string, object> PopulateComp()
    {
        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionstring2"].ToString()))
        {
            SqlCommand cmd = new SqlCommand("select top 300 [comp_id],[comp_name] from [tbl_company] where isnull([Deleted],0)<>1 order by [created_date] desc", cn);
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataSet ds = new DataSet();
            da.Fill(ds, "Company");
            DataTable dt = new DataTable();
            dt = ds.Tables["Company"];
            return ToJson(dt);
        }
    }
    [WebMethod]
    public static Dictionary<string, object> PopClient(string CompanyID)
    {
        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionstring2"].ToString()))
        {
            SqlCommand cmd = new SqlCommand("select top 300 client_id,client_name from client where comp_id = '" + CompanyID + "' and isnull(Deleted,0)<>1", cn);
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataSet ds = new DataSet();
            da.Fill(ds, "Clients");
            DataTable dt = new DataTable();
            dt = ds.Tables["Clients"];
            return ToJson(dt);
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
    public static Dictionary<string, object> PopulateCall()
    {
        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionstring2"].ToString()))
        {
            string query = "select tt_id, tt_name from tbl_TargetType where Deleted <> 0 order by tt_name asc";
            SqlDataAdapter da = new SqlDataAdapter(query, cn);
            DataSet ds = new DataSet();
            da.Fill(ds, "Call");
            DataTable dt = new DataTable();
            dt = ds.Tables["Call"];
            return ToJson(dt);
        }
    }
    [WebMethod]
    public static Dictionary<string, object> PopulateResponse()
    {
        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionstring2"].ToString()))
        {
            string query = "select * from T_ClientResponse order by response_name asc";
            SqlDataAdapter da = new SqlDataAdapter(query, cn);
            DataSet ds = new DataSet();
            da.Fill(ds, "Response");
            DataTable dt = new DataTable();
            dt = ds.Tables["Response"];
            return ToJson(dt);
        }
    }
    [WebMethod]
    public static Dictionary<string, object> GetCategory_Products_DDL(string Cat_Id)
    {
        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionstring2"].ToString()))
        {
            if (Cat_Id == string.Empty)
            {
                Cat_Id = "0";
            }
            SqlCommand cmd = new SqlCommand("SELECT Item_name, item_id from tbl_item where cat_id=" + Cat_Id + " and isnull(Deleted,0)<>1 order by item_name", cn);
            cn.Open();
            DataTable dt = new DataTable();
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataSet ds = new DataSet();
            da.Fill(ds, "Products");
            dt = ds.Tables["Products"];
            return ToJson(dt);
        }
    }
    [WebMethod]
    public static Dictionary<string, object> Load_CategoriesDDL()
    {
        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionstring2"].ToString()))
        {
            SqlCommand cmd = new SqlCommand("select cat_id,cat_name from tbl_category where isnull(deleted,0)<>1", cn);
            cn.Open();
            DataTable dt = new DataTable();
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataSet ds = new DataSet();
            da.Fill(ds, "Categories");
            dt = ds.Tables["Categories"];
            return ToJson(dt);
        }
    }
    [WebMethod]
    public static Dictionary<string, object> Load_Companies()
    {
        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionstring2"].ToString()))
        {
            DataTable dt = new DataTable();
            DataSet ds = new DataSet();
            cn.Open();
            SqlCommand cmd = new SqlCommand("select top 10 comp_id,comp_name from tbl_company where isnull(deleted,0)<>1 order by 2", cn);
            SqlDataAdapter ad = new SqlDataAdapter(cmd);
            ad.Fill(ds, "Companies");
            dt = ds.Tables["Companies"];
            return ToJson(dt);
        }
    }
    [WebMethod]
    public static Dictionary<string, object> LoadCity_Client(string countryid)
    {
        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionstring2"].ToString()))
        {
            if (countryid == string.Empty)
            {
                countryid = "0";
            }
            DataTable dt = new DataTable();
            DataSet ds = new DataSet();
            cn.Open();
            SqlCommand cmd = new SqlCommand("select * from city where isnull(deleted,0)<>1 and country_id= " + countryid + " order by 2", cn);
            SqlDataAdapter ad = new SqlDataAdapter(cmd);
            ad.Fill(ds, "City_Client");
            dt = ds.Tables["City_Client"];
            return ToJson(dt);
        }
    }

    public void GetCity()
    {
        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionstring2"].ToString()))
        {
            SqlCommand cmd = new SqlCommand("SELECT * from city where isnull(deleted,0)<>1 order by 2", cn);
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

    public void LoadCountries()
    {
        try
        {
            using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionstring2"].ToString()))
            {
                SqlCommand cmdEmp = new SqlCommand("select * from country where isnull(deleted,0)<>1 order by 2", cn);
                cn.Open();
                SqlDataAdapter daEmp = new SqlDataAdapter(cmdEmp);
                DataTable dtEmp = new DataTable();
                daEmp.Fill(dtEmp);
                ddlCountry_Client.DataSource = dtEmp;
                ddlCountry_Client.DataTextField = "country_name";
                ddlCountry_Client.DataValueField = "country_id";
                ddlCountry_Client.DataBind();
                ddlCountry_Client.Items.Insert(0, "");
            }
        }
        catch (Exception)
        {
            //throw;
        }
    }

    #endregion

    #region GetCompanyCreated
    [WebMethod]
    public static string CompCreated(string CompanyID)
    {
        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionstring2"].ToString()))
        {
            string query = "select convert(varchar(20),Created_Date,101) as Created_Date  from tbl_Company where comp_id = '" + CompanyID + "'";
            SqlDataAdapter da = new SqlDataAdapter(query, cn);
            DataTable dt = new DataTable();
            da.Fill(dt);
            string CreatedDate = "";
            if (dt.Rows.Count > 0)
            {
                CreatedDate = dt.Rows[0]["Created_Date"].ToString();
            }
            return CreatedDate;
        }
    }
    public void GetSelComp()
    {
        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionstring2"].ToString()))
        {
            SqlCommand cmd = new SqlCommand("select [comp_id],[comp_name] from [tbl_company] where isnull([Deleted],0)<>1 order by [comp_name] asc", cn);
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);
            ddlSelCompany.DataSource = dt;
            ddlSelCompany.DataValueField = "comp_id";
            ddlSelCompany.DataTextField = "comp_name";
            ddlSelCompany.DataBind();
            ddlSelCompany.Items.Insert(0, "");
        }
    }
    #endregion

    #region SaveVisit
    [WebMethod]
    public static void AddVisit(string ClientID, string CallType, string ClientRes, string SaleAmt, string RemindDate, string Remarks)
    {
        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionstring2"].ToString()))
        {
            if (SaleAmt == "")
            {
                SaleAmt = "0";
            }
            SqlCommand cmd = new SqlCommand("INSERT INTO [visit]([client_id],[typeofvisit_id],[clientresponse_id],[total_Sale],[VisitDate],[RemindDate],[UserId],[remarks],[client_IpAdress])VALUES('" + ClientID + "','" + CallType + "','" + ClientRes + "','" + SaleAmt + "','" + DateTime.Now.ToShortDateString() + "','" + RemindDate + "','" + UserID + "','" + Remarks + "','" + IPAddress + "')", cn);
            cn.Open();
            cmd.ExecuteNonQuery();
        }
    }
    #endregion

    #region MonthSaleUptoToday
    [WebMethod]
    public static string GetMonthSal()
    {
        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionstring2"].ToString()))
        {
            string query = "Select isnull(Sum(total_Sale),0) as [Amount] From visit " +
                           "Where VisitDate Between '" + ThisMon + "' And GetDate() And UserId = '" + UserID + "'";
            SqlDataAdapter da = new SqlDataAdapter(query, cn);
            DataTable dt = new DataTable();
            da.Fill(dt);
            if (dt.Rows.Count > 0)
            {
                SalesAmount = dt.Rows[0]["Amount"].ToString();
            }
            else
            {
                SalesAmount = "0.00";
            }
            return SalesAmount;
        }
    }
    #endregion

    #region TotalSaleUptoToday
    [WebMethod]
    public static string GetTotalSal()
    {
        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionstring2"].ToString()))
        {
            string query = "select isnull(sum(total_Sale),0) as TotalSale from visit group by UserId having UserId = '" + UserID + "'";
            SqlDataAdapter da = new SqlDataAdapter(query, cn);
            DataTable dt = new DataTable();
            da.Fill(dt);
            if (dt.Rows.Count > 0)
            {
                TotalSaleAmount = dt.Rows[0]["TotalSale"].ToString();
            }
            else
            {
                TotalSaleAmount = "0.00";
            }
            return TotalSaleAmount;
        }
    }
    #endregion

    #region Today's Visits
    [WebMethod]
    public static Dictionary<string, object> GetTodaysVisit()
    {
        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionstring2"].ToString()))
        {
            string Query = "select v.visit_id ,isnull(convert(varchar(20),V.Visitdate,101),0) as [Visit_Date], " +
                           "isnull(tc.comp_name,'') as CompName, isnull(cl.client_name,'') as ClientName, " +
                           "isnull(vt.tt_name,'') as TypeName, isnull(v.total_Sale,0) as TotalSale, " +
                           "isnull(cr.response_name,'') as ClientRes, " +
                           "isnull(te.E_Name,'') as EName, isnull(v.client_IpAdress,'') as IPAddress " +
                           "from visit as v join user1 as u " +
                           "on v.userId = u.user_id Join tbl_Employee as te on u.E_badge = te.E_badge " +
                           "Join client as cl on v.client_id = cl.client_id Join tbl_company as tc " +
                           "on cl.comp_id = tc.comp_id Join T_ClientResponse as cr on " +
                           "v.clientresponse_id = cr.response_id Join tbl_TargetType as vt " +
                           "on v.typeofvisit_id = vt.tt_id where u.user_id = '" + UserID + "' " +
                           "and convert(varchar(20),V.Visitdate,101) between " +
                           "'" + CurrentDate + "' and '" + CurrentDate + "' order by 1 desc";
            SqlDataAdapter da = new SqlDataAdapter(Query, cn);
            DataSet ds = new DataSet();
            DataTable dt = new DataTable();
            da.Fill(ds, "VisitsToday");
            dt = ds.Tables["VisitsToday"];
            return ToJson(dt);
        }
    }
    #endregion

    #region Show All Visits
    [WebMethod]
    public static Dictionary<string, object> GetAllVisit()
    {
        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionstring2"].ToString()))
        {
            string Query = "select distinct v.visit_id ,isnull(convert(varchar(20),V.Visitdate,101),0) as [Visit_Date], " +
                           "isnull(tc.comp_name,'') as CompName, isnull(cl.client_name,'') as ClientName, " +
                           "isnull(vt.tt_name,'') as TypeName, isnull(v.total_Sale,0) as TotalSale, " +
                           "isnull(cr.response_name,'') as ClientRes, " +
                           "isnull(te.E_Name,'') as EName, isnull(v.client_IpAdress,'') as IPAddress, v.remarks " +
                           "from visit as v join user1 as u " +
                           "on v.userId = u.user_id Join tbl_Employee as te on u.E_badge = te.E_badge " +
                           "Join client as cl on v.client_id = cl.client_id Join tbl_company as tc " +
                           "on cl.comp_id = tc.comp_id Join T_ClientResponse as cr on " +
                           "v.clientresponse_id = cr.response_id Join tbl_TargetType as vt " +
                           "on v.typeofvisit_id = vt.tt_id where u.user_id = '" + UserID + "' " +
                            " order by 1 desc";
            SqlDataAdapter da = new SqlDataAdapter(Query, cn);
            DataSet ds = new DataSet();
            DataTable dt = new DataTable();
            da.Fill(ds, "AllVisits");
            dt = ds.Tables["AllVisits"];
            return ToJson(dt);
        }
    }
    #endregion
    #region CheckBooked
    [WebMethod]
    public static int GetBookedComp(string CompID)
    {
        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionstring2"].ToString()))
        {
            string Query = "select * from tbl_Prospecting where comp_id = " + CompID + " and " +
                            "user_id <> '" + UserID + "' and convert(varchar(20),Reserverd_date,101) > '" + CurrentDate + "'";
            SqlDataAdapter da = new SqlDataAdapter(Query, cn);
            DataTable dt = new DataTable();
            da.Fill(dt);
            int Booked = 0;
            if (dt.Rows.Count > 0)
            {
                Booked = 1;
            }
            return Booked;
        }
    }
    #endregion

    #region CheckAlreadyEntered
    [WebMethod]
    public static int CheckEntered(string CompID)
    {
        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionstring2"].ToString()))
        {
            string Query = "select v.visit_id,tc.comp_name,v.UserId from visit as v Join client as cl on v.client_id = cl.client_id " +
                            "Join tbl_company as tc on cl.comp_id = tc.comp_id " +
                            "where tc.comp_id  = '" + CompID + "' and " +
                            "convert(Varchar(20),VisitDate,101) = convert(Varchar(20),getdate(),101)";
            SqlDataAdapter da = new SqlDataAdapter(Query, cn);
            DataTable dt = new DataTable();
            da.Fill(dt);
            int Booked = 0;
            if (dt.Rows.Count > 0)
            {
                Booked = 1;
            }
            return Booked;
        }
    }
    #endregion

    #region AddVisitExcuse
    [WebMethod]
    public static void AddExcuse(string CompID, string Subject, string Details)
    {
        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionstring2"].ToString()))
        {
            SqlCommand cmd = new SqlCommand("Insert Into dbo.tbl_VisitExcuse (user_id,exDate,ex_Subject,Description,comp_id) " +
                                            "Values ('" + UserID + "','" + CurrentDate + "','" + Subject + "','" + Details + "'," + CompID + ")", cn);
            cn.Open();
            cmd.ExecuteNonQuery();
        }
    }
    #endregion

    #region CheckExcuse
    [WebMethod]
    public static int GetCheckExcuse(string CompID)
    {
        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionstring2"].ToString()))
        {
            SqlCommand cmd = new SqlCommand("select * from tbl_VisitExcuse where user_id = '" + UserID + "' and comp_id = '" + CompID + "' and " +
                                            "convert(varchar(20),exDate,101) = '" + CurrentDate + "'", cn);
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);
            int result = 0;
            if (dt.Rows.Count > 0)
            {
                result = 1;
            }
            return result;
        }
    }
    #endregion

    #region SaveCompanyInfo
    [WebMethod]
    public static void SaveCompanyInfo(string CompName, string CityID, string Email, string WebAdd, string PhoneNum, string TarProd, string TarProdId, string Address, string Cat_Id)
    {
        DateTime Date = DateTime.Parse(DateTime.Now.ToShortDateString());
        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionstring2"].ToString()))
        {
            SqlCommand cmd = new SqlCommand();
            cmd.CommandText = "Web_Proc_SaveCompInfo";
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Add("@CompName", CompName);
            cmd.Parameters.Add("@CityID", int.Parse(CityID));
            cmd.Parameters.Add("@Email", Email);
            cmd.Parameters.Add("@WebAdd", WebAdd);
            cmd.Parameters.Add("@PhoneNum", PhoneNum);
            cmd.Parameters.Add("@Category_Id", Cat_Id);
            cmd.Parameters.Add("@TarProd", TarProd);
            cmd.Parameters.Add("@TarProdID", int.Parse(TarProdId));
            cmd.Parameters.Add("@Address", Address);
            cmd.Parameters.Add("@CreatedBy", UserID);
            cmd.Parameters.Add("@CreatedDate", CurrentDate);
            cmd.Parameters.Add("@ModBy", "");
            cmd.Parameters.Add("@ModDate", "");
            cmd.Parameters.Add("@Deleted", false);
            cmd.Connection = cn;
            cn.Open();
            cmd.ExecuteNonQuery();
        }
    }
    #endregion

    #region AddClientInfo
    [WebMethod]
    public static void Add_ClientInfo(string client_name, string client_address, string client_dept, string client_designation, string client_email,
        string Client_mobile, string client_phone, string city_id, string comp_id)
    {
        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionstring2"].ToString()))
        {
            DataTable dt = new DataTable();
            DataSet ds = new DataSet();
            cn.Open();
            string query = "Insert INTO client (client_name , client_address , client_dept,client_designation,client_email," +
                            "Client_mobile,client_phone,city_id,comp_id) Values ('" + client_name + "','" + client_address + "','" + client_dept + "'," +
                            "'" + client_designation + "','" + client_email + "','" + Client_mobile + "','" + client_phone + "'," + city_id + "," +
                            "" + comp_id + ")";
            SqlCommand cmd = new SqlCommand(query, cn);
            cmd.ExecuteNonQuery();
        }
    }
    #endregion

    #region SendEmail
    [WebMethod]
    public static void SendEmail(string CompName, string ClientName, string CallType, string ClientResponse, string TotalAmt, string Remarks)
    {
        try
        {
            MailMessage sms = new MailMessage();
            sms.To = "ceo@mechatronix.com.pk";
            sms.From = "info@mechatronix.com.pk";
            sms.Cc = "ceo@mechatronix.com.pk";
            sms.Subject = UserFullName + " - Visit Added!";
            sms.Body = "MCTX Visit Details" + Environment.NewLine + Environment.NewLine +
                       "This is System Generated Email Please don not Reply!" + Environment.NewLine + Environment.NewLine +
                       "Visit Date          :       " + CurrentDate + Environment.NewLine +
                       "Visited By          :       " + UserFullName + Environment.NewLine +
                       "Visit Type          :       " + CallType + Environment.NewLine +
                       "IP Address          :       " + IPAddress + Environment.NewLine +
                       "Client Response     :       " + ClientResponse + Environment.NewLine +
                       "Company Name        :       " + CompName + Environment.NewLine +
                       "Sales Amount        :       " + "Rs. " + TotalAmt + Environment.NewLine + Environment.NewLine +
                       "Remarks             :       " + Environment.NewLine +
                       "------------------" + Environment.NewLine +
                       "" + Remarks + "" + Environment.NewLine + Environment.NewLine +
                       "This is System Generated Email Please do not Reply!";

            SmtpMail.SmtpServer = "mail.mechatronix.com.pk";
            SmtpMail.Send(sms);
        }
        catch (Exception ex)
        {

        }

    }
    #endregion

}

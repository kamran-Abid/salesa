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
using Sales_BOL;
using System.Runtime.Serialization.Json;
using System.Web.Script.Serialization;
using System.Web.Services;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Text;
using System.Net.Mail;


public partial class MCTX_Internal_SuperAdmin_frmProspectingList : System.Web.UI.Page
{
    static string user = "";

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

    #region Variables
    _ProspectingList objPros = new _ProspectingList();
    DataTable dt = new DataTable();
    #endregion

    #region Methods
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
                ddlEmployees.DataSource = dtEmp;
                ddlEmployees.DataTextField = "E_Name";
                ddlEmployees.DataValueField = "User_Id";
                ddlEmployees.DataBind();
                ddlEmployees.Items.Insert(0, "");
            }
        }
        catch (Exception)
        {
            //throw;
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
    public void LoadCompanies()
    {
        try
        {
            using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionstring2"].ToString()))
            {
                SqlCommand cmdEmp = new SqlCommand("select comp_id,comp_name from tbl_company where isnull(deleted,0)<>1 order by 2", cn);
                cn.Open();
                SqlDataAdapter daEmp = new SqlDataAdapter(cmdEmp);
                DataTable dtEmp = new DataTable();
                daEmp.Fill(dtEmp);
                ddlCompanyName_Prospecting.DataSource = dtEmp;
                ddlCompanyName_Prospecting.DataTextField = "comp_name";
                ddlCompanyName_Prospecting.DataValueField = "comp_id";
                ddlCompanyName_Prospecting.DataBind();
                ddlCompanyName_Prospecting.Items.Insert(0, "");

                ddlCompanyName_Client.DataSource = dtEmp;
                ddlCompanyName_Client.DataTextField = "comp_name";
                ddlCompanyName_Client.DataValueField = "comp_id";
                ddlCompanyName_Client.DataBind();
                ddlCompanyName_Client.Items.Insert(0, "");
            }
        }
        catch (Exception)
        {
            //throw;
        }
    }
    public void GetCityS()
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

    #endregion

    #region Events
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {

            //if (Profile.UserID== null)
            //{
            //    Response.Redirect("../../MCTX_General/Login.aspx");
            //    return;
            //}
            //if (Session["Username"].ToString() != "" && Session["Username"].ToString() != null)
            //{
            //    Session.Timeout = 60;
            //}
            //else
            //{
            //    Response.Redirect("../../MCTX_General/Login.aspx");
            //    return;
            //}
        }
        catch (Exception)
        {
            //Response.Redirect("../../MCTX_General/Login.aspx");
        }

        if (!IsPostBack)
        {
            //user = Session["Username"].ToString();
            //user = Profile.UserID;
            LoadEmp();
            LoadCountries();
            LoadCompanies();
            GetCityS();
        }
    }
    #endregion
    protected void btn_add_Click(object sender, EventArgs e)
    {
        // Page.ClientScript.RegisterStartupScript(this.GetType(), "op", "window.open ('frmAddPropecting.aspx', null,'top=1,left=1,center=yes,resizable=no,Width=550px,Height= 600px,status=no,titlebar=no;toolbar=no,menubar=no,location=0,scrollbars=yes');", true);
    }

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
            cmd.Parameters.Add("@CreatedBy", user);
            cmd.Parameters.Add("@CreatedDate", Date);
            cmd.Parameters.Add("@ModBy", "");
            cmd.Parameters.Add("@ModDate", "");
            cmd.Parameters.Add("@Deleted", false);
            cmd.Connection = cn;
            cn.Open();
            cmd.ExecuteNonQuery();
        }
    }
    #endregion

    #region webmethods by Obaid Altaf
    [WebMethod]
    public static Dictionary<string, object> GetProspects(string FromDate, string ToDate, string EmployeeId)
    {
        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionstring2"].ToString()))
        {
            DataTable dt = new DataTable();
            DataSet ds = new DataSet();
            cn.Open();
            string query = "select top 200 com.comp_name, cl.client_name, cl.client_designation," +
               "client_phone,pr.Target_products,convert(Varchar(10),pr.booking_date,101) as Bookingdate," +
               "convert(Varchar(10),pr.Reserverd_date,101) as reserverddate ,pr.visit_status,te.E_Name " +
               "from tbl_prospecting as pr " +
               "Join tbl_company as com on pr.comp_id = com.comp_id " +
               "Join client as cl on pr.client_id = cl.client_id " +
               "Join user1 as u on pr.user_id = u.user_id " +
               "Join tbl_employee as te on u.E_badge = te.E_badge " +
               "where cl.client_name <> '' ";

            if (FromDate != "" && ToDate != "")
            {
                query += " and convert(Varchar(20),pr.booking_date,101) between '" + FromDate + "' and '" + ToDate + "'";
            }

            if (EmployeeId != "")
            {
                query += " and u.user_id ='" + EmployeeId + "'";
            }
            query += "order by pr.Prospecting_id desc";
            SqlCommand cmd = new SqlCommand(query, cn);
            SqlDataAdapter ad = new SqlDataAdapter(cmd);
            ad.Fill(ds, "Prospects");
            dt = ds.Tables["Prospects"];
            return ToJson(dt);
        }
    }

    [WebMethod]
    public static Dictionary<string, object> LoadCity_Company(string countryid)
    {
        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionstring2"].ToString()))
        {
            DataTable dt = new DataTable();
            DataSet ds = new DataSet();
            cn.Open();
            SqlCommand cmd = new SqlCommand("select * from city where isnull(deleted,0)<>1 and country_id= " + countryid + " order by 2", cn);
            SqlDataAdapter ad = new SqlDataAdapter(cmd);
            ad.Fill(ds, "City_Company");
            dt = ds.Tables["City_Company"];
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

    [WebMethod]
    public static Dictionary<string, object> Load_Companies()
    {
        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionstring2"].ToString()))
        {
            DataTable dt = new DataTable();
            DataSet ds = new DataSet();
            cn.Open();
            SqlCommand cmd = new SqlCommand("select comp_id,comp_name from tbl_company where isnull(deleted,0)<>1 order by 2", cn);
            SqlDataAdapter ad = new SqlDataAdapter(cmd);
            ad.Fill(ds, "Companies");
            dt = ds.Tables["Companies"];
            return ToJson(dt);
        }
    }


    [WebMethod]
    public static Dictionary<string, object> LoadClients_Prospecting(string Comp_id)
    {
        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionstring2"].ToString()))
        {
            if (Comp_id == string.Empty)
            {
                Comp_id = "0";
            }
            DataTable dt = new DataTable();
            DataSet ds = new DataSet();
            cn.Open();
            SqlCommand cmd = new SqlCommand("select client_id, client_name from client where comp_id=" + Comp_id + " and isnull(deleted,0)<>1 order by 2", cn);
            SqlDataAdapter ad = new SqlDataAdapter(cmd);
            ad.Fill(ds, "Client_List_Prospecting");
            dt = ds.Tables["Client_List_Prospecting"];
            return ToJson(dt);
        }
    }

    [WebMethod]
    public static void Add_Prospecting(string Target_products, string Booking_date, string Reserverd_date, string client_id, string comp_id, string Cat_Id, string Product_Id)
    {
        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionstring2"].ToString()))
        {
            DataTable dt = new DataTable();
            DataSet ds = new DataSet();
            cn.Open();
            string query = "insert into tbl_prospecting(Target_products,Visit_Status,Booking_date," +
            "Reserverd_date,client_id,comp_id,user_id,Category_Id,Product_Id)Values('" + Target_products + "'," +
            "'Pending','" + Booking_date + "','" + Reserverd_date + "'," + client_id + "," + comp_id + ",'" + user + "'," + Cat_Id + "," + Product_Id + ")";
            SqlCommand cmd = new SqlCommand(query, cn);
            cmd.ExecuteNonQuery();
            Sendemail();
        }
    }

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

    [WebMethod]
    public static Dictionary<string, object> Load_CategoriesDDL()
    {
        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionstring2"].ToString()))
        {
            SqlCommand cmd = new SqlCommand("select cat_id,cat_name from tbl_category where isnull(deleted,0)<>1 order by 2", cn);
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

    public static void Sendemail()
    {
        DataTable dt = new DataTable();
        DataTable dtEmp = new DataTable();
        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionstring2"].ToString()))
        {
            DataSet ds = new DataSet();
            cn.Open();
            string query = "select top 1 com.comp_name, cl.client_name, cl.client_designation, " +
                            "client_phone,pr.Target_products,convert(Varchar(10),pr.booking_date,101) as Bookingdate, " +
                            "convert(Varchar(10),pr.Reserverd_date,101) as reserverddate ,pr.visit_status,te.E_Name, te.E_Email, " +
                            " te.reporting_person_id from tbl_prospecting as pr " +
                            "Join tbl_company as com on pr.comp_id = com.comp_id " +
                            "Join client as cl on pr.client_id = cl.client_id " +
                            "Join user1 as u on pr.user_id = u.user_id " +
                            "Join tbl_employee as te on u.E_badge = te.E_badge " +
                            "where cl.client_name <> '' " +
                            "and u.user_id ='" + user + "' " +
                            "order by pr.Prospecting_id desc";
            SqlCommand cmd = new SqlCommand(query, cn);
            SqlDataAdapter ad = new SqlDataAdapter(cmd);
            ad.Fill(ds, "ProspectForEmail");
            dt = ds.Tables["ProspectForEmail"];


            
            string query2 = "select te.e_email from tbl_employee te "+
                            " join user1 u on te.E_badge= u.E_badge"+
                            " where u.user_id='" + dt.Rows[0]["reporting_person_id"].ToString() + "'";
            SqlCommand cmd1 = new SqlCommand(query2, cn);
            SqlDataAdapter ad1 = new SqlDataAdapter(cmd1);
            ad1.Fill(dtEmp);
        }

        StringBuilder sb = new StringBuilder();
        sb.Append("<table width='770' cellspacing='0' cellpadding='0' border='0' align='center' style='border: 0px;" +
        "border-left: 1px solid #cccccc; border-right: 1px solid #cccccc; background-color: #ffffff'" +
        "class='ecxouter frame'>" +
        "<tbody>" +
            "<tr>" +
               " <td>" +
                    "<a target='_blank' style='border: none; color: #0084b4; text-decoration: none' href='www.mechatronix.com.pk'>" +
                        "<span class='ecxmedia_logo_div'></span></a>" +
                    "<table width='770' cellspacing='0' cellpadding='0' border='0' style='background-color: #f2f2f2' " +
                        "class='header frame'> " +
                        "<tbody>" +
                            "<tr>" +
                               " <td style='width: 19px; height: 77px' class='ecxheader_left ecxcut'> " +
                               " </td>" +
                                "<td width='46' valign='top' height='94' style='background-color: #ffffff; line-height: 100%'" +
                                   " class='ecxlogo_header ecxcut' rowspan='2'>" +
                                  "  <a target='_blank' style='border: none; color: #0084b4; text-decoration: none' href='www.mechatronix.com.pk'>" +
                                     "   <img width='46' height='94' style='border: 0; background-color: #fff; line-height: 100%;" +
                                    "       border: 0' src='http://www.mechatronix.com.pk/salesbeta/images1/LogoEmail.png' class='ecxlogo ecxcut'></a>" +
                                "</td>" +
                                "<td width='10' class='ecxcut'>" +
                                "</td>" +
                                "<td width='588' height='77' style='padding-left: 10px; padding-right: 10px; font-family: 'Helvetica Neue', Helvetica, Arial, sans-serif;" +
                                   " color: #333333' class='ecxmain_header ecxmedia_header'>" +
                                    "<span style='font-size: 14px; line-height: 16px; font-weight: bold; color: #000000'" +
                                       "  class='ecxmain_name'>New Prospect by "+user+",</span>" +
                                "</td>" +
                                "<td width='32' style='text-align: right; padding-right: 10px' class='ecxmain_avatar ecxcut'>" +
                                    "" +
                                "</td>" +
                                "<td style='width: 75px; background-color: #f2f2f2' class='col header ecxcut'>" +
                                " </td>" +
                            "</tr>" +
                            "<tr>" +
                                "<td style='border-top: 1px solid #dddddd; background-color: #ffffff' class='ecxmain ecxheader_drop ecxcut'>" +
                                   " &nbsp;" +
                                "</td>" +
                                "<td style='border-top: 1px solid #dddddd; background-color: #ffffff' class='ecxmain ecxheader_drop ecxcut'>" +
                                   " &nbsp;" +
                                "</td>" +
                                "<td height='17' style='border-top: 1px solid #dddddd; background-color: #ffffff'" +
                                  "  class='ecxmain ecxheader_drop ecxmedia_header'>" +
                                   " <img width='1' height='1' src='http://mechatronix.com.pk/images/Mechatronix.png'" +
                                       " style='display: block; border: 0'>" +
                                "</td>" +
                                "<td height='17' style='border-top: 1px solid #dddddd; background-color: #ffffff'" +
                                "    colspan='2' class='ecxmain ecxheader_drop ecxcut'>" +
                                "    &nbsp;" +
                                "</td>" +
                           " </tr>" +
                       " </tbody>" +
                    "</table>" +
               " </td>" +
               " <td rowspan='3'>" +
               " </td>" +
            "</tr>" +
           " <tr>" +
               " <td>" +
                "    <table width='770' cellspacing='0' cellpadding='0' border='0' style='background-color: #ffffff'" +
                      "  class='ecxmain frame'>" +
                       " <tbody>" +
                         "   <tr>" +
                         "       <td style='width: 40px' class='col ecxcut'>" +
                           "     </td>" +
                            "    <td class='ecxmedia_main'>" +
                               "     <table cellspacing='0' cellpadding='0' border='0'>" +
                             "           <tbody>" +
                                            "<tr>" +
                                              "<td style='padding: 10px; font-family: Calibri,'Helvetica Neue', Helvetica, Arial, sans-serif;" +
                                                "  color: #333333; padding-bottom: 0; font-size: 15px; line-height: 20px' class='ecxmid ecxtext'> " +
                                                "<table> <tr> " +
                                                "<td><strong>Prospect by: </strong>" +
                                                "</td>" +
                                                "<td>" +
                                                "" + dt.Rows[0]["E_Name"].ToString() + "</br> \r" +
                                                "</td>" +
                                                "</tr>" +

                                                "<tr>" +
                                                "<td><strong>Email: </strong>" +
                                                "</td>" +
                                                "<td>" +
                                                "" + dt.Rows[0]["E_Email"].ToString() + "</br> \r" +
                                                "</td>" +
                                                "</tr>" +

                                                "<tr>" +
                                                "<td><strong>Company: </strong>" +
                                                "</td>" +
                                                "<td>" +
                                                "" + dt.Rows[0]["comp_name"].ToString() + "</br> \r" +
                                                "</td>" +
                                                "</tr>" +

                                                "<tr>" +
                                                "<td><strong>Client: </strong>" +
                                                "</td>" +
                                                "<td>" +
                                                "" + dt.Rows[0]["client_name"].ToString() + "</br>" +
                                                "</td>" +
                                                "</tr>" +

                                                "<tr>" +
                                                "<td><strong>Client Designation: </strong>" +
                                                "</td>" +
                                                "<td>" +
                                                "" + dt.Rows[0]["client_designation"].ToString() + "</br>" +
                                                "</td>" +
                                                "</tr>" +

                                                "<tr>" +
                                                "<td><strong>Client Phone No: </strong>" +
                                                "</td>" +
                                                "<td>" +
                                                "" + dt.Rows[0]["client_phone"].ToString() + "</br>" +
                                                "</td>" +
                                                "</tr>" +

                                                "<tr>" +
                                                "<td><strong>Target Product(s): </strong>" +
                                                "</td>" +
                                                "<td>" +
                                                "" + dt.Rows[0]["Target_products"].ToString() + "</br>" +
                                                "</td>" +
                                                "</tr>" +

                                                "<tr>" +
                                                "<td><strong>Booking Date: </strong>" +
                                                "</td>" +
                                                "<td>" +
                                                "" + dt.Rows[0]["Bookingdate"].ToString() + "</br>" +
                                                "</td>" +
                                                "</tr>" +

                                                "<tr>" +
                                                "<td><strong>Reserve Date: </strong>" +
                                                "</td>" +
                                                "<td>" +
                                                "" + dt.Rows[0]["reserverddate"].ToString() + "</br>" +
                                                "</td>" +
                                                "</tr>" +

                                                "<tr>" +
                                                "<td><strong>Time: </strong>" +
                                                "</td>" +
                                                "<td>" +
                                                "" + DateTime.Now.ToShortTimeString() + "</br>" +
                                                "</td>" +
                                                "</tr>" +

                                                "<tr>" +
                                                "<td><strong>Visit Status: </strong>" +
                                                "</td>" +
                                                "<td>" +
                                                "" + dt.Rows[0]["visit_status"].ToString() + "</br>" +
                                                "</td>" +
                                                "</tr>" +

                                                "</table>" +
                                                "</td>" +
                                            " </tr>" +
                                            " <tr>" +
                                            "     <td height='20'>" +
                                             "    </td>" +
                                           "  </tr>" +
                                      "   </tbody>" +
                                  "   </table>" +
                               "  </td>" +
                              "   <td style='width: 50px' class='col ecxcut'>" +
                               "  </td>" +
                            " </tr>" +
                       "  </tbody>" +
                   "  </table>" +
               "  </td>" +
           "  </tr>" +
           "  <tr>" +
            "     <td>" +
                  "   <table width='770' cellspacing='0' cellpadding='0' border='0' style='background-color: #eeeeee'" +
                     "    class='frame footer'>" +
                     "    <tbody>" +
                        "     <tr>" +
                            "     <td height='28' style='border-top: 1px solid #dddddd' class='ecxfooter-padding-top'" +
                            "         colspan='3'>" +
                             "    </td>" +
                          "   </tr>" +
                           "  <tr>" +
                             "    <td style='width: 75px' class='col ecxcut'>" +
                             "    </td>" +
                              "   <td style='font-family: 'Helvetica Neue', Helvetica, Arial, sans-serif; font-size: 12px;" +
                                "     line-height: 17px; color: #777; text-shadow: 0 1px 0 #ffffff' class='ecxfooter_body ecxmedia_footer'>" +
                                 "    <div>" +
                                    "     Mechatronix <a target='_blank' style='border: none; color: #0084b4;" +
                                     "        text-decoration: none' href='www.mechatronix.com.pk'" +
                                      "       class='ecxreset'>Get the detailed information about the company.</a>" +
                                    " </div>" +
                                   "  <div>" +
                                   "      <span style='border: none; color: #0084b4; text-decoration: none; font-family: 'Helvetica Neue', Helvetica, Arial, sans-serif;" +
                                    "         text-decoration: none; font-size: 11px; line-height: 17px; color: #999999; text-shadow: 0 1px 0 #ffffff'" +
                                    "         class='address'>Mechatronix, Head office: Off# 7-9, 3rd Floor, Mujahid Plaza,Blue Area, Jinnah Avenue, <span style='white-space: nowrap'" +
                                    "             class='ecxnobreak'>Islamabad, Pakistan.</span></span>" +
                                   "  </div>" +
                               "  </td>" +
                               "  <td style='width: 75px' class='col ecxcut'>" +
                              "   </td>" +
                           "  </tr>" +
                          "   <tr>" +
                             "    <td height='25' class='ecxfooter-padding-bottom' colspan='3'>" +
                              "   </td>" +
                            " </tr>" +
                        " </tbody>" +
                   "  </table>" +
                " </td>" +
          "   </tr>" +
        "</tbody>" +
    " </table>");

        MailMessage mail = new MailMessage();
        mail.From = new MailAddress("info@mechatronix.com.pk");
        if (dtEmp.Rows.Count > 0)
        {
            mail.To.Add("obaidaltaf@mechatronix.com.pk");
            //mail.To.Add(dtEmp.Rows[0]["e_email"].ToString());
        }
        else
        {
            mail.To.Add("obaidaltaf@mechatronix.com.pk");
            //mail.To.Add("info@mechatronix.com.pk");
        }
        //mail.CC.Add("ceo@mechatronix.com.pk");
        //mail.Bcc.Add("obaidaltaf@mechatronix.com.pk");
        
        mail.Subject = "Test Prospect Added by " + user;
        mail.Body = sb.ToString();
        mail.IsBodyHtml = true;
        SmtpClient smtp = new SmtpClient();
        smtp.Host = "mail.mechatronix.com.pk";
        System.Net.NetworkCredential BasicAuthenticationInfo = new System.Net.NetworkCredential("info@mechatronix.com.pk", "manager");
        smtp.Timeout = 200000;
        smtp.UseDefaultCredentials = false;
        smtp.Credentials = BasicAuthenticationInfo;
        smtp.EnableSsl = false;
        smtp.Send(mail);
    }
    #endregion
}

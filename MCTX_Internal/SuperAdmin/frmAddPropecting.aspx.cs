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
using System.Data.SqlClient;

public partial class MCTX_Internal_GeneralUser_frmAddPropecting : System.Web.UI.Page
{


    _Company objcompany = new _Company();
    _Clients objCL = new _Clients();
    _ProspectingList objpros = new _ProspectingList();

    string country = "";
    int countryid = 0;
    string city = "";
    int cityid = 0;

    protected void Page_Load(object sender, EventArgs e)
    {

        try
        {
            if (Session["Username"].ToString() == "logout")
            {
                Response.Redirect("../../MCTX_General/Login.aspx");
                return;
            }


        }
        catch (Exception ex)
        {
            Response.Redirect("../../MCTX_General/Login.aspx");

        }


        if (!IsPostBack)
        {
            try
            {

                GetCompanies();
                GetItems();
                GetCountries();
                getcountires();
                GetCompanies_pros();
                ddlcompanyname3_SelectedIndexChanged(null, null);
                ddlCountry1_SelectedIndexChanged(null, null);

            }
            catch (Exception ex)
            { }
            //ddlCity.Items[0].Text = "--Select--";
        }

    }

    public void getcountires()
    {
        objcompany.Bolgetcountries();
        for (int i = 0; i < objcompany.ALcountries.Count; i++)
        {
            ddlCountry.Items.Add(objcompany.ALcountries[i].ToString());
            //ddlCountry.Items[0].Text = "--Select--";
        }

        refreshcities();


    }
    public void getcities(int countid)
    {
        objcompany.Bolgetcities(countid);
        for (int i = 0; i < objcompany.ALcities.Count; i++)
        {
            ddlCity.Items.Add(objcompany.ALcities[i].ToString());
            //ddlCity.Items[0].Text = "--Select--";
        }

    }
    public void GetItems()
    {
        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionstring2"].ToString()))
        {

            SqlCommand cmd = new SqlCommand("SELECT item_id,item_name from tbl_item where Deleted  = 0 order by item_name asc", cn);
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);
            ddlTarProd.DataSource = dt;
            ddlTarProd.DataValueField = "item_id";
            ddlTarProd.DataTextField = "item_name";
            ddlTarProd.DataBind();
            ddlTarProd.Items.Insert(0, "");
        }
    }


    protected void btn_addcomp_Click(object sender, EventArgs e)
    {
        addclient.Visible = false;
        addcomp.Visible = true;
    }
    protected void btn_cancel_Click(object sender, EventArgs e)
    {
        addcomp.Visible = false;
        //txt_compname.Text = "";
        //txt_compname.Text = "";
        //txt_compadd.Text = "";
        //txt_compcountry.Text = "";
        //txt_compcity.Text = "";
        //txt_compphone.Text = "";

    }
    protected void btn_cancel0_Click(object sender, EventArgs e)
    {
        addclient.Visible = false;
    }


    protected void btn_addclient_Click(object sender, EventArgs e)
    {
        addcomp.Visible = false;
        addclient.Visible = true;
    }
    protected void btn_save_Click(object sender, EventArgs e)
    {
        if (!validate_company())
        {
            return;

        }

        try
        {

            country = ddlCountry.Text.Substring(0, ddlCountry.Text.IndexOf("-"));
            countryid = int.Parse(country);

            city = ddlCity.Text.Substring(0, ddlCity.Text.IndexOf("-"));
            cityid = int.Parse(city);

            string products = "Nil";


            if (objpros.company_alreadyExist(txt_compname.Text))
            {
                lbl_Msg.Visible = true;
                lbl_Msg.ForeColor = System.Drawing.Color.Red;
                lbl_Msg.Text = "*Company already exist";
                return;
            }

            DateTime date = DateTime.Now;
            string curdate = date.Month.ToString() + "/" + date.Day.ToString() + "/" + date.Year.ToString();
            int inserted = 0;
            inserted = objcompany.insert_companyinfo(txt_compname.Text, txt_compwebadd.Text,
                countryid, cityid, txt_compphone.Text, txt_add.Text,
                products, curdate, Session["Username"].ToString());

            if (inserted == 1)
            {
                lbl_Msg.Visible = true;
                lbl_Msg.ForeColor = System.Drawing.Color.Green;
                lbl_Msg.Text = "*Record saved successfully";
                GetCompanies();
                GetCompanies_pros();
            }
            else
            {
                lbl_Msg.Visible = true;
                lbl_Msg.ForeColor = System.Drawing.Color.Red;
                lbl_Msg.Text = "*Unable to save record";

            }
        }
        catch (Exception ex)
        {
            lbl_Msg.Visible = true;
            lbl_Msg.ForeColor = System.Drawing.Color.Red;
            lbl_Msg.Text = ex.Message.ToString();

        }




    }
    protected void ddlCountry_SelectedIndexChanged(object sender, EventArgs e)
    {
        refreshcities();

    }
    public void refreshcities()
    {
        try
        {
            ddlCity.Items.Clear();
            country = ddlCountry.Text.Substring(0, ddlCountry.Text.IndexOf("-"));
            countryid = int.Parse(country);
            getcities(countryid);
            city = ddlCity.Text.Substring(0, ddlCity.Text.IndexOf("-"));
            cityid = int.Parse(city);
        }
        catch (Exception ex)
        {

            lbl_Msg.Visible = true;
            lbl_Msg.ForeColor = System.Drawing.Color.Red;
            lbl_Msg.Text = ex.Message.ToString();

        }

    }

    public void GetCompanies()
    {
        objCL.fngetcompanies();
        ddlCompanyName.DataSource = objCL.DT_Companies;
        ddlCompanyName.DataValueField = "comp_id";
        ddlCompanyName.DataTextField = "comp_name";
        ddlCompanyName.DataBind();
        //ddlCompanyName.Items.Insert(0, "-- Select --");
    }
    public void GetCountries()
    {
        objCL.fngetCountries();
        ddlCountry1.DataSource = objCL.DT_Countries;
        ddlCountry1.DataValueField = "country_id";
        ddlCountry1.DataTextField = "country_name";
        ddlCountry1.DataBind();
        //ddlCountry1.Items.Insert(0, "-- Select --");
    }
    public void GetCities(int c_id)
    {
        objCL.fngetCities(c_id);
        ddlCity1.DataSource = objCL.DT_Cities;
        ddlCity1.DataValueField = "city_id";
        ddlCity1.DataTextField = "city_name";
        ddlCity1.DataBind();
        //ddlCity1.Items.Insert(0, "-- Select --");
    }


    public bool validate_company()
    {
        if (txt_compname.Text == "")
        {
            lbl_Msg.Visible = true;
            lbl_Msg.ForeColor = System.Drawing.Color.Red;
            lbl_Msg.Text = "Please enter company name";
            return false;
        }
        if (txt_compphone.Text == "")
        {
            lbl_Msg.Visible = true;
            lbl_Msg.ForeColor = System.Drawing.Color.Red;
            lbl_Msg.Text = "Please enter company phone no";
            return false;
        }
        lbl_Msg.Text = "";
        return true;

    }
    protected void btn_saveclient_Click(object sender, EventArgs e)
    {
        if (!validateclient())
        {
            return;
        }
        string address = "Nil";
        string faxno = "Nil";
        try
        {
            int inserted = objCL.fnInsertClient(txtclientname.Text, address, txtclientdept.Text, txtclientdesignation.Text, txtclientemail.Text, faxno, txtclientmobno.Text, txtclientphone.Text, int.Parse(ddlCity1.SelectedValue), int.Parse(ddlCountry1.SelectedValue), int.Parse(ddlCompanyName.SelectedValue));
            if (inserted == 1)
            {
                //lblmessage.Visible = true;
                lbl_Msg0.ForeColor = System.Drawing.Color.Green;
                lbl_Msg0.Text = "*Record saved successfully";
                ddlcompanyname3_SelectedIndexChanged(null, null);
            }
            else
            {
                //lblmessage.Visible = true;
                lbl_Msg0.ForeColor = System.Drawing.Color.Red;
                lbl_Msg0.Text = "*Unable to save record";
            }

        }
        catch (Exception ex)
        { }


    }
    public bool validateclient()
    {
        if (txtclientname.Text == "")
        {
            lbl_Msg0.Visible = true;
            lbl_Msg0.ForeColor = System.Drawing.Color.Red;
            lbl_Msg0.Text = "Please enter client name";
            return false;
        }
        if (txtclientmobno.Text == "")
        {
            lbl_Msg0.Visible = true;
            lbl_Msg0.ForeColor = System.Drawing.Color.Red;
            lbl_Msg0.Text = "Please enter client mobile phone";
            return false;
        }
        if (ddlCompanyName.Text == "")
        {
            lbl_Msg0.Visible = true;
            lbl_Msg0.ForeColor = System.Drawing.Color.Red;
            lbl_Msg0.Text = "Please select client company name";
            return false;
        }
        if (ddlCountry1.Text == "-- Select --")
        {
            lbl_Msg0.Visible = true;
            lbl_Msg0.ForeColor = System.Drawing.Color.Red;
            lbl_Msg0.Text = "Please select client country name";
            return false;

        }
        if (ddlCity1.Text == "" || ddlCity1.Text == "-- Select --")
        {
            lbl_Msg0.Visible = true;
            lbl_Msg0.ForeColor = System.Drawing.Color.Red;
            lbl_Msg0.Text = "Please select client city name";
            return false;

        }
        lbl_Msg0.Text = "";
        return true;

    }
    protected void ddlCountry1_SelectedIndexChanged(object sender, EventArgs e)
    {
        string country = ddlCountry1.SelectedValue;
        int c_id = int.Parse(country);
        GetCities(c_id);
        //ViewState["Country_id"] = c_id;
    }

    public void GetCompanies_pros()
    {
        try
        {
            objCL.fngetcompanies();
            ddlcompanyname3.DataSource = objCL.DT_Companies;
            ddlcompanyname3.DataValueField = "comp_id";
            ddlcompanyname3.DataTextField = "comp_name";
            ddlcompanyname3.DataBind();
            //ddlcompanyname3.Items.Insert(0, "-- Select --");
            txt_todaydate.Text = objCL.DT_Companies.Rows[0][2].ToString();
            DateTime today = DateTime.Parse(txt_todaydate.Text);
            DateTime reserverdate = today.AddDays(int.Parse(txt_reserveddays.Text));
            txt_reserverdate.Text = reserverdate.ToShortDateString();
        }
        catch (Exception ex)
        {
            lbl_Msg1.Visible = true;
            lbl_Msg1.ForeColor = System.Drawing.Color.Red;
            lbl_Msg1.Text = ex.Message.ToString(); ;

        }
    }





    protected void ddlcompanyname3_SelectedIndexChanged(object sender, EventArgs e)
    {
        string company = ddlcompanyname3.SelectedValue;
        int c_id = int.Parse(company);
        getclients(c_id);
    }

    public void getclients(int compid)
    {
        objpros.BOlgetclient(compid);
        ddlClient.DataSource = objpros.dt_clients;
        ddlClient.DataValueField = "client_id";
        ddlClient.DataTextField = "client_name";
        ddlClient.DataBind();
        //ddlClient.Items.Insert(0, "-- Select --");


    }

    protected void btn_submit_Click(object sender, EventArgs e)
    {

        addcomp.Visible = false;
        addclient.Visible = false;

        if (ddlTarProd.SelectedItem.Text == "")
        {
            lbl_Msg1.Visible = true;
            lbl_Msg1.ForeColor = System.Drawing.Color.Red;
            lbl_Msg1.Text = "Please enter target products";
            return;
        }

        if (ddlClient.Text == "")
        {
            ddlClient.Items.Add("21");
            ddlClient.SelectedValue = "21";

            //lbl_Msg1.Visible = true;
            //lbl_Msg1.ForeColor = System.Drawing.Color.Red;
            //lbl_Msg1.Text = "Please select client";
            //return;
        }

        try
        {
            string user = (string)Session["Username"];
            int clientidi = int.Parse(ddlClient.SelectedValue);
            //if (clientidi.ToString() != "")
            //{
            int companyidi = int.Parse(ddlcompanyname3.SelectedValue);
            //}
            //else
            //{ 
            if (objpros.isalreadyBooked(companyidi.ToString()))
            {
                lbl_Msg1.Visible = true;
                lbl_Msg1.ForeColor = System.Drawing.Color.Red;
                lbl_Msg1.Text = "Company is already booked";
                return;

            }

            //}
            int inserted = objpros.addProspecting(ddlTarProd.SelectedItem.Text, txt_todaydate.Text,
                txt_reserverdate.Text, clientidi, companyidi, user);

            if (inserted == 1)
            {
                lbl_Msg1.Visible = true;
                lbl_Msg1.ForeColor = System.Drawing.Color.Green;
                lbl_Msg1.Text = "Record saved successfully";
                ddlTarProd.SelectedIndex = 0;


            }
            else
            {

                lbl_Msg1.Visible = true;
                lbl_Msg1.ForeColor = System.Drawing.Color.Red;
                lbl_Msg1.Text = "Error in saving record";
            }
        }
        catch (Exception ex)
        {
            lbl_Msg1.Visible = true;
            lbl_Msg1.ForeColor = System.Drawing.Color.Red;
            lbl_Msg1.Text = ex.Message.ToString(); ;
        }
    }
}

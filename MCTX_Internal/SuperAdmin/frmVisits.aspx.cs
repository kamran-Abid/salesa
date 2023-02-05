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
using System.Web.Mail;
using Sales_BOL;
using System.Text.RegularExpressions;


public partial class MCTX_Internal_SuperAdmin_frmVisits : System.Web.UI.Page
{
    #region Variables
    _ProspectingList objpros = new _ProspectingList();
    _Clients objclients = new _Clients();
    _Visits objvisit = new _Visits();
    DataTable dt_items = new DataTable();
    DataRow dr = null;
    DataTable DT_VisitsData = new DataTable();
    //DataTable DT_VistsRecord = new DataTable();
    #endregion

    #region Methods
    public void GetClients(int compid)
    {
        objpros.BOlgetclient(compid);
        ddlClientName.DataSource = objpros.dt_clients;
        ddlClientName.DataValueField = "client_id";
        ddlClientName.DataTextField = "client_name";
        ddlClientName.DataBind();
    }
    public void GetCompanies()
    {
      objclients.fngetcompanies();
      ddlCompanyName.DataSource =  objclients.DT_Companies;
      ddlCompanyName.DataValueField = "comp_id";
      ddlCompanyName.DataTextField = "comp_name";
      ddlCompanyName.DataBind();
    }
    public void GetClientResponse()
    {
        objvisit.getClientResponse();
        ddlClientResponse.DataSource = objvisit.dt_clientresponse;
        ddlClientResponse.DataValueField = "response_id";
        ddlClientResponse.DataTextField = "response_name";
        ddlClientResponse.DataBind();
        
    }
    public void GetTypeofCalls()
    { 
        objvisit.getTypeofCalls();
        ddlTypeofCall.DataSource = objvisit.dt_typeofcalls;
        ddlTypeofCall.DataValueField = "tt_id";
        ddlTypeofCall.DataTextField = "tt_name";
        ddlTypeofCall.DataBind();
        
    }
    public void GetItemcategory()
    {
        objvisit.getItemcategories();
        ddlCategory.DataSource = objvisit.dt_Itemcategory;
        ddlCategory.DataValueField = "cat_id";
        ddlCategory.DataTextField = "cat_name";
        ddlCategory.DataBind();
    }
    public void GetItems(int c_id)
    {
        objvisit.BLGetItems(c_id);
        if (objvisit.dt_Items.Rows.Count > 0)
        {
            ddlItem.DataSource = objvisit.dt_Items;
            ddlItem.DataValueField = "item_id";
            ddlItem.DataTextField = "item_name";
            ddlItem.DataBind();
        }
        else
        {
            ddlItem.Items.Clear();
        }
    }
    public void GetClients()
    {
        //objvisit.GetClientsData();
        //GridView1.DataSource = objvisit.dt_Clients;
        //GridView1.DataBind();
    }
    public DataTable MakeTable()
    {
        // Adding New Table of Target Information
        DataTable dt = new DataTable();
        // Add new Columns
        dt.Columns.Add(new DataColumn("Category", typeof(string)));
        dt.Columns.Add(new DataColumn("Item Name", typeof(string)));
        dt.Columns.Add(new DataColumn("Sale Amount", typeof(string)));
        dt.Columns.Add(new DataColumn("cat_id", typeof(string)));
        dt.Columns.Add(new DataColumn("item_id", typeof(string)));
        return dt;
    }

    public int sumofprices()
    {
        int sum = 0;
        DataTable Dt_Visitsitemprices = (DataTable)ViewState["VisitData"];
        if (Dt_Visitsitemprices.Rows.Count > 0)
        {

            for (int i = 0; i < Dt_Visitsitemprices.Rows.Count; i++)
            {
                sum = sum + int.Parse(Dt_Visitsitemprices.Rows[i][2].ToString());
            }
        }
        return sum;
    }

    public int Validate(string item,string salesamount)
    {

        DataTable Dt_Visitsitem = (DataTable)ViewState["VisitData"];

        if (item == "")
        {
            lblMessage1.Text = "Please select item";
            lblMessage1.ForeColor = System.Drawing.Color.Red;
            return 0;
        }
        if (salesamount == "")
        {
            lblMessage1.Text = "Please enter item price";
            lblMessage1.ForeColor = System.Drawing.Color.Red;
            return 0;
        
        }
        if (Dt_Visitsitem.Rows.Count > 0)
        {

            for (int i = 0; i < Dt_Visitsitem.Rows.Count; i++)
            {
                if (Dt_Visitsitem.Rows[i][1].ToString() == item)
                {
                    lblMessage1.Text = "Item already added";
                    lblMessage1.ForeColor = System.Drawing.Color.Red;
                    return 0;
                }

            }
        }
        return 1;
        //if (category != "")
        //{
        //    if (IsAlphaNumeric(category))
        //        return 0;
        //    if (item != "")
        //    {
        //        if (IsAlphaNumeric(item))
        //            return 0;

        //        return 1;

        //    }
        //    return 0;
        //}
        //return 0;
    }
    // Function to test for Alphabets (Added By Awais)
    public bool IsAlpha(String strToCheck)
    {
        Regex objAlphaPattern = new Regex(@"^[a-zA-Z''-'\s]{1,40}$");
        return objAlphaPattern.IsMatch(strToCheck);
    }
    // Function to test for Positive Integers with zero inclusive(Added By Awais)
    public bool IsNumber(String strNumber)
    {
        Regex objNotWholePattern = new Regex("[^0-9]");
        return !objNotWholePattern.IsMatch(strNumber);
    }
    // Function to Check for AlphaNumeric.
    public bool IsAlphaNumeric(String strToCheck)
    {
        Regex objAlphaNumericPattern = new Regex("[^a-zA-Z0-9]");
        return !objAlphaNumericPattern.IsMatch(strToCheck);
    }
    public void BindGridAdd(DataTable dt)
    {
        GridView3.DataSource = dt;
        GridView3.DataBind();
    }
    public int ValidateFields(int compname,string clientName,int typeofcall,string Address,string clientresponse,string remarks,int category,int item,string amount)
    {
        return 1; 
    }
    public void SetData(DataTable dt)
    {
        try
        {
            // Setting Filds Values For Client
            txtMobile.Text = dt.Rows[0]["Client_mobile"].ToString();
            txtPhone.Text = dt.Rows[0]["client_phone"].ToString();
            txtDesignation.Text = dt.Rows[0]["client_designation"].ToString();
            txtFax.Text = dt.Rows[0]["client_fax"].ToString();
            txtCity.Text = dt.Rows[0]["city_name"].ToString();
            txtAddress.Text = dt.Rows[0]["client_address"].ToString();
            //txtCountry.Text = dt.Rows[0]["country_name"].ToString();
            txtDepartment.Text = dt.Rows[0]["client_dept"].ToString();
            txtCompName.Text = dt.Rows[0]["comp_name"].ToString();
            txtEmail.Text = dt.Rows[0]["client_email"].ToString();

            //string tip = "Company : " + dt.Rows[0]["Ccomp_name"].ToString();// +" Phone " + dt.Rows[0]["Client_mobile"].ToString();

            //           ddlClientName.ToolTip = tip; //"Client Mobile : " + txtMobile.Text = dt.Rows[0]["Client_mobile"].ToString()+"";// +"\n" +
            //    //"Client Company : " + txtCompName.Text = dt.Rows[0]["comp_name"].ToString();

        }
        catch (Exception ex)
        {
            lblMessage1.Text = ex.Message.ToString();
        }
    }
    public void clearfields()
    {
        txtMobile.Text = "";
        txtPhone.Text = "";
        txtDesignation.Text = "";
        txtFax.Text = "";
        txtCity.Text = "";
        txtAddress.Text = "";
        //txtCountry.Text = dt.Rows[0]["country_name"].ToString();
        txtDepartment.Text = "";
        txtCompName.Text = "";
        txtEmail.Text = "";

    }
    public void sendemail()
    {
        try
        {

            DateTime dattime = DateTime.Now;
            string dateandtime = dattime.ToLongDateString() + "  " + dattime.ToLongTimeString();
            MailMessage sms = new MailMessage();
            sms.To = "ceo@mechatronix.com.pk";
            sms.From = "info@mechatronix.com.pk";
            sms.Cc = "ceo@mechatronix.com.pk";
            sms.Subject = Session["UserFullName"].ToString() + " - Visit Added!";
            sms.Body = "MCTX Visit details .... " + Environment.NewLine + Environment.NewLine +
                       "This is System Generated Email Please don not Reply!" + Environment.NewLine + Environment.NewLine +
                       "Visit Date          :       " + dateandtime + Environment.NewLine +
                       "Visited By          :       " + Session["UserFullName"].ToString() + Environment.NewLine +
                       "Visit Type          :       " + ddlTypeofCall.SelectedItem.Text + Environment.NewLine +
                       "IP Address          :       " + userIpAddress() + Environment.NewLine +
                       "Client Response     :       " + ddlClientResponse.SelectedItem.Text + Environment.NewLine +
                       "Company Name        :       " + ddlCompanyName.SelectedItem.Text + Environment.NewLine +
                       "Client Name         :       " + ddlClientName.SelectedItem.Text + Environment.NewLine +
                       "Client Designation  :       " + txtDesignation.Text + Environment.NewLine +
                       "Client Mobile#      :       " + txtMobile.Text + Environment.NewLine +
                       "Client Phone#       :       " + txtPhone.Text + Environment.NewLine +
                       "Client Email        :       " + txtEmail.Text + Environment.NewLine +
                       "Sales Amount        :       " + "Rs. " + txtSaleAmount.Text + Environment.NewLine + Environment.NewLine +
                       "Remarks             :       " + Environment.NewLine +
                       "------------------" + Environment.NewLine +
                       "" + txtRemarks.Text + "" + Environment.NewLine +Environment.NewLine +
                       "This is System Generated Email Please do not Reply!";

            SmtpMail.SmtpServer = "mail.mechatronix.com.pk";
            SmtpMail.Send(sms);
            lblmsg.Text = " + E-Mail Sent....";
    
        }
        catch (Exception ex)
        {
            lblmsg.Text = " + " + ex.Message.ToString();
        }

    }

    public void MonthToDateSale()
    {
        string year = "";
        string month = "";
        string Date = DateTime.Now.ToShortDateString();
        string[] DateParts = Date.Split(new Char[] { '/' });
        for (int i = 0; i <= DateParts.Count(); i++)
        {
            if (i == 0)
            {
                month = DateParts[i];
            }
            if (i == 2)
            {
                year = DateParts[i];
                break;
            }
        }
        string datestart = month + "/01/" + year;
        try
        {
            lblMTDsalesamount.Text = objvisit.fnMonthToDateSale(datestart, Session["Username"].ToString());
        }
        catch (Exception ex)
        {
            lblMTDsalesamount.Text = "0";
        }
    }
    public bool check_reportTime()
    {
        int hh = DateTime.Now.Hour;

        if (hh == 8 || hh == 9 || hh == 16 || hh == 17 || hh == 18 || hh == 19)
        return true;

        return false;
    }
    public string userIpAddress()
    {
        string useripaddress = "";
        useripaddress = Request.UserHostAddress;
        return useripaddress;

    }


    #endregion

    #region Events
    protected void Page_Load(object sender, EventArgs e)
    {
        btnSave.Attributes.Add("onclick", "return validate()");

        try
        {
            if (Request.Cookies["userName"] == null)
            {
                
                Response.Redirect("../../MCTX_General/Login.aspx");
                return;
            }
            else
            {
                Session["Username"] = Request.Cookies["Username"].Value.ToString(); 
            }



        }
        catch (Exception ex)
        {
           // Response.Redirect("../../MCTX_General/Login.aspx");

        }


        if (check_reportTime())
        {
            btnSave.Enabled = true;
            lblmsg.Text = "";
        }
        else
        {
            btnSave.Enabled = false;
            lblmsg.Text = "*Report Time is 08:00AM to 10:00AM and 04:00PM to 08:00PM";
            lblmsg.ForeColor = System.Drawing.Color.Red;

        }
        
        if(!IsPostBack)
        {
           try
           {
                DataTable dt = new DataTable();
                DataTable dt2 = new DataTable();
                GetCompanies();
                ddlCompanyName_SelectedIndexChanged(null, null);
                GetClientResponse();
                GetTypeofCalls();
                GetItemcategory();
                ddlCategory_SelectedIndexChanged1(null, null);
                GetClients();
                dt = MakeTable();
                dt2 = MakeTable(); // for categoryIds;
                // Saving Data into ViewState
                ViewState["VisitData"] = dt;
                ViewState["VisitDataids"] = dt2;
                lblTotalSalesAmount.Text = objvisit.totalsales(Session["Username"].ToString()); 
                MonthToDateSale();
                upcomingvisits.Visible = true;
                showupcomingvisits();
                
           }
           catch(Exception ex)
           {
                
           }
        }
    }
    public void showupcomingvisits()
    {
        objvisit.getUpcomingvisits(Session["Username"].ToString());
        GridView_UCVisit.DataSource = objvisit.dt_upcoming_visits;
        GridView_UCVisit.DataBind();

        if (objvisit.dt_upcoming_visits.Rows.Count < 1)
        {
            emptyupcomingvisits.Visible = true;
        }
        else
        {
            emptyupcomingvisits.Visible = false;
        }

    }
    protected void ImageButton1_Click(object sender, ImageClickEventArgs e)
    {
        Response.Redirect("frmExcuse.aspx?Comp="+ddlCompanyName.SelectedValue);
    }
    protected void ddlCompanyName_SelectedIndexChanged(object sender, EventArgs e)
    {

        string company = ddlCompanyName.SelectedValue;
        int c_id = int.Parse(company);
        GetClients(c_id);
        lblMessage1.Text = "";
        ddlClientName_SelectedIndexChanged(null, null);
    }
    protected void btnAddClient_Click(object sender, EventArgs e)
    {
        Response.Redirect("frmClient.aspx");
    }
    protected void btnAddCompany_Click(object sender, EventArgs e)
    {
        Response.Redirect("frmCompany.aspx");
    }
    protected void ddlCategory_SelectedIndexChanged1(object sender, EventArgs e)
    {
        string catid = ddlCategory.SelectedValue;
        int c_id = int.Parse(catid);
        GetItems(c_id);
        lblMessage1.Text = "";
    }
    protected void btnAdd_Click(object sender, EventArgs e)
    {
        try
        {
            lblMessage1.Text = "";
            itemsheader.Visible = false;
            //DT_VistsRecord = (DataTable)ViewState["VisitDataids"];
            DT_VisitsData = (DataTable)ViewState["VisitData"];
            dr = DT_VisitsData.NewRow();
            string category = ddlCategory.SelectedItem.Text;
            int categoryid = int.Parse(ddlCategory.SelectedValue);
            string item = "";
            int itemid = 0;

            try
            {
               item = ddlItem.SelectedItem.Text;
               itemid = int.Parse(ddlItem.SelectedValue);
            }
            catch (Exception ex)
            { 
                
            }
                 
            int itemSalesAmount = 0;
            if (txtitemsales.Text != "")
            {
                itemSalesAmount = int.Parse(txtitemsales.Text);
            }
            int status = Validate(item, txtitemsales.Text);
            if (status == 1)
            {
                dr["Category"] = category;
                dr["Item Name"] = item;
                dr["Sale Amount"] = itemSalesAmount;
                dr["cat_id"] = categoryid;
                dr["item_id"] = itemid;
                // Adding new Row to Grid
                DT_VisitsData.Rows.Add(dr);
                BindGridAdd(DT_VisitsData);
                // Saving Data into ViewState
                ViewState["VisitData"] = DT_VisitsData;
            }
            
            dr = null;
           txtSaleAmount.Text = sumofprices().ToString();
           txtitemsales.Focus();
        }
        catch (Exception ex)
        {
            lblMessage1.Text = ex.Message.ToString();
            lblMessage1.ForeColor = System.Drawing.Color.Red;
        }
    }
    protected void btnSave_Click(object sender, EventArgs e)
    {
        try
        {
            if (Session["Username"].ToString() == "logout")
            {
                Response.Redirect("../../MCTX_General/Login.aspx");

            }
        }
        catch (Exception ex)
        {
            Response.Redirect("../../MCTX_General/Login.aspx");
        }
        
        int compname = int.Parse(ddlCompanyName.SelectedValue);
        int clientName = int.Parse(ddlClientName.SelectedValue);
        int typeofcall = int.Parse(ddlTypeofCall.SelectedValue);
        //string Address = txtAddress.Text;
        int clientresponse = int.Parse(ddlClientResponse.SelectedValue);
        string remarks = txtRemarks.Text;
        int category = int.Parse(ddlCategory.SelectedValue);
        int item = 0;
        bool results = Int32.TryParse(ddlItem.SelectedValue,out item);
        if (results != true)
        { 
             
        }
        //string amount = ;
        int salesamount = 0;
        if (txtSaleAmount.Text != "")
        {
            salesamount = int.Parse(txtSaleAmount.Text);
        }


        if (objvisit.iscompanybook(compname.ToString(), Session["Username"].ToString()))
        {
            lblMessage1.Text = "Company is already booked";
            lblMessage1.ForeColor = System.Drawing.Color.Red;
            return;

        }
        if (objvisit.isalreadyentered(compname.ToString()))
        {
            lblMessage1.Text = "visit already entered against this company for today";
            lblMessage1.ForeColor = System.Drawing.Color.Red;
            return;

        }
        
        
        int status = 1;// ValidateFields();
        if (status == 1)
        {
            int result = objvisit.fnAddVisit((DataTable)ViewState["VisitData"], compname, clientName, typeofcall, clientresponse, remarks, category, item, salesamount, Session["Username"].ToString(),txtreminderdate.Text,ddlTypeofCall.SelectedItem.Text,userIpAddress());
            if (result == 1)
            {
                lblMessage1.Text = "Visit added successfuly";
                lblMessage1.ForeColor = System.Drawing.Color.SeaGreen;
                sendemail();
                clearfields();
                int prosstatus = objvisit.updateprospecting(compname.ToString(), Session["Username"].ToString());
                if (prosstatus == 1)
                lblMessage1.Text = lblMessage1.Text + " + Prospecting Complete";
            }
            else
            {
                lblMessage1.Text = "Visit Not Added";
                lblMessage1.ForeColor = System.Drawing.Color.Red;

            }
        }
        else
        {
            lblMessage1.Text = "Data Not Valid";
            lblMessage1.ForeColor = System.Drawing.Color.Red;
        }
    }
    protected void ddlClientName_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            clearfields();
            int client_id = int.Parse(ddlClientName.SelectedValue);
            DataTable dt_clientinfo = objvisit.fnGetClientInfo(client_id);
            SetData(dt_clientinfo);
        }
        catch(Exception ex)
        {
            clearfields();
        }
    }
    protected void clearall_Click(object sender, EventArgs e)
    {
        try
        {
            DataTable dt_clear = (DataTable)ViewState["VisitData"];
            dt_clear.Clear();
            ViewState["VisitData"] = null;
            ViewState["VisitData"] = dt_clear;
            DataTable test = (DataTable)ViewState["VisitData"];
            GridView3.DataSource = dt_clear;
            GridView3.DataBind();
            itemsheader.Visible = true;
            txtSaleAmount.Text = "";
        }
        catch (Exception ex)
        { }

    }
    protected void btnAddproduct_Click(object sender, EventArgs e)
    {
        Response.Redirect("frmProductInfo.aspx", true);
    }
    
    #endregion
    protected void todayvisitlink_Click(object sender, EventArgs e)
    {
        DateTime Lday = DateTime.Now;

        string mon = Lday.Month.ToString();
        string day = Lday.Day.ToString();
        string year = Lday.Year.ToString();

        if (mon.Length != 2)
            mon = "0" + mon;
        if (day.Length != 2)
            day = "0" + day;

        string LastDate = mon + "/" + day + "/" + year;




        Response.Redirect("rptVisits.aspx?UserId=" + Session["Username"].ToString() + "&VisitType=All&fromdate=" +
          LastDate + "&todate=" + LastDate);
    }

    protected void txt_linkedbutton_Click(object sender, EventArgs e)
    {
        if (upcomingvisits.Visible)
        {
            upcomingvisits.Visible = false;
            txt_linkedbutton.Text = "Show upcoming visits";
        }
        else
        {
            upcomingvisits.Visible = true;
            txt_linkedbutton.Text = "Hide upcoming visits";
        }
    }
}

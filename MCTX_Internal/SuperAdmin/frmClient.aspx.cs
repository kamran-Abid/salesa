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

public partial class MCTX_Internal_SuperAdmin_frmClient : System.Web.UI.Page
{
    #region Variables
    _Clients objCL = new _Clients();
    #endregion

    #region Methods
    public void GetCompanies()
    {
        objCL.fngetcompanies();
        ddlCompanyName.DataSource = objCL.DT_Companies;
        ddlCompanyName.DataValueField = "comp_id";
        ddlCompanyName.DataTextField = "comp_name";
        ddlCompanyName.DataBind();
        ddlCompanyName.Items.Insert(0, "-- Select --");
    }
    public void GetCountries()
    {
        objCL.fngetCountries();
        ddlCountry.DataSource = objCL.DT_Countries;
        ddlCountry.DataValueField = "country_id";
        ddlCountry.DataTextField = "country_name";
        ddlCountry.DataBind();
        ddlCountry.Items.Insert(0, "-- Select --");
    }
    public void GetCities(int c_id)
    {
        objCL.fngetCities(c_id);
        ddlCity.DataSource = objCL.DT_Cities;
        ddlCity.DataValueField = "city_id";
        ddlCity.DataTextField = "city_name";
        ddlCity.DataBind();
        ddlCity.Items.Insert(0, "-- Select --");
    }
    #endregion

    #region Events
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            if (Session["Username"] == null)
            {
                Response.Redirect("../../MCTX_General/Login.aspx");
                //return;
            }
            string role = Session["Role"].ToString();
            if (role == "Employee")
            {
                Response.Redirect("Accessdenied.aspx");
                return;
            }
        }
        catch (Exception ex)
        { 
            
        }
        try
        {
            if (!IsPostBack)
            {
                GetCompanies();
                GetCountries();
                //ddlCity.Items[0].Text = "--Select--";
            }
        }
        catch (Exception ex)
        { 
            
        }
    }
    protected void ddlCountry_SelectedIndexChanged1(object sender, EventArgs e)
    {
        lblmessage.Text = "";
        string country = ddlCountry.SelectedValue;
        if (country != "-- Select --")
        {
            int c_id = int.Parse(country);
            GetCities(c_id);
        }
        else
        {
            lblmessage.Text = "Please Select a Valid Country Name";
            lblmessage.ForeColor = System.Drawing.Color.Red;
            objCL.DT_Cities = null;
            ddlCity.SelectedValue = "-- Select --";
        }
        //ViewState["Country_id"] = c_id;
    }
    protected void btnSaveUser_Click(object sender, EventArgs e)
    {
        lblmessage.Text = "";
        try
        {
            int inserted = objCL.fnInsertClient(txtClientName.Text, txtAddress.Text, txtDepartment.Text, txtDesignation.Text, txtEmail.Text, txtFaxNo.Text, txtMobileNo.Text, txtPhone.Text, int.Parse(ddlCity.SelectedValue), int.Parse(ddlCountry.SelectedValue), int.Parse(ddlCompanyName.SelectedValue));
            if (inserted == 1)
            {
                //lblmessage.Visible = true;
                lblmessage.ForeColor = System.Drawing.Color.Green;
                lblmessage.Text = "*Record saved successfully";
            }
            else
            {
                //lblmessage.Visible = true;
                lblmessage.ForeColor = System.Drawing.Color.Red;
                lblmessage.Text = "*Unable to save record";
            }
        }
        catch (Exception ex)
        {
            lblmessage.Visible = true;
            lblmessage.ForeColor = System.Drawing.Color.Red;
            lblmessage.Text = ex.Message.ToString();
        }
    }
    #endregion
}

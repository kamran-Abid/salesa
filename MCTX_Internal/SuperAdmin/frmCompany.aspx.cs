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

public partial class MCTX_Internal_SuperAdmin_frmCompany : System.Web.UI.Page
{

    _Company objcompany = new _Company();
    _Clients objCL = new _Clients();
    string country = "";
    int countryid = 0;
    string city = "";
    int cityid = 0;
    
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
            getcountires();
        }
        catch (Exception ex)
        { 
            
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


    protected void btnSaveUser_Click(object sender, EventArgs e)
    {
        //txtCompanyName.Text;
        //txtWebsite.Text;
        //ddlCountry.Text;
        //ddlCity.Text;
       // txtPhone.Text;
        //txtAddress;
       // txtMultiproducts;
        //if (Validate())
        //{
        //    return;
        //}

        try
        {

            country = ddlCountry.Text.Substring(0, ddlCountry.Text.IndexOf("-"));
            countryid = int.Parse(country);

            city = ddlCity.Text.Substring(0, ddlCity.Text.IndexOf("-"));
            cityid = int.Parse(city);


            DateTime date = DateTime.Now;
            string curdate = date.Month.ToString() + "/" + date.Day.ToString() + "/" + date.Year.ToString();
            int inserted = 0;
            inserted = objcompany.insert_companyinfo(txtCompanyName.Text, txtWebsite.Text,
                countryid, cityid, txtPhone.Text, txtAddress.Text, txtMultiproducts.Text, curdate, Session["Username"].ToString());

            if (inserted == 1)
            {
                lblmessage.Visible = true;
                lblmessage.ForeColor = System.Drawing.Color.Green;
                lblmessage.Text = "*Record saved successfully";
            }
            else
            {
                lblmessage.Visible = true;
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
    //public bool Validate()
    //{ 
        
    
    //}
    protected void ddlCountry_SelectedIndexChanged(object sender, EventArgs e)
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

            lblmessage.Visible = true;
            lblmessage.ForeColor = System.Drawing.Color.Red;
            lblmessage.Text = ex.Message.ToString();

        }
    }
}

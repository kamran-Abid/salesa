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
using System.Text.RegularExpressions;

public partial class MCTX_Internal_SuperAdmin_frmExcuse : System.Web.UI.Page
{
    #region Variables
    _Excuse objExcuse = new _Excuse();
    string username = String.Empty;
    _Clients objclients = new _Clients();
    int comp_id = 0;
    #endregion

    #region Methods
    // Function to Check for AlphaNumeric.
    public bool IsAlphaNumeric(String strToCheck)
    {
        Regex objAlphaNumericPattern = new Regex("[^a-zA-Z0-9]");
        return !objAlphaNumericPattern.IsMatch(strToCheck);
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
    public int Validate(string username, string subject, string description, int comp_id)
    {
        if (comp_id.ToString() != "")
        {
            if(!IsNumber(comp_id.ToString()))
                return 0;
            if (username != "")
            {
                if (!IsAlphaNumeric(username))
                    return 0;
                if(subject != "")
                {
                    if (IsAlphaNumeric(subject))
                        return 0;
                    if (description != "")
                    {
                        if (!IsAlpha(description))
                            return 0;
                        return 1;
                    }
                    return 0;
                }
                return 0;
            }
            return 0;
       }
       return 0;
    }
    public void GetCompanies()
    {
        objclients.fngetcompanies();
        ddlCompanies.DataSource = objclients.DT_Companies;
        ddlCompanies.DataValueField = "comp_id";
        ddlCompanies.DataTextField = "comp_name";
        ddlCompanies.DataBind();
    }
    #endregion

    #region Events
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
        try
        {
            if (!IsPostBack)
            {
                GetCompanies();
            }
            comp_id = int.Parse(Request.QueryString["comp"]);
            ddlCompanies.SelectedValue = Request.QueryString["comp"];
            ddlCompanies.Enabled = false;
            username = (string)Session["Username"];
            lblmessage.Text = "";
        }
        catch (Exception ex)
        { 
            
        }
    }
    protected void btnSave_Click(object sender, EventArgs e)
    {
        lblmessage.Text = "";
        string subject = txtSubject.Text;
        string description = txtDescription.Text;
        string date = DateTime.Now.ToShortDateString();
        int result = Validate(username, subject, description, comp_id);
        
        if (result == 1)
        {
            int status = objExcuse.fnAddExcuse(username, subject, description, comp_id);
            if (status == 1)
            {
                lblmessage.Text = "Excuse Added Successfuly";
                lblmessage.ForeColor = System.Drawing.Color.Green;
            }
            else
            {
                lblmessage.Text = "Excuse Not Added";
                lblmessage.ForeColor = System.Drawing.Color.Red;
            }
        }
        else
        {
            lblmessage.Text = "Please Enter the Correct Values";
            lblmessage.ForeColor = System.Drawing.Color.Red;
        }
        txtSubject.Text = "";
        txtDescription.Text = "";
    }
    protected void btnClear_Click(object sender, EventArgs e)
    {
        ddlCompanies.SelectedIndex = 1;
        txtSubject.Text = "";
        txtDescription.Text = "";
        txtSubject.Focus();
    }
    #endregion
}

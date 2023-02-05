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

public partial class MCTX_Internal_SuperAdmin_frmCountry : System.Web.UI.Page
{
    #region Variables
    _Country objCountry = new _Country();
    #endregion
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            if (Session["Username"].ToString() == "logout")
            {
                Response.Redirect("../../MCTX_General/Login.aspx");
                return;
            }
            string role = Session["Role"].ToString();
            if (role == "Employee")
            {
                Response.Redirect("Accessdenied.aspx");
                return;
            }
            //txtCounntryName.Text = "";
            txtCounntryName.Focus();
        }
        catch (Exception ex)
        { 
            
        }
    }
    protected void btnSaveCountry_Click(object sender, EventArgs e)
    {
        string Country =  txtCounntryName.Text;
        int result = objCountry.fnAddCountry(Country);
        if (result == 1)
        {
            lblMessage.Text = "Country Added Successfuly";
            lblMessage.ForeColor = System.Drawing.Color.Green;
        }
        else
        {
            lblMessage.Text = "Insertion Error";
            lblMessage.ForeColor = System.Drawing.Color.Red;
        }
    }
    protected void btnCancelCountry_Click(object sender, EventArgs e)
    {
        txtCounntryName.Text = "";
        txtCounntryName.Focus();
    }
}

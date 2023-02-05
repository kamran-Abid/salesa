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

public partial class MCTX_Internal_SuperAdmin_frmvisitrpt : System.Web.UI.Page
{

    _TargetSettings objts = new _TargetSettings();
    _changepassword BL = new _changepassword();
    _Visits objvist = new _Visits();


    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            if (Request.Cookies["userName"] == null)
            {
                Response.Redirect("../../MCTX_General/Login.aspx");
                return;
            }
            else
                Session["Username"] = Request.Cookies["Username"].Value.ToString();
        }
        catch (Exception ex)
        {
            Response.Redirect("../../MCTX_General/Login.aspx");
        }

        if (!IsPostBack)
        {
            ddlselectuser_SelectedIndexChanged(null, null);
            GetvisitType();
            GetUserlist();
        }
    }

    public void GetUserlist()
    {
        BL.getUserid();
        ddlselectuser.DataSource = BL.dt_userid;
        ddlselectuser.DataTextField = "user_id";
        ddlselectuser.DataBind();
        ddlselectuser.Items.Insert(0, "All");
    }

    protected void ddlselectuser_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            BL.GETusername(ddlselectuser.SelectedItem.Text);
            txtusername.Text = BL.dt_username.Rows[0][0].ToString();
        }
        catch (Exception ex)
        {
            txtusername.Text = "";
        }
    }
    public void GetvisitType()
    {
        objvist.getTypeofCalls();
        ddlselectvisit.DataSource = objvist.dt_typeofcalls;
        ddlselectvisit.DataValueField = "tt_id";
        ddlselectvisit.DataTextField = "tt_name";
        ddlselectvisit.DataBind();
        ddlselectvisit.Items.Insert(0, "All");
    }
    protected void btn_submit_Click(object sender, EventArgs e)
    {
        string user = "";
        string visittype = "";

        try
        {
            user = ddlselectuser.SelectedItem.Text;
        }
        catch (Exception ex)
        {
            user = "All";
        }
        try
        {
            visittype = ddlselectvisit.SelectedValue;
        }
        catch (Exception ex)
        {
            visittype = "All";
        }

        Response.Redirect("rptVisits.aspx?UserId=" + user + "&VisitType=" + visittype + "&fromdate=" +
            txtfromdate.Text + "&todate=" + txttodate.Text);
    }
    protected void txtfromdate_TextChanged(object sender, EventArgs e)
    {

    }
    protected void txttodate_TextChanged(object sender, EventArgs e)
    {

    }
}

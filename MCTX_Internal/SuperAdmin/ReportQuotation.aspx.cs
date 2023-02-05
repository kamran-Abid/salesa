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

public partial class MCTX_Internal_SuperAdmin_ReportQuotation : System.Web.UI.Page
{
    #region Variables
    _Quotation objQuot = new _Quotation();
    double priceofallitems =0;
    #endregion

    #region Methods
    public void ShowReport(DataSet dsQuotData)
    {
        GridQuotReport.DataSource = dsQuotData.Tables[0];
        GridQuotReport.DataBind();
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
            string role = Session["Role"].ToString();
            if (role == "Employee")
            {
                Response.Redirect("Accessdenied.aspx");
                return;
            }
            if (!IsPostBack)
            {
            
                //btnprint.Attributes.Add("onclick", "getPrint('printdata','btnprint','btnback')");
                int quotId = int.Parse(Request.QueryString["QuotID"].ToString());
                DataSet dsQuotData = objQuot.fnGetQuotData(quotId);
                DataTable dt = dsQuotData.Tables[0];
                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    priceofallitems += double.Parse(dt.Rows[i]["totalprice"].ToString());
                }
                dt.Columns.Add("NetTotal", typeof(double));
                priceofallitems = priceofallitems + double.Parse(dt.Rows[0]["sumgst"].ToString());
                for (int j = 0; j < dt.Rows.Count; j++)
                {
                    dt.Rows[j]["NetTotal"] = priceofallitems;
                }
                ShowReport(dsQuotData);
                //Setting Data on Report
                lblSubject.Text = dt.Rows[0]["subject"].ToString();
                lblDate.Text = DateTime.Now.ToShortDateString();
                lbladdress.Text = dt.Rows[0]["comp_address"].ToString();
                lblAttn.Text = dt.Rows[0]["client_name"].ToString();
                lblcomp.Text = dt.Rows[0]["comp_name"].ToString();
                lbldepart.Text = dt.Rows[0]["client_dept"].ToString();
                lblDesig.Text = dt.Rows[0]["client_designation"].ToString();
                lblemail.Text = dt.Rows[0]["client_email"].ToString();
                lblEmailManager.Text = dt.Rows[0]["man_email"].ToString();
                lblemailoffice.Text = "info@mechatronix.com.pk";
                lblEmailRep.Text = dt.Rows[0]["sale_email"].ToString();
                lblEmailTech.Text = dt.Rows[0]["tec_email"].ToString();
                lblFax.Text = "051-2872811";
                lblmobile.Text = dt.Rows[0]["Client_mobile"].ToString();
                lblMobManager.Text = dt.Rows[0]["man_mobile"].ToString();
                lblMobRep.Text = dt.Rows[0]["sale_mobile"].ToString();
                lblMobTech.Text = dt.Rows[0]["tec_mobile"].ToString();
                lblOffice.Text = "Office # 7-9, 3rd floor, Mujahid Plaza, Jinnah Avenue Blue Area,Islamabad";
                lblphone.Text = "051-2821100";
                lblquotno.Text = dt.Rows[0]["quot_id"].ToString();
                lblRepresentative.Text = dt.Rows[0]["sale_per_name"].ToString();
                lblSalManager.Text = dt.Rows[0]["sal_manager_name"].ToString();
                lblsite.Text = dt.Rows[0]["customer_site"].ToString();
                lbltechPerson.Text = dt.Rows[0]["tec_per_name"].ToString();
            }
        }
        catch(Exception ex)
        {}
    }
    protected void btnBack_Click1(object sender, EventArgs e)
    {
        Response.Redirect("frmQuotations.aspx");
    }
    protected void btnprint_Click(object sender, EventArgs e)
    {
        //btnprint.Visible = false;
        //btnback.Visible = false;
    }
    #endregion

    
}

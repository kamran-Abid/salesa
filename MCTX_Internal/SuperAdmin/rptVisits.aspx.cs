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

public partial class MCTX_Internal_SuperAdmin_rptVisits : System.Web.UI.Page
{

    _Visits objvisits = new _Visits();
    
    string userid = "";
    string visittype = "";
    string fromdate = "";
    string todate = "";
    
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
            {
                //lblUser.Visible = true;
                //lblUser.Text = Request.Cookies["Username"].Value.ToString() + " As " + Request.Cookies["Role"].Value + " ! ";
                Session["Username"] = Request.Cookies["Username"].Value.ToString();
            }
        }
        catch (Exception ex)
        {
            Response.Redirect("../../MCTX_General/Login.aspx");
           
        }
        if (!IsPostBack)
        { 
            DateTime date = DateTime.Now;
            lbldate.Text = date.ToLongDateString();
            userid = Request.QueryString["UserId"];
            visittype = Request.QueryString["VisitType"];
            fromdate = Request.QueryString["fromdate"];
            todate = Request.QueryString["todate"];
            lbl_username.Text = userid;
            lbl_visittype.Text = visittype;
            lbldaterange.Text = fromdate + " -- to -- " + todate;
            GetData();
            get_visitcounts();
            
        }
    }
    public void GetData()
    {
        try
        {
            objvisits.Getvisits(userid, visittype, fromdate, todate);
            lblTotalvisits.Text = objvisits.dt_vistis.Rows.Count.ToString();
            ViewState["visits_data"] = objvisits.dt_vistis;
            GridViewVisitReport.DataSource = objvisits.dt_vistis;
            GridViewVisitReport.DataBind();
        }
        catch (Exception ex)
        { }
    }
    public void get_visitcounts()
    {
        int freshvisit = 0;
        int followupvisit = 0;
        int salestype = 0;
        float salesamount = 0;

        DataTable dtcount = new DataTable();
        dtcount = (DataTable)ViewState["visits_data"];

        try
        {

       
        for (int i = 0; i < dtcount.Rows.Count; i++)
        { 
            if(dtcount.Rows[i][4].ToString() == "Fresh Visits")
            {
                freshvisit++;
            }
            else if (dtcount.Rows[i][4].ToString() == "Follow Up")
            {
                followupvisit++;
            }
            else if (dtcount.Rows[i][4].ToString() == "Sale")
            {
                salestype++;
            }

            salesamount = salesamount + float.Parse(dtcount.Rows[i][5].ToString()); 

        }

             }
        catch (Exception ex)
        {
            
            //throw;
        }

        lblfreshvisit.Text = freshvisit.ToString();
        lbFUvisit.Text = followupvisit.ToString();
        lblsalvisit.Text = salestype.ToString();
        lblsaleamt.Text = salesamount.ToString();

    }

    protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName == "details")
        {
            int visit_id = int.Parse(e.CommandArgument.ToString());

            Clearlables();

            try
            {
                objvisits.visits_details(visit_id);
                lbl_visitid.Text = objvisits.dt_visits_details2.Rows[0]["visit_id"].ToString();
                lbl_type.Text = objvisits.dt_visits_details2.Rows[0]["tt_name"].ToString();
                lblvisitby.Text = objvisits.dt_visits_details2.Rows[0]["E_Name"].ToString();
                lblvisitdate.Text = objvisits.dt_visits_details2.Rows[0]["Visit_Date"].ToString();
                lbl_clientreponse.Text = objvisits.dt_visits_details2.Rows[0]["response_name"].ToString();
                lbl_compname.Text = objvisits.dt_visits_details2.Rows[0]["comp_name"].ToString();
                lbl_salesamt.Text = objvisits.dt_visits_details2.Rows[0]["total_Sale"].ToString();
                lblclname.Text = objvisits.dt_visits_details2.Rows[0]["client_name"].ToString();
                lblclientdesig.Text = objvisits.dt_visits_details2.Rows[0]["client_designation"].ToString();
                lblclientmobile.Text = objvisits.dt_visits_details2.Rows[0]["Client_mobile"].ToString();
                lblclientphone.Text = objvisits.dt_visits_details2.Rows[0]["client_phone"].ToString();
                lblclientemail.Text = objvisits.dt_visits_details2.Rows[0]["client_email"].ToString();
                lblAddress.Text = objvisits.dt_visits_details2.Rows[0]["comp_address"].ToString();
                lbl_city.Text = objvisits.dt_visits_details2.Rows[0]["city_name"].ToString();
                lblremarks.Text = objvisits.dt_visits_details2.Rows[0]["remarks"].ToString();
                
                 
                
                if (objvisits.dt_visits_details.Rows.Count > 0)
                {
                    Gridveiw_visitdetails.DataSource = objvisits.dt_visits_details;
                    Gridveiw_visitdetails.DataBind();
                    lblnorecord.Visible = false;
                }
                else
                {
                    lblnorecord.Visible = true;
                    Gridveiw_visitdetails.DataSource = objvisits.dt_visits_details;
                    Gridveiw_visitdetails.DataBind();
                }
                
            }
            catch (Exception ex)
            {
                 
            }
        }  
    }
    public void Clearlables()
    {
        lbl_visitid.Text = "";
        lbl_visittype.Text = "";
        lblvisitby.Text = "";
        lblvisitdate.Text = "";
        lbl_clientreponse.Text = "";
        lbl_compname.Text = "";
        lbl_salesamt.Text = "";
        lblclname.Text = "";
        lblclientdesig.Text = "";
        lblclientmobile.Text = "";
        lblclientphone.Text = "";
        lblclientemail.Text = "";
        lblAddress.Text = "";
        lbl_city.Text = "";
    
    }

    protected void btnback_Click(object sender, EventArgs e)
    {
        Response.Redirect("frmvisitrpt.aspx");
    }
    protected void GridViewVisitReport_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        GridViewVisitReport.PageIndex = e.NewPageIndex;
        //objvisits.Getvisits(userid, visittype, fromdate, todate);
        GridViewVisitReport.DataSource = (DataTable)ViewState["visits_data"];
        GridViewVisitReport.DataBind();
    }
    protected void btnview_details_Click(object sender, EventArgs e)
    {

    }
    protected void btn_export_Click(object sender, EventArgs e)
    {
        DataTable dt = (DataTable)ViewState["visits_data"];
        string attachment = "attachment; filename=Report.xls";
        Response.ClearContent();
        Response.AddHeader("content-disposition", attachment);
        Response.ContentType = "application/vnd.ms-excel";

        string tab = "";
        foreach (DataColumn dc in dt.Columns)
        {
            Response.Write(tab + dc.ColumnName);
            tab = "\t";
        }
        Response.Write("\n");
        int i;
        foreach (DataRow dr in dt.Rows)
        {
            tab = "";
            for (i = 0; i < dt.Columns.Count; i++)
            {
                Response.Write(tab + dr[i].ToString());
                tab = "\t";
            }
            Response.Write("\n");
        }
        Response.End();
    }
    protected void GridViewVisitReport_SelectedIndexChanged(object sender, EventArgs e)
    {

    }
    protected void GridViewVisitReport_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            e.Row.Attributes.Add("onmouseover", "this.style.backgroundColor='#8CCDEC'");
            // This will be the back ground color of the GridView Control
            e.Row.Attributes.Add("onmouseout", "this.style.backgroundColor='White'");
        }
    }
}

using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;

public partial class Master2nd : System.Web.UI.MasterPage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            //if (Session["Username"] == null && Profile.UserID == "")
            if (Session["Username"] == null)
            {
                Response.Redirect("../../MCTX_General/Login.aspx");
                return;
            }
            else if (Session["Username"] == "")
            {
                Response.Redirect("../../MCTX_General/Login.aspx");
                return;
            }
            else
            {
                

            }
            //if (Session["Username"] == null)
            //{
            //    Response.Redirect("../../MCTX_General/Login.aspx");
            //    return;
            //}
            //else
            //{
                //lblUser.Visible = true;
                //lblUser.Text = Request.Cookies["Username"].Value.ToString() + " As " + Request.Cookies["Role"].Value + " ! ";

                //Label lblHeader = (Label)Master.FindControl("lblHeader");
                //lblHeader.Text = text;
                if (!IsPostBack)
                {
                    //if (Profile.RoleName != "")
                    //{
                    //    lblUserRole.Text = Profile.RoleName;
                    //    lblUserName.Text = Profile.EmpFullName;
                    //}
                    //else
                    //{
                    //}

                    lblUserRole.Text = Session["Role"].ToString();
                    lblUserName.Text = Session["UserFullName"].ToString();
                    //Label lblHeader = (Label)Master.FindControl("lblUserRole");
                    //lblHeader.Text = Response.Cookies["Role"].Value.ToString();
                    
                    //Session["Username"] = Request.Cookies["Username"].Value.ToString();
                    //Session["Role"] = Response.Cookies["Role"].Value.ToString();
                    //Session["UserFullName"] = Response.Cookies["UserFullName"].Value.ToString();
                    //Session["UserPass"] = Response.Cookies["UserPass"].Value.ToString();
                }
            //}
        }
        catch (Exception ex)
        {
            //Response.Redirect("../../MCTX_General/Login.aspx");
        }

        try
        {
            //lblUserRole.Text = Session["Role"].ToString();
            //lblUserName.Text = Session["UserFullName"].ToString();


            //lblUserRole.Text = Request.Cookies["Role"].Value.ToString();
            //lblUserName.Text = Request.Cookies["UserFullName"].Value.ToString();
            lblUserName.ForeColor = System.Drawing.Color.OliveDrab;
            string Time = DateTime.Now.ToShortTimeString();
            string[] TimeArray = Time.Split(new Char[] { ':', ' ' });
            int hour = int.Parse(TimeArray[0]);
            string mode = TimeArray[2];

            if (hour < 12 && hour > 4 && mode == "AM")
            {
                lblGreeting.Text = "Good Morning";
                lblGreeting.ForeColor = System.Drawing.Color.OliveDrab;
            }
            if (hour == 12 && mode == "PM")
            {
                lblGreeting.Text = "Good AfterNoon";
                lblGreeting.ForeColor = System.Drawing.Color.OliveDrab;
            }
            if (hour > 6 && hour < 9 && mode == "PM")
            {
                lblGreeting.Text = "Good Evening";
                lblGreeting.ForeColor = System.Drawing.Color.OliveDrab;
            }
            if (hour > 9 && hour < 12 && mode == "PM")
            {
                lblGreeting.Text = "Good Night";
                lblGreeting.ForeColor = System.Drawing.Color.OliveDrab;
            }
        }
        catch (Exception ex)
        {
            ex.Message.ToString();
        }
    }
}

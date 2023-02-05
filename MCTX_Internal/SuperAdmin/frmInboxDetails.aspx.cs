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

public partial class MCTX_Internal_SuperAdmin_frmInboxDetails : System.Web.UI.Page
{
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
        }
        catch (Exception ex)
        { 
            
        }
        try
        {
            lblUserID.Text = Session["Username"].ToString();
            string TaskId = Request.QueryString["taskId"];
            string TaskName = Request.QueryString["TaskName"];
            string TaskDetail = Request.QueryString["TaskDetail"];
            string AssignDate = Request.QueryString["AssignDate"];
            string EndDate = Request.QueryString["EndDate"];
            string Fullname = Request.QueryString["FullName"];
            string TaskRemarks = Request.QueryString["TaskRemarks"];

            lblTaskID.Text = TaskId;
            lblTask.Text = TaskName;
            lblSubDate.Text = EndDate;
            lblPostDate.Text = AssignDate;
            lblEmpName.Text = Fullname;
            txtTaskDetail.Text = TaskDetail;
            txtRemarks.Text = TaskRemarks;

            txtTaskDetail.Enabled = false;
            txtRemarks.Enabled = false;
        }
        catch (Exception ex)
        { }
    }
}

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

public partial class MCTX_Internal_SuperAdmin_TaskDetals : System.Web.UI.Page
{
    #region Variables
    _UserTask objUTask = new _UserTask();
    #endregion

    #region Methods

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
        }
        catch (Exception ex)
        { }
        try
        {
            if (!IsPostBack)
            {
                try
                {
                    string userId = Request.QueryString["userId"];
                    string TaskId = Request.QueryString["taskId"];
                    string TaskName = Request.QueryString["TaskName"];
                    string TaskDetail = Request.QueryString["TaskDetail"];
                    string AssignDate = Request.QueryString["AssignDate"];
                    string EndDate = Request.QueryString["EndDate"];
                    string fullname = Request.QueryString["FullName"];
                    //lblUser.Text = fullname;
                    lblUserId.Text = userId;
                    lblTaskName.Text = TaskName;
                    lblTaskDetail.Text = TaskDetail;
                    lblPostingDate.Text = AssignDate;
                    lblCompDate.Text = EndDate;
                    lblTaskID.Text = TaskId;
                    lblMessage.Text = "";
                }
                catch (Exception ex)
                {
                    ex.Message.ToString();
                }
            }
        }
        catch (Exception ex)
        { }
    }
    protected void btnSubmit_Click1(object sender, EventArgs e)
    {
        string time = DateTime.Now.ToShortTimeString();
        int status = objUTask.AddTaskRemarks(txtRemarks.Text, int.Parse(lblTaskID.Text), lblUserId.Text, time);
        if (status == 1)
        {
            lblMessage.Text = "Remarks Added Successfuly";
            lblMessage.ForeColor = System.Drawing.Color.Green;
        }
        else
        {
            lblMessage.Text = "Remarks Not Added";
            lblMessage.ForeColor = System.Drawing.Color.Red;
        }
    }
   
    #endregion
    
}

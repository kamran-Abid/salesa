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

public partial class MCTX_Internal_SuperAdmin_frmUserTask : System.Web.UI.Page
{
    #region Variables
    _UserTask objUTask = new _UserTask();
    #endregion

    #region Methods
    public int GetCount(string user)
    {
        DataTable dt_count = objUTask.fnGetCount(user);
        lblUserName.Text = dt_count.Rows[0]["E_Name"].ToString();
        Session["FullName"] = dt_count.Rows[0]["E_Name"].ToString();
        return int.Parse(dt_count.Rows[0]["Count"].ToString()); 
    }
    public void GetTasks(string userid, string fromDate, string toDate, int taskStatus, string AssignBy, string statustask)
    {
        // Data
        int done = 0;
        int inprogress = 0;
        int New = 0;
        int reOpened = 0;
        // Getting Tasks
        DataTable dt = objUTask.fnGetTasks(userid, fromDate, toDate, taskStatus, AssignBy, statustask);
        GridTasks.DataSource = dt;
        GridTasks.DataBind();
        Session["TaskDetail"] = dt;
        if (dt.Rows.Count < 1)
        {
            gridheader.Visible = true;
        }
        else
        {
            gridheader.Visible = false;
        }
        for (int i = 0; i < dt.Rows.Count; i++)
        {
            if (dt.Rows[i][7].ToString() == "Done")
            {
                done++;
            }
            else if (dt.Rows[i][7].ToString() == "In Progress")
            {
                inprogress++;
            }
            else if (dt.Rows[i][7].ToString() == "New")
            {
                New++;
            }
            else if (dt.Rows[i][7].ToString() == "Re-Opened")
            {
                reOpened++;
            }
        }
        lblcompletedtasks.Text = done.ToString();
        lblinprogresstasks.Text = inprogress.ToString();
        lblNewtasks.Text = New.ToString();
        lblReOpenedTasks.Text = reOpened.ToString();
    }
    public void GetTaskStatus()
    {
        ddlTaskStatus.DataSource = objUTask.fnGetTaskStatus();
        ddlTaskStatus.DataTextField = "TaskStatus_Name";
        ddlTaskStatus.DataValueField = "TaskStatusID";
        ddlTaskStatus.DataBind();
        ddlTaskStatus.Items.Insert(0,"All");
    }
    public void GetAdmins()
    {
        ddlAssigBy.DataSource = objUTask.fnGetAdmins(); 
        ddlAssigBy.DataTextField = "user_id";
        ddlAssigBy.DataValueField = "user_id";
        ddlAssigBy.DataBind();
        ddlAssigBy.Items.Insert(0,"All");
    }
    #endregion

    #region Events
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            if (!IsPostBack)
            {
                int count = GetCount(Session["Username"].ToString());
                lblCounter.Text = count.ToString();
                GridTasks.Visible = false;
                GetTaskStatus();
                GetAdmins();
            }
        }
        catch (Exception ex)
        { }
    }
    protected void btnViewTask_Click(object sender, EventArgs e)
    {
        try
        {
            string statustask = ddlTaskStatus.SelectedItem.Text;
            int taskStatus = 0;
            bool result = int.TryParse(ddlTaskStatus.SelectedValue,out taskStatus);
            if (result == false)
            {
                taskStatus = 0;
            }
            string AssignBy = ddlAssigBy.SelectedItem.Text;
            string fromDate = txtFromDate.Text;
            string toDate = txtToDate.Text;
            GridTasks.Visible = true;
            GetTasks((string)Session["Username"], fromDate, toDate, taskStatus, AssignBy, statustask);
        }
        catch(Exception ex)
        {
            
        }
    }
    protected void GridTasks_SelectedIndexChanging(object sender, GridViewSelectEventArgs e)
    {
        //GridTasks.SelectedIndex = e.NewSelectedIndex;
        //Session["Index"] = GridTasks.SelectedIndex;
    }
    protected void GridTasks_RowCommand1(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName == "Detail")
        {
            string[] CommandArguments = e.CommandArgument.ToString().Split(',');
            string Taskid = CommandArguments[0];
            string UserId = CommandArguments[1];
            // Get Specific User's Task Details
            DataTable dt_Task = objUTask.fnGetSpecific(UserId, Taskid);
            string TaskName = dt_Task.Rows[0]["TaskName"].ToString();
            string TaskDetail = dt_Task.Rows[0]["TaskDetail"].ToString();
            string AssignDate = dt_Task.Rows[0]["TaskDate"].ToString();
            string userId = dt_Task.Rows[0]["UserID"].ToString();
            string taskId = dt_Task.Rows[0]["TaskID"].ToString();
            string EndDate = dt_Task.Rows[0]["EndDate"].ToString();
            // Sending Values to TaskDetail Page
            Response.Redirect("TaskDetails.aspx?TaskName=" + TaskName + "&TaskDetail=" + TaskDetail + "&AssignDate=" + AssignDate + "&userId=" + userId + "&taskId=" + taskId + "&EndDate=" + EndDate + "&FullName=" + lblUserName.Text);
        }
    }
    
    #endregion


    
}

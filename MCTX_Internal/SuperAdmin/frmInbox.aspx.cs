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

public partial class MCTX_Internal_SuperAdmin_frmInbox : System.Web.UI.Page
{
    #region Variables
    _UserTask objUTask = new _UserTask();
    #endregion

    #region Methods
    public void BindTaskData()
    {
        DataTable dt_Tasks = objUTask.fnGetAllTasks();
        GridInbox.DataSource = dt_Tasks;
        GridInbox.DataBind();
    }
    #endregion

    #region Events
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            if (!IsPostBack)
            {
                BindTaskData();
            }
        }
        catch (Exception ex)
        { 
            
        }
    }
    protected void GridInbox_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName == "Detail")
        {
            string[] CommandArguments = e.CommandArgument.ToString().Split(',');
            string Taskid = CommandArguments[0];
            string E_Name = CommandArguments[1];
            string TaskDate = CommandArguments[2];
            string EndDate = CommandArguments[3];
            string TaskRemarks = CommandArguments[4];
            string TaskName = CommandArguments[5];
            string TaskDetail = CommandArguments[1];
            // Sending Data To Next Page
            Response.Redirect("frmInboxDetails.aspx?TaskName=" + TaskName + "&TaskDetail=" + TaskDetail + "&AssignDate=" + TaskDate + "&taskId=" + Taskid + "&EndDate=" + EndDate + "&FullName=" + E_Name + "&TaskRemarks=" + TaskRemarks);
        }
    }
   
    #endregion

    
}

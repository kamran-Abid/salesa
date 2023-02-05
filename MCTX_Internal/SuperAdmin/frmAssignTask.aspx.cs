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
using System.Web.Mail;

public partial class MCTX_Internal_SuperAdmin_frmAssignTask : System.Web.UI.Page
{
    #region Variables
    _UserTask objUTask = new _UserTask();
    
    #endregion

    #region Methods
    public int Validate(string TaskName, string EnterTask)
    {
        if (TaskName != "")
        {
            if (EnterTask != "")
            {
                return 1;
            }
            return 0;
        }
        return 0;
    }
    public void GetUsers()
    {
        try
        {
            DataTable dt_Users = objUTask.fnGetUsers();
            ddlUserName.DataSource = dt_Users;
            ddlUserName.DataTextField = "user_id";
            ddlUserName.DataValueField = "user_id";
            ddlUserName.DataBind();
            //ddlUserName.Items[0].Text = "--Select--";
        }
        catch (Exception ex)
        {

        }
    }
    public void sendemail()
    {
        try
        {
            DateTime dattime = DateTime.Now;
            string dateandtime = dattime.ToLongDateString() + "  " + dattime.ToLongTimeString();
            MailMessage TaskMail = new MailMessage();
            TaskMail.To = "zaeemnsm@mechatronix.com.pk";
            TaskMail.From = "info@mechatronix.com.pk";
            TaskMail.Cc = "ceo@mechatronix.com.pk";
            TaskMail.Subject = "Your New Assigned Task!";
            TaskMail.Body = "MCTX Task details .... " + Environment.NewLine + Environment.NewLine +
                       " ---- Please Inform The Said Sales Person To Complete The Task ---- "+ Environment.NewLine +
                       "User Name               :       " + Session["UserFullName"].ToString() + Environment.NewLine +
                       "Task Assign Date        :       " + DateTime.Now.ToShortDateString() + Environment.NewLine +
                       "Days To Complete Task   :       " + ddlDays.SelectedItem.Text + Environment.NewLine +
                       "Task Description        :       " + txtEnterTask.Text + Environment.NewLine +
                       "This is System Generated Email Please don not Reply!";

            SmtpMail.SmtpServer = "mail.mechatronix.com.pk";
            SmtpMail.Send(TaskMail);
            lblMessage.Text = " + E-Mail Sent....";
        }
        catch (Exception ex)
        {
            lblMessage.Text = " + " + ex.Message.ToString();
        }

    }
    #endregion

    #region Events
    protected void Page_Load(object sender, EventArgs e)
    {
        lblMessage.Text = "";
        try
        {
            if (Session["Username"].ToString() == "logout")
            {
                Response.Redirect("../../MCTX_General/Login.aspx");
                return;
            }

            string role = Session["Role"].ToString();
            if (role != "Super Admin" && role != "Admin")
            {
                Response.Redirect("Accessdenied.aspx");
                return;
            }
            if (!IsPostBack)
            {
                GetUsers();
            }
        }
        catch(Exception ex)
        {
            
        }
    }
    protected void btnAddTask_Click(object sender, EventArgs e)
    {
        try
        {
            if (ddlDays.SelectedItem.Text != "Day(s)")
            {
                string timeAllowed = ddlDays.SelectedItem.Text;
                int result = Validate(txtTaskName.Text, txtEnterTask.Text);
                if (result == 1)
                {
                    int status = objUTask.fnAddNewTask(txtTaskName.Text, txtEnterTask.Text, ddlUserName.SelectedItem.Text, RBtnPriority.SelectedItem.Text, timeAllowed, (string)Session["Username"]);
                    if (status == 1)
                    {
                        lblMessage.Text = "Task Addedd Successfuly";
                        lblMessage.ForeColor = System.Drawing.Color.Green;
                        sendemail();
                    }
                    else
                    {
                        lblMessage.Text = "Task Not Added";
                        lblMessage.ForeColor = System.Drawing.Color.Red;
                    }
                }
                else
                {
                    lblMessage.Text = "Validation Error, Please Enter Correct Values";
                    lblMessage.ForeColor = System.Drawing.Color.Red;
                }
            }
            else
            {
                lblMessage.Text = "Please Select a Proper Value";
                lblMessage.ForeColor = System.Drawing.Color.Red;
            }
        }
        catch(Exception ex)
        {

        }
    }


    #endregion
}
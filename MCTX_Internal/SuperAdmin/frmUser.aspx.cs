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
using System.Web.Mail;
using Sales_BOL;

public partial class MCTX_Internal_SuperAdmin_frmUser : System.Web.UI.Page
{
    #region Variables
    _User objUser = new _User();
    #endregion

    #region Methods
    public void GetEmpNames()
    {
        objUser.fnGetEmpFullName();
        ddlEmpFullName.DataSource = objUser.DT_EmpNames;
        ddlEmpFullName.DataValueField = "E_badge";
        ddlEmpFullName.DataTextField = "E_Name";
        ddlEmpFullName.DataBind();
        lblMessage.Text = "";
        //ddlEmpFullName.Items.Insert(0, "-- Select --");
    }
    public void GetRoles()
    {
        objUser.fnGetRoles();
        ddlRoles.DataSource = objUser.DT_GetRoles;
        ddlRoles.DataValueField = "role_id";
        ddlRoles.DataTextField = "role_name";
        ddlRoles.DataBind();
        //ddlRoles.Items.Insert(0, "--Select--");
    }
    public void GetUsrerList()
    {
        objUser.fnGetUserList();
        UsersGrid.DataSource = objUser.DT_Users;
        UsersGrid.DataBind();
    }
    public int CheckUser(string user)
    {
        objUser.fnCheckUser();
        DataTable dt = objUser.DT_Users;
        for (int i = 1; i < dt.Rows.Count; i++)
        {
            if (dt.Rows[i]["user_id"].ToString().Equals(user))
            {
                return 1;
            }
        }
        return 0;
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
            if (role != "Super Admin" && role != "Admin")
            {
                Response.Redirect("Accessdenied.aspx");
                return;
            }
        }
        catch (Exception ex)
        {
          Response.Redirect("../../MCTX_General/Login.aspx");
        }
        try
        {
            if (!IsPostBack)
            {
                GetEmpNames();
                GetRoles();
                GetUsrerList();
            }
        }
        catch (Exception ex)
        {
           
        }
    }
    protected void btnSaveUser_Click(object sender, EventArgs e)
    {
        lblMessage.Text = "";
        lblAvailable.Text = "";
        int found = objUser.fnCheckAvailable(txtUserName.Text.Trim());
        if (found < 1)
        {
            int Role_id = 1;
            string UserName = txtUserName.Text;
            string Password = txtPassword.Text.GetHashCode().ToString();
            string ConfPwd = txtConfirmPassword.Text.GetHashCode().ToString();
            string Emp_Id = ddlEmpFullName.SelectedValue;

            try
            {

                if (ddlRoles.SelectedItem.Text != "-- Select --")
                {
                    Role_id = int.Parse(ddlRoles.SelectedValue);
                }
                else
                {
                    lblMessage.Text = "Please select Role";
                    return;
                }
                if (Password.Equals(ConfPwd) && Password != "" && UserName != "")
                {
                    int answer = CheckUser(UserName);
                    if (answer == 1)
                    {
                        lblMessage.Text = "User Already Exists";
                        lblMessage.ForeColor = System.Drawing.Color.Red;
                        return;
                    }
                    int result = objUser.fnAddUser(Emp_Id, UserName, Password, ConfPwd, Role_id);
                    if (result == 1)
                    {
                        lblMessage.Text = "User Added Successfuly";
                        lblMessage.ForeColor = System.Drawing.Color.Green;
                        GetEmpNames();
                        GetRoles();
                        GetUsrerList();
                    }
                    else
                    {
                        lblMessage.Text = "Unable to save record";
                        lblMessage.ForeColor = System.Drawing.Color.Red;
                    }
                }
                else
                {
                    lblMessage.Text = "Password Does not Match, Please Enter The Correct Password";
                    lblMessage.ForeColor = System.Drawing.Color.Red;
                }

            }
            catch (Exception ex)
            {
                lblMessage.Text = ex.Message.ToString();
                lblMessage.ForeColor = System.Drawing.Color.Red;
            }
        }
        else
        {
            lblMessage.Text = "User Name Not Available";
            lblMessage.ForeColor = System.Drawing.Color.Red;
        }
    }
    protected void btnCancelUser_Click(object sender, EventArgs e)
    {
        sendemail();
        cancel();

    }

    public void sendemail()
    { 
            //System.Web.Mail.MailMessage objEmail  = new System.Web.Mail.MailMessage();
            //objEmail.To = "info@mechatronix.com.pk";
            //objEmail.From = "ceo@mechatronix.com.pk";
            ////objEmail.Cc       = "khalidaries2007@gmail.com";
            //objEmail.Subject  = "Test Email";
            //objEmail.Body = " Test ";
                                
            //objEmail.Priority = System.Web.Mail.MailPriority.High;
            //System.Web.Mail.SmtpMail.SmtpServer = "mail.mechatronix.com.pk";
            //System.Net.Mail.SmtpAccess.Connect
            
            //try
            //{
            //    SmtpMail.Send(objEmail);
            //    //te("Your Email has been sent sucessfully -
            //    //              Thank You");
            //}
            //catch (Exception exc)
            //{
            //    //Response.Write("Send failure: " + exc.ToString());
            //}
        try
        {
            //System.Net.Mail.SmtpClient client = new System.Net.Mail.SmtpClient("mail.mechatronix.com.pk");
            //MailAddress from = new MailAddress("ceo@mechatronix.com.pk");
            //MailAddress to = new MailAddress("info@mechatronix.com");
            //MailMessage message = new MailMessage(from, to);
            //message.Body = "This is a test e-mail message sent by an application. ";
            //message.Subject = "test message 1";
            //client.Send(message);
            //

            MailMessage sms = new MailMessage();
            sms.To = "ceo@mechatronix.com.pk";
            sms.From = "info@mechatronix.com.pk";
            sms.Cc = "ceo@mechatronix.com.pk";
            sms.Subject = "Test";
            sms.Body = "Test email";

            SmtpMail.SmtpServer = "mail.mechatronix.com.pk";
            SmtpMail.Send(sms);
            //lblmsg.Text = "Mail Sent....";

        }
        catch (Exception ex)
        {
            //lblmsg.Text = ex.Message.ToString();
        }



    }

    public void cancel()
    {
        try
        {
            txtConfirmPassword.Text = "";
            txtPassword.Text = "";
            txtUserName.Text = "";
            lblMessage.Text = "";
            GetEmpNames();
            GetRoles();
            GetUsrerList();
            ddlEmpFullName.Focus();

        }
        catch (Exception ex)
        { }
    
    }
    protected void UsersGrid_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        string userid = "";

        try
        {

            if (e.CommandName == "Delete")
            {
                userid = e.CommandArgument.ToString();
            }

            int deleted = objUser.BoldeleteUser(userid);

            if (deleted == 1)
            {
                lblMessage.Text = "Deleted Successfully";
                lblMessage.ForeColor = System.Drawing.Color.Green;
            }
            else
            {
                lblMessage.Text = "Delete operation cannot be performed";
                lblMessage.ForeColor = System.Drawing.Color.Red;
            }

        }
        catch (Exception ex)
        {

        }

    }
    protected void UsersGrid_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {
        cancel();
    }
    protected void btnCheckAvailable_Click(object sender, EventArgs e)
    {
        lblMessage.Text = "";
        lblAvailable.Text = "";
        int result = objUser.fnCheckAvailable(txtUserName.Text.Trim());
        if (result < 1)
        {
            lblAvailable.Text = "User Name Available";
            lblAvailable.ForeColor = System.Drawing.Color.Green;
        }
        else
        {
            lblAvailable.Text = "User Name Not Available";
            lblAvailable.ForeColor = System.Drawing.Color.Red;
        }
    }
    #endregion
    
}

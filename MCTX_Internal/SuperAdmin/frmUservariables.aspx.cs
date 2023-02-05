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
using System.Text.RegularExpressions;
using System.Data.SqlClient;

public partial class MCTX_Internal_SuperAdmin_frmUservariables : System.Web.UI.Page
{
    #region Variables
    _Variables objVar = new _Variables();
    _UserTask objUTask = new _UserTask();
    _TargetSettings objTSettings = new _TargetSettings();
    #endregion

    #region Methods
    public void GetUsers()
    {
        try
        {
            DataTable dt_Users = objUTask.fnGetUsers();
            ddladduserid.DataSource = dt_Users;
            ddladduserid.DataTextField = "user_id";
            ddladduserid.DataValueField = "user_id";
            ddladduserid.DataBind();
            //ddladduserid.Items[0].Text = "--Select--";
        }
        catch (Exception ex)
        {

        }
    }
    public void GetVariables()
    {
        try
        {
            DataTable dt_Variables = objVar.fnGetVariables();
            ddlselectvariable.DataSource = dt_Variables;
            ddlselectvariable.DataTextField = "Variablename";
            ddlselectvariable.DataValueField = "variable_id";
            ddlselectvariable.DataBind();
            //ddlselectvariable.Items[0].Text = "--Select--";
        }
        catch (Exception ex)
        {

        }
    }
    public void DisplayUsers()
    {
        try
        {
            DataTable dt_Users = objUTask.fnGetUsers();
            ddldisplayuserid.DataSource = dt_Users;
            ddldisplayuserid.DataTextField = "user_id";
            ddldisplayuserid.DataValueField = "user_id";
            ddldisplayuserid.DataBind();
            //ddldisplayuserid.Items[0].Text = "--Select--";
        }
        catch (Exception ex)
        {

        }
    }
    public void Users()
    {
        try
        {
            DataTable dt_Users = objVar.fnGetUserNames();
            ddlusers.DataSource = dt_Users;
            ddlusers.DataTextField = "E_Name";
            ddlusers.DataValueField = "user_id";
            ddlusers.DataBind();
            //ddlusers.Items[0].Text = "--Select--";
        }
        catch (Exception ex)
        {

        }
    }
    // Function to test for Positive Integers. 
    public bool IsNaturalNumber(String strNumber)
    {
        Regex objNotNaturalPattern = new Regex("[^0-9]");
        Regex objNaturalPattern = new Regex("0*[1-9][0-9]*");
        return !objNotNaturalPattern.IsMatch(strNumber) &&
        objNaturalPattern.IsMatch(strNumber);
    }
    public int Validate(string commpercent, string dedpercent)
    {
        int result = 0;
        if (!IsNaturalNumber(commpercent))
        {
            if (!IsNaturalNumber(dedpercent))
            {
                return result = 1;
            }
            return result;
        }
        return result;
    }
    public void GetDuration()
    {
        try
        {
            DataTable dt_Duration = objVar.fnGetDuration();
            ddlEvalCriteria.DataSource = dt_Duration;
            ddlEvalCriteria.DataTextField = "td_name";
            ddlEvalCriteria.DataValueField = "td_id";
            ddlEvalCriteria.DataBind();
            //ddlEvalCriteria.Items[0].Text = "--Select--";
        }
        catch (Exception ex)
        {

        }
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
                lblmessage1.Text = "";
                lblmessage.Text = "";
                GetUsers();
                Users();
                DisplayUsers();
                GetVariables();
                GetDuration();
                txtaddusername.Enabled = false;
                txtDisplayusername.Text = "--Select--";
                txtaddusername.Text = "--Select--";
                txtDisplayusername.Enabled = false;
                ddladduserid_SelectedIndexChanged(null, null);
                ddldisplayuserid_SelectedIndexChanged(null, null);
                Bindvariablegrid(ddladduserid.SelectedValue);
                viewUserVariables.Visible = false;
            }
        }
        catch (Exception ex)
        {
            //   Response.Redirect("../../MCTX_General/Login.aspx");
        }
    }
    protected void btnsetvariable_Click(object sender, EventArgs e)
    {
        setvariable.Visible = true;
    }
    protected void btnaddvariable_Click(object sender, EventArgs e)
    {
        lblmessage.Text = "";
        addvariable.Visible = true;
    }
    protected void btncancelnewvariable_Click(object sender, EventArgs e)
    {
        txtaddvariablename.Text = "";
        addvariable.Visible = false;
    }
    protected void btncancel_Click(object sender, EventArgs e)
    {
        setvariable.Visible = false;
    }
    protected void btnsavenewvariable_Click(object sender, EventArgs e)
    {
        setvariable.Visible = false;
        userdays.Visible = false;
        lblErrorMessage.Text = "";
        lblmessage.Text = "";
        if (lblErrorMessage.Text != "")
        {
            int status = objVar.fnAddNewVariable(txtaddvariablename.Text);
            if (status == 1)
            {
                lblmessage1.Text = "Variable Added Successfuly";
                lblmessage1.ForeColor = System.Drawing.Color.Green;
            }
            else
            {
                lblmessage1.Text = "Variable Not Added";
                lblmessage1.ForeColor = System.Drawing.Color.Red;
            }
        }
        else
        {
            lblErrorMessage.Text = "Provide Variable";
            lblErrorMessage.ForeColor = System.Drawing.Color.Red;
        }
        GetVariables();
    }
    protected void btnsavevariable_Click(object sender, EventArgs e)
    {
        userdays.Visible = false;
        addvariable.Visible = false;
        lblmessage1.Text = "";
        int result = 1; //= Validate(txtcommissionpercent.Text,txtdeductionpercent.Text);
        if (result == 1)
        {
            int status = objVar.fnAddVarToUser(ddladduserid.SelectedValue, int.Parse(ddlselectvariable.SelectedValue), int.Parse(txtcommissionpercent.Text), int.Parse(txtdeductionpercent.Text), ddlEvalCriteria.SelectedItem.Text);
            if (status == 1)
            {
                lblmessage.Text = "Variable Added Successfuly for User: ";
                lblmessage.ForeColor = System.Drawing.Color.Green;
                Bindvariablegrid(ddladduserid.SelectedValue);
            }
            else
            {
                lblmessage.Text = "Variable Not Added";
                lblmessage.ForeColor = System.Drawing.Color.Red;
            }
        }
        else
        {
            lblmessage.Text = "Enter Positive Integer Values For Pecentages";
            lblmessage.ForeColor = System.Drawing.Color.Red;
        }
    }
    public void Bindvariablegrid(string user)
    {
        objVar.getuservariables(user);
        Variablegrid.DataSource = objVar.dt_variables;
        Variablegrid.DataBind();
    }
    protected void ddladduserid_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddladduserid.SelectedItem.Text == "--Select--")
        {
            lblmessage.Text = "Please Select Correct User ID";
            lblmessage.ForeColor = System.Drawing.Color.Red;
        }
        else
        {
            txtaddusername.Text = objTSettings.getUserName(ddladduserid.SelectedItem.Text);
        }
    }
    protected void ddldisplayuserid_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddldisplayuserid.SelectedItem.Text == "--Select--")
        {
            lblmessage1.Text = "Please Select Correct User ID";
            lblmessage1.ForeColor = System.Drawing.Color.Red;
        }
        else
        {
            txtDisplayusername.Text = objTSettings.getUserName(ddldisplayuserid.SelectedItem.Text);
            Bindvariablegrid(ddldisplayuserid.SelectedItem.Text);
        }
        Session["User_ID"] = ddldisplayuserid.SelectedValue;
    }
    protected void Variablegrid_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName == "Delete")
        {
            int status = objVar.fnDeleteVariable(int.Parse(e.CommandArgument.ToString()));
            if (status == 1)
            {
                lblmessage.Text = "Variable Deleted Successfuly";
                lblmessage.ForeColor = System.Drawing.Color.Green;
                // UserId should be of selected userid
                Bindvariablegrid(Session["User_ID"].ToString());
            }
            else
            {
                lblmessage.Text = "Variable Not Deleted";
                lblmessage.ForeColor = System.Drawing.Color.Red;
            }
        }
        if (e.CommandName == "Update")
        {

        }
        if (e.CommandName == "Edit")
        {

        }
    }
    protected void Variablegrid_RowCreated(object sender, GridViewRowEventArgs e)
    {
        e.Row.Cells[0].Visible = false;
    }
    protected void Variablegrid_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {

    }
    protected void Variablegrid_RowUpdating(object sender, GridViewUpdateEventArgs e)
    {

    }
    protected void Variablegrid_RowEditing(object sender, GridViewEditEventArgs e)
    {

    }
    protected void btnSave_Click(object sender, EventArgs e)
    {
        setvariable.Visible = false;
        addvariable.Visible = false;
        lblmessage2.Text = "";
        int value = 0;
        int status = 0;
        try
        {
            string userid = ddlusers.SelectedValue;
            value = int.Parse(txtWorkDays.Text);
            //status = objVar.fnAddUserWorkingDays(value, e_badge);
            using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionstring2"].ToString()))
            {
                SqlCommand cmd = new SqlCommand("select E_badge from user1 where user_id = '" + userid + "'", cn);
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);
                if (dt.Rows.Count > 0)
                {
                    string EBadge = dt.Rows[0]["E_badge"].ToString();
                    SqlCommand query = new SqlCommand("update tbl_Employee set WorkingDays = " + value + " where E_badge = '" + EBadge + "'", cn);
                    cn.Open();
                    status = query.ExecuteNonQuery();
                }
            }

            if (status == 1)
            {
                lblmessage2.Text = "Working Days Added Successfuly";
                lblmessage2.ForeColor = System.Drawing.Color.Green;
            }
            else
            {
                lblmessage2.Text = "Working Days Not Added";
                lblmessage2.ForeColor = System.Drawing.Color.Red;
            }
        }
        catch (Exception ex)
        {
            lblmessage2.Text = "Due to Error Working Days Not Added";
            lblmessage2.ForeColor = System.Drawing.Color.Red;
        }
        ddlusers.SelectedValue = (string)Session["UserSelected"];
    }
    protected void btnWorkingDays_Click(object sender, EventArgs e)
    {
        userdays.Visible = true;
    }
    protected void btnViewUserVariables_Click(object sender, EventArgs e)
    {
        viewUserVariables.Visible = true;
    }
    protected void ddlusers_SelectedIndexChanged(object sender, EventArgs e)
    {
        Session["UserSelected"] = ddlusers.SelectedValue;
    }

    #endregion

}

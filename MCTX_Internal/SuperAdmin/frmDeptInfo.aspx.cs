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

public partial class MCTX_Internal_SuperAdmin_frmDeptInfo : System.Web.UI.Page
{
    #region Variables
    _DepartmentInfo objDeptInfo = new _DepartmentInfo();
    string DeptName = "";
    string Phone1 = "";
    string Phone2 = "";
    string Address = "";
    int branch_id = 0;
    string designation = "";
    #endregion

    #region Methods
    public void getBranches()
    {
        try
        {
            objDeptInfo.get_Branches();

            ddlSelectBranch.DataSource = objDeptInfo.DT_Branches;
            ddlSelectBranch.DataValueField = "BRID";
            ddlSelectBranch.DataTextField = "BRANCHNAME";
            ddlSelectBranch.DataBind();
            ddlSelectBranch.Items.Insert(0, "-- Select --");
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
                getBranches();
            }
        }
        catch (Exception ex)
        {
 
        }
    }

    #endregion
    protected void btnCancel_Click(object sender, EventArgs e)
    {
        txtDeptName.Text = "";
        txtPhone1.Text = "";
        txtPhone2.Text = "";
        txtAddress.Text = "";
        ddlSelectBranch.Focus();
    }
    protected void btnSave_Click(object sender, EventArgs e)
    {
        lblMessage1.Text = "";
        lblMessage2.Text = "";
        bool Value = false;
        Value = int.TryParse(ddlSelectBranch.SelectedValue, out branch_id);
        if (Value != true)
        {
            lblMessage1.Text = "Select a Correct Branch";
            lblMessage1.ForeColor = System.Drawing.Color.Red;
            return;
        }
        DeptName = txtDeptName.Text;
        Phone1 = txtPhone1.Text;
        Phone2 = txtPhone2.Text;
        Address = txtAddress.Text;
        // Inserting Values
        int status = objDeptInfo.fnInsertDept(branch_id,DeptName, Phone1, Phone2, Address);
        if (status == 1)
        {
            lblMessage1.Text = "Successfuly Saved Data";
            lblMessage1.ForeColor = System.Drawing.Color.Green;
        }
        else
        {
            lblMessage1.Text = "Error in Saving Data";
            lblMessage1.ForeColor = System.Drawing.Color.Green;
        }
    }
    protected void btnSaveDesignation_Click(object sender, EventArgs e)
    {
        int status = 0;
        lblMessage2.Text = "";
        designation = txtdesignation.Text;
        // Inserting Values
        if (designation != "")
        {
            status = objDeptInfo.fnInsertDesignation(designation);
        }
        if (status == 1)
        {
            lblMessage1.Text = "Successfuly Saved Data";
            lblMessage1.ForeColor = System.Drawing.Color.Green;
        }
        else
        {
            lblMessage2.Text = "Error in Saving Data";
            lblMessage2.ForeColor = System.Drawing.Color.Red;
        }
    }
    protected void btnCancelDesig_Click(object sender, EventArgs e)
    {
        txtdesignation.Text = "";
        txtdesignation.Focus();
    }
}

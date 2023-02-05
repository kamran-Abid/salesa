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
using System.Text;
using System.Text.RegularExpressions;

public partial class MCTX_Internal_SuperAdmin_frmEmployee : System.Web.UI.Page
{
    #region Variables
    _Employees objEmps = new _Employees();
    string emp_id = "mctx-";
    #endregion

    #region Methods
    // Function to test for Dates (Added By Awais)
    public bool IsTrueFormatDate(string date)
    {
            string[] dateParts = date.Split('/');
            if (!(dateParts.Length > 3) && !(dateParts.Length < 3))
            {
                if ((dateParts[0].Length == 1) || (dateParts[0].Length == 2))
                {
                    if ((dateParts[1].Length == 1) || (dateParts[1].Length == 2))
                    {
                        if (!(dateParts[2].Length < 4))
                        {
                            return true;
                        }
                        return false;
                    }
                    return false;
                }
                return false;
            }
            return false;
    }
    // Function to test for Alphabets (Added By Awais)
    public bool IsAlpha(String strToCheck)
    {
        Regex objAlphaPattern = new Regex(@"^[a-zA-Z''-'\s]{1,40}$");
        return objAlphaPattern.IsMatch(strToCheck);
    }
    // Function to test for Phone Number(Added By Awais)
    public bool IsPhone(string StrPhone)
    {
        Regex objcnicPatteren = new Regex(@"^\d{2}-\d{2}-\d{7}$");
        return objcnicPatteren.IsMatch(StrPhone);
    }
    // Function to test for Mobile Phone Number(Added By Awais)
    public bool IsMobileNumber(string StrMobile)
    {
        Regex objcnicPatteren = new Regex(@"^\d{2}-\d{3}-\d{7}$");
        return objcnicPatteren.IsMatch(StrMobile);
    }
    // Function to test for Computerized N.I.Card(Added By Awais)
    public bool IsCNIC(string Strcnic)
    { 
        Regex objcnicPatteren = new Regex(@"^\d{5}-\d{7}-\d{1}$");
        return objcnicPatteren.IsMatch(Strcnic);
    }
    // Function To test for Alphabets.
    public bool IsAlphaNumeric(String strToCheck)
    {
        Regex objAlphaNumericPattern = new Regex(@"^[a-zA-Z0-9\s.\-_']+$");
        return !objAlphaNumericPattern.IsMatch(strToCheck);
    }
    // Function to test for Positive Integers with zero inclusive(Added By Awais)
    public bool IsNumber(String strNumber)
    {
        Regex objNotWholePattern = new Regex("[^0-9]");
        return !objNotWholePattern.IsMatch(strNumber);
    }
    // Function to test for Valid Email (Added By Awais)
    public bool fnValidateForm(String eMail)
    {
        Regex vEmail = new Regex(@"\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*");
        return vEmail.IsMatch(eMail);
    }
    public void BindGrid()
    {
        DataTable dt = objEmps.fnGetEmployees();
        EmployeesGrid.DataSource = dt;
        EmployeesGrid.DataBind();
    }
    public void BindDDLBranch()
    {
        try
        {
            objEmps.fnGetBranches();

            ddlBranch.DataSource = objEmps.DT_BR;
            ddlBranch.DataValueField = "BRID";
            ddlBranch.DataTextField = "BRANCHNAME";
            ddlBranch.DataBind();
            ddlBranch.Items.Insert(0, "-- Select --");
        }
        catch (Exception ex)
        {

        }
    }
    public void  BindDDLDepartment()
    {
        try
        {
            objEmps.fnGetDepartments();

            ddlDepartment.DataSource = objEmps.DT_DEP;
            ddlDepartment.DataValueField = "D_ID";
            ddlDepartment.DataTextField = "D_NAME";
            ddlDepartment.DataBind();
            ddlDepartment.Items.Insert(0, "-- Select --");
        }
        catch (Exception ex)
        {

        }
    }
    public void BindDDLDesignation()
    {
        try
        {
            objEmps.fnGetDesignations();

            ddlDesignation.DataSource = objEmps.DT_DES;
            ddlDesignation.DataValueField = "ID";
            ddlDesignation.DataTextField = "Desig_Name";
            ddlDesignation.DataBind();
            ddlDesignation.Items.Insert(0, "-- Select --");
        }
        catch (Exception ex)
        {

        }
    }
    public void OpenFields()
    {
        txtEmpID.Text = "";
        txtEmpName.Text = "";
        txtPhone.Text = "";
        txtMobile.Text = "";
        ddlGender.SelectedIndex = 0;
        txtEducation.Text = "";
        txtCNIC.Text = "";
        txtAddress.Text = "";
        txtPhone1.Text = "";
        txtGaurdianMobile.Text = "";
        ddlBranch.SelectedIndex = 0;
        ddlDepartment.SelectedIndex = 0;
        ddlDesignation.SelectedIndex = 0;
        txtStartDate.Text = "";
        txtBasicSalary.Text = "";
        txtMobileAllow.Text = "";
        txtOtherAllow.Text = "";
        txtTravllingAllow.Text = "";
    }
    public int ValidateFields(string Address,string BasicSalary,string CNIC,string Education,string EmpID,string EmpName,string DOB,string GaurdianMobile,string Mobile,string MobileAllow,string OtherAllow,string Phone,string Gender,string Phone1,int Branch,int Department,int Designation,string StartDate,string TravlingAllow)
    {
        if (Address != "")
        {
            if (BasicSalary != "")
            {
                if (!IsNumber(BasicSalary))
                    return 0;
                if(CNIC != "")
                {
                    if (!IsCNIC(CNIC))
                        return 0;
                    if(Education != "")
                    {
                        if(!IsAlpha(Education))
                            return 0;
                        if(EmpID != "")
                        {
                            //if (!IsAlphaNumeric(EmpID))
                            //    return 0;
                            if (EmpName != "")
                            {
                                //if (!IsAlpha(EmpName))
                                //    return 0;
                                if(DOB != "")
                                {
                                    //if (!IsTrueFormatDate(DOB))
                                    //    return 0;
                                    if (GaurdianMobile != "")
                                    {
                                        //if(!IsMobileNumber(GaurdianMobile))
                                        //    return 0;
                                        if (Mobile != "")
                                        {
                                            //if (!IsMobileNumber(Mobile))
                                            //    return 0;
                                            if (MobileAllow != "")
                                            {
                                                //if (!IsNumber(MobileAllow))
                                                //    return 0;
                                                if (OtherAllow != "")
                                                {
                                                    //if (!IsNumber(OtherAllow))
                                                    //    return 0;
                                                    if (Phone != "")
                                                    {
                                                        //if(!IsPhone(Phone))
                                                        //    return 0;
                                                        if (Gender != "")
                                                        {
                                                            //if (!IsAlpha(Gender))
                                                            //    return 0;
                                                            if(Phone1 != "")
                                                            {
                                                                //if (!IsPhone(Phone1))
                                                                //    return 0;
                                                                if(Branch.ToString() != "")
                                                                {
                                                                    //if (!IsNumber(Branch.ToString()))
                                                                    //    return 0;
                                                                    if (Department.ToString() != "")
                                                                    {
                                                                        //if (!IsNumber(Department.ToString()))
                                                                        //    return 0;
                                                                        if (Designation.ToString() != "")
                                                                        {
                                                                            //if (!IsNumber(Designation.ToString()))
                                                                            //    return 0;
                                                                            if(StartDate != "")
                                                                            {
                                                                                //if (!IsTrueFormatDate(StartDate))
                                                                                //    return 0;
                                                                                if(TravlingAllow != "")
                                                                                {
                                                                                    //if (!IsNumber(BasicSalary))
                                                                                    //    return 0;
                                                                                    return 1;
                                                                                }
                                                                            }
                                                                        }
                                                                    }
                                                                }
                                                            }
                                                        }
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
        return 1;
    }
    public void GetEmpRecord(string empId)
    {
        try
        {
            //ddlDepartment.Items.Clear();
            //ddlDesignation.Items.Clear();
            
            DataTable dt = objEmps.fnGetEmpRecord(empId);
            // Populating the Data Into Controls
            txtEmpID.Text = dt.Rows[0]["E_badge"].ToString();
            txtEmpName.Text = dt.Rows[0]["E_Name"].ToString();
            txtPhone.Text = dt.Rows[0]["E_PhNo1"].ToString();
            txtMobile.Text = dt.Rows[0]["E_Mobile"].ToString();
            ddlGender.SelectedValue = dt.Rows[0]["E_Sex"].ToString();
            txtEducation.Text = dt.Rows[0]["E_Education"].ToString();
            txtCNIC.Text = dt.Rows[0]["E_NIC"].ToString();
            try
            {
                txtDOB.Text = dt.Rows[0]["DOB"].ToString().Substring(0, 9);

            }
            catch (Exception ex)
            {
                txtDOB.Text = "";
            }
            
            txtAddress.Text = dt.Rows[0]["E_Address"].ToString();
            txtPhone1.Text = dt.Rows[0]["E_PhNo2"].ToString();
            txtGaurdianMobile.Text = dt.Rows[0]["FatherMobile"].ToString();
            txtStartDate.Text = dt.Rows[0]["E_EmpDate"].ToString();
            txtBasicSalary.Text = dt.Rows[0]["BasicSalary"].ToString();
            txtTravllingAllow.Text = dt.Rows[0]["ConvenceAllowence"].ToString();
            txtOtherAllow.Text = dt.Rows[0]["MiscAllowence"].ToString();
            txtMobileAllow.Text = dt.Rows[0]["MobileAllowence"].ToString();
            ddlBranch.SelectedValue = dt.Rows[0]["BRID"].ToString();
            ddlDepartment.SelectedValue = dt.Rows[0]["Dp_Id"].ToString();
            ddlDesignation.SelectedValue = dt.Rows[0]["Ds_id"].ToString();
        }
        catch (Exception ex)
        { 
            
        }
    }
    public void BlockFields()
    {
        txtEmpID.Enabled = false;
        txtEmpName.Enabled = false;
        txtPhone.Enabled = false;
        txtMobile.Enabled = false;
        ddlGender.Enabled = false;
        txtEducation.Enabled = false;
        txtCNIC.Enabled = false;
        txtAddress.Enabled = false;
        txtPhone1.Enabled = false;
        txtGaurdianMobile.Enabled = false;
        ddlBranch.Enabled = false;
        ddlDepartment.Enabled = false;
        ddlDesignation.Enabled = false;
        txtStartDate.Enabled = false;
        txtBasicSalary.Enabled = false;
        txtMobileAllow.Enabled = false;
        txtOtherAllow.Enabled = false;
        txtTravllingAllow.Enabled = false;
        btnSave.Enabled = false;
        btnCancel.Enabled = false;
    }
    public void EnableFields()
    {
        txtEmpID.Enabled = true;
        txtEmpName.Enabled = true;
        txtPhone.Enabled = true;
        txtMobile.Enabled = true;
        ddlGender.Enabled = true;
        txtEducation.Enabled = true;
        txtCNIC.Enabled = true;
        txtAddress.Enabled = true;
        txtPhone1.Enabled = true;
        txtGaurdianMobile.Enabled = true;
        ddlBranch.Enabled = true;
        ddlDepartment.Enabled = true;
        ddlDesignation.Enabled = true;
        txtStartDate.Enabled = true;
        txtBasicSalary.Enabled = true;
        txtMobileAllow.Enabled = true;
        txtOtherAllow.Enabled = true;
        txtTravllingAllow.Enabled = true;
        btnSave.Enabled = true;
        btnCancel.Enabled = true;
    }
    public void clearFileds()
    {

        txtEmpID.Text = "";
        txtEmpName.Text = "";
        txtPhone.Text = "";
        txtMobile.Text = "";
        //ddlGender.Text = "";
        txtEducation.Text = "";
        txtCNIC.Text = "";
        txtAddress.Text = "";
        txtPhone1.Text = "";
        txtGaurdianMobile.Text = "";
        //ddlBranch.Text = "";
        //ddlDepartment.Text = "";
        //ddlDesignation.Text = "";
        txtStartDate.Text = "";
        txtBasicSalary.Text = "";
        txtMobileAllow.Text = "";
        txtOtherAllow.Text = "";
        txtTravllingAllow.Text = "";
            
    }
    #endregion

    #region Events
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
                Session["userName"] = Request.Cookies["userName"].Value.ToString();
                string username = Session["userName"].ToString();
            }

            string role = Request.Cookies["Role"].Value.ToString();
            if (role == "")
            {
              role =  Session["Role"].ToString();
            }
            if (role != "Super Admin" && role != "Admin")
            {
                Response.Redirect("Accessdenied.aspx");
                return;
            }
            
            if (!IsPostBack)
            {
                //int counter = 101;
                Session["counter"] = 101;
                txtEmpID.Text = emp_id;
                BlockFields();
                BindGrid();
                // Bind Data to Designation, Department & Branch DropDown Lists
                BindDDLBranch();
                BindDDLDepartment();
                BindDDLDesignation();
                txtStartDate.Text = DateTime.Now.ToShortDateString();
                txtStartDate.Enabled = false;
                txtEmpID.Attributes.Add("onBlur", "validate()");
                txtEmpID.Attributes.Add("focus","");
            }
        }
        catch (Exception ex)
        {
            Response.Redirect("../../MCTX_General/Login.aspx");
        }
    }
    protected void EmployeesGrid_RowUpdating(object sender, GridViewUpdateEventArgs e)
    {
        GridViewRow row = EmployeesGrid.Rows[e.RowIndex];
        Label lblEmpId = row.FindControl("lblEmpNo") as Label;
        
        EmployeesGrid.EditIndex = -1;
        BindGrid();
    }
    protected void EmployeesGrid_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {
        BindGrid();
    }
    protected void EmployeesGrid_RowEditing(object sender, GridViewEditEventArgs e)
    {
        EmployeesGrid.EditIndex = e.NewEditIndex;
        BindGrid();
    }
    protected void EmployeesGrid_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName == "Delete")
        {
            string emp_id = e.CommandArgument.ToString();
            int status = objEmps.fnDeleteEmployee(emp_id);
            if (status == 1)
            {
                lblMessage.Text = "Successfuly Deleted Employee";
                lblMessage.ForeColor = System.Drawing.Color.Green;
            }
            else
            {
                lblMessage.Text = "Error in Deleting Employee";
                lblMessage.ForeColor = System.Drawing.Color.Red;
            }
        }
        if (e.CommandName == "Edit")
        {
            try
            {
                string empId = e.CommandArgument.ToString();
                GetEmpRecord(empId);
                EnableFields();
                btnSave.Text = "Update";
            }
            catch (Exception ex)
            { 
                
            }
        }
    }
    protected void EmployeesGrid_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
    {
        EmployeesGrid.EditIndex = -1;
        BindGrid();
        
    }
    protected void btnSave_Click(object sender, EventArgs e)
    {
        int status = 0;
        
            string Address = txtAddress.Text;
            string BasicSalary = txtBasicSalary.Text;
            string CNIC = txtCNIC.Text;
            string Education = txtEducation.Text;
            string EmpID = txtEmpID.Text;
            string EmpName = txtEmpName.Text;
            string DOB = txtDOB.Text;
            string GaurdianMobile = txtGaurdianMobile.Text;
            string Mobile = txtMobile.Text;
            string MobileAllow = txtMobileAllow.Text;
            string OtherAllow = txtOtherAllow.Text;
            string Phone = txtPhone.Text;
            string Gender = ddlGender.SelectedItem.Text;
            string Phone1 = txtPhone1.Text;
            int Branch = int.Parse(ddlBranch.SelectedValue);
            int Department = int.Parse(ddlDepartment.SelectedValue);
            int Designation = int.Parse(ddlDesignation.SelectedValue);
            string StartDate = txtStartDate.Text;
            string TravlingAllow = txtTravllingAllow.Text;
            // Validating User Input
            int result = ValidateFields(Address, BasicSalary, CNIC, Education, EmpID, EmpName, DOB, GaurdianMobile, Mobile, MobileAllow, OtherAllow, Phone, Gender, Phone1, Branch, Department, Designation, StartDate, TravlingAllow);
            if (btnSave.Text == "Save")
            {
                // Function to Add Employee Record
                status = objEmps.fnAddEmployee(Address, BasicSalary, CNIC, Education, EmpID, EmpName, DOB, GaurdianMobile, Mobile, MobileAllow, OtherAllow, Phone, Gender, Phone1, Branch, Department, Designation, StartDate, TravlingAllow);
                if (status == 1)
                {
                    int counter = (int)Session["counter"];
                    counter++;
                    Session["counter"] = counter;
                    lblMessage.Text = "Record Saved Successfuly";
                    lblMessage.ForeColor = System.Drawing.Color.Green;
                    OpenFields();
                }
                else
                {
                    lblMessage.Text = "Record Not Saved";
                    lblMessage.ForeColor = System.Drawing.Color.Red;
                }
            }
            else if (btnSave.Text == "Update")
            {
                result = ValidateFields(Address, BasicSalary, CNIC, Education, EmpID, EmpName, DOB, GaurdianMobile, Mobile, MobileAllow, OtherAllow, Phone, Gender, Phone1, Branch, Department, Designation, StartDate, TravlingAllow);
                if (result == 1)
                {
                    status = objEmps.fnUpdateEmployee(Address, BasicSalary, CNIC, Education, EmpID, EmpName, DOB, GaurdianMobile, Mobile, MobileAllow, OtherAllow, Phone, Gender, Phone1, Branch, Department, Designation, StartDate, TravlingAllow);
                    if (status == 1)
                    {
                        lblMessage.Text = "Record Updated Successfuly";
                        lblMessage.ForeColor = System.Drawing.Color.Green;
                    }
                    else
                    {
                        lblMessage.Text = "Record Not Updated";
                        lblMessage.ForeColor = System.Drawing.Color.Red;
                    }
                }
                else
                {
                    lblMessage.Text = "Record Not Updated";
                    lblMessage.ForeColor = System.Drawing.Color.Red;
                }
            }
    }
    protected void btnCancel_Click(object sender, EventArgs e)
    {
        OpenFields();
        txtEmpID.Focus();
    }
    protected void btnAddNewEmployee_Click(object sender, EventArgs e)
    {
        clearFileds();
        txtEmpID.Text = "";
        EnableFields();
    }

    #endregion
    
}

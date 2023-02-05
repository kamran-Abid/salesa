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

public partial class MCTX_Internal_SuperAdmin_frmSetTarget : System.Web.UI.Page
{
    #region Variables
    _TargetSettings objTSettings = new _TargetSettings();
    ListBox lboxVisitTypes = new ListBox();
    DataTable dt_AddVisit = new DataTable();
    int targetsetid = 0;
    
    #endregion

    #region Methods
    private void get_Targettypes()
    {
        try
        {
            objTSettings.get_TargetTypes();

            for (int i = 0; i < objTSettings.AL_Target_Types.Count; i++)
            {
                ddlTargetType.Items.Add(objTSettings.AL_Target_Types[i].ToString());
                ddlTargetType.Items[0].Text = "--Select--";
            }
        }
        catch (Exception ex)
        {

        }
    }
    public void get_Users()
    {
        try
        {
            objTSettings.get_Users();

            for (int i = 0; i < objTSettings.AL_Users.Count; i++)
            {
                ddlLoginName.Items.Add(objTSettings.AL_Users[i].ToString());
                ddlLoginName.Items[0].Text = "--Select--";
            }
        }
        catch (Exception ex)
        {

        }
    }
    public void GetTargetDuration()
    {
        try
        {
            ArrayList AL_TD = objTSettings.get_TarDuration();
            ddlEvalOn.DataSource = AL_TD;
            ddlEvalOn.DataBind();
            ddlEvalOn.Items[0].Text = "--Select--";
        }
        catch (Exception ex)
        {

        }
    }
    public DataTable MakeTable()
    {
        // Adding New Table of Target Information
        DataTable dt = new DataTable();
        // Add new Columns
        dt.Columns.Add(new DataColumn("Target Type", typeof(string)));
        dt.Columns.Add(new DataColumn("Evalution Type", typeof(string)));
        dt.Columns.Add(new DataColumn("Target Amount", typeof(string)));
        return dt;
    }
    public void BindGridAdd(DataTable dt)
    {
        GridTargetAdd.DataSource = dt;
        GridTargetAdd.DataBind();
    }
    public void get_UsersList()
    {
        try 
        {
            DataTable dt = objTSettings.fnGetUsersList();

            GridAllTargets.DataSource = dt;
            GridAllTargets.DataBind();
        }
        catch(Exception ex)
        {
            
        }
    }
    public void BindGridTargetsDetail(int settingid)
    {
        DetailsGrid.Visible = true;
        ddlTargetType.Enabled = false;
        ddlEvalOn.Enabled = false;
        //ddlDeductionPercentage.Enabled = false;
        //ddlVisitPercentage.Enabled = false;
        txtTargetAmount.Enabled = false;
        txtNoOfVisits.Enabled = false;
        DataSet ds = new DataSet();
        try
        {
            ds.Clear();
            ds = objTSettings.fnGetDetails(settingid);
            // Adding Setting_Id to Each Row
            ds.Tables["Targetdetails_information"].Columns.Add("Setting_id", typeof(int));
            //DetailsGrid.DataSource = dt;
            //DetailsGrid.DataBind();
            ddlLoginName.Text = ds.Tables["Target_information"].Rows[0][0].ToString();
            ddlLoginName.Enabled = false;
            txtUserName.Text = ds.Tables["Target_information"].Rows[0][1].ToString();
            txtUserName.Enabled = false;
            txtStartDate.Text = ds.Tables["Target_information"].Rows[0][2].ToString();
            txtStartDate.Enabled = false;
            txtEndDate.Text = ds.Tables["Target_information"].Rows[0][3].ToString();
            txtEndDate.Enabled = false;
            //txtStartTime.Text = ds.Tables["Target_information"].Rows[0][4].ToString();
            //txtStartTime.Enabled = false;
            //txtEndTime.Text = ds.Tables["Target_information"].Rows[0][5].ToString();
            //txtEndTime.Enabled = false;
            for (int j = 0; j < 3; j++)
            {
                ds.Tables["Targetdetails_information"].Rows[j]["Setting_id"] = settingid;
            }
            ViewState["settingid"] = settingid;
            ViewState["Targetdetails_info"] = ds.Tables["Targetdetails_information"];
            target_details.Visible = true;
            DetailsGrid.DataSource = ds.Tables["Targetdetails_information"];
            DetailsGrid.DataBind();
            
        }
        catch (Exception ex)
        {

        }
    }
    public void OpenControls()
    {
        //ddlLoginName.Enabled = true;
        txtEndDate.Enabled = true;
        txtStartDate.Enabled = true;
        ddlhourStartTime.Enabled = true;
        ddlhourEndTime.Enabled = true;
        
    }
    public void getTargetSettingData(int Tarset_id)
    {
        //fngetTargetSettingData(Tarset_id);
        //BindGridDetails();
    }
    public void BindGridDetails()
    {
        //DetailsGrid.DataSource = objTSettings.dt_DetailsTarget;
        //DetailsGrid.DataBind();
    }
    public DataTable PopulateTTDropDownList()
    {
        DataTable dt = objTSettings.fnGeTargetTypes();
        return dt; 
    }
    public bool ValidateTarget(string ttype)
    {
        DataTable dt = (DataTable)ViewState["Targetdetails_info"];
        for(int i =0;i<dt.Rows.Count;i++)
        {
            string targettype = dt.Rows[i]["tt_name"].ToString();
            if (i != int.Parse(ViewState["EditIndex"].ToString()))
            {
                if (targettype.Equals(ttype))
                    return false;
            }
            
        }
        return true;
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
        { }
        try
        {
            if (!IsPostBack)
            {
                DataTable dt = new DataTable();
                // Populating Target Types in DropDownList
                get_Targettypes();
                // Populating Users in DropDownList
                get_Users();
                btnSave.Enabled = false;
                btnCancel.Enabled = false;
                dt = MakeTable();
                // Saving Data into ViewState
                ViewState["TargetData"] = dt;
                //Getting User List Data
                get_UsersList();
                //TargetDetailsDiv.Visible = false;
                ArrayList AL_VPercent = new ArrayList();
                ArrayList AL_DedPercent = new ArrayList();
                ArrayList AL_TarType = new ArrayList();
                ArrayList AL_TarEval = new ArrayList();
                ViewState["AL_DedPercent"] = AL_DedPercent;
                ViewState["AL_VPercent"] = AL_VPercent;
                ViewState["AL_TarType"] = AL_TarType;
                ViewState["AL_TarEval"] = AL_TarEval;
                // GetTargetDuration();
                lblTarget.Visible = false;
                target_details.Visible = false;
                divButtonsNewTarget.Visible = false;
                ddlhourStartTime.Enabled = false;
                txtStartDate.Enabled = false;
                ddlhourEndTime.Enabled = false;
                txtEndDate.Enabled = false;
                txtUserName.Enabled = false;
                ddlLoginName.Enabled = false;
                divEditUpdate.Visible = false;
            }
        }
        catch (Exception ex)
        { 
            
        }
    }

    protected void btnAdd_Click(object sender, EventArgs e)
    {
        lblTarget.Text = "Target";
        lblMessage.Text = "";
        lblTarget.Visible = true;
        int found = 0;
        // Declaring a row
        DataRow dr = null;
        dt_AddVisit = (DataTable)ViewState["TargetData"];
        string TargetAmount = "";
        string NoOfVisits = "";

        string TargetType = ddlTargetType.SelectedItem.Text.ToString();
        ArrayList AL_TTyp = (ArrayList)ViewState["AL_TarType"];
        AL_TTyp.Add(ddlTargetType.SelectedIndex);
        ViewState["AL_TarType"] = AL_TTyp;

        string EvalType = ddlEvalOn.SelectedItem.Text.ToString();
        ArrayList AL_EType = (ArrayList)ViewState["AL_TarEval"];
        AL_EType.Add(ddlEvalOn.SelectedItem.Text);
        ViewState["AL_TarEval"] = AL_EType;

        if (txtTargetAmount.Text != "")
        {
            TargetAmount = txtTargetAmount.Text;
        }
        else
        {
            NoOfVisits = txtNoOfVisits.Text;
        }
        if (TargetAmount != "" || NoOfVisits != "")
        {
            dr = dt_AddVisit.NewRow();
            if (dt_AddVisit.Rows.Count == 0)
            {
                dr["Target Type"] = TargetType;
                dr["Evalution Type"] = EvalType;
                if (txtTargetAmount.Text != "")
                {
                    dr["Target Amount"] = TargetAmount;
                }
                else
                {
                    dr["Target Amount"] = NoOfVisits;
                }

                // Adding new Row to Grid
                dt_AddVisit.Rows.Add(dr);
                BindGridAdd(dt_AddVisit);
                // Saving Data into ViewState
                ViewState["TargetData"] = dt_AddVisit;
            }
            else
            {
                string[] TarTypes = new string[dt_AddVisit.Rows.Count];
                for (int i = 0; i < dt_AddVisit.Rows.Count; i++)
                {
                    TarTypes[i] = dt_AddVisit.Rows[i]["Target Type"].ToString();
                    if (TarTypes.Length != 0)
                    {
                        if (TargetType.Equals(TarTypes[i]))
                        {
                            found = 1;
                            break;
                        }
                    }
                }
                if (found == 0)
                {
                    dr["Target Type"] = TargetType;
                    dr["Evalution Type"] = EvalType;
                    if (txtTargetAmount.Text != "")
                    {
                        dr["Target Amount"] = TargetAmount;
                    }
                    else
                    {
                        dr["Target Amount"] = NoOfVisits;
                    }
                    // Adding new Row to Grid
                    dt_AddVisit.Rows.Add(dr);
                    BindGridAdd(dt_AddVisit);
                    // Saving Data Into View State
                    ViewState["TargetData"] = dt_AddVisit;
                }
                else
                {
                    lblMessage.Text = "You Have Already Added This Type of Visit/Target";
                    lblMessage.ForeColor = System.Drawing.Color.Red;
                }
            }
        }
        else
        {
            lblMessage.Text = "Enter Correct Target Amount / Visits Amount";
            lblMessage.ForeColor = System.Drawing.Color.Red;
        }
        // Get and Save Deduction and Visit Percentages into ArrayList
        //ArrayList AL_VP = (ArrayList)ViewState["AL_DedPercent"];
        //AL_VP.Add(ddlVisitPercentage.SelectedValue);
        //ArrayList AL_DP = (ArrayList)ViewState["AL_VPercent"];
        //AL_DP.Add(ddlDeductionPercentage.SelectedValue);
        // Saving Percentage Data into View State
        //ViewState["AL_VPercent"] = AL_VP;
        //ViewState["AL_DedPercent"] = AL_DP;
        // Making Row & Data Null
        dr = null;
        TargetType = null;
        EvalType = null;
        TargetAmount = null;
    }
    protected void btnSave_Click(object sender, EventArgs e)
    {
        int result1 = 0;
        int result2 = 0;
        try
        {
            //Table Setting Data
            string uname = ddlLoginName.SelectedItem.Text;
            string startDate = txtStartDate.Text;
            string endDate = txtEndDate.Text;
            string startTime = ddlhourStartTime.SelectedItem.Text;
            string endTime = ddlhourEndTime.SelectedItem.Text;

            objTSettings.checkexistancetarget(uname, startDate);
            if (objTSettings.dt_targExist.Rows.Count > 0)
            {
                lblMessage.Text = "Target already exists for this user during this period";
                lblMessage.ForeColor = System.Drawing.Color.Red;
                return;
            }
                       
                //Insert Record into Setting Table
               result1 = objTSettings.fnInsertSetting(startDate, endDate, uname, startTime, endTime);
                // Getting Targetsetting Data
                DataTable dt = (DataTable)ViewState["TargetData"];
                // Inserting data into DB
                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    ArrayList AL_TargetType = (ArrayList)ViewState["AL_TarType"];
                    ArrayList AL_EvalutionType = (ArrayList)ViewState["AL_TarEval"];
                    int TargetType = int.Parse(AL_TargetType[i].ToString());
                    string EvalutionType = AL_EvalutionType[i].ToString();
                    float TargetAmount = float.Parse(dt.Rows[i]["Target Amount"].ToString());
                    DataTable settingId = objTSettings.fnGetSettingId();
                    int set_id = int.Parse(settingId.Rows[0][0].ToString());
                    ///////////////////////////////////////////
                    // Inserting Data
                    result2 = objTSettings.fnInsertTarget(TargetType, TargetAmount, set_id, EvalutionType);
                }
                if (result1 == 1)
                {
                    lblMessage.Visible = true;
                    lblMessage.Text = "Record saved successfully";
                    lblMessage.ForeColor = System.Drawing.Color.Green;

                    if (result2 == 1)
                    {
                        lblMessage.Text = lblMessage.Text + " ... ";
                        lblMessage.ForeColor = System.Drawing.Color.Green;
                    }
                }
                   
                else
                {
                    lblMessage.Visible = true;
                    lblMessage.Text = "Error while inserting record";
                    lblMessage.ForeColor = System.Drawing.Color.Red;
                }
            
        }
        catch (Exception ex)
        {
            lblMessage.Text = ex.Message.ToString();
            lblMessage.ForeColor = System.Drawing.Color.Red;
        }
        btnAdd.Enabled = false;
        btnCancel.Enabled = false;
        btnDone.Enabled = false;
        btnSave.Enabled = false;
        divGridAddTarget.Visible = false;
        lblTarget.Text = "";       
    }
    protected void btnCancel_Click(object sender, EventArgs e)
    {
        btnDone.Enabled = false;
        btnSave.Enabled = false;
        btnCancel.Enabled = false;
        btnAdd.Enabled = false;
        txtUserName.Enabled = true;
        txtUserName.Text = "";
        txtStartDate.Text = "";
        txtEndDate.Text = "";
        ddlhourStartTime.SelectedIndex = 0;
        ddlhourEndTime.SelectedIndex = 0;
        txtNoOfVisits.Text = "";
        txtNoOfVisits.Enabled = true;
        txtTargetAmount.Text = "";
        lblMessage.Text = "";
        // Disabling the Contrls
        txtUserName.Enabled = false;
        txtStartDate.Enabled = false;
        txtEndDate.Enabled = false;
        ddlhourStartTime.Enabled = false;
        ddlhourEndTime.Enabled = false;
        txtNoOfVisits.Enabled = false;
        txtTargetAmount.Enabled = false;
        ddlEvalOn.Enabled = false;
        ddlLoginName.Enabled = false;
        ddlTargetType.Enabled = false;
        divGridAddTarget.Visible = false;
    }
    protected void ddlLoginName_SelectedIndexChanged(object sender, EventArgs e)
    {
        string lname = ddlLoginName.SelectedItem.Text.ToString();
        string FullName = objTSettings.getUserName(lname);
        txtUserName.Text = FullName;
        txtUserName.Enabled = false;
    }
    protected void ddlTargetType_SelectedIndexChanged(object sender, EventArgs e)
    {
        txtNoOfVisits.Text = "";
        txtTargetAmount.Text = "";
        txtTargetAmount.Enabled = true;
        txtNoOfVisits.Enabled = true;
        if (ddlTargetType.SelectedItem.Text == "Sale")
        {
            txtNoOfVisits.Enabled = false;
        }
        else if (ddlTargetType.SelectedItem.Text != "Sale")
        {
            txtTargetAmount.Enabled = false;
        }
    }
    protected void GridAllTargets_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName == "View")
        {
            lblMessage.Text = "";
            int setting_id = int.Parse(e.CommandArgument.ToString());
            ViewState["setting_id"] = setting_id;
            BindGridTargetsDetail(setting_id);
            divEditUpdate.Visible = true;
        }
    }
    protected void btnDone_Click1(object sender, EventArgs e)
    {
        btnSave.Enabled = true;
        btnCancel.Enabled = true;
        btnAdd.Enabled = false;
        ddlLoginName.Enabled = false;
        txtStartDate.Enabled = false;
        txtEndDate.Enabled = false;
        ddlhourStartTime.Enabled = false;
        ddlhourEndTime.Enabled = false;
        ddlTargetType.Enabled = false;
        ddlEvalOn.Enabled = false;
        txtNoOfVisits.Enabled = false;
        txtTargetAmount.Enabled = false;

        //ddlVisitPercentage.Enabled = false;
        //ddlDeductionPercentage.Enabled = false;
    }
    protected void btnAddNewTarget_Click(object sender, EventArgs e)
    {
        dt_AddVisit = (DataTable)ViewState["TargetData"];
        dt_AddVisit = new DataTable();
        btnSave.Enabled = false;
        btnDone.Enabled = true;
        btnCancel.Enabled = true;
        btnAdd.Enabled = true;
        DetailsGrid.Visible = false;
        ddlLoginName.Enabled = true;
        ddlLoginName.SelectedIndex = 0;
        txtUserName.Text = "";
        txtStartDate.Text = "";
        txtStartDate.Enabled = true;
        txtEndDate.Text = "";
        txtEndDate.Enabled = true;
        ddlhourStartTime.SelectedIndex = 0;
        ddlhourStartTime.Enabled = true;
        ddlhourEndTime.SelectedIndex = 0;
        ddlhourEndTime.Enabled = true;
        txtNoOfVisits.Text = "";
        txtNoOfVisits.Enabled = true;
        txtTargetAmount.Text = "";
        txtTargetAmount.Enabled = true;
        lblMessage.Text = "";
        ddlTargetType.Enabled = true;
        ddlTargetType.SelectedIndex = 0;
        ddlEvalOn.Enabled = true;
        ddlEvalOn.SelectedIndex = 0;
        divButtonsNewTarget.Visible = true;
    }
    protected void btnRefresh_Click(object sender, EventArgs e)
    {
        get_UsersList();
    }
    protected void DetailsGrid_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        DataTable dt_targetData = (DataTable)ViewState["Targetdetails_info"];
        DataTable dtUpdateData = new DataTable();
        // Copying Schema into Other Table
        dtUpdateData = dt_targetData.Clone();

        if (e.CommandName == "Edit")
        {

            targetsetid = int.Parse(e.CommandArgument.ToString());
            ViewState["targetsetid"] = targetsetid;
            OpenControls();
            for (int k = 0; k < 3; k++)
            {
                DataRow newRow = dtUpdateData.NewRow();
                dtUpdateData.Rows.Add(newRow);
            }
            // Getting Values From Respective Controls
            for (int i = 0; i < 3; i++)
            {
                dtUpdateData.Rows[i]["tt_name"] = dt_targetData.Rows[i]["tt_name"];
                dtUpdateData.Rows[i]["actual_target"] = dt_targetData.Rows[i]["actual_target"];
                dtUpdateData.Rows[i]["Evaluation_on"] = dt_targetData.Rows[i]["Evaluation_on"];
                dtUpdateData.Rows[i]["Setting_id"] = dt_targetData.Rows[i]["setting_id"];
                dtUpdateData.Rows[i]["ts_id"] = dt_targetData.Rows[i]["ts_id"];
            }
            // Saving Target DataTable into ViewState
            Session["Target"] = dtUpdateData;
        }
    }
    protected void DetailsGrid_RowUpdating(object sender, GridViewUpdateEventArgs e)
    {
            // int result1 = 0;
            int result2 = 0;
            int targettype_id = 0;
            int setting_id = (int)ViewState["settingid"];
            /////////////////////////////////////////////
            int EditIndex = (int)ViewState["EditIndex"];
            DropDownList drdList1 = (DropDownList)(DetailsGrid.Rows[EditIndex].Cells[0].FindControl("ddltt_name"));
            //DropDownList ddltt_name = ((DropDownList)DetailsGrid.FindControl("ddltt_name") as DropDownList).SelectedValue;
            targettype_id = int.Parse(drdList1.SelectedValue);
            //DropDownList EvalOn = ((DropDownList)DetailsGrid.FindControl("ddlEvalOn") as DropDownList);
            DropDownList drdList2 = (DropDownList)(DetailsGrid.Rows[EditIndex].Cells[2].FindControl("ddlEvalOn"));
            string Eval_type = drdList2.SelectedItem.Text;
            TextBox txtActualTarget = DetailsGrid.Rows[e.RowIndex].FindControl("txtActualTarget") as TextBox;   
            //int setting_id = (int)ViewState["settingid"];
            int old_tt_id = int.Parse(ViewState["old_tt_id"].ToString());
            //int targetsetting_id = objTSettings.fnGetTargetSettingID(setting_id, old_tt_id);
            float actual_target = float.Parse(txtActualTarget.Text);
            if (ValidateTarget(drdList1.SelectedItem.Text))
            {
                result2 = objTSettings.fnUpdateTarget(targettype_id, actual_target, Eval_type, int.Parse(ViewState["targetsetid"].ToString()));
                if (result2 == 1)
                {
                    lblMessage.Text = "Successfuly Updated Target Information";
                    lblMessage.ForeColor = System.Drawing.Color.Green;
                    int set_id = (int)ViewState["settingid"];
                    DetailsGrid.EditIndex = -1;
                    BindGridTargetsDetail(set_id);

                }
                else
                {
                    lblMessage.Text = "Error in Updating Target Information";
                    lblMessage.ForeColor = System.Drawing.Color.Red;
                }
            }
            else
            {
                lblMessage.Text = "You Can Add a Visit Type once only";
                lblMessage.ForeColor = System.Drawing.Color.Red;
            }
            ddlhourStartTime.Enabled = false;
            ddlhourEndTime.Enabled = false;
    }
    protected void DetailsGrid_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
    {
        int setting_id = (int)ViewState["settingid"];
        DetailsGrid.EditIndex = -1;
        BindGridTargetsDetail(setting_id);
    }
    protected void DetailsGrid_RowEditing(object sender, GridViewEditEventArgs e)
    {
        //open = true;
        int setting_id = (int)ViewState["settingid"];
            
        DetailsGrid.EditIndex = e.NewEditIndex;
        ViewState["EditIndex"] = DetailsGrid.EditIndex;
        
        BindGridTargetsDetail(setting_id);
        DropDownList drdList1 = (DropDownList)(DetailsGrid.Rows[e.NewEditIndex].Cells[0].FindControl("ddltt_name"));
        ViewState["old_tt_id"] = drdList1.SelectedValue;
        ///////////////////////////NEW ROW/////////////////////////////
        //drdList1.SelectedItem.Text = ViewState["lblTT_name"].ToString();
    }
    protected void btncal_Click(object sender, EventArgs e)
    {

    }
    protected void btnSetVariables_Click(object sender, EventArgs e)
    {
        Response.Redirect("frmUservariables.aspx");
    }
    #endregion    
    
    
}

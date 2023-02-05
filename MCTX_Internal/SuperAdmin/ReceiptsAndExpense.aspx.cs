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
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Runtime.Serialization.Json;
using System.Web.Script.Serialization;
using System.Web.Services;



public partial class MCTX_Internal_ReceiptsAndExpense : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

        if (Session["Role"] != null)
            txtUserRole.Text = Session["Role"].ToString();
        if (txtUserRole.Text != "Admin")
        {
            divCashDispersement.Visible = false;
            divReceipt.Visible = false;
            txtCashinBranch.Visible = false;
            cashreceivables.Visible = false;
        }
        else
        {
            divCashDispersement.Visible = true;
            divReceipt.Visible = true;
            txtCashinBranch.Visible = true;
        }
        try
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
                    Session["UserName"] = Request.Cookies["UserName"].Value.ToString();
                    Session["UserFullName"] = Request.Cookies["UserFullName"].Value.ToString();
                }
            }
            catch (Exception ex)
            {
                Response.Redirect("../../MCTX_General/Login.aspx");
            }
            try
            {
                using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionstring2"].ToString()))
                {
                    SqlCommand cmdCashDispersedIH = new SqlCommand("SELECT SUM(Dispersed_Amount) as CashDisbursed from Act_Dispersment where Dispersed_To= '" + Session["UserName"].ToString() + "' and isnull(deleted,0)<>1", cn);
                    SqlCommand cmdCashExpenseIH = new SqlCommand("SELECT SUM(Expense_Amount) as CashExpense from Act_Expense where Expense_By = '" + Session["UserName"].ToString() + "' and isnull(Deleted,0)<>1", cn);
                    cn.Open();
                    int CashinHand = 0;
                    string BranchId = "";
                    string CashDisbursed = "";
                    string CashExpense = "";
                    int CashinBranch = 0;
                    string CashDisbursedB = "";
                    string CashExpenseB = "";
                    try
                    {
                        SqlDataAdapter daN = new SqlDataAdapter(cmdCashDispersedIH);
                        DataTable dtN = new DataTable();
                        daN.Fill(dtN);
                        CashDisbursed = dtN.Rows[0]["CashDisbursed"].ToString();
                        if (CashDisbursed == "")
                        {
                            CashDisbursed = "0";
                        }
                        SqlDataAdapter daN1 = new SqlDataAdapter(cmdCashExpenseIH);
                        DataTable dtN1 = new DataTable();
                        daN1.Fill(dtN1);
                        CashExpense = dtN1.Rows[0]["CashExpense"].ToString();
                        if (CashExpense == "")
                        {
                            CashExpense = "0";
                        }
                        CashinHand = int.Parse(CashDisbursed) - int.Parse(CashExpense);

                        // BranchId = dtN.Rows[0]["Branch_Id"].ToString();

                    }
                    catch (Exception ex)
                    {
                        //throw;
                    }
                    cn.Close();
                    //string BranchID = getBranchID(Session["UserName"].ToString());

                    string BranchID = getBranchID(Session["UserName"].ToString());
                    //SqlCommand cmdCashinBranch = new SqlCommand("select sum(AmountInHand) as Amtinbranch from dbo.Act_AmtInBranch where Branch_Id =" + BranchId + "", cn);
                    SqlCommand cmdCashDispersedIB = new SqlCommand("SELECT SUM(Dispersed_Amount) as CashDisbursedB from Act_Dispersment where Amt_cashInBranch_Id =" + BranchID + " and isnull(deleted,0)<>1", cn);
                    SqlCommand cmdCashExpenseIB = new SqlCommand("SELECT SUM(Expense_Amount) as CashExpenseB from Act_Expense where Branch_ID = '" + BranchID + "' and isnull(Deleted,0)<>1", cn);
                    cn.Open();
                    try
                    {
                        CashDisbursedB = cmdCashDispersedIB.ExecuteScalar().ToString();
                        if (CashDisbursedB == "")
                        {
                            CashDisbursedB = "0";
                        }
                        CashExpenseB = cmdCashExpenseIB.ExecuteScalar().ToString();
                        if (CashExpenseB == "")
                        {
                            CashExpenseB = "0";
                        }

                        CashinBranch = int.Parse(CashDisbursedB) - int.Parse(CashExpenseB);
                    }
                    catch (Exception ex)
                    {
                        //throw;
                    }
                    cn.Close();

                    txtCashInHand.Text = CashinHand.ToString();
                    txtCashinBranch.Text = CashinBranch.ToString();
                }
            }
            catch (Exception)
            {

                throw;
            }

            loadDDL();
            ReceivableAmt();
            string expID = Request.Params["ExpID"];
            string Recp_Id = Request.Params["Recp_Id"];
            string Desp_Id = Request.Params["Disp_Id"];
            string Inv_Id = Request.Params["invoice_id"];
            try
            {
                if (Recp_Id != null)
                {
                    btnRecSave.Visible = false;
                    btnUpdate.Visible = true;
                    lblRecp_Id.Text = Recp_Id;
                    using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionstring2"].ToString()))
                    {
                        SqlCommand cmd = new SqlCommand("SELECT * from Act_Reciepts where Recp_Id='" + Recp_Id + "'", cn);
                        DataSet ds = new DataSet();
                        SqlDataAdapter DA = new SqlDataAdapter(cmd);
                        DA.Fill(ds, "RecDetails");
                        DataTable dt = new DataTable();
                        dt = ds.Tables["RecDetails"];
                        txtReceiptDate.Text = dt.Rows[0]["Rep_Date"].ToString();
                        txtReceiptAmount.Text = dt.Rows[0]["Rcp_Amount"].ToString();
                        ddlReceivedBy.SelectedItem.Text = dt.Rows[0]["Rcp_Recievedby"].ToString();
                        ddlReceiveFrom.SelectedItem.Text = dt.Rows[0]["Rcp_Receivedfrom"].ToString();
                        ddlModeOfPayment.SelectedItem.Text = dt.Rows[0]["Rcp_PaymentMode"].ToString();
                        ddlProjecName.SelectedItem.Text = dt.Rows[0]["Rcp_ForProject"].ToString();
                        btnUpdate.Visible = true;
                    }

                }
                else
                {
                    btnRecSave.Visible = true;
                    btnUpdate.Visible = false;
                }
            }
            catch (Exception ex)
            {

                // throw;
            }

            try
            {
                if (Desp_Id != null)
                {
                    btnCashDisSave.Visible = false;
                    btnDisUpd.Visible = true;
                    lblDesp_Id.Text = Desp_Id;
                    using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionstring2"].ToString()))
                    {
                        SqlCommand cmd = new SqlCommand("SELECT Act_Dispersment.Dispersment_Id, Act_ApprovingAuth.ApproveAuth_name, Act_Dispersment.Dispersed_To, tbl_employee.E_Name, Act_Dispersment.Dispersed_Method,Act_Dispersment.Check_No, Act_Dispersment.Dispersed_Amount,Act_Dispersment.Created_By, Act_Dispersment.Created_Date, Act_Dispersment.Modified_By, Act_Dispersment.Modified_Date from Act_Dispersment inner join Act_ApprovingAuth on Act_Dispersment.DisPersed_By=Act_ApprovingAuth.ApproveAuth_Id inner join user1 on Act_Dispersment.Dispersed_To=user1.user_id inner join tbl_employee on user1.E_badge=tbl_employee.E_badge  where Dispersment_Id='" + Desp_Id + "'", cn);
                        //DataSet ds = new DataSet();
                        SqlDataAdapter DA = new SqlDataAdapter(cmd);

                        DataTable dt = new DataTable();
                        DA.Fill(dt);
                        cn.Close();
                        ddlDispersedTo.Items.FindByText(dt.Rows[0]["E_Name"].ToString()).Selected = true;
                        ddlDispersedBy.Items.FindByText(dt.Rows[0]["ApproveAuth_name"].ToString()).Selected = true;
                        ddlDispersionMethod.Items.FindByText(dt.Rows[0]["Dispersed_Method"].ToString()).Selected = true;
                        lblPreDisburseTo.Text = dt.Rows[0]["Dispersed_To"].ToString();
                        //ddlDispersedBy.SelectedItem.Text = dt.Rows[0]["ApproveAuth_name"].ToString();
                        //ddlDispersionMethod.SelectedItem.Text = dt.Rows[0]["Dispersed_Method"].ToString();
                        txtDispersedAmt.Text = dt.Rows[0]["Dispersed_Amount"].ToString();
                        btnDisUpd.Visible = true;
                    }
                }
                else
                {
                    btnCashDisSave.Visible = true;
                    btnDisUpd.Visible = false;
                }
            }
            catch (Exception ex)
            {

                //throw;
            }

            if (expID != null)
            {
                btnExpUpdate.Visible = true;
                btnSaveExpense.Visible = false;
                lblExpID.Text = expID;
                //btnSaveExpense.Visible = false;
                using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionstring2"].ToString()))
                {
                    try
                    {
                        SqlCommand cmd = new SqlCommand("SELECT ACT_Expense.Expense_Amount,ACT_Expense.Expense_Detail,ACT_Expense.Expense_Date, Act_ExpenseType.ExpenseType_Name,Act_Expense.Modeof_Payment,Act_Projects.Pro_Name,Act_Expense.Expense_Status,Act_Expense.Approval_Status,Act_ApprovingAuth.ApproveAuth_Name,Act_ExpenseCategory.ExpenseCat_Name from Act_Expense inner join Act_ExpenseType on Act_Expense.Expense_Type = Act_ExpenseType.ExpenseType_Id inner join Act_Projects on Act_Expense.Expense_Project = Act_Projects.Project_Id inner join Act_ExpenseCategory on ACT_Expense.Expense_Category = Act_ExpenseCategory.ExpenseCat_Id inner join Act_ApprovingAuth on ACT_Expense.Approval_Authority=Act_ApprovingAuth.ApproveAuth_Id where Act_Expense.deleted=0 and ACT_Expense.Expense_Id = " + expID + " order by Expense_Id desc", cn);
                        cn.Open();
                        SqlDataAdapter da = new SqlDataAdapter(cmd);
                        DataTable dt = new DataTable();
                        da.Fill(dt);
                        cn.Close();
                        txtExpenseDate.Text = dt.Rows[0]["Expense_Date"].ToString();
                        txtExpDetails.Text = dt.Rows[0]["Expense_Detail"].ToString();
                        TextExpenseAmt.Text = dt.Rows[0]["Expense_Amount"].ToString();
                        ddlExpenseCategory.Items.FindByText(dt.Rows[0]["ExpenseCat_Name"].ToString()).Selected = true;
                        //ddlExpenseType.Items.FindByText(dt.Rows[0]["ExpenseType_Name"].ToString()).Selected = true;
                        ddlPaymentMode.Items.FindByText(dt.Rows[0]["Modeof_Payment"].ToString()).Selected = true;
                        ddlProjectName.Items.FindByText(dt.Rows[0]["Pro_Name"].ToString()).Selected = true;
                        ddlExpStatus.Items.FindByText(dt.Rows[0]["Expense_Status"].ToString()).Selected = true;
                        DropDownList4.Items.FindByText(dt.Rows[0]["Approval_Status"].ToString()).Selected = true;
                        ddlApprovingAuthority.Items.FindByText(dt.Rows[0]["ApproveAuth_Name"].ToString()).Selected = true;
                    }
                    catch (Exception ex)
                    {
                        cn.Close();
                        //throw;
                    }
                }
            }
            else
            {
                btnExpUpdate.Visible = false;
                btnSaveExpense.Visible = true;
            }


            if (Inv_Id != null)
            {
                btnRecableSave.Visible = false;
                btnRecableUpdate.Visible = true;
                lblRecievableID.Text = Inv_Id;
                using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionstring2"].ToString()))
                    try
                    {
                        SqlCommand cmd = new SqlCommand("SELECT Act_Projects.Pro_Name, ACT_Recievables.PO_Date, ACT_Recievables.Invoice_Date, ACT_Recievables.Payment_Due_On, ACT_Recievables.Invoice_No, ACT_Recievables.PO_No, ACT_Recievables.Invoice_Amount, ACT_Recievables.GST, ACT_Recievables.WHT from ACT_Recievables inner join Act_Projects on ACT_Recievables.invoice_to=Act_Projects.Project_Id where ACT_Recievables.invoice_id = '" + Inv_Id + "'", con);
                        con.Open();
                        SqlDataAdapter da = new SqlDataAdapter(cmd);
                        DataTable dt = new DataTable();
                        da.Fill(dt);
                        con.Close();
                        ddlInvoiceTo.Items.FindByText(dt.Rows[0]["Pro_Name"].ToString()).Selected = true;
                        txtPODate.Text = dt.Rows[0]["PO_Date"].ToString();
                        txtInvoiceDate.Text = dt.Rows[0]["Invoice_Date"].ToString();
                        txtPaymentDueon.Text = dt.Rows[0]["Payment_Due_On"].ToString();
                        txtInvoiceNo.Text = dt.Rows[0]["Invoice_No"].ToString();
                        txtPONumber.Text = dt.Rows[0]["PO_No"].ToString();
                        txtInvoiceAmt.Text = dt.Rows[0]["Invoice_Amount"].ToString();
                        txtGST.Text = dt.Rows[0]["GST"].ToString();
                        txtWHT.Text = dt.Rows[0]["WHT"].ToString();
                        btnRecableUpdate.Visible = true;
                    }
                    catch (Exception)
                    {
                        con.Close();
                        //throw;
                    }
            }
            else
            {
                btnRecableSave.Visible = true;
                btnRecableUpdate.Visible = false;
            }



            //SqlCommand cmdCashinhand = new SqlCommand("select AmountInHand,Branch_Id from dbo.Act_AmtInBranch where Employee_Id = '" + Session["UserName"].ToString() + "'", cn);
            //SqlCommand cmdCashinhand = new SqlCommand("select sum(Dispersed_Amount)as CashInHand from Act_Dispersment where Dispersed_To= '" + Session["UserName"].ToString() + "' and isnull(deleted,0)<>1", cn);
            //cn.Open();
            //string CashinHand = "";
            //string BranchId = "";
            //string CashinBranch = "";
            //try
            //{
            //    SqlDataAdapter daN = new SqlDataAdapter(cmdCashinhand);
            //    DataTable dtN = new DataTable();
            //    daN.Fill(dtN);
            //    CashinHand = dtN.Rows[0]["CashInHand"].ToString();
            //    // BranchId = dtN.Rows[0]["Branch_Id"].ToString();

            //}
            //catch (Exception ex)
            //{
            //    //throw;
            //}
            //cn.Close();
            ////string BranchID = getBranchID(Session["UserName"].ToString());

            //string BranchID = getBranchID(Session["UserName"].ToString());
            ////SqlCommand cmdCashinBranch = new SqlCommand("select sum(AmountInHand) as Amtinbranch from dbo.Act_AmtInBranch where Branch_Id =" + BranchId + "", cn);
            //SqlCommand cmdCashinBranch = new SqlCommand("select sum(Dispersed_Amount)as CashInBranch from Act_Dispersment where Amt_CashInBranch_id =" + BranchID + " and isnull(deleted,0)<>1", cn);

            //cn.Open();
            //try
            //{
            //    CashinBranch = cmdCashinBranch.ExecuteScalar().ToString();
            //}
            //catch (Exception ex)
            //{
            //    //throw;
            //}
            //cn.Close();

            //txtCashInHand.Text = CashinHand;
            //txtCashinBranch.Text = CashinBranch;





        }
        catch (Exception ex)
        {

            // throw;
        }

    }


    public void loadDDL()
    {
        PopulateExpenseCategory();
        PopulateExpenseCategory2();
        PopulateProjectName();
        PopulateProjectName2();
        //PopulateExpanseType();
        PopulateApprovalAuthority();
        PopulateApprovalAuthority2();
        PopulateReceivedFrom();
        PopulateEmployee();
        PopulateEmployee1();
        PopulateEmployee2();
        PopulatePaymentNature();
        Populate_DisburseTo_Inward();
        Populate_DisburseBy_Inward();
        PopulateInvoiceTo();
        PopulateReceivedFromProject();
        PopulateBranch();
    }


    public void PopulateExpenseCategory()
    {

        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionstring2"].ToString()))
        {

            SqlCommand cmd = new SqlCommand("SELECT ExpenseCat_Id,ExpenseCat_Name FROM Act_ExpenseCategory", cn);
            cn.Open();
            SqlDataReader ddlValues;
            ddlValues = cmd.ExecuteReader();

            ddlExpenseCategory.DataSource = ddlValues;
            ddlExpenseCategory.DataValueField = "ExpenseCat_Id";
            ddlExpenseCategory.DataTextField = "ExpenseCat_Name";
            ddlExpenseCategory.DataBind();
            ddlExpenseCategory.Items.Insert(0, "");
        }

    }
    public void PopulateExpenseCategory2()
    {

        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionstring2"].ToString()))
        {

            SqlCommand cmd = new SqlCommand("SELECT ExpenseCat_Id,ExpenseCat_Name FROM Act_ExpenseCategory", cn);
            cn.Open();
            SqlDataReader ddlValues;
            ddlValues = cmd.ExecuteReader();
            ddlExpenseType0.DataSource = ddlValues;
            ddlExpenseType0.DataValueField = "ExpenseCat_Id";
            ddlExpenseType0.DataTextField = "ExpenseCat_Name";
            ddlExpenseType0.DataBind();
            ddlExpenseType0.Items.Insert(0, "");
        }
    }
    public void PopulateProjectName()
    {

        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionstring2"].ToString()))
        {

            SqlCommand cmd = new SqlCommand("SELECT Project_Id,Pro_Name FROM Act_Projects", cn);
            cn.Open();
            SqlDataReader ddlValues;
            ddlValues = cmd.ExecuteReader();

            ddlProjecName.DataSource = ddlValues;
            ddlProjecName.DataValueField = "Project_Id";
            ddlProjecName.DataTextField = "Pro_Name";
            ddlProjecName.DataBind();
            ddlProjecName.Items.Insert(0, "");
        }

    }
    public void PopulateProjectName2()
    {

        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionstring2"].ToString()))
        {

            SqlCommand cmd = new SqlCommand("SELECT Project_Id,Pro_Name FROM Act_Projects", cn);
            cn.Open();
            SqlDataReader ddlValues;
            ddlValues = cmd.ExecuteReader();
            ddlProjectName.DataSource = ddlValues;
            ddlProjectName.DataValueField = "Project_Id";
            ddlProjectName.DataTextField = "Pro_Name";
            ddlProjectName.DataBind();
            ddlProjectName.Items.Insert(0, "");
        }
    }

    public void PopulateExpanseType()
    {

        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionstring2"].ToString()))
        {

            SqlCommand cmd = new SqlCommand("SELECT ExpenseType_Id,ExpenseType_Name FROM Act_ExpenseType", cn);
            cn.Open();
            SqlDataReader ddlValues;
            ddlValues = cmd.ExecuteReader();
            ddlExpenseType.DataSource = ddlValues;
            ddlExpenseType.DataValueField = "ExpenseType_Id";
            ddlExpenseType.DataTextField = "ExpenseType_Name";
            ddlExpenseType.DataBind();
            ddlExpenseType.Items.Insert(0, "");
        }
    }
    public void PopulateApprovalAuthority()
    {

        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionstring2"].ToString()))
        {

            SqlCommand cmd = new SqlCommand("SELECT ApproveAuth_Id,ApproveAuth_Name FROM Act_ApprovingAuth", cn);
            cn.Open();
            SqlDataReader ddlValues;
            ddlValues = cmd.ExecuteReader();
            ddlApprovingAuthority.DataSource = ddlValues;
            ddlApprovingAuthority.DataValueField = "ApproveAuth_Id";
            ddlApprovingAuthority.DataTextField = "ApproveAuth_Name";
            ddlApprovingAuthority.DataBind();
            ddlApprovingAuthority.Items.Insert(0, "");
        }
    }

    // SELECT * FROM tbl_Employee where isnull(deleted,0)<>1
    //ddlDispersedBy


    public void PopulateApprovalAuthority2()
    {

        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionstring2"].ToString()))
        {

            SqlCommand cmd = new SqlCommand("SELECT ApproveAuth_Id,ApproveAuth_Name FROM Act_ApprovingAuth", cn);
            cn.Open();
            SqlDataReader ddlValues;
            ddlValues = cmd.ExecuteReader();
            ddlDispersedBy.DataSource = ddlValues;
            ddlDispersedBy.DataValueField = "ApproveAuth_Id";
            ddlDispersedBy.DataTextField = "ApproveAuth_Name";
            ddlDispersedBy.DataBind();
            ddlDispersedBy.Items.Insert(0, "");
        }
    }

    //ddlReceiveFrom
    public void PopulateReceivedFrom()
    {

        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionstring2"].ToString()))
        {

            SqlCommand cmd = new SqlCommand("SELECT Received_From_ID,Received_From_Name FROM Act_ReceivedFrom", cn);
            cn.Open();
            SqlDataReader ddlValues;
            ddlValues = cmd.ExecuteReader();
            ddlReceiveFrom.DataSource = ddlValues;
            ddlReceiveFrom.DataValueField = "Received_From_ID";
            ddlReceiveFrom.DataTextField = "Received_From_Name";
            ddlReceiveFrom.DataBind();
            ddlReceiveFrom.Items.Insert(0, "");
        }
    }

    //ddlBranch
    public void PopulateBranch()
    {

        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionstring2"].ToString()))
        {

            SqlCommand cmd = new SqlCommand("select BRID,BRANCHNAME from tbl_BRANCHES", cn);
            cn.Open();
            SqlDataReader ddlValues;
            ddlValues = cmd.ExecuteReader();
            ddlBranch.DataSource = ddlValues;
            ddlBranch.DataValueField = "BRID";
            ddlBranch.DataTextField = "BRANCHNAME";
            ddlBranch.DataBind();
            ddlBranch.Items.Insert(0, "");
        }
    }
    //ddlEmployee
    public void PopulateEmployee()
    {
        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionstring2"].ToString()))
        {

            SqlCommand cmd = new SqlCommand("select user1.User_Id, tbl_Employee.E_Name from user1 inner join tbl_Employee on user1.E_badge=tbl_Employee.E_badge where isnull(tbl_Employee.deleted,0)<>1 and isnull(user1.deleted,0)<>1", cn);
            cn.Open();
            SqlDataReader ddlValues;
            ddlValues = cmd.ExecuteReader();
            ddlEmployee.DataSource = ddlValues;
            ddlEmployee.DataValueField = "User_Id";
            ddlEmployee.DataTextField = "E_Name";
            ddlEmployee.DataBind();
            ddlEmployee.Items.Insert(0, "");
        }
    }
    public void PopulateReceivedFromProject()
    {

        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionstring2"].ToString()))
        {

            SqlCommand cmd = new SqlCommand("SELECT Project_Id,Pro_Name FROM Act_Projects", cn);
            cn.Open();
            SqlDataReader ddlValues;
            ddlValues = cmd.ExecuteReader();
            ddlReciveFromPro.DataSource = ddlValues;
            ddlReciveFromPro.DataValueField = "Project_Id";
            ddlReciveFromPro.DataTextField = "Pro_Name";
            ddlReciveFromPro.DataBind();
            ddlReciveFromPro.Items.Insert(0, "");
        }
    }
    public void PopulateEmployee1()
    {

        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionstring2"].ToString()))
        {

            SqlCommand cmd = new SqlCommand("select U.user_id,E.E_Name from user1 U inner join tbl_Employee E on U.E_badge=E.E_badge where isnull(E.deleted,0)<>1  order by E.E_Name", cn);
            cn.Open();
            SqlDataReader ddlValues;
            ddlValues = cmd.ExecuteReader();
            ddlDispersedTo.DataSource = ddlValues;
            ddlDispersedTo.DataValueField = "user_id";
            ddlDispersedTo.DataTextField = "E_Name";
            ddlDispersedTo.DataBind();
            ddlDispersedTo.Items.Insert(0, "");
        }
    }
    public void PopulateInvoiceTo()
    {
        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionstring2"].ToString()))
        {

            SqlCommand cmd = new SqlCommand("SELECT Project_Id,Pro_Name FROM Act_Projects", cn);
            cn.Open();
            SqlDataReader ddlValues;
            ddlValues = cmd.ExecuteReader();

            ddlInvoiceTo.DataSource = ddlValues;
            ddlInvoiceTo.DataValueField = "Project_Id";
            ddlInvoiceTo.DataTextField = "Pro_Name";
            ddlInvoiceTo.DataBind();
            ddlInvoiceTo.Items.Insert(0, "");
        }
    }



    #region [Oct 27, 2011] by Obaid

    public void Populate_DisburseTo_Inward()
    {

        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionstring2"].ToString()))
        {

            SqlCommand cmd = new SqlCommand("select U.user_id,E.E_Name from user1 U inner join tbl_Employee E on U.E_badge=E.E_badge where isnull(E.deleted,0)<>1  order by E.E_Name", cn);
            cn.Open();
            SqlDataReader ddlValues;
            ddlValues = cmd.ExecuteReader();
            ddlDisbursedTo_Inward.DataSource = ddlValues;
            ddlDisbursedTo_Inward.DataValueField = "user_id";
            ddlDisbursedTo_Inward.DataTextField = "E_Name";
            ddlDisbursedTo_Inward.DataBind();
            ddlDisbursedTo_Inward.Items.Insert(0, "");

            List<ListItem> items = new List<ListItem>();
            items.Add(new ListItem("Head Office", "7"));
            items.Add(new ListItem("Lahore", "8"));
            items.Add(new ListItem("Karachi", "9"));
            items.Add(new ListItem("Multan", "10"));

            items.Sort(delegate(ListItem item1, ListItem item2) { return item1.Text.CompareTo(item2.Text); });
            ddlDisbursedTo_Inward.Items.AddRange(items.ToArray());


        }
    }

    public void Populate_DisburseBy_Inward()
    {

        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionstring2"].ToString()))
        {

            SqlCommand cmd = new SqlCommand("SELECT ApproveAuth_Id,ApproveAuth_Name FROM Act_ApprovingAuth", cn);
            cn.Open();
            SqlDataReader ddlValues;
            ddlValues = cmd.ExecuteReader();
            ddlDisbursedBy_Inward.DataSource = ddlValues;
            ddlDisbursedBy_Inward.DataValueField = "ApproveAuth_Id";
            ddlDisbursedBy_Inward.DataTextField = "ApproveAuth_Name";
            ddlDisbursedBy_Inward.DataBind();
            ddlDisbursedBy_Inward.Items.Insert(0, "");
        }
    }


    public void PopulatePaymentNature()
    {
        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionstring2"].ToString()))
        {
            string query = "Select * from [Act_PaymentNature]";
            SqlCommand cmd = new SqlCommand(query, cn);
            cn.Open();
            DataTable dtPaymentNature = new DataTable();
            SqlDataAdapter sqlda = new SqlDataAdapter(query, cn);
            sqlda.Fill(dtPaymentNature);
            cmd.ExecuteNonQuery();
            ddlPaymentNature.DataSource = dtPaymentNature;
            ddlPaymentNature.DataTextField = "PaymentNatureName";
            ddlPaymentNature.DataValueField = "PaymentNature_ID";
            ddlPaymentNature.DataBind();
            ddlPaymentNature.Items.Insert(0, "");
        }
    }
    #endregion

    //ddlReceivedBy

    public void PopulateEmployee2()
    {

        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionstring2"].ToString()))
        {

            SqlCommand cmd = new SqlCommand("select U.user_id,E.E_Name from user1 U inner join tbl_Employee E on U.E_badge=E.E_badge where isnull(E.deleted,0)<>1  order by E.E_Name", cn);
            cn.Open();
            SqlDataReader ddlValues;
            ddlValues = cmd.ExecuteReader();
            ddlReceivedBy.DataSource = ddlValues;
            ddlReceivedBy.DataValueField = "user_id";
            ddlReceivedBy.DataTextField = "E_Name";
            ddlReceivedBy.DataBind();
            ddlReceivedBy.Items.Insert(0, "");
        }
    }

    [WebMethod]
    public static void SaveReceiptInformation(string txtReceiptDate, string txtReceiptAmount, string txtReceivedBy, string ddlReceiveFrom, string ddlModeOfPayment, string ddlProjecName, string ddlNatureOfPayment)
    {
        string userName = HttpContext.Current.Session["UserFullName"].ToString();
        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionstring2"].ToString()))
        {
            if (userName != "")
            {
                string query = "insert into Act_Reciepts(Rep_Date,Rcp_Amount,Rcp_Recievedby,Rcp_Receivedfrom, " +
                               "Rcp_PaymentMode,Rcp_ForProject,Payment_Nature,Created_By,Created_Date,Modified_By,Modified_Date,deleted) " +
                               "values ('" + txtReceiptDate + "','" + txtReceiptAmount + "','" + txtReceivedBy + "'" +
                               ",'" + ddlReceiveFrom + "','" + ddlModeOfPayment + "'," + ddlProjecName + ",'" + ddlNatureOfPayment + "','" + userName + "',getdate(),'" + userName + "',getdate(),0)";
                SqlCommand cmd = new SqlCommand(query, cn);
                cn.Open();
                cmd.ExecuteNonQuery();
            }



        }
    }
    [WebMethod]
    public static void SaveProjectName(string txtProjectName)
    {
        string userName = HttpContext.Current.Session["UserFullName"].ToString();
        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionstring2"].ToString()))
        {
            if (userName != "")
            {
                string query = "insert into Act_Projects(Pro_Name,Created_By,Created_Date,Modified_By,Modified_Date) " +
                               "values ('" + txtProjectName + "','" + userName + "',getdate(),'" + userName + "',getdate())";
                SqlCommand cmd = new SqlCommand(query, cn);
                cn.Open();
                cmd.ExecuteNonQuery();
            }



        }
    }
    [WebMethod]
    public static void SaveExpCatName(string txtExpenseCategory)
    {
        string userName = HttpContext.Current.Session["UserFullName"].ToString();
        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionstring2"].ToString()))
        {
            if (userName != "")
            {
                string query = "insert into Act_ExpenseCategory(ExpenseCat_Name,Created_By,Created_Date,Modified_By,Modified_Date) " +
                               "values ('" + txtExpenseCategory + "','" + userName + "',getdate(),'" + userName + "',getdate())";
                SqlCommand cmd = new SqlCommand(query, cn);
                cn.Open();
                cmd.ExecuteNonQuery();
            }

        }
    }

    [WebMethod]
    public static void SaveExpTypeName(string txtExpenseType, string ExpenseCatId)
    {
        string userName = HttpContext.Current.Session["UserFullName"].ToString();
        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionstring2"].ToString()))
        {
            if (userName != "")
            {
                string query = "insert into Act_ExpenseType(ExpenseType_Name,Created_By,Created_Date,Modified_By,Modified_Date,ExpenseCatId) " +
                               "values ('" + txtExpenseType + "','" + userName + "',getdate(),'" + userName + "',getdate()," + ExpenseCatId + ")";
                SqlCommand cmd = new SqlCommand(query, cn);
                cn.Open();
                cmd.ExecuteNonQuery();
            }

        }
    }

    [WebMethod]
    public static void SaveApprovalAuthority(string txtApprovalAut)
    {
        string userName = HttpContext.Current.Session["UserFullName"].ToString();
        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionstring2"].ToString()))
        {
            if (userName != "")
            {
                string query = "insert into Act_ApprovingAuth(ApproveAuth_Name) " +
                               "values ('" + txtApprovalAut + "')";
                SqlCommand cmd = new SqlCommand(query, cn);
                cn.Open();
                cmd.ExecuteNonQuery();
            }

        }
    }

    //-----------------------------------------Save Receive From Information (Tahir Kazmi)------------------

    [WebMethod]
    public static void SaveReceivedFrom(string txtReceivedFrom)
    {
        string userName = HttpContext.Current.Session["UserFullName"].ToString();
        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionstring2"].ToString()))
        {
            if (userName != "")
            {
                string query = "insert into Act_ReceivedFrom(Received_From_Name) " +
                               "values ('" + txtReceivedFrom + "')";
                SqlCommand cmd = new SqlCommand(query, cn);
                cn.Open();
                cmd.ExecuteNonQuery();
            }

        }
    }


    //-------------------------------------------------------End Receive From Information--------------




    //[WebMethod]
    //public static void SaveExpense(string txtExpenseDate, string TextExpenseAmt, string ddlExpenseCategory, string ddlExpenseType, string ddlPaymentMode, string ddlProjectName, string ddlExpStatus, string ddlApprovingAuthority)
    //{
    //    string userName = HttpContext.Current.Session["UserFullName"].ToString();
    //    using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionstring2"].ToString()))
    //    {
    //        //if (userName != "")
    //        //{
    //        //    string query = "insert into Act_Expense(ApproveAuth_Name) " +
    //        //                   "values ('" + txtApprovalAut + "')";
    //        //    SqlCommand cmd = new SqlCommand(query, cn);
    //        //    cn.Open();
    //        //    cmd.ExecuteNonQuery();
    //        //}

    //    }
    //}
    //[WebMethod]
    //public static void SaveCashDispersement(string ddlDispersedTo, string ddlDispersedBy, string ddlDispersionMethod, string txtDispersedAmt)
    //{
    //    string userName = "";
    //    try
    //    {
    //        userName = HttpContext.Current.Session["UserFullName"].ToString();
    //    }
    //    catch (Exception ex)
    //    {
    //        HttpContext.Current.Response.Redirect("../../MCTX_General/Login.aspx");
    //    }


    //    using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionstring2"].ToString()))
    //    {
    //        if (userName != "")
    //        {
    //            string query = "INSERT INTO [Act_Dispersment] ([DisPersed_By],[Dispersed_Method],[Check_No],[Payee_Name] " +
    //                           ",[Dispersed_Amount],[Created_By],[Created_Date],[Modified_By],[Modified_Date],[Deleted],Dispersed_To) " +
    //                           " VALUES('" + ddlDispersedBy + "','" + ddlDispersionMethod + "','',''," + txtDispersedAmt + ",'" + userName + "',getdate(),'" + userName + "',getdate(),0,'" + ddlDispersedTo + "')";
    //            SqlCommand cmd = new SqlCommand(query, cn);
    //            cn.Open();
    //            int result = cmd.ExecuteNonQuery();
    //            cn.Close();
    //            if (result > 0)
    //            {
    //                //getting Dispersed to BranchId and Branch Name
    //                string selectBranchofEmp = "select tb.BRID,tb.BRANCHNAME from user1 U inner join tbl_Employee E on U.E_badge=E.E_badge Join  tbl_BRANCHES tb on E.BRID = tb.BRID where U.User_Id = '" + ddlDispersedTo + "' and isnull(E.deleted,0)<>1";// = '" + ddlDispersedTo + "'";
    //                cn.Open();
    //                DataTable dtBranch = new DataTable();
    //                SqlDataAdapter sqlda = new SqlDataAdapter(selectBranchofEmp, cn);
    //                sqlda.Fill(dtBranch);
    //                string DisToBrachId = dtBranch.Rows[0]["BRID"].ToString();
    //                string DisToBranchName = dtBranch.Rows[0]["BRANCHNAME"].ToString();


    //                cn.Close();


    //                // Getting LastAmount in Hand of Dispersed-to Employee 


    //                string selectlastAmtofEmp = "select AmountInHand from  Act_AmtInBranch where Employee_Id = '" + ddlDispersedTo + "'";
    //                cn.Open();
    //                SqlCommand cmdselect = new SqlCommand(selectlastAmtofEmp, cn);
    //                string LastAmtInHand = "";
    //                try
    //                {
    //                    LastAmtInHand = cmdselect.ExecuteScalar().ToString();
    //                }
    //                catch (Exception ex)
    //                {

    //                    //throw;
    //                }

    //                cn.Close();
    //                int lastAmountInHand = 0;
    //                if (LastAmtInHand != "")
    //                {
    //                    lastAmountInHand = int.Parse(LastAmtInHand);
    //                }

    //                int latestAmtInHand = lastAmountInHand + int.Parse(txtDispersedAmt);

    //                //Inserting Amount in Hand Table
    //                string queryIAH = "INSERT INTO [Act_AmountInHand]([AmtInHand] " +
    //                                  ",[Employee_Id],[EmployeeName],[BranchName],[Created_Date],[Created_By] " +
    //                                  ",[Modified_Date],[Modified_By],[Deleted],[Branch_Id],[CashReceived],[CaseDispersed]) " +
    //                                  "VALUES (" + latestAmtInHand + ",'" + ddlDispersedTo + "','' " +
    //                                  ",'" + DisToBranchName + "',getdate(),'" + userName + "',getdate(),'" + userName + "',0," + DisToBrachId + ",0," + txtDispersedAmt + ")";
    //                cn.Open();
    //                SqlCommand cmdIAH = new SqlCommand(queryIAH, cn);
    //                int result2 = cmdIAH.ExecuteNonQuery();
    //                cn.Close();
    //                if (result2 > 0)
    //                {
    //                    string queryIAB = "";
    //                    if (LastAmtInHand == "")
    //                    {
    //                        queryIAB = "INSERT INTO [Act_AmtInBranch]([AmountInHand],[Employee_Id],[Employee_Name] " +
    //                                      ",[Branch_Id],[Branch_Name])VALUES(" + latestAmtInHand + ",'" + ddlDispersedTo + "',''," + DisToBrachId + ",'" + DisToBranchName + "' )";
    //                    }
    //                    else
    //                    {
    //                        queryIAB = "update Act_AmtInBranch set AmountInHand = " + latestAmtInHand + " where Employee_Id = '" + ddlDispersedTo + "' ";
    //                    }
    //                    cn.Open();
    //                    SqlCommand cmdIAB = new SqlCommand(queryIAB, cn);
    //                    cmdIAB.ExecuteNonQuery();
    //                    cn.Close();

    //                }

    //            }
    //        }

    //    }
    //}

    public static class Myclass
    {
        public static string getId(string table)
        {
            string id = "";
            string selquery = "select top 1 * from " + table + " order by 1 desc";
            using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionstring2"].ToString()))
            {
                cn.Open();
                SqlCommand cmdselect = new SqlCommand(selquery, cn);

                try
                {
                    id = Convert.ToString(cmdselect.ExecuteScalar());
                }
                catch (Exception ex)
                {

                    //throw;
                }

                cn.Close();
            }

            return id;
        }
        public static int updateReferenceinDispermentTable(string Act_DispersmentId, string Amt_inBranchId, string Amt_inHandId)
        {
            int result = 0;
            string query = "update Act_Dispersment set Amt_cashInHand_Id = " + Amt_inHandId + ", Amt_cashInBranch_Id = " + Amt_inBranchId + " where Dispersment_Id = " + Act_DispersmentId + "";
            using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionstring2"].ToString()))
            {
                cn.Open();
                SqlCommand cmdupdate = new SqlCommand(query, cn);
                result = cmdupdate.ExecuteNonQuery();
                cn.Close();
            }

            return result;

        }

    }

    public static string getBranchID(string userID)
    {
        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionstring2"].ToString()))
        {
            string BranchIDsQuery = "SELECT tb.BRID,tb.BRANCHNAME from user1 U inner join tbl_Employee E on U.E_badge=E.E_badge Join  tbl_BRANCHES tb on E.BRID = tb.BRID where U.User_Id = '" + userID + "' and isnull(E.deleted,0)<>1";

            DataTable dtBranchid = new DataTable();
            SqlDataAdapter sqlda1 = new SqlDataAdapter(BranchIDsQuery, cn);
            sqlda1.Fill(dtBranchid);
            string BranchIDs = dtBranchid.Rows[0]["BRID"].ToString();
            return BranchIDs;
        }


    }

    [WebMethod]
    public static void SaveCashDispersement(string ddlDispersedTo, string ddlDispersedBy, string ddlDispersionMethod, string txtDispersedAmt)
    {
        string userName = "";
        string Act_DispersmentId = "";
        string Amt_inHandId = "";
        string Amt_inBranchId = "";
        try
        {
            userName = HttpContext.Current.Session["UserFullName"].ToString();
        }
        catch (Exception ex)
        {
            HttpContext.Current.Response.Redirect("../../MCTX_General/Login.aspx");
        }


        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionstring2"].ToString()))
        {
            if (userName != "")
            {
                string branchIdd = "";
                if (ddlDispersedTo == "7") { ddlDispersedTo = "Head Office"; branchIdd = "7"; }
                if (ddlDispersedTo == "8") { ddlDispersedTo = "Lahore"; branchIdd = "8"; }
                if (ddlDispersedTo == "9") { ddlDispersedTo = "Karachi"; branchIdd = "9"; }
                if (ddlDispersedTo == "10") { ddlDispersedTo = "Multan"; branchIdd = "10"; }


                string BranchIDs = getBranchID(ddlDispersedTo);

                string query = "INSERT INTO [Act_Dispersment] ([DisPersed_By],[Dispersed_Method],[Check_No],[Payee_Name] " +
                               ",[Dispersed_Amount],[Created_By],[Created_Date],[Modified_By],[Modified_Date],[Deleted],Dispersed_To,Amt_cashInBranch_Id) " +
                               " VALUES('" + ddlDispersedBy + "','" + ddlDispersionMethod + "','',''," + txtDispersedAmt + ",'" + userName + "',getdate(),'',getdate(),0,'" + ddlDispersedTo + "'," + BranchIDs + ")";
                SqlCommand cmd = new SqlCommand(query, cn);
                cn.Open();
                int result = cmd.ExecuteNonQuery();
                cn.Close();
                if (result > 0)
                {
                    Act_DispersmentId = Myclass.getId("Act_Dispersment");
                }

                if (ddlDispersedTo == "Head Office" || ddlDispersedTo == "Lahore" || ddlDispersedTo == "Karachi" || ddlDispersedTo == "Multan")
                {
                    string queryIAB = "";
                    queryIAB = "INSERT INTO [Act_AmtInBranch]([AmountInHand],[Employee_Id],[Employee_Name] " +
                                      ",[Branch_Id],[Branch_Name])VALUES(" + txtDispersedAmt + ",'" + ddlDispersedTo + "',''," + branchIdd + ",'" + ddlDispersedTo + "' )";

                    cn.Open();
                    SqlCommand cmdIAB = new SqlCommand(queryIAB, cn);
                    int result1 = cmdIAB.ExecuteNonQuery();
                    cn.Close();
                    if (result1 > 0)
                    {
                        Amt_inBranchId = Myclass.getId("Act_AmtInBranch");
                    }
                }
                else
                {
                    if (result > 0)
                    {
                        //getting Dispersed to BranchId and Branch Name
                        string selectBranchofEmp = "select tb.BRID,tb.BRANCHNAME from user1 U inner join tbl_Employee E on U.E_badge=E.E_badge Join  tbl_BRANCHES tb on E.BRID = tb.BRID where U.User_Id = '" + ddlDispersedTo + "' and isnull(E.deleted,0)<>1";// = '" + ddlDispersedTo + "'";
                        cn.Open();
                        DataTable dtBranch = new DataTable();
                        SqlDataAdapter sqlda = new SqlDataAdapter(selectBranchofEmp, cn);
                        sqlda.Fill(dtBranch);
                        string DisToBrachId = dtBranch.Rows[0]["BRID"].ToString();
                        string DisToBranchName = dtBranch.Rows[0]["BRANCHNAME"].ToString();


                        cn.Close();


                        // Getting LastAmount in Hand of Dispersed-to Employee 


                        string selectlastAmtofEmp = "select AmountInHand from  Act_AmtInBranch where Employee_Id = '" + ddlDispersedTo + "'";
                        cn.Open();
                        SqlCommand cmdselect = new SqlCommand(selectlastAmtofEmp, cn);
                        string LastAmtInHand = "";
                        try
                        {
                            LastAmtInHand = cmdselect.ExecuteScalar().ToString();
                        }
                        catch (Exception ex)
                        {

                            //throw;
                        }

                        cn.Close();
                        int lastAmountInHand = 0;
                        if (LastAmtInHand != "")
                        {
                            lastAmountInHand = int.Parse(LastAmtInHand);
                        }

                        int latestAmtInHand = lastAmountInHand + int.Parse(txtDispersedAmt);
                        int result2 = 0;
                        if (lastAmountInHand == 0)
                        {
                            //Inserting Amount in Hand Table
                            string queryIAH = "INSERT INTO [Act_AmountInHand]([AmtInHand] " +
                                              ",[Employee_Id],[EmployeeName],[BranchName],[Created_Date],[Created_By] " +
                                              ",[Modified_Date],[Modified_By],[Deleted],[Branch_Id],[CashReceived],[CaseDispersed]) " +
                                              "VALUES (" + latestAmtInHand + ",'" + ddlDispersedTo + "','' " +
                                              ",'" + DisToBranchName + "',getdate(),'" + userName + "',getdate(),'" + userName + "',0," + DisToBrachId + ",0," + txtDispersedAmt + ")";
                            cn.Open();
                            SqlCommand cmdIAH = new SqlCommand(queryIAH, cn);
                            result2 = cmdIAH.ExecuteNonQuery();
                            cn.Close();
                        }
                        else
                        {
                            string queryIAH = "Update [Act_AmountInHand] set [AmtInHand] = " + latestAmtInHand + " where [Employee_Id]= '" + ddlDispersedTo + "'";
                            cn.Open();
                            SqlCommand cmdIAH = new SqlCommand(queryIAH, cn);
                            result2 = cmdIAH.ExecuteNonQuery();
                            cn.Close();
                        }


                        if (result2 > 0)
                        {
                            Amt_inHandId = Myclass.getId("Act_AmountInHand");
                            string queryIAB = "";
                            if (LastAmtInHand == "")
                            {
                                queryIAB = "INSERT INTO [Act_AmtInBranch]([AmountInHand],[Employee_Id],[Employee_Name] " +
                                              ",[Branch_Id],[Branch_Name])VALUES(" + latestAmtInHand + ",'" + ddlDispersedTo + "',''," + DisToBrachId + ",'" + DisToBranchName + "' )";
                            }
                            else
                            {
                                queryIAB = "update Act_AmtInBranch set AmountInHand = " + latestAmtInHand + " where Employee_Id = '" + ddlDispersedTo + "' ";
                            }
                            cn.Open();
                            SqlCommand cmdIAB = new SqlCommand(queryIAB, cn);
                            int result4 = cmdIAB.ExecuteNonQuery();
                            cn.Close();
                            if (result4 > 0)
                            {
                                Amt_inBranchId = Myclass.getId("Act_AmtInBranch");
                            }
                        }

                    }
                }

                //int resultReferenUpdates = Myclass.updateReferenceinDispermentTable(Act_DispersmentId, Amt_inBranchId, Amt_inHandId);



            }

        }
    }

    [WebMethod]
    public static void SaveExpense(string txtExpenseDate, string TextExpenseAmt, string txtExpDetails, string ddlExpenseCategory, string ddlExpenseType,
        string ddlPaymentMode, string ddlProjectName, string ddlExpStatus, string ddlApprovalStatus, string ddlApprovingAuthority)
    {
        string userName = HttpContext.Current.Session["UserName"].ToString();
        string UserFullName = HttpContext.Current.Session["UserFullName"].ToString();
        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionstring2"].ToString()))
        {
            if (userName != "")
            {
                string queryBID = "select tb.BRID from user1 U inner join tbl_Employee E on U.E_badge=E.E_badge Join  tbl_BRANCHES tb on E.BRID = tb.BRID where U.User_Id = '" + userName + "'";
                SqlDataAdapter DABID = new SqlDataAdapter(queryBID, cn);
                DataTable dtExpBranchID = new DataTable();
                DABID.Fill(dtExpBranchID);
                string ExpByBrachId = "";
                ExpByBrachId = dtExpBranchID.Rows[0]["BRID"].ToString();
                string query = "INSERT INTO [Act_Expense] " +
                               "([Expense_Amount],[Expense_Detail],[Expense_Date],[Expense_Type],[Expense_Project],[Expense_Status],[Expense_Category],[Expense_By] " +
                               ",[Branch_ID],[Created_By],[Created_Date],[Modeof_Payment],[Approval_Status],[Approval_Authority],[Modified_By],[Modified_Date],[Deleted]) VALUES " +
                               "(" + TextExpenseAmt + ",'" + txtExpDetails + "','" + txtExpenseDate + "'," + ddlExpenseType + "," + ddlProjectName + ",'" + ddlExpStatus + "','" + ddlExpenseCategory + "', " +
                               "'" + userName + "','" + ExpByBrachId + "','" + userName + "',getdate(),'" + ddlPaymentMode + "','" + ddlApprovalStatus + "','" + ddlApprovingAuthority + "','',getdate(),0)";
                SqlCommand cmd = new SqlCommand(query, cn);
                cn.Open();
                int result = cmd.ExecuteNonQuery();
                cn.Close();
                if (result > 0)
                {
                    //getting Dispersed to BranchId and Branch Name
                    string selectBranchofEmp = "select tb.BRID,tb.BRANCHNAME from user1 U inner join tbl_Employee E on U.E_badge=E.E_badge Join  tbl_BRANCHES tb on E.BRID = tb.BRID where U.User_Id = '" + userName + "' and isnull(E.deleted,0)<>1";// = '" + ddlDispersedTo + "'";
                    cn.Open();
                    DataTable dtBranch = new DataTable();
                    SqlDataAdapter sqlda = new SqlDataAdapter(selectBranchofEmp, cn);
                    sqlda.Fill(dtBranch);
                    string DisToBrachId = dtBranch.Rows[0]["BRID"].ToString();
                    string DisToBranchName = dtBranch.Rows[0]["BRANCHNAME"].ToString();


                    cn.Close();


                    // Getting LastAmount in Hand of Expense-to Employee 


                    string selectlastAmtofEmp = "select AmountInHand from  Act_AmtInBranch where Employee_Id = '" + userName + "'";
                    cn.Open();
                    SqlCommand cmdselect = new SqlCommand(selectlastAmtofEmp, cn);
                    string LastAmtInHand = "";
                    try
                    {
                        LastAmtInHand = cmdselect.ExecuteScalar().ToString();
                    }
                    catch (Exception ex)
                    {

                        //throw;
                    }

                    cn.Close();
                    int lastAmountInHand = 0;
                    if (LastAmtInHand != "")
                    {
                        lastAmountInHand = int.Parse(LastAmtInHand);
                    }

                    int latestAmtInHand = lastAmountInHand - int.Parse(TextExpenseAmt);

                    //Inserting Amount in Hand Table
                    string queryIAH = "INSERT INTO [Act_AmountInHand]([AmtInHand] " +
                                      ",[Employee_Id],[EmployeeName],[BranchName],[Created_Date],[Created_By] " +
                                      ",[Modified_Date],[Modified_By],[Deleted],[Branch_Id],[CashReceived],[CaseDispersed]) " +
                                      "VALUES (" + latestAmtInHand + ",'" + userName + "','" + UserFullName + "' " +
                                      ",'" + DisToBranchName + "',getdate(),'" + userName + "',getdate(),'" + userName + "',0," + DisToBrachId + "," + TextExpenseAmt + ",0)";
                    cn.Open();
                    SqlCommand cmdIAH = new SqlCommand(queryIAH, cn);
                    int result2 = cmdIAH.ExecuteNonQuery();
                    cn.Close();
                    if (result2 > 0)
                    {
                        string queryIAB = "";
                        if (LastAmtInHand == "")
                        {
                            queryIAB = "INSERT INTO [Act_AmtInBranch]([AmountInHand],[Employee_Id],[Employee_Name] " +
                                          ",[Branch_Id],[Branch_Name])VALUES(" + latestAmtInHand + ",'" + userName + "','" + UserFullName + "'," + DisToBrachId + ",'" + DisToBranchName + "' )";
                        }
                        else
                        {
                            queryIAB = "update Act_AmtInBranch set AmountInHand = " + latestAmtInHand + " where Employee_Id = '" + userName + "' ";
                        }
                        cn.Open();
                        SqlCommand cmdIAB = new SqlCommand(queryIAB, cn);
                        cmdIAB.ExecuteNonQuery();
                        cn.Close();

                    }

                }
            }

        }
    }


    #region Add Payment Nature [Oct 27, 2011] by Obaid
    [WebMethod]
    public static void InsertPaymentNature(string PaymentNature)
    {
        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionstring2"].ToString()))
        {
            string query = "INSERT INTO [Act_PaymentNature]([PaymentNatureName]) VALUES ('" + PaymentNature + "')";
            SqlCommand cmd = new SqlCommand(query, cn);
            cn.Open();
            cmd.ExecuteNonQuery();

        }
    }
    #endregion


    [WebMethod]
    public static void UpdateExpense(string expID, string txtExpenseDate, string TextExpenseAmt, string txtExpDetails, string ddlExpenseCategory, string ddlExpenseType,
        string ddlPaymentMode, string ddlProjectName, string ddlExpStatus, string ddlApprovalStatus, string ddlApprovingAuthority)
    {
        string userName = HttpContext.Current.Session["UserName"].ToString();
        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionstring2"].ToString()))
        {
            if (expID != "")
            {
                string query = "update [Act_Expense] " +
                               "set [Expense_Amount]=" + TextExpenseAmt + ", [Expense_Detail] = '" + txtExpDetails + "',[Expense_Date]='" + txtExpenseDate + "',[Expense_Type]=" + ddlExpenseType + "" +
                               ",[Expense_Project]=" + ddlProjectName + ",[Expense_Status]='" + ddlExpStatus + "',[Expense_Category]='" + ddlExpenseCategory + "'" +
                               ",[Expense_By]='" + userName + "',[Created_By]='" + userName + "',[Created_Date]=getdate(),[Modeof_Payment]='" + ddlPaymentMode + "'," +
                                "[Approval_Status]='" + ddlApprovalStatus + "',[Approval_Authority]='" + ddlApprovingAuthority + "',[Modified_By]='" + userName + "',[Modified_Date]=getdate() where Expense_Id=" + expID;

                SqlCommand cmd = new SqlCommand(query, cn);
                cn.Open();
                cmd.ExecuteNonQuery();
            }

        }
    }

    [WebMethod]
    public static void UpdateReceiptData(string Recp_Id, string Rep_Date, string Rcp_Amount, string Rcp_Recievedby, string Rcp_Receivedfrom, string Rcp_PaymentMode, string Rcp_ForProject)
    {
        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionstring2"].ToString()))
        {
            string moddate = DateTime.Now.ToShortDateString();
            string modby = HttpContext.Current.Session["UserName"].ToString();
            SqlCommand cmd = new SqlCommand("UPDATE Act_Reciepts SET Rep_Date='" + Rep_Date + "',Rcp_Amount=" + Rcp_Amount + ", Rcp_Recievedby='" + Rcp_Recievedby + "',Rcp_Receivedfrom='" + Rcp_Receivedfrom + "',Rcp_PaymentMode='" + Rcp_PaymentMode + "', Rcp_ForProject='" + Rcp_ForProject + "',Modified_By ='" + modby + "', Modified_Date='" + moddate + "' where Recp_Id = '" + Recp_Id + "'", cn);
            cn.Open();
            cmd.ExecuteNonQuery();
        }
    }

    [WebMethod]
    public static void UpdateDespData(string Desp_Id, string PreDesp_To, string Desp_To, string Desp_By, string Desp_Method, string Desp_Amount)
    {
        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionstring2"].ToString()))
        {
            string mdby = HttpContext.Current.Session["UserName"].ToString();
            string branchid = getBranchID(Desp_To);
            SqlCommand cmd = new SqlCommand("UPDATE Act_Dispersment SET DisPersed_By = '" + Desp_By + "', Dispersed_Method = '" + Desp_Method + "', Dispersed_Amount = '" + Desp_Amount + "', Dispersed_To = '" + Desp_To + "', Amt_cashInBranch_Id = '" + branchid + "', Modified_By = '" + mdby + "', Modified_Date = getdate() where Dispersment_Id = '" + Desp_Id + "'", cn);
            cn.Open();
            cmd.ExecuteNonQuery();
        }
    }



    protected void btnExpenseDetails_Click(object sender, EventArgs e)
    {
        Response.Redirect("FrmExpenseDetails.aspx");
    }
    protected void btnViewRecpts_Click(object sender, EventArgs e)
    {
        Response.Redirect("FrmReciptsDetails.aspx");
    }
    protected void btnDisDetails_Click(object sender, EventArgs e)
    {
        Response.Redirect("frmDisbursementDetails.aspx");
    }
    /////////////////////////////////////Receivables/////////////////////////////////////////
    [WebMethod]
    public static void SaveReceivables(string InvoiceTo, string InvoiceAmount, string InvoiceDate, string PaymentDueon, string InvoiceNo, string PONumber, string PODate, string GST, string WHT)
    {
        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionstring2"].ToString()))
        {
            string cDate = DateTime.Now.ToShortDateString();
            string cBy = HttpContext.Current.Session["UserName"].ToString();
            SqlCommand cmd = new SqlCommand("INSERT INTO ACT_Recievables(invoice_to, Invoice_Amount, Invoice_Date, Payment_Due_On, Invoice_No, PO_No,GST,WHT, PO_Date, Created_Date, Created_By, Deleted) Values('" + InvoiceTo + "','" + InvoiceAmount + "','" + InvoiceDate + "','" + PaymentDueon + "','" + InvoiceNo + "' ,'" + PONumber + "','" + GST + "','" + WHT + "', '" + PODate + "', '" + cDate + "','" + cBy + "', '" + false + "')", cn);
            cn.Open();
            cmd.ExecuteNonQuery();
        }
    }
    public void ReceivableAmt()
    {
        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionstring2"].ToString()))
        {
            string query = "";
            query = "SELECT Invoice_Amount from ACT_Recievables where isnull(deleted,0)<>1";
            DataTable dt = new DataTable();
            SqlDataAdapter da = new SqlDataAdapter(query, cn);
            da.Fill(dt);
            object sumObject;
            sumObject = dt.Compute("Sum(Invoice_Amount)", "");
            lblTotalAmount.Text = sumObject.ToString();
        }
    }
    protected void btnRecableDetails_Click(object sender, EventArgs e)
    {
        Response.Redirect("FrmReceivableDetails.aspx");
    }
    [WebMethod]
    public static void UpdateReceivables(string InvoiceID, string InvoiceTo, string InvoiceAmount, string InvoiceDate, string PaymentDueon, string InvoiceNo, string PONumber, string PODate, string GST, string WHT)
    {
        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionstring2"].ToString()))
        {
            string mDate = DateTime.Now.ToShortDateString();
            string mBy = HttpContext.Current.Session["UserName"].ToString();
            SqlCommand cmd = new SqlCommand("UPDATE ACT_Recievables SET invoice_to = '" + InvoiceTo + "', Invoice_Amount = '" + InvoiceAmount + "', Invoice_Date = '" + InvoiceDate + "',Payment_Due_On = '" + PaymentDueon + "', Invoice_No = '" + InvoiceNo + "', PO_No = '" + PONumber + "', PO_Date = '" + PODate + "', GST = '" + GST + "', WHT = '" + WHT + "', Modified_Date = '" + mDate + "', Modified_By = '" + mBy + "', Deleted = '" + false + "' where invoice_id = '" + InvoiceID + "'", cn);
            cn.Open();
            cmd.ExecuteNonQuery();
        }
    }

    //------------------------------------Populate ddl added by Tahir Kazmi-------------------------------------------------------

    public static Dictionary<string, object> ToJson(DataTable table)
    {
        Dictionary<string, object> j = new Dictionary<string, object>();
        j.Add(table.TableName, RowsToDictionary(table));
        return j;
    }

    private static List<Dictionary<string, object>> RowsToDictionary(DataTable table)
    {
        List<Dictionary<string, object>> objs =
            new List<Dictionary<string, object>>();
        foreach (DataRow dr in table.Rows)
        {
            Dictionary<string, object> drow = new Dictionary<string, object>();
            for (int i = 0; i < table.Columns.Count; i++)
            {
                drow.Add(table.Columns[i].ColumnName, dr[i]);
            }
            objs.Add(drow);
        }

        return objs;
    }
    [WebMethod]
    public static Dictionary<string, object> GetExpenseType(string catID)
    {
        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionstring2"].ToString()))
        {
            SqlCommand cmd = new SqlCommand("select exType.expenseType_id,exType.ExpenseType_Name from Act_ExpenseType exType where exType.ExpenseCatid=" + int.Parse(catID) + "", cn);
            cn.Open();
            SqlDataAdapter DA = new SqlDataAdapter(cmd);
            DataSet ds = new DataSet();
            DA.Fill(ds, "Act_ExpenseType");
            DataTable dt = new DataTable();
            dt = ds.Tables["Act_ExpenseType"];
            return ToJson(dt);
        }
    }



    /////////////////////////////////////////////////////////////////////////////////////////


    protected void btnRefresh_Click(object sender, EventArgs e)
    {
        Response.Redirect("ReceiptsAndExpense.aspx");
    }
    protected void btnRefresh_Click1(object sender, EventArgs e)
    {
        Response.Redirect("ReceiptsAndExpense.aspx");
    }
    #region DisbursementSummary
    [WebMethod]
    public static string SummaryDisbB(string BranchID)
    {
        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionstring2"].ToString()))
        {
            string CashDisbursedB = "";
            string CashExpenseB = "";
            int CashinBranch = 0;
            SqlCommand cmdCashDispersedIB = new SqlCommand("SELECT SUM(Dispersed_Amount) as CashDisbursedB from Act_Dispersment where Amt_cashInBranch_Id =" + BranchID + " and isnull(deleted,0)<>1", cn);
            SqlCommand cmdCashExpenseIB = new SqlCommand("SELECT SUM(Expense_Amount) as CashExpenseB from Act_Expense where Branch_ID = '" + BranchID + "' and isnull(Deleted,0)<>1", cn);
            cn.Open();
            try
            {
                CashDisbursedB = cmdCashDispersedIB.ExecuteScalar().ToString();
                if (CashDisbursedB == "")
                {
                    CashDisbursedB = "0";
                }
                CashExpenseB = cmdCashExpenseIB.ExecuteScalar().ToString();
                if (CashExpenseB == "")
                {
                    CashExpenseB = "0";
                }

                CashinBranch = int.Parse(CashDisbursedB) - int.Parse(CashExpenseB);
            }
            catch (Exception ex)
            {
                //throw;
            }
            return CashinBranch.ToString();
        }
    }
    [WebMethod]
    public static string SummaryDisbE(string EmployeeID)
    {
        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionstring2"].ToString()))
        {
            SqlCommand cmdCashDispersedIH = new SqlCommand("SELECT SUM(Dispersed_Amount) as CashDisbursed from Act_Dispersment where Dispersed_To= '" + EmployeeID + "' and isnull(deleted,0)<>1", cn);
            SqlCommand cmdCashExpenseIH = new SqlCommand("SELECT SUM(Expense_Amount) as CashExpense from Act_Expense where Expense_By = '" + EmployeeID + "' and isnull(Deleted,0)<>1", cn);
            cn.Open();
            int CashinHand = 0;
            string CashDisbursed = "";
            string CashExpense = "";
            try
            {
                SqlDataAdapter daN = new SqlDataAdapter(cmdCashDispersedIH);
                DataTable dtN = new DataTable();
                daN.Fill(dtN);
                CashDisbursed = dtN.Rows[0]["CashDisbursed"].ToString();
                if (CashDisbursed == "")
                {
                    CashDisbursed = "0";
                }
                SqlDataAdapter daN1 = new SqlDataAdapter(cmdCashExpenseIH);
                DataTable dtN1 = new DataTable();
                daN1.Fill(dtN1);
                CashExpense = dtN1.Rows[0]["CashExpense"].ToString();
                if (CashExpense == "")
                {
                    CashExpense = "0";
                }
                CashinHand = int.Parse(CashDisbursed) - int.Parse(CashExpense);

                // BranchId = dtN.Rows[0]["Branch_Id"].ToString();

            }
            catch (Exception ex)
            {
                //throw;
            }
            return CashinHand.ToString();
        }
    }

    [WebMethod]
    public static string SummaryDisbTotal()
    {
        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionstring2"].ToString()))
        {
            int amount = 0;
            string CashDisbursed = "";
            string CashExpense = "";
            SqlCommand cmdCashDisbursement = new SqlCommand("SELECT sum(Dispersed_Amount)as CashInTotal from Act_Dispersment where isnull(deleted,0)<>1", cn);
            SqlCommand cmdCashExpense = new SqlCommand("SELECT SUM(Expense_Amount) as CashExpense from Act_Expense where isnull(Deleted,0)<>1", cn);
            cn.Open();
            try
            {
                SqlDataAdapter DA = new SqlDataAdapter(cmdCashDisbursement);
                DataTable DT = new DataTable();
                DA.Fill(DT);
                CashDisbursed = DT.Rows[0]["CashInTotal"].ToString();
                if (CashDisbursed == "")
                {
                    CashDisbursed = "0";
                }
                SqlDataAdapter DA1 = new SqlDataAdapter(cmdCashExpense);
                DataTable DT1 = new DataTable();
                DA1.Fill(DT1);
                CashExpense = DT1.Rows[0]["CashExpense"].ToString();
                if (CashExpense == "")
                {
                    CashExpense = "0";
                }
                amount = int.Parse(CashDisbursed) - int.Parse(CashExpense);
            }
            catch (Exception)
            {

                //throw;
            }
            return amount.ToString();
        }
    }
    #endregion

}

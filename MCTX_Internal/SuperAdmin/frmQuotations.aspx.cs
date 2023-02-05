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
using System.Web.Services;
using System.Data.SqlClient;
using System.Collections.Generic;

public partial class MCTX_Internal_SuperAdmin_Quotations : System.Web.UI.Page
{
    #region Variables
    _Quotation objQuot = new _Quotation();
    _UserTask objUTask = new _UserTask();
    _ProspectingList objpros = new _ProspectingList();
    DataTable dt_item;
    DataTable dt_TermsAndCondition;
    #endregion

    #region Methods
    private void CreateTable()
    {
        dt_item = new DataTable("Add_items");
        dt_item.Columns.Add("itemid", typeof(int));
        dt_item.Columns.Add("itemname", typeof(string));
        dt_item.Columns.Add("description", typeof(string));
        dt_item.Columns.Add("quantity", typeof(int));
        dt_item.Columns.Add("unit", typeof(string));
        dt_item.Columns.Add("price", typeof(double));
        dt_item.Columns.Add("totalprice", typeof(double));
        dt_item.Columns.Add("gstPercent", typeof(double));
        dt_item.Columns.Add("gst", typeof(double));
        dt_item.Columns.Add("qitem_id", typeof(int));
        dt_item.Columns.Add("FromDB", typeof(string));
        dt_item.Columns.Add("QuotationId", typeof(string));
        dt_item.Columns.Add("ItemCat", typeof(string));
        dt_item.Columns.Add("PriceType", typeof(string));
        ViewState["DataTable"] = dt_item;
    }
    private void CreateTableTerm()
    {
        dt_TermsAndCondition = new DataTable("Add_terms");
        dt_TermsAndCondition.Columns.Add("ID", typeof(int));
        dt_TermsAndCondition.Columns.Add("TermTypeID", typeof(int));
        dt_TermsAndCondition.Columns.Add("TermType", typeof(string));
        dt_TermsAndCondition.Columns.Add("TermNameID", typeof(int));
        dt_TermsAndCondition.Columns.Add("TermName", typeof(string));
        dt_TermsAndCondition.Columns.Add("TermDiscription", typeof(string));
        dt_TermsAndCondition.Columns.Add("FromDB", typeof(string));
        dt_TermsAndCondition.Columns.Add("QuotationId", typeof(string));
        
        ViewState["DataTable1"] = dt_TermsAndCondition;
    }
    public void GetClients(int comp_id)
    {
        DataTable dt_Clients = objQuot.fnGetClients(comp_id);
        ddlClient.DataSource = dt_Clients;
        ddlClient.DataValueField = "client_id";
        ddlClient.DataTextField = "client_name";
        ddlClient.DataBind();
        ddlClient.Items.Insert(0, "-- Select --");
    }
    public void GetCompany()
    {
        DataTable dt_Company = objQuot.fnGetCompany();
        ddlCompany.DataSource = dt_Company;
        ddlCompany.DataValueField = "comp_id";
        ddlCompany.DataTextField = "comp_name";
        ddlCompany.DataBind();
        ddlCompany.Items.Insert(0, "-- Select --");
    }
    public void GetTerm()
    {
        //DataTable dt_Terms = objQuot.fnGetTerm();
        //ddlSelectTerm.DataSource = dt_Terms;
        //ddlSelectTerm.DataValueField = "term_id";
        //ddlSelectTerm.DataTextField = "term_name";
        //ddlSelectTerm.DataBind();
        //ddlSelectTerm.Items.Insert(0, "-- Select --");
    }
    public void GetManagers()
    {
        DataTable dt_Managers = objQuot.fnGetMangers();
        ddlSaleManager.DataSource = dt_Managers;
        ddlSaleManager.DataValueField = "E_badge";
        ddlSaleManager.DataTextField = "E_Name";
        ddlSaleManager.DataBind();
        ddlSaleManager.Items.Insert(0, "-- Select --");
    }
    public void GetTechPersons()
    {
        DataTable dt_TechPersons = objQuot.fnGetTechPersons();
        ddlTechPerson.DataSource = dt_TechPersons;
        ddlTechPerson.DataValueField = "E_badge";
        ddlTechPerson.DataTextField = "E_Name";
        ddlTechPerson.DataBind();
        ddlTechPerson.Items.Insert(0, "-- Select --");
    }
    public void GetItemsCategory()
    {
        DataTable dt_ItemCat = objQuot.fnGetItemsCategory();
        ddlItemCat.DataSource = dt_ItemCat;
        ddlItemCat.DataValueField = "cat_id";
        ddlItemCat.DataTextField = "cat_name";
        ddlItemCat.DataBind();
        ddlItemCat.Items.Insert(0, "-- Select --");
    }
    public void GetItems(String catId)
    {
        DataTable dt_Items = objQuot.fnGetItems(catId);
        ddlItem.DataSource = dt_Items;
        ddlItem.DataValueField = "item_id";
        ddlItem.DataTextField = "item_name";
        ddlItem.DataBind();
        ddlItem.Items.Insert(0, "-- Select --");
    }
    public void BindGrid(DataTable dt_item)
    {
        GridQuotItems.DataSource = dt_item;
        GridQuotItems.DataBind();
    }
    public void BindGridGVTermsAndCondition(DataTable dt_item)
    {
        GVTermsAndCondition.DataSource = dt_item;
        GVTermsAndCondition.DataBind();
    }
    private void ClearFields()
    {
        txtQuantity.Text = "";
        CreateTable();
        CreateTableTerm();
        btnSave.Visible = true;
        btnUpdate1.Visible = false;
        btnAdd.Visible = true;
        btnUpdate.Visible = false;
        DataTable dt_item = (DataTable)ViewState["DataTable"];
        BindGrid(dt_item);
        DataTable dt_Term = (DataTable)ViewState["DataTable1"];
        BindGridGVTermsAndCondition(dt_Term);
        lblmessage.Text = "";
        lblTermsAndDiscription.Text = "";
    }
    public void SetTermValues(DataTable dt_Term, int index) {
        ddlType.SelectedValue = Convert.ToString(dt_Term.Rows[index]["TermTypeID"]);
        GetTermNames(Convert.ToInt16(ddlType.SelectedValue));
        ddlTermName.SelectedValue = Convert.ToString(dt_Term.Rows[index]["TermNameID"]);
        txtDiscription.Value = Convert.ToString(dt_Term.Rows[index]["TermDiscription"]);
        btnAddTermsAndCondition.Visible = false;
        btnUpdateTermsAndCondition.Visible = true;
    }
    public void SetRecordValues(DataTable dt_item,int index)
    {
        txtPrice.Text = dt_item.Rows[index]["price"].ToString();
        txtQuantity.Text = dt_item.Rows[index]["quantity"].ToString();
        txtGST.Text = dt_item.Rows[index]["gstPercent"].ToString();
        ddlItemCat.SelectedValue = Convert.ToString(dt_item.Rows[index]["ItemCat"]);//
        ddlPriceType.SelectedValue = Convert.ToString(dt_item.Rows[index]["PriceType"]);
        GetItems(ddlItemCat.SelectedValue.ToString());
        ddlItem.SelectedValue = Convert.ToString(dt_item.Rows[index]["itemid"]);
        ddlIUnit.SelectedValue = Convert.ToString(dt_item.Rows[index]["unit"]);
        btnUpdate.Visible = true;
        btnAdd.Visible = false;
        if (int.Parse(dt_item.Rows[index]["gstPercent"].ToString()) != 0)
        {
            cboxGST.Checked = true;
        }
        else
        {
            cboxGST.Checked = false;
        }
    }
    public void BindQuotGridView()
    {
        DataTable dt_QuotData = objQuot.fnGetQuotations();
        GridQuotations.DataSource = dt_QuotData;
        GridQuotations.DataBind();
    }
    #endregion
    #region Events
    protected void Page_Load(object sender, EventArgs e)
    {
        txtGST.Enabled = false;
        try
        {
            string role = Session["Role"].ToString();
            if (role == "Employee")
            {
                Response.Redirect("Accessdenied.aspx");
                return;
            }
            if (!IsPostBack)
            {
                GetTermType();
                CreateTable();
                CreateTableTerm();
                GetCompany();
                GetManagers();
                GetTerm();
                
                GetTechPersons();
                btnUpdate.Visible = false;
                btnUpdateTermsAndCondition.Visible = false;
                btnUpdate1.Visible = false;
                ddlClient_SelectedIndexChanged(null, null);
                ddlSelectTerm_SelectedIndexChanged(null,null);
                GridQuotations.Visible = false;
                GetItemsCategory();
            }
        }
        catch(Exception ex)
        {

        }
    }
    protected void btnViewQot_Click(object sender, EventArgs e)
    {
        if (GridQuotations.Visible == true)
        {
            GridQuotations.Visible = false;
            btnViewQot.Text = "Search Previous Quotations";
        }
        else
        {
            GridQuotations.Visible = true;
            BindQuotGridView();
            btnViewQot.Text = "Hide Quotations List";
        }
    }
    protected void btnAdd_Click(object sender, EventArgs e)
    {
        try
        {
            lblmessage.Text = "";
            dt_item = (DataTable)ViewState["DataTable"];

            DataRow[] dr1 = dt_item.Select("itemid='"+ddlItem.SelectedValue+"'");

            if (dr1.Count() > 0)
            {
                lblmessage.Text = "Item Already Exist";
                lblmessage.ForeColor = System.Drawing.Color.Red;
                return;
            }

            DataRow dr = dt_item.NewRow();
            DataTable dt_ItemDescription = objQuot.fnGetItemData(int.Parse(ddlItem.SelectedValue));
            float gst=0;
            //setting GST percentage
            if (cboxGST.Checked && txtGST.Text != "")
            {
                gst = ((float.Parse(txtPrice.Text) * float.Parse(txtQuantity.Text)) * float.Parse(txtGST.Text)) / 100;
                dr["gstPercent"] = float.Parse(txtGST.Text);
            }
            else
            {
                dr["gstPercent"] = 0;
                gst = 0 ;
            }
            double totalPrice = (double.Parse(txtPrice.Text) * int.Parse(txtQuantity.Text)) + gst;
            dr["ItemCat"] = Convert.ToInt32(ddlItemCat.SelectedValue);
            dr["itemid"] = int.Parse(ddlItem.SelectedValue);
            dr["PriceType"] = ddlPriceType.SelectedValue;
            dr["itemname"] = ddlItem.SelectedItem.Text;
            if (dt_ItemDescription.Rows.Count > 0)
            {
                dr["description"] = dt_ItemDescription.Rows[0][0].ToString();
            }
            else
            {
                dr["description"] = "No Discription Given For This Item";
            }
            dr["quantity"] = int.Parse(txtQuantity.Text);
            dr["price"] = float.Parse(txtPrice.Text);
            dr["unit"] = ddlIUnit.SelectedValue;
            dr["totalprice"] = string.Format("{0:#,##0.##}", Convert.ToInt64(totalPrice));
            dr["gst"] = Convert.ToInt64(gst);
            dr["FromDB"] = "0";
            dr["QuotationId"] = "0";
            dr["qitem_id"] = "0";
            dt_item.Rows.Add(dr);
            ViewState["DataTable"] = dt_item;
            BindGrid(dt_item);
            //txtQuantity.Text = "";
        }
        catch (Exception ex)
        { 
            
        }
    }
    protected void btnUpdate_Click(object sender, EventArgs e)
    {
        try
        {
            lblmessage.Text = "";
            dt_item = (DataTable)ViewState["DataTable"];
            DataRow dr;
            dr = dt_item.Rows[(int)ViewState["RID"]];
            DataTable dt_ItemDescription = objQuot.fnGetItemData(int.Parse(ddlItem.SelectedValue));
            double gst = 0;
            //setting GST percentage
            if (txtGST.Text == "") txtGST.Text = "0";
            if (cboxGST.Checked)
            {
                dr["gstPercent"] = txtGST.Text;
                gst = ((double.Parse(txtPrice.Text) * int.Parse(txtQuantity.Text)) * Convert.ToInt32(txtGST.Text)) / 100;
            }
            else
            {
                gst = 0;
            }
            double totalPrice = (double.Parse(txtPrice.Text) * int.Parse(txtQuantity.Text)) + gst;
            dr["ItemCat"] = Convert.ToInt32(ddlItemCat.SelectedValue);
            dr["itemid"] = int.Parse(ddlItem.SelectedValue);
            dr["PriceType"] = ddlPriceType.SelectedValue;
            dr["itemname"] = ddlItem.SelectedItem.Text;
            if(dt_ItemDescription.Rows.Count > 0)
                dr["description"] = dt_ItemDescription.Rows[0][0].ToString();
            else
                dr["description"] = "";

            dr["quantity"] = int.Parse(txtQuantity.Text);
            dr["price"] = double.Parse(txtPrice.Text);
            dr["unit"] = ddlIUnit.SelectedValue;
            dr["totalprice"] = totalPrice;
            dr["gst"] = gst;
            
            
            dr.AcceptChanges();
            ViewState["DataTable"] = dt_item;
            BindGrid(dt_item);
            txtQuantity.Text = "";
            btnUpdate.Visible = false;
            btnAdd.Visible = true;
            lblmessage.Text = "Quotation Line Updateed, You have to press Update Quote button at end to save permanently";
            lblmessage.ForeColor = System.Drawing.Color.Green;
        }
        catch (Exception)
        { 
            
        }
    }
    public void GetTermType()
    {
        ddlType.DataSource = objUTask.getTermType();
        ddlType.DataTextField = "TypeName";
        ddlType.DataValueField = "ID";
        ddlType.DataBind();
        ddlType.Items.Insert(0, "Select");
    }
    public void GetTermNames( int TermsName)
    {
        ddlTermName.DataSource = objUTask.getTermName(TermsName);
        ddlTermName.DataTextField = "Term_Name";
        ddlTermName.DataValueField = "Term_ID";
        ddlTermName.DataBind();
        ddlTermName.Items.Insert(0, "Select");
    }
    protected void ddlClient_SelectedIndexChanged(object sender, EventArgs e)
    {
        int client_id = 0;
        bool result = int.TryParse(ddlClient.SelectedValue, out client_id);
        if (result)
        {
            DataTable dt_ClientRecord = objQuot.fnGetClientRecord(client_id);
            // Setting Text Fields Text For The Select Client
            if (dt_ClientRecord.Rows.Count > 0)
            {
                txtDesignation.Text = dt_ClientRecord.Rows[0]["client_designation"].ToString();
                txtDepartment.Text = dt_ClientRecord.Rows[0]["client_dept"].ToString();
               // txtCompany.Text = dt_ClientRecord.Rows[0]["comp_name"].ToString();
            }
        }
    }
    protected void ddlSelectTerm_SelectedIndexChanged(object sender, EventArgs e)
    {
        int term_id = 0;
        bool result = int.TryParse(ddlSelectTerm.SelectedValue, out term_id);
        if (result)
        {
           // DataTable dt_TermDescription = objQuot.fnGetTermDescriptionRecord(term_id);


            //ddlTermDescription.DataSource = dt_TermDescription;
            //ddlTermDescription.DataValueField = "term_description_id";
            //ddlTermDescription.DataTextField = "term_description";
            //ddlTermDescription.DataBind();
            //ddlTermDescription.Items.Insert(0, "-- Select --");

            //txtCompany.Text = dt_TermDescription.Rows[0]["term_description"].ToString();
        }
    }
    protected void btnSave_Click(object sender, EventArgs e)
    {
        try
        {
            int status = 0;
            lblmessage.Text = "";
            dt_item = (DataTable)ViewState["DataTable"];
            dt_TermsAndCondition = (DataTable)ViewState["DataTable1"];
            string EmpID = Session["EmployeeID"].ToString();
            float gstPercent = float.Parse(txtGST.Text == "" ? "0" : txtGST.Text);
            int result = 
                objQuot.AddQuotation(int.Parse(ddlClient.SelectedValue), ddlSaleManager.SelectedValue, ddlTechPerson.SelectedValue,
                txtQuotationSubject.Text, txtCustomerSite.Text, EmpID, txtPaymentTerms.Text, txtWarrantyTerms.Text, txtWarrantyException.Text, txtDeliveryInstallation.Text, txtValidity.Text, txtTexExemption.Text, textAreaSpecialNotes.Value);
            
            int quo_id = objQuot.GetQuotID();
            ViewState["quo_id"] = quo_id;
            for (int i = 0; i < dt_item.Rows.Count; i++)
            {
              status = objQuot.AddQuotItem(quo_id, Convert.ToInt32(dt_item.Rows[i]["itemid"]), Convert.ToInt32(dt_item.Rows[i]["quantity"]),
                    Convert.ToInt32(dt_item.Rows[i]["price"]), Convert.ToString(dt_item.Rows[i]["unit"]),
                    Convert.ToInt32(dt_item.Rows[i]["gst"]), float.Parse(Convert.ToString(dt_item.Rows[i]["gstPercent"])), dt_item.Rows[i]["FromDB"].ToString(), dt_item.Rows[i]["qitem_id"].ToString()
                    , dt_item.Rows[i]["ItemCat"].ToString(), dt_item.Rows[i]["PriceType"].ToString());//
            }

            for (int i = 0; i < dt_TermsAndCondition.Rows.Count; i++)
            {
                status = objQuot.AddTermsAndCondition(quo_id, Convert.ToInt32(dt_TermsAndCondition.Rows[i]["TermTypeID"]), Convert.ToInt32(dt_TermsAndCondition.Rows[i]["TermNameID"]), dt_TermsAndCondition.Rows[i]["FromDB"].ToString(),
                    dt_TermsAndCondition.Rows[i]["TermType"].ToString(), dt_TermsAndCondition.Rows[i]["TermName"].ToString(), dt_TermsAndCondition.Rows[i]["TermDiscription"].ToString(), Convert.ToInt32(dt_TermsAndCondition.Rows[i]["ID"]));//
            }
            if (status == 1)
            {
                lblQuotation.Text = "Successfuly Saved Quotation";
                lblQuotation.ForeColor = System.Drawing.Color.Green;
            }
            else
            {
                lblQuotation.Text = "Quotation Not Saved";
                lblQuotation.ForeColor = System.Drawing.Color.Red;
            }
          //  ViewState["DataTable"] = "";
        }
        catch (Exception ex)
        {
            lblQuotation.Text = "Quotation Not Saved";
            lblQuotation.ForeColor = System.Drawing.Color.Red;
        }
        btnSave.Visible = true;
        btnUpdate1.Visible = false;
        btnAdd.Visible = true;
        btnUpdate.Visible = false;
    }
    protected void btnUpdate1_Click(object sender, EventArgs e)
    {
        try
        {
            lblmessage.Text = "";
            dt_item = (DataTable)ViewState["DataTable"];
            dt_TermsAndCondition = (DataTable)ViewState["DataTable1"];
            int status = 0;
            float gstPercent = float.Parse(txtGST.Text == "" ? "0" : txtGST.Text);
            String QuotationId = "";
            String DeletedItems = "";
            String QuotationIdTerm = "";
            String DeletedTerms = "";
            
            if (ViewState["Deletequo_id"] != null)
            {
                String[] QTIDandQitemId = ViewState["Deletequo_id"].ToString().Split('~');
                QuotationId = QTIDandQitemId[0].ToString();
                DeletedItems = QTIDandQitemId[1].ToString();
            }
            else
            {
               QuotationId = dt_item.Rows[0]["QuotationId"].ToString();
            }


            //For Tarms and Condotion
            if (ViewState["Deleteterm_id"] != null)
            {
                String[] QTIDandQTerms = ViewState["Deleteterm_id"].ToString().Split('~');
                QuotationIdTerm = QTIDandQTerms[0].ToString();
                DeletedTerms = QTIDandQTerms[1].ToString();
            }
            else
            {
                QuotationIdTerm = dt_TermsAndCondition.Rows[0]["QuotationId"].ToString();
            }
            //end Terms and Condition
          int result =
               objQuot.UpdateQuotation(int.Parse(ddlClient.SelectedValue), ddlSaleManager.SelectedValue, ddlTechPerson.SelectedValue,
                txtQuotationSubject.Text, txtCustomerSite.Text, Convert.ToInt32(QuotationId), Session["EmployeeID"].ToString(), txtPaymentTerms.Text, txtWarrantyTerms.Text, txtWarrantyException.Text, txtDeliveryInstallation.Text, txtValidity.Text, txtTexExemption.Text, textAreaSpecialNotes.Value);

            if (DeletedItems != String.Empty)
            {

                if (DeletedItems.Contains('*'))
                {
                    String[] QIdsToDelete = DeletedItems.Split('*');
                    foreach (string s in QIdsToDelete)
                    {
                        int rows = objQuot.fnDeleteQuotationItems(Convert.ToInt32(s));  
                    }
                }
                else
                {
                    int rows = objQuot.fnDeleteQuotationItems(Convert.ToInt32(DeletedItems));
                }
            }

            //delete terms and condition
            if (DeletedTerms != String.Empty)
            {

                if (DeletedTerms.Contains('*'))
                {
                    String[] QIdsToDelete = DeletedItems.Split('*');
                    foreach (string s in QIdsToDelete)
                    {
                        int rows = objQuot.fnDeleteQuotationTerms(Convert.ToInt32(s));
                    }
                }
                else
                {
                    int rows = objQuot.fnDeleteQuotationTerms(Convert.ToInt32(DeletedTerms));
                }
            }
            //end terms and condition deleted
           // float gstPrice;
            if (result > 0)
            {
                
                for (int i = 0; i < dt_item.Rows.Count; i++)
                {
                   // gstPrice = float.Parse(dt_item.Rows[i]["gstPercent"].ToString());
                    status = 
                        objQuot.AddQuotItem(Convert.ToInt32(QuotationId), 
                                                 Convert.ToInt32(dt_item.Rows[i]["itemid"]), 
                                                 Convert.ToInt32(dt_item.Rows[i]["quantity"]), 
                                                 Convert.ToDouble(dt_item.Rows[i]["price"]), 
                                                 Convert.ToString(dt_item.Rows[i]["unit"]),
                                                 Convert.ToDouble(dt_item.Rows[i]["gst"]),
                                                 float.Parse(Convert.ToString(dt_item.Rows[i]["gstPercent"])), 
                                                 dt_item.Rows[i]["FromDB"].ToString(), 
                                                 dt_item.Rows[i]["qitem_id"].ToString(),
                                                 dt_item.Rows[i]["ItemCat"].ToString(),
                                                 dt_item.Rows[i]["PriceType"].ToString()
                                                 );
                }
                //update and add quotation terms and condition
                for (int i = 0; i < dt_TermsAndCondition.Rows.Count; i++)
                {
                    status = objQuot.AddTermsAndCondition(Convert.ToInt32(QuotationIdTerm),
                        Convert.ToInt32(dt_TermsAndCondition.Rows[i]["TermTypeID"]),
                        Convert.ToInt32(dt_TermsAndCondition.Rows[i]["TermNameID"]),
                        dt_TermsAndCondition.Rows[i]["FromDB"].ToString(),
                        dt_TermsAndCondition.Rows[i]["TermType"].ToString(),
                        dt_TermsAndCondition.Rows[i]["TermName"].ToString(),
                        dt_TermsAndCondition.Rows[i]["TermDiscription"].ToString(),
                     Convert.ToInt32(dt_TermsAndCondition.Rows[i]["ID"]));//
                }

                BindQuotGridView();
                ClearFields();
                ViewState["DataTable"] = "";
                ViewState["DataTable1"] = "";
                lblQuotation.Text = "Record Updated Successfully";
                lblQuotation.ForeColor = System.Drawing.Color.Green;
                ViewState["Deletequo_id"] = null;
                ViewState["Deleteterm_id"] = null;
            }
        }
        catch (Exception ex)
        {
            lblQuotation.Text = "Error In Update Quotation";
            lblQuotation.ForeColor = System.Drawing.Color.Red;
        }
    }
    protected void btnClear_Click(object sender, EventArgs e)
    {
        ClearFields();
        
        txtQuotationSubject.Text = "";
        //ddlClient.SelectedValue.Replace(ddlClient.SelectedValue,"0");
     ////   ddlClient.SelectedIndex = 0;
        txtCustomerSite.Text = "";
        //ddlSaleManager.SelectedValue.Replace(ddlSaleManager.SelectedValue, "0");
        ddlSaleManager.SelectedIndex = 0;

        ddlTechPerson.SelectedIndex = 0;
        //ddlTechPerson.SelectedValue.Replace(ddlTechPerson.SelectedValue, "0");
        //ddlItem.SelectedValue.Replace(ddlItem.SelectedValue, "0");
        try
        {
            ddlItem.SelectedIndex = 0;
            ddlItemCat.SelectedIndex = 0;
            ddlPriceType.SelectedIndex = 0;
        }
        catch (Exception ex)
        {
            
            //throw;
        } 
        ddlIUnit.SelectedIndex = 0;

        txtPrice.Text = "";
        txtGST.Text = "";
        cboxGST.Checked = false;

        //Added by khalid March 17-2012
        txtDepartment.Text = String.Empty;
        txtDesignation.Text = String.Empty;
       // txtCompany.Text = String.Empty;
        //txtPaymentTerms.Text="";
        //txtWarrantyTerms.Text="";
        //txtWarrantyException.Text="";
        //txtDeliveryInstallation.Text="";
        //txtValidity.Text="";
        //txtTexExemption.Text = "";
        string str = textAreaSpecialNotes.Value;


    }
    protected void GridQuotItems_RowCommand(object sender, GridViewCommandEventArgs e)
    {
       
    }
    protected void GridQuotItems_RowEditing(object sender, GridViewEditEventArgs e)
    {
        lblmessage.Text = "";
        int rid = e.NewEditIndex;
        ViewState["RID"] = rid;
        dt_item = (DataTable)ViewState["DataTable"];
        SetRecordValues(dt_item, rid);
    }
    protected void GridQuotItems_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {
        try
        {
            lblmessage.Text = "";
            int rid = e.RowIndex;
            dt_item = (DataTable)ViewState["DataTable"];
            if (ViewState["Deletequo_id"] != null)
            {
                ViewState["Deletequo_id"] = ViewState["Deletequo_id"].ToString() +"*"+ dt_item.Rows[e.RowIndex]["qitem_id"].ToString();
            }
            else
            {
                ViewState["Deletequo_id"] = dt_item.Rows[e.RowIndex]["QuotationId"].ToString() + "~" + dt_item.Rows[e.RowIndex]["qitem_id"].ToString();
            }
           
            dt_item.Rows[e.RowIndex].Delete();
            dt_item.AcceptChanges();
            ViewState["DataTable"] = dt_item;
            string str = ViewState["Deletequo_id"].ToString();
            BindGrid(dt_item);

            //lblmessage.Text = "Successfuly Deleted Record";
            //lblmessage.ForeColor = System.Drawing.Color.Green;
        }
        catch (Exception ex)
        {

        }
    }
    protected void GridQuotations_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        int quotid = int.Parse(e.CommandArgument.ToString());
        if (e.CommandName == "View")
        {
            Response.Redirect("FrmQuotationsViewer.aspx?QuotID=" + quotid);
            //Response.Redirect("ReportQuotation.aspx?QuotID=" + quotid);
        }
        if (e.CommandName == "Edit")
        {
            ViewState["Deletequo_id"] = null;
            btnClear_Click(null, null);
            DataTable DTQuotDetails = objQuot.fnGetQuotData(quotid).Tables[0];
            
            try
            {
            txtQuotationSubject.Text = DTQuotDetails.Rows[0]["subject"].ToString();
            
                if (String.IsNullOrEmpty(DTQuotDetails.Rows[0]["client_id"].ToString()))
                {
                    ddlClient.SelectedValue = "0";
                }
                else
                ddlClient.SelectedValue = DTQuotDetails.Rows[0]["client_id"].ToString();
            }
            catch (Exception ex)
            {}
            try
            { 
                if (String.IsNullOrEmpty(DTQuotDetails.Rows[0]["mangId"].ToString()))
                {
                    ddlSaleManager.SelectedValue = "0";
                }
                else
                ddlSaleManager.SelectedValue = DTQuotDetails.Rows[0]["mangId"].ToString();
            }
            catch (Exception ex)
            { }
            try
            {
                if (String.IsNullOrEmpty(DTQuotDetails.Rows[0]["tecPerId"].ToString()))
                {
                    ddlTechPerson.SelectedValue = "0";
                }
                ddlTechPerson.SelectedValue = DTQuotDetails.Rows[0]["tecPerId"].ToString();
            }
            catch (Exception ex)
            { }

            try
            {
                ddlCompany.SelectedValue = DTQuotDetails.Rows[0]["comp_id"].ToString();
                GetClients(Convert.ToInt32(DTQuotDetails.Rows[0]["comp_id"]));
                ddlClient.SelectedValue = DTQuotDetails.Rows[0]["client_id"].ToString();
                txtDesignation.Text = DTQuotDetails.Rows[0]["client_designation"].ToString();
                txtDepartment.Text = DTQuotDetails.Rows[0]["client_dept"].ToString();
                txtCustomerSite.Text = DTQuotDetails.Rows[0]["customer_site"].ToString();
            
            CreateTable();
            CreateTableTerm();
            DataTable DTQuotationLines = (DataTable)ViewState["DataTable"];
            for (int i = 0; i < DTQuotDetails.Rows.Count; i++)
            {

                //dt_item = new DataTable("Add_items");
                //dt_item.Columns.Add("itemid", typeof(int));
                //dt_item.Columns.Add("itemname", typeof(string));
                //dt_item.Columns.Add("description", typeof(string));
                //dt_item.Columns.Add("quantity", typeof(int));
                //dt_item.Columns.Add("unit", typeof(string));
                //dt_item.Columns.Add("price", typeof(double));
                //dt_item.Columns.Add("totalprice", typeof(double));
                //dt_item.Columns.Add("gstPercent", typeof(double));
                //dt_item.Columns.Add("gst", typeof(double));
                //dt_item.Columns.Add("qitem_id", typeof(int));
                //dt_item.Columns.Add("FromDB", typeof(string));
                //dt_item.Columns.Add("QuotationId", typeof(string));
                //dt_item.Columns.Add("ItemCat", typeof(string));
                //dt_item.Columns.Add("PriceType", typeof(string));

                DTQuotationLines.Rows.Add(
                                          DTQuotDetails.Rows[i]["item_id"].ToString(),
                                          DTQuotDetails.Rows[i]["item_name"].ToString(),
                                          DTQuotDetails.Rows[i]["description"].ToString(),
                                          DTQuotDetails.Rows[i]["item_quantity"].ToString(),
                                          DTQuotDetails.Rows[i]["Iunit"].ToString(),
                                          DTQuotDetails.Rows[i]["item_price"].ToString(),
                                          DTQuotDetails.Rows[i]["totalprice"].ToString(),
                                          DTQuotDetails.Rows[i]["gstPercent"].ToString(),
                                          DTQuotDetails.Rows[i]["gst"].ToString(),
                                          DTQuotDetails.Rows[i]["qitem_id"].ToString(),
                                          "1",
                                          quotid.ToString(),
                                          DTQuotDetails.Rows[i]["cat_id"].ToString(),
                                          DTQuotDetails.Rows[i]["Price_type"].ToString()

                                          );
                //dt_item.Columns.Add("ItemCat", typeof(string));
                //dt_item.Columns.Add("PriceType", typeof(string));

            }

            ViewState["DataTable"] = DTQuotationLines;
            BindGrid((DataTable)ViewState["DataTable"]);
            }
            catch (Exception ex) { }

            DataTable DTQuotationTerms = (DataTable)ViewState["DataTable1"];
            DataTable DTQuotTerms = objQuot.fnGetQuotationsTerms(quotid);

            try
            {
                for (int i = 0; i < DTQuotTerms.Rows.Count; i++)
                {

                    DTQuotationTerms.Rows.Add(
                                          DTQuotTerms.Rows[i]["ID"].ToString(),
                                          Convert.ToInt16(DTQuotTerms.Rows[i]["TermTypeID"]),
                                          DTQuotTerms.Rows[i]["TermType"].ToString(),
                                         Convert.ToInt16(DTQuotTerms.Rows[i]["TermNameID"]),
                                          DTQuotTerms.Rows[i]["TermName"].ToString(),
                                          DTQuotTerms.Rows[i]["TermDiscription"].ToString(),
                                          "1",
                                          Convert.ToInt16(DTQuotTerms.Rows[i]["Quot_ID"])
                                          
                                          );
                }
                ViewState["DataTable1"] = DTQuotationTerms;
                BindGridGVTermsAndCondition((DataTable)ViewState["DataTable1"]);
            }
            catch (Exception ex) { }
            //terms and condition
            try
            {
                txtPaymentTerms.Text = DTQuotDetails.Rows[0]["PaymentTerms"].ToString();
                txtWarrantyTerms.Text = DTQuotDetails.Rows[0]["WarrantyTerms"].ToString();
                txtWarrantyException.Text = DTQuotDetails.Rows[0]["WarrantyException"].ToString();
                txtDeliveryInstallation.Text = DTQuotDetails.Rows[0]["DeliveryInstallation"].ToString();
                txtValidity.Text = DTQuotDetails.Rows[0]["Validity"].ToString();
                txtTexExemption.Text = DTQuotDetails.Rows[0]["TexExemption"].ToString();
            }

            catch (Exception ex) { }

            btnSave.Visible = false;
            btnUpdate1.Visible = true;


        }
    }
    protected DataTable GetQutioLineDataTable()
    {
        DataTable dt = new DataTable();

        dt.Columns.Add("");
        dt.Columns.Add("");
        dt.Columns.Add("");
        dt.Columns.Add("");

        return dt;
    
    }
    #endregion   
    protected void GridQuotations_RowEditing(object sender, GridViewEditEventArgs e)
    {

    }
    protected void ddlItemCat_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            GetItems(ddlItemCat.SelectedValue.ToString());
        }
        catch (Exception ex)
        {
            
           // throw;
        }
        
    }
    protected void ddlPriceType_SelectedIndexChanged(object sender, EventArgs e)
    {
        GetItemPriceInfoByPriceType();
    }
    protected void ddlItem_SelectedIndexChanged(object sender, EventArgs e)
    {
        GetItemPriceInfoByPriceType();
    }
    void GetItemPriceInfoByPriceType()
    {
        if (ddlItem.SelectedValue == "-- Select --" || ddlItem.SelectedValue == "" || ddlPriceType.SelectedValue == "" || ddlPriceType.SelectedValue == "0")
        {
            lblmessage.Text = "Please select correct item or price type!";
            lblmessage.ForeColor = System.Drawing.Color.Red;
            txtPrice.Text = "0";
            txtPrice.Enabled = false;
            return;
        }

        try
        {
            switch (ddlPriceType.SelectedValue.ToString())
            {
                case "Maximum":
                    txtPrice.Enabled = false;
                    txtPrice.Text = objQuot.GetPriceinfo("MaximumPrice", ddlItem.SelectedValue.ToString());
                    lblmessage.Text = "";
                    break;
                case "Minimum":
                    txtPrice.Enabled = false;
                    txtPrice.Text = objQuot.GetPriceinfo("MinimumPrice", ddlItem.SelectedValue.ToString());
                    lblmessage.Text = "";
                    break;
                case "Normal":
                    txtPrice.Enabled = false;
                    txtPrice.Text = objQuot.GetPriceinfo("NormalPrice", ddlItem.SelectedValue.ToString());
                    lblmessage.Text = "";
                    break;
                case "Special":
                    txtPrice.Enabled = true;
                    txtPrice.Text = "0";
                    lblmessage.Text = "";
                    break;


            }
        }
        catch (Exception ex)
        {
            //throw;
        }
    }
    protected void en_Click(object sender, EventArgs e)
    {
        //GetClients();
    }
    protected void btnRefreshItemCat_Click(object sender, EventArgs e)
    {
        GetItemsCategory();
    }
    protected void btnRefreah_Click(object sender, EventArgs e)
    {
        if(ddlItemCat.Text != "-- Select --")
        GetItems(ddlItemCat.SelectedValue.ToString());
    }
    protected void ddlCompany_SelectedIndexChanged(object sender, EventArgs e)
    {
        ddlClient.Items.Clear();
        GetClients(Convert.ToInt32(ddlCompany.SelectedValue));
    }
    protected void cboxGST_CheckedChanged(object sender, EventArgs e)
    {
        if (cboxGST.Checked)
        {
            txtGST.Enabled=true;
            txtGST.Text = "";

        }
        else {

            txtGST.Enabled = false;
            txtGST.Text = "";
        
        }
    }
    protected void ddlType_SelectedIndexChanged(object sender, EventArgs e)
    {
        GetTermNames(Convert.ToInt16(ddlType.SelectedValue));
    }
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
    public static Dictionary<string, object> LoadTermDiscription(string term_ID)
    {
        string query = "";
        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionstring2"].ToString()))
        {
            query = "select term_discription from tbl_Term_Discription where Term_ID = '" + term_ID + "'";
            SqlDataAdapter da = new SqlDataAdapter(query, cn);
            DataSet ds = new DataSet();
            da.Fill(ds, "TermDiscription");
            DataTable dt = new DataTable();
            dt = ds.Tables["TermDiscription"];
            return ToJson(dt);


        }



    }
    protected void btnAddTermsAndCondition_Click(object sender, EventArgs e)
    {
        try
        {
            dt_TermsAndCondition = (DataTable)ViewState["DataTable1"];

            DataRow[] dr1 = dt_TermsAndCondition.Select("TermNameID='" + ddlTermName.SelectedValue + "'");
            if (dr1.Count() > 0)
            {
                lblTermsAndDiscription.Text = "Terms And Condition Already Exist";
                lblTermsAndDiscription.ForeColor = System.Drawing.Color.Red;
                return;
            }
            DataRow dr = dt_TermsAndCondition.NewRow();
            dr["TermTypeID"] = ddlType.SelectedItem.Value;
            dr["TermType"] = ddlType.SelectedItem.Text;
            dr["TermNameID"] = ddlTermName.SelectedItem.Value;
            dr["TermName"] = ddlTermName.SelectedItem.Text;
            dr["TermDiscription"] = txtDiscription.Value;
            dr["FromDB"] = "0";
            dr["QuotationId"] = "0";
           dr["ID"] = "0";
            //dr["qTerm_id"] = "0";

            dt_TermsAndCondition.Rows.Add(dr);
            ViewState["DataTable1"] = dt_TermsAndCondition;
            BindGridGVTermsAndCondition(dt_TermsAndCondition);
        }
        catch (Exception ex) { }
    }
    protected void btnUpdateTermsAndCondition_Click(object sender, EventArgs e)
    {
        try
        {
         
            dt_TermsAndCondition = (DataTable)ViewState["DataTable1"];
            DataRow dr;
            dr = dt_TermsAndCondition.Rows[(int)ViewState["TID"]];

            dr["TermTypeID"] = ddlType.SelectedItem.Value;
            dr["TermType"] = ddlType.SelectedItem.Text;
            dr["TermNameID"] = ddlTermName.SelectedItem.Value;
            dr["TermName"] = ddlTermName.SelectedItem.Text;
            dr["TermDiscription"] = txtDiscription.Value;
          
            dr.AcceptChanges();
            ViewState["DataTable1"] = dt_TermsAndCondition;
            BindGridGVTermsAndCondition(dt_TermsAndCondition);

            btnUpdateTermsAndCondition.Visible = false;
            btnAddTermsAndCondition.Visible = true;
            lblTermsAndDiscription.Text = "Term And Condition updated";
            lblTermsAndDiscription.ForeColor = System.Drawing.Color.Green;
        }
        catch (Exception)
        {

        }
    }
    protected void GVTermsAndCondition_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {
        try
        {
            lblmessage.Text = "";
            int rid = e.RowIndex;
            dt_TermsAndCondition = (DataTable)ViewState["DataTable1"];
            if (ViewState["Deleteterm_id"] != null)
            {
                ViewState["Deleteterm_id"] = ViewState["Deleteterm_id"].ToString() + "*" + dt_TermsAndCondition.Rows[e.RowIndex]["ID"].ToString();
            }
            else
            { 
                ViewState["Deleteterm_id"] = dt_TermsAndCondition.Rows[e.RowIndex]["QuotationId"].ToString() + "~" + dt_TermsAndCondition.Rows[e.RowIndex]["ID"].ToString();
            }


            dt_TermsAndCondition.Rows[e.RowIndex].Delete();
            dt_TermsAndCondition.AcceptChanges();
            ViewState["DataTable1"] = dt_TermsAndCondition;
            BindGridGVTermsAndCondition(dt_TermsAndCondition);

            lblTermsAndDiscription.Text = "Successfuly Deleted Record";
            lblTermsAndDiscription.ForeColor = System.Drawing.Color.Green;
            string strTerm = ViewState["Deleteterm_id"].ToString();
            
        }
        catch (Exception ex)
        {
            lblTermsAndDiscription.Text = "Record Not Deleted";
            lblTermsAndDiscription.ForeColor = System.Drawing.Color.Red;
        }
    }
    protected void GVTermsAndCondition_RowEditing(object sender, GridViewEditEventArgs e)
    {
        lblmessage.Text = "";
        int rid = e.NewEditIndex;
        ViewState["TID"] = rid;
        dt_TermsAndCondition = (DataTable)ViewState["DataTable1"];
        SetTermValues(dt_TermsAndCondition, rid);
    }
    protected void GVTermsAndCondition_RowCommand(object sender, GridViewCommandEventArgs e)
    {

    }
}

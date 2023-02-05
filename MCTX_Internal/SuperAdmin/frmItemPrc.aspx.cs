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

public partial class MCTX_Internal_SuperAdmin_frmItemPrc : System.Web.UI.Page
{
    #region Variables
    
    #endregion
    _ItemsPrice objItmPrc = new _ItemsPrice();
    #region Methods
    public void GetCategories()
    {
        objItmPrc.fnGetCategories();
        ddlCategories.DataSource = objItmPrc.DT_Categories;
        ddlCategories.DataValueField = "cat_id";
        ddlCategories.DataTextField = "cat_name";
        ddlCategories.DataBind();
        ddlCategories.Items.Insert(0, "-- Select --");
    }
    public void GetItems()
    {
        objItmPrc.fnGetItems();
        ddlItem.DataSource = objItmPrc.DT_Items;
        ddlItem.DataValueField = "item_id";
        ddlItem.DataTextField = "item_name";
        ddlItem.DataBind();
        ddlItem.Items.Insert(0, "-- Select --");
    }
    public void GetPriceData()
    {
        objItmPrc.fnGetItemPrices();
        ItemsPriceGrid.DataSource = objItmPrc.DT_ItemPrices;
        ItemsPriceGrid.DataBind();
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
        { 
            
        }
        try
        {
            if (!IsPostBack)
            {
                GetCategories();
                GetItems();
                GetPriceData();
            }
        }
        catch (Exception ex)
        { 
            
        }
    }
    protected void btnSaveUser_Click(object sender, EventArgs e)
    {
        string MaxPrice = txtMaxPrice.Text;
        string MinPrice = txtMinPrice.Text;
        string NormalPrc = txtNormalPrice.Text;
        string ShipRef = txtShipmentRef.Text;
        int Item_id = int.Parse(ddlItem.SelectedValue);
        int Cat_id = int.Parse(ddlCategories.SelectedValue);
        if (Item_id.ToString() != "" && MaxPrice != "" && NormalPrc != "" && MinPrice != "")
        {
            int result = objItmPrc.fnInsertItemPrice(Item_id, MaxPrice, NormalPrc, MinPrice);
            if (result == 1)
            {
                lblMessage.ForeColor = System.Drawing.Color.Green;
                lblMessage.Text = "*Record saved successfully";
            }
            else
            {
                lblMessage.ForeColor = System.Drawing.Color.Red;
                lblMessage.Text = "*Unable to save record";
            }
        }
        else
        {
            lblMessage.ForeColor = System.Drawing.Color.Red;
            lblMessage.Text = "Please Enter The Correct Values";
        }
    }
    protected void btnCancelUser_Click(object sender, EventArgs e)
    {
        ddlCategories.SelectedIndex = 0;
        ddlItem.SelectedIndex = 0;
        txtMaxPrice.Text = "";
        txtMinPrice.Text = "";
        txtNormalPrice.Text = "";
        txtShipmentRef.Text = "";
        ddlCategories.Focus();
    }
    #endregion
}

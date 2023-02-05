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
using System.Drawing;
using System.Drawing.Drawing2D;
using System.Drawing.Imaging;
using Sales_BOL;
public partial class MCTX_Internal_SuperAdmin_PopUp : System.Web.UI.Page
{
    #region Variables
    DataSet ds = new DataSet();
    _PopUp objPopup = new _PopUp();
    #endregion

    #region Events
    protected void Page_Load(object sender, EventArgs e)
    {
         if(!IsPostBack)
         {
             //Graphics g = new Graphics();
             //Pen p = new Pen(Color.Black,2);
             //g.DrawPie(p, 60, 160, 100, 100);
             //g.FillPie(, 60, 160, 100, 100, 0, 50);
             BindGrid();
             lblUserName.Text = Session["Username"].ToString();
             lblDate.Text = DateTime.Now.ToString();
             //lblTotCompTargets.Text = objPopup.fnGetDoneTargets();
             //lblBasicSalary.Text = objPopup.fnGetBasicPay();
             //lblSalary.Text = objPopup.fnGetTotPay();
         }
    }
    #endregion

    #region Methods
    public void BindGrid()
    {
        //ds = objPopup.fnGetGridData();
        // Bind Grid To GridView
        //PopUpGrid.DataSource = ds;
        //PopUpGrid.DataBind();
    }
    #endregion
    protected void btnClose_Click(object sender, EventArgs e)
    {
        
    }
}

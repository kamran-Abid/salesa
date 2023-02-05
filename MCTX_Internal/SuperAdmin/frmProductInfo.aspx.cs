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
using System.Text.RegularExpressions;
using Sales_BOL;
using System.IO;
using System.Drawing;
using System.Data.SqlClient;
using System.Runtime.Serialization.Json;
using System.Web.Script.Serialization;
using System.Collections.Generic;
using System.Web.Services;

public partial class MCTX_Internal_SuperAdmin_frmProductInfo : System.Web.UI.Page
{
    #region Variables
    _Products objPro = new _Products();
    #endregion

    #region Methods

    public void BindGridItems()
    {
        //DataTable dt = objPro.fnGetItems();
        //GridItemInfo.DataSource = dt;
        //GridItemInfo.DataBind();
    }
    // Function to test for Alphabets (Added By Awais)

    //public void GetCategories()
    //{
    //    objPro.fnGetCategories();
    //    ddlCategory.DataSource = objPro.DT_GetCats;

    //    ddlCategory.DataValueField = "cat_id";
    //    ddlCategory.DataTextField = "cat_name";
    //    ddlCategory.DataBind();
    //}
    public void GetOrigin()
    {
        objPro.fnGetOrigin();
        ddlOrigin.DataSource = objPro.DT_GetOrigin;
        ddlOrigin.DataValueField = "country_id";
        ddlOrigin.DataTextField = "country_name";
        ddlOrigin.DataBind();
    }

    public void GetEmployees()
    {
        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionstring2"].ToString()))
        {
            SqlCommand cmd = new SqlCommand("select id,e_name from tbl_employee where isnull(deleted,0)<>1 order by e_name", cn);
            cn.Open();
            DataTable dt = new DataTable();
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataSet ds = new DataSet();
            da.Fill(ds, "Get_Items");
            dt = ds.Tables["Get_Items"];
            ddlEmlpoyees_Officer.DataSource = dt;
            ddlEmlpoyees_Officer.DataTextField = "E_Name";
            ddlEmlpoyees_Officer.DataValueField = "id";
            ddlEmlpoyees_Officer.DataBind();
        }
    }

    public static byte[] ImageToByte(System.Drawing.Image img)
    {
        ImageConverter converter = new ImageConverter();
        return (byte[])converter.ConvertTo(img, typeof(byte[]));
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
            if (!IsPostBack)
            {

                //BindGridItems();
                GetOrigin();
                //GetCategories();
                GetEmployees();
            }
        }
        catch (Exception ex)
        {

        }
    }

    #endregion

    #region New Implemention by Obaid Altaf March 14, 2012

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
    public static Dictionary<string, object> GetProductInfo()
    {
        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionstring2"].ToString()))
        {
            //SqlCommand cmd = new SqlCommand("Web_Proc_GetEmpDailOutPutReport", cn);
            SqlCommand cmd = new SqlCommand();
            cmd.CommandText = "Web_Proc_GetProductCategory";
            cmd.CommandType = CommandType.StoredProcedure;
            //cmd.Parameters.Add("@UserID", userID);
            //cmd.Parameters.Add("@FromDate", DateTime.Parse(FromDate));
            //cmd.Parameters.Add("@TODATE", DateTime.Parse(ToDate));
            cmd.Connection = cn;
            //SqlCommand cmd = new SqlCommand("SELECT Act_Expense.Expense_Id, Act_Expense.Expense_By, Act_Expense.Expense_Amount,Act_Expense.Expense_Date,Act_ExpenseType.ExpenseType_Name, Act_Projects.Pro_Name,Act_Expense.Expense_Status, Act_Expense.Created_By, Act_Expense.Created_Date,Act_Expense.Modified_By, Act_Expense.Modified_Date from Act_Expense inner join Act_ExpenseType on Act_Expense.Expense_Type = Act_ExpenseType.ExpenseType_Id inner join Act_Projects on Act_Expense.Expense_Project = Act_Projects.Project_Id where Act_Expense.deleted=0 order by Expense_Id desc", cn);
            cn.Open();
            SqlDataAdapter DA = new SqlDataAdapter(cmd);
            DataSet ds = new DataSet();
            DA.Fill(ds, "ProductDetails");
            // string json = JsonConvert.SerializeObject(Picture);
            DataTable dt = new DataTable();
            dt = ds.Tables["ProductDetails"];
            return ToJson(dt);
        }
    }


    [WebMethod]
    public static void SaveMainProduct(string ProductID, string cat_name, string deleted, string flag)
    {
        string userName = HttpContext.Current.Session["UserFullName"].ToString();

        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionstring2"].ToString()))
        {
            try
            {
                if (userName != "")
                {
                    if (ProductID == "")
                    {
                        ProductID = "0";
                    }
                    SqlCommand cmd = new SqlCommand();
                    cmd.CommandText = "Web_Proc_InsertUpdateORDeleteProduct";
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.Add("@ProductID", int.Parse(ProductID));
                    cmd.Parameters.Add("@cat_name", cat_name);
                    cmd.Parameters.Add("@Created_By", userName);
                    cmd.Parameters.Add("@Created_Date", DateTime.Now);
                    cmd.Parameters.Add("@Modified_By", userName);
                    cmd.Parameters.Add("@Modified_Date", DateTime.Now);
                    cmd.Parameters.Add("@delete", deleted);
                    cmd.Parameters.Add("@FLAG", flag);
                    cmd.Connection = cn;
                    //SqlCommand cmd = new SqlCommand("SELECT Act_Expense.Expense_Id, Act_Expense.Expense_By, Act_Expense.Expense_Amount,Act_Expense.Expense_Date,Act_ExpenseType.ExpenseType_Name, Act_Projects.Pro_Name,Act_Expense.Expense_Status, Act_Expense.Created_By, Act_Expense.Created_Date,Act_Expense.Modified_By, Act_Expense.Modified_Date from Act_Expense inner join Act_ExpenseType on Act_Expense.Expense_Type = Act_ExpenseType.ExpenseType_Id inner join Act_Projects on Act_Expense.Expense_Project = Act_Projects.Project_Id where Act_Expense.deleted=0 order by Expense_Id desc", cn);
                    cn.Open();
                    cmd.ExecuteNonQuery();
                }
            }
            catch (Exception ex)
            {

            }
        }
    }

    [WebMethod]
    public static void SaveProduct(string item_id, string cat_id, string item_name, string modelno, string description, string Warrenty, string Itemcode, string Origin, string BrandName, string Mctx_Item_Code, string Warranty_With_Parts, string Technical_Officer, string Item_Leave_Time, string deleted, string flag)
    {
        string userName = HttpContext.Current.Session["UserFullName"].ToString();
        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionstring2"].ToString()))
        {
            if (item_id == "")
            {
                item_id = "0";
            }
            if (Warrenty == "")
            {
                Warrenty = "0";
            }
            SqlCommand cmd = new SqlCommand("Web_Proc_InsertUpdateORDeleteProduct_category", cn);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Add("@item_id", int.Parse(item_id));
            cmd.Parameters.Add("@cat_id", int.Parse(cat_id));
            cmd.Parameters.Add("@item_name", item_name);
            cmd.Parameters.Add("@modelno", modelno);
            cmd.Parameters.Add("@description", description);
            cmd.Parameters.Add("@Warrenty", Convert.ToInt32(Warrenty));
            cmd.Parameters.Add("@Itemcode", Itemcode);
            cmd.Parameters.Add("@Origin", Origin);

            cmd.Parameters.Add("@Brand_Name", BrandName);
            cmd.Parameters.Add("@Mctx_Code", Mctx_Item_Code);
            cmd.Parameters.Add("@Technical_Officer", Technical_Officer);
            cmd.Parameters.Add("@Warranty_With_Parts", Warranty_With_Parts);
            cmd.Parameters.Add("@Leave_Time", Item_Leave_Time);

            cmd.Parameters.Add("@delete", deleted);
            cmd.Parameters.Add("@image_url", "NoImage");
            cmd.Parameters.Add("@FLAG", flag);
            cmd.Connection = cn;
            cn.Open();
            cmd.ExecuteNonQuery();
        }
    }


    [WebMethod]
    public static Dictionary<string, object> LoadCategoryItems()
    {
        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionstring2"].ToString()))
        {
            SqlCommand cmd = new SqlCommand("Products_Get_Items", cn);
            cmd.CommandType = CommandType.StoredProcedure;
            cn.Open();
            DataTable dt = new DataTable();
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataSet ds = new DataSet();
            da.Fill(ds, "Get_Items");
            dt = ds.Tables["Get_Items"];
            return ToJson(dt);
        }
    }

    [WebMethod]
    public static Dictionary<string, object> Load_CategoriesDDL()
    {
        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionstring2"].ToString()))
        {
            SqlCommand cmd = new SqlCommand("select cat_id,cat_name from tbl_category where isnull(deleted,0)<>1", cn);
            cn.Open();
            DataTable dt = new DataTable();
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataSet ds = new DataSet();
            da.Fill(ds, "Categories");
            dt = ds.Tables["Categories"];
            return ToJson(dt);
        }
    }

    #endregion
}

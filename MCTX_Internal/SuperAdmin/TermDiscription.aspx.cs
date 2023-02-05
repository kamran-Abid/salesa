using Sales_BOL;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Sales_DAL;
using System.Data;
using System.Web.Services;
using System.Configuration;
using System.Data.SqlClient;

public partial class MCTX_Internal_SuperAdmin_TermDiscription : System.Web.UI.Page
{
    _UserTask objUTask = new _UserTask();
    string query = "";
    int result = 0;
    Dlayer objDA = new Dlayer();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {

            GetTermType();

        }
    }

    protected void btnTermsAndCondition_Click(object sender, EventArgs e)
    {
        if (txtID.Text == "0")
        {

            query = "insert into tbl_Term_Discription(typeID , Term_Name, term_discription , created_By , created_date ) values (" + ddlType.SelectedValue + ", '" + txtTermName.Text + "', '" + txtDiscription.Value + "', '" + Session["Username"] + "', GETDATE())";
            result = objDA.insertquery(query);
        }
        else
        {
            query = "update tbl_Term_Discription set TypeID= " + ddlType.SelectedValue + ", Term_Name='" + txtTermName.Text + "', Term_Discription='" + txtDiscription.Value + "' , modify_By='" + Session["Username"] + "' , modify_Date= getdate() where term_ID = "+txtID.Text+"";
            result = objDA.insertquery(query);

        }

        txtID.Text = "0";
        txtTermName.Text = "";
        txtDiscription.Value = "";
        ddlType.SelectedValue = "Select";
    }
    public void GetTermType()
    {
        ddlType.DataSource = objUTask.getTermType();
        ddlType.DataTextField = "TypeName";
        ddlType.DataValueField = "ID";
        ddlType.DataBind();
        ddlType.Items.Insert(0, "Select");
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
    public static Dictionary<string, object> LoadTermDiscription()
    {
        string query = "";
        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionstring2"].ToString()))
        {
            query = "select ted.Term_ID,  tec.id,typeName,ted.Term_Discription , ted.created_By,CONVERT(VARCHAR(10), ted.created_date, 101) created_date , ted.modify_By,CONVERT(VARCHAR(10), ted.modify_Date, 101) modify_Date  from tbl_termsAndCondition tec  inner join tbl_Term_Discription ted on ted.typeid = tec.ID";
            SqlDataAdapter da = new SqlDataAdapter(query, cn);
            DataSet ds = new DataSet();
            da.Fill(ds, "TermDiscription");
            DataTable dt = new DataTable();
            dt = ds.Tables["TermDiscription"];
            return ToJson(dt);


        }



    }

}
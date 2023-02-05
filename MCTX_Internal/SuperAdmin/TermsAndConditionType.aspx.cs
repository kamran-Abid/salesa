using Sales_DAL;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class MCTX_Internal_SuperAdmin_TermsAndConditionType : System.Web.UI.Page
{
    string query = "";
    int result = 0;
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    Dlayer objDA = new Dlayer();
    protected void btnTermsAndCondition_Click(object sender, EventArgs e)
    {
        if (txtID.Text == "0")
        {

            query = "insert into tbl_TermsAndCondition (TypeName,created_By,created_Date) values ('" + txtTypeName.Text + "' , '" + Session["Username"] + "' , getdate())";
            result = objDA.insertquery(query);
        }
        else {
            query = "update tbl_TermsAndCondition set typeName= '" + txtTypeName.Text + "' , modify_By = '" + Session["Username"] + "', modify_Date = GETDATE() where ID='"+txtID.Text+"'";
            result = objDA.insertquery(query);
        
        }
        txtTypeName.Text = "";
        txtID.Text = "0";

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
    public static Dictionary<string, object> LoadType()
    {
        string query = "";
        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionstring2"].ToString()))
        {
            query = "select id,typeName, created_By,CONVERT(VARCHAR(10), created_date, 101) created_date , modify_By,CONVERT(VARCHAR(10), modify_Date, 101) modify_Date from tbl_termsAndCondition";
            SqlDataAdapter da = new SqlDataAdapter(query, cn);
            DataSet ds = new DataSet();
            da.Fill(ds, "TypeDetail");
            DataTable dt = new DataTable();
            dt = ds.Tables["TypeDetail"];
            return ToJson(dt);


        }

        
        
    }


}
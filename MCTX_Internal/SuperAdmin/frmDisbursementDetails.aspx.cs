using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Services;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Runtime.Serialization.Json;
using System.Web.Script.Serialization;

public partial class MCTX_Internal_SuperAdmin_frmDispersementDetails : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

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
    public static Dictionary<string, object> DispData()
    {
        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionstring2"].ToString()))
        {
            SqlCommand cmd = new SqlCommand("SELECT top 100 Act_Dispersment.Dispersment_Id, Act_ApprovingAuth.ApproveAuth_name, Act_Dispersment.Dispersed_To, Act_Dispersment.Dispersed_Method,Act_Dispersment.Check_No, Act_Dispersment.Dispersed_Amount,Act_Dispersment.Created_By, Act_Dispersment.Created_Date, Act_Dispersment.Modified_By, Act_Dispersment.Modified_Date from Act_Dispersment inner join Act_ApprovingAuth on Act_Dispersment.DisPersed_By=Act_ApprovingAuth.ApproveAuth_Id where Deleted = '" + false + "' order by Act_Dispersment.Dispersment_Id desc", cn);
            cn.Open();
            SqlDataAdapter DA = new SqlDataAdapter(cmd);
            DataSet ds = new DataSet();
            DataTable dt = new DataTable();
            DA.Fill(ds, "DisData");
            dt = ds.Tables["DisData"];
            return ToJson(dt);
        }

    }

    [WebMethod]
    public static void DeleteDispData(string Disp_Id)
    {
        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionstring2"].ToString()))
        {
            string moddate = DateTime.Now.ToShortDateString();
            SqlCommand cmd = new SqlCommand("UPDATE Act_Dispersment SET Deleted ='" + true + "', Modified_Date = '" + moddate + "' where Dispersment_Id = " + int.Parse(Disp_Id) + "", cn);
            cn.Open();
            cmd.ExecuteNonQuery();
        }
    }

    [WebMethod]
    public static Dictionary<string, object> DispSearchData(string Disp_Date, string Disp_By, string Disp_To, string Disp_Method)
    {
        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionstring2"].ToString()))
        {
            string cmd = "SELECT top 100 Act_Dispersment.Dispersment_Id, Act_ApprovingAuth.ApproveAuth_name, Act_Dispersment.Dispersed_To, Act_Dispersment.Dispersed_Method,Act_Dispersment.Check_No, Act_Dispersment.Dispersed_Amount,Act_Dispersment.Created_By, Act_Dispersment.Created_Date, Act_Dispersment.Modified_By, Act_Dispersment.Modified_Date from Act_Dispersment inner join Act_ApprovingAuth on Act_Dispersment.DisPersed_By=Act_ApprovingAuth.ApproveAuth_Id where Deleted = '" + false + "'";
            if (Disp_Date != "")
            {
                cmd += " and CONVERT(Varchar(20),Created_Date,101) like '" + Disp_Date + "'";
            }
            if (Disp_By != "")
            {
                cmd += " and Act_ApprovingAuth.ApproveAuth_name like '" + Disp_By + "%'";
            }
            if (Disp_To != "")
            {
                cmd += " and Dispersed_To like '" + Disp_To + "%'";
            }
            if (Disp_Method != "")
            {
                cmd += " and Dispersed_Method like '" + Disp_Method + "%'";
            }
            cmd += " order by Dispersment_Id desc";
            SqlCommand cmd1 = new SqlCommand(cmd, cn);
            cn.Open();
            SqlDataAdapter DA = new SqlDataAdapter(cmd1);
            DataSet ds = new DataSet();
            DA.Fill(ds, "DisData");
            DataTable dt = new DataTable();
            dt = ds.Tables["DisData"];
            return ToJson(dt);
        }
    }



    protected void btn_Back_Click(object sender, EventArgs e)
    {
        Response.Redirect("ReceiptsAndExpense.aspx");
    }
}

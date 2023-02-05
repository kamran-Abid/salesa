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

public partial class MCTX_Internal_SuperAdmin_FrmReceivableDetails : System.Web.UI.Page
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
    public static Dictionary<string, object> ReceivableData()
    {

        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionstring2"].ToString()))
        {
            SqlCommand cmd = new SqlCommand("SELECT top 100 ACT_Recievables.invoice_id, Act_Projects.Pro_Name, ACT_Recievables.Invoice_Amount, ACT_Recievables.Invoice_Date, ACT_Recievables.Payment_Due_On, ACT_Recievables.Invoice_No, ACT_Recievables.PO_No, ACT_Recievables.PO_Date, ACT_Recievables.Created_Date, ACT_Recievables.Created_By, ACT_Recievables.Modified_Date, isnull(ACT_Recievables.Modified_By, '') as Modified_By from ACT_Recievables inner join Act_Projects on ACT_Recievables.invoice_to=Act_Projects.Project_Id where isnull(ACT_Recievables.Deleted,0)<>1 order by Invoice_No desc", cn);
            cn.Open();
            SqlDataAdapter DA = new SqlDataAdapter(cmd);
            DataSet ds = new DataSet();
            DA.Fill(ds, "ReceivableDetails");
            DataTable dt = new DataTable();
            dt = ds.Tables["ReceivableDetails"];
            return ToJson(dt);
        }
    }
    [WebMethod]
    public static Dictionary<string, object> SearchReceivablesData(string InvID, string InvNo, string InvTo, string InvDate, string PONum, string PODate)
    {
        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionstring2"].ToString()))
        {
            string cmd = "SELECT top 100 ACT_Recievables.invoice_id, Act_Projects.Pro_Name, ACT_Recievables.Invoice_Amount, ACT_Recievables.Invoice_Date, ACT_Recievables.Payment_Due_On, ACT_Recievables.Invoice_No, ACT_Recievables.PO_No, ACT_Recievables.PO_Date, ACT_Recievables.Created_Date, ACT_Recievables.Created_By, ACT_Recievables.Modified_Date, isnull(ACT_Recievables.Modified_By, '') as Modified_By from ACT_Recievables inner join Act_Projects on ACT_Recievables.invoice_to=Act_Projects.Project_Id where ACT_Recievables.Deleted='" + false + "'";
            if (InvID != "")
            {
                cmd += " and invoice_id like '" + InvID.Trim() + "%'";
            }
            if (InvNo != "")
            {
                cmd += " and Invoice_No like '" + InvNo.Trim() + "%'";
            }
            if (InvTo != "")
            {
                cmd += " and Pro_Name like '" + InvTo.Trim() + "%'";
            }
            if (InvDate != "")
            {
                cmd += " and Invoice_Date = '" + InvDate.Trim() + "'";
            }
            if (PONum != "")
            {
                cmd += " and PO_No like '" + PONum.Trim() + "%'";
            }
            if (PODate != "")
            {
                cmd += " and PO_Date = '" + PODate.Trim() + "'";
            }
            cmd += " order by Invoice_No desc";
            SqlCommand query = new SqlCommand(cmd, cn);
            cn.Open();
            SqlDataAdapter DA = new SqlDataAdapter(query);
            DataSet ds = new DataSet();
            DA.Fill(ds, "ReceivableDetails");
            DataTable dt = new DataTable();
            dt = ds.Tables["ReceivableDetails"];
            return ToJson(dt);
        }
    }
    [WebMethod]
    public static void DeleteRecpData(string Inv_Id)
    {
        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionstring2"].ToString()))
        {
            string moddate = DateTime.Now.ToShortDateString();
            string modby = HttpContext.Current.Session["UserName"].ToString();
            SqlCommand cmd = new SqlCommand("UPDATE ACT_Recievables SET Deleted ='" + true + "', Modified_Date = '" + moddate + "', Modified_By = '" + modby + "' where invoice_id = " + int.Parse(Inv_Id) + "", cn);
            cn.Open();
            cmd.ExecuteNonQuery();
        }
    }

}

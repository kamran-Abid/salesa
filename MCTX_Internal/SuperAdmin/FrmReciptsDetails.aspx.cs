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

public partial class MCTX_Internal_FrmReciptsDetails : System.Web.UI.Page
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
    public static Dictionary<string, object> RecpData()
    {
        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionstring2"].ToString()))
        {
            SqlCommand cmd = new SqlCommand("SELECT top 100 Act_Reciepts.Recp_Id,Convert(varchar(10), Act_Reciepts.Rep_Date, 101) as Rep_Date, Act_Reciepts.Rcp_Amount, Act_Reciepts.Rcp_Recievedby, Act_ApprovingAuth.ApproveAuth_name, Act_Reciepts.Rcp_PaymentMode, Act_Projects.Pro_Name, Act_Reciepts.Created_By, Act_Reciepts.Created_Date, Act_Reciepts.Modified_By, Act_Reciepts.Modified_Date from Act_Reciepts inner join Act_ApprovingAuth on Act_Reciepts.Rcp_Receivedfrom = Act_ApprovingAuth.ApproveAuth_Id inner join Act_Projects on Act_Reciepts.Rcp_ForProject = Act_Projects.Project_Id where Act_Reciepts.deleted = '" + false + "' order by Recp_Id desc", cn);
            cn.Open();
            SqlDataAdapter DA = new SqlDataAdapter(cmd);
            DataSet ds = new DataSet();
            DA.Fill(ds, "RecDetails");
            DataTable dt = new DataTable();
            dt = ds.Tables["RecDetails"];
            return ToJson(dt);
        }
    }
    [WebMethod]
    public static Dictionary<string, object> SearchRecpData(string Recp_Id, string Rep_Date, string Rcp_ForProject, string Rcp_Receivedfrom, string Rcp_Recievedby, string Rcp_PaymentMode)
    {
        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionstring2"].ToString()))
        {
            string cmd = "SELECT top 100 Act_Reciepts.Recp_Id,Convert(varchar(10), Act_Reciepts.Rep_Date, 101) as Rep_Date, Act_Reciepts.Rcp_Amount, Act_Reciepts.Rcp_Recievedby, Act_ApprovingAuth.ApproveAuth_name, Act_Reciepts.Rcp_PaymentMode, Act_Projects.Pro_Name, Act_Reciepts.Created_By, Act_Reciepts.Created_Date, Act_Reciepts.Modified_By, Act_Reciepts.Modified_Date from Act_Reciepts inner join Act_ApprovingAuth on Act_Reciepts.Rcp_Receivedfrom = Act_ApprovingAuth.ApproveAuth_Id inner join Act_Projects on Act_Reciepts.Rcp_ForProject = Act_Projects.Project_Id where Act_Reciepts.deleted = '" + false + "'";
            if (Recp_Id != "")
            {
                cmd += " and Recp_Id like " + Recp_Id + "";
            }
            if (Rep_Date != "")
            {
                cmd += " and Rep_Date like convert(datetime,'" + Rep_Date + "')";
            }
            if (Rcp_ForProject != "")
            {
                cmd += " and Act_Projects.Pro_Name like '" + Rcp_ForProject + "%'";
            }
            if (Rcp_Receivedfrom != "")
            {
                cmd += " and Act_ApprovingAuth.ApproveAuth_name like '" + Rcp_Receivedfrom + "%'";
            }
            if (Rcp_Recievedby != "")
            {
                cmd += " and Rcp_Recievedby like '" + Rcp_Recievedby + "%'";
            }
            if (Rcp_PaymentMode != "")
            {
                cmd += " and Rcp_PaymentMode like '" + Rcp_PaymentMode + "%'";
            }
                cmd += " order by Recp_Id desc";
            SqlCommand cmd1 = new SqlCommand(cmd, cn);
            cn.Open();
            SqlDataAdapter DA = new SqlDataAdapter(cmd1);
            DataSet ds = new DataSet();
            DA.Fill(ds, "RecDetails");
            DataTable dt = new DataTable();
            dt = ds.Tables["RecDetails"];
            return ToJson(dt);
        }
    }

    [WebMethod]
    public static void DeleteRecpData(string Recp_Id)
    {
        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionstring2"].ToString()))
        {
            string moddate = DateTime.Now.ToShortDateString();
            SqlCommand cmd = new SqlCommand("UPDATE Act_Reciepts SET deleted ='" + true + "', Modified_Date = '" + moddate + "' where Recp_Id = " + int.Parse(Recp_Id) + "", cn);
            cn.Open();
            cmd.ExecuteNonQuery();
        }
    }
}

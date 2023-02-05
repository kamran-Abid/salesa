using System;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Data.SqlClient;
using System.Collections.Generic;
using System.Web.Services;
using System.Web.Mail;



public partial class MCTX_Internal_SuperAdmin_frmDailyOutputReport : System.Web.UI.Page
{
    static string RepID = "";
    static string RPTID = "";
    static string EmployeeName = "";
    static string DailyRPTID = "";
    static string CheckIn = "";
    static string DPTID = "";
    protected void Page_Load(object sender, EventArgs e)
    
    {
        try
        {
            EmployeeName = Session["username"].ToString();

            if (EmployeeName == "")
            {
                Response.Redirect("../../MCTX_General/Login.aspx");
                return;
            }
        }
        catch (Exception)
        {

            //throw;
        }
        #region Methods
        if (Request.Cookies["userName"] == null)
        {
            Response.Redirect("../../MCTX_General/Login.aspx");
            return;
        }
        else
        {
            if (!IsPostBack)
            {
                LoadProj();
               // lblCurrentTime.Text = DateTime.Now.Hour + ":" + DateTime.Now.Minute;
            }
            GetUserReport();
        }
        #endregion
        try
        {
            //lblReportID.Text = DailyRPTID;
            //lblTimeIn.Text = CheckIn;
        }
        catch (Exception)
        {

            //throw;
        }
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

    #region ReportHrs

    #region SaveFirstHr
    [WebMethod]
    public static string SaveRPTData(string EmpName, string TimeIn, string FrmTime1, string ToTime1, string RPTTime1, string Proj1, string Task1, string Hr1, string DailyReport_ID)
    {

        String[] ArrayRptTime = RPTTime1.Split(':');
        // Added by Khalid to restrict to add previous hours report
        if (DateTime.Now.Hour > (Convert.ToInt32(ArrayRptTime[0]) + 1))
        {
            return "expired";
        }

        if (DateTime.Now.Hour == (Convert.ToInt32(ArrayRptTime[0]) + 1))
        {
            if (DateTime.Now.Minute > Convert.ToInt32(ArrayRptTime[1]))
            {
                return "expired";
            }
        }

        if (DailyReport_ID == "0" || DailyReport_ID == "")
        {
            DailyReport_ID = CreateReportReport(EmpName, TimeIn);
        }
        //Response.Write("<script>alert('Hello');</script>");
        if (DailyReport_ID == "0" || DailyReport_ID == "")
        {
            DailyReport_ID = CreateReportReport(EmpName, TimeIn);
        }
        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionstring2"].ToString()))
        {
            cn.Open();
            string CHCK = "SELECT * from ReportDetails where DailyReport_ID = '" + DailyReport_ID + "' and hourNo = '" + Hr1 + "'";
            SqlDataAdapter da = new SqlDataAdapter(CHCK, cn);
            DataTable dt = new DataTable();
            da.Fill(dt);
            if (dt.Rows.Count == 0)
            {
                SqlCommand RPT = new SqlCommand();
                RPT.CommandText = "Web_Proc_AddReportDetails";
                RPT.CommandType = CommandType.StoredProcedure;
                RPT.Parameters.Add("@TaskDetail", Task1);
                RPT.Parameters.Add("@DailyRPTID", DailyReport_ID);
                RPT.Parameters.Add("@FrmTime", FrmTime1);
                RPT.Parameters.Add("@ToTime", ToTime1);
                RPT.Parameters.Add("@RptTime", RPTTime1);
                RPT.Parameters.Add("@ProjID", Convert.ToInt32((String.IsNullOrEmpty(Proj1) == true ? "0" : Proj1)));
                RPT.Parameters.Add("@HrNo", Hr1);
                RPT.Connection = cn;
                RPT.ExecuteNonQuery();
            }
            else
            {
                SqlCommand RPT = new SqlCommand();
                RPT.CommandText = "Web_Proc_UpdateReportDetails";
                RPT.CommandType = CommandType.StoredProcedure;
                RPT.Parameters.Add("@DailyRPTID", DailyReport_ID);
                RPT.Parameters.Add("@HrNo", Hr1);
                RPT.Parameters.Add("@TaskDetail", Task1);
                RPT.Parameters.Add("@FrmTime", FrmTime1);
                RPT.Parameters.Add("@ToTime", ToTime1);
                RPT.Parameters.Add("@RptTime", RPTTime1);
                RPT.Parameters.Add("@ProjID", Convert.ToInt32((String.IsNullOrEmpty(Proj1) == true ? "0" : Proj1)));
                RPT.Connection = cn;
                RPT.ExecuteNonQuery();
            }
        }

        return DailyReport_ID;

        //string REPTID = "";
        //String[] ArrayRptTime = RPTTime1.Split(':');
        //// Added by Khalid to restrict to add previous hours report
        //if (DateTime.Now.Hour > (Convert.ToInt32(ArrayRptTime[0]) + 1))
        //{
        //    return "expired";
        //}

        //if (DateTime.Now.Hour == (Convert.ToInt32(ArrayRptTime[0]) + 1))
        //{
        //    if (DateTime.Now.Minute > Convert.ToInt32(ArrayRptTime[1]))
        //    {
        //        return "expired";
        //    }
        //}

        //if (DailyReport_ID == "0" || DailyReport_ID == "")
        //{
        //    DailyReport_ID = CreateReportReport(EmpName, TimeIn);
        //}
        //using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionstring2"].ToString()))
        //{

        //    string usr = "SELECT user1.user_id,tbl_employee.EmpType_ID from user1 inner join tbl_employee " +
        //                 "on user1.E_badge=tbl_employee.E_badge where tbl_employee.E_Name = '" + EmpName + "'";
        //    cn.Open();
        //    SqlDataAdapter SDA = new SqlDataAdapter(usr, cn);
        //    DataTable SDT = new DataTable();
        //    SDA.Fill(SDT);
        //    string userid = SDT.Rows[0]["user_id"].ToString();
        //    int EmpType_ID = int.Parse(SDT.Rows[0]["EmpType_ID"].ToString());
        //    string Check = "SELECT * from DailyReport where user_id = '" + userid + "' and CONVERT(varchar(20),CurrentDate, 101)=CONVERT(varchar(20),getdate(),101)";
        //    SqlDataAdapter DA = new SqlDataAdapter(Check, cn);
        //    DataTable DT = new DataTable();
        //    DA.Fill(DT);
        //    int result = 0;
        //    if (DT.Rows.Count == 0)
        //    {
        //        SqlCommand cmd = new SqlCommand();
        //        cmd.CommandText = "Web_Proc_SaveDailyReportFirstHr";
        //        cmd.CommandType = CommandType.StoredProcedure;
        //        cmd.Parameters.Add("@userid", userid);
        //        cmd.Parameters.Add("@TimeIn", TimeIn);
        //        cmd.Parameters.Add("@CurrentDate", DateTime.Now);
        //        cmd.Parameters.Add("@EmpTypeID", EmpType_ID);
        //        cmd.Connection = cn;
        //        result = cmd.ExecuteNonQuery();
        //    }
        //    else
        //    {
        //        int ReportID = 0;
        //        ReportID = int.Parse(DT.Rows[0]["DailyReport_ID"].ToString());
        //        SqlCommand cmd = new SqlCommand();
        //        cmd.CommandText = "Web_Proc_UpdateDailyReportFirstHr";
        //        cmd.CommandType = CommandType.StoredProcedure;
        //        cmd.Parameters.Add("@RPTID", ReportID);
        //        cmd.Parameters.Add("@TimeIn", TimeIn);
        //        cmd.Connection = cn;
        //        result = cmd.ExecuteNonQuery();
        //    }
        //    if (result > 0)
        //    {
        //        string str = "SELECT top 1 DailyReport_ID from DailyReport order by 1 desc";
        //        DataTable dt = new DataTable();
        //        SqlDataAdapter da = new SqlDataAdapter(str, cn);
        //        da.Fill(dt);
        //        int RPTID = 0;
        //        RPTID = int.Parse((dt.Rows[0]["DailyReport_ID"].ToString()));
        //        RepID = RPTID.ToString();
        //        string CHCK = "SELECT * from ReportDetails where DailyReport_ID = " + RPTID + " and hourNo = '" + Hr1 + "'";
        //        SqlDataAdapter DACHCK = new SqlDataAdapter(CHCK, cn);
        //        DataTable DTCHCK = new DataTable();
        //        DACHCK.Fill(DTCHCK);
        //        if (DTCHCK.Rows.Count == 0)
        //        {
        //            SqlCommand RPT = new SqlCommand();
        //            RPT.CommandText = "Web_Proc_AddReportDetails";
        //            RPT.CommandType = CommandType.StoredProcedure;
        //            RPT.Parameters.Add("@TaskDetail", Task1);
        //            RPT.Parameters.Add("@DailyRPTID", RPTID);
        //            RPT.Parameters.Add("@FrmTime", FrmTime1);
        //            RPT.Parameters.Add("@ToTime", ToTime1);
        //            RPT.Parameters.Add("@RptTime", RPTTime1);
        //            RPT.Parameters.Add("@ProjID", Convert.ToInt32((String.IsNullOrEmpty(Proj1) == true ? "0" : Proj1)));
        //            RPT.Parameters.Add("@HrNo", Hr1);
        //            RPT.Connection = cn;
        //            RPT.ExecuteNonQuery();
        //        }
        //        else
        //        {
        //            SqlCommand RPT = new SqlCommand();
        //            RPT.CommandText = "Web_Proc_UpdateReportDetails";
        //            RPT.CommandType = CommandType.StoredProcedure;
        //            RPT.Parameters.Add("@DailyRPTID", RPTID);
        //            RPT.Parameters.Add("@HrNo", Hr1);
        //            RPT.Parameters.Add("@TaskDetail", Task1);
        //            RPT.Parameters.Add("@FrmTime", FrmTime1);
        //            RPT.Parameters.Add("@ToTime", ToTime1);
        //            RPT.Parameters.Add("@RptTime", RPTTime1);
        //            RPT.Parameters.Add("@ProjID", Convert.ToInt32((String.IsNullOrEmpty(Proj1) == true ? "0" : Proj1)));
        //            RPT.Connection = cn;
        //            RPT.ExecuteNonQuery();
        //        }
        //    }
        //    REPTID = RepID.ToString();
        //}
        //return REPTID;
    }
    #endregion

  
    public static String CreateReportReport(string EmpName, string TimeIn)
    {
        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionstring2"].ToString()))
        {
            string usr = "SELECT user1.user_id,tbl_employee.EmpType_ID from user1 inner join tbl_employee " +
                         "on user1.E_badge=tbl_employee.E_badge where tbl_employee.E_Name = '" + EmpName + "'";
            cn.Open();
            SqlDataAdapter SDA = new SqlDataAdapter(usr, cn);
            DataTable SDT = new DataTable();
            SDA.Fill(SDT);
            string userid = SDT.Rows[0]["user_id"].ToString();
            int EmpType_ID = int.Parse(SDT.Rows[0]["EmpType_ID"].ToString());
            string Check = "SELECT * from DailyReport where user_id = '" + userid + "' and CONVERT(varchar(20),CurrentDate, 101)=CONVERT(varchar(20),getdate(),101)";
            SqlDataAdapter DA = new SqlDataAdapter(Check, cn);
            DataTable DT = new DataTable();
            DA.Fill(DT);
            int result = 0;
            if (DT.Rows.Count == 0)
            {
                SqlCommand cmd = new SqlCommand();
                cmd.CommandText = "Web_Proc_SaveDailyReportFirstHr";
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add("@userid", userid);
                cmd.Parameters.Add("@TimeIn", TimeIn);
                cmd.Parameters.Add("@CurrentDate", DateTime.Now);
                cmd.Parameters.Add("@EmpTypeID", EmpType_ID);
                cmd.Connection = cn;
                result = cmd.ExecuteNonQuery();
            }

            if (result > 0)
            {
                string str = "SELECT top 1 DailyReport_ID from DailyReport order by 1 desc";
                DataTable dt = new DataTable();
                SqlDataAdapter da = new SqlDataAdapter(str, cn);
                da.Fill(dt);
                int RPTID = 0;
                RPTID = int.Parse((dt.Rows[0]["DailyReport_ID"].ToString()));
                return RPTID.ToString();
            }

            return "0";
        }
    }

    #region SaveSecondHr
    [WebMethod]
    public static string SaveRPTData1(string EmpName, string TimeIn, string FrmTime2, string ToTime2, string RPTTime2, string Proj2, string Task2, string Hr2, string DailyReport_ID)
    {
        String[] ArrayRptTime = RPTTime2.Split(':');
        // Added by Khalid to restrict to add previous hours report
        if (DateTime.Now.Hour > (Convert.ToInt32(ArrayRptTime[0]) + 1))
        {
            return "expired";
        }

        if (DateTime.Now.Hour == (Convert.ToInt32(ArrayRptTime[0]) + 1))
        {
            if (DateTime.Now.Minute > Convert.ToInt32(ArrayRptTime[1]))
            {
                return "expired";
            }
        }

        if (DailyReport_ID == "0" || DailyReport_ID == "")
        {
            DailyReport_ID = CreateReportReport(EmpName, TimeIn);
        }
        //Response.Write("<script>alert('Hello');</script>");
        if (DailyReport_ID == "0" || DailyReport_ID == "")
        {
            DailyReport_ID = CreateReportReport(EmpName, TimeIn);
        }
        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionstring2"].ToString()))
        {
            cn.Open();
            string CHCK = "SELECT * from ReportDetails where DailyReport_ID = '" + DailyReport_ID + "' and hourNo = '" + Hr2 + "'";
            SqlDataAdapter da = new SqlDataAdapter(CHCK, cn);
            DataTable dt = new DataTable();
            da.Fill(dt);
            if (dt.Rows.Count == 0)
            {
                SqlCommand RPT = new SqlCommand();
                RPT.CommandText = "Web_Proc_AddReportDetails";
                RPT.CommandType = CommandType.StoredProcedure;
                RPT.Parameters.Add("@TaskDetail", Task2);
                RPT.Parameters.Add("@DailyRPTID", DailyReport_ID);
                RPT.Parameters.Add("@FrmTime", FrmTime2);
                RPT.Parameters.Add("@ToTime", ToTime2);
                RPT.Parameters.Add("@RptTime", RPTTime2);
                RPT.Parameters.Add("@ProjID", Convert.ToInt32((String.IsNullOrEmpty(Proj2) == true ? "0" : Proj2)));
                RPT.Parameters.Add("@HrNo", Hr2);
                RPT.Connection = cn;
                RPT.ExecuteNonQuery();
            }
            else
            {
                SqlCommand RPT = new SqlCommand();
                RPT.CommandText = "Web_Proc_UpdateReportDetails";
                RPT.CommandType = CommandType.StoredProcedure;
                RPT.Parameters.Add("@DailyRPTID", DailyReport_ID);
                RPT.Parameters.Add("@HrNo", Hr2);
                RPT.Parameters.Add("@TaskDetail", Task2);
                RPT.Parameters.Add("@FrmTime", FrmTime2);
                RPT.Parameters.Add("@ToTime", ToTime2);
                RPT.Parameters.Add("@RptTime", RPTTime2);
                RPT.Parameters.Add("@ProjID", Convert.ToInt32((String.IsNullOrEmpty(Proj2) == true ? "0" : Proj2)));
                RPT.Connection = cn;
                RPT.ExecuteNonQuery();
            }
        }

        return DailyReport_ID;
    }
    #endregion

    #region SaveThirdHr
    [WebMethod]
    public static string SaveRPTData2(string EmpName, string TimeIn, string FrmTime3, string ToTime3, string RPTTime3, string Proj3, string Task3, string Hr3, string DailyReport_ID)
    {
        String[] ArrayRptTime = RPTTime3.Split(':');
        // Added by Khalid to restrict to add previous hours report
        if (DateTime.Now.Hour > (Convert.ToInt32(ArrayRptTime[0]) + 1))
        {
            return "expired";
        }

        if (DateTime.Now.Hour == (Convert.ToInt32(ArrayRptTime[0]) + 1))
        {
            if (DateTime.Now.Minute > Convert.ToInt32(ArrayRptTime[1]))
            {
                return "expired";
            }
        }

        if (DailyReport_ID == "0" || DailyReport_ID == "")
        {
            DailyReport_ID = CreateReportReport(EmpName, TimeIn);
        }
        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionstring2"].ToString()))
        {
            cn.Open();
            string CHCK = "SELECT * from ReportDetails where DailyReport_ID = '" + DailyReport_ID + "' and hourNo = '" + Hr3 + "'";
            SqlDataAdapter da = new SqlDataAdapter(CHCK, cn);
            DataTable dt = new DataTable();
            da.Fill(dt);
            if (dt.Rows.Count == 0)
            {
                SqlCommand RPT = new SqlCommand();
                RPT.CommandText = "Web_Proc_AddReportDetails";
                RPT.CommandType = CommandType.StoredProcedure;
                RPT.Parameters.Add("@TaskDetail", Task3);
                RPT.Parameters.Add("@DailyRPTID", DailyReport_ID);
                RPT.Parameters.Add("@FrmTime", FrmTime3);
                RPT.Parameters.Add("@ToTime", ToTime3);
                RPT.Parameters.Add("@RptTime", RPTTime3);
                RPT.Parameters.Add("@ProjID", Convert.ToInt32((String.IsNullOrEmpty(Proj3) == true ? "0" : Proj3)));
                RPT.Parameters.Add("@HrNo", Hr3);
                RPT.Connection = cn;
                RPT.ExecuteNonQuery();
            }
            else
            {
                SqlCommand RPT = new SqlCommand();
                RPT.CommandText = "Web_Proc_UpdateReportDetails";
                RPT.CommandType = CommandType.StoredProcedure;
                RPT.Parameters.Add("@DailyRPTID", DailyReport_ID);
                RPT.Parameters.Add("@HrNo", Hr3);
                RPT.Parameters.Add("@TaskDetail", Task3);
                RPT.Parameters.Add("@FrmTime", FrmTime3);
                RPT.Parameters.Add("@ToTime", ToTime3);
                RPT.Parameters.Add("@RptTime", RPTTime3);
                RPT.Parameters.Add("@ProjID", Convert.ToInt32((String.IsNullOrEmpty(Proj3) == true ? "0" : Proj3)));
                RPT.Connection = cn;
                RPT.ExecuteNonQuery();
            }
        }

        return DailyReport_ID;
    }
    #endregion

    #region SaveFourthHr
    [WebMethod]
    public static String SaveRPTData3(string EmpName, string TimeIn, string FrmTime4, string ToTime4, string RPTTime4, string Proj4, string Task4, string Hr4, string DailyReport_ID)
    {

        String[] ArrayRptTime = RPTTime4.Split(':');
        // Added by Khalid to restrict to add previous hours report
        if (DateTime.Now.Hour > (Convert.ToInt32(ArrayRptTime[0]) + 1))
        {
            return "expired";
        }

        if (DateTime.Now.Hour == (Convert.ToInt32(ArrayRptTime[0]) + 1))
        {
            if (DateTime.Now.Minute > Convert.ToInt32(ArrayRptTime[1]))
            {
                return "expired";
            }
        }

        if (DailyReport_ID == "0" || DailyReport_ID == "")
        {
            DailyReport_ID = CreateReportReport(EmpName, TimeIn);
        }

        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionstring2"].ToString()))
        {
            cn.Open();
            string CHCK = "SELECT * from ReportDetails where DailyReport_ID = '" + DailyReport_ID + "' and hourNo = '" + Hr4 + "'";
            SqlDataAdapter da = new SqlDataAdapter(CHCK, cn);
            DataTable dt = new DataTable();
            da.Fill(dt);
            if (dt.Rows.Count == 0)
            {
                SqlCommand RPT = new SqlCommand();
                RPT.CommandText = "Web_Proc_AddReportDetails";
                RPT.CommandType = CommandType.StoredProcedure;
                RPT.Parameters.Add("@TaskDetail", Task4);
                RPT.Parameters.Add("@DailyRPTID", DailyReport_ID);
                RPT.Parameters.Add("@FrmTime", FrmTime4);
                RPT.Parameters.Add("@ToTime", ToTime4);
                RPT.Parameters.Add("@RptTime", RPTTime4);
                RPT.Parameters.Add("@ProjID", Convert.ToInt32((String.IsNullOrEmpty(Proj4) == true ? "0" : Proj4)));
                RPT.Parameters.Add("@HrNo", Hr4);
                RPT.Connection = cn;
                RPT.ExecuteNonQuery();
            }
            else
            {
                SqlCommand RPT = new SqlCommand();
                RPT.CommandText = "Web_Proc_UpdateReportDetails";
                RPT.CommandType = CommandType.StoredProcedure;
                RPT.Parameters.Add("@DailyRPTID", DailyReport_ID);
                RPT.Parameters.Add("@HrNo", Hr4);
                RPT.Parameters.Add("@TaskDetail", Task4);
                RPT.Parameters.Add("@FrmTime", FrmTime4);
                RPT.Parameters.Add("@ToTime", ToTime4);
                RPT.Parameters.Add("@RptTime", RPTTime4);
                RPT.Parameters.Add("@ProjID", Convert.ToInt32((String.IsNullOrEmpty(Proj4) == true ? "0" : Proj4)));
                RPT.Connection = cn;
                RPT.ExecuteNonQuery();
            }
        }

        return DailyReport_ID;
    }
    #endregion

    #region SaveFifthHr
    [WebMethod]
    public static string SaveRPTData4(string EmpName, string TimeIn, string FrmTime5, string ToTime5, string RPTTime5, string Proj5, string Task5, string Hr5, string DailyReport_ID)
    {
        String[] ArrayRptTime =  RPTTime5.Split(':');
        // Added by Khalid to restrict to add previous hours report
        if (DateTime.Now.Hour > (Convert.ToInt32(ArrayRptTime[0]) + 1))
        {
            return "expired";
        }

        if (DateTime.Now.Hour == (Convert.ToInt32(ArrayRptTime[0]) + 1))
        {
            if (DateTime.Now.Minute > Convert.ToInt32(ArrayRptTime[1]))
            {
                return "expired";
            }
        }

        if (DailyReport_ID == "0" || DailyReport_ID == "")
        {
            DailyReport_ID = CreateReportReport(EmpName, TimeIn);
        }
        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionstring2"].ToString()))
        {
            cn.Open();
            string CHCK = "SELECT * from ReportDetails where DailyReport_ID = '" + DailyReport_ID + "' and hourNo = '" + Hr5 + "'";
            SqlDataAdapter da = new SqlDataAdapter(CHCK, cn);
            DataTable dt = new DataTable();
            da.Fill(dt);
            if (dt.Rows.Count == 0)
            {
                SqlCommand RPT = new SqlCommand();
                RPT.CommandText = "Web_Proc_AddReportDetails";
                RPT.CommandType = CommandType.StoredProcedure;
                RPT.Parameters.Add("@TaskDetail", Task5);
                RPT.Parameters.Add("@DailyRPTID", DailyReport_ID);
                RPT.Parameters.Add("@FrmTime", FrmTime5);
                RPT.Parameters.Add("@ToTime", ToTime5);
                RPT.Parameters.Add("@RptTime", RPTTime5);
                RPT.Parameters.Add("@ProjID", Convert.ToInt32((String.IsNullOrEmpty(Proj5) == true ? "0" : Proj5)));
                RPT.Parameters.Add("@HrNo", Hr5);
                RPT.Connection = cn;
                RPT.ExecuteNonQuery();
            }
            else
            {
                SqlCommand RPT = new SqlCommand();
                RPT.CommandText = "Web_Proc_UpdateReportDetails";
                RPT.CommandType = CommandType.StoredProcedure;
                RPT.Parameters.Add("@DailyRPTID", DailyReport_ID);
                RPT.Parameters.Add("@HrNo", Hr5);
                RPT.Parameters.Add("@TaskDetail", Task5);
                RPT.Parameters.Add("@FrmTime", FrmTime5);
                RPT.Parameters.Add("@ToTime", ToTime5);
                RPT.Parameters.Add("@RptTime", RPTTime5);
                RPT.Parameters.Add("@ProjID", Convert.ToInt32((String.IsNullOrEmpty(Proj5) == true ? "0" : Proj5)));
                RPT.Connection = cn;
                RPT.ExecuteNonQuery();
            }

        }

        return DailyReport_ID;
    }
    #endregion

    #region SaveSixthhHr
    [WebMethod]
    public static string SaveRPTData5(string EmpName, string TimeIn, string FrmTime6, string ToTime6, string RPTTime6, string Proj6, string Task6, string Hr6, string DailyReport_ID)
    {
        String[] ArrayRptTime = RPTTime6.Split(':');
        if (DateTime.Now.Hour > (Convert.ToInt32(ArrayRptTime[0]) + 1))
        {
            return "expired";
        }

        if (DateTime.Now.Hour == (Convert.ToInt32(ArrayRptTime[0]) + 1))
        {
            if (DateTime.Now.Minute > Convert.ToInt32(ArrayRptTime[1]))
            {
                return "expired";
            }
        }

        if (DailyReport_ID == "0" || DailyReport_ID == "")
        {
            DailyReport_ID = CreateReportReport(EmpName, TimeIn);
        }

        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionstring2"].ToString()))
        {
            cn.Open();
            string CHCK = "SELECT * from ReportDetails where DailyReport_ID = '" + DailyReport_ID + "' and hourNo = '" + Hr6 + "'";
            SqlDataAdapter da = new SqlDataAdapter(CHCK, cn);
            DataTable dt = new DataTable();
            da.Fill(dt);
            if (dt.Rows.Count == 0)
            {
                SqlCommand RPT = new SqlCommand();
                RPT.CommandText = "Web_Proc_AddReportDetails";
                RPT.CommandType = CommandType.StoredProcedure;
                RPT.Parameters.Add("@TaskDetail", Task6);
                RPT.Parameters.Add("@DailyRPTID", DailyReport_ID);
                RPT.Parameters.Add("@FrmTime", FrmTime6);
                RPT.Parameters.Add("@ToTime", ToTime6);
                RPT.Parameters.Add("@RptTime", RPTTime6);
                RPT.Parameters.Add("@ProjID", Convert.ToInt32((String.IsNullOrEmpty(Proj6) == true ? "0" : Proj6)));
                RPT.Parameters.Add("@HrNo", Hr6);
                RPT.Connection = cn;
                RPT.ExecuteNonQuery();
            }
            else
            {
                SqlCommand RPT = new SqlCommand();
                RPT.CommandText = "Web_Proc_UpdateReportDetails";
                RPT.CommandType = CommandType.StoredProcedure;
                RPT.Parameters.Add("@DailyRPTID", DailyReport_ID);
                RPT.Parameters.Add("@HrNo", Hr6);
                RPT.Parameters.Add("@TaskDetail", Task6);
                RPT.Parameters.Add("@FrmTime", FrmTime6);
                RPT.Parameters.Add("@ToTime", ToTime6);
                RPT.Parameters.Add("@RptTime", RPTTime6);
                RPT.Parameters.Add("@ProjID", Convert.ToInt32((String.IsNullOrEmpty(Proj6) == true ? "0" : Proj6)));
                RPT.Connection = cn;
                RPT.ExecuteNonQuery();
            }

        }

        return DailyReport_ID;
    }
    #endregion

    #region SaveSeventhHr
    [WebMethod]
    public static string SaveRPTData6(string EmpName, string TimeIn, string FrmTime7, string ToTime7, string RPTTime7, string Proj7, string Task7, string Hr7, string DailyReport_ID)
    {
        String[] ArrayRptTime = RPTTime7.Split(':');
        if (DateTime.Now.Hour > (Convert.ToInt32(ArrayRptTime[0]) + 1))
        {
            return "expired";
        }

        if (DateTime.Now.Hour == (Convert.ToInt32(ArrayRptTime[0]) + 1))
        {
            if (DateTime.Now.Minute > Convert.ToInt32(ArrayRptTime[1]))
            {
                return "expired";
            }
        }

        if (DailyReport_ID == "0" || DailyReport_ID == "")
        {
            DailyReport_ID = CreateReportReport(EmpName, TimeIn);
        }
        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionstring2"].ToString()))
        {
            cn.Open();
            string CHCK = "SELECT * from ReportDetails where DailyReport_ID = '" + DailyReport_ID + "' and hourNo = '" + Hr7 + "'";
            SqlDataAdapter da = new SqlDataAdapter(CHCK, cn);
            DataTable dt = new DataTable();
            da.Fill(dt);
            if (dt.Rows.Count == 0)
            {
                SqlCommand RPT = new SqlCommand();
                RPT.CommandText = "Web_Proc_AddReportDetails";
                RPT.CommandType = CommandType.StoredProcedure;
                RPT.Parameters.Add("@TaskDetail", Task7);
                RPT.Parameters.Add("@DailyRPTID", DailyReport_ID);
                RPT.Parameters.Add("@FrmTime", FrmTime7);
                RPT.Parameters.Add("@ToTime", ToTime7);
                RPT.Parameters.Add("@RptTime", RPTTime7);
                RPT.Parameters.Add("@ProjID", Convert.ToInt32((String.IsNullOrEmpty(Proj7) == true ? "0" : Proj7)));
                RPT.Parameters.Add("@HrNo", Hr7);
                RPT.Connection = cn;
                RPT.ExecuteNonQuery();
            }
            else
            {
                SqlCommand RPT = new SqlCommand();
                RPT.CommandText = "Web_Proc_UpdateReportDetails";
                RPT.CommandType = CommandType.StoredProcedure;
                RPT.Parameters.Add("@DailyRPTID", DailyReport_ID);
                RPT.Parameters.Add("@HrNo", Hr7);
                RPT.Parameters.Add("@TaskDetail", Task7);
                RPT.Parameters.Add("@FrmTime", FrmTime7);
                RPT.Parameters.Add("@ToTime", ToTime7);
                RPT.Parameters.Add("@RptTime", RPTTime7);
                RPT.Parameters.Add("@ProjID", Convert.ToInt32((String.IsNullOrEmpty(Proj7) == true ? "0" : Proj7)));
                RPT.Connection = cn;
                RPT.ExecuteNonQuery();
            }

        }

        return DailyReport_ID;
    }
    #endregion

    #region SaveEigthHr
    [WebMethod]
    public static string SaveRPTData7(string EmpName, string TimeIn, string FrmTime8, string ToTime8, string RPTTime8, string Proj8, string Task8, string Hr8, string DailyReport_ID)
    {
        String[] ArrayRptTime = RPTTime8.Split(':');
        if (DateTime.Now.Hour > (Convert.ToInt32(ArrayRptTime[0]) + 1))
        {
            return "expired";
        }

        if (DateTime.Now.Hour == (Convert.ToInt32(ArrayRptTime[0]) + 1))
        {
            if (DateTime.Now.Minute > Convert.ToInt32(ArrayRptTime[1]))
            {
                return "expired";
            }
        }

        if (DailyReport_ID == "0" || DailyReport_ID == "")
        {
            DailyReport_ID = CreateReportReport(EmpName, TimeIn);
        }

        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionstring2"].ToString()))
        {
            cn.Open();
            string CHCK = "SELECT * from ReportDetails where DailyReport_ID = '" + DailyReport_ID + "' and hourNo = '" + Hr8 + "'";
            SqlDataAdapter da = new SqlDataAdapter(CHCK, cn);
            DataTable dt = new DataTable();
            da.Fill(dt);
            if (dt.Rows.Count == 0)
            {
                SqlCommand RPT = new SqlCommand();
                RPT.CommandText = "Web_Proc_AddReportDetails";
                RPT.CommandType = CommandType.StoredProcedure;
                RPT.Parameters.Add("@TaskDetail", Task8);
                RPT.Parameters.Add("@DailyRPTID", DailyReport_ID);
                RPT.Parameters.Add("@FrmTime", FrmTime8);
                RPT.Parameters.Add("@ToTime", ToTime8);
                RPT.Parameters.Add("@RptTime", RPTTime8);
                RPT.Parameters.Add("@ProjID", Convert.ToInt32((String.IsNullOrEmpty(Proj8) == true ? "0" : Proj8)));
                RPT.Parameters.Add("@HrNo", Hr8);
                RPT.Connection = cn;
                RPT.ExecuteNonQuery();
            }
            else
            {
                SqlCommand RPT = new SqlCommand();
                RPT.CommandText = "Web_Proc_UpdateReportDetails";
                RPT.CommandType = CommandType.StoredProcedure;
                RPT.Parameters.Add("@DailyRPTID", DailyReport_ID);
                RPT.Parameters.Add("@HrNo", Hr8);
                RPT.Parameters.Add("@TaskDetail", Task8);
                RPT.Parameters.Add("@FrmTime", FrmTime8);
                RPT.Parameters.Add("@ToTime", ToTime8);
                RPT.Parameters.Add("@RptTime", RPTTime8);
                RPT.Parameters.Add("@ProjID", Convert.ToInt32((String.IsNullOrEmpty(Proj8) == true ? "0" : Proj8)));
                RPT.Connection = cn;
                RPT.ExecuteNonQuery();
            }
        }

        return DailyReport_ID;
    }
    #endregion

    #region SaveNinthHr
    [WebMethod]
    public static string SaveRPTData8(string EmpName, string TimeIn, string FrmTime9, string ToTime9, string RPTTime9, string Proj9, string Task9, string Hr9, string DailyReport_ID)
    {
        String[] ArrayRptTime = RPTTime9.Split(':');
        if (DateTime.Now.Hour > (Convert.ToInt32(ArrayRptTime[0]) + 1))
        {
            return "expired";
        }

        if (DateTime.Now.Hour == (Convert.ToInt32(ArrayRptTime[0]) + 1))
        {
            if (DateTime.Now.Minute > Convert.ToInt32(ArrayRptTime[1]))
            {
                return "expired";
            }
        }

        if (DailyReport_ID == "0" || DailyReport_ID == "")
        {
            DailyReport_ID = CreateReportReport(EmpName, TimeIn);
        }

        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionstring2"].ToString()))
        {
            cn.Open();
            string CHCK = "SELECT * from ReportDetails where DailyReport_ID = '" + DailyReport_ID + "' and hourNo = '" + Hr9 + "'";
            SqlDataAdapter da = new SqlDataAdapter(CHCK, cn);
            DataTable dt = new DataTable();
            da.Fill(dt);
            if (dt.Rows.Count == 0)
            {
                SqlCommand RPT = new SqlCommand();
                RPT.CommandText = "Web_Proc_AddReportDetails";
                RPT.CommandType = CommandType.StoredProcedure;
                RPT.Parameters.Add("@TaskDetail", Task9);
                RPT.Parameters.Add("@DailyRPTID", DailyReport_ID);
                RPT.Parameters.Add("@FrmTime", FrmTime9);
                RPT.Parameters.Add("@ToTime", ToTime9);
                RPT.Parameters.Add("@RptTime", RPTTime9);
                RPT.Parameters.Add("@ProjID", Convert.ToInt32((String.IsNullOrEmpty(Proj9) == true ? "0" : Proj9)));
                RPT.Parameters.Add("@HrNo", Hr9);
                RPT.Connection = cn;
                RPT.ExecuteNonQuery();
            }
            else
            {
                SqlCommand RPT = new SqlCommand();
                RPT.CommandText = "Web_Proc_UpdateReportDetails";
                RPT.CommandType = CommandType.StoredProcedure;
                RPT.Parameters.Add("@DailyRPTID", DailyReport_ID);
                RPT.Parameters.Add("@HrNo", Hr9);
                RPT.Parameters.Add("@TaskDetail", Task9);
                RPT.Parameters.Add("@FrmTime", FrmTime9);
                RPT.Parameters.Add("@ToTime", ToTime9);
                RPT.Parameters.Add("@RptTime", RPTTime9);
                RPT.Parameters.Add("@ProjID", Convert.ToInt32((String.IsNullOrEmpty(Proj9) == true ? "0" : Proj9)));
                RPT.Connection = cn;
                RPT.ExecuteNonQuery();
            }
        }

        return DailyReport_ID;
    }
    #endregion

    #region SaveTenthHr
    [WebMethod]
    public static string SaveRPTData9(string EmpName, string TimeIn, string FrmTime10, string ToTime10, string RPTTime10, string Proj10, string Task10, string Hr10, string DailyReport_ID)
    {
        String[] ArrayRptTime = RPTTime10.Split(':');
        if (DateTime.Now.Hour > (Convert.ToInt32(ArrayRptTime[0]) + 1))
        {
            return "expired";
        }

        if (DateTime.Now.Hour == (Convert.ToInt32(ArrayRptTime[0]) + 1))
        {
            if (DateTime.Now.Minute > Convert.ToInt32(ArrayRptTime[1]))
            {
                return "expired";
            }
        }

        if (DailyReport_ID == "0" || DailyReport_ID == "")
        {
            DailyReport_ID = CreateReportReport(EmpName, TimeIn);
        }
        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionstring2"].ToString()))
        {
            cn.Open();
            string CHCK = "SELECT * from ReportDetails where DailyReport_ID = '" + DailyReport_ID + "' and hourNo = '" + Hr10 + "'";
            SqlDataAdapter da = new SqlDataAdapter(CHCK, cn);
            DataTable dt = new DataTable();
            da.Fill(dt);
            if (dt.Rows.Count == 0)
            {
                SqlCommand RPT = new SqlCommand();
                RPT.CommandText = "Web_Proc_AddReportDetails";
                RPT.CommandType = CommandType.StoredProcedure;
                RPT.Parameters.Add("@TaskDetail", Task10);
                RPT.Parameters.Add("@DailyRPTID", DailyReport_ID);
                RPT.Parameters.Add("@FrmTime", FrmTime10);
                RPT.Parameters.Add("@ToTime", ToTime10);
                RPT.Parameters.Add("@RptTime", RPTTime10);
                RPT.Parameters.Add("@ProjID", Convert.ToInt32((String.IsNullOrEmpty(Proj10) == true ? "0" : Proj10)));
                RPT.Parameters.Add("@HrNo", Hr10);
                RPT.Connection = cn;
                RPT.ExecuteNonQuery();
            }
            else
            {
                SqlCommand RPT = new SqlCommand();
                RPT.CommandText = "Web_Proc_UpdateReportDetails";
                RPT.CommandType = CommandType.StoredProcedure;
                RPT.Parameters.Add("@DailyRPTID", DailyReport_ID);
                RPT.Parameters.Add("@HrNo", Hr10);
                RPT.Parameters.Add("@TaskDetail", Task10);
                RPT.Parameters.Add("@FrmTime", FrmTime10);
                RPT.Parameters.Add("@ToTime", ToTime10);
                RPT.Parameters.Add("@RptTime", RPTTime10);
                RPT.Parameters.Add("@ProjID", Convert.ToInt32((String.IsNullOrEmpty(Proj10) == true ? "0" : Proj10)));
                RPT.Connection = cn;
                RPT.ExecuteNonQuery();
            }
        }

        return DailyReport_ID;
    }
    #endregion

    #region SaveElevethHr
    [WebMethod]
    public static string SaveRPTData10(string EmpName, string TimeIn, string FrmTime11, string ToTime11, string RPTTime11, string Proj11, string Task11, string Hr11, string DailyReport_ID)
    {
        String[] ArrayRptTime = RPTTime11.Split(':');
        if (DateTime.Now.Hour > (Convert.ToInt32(ArrayRptTime[0]) + 1))
        {
            return "expired";
        }

        if (DateTime.Now.Hour == (Convert.ToInt32(ArrayRptTime[0]) + 1))
        {
            if (DateTime.Now.Minute > Convert.ToInt32(ArrayRptTime[1]))
            {
                return "expired";
            }
        }

        if (DailyReport_ID == "0" || DailyReport_ID == "")
        {
            DailyReport_ID = CreateReportReport(EmpName, TimeIn);
        }

        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionstring2"].ToString()))
        {
            cn.Open();
            string CHCK = "SELECT * from ReportDetails where DailyReport_ID = '" + DailyReport_ID + "' and hourNo = '" + Hr11 + "'";
            SqlDataAdapter da = new SqlDataAdapter(CHCK, cn);
            DataTable dt = new DataTable();
            da.Fill(dt);
            if (dt.Rows.Count == 0)
            {
                SqlCommand RPT = new SqlCommand();
                RPT.CommandText = "Web_Proc_AddReportDetails";
                RPT.CommandType = CommandType.StoredProcedure;
                RPT.Parameters.Add("@TaskDetail", Task11);
                RPT.Parameters.Add("@DailyRPTID", DailyReport_ID);
                RPT.Parameters.Add("@FrmTime", FrmTime11);
                RPT.Parameters.Add("@ToTime", ToTime11);
                RPT.Parameters.Add("@RptTime", RPTTime11);
                RPT.Parameters.Add("@ProjID", Convert.ToInt32((String.IsNullOrEmpty(Proj11) == true ? "0" : Proj11)));
                RPT.Parameters.Add("@HrNo", Hr11);
                RPT.Connection = cn;
                RPT.ExecuteNonQuery();
            }
            else
            {
                SqlCommand RPT = new SqlCommand();
                RPT.CommandText = "Web_Proc_UpdateReportDetails";
                RPT.CommandType = CommandType.StoredProcedure;
                RPT.Parameters.Add("@DailyRPTID", DailyReport_ID);
                RPT.Parameters.Add("@HrNo", Hr11);
                RPT.Parameters.Add("@TaskDetail", Task11);
                RPT.Parameters.Add("@FrmTime", FrmTime11);
                RPT.Parameters.Add("@ToTime", ToTime11);
                RPT.Parameters.Add("@RptTime", RPTTime11);
                RPT.Parameters.Add("@ProjID", Convert.ToInt32((String.IsNullOrEmpty(Proj11) == true ? "0" : Proj11)));
                RPT.Connection = cn;
                RPT.ExecuteNonQuery();
            }
        }

        return DailyReport_ID;
    }
    #endregion

    #region SaveTwelfthHr
    [WebMethod]
    public static string SaveRPTData11(string EmpName, string TimeIn, string FrmTime12, string ToTime12, string RPTTime12, string Proj12, string Task12, string Hr12, string DailyReport_ID)
    {
        String[] ArrayRptTime = RPTTime12.Split(':');
        if (DateTime.Now.Hour > (Convert.ToInt32(ArrayRptTime[0]) + 1))
        {
            return "expired";
        }

        if (DateTime.Now.Hour == (Convert.ToInt32(ArrayRptTime[0]) + 1))
        {
            if (DateTime.Now.Minute > Convert.ToInt32(ArrayRptTime[1]))
            {
                return "expired";
            }
        }

        if (DailyReport_ID == "0" || DailyReport_ID == "")
        {
            DailyReport_ID = CreateReportReport(EmpName, TimeIn);
        }

        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionstring2"].ToString()))
        {
            cn.Open();
            string CHCK = "SELECT * from ReportDetails where DailyReport_ID = '" + DailyReport_ID + "' and hourNo = '" + Hr12 + "'";
            SqlDataAdapter da = new SqlDataAdapter(CHCK, cn);
            DataTable dt = new DataTable();
            da.Fill(dt);
            if (dt.Rows.Count == 0)
            {
                SqlCommand RPT = new SqlCommand();
                RPT.CommandText = "Web_Proc_AddReportDetails";
                RPT.CommandType = CommandType.StoredProcedure;
                RPT.Parameters.Add("@TaskDetail", Task12);
                RPT.Parameters.Add("@DailyRPTID", DailyReport_ID);
                RPT.Parameters.Add("@FrmTime", FrmTime12);
                RPT.Parameters.Add("@ToTime", ToTime12);
                RPT.Parameters.Add("@RptTime", RPTTime12);
                RPT.Parameters.Add("@ProjID", Convert.ToInt32((String.IsNullOrEmpty(Proj12) == true ? "0" : Proj12)));
                RPT.Parameters.Add("@HrNo", Hr12);
                RPT.Connection = cn;
                RPT.ExecuteNonQuery();
            }
            else
            {
                SqlCommand RPT = new SqlCommand();
                RPT.CommandText = "Web_Proc_UpdateReportDetails";
                RPT.CommandType = CommandType.StoredProcedure;
                RPT.Parameters.Add("@DailyRPTID", DailyReport_ID);
                RPT.Parameters.Add("@HrNo", Hr12);
                RPT.Parameters.Add("@TaskDetail", Task12);
                RPT.Parameters.Add("@FrmTime", FrmTime12);
                RPT.Parameters.Add("@ToTime", ToTime12);
                RPT.Parameters.Add("@RptTime", RPTTime12);
                RPT.Parameters.Add("@ProjID", Convert.ToInt32((String.IsNullOrEmpty(Proj12) == true ? "0" : Proj12)));
                RPT.Connection = cn;
                RPT.ExecuteNonQuery();
            }
        }

        return DailyReport_ID;
    }
    #endregion

    #endregion

    #region GetReportHrs
    public void GetUserReport()
    {
        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionstring2"].ToString()))
        {
            try
            {
                string RPT = "SELECT * from DailyReport where user_id = '" + EmployeeName + "' and CONVERT(varchar(20),CurrentDate, 101)=CONVERT(varchar(20),getdate(),101)";
                DataTable DT = new DataTable();
                SqlDataAdapter DA = new SqlDataAdapter(RPT, cn);
                DA.Fill(DT);
                int Report_ID = 0;
                string MyOutput = "";
                string Contseniors = "";
                if (DT.Rows.Count == 0)
                {
                    lblReportID.Text = "";
                    lblTimeIn.Text = "";
                    return;
                }
                else
                {
                    lblReportID.Text = DT.Rows[0]["DailyReport_ID"].ToString();
                    CheckIn = DT.Rows[0]["Time-In"].ToString();
                    lblTimeIn.Text = DT.Rows[0]["Time-In"].ToString();
                    ddlCInHrs.Enabled = false;
                    ddlCInMins.Enabled = false;
                }
                
                Report_ID = int.Parse(DT.Rows[0]["DailyReport_Id"].ToString());
                MyOutput = DT.Rows[0]["MyOutput"].ToString();
                Contseniors = DT.Rows[0]["ContactedSenior"].ToString();
                
                string cmd = "select fromtime from ReportDetails where DailyReport_ID = '" + Report_ID + "' order by hourNo asc";
                SqlDataAdapter DAH = new SqlDataAdapter(cmd, cn);
                DataTable DTH = new DataTable();
                DAH.Fill(DTH);
                //CheckIn = "";
                if (DTH.Rows.Count > 0)
                {
                    //CheckIn = DTH.Rows[0]["fromtime"].ToString();
                    lblTimeIn.Text = CheckIn;
                }
                DailyRPTID = Report_ID.ToString();
                lblReportID.Text = DailyRPTID;
                string query = "";
                query = "SELECT * from ReportDetails where DailyReport_ID = " + Report_ID + " order by hourNo asc";
                DataTable dt = new DataTable();
                SqlDataAdapter DAR = new SqlDataAdapter(query, cn);
                DAR.Fill(dt);
                int count = 0;
                count = dt.Rows.Count;
                if (count > 0)
                {
                    DataRow[] DRows;

                    #region First Hour
                    DRows = dt.Select("hourNo = '1'");
                    if (DRows.Count() > 0)
                    {
                        txtFrmTime1.Text = DRows[0]["fromTime"].ToString();
                        txtToTime1.Text = DRows[0]["toTime"].ToString();
                        txtRPTTime1.Text = DRows[0]["rptTime"].ToString();
                        txtOutput1.Text = DRows[0]["TaskDetails"].ToString();
                        if (Convert.ToInt32(DRows[0]["Proj_IT_ID"].ToString()) != 0)
                        {
                            ddlProj1.Items.FindByValue(DRows[0]["Proj_IT_ID"].ToString()).Selected = true;
                        }
                    }
                    #endregion

                    #region Second Hour
                    DRows = dt.Select("hourNo = '2'");
                    if (DRows.Count() > 0)
                    {
                        txtFrmTime2.Text = DRows[0]["fromTime"].ToString();
                        txtToTime2.Text = DRows[0]["toTime"].ToString();
                        txtRPTTime2.Text = DRows[0]["rptTime"].ToString();
                        txtOutput2.Text = DRows[0]["TaskDetails"].ToString();
                        if (Convert.ToInt32(DRows[0]["Proj_IT_ID"]) != 0)
                        {
                            ddlProj2.Items.FindByValue(DRows[0]["Proj_IT_ID"].ToString()).Selected = true;
                        }
                    }
                    #endregion

                    #region Third Hour

                    DRows = dt.Select("hourNo = '3'");

                    if (DRows.Count() > 0)
                    {
                        txtFrmTime3.Text = DRows[0]["fromTime"].ToString();
                        txtToTime3.Text = DRows[0]["toTime"].ToString();
                        txtRPTTime3.Text = DRows[0]["rptTime"].ToString();
                        txtOutput3.Text = DRows[0]["TaskDetails"].ToString();
                        if (Convert.ToInt32(DRows[0]["Proj_IT_ID"]) != 0)
                        {
                            ddlProj3.Items.FindByValue(DRows[0]["Proj_IT_ID"].ToString()).Selected = true;
                        }
                    }
                    #endregion

                    #region Fourth Hour
                    DRows = dt.Select("hourNo = '4'");
                    if (DRows.Count() > 0)
                    {
                        txtFrmTime4.Text = DRows[0]["fromTime"].ToString();
                        txtToTime4.Text = DRows[0]["toTime"].ToString();
                        txtRPTTime4.Text = DRows[0]["rptTime"].ToString();
                        txtOutput4.Text = DRows[0]["TaskDetails"].ToString();
                        if (Convert.ToInt32(DRows[0]["Proj_IT_ID"]) != 0)
                        {
                            ddlProj4.Items.FindByValue(DRows[0]["Proj_IT_ID"].ToString()).Selected = true;
                        }
                    }
                    #endregion

                    #region Fifth Hour

                     DRows = dt.Select("hourNo = '5'");
                     if (DRows.Count() > 0)
                     {
                         txtFrmTime5.Text = DRows[0]["fromTime"].ToString();
                         txtToTime5.Text = DRows[0]["toTime"].ToString();
                         txtRPTTime5.Text = DRows[0]["rptTime"].ToString();
                         txtOutput5.Text = DRows[0]["TaskDetails"].ToString();
                         if (Convert.ToInt32(DRows[0]["Proj_IT_ID"]) != 0)
                         {
                             ddlProj5.Items.FindByValue(DRows[0]["Proj_IT_ID"].ToString()).Selected = true;
                         }
                     }
                    #endregion

                    #region Sixth Hour
                     DRows = dt.Select("hourNo = '6'");
                     if (DRows.Count() > 0)
                     {
                         txtFrmTime6.Text = DRows[0]["fromTime"].ToString();
                         txtToTime6.Text = DRows[0]["toTime"].ToString();
                         txtRPTTime6.Text = DRows[0]["rptTime"].ToString();
                         txtOutput6.Text = DRows[0]["TaskDetails"].ToString();
                         if (Convert.ToInt32(DRows[0]["Proj_IT_ID"]) != 0)
                         {
                             ddlProj6.Items.FindByValue(DRows[0]["Proj_IT_ID"].ToString()).Selected = true;
                         }
                     }
                    #endregion

                    #region Seventh Hour
                     DRows = dt.Select("hourNo = '7'");
                     if (DRows.Count() > 0)
                     {
                         txtFrmTime7.Text = DRows[0]["fromTime"].ToString();
                         txtToTime7.Text = DRows[0]["toTime"].ToString();
                         txtRPTTime7.Text = DRows[0]["rptTime"].ToString();
                         txtOutput7.Text = DRows[0]["TaskDetails"].ToString();
                         if (Convert.ToInt32(DRows[0]["Proj_IT_ID"]) != 0)
                         {
                             ddlProj7.Items.FindByValue(DRows[0]["Proj_IT_ID"].ToString()).Selected = true;
                         }
                     }
                    #endregion

                    #region Eigth Hour
                     DRows = dt.Select("hourNo = '8'");
                     if (DRows.Count() > 0)
                     {
                         txtFrmTime8.Text = DRows[0]["fromTime"].ToString();
                         txtToTime8.Text = DRows[0]["toTime"].ToString();
                         txtRPTTime8.Text = DRows[0]["rptTime"].ToString();
                         txtOutput8.Text = DRows[0]["TaskDetails"].ToString();
                         if (Convert.ToInt32(DRows[0]["Proj_IT_ID"]) != 0)
                         {
                             ddlProj8.Items.FindByValue(DRows[0]["Proj_IT_ID"].ToString()).Selected = true;
                         }
                     }
                    #endregion

                    #region Ninth Hour
                    DRows = dt.Select("hourNo = '9'");
                    if (DRows.Count() > 0)
                    {
                        txtFrmTime9.Text = DRows[0]["fromTime"].ToString();
                        txtToTime9.Text = DRows[0]["toTime"].ToString();
                        txtRPTTime9.Text = DRows[0]["rptTime"].ToString();
                        txtOutput9.Text = DRows[0]["TaskDetails"].ToString();
                        if (Convert.ToInt32(DRows[0]["Proj_IT_ID"]) != 0)
                        {
                            ddlProj9.Items.FindByValue(DRows[0]["Proj_IT_ID"].ToString()).Selected = true;
                        }
                    }
                    #endregion

                    #region Tenth Hour
                    DRows = dt.Select("hourNo = '10'");
                    if (DRows.Count() > 0)
                    {
                        txtFrmTime10.Text = DRows[0]["fromTime"].ToString();
                        txtToTime10.Text = DRows[0]["toTime"].ToString();
                        txtRPTTime10.Text = DRows[0]["rptTime"].ToString();
                        txtOutput10.Text = DRows[0]["TaskDetails"].ToString();
                        if (Convert.ToInt32(DRows[0]["Proj_IT_ID"]) != 0)
                        {
                            ddlProj10.Items.FindByValue(DRows[0]["Proj_IT_ID"].ToString()).Selected = true;
                        }
                    }
                    #endregion

                    #region Eleventh Hour
                    DRows = dt.Select("hourNo = '11'");
                    if (DRows.Count() > 0)
                    {
                        txtFrmTime11.Text = DRows[0]["fromTime"].ToString();
                        txtToTime11.Text = DRows[0]["toTime"].ToString();
                        txtRPTTime11.Text = DRows[0]["rptTime"].ToString();
                        txtOutput11.Text = DRows[0]["TaskDetails"].ToString();
                        if (Convert.ToInt32(DRows[0]["Proj_IT_ID"]) != 0)
                        {
                            ddlProj11.Items.FindByValue(DRows[0]["Proj_IT_ID"].ToString()).Selected = true;
                        }
                    }
                    #endregion

                    #region Twelfth Hour
                     DRows = dt.Select("hourNo = '12'");
                     if (DRows.Count() > 0)
                     {
                         txtFrmTime12.Text = DRows[0]["fromTime"].ToString();
                         txtToTime12.Text = DRows[0]["toTime"].ToString();
                         txtRPTTime12.Text = DRows[0]["rptTime"].ToString();
                         txtOutput12.Text = DRows[0]["TaskDetails"].ToString();
                         if (Convert.ToInt32(DRows[0]["Proj_IT_ID"]) != 0)
                         {
                             ddlProj12.Items.FindByValue(DRows[0]["Proj_IT_ID"].ToString()).Selected = true;
                         }
                     }
                    #endregion
                }


            }
            catch (Exception)
            {
                //throw;
            }
            try
            {
                #region FinalOutput
                string RPT = "SELECT * from DailyReport where user_id = '" + EmployeeName + "' and CONVERT(varchar(20),CurrentDate, 101)=CONVERT(varchar(20),getdate(),101)";
                DataTable DT = new DataTable();
                SqlDataAdapter DA = new SqlDataAdapter(RPT, cn);
                DA.Fill(DT);
                string MyOutput = "";
                string Contseniors = "";
                if (DT.Rows.Count > 0)
                {
                    MyOutput = DT.Rows[0]["MyOutput"].ToString();
                    Contseniors = DT.Rows[0]["ContactedSenior"].ToString();
                }
                txtOveralloutput.Text = MyOutput;
                string checkout = DT.Rows[0]["Time-Out"].ToString();
                if (Contseniors == "Yes")
                {
                    CByes.Checked = true;
                    CBAgree.Checked = true;
                }
                string[] Cout = checkout.Split(':');
                ddlCOutHrs.SelectedValue = Cout[0];
                ddlCOutMins.SelectedValue = Cout[1];
                #endregion
            }
            catch (Exception)
            {

                //throw;
            }


        }
    }

    #endregion

    #region GenerateEmail
    [WebMethod]
    public static void SendEmail(string TimeIn, string frmTime1, string frmTime2, string frmTime3, string frmTime4, 
        string frmTime5, string frmTime6, string frmTime7, string frmTime8, string frmTime9, string frmTime10, string frmTime11, 
        string frmTime12, string totime1, string totime2, string totime3, string totime4, string totime5, string totime6, string totime7,
        string totime8, string totime9, string totime10, string totime11, string totime12, string RPTtime1, string RPTtime2, string RPTtime3, 
        string RPTtime4, string RPTtime5, string RPTtime6, string RPTtime7, string RPTtime8, string RPTtime9, string RPTtime10, string RPTtime11,
        string RPTtime12, string Proj1, string Proj2, string Proj3, string Proj4, string Proj5, string Proj6, string Proj7, string Proj8, string Proj9,
        string Proj10, string Proj11, string Proj12, string Task1, string Task2, string Task3, string Task4, string Task5, string Task6, string Task7,
        string Task8, string Task9, string Task10, string Task11, string Task12, string MyOutput, string CheckOut, string EmpName, string Fatigues)
    {
        try
        {
            string Timein = TimeIn;
            string TimeOut = CheckOut;
            string dateandtime = DateTime.Now.ToShortDateString();
            MailMessage Mail = new MailMessage();
            Mail.To = "ceo@mechatronix.com.pk";
            Mail.From = "info@mechatronix.com.pk";
            Mail.Cc = "info@mechatronix.com.pk";
            Mail.Bcc = "it@mechatronix.com.pk";
            Mail.Bcc = "hub@mechatronix.com.pk";
            Mail.Subject = EmpName + " - Daily Output Report!";
            Mail.BodyFormat = MailFormat.Html;
            Mail.Body = "<table border='1' style='width:990px'>" +
                       "<tr>" +
                       "<td style='font-weight: bold; font-family: calibri; text-align: center; font-size: small; background-color:Gray; color: #FFFFFF;'>MCTX Report Details</td>" +
                       "</tr>" +
                       "<tr>" +
                       "<td style='font-family: calibri; font-size: small; color: DarkBlue;'>" +
                       "<p>System Generated Email Please Do Not Reply!</p></td>" +
                       "</tr>" +
                       "<tr>" +
                       "<td style='background-color: #006699; color: #FFFFFF;'>" +
                            "<table style='width:100%'> " +
                            "<tr>" +
                            "<td style='width:200px; font-family:calibri; color: #FFFFFF; font-size:small'>Employee Name:</td><td style='font-family:Verdana; color: #FFFFFF; font-size:12px;'>" + EmpName + " </td>" +
                            "</tr>" +
                "<tr>" +
                            "<td style='width:200px; font-family:calibri; color: #FFFFFF; font-size:small'>Check-In Time: </td><td style='font-family:Verdana; color: #FFFFFF; font-size:12px;'>" + Timein + " </td>" +
                            "</tr>" +
                            "<tr>" +
                            "<td style='width:200px; font-family:calibri; color: #FFFFFF; font-size:small'>Check-Out Time: </td><td style='font-family:Verdana; color: #FFFFFF; font-size:12px;'>" + TimeOut + " </td>" +
                            "</tr>" +
                "<tr>" +
                            "<td style='width:200px; font-family:calibri; color: #FFFFFF; font-size:small'>Date:</td><td style='font-family:Verdana; color: #FFFFFF; font-size:12px;'>" + dateandtime + " </td>" +
                            "</tr>" +
                            "</table>" +
                       "</td>" +
                       "</tr>" +
                       "<tr>" +
                       "<td>" +
                            "<table border='1' align='left' width='100%'>" +
                            "<tr>" +
                                "<td style='background-color: #B8DBFF; font-family:calibri; width:5%;'>Hr #</td><td style='background-color: #B8DBFF; font-family:calibri; width:10%;'>From Time</td><td style='background-color: #B8DBFF; font-family:calibri; width:8%;'>To Time</td><td style='background-color: #B8DBFF; font-family:calibri; width:12%;'>Report Time</td><td style='background-color: #B8DBFF; font-family:calibri; width:15%;'>Project</td><td style='background-color: #B8DBFF; font-family:calibri; width:50%;'>Activity</td>" +
                            "</tr>" +
                            "<tr>" +
                                "<td style='font-family:calibri; text-align:center;'>1</td><td style='font-family:calibri'>" + frmTime1 + "</td><td style='font-family:calibri'>" + totime1 + "</td><td style='font-family:calibri'>" + RPTtime1 + "</td><td style='font-family:calibri'>" + Proj1 + "</td><td style='font-family:calibri'>" + Task1 + "</td>" +
                            "</tr>" +
                            "<tr>" +
                                "<td style='font-family:calibri; text-align:center;'>2</td><td style='font-family:calibri'>" + frmTime2 + "</td><td style='font-family:calibri'>" + totime2 + "</td><td style='font-family:calibri'>" + RPTtime2 + "</td><td style='font-family:calibri'>" + Proj2 + "</td><td style='font-family:calibri'>" + Task2 + "</td>" +
                            "</tr>" +
                            "<tr>" +
                                "<td style='font-family:calibri; text-align:center;'>3</td><td style='font-family:calibri'>" + frmTime3 + "</td><td style='font-family:calibri'>" + totime3 + "</td><td style='font-family:calibri'>" + RPTtime3 + "</td><td style='font-family:calibri'>" + Proj3 + "</td><td style='font-family:calibri'>" + Task3 + "</td>" +
                            "</tr>" +
                            "<tr>" +
                                "<td style='font-family:calibri; text-align:center;'>4</td><td style='font-family:calibri'>" + frmTime4 + "</td><td style='font-family:calibri'>" + totime4 + "</td><td style='font-family:calibri'>" + RPTtime4 + "</td><td style='font-family:calibri'>" + Proj4 + "</td><td style='font-family:calibri'>" + Task4 + "</td>" +
                            "</tr>" +
                            "<tr>" +
                                "<td style='font-family:calibri; text-align:center;'>5</td><td style='font-family:calibri'>" + frmTime5 + "</td><td style='font-family:calibri'>" + totime5 + "</td><td style='font-family:calibri'>" + RPTtime5 + "</td><td style='font-family:calibri'>" + Proj5 + "</td><td style='font-family:calibri'>" + Task5 + "</td>" +
                            "</tr>" +
                            "<tr>" +
                                "<td style='font-family:calibri; text-align:center;'>6</td><td style='font-family:calibri'>" + frmTime6 + "</td><td style='font-family:calibri'>" + totime6 + "</td><td style='font-family:calibri'>" + RPTtime6 + "</td><td style='font-family:calibri'>" + Proj6 + "</td><td style='font-family:calibri'>" + Task6 + "</td>" +
                            "</tr>" +
                            "<tr>" +
                                "<td style='font-family:calibri; text-align:center;'>7</td><td style='font-family:calibri'>" + frmTime7 + "</td><td style='font-family:calibri'>" + totime7 + "</td><td style='font-family:calibri'>" + RPTtime7 + "</td><td style='font-family:calibri'>" + Proj7 + "</td><td style='font-family:calibri'>" + Task7 + "</td>" +
                            "</tr>" +
                            "<tr>" +
                                "<td style='font-family:calibri; text-align:center;'>8</td><td style='font-family:calibri'>" + frmTime8 + "</td><td style='font-family:calibri'>" + totime8 + "</td><td style='font-family:calibri'>" + RPTtime8 + "</td><td style='font-family:calibri'>" + Proj8 + "</td><td style='font-family:calibri'>" + Task8 + "</td>" +
                            "</tr>" +
                            "<tr>" +
                                "<td style='font-family:calibri; text-align:center;'>9</td><td style='font-family:calibri'>" + frmTime9 + "</td><td style='font-family:calibri'>" + totime9 + "</td><td style='font-family:calibri'>" + RPTtime9 + "</td><td style='font-family:calibri'>" + Proj9 + "</td><td style='font-family:calibri'>" + Task9 + "</td>" +
                            "</tr>" +
                            "<tr>" +
                                "<td style='font-family:calibri; text-align:center;'>10</td><td style='font-family:calibri'>" + frmTime10 + "</td><td style='font-family:calibri'>" + totime10 + "</td><td style='font-family:calibri'>" + RPTtime10 + "</td><td style='font-family:calibri'>" + Proj10 + "</td><td style='font-family:calibri'>" + Task10 + "</td>" +
                            "</tr>" +
                            "<tr>" +
                                "<td style='font-family:calibri; text-align:center;'>11</td><td style='font-family:calibri'>" + frmTime11 + "</td><td style='font-family:calibri'>" + totime11 + "</td><td style='font-family:calibri'>" + RPTtime11 + "</td><td style='font-family:calibri'>" + Proj11 + "</td><td style='font-family:calibri'>" + Task11 + "</td>" +
                            "</tr>" +
                            "<tr>" +
                                "<td style='font-family:calibri; text-align:center;'>12</td><td style='font-family:calibri'>" + frmTime12 + "</td><td style='font-family:calibri'>" + totime12 + "</td><td style='font-family:calibri'>" + RPTtime12 + "</td><td style='font-family:calibri'>" + Proj12 + "</td><td style='font-family:calibri'>" + Task12 + "</td>" +
                            "</tr>" +

                            "</table>" +
                       "</td>" +
                       "</tr>" +
                       "<tr>" +
                       "<td style='font-family: calibri; font-size: small; background-color: #006699; color: #FFFFFF;'>My Benefit To Mechatronix:  " + Fatigues + "</td>" +
                       "</tr>" +
                       "<tr>" +
                       "<td style='font-family: calibri; font-size: small; background-color: #006699; color: #FFFFFF;'>My Benefit To Mechatronix:  " + MyOutput + "</td>" +
                       "</tr>" +
                       "</table>";
            SmtpMail.SmtpServer = "mail.mechatronix.com.pk";
            SmtpMail.Send(Mail);
        }
        catch (Exception ex)
        {
            //throw;
        }
    }
    #endregion

    #region SendFinalReport
    [WebMethod]
    public static void SendFinalReport(string CheckOut, string Output, string ContSenior, string DailyReport_ID, string Fatigues)
    {
        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionstring2"].ToString()))
        {
            cn.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.CommandText = "Web_Proc_SendFinalReport";
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Add("@Checkout", CheckOut);
            cmd.Parameters.Add("@Output", Output);
            cmd.Parameters.Add("@ContactSenior", ContSenior);
            cmd.Parameters.Add("@RPTID", int.Parse(DailyReport_ID));
            cmd.Connection = cn;
            cmd.ExecuteNonQuery();
        }
    }
    #endregion

    #region LoadProjDDLs
    public void LoadProj()
    {
        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionstring2"].ToString()))
        {
            try
            {
                SqlCommand cmdProj = new SqlCommand("select Proj_IT_ID,Proj_Name from tbl_IT_Projects where Deleted = 0 order by Proj_Name", cn);
                cn.Open();
                SqlDataAdapter daProj = new SqlDataAdapter(cmdProj);
                DataTable dtProj = new DataTable();
                daProj.Fill(dtProj);
                #region FirstDDL
                ddlProj1.DataSource = dtProj;
                ddlProj1.DataTextField = "Proj_Name";
                ddlProj1.DataValueField = "Proj_IT_ID";
                ddlProj1.DataBind();
                ddlProj1.Items.Insert(0, "");
                #endregion

                #region SecondDDL
                ddlProj2.DataSource = dtProj;
                ddlProj2.DataTextField = "Proj_Name";
                ddlProj2.DataValueField = "Proj_IT_ID";
                ddlProj2.DataBind();
                ddlProj2.Items.Insert(0, "");
                #endregion

                #region ThirdDDL
                ddlProj3.DataSource = dtProj;
                ddlProj3.DataTextField = "Proj_Name";
                ddlProj3.DataValueField = "Proj_IT_ID";
                ddlProj3.DataBind();
                ddlProj3.Items.Insert(0, "");
                #endregion

                #region FourthDDL
                ddlProj4.DataSource = dtProj;
                ddlProj4.DataTextField = "Proj_Name";
                ddlProj4.DataValueField = "Proj_IT_ID";
                ddlProj4.DataBind();
                ddlProj4.Items.Insert(0, "");
                #endregion

                #region FifthDDL
                ddlProj5.DataSource = dtProj;
                ddlProj5.DataTextField = "Proj_Name";
                ddlProj5.DataValueField = "Proj_IT_ID";
                ddlProj5.DataBind();
                ddlProj5.Items.Insert(0, "");
                #endregion

                #region SixthDDL
                ddlProj6.DataSource = dtProj;
                ddlProj6.DataTextField = "Proj_Name";
                ddlProj6.DataValueField = "Proj_IT_ID";
                ddlProj6.DataBind();
                ddlProj6.Items.Insert(0, "");
                #endregion

                #region SeventhDDL
                ddlProj7.DataSource = dtProj;
                ddlProj7.DataTextField = "Proj_Name";
                ddlProj7.DataValueField = "Proj_IT_ID";
                ddlProj7.DataBind();
                ddlProj7.Items.Insert(0, "");
                #endregion

                #region EigthDDL
                ddlProj8.DataSource = dtProj;
                ddlProj8.DataTextField = "Proj_Name";
                ddlProj8.DataValueField = "Proj_IT_ID";
                ddlProj8.DataBind();
                ddlProj8.Items.Insert(0, "");
                #endregion

                #region NinthDDL
                ddlProj9.DataSource = dtProj;
                ddlProj9.DataTextField = "Proj_Name";
                ddlProj9.DataValueField = "Proj_IT_ID";
                ddlProj9.DataBind();
                ddlProj9.Items.Insert(0, "");
                #endregion

                #region TenthDDL
                ddlProj10.DataSource = dtProj;
                ddlProj10.DataTextField = "Proj_Name";
                ddlProj10.DataValueField = "Proj_IT_ID";
                ddlProj10.DataBind();
                ddlProj10.Items.Insert(0, "");
                #endregion

                #region EleventhDDL
                ddlProj11.DataSource = dtProj;
                ddlProj11.DataTextField = "Proj_Name";
                ddlProj11.DataValueField = "Proj_IT_ID";
                ddlProj11.DataBind();
                ddlProj11.Items.Insert(0, "");
                #endregion

                #region TwelfthDDL
                ddlProj12.DataSource = dtProj;
                ddlProj12.DataTextField = "Proj_Name";
                ddlProj12.DataValueField = "Proj_IT_ID";
                ddlProj12.DataBind();
                ddlProj12.Items.Insert(0, "");
                #endregion
            }
            catch (Exception)
            {

                //throw;
            }
        }
    }

    #endregion

    #region CheckDepart
    [WebMethod]
    public static string UserDeptType(string EmpName)
    {
        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionstring2"].ToString()))
        {
            SqlCommand cmd = new SqlCommand("select Dp_Id from tbl_employee where E_Name = '" + EmpName + "'", cn);
            cn.Open();
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);
            DPTID = dt.Rows[0]["Dp_Id"].ToString();
        }
        return DPTID;
    }
    #endregion

}

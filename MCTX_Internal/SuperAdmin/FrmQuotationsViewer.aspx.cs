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
using System.IO;
using iTextSharp;
using iTextSharp.text;
using iTextSharp.text.html.simpleparser;
using iTextSharp.text.pdf;
using System.Collections;
using System.Web.Mail;
using System.Net;
using System.Text;
using System.Net.Mime;
using System.Diagnostics;



public partial class MCTX_Internal_SuperAdmin_FrmQuotationsViewer : System.Web.UI.Page
{
    static DataTable _dt = new DataTable();
    static string Quot_Id = "";
    string PDF_filename = "";

    protected void Page_Load(object sender, EventArgs e)
    {
        if(Request.QueryString["QuotID"].ToString()!="")
        Quot_Id = Request.QueryString["QuotID"].ToString();
        if (!IsPostBack)
        {
            PDF_filename = "";
            Quot_Id = Request.QueryString["QuotID"].ToString();
            GetQuotation();
            BindLabels();
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

    public void BindLabels()
    {
        try
        {
            //lblRep.Text = _dt.Rows[0]["sal_manager_name"].ToString();
            lblRep.Text = _dt.Rows[0]["E_Name"].ToString();
        }
        catch (Exception)
        {
            
          //  throw;
        }
        

        try
        {
            lblAttention.Text = _dt.Rows[0]["client_name"].ToString();
        }
        catch (Exception ex)
        {

        }
        try
        {
            lblDesg.Text = _dt.Rows[0]["client_designation"].ToString();
        }
        catch (Exception ex)
        {

        }
        try
        {
            lblDept.Text = _dt.Rows[0]["client_dept"].ToString();
        }
        catch (Exception ex)
        {

        }
        try
        {
            lblOrganisation.Text = _dt.Rows[0]["comp_name"].ToString();
        }
        catch (Exception ex)
        {

        }
        try
        {
            lblContact.Text = _dt.Rows[0]["Client_mobile"].ToString();
        }
        catch (Exception ex)
        {

        }

        lblFax.Text = _dt.Rows[0]["client_phone"].ToString();
        try
        {
            lblEmail.Text = _dt.Rows[0]["client_email"].ToString();
        }
        catch (Exception ex)
        {

        }
        //lblNoofPages.Text = _dt.Rows[0][""].ToString();
        try
        {
            lblDate.Text = _dt.Rows[0]["quo_date"].ToString();
        }
        catch (Exception ex)
        {

        }
        try
        {
            lblTechPerson.Text = _dt.Rows[0]["tec_per_name"].ToString();
        }
        catch (Exception ex)
        {

        }
        try
        {
            //lblRefContact.Text = _dt.Rows[0]["tec_mobile"].ToString();
            lblRefContact.Text = _dt.Rows[0]["Emp_offcial_number"].ToString();
        }
        catch (Exception ex)
        {

        }
        try
        {
            lblOffEmail.Text = "info@mechatronix.com.pk";
        }
        catch (Exception ex)
        {

        }
        try
        {
            lblRefFax.Text = "051-2872-811";
        }
        catch (Exception ex)
        {

        }
        try
        {
            lblSalesRepEmail.Text = _dt.Rows[0]["sale_email"].ToString();
        }
        catch (Exception ex)
        {

        }
        try
        {
            lblTitle.Text = _dt.Rows[0]["subject"].ToString();
        }
        catch (Exception ex)
        {

        }
        try
        {
            lblRef.Text = "MCTX" + "/" + _dt.Rows[0]["comp_Key"].ToString() + "/" + _dt.Rows[0]["quo_id"].ToString();
            //lblRef.Text = "MCTX" + "/ " + DateTime.Now.Year + "/ " + DateTime.Now.Month + "/ " + DateTime.Now.Day + "/ " + _dt.Rows[0]["comp_name"].ToString().Substring(0, 3);
        }
        catch
        {

        }
    }

    [WebMethod]
    public static Dictionary<string, object> GetQuotation()
    {
        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionstring2"].ToString()))
        {
            SqlCommand cmd = new SqlCommand("QuotData", cn);
            cmd.CommandType = CommandType.StoredProcedure;
            cn.Open();
            cmd.Parameters.Add("@quot_id", Convert.ToInt32(Quot_Id));
            SqlDataAdapter DA = new SqlDataAdapter(cmd);
            DataSet ds = new DataSet();
            DA.Fill(ds, "GetQuotation");
            DataTable dt = new DataTable();
            dt = ds.Tables["GetQuotation"];
            _dt = dt;
            return ToJson(dt);
        }
    }



    [WebMethod]
    public static Dictionary<string, object> GetQuotTermsAndCondtion()
    {
        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionstring2"].ToString()))
        {
            SqlCommand cmd = new SqlCommand("S_QuotTermsAndCondition", cn);
            cmd.CommandType = CommandType.StoredProcedure;
            cn.Open();
            cmd.Parameters.Add("@QuotID", Convert.ToInt32(Quot_Id));
            SqlDataAdapter DA = new SqlDataAdapter(cmd);
            DataSet ds = new DataSet();
            DA.Fill(ds, "GetQuotTermAndCondition");
            DataTable dt = new DataTable();
            dt = ds.Tables["GetQuotTermAndCondition"];
            _dt = dt;
            return ToJson(dt);
        }
    }
    // DataTable DTQuotTerms = objQuot.fnGetQuotationsTerms(quotid);
    protected void btnExcel_Click(object sender, EventArgs e)
    {
        string html = HdnValue.Value;
        Utility _export = new Utility();
        _export.ExportToExcel(ref html, "Quotation.xls");
        //ExportToExcel(ref html, "Quotation (Mechatronix)");
    }
    //public void ExportToExcel(ref string html, string fileName)
    //{
    //    html = html.Replace("&gt;", ">");
    //    html = html.Replace("&lt;", "<");
    //    HttpContext.Current.Response.ClearContent();
    //    HttpContext.Current.Response.AddHeader("content-disposition", "attachment;filename=" + fileName + "_" + DateTime.Now.ToString("M_dd_yyyy_H_M_s") + ".xls");
    //    HttpContext.Current.Response.ContentType = "application/xls";
    //    HttpContext.Current.Response.Write(html);
    //    HttpContext.Current.Response.End();
    //}

    protected void Button1_Click1(object sender, EventArgs e)
    {
        //saveURLToImage("http://google.com.pk/");
    }

    protected void btnExport_Click(object sender, EventArgs e)
    {
        string html = HdnValue.Value;
        Utility _export = new Utility();
        //if (ddlExportOpt.SelectedValue == "1")
        //{
        //HttpContext.Current.Response.ClearHeaders();
        //HttpContext.Current.Response.AddHeader("Cache-Control", "");
        //_export.ExportToExcel(ref html, "Quotation.xls");
        //}
        //else
        //{
        ExportToPDFByTahir(ref html, "Quotation.pdf");
        //}
    }

    protected void lnkEmail_Click(object sender, EventArgs e)
    {
        string html = HdnValue.Value;
        Utility _export = new Utility();
        ExportToPDFByTahir(ref html, "Quotation.pdf");
        String rootPath = Server.MapPath(@"~\Quotes");
        PDF_filename = rootPath + "\\Quotation.pdf";
        //Path.Combine(Path.GetTempPath(), "Quotation.pdf");
        SendEmail(txtEmail.Text.Trim(), PDF_filename);
        lblEmail_Quotation.Visible = true;
        lblEmail_Quotation.ForeColor = System.Drawing.Color.Green;
    }

    #region Export to PDF
    public void ExportToPDFByTahir(ref string html, string filename)
    {
        //using (new NetworkConnection(@"\\server2\write", writeCredentials))
        //{
        //    File.Copy(@"\\server\read\file", @"\\server2\write\file");
        //}

        NetworkCredential NC = new NetworkCredential("mechatronix.com.pk", "islamisbest", "mechatronix.com.pk");

        //DirectoryInfo di = new DirectoryInfo(Directory.GetCurrentDirectory());
        String rootPath = Server.MapPath(@"~\Quotes");
        DirectoryInfo di = new DirectoryInfo(Server.MapPath(@"~\Quotes"));
        //GetFileList(rootPath+ "\\Quotes");

        FileInfo[] rgFiles = di.GetFiles("*.pdf");
        foreach (FileInfo fi in rgFiles)
        {
            //try
            //{
            //ConnectToFtp(di + "\\" + fi, "");
            //System.Uri uri = new System.Uri(di + "" + fi);
            //ConnectToFtp(di + "" + fi,
            File.Delete(di + "\\" + fi);

            //try
            //{

            //}
            //catch (Exception ex)
            //{ 
            //}
            //}
            //catch (Exception ex)
            //{ }
        }

        html = html.Replace("&gt;", ">");
        html = html.Replace("&lt;", "<");
        HttpContext.Current.Response.ContentType = "application/pdf";
        HttpContext.Current.Response.AddHeader("content-disposition", "attachment;filename=" + filename);// + fileName + "_" + DateTime.Now.ToString("M_dd_yyyy_H_M_s") + ".pdf");        
        /*
         * need the Rectangle for later when we set the column widths
        */
        Rectangle rect = PageSize.A4;
        Document document = new Document(rect);

        iTextSharp.text.html.simpleparser.StyleSheet styles = new iTextSharp.text.html.simpleparser.StyleSheet();
        styles.LoadTagStyle("td", "abc", "10");
        document.SetPageSize(new Rectangle(815f, 930f));
        PdfWriter.GetInstance(document, HttpContext.Current.Response.OutputStream);
        PdfWriter.GetInstance(document, new FileStream(rootPath + "\\Quotation.pdf", FileMode.Create));

        //test code

        //end test code

        document.Open();
        styles.LoadTagStyle("td", "size", "10pt");
        styles.LoadTagStyle("th", "size", "12pt");
        //document.Add(new Paragraph("Hello Moon"));
        /* 
         * iterate over iText elements
         */

        //PdfContentByte cb = writer.DirectContent;
        //cb.BeginText();
        //cb.SetTextMatrix(100, 400);
        //cb.ShowText("Text at position 100,400.");


        List<IElement> ie = HTMLWorker.ParseToList(
          new StringReader(html), styles
        );
        /*
         * page width
         */
        float pageWidth = rect.Width;
        /*
         * look for PdfPTable(s)
         */
        foreach (IElement element in ie)
        {
            PdfPTable table = element as PdfPTable;
            /*
             * set the column widths
             */
            if (table != null)
            {
                table.SetWidthPercentage(
                  new float[] {
            (float).05 * pageWidth, 
            (float).06 * pageWidth, 
            (float).39 * pageWidth, 
            (float).05 * pageWidth, 
            (float).07 * pageWidth, 
            (float).08 * pageWidth, 
            (float).06 * pageWidth, 
            (float).06 * pageWidth, 
            (float).1 * pageWidth, 
            (float).08 * pageWidth
          },
                  rect
                );
            }
            document.Add(element);
        }
        document.Close();
    }

    #endregion

    # region Send Email

    public void SendEmail(string pTo, string pAttachmentPath)
    {
        try
        {
            StringBuilder sb = new StringBuilder();
            sb.Append("Respected Sir/Ma'am,");
            sb.Append("<br /><br />");
            sb.Append("Please find the attached Quotation, Thanks.");
            sb.Append("<br /><br /><br />");
            sb.Append(" Regards,");
            sb.Append("<br />");
            sb.Append("Mechatronix");
            sb.Append("<br />");
            sb.Append("www.mechatronix.com.pk");
            sb.Append("<br />");

            SmtpMail.SmtpServer = "mail.mechatronix.com.pk";
            MailMessage mail = null;

            mail = new MailMessage();
            //mail.Fields.Add("")
            MailAttachment attach = new MailAttachment(pAttachmentPath);
            mail.Attachments.Add(attach);
            mail.BodyFormat = MailFormat.Html;
            mail.To = "" + pTo + "";
            //mail.Cc = "ceo@mechatronix.com.pk";

            mail.Fields.Add("http://schemas.microsoft.com/cdo/configuration/smtpauthenticate", "1");    //basic authentication
            mail.Fields.Add("http://schemas.microsoft.com/cdo/configuration/sendusername", "info@mechatronix.com.pk"); //set your username here
            mail.Fields.Add("http://schemas.microsoft.com/cdo/configuration/sendpassword", "Mctx@123info");    //set your password here


            System.Net.NetworkCredential basicCrenntial = new System.Net.NetworkCredential("info@mechatronix.com.pk", "Mctx@123info");
            mail.Subject = "Quotation";
            mail.From = "info@mechatronix.com.pk";
            mail.Body = "" + sb + "";

            System.Net.Mail.SmtpClient emailClient = new System.Net.Mail.SmtpClient();
            emailClient.Host = "smtp.gmail.com";

            SmtpMail.Send(mail);
        }
        catch (Exception)
        {
            //throw;
        }
    }

    #endregion

    public Dictionary<string, string> GetFileList(string FolderUrl)
    {
        StringBuilder filesstring = new StringBuilder();
        WebResponse webResponse = null;
        StreamReader sreader = null;
        /// I use string type Dictionary to get both filename and filename with path
        Dictionary<string, string> Files = new Dictionary<string, string>();
        try
        {
            //you can change url to connect to ftp according to your need
            FtpWebRequest ftpRequest = ConnectToFtp(FolderUrl,
                           WebRequestMethods.Ftp.ListDirectory);

            webResponse = ftpRequest.GetResponse();
            sreader = new StreamReader(webResponse.GetResponseStream());
            string strline = sreader.ReadLine();
            while (strline != null)
            {
                //Add filename and filename with path to dictionary
                Files.Add(strline, FolderUrl + "/" + strline);

            }

            return Files;
        }
        catch (Exception ex)
        {
            //do any thing with exception
            return null;
        }
        finally
        {
            if (sreader != null)
            {
                sreader.Close();
            }
            if (webResponse != null)
            {
                webResponse.Close();
            }
        }
    }


    public FtpWebRequest ConnectToFtp(string SpecificPathOnFtpUrl, string Method)
    {
        FtpWebRequest ftpRequest = ConnectToFtp(SpecificPathOnFtpUrl, WebRequestMethods.Ftp.DeleteFile);
        //FtpWebRequest ftpRequest = (FtpWebRequest)FtpWebRequest.Create(new Uri(SpecificPathOnFtpUrl));
        ftpRequest.Timeout = 120000; // in milliseconds = 120 seconds 
        ftpRequest.UseBinary = true;
        ftpRequest.Credentials = new NetworkCredential("mechatronix.com.pk", "islamisbest", "mechatronix.com.pk");
        ftpRequest.Method = Method;
        //Method;

        ftpRequest.Proxy = null;
        ftpRequest.KeepAlive = false;
        ftpRequest.UsePassive = false;
        return ftpRequest;
    }

    //public void deletefile()
    //{
    //    // Get the object used to communicate with the server.
    //    FtpWebRequest request = (FtpWebRequest)WebRequest.Create("ftp://www.mechatronix.com.pk");
    //    request.Method = WebRequestMethods.Ftp.ListDirectoryDetails;

    //    // This example assumes the FTP site uses anonymous logon.
    //    request.Credentials = new NetworkCredential("mechatronix.com.pk", "islamisbest");

    //    FtpWebResponse response = (FtpWebResponse)request.GetResponse();

    //    Stream responseStream = response.GetResponseStream();
    //    StreamReader reader = new StreamReader(responseStream);
    //    Console.WriteLine(reader.ReadToEnd());

    //    //Console.WriteLine("Directory List Complete, status {0}", response.StatusDescription);

    //    reader.Close();
    //    response.Close();

    //}
}

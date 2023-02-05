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
using iTextSharp.text;
using iTextSharp.text.pdf;
using iTextSharp.text.html;
using iTextSharp.text.html.simpleparser;
using System.Text;
using System.Drawing;
using System.Threading;
using System.Net;
//using CrystalDecisions.CrystalReports.Engine;


public partial class MCTX_Internal_SuperAdmin_FrmQuotationsViewer : System.Web.UI.Page
{
    //static DataTable _dt = new DataTable();
    static string Quot_Id = "";

    protected void Page_Load(object sender, EventArgs e)
    {
        Quot_Id = Request.QueryString["QuotID"].ToString();
        if (!IsPostBack)
        {
            Quot_Id = Request.QueryString["QuotID"].ToString();
                GetQuotation();
            //    BindLabels();
        }
        try
        {
            //CRVAC.ReportSource = (ReportDocument)this.Session["Report"];
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
    public void GetQuotation()
      {
        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionstring2"].ToString()))
        {

            string cmd="SELECT cl.client_name, cl.client_designation, cl.client_dept,com.comp_name, "+
                        "ti.item_name, ti.model_no,ti.description,"+
                        "tqi.gst,(SELECT SUM(gst) AS gstt  FROM tbl_quot_item WHERE (quo_id = '" + Quot_Id + "')) AS sumgst," +
                        "tqi.gstPercent,tqi.item_quantity,tqi.Iunit, tqi.item_price,tqi.item_quantity * tqi.item_price AS totalprice,"+
                        "tqi.Price_type,Convert(Varchar(10),tq.quo_date,101) as quo_date, te.E_Name AS sale_per_name,"+
                        "te1.E_Name AS sal_manager_name,te2.E_Name AS tec_per_name,"+
                        "te.E_Mobile AS sale_mobile, te.E_Email AS sale_email,te1.E_Mobile AS man_mobile,te1.E_Email AS man_email, "+
                        "te2.E_Mobile AS tec_mobile,te2.E_Email AS tec_email,com.comp_address, cl.Client_mobile, cl.client_phone, cl.client_email,"+
                        "tq.subject, tq.customer_site,ti.item_code, co.country_name "+
                        "From tbl_quotation as tq Left Join tbl_quot_item as tqi on tq.quo_id = tqi.quo_id "+
                        "Left Join tbl_item as ti on tqi.item_id = ti.item_id "+
                        "Left Join country as co on ti.origin_id = co.country_id "+
                        "Left Join client as cl on tq.client_id = cl.client_id "+
                        "Left Join tbl_company as com on cl.comp_id = com.comp_id "+
                        "Left Join Tbl_employee as te on tq.sal_per_id = te.E_badge "+
                        "Left Join Tbl_employee as te1 on tq.manager_id = te1.E_badge "+
                        "Left Join Tbl_employee as te2 on tq.tech_per_id = te2.E_badge "+
                        "Left Join city as cy on cl.city_id = cy.city_id Where tqi.quo_id = '" + Quot_Id + "'";
            //string cmd = "SELECT cl.client_id,cl.client_name, cl.client_designation, cl.client_dept," +
            //             "com.comp_name, cy.city_name, ti.item_name, ti.model_no," +
            //             "ti.description,ti.image_url,ti.item_id, ti.Product_Image,tqi.qi_id as qitem_id,tqi.gst," +
            //             "(SELECT SUM(gst) AS gstt  FROM tbl_quot_item WHERE (quo_id = '" + Quot_Id + "')) AS sumgst," +
            //             "tqi.gstPercent,tqi.item_quantity,tqi.Iunit, tqi.item_price," +
            //             "tqi.item_quantity * tqi.item_price AS totalprice,tqi.cat_id,tqi.Price_type," +
            //             "Convert(Varchar(10),tq.quo_date,101) as quo_date, tq.quo_id AS quot_id," +
            //             "te.E_Name AS sale_per_name,te1.E_badge as mangId, te1.E_Name AS sal_manager_name,te2.E_badge as tecPerId," +
            //             "te2.E_Name AS tec_per_name," +
            //             "te.E_Mobile AS sale_mobile, te.E_Email AS sale_email," +
            //             "te1.E_Mobile AS man_mobile," +
            //             "te1.E_Email AS man_email, te2.E_Mobile AS tec_mobile," +
            //             "te2.E_Email AS tec_email," +
            //             "com.comp_address, cl.Client_mobile, cl.client_phone, cl.client_email," +
            //             "tq.subject, tq.customer_site," +
            //             "ti.item_code, co.country_name " +
            //             "From tbl_quotation as tq " +
            //             "Left Join tbl_quot_item as tqi on tq.quo_id = tqi.quo_id " +
            //             "Left Join tbl_item as ti on tqi.item_id = ti.item_id " +
            //             "Left Join country as co on ti.origin_id = co.country_id " +
            //             "Left Join client as cl on tq.client_id = cl.client_id " +
            //             "Left Join tbl_company as com on cl.comp_id = com.comp_id " +
            //             "Left Join Tbl_employee as te on tq.sal_per_id = te.E_badge " +
            //             "Left Join Tbl_employee as te1 on tq.manager_id = te1.E_badge " +
            //             "Left Join Tbl_employee as te2 on tq.tech_per_id = te2.E_badge " +
            //             "Left Join city as cy on cl.city_id = cy.city_id " +
            //             "Where tqi.quo_id = '" + Quot_Id + "'";
            SqlDataAdapter DA = new SqlDataAdapter(cmd, cn);
            DataTable dt = new DataTable();
            //ReportDocument rptDoc = new ReportDocument();
            //DA.Fill(dt);
            //rptDoc.Load(Server.MapPath(@"~/MCTX_Internal/SuperAdmin/QuotationViewer.rpt"));
            //rptDoc.SetDataSource(dt);
           // this.Session["Report"] = rptDoc;
            //CRVAC.ReportSource = rptDoc;
        }
    }
    //public void BindLabels()
    //{
    //    lblAttention.Text = _dt.Rows[0]["client_name"].ToString();
    //    lblDesg.Text = _dt.Rows[0]["client_designation"].ToString();
    //    lblDept.Text = _dt.Rows[0]["client_dept"].ToString();
    //    lblOrganisation.Text = _dt.Rows[0]["comp_name"].ToString();
    //    lblContact.Text = _dt.Rows[0]["Client_mobile"].ToString();
    //    //lblFax.Text = _dt.Rows[0][""].ToString();
    //    lblEmail.Text = _dt.Rows[0]["client_email"].ToString();
    //    //lblNoofPages.Text = _dt.Rows[0][""].ToString();
    //    lblDate.Text = _dt.Rows[0]["quo_date"].ToString();
    //    lblTechPerson.Text = _dt.Rows[0]["tec_per_name"].ToString();
    //    lblRefContact.Text = _dt.Rows[0]["tec_mobile"].ToString();
    //    lblOffEmail.Text = "info@mechatronix.com.pk";
    //    lblRefFax.Text = "051-2872-811";
    //    lblSalesRepEmail.Text = _dt.Rows[0]["sale_email"].ToString();
    //    lblTitle.Text = _dt.Rows[0]["subject"].ToString();
    //}

    //[WebMethod]
    //public static Dictionary<string, object> GetQuotation()
    //{
    //    using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionstring2"].ToString()))
    //    {
    //        SqlCommand cmd = new SqlCommand("QuotData", cn);
    //        cmd.CommandType = CommandType.StoredProcedure;
    //        cn.Open();
    //        cmd.Parameters.Add("@quot_id", Convert.ToInt32(Quot_Id));
    //        SqlDataAdapter DA = new SqlDataAdapter(cmd);
    //        DataSet ds = new DataSet();
    //        DA.Fill(ds, "GetQuotation");
    //        DataTable dt = new DataTable();
    //        dt = ds.Tables["GetQuotation"];
    //        _dt = dt;
    //        return ToJson(dt);
    //    }

    //}
    //protected void btnExcel_Click(object sender, EventArgs e)
    //{
    //    string html = HdnValue.Value;
    //    ExportToExcel(ref html, "Quotation (Mechatronix)");
    //}
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

    ////protected void process(object sender, CommandEventArgs e)
    ////{
    ////    Response.ContentType = "application/pdf";
    ////    Response.AppendHeader("Content-Disposition", "attachment; filename=table.pdf");
    ////    var doc = new Document();
    ////    PdfWriter.GetInstance(doc, Response.OutputStream);
    ////    doc.Open();
    ////    var html = new StringBuilder();
    ////    var stringWriter = new StringWriter(html);
    ////    var htmlWriter = new HtmlTextWriter(stringWriter);
    ////    tblExport.RenderControl(htmlWriter);
    ////    var interfaceProps = new Dictionary<string, Object>();

    ////    var ih = new ImageHander() { BaseUri = Request.Url.ToString() };
    ////    interfaceProps.Add(HTMLWorker.IMG_PROVIDER, ih);
    ////    foreach (IElement element in HTMLWorker.ParseToList(
    ////        new StringReader(html.ToString()), null, interfaceProps))
    ////    {
    ////        doc.Add(element);
    ////    }
    ////    doc.Close();
    ////    Response.End();
    ////}

    ////public class ImageHander : IImageProvider
    ////{
    ////    public string BaseUri = "www.google.com";
    ////    public iTextSharp.text.Image GetImage(string src,
    ////        // iTextSharp 5.0.6 or higher
    ////        IDictionary<string, string> h,
    ////        // iTextSharp 5.0.0 to 5.0.5
    ////        // Dictionary<string, string> h,
    ////        ChainedProperties cprops,
    ////        IDocListener doc)
    ////    {
    ////        /*
    ////         * !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
    ////         * HTMLWorker does **NOT** understand relative URLs, make it absolute
    ////         * !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
    ////         */
    ////        return iTextSharp.text.Image.GetInstance(HttpContext.Current.Server.MapPath(new Uri(new Uri(BaseUri), src).AbsolutePath));
    ////        /*
    ////         * next line works too; absolute URL
    ////         */
    ////        // new Uri(new Uri(BaseUri), src)

    ////    }
    ////}

    ////public void ExportToPDF()
    ////{
    ////    // Saving an XLS file in Aspose.Pdf xml format
    ////    Workbook wb = new Workbook();
    ////    wb.Open("C:\\book1.xls);
    ////    wb.Save("C:\\xls2pdf.xml", FileFormatType.AsposePdf);

    ////    // Converting XLS file to PDF through Aspose.Pdf using Aspose.Pdf xml file as a medium
    ////    Aspose.Pdf.Pdf pdf = new Aspose.Pdf.Pdf();
    ////    pdf.BindXML("c:\\xls2pdf.xml", null);
    ////    pdf.Save("C:\\xls2pdf.pdf");
    ////}


    ////protected void Button1_Click(object sender, EventArgs e)
    ////{
    ////    Response.ContentType = "application/pdf";
    ////    Response.AddHeader("content-disposition", "attachment;filename=GridViewExport.pdf");
    ////    Response.Cache.SetCacheability(HttpCacheability.NoCache);
    ////    string html = HdnValue.Value;
    ////    StringWriter sw = new StringWriter();
    ////    HtmlTextWriter hw = new HtmlTextWriter(sw);
    ////    //GridView1.AllowPaging = false;
    ////    //GridView1.DataBind();
    ////    //GridView1.RenderControl(hw);
    ////    hw.Write(html);
    ////    StringReader sr = new StringReader(sw.ToString());
    ////    Document pdfDoc = new Document(PageSize.A4, 10f, 10f, 10f, 0f);
    ////    HTMLWorker htmlparser = new HTMLWorker(pdfDoc);
    ////    PdfWriter.GetInstance(pdfDoc, Response.OutputStream);
    ////    pdfDoc.Open();
    ////    htmlparser.Parse(sr);
    ////    pdfDoc.Close();
    ////    Response.Write(pdfDoc);
    ////    Response.End();

    ////    //GridView grdTemp = new GridView();
    ////    //grdTemp.DataSource = GetFirstTable();
    ////    //grdTemp.DataBind();
    ////    //HtmlForm form = new HtmlForm();
    ////    //form.Controls.Add(grdTemp);
    ////}
    //protected void Button1_Click1(object sender, EventArgs e)
    //{
    //    //saveURLToImage("http://google.com.pk/");
    //}

    //public void abc()
    //{
    //    //panelmain.Controls.Add(abc);
    //    //panelmain.Controls.Add(grid1);


    //    string toexport;
    //    toexport = HdnValue.Value;
    //    //toexport = RenderControl();

    //    ImageFormatConverter imgc = new ImageFormatConverter();
    //    System.Drawing.Image convertedimage;
    //    convertedimage = (System.Drawing.Image)imgc.ConvertFromString(toexport);
    //    Response.ContentType = "image/jpg";
    //    Response.AppendHeader("Content-Disposition", "inline;filename=tm.jpeg");
    //    Response.BufferOutput = true;
    //    Response.Charset = "utf-8";
    //    Response.Write(convertedimage);
    //    Response.End();
    //    //form1.Controls.Add(abc);
    //}
    //public string RenderControl(Control ctrl)
    //{
    //    StringBuilder sb = new StringBuilder();
    //    StringWriter tw = new StringWriter(sb);
    //    HtmlTextWriter hw = new HtmlTextWriter(tw);
    //    ctrl.RenderControl(hw);
    //    Response.Write(sb);
    //    return sb.ToString();
    //}

    //private void saveURLToImage(string url)
    //{
    //    if (!string.IsNullOrEmpty(url))
    //    {


    //        //string content = "";

    //        //System.Net.WebRequest webRequest = WebRequest.Create(url);
    //        //System.Net.WebResponse webResponse = webRequest.GetResponse();
    //        //System.IO.StreamReader sr = new StreamReader(webResponse.GetResponseStream(), System.Text.Encoding.GetEncoding("UTF-8"));

    //        //content = sr.ReadToEnd();


    //        ////save to file
    //        ////byte[] b = System.Text.Encoding.UTF8.GetBytes(content);
    //        ////byte[] b = Convert.FromBase64String(content);

    //        ////byte[] b = Convert.FromBase64String(FixBase64ForImage(content));
    //        //byte[] b = Encoding.UTF8.GetBytes(content);

    //        ////byte[] _buf = (byte[])_cmd.ExecuteScalar(); //where your image save as blob in SQL server
    //        //Response.ContentType = "image/gif";
    //        //Response.BinaryWrite(b);


    //        //System.IO.MemoryStream ms = new System.IO.MemoryStream(b);
    //        //System.Drawing.Image img = System.Drawing.Image.FromStream(ms);
    //        //img.Save(@"c:\pic.jpg", System.Drawing.Imaging.ImageFormat.Jpeg);

    //        //img.Dispose();
    //        //ms.Close();
    //    }
    //}

    //public string FixBase64ForImage(string Image)
    //{
    //    System.Text.StringBuilder sbText = new System.Text.StringBuilder(Image, Image.Length);
    //    sbText.Replace("\r\n", String.Empty);
    //    sbText.Replace(" ", String.Empty);
    //    sbText.Replace("\0", String.Empty);
    //    return sbText.ToString();
    //}
}

using System;
using System.Collections;
using System.Collections.Generic;
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
using Sales_BOL;
using Microsoft.Reporting.WebForms;
using System.Web.Mail;
using System.Net;
using System.IO;
using System.Text;

public partial class MCTX_Internal_SuperAdmin_rptQuotation : System.Web.UI.Page
{
    #region Variables
    _Quotation objQuot = new _Quotation();
    string filename = null;
    #endregion

    #region Methods
    public void ShowReport(DataSet dsQuotData)
    {
        ReportViewer1.LocalReport.DataSources.Clear();
        ReportViewer1.LocalReport.ReportPath = Server.MapPath(@"QuotReport.rdlc");
        ReportDataSource RptDsrc = new ReportDataSource("QuotDataSet_QuotData", dsQuotData.Tables[0]);
        ReportViewer1.LocalReport.DataSources.Add(RptDsrc);
        ReportViewer1.LocalReport.Refresh();
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
        }
        catch (Exception ex)
        {

        }
        try
        {
            if (!IsPostBack)
            {
                ReportViewer1.LocalReport.EnableExternalImages = true;
                //List<ReportParameter> param1 = new List<ReportParameter>();
                //param1.Add(new ReportParameter("Path", Request.Url.AbsoluteUri.Replace(Request.Url.AbsolutePath, "" + @"images1/Quotation.png")));
                //ReportViewer1.LocalReport.SetParameters(param1);
                int quotId = int.Parse(Request.QueryString["QuotID"].ToString());
                DataSet dsQuotData = objQuot.fnGetQuotData(quotId);
                ShowReport(dsQuotData);
            }
        }
        catch (Exception ex)
        {

        }
    }
    protected void btnBack_Click(object sender, EventArgs e)
    {
        Response.Redirect("frmQuotations.aspx");
    }
    #endregion



    protected void btnEmail_Click(object sender, EventArgs e)
    {
        ExportReportToPDF("Quotation.pdf");
        if (txtEmail.Text.Trim() != "")
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

            SendEmail("mctxdata@gmail.com", "Mechatronix", "" + txtEmail.Text.Trim() + "", "Quotation", "" + sb + "", MailFormat.Html, "" + filename + "");
        }
        else
        {
            lblEmail.Visible = true;
            lblEmail.Text = "Please Enter Email!";
            lblEmail.ForeColor = System.Drawing.Color.Red;
        }
        //SendMailMessage("tahrikazmi897@gmail.com", "sardarubaid@hotmail.com", "", "", "Test", ""+tblReport+"");
    }

    #region Export To PDF 

    private void ExportReportToPDF(string reportName)
    {
        Warning[] warnings;
        string[] streamids;
        string mimeType;
        string encoding;
        string filenameExtension;
        byte[] bytes = ReportViewer1.LocalReport.Render(
            "PDF", null, out mimeType, out encoding, out filenameExtension,
             out streamids, out warnings);

        filename = Path.Combine(Path.GetTempPath(), reportName);
        using (var fs = new FileStream(filename, FileMode.Create))
        {


            fs.Write(bytes, 0, bytes.Length);
            fs.Close();
        }

        //return filename;


        //SmtpMail.SmtpServer = "mail.mechatronix.com.pk";
        //MailMessage mail = null;



        //mail = new MailMessage();
        ////mail.Fields.Add("")
        //MailAttachment attach = new MailAttachment(filename);
        //mail.Attachments.Add(attach);
        //mail.BodyFormat = MailFormat.Html;
        //mail.To = "sardarubaid@gmail.com";
        ////mail.Cc = "khalidrafique@mechatronix.com.pk";

        //mail.Fields.Add
        //        ("http://schemas.microsoft.com/cdo/configuration/smtpserver",
        //                      "smtp.gmail.com");
        //mail.Fields.Add
        //        ("http://schemas.microsoft.com/cdo/configuration/smtpserverport",
        //                      "465");
        //mail.Fields.Add
        //    ("http://schemas.microsoft.com/cdo/configuration/sendusing",
        //                "2");

        //System.Net.NetworkCredential basicCrenntial = new System.Net.NetworkCredential("info@mechatronix.com.pk", "manager");
        //mail.Subject = "Quotation";
        //mail.From = "info@mechatronix.com.pk";
        //mail.Body = "Test Body";

        //SmtpMail.Send(mail);
    }

#endregion


    # region Send Email

    public void SendEmail(string pGmailEmail, string pGmailPassword, string pTo, string pSubject, string pBody,System.Web.Mail.MailFormat pFormat,string pAttachmentPath)
    {
        lblEmail.Visible = false;
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
            MailAttachment attach = new MailAttachment(filename);
            mail.Attachments.Add(attach);
            mail.BodyFormat = MailFormat.Html;
            mail.To = ""+pTo+"";
            mail.Cc = "ceo@mechatronix.com.pk";

            mail.Fields.Add("http://schemas.microsoft.com/cdo/configuration/smtpauthenticate", "1");    //basic authentication
            mail.Fields.Add("http://schemas.microsoft.com/cdo/configuration/sendusername", "info@mechatronix.com.pk"); //set your username here
            mail.Fields.Add("http://schemas.microsoft.com/cdo/configuration/sendpassword", "manager");    //set your password here


            System.Net.NetworkCredential basicCrenntial = new System.Net.NetworkCredential("info@mechatronix.com.pk", "manager");
            mail.Subject = "Quotation";
            mail.From = "info@mechatronix.com.pk";
            mail.Body = ""+sb+"";

            System.Net.Mail.SmtpClient emailClient = new System.Net.Mail.SmtpClient();
            emailClient.Host="smtp.gmail.com";
            
            SmtpMail.Send(mail);
            lblEmail.Visible = true;
            lblEmail.Text = "Quotation has been sent!";


          //  System.Web.Mail.MailMessage myMail = new System.Web.Mail.MailMessage();
          //  myMail.Fields.Add
          //      ("http://schemas.microsoft.com/cdo/configuration/smtpserver",
          //                    "smtp.gmail.com");
          //  myMail.Fields.Add
          //      ("http://schemas.microsoft.com/cdo/configuration/smtpserverport",
          //                    "465");
          //  myMail.Fields.Add
          //      ("http://schemas.microsoft.com/cdo/configuration/sendusing",
          //                  "2");
            

          //  myMail.Fields.Add
          //("http://schemas.microsoft.com/cdo/configuration/smtpauthenticate", "1");
          //  // Use 0 for anonymous
          //  myMail.Fields.Add
          //  ("http://schemas.microsoft.com/cdo/configuration/sendusername",
          //      pGmailEmail);
          //  myMail.Fields.Add
          //  ("http://schemas.microsoft.com/cdo/configuration/sendpassword",
          //       pGmailPassword);
          //  myMail.Fields.Add
          //  ("http://schemas.microsoft.com/cdo/configuration/smtpusessl",
          //       "true");
            
          //  myMail.From = pGmailEmail;
          //  myMail.To = pTo;
          //  myMail.Bcc = "khalidaries2007@gmail.com";
          //  myMail.Subject = pSubject;
          //  myMail.BodyFormat = pFormat;

          //  myMail.Body = pBody;
          //  myMail.Priority = MailPriority.High;
          //  if (pAttachmentPath.Trim() != "")
          //  {
          //      MailAttachment MyAttachment =new MailAttachment(pAttachmentPath);
          //      myMail.Attachments.Add(MyAttachment);
          //      myMail.Priority = System.Web.Mail.MailPriority.High;
          //  }

          //  System.Web.Mail.SmtpMail.SmtpServer = "smtp.gmail.com:465";
          //  System.Web.Mail.SmtpMail.Send(myMail);
          //  lblEmail.Visible = true;
          //  //return true;
        }
        catch (Exception ex)
        {
            lblEmail.Text = "Please Enter Valid Email Id!";
            throw;
        }
    }

    #endregion
}

using System;
using System.Data;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Xml.Linq;
using System.Linq;
using System.Net.Mail;
using System.Text;
using System.Data.SqlClient;


public partial class MCTX_Internal_SuperAdmin_EmailMarketing : System.Web.UI.Page
{
    string userid = "";                                                         //Obaid Altaf June 11, 2012
    protected void Page_Load(object sender, EventArgs e)
    {
        //userid = Profile.UserID;
        userid = Session["Username"].ToString(); 
    }
    
    # region Send Email

    public void SendEmail(string To, string Subject, string AttachmentPath, string Message)
    {
        try
        {
            DivError.Visible = false;
            Confirmation.Visible = false;
            StringBuilder sb = new StringBuilder();
            sb.Append("<table width='770' cellspacing='0' cellpadding='0' border='0' align='center' style='border: 0px;"+
            "border-left: 1px solid #cccccc; border-right: 1px solid #cccccc; background-color: #ffffff'"+
            "class='ecxouter frame'>"+
            "<tbody>"+
                "<tr>"+
                   " <td>"+
                        "<a target='_blank' style='border: none; color: #0084b4; text-decoration: none' href='www.mechatronix.com.pk'>" +
                            "<span class='ecxmedia_logo_div'></span></a>"+
                        "<table width='770' cellspacing='0' cellpadding='0' border='0' style='background-color: #f2f2f2' " +
                            "class='header frame'> "+
                            "<tbody>"+
                                
                                "<tr>"+
                                    "<td style='border-top: 1px solid #dddddd; background-color: #ffffff' class='ecxmain ecxheader_drop ecxcut'>"+
                                       " &nbsp;"+
                                    "</td>"+
                                    "<td style='border-top: 1px solid #dddddd; background-color: #ffffff' class='ecxmain ecxheader_drop ecxcut'>"+
                                       " &nbsp;"+
                                    "</td>"+
                                    "<td height='17' style='border-top: 1px solid #dddddd; background-color: #ffffff'"+
                                      "  class='ecxmain ecxheader_drop ecxmedia_header'>"+
                                       " <img width='1' height='1' src='http://mechatronix.com.pk/images/Mechatronix.png'" +
                                           " style='display: block; border: 0'>"+
                                    "</td>"+
                                    "<td height='17' style='border-top: 1px solid #dddddd; background-color: #ffffff'"+
                                    "    colspan='2' class='ecxmain ecxheader_drop ecxcut'>"+
                                    "    &nbsp;"+
                                    "</td>" +
                               " </tr>"+
                           " </tbody>"+
                        "</table>"+
                   " </td>"+
                   " <td rowspan='3'>"+
                   " </td>"+
                "</tr>"+
               " <tr>"+
                   " <td>"+
                    "    <table width='770' cellspacing='0' cellpadding='0' border='0' style='background-color: #ffffff'" +
                          "  class='ecxmain frame'>"+
                           " <tbody>"+
                             "   <tr>"+
                             "       <td style='width: 40px' class='col ecxcut'>"+
                               "     </td>"+
                                "    <td class='ecxmedia_main'>"+
                                   "     <table cellspacing='0' cellpadding='0' border='0'>"+
                                 "           <tbody>"+
                                    "            <tr>"+
                                                  "  <td style='padding: 10px; font-family: 'Helvetica Neue', Helvetica, Arial, sans-serif;"+
                                                      "  color: #333333; padding-bottom: 0; font-size: 15px; line-height: 20px' class='ecxmid ecxtext'>"+
                                                    "" + Message + "</td>" +
                                                " </tr>"+
                                                " <tr>"+
                                                "     <td height='20'>"+
                                                 "    </td>"+
                                               "  </tr>"+
                                          "   </tbody>"+
                                      "   </table>"+
                                   "  </td>"+
                                  "   <td style='width: 50px' class='col ecxcut'>"+
                                   "  </td>"+
                                " </tr>"+
                           "  </tbody>"+
                       "  </table>"+
                   "  </td>"+
               "  </tr>"+
               "  <tr>"+
                "     <td>"+
                      "   <table width='770' cellspacing='0' cellpadding='0' border='0' style='background-color: #eeeeee'" +
                         "    class='frame footer'>"+
                         "    <tbody>"+
                            "     <tr>"+
                                "     <td height='28' style='border-top: 1px solid #dddddd' class='ecxfooter-padding-top'"+
                                "         colspan='3'>"+
                                 "    </td>"+
                              "   </tr>"+
                               "  <tr>"+
                                 "    <td style='width: 75px' class='col ecxcut'>"+
                                 "    </td>"+
                                  "   <td style='font-family: 'Helvetica Neue', Helvetica, Arial, sans-serif; font-size: 12px;"+
                                    "     line-height: 17px; color: #777; text-shadow: 0 1px 0 #ffffff' class='ecxfooter_body ecxmedia_footer'>"+
                                     "    <div>"+
                                        "     Mechatronix <a target='_blank' style='border: none; color: #0084b4;"+
                                         "        text-decoration: none' href='www.mechatronix.com.pk'" +
                                          "       class='ecxreset'>Get the detailed information about the company.</a>"+
                                        " </div>"+
                                       "  <div>"+
                                       "      <span style='border: none; color: #0084b4; text-decoration: none; font-family: 'Helvetica Neue', Helvetica, Arial, sans-serif;"+
                                        "         text-decoration: none; font-size: 11px; line-height: 17px; color: #999999; text-shadow: 0 1px 0 #ffffff'"+
                                        "         class='address'>Mechatronix, Head office: Plot No 169, Street # 9, Industrial Area I-10/3,<span style='white-space: nowrap'"+
                                        "             class='ecxnobreak'>Islamabad, Pakistan.</span></span>" +
                                       "  </div>"+
                                   "  </td>"+
                                   "  <td style='width: 75px' class='col ecxcut'>"+
                                  "   </td>"+
                               "  </tr>"+
                              "   <tr>"+
                                 "    <td height='25' class='ecxfooter-padding-bottom' colspan='3'>"+
                                  "   </td>"+
                                " </tr>"+
                            " </tbody>"+
                       "  </table>"+
                    " </td>"+
              "   </tr>"+
            "</tbody>"+
        " </table>");
            To= To.Replace('\n',' ');
            To = To.Replace('\r', ' ');
            string[] Addresses;
            Addresses = To.Split(';');
            Confirmation.Visible = false;
            MailMessage mail = new MailMessage();

            if (Addresses.Length > 1)
            {
                DivError.Visible = true;
            }
            else
            {
                for (int i = 0; i < Addresses.Length; i++)
                {
                    if (Addresses[i].Trim() != "" && Addresses[i] != string.Empty)
                    {
                        mail.To.Add(Addresses[i].Trim());
                    }
                }
                mail.From = new MailAddress("info@mechatronix.com.pk");
                //string cc1 = "tahirkazmi897@gmail.com";
               // mail.CC.Add(cc1);
                mail.CC.Add("info@mechatronix.com.pk");
                mail.Bcc.Add("ceo@mechatronix.com.pk");
                mail.Bcc.Add("it@mechatronix.com.pk");
                mail.Subject = Subject;
                
                mail.Body = sb.ToString();
                mail.IsBodyHtml = true;
               
                //Attach file using FileUpload Control and put the file in memory stream
                if (fuAttachment.HasFile)
                {
                    mail.Attachments.Add(new Attachment(fuAttachment.PostedFile.InputStream, fuAttachment.FileName));
                }
                SmtpClient smtp = new SmtpClient();
                smtp.Host = "mail.mechatronix.com.pk";

                System.Net.NetworkCredential BasicAuthenticationInfo = new System.Net.NetworkCredential("info@mechatronix.com.pk", "Mctx@123info");
                smtp.Timeout = 600000;
                smtp.UseDefaultCredentials = false;
                smtp.Credentials = BasicAuthenticationInfo;
                smtp.EnableSsl = false;
                smtp.Send(mail);
                Confirmation.Visible = true;
            }
        }
        catch (Exception ex)
        {
            //throw;
        }
    }

    #endregion
    protected void btnSendEmail_Click(object sender, EventArgs e)
    {
        SendEmail(txtTo.Text, txtSubject.Text, "", CKEditor1.Text);
        InsertEmail(txtTo.Text.Trim(), "ceo@mechatronix.com.pk", txtSubject.Text.Trim().Replace("'", ""), CKEditor1.Text.Trim().Replace("'", ""), fuAttachment.PostedFile.FileName, fuAttachment.PostedFile.ContentLength, userid);
        txtTo.Text = "";
        txtSubject.Text = "";
        CKEditor1.Text = "";
    }

    //Not saving Message because it contains HTML tags and also consumes alot of database space
    public int InsertEmail(string To, string CC, string Subject, string Message,string Attachment_Name,int AttachmentSize, string User)
    {
        int result = 0;
        using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionstring2"].ToString()))
        {
            string query = "INSERT INTO tbl_EmailMarketing ([To_Address],[CC_Address],[Subject],Attachment_Name,Attachment_Size,[Date],[UserId]) " +
                            " VALUES('"+To+"','"+CC+"','"+Subject+"','"+Attachment_Name+"','"+AttachmentSize+"','"+DateTime.Now+"','"+User+"')";
            cn.Open();
            SqlCommand cmd = new SqlCommand(query, cn);
            result=cmd.ExecuteNonQuery();
        }
        return result;
    }
}

using System;
using System.Collections;
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

public partial class MCTX_Internal_SuperAdmin_frmChangePassword : System.Web.UI.Page
{

    _changepassword BL = new _changepassword();
    
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
            if (role == "Super Admin" || role == "Admin")
            {
                ddluserids.Enabled = true;

                if (!IsPostBack)
                {

                    ddlGetuserid();
                    ddluserids_SelectedIndexChanged(null, null);
                }

                txt_oldpassword.Enabled = false;
                txt_oldpassword.Text = "No Need";


            }
            else
            {
                

                if (!IsPostBack)
                {
                    ddluserids.Items.Add(Session["Username"].ToString());
                    ddluserids.SelectedIndex = 0;
                    txtuserName.Text = Session["UserFullName"].ToString();
                    ddluserids.Enabled = false;
                    txt_oldpassword.Enabled = true;
                }
            }

            
        }
        catch (Exception ex)
        { }
        try
        {

        }
        catch (Exception ex)
        {
            if (!IsPostBack)
            {

            }
        }
    }
    public void ddlGetuserid()
    {
        BL.getUserid();
        ddluserids.DataSource = BL.dt_userid;
        ddluserids.DataTextField = "user_id";
        ddluserids.DataBind();

    
    }
    protected void ddluserids_SelectedIndexChanged(object sender, EventArgs e)
    {
        BL.GETusername(ddluserids.SelectedItem.Text);
        txtuserName.Text = BL.dt_username.Rows[0][0].ToString();
    }

    protected void btn_update_Click(object sender, EventArgs e)
    {
        try
        {

            if (txt_oldpassword.Enabled)
            {
                string pass = txt_oldpassword.Text.GetHashCode().ToString();
                if (pass != Session["UserPass"].ToString())
                {
                    lbl_MSG.Text = "Old Password does not match";
                    lbl_MSG.ForeColor = System.Drawing.Color.Red;
                    return;
                }
            }

            if (txtnewPassword.Text != "")
            {
                if (txtnewPassword.Text != txtconfirmPassword.Text)
                {
                    lbl_MSG.Text = "New password and confirm password  do not match";
                    lbl_MSG.ForeColor = System.Drawing.Color.Red;
                    return;
                }
            }
            else
            {
                lbl_MSG.Text = "Enter new password";
                lbl_MSG.ForeColor = System.Drawing.Color.Red;
                return;
            
            }


            int inserted = BL.updatepassword(ddluserids.SelectedItem.Text, txtnewPassword.Text.GetHashCode().ToString());

            if (inserted == 1)
            {
                lbl_MSG.Text = "Password updated successfully";
                lbl_MSG.ForeColor = System.Drawing.Color.Green;
                return;

            }
            else
            {
                lbl_MSG.Text = "Password can not be changed";
                lbl_MSG.ForeColor = System.Drawing.Color.Red;
                return;
            
            }



            



        }
        catch (Exception ex)
        { }
    }
}

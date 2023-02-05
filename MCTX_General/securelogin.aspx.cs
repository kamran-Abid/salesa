using System;
using System.Configuration;
using System.Data;
using Sales_BOL;
using System.Data.SqlClient;

public partial class MCTX_General_securelogin : System.Web.UI.Page
{
    #region Variables
    _Login BL_login = new Sales_BOL._Login();
    DataSet ds_userinfo = new DataSet();
    DataTable dt_userinfo = new DataTable();
    //private ProfileCommon _PC;

    #endregion
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Request.QueryString["userID"] != null)
        {
            string userName = Request.QueryString["userID"].ToString();
            BL_login.userAuthViaWebLogin(userName);

            dt_userinfo = BL_login.ds_User.Tables["UserViaWebLogin"];

            if (dt_userinfo.Rows[0]["user_id"].ToString() == userName)
            {
                Session["EmployeeID"] = dt_userinfo.Rows[0]["employeeID"].ToString();
                Session["Username"] = dt_userinfo.Rows[0]["user_id"].ToString();
                Response.Cookies["Username"].Value = dt_userinfo.Rows[0]["user_id"].ToString();
                Response.Cookies["Username"].Expires = DateTime.Now.AddHours(3);
                Session["Role"] = dt_userinfo.Rows[0]["role_name"].ToString();
                Response.Cookies["Role"].Value = dt_userinfo.Rows[0]["role_name"].ToString();
                Response.Cookies["Role"].Expires = DateTime.Now.AddHours(3);
                Session["UserFullName"] = dt_userinfo.Rows[0]["E_name"].ToString();
                Response.Cookies["UserFullName"].Value = dt_userinfo.Rows[0]["E_name"].ToString();
                Response.Cookies["UserFullName"].Expires = DateTime.Now.AddHours(3);
                Session["UserPass"] = dt_userinfo.Rows[0]["user_pwd"].ToString();
                Response.Cookies["UserPass"].Value = dt_userinfo.Rows[0]["user_pwd"].ToString();
                Response.Cookies["UserPass"].Expires = DateTime.Now.AddHours(3);
                Response.Redirect("../MCTX_Internal/SuperAdmin/Welcome.aspx");
            }
        }
        //else if (Session["Username"] != null)
        //{
        //    Response.Redirect("../MCTX_Internal/SuperAdmin/Welcome.aspx");
        //}
    }

    protected void btn_login_Click(object sender, EventArgs e)
    {
        try
        {

            BL_login.user_atuhentication(username.Text, password.Text.GetHashCode().ToString());
            if (BL_login.ds_User.Tables["User_information"].Rows.Count < 1)
            {
                lbl_Msg.Text = "*Enter correct credentials:";// mubashir
                return;
            }
            dt_userinfo = BL_login.ds_User.Tables["User_information"];
            //modified by khalid 05-06-2010
            //modified by khalid 01-04-2011
            string pass = password.Text.GetHashCode().ToString();
            string d_pass = dt_userinfo.Rows[0]["user_pwd"].ToString();
            if (dt_userinfo.Rows[0]["user_id"].ToString() == username.Text && d_pass == pass)
            {
                Session["EmployeeID"] = dt_userinfo.Rows[0]["employeeID"].ToString();
                string EmployeeID = Session["EmployeeID"].ToString();
                Session["Username"] = dt_userinfo.Rows[0]["user_id"].ToString();
                Response.Cookies["Username"].Value = dt_userinfo.Rows[0]["user_id"].ToString();
                Response.Cookies["Username"].Expires = DateTime.Now.AddHours(3);
                Session["Role"] = dt_userinfo.Rows[0]["role_name"].ToString();
                Response.Cookies["Role"].Value = dt_userinfo.Rows[0]["role_name"].ToString();
                Response.Cookies["Role"].Expires = DateTime.Now.AddHours(3);
                Session["UserFullName"] = dt_userinfo.Rows[0]["E_name"].ToString();
                Response.Cookies["UserFullName"].Value = dt_userinfo.Rows[0]["E_name"].ToString();
                Response.Cookies["UserFullName"].Expires = DateTime.Now.AddHours(3);
                Session["UserPass"] = dt_userinfo.Rows[0]["user_pwd"].ToString();
                Response.Cookies["UserPass"].Value = dt_userinfo.Rows[0]["user_pwd"].ToString();
                Response.Cookies["UserPass"].Expires = DateTime.Now.AddHours(3);
                Response.Redirect("../MCTX_Internal/SuperAdmin/Welcome.aspx");

            }
        }
        catch (Exception ex)
        {
            lbl_Msg.Text = ex.Message.ToString(); 

        }
    }

    protected void Login()
    {
        if (!String.IsNullOrEmpty(username.Text.Trim()) && !String.IsNullOrEmpty(password.Text))
        {
            string strUsername = username.Text.Trim().Replace("'", "");
            string strUserpass = password.Text.Replace("'", "");// txt_Password.Text.GetHashCode().ToString();//
            //string strIPAddress = IP();

            if (ValidateUser(strUsername, strUserpass.GetHashCode().ToString()) == 1)
            {
                //if (!System.Web.Security.Membership.ValidateUser(strUsername, strUserpass))
                //{
                //    try
                //    {
                //        System.Web.Security.MembershipUser user = System.Web.Security.Membership.CreateUser(strUsername, strUserpass);
                //    }
                //    catch (Exception ex) { throw ex; }
                //}

                //_PC = UpdateUserProfile(strUsername);
                //System.Web.Security.FormsAuthentication.RedirectFromLoginPage(_PC.UserName, false);
                //Response.Redirect("../MCTX_Internal/SuperAdmin/Welcome.aspx");
            }
            else
            {
                lbl_Msg.Text = "Invalid User"; 
                lbl_Msg.Visible = true;
            }
        }
    }

    protected int ValidateUser(string userID, string password)
    {
        int valid = 0;
        try
        {
            using (SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["connectionstring2"].ToString()))
            {
                DataTable dt = new DataTable();
                DataSet ds = new DataSet();
                cn.Open();
                string query = "select u.user_id,u.user_pwd,u.role_id,te.E_name," +
                               "u.Status,u.logName,r.role_id,r.role_name from user1 as u " +
                               "join tbl_role as r on u.role_id=r.role_id " +
                               "join tbl_Employee as te on u.E_badge = te.E_badge " +
                               "where u.user_id = '" + userID + "'" +
                               "and u.status <> 3 " +
                               "and u.user_pwd = '" + password + "' " +
                               "and u.Deleted = 0 and te.deleted = 0";
                SqlCommand cmd = new SqlCommand(query, cn);
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                da.Fill(dt);
                if (dt.Rows.Count > 0)
                {
                    valid = 1;
                }
            }
        }
        catch (Exception ex)
        {
            ex.Message.ToString();
        }
        return valid;
    }

}
﻿using System;
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
using System.Collections.Generic;

public partial class MCTX_General_Logout : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        //Added by Khalid 05-06-2010
        try
        {
            Session.Abandon();
            Session.Clear();
            Session["Username"] = null;
            Response.Cookies["Username"].Expires = DateTime.Now.AddHours(-1);
            Response.Cookies["Role"].Expires = DateTime.Now.AddHours(-1);
            Response.Cookies["UserFullName"].Expires = DateTime.Now.AddHours(-1);
            Response.Cookies["UserPass"].Expires = DateTime.Now.AddHours(-1);
            ProcessRequest();
            //Response.Redirect("Login.aspx");
        }
        catch (Exception ex)
        {
            Response.Redirect("securelogin.aspx");
        }

    }

    public void ProcessRequest()
    {
        //HttpContext context;
        /// Expire all the cookies so browser visits us as a brand new user
        List<String> cookiesToClear = new List<string>();
        foreach (string cookieName in HttpContext.Current.Request.Cookies)
        {
            HttpCookie cookie = HttpContext.Current.Request.Cookies[cookieName];
            cookiesToClear.Add(cookie.Name);
        }

        foreach (string name in cookiesToClear)
        {
            HttpCookie cookie = new HttpCookie(name, string.Empty);
            cookie.Expires = DateTime.Today.AddYears(-1);

            HttpContext.Current.Response.Cookies.Set(cookie);
        }
        HttpContext.Current.Response.Redirect("~/MCTX_General/securelogin.aspx");
    }
}

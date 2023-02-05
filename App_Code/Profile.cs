using System;
using System.Data;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Web.Profile;
using System.Collections.Generic;

/// <summary>
/// Summary description for Profile
/// </summary>
/// 
namespace UsersProfile
{
    [Serializable]
    public class Profile : System.Web.Profile.ProfileBase
    {
        public Profile()
        {
            //
            // TODO: Add constructor logic here
            //
        }
        public virtual string UserID
        {
            get { return ((string)(this.GetPropertyValue("UserID"))); }
            set { this.SetPropertyValue("UserID", value); }
        }
        
        public virtual string EmailAddress
        {

            get { return ((string)(this.GetPropertyValue("EmailAddress"))); }
            set { this.SetPropertyValue("EmailAddress", value); }

        }
        public virtual string FirstName
        {
            get { return ((string)(this.GetPropertyValue("FirstName"))); }
            set { this.SetPropertyValue("FirstName", value); }
        }
        public virtual string LastName
        {
            get { return ((string)(this.GetPropertyValue("FirstName"))); }
            set { this.SetPropertyValue("FirstName", value); }
        }

        public virtual string EmpFullName
        {
            get { return ((string)(this.GetPropertyValue("EmpFullName"))); }
            set { this.SetPropertyValue("EmpFullName", value); }

        }
        public virtual string EmpWorkType
        {
            get { return ((string)(this.GetPropertyValue("EmpWorkType"))); }
            set { this.SetPropertyValue("EmpWorkType", value); }
        }
        public virtual int RoleId
        {
            get { return ((int)(this.GetPropertyValue("RoleId"))); }
            set { this.SetPropertyValue("RoleId", value); }
        }

        public virtual string RoleName
        {
            get { return ((string)(this.GetPropertyValue("RoleName"))); }
            set { this.SetPropertyValue("RoleName", value); }
        }
        

        //}

    }
}

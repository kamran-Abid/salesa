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

public partial class MCTX_Internal_GeneralUser_frmAddPropecting : System.Web.UI.Page
{


    _Company objcompany = new _Company();
    _Clients objCL = new _Clients();
    _ProspectingList objpros = new _ProspectingList();

    string country = "";
    int countryid = 0;
    string city = "";
    int cityid = 0;

    protected void Page_Load(object sender, EventArgs e)
    {

    }

   
}

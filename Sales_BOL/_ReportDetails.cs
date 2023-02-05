using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using Sales_DAL;

namespace Sales_BOL
{
    public class _ReportDetails
    {
        Dlayer DA = new Dlayer();

        public void rptdetail()
        {
            string query = "select taskdetails from reportdetails where date between ";
        }
    }
}

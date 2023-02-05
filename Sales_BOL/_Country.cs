using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using Sales_DAL;

namespace Sales_BOL
{
    public class _Country
    {
        #region Variables
        Dlayer objDA = new Dlayer();
        string query = "";
        #endregion

        #region Methods
        public int fnAddCountry(string country)
        {
            query = "Insert Into country (country_name) Values ('"+country+"')";
            int result = objDA.insertquery(query);
            return result;
        }
        #endregion
    }
}

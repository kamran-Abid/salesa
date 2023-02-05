using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Sales_DAL;
using System.Data;
using System.Collections;

namespace Sales_BOL
{
    public class _Clients
    {
        #region Variables
        Dlayer objDA = new Dlayer();
        public DataTable DT_Companies = new DataTable();
        public DataTable DT_Countries = new DataTable();
        public DataTable DT_Cities = new DataTable();
        //public ArrayList AL_Countries = new ArrayList();
        //public ArrayList AL_Cities = new ArrayList();
        string query = "";
        #endregion

        #region Methods
        public void fngetcompanies()
        {
            query = "Select comp_name,comp_id,Convert(Varchar(20),getdate(),101) as date From tbl_company where comp_name <> ''order by comp_name ";
            DT_Companies = objDA.DA_getTable(query);
        }
        public void fngetCountries()
        {
            query = "Select country_name,country_id From country";
            DT_Countries = objDA.DA_getTable(query);
        }
        public void fngetCities(int c_id)
        {
            query = "Select city.city_name,city.city_id From city Join country on city.country_id = country.country_id Where country.country_id = " + c_id;
            DT_Cities = objDA.DA_getTable(query);
        }
        public int fnInsertClient(string ClientName , string Address , string Department, string Designation,string Email,string FaxNo,string MobileNo,string Phone,int City,int Country,int CompanyName)
        {
            int result = 0;
            query = "Insert INTO client (client_name , client_address , client_dept,client_designation,client_email,client_fax,Client_mobile,client_phone,city_id,comp_id) Values ('" + ClientName + "','" + Address + "','" + Department + "','" + Designation + "','" + Email + "','" + FaxNo + "','" + MobileNo + "','" + Phone + "'," + City + "," + CompanyName + ")";
            result = objDA.insertquery(query);
            return result;
        }
     
        #endregion
    }
}

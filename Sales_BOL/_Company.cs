using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Sales_DAL;
using System.Data;
using System.Collections;

namespace Sales_BOL
{
    public class _Company
    {
        Dlayer DA = new Dlayer();
        public ArrayList ALcountries = new ArrayList();
        public ArrayList ALcities = new ArrayList();

        public int insert_companyinfo(string CompanyName, string Website,
            int Country,int City,string Phone, string Address,string Multiproducts,string curdate,string Username)
        { 
            int inserted = 0;
            string query = "INSERT INTO tbl_company (comp_name, comp_address,"+
                "comp_phone,comp_mobile,comp_country_id,comp_city_id,comp_website,"+
                "comp_email,user_id,comp_created_date,comp_targted_products) "+
                "VALUES ('" + CompanyName + "','" + Address + "','" + Phone + "',''," +
                Country + "," + City + ",'" + Website + "','','" + Username + "','" + curdate + "','" + Multiproducts + "'" + ")";

            inserted = DA.insertquery(query);
                        
            return inserted;
        }

        public void Bolgetcountries()
        {
            
            string query = "select * from country";
            DataTable dt = DA.DA_getTable(query);

            for (int i = 0; i < dt.Rows.Count; i++)
            {
                ALcountries.Add(dt.Rows[i][0].ToString() + "-" + dt.Rows[i][1].ToString());
             
            }
            
        
        }
        public void Bolgetcities(int countryid)
        {
            string query = "select city_id,city_name from city where country_id = "+countryid+"";
            DataTable dt = DA.DA_getTable(query);
            ALcities = new ArrayList();

            for (int i = 0; i < dt.Rows.Count; i++)
            {
                ALcities.Add(dt.Rows[i][0].ToString() + "-" + dt.Rows[i][1].ToString());

            }


        }


    }
}

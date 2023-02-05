using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Sales_DAL;
using System.Data;

namespace Sales_BOL
{
    public class _ProspectingList
    {
        #region Variables
        Dlayer DA = new Dlayer();
        public DataTable dt_clients = new DataTable();
        #endregion

        #region Methods
        public DataTable fnGetProspecting()
        {
            DataTable dt = DA.DA_fnGetProspecting();
            return dt;
        }
        public void BOlgetclient(int companyid)
        {

            string query = "select client_id,client_name from client where comp_id = " + companyid + " and client_name <> ''";
            dt_clients = DA.DA_getTable(query);
        
        }

        public int addProspecting(string targetproducts,string bookdate,
            string reserveddate, int clientid, int compid, string createdby)
        {
            string query = "insert into tbl_prospecting(Target_products,Visit_Status,Booking_date,"+
            "Reserverd_date,client_id,comp_id,user_id)Values('" + targetproducts + "'," +
            "'Pending','" + bookdate + "','" + reserveddate + "'," + clientid + "," + compid + ",'" + createdby + "')";

            int status = DA.insertquery(query);

            return status;
        
        }

        public DataTable getusersprospecting(string username)
        {
            DataTable dtt = new DataTable();

            try
            {
                string query = "select com.comp_name, cl.client_name, cl.client_designation," +
                   "client_phone,pr.Target_products,convert(Varchar(10),pr.booking_date,101) as Bookingdate," +
                   "convert(Varchar(10),pr.Reserverd_date,101) as reserverddate ,pr.visit_status,te.E_Name " +
                   "from tbl_prospecting as pr " +
                   "Join tbl_company as com on pr.comp_id = com.comp_id " +
                   "Join client as cl on pr.client_id = cl.client_id " +
                   "Join user1 as u on pr.user_id = u.user_id " +
                   "Join tbl_employee as te on u.E_badge = te.E_badge " +
                   "where cl.client_name <> '' " +
                   "and te.E_Name like '%" + username + "%' " +
                   "order by pr.Prospecting_id desc";

                dtt = DA.DA_getTable(query);

                
            }
            catch (Exception ex)
            { }
            return dtt;
        }

        public bool isalreadyBooked(string companyidi)
        {
            DataTable dt_new = new DataTable();
            try
            {
                
                string query = "select * from tbl_prospecting where comp_id = " + companyidi + " and Reserverd_date> Getdate()";
                dt_new = DA.DA_getTable(query);

            }
            catch (Exception ex)
            { }

            if (dt_new.Rows.Count > 0)
            {
                return true;
            }

            return false;
        
        }

        public bool company_alreadyExist(string txt_compname)
        {

            DataTable dt_new = new DataTable();
            try
            {

                string query = "select * from tbl_company where comp_name like '" + txt_compname + "'";
                dt_new = DA.DA_getTable(query);

            }
            catch (Exception ex)
            { }

            if (dt_new.Rows.Count > 0)
            {
                return true;
            }

            return false;

        }


        #endregion
    }
}
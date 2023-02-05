using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using Sales_DAL;

namespace Sales_BOL
{
    public class _Visits
    {
        #region Variables
        Dlayer objDA = new Dlayer();
        public DataTable dt_typeofcalls = new DataTable();
        public DataTable dt_clientresponse = new DataTable();
        public DataTable dt_Itemcategory = new DataTable();
        public DataTable dt_Items = new DataTable();
        public DataTable dt_Clients = new DataTable();
        public DataTable dt_vistis = new DataTable();
        public DataTable dt_visits_details = new DataTable();
        public DataTable dt_visits_details2 = new DataTable();
        public DataTable dt_upcoming_visits = new DataTable();
        string query = "";
        #endregion

        #region Methods
        public void getTypeofCalls()
        {
            query = "select tt_id, tt_name from tbl_TargetType where Deleted <> 0";
            dt_typeofcalls.Clear();
            dt_typeofcalls = objDA.DA_getTable(query);
        }
        public void getClientResponse()
        {
            query = "select * from T_ClientResponse";
            dt_clientresponse.Clear();
            dt_clientresponse = objDA.DA_getTable(query);
        
        }
        public void getItemcategories()
        {
            query = "select * from tbl_category";
            dt_Itemcategory.Clear();
            dt_Itemcategory = objDA.DA_getTable(query);
        
        }
        public void BLGetItems(int categoryid)
        {
            query = "select item_id,item_name from tbl_item where cat_id = " + categoryid + "";
            dt_Items.Clear();
            dt_Items = objDA.DA_getTable(query);
        }
        public void GetClientsData()
        {
            query = "Select u.user_id,cl.client_name,cl.client_mobile,cl.client_designation,co.comp_name From client as cl Join tbl_company as co On cl.comp_id = co.comp_id Join user1 as u on co.user_id = u.user_id Order By u.user_id desc";
            dt_Clients.Clear();
            dt_Clients = objDA.DA_getTable(query);
        }
        public int fnAddVisit(DataTable dt_Visit_items, int compname,int clientName,int typeofcall,int clientresponse,string remarks,int category,int item,int amount, string user, string reminderdate, string vtype,string ipAddress)
        {
            string maxvisitid = "";
            int finalresult = 0;
            string query1 = "insert into visit (client_id,typeofvisit_id,clientresponse_id,total_Sale,"+
                     "VisitDate,RemindDate,UserId,remarks,client_IpAdress)Values " +
                     "(" + clientName + "," + typeofcall + "," + clientresponse + "," + amount + ",getdate(),'" + reminderdate + "','" + user + "','" + remarks + "','" + ipAddress + "')";
            int result = objDA.insertquery(query1);
            if (result == 1)
            {
                string query2 = "select max(visit_id) from visit";
                DataTable dt_maxvisitid = objDA.DA_getTable(query2);
                if (dt_maxvisitid.Rows.Count > 0)
                {
                    maxvisitid = dt_maxvisitid.Rows[0][0].ToString();
                }
                if (maxvisitid != "")
                {
                    string query3 = "";
                    int visitresult = 0;

                    if (dt_Visit_items.Rows.Count > 0)
                    {

                        for (int i = 0; i < dt_Visit_items.Rows.Count; i++)
                        {
                            query3 = "insert into visitItems (visit_id,item_id,items_sales_amount) " +
                                     "Values (" + maxvisitid + "," + dt_Visit_items.Rows[i][4].ToString() + "," + dt_Visit_items.Rows[i][2].ToString() + ")";
                            visitresult = objDA.insertquery(query3);

                            if (visitresult == 0)
                            {

                                finalresult = 2;
                            }

                        }
                    }

                    if (visitresult == 1)
                    {
                        finalresult = 1;
                    
                    }
                    else if (vtype != "Sale")
                    {
                        finalresult = 1;
                    }

                    
                                    
                }

            }

            
            return finalresult;
        }
        public void Getvisits(string userid,string visittype,string fromdate,string todate)
        {
            string query = "";

            if (fromdate == "")
            {
                fromdate = "07/01/2010";
            }
            if (todate == "")
            {
                DateTime dt = DateTime.Now;
                todate = dt.ToShortDateString();
            }
            if (userid == "All")
            {
                if (visittype == "All")
                {
                    query = "select v.visit_id ,convert(varchar(20),V.Visitdate,101) as [Visit_Date] ,tc.comp_name ,cl.client_name ,vt.tt_name ,v.total_Sale ,cr.response_name ,te.E_Name,v.client_IpAdress " +
                            "from visit as v " +
                            "join user1 as u on v.userId = u.user_id " +
                            "Join tbl_Employee as te on u.E_badge = te.E_badge " +
                            "Join client as cl on v.client_id = cl.client_id " +
                            "Join tbl_company as tc on cl.comp_id = tc.comp_id " +
                            "Join T_ClientResponse as cr on v.clientresponse_id = cr.response_id " +
                            "Join tbl_TargetType as vt on v.typeofvisit_id = vt.tt_id " +
                            "where convert(varchar(20),V.Visitdate,101) between '" + fromdate + "' and '" + todate + "' " +
                            "order by 1 desc  ";
                }
                else
                {
                    query = "select v.visit_id ,convert(varchar(20),V.Visitdate,101) as [Visit_Date] ,tc.comp_name ,cl.client_name ,vt.tt_name ,v.total_Sale ,cr.response_name ,te.E_Name,v.client_IpAdress  " +
                            "from visit as v " +
                            "join user1 as u on v.userId = u.user_id " +
                            "Join tbl_Employee as te on u.E_badge = te.E_badge " +
                            "Join client as cl on v.client_id = cl.client_id " +
                            "Join tbl_company as tc on cl.comp_id = tc.comp_id " +
                            "Join T_ClientResponse as cr on v.clientresponse_id = cr.response_id " +
                            "Join tbl_TargetType as vt on v.typeofvisit_id = vt.tt_id " +
                            "where v.typeofvisit_id = " + visittype + " and " +
                            "convert(varchar(20),V.Visitdate,101) between '" + fromdate + "' and '" + todate + "' " +
                            "order by 1 desc  ";
                }
            }
            else
            {

                if (visittype == "All")
                {
                    query = "select v.visit_id ,convert(varchar(20),V.Visitdate,101) as [Visit_Date] ,tc.comp_name ,cl.client_name ,vt.tt_name ,v.total_Sale ,cr.response_name ,te.E_Name,v.client_IpAdress  " +
                            "from visit as v " +
                            "join user1 as u on v.userId = u.user_id " +
                            "Join tbl_Employee as te on u.E_badge = te.E_badge " +
                            "Join client as cl on v.client_id = cl.client_id " +
                            "Join tbl_company as tc on cl.comp_id = tc.comp_id " +
                            "Join T_ClientResponse as cr on v.clientresponse_id = cr.response_id " +
                            "Join tbl_TargetType as vt on v.typeofvisit_id = vt.tt_id " +
                            "where u.user_id = '" + userid + "' and " +
                            "convert(varchar(20),V.Visitdate,101) between '" + fromdate + "' and '" + todate + "' " +
                            "order by 1 desc  ";
                }
                else
                {
                    query = "select v.visit_id ,convert(varchar(20),V.Visitdate,101) as [Visit_Date] ,tc.comp_name ,cl.client_name ,vt.tt_name ,v.total_Sale ,cr.response_name ,te.E_Name,v.client_IpAdress  " +
                            "from visit as v " +
                            "join user1 as u on v.userId = u.user_id " +
                            "Join tbl_Employee as te on u.E_badge = te.E_badge " +
                            "Join client as cl on v.client_id = cl.client_id " +
                            "Join tbl_company as tc on cl.comp_id = tc.comp_id " +
                            "Join T_ClientResponse as cr on v.clientresponse_id = cr.response_id " +
                            "Join tbl_TargetType as vt on v.typeofvisit_id = vt.tt_id " +
                            "where u.user_id = '"+userid+"' and " +
                            "v.typeofvisit_id = "+visittype+" and " +
                            "convert(varchar(20),V.Visitdate,101) between '"+fromdate+"' and '"+todate+"' " +
                            "order by 1 desc  ";
                 }
            
            
        
            }

            dt_vistis = objDA.DA_getTable(query);
        
        }
        public DataTable fnGetClientInfo(int client_id)
        {
            query = "Select cl.client_designation,cl.Client_mobile,cl.client_email,cl.client_address,cl.client_phone," +
                    "cl.client_fax,cy.city_name,cn.country_name,cl.client_dept,co.comp_name From client as cl " +
                    "Left Join city as cy on cl.city_id = cy.city_id Join country as cn on cy.country_id = cn.country_id " +
                    "Join tbl_company as co on cl.comp_id = co.comp_id Where client_id = " + client_id;
            DataTable dt = objDA.DA_getTable(query);
            return dt;
        }

        public void visits_details(int id)
        {
            string query = "select ti.item_name as [Item Name],tc.cat_name as [category],vi.items_sales_amount as [Amount] "+
                           "from  VisitItems as vi join visit as v on v.visit_id = vi.visit_id "+
                           "join tbl_item as ti on ti.item_id = vi.item_id "+
                           "join tbl_category as tc on tc.cat_id = ti.cat_id "+
                           "where v.visit_id = "+id.ToString()+"";
            dt_visits_details = objDA.DA_getTable(query);
            string query2 = "select v.visit_id ,convert(varchar(20),V.Visitdate,101) as [Visit_Date] ,tc.comp_name ,cl.client_name , "+
                            "vt.tt_name ,v.total_Sale ,cr.response_name ,te.E_Name, cl.client_phone,cl.Client_mobile, "+
                            "cl.client_email,cl.client_designation,tc.comp_address,v.remarks,cty.city_name "+ 
                            "from visit as v "+
                            "join user1 as u on v.userId = u.user_id "+
                            "Join tbl_Employee as te on u.E_badge = te.E_badge "+
                            "Join client as cl on v.client_id = cl.client_id "+
                            "Join tbl_company as tc on cl.comp_id = tc.comp_id "+
                            "Join T_ClientResponse as cr on v.clientresponse_id = cr.response_id "+ 
                            "Join tbl_TargetType as vt on v.typeofvisit_id = vt.tt_id "+ 
                            "Join city as cty on tc.comp_city_id = cty.city_id "+
                            "where v.visit_id = "+id.ToString()+"";
            dt_visits_details2 = objDA.DA_getTable(query2);
                   
        }
        public string totalsales(string user)
        {
            string query = "select sum(total_Sale) from visit group by UserId having UserId = '"+user+"'";
            string salesamount = "";
            DataTable dt = objDA.DA_getTable(query);

            if (dt.Rows.Count > 0)
            {
                salesamount = dt.Rows[0][0].ToString();
            }
            else
            {
                salesamount = "0.00";
            }

            return salesamount;


        }

        public string fnMonthToDateSale(string month,string username)
        {
            query = " Select isnull(Sum(total_Sale),0) as [Month To Date Amount] From visit   " +
                    "Where VisitDate Between '"+month+"' And GetDate() And UserId = '"+username+"'";
            DataTable saleamount_DT = objDA.DA_getTable(query);

            string salesamount = "";

            if (saleamount_DT.Rows.Count > 0)
            {
                salesamount = saleamount_DT.Rows[0][0].ToString();
            }

            return salesamount;
        }

        public bool iscompanybook(string compname, string username)
        {
            string query1 = "select * from tbl_Prospecting where comp_id = " + compname + " and user_id <> '" + username + "' " +
                    "and Reserverd_date > getdate()";
            DataTable dt = new DataTable();
            dt = objDA.DA_getTable(query1);

            if (dt.Rows.Count > 0)
            {
                return true;
                
            }

            return false;
        
        }
        public bool isalreadyentered(string compid)
        {

            string query1 = "select v.visit_id,tc.comp_name,v.UserId from visit as v Join client as cl on v.client_id = cl.client_id "+
                            "Join tbl_company as tc on cl.comp_id = tc.comp_id "+ 
                            "where tc.comp_id  = '"+compid+"' and "+
                            "convert(Varchar(20),VisitDate,101) = convert(Varchar(20),getdate(),101)";
            DataTable dt = new DataTable();
            dt = objDA.DA_getTable(query1);

            if (dt.Rows.Count > 0)
            {
                return true;

            }

            return false;
        
        }


        public int updateprospecting(string compname, string username)
        {
            int updated = 0;
            try
            {
                string query2 = "select max(Prospecting_id) from tbl_Prospecting " +
                                "where comp_id = " + compname + " and user_id = '" + username + "'";
                DataTable dt_new = new DataTable();
                dt_new = objDA.DA_getTable(query2);

                if (dt_new.Rows.Count > 0)
                {
                    string pros_id = dt_new.Rows[0][0].ToString();
                    string query3 = "update tbl_Prospecting set Visit_Status = 'Done' where Prospecting_id = " + pros_id + "";
                    updated = objDA.Updatequery(query3);
                }
            }
            catch (Exception ex)
            { }
            return updated;

            
        }

        public void getUpcomingvisits(string user)
        {
            dt_upcoming_visits = new DataTable();
            string myquery ="select convert(varchar(20),V.RemindDate,101) as [Remind date] , "+
                            "tc.comp_name as [Comp name] ,cl.client_name as [Client name],cl.Client_mobile as [Client mobile],cl.client_email [Client email], "+
                            "convert(varchar(20),V.Visitdate,101) as [Last visit] from visit as v "+
                            "join user1 as u on v.userId = u.user_id "+
                            "Join tbl_Employee as te on u.E_badge = te.E_badge "+ 
                            "Join client as cl on v.client_id = cl.client_id "+
                            "Join tbl_company as tc on cl.comp_id = tc.comp_id "+
                            "Join T_ClientResponse as cr on v.clientresponse_id = cr.response_id "+  
                            "Join tbl_TargetType as vt on v.typeofvisit_id = vt.tt_id "+
                            "Join city as cty on tc.comp_city_id = cty.city_id "+
                            "where convert(varchar(15),v.RemindDate,101) > convert(varchar(15),getdate(),101) and "+
                            "convert(varchar(15),v.RemindDate,101) < dateadd(day,5,convert(varchar(15),getdate(),101)) "+ 
                            "and v.UserId = '"+user+"'";
            dt_upcoming_visits = objDA.DA_getTable(myquery);
        
        }
    
    


        #endregion
    }
}

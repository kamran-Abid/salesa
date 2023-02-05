using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Sales_DAL;
using System.Data;

namespace Sales_BOL
{
    public class _Quotation
    {
        #region Variables
        Dlayer objDA = new Dlayer();
        string query = "";
        #endregion

        #region Methods
        public DataTable fnGetImage()
        {
            query = "Select image_url From tbl_item where item_id = 72";
            DataTable dt = objDA.DA_getTable(query);
            return dt;
        }
        public DataTable fnGetClients(int Comp_id)
        {
            query = "Select   * From client where deleted = 0  and comp_id = " + Comp_id + "  order by client_name ";
            DataTable dt_Clients = objDA.DA_getTable(query);
            return dt_Clients;
        }

        public DataTable fnGetCompany()
        {
            query = "select  comp_id , comp_name  from tbl_company where deleted!=1 order by comp_name ";
            DataTable dt_Company = objDA.DA_getTable(query);
            return dt_Company;
        }
        public DataTable fnGetClientRecord(int client_id)
        {
            query = "Select tcl.client_designation,tcl.client_dept,tcl.client_name,tco.comp_name "+
                    "From client as tcl Join tbl_company as tco on tcl.comp_id = tco.comp_id Where client_id = "+client_id;
            DataTable dt_Record = objDA.DA_getTable(query);
            return dt_Record;
        }

        public DataTable GetDiscription(string TermID)
        {
            query = "select term_discription from tbl_Term_Discription where Term_ID = '" + TermID+"'";
            DataTable dt_Record = objDA.DA_getTable(query);
            return dt_Record;
        }

        public DataTable fnGetMangers()
        {
            query = "Select te.E_Name,te.E_badge From Tbl_Employee as te "+
                    "Join user1 as tu on te.E_badge = tu.E_badge Where role_id in (1,2) and isnull(te.deleted,0)<>1";
            DataTable dt_Managers = objDA.DA_getTable(query);
            return dt_Managers;
        }
        public DataTable fnGetTechPersons()
        {
            query = "Select te.E_Name,te.E_badge From Tbl_Employee as te " +
                    "Join user1 as tu on te.E_badge = tu.E_badge Where  Employee_type='1'  and isnull(te.deleted,0)<>1";
            DataTable dt_TechPersons = objDA.DA_getTable(query);
            return dt_TechPersons;
        }
        public DataTable fnGetItems(String CatId)
        {
            query = "Select * From tbl_item where isnull(Deleted,0) <> 1 and cat_id = '" + CatId + "'";
            DataTable dt_Items = objDA.DA_getTable(query);
            return dt_Items;
        }
        public DataTable fnGetItemsCategory()
        {
            query = "select * from dbo.tbl_category where isnull(Deleted,0) <> 1 order by cat_name ";
            DataTable dt_Items = objDA.DA_getTable(query);
            return dt_Items;
        }
        public DataTable fnGetItemData(int item_id)
        {
            query = "Select description From tbl_item Where item_id = " + item_id;
            DataTable dt_ItemData = objDA.DA_getTable(query);
            return dt_ItemData;
        }
        public int AddQuotation(int Client, string SalManager, string TechPerson, string QSubject, string CustomerSite, string EmpID, string PaymentTerms, string WarrantyTerms, string WarrantyException , string DeliveryInstallation , string Validity , string TexExemption, string SpecialNotes)
        {

            query = "Insert Into tbl_quotation (client_id,manager_id,tech_per_id,quo_date,subject,customer_site,status,Created_By,Created_Date,Modify_By,Modify_Date,PaymentTerms,WarrantyTerms,WarrantyException,DeliveryInstallation,Validity,TexExemption,SpecialNotes) "
           + "Values (" + Client + ",'" + SalManager + "','" + TechPerson + "',GETDATE()" + ",'" + QSubject + "','" + CustomerSite + "',1,'" + EmpID + "','" + DateTime.Now + "','" + EmpID + "','" + DateTime.Now + "','','','','','','','" + SpecialNotes + "')";
            int result = 
                objDA.insertquery(query);
            return result;
        }
        public int AddQuotItem(int quo_id, int itemid, int quantity, double price, string unit, double gst, float gstPercent,String IsAlreadySave,String QitemId,String ItemId,String PriceType)
        {
           int result = 0;
            if (IsAlreadySave == "0")
            {

                query = "Insert Into tbl_quot_item (quo_id,item_id,item_quantity,item_price,Iunit,gst,gstPercent,cat_id,Price_type) "+
                        " Values (" + quo_id + "," + itemid + "," + quantity + "," + price + ",'" + unit + "'," + gst + "," + gstPercent + ",'" + ItemId + "','"+PriceType+"')";
                result = 
                objDA.insertquery(query);
            }
            else
            {
                query = "update tbl_quot_item set item_id=" + itemid + ",cat_id='" + ItemId + "',Price_type='" + PriceType + "',item_quantity=" + quantity + ",item_price=" + price + ",Iunit='" + unit + "',gst=" + gst + ",gstPercent=" + gstPercent + " where qi_id=" + QitemId + "";
                result = 
                objDA.insertquery(query);
            }
           return result;
        }


        //added by saqib term and condition
        public int AddTermsAndCondition(int quo_id, int TermTypeID, int TermNameID, String IsAlreadySave, String TermType, String TermName, String TermDiscription, int ID)
        {
            int result = 0;
            if (IsAlreadySave == "0")
            {

                query = "insert into tbl_Quotation_TermAndCondition (TermTypeID, TermNameID, TermType, TermName, TermDiscription, Quot_ID) values"+
                            "("+TermTypeID+" ,"+TermNameID+" ,'"+TermType+"' , '"+TermName+"' , '"+TermDiscription+"',"+quo_id+" )";
                result =objDA.insertquery(query);
            }
            else
            {
                query = "update tbl_Quotation_TermAndCondition set TermTypeID = "+TermTypeID+", TermType = '"+TermType+"' , TermNameID="+TermNameID+" , TermNameID = '"+TermNameID+"' , termDiscription='"+TermDiscription+"'  where  ID="+ID+" ";
                result = objDA.insertquery(query);
            }
            return result;
        }


        public int GetQuotID()
        {
            query = "Select max(quo_id) as quo_id From dbo.tbl_quotation";
            int quot_id = 0;
            DataTable dt = objDA.DA_getTable(query);
            return int.Parse(dt.Rows[0][0].ToString());
        }
        public int UpdateQuotation(int Client, string SalManager, string TechPerson, string QSubject, string CustomerSite, int quo_id, string EmpID, string PaymentTerms, string WarrantyTerms, string WarrantyException, string DeliveryInstallation, string Validity, string TexExemption, string SpecialNotes)
        {
            query = "UPDATE tbl_quotation SET manager_id ='" + SalManager + "', tech_per_id ='" + TechPerson + "', subject ='" +
                    QSubject + "', customer_site ='" + CustomerSite + "', client_id =" + Client + " , Modify_By ='" + EmpID + "' , Modify_Date ='" + DateTime.Now + "' "+
                    ", PaymentTerms='' , WarrantyTerms='', WarrantyException='', DeliveryInstallation='' ,Validity='' , TexExemption='' , SpecialNotes='" + SpecialNotes + "'" +
            " where quo_id = " + quo_id;
            int status = 
                objDA.Updatequery(query);
            return status;
        }
        public DataTable fnGetQuotations()
        {
            query = "SELECT tq.quo_id, 'MCTX/' + tco.comp_Key+'/' + CAST(tq.quo_id as varchar(10)) Ref , tcl.client_name, tcl.client_designation," +
                    "tco.comp_name,Convert(Varchar(10),tq.quo_date,101) as quo_date, tq.status, ts.status_name "+
                    "FROM  tbl_quotation as tq "+
                    "INNER JOIN client as tcl ON tq.client_id = tcl.client_id "+
                    "INNER JOIN tbl_company as tco ON tcl.comp_id = tco.comp_id "+
                    "INNER JOIN T_Status as ts ON tq.status = ts.status_id order by tq.quo_id desc";
            DataTable dt_QuotData = objDA.DA_getTable(query);
            return dt_QuotData;
        }

        public DataTable fnGetQuotationsTerms(int ID)
        {
            query = "select * from tbl_Quotation_TermAndCondition where Quot_ID = "+ID+"";
            DataTable dt_QuotTerm = objDA.DA_getTable(query);
            return dt_QuotTerm;
        }
        public int fnDeleteQuotationItems(int quo_id)
        {            
            string Query2 = "select quo_id from tbl_quot_item where qi_id = '"+quo_id+"'";
            DataTable dtQID = objDA.DA_getTable(Query2);

            query = "delete from tbl_quot_item where qi_id =  " + quo_id;
            int result = objDA.DeleteQuery(query);
            if (result == 1)
            {
                string query1 = "select count(*) as itemCount from tbl_quot_item where quo_id = "+dtQID.Rows[0][0].ToString()+"";
                DataTable dtitemCount = objDA.DA_getTable(query1);
                if(Convert.ToInt32(dtitemCount.Rows[0][0].ToString()) == 0)
                {
                    string QuerDeleteQuote = "delete from tbl_quotation where quo_id='" + dtQID.Rows[0][0].ToString() + "'";
                    int result1 = objDA.DeleteQuery(QuerDeleteQuote);
                }
            }
            return result;
        }

        public int fnDeleteQuotationTerms(int TermNameID  )
        {
            String QueryTerm = "delete from tbl_Quotation_TermAndCondition where ID ="+TermNameID+"  ";
            int result = objDA.DeleteQuery(QueryTerm);
            return result;
        }
        public DataSet fnGetQuotData(int quotId)
        { 
            DataSet ds_QuotData = objDA.ExecuteProc(quotId);
            return ds_QuotData;
        }
        public String GetPriceinfo(String Saltype,String ItemId)
        {
            String Price = "0";
           //String Query = "select " + Saltype + " from tbl_ItemsPrices where item_id='" + ItemId + "' and isnull(Deleted,0) <> 1";
            string Query = @"select " + Saltype + "  from dbo.tbl_category cat inner join tbl_item Ti on Ti.cat_id = cat.cat_id inner join tbl_ItemsPrices item on item.item_id = Ti.item_id"
                            + " where isnull(cat.deleted,0) <> 1 and isnull(Ti.Deleted,0)<>1  and ti.item_id='" + ItemId + "'";
            DataTable dt = objDA.DA_getTable(Query);
            if (dt.Rows.Count > 0)
            {
                Price = dt.Rows[0][0].ToString();
            }
            return Price==""?"0":Price;
        }
        #endregion
    }
}

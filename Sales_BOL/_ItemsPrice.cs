using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Sales_DAL;
using System.Data;
using System.Collections;

namespace Sales_BOL
{
    public class _ItemsPrice
    {
        #region Variables
        public DataTable DT_Categories = new DataTable();
        public DataTable DT_Items = new DataTable();
        public DataTable DT_ItemPrices = new DataTable();
        Dlayer objDA = new Dlayer();
        string query = "";
        #endregion

        #region Methods
        public void fnGetCategories()
        {
            query = "Select cat_name,cat_id From tbl_category";
            DT_Categories = objDA.DA_getTable(query);
        }
        public void fnGetItems()
        {
            query = "Select item_id,item_name From tbl_item";
            DT_Items = objDA.DA_getTable(query);
        }
        public void fnGetItemPrices()
        {
            query = "Select IP.MaximumPrice,IP.NormalPrice,IP.MinimumPrice,i.item_add_date,i.Active "+ 
                    "From tbl_ItemsPrices as IP Join tbl_item as i on IP.item_id = i.item_id";
            DT_ItemPrices = objDA.DA_getTable(query);
        }
        public int fnInsertItemPrice(int item_id ,string maxprc ,string normalprc ,string minprc)
        {
            query = "Insert Into tbl_ItemsPrices (item_id,MaximumPrice,NormalPrice,MinimumPrice) Values ("+item_id+",'"+maxprc+"','"+normalprc+"','"+minprc+"')";
            int result = objDA.insertquery(query);
            return result;
        }
        #endregion
    }
}

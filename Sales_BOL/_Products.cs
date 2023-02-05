using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using Sales_DAL;

namespace Sales_BOL
{
    public class _Products
    {
        #region Variables
        Dlayer objDA = new Dlayer();
        string query = "";
        public DataTable DT_GetCats = new DataTable();
        public DataTable DT_GetOrigin = new DataTable();
        #endregion

        #region Methods
        public DataTable fnGetProduct()
        {
            query = "Select cat_id,cat_name From tbl_category";
            DataTable dt = objDA.DA_getTable(query);
            return dt;
        }
        public DataTable fnGetItems()
        {
            query = "Select cat.cat_name,itm.item_id,itm.item_name,itm.model_no,itm.item_code,itm.warrenty From tbl_item as itm Join tbl_category as cat on itm.cat_id = cat.cat_id";
            DataTable dt = objDA.DA_getTable(query);
            return dt;
        }
        public int fnAddCategory(string category)
        {
            query = "Insert Into tbl_category (cat_name) Values ('" + category + "')";
            int result = objDA.insertquery(query);
            return result;
        }
        public int fnAddProduct(string brand, string eqserdes, string Itemcode, string modelno, int Warrenty, int Origin, int category, byte[] thumbnailBytes)
        {
            //query = "Insert Into tbl_item (item_name,description,item_code,model_no,warrenty,origin_id,cat_id,image_url) Values ('" + brand + "','" + eqserdes + "','" + Itemcode + "','" + modelno + "'," + Warrenty + "," + Origin + "," + category + "," + thumbnailBytes + ")";
            query = "Insert Into tbl_item (item_name,description,item_code,model_no,warrenty,origin_id,cat_id,Product_Image) Values ('" + brand + "',@eqserdes,@Itemcode,@modelno,@Warrenty,@Origin,@category,@imgbin)";
            int result = objDA.insertquery(query);
            return result;
        }
        public void fnGetCategories()
        {
            query = "select cat_id,cat_name from tbl_category where isnull(deleted,0)<>1";
            DT_GetCats = objDA.DA_getTable(query);
        }
        public void fnGetOrigin()
        {
            query = "Select country_id,country_name From country";
            DT_GetOrigin = objDA.DA_getTable(query);
        }
        public DataTable fnGetImage()
        {
            query = "Select item_name,Product_Image From tbl_item Where item_id in (69,70,71)";
            DataTable dt = objDA.DA_getTable(query);
            return dt;
        }
        public int fnDeleteCategory(string category)
        {
            query = "delete from tbl_category where cat_id = " + category + "";
            int result = objDA.insertquery(query);
            return result;
        }
        #endregion
    }
}

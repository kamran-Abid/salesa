using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Sales_DAL;
using System.Data;

namespace Sales_BOL
{
    public class _Excuse
    {
        #region Variables
        Dlayer objDA = new Dlayer();
        string query = "";
        #endregion

        #region Methods
        public int fnAddExcuse(string username,string subject,string description,int comp)
        {
            query = "Insert Into dbo.tbl_VisitExcuse (user_id,exDate,ex_Subject,Description,comp_id)"+
                    " Values ('"+username+"',CONVERT(VARCHAR(10),GETDATE(),110),'"+subject+"','"+description+"',"+comp+")";
            int Status = objDA.insertquery(query);
            return Status;
        }
        #endregion
    }
}

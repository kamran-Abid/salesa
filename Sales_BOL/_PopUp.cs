using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using Sales_DAL;

namespace Sales_BOL
{
    public class _PopUp
    {
        #region Variables
        DataSet ds = new DataSet();
        Dlayer objDlayer = new Dlayer();
        #endregion

        #region Methods
        public DataSet fnGetGridData()
        {
            ds = objDlayer.DA_GETPopUpGridData();
            return ds;
        }
        public int fnGetDoneTargets()
        {
            int targets = 0;
            targets = objDlayer.DA_fnGetDoneTargets();
            return targets;
        }
        //public DataTable fnGetTypes()
        //{
        //    DataTable dt = objDlayer.DA_fnGetTypes();
        //    return dt;
        //}
        #endregion
    }
}

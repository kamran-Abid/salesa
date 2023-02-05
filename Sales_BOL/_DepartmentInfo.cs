using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Sales_DAL;
using System.Data;
using System.Collections;

namespace Sales_BOL
{
    public class _DepartmentInfo
    {
        #region Variables
        public DataTable DT_Branches = new DataTable();
        Dlayer objDA = new Dlayer();
        string query = "";
        #endregion

        #region Methods
        public void get_Branches()
        {
            query = "Select BRID,BRANCHNAME From tbl_BRANCHES";
            DT_Branches = objDA.DA_getTable(query);
        }
        public int fnInsertDept(int br_id, string DeptName, string Phone1, string Phone2, string Address)
        {
            int status = objDA.DA_fnInsertDept(br_id, DeptName, Phone1, Phone2, Address);
            return status;
        }
        public int fnInsertDesignation(string desgnation)
        {
            int status = objDA.DA_fnInsertDesignation(desgnation);
            return status;
        }
        #endregion
    }
}

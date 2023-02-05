using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Sales_DAL;
using System.Data;
using System.Collections;

namespace Sales_BOL
{
    public class _Employees
    {
        #region Variables
        Dlayer objDA = new Dlayer();
        public DataTable DT_BR = new DataTable();
        public DataTable DT_DEP = new DataTable();
        public DataTable DT_DES = new DataTable();
        string query = "";
        #endregion

        #region Methods
        public DataTable fnGetEmployees()
        {
            query = "Select emp.E_badge,emp.E_Name,des.Desig_Name,dep.D_NAME From Tbl_Employee as emp join Tbl_Designation as des on emp.Ds_id = des.ID join Tbl_Department as dep on emp.Dp_id = dep.D_ID Where emp.deleted = 0";
            DataTable dt = objDA.DA_getTable(query);
            return dt;
        }
        public void fnGetBranches()
        {
            query = "Select BRID,BRANCHNAME From tbl_BRANCHES";
            DT_BR = objDA.DA_getTable(query);
        }
        public void fnGetDepartments()
        {
            query = "Select D_ID,D_NAME From Tbl_Department";
            DT_DEP = objDA.DA_getTable(query);
        }
        public void fnGetDesignations()
        {
            query = "Select ID,Desig_Name From Tbl_Designation";
            DT_DES = objDA.DA_getTable(query);
        }
        public int fnAddEmployee(string Address, string BasicSalary, string CNIC, string Education, string EmpID, string EmpName, string DOB, string GaurdianMobile, string Mobile, string MobileAllow, string OtherAllow, string Phone, string Gender, string Phone1, int Branch, int Department, int Designation, string StartDate, string TravlingAllow)
        {
            query = "Insert Into Tbl_Employee (E_Address,BasicSalary,E_NIC,E_Education,E_badge,E_Name,DOB,FatherMobile,E_Mobile,MobileAllowence,MiscAllowence,E_PhNo1,E_Sex,E_PhNo2,BRID,Dp_Id,Ds_id,E_EmpDate,ConvenceAllowence,Deleted) Values ('"+Address+"','"+BasicSalary+"','"+CNIC+"','"+Education+"','"+EmpID+"','"+EmpName+"','"+DOB+"','"+GaurdianMobile+"','"+Mobile+"','"+MobileAllow+"','"+OtherAllow+"','"+Phone+"','"+Gender+"','"+Phone1+"',"+Branch+","+Department+","+Designation+",'"+StartDate+"','"+TravlingAllow+"',"+0+")";
            int status = objDA.insertquery(query);
            return status;
        }
        public int fnDeleteEmployee(string row_id)
        {
            query = "Update Tbl_Employee Set Deleted = 1 Where E_badge = '"+row_id+"'";
            int status = objDA.Updatequery(query);
            return status;
        }
        public DataTable fnGetEmpRecord(string empId)
        {
            query = "Select * From Tbl_Employee Where E_badge = '"+empId+"'";
            DataTable dt = objDA.DA_getTable(query);
            return dt;
        }
        public int fnUpdateEmployee(string Address,string BasicSalary,string CNIC,string Education,string EmpID,string EmpName,
            string DOB,string GaurdianMobile,string Mobile,string MobileAllow,string OtherAllow,string Phone,
           string Gender, string Phone1, int Branch, int Department, int Designation, string StartDate, 
           string TravlingAllow)
        {
            query = "Update Tbl_Employee Set " +
                    "E_Name = '"+EmpName+"',E_Address = '"+Address+"', E_PhNo1 = '"+Phone+"', Ds_id = "+Designation+" ,"+
                    "E_EmpDate = '"+StartDate+"',E_Sex = '"+Gender+"',E_Education = '"+Education+"',E_Mobile = '"+Mobile+"',"+ 
                    "E_NIC = '"+CNIC+"', E_AllowedLeaves = '02',Dp_Id = "+Department+" ,FatherMobile = '"+GaurdianMobile+"',"+
                    "E_PhNo2 = '"+Phone1+"',BasicSalary = '"+BasicSalary+"',ConvenceAllowence = '"+TravlingAllow+"',"+
                    "MobileAllowence = '"+MobileAllow+"',MiscAllowence = '"+OtherAllow+"',BRID = "+Branch+" ,DOB = '"+DOB+"'"+ 
                    "where E_badge = '"+EmpID+"' ";
            int status = objDA.Updatequery(query);
            return status;
        }
        #endregion
    }
}

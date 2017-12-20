//using System;
//using System.Configuration;
//using System.Data;
//using System.Data.SqlClient;
//using System.Web.Services;
//using System.Web.Script.Serialization;
//using System.Collections.Generic;

//namespace chp54
//{
//    [WebService(Namespace = "http://tempuri.org/")]
//    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
//    [System.ComponentModel.ToolboxItem(false)]
//    [System.Web.Script.Services.ScriptService]
//    public class EmployeeService : System.Web.Services.WebService
//    {
//        [WebMethod]

//        public void GetAllEmployees()
//        {
//            List<Employee> ListEmployees = new List<Employee>();

//            string cs = ConfigurationManager.ConnectionStrings["DBCS"].ConnectionString;
//            using (SqlConnection con = new SqlConnection(cs))
//            {
//                SqlCommand cmd = new SqlCommand("select * from tblEmployee", con);

//                con.Open();
//                SqlDataReader rdr = cmd.ExecuteReader();
//                while (rdr.Read())
//                {
//                    Employee employee = new Employee();
//                    employee.ID = Convert.ToInt32(rdr["Id"]);
//                    employee.Name = rdr["Name"].ToString();
//                    employee.Gender = rdr["Gender"].ToString();
//                    employee.Salary = Convert.ToInt32(rdr["Salary"]);
//                    ListEmployees.Add(employee);
//                }
//            }
//            JavaScriptSerializer js = new JavaScriptSerializer();
//            Context.Response.Write(js.Serialize(ListEmployees));
//        }
//    }
//}


//    //    public void GetEmployeeById(int employeeId)
//        //    {
//        //        Employee employee = new Employee();

//        //        string cs = ConfigurationManager.ConnectionStrings["DBCS"].ConnectionString;
//        //        using (SqlConnection con = new SqlConnection(cs))
//        //        {
//        //            SqlCommand cmd = new SqlCommand("spGetEmployeeById", con);
//        //            cmd.CommandType = CommandType.StoredProcedure;

//        //            SqlParameter parameter = new SqlParameter();
//        //            parameter.ParameterName = "@Id";
//        //            parameter.Value = employeeId;

//        //            cmd.Parameters.Add(parameter);
//        //            con.Open();
//        //            SqlDataReader rdr = cmd.ExecuteReader();
//        //            while(rdr.Read())
//        //            {
//        //                employee.ID = Convert.ToInt32(rdr["Id"]);
//        //                employee.Name = rdr["Name"].ToString();
//        //                employee.Gender = rdr["Gender"].ToString();
//        //                employee.Salary = Convert.ToInt32(rdr["Salary"]);

//        //            }
//        //        }
//        //        JavaScriptSerializer js = new JavaScriptSerializer();
//        //        Context.Response.Write(js.Serialize(employee));
//        //    }
//        //}

//        //approach 1 chp 62 :
//        //public Employee GetEmployeeById(int employeeId)
//        //{
//        //    Employee employee = new Employee();

//        //    string cs = ConfigurationManager.ConnectionStrings["DBCS"].ConnectionString;
//        //    using (SqlConnection con = new SqlConnection(cs))
//        //    {
//        //        SqlCommand cmd = new SqlCommand("spGetEmployeeById", con);
//        //        cmd.CommandType = CommandType.StoredProcedure;

//        //        SqlParameter parameter = new SqlParameter();
//        //        parameter.ParameterName = "@Id";
//        //        parameter.Value = employeeId;

//        //        cmd.Parameters.Add(parameter);
//        //        con.Open();
//        //        SqlDataReader rdr = cmd.ExecuteReader();
//        //        while (rdr.Read())
//        //        {
//        //            employee.ID = Convert.ToInt32(rdr["Id"]);
//        //            employee.Name = rdr["Name"].ToString();
//        //            employee.Gender = rdr["Gender"].ToString();
//        //            employee.Salary = Convert.ToInt32(rdr["Salary"]);

//        //        }
//        //    }

//        //    return employee;
//        //}



using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.Script.Serialization;
using System.Web.Services;

namespace chp54
{
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    [System.Web.Script.Services.ScriptService]
    public class EmployeeService : System.Web.Services.WebService
    {
        [WebMethod]
        public void AddEmployee(Employee emp)
        {
            string cs = ConfigurationManager.ConnectionStrings["DBCS"].ConnectionString;
            using (SqlConnection con = new SqlConnection(cs))
            {
                SqlCommand cmd = new SqlCommand("spInsertEmployee", con);
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.Add(new SqlParameter()
                {
                    ParameterName = "@Name",
                    Value = emp.Name
                });

                cmd.Parameters.Add(new SqlParameter()
                {
                    ParameterName = "@Gender",
                    Value = emp.Gender
                });

                cmd.Parameters.Add(new SqlParameter()
                {
                    ParameterName = "@Salary",
                    Value = emp.Salary
                });

                con.Open();
                cmd.ExecuteNonQuery();
            }
        }

        [WebMethod]
        public void GetAllEmployees()
        {
            List<Employee> listEmployees = new List<Employee>();

            string cs = ConfigurationManager.ConnectionStrings["DBCS"].ConnectionString;
            using (SqlConnection con = new SqlConnection(cs))
            {
                SqlCommand cmd = new SqlCommand("Select * from tblEmployee", con);
                con.Open();
                SqlDataReader rdr = cmd.ExecuteReader();
                while (rdr.Read())
                {
                    Employee employee = new Employee();
                    employee.ID = Convert.ToInt32(rdr["Id"]);
                    employee.Name = rdr["Name"].ToString();
                    employee.Gender = rdr["Gender"].ToString();
                    employee.Salary = Convert.ToInt32(rdr["Salary"]);
                    listEmployees.Add(employee);
                }
            }

            JavaScriptSerializer js = new JavaScriptSerializer();
            Context.Response.Write(js.Serialize(listEmployees));
        }
    }
}



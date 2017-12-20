
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
    public class EmployeeChp90Service : System.Web.Services.WebService
    {
        [WebMethod]
        public void SaveEmployeeChp90(EmployeeChp90 employee)
        {
            string cs = ConfigurationManager.ConnectionStrings["DBCS"].ConnectionString;
            using (SqlConnection con = new SqlConnection(cs))
            {
                SqlCommand cmd = new SqlCommand("spInsertEmployeeChp90", con);
                cmd.CommandType = CommandType.StoredProcedure;

                SqlParameter paramFirstName = new SqlParameter()
                {
                    ParameterName = "@FirstName",
                    Value = employee.FirstName
                };
                cmd.Parameters.Add(paramFirstName);

                SqlParameter paramLastName = new SqlParameter()
                {
                    ParameterName = "@LastName",
                    Value = employee.LastName
                };
                cmd.Parameters.Add(paramLastName);

                SqlParameter paramEmail = new SqlParameter()
                {
                    ParameterName = "@Email",
                    Value = employee.Email
                };
                cmd.Parameters.Add(paramEmail);

                con.Open();
                cmd.ExecuteNonQuery();
            }
        }

        [WebMethod]
        public void GetEmployee()
        {
            string cs = ConfigurationManager.ConnectionStrings["DBCS"].ConnectionString;
            List<EmployeeChp90> listEmployee = new List<EmployeeChp90>();

            using (SqlConnection con = new SqlConnection(cs))
            {
                SqlCommand cmd = new SqlCommand("spGetEmployeeChp90s", con);
                cmd.CommandType = CommandType.StoredProcedure;

                con.Open();
                SqlDataReader rdr = cmd.ExecuteReader();
                while (rdr.Read())
                {
                    EmployeeChp90 employee = new EmployeeChp90();
                    employee.FirstName = rdr["FirstName"].ToString();
                    employee.LastName = rdr["LastName"].ToString();
                    employee.Email = rdr["Email"].ToString();
                    listEmployee.Add(employee);
                }
            }

            JavaScriptSerializer js = new JavaScriptSerializer();
            Context.Response.Write(js.Serialize(listEmployee));
        }
    }
}
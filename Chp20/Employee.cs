using System;
using System.Collections.Generic;
using System.Web.Script.Serialization;


namespace Chp20
{
    public class Employee
    {
        public string firstName { get; set; }
        public string lastName { get; set; }
        public string gender { get; set; }
        public int salary { get; set; }
    }

    public partial class WebForm1 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            //.net obj to json string
            Employee employee1 = new Employee
            {
                firstName = "Todd",
                lastName = "Grover",
                gender = "Male",
                salary = 50000
            };

            Employee employee2 = new Employee
            {
                firstName = "Sara",
                lastName = "Baker",
                gender = "Female",
                salary = 40000
            };

            List<Employee> listEmployee = new List<Employee>();
            listEmployee.Add(employee1);
            listEmployee.Add(employee2);

            JavaScriptSerializer javaScriptSerializer = new JavaScriptSerializer();
            string JSONString = javaScriptSerializer.Serialize(listEmployee);

            Response.Write(JSONString);

            //json string to js object

            //string jsonString = "[{\"firstName\":\"Todd\",\"lastName\":\"Grover\",\"gender\":\"Male\",\"salary\":50000},{\"firstName\":\"Sara\",\"lastName\":\"Baker\",\"gender\":\"Female\",\"salary\":40000}]";

            //JavaScriptSerializer javaScriptSerializer = new JavaScriptSerializer();
            //List<Employee> employees = (List<Employee>)javaScriptSerializer.Deserialize(jsonString, typeof(List<Employee>));

            //foreach (Employee employee in employees)
            //{
            //    Response.Write("First Name = " + employee.firstName + "<br/>");
            //    Response.Write("Last Name = " + employee.lastName + "<br/>");
            //    Response.Write("Gender = " + employee.gender + "<br/>");
            //    Response.Write("Salary = " + employee.salary + "<br/><br/>");
            //}
        }
    }
}

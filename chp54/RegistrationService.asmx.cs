using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.Script.Serialization;

namespace chp54
{
    /// <summary>
    /// Summary description for RegistrationService
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    // To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
    [System.Web.Script.Services.ScriptService]

    public class RegistrationService : System.Web.Services.WebService
    {
        //[WebMethod]
        public bool UserNameExists(string username)
        {
            string cs = ConfigurationManager.ConnectionStrings["DBCS"].ConnectionString;
            using (SqlConnection con = new SqlConnection())
            {
                SqlCommand cmd = new SqlCommand("spUserNameExists", con);
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.Add(new SqlParameter()
                {
                    ParameterName = "@UserName",
                    Value = username
                });

                con.Open();
                return Convert.ToBoolean(cmd.ExecuteScalar());
            }
           
        }

        [WebMethod]
        public void GetAvailableUserName(string userName)
        {
            Registration reg = new Registration();
            reg.UserNameInUse = false;

            while(UserNameExists(userName))
            {
                Random random = new Random();
                int randomNo = random.Next(1, 100);
                userName = userName + randomNo.ToString();
                reg.UserNameInUse = true;
            }

            reg.UserName = userName;

            JavaScriptSerializer js = new JavaScriptSerializer();
            Context.Response.Write(js.Serialize(reg));
        }
    }
}

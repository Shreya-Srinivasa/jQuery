using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.Script.Serialization;
using System.Web.Services;

namespace chp54.Chp82
{
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    [System.Web.Script.Services.ScriptService]
    public class TooltipService : System.Web.Services.WebService
    {
        [WebMethod]
        public void GetTooltip(string fieldName)
        {
            string cs = ConfigurationManager.ConnectionStrings["DBCS"].ConnectionString;
            Tooltip tooltip = new Tooltip();

            using (SqlConnection con = new SqlConnection(cs))
            {
                SqlCommand cmd = new SqlCommand("spGetTooltip", con);
                cmd.CommandType = CommandType.StoredProcedure;

                SqlParameter parameter = new SqlParameter();
                parameter.ParameterName = "@FieldName";
                parameter.Value = fieldName;
                cmd.Parameters.Add(parameter);

                con.Open();
                SqlDataReader rdr = cmd.ExecuteReader();
                while (rdr.Read())
                {
                    tooltip.FieldName = rdr["FieldName"].ToString();
                    tooltip.TooltipText = rdr["TooltipText"].ToString();
                }
            }

            JavaScriptSerializer js = new JavaScriptSerializer();
            Context.Response.Write(js.Serialize(tooltip));
        }
    }
}

using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.Script.Serialization;
using System.Xml.Serialization;

namespace chp54
{
    public class HelpText
    {
        public string Key { get; set; }
        public string Text { get; set; }

        public partial class GetHelpText : System.Web.UI.Page
        {
            protected void Page_Load(object sender, EventArgs e)
            {
                Response.ContentType = "text/xml";
                XmlSerializer xmlSerializer = new XmlSerializer(typeof(HelpText));
                xmlSerializer.Serialize(Response.OutputStream, GetHelpTextByKey(Request["HelpTextKey"]));

                //chp 57
                //JavaScriptSerializer js = new JavaScriptSerializer();
                //string jsonString = js.Serialize(GetHelpTextByKey(Request["HelpTextKey"]));
                //Response.Write(jsonString);
            }

            private HelpText GetHelpTextByKey(string key)
            {
                HelpText helpText = new HelpText();

                string cs = ConfigurationManager.ConnectionStrings["DBCS"].ConnectionString;
                using (SqlConnection con = new SqlConnection(cs))
                {
                    SqlCommand cmd = new SqlCommand("spGetHelpTextByKey", con);
                    cmd.CommandType = CommandType.StoredProcedure;
                    SqlParameter parameter = new SqlParameter("@HelpTextKey", key);
                    cmd.Parameters.Add(parameter);
                    con.Open();
                    helpText.Text = cmd.ExecuteScalar().ToString();
                    helpText.Key = key;
                }
                return helpText;
            }

        }
    }
}
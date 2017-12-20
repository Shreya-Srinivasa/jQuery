
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.Script.Serialization;
using System.Web.Services;

namespace chp54.Chp100
{
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    [System.Web.Script.Services.ScriptService]
    public class QuestionService : System.Web.Services.WebService
    {
        [WebMethod]
        public void GetQuestionData()
        {
            string cs = ConfigurationManager.ConnectionStrings["DBCS"].ConnectionString;
            QuestionPageData questionPageData = new QuestionPageData
            {
                QuestionOptions = new List<Option>(),
                AnswerOptions = new List<Option>()
            };
            using (SqlConnection con = new SqlConnection(cs))
            {
                SqlDataAdapter da = new SqlDataAdapter("GetQuestionDataById", con);
                da.SelectCommand.CommandType = CommandType.StoredProcedure;

                SqlParameter paramQuestionId = new SqlParameter()
                {
                    ParameterName = "@QuestionId",
                    Value = 1
                };
                da.SelectCommand.Parameters.Add(paramQuestionId);

                DataSet ds = new DataSet();
                da.Fill(ds);

                questionPageData.QuestionId = Convert.ToInt32(ds.Tables[0].Rows[0]["Id"]);
                questionPageData.QuestionText = ds.Tables[0].Rows[0]["QuestionText"].ToString();

                foreach (DataRow dr in ds.Tables[1].Rows)
                {
                    Option questionOption = new Option();
                    questionOption.Id = Convert.ToInt32(dr["Id"]);
                    questionOption.OptionText = dr["OptionText"].ToString();
                    questionOption.QuestionId = Convert.ToInt32(dr["QuestionId"]);
                    questionPageData.QuestionOptions.Add(questionOption);
                }

                foreach (DataRow dr in ds.Tables[2].Rows)
                {
                    Option answerOption = new Option();
                    answerOption.Id = Convert.ToInt32(dr["Id"]);
                    answerOption.OptionText = dr["OptionText"].ToString();
                    answerOption.QuestionId = Convert.ToInt32(dr["QuestionId"]);
                    questionPageData.AnswerOptions.Add(answerOption);
                }
            }

            JavaScriptSerializer js = new JavaScriptSerializer();
            Context.Response.Write(js.Serialize(questionPageData));
        }

        [WebMethod]
        public void GetAnswer()
        {
            string cs = ConfigurationManager.ConnectionStrings["DBCS"].ConnectionString;
            Answer answer = new Answer();
            using (SqlConnection con = new SqlConnection(cs))
            {
                SqlDataAdapter da = new SqlDataAdapter("GetAnswerByQuestionId", con);
                da.SelectCommand.CommandType = CommandType.StoredProcedure;

                SqlParameter paramQuestionId = new SqlParameter()
                {
                    ParameterName = "@QuestionId",
                    Value = 1
                };
                da.SelectCommand.Parameters.Add(paramQuestionId);

                DataSet ds = new DataSet();
                da.Fill(ds);

                answer.Id = Convert.ToInt32(ds.Tables[0].Rows[0]["Id"]);
                answer.AnswerText = ds.Tables[0].Rows[0]["Answer"].ToString();
                answer.QuestionId = Convert.ToInt32(ds.Tables[0].Rows[0]["QuestionId"]);
            }

            JavaScriptSerializer js = new JavaScriptSerializer();
            Context.Response.Write(js.Serialize(answer));
        }
    }
}
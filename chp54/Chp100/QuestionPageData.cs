using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace chp54.Chp100
{
    public class QuestionPageData
    {
        public int QuestionId { get; set; }
        public string QuestionText { get; set; }
        public List<Option> QuestionOptions { get; set; }
        public List<Option> AnswerOptions { get; set; }
    }
}
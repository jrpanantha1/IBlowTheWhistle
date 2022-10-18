using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;

namespace Dev.Project.WhistleBlower.Web.Assessment
{
    public class Evaluation
    {
        public static string GetFileContent(string fileName)
        {
            return File.ReadAllText(fileName);
        }

        public static string FindandReplaceContent(string orgString, string findString, string replaceString)
        {
            return orgString.Replace(findString, replaceString);
        }
        public static string GetEvalData(string category, double score)
        {
            string htmlContentPath = System.Web.Hosting.HostingEnvironment.MapPath(@"~/Assessment/htmlContent/");

            List<EvalObj> EvalData = new List<EvalObj> {

                new EvalObj{Category = "TRUST",MinScore = 0,MaxScore = 3.9,EvaluationText = Evaluation.GetFileContent(htmlContentPath + @"TRUST1-3.txt")},
                new EvalObj{Category = "TRUST",MinScore = 4,MaxScore = 7.9,EvaluationText = Evaluation.GetFileContent(htmlContentPath + @"TRUST4-7.txt")},
                new EvalObj{Category = "TRUST",MinScore = 8,MaxScore = 10,EvaluationText = Evaluation.GetFileContent(htmlContentPath + @"TRUST8-10.txt")},

                new EvalObj{Category = "IMPARTIALITY",MinScore = 0,MaxScore = 3.9,EvaluationText = Evaluation.GetFileContent(htmlContentPath + @"IMPARTIALITY1-3.txt")},
                new EvalObj{Category = "IMPARTIALITY",MinScore = 4,MaxScore = 7.9,EvaluationText = Evaluation.GetFileContent(htmlContentPath + @"IMPARTIALITY4-7.txt")},
                new EvalObj{Category = "IMPARTIALITY",MinScore = 8,MaxScore = 10,EvaluationText = Evaluation.GetFileContent(htmlContentPath + @"IMPARTIALITY8-10.txt")},

                new EvalObj{Category = "PROTECTION",MinScore = 0,MaxScore = 3.9,EvaluationText = Evaluation.GetFileContent(htmlContentPath + @"PROTECTION1-3.txt")},
                new EvalObj{Category = "PROTECTION",MinScore = 4,MaxScore = 7.9,EvaluationText = Evaluation.GetFileContent(htmlContentPath + @"PROTECTION4-7.txt")},
                new EvalObj{Category = "PROTECTION",MinScore = 8,MaxScore = 10,EvaluationText = Evaluation.GetFileContent(htmlContentPath + @"PROTECTION8-10.txt")},

            };

            var result = EvalData.FirstOrDefault(v => v.Category == category && (score <= v.MaxScore && score >= v.MinScore));

            return result.EvaluationText;
        }

    }
    public class EvalObj
    {
        public EvalObj()
        {
            MinScore = 0;
            MaxScore = 0;
            Category = string.Empty;
            EvaluationText = string.Empty; ;
        }

        public double MinScore { get; set; }
        public double MaxScore { get; set; }
        public string Category { get; set; }
        public string EvaluationText { get; set; }

    }
}
using Dev.Project.WhistleBlower.Web.Data;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using WhistleBlowerDAL;

namespace Dev.Project.WhistleBlower.Web.Models
{
    public class WhistleBlowMultipleColn
    {
        public ReportFraudDetails IncDetails { get; set; }
        public WitnessDetail[] witnessColn { get; set; }

    }
    public class ViewIncindetandWitnessDetails
    {
        public WhistleViewForm IncDetails { get; set; }
        public WitnessDetail[] witnessColn { get; set; }

    }
    public class SuccessClass
    {
        public string TransactionID { get; set; }
        public string AnonymousUserName { get; set; }
        public string AnonymousPassowrd { get; set; }
        public string ExistingAccountMessage { get; set; }
    }
}
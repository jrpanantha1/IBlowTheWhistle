using Dev.Project.WhistleBlower.Web.Data;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Text;
using System.Web.Http;
using WhistleBlowerDAL;

namespace Dev.Project.WhistleBlower.Web.Controllers
{
    public class ExchangeController : ApiController
    {
        [AllowAnonymous]
        public HttpResponseMessage PostEmail([FromBody] enquiryData enqDataObj)
        {
            try
            {
                string mailMessage = Utility.GetEmailTemplate("101");
                //mailMessage = string.Format(mailMessage, enqDataObj.FirstName, enqDataObj.LastName, enqDataObj.EmailAddress);
                StringBuilder sb = new StringBuilder();
                //sb.AppendFormat(mailMessage, enqDataObj.FirstName, enqDataObj.LastName, enqDataObj.EmailAddress);
                string mailMessageConstuct = string.Format(mailMessage, enqDataObj.FirstName, enqDataObj.LastName, enqDataObj.EmailAddress);
                Utility.SendEmail("support@iblowthewhistle.com", "I blow Whistle New Company Inquiry", mailMessageConstuct);
                return Request.CreateResponse(HttpStatusCode.OK, "Email Send successfully");
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.BadRequest, "Error while send email");
            }

        }
        public partial class enquiryData
        {
            public string FirstName { get; set; }
            public string LastName { get; set; }
            public string EmailAddress { get; set; }
        }

    }
}

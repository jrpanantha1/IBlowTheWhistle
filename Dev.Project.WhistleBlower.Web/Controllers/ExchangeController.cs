using Dev.Project.WhistleBlower.Web.Data;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Security.Claims;
using System.Text;
using System.Web.Http;
using WhistleBlowerDAL;

namespace Dev.Project.WhistleBlower.Web.Controllers
{
    public class ExchangeController : ApiController
    {
        private eformulus_IBTW_DBEntities db = new eformulus_IBTW_DBEntities();
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
        [Authorize]
        public HttpResponseMessage PostRouteToEMail([FromBody] routeEmailLink routeData, string IncID)
        {
            try
            {
                string mailMessage = Utility.GetEmailTemplate("102");
                //mailMessage = string.Format(mailMessage, enqDataObj.FirstName, enqDataObj.LastName, enqDataObj.EmailAddress);
                StringBuilder sb = new StringBuilder();

                string companyID = ((ClaimsIdentity)User.Identity).Claims.FirstOrDefault(x => x.Type == "companyID").Value;
                var encPassword = db.CompanyMasters.FirstOrDefault(e => e.CURN.ToString() == companyID).encPassword;

                //sb.AppendFormat(mailMessage, enqDataObj.FirstName, enqDataObj.LastName, enqDataObj.EmailAddress);

                var whistleBlowIncident = db.WhistleBlowIncidents.Where(d => d.IURN.ToString() == IncID).FirstOrDefault();
                try
                {
                    if (whistleBlowIncident != null)
                    {
                        var rEvidenceDetails = whistleBlowIncident.EvidenceDetails != null && whistleBlowIncident.EvidenceDetails != "" ? Cipher.Decrypt(whistleBlowIncident.EvidenceDetails, encPassword) : "";
                        var rComments = whistleBlowIncident.Comments != "" && whistleBlowIncident.Comments != null ? Cipher.Decrypt(whistleBlowIncident.Comments, encPassword) : "";
                        var rEmail = whistleBlowIncident.Email != "" && whistleBlowIncident.Email != null ? Cipher.Decrypt(whistleBlowIncident.Email, encPassword) : "";
                        var rPhone = whistleBlowIncident.Phone != "" && whistleBlowIncident.Phone != null ? Cipher.Decrypt(whistleBlowIncident.Phone, encPassword) : "";
                        var rAnonymousEmailID = whistleBlowIncident.AnonymousEmailID != "" && whistleBlowIncident.AnonymousEmailID != null ? Cipher.Decrypt(whistleBlowIncident.AnonymousEmailID, encPassword) : "";
                        var rIsReportable = whistleBlowIncident.IsReportable == true ? "Yes" : "No";
                        var rSupportingEvidence = whistleBlowIncident.SupportingEvidence == true ? "Yes" : "No";
                        var rHaveWitness = whistleBlowIncident.HaveWitness == true ? "Yes" : "No";
                        var rUpdatedOnIncident = whistleBlowIncident.UpdatedOnIncident == true ? "Yes" : "No";


                        string mailMessageConstuct = string.Format(mailMessage, routeData.SenderName, whistleBlowIncident.IURN.ToString(),
                            rEvidenceDetails,
                           rComments,
                            rIsReportable,
                            rSupportingEvidence,
                            rHaveWitness,
                            rUpdatedOnIncident,
                            rEmail,
                            rPhone,
                            rAnonymousEmailID,
                            whistleBlowIncident.SubmissionDateTime.ToString());

                        Utility.SendEmail("support@iblowthewhistle.com", "Route To Eamil - " + IncID + "", mailMessageConstuct);
                    }
                }
                catch (Exception ex)
                {

                    throw ex;
                }


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

        public partial class routeEmailLink
        {
            public string hLink { get; set; }
            public string SenderName { get; set; }

        }

    }
}

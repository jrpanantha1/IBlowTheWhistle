using Dev.Project.WhistleBlower.Web.Data;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Security.Claims;
using System.Web.Http;
using WhistleBlowerDAL;

namespace Dev.Project.WhistleBlower.Web.Controllers
{
    public class ManageCompanyController : ApiController
    {
        [Authorize]
        public HttpResponseMessage GetCheckActiveUsers(string companyID)
        {

            try
            {
                using (eformulus_IBTW_DBEntities Entities = new eformulus_IBTW_DBEntities())
                {
                    var companyCheck = Entities.CompanyMasters.Where(e => e.CURN.ToString() == companyID);

                    if (companyCheck.Count() > 0)
                    {
                        return Request.CreateResponse(HttpStatusCode.OK, true);
                    }
                    else
                    {
                        return Request.CreateResponse(HttpStatusCode.OK, false);
                    }
                }
            }
            catch (Exception ex)
            {
                return Request.CreateResponse(HttpStatusCode.OK, false);
            }

        }
        [Authorize]
        public IEnumerable<LanguageDetail> GetFormLableText(string formID, int langID)
        {

            try
            {
                var data = new List<LanguageDetail>();


                using (eformulus_IBTW_DBEntities Entities = new eformulus_IBTW_DBEntities())
                {
                    var lngDetails = (from lm in Entities.LanguageMasters
                                      join ld in Entities.LanguageDetails on lm.LanguageID equals ld.LanguageID
                                      where lm.LanguageID == langID
                                      select ld).ToList();
                    data = lngDetails;

                }
                return data;
            }
            catch (Exception ex)
            {
                return null;
            }

        }
        [Authorize]
        public string PostIncidents([FromBody]ReportFraudDetails WhistleBlowDetail)
        {
            try
            {
                string traxID = "";
                if (WhistleBlowDetail != null)
                {
                    using (eformulus_IBTW_DBEntities Entities = new eformulus_IBTW_DBEntities())
                    {

                        string companyID = ((ClaimsIdentity)User.Identity).Claims.FirstOrDefault(x => x.Type == "companyID").Value;
                        string encPassword = ((ClaimsIdentity)User.Identity).Claims.FirstOrDefault(x => x.Type == "encPassword").Value;


                        Guid companyIURN = Guid.NewGuid();

                        WhistleBlowIncident objWhistleBlow = new WhistleBlowIncident();
                        objWhistleBlow.IURN = companyIURN;
                        traxID = companyIURN.ToString();

                        objWhistleBlow.CompanyID = new Guid(companyID);
                        objWhistleBlow.IsReportable = WhistleBlowDetail.IsReportable;
                        objWhistleBlow.SupportingEvidence = WhistleBlowDetail.SupportingEvidence;
                        objWhistleBlow.EvidenceDetails = Cipher.Encrypt(WhistleBlowDetail.EvidenceDetails, encPassword);
                        objWhistleBlow.FileAttachment = WhistleBlowDetail.FileAttachment;
                        objWhistleBlow.HaveWitness = WhistleBlowDetail.HaveWitness;
                        objWhistleBlow.UpdatedOnIncident = WhistleBlowDetail.UpdatedOnIncident;
                        objWhistleBlow.UpdatedOnIncidentMethod = WhistleBlowDetail.UpdatedOnIncidentMethod;
                        objWhistleBlow.Email = Cipher.Encrypt(WhistleBlowDetail.Email, encPassword);
                        objWhistleBlow.Phone = Cipher.Encrypt(WhistleBlowDetail.Phone, encPassword);
                        objWhistleBlow.EvidenceCanBeUsedForInvestigation = WhistleBlowDetail.EvidenceCanBeUsedForInvestigation;
                        objWhistleBlow.SupportingDocuments = Cipher.Encrypt(WhistleBlowDetail.SupportingDocuments, encPassword);

                        objWhistleBlow.Comments = Cipher.Encrypt(WhistleBlowDetail.Comments, encPassword);
                        objWhistleBlow.SubmissionDateTime = DateTime.Today;
                        objWhistleBlow.SubmissionModifiedDate = DateTime.Today;

                        Entities.WhistleBlowIncidents.Add(objWhistleBlow);
                        Entities.SaveChanges();

                        if (WhistleBlowDetail.WitnessFullName != null && WhistleBlowDetail.WitnessFullName != "")
                        {
                            WitnessDetail objWitnesDestails = new WitnessDetail();

                            objWitnesDestails.IURN = companyIURN;
                            companyIURN = Guid.NewGuid();
                            objWitnesDestails.WURN = companyIURN;
                            objWitnesDestails.FullName = Cipher.Encrypt(WhistleBlowDetail.WitnessFullName, encPassword);
                            objWitnesDestails.Email = Cipher.Encrypt(WhistleBlowDetail.WitnessEmail, encPassword);
                            objWitnesDestails.Phone = Cipher.Encrypt(WhistleBlowDetail.WitnessPhone, encPassword);
                            objWitnesDestails.WitnessModifiedDate = DateTime.Today;

                            Entities.WitnessDetails.Add(objWitnesDestails);
                            Entities.SaveChanges();
                        }
                        if (WhistleBlowDetail.Email != null && WhistleBlowDetail.Email != "")
                        {
                            RegisteredUser objRegisteredUser = new RegisteredUser();

                            var result = Entities.RegisteredUsers.FirstOrDefault(u => u.Email.Equals(WhistleBlowDetail.Email));
                            if (result == null)
                            {
                                objRegisteredUser.CompanyID = new Guid(companyID);
                                Guid RegUserID = Guid.NewGuid();
                                objRegisteredUser.RegUserID = RegUserID;
                                objRegisteredUser.Email = WhistleBlowDetail.Email;
                                objRegisteredUser.Password = "Whistle@123";
                                Entities.RegisteredUsers.Add(objRegisteredUser);
                                Entities.SaveChanges();
                            }
                           
                        }
                    }
                }
                return traxID;
                //return Request.CreateResponse(HttpStatusCode.OK, "Incidents stored successfully");
            }
            catch (System.Data.Entity.Validation.DbEntityValidationException dbEx)
            {
                throw dbEx;
            }

        }
    }
}

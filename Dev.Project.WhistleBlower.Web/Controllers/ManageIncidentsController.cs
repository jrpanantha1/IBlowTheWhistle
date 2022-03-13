using Dev.Project.WhistleBlower.Web.Data;
using Dev.Project.WhistleBlower.Web.Models;
using Newtonsoft.Json.Linq;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Security.Claims;
using System.Web;
using System.Web.Http;
using System.Web.Http.Description;
using System.Web.Security;
using WhistleBlowerDAL;

namespace Dev.Project.WhistleBlower.Web.Controllers
{
    public class ManageIncidentsController : ApiController
    {
        private eformulus_IBTW_DBEntities db = new eformulus_IBTW_DBEntities();
        // GET: api/Test/5
        [ResponseType(typeof(WhistleBlowIncident))]
        [Authorize]
        public IHttpActionResult GetWhistleBlowIncident()
        {
            string emailID = User.Identity.Name;
            IncidentsPageContent objIncidentsPageContent = new IncidentsPageContent();

            try
            {
                string companyID = ((ClaimsIdentity)User.Identity).Claims.FirstOrDefault(x => x.Type == "companyID").Value;
                string AccType = ((ClaimsIdentity)User.Identity).Claims.FirstOrDefault(x => x.Type == "accType").Value;
                var objCM = db.CompanyMasters.FirstOrDefault(e => e.CURN.ToString() == companyID);
                if (objCM != null)
                {
                    objCM.CompanyKey = Cipher.Encrypt(objCM.CompanyKey, objCM.encPassword);
                    objIncidentsPageContent.CompanyValueNonEncrypt = objCM.CompanyValue;
                    objCM.CompanyValue = Cipher.Encrypt(objCM.CompanyValue, objCM.encPassword);

                    objIncidentsPageContent.objCompanyMasters = objCM;

                    string path = System.Web.Hosting.HostingEnvironment.MapPath(@"~/IBTWImages/" + companyID + "/CompanyBanners/");
                    if (System.IO.Directory.Exists(path))
                    {
                        string[] filePaths = Directory.GetFiles(path);
                        string consolidPaths = "";
                        foreach (string file in filePaths)
                        {
                            if (Path.GetFileName(file).Contains("CompanyTopBanner"))
                            {
                                //consolidPaths = path + Path.GetFileName(file);
                                consolidPaths = "/IBTWImages/" + companyID + "/CompanyBanners/" + Path.GetFileName(file);
                            }
                        }

                        objIncidentsPageContent.CompantTopBanners = consolidPaths;// String.Join(";", filePaths);

                    }

                }

                if (AccType == WhistleContants.anonymousUserAccountType || AccType == WhistleContants.normalUserAccountType)
                {
                    if (companyID != "")
                    {
                        var decryptEmailID = Cipher.Encrypt(emailID, objCM.encPassword);

                        var whistleBlowIncident = from r in db.WhistleBlowIncidents
                                     .Where(d => AccType == WhistleContants.anonymousUserAccountType ? d.AnonymousEmailID == decryptEmailID : d.Email == decryptEmailID).OrderByDescending(s => s.SubmissionDateTime)
                                                  select new
                                                  {
                                                      IURN = r.IURN,
                                                      IsReportable = r.IsReportable,
                                                      SupportingEvidence = r.SupportingEvidence,
                                                      HaveWitness = r.HaveWitness,
                                                      UpdatedOnIncident = r.UpdatedOnIncident,
                                                      SubmissionDateTime = r.SubmissionDateTime,
                                                      EvidenceDetails = r.EvidenceDetails,
                                                      Comments = r.Comments,
                                                      Phone = r.Phone,
                                                      AnonymousEmailID = r.AnonymousEmailID,
                                                      Count = db.AnonymousResponseHistories.Count(a => a.IURN == r.IURN && a.ViewStatus == false && a.commentBy != WhistleContants.anonymousUserAccountType),
                                                      IncCategory = r.IncCategory
                                                  };
                        if (whistleBlowIncident == null)
                        {
                            return NotFound();
                        }
                        List<WhistleIncidentWithHistoryCount> whictleIncObj = new List<WhistleIncidentWithHistoryCount>();
                        foreach (var item in whistleBlowIncident)
                        {
                            whictleIncObj.Add(new WhistleIncidentWithHistoryCount
                            {
                                IURN = item.IURN,
                                IsReportable = item.IsReportable,
                                SupportingEvidence = item.SupportingEvidence,
                                HaveWitness = item.HaveWitness,
                                UpdatedOnIncident = item.UpdatedOnIncident,
                                SubmissionDateTime = item.SubmissionDateTime,
                                EvidenceDetails = item.EvidenceDetails != "" ? Cipher.Decrypt(item.EvidenceDetails, objCM.encPassword) : "",
                                Comments = item.Comments != "" ? Cipher.Decrypt(item.Comments, objCM.encPassword) : "",
                                Phone = item.Phone != "" ? Cipher.Decrypt(item.Phone, objCM.encPassword) : "",
                                AnonymousEmailID = item.AnonymousEmailID != "" ? Cipher.Decrypt(item.AnonymousEmailID, objCM.encPassword) : "",
                                HistoryCount = item.Count.ToString(),
                                IncCategory = item.IncCategory
                            });
                        }

                        //var whistleBlowIncident = db.WhistleBlowIncidents.Where(d => AccType == WhistleContants.anonymousUserAccountType ? d.AnonymousEmailID == decryptEmailID : d.Email == decryptEmailID).OrderByDescending(s => s.SubmissionDateTime);

                        //if (whistleBlowIncident == null)
                        //{
                        //    return NotFound();
                        //}
                        //foreach (var item in whistleBlowIncident)
                        //{
                        //    item.EvidenceDetails = item.EvidenceDetails != "" ? Cipher.Decrypt(item.EvidenceDetails, objCM.encPassword) : "";
                        //    item.Comments = item.Comments != "" ? Cipher.Decrypt(item.Comments, objCM.encPassword) : "";
                        //    item.Email = item.Email != "" ? Cipher.Decrypt(item.Email, objCM.encPassword) : "";
                        //    item.Phone = item.Phone != "" ? Cipher.Decrypt(item.Phone, objCM.encPassword) : "";
                        //    item.AnonymousEmailID = item.AnonymousEmailID != "" ? Cipher.Decrypt(item.AnonymousEmailID, objCM.encPassword) : "";
                        //}
                        objIncidentsPageContent.objWhistleBlowIncidents = whictleIncObj;
                        return Ok(objIncidentsPageContent);
                    }
                }
                else if (AccType == WhistleContants.AdminUserAccountType)
                {
                    if (companyID != "")
                    {

                        //var whistleBlowIncident = from r in db.WhistleBlowIncidents
                        //                          join t2 in db.AnonymousResponseHistories on r.IURN equals t2.IURN into def1
                        //                          from def2 in def1.DefaultIfEmpty()
                        //                           .Where(d => r.CompanyID.ToString() == companyID)
                        //                           .OrderByDescending(cc => cc.ResponseDate).
                        //                           Distinct()
                        //                          select new
                        //                          {
                        //                              IURN = r.IURN,
                        //                              IsReportable = r.IsReportable,
                        //                              SupportingEvidence = r.SupportingEvidence,
                        //                              HaveWitness = r.HaveWitness,
                        //                              UpdatedOnIncident = r.UpdatedOnIncident,
                        //                              SubmissionDateTime = r.SubmissionDateTime,
                        //                              EvidenceDetails = r.EvidenceDetails,
                        //                              Comments = r.Comments,
                        //                              Phone = r.Phone,
                        //                              AnonymousEmailID = r.AnonymousEmailID,
                        //                              Count = def1.Count()
                        //                          };

                        //whistleBlowIncident.OrderByDescending(ff => ff.SubmissionDateTime);

                        var whistleBlowIncident = from r in db.WhistleBlowIncidents
                                      .Where(d => d.CompanyID.ToString() == companyID).OrderByDescending(s => s.SubmissionDateTime)
                                                  select new
                                                  {
                                                      IURN = r.IURN,
                                                      IsReportable = r.IsReportable,
                                                      SupportingEvidence = r.SupportingEvidence,
                                                      HaveWitness = r.HaveWitness,
                                                      UpdatedOnIncident = r.UpdatedOnIncident,
                                                      SubmissionDateTime = r.SubmissionDateTime,
                                                      EvidenceDetails = r.EvidenceDetails,
                                                      Comments = r.Comments,
                                                      Phone = r.Phone,
                                                      AnonymousEmailID = r.AnonymousEmailID,
                                                      Count = db.AnonymousResponseHistories.Count(a => a.IURN == r.IURN && a.ViewStatus == false && a.commentBy == WhistleContants.anonymousUserAccountType),
                                                      IncCategory = r.IncCategory
                                                  };
                        if (whistleBlowIncident == null)
                        {
                            return NotFound();
                        }
                        List<WhistleIncidentWithHistoryCount> whictleIncObj = new List<WhistleIncidentWithHistoryCount>();
                        foreach (var item in whistleBlowIncident)
                        {
                            whictleIncObj.Add(new WhistleIncidentWithHistoryCount
                            {
                                IURN = item.IURN,
                                IsReportable = item.IsReportable,
                                SupportingEvidence = item.SupportingEvidence,
                                HaveWitness = item.HaveWitness,
                                UpdatedOnIncident = item.UpdatedOnIncident,
                                SubmissionDateTime = item.SubmissionDateTime,
                                EvidenceDetails = item.EvidenceDetails != "" ? Cipher.Decrypt(item.EvidenceDetails, objCM.encPassword) : "",
                                Comments = item.Comments != "" ? Cipher.Decrypt(item.Comments, objCM.encPassword) : "",
                                Phone = item.Phone != "" ? Cipher.Decrypt(item.Phone, objCM.encPassword) : "",
                                AnonymousEmailID = item.AnonymousEmailID != "" ? Cipher.Decrypt(item.AnonymousEmailID, objCM.encPassword) : "",
                                HistoryCount = item.Count.ToString(),
                                IncCategory = item.IncCategory
                            });
                        }


                        //var whistleBlowIncident = db.WhistleBlowIncidents.Where(d => d.CompanyID.ToString() == companyID).OrderByDescending(s => s.SubmissionDateTime).ToList();
                        //if (whistleBlowIncident == null)
                        //{
                        //    return NotFound();
                        //}
                        //foreach (var item in whistleBlowIncident)
                        //{
                        //    item.EvidenceDetails = item.EvidenceDetails != "" ? Cipher.Decrypt(item.EvidenceDetails, objCM.encPassword) : "";
                        //    item.Comments = item.Comments != "" ? Cipher.Decrypt(item.Comments, objCM.encPassword) : "";
                        //    item.Email = item.Email != "" ? Cipher.Decrypt(item.Email, objCM.encPassword) : "";
                        //    item.Phone = item.Phone != "" ? Cipher.Decrypt(item.Phone, objCM.encPassword) : "";
                        //    item.AnonymousEmailID = item.AnonymousEmailID != "" ? Cipher.Decrypt(item.AnonymousEmailID, objCM.encPassword) : "";
                        //}
                        objIncidentsPageContent.objWhistleBlowIncidents = whictleIncObj;
                        return Ok(objIncidentsPageContent);
                    }
                }
            }
            catch (Exception)
            {
                throw;
            }
            return NotFound();

        }

        [ResponseType(typeof(WhistleBlowIncident))]
        [Authorize]
        public IHttpActionResult GetWhistleBlowIncidentByIncCategory(string IncCategory, string SearchID)
        {
            string emailID = User.Identity.Name;
            IncidentsPageContent objIncidentsPageContent = new IncidentsPageContent();

            try
            {
                string companyID = ((ClaimsIdentity)User.Identity).Claims.FirstOrDefault(x => x.Type == "companyID").Value;
                string AccType = ((ClaimsIdentity)User.Identity).Claims.FirstOrDefault(x => x.Type == "accType").Value;
                var objCM = db.CompanyMasters.FirstOrDefault(e => e.CURN.ToString() == companyID);
                if (objCM != null)
                {
                    objCM.CompanyKey = Cipher.Encrypt(objCM.CompanyKey, objCM.encPassword);
                    objIncidentsPageContent.CompanyValueNonEncrypt = objCM.CompanyValue;
                    objCM.CompanyValue = Cipher.Encrypt(objCM.CompanyValue, objCM.encPassword);

                    objIncidentsPageContent.objCompanyMasters = objCM;

                    string path = System.Web.Hosting.HostingEnvironment.MapPath(@"~/IBTWImages/" + companyID + "/CompanyBanners/");
                    if (System.IO.Directory.Exists(path))
                    {
                        string[] filePaths = Directory.GetFiles(path);
                        string consolidPaths = "";
                        foreach (string file in filePaths)
                        {
                            if (Path.GetFileName(file).Contains("CompanyTopBanner"))
                            {
                                //consolidPaths = path + Path.GetFileName(file);
                                consolidPaths = "/IBTWImages/" + companyID + "/CompanyBanners/" + Path.GetFileName(file);
                            }
                        }

                        objIncidentsPageContent.CompantTopBanners = consolidPaths;// String.Join(";", filePaths);

                    }

                }

                if (AccType == WhistleContants.anonymousUserAccountType || AccType == WhistleContants.normalUserAccountType)
                {
                    if (companyID != "")
                    {
                        var decryptEmailID = Cipher.Encrypt(emailID, objCM.encPassword);

                        var whistleBlowIncident = from r in db.WhistleBlowIncidents
                                     .Where(d => AccType == WhistleContants.anonymousUserAccountType ? d.AnonymousEmailID == decryptEmailID : d.Email == decryptEmailID).OrderByDescending(s => s.SubmissionDateTime)
                                                  select new
                                                  {
                                                      IURN = r.IURN,
                                                      IsReportable = r.IsReportable,
                                                      SupportingEvidence = r.SupportingEvidence,
                                                      HaveWitness = r.HaveWitness,
                                                      UpdatedOnIncident = r.UpdatedOnIncident,
                                                      SubmissionDateTime = r.SubmissionDateTime,
                                                      EvidenceDetails = r.EvidenceDetails,
                                                      Comments = r.Comments,
                                                      Phone = r.Phone,
                                                      AnonymousEmailID = r.AnonymousEmailID,
                                                      Count = db.AnonymousResponseHistories.Count(a => a.IURN == r.IURN && a.ViewStatus == false && a.commentBy != WhistleContants.anonymousUserAccountType),
                                                      IncCategory = r.IncCategory
                                                  };
                        if (whistleBlowIncident == null)
                        {
                            return NotFound();
                        }
                        List<WhistleIncidentWithHistoryCount> whictleIncObj = new List<WhistleIncidentWithHistoryCount>();
                        foreach (var item in whistleBlowIncident)
                        {
                            whictleIncObj.Add(new WhistleIncidentWithHistoryCount
                            {
                                IURN = item.IURN,
                                IsReportable = item.IsReportable,
                                SupportingEvidence = item.SupportingEvidence,
                                HaveWitness = item.HaveWitness,
                                UpdatedOnIncident = item.UpdatedOnIncident,
                                SubmissionDateTime = item.SubmissionDateTime,
                                EvidenceDetails = item.EvidenceDetails != "" ? Cipher.Decrypt(item.EvidenceDetails, objCM.encPassword) : "",
                                Comments = item.Comments != "" ? Cipher.Decrypt(item.Comments, objCM.encPassword) : "",
                                Phone = item.Phone != "" ? Cipher.Decrypt(item.Phone, objCM.encPassword) : "",
                                AnonymousEmailID = item.AnonymousEmailID != "" ? Cipher.Decrypt(item.AnonymousEmailID, objCM.encPassword) : "",
                                HistoryCount = item.Count.ToString(),
                                IncCategory = item.IncCategory
                            });
                        }

                        objIncidentsPageContent.objWhistleBlowIncidents = whictleIncObj;
                        return Ok(objIncidentsPageContent);
                    }
                }
                else if (AccType == WhistleContants.AdminUserAccountType)
                {
                    if (companyID != "")
                    {


                        var whistleBlowIncident = from r in db.WhistleBlowIncidents
                                      .Where(d => d.CompanyID.ToString() == companyID && d.IncCategory == IncCategory).OrderByDescending(s => s.SubmissionDateTime)
                                                  select new
                                                  {
                                                      IURN = r.IURN,
                                                      IsReportable = r.IsReportable,
                                                      SupportingEvidence = r.SupportingEvidence,
                                                      HaveWitness = r.HaveWitness,
                                                      UpdatedOnIncident = r.UpdatedOnIncident,
                                                      SubmissionDateTime = r.SubmissionDateTime,
                                                      EvidenceDetails = r.EvidenceDetails,
                                                      Comments = r.Comments,
                                                      Phone = r.Phone,
                                                      AnonymousEmailID = r.AnonymousEmailID,
                                                      Count = db.AnonymousResponseHistories.Count(a => a.IURN == r.IURN && a.ViewStatus == false && a.commentBy == WhistleContants.anonymousUserAccountType),
                                                      IncCategory = r.IncCategory
                                                  };
                        if (whistleBlowIncident == null)
                        {
                            return NotFound();
                        }
                        List<WhistleIncidentWithHistoryCount> whictleIncObj = new List<WhistleIncidentWithHistoryCount>();
                        foreach (var item in whistleBlowIncident)
                        {
                            whictleIncObj.Add(new WhistleIncidentWithHistoryCount
                            {
                                IURN = item.IURN,
                                IsReportable = item.IsReportable,
                                SupportingEvidence = item.SupportingEvidence,
                                HaveWitness = item.HaveWitness,
                                UpdatedOnIncident = item.UpdatedOnIncident,
                                SubmissionDateTime = item.SubmissionDateTime,
                                EvidenceDetails = item.EvidenceDetails != "" ? Cipher.Decrypt(item.EvidenceDetails, objCM.encPassword) : "",
                                Comments = item.Comments != "" ? Cipher.Decrypt(item.Comments, objCM.encPassword) : "",
                                Phone = item.Phone != "" ? Cipher.Decrypt(item.Phone, objCM.encPassword) : "",
                                AnonymousEmailID = item.AnonymousEmailID != "" ? Cipher.Decrypt(item.AnonymousEmailID, objCM.encPassword) : "",
                                HistoryCount = item.Count.ToString(),
                                IncCategory = item.IncCategory
                            });
                        }


                        objIncidentsPageContent.objWhistleBlowIncidents = whictleIncObj;
                        return Ok(objIncidentsPageContent);
                    }
                }
            }
            catch (Exception)
            {
                throw;
            }
            return NotFound();

        }

        [ResponseType(typeof(WhistleViewForm))]
        [Authorize]
        public IHttpActionResult GetWhistleBlowIncidentByIURN(string IURN)
        {
            string companyID = ((ClaimsIdentity)User.Identity).Claims.FirstOrDefault(x => x.Type == "companyID").Value;
            var encPassword = db.CompanyMasters.FirstOrDefault(e => e.CURN.ToString() == companyID).encPassword;

            var whistleBlowIncident = db.WhistleBlowIncidents.Where(d => d.IURN.ToString() == IURN).ToList();
            var WhistleViewForm = new WhistleViewForm();
            List<WitnessDetail> lstItemWitness = new List<WitnessDetail>();
            WitnessDetail objWitness = new WitnessDetail();


            if (whistleBlowIncident == null)
            {
                return NotFound();
            }
            if (whistleBlowIncident.Count > 0)
            {
                WhistleViewForm.IURN = whistleBlowIncident[0].IURN;
                WhistleViewForm.SubmissionDateTime = whistleBlowIncident[0].SubmissionDateTime;
                WhistleViewForm.IsReportable = whistleBlowIncident[0].IsReportable;
                WhistleViewForm.SupportingEvidence = whistleBlowIncident[0].SupportingEvidence;
                WhistleViewForm.HaveWitness = whistleBlowIncident[0].HaveWitness;
                WhistleViewForm.FileAttachment = whistleBlowIncident[0].FileAttachment;
                WhistleViewForm.UpdatedOnIncident = whistleBlowIncident[0].UpdatedOnIncident;
                WhistleViewForm.UpdatedOnIncidentMethod = whistleBlowIncident[0].UpdatedOnIncidentMethod;
                WhistleViewForm.ReportedLanguageID = whistleBlowIncident[0].ReportedLanguageID != null ? whistleBlowIncident[0].ReportedLanguageID.ToString() : "1";

                //WhistleViewForm.SupportingDocuments = whistleBlowIncident[0].SupportingDocuments != null && whistleBlowIncident[0].SupportingDocuments != "" ? Cipher.Decrypt(whistleBlowIncident[0].SupportingDocuments, encPassword) : "";

                string path = System.Web.Hosting.HostingEnvironment.MapPath(@"~/IBTWImages/" + companyID + "/" + IURN + "/");
                if (System.IO.Directory.Exists(path))
                {
                    string[] filePaths = Directory.GetFiles(path);
                    string consolidPaths = "";
                    foreach (string file in filePaths)
                    {
                        consolidPaths += "/IBTWImages/" + companyID + "/" + IURN + "/" + Path.GetFileName(file) + ";";
                    }

                    WhistleViewForm.SupportingDocuments = consolidPaths;// String.Join(";", filePaths);

                }

                WhistleViewForm.EvidenceDetails = whistleBlowIncident[0].EvidenceDetails != null && whistleBlowIncident[0].EvidenceDetails != "" ? Cipher.Decrypt(whistleBlowIncident[0].EvidenceDetails, encPassword) : "";
                WhistleViewForm.Comments = whistleBlowIncident[0].Comments != "" && whistleBlowIncident[0].Comments != null ? Cipher.Decrypt(whistleBlowIncident[0].Comments, encPassword) : "";
                WhistleViewForm.Email = whistleBlowIncident[0].Email != "" && whistleBlowIncident[0].Email != null ? Cipher.Decrypt(whistleBlowIncident[0].Email, encPassword) : "";
                WhistleViewForm.Phone = whistleBlowIncident[0].Phone != "" && whistleBlowIncident[0].Phone != null ? Cipher.Decrypt(whistleBlowIncident[0].Phone, encPassword) : "";



                if (whistleBlowIncident[0].HaveWitness == true)
                {


                    var witnessIncident = db.WitnessDetails.OrderBy(s => s.WitnessModifiedDate).Where(d => d.IURN.ToString() == IURN).ToList();
                    foreach (var item in witnessIncident)
                    {
                        item.FullName = item.FullName != null && item.FullName != "" ? Cipher.Decrypt(item.FullName, encPassword) : "";
                        item.Email = item.Email != null && item.Email != "" ? Cipher.Decrypt(item.Email, encPassword) : "";
                        item.Phone = item.Phone != null && item.Phone != "" ? Cipher.Decrypt(item.Phone, encPassword) : "";
                        lstItemWitness.Add(item);
                    }

                }

            }

            ViewIncindetandWitnessDetails retunObj = new ViewIncindetandWitnessDetails();
            retunObj.IncDetails = WhistleViewForm;
            retunObj.witnessColn = lstItemWitness.ToArray();



            return Ok(retunObj);
            //return Ok(WhistleViewForm);

        }


        [Authorize]
        public IHttpActionResult PostIncidents(Object objData)
        {
            try
            {

                string emailIDNew = User.Identity.Name;

                List<WitnessDetail> lstItemWitness = new List<WitnessDetail>();
                List<SuccessClass> returnObj = new List<SuccessClass>();


                dynamic jsonData = objData;
                JObject IncidentJson = jsonData.IncDetails;
                JArray witnessDetailsJson = jsonData.witnessColn;
                var WhistleBlowDetail = IncidentJson.ToObject<ReportFraudDetails>();

                string traxID = "";
                string AnonyPassword = "";
                string passwordToBeReturned = "";

                if (WhistleBlowDetail != null)
                {
                    using (eformulus_IBTW_DBEntities Entities = new eformulus_IBTW_DBEntities())
                    {

                        string companyID = ((ClaimsIdentity)User.Identity).Claims.FirstOrDefault(x => x.Type == "companyID").Value;
                        if (companyID != "")
                        {

                            var encPassword = Entities.CompanyMasters.FirstOrDefault(e => e.CURN.ToString() == companyID).encPassword;


                            Guid IncidentIURN = Guid.NewGuid();

                            WhistleBlowIncident objWhistleBlow = new WhistleBlowIncident();
                            objWhistleBlow.IURN = IncidentIURN;
                            traxID = IncidentIURN.ToString();
                            objWhistleBlow.CompanyID = new Guid(companyID);
                            objWhistleBlow.IsReportable = WhistleBlowDetail.IsReportable;
                            objWhistleBlow.SupportingEvidence = WhistleBlowDetail.SupportingEvidence;
                            objWhistleBlow.EvidenceDetails = WhistleBlowDetail.EvidenceDetails != "" ? Cipher.Encrypt(WhistleBlowDetail.EvidenceDetails, encPassword) : DBNull.Value.ToString();
                            objWhistleBlow.FileAttachment = WhistleBlowDetail.FileAttachment;
                            objWhistleBlow.HaveWitness = WhistleBlowDetail.HaveWitness;
                            objWhistleBlow.UpdatedOnIncident = WhistleBlowDetail.UpdatedOnIncident;
                            objWhistleBlow.ReportedLanguageID = WhistleBlowDetail.ReportedLanguageID != null && WhistleBlowDetail.ReportedLanguageID != "" ? Convert.ToInt32(WhistleBlowDetail.ReportedLanguageID) : 1;
                            objWhistleBlow.IncCategory = "Unread";

                            string AnonymousEmailID = "";
                            string EmailExistMessage = "";
                            if (WhistleBlowDetail.UpdatedOnIncidentMethod == 3)//3 means Anonymous update progress
                            {
                                if (emailIDNew != null)
                                {
                                    AnonymousEmailID = emailIDNew;
                                }
                                else
                                    AnonymousEmailID = Utility.getRandomEmail() + "@Iblowthewhistle.com";

                                objWhistleBlow.AnonymousEmailID = Cipher.Encrypt(AnonymousEmailID, encPassword);

                            }
                            objWhistleBlow.UpdatedOnIncidentMethod = WhistleBlowDetail.UpdatedOnIncidentMethod;


                            objWhistleBlow.Email = WhistleBlowDetail.Email != "" ? Cipher.Encrypt(WhistleBlowDetail.Email, encPassword) : DBNull.Value.ToString();
                            objWhistleBlow.Phone = WhistleBlowDetail.Phone != "" ? Cipher.Encrypt(WhistleBlowDetail.Phone, encPassword) : DBNull.Value.ToString();
                            objWhistleBlow.EvidenceCanBeUsedForInvestigation = WhistleBlowDetail.EvidenceCanBeUsedForInvestigation;

                            //documnet updaload starts here maximum 3 documents
                            if (!string.IsNullOrEmpty(WhistleBlowDetail.SupportingDocuments))
                            {
                                if (!WhistleBlowDetail.SupportingDocuments.Contains(@"/IBTWImages/"))
                                {
                                    objWhistleBlow.SupportingDocuments = Utility.UploadImagefromBase64(WhistleBlowDetail.SupportingDocuments, traxID, companyID);
                                }
                            }
                            if (!string.IsNullOrEmpty(WhistleBlowDetail.SupportingDocuments1))
                            {
                                if (!WhistleBlowDetail.SupportingDocuments1.Contains(@"/IBTWImages/"))
                                {
                                    objWhistleBlow.SupportingDocuments = Utility.UploadImagefromBase64(WhistleBlowDetail.SupportingDocuments1, traxID, companyID);
                                }
                            }
                            if (!string.IsNullOrEmpty(WhistleBlowDetail.SupportingDocuments2))
                            {
                                if (!WhistleBlowDetail.SupportingDocuments2.Contains(@"/IBTWImages/"))
                                {
                                    objWhistleBlow.SupportingDocuments = Utility.UploadImagefromBase64(WhistleBlowDetail.SupportingDocuments2, traxID, companyID);
                                }
                            }
                            //objWhistleBlow.SupportingDocuments = WhistleBlowDetail.SupportingDocuments != "" ? Cipher.Encrypt(WhistleBlowDetail.SupportingDocuments, encPassword) : DBNull.Value.ToString();

                            objWhistleBlow.Comments = WhistleBlowDetail.Comments != "" ? Cipher.Encrypt(WhistleBlowDetail.Comments, encPassword) : DBNull.Value.ToString();
                            objWhistleBlow.SubmissionDateTime = System.DateTime.Now;// Today;
                            objWhistleBlow.SubmissionModifiedDate = DateTime.Now;

                            Entities.WhistleBlowIncidents.Add(objWhistleBlow);
                            Entities.SaveChanges();




                            //insert witness detaiuls here
                            foreach (var item in witnessDetailsJson)
                            {
                                lstItemWitness.Add(item.ToObject<WitnessDetail>());
                            }
                            foreach (var objWitnesDestails in lstItemWitness)
                            {
                                objWitnesDestails.IURN = IncidentIURN;
                                var witnessURN = Guid.NewGuid();
                                objWitnesDestails.WURN = witnessURN;
                                objWitnesDestails.FullName = objWitnesDestails.FullName != "" ? Cipher.Encrypt(objWitnesDestails.FullName, encPassword) : DBNull.Value.ToString();
                                objWitnesDestails.Email = objWitnesDestails.Email != "" ? Cipher.Encrypt(objWitnesDestails.Email, encPassword) : DBNull.Value.ToString();
                                objWitnesDestails.Phone = objWitnesDestails.Phone != "" ? Cipher.Encrypt(objWitnesDestails.Phone, encPassword) : DBNull.Value.ToString();
                                objWitnesDestails.WitnessModifiedDate = DateTime.Now;

                                Entities.WitnessDetails.Add(objWitnesDestails);
                                Entities.SaveChanges();
                            }

                            RegisteredUser objRegisteredUser = new RegisteredUser();
                            string strRegUserID = "";

                            //if (WhistleBlowDetail.Email == null || WhistleBlowDetail.Email == "")
                            //{
                            //    if (emailIDNew != null)
                            //    {
                            //        WhistleBlowDetail.Email = emailIDNew;
                            //    }
                            //}

                            if (WhistleBlowDetail.Email != null && WhistleBlowDetail.Email != "")//update progress by email given
                            {
                                objRegisteredUser = new RegisteredUser();

                                var result = Entities.RegisteredUsers.FirstOrDefault(u => u.Email.Equals(WhistleBlowDetail.Email));
                                if (result == null)
                                {
                                    objRegisteredUser.CompanyID = new Guid(companyID);
                                    Guid RegUserID = Guid.NewGuid();
                                    //strRegUserID = RegUserID.ToString();
                                    objRegisteredUser.RegUserID = RegUserID;
                                    objRegisteredUser.Email = AnonymousEmailID = WhistleBlowDetail.Email;

                                    string RandomPasswordTobeUpdated = passwordToBeReturned = Membership.GeneratePassword(WhistleContants.PasswordLength, WhistleContants.PasswordNumericCharLength);
                                    RandomPasswordTobeUpdated = Cipher.EncryptPassword(RandomPasswordTobeUpdated, encPassword);


                                    objRegisteredUser.Password = AnonyPassword = RandomPasswordTobeUpdated;//Membership.GeneratePassword(WhistleContants.PasswordLength, WhistleContants.PasswordNumericCharLength);// WhistleContants.userPassword;
                                    objRegisteredUser.AcctType = WhistleContants.normalUserAccountType;
                                    Entities.RegisteredUsers.Add(objRegisteredUser);
                                    Entities.SaveChanges();
                                }
                                else
                                {
                                    EmailExistMessage = WhistleContants.AccountExistMessage;
                                }

                            }
                            if (objWhistleBlow.UpdatedOnIncidentMethod == 3 && emailIDNew == null)//Anonymous update progress
                            {

                                objRegisteredUser = new RegisteredUser();
                                objRegisteredUser.CompanyID = new Guid(companyID);
                                Guid RegUserID = Guid.NewGuid();
                                //strRegUserID = RegUserID.ToString();
                                objRegisteredUser.RegUserID = RegUserID;
                                objRegisteredUser.Email = AnonymousEmailID; //Utility.getRandomEmail() + "@ibtw.com";

                                string RandomPasswordTobeUpdated = passwordToBeReturned = Membership.GeneratePassword(WhistleContants.PasswordLength, WhistleContants.PasswordNumericCharLength);
                                RandomPasswordTobeUpdated = Cipher.EncryptPassword(RandomPasswordTobeUpdated, encPassword);


                                objRegisteredUser.Password = AnonyPassword = RandomPasswordTobeUpdated;// Membership.GeneratePassword(WhistleContants.PasswordLength, WhistleContants.PasswordNumericCharLength); //WhistleContants.userPassword;
                                objRegisteredUser.AcctType = WhistleContants.anonymousUserAccountType;
                                Entities.RegisteredUsers.Add(objRegisteredUser);
                                Entities.SaveChanges();

                            }

                            //Add default entry into case  management for this created Incident URN
                            string emailID = User.Identity.Name;
                            //var userInfo = db.RegisteredUsers.FirstOrDefault(d => d.Email == emailID);
                            var caseInfo = db.CaseManagements.FirstOrDefault(d => d.IURN == IncidentIURN);
                            if (caseInfo == null)
                            {

                                CaseManagement objCase = new CaseManagement();
                                objCase.CaseURN = Guid.NewGuid();
                                objCase.IURN = IncidentIURN;
                                objCase.CompanyURN = new Guid(companyID);
                                //objCase.RegUserID = userInfo.RegUserID;
                                objCase.CaseInformation = WhistleBlowDetail.HaveWitness == true ? "New incident has been registered with witness" : "New incident has been registered without witness";
                                objCase.CaseUpdated = System.DateTime.Now;
                                db.CaseManagements.Add(objCase);
                                db.SaveChanges();
                            }

                            returnObj = new List<SuccessClass>
                            {
                                new SuccessClass { TransactionID = traxID, AnonymousUserName = AnonymousEmailID, AnonymousPassowrd = passwordToBeReturned,ExistingAccountMessage = EmailExistMessage }

                            };
                        }
                    }
                }



                //return traxID;
                return Ok(returnObj);
            }
            catch (System.Data.Entity.Validation.DbEntityValidationException dbEx)
            {
                throw dbEx;
            }

        }

        [Authorize]
        public IHttpActionResult PutIncidents(string IURN, string status)
        {
            try
            {
                var whistleBlowIncident = db.WhistleBlowIncidents.FirstOrDefault(d => d.IURN.ToString() == IURN);
                if (whistleBlowIncident != null)
                {
                    string currrentStatus = whistleBlowIncident.IncCategory;
                    if (currrentStatus != status)
                    {
                        whistleBlowIncident.IncCategory = status;
                        db.SaveChanges();
                    }

                }
                return Ok("Success");
            }
            catch (Exception)
            {

                throw;
            }

        }
        protected override void Dispose(bool disposing)
        {
            if (disposing)
            {
                db.Dispose();
            }
            base.Dispose(disposing);
        }

        private bool WhistleBlowIncidentExists(Guid id)
        {
            return db.WhistleBlowIncidents.Count(e => e.IURN == id) > 0;
        }

        #region backupcode
        //[Authorize]
        //public string PostIncidents([FromBody]ReportFraudDetails WhistleBlowDetail)
        //{
        //    try
        //    {
        //        string traxID = "";
        //        if (WhistleBlowDetail != null)
        //        {
        //            using (eformulus_IBTW_DBEntities Entities = new eformulus_IBTW_DBEntities())
        //            {

        //                string companyID = ((ClaimsIdentity)User.Identity).Claims.FirstOrDefault(x => x.Type == "companyID").Value;
        //                if (companyID != "")
        //                {

        //                    var encPassword = Entities.CompanyMasters.FirstOrDefault(e => e.CURN.ToString() == companyID).encPassword;


        //                    Guid companyIURN = Guid.NewGuid();

        //                    WhistleBlowIncident objWhistleBlow = new WhistleBlowIncident();
        //                    objWhistleBlow.IURN = companyIURN;
        //                    traxID = companyIURN.ToString();

        //                    objWhistleBlow.CompanyID = new Guid(companyID);
        //                    objWhistleBlow.IsReportable = WhistleBlowDetail.IsReportable;
        //                    objWhistleBlow.SupportingEvidence = WhistleBlowDetail.SupportingEvidence;
        //                    objWhistleBlow.EvidenceDetails = WhistleBlowDetail.EvidenceDetails != "" ? Cipher.Encrypt(WhistleBlowDetail.EvidenceDetails, encPassword) : DBNull.Value.ToString();
        //                    objWhistleBlow.FileAttachment = WhistleBlowDetail.FileAttachment;
        //                    objWhistleBlow.HaveWitness = WhistleBlowDetail.HaveWitness;
        //                    objWhistleBlow.UpdatedOnIncident = WhistleBlowDetail.UpdatedOnIncident;

        //                    string AnonymousEmailID = "";
        //                    if (WhistleBlowDetail.UpdatedOnIncidentMethod == 3)
        //                    {
        //                        AnonymousEmailID = Utility.getRandomEmail() + "@ibtw.com";
        //                        objWhistleBlow.AnonymousEmailID = Cipher.Encrypt(AnonymousEmailID, encPassword);

        //                    }
        //                    objWhistleBlow.UpdatedOnIncidentMethod = WhistleBlowDetail.UpdatedOnIncidentMethod;
        //                    objWhistleBlow.Email = WhistleBlowDetail.Email != "" ? Cipher.Encrypt(WhistleBlowDetail.Email, encPassword) : DBNull.Value.ToString();
        //                    objWhistleBlow.Phone = WhistleBlowDetail.Phone != "" ? Cipher.Encrypt(WhistleBlowDetail.Phone, encPassword) : DBNull.Value.ToString();
        //                    objWhistleBlow.EvidenceCanBeUsedForInvestigation = WhistleBlowDetail.EvidenceCanBeUsedForInvestigation;
        //                    objWhistleBlow.SupportingDocuments = WhistleBlowDetail.SupportingDocuments != "" ? Cipher.Encrypt(WhistleBlowDetail.SupportingDocuments, encPassword) : DBNull.Value.ToString();

        //                    objWhistleBlow.Comments = WhistleBlowDetail.Comments != "" ? Cipher.Encrypt(WhistleBlowDetail.Comments, encPassword) : DBNull.Value.ToString();
        //                    objWhistleBlow.SubmissionDateTime = System.DateTime.Now;// Today;
        //                    objWhistleBlow.SubmissionModifiedDate = DateTime.Now;

        //                    Entities.WhistleBlowIncidents.Add(objWhistleBlow);
        //                    Entities.SaveChanges();

        //                    if (WhistleBlowDetail.WitnessFullName != null && WhistleBlowDetail.WitnessFullName != "")
        //                    {
        //                        WitnessDetail objWitnesDestails = new WitnessDetail();

        //                        objWitnesDestails.IURN = companyIURN;
        //                        companyIURN = Guid.NewGuid();
        //                        objWitnesDestails.WURN = companyIURN;
        //                        objWitnesDestails.FullName = WhistleBlowDetail.WitnessFullName != "" ? Cipher.Encrypt(WhistleBlowDetail.WitnessFullName, encPassword) : DBNull.Value.ToString();
        //                        objWitnesDestails.Email = WhistleBlowDetail.WitnessEmail != "" ? Cipher.Encrypt(WhistleBlowDetail.WitnessEmail, encPassword) : DBNull.Value.ToString();
        //                        objWitnesDestails.Phone = WhistleBlowDetail.WitnessPhone != "" ? Cipher.Encrypt(WhistleBlowDetail.WitnessPhone, encPassword) : DBNull.Value.ToString();
        //                        objWitnesDestails.WitnessModifiedDate = DateTime.Now;

        //                        Entities.WitnessDetails.Add(objWitnesDestails);
        //                        Entities.SaveChanges();
        //                    }
        //                    RegisteredUser objRegisteredUser = new RegisteredUser();
        //                    if (WhistleBlowDetail.Email != null && WhistleBlowDetail.Email != "")
        //                    {
        //                        objRegisteredUser = new RegisteredUser();

        //                        var result = Entities.RegisteredUsers.FirstOrDefault(u => u.Email.Equals(WhistleBlowDetail.Email));
        //                        if (result == null)
        //                        {
        //                            objRegisteredUser.CompanyID = new Guid(companyID);
        //                            Guid RegUserID = Guid.NewGuid();
        //                            objRegisteredUser.RegUserID = RegUserID;
        //                            objRegisteredUser.Email = WhistleBlowDetail.Email;
        //                            objRegisteredUser.Password = WhistleContants.userPassword;
        //                            objRegisteredUser.AcctType = WhistleContants.normalUserAccountType;
        //                            Entities.RegisteredUsers.Add(objRegisteredUser);
        //                            Entities.SaveChanges();
        //                        }

        //                    }
        //                    if (objWhistleBlow.UpdatedOnIncidentMethod == 3)
        //                    {

        //                        objRegisteredUser = new RegisteredUser();
        //                        objRegisteredUser.CompanyID = new Guid(companyID);
        //                        Guid RegUserID = Guid.NewGuid();
        //                        objRegisteredUser.RegUserID = RegUserID;
        //                        objRegisteredUser.Email = AnonymousEmailID; //Utility.getRandomEmail() + "@ibtw.com";
        //                        objRegisteredUser.Password = WhistleContants.userPassword;
        //                        objRegisteredUser.AcctType = WhistleContants.anonymousUserAccountType;
        //                        Entities.RegisteredUsers.Add(objRegisteredUser);
        //                        Entities.SaveChanges();

        //                    }
        //                }
        //            }
        //        }
        //        return traxID;
        //        //return Request.CreateResponse(HttpStatusCode.OK, "Incidents stored successfully");
        //    }
        //    catch (System.Data.Entity.Validation.DbEntityValidationException dbEx)
        //    {
        //        throw dbEx;
        //    }

        //}
        #endregion
    }

    public class IncidentsPageContent
    {
        public IncidentsPageContent()
        {
            objCompanyMasters = null;
            objWhistleBlowIncidents = null;
            CompanyValueNonEncrypt = null;
        }

        public CompanyMaster objCompanyMasters { get; set; }
        public string CompanyValueNonEncrypt { get; set; }
        public List<WhistleIncidentWithHistoryCount> objWhistleBlowIncidents { get; set; }
        public string CompantTopBanners { get; set; }


    }
    public partial class WhistleIncidentWithHistoryCount
    {
        public System.Guid IURN { get; set; }
        public System.Guid CompanyID { get; set; }
        public Nullable<bool> IsReportable { get; set; }
        public Nullable<bool> SupportingEvidence { get; set; }
        public string EvidenceDetails { get; set; }
        public Nullable<bool> FileAttachment { get; set; }
        public Nullable<bool> HaveWitness { get; set; }
        public Nullable<bool> UpdatedOnIncident { get; set; }
        public Nullable<int> UpdatedOnIncidentMethod { get; set; }
        public string Email { get; set; }
        public string Phone { get; set; }
        public Nullable<bool> EvidenceCanBeUsedForInvestigation { get; set; }
        public string Comments { get; set; }
        public Nullable<System.DateTime> SubmissionDateTime { get; set; }
        public Nullable<System.DateTime> SubmissionModifiedDate { get; set; }
        public string SupportingDocuments { get; set; }
        public string AnonymousEmailID { get; set; }
        public string HistoryCount { get; set; }
        public string IncCategory { get; set; }
    }
}

using System;
using System.Collections;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Data.Entity;
using System.Data.Entity.Infrastructure;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Security.Claims;
using System.Web.Http;
using System.Web.Http.Description;
using WhistleBlowerDAL;

namespace Dev.Project.WhistleBlower.Web.Controllers
{
    public class LanguageDetailsByCompaniesController : ApiController
    {
        private eformulus_IBTW_DBEntities db = new eformulus_IBTW_DBEntities();

        // GET: api/LanguageDetailsByCompanies
        public IQueryable<LanguageDetailsByCompany> GetLanguageDetailsByCompanies()
        {
            return db.LanguageDetailsByCompanies;
        }

        // GET: api/LanguageDetailsByCompanies/5
        [ResponseType(typeof(LanguageDetailsByCompany))]
        public IHttpActionResult GetLanguageDetailsByCompany(int langID)
        {
            if (langID == 0)
            {
                langID = 1;
            }

            LanguageByCompanyPageContent objRetunLists = new LanguageByCompanyPageContent();
            string companyID = ((ClaimsIdentity)User.Identity).Claims.FirstOrDefault(x => x.Type == "companyID").Value;


            var lngDetails = (from lm in db.LanguageMasters
                              join ld in db.LanguageDetails on lm.LanguageID equals ld.LanguageID
                              where lm.LanguageID == langID
                              select ld).ToList();

            objRetunLists.objLangDetails = lngDetails;


            var cuslngDetails = (from lm in db.LanguageMasters
                                 join ld in db.LanguageDetailsByCompanies on lm.LanguageID equals ld.LanguageID
                                 where lm.LanguageID == langID & ld.CURN.ToString() == companyID
                                 select ld).ToList();
            objRetunLists.objLangPerCompany = cuslngDetails;


            //var finalLables = (from lm in db.LanguageMasters
            //                   join ldc in db.LanguageDetailsByCompanies on lm.LanguageID equals ldc.LanguageID
            //                   join ld in db.LanguageDetails on lm.LanguageID equals ld.LanguageID
            //                   where lm.LanguageID == langID
            //                   select new { ldc, ld }).ToList();






            //var element = lngDetails[0];

            //SortedList fslist = new SortedList();

            //Dictionary<string, List<string>> openWith = new Dictionary<string, List<string>>();
            //openWith.Add("notepad.exe", new List<string>() { ".txt", ".vbs", ".csv" });

            ////var columnnames = from t in typeof(LanguageDetail).GetProperties() select t.Name;

            //////System.Linq.SystemCore_EnumerableDebugView<string>(columnnames).Items[0]

            //var ff = element.GetType();
            //var PropertyInfo = ff.GetProperties();

            //if (cuslngDetails.Count > 0)
            //{
            //    foreach (var item in lngDetails)
            //    {

            //        foreach (var itemCus in cuslngDetails)
            //        {
            //            foreach (var pinfo in PropertyInfo)
            //            {
            //                var cc = pinfo.Name;
            //                var DefTeext = pinfo.GetValue(item, null).ToString();
            //                var CusTeext = pinfo.GetValue(itemCus, null).ToString();

            //                openWith.Add("text", new List<string>() { cc, DefTeext, CusTeext });

            //                fslist.Add(cc, DefTeext);

            //            }
            //        }
            //    }
            //}
            //else
            //{
            //    foreach (var item in lngDetails)
            //    {
            //        foreach (var pinfo in PropertyInfo)
            //        {
            //            var cc = pinfo.Name;
            //            var ccTeext = pinfo.GetValue(item, null);

            //            fslist.Add(cc, ccTeext);

            //        }
            //    }
            //}




            if (lngDetails == null)
            {
                return NotFound();
            }

            return Ok(objRetunLists);
        }

        // PUT: api/LanguageDetailsByCompanies/5
        [ResponseType(typeof(void))]
        public IHttpActionResult PutLanguageDetailsByCompany(Guid id, LanguageDetailsByCompany languageDetailsByCompany)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            if (id != languageDetailsByCompany.LangURN)
            {
                return BadRequest();
            }

            db.Entry(languageDetailsByCompany).State = EntityState.Modified;

            try
            {
                db.SaveChanges();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!LanguageDetailsByCompanyExists(id))
                {
                    return NotFound();
                }
                else
                {
                    throw;
                }
            }

            return StatusCode(HttpStatusCode.NoContent);
        }

        // POST: api/LanguageDetailsByCompanies
        [ResponseType(typeof(LanguageDetailsByCompany))]
        public IHttpActionResult PostLanguageDetailsByCompany(LanguageDetailsByCompany languageDetailsByCompany)
        {
            Guid newStatusID = Guid.NewGuid();
            string companyID = ((ClaimsIdentity)User.Identity).Claims.FirstOrDefault(x => x.Type == "companyID").Value;

            var avilableLables = db.LanguageDetailsByCompanies.Where(e => e.CURN.ToString() == companyID && e.LanguageID == languageDetailsByCompany.LanguageID).FirstOrDefault();
            if (avilableLables != null)
            {
                avilableLables.AckPolicy = languageDetailsByCompany.AckPolicy;
                avilableLables.AdditionalComments = languageDetailsByCompany.AdditionalComments;
                avilableLables.AnonymousUpdate = languageDetailsByCompany.AnonymousUpdate;
                avilableLables.AreYouWhistleBlower = languageDetailsByCompany.AreYouWhistleBlower;
                avilableLables.AServiceForm = languageDetailsByCompany.AServiceForm;
                avilableLables.AuthrizeDeclaration = languageDetailsByCompany.AuthrizeDeclaration;
                avilableLables.BrowseText = languageDetailsByCompany.BrowseText;
                avilableLables.ByEmailUpdate = languageDetailsByCompany.ByEmailUpdate;
                avilableLables.ByPhoneUpdate = languageDetailsByCompany.ByPhoneUpdate;
                avilableLables.CloseBtn = languageDetailsByCompany.CloseBtn;
                avilableLables.Comments = languageDetailsByCompany.Comments;
                avilableLables.ConcernDetailsPHT = languageDetailsByCompany.ConcernDetailsPHT;
                avilableLables.DoyouhaveanyDocument = languageDetailsByCompany.DoyouhaveanyDocument;
                avilableLables.EmailAddresslbl = languageDetailsByCompany.EmailAddresslbl;
                avilableLables.EvidenceCanBeUsedForInvestigation = languageDetailsByCompany.EvidenceCanBeUsedForInvestigation;
                avilableLables.EvidenceDetails = languageDetailsByCompany.EvidenceDetails;
                avilableLables.EvidenceDetailsPHT = languageDetailsByCompany.EvidenceDetailsPHT;
                avilableLables.HaveWitness = languageDetailsByCompany.HaveWitness;
                avilableLables.HowWouldUpdated = languageDetailsByCompany.HowWouldUpdated;
                avilableLables.IdentityNeverRevel = languageDetailsByCompany.IdentityNeverRevel;
                avilableLables.IsReportable = languageDetailsByCompany.IsReportable;
                avilableLables.No = languageDetailsByCompany.No;
                avilableLables.NoFileSelected = languageDetailsByCompany.NoFileSelected;
                avilableLables.Phone = languageDetailsByCompany.Phone;
                avilableLables.Phonelbl = languageDetailsByCompany.Phonelbl;
                avilableLables.PleaseSelect = languageDetailsByCompany.PleaseSelect;
                avilableLables.PrivacyPolicy = languageDetailsByCompany.PrivacyPolicy;
                avilableLables.ReportIncident = languageDetailsByCompany.ReportIncident;
                avilableLables.Signin = languageDetailsByCompany.Signin;
                avilableLables.SupportingEvidence = languageDetailsByCompany.SupportingEvidence;
                avilableLables.TermsofService = languageDetailsByCompany.TermsofService;
                avilableLables.UpdatedOnIncident = languageDetailsByCompany.UpdatedOnIncident;
                avilableLables.ViewDocumentsLnk = languageDetailsByCompany.ViewDocumentsLnk;
                avilableLables.WitnessEmail = languageDetailsByCompany.WitnessEmail;
                avilableLables.WitnessName = languageDetailsByCompany.WitnessName;
                avilableLables.WitnessPhone = languageDetailsByCompany.WitnessPhone;
                avilableLables.Yes = languageDetailsByCompany.Yes;

            }
            else
            {
                languageDetailsByCompany.LangURN = newStatusID;
                languageDetailsByCompany.CURN = new Guid(companyID);

                db.LanguageDetailsByCompanies.Add(languageDetailsByCompany);
            }


            try
            {
                db.SaveChanges();
                return Ok("Success");
            }
            catch (DbUpdateException)
            {
                if (LanguageDetailsByCompanyExists(languageDetailsByCompany.LangURN))
                {
                    return Conflict();
                }
                else
                {
                    throw;
                }
            }

            return CreatedAtRoute("DefaultApi", new { id = languageDetailsByCompany.LangURN }, languageDetailsByCompany);
        }

        // DELETE: api/LanguageDetailsByCompanies/5
        [ResponseType(typeof(LanguageDetailsByCompany))]
        public IHttpActionResult DeleteLanguageDetailsByCompany(int langID)
        {

            string companyID = ((ClaimsIdentity)User.Identity).Claims.FirstOrDefault(x => x.Type == "companyID").Value;

            var languageDetailsByCompany = (from lm in db.LanguageMasters
                                            join ld in db.LanguageDetailsByCompanies on lm.LanguageID equals ld.LanguageID
                                            where lm.LanguageID == langID & ld.CURN.ToString() == companyID
                                            select ld).FirstOrDefault();


            if (languageDetailsByCompany == null)
            {
                return NotFound();
            }

            db.LanguageDetailsByCompanies.Remove(languageDetailsByCompany);
            db.SaveChanges();

            return Ok("Success");
        }

        protected override void Dispose(bool disposing)
        {
            if (disposing)
            {
                db.Dispose();
            }
            base.Dispose(disposing);
        }

        private bool LanguageDetailsByCompanyExists(Guid id)
        {
            return db.LanguageDetailsByCompanies.Count(e => e.LangURN == id) > 0;
        }
    }
    public class LanguageByCompanyPageContent
    {
        public LanguageByCompanyPageContent()
        {
            objLangPerCompany = null;
            objLangDetails = null;
        }
        public List<LanguageDetailsByCompany> objLangPerCompany { get; set; }
        public List<LanguageDetail> objLangDetails { get; set; }
    }
}
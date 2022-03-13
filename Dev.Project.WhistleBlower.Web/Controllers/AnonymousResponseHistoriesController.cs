using Dev.Project.WhistleBlower.Web.Data;
using Dev.Project.WhistleBlower.Web.Models;
using System;
using System.Collections.Generic;
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
    public class AnonymousResponseHistoriesController : ApiController
    {
        private eformulus_IBTW_DBEntities db = new eformulus_IBTW_DBEntities();

        // GET: api/AnonymousResponseHistories
        public IQueryable<AnonymousResponseHistory> GetAnonymousResponseHistories()
        {
            return db.AnonymousResponseHistories;
        }

        // GET: api/AnonymousResponseHistories/5
        //strIURN Incident Unique Identifier
        [ResponseType(typeof(AnonymousResponseHistory))]
        public IHttpActionResult GetAnonymousResponseHistory(string strIURN)
        {
            var anonymousResponse = db.AnonymousResponseHistories.OrderBy(tt => tt.ResponseDate).Where(d => d.IURN.ToString() == strIURN).OrderBy(g => g.ResponseDate).ToList();
            string AccType = ((ClaimsIdentity)User.Identity).Claims.FirstOrDefault(x => x.Type == "accType").Value;

            if (anonymousResponse == null)
            {
                return NotFound();
            }

            if (AccType == WhistleContants.anonymousUserAccountType || AccType == WhistleContants.normalUserAccountType)
            {
                var updateAnonymousHistry = from x in db.AnonymousResponseHistories
                                            where x.IURN.ToString() == strIURN && x.commentBy == "Admin" && x.ViewStatus == false
                                            select x;


                // now use First or a loop if you expect multiple
                foreach (var updAnnoy in updateAnonymousHistry)
                    updAnnoy.ViewStatus = true;
                db.SaveChanges();
            }
            else
            {
                var updateAnonymousHistry = from x in db.AnonymousResponseHistories
                                            where x.IURN.ToString() == strIURN && x.commentBy != "Admin" && x.ViewStatus == false
                                            select x;

                // now use First or a loop if you expect multiple
                foreach (var updAnnoy in updateAnonymousHistry)
                    updAnnoy.ViewStatus = true;
                db.SaveChanges();
            }


            string companyID = ((ClaimsIdentity)User.Identity).Claims.FirstOrDefault(x => x.Type == "companyID").Value;
            var objCompanyMaster = db.CompanyMasters.Where(e => e.CURN.ToString() == companyID).Select(o => new { o.encPassword, o.CompanyName, o.CompanyLogo }).Distinct();
            string encPassword = "", companyName = "", companylogo = "";

            foreach (var comItem in objCompanyMaster)
            {
                encPassword = comItem.encPassword;
                companyName = comItem.CompanyName;


                companylogo = comItem.CompanyLogo;

            }

            List<AnonymousResponse> objAnonymous = new List<AnonymousResponse>();

            foreach (var item in anonymousResponse)
            {
                objAnonymous.Add(new AnonymousResponse
                {
                    Message = item.Message != "" ? Cipher.Decrypt(item.Message, encPassword) : "",
                    IURN = item.IURN,
                    RegUserID = item.RegUserID,
                    ResClusterID = item.ResClusterID,
                    ResponseDate = item.ResponseDate,
                    RURN = item.RURN,
                    ViewStatus = item.ViewStatus,
                    commentBy = item.commentBy,
                    companyName = companyName,
                    companyLogo = companylogo
                });

            }

            return Ok(objAnonymous);

        }

        // PUT: api/AnonymousResponseHistories/5
        [ResponseType(typeof(void))]
        public IHttpActionResult PutAnonymousResponseHistory(Guid id, AnonymousResponseHistory anonymousResponseHistory)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            if (id != anonymousResponseHistory.RURN)
            {
                return BadRequest();
            }

            db.Entry(anonymousResponseHistory).State = EntityState.Modified;

            try
            {
                db.SaveChanges();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!AnonymousResponseHistoryExists(id))
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

        // POST: api/AnonymousResponseHistories
        [ResponseType(typeof(AnonymousResponseHistory))]
        public IHttpActionResult PostAnonymousResponseHistory(AnonymousResponseHistory anonymousResponseHistory)
        {

            string regUserID = ((ClaimsIdentity)User.Identity).Claims.FirstOrDefault(x => x.Type == "regUserID").Value;
            string strIURN = "";//anonymousResponseHistory.IURN.ToString();
            if (regUserID == "")
            {
                return BadRequest("Invalid Request");
            }

            string companyID = ((ClaimsIdentity)User.Identity).Claims.FirstOrDefault(x => x.Type == "companyID").Value;
            string AccType = ((ClaimsIdentity)User.Identity).Claims.FirstOrDefault(x => x.Type == "accType").Value;
            //var encPassword = db.CompanyMasters.FirstOrDefault(e => e.CURN.ToString() == companyID).encPassword;
            var objCompanyMaster = db.CompanyMasters.Where(e => e.CURN.ToString() == companyID).Select(o => new { o.encPassword, o.CompanyName, o.CompanyLogo }).Distinct();
            string encPassword = "", companyName = "", companylogo = "";

            foreach (var comItem in objCompanyMaster)
            {
                encPassword = comItem.encPassword;
                companyName = comItem.CompanyName;
                companylogo = comItem.CompanyLogo;
            }

            if (companyID != "" && anonymousResponseHistory != null)
            {

                strIURN = anonymousResponseHistory.IURN.ToString();

                AnonymousResponseHistory objEncryptedAnonymous = new AnonymousResponseHistory();

                objEncryptedAnonymous.RURN = Guid.NewGuid();
                objEncryptedAnonymous.RegUserID = new Guid(regUserID);
                objEncryptedAnonymous.IURN = anonymousResponseHistory.IURN;
                objEncryptedAnonymous.Message = anonymousResponseHistory.Message != null && anonymousResponseHistory.Message != "" ? Cipher.Encrypt(anonymousResponseHistory.Message, encPassword) : "";
                objEncryptedAnonymous.ResponseDate = DateTime.Now;
                objEncryptedAnonymous.commentBy = AccType;
                objEncryptedAnonymous.ViewStatus = false;

                db.AnonymousResponseHistories.Add(objEncryptedAnonymous);
            }

            try
            {
                db.SaveChanges();

                var anonymousResponse = db.AnonymousResponseHistories.OrderBy(tt => tt.ResponseDate).Where(d => d.IURN.ToString() == strIURN).ToList();
                if (anonymousResponse == null)
                {
                    return NotFound();
                }

                List<AnonymousResponse> objAnonymous = new List<AnonymousResponse>();
                foreach (var item in anonymousResponse)
                {
                    objAnonymous.Add(new AnonymousResponse
                    {
                        Message = item.Message != "" ? Cipher.Decrypt(item.Message, encPassword) : "",
                        IURN = item.IURN,
                        RegUserID = item.RegUserID,
                        ResClusterID = item.ResClusterID,
                        ResponseDate = item.ResponseDate,
                        RURN = item.RURN,
                        ViewStatus = item.ViewStatus,
                        commentBy = item.commentBy,
                        companyName = companyName,
                        companyLogo = companylogo
                    });

                }
                return Ok(objAnonymous);
            }
            catch (DbUpdateException)
            {
                throw;
            }

        }

        // DELETE: api/AnonymousResponseHistories/5
        [ResponseType(typeof(AnonymousResponseHistory))]
        public IHttpActionResult DeleteAnonymousResponseHistory(Guid id)
        {
            AnonymousResponseHistory anonymousResponseHistory = db.AnonymousResponseHistories.Find(id);
            if (anonymousResponseHistory == null)
            {
                return NotFound();
            }

            db.AnonymousResponseHistories.Remove(anonymousResponseHistory);
            db.SaveChanges();

            return Ok(anonymousResponseHistory);
        }

        protected override void Dispose(bool disposing)
        {
            if (disposing)
            {
                db.Dispose();
            }
            base.Dispose(disposing);
        }

        private bool AnonymousResponseHistoryExists(Guid id)
        {
            return db.AnonymousResponseHistories.Count(e => e.RURN == id) > 0;
        }
    }
}
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Data.Entity.Infrastructure;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using System.Web.Http.Description;
using WhistleBlowerDAL;

namespace Dev.Project.WhistleBlower.Web.Controllers
{
    public class LanguageDetailsController : ApiController 
    {
        private eformulus_IBTW_DBEntities db = new eformulus_IBTW_DBEntities();

        // GET: api/LanguageDetails
        public IQueryable<LanguageDetail> GetLanguageDetails()
        {
            return db.LanguageDetails;
        } 

        // GET: api/LanguageDetails/5
        [ResponseType(typeof(LanguageDetail))]       
        public IEnumerable<LanguageDetail> GetLanguageDetail(string formID, int langID)
        {
            try
            {
                var data = new List<LanguageDetail>();
                var lngDetails = (from lm in db.LanguageMasters
                                  join ld in db.LanguageDetails on lm.LanguageID equals ld.LanguageID
                                  where lm.LanguageID == langID
                                  select ld).ToList();
                data = lngDetails;


                return data;
            }
            catch (Exception ex)
            {
                return null;
            }
        }

        // PUT: api/LanguageDetails/5
        [ResponseType(typeof(void))]
        public IHttpActionResult PutLanguageDetail(Guid id, LanguageDetail languageDetail)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            if (id != languageDetail.LangURN)
            {
                return BadRequest();
            }

            db.Entry(languageDetail).State = EntityState.Modified;

            try
            {
                db.SaveChanges();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!LanguageDetailExists(id))
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

        // POST: api/LanguageDetails
        [ResponseType(typeof(LanguageDetail))]
        public IHttpActionResult PostLanguageDetail(LanguageDetail languageDetail)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            db.LanguageDetails.Add(languageDetail);

            try
            {
                db.SaveChanges();
            }
            catch (DbUpdateException)
            {
                if (LanguageDetailExists(languageDetail.LangURN))
                {
                    return Conflict();
                }
                else
                {
                    throw;
                }
            }

            return CreatedAtRoute("DefaultApi", new { id = languageDetail.LangURN }, languageDetail);
        }

        // DELETE: api/LanguageDetails/5
        [ResponseType(typeof(LanguageDetail))]
        public IHttpActionResult DeleteLanguageDetail(Guid id)
        {
            LanguageDetail languageDetail = db.LanguageDetails.Find(id);
            if (languageDetail == null)
            {
                return NotFound();
            }

            db.LanguageDetails.Remove(languageDetail);
            db.SaveChanges();

            return Ok(languageDetail);
        }

        protected override void Dispose(bool disposing)
        {
            if (disposing)
            {
                db.Dispose();
            }
            base.Dispose(disposing);
        }

        private bool LanguageDetailExists(Guid id)
        {
            return db.LanguageDetails.Count(e => e.LangURN == id) > 0;
        }
    }
}
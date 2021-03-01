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
    public class ResponseLanguagesController : ApiController
    {
        private eformulus_IBTW_DBEntities db = new eformulus_IBTW_DBEntities();

        // GET: api/ResponseLanguages
        public IQueryable<ResponseLanguage> GetResponseLanguages()
        {
            return db.ResponseLanguages;
        }

        // GET: api/ResponseLanguages/5
        [ResponseType(typeof(ResponseLanguage))]
        public IHttpActionResult GetResponseLanguage(int langID)
        {
            if (langID == 0)  
            {
                langID = 1;
            }

            var lngDetails = (from lm in db.LanguageMasters
                              join ld in db.ResponseLanguages on lm.LanguageID equals ld.LanguageID
                              where lm.LanguageID == langID
                              select ld).ToList();

            if (lngDetails == null)
            {
                return NotFound();
            }

            return Ok(lngDetails);
        }

        // PUT: api/ResponseLanguages/5
        [ResponseType(typeof(void))]
        public IHttpActionResult PutResponseLanguage(Guid id, ResponseLanguage responseLanguage)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            if (id != responseLanguage.RURN)
            {
                return BadRequest();
            }

            db.Entry(responseLanguage).State = EntityState.Modified;

            try
            {
                db.SaveChanges();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!ResponseLanguageExists(id))
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

        // POST: api/ResponseLanguages
        [ResponseType(typeof(ResponseLanguage))]
        public IHttpActionResult PostResponseLanguage(ResponseLanguage responseLanguage)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            db.ResponseLanguages.Add(responseLanguage);

            try
            {
                db.SaveChanges();
            }
            catch (DbUpdateException)
            {
                if (ResponseLanguageExists(responseLanguage.RURN))
                {
                    return Conflict();
                }
                else
                {
                    throw;
                }
            }

            return CreatedAtRoute("DefaultApi", new { id = responseLanguage.RURN }, responseLanguage);
        }

        // DELETE: api/ResponseLanguages/5
        [ResponseType(typeof(ResponseLanguage))]
        public IHttpActionResult DeleteResponseLanguage(Guid id)
        {
            ResponseLanguage responseLanguage = db.ResponseLanguages.Find(id);
            if (responseLanguage == null)
            {
                return NotFound();
            }

            db.ResponseLanguages.Remove(responseLanguage);
            db.SaveChanges();

            return Ok(responseLanguage);
        }

        protected override void Dispose(bool disposing)
        {
            if (disposing)
            {
                db.Dispose();
            }
            base.Dispose(disposing);
        }

        private bool ResponseLanguageExists(Guid id)
        {
            return db.ResponseLanguages.Count(e => e.RURN == id) > 0;
        }
    }
}
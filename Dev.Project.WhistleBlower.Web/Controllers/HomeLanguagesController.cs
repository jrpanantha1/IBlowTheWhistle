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
    public class HomeLanguagesController : ApiController
    {
        private eformulus_IBTW_DBEntities db = new eformulus_IBTW_DBEntities();

        // GET: api/HomeLanguages
        public IQueryable<HomeLanguage> GetHomeLanguages()
        {
            return db.HomeLanguages;
        }

        // GET: api/HomeLanguages/5
        [ResponseType(typeof(HomeLanguage))]
        public IHttpActionResult GetHomeLanguage(int langID)
        {
            if (langID == 0)
            {
                langID = 1;
            }

            var lngDetails = (from lm in db.LanguageMasters
                              join ld in db.HomeLanguages on lm.LanguageID equals ld.LanguageID
                              where lm.LanguageID == langID
                              select ld).ToList();

            if (lngDetails == null)
            {
                return NotFound();
            }

            return Ok(lngDetails);
        }

        // PUT: api/HomeLanguages/5
        [ResponseType(typeof(void))]
        public IHttpActionResult PutHomeLanguage(Guid id, HomeLanguage homeLanguage)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            if (id != homeLanguage.HURN)
            {
                return BadRequest();
            }

            db.Entry(homeLanguage).State = EntityState.Modified;

            try
            {
                db.SaveChanges();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!HomeLanguageExists(id))
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

        // POST: api/HomeLanguages
        [ResponseType(typeof(HomeLanguage))]
        public IHttpActionResult PostHomeLanguage(HomeLanguage homeLanguage)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            db.HomeLanguages.Add(homeLanguage);

            try
            {
                db.SaveChanges();
            }
            catch (DbUpdateException)
            {
                if (HomeLanguageExists(homeLanguage.HURN))
                {
                    return Conflict();
                }
                else
                {
                    throw;
                }
            }

            return CreatedAtRoute("DefaultApi", new { id = homeLanguage.HURN }, homeLanguage);
        }

        // DELETE: api/HomeLanguages/5
        [ResponseType(typeof(HomeLanguage))]
        public IHttpActionResult DeleteHomeLanguage(Guid id)
        {
            HomeLanguage homeLanguage = db.HomeLanguages.Find(id);
            if (homeLanguage == null)
            {
                return NotFound();
            }

            db.HomeLanguages.Remove(homeLanguage);
            db.SaveChanges();

            return Ok(homeLanguage);
        }

        protected override void Dispose(bool disposing)
        {
            if (disposing)
            {
                db.Dispose();
            }
            base.Dispose(disposing);
        }

        private bool HomeLanguageExists(Guid id)
        {
            return db.HomeLanguages.Count(e => e.HURN == id) > 0;
        }
    }
}
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
    public class ViewIncidentsLanguagesController : ApiController
    {
        private eformulus_IBTW_DBEntities db = new eformulus_IBTW_DBEntities();

        // GET: api/ViewIncidentsLanguages
        public IQueryable<ViewIncidentsLanguage> GetViewIncidentsLanguages()
        {
            return db.ViewIncidentsLanguages;
        }

        // GET: api/ViewIncidentsLanguages/5
        [ResponseType(typeof(ViewIncidentsLanguage))]
        public IEnumerable<ViewIncidentsLanguage> GetViewIncidentsLanguageDetail(int langID)
        {
            try
            {
                var data = new List<ViewIncidentsLanguage>();
                var lngDetails = (from lm in db.LanguageMasters
                                  join ld in db.ViewIncidentsLanguages on lm.LanguageID equals ld.LanguageID
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

        // PUT: api/ViewIncidentsLanguages/5
        [ResponseType(typeof(void))]
        public IHttpActionResult PutViewIncidentsLanguage(Guid id, ViewIncidentsLanguage viewIncidentsLanguage)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            if (id != viewIncidentsLanguage.VURN)
            {
                return BadRequest();
            }

            db.Entry(viewIncidentsLanguage).State = EntityState.Modified;

            try
            {
                db.SaveChanges();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!ViewIncidentsLanguageExists(id))
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

        // POST: api/ViewIncidentsLanguages
        [ResponseType(typeof(ViewIncidentsLanguage))]
        public IHttpActionResult PostViewIncidentsLanguage(ViewIncidentsLanguage viewIncidentsLanguage)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            db.ViewIncidentsLanguages.Add(viewIncidentsLanguage);

            try
            {
                db.SaveChanges();
            }
            catch (DbUpdateException)
            {
                if (ViewIncidentsLanguageExists(viewIncidentsLanguage.VURN))
                {
                    return Conflict();
                }
                else
                {
                    throw;
                }
            }

            return CreatedAtRoute("DefaultApi", new { id = viewIncidentsLanguage.VURN }, viewIncidentsLanguage);
        }

        // DELETE: api/ViewIncidentsLanguages/5
        [ResponseType(typeof(ViewIncidentsLanguage))]
        public IHttpActionResult DeleteViewIncidentsLanguage(Guid id)
        {
            ViewIncidentsLanguage viewIncidentsLanguage = db.ViewIncidentsLanguages.Find(id);
            if (viewIncidentsLanguage == null)
            {
                return NotFound();
            }

            db.ViewIncidentsLanguages.Remove(viewIncidentsLanguage);
            db.SaveChanges();

            return Ok(viewIncidentsLanguage);
        }

        protected override void Dispose(bool disposing)
        {
            if (disposing)
            {
                db.Dispose();
            }
            base.Dispose(disposing);
        }

        private bool ViewIncidentsLanguageExists(Guid id)
        {
            return db.ViewIncidentsLanguages.Count(e => e.VURN == id) > 0;
        }
    }
}
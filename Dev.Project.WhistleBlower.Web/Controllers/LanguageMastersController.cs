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
    public class LanguageMastersController : ApiController
    {
        private eformulus_IBTW_DBEntities db = new eformulus_IBTW_DBEntities();

        // GET: api/LanguageMasters
        public IQueryable<LanguageMaster> GetLanguageMasters()
        {
            return db.LanguageMasters;
        }

        // GET: api/LanguageMasters/5
        [ResponseType(typeof(LanguageMaster))]
        public IHttpActionResult GetLanguageMaster(int id)
        {
            LanguageMaster languageMaster = db.LanguageMasters.Find(id);
            if (languageMaster == null)
            {
                return NotFound();
            }

            return Ok(languageMaster);
        }

        // PUT: api/LanguageMasters/5
        [ResponseType(typeof(void))]
        public IHttpActionResult PutLanguageMaster(int id, LanguageMaster languageMaster)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            if (id != languageMaster.LanguageID)
            {
                return BadRequest();
            }

            db.Entry(languageMaster).State = EntityState.Modified;

            try
            {
                db.SaveChanges();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!LanguageMasterExists(id))
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

        // POST: api/LanguageMasters
        [ResponseType(typeof(LanguageMaster))]
        public IHttpActionResult PostLanguageMaster(LanguageMaster languageMaster)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            db.LanguageMasters.Add(languageMaster);

            try
            {
                db.SaveChanges();
            }
            catch (DbUpdateException)
            {
                if (LanguageMasterExists(languageMaster.LanguageID))
                {
                    return Conflict();
                }
                else
                {
                    throw;
                }
            }

            return CreatedAtRoute("DefaultApi", new { id = languageMaster.LanguageID }, languageMaster);
        }

        // DELETE: api/LanguageMasters/5
        [ResponseType(typeof(LanguageMaster))]
        public IHttpActionResult DeleteLanguageMaster(int id)
        {
            LanguageMaster languageMaster = db.LanguageMasters.Find(id);
            if (languageMaster == null)
            {
                return NotFound();
            }

            db.LanguageMasters.Remove(languageMaster);
            db.SaveChanges();

            return Ok(languageMaster);
        }

        protected override void Dispose(bool disposing)
        {
            if (disposing)
            {
                db.Dispose();
            }
            base.Dispose(disposing);
        }

        private bool LanguageMasterExists(int id)
        {
            return db.LanguageMasters.Count(e => e.LanguageID == id) > 0;
        }
    }
}
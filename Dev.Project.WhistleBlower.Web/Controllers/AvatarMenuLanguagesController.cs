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
    public class AvatarMenuLanguagesController : ApiController
    {
        private eformulus_IBTW_DBEntities db = new eformulus_IBTW_DBEntities();

        // GET: api/AvatarMenuLanguages
        public IQueryable<AvatarMenuLanguage> GetAvatarMenuLanguages()
        {
            return db.AvatarMenuLanguages;
        }

        // GET: api/AvatarMenuLanguages/5
        [ResponseType(typeof(AvatarMenuLanguage))]
        public IHttpActionResult GetAvatarMenuLanguage(int langID)
        {
            if (langID == 0)
            {
                langID = 1;
            }

            var lngDetails = (from lm in db.LanguageMasters
                              join ld in db.AvatarMenuLanguages on lm.LanguageID equals ld.LanguageID
                              where lm.LanguageID == langID
                              select ld).ToList();

            if (lngDetails == null)
            {
                return NotFound();
            }

            return Ok(lngDetails);
        }

        // PUT: api/AvatarMenuLanguages/5
        [ResponseType(typeof(void))]
        public IHttpActionResult PutAvatarMenuLanguage(Guid id, AvatarMenuLanguage avatarMenuLanguage)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            if (id != avatarMenuLanguage.AMURN)
            {
                return BadRequest();
            }

            db.Entry(avatarMenuLanguage).State = EntityState.Modified;

            try
            {
                db.SaveChanges();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!AvatarMenuLanguageExists(id))
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

        // POST: api/AvatarMenuLanguages
        [ResponseType(typeof(AvatarMenuLanguage))]
        public IHttpActionResult PostAvatarMenuLanguage(AvatarMenuLanguage avatarMenuLanguage)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            db.AvatarMenuLanguages.Add(avatarMenuLanguage);

            try
            {
                db.SaveChanges();
            }
            catch (DbUpdateException)
            {
                if (AvatarMenuLanguageExists(avatarMenuLanguage.AMURN))
                {
                    return Conflict();
                }
                else
                {
                    throw;
                }
            }

            return CreatedAtRoute("DefaultApi", new { id = avatarMenuLanguage.AMURN }, avatarMenuLanguage);
        }

        // DELETE: api/AvatarMenuLanguages/5
        [ResponseType(typeof(AvatarMenuLanguage))]
        public IHttpActionResult DeleteAvatarMenuLanguage(Guid id)
        {
            AvatarMenuLanguage avatarMenuLanguage = db.AvatarMenuLanguages.Find(id);
            if (avatarMenuLanguage == null)
            {
                return NotFound();
            }

            db.AvatarMenuLanguages.Remove(avatarMenuLanguage);
            db.SaveChanges();

            return Ok(avatarMenuLanguage);
        }

        protected override void Dispose(bool disposing)
        {
            if (disposing)
            {
                db.Dispose();
            }
            base.Dispose(disposing);
        }

        private bool AvatarMenuLanguageExists(Guid id)
        {
            return db.AvatarMenuLanguages.Count(e => e.AMURN == id) > 0;
        }
    }
}
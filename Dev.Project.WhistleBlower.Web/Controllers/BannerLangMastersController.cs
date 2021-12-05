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
    public class BannerLangMastersController : ApiController
    {
        private eformulus_IBTW_DBEntities db = new eformulus_IBTW_DBEntities();

        // GET: api/BannerLangMasters
        public IQueryable<BannerLangMaster> GetBannerLangMasters()
        {
            return db.BannerLangMasters;
        }

        // GET: api/BannerLangMasters/5
        [ResponseType(typeof(BannerLangMaster))]
        public IHttpActionResult GetBannerLangMaster(int langID)
        {
            if (langID == 0)
            {
                langID = 1;
            }

            var lngDetails = (from lm in db.LanguageMasters
                              join ld in db.BannerLangMasters on lm.LanguageID equals ld.LanguageID
                              where lm.LanguageID == langID
                              select ld).ToList();

            if (lngDetails == null)
            {
                return NotFound();
            }

            return Ok(lngDetails);
        }

        // PUT: api/BannerLangMasters/5
        [ResponseType(typeof(void))]
        public IHttpActionResult PutBannerLangMaster(Guid id, BannerLangMaster bannerLangMaster)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            if (id != bannerLangMaster.BURN)
            {
                return BadRequest();
            }

            db.Entry(bannerLangMaster).State = EntityState.Modified;

            try
            {
                db.SaveChanges();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!BannerLangMasterExists(id))
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

        // POST: api/BannerLangMasters
        [ResponseType(typeof(BannerLangMaster))]
        public IHttpActionResult PostBannerLangMaster(BannerLangMaster bannerLangMaster)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            db.BannerLangMasters.Add(bannerLangMaster);

            try
            {
                db.SaveChanges();
            }
            catch (DbUpdateException)
            {
                if (BannerLangMasterExists(bannerLangMaster.BURN))
                {
                    return Conflict();
                }
                else
                {
                    throw;
                }
            }

            return CreatedAtRoute("DefaultApi", new { id = bannerLangMaster.BURN }, bannerLangMaster);
        }

        // DELETE: api/BannerLangMasters/5
        [ResponseType(typeof(BannerLangMaster))]
        public IHttpActionResult DeleteBannerLangMaster(Guid id)
        {
            BannerLangMaster bannerLangMaster = db.BannerLangMasters.Find(id);
            if (bannerLangMaster == null)
            {
                return NotFound();
            }

            db.BannerLangMasters.Remove(bannerLangMaster);
            db.SaveChanges();

            return Ok(bannerLangMaster);
        }

        protected override void Dispose(bool disposing)
        {
            if (disposing)
            {
                db.Dispose();
            }
            base.Dispose(disposing);
        }

        private bool BannerLangMasterExists(Guid id)
        {
            return db.BannerLangMasters.Count(e => e.BURN == id) > 0;
        }
    }
}
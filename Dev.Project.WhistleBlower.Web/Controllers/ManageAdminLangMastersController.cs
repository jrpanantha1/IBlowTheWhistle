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
    public class ManageAdminLangMastersController : ApiController
    {
        private eformulus_IBTW_DBEntities db = new eformulus_IBTW_DBEntities();

        // GET: api/ManageAdminLangMasters
        public IQueryable<ManageAdminLangMaster> GetManageAdminLangMasters()
        {
            return db.ManageAdminLangMasters;
        }

        // GET: api/ManageAdminLangMasters/5
        [ResponseType(typeof(ManageAdminLangMaster))]
        public IHttpActionResult GetManageAdminLangMaster(int langID)
        {
            if (langID == 0)
            {
                langID = 1;
            }

            var lngDetails = (from lm in db.LanguageMasters
                              join ld in db.ManageAdminLangMasters on lm.LanguageID equals ld.LanguageID
                              where lm.LanguageID == langID
                              select ld).ToList();

            if (lngDetails == null)
            {
                return NotFound();
            }

            return Ok(lngDetails);
        }

        // PUT: api/ManageAdminLangMasters/5
        [ResponseType(typeof(void))]
        public IHttpActionResult PutManageAdminLangMaster(Guid id, ManageAdminLangMaster manageAdminLangMaster)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            if (id != manageAdminLangMaster.MURN)
            {
                return BadRequest();
            }

            db.Entry(manageAdminLangMaster).State = EntityState.Modified;

            try
            {
                db.SaveChanges();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!ManageAdminLangMasterExists(id))
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

        // POST: api/ManageAdminLangMasters
        [ResponseType(typeof(ManageAdminLangMaster))]
        public IHttpActionResult PostManageAdminLangMaster(ManageAdminLangMaster manageAdminLangMaster)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            db.ManageAdminLangMasters.Add(manageAdminLangMaster);

            try
            {
                db.SaveChanges();
            }
            catch (DbUpdateException)
            {
                if (ManageAdminLangMasterExists(manageAdminLangMaster.MURN))
                {
                    return Conflict();
                }
                else
                {
                    throw;
                }
            }

            return CreatedAtRoute("DefaultApi", new { id = manageAdminLangMaster.MURN }, manageAdminLangMaster);
        }

        // DELETE: api/ManageAdminLangMasters/5
        [ResponseType(typeof(ManageAdminLangMaster))]
        public IHttpActionResult DeleteManageAdminLangMaster(Guid id)
        {
            ManageAdminLangMaster manageAdminLangMaster = db.ManageAdminLangMasters.Find(id);
            if (manageAdminLangMaster == null)
            {
                return NotFound();
            }

            db.ManageAdminLangMasters.Remove(manageAdminLangMaster);
            db.SaveChanges();

            return Ok(manageAdminLangMaster);
        }

        protected override void Dispose(bool disposing)
        {
            if (disposing)
            {
                db.Dispose();
            }
            base.Dispose(disposing);
        }

        private bool ManageAdminLangMasterExists(Guid id)
        {
            return db.ManageAdminLangMasters.Count(e => e.MURN == id) > 0;
        }
    }
}
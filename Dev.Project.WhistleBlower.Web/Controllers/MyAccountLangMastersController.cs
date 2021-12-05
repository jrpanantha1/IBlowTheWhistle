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
    public class MyAccountLangMastersController : ApiController
    {
        private eformulus_IBTW_DBEntities db = new eformulus_IBTW_DBEntities();

        // GET: api/MyAccountLangMasters
        public IQueryable<MyAccountLangMaster> GetMyAccountLangMasters()
        {
            return db.MyAccountLangMasters;
        }

        // GET: api/MyAccountLangMasters/5
        [ResponseType(typeof(MyAccountLangMaster))]
        public IHttpActionResult GetMyAccountLangMaster(int langID)
        {
            if (langID == 0)
            {
                langID = 1;
            }

            var lngDetails = (from lm in db.LanguageMasters
                              join ld in db.MyAccountLangMasters on lm.LanguageID equals ld.LanguageID
                              where lm.LanguageID == langID
                              select ld).ToList();

            if (lngDetails == null)
            {
                return NotFound();
            }

            return Ok(lngDetails);
        }

        // PUT: api/MyAccountLangMasters/5
        [ResponseType(typeof(void))]
        public IHttpActionResult PutMyAccountLangMaster(Guid id, MyAccountLangMaster myAccountLangMaster)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            if (id != myAccountLangMaster.MURN)
            {
                return BadRequest();
            }

            db.Entry(myAccountLangMaster).State = EntityState.Modified;

            try
            {
                db.SaveChanges();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!MyAccountLangMasterExists(id))
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

        // POST: api/MyAccountLangMasters
        [ResponseType(typeof(MyAccountLangMaster))]
        public IHttpActionResult PostMyAccountLangMaster(MyAccountLangMaster myAccountLangMaster)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            db.MyAccountLangMasters.Add(myAccountLangMaster);

            try
            {
                db.SaveChanges();
            }
            catch (DbUpdateException)
            {
                if (MyAccountLangMasterExists(myAccountLangMaster.MURN))
                {
                    return Conflict();
                }
                else
                {
                    throw;
                }
            }

            return CreatedAtRoute("DefaultApi", new { id = myAccountLangMaster.MURN }, myAccountLangMaster);
        }

        // DELETE: api/MyAccountLangMasters/5
        [ResponseType(typeof(MyAccountLangMaster))]
        public IHttpActionResult DeleteMyAccountLangMaster(Guid id)
        {
            MyAccountLangMaster myAccountLangMaster = db.MyAccountLangMasters.Find(id);
            if (myAccountLangMaster == null)
            {
                return NotFound();
            }

            db.MyAccountLangMasters.Remove(myAccountLangMaster);
            db.SaveChanges();

            return Ok(myAccountLangMaster);
        }

        protected override void Dispose(bool disposing)
        {
            if (disposing)
            {
                db.Dispose();
            }
            base.Dispose(disposing);
        }

        private bool MyAccountLangMasterExists(Guid id)
        {
            return db.MyAccountLangMasters.Count(e => e.MURN == id) > 0;
        }
    }
}
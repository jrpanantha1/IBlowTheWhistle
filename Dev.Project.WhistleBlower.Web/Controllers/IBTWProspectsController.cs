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
    public class IBTWProspectsController : ApiController
    {
        private eformulus_IBTW_DBEntities db = new eformulus_IBTW_DBEntities();

        // GET: api/IBTWProspects
        public IQueryable<IBTWProspect> GetIBTWProspects()
        {
            return db.IBTWProspects;
        }

        // GET: api/IBTWProspects/5
        [ResponseType(typeof(IBTWProspect))]
        public IHttpActionResult GetIBTWProspect(Guid id)
        {
            IBTWProspect iBTWProspect = db.IBTWProspects.Find(id);
            if (iBTWProspect == null)
            {
                return NotFound();
            }

            return Ok(iBTWProspect);
        }

        // PUT: api/IBTWProspects/5
        [ResponseType(typeof(void))]
        public IHttpActionResult PutIBTWProspect(Guid id, IBTWProspect iBTWProspect)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            if (id != iBTWProspect.PUID)
            {
                return BadRequest();
            }

            db.Entry(iBTWProspect).State = EntityState.Modified;

            try
            {
                db.SaveChanges();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!IBTWProspectExists(id))
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

        // POST: api/IBTWProspects
        [ResponseType(typeof(IBTWProspect))]
        public IHttpActionResult PostIBTWProspect(IBTWProspect iBTWProspect)
        {

            if (iBTWProspect != null)
            {
                iBTWProspect.PUID = Guid.NewGuid();
                iBTWProspect.Created = System.DateTime.Now;

            }
            db.IBTWProspects.Add(iBTWProspect);

            try
            {
                db.SaveChanges();
                return Ok("Success");
            }
            catch (DbUpdateException ex)
            {
                if (IBTWProspectExists(iBTWProspect.PUID))
                {
                    return Conflict();
                }
                else
                {
                    throw;
                }
            }

        }

        // DELETE: api/IBTWProspects/5
        [ResponseType(typeof(IBTWProspect))]
        public IHttpActionResult DeleteIBTWProspect(Guid id)
        {
            IBTWProspect iBTWProspect = db.IBTWProspects.Find(id);
            if (iBTWProspect == null)
            {
                return NotFound();
            }

            db.IBTWProspects.Remove(iBTWProspect);
            db.SaveChanges();

            return Ok(iBTWProspect);
        }

        protected override void Dispose(bool disposing)
        {
            if (disposing)
            {
                db.Dispose();
            }
            base.Dispose(disposing);
        }

        private bool IBTWProspectExists(Guid id)
        {
            return db.IBTWProspects.Count(e => e.PUID == id) > 0;
        }
    }
}
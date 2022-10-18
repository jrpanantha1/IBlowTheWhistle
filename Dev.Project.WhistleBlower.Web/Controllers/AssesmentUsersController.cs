using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Data.Entity.Infrastructure;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Security.Claims;
using System.Web.Http;
using System.Web.Http.Description;
using WhistleBlowerDAL;

namespace Dev.Project.WhistleBlower.Web.Controllers
{
    public class AssesmentUsersController : ApiController
    {
        private eformulus_IBTW_DBEntities db = new eformulus_IBTW_DBEntities();

        // GET: api/AssesmentUsers
        public IQueryable<AssesmentUser> GetAssesmentUsers()
        {
            return db.AssesmentUsers;
        }

        // GET: api/AssesmentUsers/5
        [ResponseType(typeof(AssesmentUser))]
        public IHttpActionResult GetAssesmentUser(Guid id)
        {
            AssesmentUser assesmentUser = db.AssesmentUsers.Find(id);
            if (assesmentUser == null)
            {
                return NotFound();
            }

            return Ok(assesmentUser);
        }

        // PUT: api/AssesmentUsers/5
        [ResponseType(typeof(void))]
        public IHttpActionResult PutAssesmentUser(Guid id, AssesmentUser assesmentUser)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            if (id != assesmentUser.AUserURN)
            {
                return BadRequest();
            }

            db.Entry(assesmentUser).State = EntityState.Modified;

            try
            {
                db.SaveChanges();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!AssesmentUserExists(id))
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

        // POST: api/AssesmentUsers
        [ResponseType(typeof(AssesmentUser))]
        public IHttpActionResult PostAssesmentUser(AssesmentUser assesmentUser)
        {
            Guid newStatusID = Guid.NewGuid();

            assesmentUser.AUserURN = newStatusID;
            assesmentUser.AssesmentTakenOn = DateTime.Now;

            db.AssesmentUsers.Add(assesmentUser);

            try
            {
                db.SaveChanges();
                return Ok("Success");
            }
            catch (DbUpdateException)
            {
                if (AssesmentUserExists(assesmentUser.AUserURN))
                {
                    return Conflict();
                }
                else
                {
                    throw;
                }
            }

            return CreatedAtRoute("DefaultApi", new { id = assesmentUser.AUserURN }, assesmentUser);
        }

        // DELETE: api/AssesmentUsers/5
        [ResponseType(typeof(AssesmentUser))]
        public IHttpActionResult DeleteAssesmentUser(Guid id)
        {
            AssesmentUser assesmentUser = db.AssesmentUsers.Find(id);
            if (assesmentUser == null)
            {
                return NotFound();
            }

            db.AssesmentUsers.Remove(assesmentUser);
            db.SaveChanges();

            return Ok(assesmentUser);
        }

        protected override void Dispose(bool disposing)
        {
            if (disposing)
            {
                db.Dispose();
            }
            base.Dispose(disposing);
        }

        private bool AssesmentUserExists(Guid id)
        {
            return db.AssesmentUsers.Count(e => e.AUserURN == id) > 0;
        }
    }
}
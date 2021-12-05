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
    public class SubscriptionHistroysController : ApiController
    {
        private eformulus_IBTW_DBEntities db = new eformulus_IBTW_DBEntities();

        // GET: api/SubscriptionHistroys
        [Authorize]
        public IHttpActionResult GetSubscriptionHistroys()
        {
            try
            {
                string companyID = ((ClaimsIdentity)User.Identity).Claims.FirstOrDefault(x => x.Type == "companyID").Value;

                var objSubHistory = (from sh in db.SubscriptionHistroys where sh.CompanyURN.ToString() == companyID select sh).OrderByDescending(s => s.Created).ToList();
                if (objSubHistory != null)
                {
                    return Ok(objSubHistory);
                }
                return NotFound();

            }
            catch (Exception)
            {

                return NotFound();
            }

        }

        // GET: api/SubscriptionHistroys/5
        [ResponseType(typeof(SubscriptionHistroy))]
        public IHttpActionResult GetSubscriptionHistroy(Guid id)
        {
            SubscriptionHistroy subscriptionHistroy = db.SubscriptionHistroys.Find(id);
            if (subscriptionHistroy == null)
            {
                return NotFound();
            }

            return Ok(subscriptionHistroy);
        }

        // PUT: api/SubscriptionHistroys/5
        [ResponseType(typeof(void))]
        public IHttpActionResult PutSubscriptionHistroy(Guid id, SubscriptionHistroy subscriptionHistroy)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            if (id != subscriptionHistroy.SHURN)
            {
                return BadRequest();
            }

            db.Entry(subscriptionHistroy).State = EntityState.Modified;

            try
            {
                db.SaveChanges();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!SubscriptionHistroyExists(id))
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

        // POST: api/SubscriptionHistroys
        [ResponseType(typeof(SubscriptionHistroy))]
        public IHttpActionResult PostSubscriptionHistroy(SubscriptionHistroy subscriptionHistroy)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            db.SubscriptionHistroys.Add(subscriptionHistroy);

            try
            {
                db.SaveChanges();
            }
            catch (DbUpdateException)
            {
                if (SubscriptionHistroyExists(subscriptionHistroy.SHURN))
                {
                    return Conflict();
                }
                else
                {
                    throw;
                }
            }

            return CreatedAtRoute("DefaultApi", new { id = subscriptionHistroy.SHURN }, subscriptionHistroy);
        }

        // DELETE: api/SubscriptionHistroys/5
        [ResponseType(typeof(SubscriptionHistroy))]
        public IHttpActionResult DeleteSubscriptionHistroy(Guid id)
        {
            SubscriptionHistroy subscriptionHistroy = db.SubscriptionHistroys.Find(id);
            if (subscriptionHistroy == null)
            {
                return NotFound();
            }

            db.SubscriptionHistroys.Remove(subscriptionHistroy);
            db.SaveChanges();

            return Ok(subscriptionHistroy);
        }

        protected override void Dispose(bool disposing)
        {
            if (disposing)
            {
                db.Dispose();
            }
            base.Dispose(disposing);
        }

        private bool SubscriptionHistroyExists(Guid id)
        {
            return db.SubscriptionHistroys.Count(e => e.SHURN == id) > 0;
        }
    }
}
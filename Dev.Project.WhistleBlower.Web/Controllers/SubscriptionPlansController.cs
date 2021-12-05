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
    public class SubscriptionPlansController : ApiController
    {
        private eformulus_IBTW_DBEntities db = new eformulus_IBTW_DBEntities();

        // GET: api/SubscriptionPlans
        public IQueryable<SubscriptionPlan> GetSubscriptionPlans()
        {
            return db.SubscriptionPlans;
        }

        // GET: api/SubscriptionPlans/5
        [ResponseType(typeof(SubscriptionPlan))]
        [Authorize]
        public IHttpActionResult GetSubscriptionPlan(int id)
        {
            SubscriptionPlan subscriptionPlan = db.SubscriptionPlans.Find(id);
            if (subscriptionPlan == null)
            {
                return NotFound();
            }

            return Ok(subscriptionPlan);
        }

        // PUT: api/SubscriptionPlans/5
        [ResponseType(typeof(void))]
        public IHttpActionResult PutSubscriptionPlan(int id, SubscriptionPlan subscriptionPlan)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            if (id != subscriptionPlan.PlanID)
            {
                return BadRequest();
            }

            db.Entry(subscriptionPlan).State = EntityState.Modified;

            try
            {
                db.SaveChanges();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!SubscriptionPlanExists(id))
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

        // POST: api/SubscriptionPlans
        [ResponseType(typeof(SubscriptionPlan))]
        public IHttpActionResult PostSubscriptionPlan(SubscriptionPlan subscriptionPlan)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            db.SubscriptionPlans.Add(subscriptionPlan);
            db.SaveChanges();

            return CreatedAtRoute("DefaultApi", new { id = subscriptionPlan.PlanID }, subscriptionPlan);
        }

        // DELETE: api/SubscriptionPlans/5
        [ResponseType(typeof(SubscriptionPlan))]
        public IHttpActionResult DeleteSubscriptionPlan(int id)
        {
            SubscriptionPlan subscriptionPlan = db.SubscriptionPlans.Find(id);
            if (subscriptionPlan == null)
            {
                return NotFound();
            }

            db.SubscriptionPlans.Remove(subscriptionPlan);
            db.SaveChanges();

            return Ok(subscriptionPlan);
        }

        protected override void Dispose(bool disposing)
        {
            if (disposing)
            {
                db.Dispose();
            }
            base.Dispose(disposing);
        }

        private bool SubscriptionPlanExists(int id)
        {
            return db.SubscriptionPlans.Count(e => e.PlanID == id) > 0;
        }
    }
}
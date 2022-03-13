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
    public class PolicyMastersController : ApiController
    {
        private eformulus_IBTW_DBEntities db = new eformulus_IBTW_DBEntities();

        // GET: api/PolicyMasters
        public IQueryable<PolicyMaster> GetPolicyMasters()
        {
            return db.PolicyMasters;
        }

        // GET: api/PolicyMasters/5
        [Authorize]
        [ResponseType(typeof(PolicyMaster))]
        public IHttpActionResult GetPolicyMaster(int langID)
        {
            if (langID == 0)
            {
                langID = 1;
            }
            string companyID = ((ClaimsIdentity)User.Identity).Claims.FirstOrDefault(x => x.Type == "companyID").Value;

            var policyDetails = (from lm in db.LanguageMasters
                                 join ld in db.PolicyMasters on lm.LanguageID equals ld.LanguageID
                                 where lm.LanguageID == langID && ld.CURN.ToString() == companyID
                                 select ld).OrderByDescending(tt => tt.isActive).ToList();

            if (policyDetails == null)
            {
                return NotFound();
            }

            return Ok(policyDetails);
        }

        // PUT: api/PolicyMasters/5
        [ResponseType(typeof(void))]
        public IHttpActionResult PutPolicyMaster(Guid id, PolicyMaster policyMaster)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            if (id != policyMaster.PMURN)
            {
                return BadRequest();
            }

            db.Entry(policyMaster).State = EntityState.Modified;

            try
            {
                db.SaveChanges();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!PolicyMasterExists(id))
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

        // POST: api/PolicyMasters
        [Authorize]
        [ResponseType(typeof(PolicyMaster))]
        public IHttpActionResult PostPolicyMaster(PolicyMaster policyMaster)
        {


            string companyID = ((ClaimsIdentity)User.Identity).Claims.FirstOrDefault(x => x.Type == "companyID").Value;
            //check the logged user has permission to modify the content?
            string emailID = User.Identity.Name;
            var isValidaUserTofetch = db.RegisteredUsers.Where(e => e.AcctType.ToString() == "Admin" && e.CompanyID.ToString() == companyID && e.Email == emailID).FirstOrDefault();
            if (isValidaUserTofetch == null)
            {
                return Ok("Unauthorized");
            }

            // check if policy details is available ?
            var isExist = db.PolicyMasters.Where(e => e.CURN.ToString() == companyID && e.isActive == true).FirstOrDefault();
            if (isExist == null)
            {


                Guid policyID = Guid.NewGuid();
                policyMaster.PMURN = policyID;
                policyMaster.CURN = new Guid(companyID);
                policyMaster.isActive = true;

                policyMaster.UpdatedOn = System.DateTime.Now;
                db.PolicyMasters.Add(policyMaster);
            }
            else
            {
                isExist.PolicyHTML = policyMaster.PolicyHTML;
                isExist.UpdatedOn = System.DateTime.Now;
            }
            try
            {
                db.SaveChanges();
            }
            catch (DbUpdateException)
            {
                if (PolicyMasterExists(policyMaster.PMURN))
                {
                    return Conflict();
                }
                else
                {
                    throw;
                }
            }

            return CreatedAtRoute("DefaultApi", new { id = policyMaster.PMURN }, policyMaster);
        }

        // DELETE: api/PolicyMasters/5
        [ResponseType(typeof(PolicyMaster))]
        public IHttpActionResult DeletePolicyMaster(Guid id)
        {
            PolicyMaster policyMaster = db.PolicyMasters.Find(id);
            if (policyMaster == null)
            {
                return NotFound();
            }

            db.PolicyMasters.Remove(policyMaster);
            db.SaveChanges();

            return Ok(policyMaster);
        }

        protected override void Dispose(bool disposing)
        {
            if (disposing)
            {
                db.Dispose();
            }
            base.Dispose(disposing);
        }

        private bool PolicyMasterExists(Guid id)
        {
            return db.PolicyMasters.Count(e => e.PMURN == id) > 0;
        }
    }
}
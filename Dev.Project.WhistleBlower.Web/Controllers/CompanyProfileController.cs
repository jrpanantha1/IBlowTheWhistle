using Dev.Project.WhistleBlower.Web.Data;
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
    public class CompanyProfileController : ApiController
    {
        private eformulus_IBTW_DBEntities db = new eformulus_IBTW_DBEntities();

        // GET: api/CompanyProfile/5
        [ResponseType(typeof(CompanyMaster))]
        [Authorize]
        public IHttpActionResult GetCompanyMaster(long id)
        {
            string companyID = ((ClaimsIdentity)User.Identity).Claims.FirstOrDefault(x => x.Type == "companyID").Value;
            var result = db.CompanyMasters.FirstOrDefault(u => u.CURN.ToString().Trim().ToUpper().Equals(companyID.ToUpper()));
            if (result == null)
            {
                return NotFound();
            }

            return Ok(result);
        }

        // GET: api/CompanyProfile
        [ResponseType(typeof(CompanyMaster))]
        [Authorize]
        public IHttpActionResult GetCompanyMaster()
        {
            string companyID = ((ClaimsIdentity)User.Identity).Claims.FirstOrDefault(x => x.Type == "companyID").Value;
            string AccType = ((ClaimsIdentity)User.Identity).Claims.FirstOrDefault(x => x.Type == "accType").Value;

            var result = db.CompanyMasters.FirstOrDefault(u => u.CURN.ToString().Trim().ToUpper().Equals(companyID.ToUpper()));

            result.CompanyKey = Cipher.Encrypt(result.CompanyKey, result.encPassword);
            result.CompanyValue = Cipher.Encrypt(result.CompanyValue, result.encPassword);

            if (AccType == WhistleContants.anonymousUserAccountType || AccType == WhistleContants.normalUserAccountType)
            {
                result.CompanyLogo = "";
                result.CompanyValue = "";

            }
            if (result == null)
            {
                return NotFound();
            }

            return Ok(result);
        }

        // PUT: api/CompanyProfile/5
        [ResponseType(typeof(void))]
        public IHttpActionResult PutCompanyMaster(long id, CompanyMaster companyMaster)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            if (id != companyMaster.CompanyID)
            {
                return BadRequest();
            }

            db.Entry(companyMaster).State = EntityState.Modified;

            try
            {
                db.SaveChanges();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!CompanyMasterExists(id))
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

        // POST: api/CompanyProfile
        [ResponseType(typeof(CompanyMaster))]
        public IHttpActionResult PostCompanyMaster(CompanyMaster companyMaster)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            db.CompanyMasters.Add(companyMaster);
            db.SaveChanges();

            return CreatedAtRoute("DefaultApi", new { id = companyMaster.CompanyID }, companyMaster);
        }

        // DELETE: api/CompanyProfile/5
        [ResponseType(typeof(CompanyMaster))]
        public IHttpActionResult DeleteCompanyMaster(long id)
        {
            CompanyMaster companyMaster = db.CompanyMasters.Find(id);
            if (companyMaster == null)
            {
                return NotFound();
            }

            db.CompanyMasters.Remove(companyMaster);
            db.SaveChanges();

            return Ok(companyMaster);
        }

        protected override void Dispose(bool disposing)
        {
            if (disposing)
            {
                db.Dispose();
            }
            base.Dispose(disposing);
        }

        private bool CompanyMasterExists(long id)
        {
            return db.CompanyMasters.Count(e => e.CompanyID == id) > 0;
        }
    }
}
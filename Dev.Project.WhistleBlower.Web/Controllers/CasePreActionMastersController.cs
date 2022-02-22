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
    public class CasePreActionMastersController : ApiController
    {
        private eformulus_IBTW_DBEntities db = new eformulus_IBTW_DBEntities();

        // GET: api/CasePreActionMasters
        public IQueryable<CasePreActionMaster> GetCasePreActionMasters()
        {
            return db.CasePreActionMasters;
        }

        // GET: api/CasePreActionMasters/5
        [ResponseType(typeof(CasePreActionMaster))]
        [Authorize]
        public IHttpActionResult GetCasePreActionMaster(int langID)
        {
            if (langID == 0)
            {
                langID = 1;
            }
            string companyID = ((ClaimsIdentity)User.Identity).Claims.FirstOrDefault(x => x.Type == "companyID").Value;
            string emailID = User.Identity.Name;
            var isValidaUserTofetch = db.RegisteredUsers.Where(e => e.AcctType.ToString() == "Admin" && e.CompanyID.ToString() == companyID && e.Email == emailID).FirstOrDefault();
            if (isValidaUserTofetch == null)
            {
                return Ok("Unauthorized");
            }

            var casePreActionMaster = (from lm in db.LanguageMasters
                                       join ld in db.CasePreActionMasters on lm.LanguageID equals ld.LanguageID
                                       where lm.LanguageID == langID && ld.CURN.ToString() == companyID
                                       select ld).ToList();

            if (casePreActionMaster == null)
            {
                return NotFound();
            }

            return Ok(casePreActionMaster);
        }

        // PUT: api/CasePreActionMasters/5
        [ResponseType(typeof(void))]
        public IHttpActionResult PutCasePreActionMaster(CasePreActionMaster casePreActionMaster)
        {
            try
            {
                var casePreObj = db.CasePreActionMasters.FirstOrDefault(d => d.CPURN == casePreActionMaster.CPURN);
                if (casePreObj != null)
                {
                    casePreObj.PreAction = casePreActionMaster.PreAction;
                    casePreObj.PreActionBrief = casePreActionMaster.PreActionBrief;
                    db.SaveChanges();
                }
                return Ok("Success");
            }
            catch (Exception ex)
            {
                return Ok("ERROR");
            }
        }

        // POST: api/CasePreActionMasters
        [ResponseType(typeof(CasePreActionMaster))]
        public IHttpActionResult PostCasePreActionMaster(CasePreActionMaster casePreActionMaster)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            db.CasePreActionMasters.Add(casePreActionMaster);

            try
            {
                db.SaveChanges();
            }
            catch (DbUpdateException)
            {
                if (CasePreActionMasterExists(casePreActionMaster.CPURN))
                {
                    return Conflict();
                }
                else
                {
                    throw;
                }
            }

            return CreatedAtRoute("DefaultApi", new { id = casePreActionMaster.CPURN }, casePreActionMaster);
        }

        // DELETE: api/CasePreActionMasters/5
        [ResponseType(typeof(CasePreActionMaster))]
        public IHttpActionResult DeleteCasePreActionMaster(Guid id)
        {
            CasePreActionMaster casePreActionMaster = db.CasePreActionMasters.Find(id);
            if (casePreActionMaster == null)
            {
                return NotFound();
            }

            db.CasePreActionMasters.Remove(casePreActionMaster);
            db.SaveChanges();

            return Ok(casePreActionMaster);
        }

        protected override void Dispose(bool disposing)
        {
            if (disposing)
            {
                db.Dispose();
            }
            base.Dispose(disposing);
        }

        private bool CasePreActionMasterExists(Guid id)
        {
            return db.CasePreActionMasters.Count(e => e.CPURN == id) > 0;
        }
    }
}
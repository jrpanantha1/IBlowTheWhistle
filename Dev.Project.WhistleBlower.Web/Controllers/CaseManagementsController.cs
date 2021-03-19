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
    public class CaseManagementsController : ApiController
    {
        private eformulus_IBTW_DBEntities db = new eformulus_IBTW_DBEntities();

        // GET: api/CaseManagements
        public IQueryable<CaseManagement> GetCaseManagements()
        {
            return db.CaseManagements;
        }

        // GET: api/CaseManagements/5
        [ResponseType(typeof(CaseManagement))]
        [Authorize]
        public IHttpActionResult GetCaseManagement(Guid IURN)
        {

            string companyID = ((ClaimsIdentity)User.Identity).Claims.FirstOrDefault(x => x.Type == "companyID").Value;
            var encPassword = db.CompanyMasters.FirstOrDefault(e => e.CURN.ToString() == companyID).encPassword;

            CaseManagementPageContentColn objPageContent = new CaseManagementPageContentColn();

            var CaseManagementObj = db.CaseManagements.Where(d => d.IURN == IURN).OrderByDescending(tt => tt.CaseUpdated).ToArray();
            var whistleBlowIncident = db.WhistleBlowIncidents.Where(d => d.IURN == IURN).FirstOrDefault();

            objPageContent.caseMngtColn = CaseManagementObj;
            objPageContent.whistleBlowIncidentObj = whistleBlowIncident;

            if (objPageContent == null)
            {
                return NotFound();
            }

            return Ok(objPageContent);
        }

        // PUT: api/CaseManagements/5
        [ResponseType(typeof(void))]
        public IHttpActionResult PutCaseManagement(Guid id, CaseManagement caseManagement)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            if (id != caseManagement.CaseURN)
            {
                return BadRequest();
            }

            db.Entry(caseManagement).State = EntityState.Modified;

            try
            {
                db.SaveChanges();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!CaseManagementExists(id))
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

        // POST: api/CaseManagements
        [ResponseType(typeof(CaseManagement))]
        [Authorize]
        public IHttpActionResult PostCaseManagement(CaseManagement caseManagement)
        {
            string regUserID = ((ClaimsIdentity)User.Identity).Claims.FirstOrDefault(x => x.Type == "regUserID").Value;
            string companyID = ((ClaimsIdentity)User.Identity).Claims.FirstOrDefault(x => x.Type == "companyID").Value;

            if (regUserID == "")
            {
                return BadRequest("Invalid Request");
            }
            CaseManagement objCase = new CaseManagement();
            objCase.CaseURN = Guid.NewGuid();
            objCase.IURN = caseManagement.IURN;
            objCase.CompanyURN = new Guid(companyID);
            objCase.RegUserID = new Guid(regUserID);
            objCase.CaseInformation = caseManagement.CaseInformation;
            objCase.CaseUpdated = System.DateTime.Now;

            db.CaseManagements.Add(objCase);

            try
            {
                db.SaveChanges();
            }
            catch (DbUpdateException)
            {
                if (CaseManagementExists(caseManagement.CaseURN))
                {
                    return Conflict();
                }
                else
                {
                    throw;
                }
            }

            return CreatedAtRoute("DefaultApi", new { id = caseManagement.CaseURN }, caseManagement);
        }

        // DELETE: api/CaseManagements/5
        [ResponseType(typeof(CaseManagement))]
        public IHttpActionResult DeleteCaseManagement(Guid id)
        {
            CaseManagement caseManagement = db.CaseManagements.Find(id);
            if (caseManagement == null)
            {
                return NotFound();
            }

            db.CaseManagements.Remove(caseManagement);
            db.SaveChanges();

            return Ok(caseManagement);
        }

        protected override void Dispose(bool disposing)
        {
            if (disposing)
            {
                db.Dispose();
            }
            base.Dispose(disposing);
        }

        private bool CaseManagementExists(Guid id)
        {
            return db.CaseManagements.Count(e => e.CaseURN == id) > 0;
        }
    }
    public class CaseManagementPageContentColn
    {
        public CaseManagement[] caseMngtColn { get; set; }
        public WhistleBlowIncident whistleBlowIncidentObj { get; set; }

    }
}
using Dev.Project.WhistleBlower.Web.Assessment;
using Dev.Project.WhistleBlower.Web.Data;
using Newtonsoft.Json.Linq;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Data.Entity.Infrastructure;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Text.RegularExpressions;
using System.Web.Http;
using System.Web.Http.Description;
using WhistleBlowerDAL;

namespace Dev.Project.WhistleBlower.Web.Controllers
{
    public class AssessmentResultsController : ApiController
    {
        private eformulus_IBTW_DBEntities db = new eformulus_IBTW_DBEntities();

        // GET: api/AssessmentResults
        public IQueryable<AssessmentResult> GetAssessmentResults()
        {
            return db.AssessmentResults;
        }

        // GET: api/AssessmentResults/5
        [ResponseType(typeof(AssessmentResult))]
        public IHttpActionResult GetAssessmentResult(Guid id)
        {
            AssessmentResult assessmentResult = db.AssessmentResults.Find(id);
            if (assessmentResult == null)
            {
                return NotFound();
            }

            return Ok(assessmentResult);
        }

        // PUT: api/AssessmentResults/5
        [ResponseType(typeof(void))]
        public IHttpActionResult PutAssessmentResult(Guid id, AssessmentResult assessmentResult)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            if (id != assessmentResult.AsResURN)
            {
                return BadRequest();
            }

            db.Entry(assessmentResult).State = EntityState.Modified;

            try
            {
                db.SaveChanges();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!AssessmentResultExists(id))
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

        // POST: api/AssessmentResults
        [ResponseType(typeof(AssessmentResult))]
        public IHttpActionResult PostAssessmentResult(Object objData)
        {

            try
            {

                dynamic jsonData = objData;

                JArray assessmentResultJSON = jsonData.assesmentColn;
                JObject AssUserDeatils = jsonData.userDetails;
                string strJson = jsonData.pdfContent;


                var pdfAttachmentBinaryData = strJson != null ? Convert.FromBase64String(strJson) : null;

                var ObjAssesmentUser = AssUserDeatils.ToObject<AssesmentUser>();
                Guid newUserID = Guid.NewGuid();

                AssesmentUser assesmentUser = new AssesmentUser();
                assesmentUser.AUserURN = newUserID;
                assesmentUser.Name = ObjAssesmentUser.Name;
                assesmentUser.EmailAddress = ObjAssesmentUser.EmailAddress;
                assesmentUser.Organisation = ObjAssesmentUser.Organisation;
                assesmentUser.Role = ObjAssesmentUser.Role;
                assesmentUser.Phone = ObjAssesmentUser.Phone;
                assesmentUser.AssesmentTakenOn = DateTime.Now;

                db.AssesmentUsers.Add(assesmentUser);
                db.SaveChanges();

                List<AssessmentResult> lstItemAssessmentResult = new List<AssessmentResult>();
                Guid newResID = Guid.NewGuid();
                foreach (var item in assessmentResultJSON)
                {
                    lstItemAssessmentResult.Add(item.ToObject<AssessmentResult>());
                }
                foreach (var objAssResult in lstItemAssessmentResult)
                {
                    newResID = Guid.NewGuid();

                    objAssResult.AsResURN = newResID;
                    objAssResult.AUserURN = newUserID;
                    objAssResult.Category = objAssResult.Category;
                    objAssResult.Question = objAssResult.Question;
                    objAssResult.GivenAns = objAssResult.GivenAns;
                    objAssResult.Created = DateTime.Now;

                    db.AssessmentResults.Add(objAssResult);
                    db.SaveChanges();
                }
                DoCalculation(lstItemAssessmentResult, ObjAssesmentUser.EmailAddress);
                //Utility.SendEmailWithAttachement(ObjAssesmentUser.EmailAddress, "IBTW - This is your assessment copy", "Please find attched copy of your assesment", pdfAttachmentBinaryData);
            }
            catch (Exception ex)
            {
                throw ex.InnerException;
                //return Ok("Error");
            }
            return Ok("Success");
        }


        // DELETE: api/AssessmentResults/5
        [ResponseType(typeof(AssessmentResult))]
        public IHttpActionResult DeleteAssessmentResult(Guid id)
        {
            AssessmentResult assessmentResult = db.AssessmentResults.Find(id);
            if (assessmentResult == null)
            {
                return NotFound();
            }

            db.AssessmentResults.Remove(assessmentResult);
            db.SaveChanges();

            return Ok(assessmentResult);
        }

        protected override void Dispose(bool disposing)
        {
            if (disposing)
            {
                db.Dispose();
            }
            base.Dispose(disposing);
        }

        private bool AssessmentResultExists(Guid id)
        {
            return db.AssessmentResults.Count(e => e.AsResURN == id) > 0;
        }

        private void DoCalculation(List<AssessmentResult> assessment,string senderEmailID)
        {
            double sumTRUST = 0;
            double sumIMPARTIALITY = 0;
            double sumPROTECTION = 0;
            var fResult = assessment.Where(a => a.Question != "What is Whistleblowing?").ToList();
            foreach (var item in fResult)
            {
                if (item.Category == "TRUST")
                {
                    sumTRUST = Convert.ToDouble(item.GivenAns.Split(':')[0]) + sumTRUST;
                }
                else if (item.Category == "IMPARTIALITY") {
                    sumIMPARTIALITY = Convert.ToDouble(item.GivenAns.Split(':')[0]) + sumIMPARTIALITY;
                }
                else if (item.Category == "PROTECTION") {
                    sumPROTECTION = Convert.ToDouble(item.GivenAns.Split(':')[0]) + sumPROTECTION;
                }
            }
            GeneratePDF.CreatPDF(sumTRUST, sumIMPARTIALITY, sumPROTECTION, senderEmailID);
        }
    }

    
}
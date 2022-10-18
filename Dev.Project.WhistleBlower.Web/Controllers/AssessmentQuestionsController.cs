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
    public class AssessmentQuestionsController : ApiController
    {
        private eformulus_IBTW_DBEntities db = new eformulus_IBTW_DBEntities();

        // GET: api/AssessmentQuestions
        public IQueryable<AssessmentQuestion> GetAssessmentQuestions()
        {
            return db.AssessmentQuestions;
        }

        // GET: api/AssessmentQuestions/5
        [ResponseType(typeof(AssessmentQuestion))]
        public IHttpActionResult GetAssessmentQuestion(Guid id)
        {
            AssessmentQuestion assessmentQuestion = db.AssessmentQuestions.Find(id);
            if (assessmentQuestion == null)
            {
                return NotFound();
            }

            return Ok(assessmentQuestion);
        }

        // PUT: api/AssessmentQuestions/5
        [ResponseType(typeof(void))]
        public IHttpActionResult PutAssessmentQuestion(Guid id, AssessmentQuestion assessmentQuestion)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            if (id != assessmentQuestion.AssURN)
            {
                return BadRequest();
            }

            db.Entry(assessmentQuestion).State = EntityState.Modified;

            try
            {
                db.SaveChanges();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!AssessmentQuestionExists(id))
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

        // POST: api/AssessmentQuestions
        [ResponseType(typeof(AssessmentQuestion))]
        public IHttpActionResult PostAssessmentQuestion(AssessmentQuestion assessmentQuestion)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            db.AssessmentQuestions.Add(assessmentQuestion);

            try
            {
                db.SaveChanges();
            }
            catch (DbUpdateException)
            {
                if (AssessmentQuestionExists(assessmentQuestion.AssURN))
                {
                    return Conflict();
                }
                else
                {
                    throw;
                }
            }

            return CreatedAtRoute("DefaultApi", new { id = assessmentQuestion.AssURN }, assessmentQuestion);
        }

        // DELETE: api/AssessmentQuestions/5
        [ResponseType(typeof(AssessmentQuestion))]
        public IHttpActionResult DeleteAssessmentQuestion(Guid id)
        {
            AssessmentQuestion assessmentQuestion = db.AssessmentQuestions.Find(id);
            if (assessmentQuestion == null)
            {
                return NotFound();
            }

            db.AssessmentQuestions.Remove(assessmentQuestion);
            db.SaveChanges();

            return Ok(assessmentQuestion);
        }

        protected override void Dispose(bool disposing)
        {
            if (disposing)
            {
                db.Dispose();
            }
            base.Dispose(disposing);
        }

        private bool AssessmentQuestionExists(Guid id)
        {
            return db.AssessmentQuestions.Count(e => e.AssURN == id) > 0;
        }
    }
}
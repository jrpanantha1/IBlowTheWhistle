using Dev.Project.WhistleBlower.Web.Data;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Security.Claims;
using System.Web.Http;
using System.Web.Http.Description;
using WhistleBlowerDAL;

namespace Dev.Project.WhistleBlower.Web.Controllers
{
    public class ViewDashboardController : ApiController
    {
        private eformulus_IBTW_DBEntities db = new eformulus_IBTW_DBEntities();
        [ResponseType(typeof(LanguageDetail))]
        [Authorize]
        public IHttpActionResult GetIncidentsDetail()
        {
            try
            {
                ViewDashboardPageContent objPageContent = new ViewDashboardPageContent();

                string companyID = ((ClaimsIdentity)User.Identity).Claims.FirstOrDefault(x => x.Type == "companyID").Value;
                //var objCM = db.CompanyMasters.FirstOrDefault(e => e.CURN.ToString() == companyID);

                //var decryptCompanyID = Cipher.Encrypt(companyID, objCM.encPassword);

                var incCount = from inc in db.WhistleBlowIncidents where inc.CompanyID.ToString() == companyID select inc.IURN;
                var IncidentsCount = incCount.ToList().Count;

                var incUnreadCount = from inc in db.WhistleBlowIncidents where inc.CompanyID.ToString() == companyID && inc.IncCategory == "Unread" select inc.IURN;
                var incImportantCount = from inc in db.WhistleBlowIncidents where inc.CompanyID.ToString() == companyID && inc.IncCategory == "Important" select inc.IURN;
                var incRTECount = from inc in db.WhistleBlowIncidents where inc.CompanyID.ToString() == companyID && inc.IncCategory == "Route to email" select inc.IURN;


                objPageContent.totalConcerns = IncidentsCount;
                objPageContent.totalConcernsUnread = incUnreadCount.ToList().Count;
                objPageContent.totalConcernsImportant = incImportantCount.ToList().Count;
                objPageContent.totalConcernsRTE = incRTECount.ToList().Count;

                var incMonth = db.WhistleBlowIncidents.Where(inc => inc.CompanyID.ToString() == companyID)
                                .GroupBy(o => new
                                {
                                    Year = o.SubmissionDateTime.Value.Year,
                                    Month = o.SubmissionDateTime.Value.Month
                                })
                                .Select(g => new IncDashboard
                                {
                                    Year = g.Key.Year,
                                    Month = g.Key.Month,
                                    IncidentTotal = g.Count()
                                })
                         .OrderByDescending(a => a.Year)
                        .ThenByDescending(a => a.Month)
                        .ToList();

                objPageContent.incRegistered = incMonth;

                var incReportable = db.WhistleBlowIncidents.Where(inc => inc.CompanyID.ToString() == companyID && inc.IsReportable == true)
                                .GroupBy(o => new
                                {
                                    Year = o.SubmissionDateTime.Value.Year,
                                    Month = o.SubmissionDateTime.Value.Month
                                })
                                .Select(g => new IncDashboard
                                {
                                    Year = g.Key.Year,
                                    Month = g.Key.Month,
                                    IncidentTotal = g.Count()
                                })
                         .OrderByDescending(a => a.Year)
                        .ThenByDescending(a => a.Month)
                        .ToList();

                objPageContent.incReportable = incReportable;

                var incHaveWitness = db.WhistleBlowIncidents.Where(inc => inc.CompanyID.ToString() == companyID && inc.HaveWitness == true)
                               .GroupBy(o => new
                               {
                                   Year = o.SubmissionDateTime.Value.Year,
                                   Month = o.SubmissionDateTime.Value.Month
                               })
                               .Select(g => new IncDashboard
                               {
                                   Year = g.Key.Year,
                                   Month = g.Key.Month,
                                   IncidentTotal = g.Count()
                               })
                        .OrderByDescending(a => a.Year)
                       .ThenByDescending(a => a.Month)
                       .ToList();


                objPageContent.inchaveWitness = incHaveWitness;

                return Ok(objPageContent);
            }
            catch (Exception ex)
            {
                return null;
            }
        }
    }

    public class ViewDashboardPageContent
    {
        public ViewDashboardPageContent()
        {

            incRegistered = null;
            incReportable = null;
            inchaveWitness = null;
        }

        public Int32 totalConcerns { get; set; }
        public Int32 totalConcernsUnread { get; set; }
        public Int32 totalConcernsImportant { get; set; }
        public Int32 totalConcernsRTE { get; set; }
        public List<IncDashboard> incRegistered { get; set; }
        public List<IncDashboard> incReportable { get; set; }
        public List<IncDashboard> inchaveWitness { get; set; }


    }
}

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
        public IEnumerable<IncDashboard> GetIncidentsDetail()
        {
            try
            {
                string companyID = ((ClaimsIdentity)User.Identity).Claims.FirstOrDefault(x => x.Type == "companyID").Value;
                //var objCM = db.CompanyMasters.FirstOrDefault(e => e.CURN.ToString() == companyID);

                //var decryptCompanyID = Cipher.Encrypt(companyID, objCM.encPassword);

                var incCount = from inc in db.WhistleBlowIncidents where inc.CompanyID.ToString() == companyID select inc.IURN;
                var IncidentsCount = incCount.ToList().Count;

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



                return incMonth;
            }
            catch (Exception ex)
            {
                return null;
            }
        }
    }
}

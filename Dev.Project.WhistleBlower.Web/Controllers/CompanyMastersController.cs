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
using System.Web;
using System.Web.Http;
using System.Web.Http.Description;
using WhistleBlowerDAL;

namespace Dev.Project.WhistleBlower.Web.Controllers
{
    public class CompanyMastersController : ApiController
    {
        private eformulus_IBTW_DBEntities db = new eformulus_IBTW_DBEntities();


        // GET: api/CompanyMasters/5
        [ResponseType(typeof(CompanyMaster))]
        public IHttpActionResult GetCompanyMaster(long id)
        {
            string path_and_query = HttpContext.Current.Request.UrlReferrer.ToString();
            bool hasKeys = path_and_query.Contains('?');
            try
            {


                if (hasKeys == true)
                {
                    string temp = path_and_query.Split('?')[1].ToString();

                    string key = temp.Split(new string[] { "/ib" }, StringSplitOptions.None)[0].ToString();
                    string value = temp.Split(new string[] { "/ib" }, StringSplitOptions.None)[1].ToString();


                    Setting settingObj = db.Settings.Find(1);

                    string degryptKey = Cipher.Decrypt(key, settingObj.SettingValue);
                    string degryptValue = Cipher.Decrypt(value, settingObj.SettingValue);


                    IList<CompanyMaster> objCompany = db.CompanyMasters.Where(e => e.CompanyKey.ToString() == degryptKey && e.CompanyValue == degryptValue).ToList();
                    if (objCompany == null)
                    {
                        return NotFound();


                    }

                    return Ok(objCompany);
                }
                else
                    return NotFound();
            }
            catch (Exception)
            {
                return NotFound();
            }
        }


        [Authorize]
        public IHttpActionResult PostUpdateCompany([FromBody]CompanyMaster companyDetails)
        {
            try
            {
                string updatedURL = "";
                string companyID = ((ClaimsIdentity)User.Identity).Claims.FirstOrDefault(x => x.Type == "companyID").Value;
                var result = db.CompanyMasters.FirstOrDefault(u => u.CURN.ToString().Trim().ToUpper().Equals(companyID.ToUpper()));
                if (result != null)
                {

                    if (!string.IsNullOrEmpty(companyDetails.CompanyLogo))
                    {
                        if (!companyDetails.CompanyLogo.Contains(@"/IBTWImages/"))
                        {
                            //if (result.SubscriptionType == "")
                            //{

                            //}
                            updatedURL = Utility.UploadCompanyImagefromBase64(companyDetails.CompanyLogo, companyID);
                            result.CompanyLogo = updatedURL;
                        }
                    }
                    db.SaveChanges();
                    return Ok(updatedURL);
                }
                else
                {
                    return NotFound();
                }

            }
            catch (Exception ex)
            {
                throw ex;
            }
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
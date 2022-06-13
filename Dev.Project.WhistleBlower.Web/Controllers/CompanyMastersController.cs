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

                    //string key = temp.Split(new string[] { "/ib" }, StringSplitOptions.None)[0].ToString();
                    //string value = temp.Split(new string[] { "/ib" }, StringSplitOptions.None)[1].ToString();

                    string value = temp.Split(new string[] { "/ib" }, StringSplitOptions.None)[0].ToString();


                    Setting settingObj = db.Settings.Find(1);

                    // string degryptKey = Cipher.Decrypt(key, settingObj.SettingValue);
                    string degryptValue = Cipher.Decrypt(value, settingObj.SettingValue);


                    //var objCompany = db.CompanyMasters.Where(e => e.CompanyKey.ToString() == degryptKey && e.CompanyValue == degryptValue).FirstOrDefault();
                    var objCompany = db.CompanyMasters.Where(e => e.CompanyValue == degryptValue).FirstOrDefault();
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
        [ResponseType(typeof(CompanyMaster))]
        public IHttpActionResult GetCompanyMaster(string companyID)
        {
            try
            {
                var objCM = db.CompanyMasters.FirstOrDefault(e => e.CURN.ToString() == companyID);
                if (objCM != null)
                {
                    objCM.CompanyKey = Cipher.Encrypt(objCM.CompanyKey, objCM.encPassword);
                    objCM.CompanyValue = Cipher.Encrypt(objCM.CompanyValue, objCM.encPassword);

                }
                return Ok(objCM);
            }
            catch (Exception)
            {

                return Ok("error");
            }


        }
        [Authorize]
        [ResponseType(typeof(CompanyMaster))]
        public IHttpActionResult GetCompanyMaster()
        {
            try
            {
                var objCompany = db.CompanyMasters.ToList();
                if (objCompany == null)
                {
                    return NotFound();
                }
                return Ok(objCompany);
            }
            catch (Exception)
            {
                return NotFound();
            }
        }
        [Authorize]
        public IHttpActionResult PostUpdateCompany([FromBody] CompanyMasterObj companyDetails)
        {
            try
            {
                string updatedURL = "";
                string companyID = ((ClaimsIdentity)User.Identity).Claims.FirstOrDefault(x => x.Type == "companyID").Value;
                var result = db.CompanyMasters.FirstOrDefault(u => u.CURN.ToString().Trim().ToUpper().Equals(companyID.ToUpper()));
                if (result != null)
                {

                    if (!string.IsNullOrEmpty(companyDetails.TopBannerAlternateURL))
                    {
                        result.TopBannerAlternateURL = companyDetails.TopBannerAlternateURL;
                    }

                    if (!string.IsNullOrEmpty(companyDetails.CompanyLogo))
                    {
                        if (!companyDetails.CompanyLogo.Contains(@"/IBTWImages/"))
                        {
                            if (result.SubscriptionPlan != 1)
                            {
                                updatedURL = Utility.UploadCompanyImagefromBase64(companyDetails.CompanyLogo, companyID);
                                //if (!string.IsNullOrEmpty(companyDetails.CompanyTopBanner))
                                //{
                                //    updatedURL = Utility.UploadCompanyTopBannerfromBase64(companyDetails.CompanyTopBanner, companyID);
                                //}
                                result.CompanyLogo = updatedURL;
                            }

                        }
                    }
                    else if (!string.IsNullOrEmpty(companyDetails.CompanyTopBanner))
                    {
                        if (!companyDetails.CompanyTopBanner.Contains(@"/IBTWImages/"))
                        {
                            if (result.SubscriptionPlan != 1)
                            {
                                updatedURL = Utility.UploadCompanyTopBannerfromBase64(companyDetails.CompanyTopBanner, companyID);
                            }

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

        [Authorize]
        public IHttpActionResult PUTUpdateCompany([FromBody] CompanyMasterObj companyDetails)
        {
            try
            {
                string companyID = ((ClaimsIdentity)User.Identity).Claims.FirstOrDefault(x => x.Type == WhistleContants.CompanyID).Value;
                var result = db.CompanyMasters.FirstOrDefault(u => u.CURN.ToString().Trim().ToUpper().Equals(companyID.ToUpper()));

                if (result != null)
                {
                    result.SendAdmNotifyOnNewCase = companyDetails.SendAdmNotifyOnNewCase != null ? companyDetails.SendAdmNotifyOnNewCase : false;
                    db.SaveChanges();
                    return Ok(WhistleContants.SuccessAdminNotification);
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
    public partial class CompanyMasterObj
    {
        public System.Guid CURN { get; set; }
        public long CompanyID { get; set; }
        public string CompanyName { get; set; }
        public string CompanyKey { get; set; }
        public string CompanyValue { get; set; }
        public Nullable<bool> isActive { get; set; }
        public string encPassword { get; set; }
        public string Address { get; set; }
        public string CRNumber { get; set; }
        public string BusinessArea { get; set; }
        public string ContactNumber { get; set; }
        public Nullable<System.DateTime> JoinedDate { get; set; }
        public string ContactEmail { get; set; }
        public string LoginPassword { get; set; }
        public string SubscriptionType { get; set; }
        public string CompanyLogo { get; set; }
        public string CompanyTopBanner { get; set; }
        public Nullable<int> SubscriptionPlan { get; set; }
        public Nullable<bool> SendAdmNotifyOnNewCase { get; set; }
        public string TopBannerAlternateURL { get; set; }
    }
}
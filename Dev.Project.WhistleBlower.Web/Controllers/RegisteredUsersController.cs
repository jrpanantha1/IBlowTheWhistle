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
using System.Web.Security;
using WhistleBlowerDAL;

namespace Dev.Project.WhistleBlower.Web.Controllers
{
    public class RegisteredUsersController : ApiController
    {
        private eformulus_IBTW_DBEntities db = new eformulus_IBTW_DBEntities();

        // GET: api/RegisteredUsers
        public IEnumerable<RegisteredUser> GetRegisteredUsers()
        {
            string emailID = User.Identity.Name;
            string AccType = ((ClaimsIdentity)User.Identity).Claims.FirstOrDefault(x => x.Type == "accType").Value;
            List<RegisteredUser> rUser = db.RegisteredUsers.Where(r => r.Email == emailID).ToList();

            return rUser;
        }
        [Authorize]
        public IEnumerable<RegisteredUser> GetRegisteredUsers(string AcctType)
        {
            string companyID = ((ClaimsIdentity)User.Identity).Claims.FirstOrDefault(x => x.Type == "companyID").Value;
            List<RegisteredUser> rUser = db.RegisteredUsers.Where(e => e.AcctType.ToString() == AcctType && e.CompanyID.ToString() == companyID).ToList();

            return rUser;
        }
        [Authorize]
        public IHttpActionResult GETAdminCountRegisterdUser(bool adminOnly)
        {
            RegUserPageContent objRegUserContent = new RegUserPageContent();

            string companyID = ((ClaimsIdentity)User.Identity).Claims.FirstOrDefault(x => x.Type == "companyID").Value;
            var adminUsers = db.RegisteredUsers.OrderBy(tt => tt.FullName).Where(e => e.AcctType.ToString() == WhistleContants.AdminUserAccountType && e.CompanyID.ToString() == companyID).Select(dd => dd.FullName != "" ? dd.FullName : dd.FirstName + " " + dd.LastName).ToList();
            List<RegisteredUser> objRegUser = new List<RegisteredUser>();
            if (adminUsers != null)
            {

                foreach (var item in adminUsers)
                {
                    objRegUser.Add(new RegisteredUser
                    {
                        FullName = item
                    });
                }
            }
            objRegUserContent.objAdminCount = adminUsers.Count();
            objRegUserContent.objRegUser = objRegUser;

            return Ok(objRegUserContent);
        }
        [Authorize]
        public IHttpActionResult PostRegisterdUser(RegisteredUser objRegisterdUser)
        {
            string retnPassword = "";
            string retnMessage = "";

            if (objRegisterdUser.Email != "")
            {
                string companyID = ((ClaimsIdentity)User.Identity).Claims.FirstOrDefault(x => x.Type == "companyID").Value;

                if (objRegisterdUser.CompanyID == null || objRegisterdUser.CompanyID == Guid.Empty)
                {
                    var objCompany = db.CompanyMasters.Where(e => e.CURN.ToString() == companyID).FirstOrDefault();
                    if (objCompany != null)
                    {
                        var adminCount = db.RegisteredUsers.Where(e => e.AcctType.ToString() == WhistleContants.AdminUserAccountType && e.CompanyID.ToString() == companyID).Count();
                        var objSubsPlan = db.SubscriptionPlans.Where(e => e.PlanID == objCompany.SubscriptionPlan).FirstOrDefault();

                        if (adminCount >= objSubsPlan.AdminSeatCount)
                        {
                            retnMessage = "You have reached maximum count " + objSubsPlan.AdminSeatCount + " for your current plan. please contact I Blow the Whistle admin";
                            return Ok(retnMessage);
                        }
                        if (objRegisterdUser.IsPrimaryAcc == true)
                        {
                            var primaryAdminCount = db.RegisteredUsers.Where(e => e.AcctType.ToString() == WhistleContants.AdminUserAccountType && e.CompanyID.ToString() == companyID && e.IsPrimaryAcc == true).Count();
                            if (primaryAdminCount > 0)
                            {
                                retnMessage = "You have already a primary account; A company can have only one primary account";
                                return Ok(retnMessage);
                            }
                        }
                    }
                }
                Guid regID = Guid.NewGuid();
                objRegisterdUser.RegUserID = regID;
                objRegisterdUser.CompanyID = objRegisterdUser.CompanyID != null && objRegisterdUser.CompanyID != Guid.Empty ? objRegisterdUser.CompanyID : new Guid(companyID);
                objRegisterdUser.AcctType = WhistleContants.AdminUserAccountType;
                objRegisterdUser.ActivationStatus = true;
                objRegisterdUser.CreatedOn = System.DateTime.Now;
                objRegisterdUser.IsPrimaryAcc = objRegisterdUser.IsPrimaryAcc;
                retnPassword = objRegisterdUser.Password != "" && objRegisterdUser.Password != null ? "" : "Generated";

                string RandomPasswordTobeUpdated = Membership.GeneratePassword(WhistleContants.PasswordLength, WhistleContants.PasswordNumericCharLength);
                var encPassword = db.CompanyMasters.FirstOrDefault(e => e.CURN == objRegisterdUser.CompanyID).encPassword;
                RandomPasswordTobeUpdated = Cipher.EncryptPassword(RandomPasswordTobeUpdated, encPassword);

                //objRegisterdUser.Password = objRegisterdUser.Password != "" && objRegisterdUser.Password != null ? objRegisterdUser.Password : Membership.GeneratePassword(WhistleContants.PasswordLength, WhistleContants.PasswordNumericCharLength);
                objRegisterdUser.Password = objRegisterdUser.Password != "" && objRegisterdUser.Password != null ? Cipher.EncryptPassword(objRegisterdUser.Password, encPassword) : RandomPasswordTobeUpdated;


                db.RegisteredUsers.Add(objRegisterdUser);
                try
                {
                    db.SaveChanges();
                    if (retnPassword != null && retnPassword != "Generated")
                    {
                        return Ok("Success");
                    }
                    else
                        return Ok(objRegisterdUser.Password);
                }
                catch (DbUpdateException)
                {
                    if (RegisteredUserExists(objRegisterdUser.RegUserID))
                    {
                        return Conflict();
                    }
                    else
                    {
                        throw;
                    }
                }
            }
            return CreatedAtRoute("DefaultApi", new { id = objRegisterdUser.RegUserID }, objRegisterdUser);
        }
        [Authorize]
        public IHttpActionResult PutResetPassword([FromBody] RegisteredUser userDetails)
        {
            try
            {
                string emailID = userDetails.Email != null && userDetails.Email != "" ? userDetails.Email : User.Identity.Name;
                bool passWordChanged = false;
                var result = db.RegisteredUsers.FirstOrDefault(u => u.Email.ToString().Equals(emailID));
                if (result != null)
                {
                    if (userDetails.Password != null && userDetails.Password != "")
                    {

                        var encPassword = db.CompanyMasters.FirstOrDefault(e => e.CURN == result.CompanyID).encPassword;
                        result.Password = Cipher.EncryptPassword(userDetails.Password, encPassword);// userDetails.Password;
                        passWordChanged = true;
                    }
                    if (userDetails.PreferredTimeZone != null && userDetails.PreferredTimeZone != "")
                    {
                        result.PreferredTimeZone = userDetails.PreferredTimeZone;
                    }
                    if (userDetails.PreferredLanguage != null)
                    {
                        result.PreferredLanguage = userDetails.PreferredLanguage;
                    }
                    if (userDetails.PreferredFilter != null)
                    {
                        result.PreferredFilter = userDetails.PreferredFilter;
                    }
                    if (userDetails.FirstName != null && userDetails.FirstName != "")
                    {
                        result.FirstName = userDetails.FirstName;
                    }
                    if (userDetails.LastName != null && userDetails.LastName != "")
                    {
                        result.LastName = userDetails.LastName;
                    }
                    if (userDetails.FullName != null && userDetails.FullName != "")
                    {
                        result.FullName = userDetails.FullName;
                    }
                    result.ModifiedOn = System.DateTime.Now;
                    if (passWordChanged)
                    {
                        result.UpdateReason = "user details get changed including password";
                    }
                    else
                        result.UpdateReason = "user details get changed except password";


                    db.SaveChanges();
                    return Ok("updated successfully.");
                }
                else
                {
                    return NotFound();
                }

            }
            catch (Exception ex)
            {
                throw;
            }
        }
        [Authorize]
        public IHttpActionResult PutResetPassword([FromBody] RegisteredUser userDetails, bool adminOnlyAllowed)
        {
            try
            {
                if (adminOnlyAllowed)
                {
                    var result = db.RegisteredUsers.FirstOrDefault(u => u.Email.ToString().Equals(userDetails.Email));
                    if (result != null)
                    {
                        var encPassword = db.CompanyMasters.FirstOrDefault(e => e.CURN == result.CompanyID).encPassword;
                        result.Password = Cipher.EncryptPassword(userDetails.Password, encPassword);// userDetails.Password;

                        //result.Password = userDetails.Password;
                        db.SaveChanges();
                        return Ok("Password updated successfully.");
                    }
                    else
                    {
                        return NotFound();
                    }
                }
                else
                    return NotFound();

            }
            catch (Exception ex)
            {
                throw;
            }
        }
        [Authorize]
        // DELETE: api/BannerLangMasters/5
        [ResponseType(typeof(RegisteredUser))]
        public IHttpActionResult DeleteRegisteredUser(Guid id)
        {
            try
            {

                RegisteredUser regUserAcc = db.RegisteredUsers.Find(id);
                if (regUserAcc == null)
                {
                    return NotFound();
                }

                db.RegisteredUsers.Remove(regUserAcc);
                db.SaveChanges();

                return Ok("Success");
            }
            catch (Exception ex)
            {

                return Ok(ex.Message);
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

        private bool RegisteredUserExists(Guid id)
        {
            return db.RegisteredUsers.Count(e => e.RegUserID == id) > 0;
        }
    }

    public class RegUserPageContent
    {
        public RegUserPageContent()
        {
            objAdminCount = 0;
            objRegUser = null;

        }

        public List<RegisteredUser> objRegUser { get; set; }
        public int objAdminCount { get; set; }


    }
}
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
                        if (objCompany.SubscriptionPlan == 1)//Basic
                        {
                            if (adminCount >= 3)
                            {
                                retnMessage = "you have reached maximum count 3 for you current plan. please contact blow the whistle admin";
                                return Ok(retnMessage);
                            }
                        }
                        else if (objCompany.SubscriptionPlan == 2)//PREMIUM
                        {
                            if (adminCount >= 10)
                            {
                                retnMessage = "you have reached maximum count 10 for you current plan. please contact blow the whistle admin";
                                return Ok(retnMessage);
                            }

                        }
                        else if (objCompany.SubscriptionPlan == 3)//BESPOKE
                        {
                            if (adminCount >= 20)
                            {
                                retnMessage = "you have reached maximum count 20 for you current plan. please contact blow the whistle admin";
                                return Ok(retnMessage);
                            }
                        }
                        else // defualt basic paln
                        {
                            if (adminCount >= 3)
                            {
                                retnMessage = "you have reached maximum count 3 for you current plan. please contact blow the whistle admin";
                                return Ok(retnMessage);
                            }
                        }
                    }
                }
                Guid regID = Guid.NewGuid();
                objRegisterdUser.RegUserID = regID;
                objRegisterdUser.CompanyID = objRegisterdUser.CompanyID != null && objRegisterdUser.CompanyID != Guid.Empty ? objRegisterdUser.CompanyID : new Guid(companyID);
                objRegisterdUser.AcctType = WhistleContants.AdminUserAccountType;
                retnPassword = objRegisterdUser.Password != "" && objRegisterdUser.Password != null ? "" : "Generated";

                objRegisterdUser.Password = objRegisterdUser.Password != "" && objRegisterdUser.Password != null ? objRegisterdUser.Password : Membership.GeneratePassword(WhistleContants.PasswordLength, WhistleContants.PasswordNumericCharLength);


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
                string emailID = User.Identity.Name;

                var result = db.RegisteredUsers.FirstOrDefault(u => u.Email.ToString().Equals(emailID));
                if (result != null)
                {
                    result.Password = userDetails.Password;
                    db.SaveChanges();
                    return Ok("Password updated successfully.");
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
}
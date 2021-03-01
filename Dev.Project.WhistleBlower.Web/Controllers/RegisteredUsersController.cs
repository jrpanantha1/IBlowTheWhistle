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
        public IHttpActionResult PostResetPassword([FromBody]RegisteredUser userDetails)
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
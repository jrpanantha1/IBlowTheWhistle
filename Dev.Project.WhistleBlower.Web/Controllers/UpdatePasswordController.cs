using Dev.Project.WhistleBlower.Web.Data;
using System;
using System.Collections.Generic;
using System.Data.Entity.Infrastructure;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Security.Claims;
using System.Web.Http;
using WhistleBlowerDAL;

namespace Dev.Project.WhistleBlower.Web.Controllers
{
    public class UpdatePasswordController : ApiController
    {
        private eformulus_IBTW_DBEntities db = new eformulus_IBTW_DBEntities();
        [AllowAnonymous]
        public IHttpActionResult PutResetPassword([FromBody] RegisteredUser userDetails)
        {
            try
            {
                string uID = userDetails.RegUserID.ToString();

                var result = db.RegisteredUsers.FirstOrDefault(u => u.RegUserID.ToString().Equals(uID));

                if (result != null)
                {
                    if (userDetails.Password != null && userDetails.Password != "")
                    {
                        //result.Password = userDetails.Password;
                        //sha256 encryption
                        var encPassword = db.CompanyMasters.FirstOrDefault(e => e.CURN == result.CompanyID).encPassword;
                        result.Password = Cipher.EncryptPassword(userDetails.Password, encPassword);

                        result.UpdateReason = "Password got changed";
                    }
                    result.ModifiedOn = System.DateTime.Now;

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
                throw ex;
            }
        }
    }
}

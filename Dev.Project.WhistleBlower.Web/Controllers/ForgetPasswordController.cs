using Dev.Project.WhistleBlower.Web.Data;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using WhistleBlowerDAL;

namespace Dev.Project.WhistleBlower.Web.Controllers
{
    public class ForgetPasswordController : ApiController
    {
        [AllowAnonymous]
        public HttpResponseMessage GETCheckValidEmailID(string UserEmail)
        {
            try
            {
                if (UserEmail.Contains("@Iblowthewhistle.com"))
                {
                    return Request.CreateErrorResponse(HttpStatusCode.OK, "Not valid Email");
                }
                else
                {
                    RegisteredUser emailAddress = Utility.GetRegistredUserDetailsForForgotPass(UserEmail);
                    if (emailAddress != null)
                    {
                        return Request.CreateResponse(HttpStatusCode.OK, emailAddress.Email);
                    }
                    else
                        return Request.CreateErrorResponse(HttpStatusCode.OK, "Email not found");
                }

            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.BadRequest, ex);
            }

        }

        public HttpResponseMessage PostPasswordManagement([FromBody] RegisteredUser userDetails)
        {
            try
            {
                if (userDetails != null)
                {
                    using (eformulus_IBTW_DBEntities Entities = new eformulus_IBTW_DBEntities())
                    {
                        var result = Entities.RegisteredUsers.FirstOrDefault(u => u.Email.Equals(userDetails.Email));

                        if (result != null)
                        {
                            string confirmUrl = "https://apps.iblowthewhistle.com/Pages/UpdatePassword.aspx?uid=" + result.RegUserID;
                            string mailMessage = Utility.GetEmailTemplate("103");
                            mailMessage = string.Format(mailMessage, confirmUrl);
                            Utility.SendEmail(userDetails.Email, "Reset Password", mailMessage);
                            return Request.CreateResponse(HttpStatusCode.OK, "Password reset link send successfully, you will receive email to update your password");
                        }
                        else
                        {
                            return Request.CreateErrorResponse(HttpStatusCode.Ambiguous, "No user data found ");
                        }
                    }
                }
                else
                {
                    return Request.CreateErrorResponse(HttpStatusCode.Ambiguous, "No user data found ");
                }
            }
            catch (Exception ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.BadRequest, ex);
            }

        }
    }
}

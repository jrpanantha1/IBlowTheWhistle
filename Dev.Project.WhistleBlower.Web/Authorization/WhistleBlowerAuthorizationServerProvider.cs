using Dev.Project.WhistleBlower.Web.Data;
using Microsoft.Owin.Security.OAuth;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Claims;
using System.Text.RegularExpressions;
using System.Threading.Tasks;
using System.Web;
using WhistleBlowerDAL;

namespace Dev.Project.WhistleBlower.Web.Authorization
{
    public class WhistleBlowerAuthorizationServerProvider : OAuthAuthorizationServerProvider
    {
        public override async Task ValidateClientAuthentication(OAuthValidateClientAuthenticationContext context)
        {
            context.Validated();
        }

        public override async Task GrantResourceOwnerCredentials(OAuthGrantResourceOwnerCredentialsContext context)
        {
            var identity = new ClaimsIdentity(context.Options.AuthenticationType);
            var session = HttpContext.Current.Session;
            Regex regex = new Regex("[0-9]");

            //temp
            //validation 
            string path_and_query = HttpContext.Current.Request.UrlReferrer.ToString();
            bool hasKeys = path_and_query.Contains('?');

            try
            {
                #region Replaced the same login in Home.js page load
                //if (hasKeys == true)
                //{

                //    string temp = path_and_query.Split('?')[1].ToString();

                //    string key = temp.Split(new[] { '/' }, 2)[0].ToString();
                //    string value = temp.Split(new[] { '/' }, 2)[1].ToString();


                //    if (key != "" && value != "")
                //    {
                //        IList<CompanyMaster> objCompany = Utility.CheckCompanyExists(key, value);

                //        if (objCompany != null && objCompany.Count > 0)
                //        {
                //            identity.AddClaim(new Claim(ClaimTypes.Name, value));
                //            identity.AddClaim(new Claim("companyID", objCompany[0].CURN.ToString()));
                //            identity.AddClaim(new Claim("encPassword", objCompany[0].encPassword));
                //            context.Validated(identity);
                //        }
                //        else
                //        {
                //            context.SetError("Invalid user company");

                //        }
                //    }
                //    else
                //    {
                //        context.SetError("Invalid user company");

                //    }
                //}
                #endregion
                if (regex.IsMatch(context.Password) && context.UserName == "")
                {
                    IList<CompanyMaster> objCompany = Utility.CheckCompanyExistsByKey(context.Password);

                    if (objCompany != null && objCompany.Count > 0)
                    {
                        identity.AddClaim(new Claim("companyID", objCompany[0].CURN.ToString()));
                        identity.AddClaim(new Claim("encPassword", objCompany[0].encPassword));
                        context.Validated(identity);
                    }
                    else
                    {
                        context.SetError("Invalid user company");

                    }
                }
                else
                {

                    if (context.UserName != "" && context.Password != "")
                    {
                        RegisteredUser GetUserDetails = Utility.GetRegistredUserDetails(context.UserName);
                        if (GetUserDetails.Email.Trim().ToLower() == context.UserName.Trim().ToLower())
                        {
                            if (GetUserDetails.Password == context.Password)
                            {
                                identity.AddClaim(new Claim(ClaimTypes.Name, context.UserName));
                                identity.AddClaim(new Claim("companyID", GetUserDetails.CompanyID.ToString()));
                                identity.AddClaim(new Claim("accType", GetUserDetails.AcctType.ToString()));
                                identity.AddClaim(new Claim("regUserID", GetUserDetails.RegUserID.ToString()));
                                context.Validated(identity);
                            }
                            else
                            {
                                context.SetError("Login Error");
                            }
                        }
                        else
                        {
                            context.SetError("User not found");

                        }
                    }
                    else
                        context.SetError("Invalid user company");

                }

            }
            catch (Exception)
            {

                context.SetError("Invalid user company");
            }

        }
    }
}
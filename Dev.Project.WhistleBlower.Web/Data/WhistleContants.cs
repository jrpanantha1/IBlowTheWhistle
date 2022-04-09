using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Configuration;

namespace Dev.Project.WhistleBlower.Web.Data
{
    public static class WhistleContants
    {
        public const string encryptionKey = "Whistle!2@3#4$";
        // public const string CaptchaKey = "6LfpuGwUAAAAADKyN4TDJYkANzBieUD7_SfkzEL5";//Development
        public static string googleCAPTCHAKey = WebConfigurationManager.AppSettings["CAPTCHAKey"].ToString();

        //public const string CaptchaKey = "6LdIoOYUAAAAAHY5zoDMehujAIpADpDPNAJuYdei";//Staging;

        #region application string
        public const string anonymousUserAccountType = "Anonymous User";
        public const string AdminUserAccountType = "Admin";
        public const string normalUserAccountType = "User";
        public const string AccountExistMessage = "There is an secure account with this email. Please use existing credentials.";
        public const int PasswordLength = 12;
        public const int PasswordNumericCharLength = 2;
        public const string CompanyID = "companyID";
        public const string SuccessAdminNotification = "Successfully updated admin notification preferances";
        #endregion
    }
}
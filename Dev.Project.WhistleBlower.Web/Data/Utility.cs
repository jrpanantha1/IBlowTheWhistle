using System;
using System.Collections.Generic;
using System.Configuration;
using System.Drawing;
using System.IO;
using System.Linq;
using System.Net.Mail;
using System.Text.RegularExpressions;
using System.Web;
using WhistleBlowerDAL;

namespace Dev.Project.WhistleBlower.Web.Data
{
    public class Utility
    {
        public static IList<CompanyMaster> CheckCompanyExists(string companyKey, string companyValue)
        {
            string companyID = string.Empty;
            IList<CompanyMaster> objCM = null;
            try
            {
                using (eformulus_IBTW_DBEntities Entities = new eformulus_IBTW_DBEntities())
                {

                    string degryptKey = Cipher.Decrypt(companyKey, "");
                    string degryptValue = Cipher.Decrypt(companyValue, "");

                    objCM = Entities.CompanyMasters.Where(e => e.CompanyKey.ToString() == degryptKey && e.CompanyValue == degryptValue).ToList();

                }
            }
            catch (Exception ex)
            {

            }

            return objCM;
        }
        public static IList<CompanyMaster> CheckCompanyExistsByKey(string companyKey)
        {
            string companyID = string.Empty;
            IList<CompanyMaster> objCM = null;
            try
            {
                using (eformulus_IBTW_DBEntities Entities = new eformulus_IBTW_DBEntities())
                {

                    objCM = Entities.CompanyMasters.Where(e => e.CompanyValue.ToString() == companyKey).ToList();

                }
            }
            catch (Exception ex)
            {

            }

            return objCM;
        }

        public static RegisteredUser GetRegistredUserDetails(string emailID)
        {
            RegisteredUser userDetail = new RegisteredUser();
            try
            {
                using (eformulus_IBTW_DBEntities Entities = new eformulus_IBTW_DBEntities())
                {

                    if (!string.IsNullOrEmpty(emailID))
                    {
                        var userCheck = Entities.RegisteredUsers.FirstOrDefault(e => e.Email.Trim() == emailID);
                        if (userCheck != null)
                        {
                            userDetail.UserID = userCheck.UserID;
                            userDetail.Email = userCheck.Email;
                            userDetail.Password = userCheck.Password;
                            userDetail.CompanyID = userCheck.CompanyID;
                            userDetail.RegUserID = userCheck.RegUserID;
                            userDetail.AcctType = userCheck.AcctType != null && userCheck.AcctType != "" ? userCheck.AcctType : "User";
                        }
                        else
                            return null;

                    }
                }
            }
            catch (Exception ex)
            {

            }

            return userDetail;
        }
        public static void SendEmail(string mailID, string subject, string message)
        {

            string mailServer = ConfigurationManager.AppSettings["TacitousMailServer"];
            string mailServerUN = ConfigurationManager.AppSettings["TacitousMailServerUN"];
            string mailServerPSW = ConfigurationManager.AppSettings["TacitousMailServerPSW"];
            try
            {
                MailMessage objeto_mail = new MailMessage();
                SmtpClient client = new SmtpClient();
                client.Port = 25;
                client.Host = mailServer;
                client.Credentials = new System.Net.NetworkCredential(mailServerUN, mailServerPSW);
                client.EnableSsl = false;
                objeto_mail.From = new MailAddress("administrator@tacitous.com");
                objeto_mail.To.Add(new MailAddress(mailID));
                objeto_mail.Subject = subject;
                objeto_mail.IsBodyHtml = true;
                string mailBody = message;
                objeto_mail.Body = mailBody;
                client.Send(objeto_mail);
            }
            catch (Exception ex) { throw ex.InnerException; }
        }
        public static string GetEmailTemplate(string tempID)
        {
            string mailTemplate = string.Empty;
            try
            {
                using (eformulus_IBTW_DBEntities Entities = new eformulus_IBTW_DBEntities())
                {
                    if (!string.IsNullOrEmpty(tempID))
                    {
                        var data = Entities.EmailTemplates.FirstOrDefault(e => e.TemplateID.Trim() == tempID);
                        mailTemplate = data.Template;
                        return mailTemplate;
                    }

                }
            }
            catch (Exception ex)
            {

            }
            return mailTemplate;
        }
        static Random _random = new Random();
        public static string getRandomEmail()
        {
            int result = _random.Next();
            return result.ToString();

        }
        public static string UploadImagefromBase64(string base64, string ID, string companyID = "")
        {
            string imgPath = "";
            try
            {
                Image cImage = null;
                var base64Data = Regex.Match(base64, @"data:image/(?<type>.+?),(?<data>.+)").Groups["data"].Value;
                var binData = Convert.FromBase64String(base64Data);

                //using (var stream = new MemoryStream(binData))
                //{
                //    cImage = new Bitmap(stream);
                //}
                string path = System.Web.Hosting.HostingEnvironment.MapPath(@"~/IBTWImages/" + companyID + "/" + ID + "/");
                if (!System.IO.Directory.Exists(path))
                {
                    System.IO.Directory.CreateDirectory(path);
                }

                if (!string.IsNullOrEmpty(path))
                {
                    //cImage.Save(path + ID + ".png", ImageFormat.Png);
                    string fileType = GetFileExtension(base64);
                    Guid fileID = Guid.NewGuid();


                    File.WriteAllBytes(path + fileID + "." + fileType + "", binData);
                    imgPath = "/IBTWImages/" + companyID + "/" + ID + "/";
                    //imgPath = "/IBTWImages/" + companyID + "/" + ID + "/" + fileID + "." + fileType + "";
                }
                return imgPath;
            }
            catch (Exception ex)
            {
                return imgPath;
            }
        }
        public static string UploadCompanyImagefromBase64(string base64, string companyID)
        {
            string imgPath = "";
            try
            {

                var base64Data = Regex.Match(base64, @"data:image/(?<type>.+?),(?<data>.+)").Groups["data"].Value;
                var binData = Convert.FromBase64String(base64Data);
                string path = System.Web.Hosting.HostingEnvironment.MapPath(@"~/IBTWImages/" + companyID + "/");

                if (!System.IO.Directory.Exists(path))
                {
                    System.IO.Directory.CreateDirectory(path);
                }

                if (!string.IsNullOrEmpty(path))
                {
                    string fileType = GetFileExtension(base64);

                    if (File.Exists(path + "CompanyLogo" + "." + fileType))
                    {
                        File.Delete(path + "CompanyLogo" + "." + fileType);
                    }

                    File.WriteAllBytes(path + "CompanyLogo" + "." + fileType + "", binData);
                    imgPath = "/IBTWImages/" + companyID + "/" + "CompanyLogo" + "." + fileType + "";

                }
                return imgPath;
            }
            catch (Exception ex)
            {
                return ex.Message;
            }
        }
        public static string UploadCompanyTopBannerfromBase64(string base64, string companyID)
        {
            string imgPath = "";
            try
            {

                var base64Data = Regex.Match(base64, @"data:image/(?<type>.+?),(?<data>.+)").Groups["data"].Value;
                var binData = Convert.FromBase64String(base64Data);
                string path = System.Web.Hosting.HostingEnvironment.MapPath(@"~/IBTWImages/" + companyID + "/CompanyBanners/");

                if (!System.IO.Directory.Exists(path))
                {
                    System.IO.Directory.CreateDirectory(path);
                }



                if (!string.IsNullOrEmpty(path))
                {
                    string fileType = GetFileExtension(base64);

                    if (File.Exists(path + "CompanyTopBanner" + "." + fileType))
                    {
                        File.Delete(path + "CompanyTopBanner" + "." + fileType);
                    }

                    File.WriteAllBytes(path + "CompanyTopBanner" + "." + fileType + "", binData);
                    imgPath = "";// "/IBTWImages/" + companyID + "/" + "CompanyTopBanner" + "." + fileType + "";

                }
                return imgPath;
            }
            catch (Exception ex)
            {
                return ex.Message;
            }
        }


        public static string GetFileExtension(string base64String)
        {

            String[] strings = base64String.Split(',');
            String extension = "";

            switch (strings[0])
            {//check image's extension
                case "data:image/jpeg;base64":
                    extension = "jpeg";
                    break;
                case "data:image/png;base64":
                    extension = "png";
                    break;
                case "data:application/x-zip-compressed;base64":
                    extension = ".zip";
                    break;
                case "data:application/pdf;base64":
                    extension = ".pdf";
                    break;
                case "data:application/msword;base64":
                    extension = ".doc";
                    break;
                case "data:application/vnd.openxmlformats-officedocument.wordprocessingml.document;base64":
                    extension = ".docx";
                    break;
                case "data:image/gif;base64":
                    extension = ".gif";
                    break;
                case "data:text/html;base64":
                    extension = ".html";
                    break;
                case "data:text/plain;base64":
                    extension = ".txt";
                    break;
                case "data:application/vnd.ms-excel;base64":
                    extension = ".xls";
                    break;
                case "data:application/vnd.openxmlformats-officedocument.spreadsheetml.sheet;base64":
                    extension = ".xlsx";
                    break;
                case "data:text/csv;base64":
                    extension = ".csv";
                    break;
                default://should write cases for more images types
                    extension = "jpg";
                    break;
            }
            //
            return extension;
        }
    }
}
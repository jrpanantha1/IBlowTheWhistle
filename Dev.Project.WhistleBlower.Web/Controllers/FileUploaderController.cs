using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Security.Claims;
using System.Web.Http;
using WhistleBlowerDAL;

namespace Dev.Project.WhistleBlower.Web.Controllers
{
    public class FileUploaderController : ApiController
    {
        private eformulus_IBTW_DBEntities db = new eformulus_IBTW_DBEntities();

        [Authorize]
        public IHttpActionResult GetCaseDocuments(string iURN)
        {
            string companyID = ((ClaimsIdentity)User.Identity).Claims.FirstOrDefault(x => x.Type == "companyID").Value;
            string path = System.Web.Hosting.HostingEnvironment.MapPath(@"~/IBTWImages/" + companyID + "/CaseDocuments/" + iURN + "/");
            string consolidPaths = "";

            if (System.IO.Directory.Exists(path))
            {
                string[] filePaths = Directory.GetFiles(path);

                foreach (string file in filePaths)
                {
                    consolidPaths += "/IBTWImages/" + companyID + "/CaseDocuments/" + iURN + "/" + Path.GetFileName(file) + ";";

                }
            }
            return Ok(consolidPaths);
        }
        [Authorize]
        public IHttpActionResult PostUploadFiles(string iURN)
        {
            int iUploadedCnt = 0;
            string companyID = ((ClaimsIdentity)User.Identity).Claims.FirstOrDefault(x => x.Type == "companyID").Value;

            string sPath = "";
            string path = System.Web.Hosting.HostingEnvironment.MapPath(@"~/IBTWImages/" + companyID + "/CaseDocuments/" + iURN + "/");
            if (!System.IO.Directory.Exists(path))
            {
                System.IO.Directory.CreateDirectory(path);
            }

            System.Web.HttpFileCollection hfc = System.Web.HttpContext.Current.Request.Files;

            // CHECK THE FILE COUNT.
            for (int iCnt = 0; iCnt <= hfc.Count - 1; iCnt++)
            {
                System.Web.HttpPostedFile hpf = hfc[iCnt];

                if (hpf.ContentLength > 0)
                {
                    // CHECK IF THE SELECTED FILE(S) ALREADY EXISTS IN FOLDER. (AVOID DUPLICATE)
                    if (!File.Exists(sPath + Path.GetFileName(hpf.FileName)))
                    {
                        // SAVE THE FILES IN THE FOLDER.
                        hpf.SaveAs(path + Path.GetFileName(hpf.FileName));
                        iUploadedCnt = iUploadedCnt + 1;
                    }
                }
            }

            // RETURN A MESSAGE.
            if (iUploadedCnt > 0)
            {
                //return iUploadedCnt + " Files Uploaded Successfully";
            }
            else
            {
                //return "Upload Failed";
            }
            return Ok();
        }
    }
}

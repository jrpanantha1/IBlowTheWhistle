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
    public class PolicyDocumentController : ApiController
    {
        private eformulus_IBTW_DBEntities db = new eformulus_IBTW_DBEntities();
        [Authorize]
        public IHttpActionResult GetPolicyDocuments()
        {
            string companyID = ((ClaimsIdentity)User.Identity).Claims.FirstOrDefault(x => x.Type == "companyID").Value;
            string path = System.Web.Hosting.HostingEnvironment.MapPath(@"~/IBTWImages/" + companyID + "/PolicyDocuments/");
            string consolidPaths = "";

            if (System.IO.Directory.Exists(path))
            {
                string[] filePaths = Directory.GetFiles(path);

                foreach (string file in filePaths)
                {
                    consolidPaths += "/IBTWImages/" + companyID + "/PolicyDocuments/" + Path.GetFileName(file) + ";";

                }
            }
            return Ok(consolidPaths);
        }
        [Authorize]
        public IHttpActionResult PostUploadFiles()
        {
            try
            {


                int iUploadedCnt = 0;
                string companyID = ((ClaimsIdentity)User.Identity).Claims.FirstOrDefault(x => x.Type == "companyID").Value;

                string sPath = "";
                string path = System.Web.Hosting.HostingEnvironment.MapPath(@"~/IBTWImages/" + companyID + "/PolicyDocuments/");
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
                        if (hpf.FileName == "blob")
                        {
                            if (!File.Exists(sPath + Path.GetFileName(hpf.FileName)))
                            {
                                // SAVE THE FILES IN THE FOLDER.
                                hpf.SaveAs(path + Path.GetFileName(hpf.FileName));
                                iUploadedCnt = iUploadedCnt + 1;
                            }
                        }
                        else if (!File.Exists(sPath + Path.GetFileName(hpf.FileName)))
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
            catch (Exception ex)
            {

                return Ok(ex.InnerException);
            }
        }

        [Authorize]
        public IHttpActionResult DELETEDocuments(string delfilePath)
        {
            string path = "";

            int delLastIndx = delfilePath.LastIndexOf('/');

            if (delLastIndx != -1)
            {
                string delFileDirInfo = delfilePath.Substring(0, delLastIndx);
                delFileDirInfo = System.Web.Hosting.HostingEnvironment.MapPath(delFileDirInfo + "/");

                string delFileNameInfo = delfilePath.Substring(delLastIndx + 1);

                if (System.IO.Directory.Exists(delFileDirInfo))
                {
                    path = delFileDirInfo;

                    if (File.Exists(Path.Combine(delFileDirInfo, delFileNameInfo)))
                    {
                        File.Delete(Path.Combine(delFileDirInfo, delFileNameInfo));
                        return Ok("File Deleted");
                    }
                    else
                        return Ok("file not found.");
                }
                else
                    return Ok("Directory not found.");

            }
            return Ok("File Deleted");
        }
    }
}

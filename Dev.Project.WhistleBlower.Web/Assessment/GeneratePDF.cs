using Aspose.Pdf;
using Dev.Project.WhistleBlower.Web.Data;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Reflection;
using System.Web;

namespace Dev.Project.WhistleBlower.Web.Assessment
{
    public class GeneratePDF
    {
        public static void CreatPDF(double sumTRUST, double sumIMPARTIALITY, double sumPROTECTION, string senderEmailID)
        {
            string srvPath = System.Web.Hosting.HostingEnvironment.MapPath(@"~/Assessment/lic/");
            string srvImgpath = System.Web.Hosting.HostingEnvironment.MapPath(@"~/Assessment/Images/");
            string htmlContentPath = System.Web.Hosting.HostingEnvironment.MapPath(@"~/Assessment/htmlContent/");
            //string srvImgpath = @"https://apps.iblowthewhistle.com/assessment/images/";


            Aspose.Pdf.License lic = new Aspose.Pdf.License();
            lic.SetLicense(srvPath + "Aspose.Total.NET.lic");

            string firstPagefileContant = Evaluation.GetFileContent(htmlContentPath + @"firstPageContent.txt");
            string firstPageContent = Evaluation.FindandReplaceContent(firstPagefileContant, "##srvImgpath##", srvImgpath);

            string trustfileContant = Evaluation.GetFileContent(htmlContentPath + @"trustContent.txt");
            trustfileContant = Evaluation.FindandReplaceContent(trustfileContant, "##score##", sumTRUST.ToString());
            trustfileContant = Evaluation.FindandReplaceContent(trustfileContant, "##scoreCalculation##", Evaluation.GetEvalData("TRUST", sumTRUST));
            string trustContent = trustfileContant;

            string impartialityfileContant = Evaluation.GetFileContent(htmlContentPath + @"impartialityContent.txt");
            impartialityfileContant = Evaluation.FindandReplaceContent(impartialityfileContant, "##score##", sumIMPARTIALITY.ToString());
            impartialityfileContant = Evaluation.FindandReplaceContent(impartialityfileContant, "##scoreCalculation##", Evaluation.GetEvalData("IMPARTIALITY", sumIMPARTIALITY));
            string impartialityContent = impartialityfileContant;

            string protectionfileContant = Evaluation.GetFileContent(htmlContentPath + @"protectionContent.txt");
            protectionfileContant = Evaluation.FindandReplaceContent(protectionfileContant, "##score##", sumPROTECTION.ToString());
            protectionfileContant = Evaluation.FindandReplaceContent(protectionfileContant, "##scoreCalculation##", Evaluation.GetEvalData("PROTECTION", sumPROTECTION));
            string protectionContent = protectionfileContant;

            string conclusionfileContant = Evaluation.GetFileContent(htmlContentPath + @"ConclusionContent.txt");
            conclusionfileContant = Evaluation.FindandReplaceContent(conclusionfileContant, "##srvImgpath##", srvImgpath);
            string ConclusionContent = conclusionfileContant;

            string infographicContentfileContant = Evaluation.GetFileContent(htmlContentPath + @"infographicContent.txt");
            infographicContentfileContant = Evaluation.FindandReplaceContent(infographicContentfileContant, "##srvImgpath##", srvImgpath);
            string infographicContent = infographicContentfileContant;

            string lastPagefileContant = Evaluation.GetFileContent(htmlContentPath + @"lastPageContent.txt");
            lastPagefileContant = Evaluation.FindandReplaceContent(lastPagefileContant, "##srvImgpath##", srvImgpath);
            string lastPageContent = lastPagefileContant;

            Document document = new Document();
            string[] arrayContent = { firstPageContent, trustContent, impartialityContent, protectionContent, ConclusionContent, infographicContent, lastPageContent };

            // Whether the stamp is background
            Page pages = document.Pages.Add();
            pages.PageInfo.Margin.Top = 30;
            pages.PageInfo.Margin.Bottom = 30;
            pages.PageInfo.Margin.Left = 50;
            pages.PageInfo.Margin.Right = 50;
            foreach (string content in arrayContent)
            {
                pages.Paragraphs.Add(new HtmlFragment(content));
            }

            PageNumberStamp pageNumberStamp = new PageNumberStamp();
            pageNumberStamp.Background = false;
            pageNumberStamp.Format = "Assessment date: " + DateTime.Now.ToString("ddd, dd MMM yyy HH':'mm':'ss") + " - Page # of " + document.Pages.Count;
            pageNumberStamp.RightMargin = 25;
            pageNumberStamp.BottomMargin = 10;
            pageNumberStamp.HorizontalAlignment = HorizontalAlignment.Right;
            pageNumberStamp.StartingNumber = 1;
            foreach (var pg in document.Pages)
            {
                pg.AddStamp(pageNumberStamp);
            }

            //document.Save(@"C:\Aspose\pdf\Whistleblower Readiness Assessment.pdf");
            System.IO.Stream stream = new System.IO.MemoryStream();
            document.Save(stream);

            string mailBody = @"";

            Utility.SendEmailWithAttachement(senderEmailID, "Whistleblower Readiness Assessment:", mailBody, stream,htmlContentPath);
        }
    }
}
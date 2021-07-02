using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using WhistleBlowerDAL;

namespace Dev.Project.WhistleBlower.Web.Data
{
    public class ReportFraudDetails
    {
        public System.Guid IURN { get; set; }
        public System.Guid CompanyID { get; set; }
        public Nullable<bool> IsReportable { get; set; }
        public Nullable<bool> SupportingEvidence { get; set; }
        public string EvidenceDetails { get; set; }
        public Nullable<bool> FileAttachment { get; set; }
        public Nullable<bool> HaveWitness { get; set; }
        public Nullable<bool> UpdatedOnIncident { get; set; }
        public Nullable<int> UpdatedOnIncidentMethod { get; set; }
        public string Email { get; set; }
        public string Phone { get; set; }
        public Nullable<bool> EvidenceCanBeUsedForInvestigation { get; set; }
        public string Comments { get; set; }
        public Nullable<System.DateTime> SubmissionDateTime { get; set; }
        public Nullable<System.DateTime> SubmissionModifiedDate { get; set; }
        public string SupportingDocuments { get; set; }
        public string WitnessFullName { get; set; }
        public string WitnessEmail { get; set; }
        public string WitnessPhone { get; set; }
        public Nullable<System.DateTime> WitnessModifiedDateTime { get; set; }
        public string SupportingDocuments1 { get; set; }
        public string SupportingDocuments2 { get; set; }
        public string ReportedLanguageID { get; set; }


    }
}
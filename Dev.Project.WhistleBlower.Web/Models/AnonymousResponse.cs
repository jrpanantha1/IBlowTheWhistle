using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Dev.Project.WhistleBlower.Web.Models
{
    public class AnonymousResponse
    {
        public System.Guid RURN { get; set; }
        public System.Guid IURN { get; set; }
        public System.Guid RegUserID { get; set; }
        public long ResClusterID { get; set; }
        public string Message { get; set; }
        public Nullable<System.DateTime> ResponseDate { get; set; }
        public Nullable<bool> ViewStatus { get; set; }
        public string commentBy { get; set; }
        public string companyName { get; set; }
        public string companyLogo { get; set; }
        public string regUserDisplayName { get; set; }


    }
}
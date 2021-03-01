using Dev.Project.WhistleBlower.Web.Models;
using Newtonsoft.Json.Linq;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;

namespace Dev.Project.WhistleBlower.Web.Controllers
{
    public class TestAPIController : ApiController
    {
        public void PostLanguageDetail(Object objData) 
        {
            //var emp = data.EmployeeDataDetails;
            //Customer cust = data.CustomerData;

            List<Employee> lstItemEmployees = new List<Employee>();

            dynamic jsonData = objData;
            JObject orderJson = jsonData.CustomerData;
            JArray itemDetailsJson = jsonData.EmployeeData;

            var Order = orderJson.ToObject<Customer>();

            foreach (var item in itemDetailsJson)
            {
                lstItemEmployees.Add(item.ToObject<Employee>());
            }

        }
    }
}

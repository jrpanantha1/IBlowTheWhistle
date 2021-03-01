using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Dev.Project.WhistleBlower.Web.Models
{
    public class TestClass
    {
    }
    public class Employee
    {
        public int EmployeeID { get; set; }
        public string FirstName { get; set; }
        public string LastName { get; set; }
    }

    public class Customer
    {
        public string CustomerID { get; set; }
        public string CompanyName { get; set; }
    }

    public class EmployeeCustomer
    {
        public Employee[] EmployeeDataDetails { get; set; }
        public Customer CustomerData { get; set; }
    }
}
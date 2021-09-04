<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Join.aspx.cs" Inherits="Dev.Project.WhistleBlower.Web.Pages.Join" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8">
    <meta http-equiv="x-ua-compatible" content="ie=edge">
    <title>Sign Up | I Blow The Whistle</title>
    <meta name="description" content="">
    <meta name="keywords" content="">
    <meta name="author" content="">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="manifest" href="manifest.json">
    <!-- Place favicon.ico in the root directory -->
    <link rel="apple-touch-icon" href="icon.png">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/flag-icon-css/3.4.3/css/flag-icon.min.css" rel="stylesheet">
    <link href="/assets/css/styles.min.css" rel="stylesheet" />
    <meta name="msapplication-config" content="browserconfig.xml" />
    <meta name="theme-color" content="#00B48F" />
    <script src="../Scripts/jquery-3.3.1.min.js"></script>
    <script src="../Scripts/Validation.js"></script>
    <script src="/Scripts/PageScripts/Join.js"></script>
    <style>
        .error {
            border: 1px solid red;
        }
    </style>
</head>
<body>
    <header>
        <div class="navbar-dark fixed-top">
            <div class="container-fluid p-4">
                <nav class="navbar navbar-expand">
                    <a class="navbar-brand" href="Default.aspx">
                        <img alt="I Blow The Whistle" src="/assets/images/logo-light.png" class="logo d-lg-inline-block d-none"><img alt="I Blow The Whistle" src="/assets/images/logo.png" class="logo d-inline-block d-lg-none"></a>
                    <div id="navbarNav" class="collapse navbar-collapse justify-content-end">
                        <ul class="navbar-nav align-items-center">
                            <li class="nav-item d-none d-md-inline-block">
                                <span class="mr-4 text-unstyled">Already have an account?</span>
                            </li>
                            <li class="nav-item">
                                <a href="Login.aspx" class="btn btn-sm btn-outline-dark">Sign In</a>
                            </li>
                        </ul>
                    </div>
                    <!--end nav collapse-->
                </nav>
                <!--end of navbar-->
            </div>
            <!--end of container-->
        </div>
        <!--end of site-nav-->
    </header>
    <!-- // Header -->
    <section class="section-split">
        <div class="container-fluid">
            <div class="row no-gutters justify-content-center min-vh-100">
                <div class="col-lg-5 d-none d-lg-block bg-dark">
                    <img alt="Image" src="/assets/images/happywoman.jpg" class="bg-image opacity-30">
                </div>
                <!--end of col-->
                <div class="col-lg-7 d-flex align-items-center" style="padding-top: 100px;">
                    <div class="w-75 mx-auto px-lg-6 my-lg-0 mt-md-0 mt-8">
                        <div class="intro">
                            <h1 class="mb-3">Get started today!</h1>
                            <p class="mb-4 mb-md-5">Register your interested to join our growing Whistleblowing platform today.</p>
                        </div>
                        <!--end of intro-->
                        <form>
                            <div class="form-group">
                                <label for="name">First Name</label>
                                <input id="txtFirstName" class="form-control removeLater" placeholder="Arya Stark" type="text" />
                            </div>
                            <div class="form-group">
                                <label for="name">Given Name</label>
                                <input id="txtGivenName" class="form-control removeLater" placeholder="Arya Stark" type="text" />
                            </div>
                            <!--end of form-group-->
                            <div class="form-group">
                                <label for="email">Company Email Address</label>
                                <input id="txtCompanyEmail" class="form-control removeLater" placeholder="arya.stark@winterfell.com" type="email" />
                            </div>
                            <!--end of form-group-->
                            <div class="form-group">
                                <label for="companyName">Company Name</label>
                                <input id="txtCompanyName" class="form-control removeLater" placeholder="Enter Company Name" type="text" />
                            </div>
                            <!--end of form-group-->
                            <div class="form-group">
                                <label for="companyTele">Company Telephone</label>
                                <input id="txtCompanyTele" class="form-control removeLater" placeholder="Enter Telephone" type="text" />
                            </div>
                            <!--end of form-group-->
                            <div class="form-group">
                                <label for="Country">Country</label>
                                <input id="txtCountry" class="form-control removeLater" placeholder="Enter Country" type="text" />
                            </div>
                            <!--end of form-group-->
                            <div class="form-group">
                                <label for="Country">Time Zone</label>
                                <input id="txtTime" class="form-control removeLater" placeholder="Enter Time Zone" type="text" />
                            </div>
                            <!--end of form-group-->
                            <div class="form-group">
                                <label for="Country">Comments</label>
                                <textarea id="txtComments" class="removeLater form-control"></textarea>

                            </div>
                            <!--end of form-group-->
                            <div class="form-group">
                                <div class="col-12" id="divSuccess" style="display: none">
                                    <div class="alert alert-success alert-dismissible fade show" role="alert">
                                        <span id="successMessage">Successfully send your details. We will get back to you.</span>
                                        <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                                            <span aria-hidden="true">&times;</span>
                                        </button>
                                    </div>
                                </div>
                                <input type="button" class="btn btn-sm btn-block btn-primary" value="Join" onclick="if (JoinValidation()) { submitJoinDetails(); }" id="btnJoin" />
                                <input type="button" class="btn btn-sm btn-block btn-primary" value="Close" onclick="window.location.href = '/Pages/Default.aspx'" id="btnClose" />


                            </div>
                            <!--end of form-group-->
                            <p class="small text-center" style="margin-bottom: 20px;">By registering with Iblowthewhistle, I agree and consent to Iblowthewhistle to contact me and process my details in relation registering Interest in using Iblowthewhistle platform . My details will be processed in accordance with our Terms and Conditions, Privacy Policy and my consent to receiving Iblowthewhistle related information from I Blow The Whistle. Before applying please  <a href="Eligibility.aspx" style="color: blue;">click</a> here to know about the eligibility criteria.</p>
                        </form>
                        <!--end of form-->
                    </div>
                </div>
                <!--end of col-->
            </div>
            <!--end of row-->
        </div>
        <!--end of container-->
    </section>
    <!-- // Section: Split -->
    <!-- JS -->
</body>
</html>

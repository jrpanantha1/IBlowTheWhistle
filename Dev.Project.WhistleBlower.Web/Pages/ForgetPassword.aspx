<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ForgetPassword.aspx.cs" Inherits="Dev.Project.WhistleBlower.Web.Pages.ForgetPassword" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8" />
    <meta http-equiv="x-ua-compatible" content="ie=edge" />
    <title>Password Reset | I Blow The Whistle</title>
    <meta name="description" content="" />
    <meta name="keywords" content="" />
    <meta name="author" content="" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <link rel="manifest" href="manifest.json" />
    <!-- Place favicon.ico in the root directory -->
    <link rel="apple-touch-icon" href="icon.png" />
    <link rel="apple-touch-icon" sizes="57x57" href="/IblowthewhistleFavico/apple-icon-57x57.png" />
    <link rel="apple-touch-icon" sizes="60x60" href="/IblowthewhistleFavico/apple-icon-60x60.png" />
    <link rel="apple-touch-icon" sizes="72x72" href="/IblowthewhistleFavico/apple-icon-72x72.png" />
    <link rel="apple-touch-icon" sizes="76x76" href="/IblowthewhistleFavico/apple-icon-76x76.png" />
    <link rel="apple-touch-icon" sizes="114x114" href="/IblowthewhistleFavico/apple-icon-114x114.png" />
    <link rel="apple-touch-icon" sizes="120x120" href="/IblowthewhistleFavico/apple-icon-120x120.png" />
    <link rel="apple-touch-icon" sizes="144x144" href="/IblowthewhistleFavico/apple-icon-144x144.png" />
    <link rel="apple-touch-icon" sizes="152x152" href="/IblowthewhistleFavico/apple-icon-152x152.png" />
    <link rel="apple-touch-icon" sizes="180x180" href="/IblowthewhistleFavico/apple-icon-180x180.png" />
    <link rel="icon" type="image/png" sizes="192x192" href="/IblowthewhistleFavico/android-icon-192x192.png" />
    <link rel="icon" type="image/png" sizes="32x32" href="/IblowthewhistleFavico/favicon-32x32.png" />
    <link rel="icon" type="image/png" sizes="96x96" href="/IblowthewhistleFavico/favicon-96x96.png" />
    <link rel="icon" type="image/png" sizes="16x16" href="/IblowthewhistleFavico/favicon-16x16.png" />
    <link rel="manifest" href="/IblowthewhistleFavico/manifest.json" />
    <meta name="msapplication-TileColor" content="#ffffff" />
    <meta name="msapplication-TileImage" content="/IblowthewhistleFavico/ms-icon-144x144.png" />
    <meta name="theme-color" content="#ffffff" />
    <!-- Place favicon.ico in the root directory -->
    <link rel="apple-touch-icon" href="icon.png" />
    <script src='https://www.google.com/recaptcha/api.js'></script>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/flag-icon-css/3.4.3/css/flag-icon.min.css" rel="stylesheet" />
    <link href="/assets/css/styles.min.css" rel="stylesheet" />
    <meta name="msapplication-config" content="browserconfig.xml" />
    <meta name="theme-color" content="#00B48F" />
    <script src="../Scripts/jquery-3.3.1.min.js"></script>
    <script src="../Scripts/popper.min.js" async defer></script>
    <script src="../Scripts/bootstrap.min.js" async defer></script>
    <script src="/assets/js/toast.script.js"></script>
    <script src="../Scripts/Validation.js"></script>
    <script src="/Scripts/Utility.js"></script>
    <script src="../Scripts/PageScripts/ForgetPassword.js"></script>
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
                    <img alt="Image" src="/assets/images/laptop-woman.jpg" class="bg-image opacity-30">
                </div>
                <!--end of col-->
                <div class="col-lg-7 d-flex align-items-center">
                    <div class="w-75 mx-auto px-lg-6 my-lg-0 mt-md-0 mt-8">
                        <div class="intro">
                            <h1 class="mb-3">Password Reset</h1>
                            <p class="mb-4 mb-md-5">Please provide your registered valid email address.</p>
                        </div>
                        <!--end of intro-->
                        <form>

                            <div class="form-group">
                                <label id="lblError" style="display: none; color: red"></label>
                                <br />
                                <label for="email">Email Address</label>
                                <input type="text" class="form-control" value="" placeholder="Email Address" id="txtemailAddress" />
                            </div>
                            <!--end of form-group-->

                            <div id='recaptcha' class="g-recaptcha"
                                data-sitekey="<%=Dev.Project.WhistleBlower.Web.Data.WhistleContants.googleCAPTCHAKey%>"
                                data-callback="onSubmit"
                                data-size="invisible">
                            </div>
                            <!--end of form-group-->
                            <div class="form-group">
                                <input type="button" class="btn btn-sm btn-block btn-primary" value="Request" id="btnRequest" />
                            </div>
                            <!--end of form-group-->
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

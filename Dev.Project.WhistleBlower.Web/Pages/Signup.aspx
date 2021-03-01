<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Signup.aspx.cs" Inherits="Dev.Project.WhistleBlower.Web.Pages.Signup" %>

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
    <link href="/assets/css/styles.min.css" rel="stylesheet">
    <meta name="msapplication-config" content="browserconfig.xml">
    <meta name="theme-color" content="#00B48F">
</head>
<body>
     <header>
        <div class="navbar-dark fixed-top">
            <div class="container-fluid p-4">
                <nav class="navbar navbar-expand">
                    <a class="navbar-brand" href="Home.aspx"><img alt="I Blow The Whistle" src="/assets/images/logo-light.png" class="logo d-lg-inline-block d-none"><img alt="I Blow The Whistle" src="/assets/images/logo.png" class="logo d-inline-block d-lg-none"></a>
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
                <div class="col-lg-7 d-flex align-items-center">
                    <div class="w-75 mx-auto px-lg-6 my-lg-0 mt-md-0 mt-8">
                        <div class="intro">
                            <h1 class="mb-3">Get started today!</h1>
                            <p class="mb-4 mb-md-5">Debitis error illo optio quidem adipisci.</p>
                        </div>
                        <!--end of intro-->
                        <form>
                            <div class="form-group">
                                <label for="name">Full Name</label>
                                <input id="name" class="form-control" placeholder="Arya Stark" type="text">
                            </div>
                            <!--end of form-group-->
                            <div class="form-group">
                                <label for="email">Email Address</label>
                                <input id="email" class="form-control" placeholder="arya.stark@winterfell.com" type="email">
                            </div>
                            <!--end of form-group-->
                            <div class="form-group">
                                <label for="password">Password</label>
                                <input id="password" class="form-control" placeholder="7+ characters" type="password">
                            </div>
                            <!--end of form-group-->
                            <div class="form-group">
                                <button id="button" type="submit" class="btn btn-sm btn-block btn-primary">Sign Up</button>
                            </div>
                            <!--end of form-group-->
                            <p class="small text-center">By clicking "Sign Up", I agree to I Blow The Whistle's <a href="#" class="text-muted">Terms of Service</a> and <a href="#" class="text-muted">Privacy Policy</a>.</p>
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
    <script src="/Scripts/jquery-3.4.1.slim.min.js" integrity="sha384-J6qa4849blE2+poT4WnyKhv5vZF5SrPo0iEjwBvKU7imGFAV0wwj1yYfoRSJoZ+n" crossorigin="anonymous"></script>
    <script src="/Scripts/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
    <script src="/Scripts/bootstrap.min.js" integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous"></script>
</body>
</html>

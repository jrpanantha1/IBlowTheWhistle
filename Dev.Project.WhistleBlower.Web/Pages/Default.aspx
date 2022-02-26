<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="Dev.Project.WhistleBlower.Web.Pages.Default" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>I Blow the Whistle</title>
    <meta charset="UTF-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
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
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons" />
    <link rel="stylesheet" href="/assets/css/newstyle.css" />
    <link href="https://fonts.googleapis.com/css2?family=Titillium+Web:wght@400;600;700&display=swap" rel="stylesheet" />
    <link href="/assets/css/NewHome/bootstrap.min.css" rel="stylesheet" />
    <script src="/assets/js/1a4a488850.js"></script>
    <script src="/Scripts/jquery-3.3.1.min.js"></script>
    <script src="/Scripts/popper.min.js" async defer></script>
    <script src="/Scripts/bootstrap.min.js" async defer></script>
    <script src="/Scripts/PageScripts/Home.js"></script>
    <script src="/Scripts/Utility.js"></script>
    <script src="/Scripts/PageScripts/HomelanguageChange.js"></script>
    <script src="/Scripts/Validation.js"></script>
    <style type="text/css">
        .error {
            border: 1px solid red !important;
        }

        .ddlLanguage {
            background-color: #00a485;
        }

            .ddlLanguage .dropdown-item {
                width: 50%;
                clear: none;
                float: left;
            }

        .dropdown-item {
            color: white !important;
        }

        .dropdown-item {
            display: block;
            width: 100%;
            padding: .8rem 1.5rem;
            clear: both;
            font-weight: 400;
            color: #879CA7;
            text-align: inherit;
            white-space: nowrap;
            background-color: transparent;
            border: 0
        }

            .dropdown-item:hover, .dropdown-item:focus {
                color: #00122C;
                text-decoration: none;
                background-color: rgba(240,243,247,0.5)
            }

            .dropdown-item.active, .dropdown-item:active {
                color: #00122C;
                text-decoration: none;
                background-color: rgba(240,243,247,0.5)
            }

            .dropdown-item.disabled, .dropdown-item:disabled {
                color: #879CA7;
                pointer-events: none;
                background-color: transparent
            }


        .ddlLanguage .dropdown-item {
            width: 50%;
            clear: none;
            float: left;
        }

        .selected-item span {
            background: url('\assets\images\feather-check.svg') no-repeat left center / contain;
        }

        .dropdown-item span {
            padding-left: 35px;
        }

        .dropdown-menu {
            min-width: 15rem;
            -webkit-box-shadow: 0 0.125rem 0.25rem rgba(0,0,0,0.075);
            box-shadow: 0 0.125rem 0.25rem rgba(0,0,0,0.075)
        }

            .dropdown-menu.ddlLanguage {
                float: left;
                min-width: 20rem;
                -webkit-box-shadow: 0 0.125rem 0.25rem rgba(0,0,0,0.075);
                box-shadow: 0 0.125rem 0.25rem rgba(0,0,0,0.075);
                padding: 20px 0;
            }

            .dropdown-menu [class*="icon-"] {
                margin-right: 1rem
            }

        .dropdown-ellipses {
            color: #879CA7
        }

            .dropdown-ellipses:after {
                display: none !important
            }

        .dropdown-filter {
            font-size: 80%;
            text-transform: uppercase;
            color: inherit;
            font-weight: 600;
            letter-spacing: 0.04rem
        }

            .dropdown-filter:hover {
                color: rgba(0,18,44,0.8)
            }
    </style>
    <script>
        $(document).ready(function () {
            sessionStorage.clear();
        });
        window.onload = function () {
            document.getElementById("CompanyURN").focus();
        };
        $(document).ready(function () {
            $('[data-toggle="tooltip"]').tooltip();
        });
    </script>

</head>
<body>
    <form id="form1" runat="server">
        <div>
            <!----- banner ---->
            <section class="banner" id="banner">
                <div class="container">

                    <nav class="navbar navbar-expand-lg navbar-light">
                        <div class="container-fluid">
                            <a class="navbar-brand" href="/">
                                <img src="/Images/newHome/logo-light.png" class="logo" alt=""></a>
                            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
                                <i class="fas fa-bars"></i>
                            </button>
                            <div class="collapse navbar-collapse" id="navbarSupportedContent">
                                <ul class="navbar-nav ms-auto">
                                    <li class="nav-item">
                                        <a id="ancMenuInfo" class="nav-link" href="https://cutt.ly/cWkwbRP">Info</a>
                                    </li>
                                    <li class="nav-item">
                                        <a id="ancMenuPricing" class="nav-link" href="https://iblowthewhistle.com/products">Pricing</a>
                                    </li>
                                    <li class="nav-item dropdown language-switcher">

                                        <a class="nav-link icon dropdown-toggle dropdownLanguage" href="#" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"></a>
                                        <div class="dropdown-menu dropdown-menu-right ddlLanguage" aria-labelledby="dropdownLanguage">
                                            <a href="#" class="dropdown-item" id="engItem">
                                                <%-- <i class="flag-icon flag-icon-squared flag-icon-us"></i>--%>
                                                <span>English</span>
                                            </a>
                                            <a href="#" class="dropdown-item" id="thaiItem">
                                                <%--<i class="flag-icon flag-icon-squared flag-icon-th"></i>--%>
                                                <span>Thai</span>
                                            </a>
                                            <a href="#" class="dropdown-item" id="frenchItem">
                                                <%--<i class="flag-icon flag-icon-squared flag-icon-fr"></i>--%>
                                                <span>French</span>
                                            </a>
                                            <a href="#" class="dropdown-item" id="spanishItem">
                                                <%--<i class="flag-icon flag-icon-squared flag-icon-es"></i>--%>
                                                <span>Spanish</span>
                                            </a>
                                            <a href="#" class="dropdown-item" id="russianItem">
                                                <%--<i class="flag-icon flag-icon-squared flag-icon-ru"></i>--%>
                                                <span>Russian</span>
                                            </a>
                                            <a href="#" class="dropdown-item" id="kazItem">
                                                <%--<i class="flag-icon flag-icon-squared flag-icon-kz"></i>--%>
                                                <span>Kazakh</span>
                                            </a>
                                            <a href="#" class="dropdown-item" id="arabicItem">
                                                <%--<i class="flag-icon flag-icon-squared flag-icon-ar"></i>--%>
                                                <span>Arabic</span>
                                            </a>
                                        </div>
                                    </li>
                                    <li class="nav-item">
                                        <a class="nav-link" href="/Pages/Login.aspx"><i class="fas fa-user"></i><span id="ancSignIn">Sign In</span></a>
                                    </li>
                                </ul>

                            </div>
                        </div>
                    </nav>
                    <div class="banner_box text-center">
                        <div class="alert alert-warning" style="display: none; background-color: #00a485; color: #ffffff;" role="alert">
                            <span id="spanWarningMsg"></span>
                        </div>
                        <h3 id="hIncTitle">Report Concerns Without Risk</h3>

                        <div class="input-group mb-3 mx-auto">
                            <input type="text" required id="CompanyURN" maxlength="20" class="form-control" placeholder="Company URN i.e. NG123456" />
                            <button type="submit" id='basic-addon2' onclick="if (Validation()) { validateCompanyKey();} return false;" class="btn input-group-text"></button>
                        </div>
                        <p id="pIncDesc">
                            We help your company understand your Employees critical concerns with total anonymity. We connect the concerns with the right people within the organization that needs to hear those concerns.
                        </p>
                        <h6>
                            <i class="fas fa-lock"></i><span id="spanSecMsg">Using the latest Encryption Standards to ensure the highest level protection</span>
                        </h6>
                    </div>

                </div>
                <div class="custom-shape-divider-bottom-1630394071">
                    <svg data-name="Layer 1" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 1200 120" preserveAspectRatio="none">
                        <path d="M0,0V46.29c47.79,22.2,103.59,32.17,158,28,70.36-5.37,136.33-33.31,206.8-37.5C438.64,32.43,512.34,53.67,583,72.05c69.27,18,138.3,24.88,209.4,13.08,36.15-6,69.85-17.84,104.45-29.34C989.49,25,1113-14.29,1200,52.47V0Z" opacity=".25" class="shape-fill"></path>
                        <path d="M0,0V15.81C13,36.92,27.64,56.86,47.69,72.05,99.41,111.27,165,111,224.58,91.58c31.15-10.15,60.09-26.07,89.67-39.8,40.92-19,84.73-46,130.83-49.67,36.26-2.85,70.9,9.42,98.6,31.56,31.77,25.39,62.32,62,103.63,73,40.44,10.79,81.35-6.69,119.13-24.28s75.16-39,116.92-43.05c59.73-5.85,113.28,22.88,168.9,38.84,30.2,8.66,59,6.17,87.09-7.5,22.43-10.89,48-26.93,60.65-49.24V0Z" opacity=".5" class="shape-fill"></path>
                        <path d="M0,0V5.63C149.93,59,314.09,71.32,475.83,42.57c43-7.64,84.23-20.12,127.61-26.46,59-8.63,112.48,12.24,165.56,35.4C827.93,77.22,886,95.24,951.2,90c86.53-7,172.46-45.71,248.8-84.81V0Z" class="shape-fill"></path>
                    </svg>
                </div>

            </section>
            <!----- /banner ---->

            <!----- sub bannner ----->

            <section class="sub_bannner" id="sub_bannner">
                <div class="container">
                    <div class="row">

                        <div class="col-md-6">
                            <div class="sub_bannner_box">
                                <img src="/Images/newHome/p3.jpg" alt="">
                            </div>
                        </div>

                        <div class="col-md-6">
                            <div class="sub_bannner_box">
                                <h3><span id="spanBoxTitle"></span></h3>
                                <p id="pboxDesc">
                                </p>
                                <a id="ancClickhere" target="_blank" href="https://iblowthewhistle.com"></a>
                            </div>
                        </div>

                    </div>
                </div>
            </section>

            <!----- sub bannner ----->

            <!---------- contact ------->
            <section class="contact d-none" id="contact">
                <div class="container text-center">
                    <h6 id="hContactUsDesc"></h6>
                    <h1 id="hContactUs"></h1>
                    <div class="contact_box">

                        <input type="text" name="name" id="firstName" required autocomplete="off" /><br />
                        <input type="text" name="name" id="lastName" required autocomplete="off" /><br />
                        <input type="email" name="email" id="email" required autocomplete="off" /><br />
                        <textarea name="message" id="message" required autocomplete="off"></textarea><br />
                        <label for="" id="lblDoYouWant"></label>
                        <br />
                        <input type="checkbox" id="checkinp" required /><label for="checkinp" id="lblDoYouWantChkbox"></label><br />
                        <input type="submit" name="sub_btn" id="sub_btn" onclick="enquryFormValidation();return false;" /><br />
                        <label for="" id="lblReadMore"></label>


                    </div>
                </div>
            </section>
            <!----------/contact ------->


            <!------ footer ----->
            <section class="footer" id="footer">
                <div class="container">
                    <div class="row">

                        <div class="col-md-6 col-lg-3">
                            <div class="footer_box">
                                <a href="/">
                                    <img src="/Images/newHome/logo-light.png" class="logo" alt="" /></a>

                            </div>

                        </div>

                        <div class="col-md-6 col-lg-3">
                            <div class="footer_box">
                                <h4><span>About Us</span></h4>
                                <div class="social_icon">
                                    <a href="https://www.facebook.com/IBlowTheWhistle/"><i class="fab fa-facebook-f"></i></a>
                                    <a href="https://twitter.com/Iblowthewhistl1"><i class="fab fa-twitter"></i></a>
                                    <a href="https://cutt.ly/zWj6m6w"><i class="fab fa-linkedin-in"></i></a>
                                    <a href="https://cutt.ly/hWj6Kf3"><i class="fab fa-youtube"></i></a>
                                </div>
                            </div>
                        </div>

                        <div class="col-md-6 col-lg-3">
                            <div class="footer_box">
                                <h4><span>Important Links</span></h4>
                                <div class="social_link">
                                    <a target="_blank" href="https://iblowthewhistle.com">Information</a>
                                    <a target="_blank" href="https://iblowthewhistle.com/features">Features</a>
                                    <a target="_blank" href="https://iblowthewhistle.com/Support">Support</a>
                                    <a target="_blank" href="https://iblowthewhistle.com/terms-conditions">Legal</a>
                                    <a target="_blank" href="https://iblowthewhistle.com/products">Pricing</a>

                                </div>
                            </div>
                        </div>

                        <div class="col-md-6 col-lg-3">
                            <div class="footer_box">
                                <h4><span>Contact Us</span></h4>
                                <div class="follow_link">
                                    <p><a href="#"><i class="fas fa-map-marker"></i>Kuala Lumpur, Malaysia</a></p>
                                    <p><a href="mailto://contactus@iblowthewhistle.com"><i class="fas fa-envelope"></i>contactus@iblowthewhistle.com</a></p>
                                    <p><a href="https://iblowthewhistle.com"><i class="fas fa-link"></i>www.iblowthewhistle.com</a></p>
                                </div>
                            </div>
                        </div>

                    </div>

                </div>
            </section>
            <!------ /footer ----->

            <script src="/assets/js/bootstrap.bundle.min.js"></script>


        </div>
    </form>
</body>
</html>

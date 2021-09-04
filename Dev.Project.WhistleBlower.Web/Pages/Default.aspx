<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="Dev.Project.WhistleBlower.Web.Pages.Default" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>IBTW | Home</title>
    <meta charset="UTF-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons" />
    <link rel="stylesheet" href="/assets/css/newstyle.css" />
    <link href="https://fonts.googleapis.com/css2?family=Titillium+Web:wght@400;600;700&display=swap" rel="stylesheet" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous" />
    <script src="https://kit.fontawesome.com/1a4a488850.js" crossorigin="anonymous"></script>
    <script src="/Scripts/jquery-3.3.1.min.js"></script>
    <script src="/Scripts/popper.min.js" async defer></script>
    <script src="/Scripts/bootstrap.min.js" async defer></script>
    <script src="/Scripts/PageScripts/Home.js"></script>
    <script src="/Scripts/Utility.js"></script>
    <script src="/Scripts/PageScripts/languageChange.js"></script>
    <script src="/Scripts/Validation.js"></script>
    <style type="text/css">
        .error {
            border: 1px solid red !important;
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
                            <a class="navbar-brand" href="https://cutt.ly/JWj56NG">
                                <img src="/Images/newHome/logo-light.png" class="logo" alt=""></a>
                            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
                                <i class="fas fa-bars"></i>
                            </button>
                            <div class="collapse navbar-collapse" id="navbarSupportedContent">
                                <ul class="navbar-nav ms-auto">
                                    <li class="nav-item">
                                        <a class="nav-link" href="https://cutt.ly/cWkwbRP">Info</a>
                                    </li>
                                    <li class="nav-item">
                                        <a class="nav-link" href="https://info.iblowthewhistle.com/products">Pricing</a>
                                    </li>
                                    <li class="nav-item dropdown">
                                        <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">Select Language
                                        </a>
                                        <ul class="dropdown-menu" aria-labelledby="navbarDropdown" style="background-color: #00a485;">
                                            <table class="table text-white">
                                                <tr class="text-center">
                                                    <td class="text-center">English</td>
                                                    <td class="text-center">Hindi</td>
                                                </tr>
                                                <tr class="text-center">
                                                    <td class="text-center">Urdu</td>
                                                    <td class="text-center">Frencch</td>
                                                </tr>
                                                <tr class="text-center">
                                                    <td class="text-center">Chines</td>
                                                    <td class="text-center">Thai</td>
                                                </tr>
                                                <tr class="text-center">
                                                    <td class="text-center">Dutch</td>
                                                    <td class="text-center">Russian</td>
                                                </tr>
                                                <tr class="text-center">
                                                    <td class="text-center">Kazakh</td>
                                                    <td class="text-center">German</td>
                                                </tr>
                                            </table>
                                        </ul>
                                    </li>
                                    <li class="nav-item">
                                        <a class="nav-link" href="/Pages/Login.aspx"><i class="fas fa-user"></i>Sign In</a>
                                    </li>
                                </ul>

                            </div>
                        </div>
                    </nav>
                    <div class="banner_box text-center">
                        <h3>Report Concerns Without Risk</h3>

                        <div class="input-group mb-3 mx-auto">
                            <input type="text" required id="CompanyURN" class="form-control" placeholder="Company URN i.e. NG123456" />
                            <button type="submit" id='basic-addon2' onclick="if (Validation()) { validateCompanyKey();} return false;" class="btn input-group-text">Submit</button>
                        </div>
                        <p>
                            We help your company understand your Employees critical concerns with total anonymity.
             We connect the concerns with the right people within the organization that needs 
             to hear those concerns.
                        </p>
                        <h6>
                            <i class="fas fa-lock"></i>Using the latest Encryption Standards to ensure the highest level protection
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
                                <h3>Everything you need to know about whistleblowing</h3>
                                <p>
                                    If you experience an instance of incident or you have been scammed 
                        by a company you work with or a company you have worked for, you
                         can expose them risk free with our website. Spread the word and
                          make sure that others do not get taken advantage of. Rather 
                          than having a company pursue legal action against you for
                           publishing the report, get the news out with an anonymous tip!
                                </p>
                                <a href="#">Click Here</a>
                            </div>
                        </div>

                    </div>
                </div>
            </section>

            <!----- sub bannner ----->

            <!---------- contact ------->
            <section class="contact" id="contact">
                <div class="container text-center">
                    <h6>Are you interested in enabling concerns and disclosure in your organization?
            Contact us today to establish an ethical reporting service for your company.
                    </h6>
                    <h1>Contact With Us</h1>
                    <div class="contact_box">

                        <input type="text" name="name" id="firstName" placeholder="First Name" required autocomplete="off" /><br />
                        <input type="text" name="name" id="lastName" placeholder="Last Name" required autocomplete="off" /><br />
                        <input type="email" name="email" id="email" placeholder="Email" required autocomplete="off" /><br />
                        <textarea name="message" id="message" placeholder="Message" required autocomplete="off"></textarea><br />
                        <label for="">Do you want to receive the latest information?</label>
                        <br />
                        <input type="checkbox" id="checkinp" required /><label for="checkinp">Yes, I want to receive the latest marketing information from I Blow The Whistle.</label><br />
                        <input type="submit" name="sub_btn" id="sub_btn" value="Send" onclick="enquryFormValidation();return false;" /><br />
                        <label for="">Read more about how we use your info <a href="http://blog.iblowthewhistle.com/Privacy" style="color: #00a485; text-decoration: none;">here.</a></label>

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
                                <a href="https://cutt.ly/JWj56NG">
                                    <img src="/Images/newHome/logo-light.png" class="logo" alt=""></a>
                            </div>
                        </div>

                        <div class="col-md-6 col-lg-3">
                            <div class="footer_box">
                                <h4><span>About Us to Know</span></h4>
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
                                    <a target="_blank" href="https://info.iblowthewhistle.com">Information</a>
                                    <a target="_blank" href="https://info.iblowthewhistle.com/benefits-2">Features</a>
                                    <a target="_blank" href="https://info.iblowthewhistle.com/Support">Support</a>
                                    <a target="_blank" href="https://info.iblowthewhistle.com/terms-conditions">Legal</a>
                                    <a target="_blank" href="https://info.iblowthewhistle.com/products">Pricing</a>
                                    <%--  <a href="https://cutt.ly/tWkqpJZ">Benefits</a>
                                    <a href="https://cutt.ly/sWkqzBR">Eligibility</a>
                                    <a href="https://cutt.ly/OWkqEZd">Explainer</a>
                                    <a href="https://cutt.ly/rWkqO0o">Support</a>
                                    <a href="https://cutt.ly/OWkqHoV">Terms &Conditions</a>
                                    <a href="https://cutt.ly/FWkqVap">Privacy Policy</a>--%>
                                </div>
                            </div>
                        </div>

                        <div class="col-md-6 col-lg-3">
                            <div class="footer_box">
                                <h4><span>Contact Us</span></h4>
                                <div class="follow_link">
                                    <p><a href="#"><i class="fas fa-map-marker"></i>Kuala Lumpur, Malaysia</a></p>
                                    <p><a href="#"><i class="fas fa-envelope"></i>contactus@iblowthewhistle.com</a></p>
                                    <p><a href="https://cutt.ly/AWkwiXK"><i class="fas fa-link"></i>www.iblowthewhistle.com</a></p>
                                </div>
                            </div>
                        </div>

                    </div>
                </div>
            </section>
            <!------ /footer ----->



            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>


        </div>
    </form>
</body>
</html>
